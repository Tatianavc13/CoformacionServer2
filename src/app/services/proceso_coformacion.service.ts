
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProcesoCoformacionService {

  private apiUrl = 'http://127.0.0.1:8001/api/proceso-coformacion/';

  constructor(private http: HttpClient) { }

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  getById(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}${id}/`);
  }

  create(data: any): Observable<any> {
    return this.http.post<any>(this.apiUrl, data);
  }

  update(id: number, data: any): Observable<any> {
    return this.http.put<any>(`${this.apiUrl}${id}/`, data);
  }

  delete(id: number): Observable<any> {
    return this.http.delete<any>(`${this.apiUrl}${id}/`);
  }
}
