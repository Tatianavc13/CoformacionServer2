import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class PublicGuard implements CanActivate {

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): boolean {
    
    // Si no está autenticado, puede acceder
    if (!this.authService.isAuthenticated()) {
      return true;
    }

    // Si ya está autenticado, redirigir a su página de inicio
    this.authService.redirectToUserHome();
    return false;
  }
} 