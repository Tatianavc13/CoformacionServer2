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
      sector: [null, Validators.required],
      tamano: [null, Validators.required],
      direccion: ['', Validators.required],
      ciudad: ['', Validators.required],
      departamento: ['', Validators.required],
      telefono: [''],
      sitio_web: [''],
      numero_empleados: [null],
      actividad_economica: ['', Validators.required],
      
      // Convenio
      estado_convenio: [EstadoConvenio.EnTramite, Validators.required],
      fecha_convenio: [''],
      convenio_url: [''],
      
      // Otros campos
      horario_laboral: [''],
      trabaja_sabado: [false],
      observaciones: [''],
      estado: [true],
      cuota_sena: [null]
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
      return;
    }

    if (this.programasSeleccionados.length === 0) {
      alert('Debe seleccionar al menos un programa y especificar la cantidad de cupos.');
      return;
    }

    try {
      this.isLoading = true;
      this.error = null;

      const empresaData: any = {
        ...this.empresaForm.value,
        programas_solicitados: this.programasSeleccionados.map(p => ({
          programa_id: p.programa.programa_id,
          cupos: p.cupos
        }))
      };

      // Llamar al servicio para crear la empresa
      await this.empresasService.create(empresaData).toPromise();
      
      alert('Empresa agregada exitosamente');
      this.router.navigate(['/consult-empresa']);

    } catch (error) {
      console.error('Error guardando empresa:', error);
      this.error = 'Error al guardar la empresa. Por favor, intente nuevamente.';
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
}
