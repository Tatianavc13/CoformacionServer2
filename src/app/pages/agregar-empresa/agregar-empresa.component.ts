import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { EmpresasService } from '../../services/empresas.service';
import { SectoresEconomicosService } from '../../services/sectores_economicos.service';
import { TamanosEmpresaService } from '../../services/tamanos_empresa.service';
import { ProgramasService } from '../../services/programas.service';
import { Empresa, EstadoConvenio, SectorEconomico, TamanoEmpresa, Programa } from '../../models/interfaces';

interface ProgramaSolicitado {
  programa: Programa;
  cupos: number;
  seleccionado: boolean;
}

@Component({
  selector: 'app-agregar-empresa',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './agregar-empresa.component.html',
  styleUrl: './agregar-empresa.component.css'
})
export class AgregarEmpresaComponent implements OnInit {
  empresaForm: FormGroup;
  estadoConvenioOptions = Object.values(EstadoConvenio);
  
  // Datos de listas desplegables
  sectoresEconomicos: SectorEconomico[] = [];
  tamanosEmpresa: TamanoEmpresa[] = [];
  programasDisponibles: Programa[] = [];
  programasSolicitados: ProgramaSolicitado[] = [];
  
  // Estados de carga
  isLoading = false;
  error: string | null = null;
  
  // Archivos seleccionados
  archivo1: File | null = null;
  archivo2: File | null = null;
  nombreArchivo1: string = '';
  nombreArchivo2: string = '';
  
  // Logo de la empresa
  logoEmpresa: File | null = null;
  nombreLogoEmpresa: string = '';
  logoPreview: string | null = null;

  constructor(
    private fb: FormBuilder, 
    private router: Router,
    private empresasService: EmpresasService,
    private sectoresService: SectoresEconomicosService,
    private tamanosService: TamanosEmpresaService,
    private programasService: ProgramasService
  ) {
    this.empresaForm = this.fb.group({
      // Información básica
      razon_social: ['', Validators.required],
      nombre_comercial: [''],
      nit: ['', Validators.required],
      sector: ['', Validators.required],
      tamano: ['', Validators.required],
      direccion: ['', Validators.required],
      ciudad: ['', Validators.required],
      departamento: ['', Validators.required],
      telefono: [''],
      email_empresa: [''],
      sitio_web: [''],
      numero_empleados: [null],
      actividad_economica: ['', Validators.required],
      
      // Información de contacto
      nombre_persona_contacto_empresa: ['', Validators.required],
      numero_persona_contacto_empresa: [''],
      cargo_persona_contacto_empresa: ['', Validators.required],
      
      // Convenio
      estado_convenio: [EstadoConvenio.EnTramite, Validators.required],
      fecha_convenio: [''],
      convenio_url: [''],
      
      // Otros campos
      horario_laboral: [''],
      trabaja_sabado: [false],
      observaciones: [''],
      estado: [true],
      cuota_sena: [null],
      logo_url: ['']
    });
  }

  ngOnInit(): void {
    this.loadInitialData();
  }

  async loadInitialData() {
    try {
      this.isLoading = true;
      this.error = null;

      const [sectores, tamanos, programas] = await Promise.all([
        this.sectoresService.getAll().toPromise(),
        this.tamanosService.getAll().toPromise(),
        this.programasService.getAll().toPromise()
      ]);

      this.sectoresEconomicos = sectores || [];
      this.tamanosEmpresa = tamanos || [];
      this.programasDisponibles = programas || [];
      
      // Inicializar programas solicitados
      this.programasSolicitados = this.programasDisponibles.map(programa => ({
        programa,
        cupos: 0,
        seleccionado: false
      }));

    } catch (error) {
      console.error('Error cargando datos iniciales:', error);
      this.error = 'Error al cargar los datos necesarios para el formulario';
    } finally {
      this.isLoading = false;
    }
  }

  onProgramaSelectionChange(index: number, event: any) {
    this.programasSolicitados[index].seleccionado = event.target.checked;
    if (!event.target.checked) {
      this.programasSolicitados[index].cupos = 0;
    }
  }

  onCuposChange(index: number, event: any) {
    const cupos = parseInt(event.target.value) || 0;
    this.programasSolicitados[index].cupos = cupos;
    if (cupos > 0) {
      this.programasSolicitados[index].seleccionado = true;
    }
  }

  onSectorChange(event: any) {
    const value = event.target.value;
    const numValue = value && value !== '' ? parseInt(value) : '';
    this.empresaForm.patchValue({
      sector: numValue
    }, { emitEvent: true });
  }

  onTamanoChange(event: any) {
    const value = event.target.value;
    const numValue = value && value !== '' ? parseInt(value) : '';
    this.empresaForm.patchValue({
      tamano: numValue
    }, { emitEvent: true });
  }

  get totalCupos(): number {
    return this.programasSolicitados
      .filter(p => p.seleccionado)
      .reduce((total, p) => total + p.cupos, 0);
  }

  get programasSeleccionados(): ProgramaSolicitado[] {
    return this.programasSolicitados.filter(p => p.seleccionado && p.cupos > 0);
  }

  async guardarEmpresa() {
    if (this.empresaForm.invalid) {
      this.empresaForm.markAllAsTouched();
      console.log('Formulario inválido. Estado completo:', this.formStatus);
      const invalidFields = Object.keys(this.empresaForm.controls).filter(key => this.empresaForm.controls[key].invalid);
      console.log('Campos con errores:', invalidFields);
      invalidFields.forEach(field => {
        const control = this.empresaForm.controls[field];
        console.log(`  - ${field}:`, {
          value: control.value,
          errors: control.errors,
          touched: control.touched
        });
      });
      alert('Por favor, complete todos los campos requeridos correctamente.');
      return;
    }

    if (this.programasSeleccionados.length === 0) {
      alert('Debe seleccionar al menos un programa y especificar la cantidad de cupos.');
      return;
    }

    try {
      this.isLoading = true;
      this.error = null;

      const formValue = this.empresaForm.value;
      
      // Preparar datos para el backend con los nombres de columna correctos
      const empresaData: any = {
        razon_social: formValue.razon_social,
        nombre_comercial: formValue.nombre_comercial || '',
        nit: formValue.nit,
        sector: formValue.sector ? parseInt(formValue.sector) : null,
        tamano: formValue.tamano ? parseInt(formValue.tamano) : null,
        direccion: formValue.direccion,
        ciudad: formValue.ciudad,
        departamento: formValue.departamento,
        telefono: formValue.telefono || '',
        email_empresa: formValue.email_empresa || '',
        sitio_web: formValue.sitio_web || '',
        numero_empleados: formValue.numero_empleados || null,
        actividad_economica: formValue.actividad_economica,
        nombre_persona_contacto_empresa: formValue.nombre_persona_contacto_empresa,
        numero_persona_contacto_empresa: formValue.numero_persona_contacto_empresa || '',
        cargo_persona_contacto_empresa: formValue.cargo_persona_contacto_empresa,
        estado_convenio: formValue.estado_convenio,
        fecha_convenio: formValue.fecha_convenio || null,
        convenio_url: formValue.convenio_url || '',
        horario_laboral: formValue.horario_laboral || '',
        trabaja_sabado: formValue.trabaja_sabado || false,
        observaciones: formValue.observaciones || '',
        estado: formValue.estado !== false,
        cuota_sena: formValue.cuota_sena || null
        // logo_url: this.logoPreview || formValue.logo_url || ''  // Comentado temporalmente
      };

      console.log('Datos a enviar:', empresaData);
      
      // TODO: Si hay un logo seleccionado, deberías subirlo primero al servidor
      // y luego usar la URL retornada. Por ahora usamos el preview como URL temporal.

      // Llamar al servicio para crear la empresa
      await this.empresasService.create(empresaData).toPromise();
      
      alert('Empresa agregada exitosamente');
      this.router.navigate(['/consult-empresa']);

    } catch (error: any) {
      console.error('Error guardando empresa:', error);
      const errorMessage = error?.error?.error || error?.error?.message || error?.message || 'Error desconocido';
      this.error = `Error al guardar la empresa: ${errorMessage}. Por favor, intente nuevamente.`;
      alert(`Error: ${errorMessage}`);
    } finally {
      this.isLoading = false;
    }
  }

  cancelar() {
    if (confirm('¿Está seguro que desea cancelar? Se perderán todos los datos ingresados.')) {
      this.router.navigate(['/consult-empresa']);
    }
  }

  volverAConsultar() {
    this.router.navigate(['/consult-empresa']);
  }

  get f() { return this.empresaForm.controls; }

  // Métodos para manejar la selección de archivos
  onFileSelected(event: Event, archivoNumero: number): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      const file = input.files[0];
      if (archivoNumero === 1) {
        this.archivo1 = file;
        this.nombreArchivo1 = file.name;
      } else if (archivoNumero === 2) {
        this.archivo2 = file;
        this.nombreArchivo2 = file.name;
      }
    }
  }

  triggerFileInput(archivoNumero: number): void {
    const fileInput = document.getElementById(`fileInput${archivoNumero}`) as HTMLInputElement;
    if (fileInput) {
      fileInput.click();
    }
  }

  // Métodos para manejar el logo de la empresa
  onLogoSelected(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      const file = input.files[0];
      this.logoEmpresa = file;
      this.nombreLogoEmpresa = file.name;
      
      // Crear preview del logo
      const reader = new FileReader();
      reader.onload = (e: any) => {
        this.logoPreview = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  }

  triggerLogoInput(): void {
    const logoInput = document.getElementById('logoInput') as HTMLInputElement;
    if (logoInput) {
      logoInput.click();
    }
  }

  // Método de depuración para ver el estado del formulario
  get formStatus() {
    const status: any = {
      valid: this.empresaForm.valid,
      invalid: this.empresaForm.invalid,
      errors: this.empresaForm.errors,
      fieldErrors: {}
    };
    
    Object.keys(this.empresaForm.controls).forEach(key => {
      const control = this.empresaForm.controls[key];
      if (control.invalid) {
        status.fieldErrors[key] = {
          invalid: control.invalid,
          errors: control.errors,
          value: control.value
        };
      }
    });
    
    return status;
  }
}
