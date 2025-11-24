import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ApiConfigService } from './api-config.service';

@Injectable({ providedIn: 'root' })
export class RecomendacionesService {
  constructor(
    private http: HttpClient,
    private apiConfig: ApiConfigService
  ) {}

  obtenerRecomendaciones(estudianteId: number): Observable<any[]> {
    const baseUrl = this.apiConfig.getBaseUrl();
    return this.http.get<any[]>(`${baseUrl}/recomendaciones/${estudianteId}/`);
  }

  obtenerRecomendacionesCompletas(): Observable<any> {
    const baseUrl = this.apiConfig.getBaseUrl();
    return this.http.get<any>(`${baseUrl}/recomendaciones-completas/`);
  }
  
}
