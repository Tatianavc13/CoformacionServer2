import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router } from '@angular/router';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class CoformacionGuard implements CanActivate {

  constructor(
    private authService: AuthService,
    private router: Router
  ) {}

  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot
  ): boolean {
    
    console.log('CoformacionGuard - Checking access to:', state.url);
    console.log('CoformacionGuard - Is authenticated:', this.authService.isAuthenticated());
    console.log('CoformacionGuard - User type:', this.authService.getUserType());
    console.log('CoformacionGuard - Is Coformacion:', this.authService.isCoformacion());
    
    if (!this.authService.isAuthenticated()) {
      console.log('CoformacionGuard - Not authenticated, redirecting to login');
      this.router.navigate(['/login']);
      return false;
    }

    // Coformacion puede acceder a cualquier ruta
    if (this.authService.isCoformacion()) {
      console.log('CoformacionGuard - Access granted for Coformacion user');
      return true;
    }

    // Si no es coformacion, denegar acceso a rutas administrativas
    console.log('CoformacionGuard - Access denied, not a Coformacion user');
    this.authService.redirectToUserHome();
    return false;
  }
} 