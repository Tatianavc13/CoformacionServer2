import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class EmpresaGuard implements CanActivate {

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): boolean {
    
    console.log('EmpresaGuard - Checking access to:', state.url);
    console.log('EmpresaGuard - Is authenticated:', this.authService.isAuthenticated());
    console.log('EmpresaGuard - User type:', this.authService.getUserType());
    
    if (!this.authService.isAuthenticated()) {
      console.log('EmpresaGuard - Not authenticated, redirecting to login');
      this.router.navigate(['/login']);
      return false;
    }

    // Solo empresas pueden acceder a rutas de empresa
    if (this.authService.isEmpresa()) {
      console.log('EmpresaGuard - Access granted for empresa user');
      return true;
    }

    // Si no es empresa, redirigir a su página de inicio
    console.log('EmpresaGuard - Access denied, not an empresa user');
    this.authService.redirectToUserHome();
    return false;
  }
} 