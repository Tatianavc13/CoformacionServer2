import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Coformacion } from '../models/coformacion.model';
import { environment } from '@environments/environment';

@Injectable({
  providedIn: 'root'
})
export class CoformacionService {
  private apiUrl = `${environment.apiUrl}/coformacion`;

  constructor(private http: HttpClient) { }

  getCoformacion(): Observable<Coformacion[]> {
    return this.http.get<Coformacion[]>(this.apiUrl);
  }

  getCoformacionById(id: number): Observable<Coformacion> {
    return this.http.get<Coformacion>(`${this.apiUrl}/${id}`);
  }

  createCoformacion(coformacion: Coformacion): Observable<Coformacion> {
    return this.http.post<Coformacion>(this.apiUrl, coformacion);
  }

  updateCoformacion(id: number, coformacion: Coformacion): Observable<Coformacion> {
    return this.http.put<Coformacion>(`${this.apiUrl}/${id}`, coformacion);
  }

  deleteCoformacion(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`);
  }
} 
