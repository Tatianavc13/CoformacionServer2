import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { EstudiantesService } from '../../services/estudiantes.service';
import { ProgramasService } from '../../services/programas.service';
import { FacultadesService } from '../../services/facultades.service';
import { PromocionesService } from '../../services/promociones.service';
import { TiposDocumentoService } from '../../services/tipos_documento.service';
import { NivelesInglesService } from '../../services/niveles_ingles.service';
import { EstadosCarteraService } from '../../services/estados_cartera.service';
import { Estudiante, Programa, Facultad, Promocion, TipoDocumento, NivelIngles, EstadoCartera } from '../../models/interfaces';
import { Router } from '@angular/router';

interface Filtros {
  programa_id: number | null;
  promocion_id: number | null;
  estado_cartera_id: number | null;
  nivel_ingles_id: number | null;
}

@Component({
  selector: 'app-consult-estudent',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './consult-estudent.component.html',
  styleUrl: './consult-estudent.component.css'
})
export class ConsultEstudentComponent implements OnInit {
  estudiantes: Estudiante[] = [];
  estudiantesFiltrados: Estudiante[] = [];
  programas: Programa[] = [];
  facultades: Facultad[] = [];
  promociones: Promocion[] = [];
  tiposDocumento: TipoDocumento[] = [];
  nivelesIngles: NivelIngles[] = [];
  estadosCartera: EstadoCartera[] = [];
  
  isLoading = true;
  error: string | null = null;
  searchTerm = '';

  showFilterModal = false;
  filtros: Filtros = {
    programa_id: null,
    promocion_id: null,
    estado_cartera_id: null,
    nivel_ingles_id: null
  };

  constructor(
    private estudiantesService: EstudiantesService,
    private programasService: ProgramasService,
    private facultadesService: FacultadesService,
    private promocionesService: PromocionesService,
    private tiposDocumentoService: TiposDocumentoService,
    private nivelesInglesService: NivelesInglesService,
    private estadosCarteraService: EstadosCarteraService,
    private router: Router
  ) { }

  ngOnInit() {
    this.loadData();
  }

  loadData() {
    this.isLoading = true;
    this.error = null;

    Promise.all([
      this.estudiantesService.getAll().toPromise(),
      this.programasService.getAll().toPromise(),
      this.facultadesService.getAll().toPromise(),
      this.promocionesService.getAll().toPromise(),
      this.tiposDocumentoService.getAll().toPromise(),
      this.nivelesInglesService.getAll().toPromise(),
      this.estadosCarteraService.getAll().toPromise()
    ]).then(([estudiantes, programas, facultades, promociones, tiposDocumento, nivelesIngles, estadosCartera]) => {
      this.estudiantes = estudiantes || [];
      this.programas = programas || [];
      this.facultades = facultades || [];
      this.promociones = promociones || [];
      this.tiposDocumento = tiposDocumento || [];
      this.nivelesIngles = nivelesIngles || [];
      this.estadosCartera = estadosCartera || [];
      
      // Debug: verificar que los datos se cargaron
      console.log('Datos cargados:');
      console.log('- Estudiantes:', this.estudiantes.length);
      console.log('- Programas:', this.programas.length, this.programas);
      console.log('- Promociones:', this.promociones.length, this.promociones);
      console.log('- Niveles inglés:', this.nivelesIngles.length, this.nivelesIngles);
      console.log('- Estados cartera:', this.estadosCartera.length, this.estadosCartera);
      
      this.applyAllFilters(); // Aplicar filtros después de cargar datos
      this.isLoading = false;
    }).catch(error => {
      console.error('Error cargando datos:', error);
      this.error = 'Error al cargar los datos. Por favor, intente nuevamente.';
      this.isLoading = false;
    });
  }

  refreshData() {
    this.loadData();
  }

  onSearch(value: string) {
    this.searchTerm = value;
    console.log('Búsqueda iniciada con término:', this.searchTerm);
    this.applyAllFilters();
    console.log('Resultados encontrados:', this.estudiantesFiltrados.length);
  }

  private applyAllFilters() {
    console.log('Aplicando filtros:', this.filtros, 'Búsqueda:', this.searchTerm);
    console.log('Total estudiantes:', this.estudiantes.length);
    
    // Primero aplicar filtros del modal
    let resultados = this.estudiantes.filter(estudiante => {
      let cumpleFiltros = true;

      if (this.filtros.programa_id && this.filtros.programa_id !== null) {
        // Convertir a número para comparación
        const programaIdFiltro = Number(this.filtros.programa_id);
        cumpleFiltros = cumpleFiltros && estudiante.programa_id === programaIdFiltro;
        console.log(`Filtro programa: ${estudiante.programa_id} === ${programaIdFiltro}?`, estudiante.programa_id === programaIdFiltro);
      }

      if (this.filtros.promocion_id && this.filtros.promocion_id !== null) {
        const promocionIdFiltro = Number(this.filtros.promocion_id);
        cumpleFiltros = cumpleFiltros && estudiante.promocion_id === promocionIdFiltro;
        console.log(`Filtro promoción: ${estudiante.promocion_id} === ${promocionIdFiltro}?`, estudiante.promocion_id === promocionIdFiltro);
      }

      if (this.filtros.estado_cartera_id && this.filtros.estado_cartera_id !== null) {
        const estadoCarteraIdFiltro = Number(this.filtros.estado_cartera_id);
        cumpleFiltros = cumpleFiltros && estudiante.estado_cartera_id === estadoCarteraIdFiltro;
        console.log(`Filtro estado cartera: ${estudiante.estado_cartera_id} === ${estadoCarteraIdFiltro}?`, estudiante.estado_cartera_id === estadoCarteraIdFiltro);
      }

      if (this.filtros.nivel_ingles_id && this.filtros.nivel_ingles_id !== null) {
        const nivelInglesIdFiltro = Number(this.filtros.nivel_ingles_id);
        cumpleFiltros = cumpleFiltros && estudiante.nivel_ingles_id === nivelInglesIdFiltro;
        console.log(`Filtro nivel inglés: ${estudiante.nivel_ingles_id} === ${nivelInglesIdFiltro}?`, estudiante.nivel_ingles_id === nivelInglesIdFiltro);
      }

      return cumpleFiltros;
    });

    console.log('Después de filtros del modal:', resultados.length, 'estudiantes');

    // Luego aplicar búsqueda de texto
    if (this.searchTerm && this.searchTerm.trim()) {
      const searchLower = this.searchTerm.toLowerCase();
      resultados = resultados.filter(estudiante => 
        estudiante.nombre_completo.toLowerCase().includes(searchLower) ||
        estudiante.numero_documento.includes(searchLower) ||
        estudiante.email_institucional.toLowerCase().includes(searchLower) ||
        this.getProgramaNombre(estudiante.programa_id).toLowerCase().includes(searchLower) ||
        this.getFacultadNombre(estudiante.programa_id).toLowerCase().includes(searchLower)
      );
      console.log('Después de búsqueda de texto:', resultados.length, 'estudiantes');
    }

    this.estudiantesFiltrados = resultados;
    console.log('Resultado final:', this.estudiantesFiltrados.length, 'estudiantes mostrados');
  }

  getProgramaNombre(programaId: number): string {
    const programa = this.programas.find(p => p.programa_id === programaId);
    return programa ? programa.nombre : 'N/A';
  }

  getFacultadNombre(programaId: number): string {
    const programa = this.programas.find(p => p.programa_id === programaId);
    if (programa) {
      const facultad = this.facultades.find(f => f.facultad_id === programa.facultad_id);
      return facultad ? facultad.nombre : 'N/A';
    }
    return 'N/A';
  }

  getPromocionNombre(promocionId: number | null | undefined): string {
    if (!promocionId) return 'N/A';
    const promocion = this.promociones.find(p => p.promocion_id === promocionId);
    return promocion ? promocion.descripcion : 'N/A';
  }

  getTipoDocumentoNombre(tipoDocumento: string): string {
    const tiposMap: { [key: string]: string } = {
      'CC': 'Cédula de Ciudadanía',
      'CE': 'Cédula de Extranjería',
      'PAS': 'Pasaporte',
      'TI': 'Tarjeta de Identidad'
    };
    return tiposMap[tipoDocumento] || tipoDocumento || 'N/A';
  }

  getNivelInglesNombre(nivelId: number | null | undefined): string {
    if (!nivelId) return 'N/A';
    const nivel = this.nivelesIngles.find(n => n.nivel_id === nivelId);
    return nivel ? nivel.nombre : 'N/A';
  }

  getEstadoCarteraNombre(estadoId: number | null | undefined): string {
    if (!estadoId) return 'N/A';
    const estado = this.estadosCartera.find(e => e.estado_id === estadoId);
    return estado ? estado.nombre : 'N/A';
  }

  applyFilters() {
    console.log('=== APLICANDO FILTROS ===');
    console.log('Filtros seleccionados:', this.filtros);
    this.applyAllFilters();
    this.toggleFilterModal();
  }

  toggleFilterModal() {
    this.showFilterModal = !this.showFilterModal;
    if (this.showFilterModal) {
      console.log('Modal abierto - Datos disponibles para filtros:');
      console.log('- Programas para filtro:', this.programas.length);
      console.log('- Promociones para filtro:', this.promociones.length);
      console.log('- Niveles inglés para filtro:', this.nivelesIngles.length);
      console.log('- Estados cartera para filtro:', this.estadosCartera.length);
      console.log('- Filtros actuales:', this.filtros);
    }
  }

  cancelarFiltros() {
    this.showFilterModal = false;
  }

  onFilterChange(filterType: string, event: any) {
    const value = event.target.value;
    console.log(`Filtro ${filterType} cambiado a:`, value, 'tipo:', typeof value);
    
    // No aplicar filtros automáticamente, solo cuando se presione APLICAR
    // Este método es solo para debugging
  }

  clearFilters() {
    this.filtros = {
      programa_id: null,
      promocion_id: null,
      estado_cartera_id: null,
      nivel_ingles_id: null
    };
    this.applyAllFilters();
  }

  verPerfilEstudiante(estudiante: Estudiante): void {
    this.router.navigate(['/perfil-estudiante', estudiante.estudiante_id]);
  }

  navegarAgregarEstudiante(): void {
    this.router.navigate(['/agregar-estudiante']);
  }

  volverAlHome(): void {
    this.router.navigate(['/coformacion']);
  }
}
