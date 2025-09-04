import { Injectable } from '@angular/core';
import { HttpRequest, HttpHandler, HttpEvent, HttpInterceptor, HttpErrorResponse } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AuthService } from '../services/auth.service';
import { Router } from '@angular/router';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // Obtener el token de autenticación
    const token = this.authService.getToken();
    
    // Si hay token, agregarlo a los headers
    if (token) {
      request = request.clone({
        setHeaders: {
          Authorization: `Bearer ${token}`
        }
      });
    }

    // Continuar con la petición y manejar errores de autenticación
    return next.handle(request).pipe(
      catchError((error: HttpErrorResponse) => {
        if (error.status === 401) {
          // Token inválido o expirado - cerrar sesión y redirigir
          console.warn('Token inválido o expirado. Cerrando sesión...');
          this.authService.logout();
        } else if (error.status === 403) {
          // Sin permisos para acceder al recurso
          console.warn('Sin permisos para acceder al recurso');
          this.authService.redirectToUserHome();
        }
        
        return throwError(() => error);
      })
    );
  }
} 