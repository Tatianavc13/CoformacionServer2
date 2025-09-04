import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { EstudiantesService } from '../../services/estudiantes.service';
import { ProgramasService } from '../../services/programas.service';
import { TiposDocumentoService } from '../../services/tipos_documento.service';
import { NivelesInglesService } from '../../services/niveles_ingles.service';
import { PromocionesService } from '../../services/promociones.service';
import { EstadosCarteraService } from '../../services/estados_cartera.service';
import { Estudiante, Programa, TipoDocumento, NivelIngles, Promocion, EstadoCartera } from '../../models/interfaces';

@Component({
  selector: 'app-agregar-estudiante',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './agregar-estudiante.component.html',
  styleUrl: './agregar-estudiante.component.css'
})
export class AgregarEstudianteComponent implements OnInit {
  estudianteForm: FormGroup;
  
  // Datos para listas desplegables
  programas: Programa[] = [];
  tiposDocumento: TipoDocumento[] = [];
  nivelesIngles: NivelIngles[] = [];
  promociones: Promocion[] = [];
  estadosCartera: EstadoCartera[] = [];
  
  // Opciones para campos de selección
  generoOptions = [
    { value: 'M', label: 'Masculino' },
    { value: 'F', label: 'Femenino' },
    { value: 'O', label: 'Otro' }
  ];
  jornadaOptions = [
    { value: 'Diurna', label: 'Diurna' },
    { value: 'Nocturna', label: 'Nocturna' },
    { value: 'Mixta', label: 'Mixta' }
  ];
  estadoOptions = ['Activo', 'Inactivo', 'Graduado', 'Retirado'];
  
  // Estados de carga
  isLoading = false;
  error: string | null = null;

  constructor(
    private fb: FormBuilder,
    private router: Router,
    private estudiantesService: EstudiantesService,
    private programasService: ProgramasService,
    private tiposDocumentoService: TiposDocumentoService,
    private nivelesInglesService: NivelesInglesService,
    private promocionesService: PromocionesService,
    private estadosCarteraService: EstadosCarteraService
  ) {
    this.estudianteForm = this.fb.group({
      // Información personal básica
      codigo_estudiante: ['', [Validators.required, Validators.pattern(/^\d+$/)]],
      nombre_completo: ['', [Validators.required, Validators.minLength(3)]],
      tipo_documento: ['CC', Validators.required],
      numero_documento: ['', [Validators.required, Validators.pattern(/^\d+$/)]],
      fecha_nacimiento: ['', Validators.required],
      genero: ['', Validators.required],
      
      // Información de contacto
      telefono: ['', Validators.pattern(/^\d{7,10}$/)],
      celular: ['', [Validators.required, Validators.pattern(/^\d{10}$/)]],
      email_institucional: ['', [Validators.required, Validators.email]],
      email_personal: ['', Validators.email],
      direccion: [''],
      ciudad: [''],
      
      // Información académica
      programa_id: [null, Validators.required],
      semestre: [1, [Validators.required, Validators.min(1), Validators.max(20)]],
      jornada: ['', Validators.required],
      promedio_acumulado: [null, [Validators.min(0), Validators.max(5)]],
      estado: ['Activo', Validators.required],
      fecha_ingreso: ['', Validators.required],
      
      // Información adicional
      nivel_ingles_id: [null],
      promocion_id: [null],
      estado_cartera_id: [null],
      
      // Foto (opcional)
      foto_url: ['']
    });
  }

  ngOnInit(): void {
    this.loadInitialData();
  }

  async loadInitialData() {
    try {
      this.isLoading = true;
      this.error = null;

      const [programas, tiposDocumento, nivelesIngles, promociones, estadosCartera] = await Promise.all([
        this.programasService.getAll().toPromise(),
        this.tiposDocumentoService.getAll().toPromise(),
        this.nivelesInglesService.getAll().toPromise(),
        this.promocionesService.getAll().toPromise(),
        this.estadosCarteraService.getAll().toPromise()
      ]);

      this.programas = programas || [];
      this.tiposDocumento = tiposDocumento || [];
      this.nivelesIngles = nivelesIngles || [];
      this.promociones = promociones || [];
      this.estadosCartera = estadosCartera || [];

    } catch (error) {
      console.error('Error cargando datos iniciales:', error);
      this.error = 'Error al cargar los datos necesarios para el formulario';
    } finally {
      this.isLoading = false;
    }
  }

  async guardarEstudiante() {
    if (this.estudianteForm.invalid) {
      this.estudianteForm.markAllAsTouched();
      return;
    }

    try {
      this.isLoading = true;
      this.error = null;

      const estudianteData = {
        ...this.estudianteForm.value,
        // Asegurar que los campos numéricos sean números
        semestre: parseInt(this.estudianteForm.value.semestre),
        promedio_acumulado: this.estudianteForm.value.promedio_acumulado ? parseFloat(this.estudianteForm.value.promedio_acumulado) : null
      };

      await this.estudiantesService.create(estudianteData).toPromise();
      
      alert('Estudiante agregado exitosamente');
      this.router.navigate(['/consult-estudent']);

    } catch (error) {
      console.error('Error guardando estudiante:', error);
      this.error = 'Error al guardar el estudiante. Por favor, intente nuevamente.';
    } finally {
      this.isLoading = false;
    }
  }

  cancelar() {
    if (confirm('¿Está seguro que desea cancelar? Se perderán todos los datos ingresados.')) {
      this.router.navigate(['/consult-estudent']);
    }
  }

  volverAConsultar() {
    this.router.navigate(['/consult-estudent']);
  }

  get f() { return this.estudianteForm.controls; }
}
