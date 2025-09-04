import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { EmpresasService } from '../../services/empresas.service';
import { SectoresEconomicosService } from '../../services/sectores_economicos.service';
import { TamanosEmpresaService } from '../../services/tamanos_empresa.service';
import { ContactosEmpresaService } from '../../services/contactos_empresa.service';
import { TiposContactoService } from '../../services/tipos_contacto.service';
import { Empresa, SectorEconomico, TamanoEmpresa, ContactoEmpresa, TipoContacto, EstadoConvenio } from '../../models/interfaces';

interface CompanyForm {
  nombre: string;
  razonSocial: string;
  nit: string;
  ccb: string;
  actividadEconomica: string;
  pais: string;
  sector: string;
  direccion: string;
  localidad: string;
  tamanoEmpresa: string;
  formatoRegistro: string;
  estado: string;
  ccRepresentanteLegal: string;
  ejecutivoCuenta: string;
  paginaWeb: string;
  rut: string;
  ciio: string;
}

interface Agreement {
  tipoConvenio: string;
  fechaConvenio: string;
  duracionConvenio: string;
}

interface Program {
  nombre: string;
  cupos: number;
}

@Component({
  selector: 'app-editar-empresa',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './editar-empresa.component.html',
  styleUrl: './editar-empresa.component.css'
})
export class EditarEmpresaComponent implements OnInit {
  empresa: Empresa = {
    empresa_id: 0,
    razon_social: '',
    nombre_comercial: '',
    sector: 0,
    tamano: 0,
    direccion: '',
    ciudad: '',
    departamento: '',
    telefono: '',
    sitio_web: '',
    cuota_sena: null,
    numero_empleados: null,
    estado_convenio: EstadoConvenio.EnTramite,
    fecha_convenio: '',
    convenio_url: '',
    actividad_economica: '',
    horario_laboral: '',
    trabaja_sabado: false,
    observaciones: '',
    estado: true,
    fecha_creacion: '',
    fecha_actualizacion: '',
    nit: ''
  };

  // Contacto principal de la empresa
  contactoPrincipal: ContactoEmpresa = {
    contacto_id: 0,
    empresa_id: 0,
    nombre: '',
    cargo: '',
    area: '',
    telefono: '',
    celular: '',
    email: '',
    tipo: '',
    es_principal: false,
    estado: true,
    fecha_creacion: '',
    fecha_actualizacion: ''
  };

  // Datos de referencia para los dropdowns
  sectoresEconomicos: SectorEconomico[] = [];
  tamanosEmpresa: TamanoEmpresa[] = [];
  tiposContacto: TipoContacto[] = [];

  isLoading = true;
  isSaving = false;
  error: string | null = null;
  empresaId: number | null = null;
  successMessage: string | null = null;

  // Para almacenar los datos originales
  originalEmpresaData: Empresa | null = null;
  originalContactoData: ContactoEmpresa | null = null;

  // Estados del formulario
  showContactForm = false;
  isEditingContact = false;

  companyForm: CompanyForm = {
    nombre: 'Empresa de Ejemplo',
    razonSocial: 'Empresa de Ejemplo S.A.S',
    nit: '900.123.456-7',
    ccb: '',
    ciio: '',
    actividadEconomica: 'Desarrollo de Software',
    pais: 'Colombia',
    sector: 'Tecnología',
    direccion: 'Calle 123 # 45-67',
    localidad: 'Chapinero',
    tamanoEmpresa: 'Mediana',
    formatoRegistro: '',
    estado: 'Activo',
    ccRepresentanteLegal: '12345678',
    ejecutivoCuenta: 'Juan Pérez',
    paginaWeb: 'www.empresaejemplo.com',
    rut: '900123456-7'
  };

  // Archivo seleccionado para cada campo
  selectedFiles = {
    formatoRegistro: null as File | null,
    ccb: null as File | null,
    ciio: null as File | null
  };

  // Nombres de archivos para mostrar
  fileNames = {
    formatoRegistro: 'formato_actual.pdf',
    ccb: 'ccb_actual.pdf',
    ciio: 'ciio_actual.pdf'
  };

  agreement: Agreement = {
    tipoConvenio: 'Prácticas Profesionales',
    fechaConvenio: '2024-02-20',
    duracionConvenio: '180'
  };

  availablePrograms: Program[] = [
    { nombre: 'Ingeniería de Software', cupos: 3 },
    { nombre: 'Ingeniería Industrial', cupos: 2 },
    { nombre: 'Marketing y Logística', cupos: 1 },
    { nombre: 'Administración de Empresas', cupos: 2 },
    { nombre: 'Diseño de Producto', cupos: 0 },
    { nombre: 'Negocios Internacionales', cupos: 1 },
    { nombre: 'Comercio y Negocios Exterior', cupos: 0 },
    { nombre: 'Gestión de Puertos y Personas Internacionales', cupos: 1 }
  ];

  observaciones: string = 'Empresa con convenio activo desde 2023. Buena experiencia con practicantes anteriores.';
  profileImage: string | null = 'assets/empresa-ejemplo.png';

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private empresasService: EmpresasService,
    private sectoresEconomicosService: SectoresEconomicosService,
    private tamanosEmpresaService: TamanosEmpresaService,
    private contactosEmpresaService: ContactosEmpresaService,
    private tiposContactoService: TiposContactoService
  ) {}

  ngOnInit(): void {
    // Obtener ID de la empresa de los parámetros de la ruta
    this.route.queryParams.subscribe(params => {
      if (params['id']) {
        this.empresaId = +params['id'];
        this.loadData();
      } else {
        this.error = 'No se especificó el ID de la empresa a editar.';
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
      this.empresasService.getById(this.empresaId!).toPromise(),
      this.sectoresEconomicosService.getAll().toPromise(),
      this.tamanosEmpresaService.getAll().toPromise(),
      this.tiposContactoService.getAll().toPromise(),
      this.contactosEmpresaService.getAll().toPromise()
    ]).then(([empresa, sectores, tamanos, tiposContacto, contactos]) => {
      this.empresa = { ...empresa };
      this.originalEmpresaData = { ...empresa };
      this.sectoresEconomicos = sectores || [];
      this.tamanosEmpresa = tamanos || [];
      this.tiposContacto = tiposContacto || [];

      // Buscar contacto principal de la empresa
      const contactosEmpresa = contactos?.filter(c => c.empresa_id === this.empresa.empresa_id) || [];
      if (contactosEmpresa.length > 0) {
        this.contactoPrincipal = { ...contactosEmpresa[0] };
        this.originalContactoData = { ...contactosEmpresa[0] };
        this.isEditingContact = true;
      } else {
        // Si no hay contacto, preparar uno nuevo
        this.contactoPrincipal.empresa_id = this.empresa.empresa_id;
        this.isEditingContact = false;
      }

      this.isLoading = false;
    }).catch(error => {
      console.error('Error cargando datos:', error);
      this.error = 'Error al cargar los datos de la empresa.';
      this.isLoading = false;
    });
  }

  // Métodos auxiliares para obtener nombres
  getSectorNombre(sectorId: number | null | undefined): string {
    if (!sectorId) return 'Sin sector';
    const sector = this.sectoresEconomicos.find(s => s.sector_id === sectorId);
    return sector ? sector.nombre : 'Sin sector';
  }

  getTamanoDescripcion(tamanoId: number | null | undefined): string {
    if (!tamanoId) return 'Sin tamaño';
    const tamano = this.tamanosEmpresa.find(t => t.tamano_id === tamanoId);
    return tamano ? tamano.nombre : 'Sin tamaño';
  }

  // Validación del formulario
  isValidEmpresaForm(): boolean {
    return !!(
      (this.empresa.nombre_comercial || '').trim() &&
      (this.empresa.nit || '').trim()
    );
  }

  isValidContactoForm(): boolean {
    return !!(
      this.contactoPrincipal.nombre.trim() &&
      this.contactoPrincipal.email.trim()
    );
  }

  hasEmpresaChanges(): boolean {
    if (!this.originalEmpresaData) return false;
    return JSON.stringify(this.empresa) !== JSON.stringify(this.originalEmpresaData);
  }

  hasContactoChanges(): boolean {
    if (!this.originalContactoData) return true; // Nuevo contacto
    return JSON.stringify(this.contactoPrincipal) !== JSON.stringify(this.originalContactoData);
  }

  hasAnyChanges(): boolean {
    return this.hasEmpresaChanges() || this.hasContactoChanges();
  }

  // Guardar cambios (PUT)
  async guardarCambios(): Promise<void> {
    if (!this.isValidEmpresaForm()) {
      this.error = 'Por favor complete todos los campos obligatorios de la empresa.';
      return;
    }

    this.isSaving = true;
    this.error = null;
    this.successMessage = null;

    try {
      // Actualizar empresa
      if (this.hasEmpresaChanges()) {
        const empresaData = { ...this.empresa };
        
        // Convertir valores cero a null para campos opcionales
        if (!empresaData.sector) empresaData.sector = 0;
        if (!empresaData.tamano) empresaData.tamano = 0;

        const empresaResponse = await this.empresasService.update(this.empresa.empresa_id, empresaData).toPromise();
        this.originalEmpresaData = { ...this.empresa };
      }

      // Actualizar/crear contacto si hay datos válidos
      if (this.showContactForm && this.isValidContactoForm()) {
        const contactoData = { ...this.contactoPrincipal };
        
        // Asegurar que el contacto esté asociado a la empresa
        contactoData.empresa_id = this.empresa.empresa_id;
        
        // Limpiar campos vacíos opcionales
        if (!contactoData.tipo?.trim()) contactoData.tipo = null;
        if (!contactoData.cargo?.trim()) contactoData.cargo = null;
        if (!contactoData.area?.trim()) contactoData.area = null;

        if (this.isEditingContact && this.contactoPrincipal.contacto_id) {
          // Actualizar contacto existente
          const contactoResponse = await this.contactosEmpresaService.update(this.contactoPrincipal.contacto_id, contactoData).toPromise();
        } else {
          // Crear nuevo contacto
          const contactoResponse = await this.contactosEmpresaService.create(contactoData).toPromise();
          this.contactoPrincipal.contacto_id = contactoResponse.contacto_id;
          this.isEditingContact = true;
        }
        
        this.originalContactoData = { ...this.contactoPrincipal };
      }

      this.successMessage = 'Información de la empresa actualizada exitosamente.';
      this.isSaving = false;
      
      // Redirigir a información empresa después de 2 segundos
      setTimeout(() => {
        this.router.navigate(['/informacion-empresa'], { 
          queryParams: { id: this.empresaId }
        });
      }, 2000);

    } catch (error) {
      console.error('Error actualizando empresa:', error);
      this.error = 'Error al actualizar la información. Verifique los datos e intente nuevamente.';
      this.isSaving = false;
    }
  }

  cancelar(): void {
    if (this.hasAnyChanges()) {
      const confirmCancel = confirm('¿Está seguro de cancelar? Se perderán los cambios no guardados.');
      if (!confirmCancel) return;
    }
    
    this.router.navigate(['/informacion-empresa'], { 
      queryParams: { id: this.empresaId } 
    });
  }

  resetForm(): void {
    if (this.originalEmpresaData) {
      this.empresa = { ...this.originalEmpresaData };
    }
    
    if (this.originalContactoData) {
      this.contactoPrincipal = { ...this.originalContactoData };
    } else {
      // Reset contacto nuevo
      this.contactoPrincipal = {
        contacto_id: 0,
        empresa_id: this.empresa.empresa_id,
        nombre: '',
        cargo: '',
        area: '',
        telefono: '',
        celular: '',
        email: '',
        tipo: '',
        es_principal: false,
        estado: true,
        fecha_creacion: '',
        fecha_actualizacion: ''
      };
    }
    
    this.error = null;
    this.successMessage = null;
  }

  toggleContactForm(): void {
    this.showContactForm = !this.showContactForm;
  }

  navigateToInformacionEmpresa(): void {
    this.router.navigate(['/informacion-empresa'], { 
      queryParams: { id: this.empresaId } 
    });
  }

  navigateToPublicarOferta(): void {
    this.router.navigate(['/publicar-oferta'], { 
      queryParams: { empresa_id: this.empresaId } 
    });
  }

  refreshData(): void {
    this.loadData();
  }

  onFileSelected(event: any) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e: any) => {
        this.profileImage = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  }

  onDocumentSelected(event: any, fieldName: 'formatoRegistro' | 'ccb' | 'ciio') {
    const file = event.target.files[0];
    if (file) {
      this.selectedFiles[fieldName] = file;
      this.fileNames[fieldName] = file.name;
      this.companyForm[fieldName] = file.name;
    }
  }

  getTotalCupos(): number {
    return this.availablePrograms.reduce((total, program) => total + program.cupos, 0);
  }
}
