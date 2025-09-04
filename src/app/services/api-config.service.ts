import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class ApiConfigService {
  private readonly baseUrl = 'http://127.0.0.1:8001/api';
  
  constructor() { }

  getBaseUrl(): string {
    return this.baseUrl;
  }

  getEndpoint(endpoint: string): string {
    return `${this.baseUrl}/${endpoint}/`;
  }

  // Métodos para endpoints específicos
  getEstudiantesUrl(): string {
    return this.getEndpoint('estudiantes');
  }

  getEmpresasUrl(): string {
    return this.getEndpoint('empresas');
  }

  getProgramasUrl(): string {
    return this.getEndpoint('programas');
  }

  getFacultadesUrl(): string {
    return this.getEndpoint('facultades');
  }

  getPromocionesUrl(): string {
    return this.getEndpoint('promociones');
  }

  getTiposDocumentoUrl(): string {
    return this.getEndpoint('tipos-documento');
  }

  getNivelesInglesUrl(): string {
    return this.getEndpoint('niveles-ingles');
  }

  getEstadosCarteraUrl(): string {
    return this.getEndpoint('estados-cartera');
  }

  getSectoresEconomicosUrl(): string {
    return this.getEndpoint('sectores-economicos');
  }

  getTamanosEmpresaUrl(): string {
    return this.getEndpoint('tamanos-empresa');
  }

  getContactosEmpresaUrl(): string {
    return this.getEndpoint('contactos-empresa');
  }

  getOfertasEmpresasUrl(): string {
    return this.getEndpoint('ofertas-empresas');
  }

  getProcesoCoformacionUrl(): string {
    return this.getEndpoint('proceso-coformacion');
  }

  getEstadoProcesoUrl(): string {
    return this.getEndpoint('estado-proceso');
  }

  getRolesUrl(): string {
    return this.getEndpoint('roles');
  }

  getPermisosUrl(): string {
    return this.getEndpoint('permisos');
  }

  getTiposActividadUrl(): string {
    return this.getEndpoint('tipos-actividad');
  }

  getCalendarioActividadesUrl(): string {
    return this.getEndpoint('calendario-actividades');
  }

  getPlantillasCorreoUrl(): string {
    return this.getEndpoint('plantillas-correo');
  }

  getHistorialComunicacionesUrl(): string {
    return this.getEndpoint('historial-comunicaciones');
  }

  getDocumentosProcesoUrl(): string {
    return this.getEndpoint('documentos-proceso');
  }

  getMateriasNucleoUrl(): string {
    return this.getEndpoint('materias-nucleo');
  }

  getObjetivosAprendizajeUrl(): string {
    return this.getEndpoint('objetivos-aprendizaje');
  }

  getRolesPermisosUrl(): string {
    return this.getEndpoint('roles-permisos');
  }

  getTiposContactoUrl(): string {
    return this.getEndpoint('tipos-contacto');
  }
} 
