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

    if (this.authService.isEmpresa() || this.authService.isCoformacion()) {
      console.log('EmpresaGuard - Access granted');
      return true;
    }

    // Si no es empresa ni coformacion, redirigir a su página de inicio
    console.log('EmpresaGuard - Access denied, redirecting to user home');
    this.authService.redirectToUserHome();
    return false;
  }
} 