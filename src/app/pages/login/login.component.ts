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
          
          if (response.success || response.tipo_usuario) {
            
            if (this.returnUrl) {
              this.router.navigateByUrl(this.returnUrl);
            } else {
              this.authService.redirectToUserHome();
            }
          } else {
            this.error = response.message || 'Error en el inicio de sesión';
          }
        },
        error: (error) => {
          this.error = 'Credenciales inválidas o error del servidor';
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
