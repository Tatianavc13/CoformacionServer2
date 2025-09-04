import { Component, OnInit, OnDestroy } from '@angular/core';
import { Router } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Subscription } from 'rxjs';
import { AuthService, UserSession } from '../../services/auth.service';

@Component({
  selector: 'app-coformacion',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './coformacion.component.html',
  styleUrl: './coformacion.component.css'
})
export class CoformacionComponent implements OnInit, OnDestroy {
  nombreAsistente: string = 'ADMINISTRADOR COFORMACIÓN';
  private userSubscription!: Subscription;

  constructor(
    private router: Router,
    private authService: AuthService
  ) { }

  ngOnInit(): void {
    // Suscribirse a los cambios del usuario actual
    this.userSubscription = this.authService.currentUser$.subscribe(
      (userSession: UserSession | null) => {
        if (userSession && userSession.user) {
          this.updateUserName(userSession.user);
        }
      }
    );

    // También obtener el usuario actual inmediatamente
    const currentUser = this.authService.getCurrentUser();
    if (currentUser) {
      this.updateUserName(currentUser);
    }
  }

  ngOnDestroy(): void {
    if (this.userSubscription) {
      this.userSubscription.unsubscribe();
    }
  }

  private updateUserName(userData: any): void {
    // Para usuarios de coformación, intentar obtener el nombre del usuario
    let nombreUsuario = '';
    
    // Posibles campos donde puede estar el nombre
    if (userData.nombre_completo) {
      nombreUsuario = userData.nombre_completo;
    } else if (userData.nombre) {
      nombreUsuario = userData.nombre;
    } else if (userData.first_name && userData.last_name) {
      nombreUsuario = `${userData.first_name} ${userData.last_name}`;
    } else if (userData.username) {
      nombreUsuario = userData.username;
    }

    if (nombreUsuario && nombreUsuario.trim()) {
      this.nombreAsistente = nombreUsuario.trim().toUpperCase();
    } else {
      this.nombreAsistente = 'ADMINISTRADOR COFORMACIÓN';
    }
  }

  consultarEmpresa(): void {
    this.router.navigate(['/consult-empresa']);
  }

  consultarEstudiante(): void {
    this.router.navigate(['/consult-estudent']);
  }

  consultarOfertas(): void {
    this.router.navigate(['/ofertas-coformacion']);
  }

  cerrarSesion(): void {
    this.authService.logout();
  }
}
