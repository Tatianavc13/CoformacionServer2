import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { EstudiantesService } from '../../services/estudiantes.service';
import { ProgramasService } from '../../services/programas.service';
import { FacultadesService } from '../../services/facultades.service';
import { PromocionesService } from '../../services/promociones.service';
import { TiposDocumentoService } from '../../services/tipos_documento.service';
import { NivelesInglesService } from '../../services/niveles_ingles.service';
import { EstadosCarteraService } from '../../services/estados_cartera.service';
import { Estudiante, Programa, Facultad, Promocion, TipoDocumento, NivelIngles, EstadoCartera } from '../../models/interfaces';

@Component({
  selector: 'app-editar-estudiante',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './editar-estudiante.component.html',
  styleUrl: './editar-estudiante.component.css'
})
export class EditarEstudianteComponent implements OnInit {
  estudiante: Estudiante = {
    estudiante_id: 0,
    codigo_estudiante: '',
    nombre_completo: '',
    tipo_documento: 'CC',
    numero_documento: '',
    fecha_nacimiento: '',
    genero: 'M',
    telefono: '',
    celular: '',
    email_institucional: '',
    email_personal: '',
    direccion: '',
    ciudad: '',
    foto_url: '',
    programa_id: 0,
    semestre: 1,
    jornada: 'Diurna',
    promedio_acumulado: null,
    estado: 'Activo',
    fecha_ingreso: '',
    fecha_creacion: '',
    fecha_actualizacion: '',
    nivel_ingles_id: null,
    estado_cartera_id: null,
    promocion_id: null
  };

  // Datos de referencia para los dropdowns
  programas: Programa[] = [];
  facultades: Facultad[] = [];
  promociones: Promocion[] = [];
  tiposDocumento: TipoDocumento[] = [];
  nivelesIngles: NivelIngles[] = [];
  estadosCartera: EstadoCartera[] = [];

  isLoading = true;
  isSaving = false;
  error: string | null = null;
  estudianteId: number | null = null;
  successMessage: string | null = null;

  // Para almacenar los datos originales
  originalData: Estudiante | null = null;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private estudiantesService: EstudiantesService,
    private programasService: ProgramasService,
    private facultadesService: FacultadesService,
    private promocionesService: PromocionesService,
    private tiposDocumentoService: TiposDocumentoService,
    private nivelesInglesService: NivelesInglesService,
    private estadosCarteraService: EstadosCarteraService
  ) {}

  ngOnInit(): void {
    // Obtener ID del estudiante de los parámetros de la ruta
    this.route.queryParams.subscribe(params => {
      if (params['id']) {
        this.estudianteId = +params['id'];
        this.loadData();
      } else {
        this.error = 'No se especificó el ID del estudiante a editar.';
        this.isLoading = false;
      }
    });

    // Mostrar mensaje de éxito si viene en los parámetros
    if (this.route.snapshot.queryParams['mensaje']) {
      this.successMessage = this.route.snapshot.queryParams['mensaje'];
      setTimeout(() => this.successMessage = null, 5000);
    }
  }

  private loadData(): void {
    this.isLoading = true;
    this.error = null;

    // Cargar todos los datos necesarios
    Promise.all([
      this.estudiantesService.getById(this.estudianteId!).toPromise(),
      this.programasService.getAll().toPromise(),
      this.facultadesService.getAll().toPromise(),
      this.promocionesService.getAll().toPromise(),
      this.tiposDocumentoService.getAll().toPromise(),
      this.nivelesInglesService.getAll().toPromise(),
      this.estadosCarteraService.getAll().toPromise()
    ]).then(([estudiante, programas, facultades, promociones, tiposDocumento, nivelesIngles, estadosCartera]) => {
      this.estudiante = { ...estudiante };
      this.originalData = { ...estudiante };
      this.programas = programas || [];
      this.facultades = facultades || [];
      this.promociones = promociones || [];
      this.tiposDocumento = tiposDocumento || [];
      this.nivelesIngles = nivelesIngles || [];
      this.estadosCartera = estadosCartera || [];
      this.isLoading = false;
    }).catch(error => {
      console.error('Error cargando datos:', error);
      this.error = 'Error al cargar los datos del estudiante.';
      this.isLoading = false;
    });
  }

  // Métodos auxiliares para obtener nombres
  getProgramaNombre(programaId: number): string {
    const programa = this.programas.find(p => p.programa_id === programaId);
    return programa ? programa.nombre : '';
  }

  getFacultadNombre(programaId: number): string {
    const programa = this.programas.find(p => p.programa_id === programaId);
    if (programa) {
      const facultad = this.facultades.find(f => f.facultad_id === programa.facultad_id);
      return facultad ? facultad.nombre : '';
    }
    return '';
  }

  // Validación del formulario
  isValidForm(): boolean {
    return !!(
      this.estudiante.nombre_completo.trim() &&
      this.estudiante.numero_documento.trim() &&
      this.estudiante.email_institucional.trim() &&
      this.estudiante.tipo_documento &&
      this.estudiante.programa_id
    );
  }

  hasChanges(): boolean {
    if (!this.originalData) return false;
    return JSON.stringify(this.estudiante) !== JSON.stringify(this.originalData);
  }

  // Guardar cambios (PUT)
  onSave(): void {
    if (!this.isValidForm()) {
      this.error = 'Por favor complete todos los campos obligatorios.';
      return;
    }

    this.isSaving = true;
    this.error = null;
    this.successMessage = null;

    // Preparar datos para envío
    const updateData = { ...this.estudiante };
    
    // Convertir valores vacíos/cero a null para campos opcionales
    if (!updateData.telefono?.trim()) updateData.telefono = null;
    if (!updateData.email_personal?.trim()) updateData.email_personal = null;
    if (!updateData.direccion?.trim()) updateData.direccion = null;
    if (!updateData.ciudad?.trim()) updateData.ciudad = null;
    if (!updateData.foto_url?.trim()) updateData.foto_url = null;
    if (!updateData.nivel_ingles_id) updateData.nivel_ingles_id = null;
    if (!updateData.estado_cartera_id) updateData.estado_cartera_id = null;
    if (!updateData.promocion_id) updateData.promocion_id = null;

    this.estudiantesService.update(this.estudiante.estudiante_id, updateData).subscribe({
      next: (response) => {
        this.originalData = { ...this.estudiante };
        this.successMessage = 'Información del estudiante actualizada exitosamente.';
        this.isSaving = false;
        
        // Opcional: redirigir al perfil después de 2 segundos
        setTimeout(() => {
          this.router.navigate(['/perfil-estudiante'], { 
            queryParams: { id: this.estudianteId }
          });
        }, 2000);
      },
      error: (error) => {
        console.error('Error actualizando estudiante:', error);
        this.error = 'Error al actualizar la información. Verifique los datos e intente nuevamente.';
        this.isSaving = false;
      }
    });
  }

  onCancel(): void {
    if (this.hasChanges()) {
      const confirmCancel = confirm('¿Está seguro de cancelar? Se perderán los cambios no guardados.');
      if (!confirmCancel) return;
    }
    
    this.router.navigate(['/perfil-estudiante'], { 
      queryParams: { id: this.estudianteId } 
    });
  }

  resetForm(): void {
    if (this.originalData) {
      this.estudiante = { ...this.originalData };
      this.error = null;
      this.successMessage = null;
    }
  }

  navigateToHistorialCoformacion() {
    this.router.navigate(['/historial-coformacion'], { 
      queryParams: { estudiante_id: this.estudianteId } 
    });
  }

  navigateToPerfilEstudiante() {
    this.router.navigate(['/perfil-estudiante'], { 
      queryParams: { id: this.estudianteId } 
    });
  }

  navigateToProcesoCoformacion() {
    this.router.navigate(['/proceso-coformacion'], { 
      queryParams: { estudiante_id: this.estudianteId } 
    });
  }

  refreshData() {
    this.loadData();
  }
}
