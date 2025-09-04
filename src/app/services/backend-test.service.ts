import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, forkJoin } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { of } from 'rxjs';
import { ApiConfigService } from './api-config.service';

interface EndpointTest {
  name: string;
  url: string;
  status: 'success' | 'error' | 'pending';
  data?: any;
  error?: string;
  count?: number;
}

@Injectable({
  providedIn: 'root'
})
export class BackendTestService {

  constructor(
    private http: HttpClient,
    private apiConfig: ApiConfigService
  ) { }

  testAllEndpoints(): Observable<EndpointTest[]> {
    const endpoints = [
      { name: 'Estudiantes', url: this.apiConfig.getEstudiantesUrl() },
      { name: 'Empresas', url: this.apiConfig.getEmpresasUrl() },
      { name: 'Programas', url: this.apiConfig.getProgramasUrl() },
      { name: 'Facultades', url: this.apiConfig.getFacultadesUrl() },
      { name: 'Promociones', url: this.apiConfig.getPromocionesUrl() },
      { name: 'Tipos Documento', url: this.apiConfig.getTiposDocumentoUrl() },
      { name: 'Niveles Inglés', url: this.apiConfig.getNivelesInglesUrl() },
      { name: 'Estados Cartera', url: this.apiConfig.getEstadosCarteraUrl() },
      { name: 'Sectores Económicos', url: this.apiConfig.getSectoresEconomicosUrl() },
      { name: 'Tamaños Empresa', url: this.apiConfig.getTamanosEmpresaUrl() },
      { name: 'Contactos Empresa', url: this.apiConfig.getContactosEmpresaUrl() },
      { name: 'Ofertas Empresas', url: this.apiConfig.getOfertasEmpresasUrl() },
      { name: 'Proceso Coformación', url: this.apiConfig.getProcesoCoformacionUrl() },
      { name: 'Estado Proceso', url: this.apiConfig.getEstadoProcesoUrl() }
    ];

    const tests = endpoints.map(endpoint => this.testSingleEndpoint(endpoint));

    return forkJoin(tests);
  }

  private testSingleEndpoint(endpoint: { name: string, url: string }): Observable<EndpointTest> {
    return this.http.get<any[]>(endpoint.url).pipe(
      map(data => ({
        name: endpoint.name,
        url: endpoint.url,
        status: 'success' as const,
        data: data,
        count: Array.isArray(data) ? data.length : 0
      })),
      catchError(error => {
        return of({
          name: endpoint.name,
          url: endpoint.url,
          status: 'error' as const,
          error: error.message || 'Error desconocido'
        });
      })
    );
  }

  testBackendConnection(): Observable<{ connected: boolean, message: string }> {
    return this.http.get(`${this.apiConfig.getBaseUrl()}/estudiantes/`).pipe(
      map(() => ({
        connected: true,
        message: 'Conexión exitosa con el backend'
      })),
      catchError(error => {
        let message = 'Error conectando con el backend';
        if (error.status === 0) {
          message = 'Backend no disponible. Verifica que Django esté ejecutándose en http://127.0.0.1:8001';
        } else if (error.status === 404) {
          message = 'Endpoint no encontrado. Verifica las URLs de la API';
        } else if (error.status >= 500) {
          message = 'Error interno del servidor';
        }
        
        return of({
          connected: false,
          message: message
        });
      })
    );
  }

  getBackendInfo(): { baseUrl: string, version: string } {
    return {
      baseUrl: this.apiConfig.getBaseUrl(),
      version: '1.0.0'
    };
  }
} 
