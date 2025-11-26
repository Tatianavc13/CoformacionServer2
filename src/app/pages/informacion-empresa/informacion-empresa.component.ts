import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute } from '@angular/router';
import { EmpresasService } from '../../services/empresas.service';
import { SectoresEconomicosService } from '../../services/sectores_economicos.service';
import { TamanosEmpresaService } from '../../services/tamanos_empresa.service';
import { ContactosEmpresaService } from '../../services/contactos_empresa.service';
import { OfertasempresasService } from '../../services/ofertasempresas.service';
import { TiposContactoService } from '../../services/tipos_contacto.service';
import { AuthService } from '../../services/auth.service';
import { Empresa, SectorEconomico, TamanoEmpresa, ContactoEmpresa, OfertaEmpresa, TipoContacto } from '../../models/interfaces';

@Component({
  selector: 'app-informacion-empresa',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './informacion-empresa.component.html',
  styleUrl: './informacion-empresa.component.css'
})
export class InformacionEmpresaComponent implements OnInit {
  empresa: Empresa | null = null;
  sectorEconomico: SectorEconomico | null = null;
  tamanoEmpresa: TamanoEmpresa | null = null;
  contactosEmpresa: ContactoEmpresa[] = [];
  ofertasEmpresa: OfertaEmpresa[] = [];
  tiposContacto: TipoContacto[] = [];
  
  isLoading = true;
  error: string | null = null;
  empresaId: number | null = null;
  showBlockModal = false;
  isBlocking = false;
  logoUrl: string = 'assets/logoEmpresa.png'; // Logo predeterminado
  logoBase64: string | null = null; // Logo en base64 desde la base de datos

  constructor(
    private router: Router,
    private route: ActivatedRoute,
    private empresasService: EmpresasService,
    private sectoresEconomicosService: SectoresEconomicosService,
    private tamanosEmpresaService: TamanosEmpresaService,
    private contactosEmpresaService: ContactosEmpresaService,
    private ofertasEmpresasService: OfertasempresasService,
    private tiposContactoService: TiposContactoService,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    // Obtener ID de la empresa de los parámetros de la ruta
    this.route.queryParams.subscribe(params => {
      if (params['id']) {
        this.empresaId = +params['id'];
        this.loadCompanyInfo();
      } else {
        // Si no hay ID, obtener de la empresa autenticada
        this.loadAuthenticatedCompany();
      }
    });
  }

  private loadAuthenticatedCompany(): void {
    // Obtener la empresa del usuario autenticado
    const currentUser = this.authService.getCurrentUser();
    const userType = this.authService.getUserType();
    
    if (userType === 'empresa' && currentUser && currentUser.empresa_id) {
      this.empresaId = currentUser.empresa_id;
      this.loadCompanyInfo();
    } else if (userType === 'coformacion') {
      // Para usuarios de coformación, cargar la primera empresa
      this.loadFirstCompany();
    } else {
      this.error = 'No se pudo identificar la empresa asociada al usuario.';
      this.isLoading = false;
    }
  }

  private loadFirstCompany(): void {
    this.empresasService.getAll().subscribe({
      next: (empresas) => {
        if (empresas && empresas.length > 0) {
          this.empresaId = empresas[0].empresa_id;
          this.loadCompanyInfo();
        } else {
          this.error = 'No hay empresas registradas en el sistema.';
          this.isLoading = false;
        }
      },
      error: (error) => {
        console.error('Error cargando empresas:', error);
        this.error = 'Error al cargar las empresas.';
        this.isLoading = false;
      }
    });
  }

  private loadCompanyInfo(): void {
    if (!this.empresaId) return;

    this.isLoading = true;
    this.error = null;

    // Cargar datos de la empresa
    this.empresasService.getById(this.empresaId).subscribe({
      next: (empresa) => {
        this.empresa = empresa;
        
        // Establecer logo de la empresa: usar imagen_url_base64 si existe, sino el predeterminado
        if (empresa.imagen_url_base64 && empresa.imagen_url_base64.trim() !== '') {
          this.logoBase64 = empresa.imagen_url_base64;
          console.log('Logo cargado desde imagen_url_base64 en informacion-empresa');
        } else {
          this.logoBase64 = null;
          this.logoUrl = 'assets/logoEmpresa.png';
          console.log('Usando logo predeterminado en informacion-empresa');
        }
        
        this.loadRelatedData();
      },
      error: (error) => {
        console.error('Error cargando empresa:', error);
        this.error = 'Error al cargar la información de la empresa.';
        this.isLoading = false;
      }
    });
  }

  private loadRelatedData(): void {
    if (!this.empresa) return;

    // Cargar datos relacionados en paralelo
    const requests = [];

    // Cargar sector económico
    if (this.empresa.sector) {
      requests.push(
        this.sectoresEconomicosService.getById(this.empresa.sector).subscribe({
          next: (sector) => this.sectorEconomico = sector,
          error: (error) => console.error('Error cargando sector:', error)
        })
      );
    }

    // Cargar tamaño de empresa
    if (this.empresa.tamano) {
      requests.push(
        this.tamanosEmpresaService.getById(this.empresa.tamano).subscribe({
          next: (tamano) => this.tamanoEmpresa = tamano,
          error: (error) => console.error('Error cargando tamaño:', error)
        })
      );
    }

    // Cargar contactos de la empresa
    this.contactosEmpresaService.getAll().subscribe({
      next: (contactos) => {
        this.contactosEmpresa = contactos.filter(c => c.empresa_id === this.empresa!.empresa_id);
        this.loadContactTypes();
      },
      error: (error) => console.error('Error cargando contactos:', error)
    });

    // Cargar ofertas de la empresa
    this.ofertasEmpresasService.getAll().subscribe({
      next: (ofertas) => {
        this.ofertasEmpresa = ofertas.filter(o => o.empresa === this.empresa!.empresa_id);
        this.isLoading = false;
      },
      error: (error) => {
        console.error('Error cargando ofertas:', error);
        this.isLoading = false;
      }
    });
  }

  private loadContactTypes(): void {
    this.tiposContactoService.getAll().subscribe({
      next: (tipos) => this.tiposContacto = tipos,
      error: (error) => console.error('Error cargando tipos de contacto:', error)
    });
  }

  // Métodos auxiliares para mostrar información
  getSectorNombre(): string {
    return this.sectorEconomico ? this.sectorEconomico.nombre : 'No especificado';
  }

  getTamanoDescripcion(): string {
    return this.tamanoEmpresa ? this.tamanoEmpresa.nombre : 'No especificado';
  }

  getTipoContactoNombre(tipo: string | null | undefined): string {
    return tipo && tipo.trim() ? tipo : 'N/A';
  }

  getContactoPrincipal(): ContactoEmpresa | null {
    return this.contactosEmpresa.length > 0 ? this.contactosEmpresa[0] : null;
  }

  getOfertasActivas(): OfertaEmpresa[] {
    const hoy = new Date();
    return this.ofertasEmpresa.filter(oferta => {
      const fechaFin = new Date(oferta.fecha_fin);
      return fechaFin >= hoy;
    });
  }

  getOfertasVencidas(): OfertaEmpresa[] {
    const hoy = new Date();
    return this.ofertasEmpresa.filter(oferta => {
      const fechaFin = new Date(oferta.fecha_fin);
      return fechaFin < hoy;
    });
  }

  // Verificar si el usuario actual es de coformación
  isCoformacionUser(): boolean {
    return this.authService.isCoformacion();
  }

  // Acciones
  toggleBlockModal() {
    this.showBlockModal = !this.showBlockModal;
  }

  confirmBlock() {
    this.isBlocking = true;
    // Aquí podrías implementar la lógica para bloquear la empresa
    // Por ejemplo, actualizar un campo 'activa' o 'bloqueada' en el backend
    
    // Simular operación
    setTimeout(() => {
      this.isBlocking = false;
      this.showBlockModal = false;
      // Redirigir a consult-empresa después de bloquear
      this.router.navigate(['/consult-empresa']);
    }, 1000);
  }

  editarEmpresa() {
    this.router.navigate(['/editar-empresa'], { 
      queryParams: { id: this.empresaId } 
    });
  }

  publicarOferta() {
    this.router.navigate(['/publicar-oferta'], { 
      queryParams: { empresa_id: this.empresaId } 
    });
  }

  verResumen() {
    this.router.navigate(['/resumen-empresa'], { 
      queryParams: { id: this.empresaId } 
    });
  }

  cancelar() {
    this.router.navigate(['/home-empresa']);
  }

  refreshData() {
    this.loadCompanyInfo();
  }
}
