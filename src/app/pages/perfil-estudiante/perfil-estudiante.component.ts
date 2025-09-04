import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute } from '@angular/router';
import { EstudiantesService } from '../../services/estudiantes.service';
import { ProgramasService } from '../../services/programas.service';
import { FacultadesService } from '../../services/facultades.service';
import { PromocionesService } from '../../services/promociones.service';
import { TiposDocumentoService } from '../../services/tipos_documento.service';
import { NivelesInglesService } from '../../services/niveles_ingles.service';
import { EstadosCarteraService } from '../../services/estados_cartera.service';
import { ProcesoCoformacionService } from '../../services/proceso_coformacion.service';
import { EmpresasService } from '../../services/empresas.service';
import { EstadoProcesoService } from '../../services/estado_proceso.service';
import { Estudiante, Programa, Facultad, Promocion, TipoDocumento, NivelIngles, EstadoCartera, ProcesoCoformacion, Empresa, EstadoProceso } from '../../models/interfaces';

@Component({
  selector: 'app-perfil-estudiante',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './perfil-estudiante.component.html',
  styleUrl: './perfil-estudiante.component.css'
})
export class PerfilEstudianteComponent implements OnInit {
  estudiante: Estudiante | null = null;
  programa: Programa | null = null;
  facultad: Facultad | null = null;
  promocion: Promocion | null = null;
  tipoDocumento: TipoDocumento | null = null;
  nivelIngles: NivelIngles | null = null;
  estadoCartera: EstadoCartera | null = null;
  procesoCoformacion: ProcesoCoformacion | null = null;
  empresa: Empresa | null = null;
  estadoProceso: EstadoProceso | null = null;
  
  isLoading = true;
  error: string | null = null;
  estudianteId: number | null = null;

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private estudiantesService: EstudiantesService,
    private programasService: ProgramasService,
    private facultadesService: FacultadesService,
    private promocionesService: PromocionesService,
    private tiposDocumentoService: TiposDocumentoService,
    private nivelesInglesService: NivelesInglesService,
    private estadosCarteraService: EstadosCarteraService,
    private procesoCoformacionService: ProcesoCoformacionService,
    private empresasService: EmpresasService,
    private estadoProcesoService: EstadoProcesoService
  ) {}

  ngOnInit(): void {
    // Obtener ID del estudiante de los parámetros de la ruta
    this.route.params.subscribe(params => {
      if (params['id']) {
        this.estudianteId = +params['id'];
        this.loadStudentProfile();
      } else {
        // Si no hay ID en params, revisar queryParams (para compatibilidad)
        this.route.queryParams.subscribe(queryParams => {
          if (queryParams['id']) {
            this.estudianteId = +queryParams['id'];
            this.loadStudentProfile();
          } else {
            // Si no hay ID, podríamos mostrar el primer estudiante o redirigir
            this.loadFirstStudent();
          }
        });
      }
    });
  }

  private loadFirstStudent(): void {
    this.estudiantesService.getAll().subscribe({
      next: (estudiantes) => {
        if (estudiantes && estudiantes.length > 0) {
          this.estudianteId = estudiantes[0].estudiante_id;
          this.loadStudentProfile();
        } else {
          this.error = 'No hay estudiantes registrados en el sistema.';
          this.isLoading = false;
        }
      },
      error: (error) => {
        console.error('Error cargando estudiantes:', error);
        this.error = 'Error al cargar los estudiantes.';
        this.isLoading = false;
      }
    });
  }

  private loadStudentProfile(): void {
    if (!this.estudianteId) return;

    this.isLoading = true;
    this.error = null;

    // Cargar datos del estudiante
    this.estudiantesService.getById(this.estudianteId).subscribe({
      next: (estudiante) => {
        this.estudiante = estudiante;
        this.loadRelatedData();
      },
      error: (error) => {
        console.error('Error cargando estudiante:', error);
        this.error = 'Error al cargar la información del estudiante.';
        this.isLoading = false;
      }
    });
  }

  private loadRelatedData(): void {
    if (!this.estudiante) return;

    const requests = [];

    // Cargar datos relacionados
    if (this.estudiante.programa_id) {
      requests.push(
        this.programasService.getById(this.estudiante.programa_id).subscribe({
          next: (programa) => {
            this.programa = programa;
            // Cargar facultad
            if (programa.facultad_id) {
              this.facultadesService.getById(programa.facultad_id).subscribe({
                next: (facultad) => this.facultad = facultad,
                error: (error) => console.error('Error cargando facultad:', error)
              });
            }
          },
          error: (error) => console.error('Error cargando programa:', error)
        })
      );
    }

    // Para tipo_documento, ahora es un ENUM (string), no necesita consulta adicional

    if (this.estudiante.promocion_id) {
      requests.push(
        this.promocionesService.getById(this.estudiante.promocion_id).subscribe({
          next: (promocion) => this.promocion = promocion,
          error: (error) => console.error('Error cargando promoción:', error)
        })
      );
    }

    if (this.estudiante.nivel_ingles_id) {
      requests.push(
        this.nivelesInglesService.getById(this.estudiante.nivel_ingles_id).subscribe({
          next: (nivel) => this.nivelIngles = nivel,
          error: (error) => console.error('Error cargando nivel inglés:', error)
        })
      );
    }

    if (this.estudiante.estado_cartera_id) {
      requests.push(
        this.estadosCarteraService.getById(this.estudiante.estado_cartera_id).subscribe({
          next: (estado) => this.estadoCartera = estado,
          error: (error) => console.error('Error cargando estado cartera:', error)
        })
      );
    }

    // Cargar proceso de coformación activo
    this.procesoCoformacionService.getAll().subscribe({
      next: (procesos) => {
        const procesoActivo = procesos.find(p => p.estudiante === this.estudiante!.estudiante_id);
        if (procesoActivo) {
          this.procesoCoformacion = procesoActivo;
          
          // Cargar empresa del proceso
          if (procesoActivo.empresa) {
            this.empresasService.getById(procesoActivo.empresa).subscribe({
              next: (empresa) => this.empresa = empresa,
              error: (error) => console.error('Error cargando empresa:', error)
            });
          }

          // Cargar estado del proceso
          if (procesoActivo.estado) {
            this.estadoProcesoService.getById(procesoActivo.estado).subscribe({
              next: (estado) => this.estadoProceso = estado,
              error: (error) => console.error('Error cargando estado proceso:', error)
            });
          }
        }
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error cargando procesos:', error);
        this.isLoading = false;
      }
    });
  }

  // Métodos auxiliares para mostrar información
  getNombreCompleto(): string {
    return this.estudiante ? this.estudiante.nombre_completo : '';
  }

  getTipoDocumentoNombre(): string {
    // Ahora tipo_documento es un ENUM string, no necesita consulta
    if (!this.estudiante?.tipo_documento) return 'N/A';
    
    const tiposMap: { [key: string]: string } = {
      'CC': 'Cédula de Ciudadanía',
      'CE': 'Cédula de Extranjería',
      'PAS': 'Pasaporte',
      'TI': 'Tarjeta de Identidad'
    };
    
    return tiposMap[this.estudiante.tipo_documento] || this.estudiante.tipo_documento;
  }

  getProgramaNombre(): string {
    return this.programa ? this.programa.nombre : 'N/A';
  }

  getFacultadNombre(): string {
    return this.facultad ? this.facultad.nombre : 'N/A';
  }

  getPromocionNombre(): string {
    return this.promocion ? this.promocion.descripcion : 'N/A';
  }

  getNivelInglesNombre(): string {
    return this.nivelIngles ? this.nivelIngles.nombre : 'N/A';
  }

  getEstadoCarteraNombre(): string {
    return this.estadoCartera ? this.estadoCartera.nombre : 'N/A';
  }

  getEmpresaNombre(): string {
    return this.empresa && this.empresa.nombre_comercial ? this.empresa.nombre_comercial : 'Sin empresa';
  }

  getEstadoProcesoNombre(): string {
    return this.estadoProceso ? this.estadoProceso.nombre : 'N/A';
  }

  getFechaInicioFormateada(): string {
    return this.procesoCoformacion ? this.procesoCoformacion.fecha_inicio : 'N/A';
  }

  getFechaFinFormateada(): string {
    return this.procesoCoformacion?.fecha_fin || 'En curso';
  }

  // Navegación
  navigateToHistorialCoformacion() {
    this.router.navigate(['/historial-coformacion'], { 
      queryParams: { estudiante_id: this.estudianteId } 
    });
  }

  navigateToEditarEstudiante() {
    this.router.navigate(['/editar-estudiante'], { 
      queryParams: { id: this.estudianteId }
    });
  }

  navigateToCreateProcess() {
    this.router.navigate(['/proceso-coformacion'], { 
      queryParams: { estudiante_id: this.estudianteId } 
    });
  }

  refreshData() {
    this.loadStudentProfile();
  }
}
