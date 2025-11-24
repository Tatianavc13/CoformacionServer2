import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class EstudianteGuard implements CanActivate {

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): boolean {
    
    console.log('EstudianteGuard - Checking access to:', state.url);
    console.log('EstudianteGuard - Is authenticated:', this.authService.isAuthenticated());
    console.log('EstudianteGuard - User type:', this.authService.getUserType());
    
    if (!this.authService.isAuthenticated()) {
      console.log('EstudianteGuard - Not authenticated, redirecting to login');
      this.router.navigate(['/login']);
      return false;
    }

    // Solo estudiantes pueden acceder a rutas de estudiante
    if (this.authService.isEstudiante()) {
      console.log('EstudianteGuard - Access granted for estudiante user');
      return true;
    }

    // Si no es estudiante, redirigir a su página de inicio
    console.log('EstudianteGuard - Access denied, not an estudiante user');
    this.authService.redirectToUserHome();
    return false;
  }
} 