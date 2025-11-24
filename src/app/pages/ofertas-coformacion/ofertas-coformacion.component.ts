import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { RecomendacionesService } from 'src/app/services/recomendaciones.service';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-ofertas-coformacion',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './ofertas-coformacion.component.html',
  styleUrls: ['./ofertas-coformacion.component.css']
})
export class OfertasCoformacionComponent implements OnInit {
  recomendaciones: any[] = [];
  estudianteId: number = 1; // Valor por defecto
  loading: boolean = true;
  error: string | null = null;

  constructor(
    private recomendacionesService: RecomendacionesService,
    private router: Router,
    private authService: AuthService
  ) {}

  ngOnInit(): void {
    this.obtenerRecomendaciones();
  }

  obtenerRecomendaciones(): void {
    this.loading = true;
    this.error = null;
    
    // Si el usuario es de coformación, obtener todas las recomendaciones
    // Si es estudiante, obtener recomendaciones específicas para ese estudiante
    const userType = this.authService.getUserType();
    
    if (userType === 'coformacion') {
      // Para coformación, obtener todas las ofertas recomendadas
      console.log('🔍 Obteniendo todas las recomendaciones (vista coformación)');
      
      this.recomendacionesService.obtenerRecomendacionesCompletas()
        .subscribe({
          next: (response) => {
            // El endpoint devuelve un objeto con 'recomendaciones' dentro
            this.recomendaciones = response.recomendaciones || response || [];
            this.loading = false;
            console.log('✅ Recomendaciones completas recibidas:', this.recomendaciones);
            
            if (this.recomendaciones.length === 0) {
              console.log('📝 No hay ofertas disponibles');
            }
          },
          error: (error) => {
            console.error('❌ Error obteniendo recomendaciones completas:', error);
            this.error = 'Error al cargar las ofertas recomendadas. Por favor, intente nuevamente.';
            this.loading = false;
          }
        });
    } else {
      // Para estudiantes, obtener recomendaciones específicas
      this.determinarEstudianteId();
      
      console.log('🔍 Obteniendo recomendaciones para estudiante ID:', this.estudianteId);
      
      this.recomendacionesService.obtenerRecomendaciones(this.estudianteId)
        .subscribe({
          next: (data) => {
            this.recomendaciones = Array.isArray(data) ? data : [];
            this.loading = false;
            console.log('✅ Recomendaciones recibidas:', this.recomendaciones);
            
            if (this.recomendaciones.length === 0) {
              console.log('📝 No hay ofertas disponibles para este programa');
            }
          },
          error: (error) => {
            console.error('❌ Error obteniendo recomendaciones:', error);
            this.error = 'Error al cargar las ofertas recomendadas. Por favor, intente nuevamente.';
            this.loading = false;
          }
        });
    }
  }

  private determinarEstudianteId(): void {
    // Primero intentar obtener desde sessionStorage
    const idFromSession = sessionStorage.getItem('estudiante_id');
    if (idFromSession) {
      this.estudianteId = parseInt(idFromSession, 10);
      console.log('✅ Estudiante ID obtenido desde sessionStorage:', this.estudianteId);
      return;
    }

    // Si no hay en sessionStorage, intentar desde el usuario autenticado
    const currentUser = this.authService.getCurrentUser();
    if (currentUser?.user?.estudiante_id) {
      this.estudianteId = currentUser.user.estudiante_id;
      console.log('✅ Estudiante ID obtenido desde usuario autenticado:', this.estudianteId);
      // Guardar en sessionStorage para futuras consultas
      sessionStorage.setItem('estudiante_id', this.estudianteId.toString());
      return;
    }

    // Si llegamos aquí, usar el valor por defecto y mostrar advertencia
    console.warn('⚠️ No se encontró estudiante_id. Usando ID por defecto:', this.estudianteId);
    console.warn('📝 Para solucionar esto, asegúrese de hacer login correctamente como estudiante');
  }

  volverAlHome(): void {
    this.router.navigate(['/coformacion']);
  }

  refrescarRecomendaciones(): void {
    this.obtenerRecomendaciones();
  }
}
