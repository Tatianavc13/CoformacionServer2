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
    
    // Obtener empresa_id de los parámetros de la URL
    this.route.queryParams.subscribe(params => {
      if (params['empresa_id']) {
        this.empresaId = +params['empresa_id'];
      } else if (this.currentUser?.empresa_id) {
        this.empresaId = this.currentUser.empresa_id;
      }
    });

    // Cargar programas disponibles
    this.loadProgramas();
  }

  private loadProgramas(): void {
    this.programasService.getAll().subscribe({
      next: (programas) => {
        this.programasList = programas.filter(p => p.estado === true);
      },
      error: (error) => {
        console.error('Error cargando programas:', error);
        this.error = 'Error al cargar los programas disponibles.';
      }
    });
  }

  publicarOferta(): void {
    if (!this.validateForm()) {
      return;
    }

    if (!this.empresaId) {
      this.error = 'No se pudo identificar la empresa. Por favor, intente de nuevo.';
      return;
    }

    this.isLoading = true;
    this.error = null;

    const ofertaData: Partial<OfertaEmpresa> = {
      empresa: this.empresaId,
      descripcion: this.ofertaForm.descripcion,
      fecha_inicio: this.ofertaForm.fecha_inicio,
      fecha_fin: this.ofertaForm.fecha_fin,
      programa_id: this.ofertaForm.programa_id,
      tipo_oferta: this.ofertaForm.tipo_oferta,
      apoyo_economico: this.ofertaForm.apoyo_economico,
      nombre_responsable: this.ofertaForm.nombre_responsable,
      modalidad: this.ofertaForm.modalidad
    };

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
        this.error = 'Error al publicar la oferta. Por favor, intente de nuevo.';
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
