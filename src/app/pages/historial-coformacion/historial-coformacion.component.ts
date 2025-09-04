import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';

interface CompanyHistory {
  nombreEmpresa: string;
  logo: string;
  razonSocial: string;
  nit: string;
  rut: string;
  digitoVerificacion: string;
  informacionEmpresa: string;
  tipoContrato: string;
  sostenimiento: string;
  periodicidadPago: string;
  formaPago: string;
  diasTrabajo: string;
  horario: string;
  fechaInicio: string;
  fechaFin: string;
  periodo: string;
  razonDesvinculacion: string;
  observacionesEmpresa: string;
  observacionesEstudiante: string;
}

@Component({
  selector: 'app-historial-coformacion',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './historial-coformacion.component.html',
  styleUrl: './historial-coformacion.component.css'
})
export class HistorialCoformacionComponent implements OnInit {
  companyHistory: CompanyHistory = {
    nombreEmpresa: 'COMPANY',
    logo: 'assets/company-logo.png',
    razonSocial: '',
    nit: '',
    rut: '',
    digitoVerificacion: '',
    informacionEmpresa: '',
    tipoContrato: '',
    sostenimiento: '',
    periodicidadPago: '',
    formaPago: '',
    diasTrabajo: '',
    horario: '',
    fechaInicio: '',
    fechaFin: '',
    periodo: '',
    razonDesvinculacion: '',
    observacionesEmpresa: '',
    observacionesEstudiante: ''
  };

  constructor(private router: Router) {}

  ngOnInit(): void {
    this.loadCompanyHistory();
  }

  private loadCompanyHistory(): void {
    // TODO: Implement API call to get company history data
  }

  verMasInformacion(): void {
    this.router.navigate(['/informacion-empresa']);
  }

  navigateToPerfilEstudiante() {
    this.router.navigate(['/perfil-estudiante']);
  }
}
