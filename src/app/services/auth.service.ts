import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { Router } from '@angular/router';
import { map, tap } from 'rxjs/operators';
import { ApiConfigService } from './api-config.service';

export interface UserSession {
  user: any;
  tipo_usuario: 'empresa' | 'estudiante' | 'coformacion';
  token?: string;
  isAuthenticated: boolean;
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private apiUrl: string;
  private currentUserSubject = new BehaviorSubject<UserSession | null>(null);
  public currentUser$ = this.currentUserSubject.asObservable();

  constructor(
    private http: HttpClient,
    private router: Router,
    private apiConfig: ApiConfigService
  ) {
    this.apiUrl = `${this.apiConfig.getBaseUrl()}/auth`;
    
    // Recuperar sesión del localStorage al inicializar
    this.loadStoredSession();
  }

  private loadStoredSession() {
    const storedSession = localStorage.getItem('userSession');
    if (storedSession) {
      try {
        const session: UserSession = JSON.parse(storedSession);
        this.currentUserSubject.next(session);
      } catch (error) {
        console.error('Error loading stored session:', error);
        this.clearSession();
      }
    }
  }

  login(nombre: string, identificacion: string): Observable<any> {
    const loginData = {
      nombre_completo: nombre,
      numero_documento: identificacion
    };

    return this.http.post<any>(`${this.apiConfig.getBaseUrl()}/auth/login/`, loginData)
      .pipe(
        tap((response: any) => {
          console.log('AuthService - Login response:', response);
          
          const success = response?.success;
          const userData = response?.data;
          const userType = response?.tipo_usuario;
          const token = response?.token;

          if (success && userType) {
            // Normalizar el tipo de usuario a minúsculas para consistencia
            const normalizedUserType = userType.toLowerCase().trim();
            console.log('AuthService - Normalized user type:', normalizedUserType);
            
            const userSession: UserSession = {
              user: userData,
              tipo_usuario: normalizedUserType as 'empresa' | 'estudiante' | 'coformacion',
              token: token,
              isAuthenticated: true
            };
            
            console.log('AuthService - Saving session:', userSession);
            
            // Guardar sesión en localStorage y BehaviorSubject
            localStorage.setItem('userSession', JSON.stringify(userSession));
            this.currentUserSubject.next(userSession);
            
            // Si es un estudiante, guardar también el ID en sessionStorage para compatibilidad
            if (normalizedUserType === 'estudiante' && userData?.estudiante_id) {
              sessionStorage.setItem('estudiante_id', userData.estudiante_id.toString());
              console.log('AuthService - Saved estudiante_id to sessionStorage:', userData.estudiante_id);
            }
            
            // Modificar la respuesta para que el componente la entienda
            response.success = true;
          }
        })
      );
  }

  logout(): void {
    this.clearSession();
    this.router.navigate(['/home']);
  }

  private clearSession(): void {
    localStorage.removeItem('userSession');
    this.currentUserSubject.next(null);
  }

  // Getters para información de la sesión actual
  get currentUserValue(): UserSession | null {
    return this.currentUserSubject.value;
  }

  isAuthenticated(): boolean {
    const session = this.currentUserValue;
    return session?.isAuthenticated || false;
  }

  getUserType(): 'empresa' | 'estudiante' | 'coformacion' | null {
    const userType = this.currentUserValue?.tipo_usuario || null;
    console.log('AuthService - getUserType:', { 
      currentUserValue: this.currentUserValue, 
      tipo_usuario: userType 
    });
    return userType;
  }

  getCurrentUser(): any {
    return this.currentUserValue?.user || null;
  }

  getToken(): string | null {
    return this.currentUserValue?.token || null;
  }

  // Métodos para verificar permisos específicos
  isEmpresa(): boolean {
    const userType = this.getUserType();
    console.log('AuthService - isEmpresa check:', { userType, result: userType === 'empresa' });
    return userType === 'empresa';
  }

  isEstudiante(): boolean {
    const userType = this.getUserType();
    console.log('AuthService - isEstudiante check:', { userType, result: userType === 'estudiante' });
    return userType === 'estudiante';
  }

  isCoformacion(): boolean {
    const userType = this.getUserType();
    console.log('AuthService - isCoformacion check:', { userType, result: userType === 'coformacion' });
    return userType === 'coformacion';
  }

  // Verificar si el usuario puede acceder a una ruta específica
  canAccessRoute(route: string): boolean {
    if (!this.isAuthenticated()) {
      // Sin autenticar solo puede acceder a home y login
      return route === '/home' || route === '/login' || route === '/';
    }

    const userType = this.getUserType();

    switch (userType) {
      case 'empresa':
        return this.canEmpresaAccessRoute(route);
      case 'estudiante':
        return this.canEstudianteAccessRoute(route);
      case 'coformacion':
        return true; // Coformacion puede acceder a todo
      default:
        return false;
    }
  }

  private canEmpresaAccessRoute(route: string): boolean {
    const allowedRoutes = [
      '/home-empresa',
      '/editar-empresa',
      '/informacion-empresa',
      '/agregar-empresa',
      '/consult-empresa',
      '/resumen-empresa',
      '/publicar-oferta'
    ];
    return allowedRoutes.some(allowed => route.startsWith(allowed));
  }

  private canEstudianteAccessRoute(route: string): boolean {
    const allowedRoutes = [
      '/perfil-estudiante',
      '/historial-coformacion',
      '/editar-estudiante',
      '/proceso-coformacion'
    ];
    return allowedRoutes.some(allowed => route.startsWith(allowed));
  }

  // Redireccionar al usuario a su página de inicio según su tipo
  redirectToUserHome(): void {
    const userType = this.getUserType();
    const currentUser = this.getCurrentUser();
    
    console.log('AuthService - Redirecting user:', { userType, currentUser });
    
    switch (userType) {
      case 'empresa':
        console.log('AuthService - Redirecting to /home-empresa');
        this.router.navigate(['/home-empresa']);
        break;
      case 'estudiante':
        console.log('AuthService - Redirecting to /perfil-estudiante');
        this.router.navigate(['/perfil-estudiante']);
        break;
      case 'coformacion':
        console.log('AuthService - Redirecting to /coformacion');
        this.router.navigate(['/coformacion']);
        break;
      default:
        console.log('AuthService - Unknown user type, redirecting to /home');
        this.router.navigate(['/home']);
        break;
    }
  }
} 
