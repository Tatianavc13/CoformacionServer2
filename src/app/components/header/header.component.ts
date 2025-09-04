import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { AuthService, UserSession } from '../../services/auth.service';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './header.component.html',
  styleUrl: './header.component.css'
})
export class HeaderComponent implements OnInit, OnDestroy {
  
  currentUser: UserSession | null = null;
  private userSubscription!: Subscription;

  constructor(
    private router: Router,
    private authService: AuthService
  ) { }

  ngOnInit(): void {
    // Suscribirse a los cambios del usuario actual
    this.userSubscription = this.authService.currentUser$.subscribe(
      user => {
        this.currentUser = user;
      }
    );
  }

  ngOnDestroy(): void {
    if (this.userSubscription) {
      this.userSubscription.unsubscribe();
    }
  }

  cerrarSesion(): void {
    if (confirm('¿Está seguro que desea cerrar sesión?')) {
      this.authService.logout();
    }
  }

  isAuthenticated(): boolean {
    return this.authService.isAuthenticated();
  }

  getUserName(): string {
    if (this.currentUser?.user) {
      // Para empresas, mostrar nombre comercial o razón social
      if (this.currentUser.tipo_usuario === 'empresa') {
        return this.currentUser.user.nombre_comercial || this.currentUser.user.razon_social || 'Empresa';
      }
      // Para estudiantes, mostrar nombre completo
      else if (this.currentUser.tipo_usuario === 'estudiante') {
        return this.currentUser.user.nombre_completo || 'Estudiante';
      }
      // Para coformación
      else if (this.currentUser.tipo_usuario === 'coformacion') {
        return 'Administrador Coformación';
      }
    }
    return 'Usuario';
  }

  getUserType(): string {
    if (this.currentUser?.tipo_usuario) {
      switch (this.currentUser.tipo_usuario) {
        case 'empresa': return 'Empresa';
        case 'estudiante': return 'Estudiante';
        case 'coformacion': return 'Coformación';
        default: return 'Usuario';
      }
    }
    return '';
  }

  goToHome(): void {
    if (this.isAuthenticated()) {
      this.authService.redirectToUserHome();
    } else {
      this.router.navigate(['/home']);
    }
  }

  goToLogin(): void {
    this.router.navigate(['/login']);
  }
}
