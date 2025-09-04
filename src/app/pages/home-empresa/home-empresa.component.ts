import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Subscription } from 'rxjs';
import { AuthService, UserSession } from '../../services/auth.service';

@Component({
  selector: 'app-home-empresa',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home-empresa.component.html',
  styleUrl: './home-empresa.component.css'
})
export class HomeEmpresaComponent implements OnInit, OnDestroy {
  companyName: string = 'EMPRESA';
  private userSubscription!: Subscription;
  
  constructor(
    private router: Router,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    // Suscribirse a los cambios del usuario actual
    this.userSubscription = this.authService.currentUser$.subscribe(
      (userSession: UserSession | null) => {
        if (userSession && userSession.user) {
          this.updateCompanyName(userSession.user);
        }
      }
    );

    // También obtener el usuario actual inmediatamente
    const currentUser = this.authService.getCurrentUser();
    if (currentUser) {
      this.updateCompanyName(currentUser);
    }
  }

  ngOnDestroy(): void {
    if (this.userSubscription) {
      this.userSubscription.unsubscribe();
    }
  }

  private updateCompanyName(empresaData: any): void {
    // Intentar obtener el nombre comercial primero, luego razón social
    const nombreComercial = empresaData.nombre_comercial;
    const razonSocial = empresaData.razon_social;
    
    if (nombreComercial && nombreComercial.trim()) {
      this.companyName = nombreComercial.trim().toUpperCase();
    } else if (razonSocial && razonSocial.trim()) {
      this.companyName = razonSocial.trim().toUpperCase();
    } else {
      this.companyName = 'EMPRESA';
    }
  }

  verEmpresa() {
    this.router.navigate(['/informacion-empresa']);
  }

  publicarOferta() {
    // Navegar a la vista de publicar oferta
    this.router.navigate(['publicar-oferta']);
  }
}
