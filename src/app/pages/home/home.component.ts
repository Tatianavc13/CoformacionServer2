import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  constructor(private router: Router) {}

  goToLogin() {
    this.router.navigate(['/login']);
  }

  onTeacherClick() {
    // Descargar el PDF
    this.downloadPDF();
    
    // Redirigir a Make.com después de un pequeño delay para permitir que inicie la descarga
    setTimeout(() => {
      window.open('https://www.make.com/en/register?', '_blank');
    }, 500);
  }

  private downloadPDF() {
    // Ruta del PDF en assets
    const pdfUrl = 'assets/Guía de cómo usar el escenario en make.pdf';
    
    // Crear un elemento <a> temporal para la descarga
    const link = document.createElement('a');
    link.href = pdfUrl;
    link.download = 'Guía de cómo usar el escenario en make.pdf';
    link.target = '_blank';
    
    // Agregar al DOM, hacer clic y remover
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }
} 