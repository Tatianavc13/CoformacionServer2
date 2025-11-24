import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router, ActivatedRoute } from '@angular/router';
import { AuthService } from '../../services/auth.service';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, FormsModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent {
  loginForm: FormGroup;
  error: string = '';
  isLoading: boolean = false;
  returnUrl: string = '';
  showPassword: boolean = false;

  constructor(
    private fb: FormBuilder,
    private authService: AuthService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.loginForm = this.fb.group({
      nombre: ['', Validators.required],
      identificacion: ['', Validators.required]
    });

    // Obtener la URL de retorno de los query params
    this.returnUrl = this.route.snapshot.queryParams['returnUrl'] || '';
  }

  onSubmit() {
    if (this.loginForm.valid) {
      this.isLoading = true;
      this.error = '';

      const { nombre, identificacion } = this.loginForm.value;

      this.authService.login(nombre, identificacion).subscribe({
        next: (response) => {
          console.log('Login response:', response);

          if (response.success || response.tipo_usuario) {

            if (this.returnUrl) {
              this.router.navigateByUrl(this.returnUrl);
            } else {
              this.authService.redirectToUserHome();
            }
          } else {
            this.error = response.message || response.error || 'Error en el inicio de sesión';
          }
        },
        error: (error) => {
          console.error('Login error completo:', error);
          console.error('Error status:', error?.status);
          console.error('Error message:', error?.message);
          console.error('Error error:', error?.error);
          console.error('Error name:', error?.name);

          // Manejar diferentes tipos de errores
          if (!error || error.status === 0 || error.status === undefined) {
            // Error de conexión (CORS, servidor no disponible, etc.)
            this.error = 'No se pudo conectar al servidor. Verifica que:\n' +
                        '1. El backend esté corriendo en http://127.0.0.1:8000\n' +
                        '2. No haya problemas de CORS\n' +
                        '3. El firewall no esté bloqueando la conexión';
          } else if (error.error) {
            // Error con respuesta del servidor
            if (error.error.error) {
              this.error = error.error.error;
            } else if (error.error.message) {
              this.error = error.error.message;
            } else if (typeof error.error === 'string') {
              this.error = error.error;
            } else if (error.error.isTrusted) {
              // Error de CORS o conexión
              this.error = 'Error de conexión. Verifica que el backend esté corriendo y que CORS esté configurado correctamente.';
            } else {
              this.error = 'Error del servidor: ' + JSON.stringify(error.error);
            }
          } else if (error.status === 401) {
            this.error = 'Credenciales incorrectas. Verifica tu nombre y número de documento/NIT';
          } else if (error.status === 403) {
            this.error = 'Acceso denegado. No tienes permisos para acceder.';
          } else if (error.status === 404) {
            this.error = 'Endpoint no encontrado. Verifica que la URL del API sea correcta.';
          } else if (error.status === 500) {
            this.error = 'Error interno del servidor. Revisa la consola del backend para más detalles.';
          } else if (error.status) {
            this.error = `Error ${error.status}: ${error.message || 'Error del servidor'}`;
          } else {
            this.error = 'Error desconocido. Revisa la consola del navegador para más detalles.';
          }
        },
        complete: () => {
          this.isLoading = false;
        }
      });
    } else {
      this.markFormGroupTouched();
    }
  }

  private markFormGroupTouched() {
    Object.keys(this.loginForm.controls).forEach(key => {
      const control = this.loginForm.get(key);
      control?.markAsTouched();
    });
  }

  onForgotPassword() {
    // TODO: Implementar funcionalidad de recuperación de contraseña
  }

  togglePasswordVisibility() {
    this.showPassword = !this.showPassword;
  }

  goLogoHome() {
    this.router.navigate(['/home']);
  }

  // Getters para facilitar el acceso a los controles del formulario
  get nombre() { return this.loginForm.get('nombre'); }
  get identificacion() { return this.loginForm.get('identificacion'); }
}
