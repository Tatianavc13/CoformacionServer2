import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { CoformacionService } from '../../../services/coformacion.service';
import { Coformacion } from '../../../models/coformacion.model';

@Component({
  selector: 'app-coformacion-list',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './coformacion-list.component.html',
  styleUrls: ['./coformacion-list.component.css']
})
export class CoformacionListComponent implements OnInit {
  coformaciones: Coformacion[] = [];
  displayedColumns: string[] = ['id', 'nombre_completo', 'identificacion', 'rol', 'estado', 'acciones'];

  constructor(private coformacionService: CoformacionService) { }

  ngOnInit(): void {
    this.loadCoformaciones();
  }

  loadCoformaciones(): void {
    this.coformacionService.getCoformacion().subscribe(
      data => {
        this.coformaciones = data;
      },
      error => {
        console.error('Error al cargar la coformación:', error);
      }
    );
  }

  deleteCoformacion(id: number): void {
    if (confirm('¿Está seguro de eliminar este registro?')) {
      this.coformacionService.deleteCoformacion(id).subscribe(
        () => {
          this.loadCoformaciones();
        },
        error => {
          console.error('Error al eliminar la coformación:', error);
        }
      );
    }
  }
} 