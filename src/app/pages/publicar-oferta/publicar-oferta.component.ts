import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { OfertasempresasService } from '../../services/ofertasempresas.service';
import { ProgramasService } from '../../services/programas.service';
import { AuthService } from '../../services/auth.service';
import { OfertaEmpresa, Programa } from '../../models/interfaces';

interface OfertaForm {
  descripcion: string;
  fecha_inicio: string;
  fecha_fin: string;
  programa_id: number | undefined;
  tipo_oferta: string;
  apoyo_economico: string;
  valor_apoyo_economico: number | undefined;
  nombre_responsable: string;
  modalidad: string;
}

@Component({
  selector: 'app-publicar-oferta',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './publicar-oferta.component.html',
  styleUrl: './publicar-oferta.component.css'
})
export class PublicarOfertaComponent implements OnInit {
  programasList: Programa[] = [];
  ubicacionesList: string[] = ['Nacional', 'Internacional'];
  apoyoEconomicoList: string[] = ['Si', 'No'];
  modalidadList: string[] = ['Presencial', 'Virtual', 'Híbrido'];

  ofertaForm: OfertaForm = {
    descripcion: '',
    fecha_inicio: '',
    fecha_fin: '',
    programa_id: undefined,
    tipo_oferta: '',
    apoyo_economico: '',
    valor_apoyo_economico: undefined,
    nombre_responsable: '',
    modalidad: ''
  };

  isLoading = false;
  error: string | null = null;
  empresaId: number | null = null;
  currentUser: any = null;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private ofertasService: OfertasempresasService,
    private programasService: ProgramasService,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    this.loadInitialData();
  }

  private loadInitialData(): void {
    // Obtener usuario actual
    this.currentUser = this.authService.getCurrentUser();
    console.log('Usuario actual obtenido:', this.currentUser);
    
    // Obtener empresa_id automáticamente del usuario autenticado
    // Prioridad: 1. Query params, 2. Usuario actual, 3. SessionStorage
    this.route.queryParams.subscribe(params => {
      if (params['empresa_id']) {
        this.empresaId = +params['empresa_id'];
        console.log('empresa_id desde query params:', this.empresaId);
      } else if (this.currentUser) {
        // Intentar obtener empresa_id de diferentes campos posibles
        this.empresaId = this.currentUser.empresa_id || 
                        this.currentUser.empresa?.empresa_id || 
                        this.currentUser.id ||
                        null;
        console.log('empresa_id desde usuario actual:', this.empresaId);
        
        // Si aún no se encontró, verificar en sessionStorage
        if (!this.empresaId) {
          const storedEmpresaId = sessionStorage.getItem('empresa_id');
          if (storedEmpresaId) {
            this.empresaId = +storedEmpresaId;
            console.log('empresa_id desde sessionStorage:', this.empresaId);
          }
        }
      }
    });

    // Cargar programas disponibles
    this.loadProgramas();
  }

  private loadProgramas(): void {
    this.programasService.getAll().subscribe({
      next: (programas) => {
        console.log('Programas recibidos:', programas);
        // Filtrar programas activos si tienen el campo estado, sino usar todos
        if (programas && programas.length > 0) {
          this.programasList = programas.filter(p => p.estado === true || p.estado === undefined || p.estado === null);
          if (this.programasList.length === 0 && programas.length > 0) {
            // Si todos tienen estado=false, usar todos
            this.programasList = programas;
          }
        } else {
          this.programasList = [];
          this.error = 'No hay programas disponibles.';
        }
        // Limpiar el error si se cargaron correctamente
        if (this.programasList.length > 0) {
          this.error = null;
        }
      },
      error: (error) => {
        console.error('Error cargando programas:', error);
        console.error('Detalles del error:', error.error);
        console.error('Status:', error.status);
        console.error('URL:', error.url);
        
        // Determinar el mensaje de error más útil
        let errorMessage = 'Error desconocido';
        
        if (error.status === 0) {
          // Error de conexión
          errorMessage = 'No se pudo conectar con el servidor. Verifica que el servidor backend esté corriendo en http://127.0.0.1:8000';
        } else if (error.status === 404) {
          errorMessage = 'El endpoint de programas no fue encontrado. Verifica la configuración del backend.';
        } else if (error.status === 500) {
          errorMessage = 'Error interno del servidor. Revisa los logs del backend.';
        } else if (error.error?.error) {
          errorMessage = error.error.error;
        } else if (error.error?.message) {
          errorMessage = error.error.message;
        } else if (error.message) {
          errorMessage = error.message;
        }
        
        this.error = `Error al cargar los programas disponibles: ${errorMessage}`;
      }
    });
  }

  publicarOferta(): void {
    if (!this.validateForm()) {
      return;
    }

    // Obtener empresaId del usuario autenticado (prioridad)
    let empresaId = this.empresaId;
    
    // Si no está en this.empresaId, intentar obtenerlo del usuario actual
    if (!empresaId && this.currentUser) {
      // Intentar diferentes campos posibles
      empresaId = this.currentUser.empresa_id || 
                  this.currentUser.empresa?.empresa_id || 
                  this.currentUser.id ||
                  null;
    }
    
    // Si aún no está, intentar obtenerlo de sessionStorage
    if (!empresaId) {
      const storedEmpresaId = sessionStorage.getItem('empresa_id');
      if (storedEmpresaId) {
        empresaId = +storedEmpresaId;
      }
    }
    
    // Si aún no está, intentar obtenerlo de los query params
    if (!empresaId) {
      const params = this.route.snapshot.queryParams;
      if (params['empresa_id']) {
        empresaId = +params['empresa_id'];
      }
    }

    // Validación final: si no se encontró empresaId, mostrar error
    if (!empresaId || empresaId === null || empresaId === undefined || empresaId === 0) {
      console.error('ERROR: empresaId no encontrado:', {
        empresaId: this.empresaId,
        currentUser: this.currentUser,
        queryParams: this.route.snapshot.queryParams,
        sessionStorage: sessionStorage.getItem('empresa_id')
      });
      this.error = 'No se pudo identificar la empresa. Por favor, cierre sesión e inicie sesión nuevamente como empresa.';
      return;
    }

    this.isLoading = true;
    this.error = null;

    // Asegurar que empresaId sea un número válido
    empresaId = Number(empresaId);
    
    // Validación final antes de enviar
    if (isNaN(empresaId) || empresaId <= 0) {
      console.error('ERROR CRÍTICO: empresaId inválido:', empresaId);
      this.error = 'Error interno: No se pudo identificar la empresa. Por favor, cierre sesión e inicie sesión nuevamente.';
      this.isLoading = false;
      return;
    }

    // Preparar datos asegurando que empresa sea un número
    const ofertaData: any = {
      empresa: empresaId,  // Número, no string
      empresa_id: empresaId, // Enviar también como empresa_id por compatibilidad
      descripcion: this.ofertaForm.descripcion || '',
      fecha_inicio: this.ofertaForm.fecha_inicio || '',
      fecha_fin: this.ofertaForm.fecha_fin || '',
      programa_id: this.ofertaForm.programa_id ? Number(this.ofertaForm.programa_id) : null,
      tipo_oferta: this.ofertaForm.tipo_oferta || 'Nacional',
      apoyo_economico: this.ofertaForm.apoyo_economico || 'No',
      valor_apoyo_economico: this.ofertaForm.apoyo_economico === 'Si' && this.ofertaForm.valor_apoyo_economico 
        ? Number(this.ofertaForm.valor_apoyo_economico) 
        : undefined,
      nombre_responsable: this.ofertaForm.nombre_responsable || '',
      modalidad: this.ofertaForm.modalidad || 'Presencial'
    };

    // Validación adicional: asegurar que empresa esté presente
    if (!ofertaData.empresa || ofertaData.empresa === 0) {
      console.error('ERROR: empresa no está en ofertaData:', ofertaData);
      this.error = 'Error interno: El ID de empresa no se pudo establecer. Por favor, intente de nuevo.';
      this.isLoading = false;
      return;
    }

    console.log('✓ Enviando datos de oferta:');
    console.log('  empresa:', ofertaData.empresa, '(tipo:', typeof ofertaData.empresa + ')');
    console.log('  empresa_id:', ofertaData.empresa_id, '(tipo:', typeof ofertaData.empresa_id + ')');
    console.log('Datos completos:', JSON.stringify(ofertaData, null, 2));

    this.ofertasService.create(ofertaData).subscribe({
      next: (response) => {
        console.log('Oferta creada exitosamente:', response);
        alert('¡Oferta publicada exitosamente!');
        this.router.navigate(['/informacion-empresa'], { 
          queryParams: { id: this.empresaId } 
        });
      },
      error: (error) => {
        console.error('Error creando oferta:', error);
        console.error('Detalles del error:', error.error);
        const errorMessage = error.error?.error || error.error?.message || error.message || 'Error desconocido';
        this.error = `Error al publicar la oferta: ${errorMessage}. Por favor, intente de nuevo.`;
        this.isLoading = false;
      }
    });
  }

  private validateForm(): boolean {
    if (!this.ofertaForm.descripcion.trim()) {
      this.error = 'La descripción es obligatoria.';
      return false;
    }

    if (!this.ofertaForm.fecha_inicio) {
      this.error = 'La fecha de inicio es obligatoria.';
      return false;
    }

    if (!this.ofertaForm.fecha_fin) {
      this.error = 'La fecha de fin es obligatoria.';
      return false;
    }

    if (new Date(this.ofertaForm.fecha_inicio) >= new Date(this.ofertaForm.fecha_fin)) {
      this.error = 'La fecha de fin debe ser posterior a la fecha de inicio.';
      return false;
    }

    if (!this.ofertaForm.programa_id) {
      this.error = 'Debe seleccionar un programa.';
      return false;
    }

    if (!this.ofertaForm.tipo_oferta) {
      this.error = 'Debe seleccionar si es nacional o internacional.';
      return false;
    }

    if (!this.ofertaForm.apoyo_economico) {
      this.error = 'Debe especificar si hay apoyo económico.';
      return false;
    }

    // Validar que si se selecciona "Si" en apoyo económico, se ingrese un valor
    if (this.ofertaForm.apoyo_economico === 'Si') {
      if (!this.ofertaForm.valor_apoyo_economico || this.ofertaForm.valor_apoyo_economico <= 0) {
        this.error = 'Debe ingresar el valor del apoyo económico.';
        return false;
      }
    }

    if (!this.ofertaForm.nombre_responsable.trim()) {
      this.error = 'El nombre del responsable es obligatorio.';
      return false;
    }

    if (!this.ofertaForm.modalidad) {
      this.error = 'Debe seleccionar una modalidad.';
      return false;
    }

    return true;
  }

  cancelar(): void {
    this.router.navigate(['/informacion-empresa'], { 
      queryParams: { id: this.empresaId } 
    });
  }
}
