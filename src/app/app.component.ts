import { Component } from '@angular/core';
import { Router, RouterOutlet } from '@angular/router';
import { FooterComponent } from './components/footer/footer.component';
import { CommonModule } from '@angular/common';
import { HeaderComponent } from './components/header/header.component';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule ,RouterOutlet, FooterComponent, HeaderComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  constructor(public router: Router) {}
}
