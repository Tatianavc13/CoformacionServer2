import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { ProcesoCoformacionService } from '../../services/proceso_coformacion.service';
import { EstudiantesService } from '../../services/estudiantes.service';
import { EmpresasService } from '../../services/empresas.service';
import { OfertasempresasService } from '../../services/ofertasempresas.service';
import { EstadoProcesoService } from '../../services/estado_proceso.service';
import { ContactosEmpresaService } from '../../services/contactos_empresa.service';
import { ProcesoCoformacion, Estudiante, Empresa, OfertaEmpresa, EstadoProceso, ContactoEmpresa } from '../../models/interfaces';

@Component({
  selector: 'app-proceso-coformacion',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './proceso-coformacion.component.html',
  styleUrl: './proceso-coformacion.component.css'
})
export class ProcesoCoformacionComponent implements OnInit {
  proceso: ProcesoCoformacion = {
    proceso_id: 0,
    estudiante: 0,
    empresa: 0,
    oferta: 0,
    fecha_inicio: '',
    fecha_fin: '',
    estado: 0,
    observaciones: ''
  };

  estudiantes: Estudiante[] = [];
  empresas: Empresa[] = [];
  ofertas: OfertaEmpresa[] = [];
  estadosProceso: EstadoProceso[] = [];
  contactosEmpresa: ContactoEmpresa[] = [];
  
  isLoading = true;
  isSaving = false;
  error: string | null = null;
  isEditMode = false;
  procesoId: number | null = null;

  // Para formularios adicionales
  contactoSeleccionado: ContactoEmpresa | null = null;
  ofertasFiltradas: OfertaEmpresa[] = [];
  isLoadingOfertas: boolean = false;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private procesoCoformacionService: ProcesoCoformacionService,
    private estudiantesService: EstudiantesService,
    private empresasService: EmpresasService,
    private ofertasEmpresasService: OfertasempresasService,
    private estadoProcesoService: EstadoProcesoService,
    private contactosEmpresaService: ContactosEmpresaService
  ) {}

  ngOnInit() {
    // Verificar si estamos en modo edición
    this.route.queryParams.subscribe(params => {
      if (params['id']) {
        this.procesoId = +params['id'];
        this.isEditMode = true;
      }
    });

    this.loadData();
  }

  loadData() {
    this.isLoading = true;
    this.error = null;

    // Cargar todos los datos necesarios
    Promise.all([
      this.estudiantesService.getAll().toPromise(),
      this.empresasService.getAll().toPromise(),
      this.ofertasEmpresasService.getAll().toPromise(),
      this.estadoProcesoService.getAll().toPromise(),
      this.contactosEmpresaService.getAll().toPromise()
    ]).then(([estudiantes, empresas, ofertas, estados, contactos]) => {
      this.estudiantes = estudiantes || [];
      this.empresas = empresas || [];
      this.ofertas = ofertas || [];
      this.ofertasFiltradas = [...this.ofertas];
      this.estadosProceso = estados || [];
      this.contactosEmpresa = contactos || [];

      // Si estamos en modo edición, cargar el proceso específico
      if (this.isEditMode && this.procesoId) {
        this.loadProceso();
      } else {
        this.isLoading = false;
      }
    }).catch(error => {
      console.error('Error cargando datos:', error);
      this.error = 'Error al cargar los datos. Verifica que el backend esté ejecutándose.';
      this.isLoading = false;
    });
  }

  loadProceso() {
    if (!this.procesoId) return;

    this.procesoCoformacionService.getById(this.procesoId).subscribe({
      next: (proceso) => {
        this.proceso = proceso;
        this.onEmpresaChange(); // Actualizar ofertas cuando se carga el proceso
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error cargando proceso:', error);
        this.error = 'Error al cargar el proceso de coformación.';
        this.isLoading = false;
      }
    });
  }

  // Métodos auxiliares para obtener nombres
  getEstudianteNombre(estudianteId: number): string {
    const estudiante = this.estudiantes.find(e => e.estudiante_id === estudianteId);
    return estudiante ? estudiante.nombre_completo : '';
  }

  getEmpresaNombre(empresaId: number): string {
    const empresa = this.empresas.find(e => e.empresa_id === empresaId);
    return empresa && empresa.nombre_comercial ? empresa.nombre_comercial : '';
  }

  getOfertaDescripcion(ofertaId: number): string {
    const oferta = this.ofertas.find(o => o.oferta_id === ofertaId);
    return oferta ? oferta.descripcion : '';
  }

  getEstadoNombre(estadoId: number): string {
    const estado = this.estadosProceso.find(e => e.estado_id === estadoId);
    return estado ? estado.nombre : '';
  }

  // Event handlers
  onEmpresaChange() {
    if (this.proceso.empresa && this.proceso.empresa > 0) {
      // Cargar ofertas de la empresa seleccionada
      this.cargarOfertasEmpresa(this.proceso.empresa);
      
      // Obtener contacto principal de la empresa
      const contacto = this.contactosEmpresa.find(c => c.empresa_id === this.proceso.empresa);
      this.contactoSeleccionado = contacto || null;
      
      // Limpiar oferta seleccionada al cambiar de empresa
      this.proceso.oferta = 0;
    } else {
      this.ofertasFiltradas = [];
      this.contactoSeleccionado = null;
      this.proceso.oferta = 0;
    }
  }

  cargarOfertasEmpresa(empresaId: number) {
    this.isLoadingOfertas = true;
    // Filtrar ofertas por empresa desde el array local primero
    this.ofertasFiltradas = this.ofertas.filter(o => {
      // Verificar si la oferta pertenece a esta empresa
      const ofertaEmpresaId = o.empresa || o.empresa_id;
      return ofertaEmpresaId === empresaId;
    });
    
    // Si ya tenemos ofertas en el array local, usarlas
    if (this.ofertasFiltradas.length > 0) {
      this.isLoadingOfertas = false;
      return;
    }

    // Si no hay ofertas en el array local, intentar cargar desde el backend
    this.ofertasEmpresasService.getAll().subscribe({
      next: (ofertas) => {
        this.ofertas = ofertas || [];
        this.ofertasFiltradas = this.ofertas.filter(o => {
          const ofertaEmpresaId = o.empresa || o.empresa_id;
          return ofertaEmpresaId === empresaId;
        });
        this.isLoadingOfertas = false;
      },
      error: (error) => {
        console.error('Error cargando ofertas:', error);
        this.ofertasFiltradas = [];
        this.isLoadingOfertas = false;
      }
    });
  }

  seleccionarOferta(ofertaId: number) {
    if (ofertaId && ofertaId > 0) {
      this.proceso.oferta = ofertaId;
    }
  }

  getOfertaInfo(oferta: OfertaEmpresa): string {
    let info = '';
    if (oferta.descripcion) {
      info += oferta.descripcion;
    }
    if (oferta.modalidad) {
      info += info ? ` • ${oferta.modalidad}` : oferta.modalidad;
    }
    if (oferta.fecha_inicio && oferta.fecha_fin) {
      info += info ? ` • ${oferta.fecha_inicio} - ${oferta.fecha_fin}` : `${oferta.fecha_inicio} - ${oferta.fecha_fin}`;
    }
    return info || 'Sin información adicional';
  }

  getOfertaId(oferta: OfertaEmpresa): number | undefined {
    // Manejar diferentes nombres de campo para el ID
    return oferta.oferta_id || (oferta as any).idOferta;
  }

  isOfertaSelected(oferta: OfertaEmpresa): boolean {
    const ofertaId = this.getOfertaId(oferta);
    return this.proceso.oferta === ofertaId;
  }

  onSubmit() {
    if (!this.isValidForm()) {
      this.error = 'Por favor complete todos los campos obligatorios.';
      return;
    }

    this.isSaving = true;
    this.error = null;

    const procesoData = { ...this.proceso };
    
    // Convertir fechas al formato correcto si es necesario
    if (procesoData.fecha_fin === '') {
      procesoData.fecha_fin = undefined;
    }

    const operation = this.isEditMode 
      ? this.procesoCoformacionService.update(this.proceso.proceso_id, procesoData)
      : this.procesoCoformacionService.create(procesoData);

    operation.subscribe({
      next: (response) => {
        this.isSaving = false;
        this.router.navigate(['/editar-estudiante'], { 
          queryParams: { mensaje: 'Proceso de coformación guardado exitosamente' }
        });
      },
      error: (error) => {
        console.error('Error guardando proceso:', error);
        this.error = 'Error al guardar el proceso. Verifique los datos e intente nuevamente.';
        this.isSaving = false;
      }
    });
  }

  isValidForm(): boolean {
    return !!(
      this.proceso.estudiante &&
      this.proceso.empresa &&
      this.proceso.oferta &&
      this.proceso.fecha_inicio &&
      this.proceso.estado
    );
  }

  onCancel() {
    this.router.navigate(['/editar-estudiante']);
  }

  guardar() {
    this.onSubmit();
  }

  cancelar() {
    this.onCancel();
  }

  verHistorialProcesos() {
    this.router.navigate(['/historial-coformacion']);
  }

  refreshData() {
    this.loadData();
  }
}
