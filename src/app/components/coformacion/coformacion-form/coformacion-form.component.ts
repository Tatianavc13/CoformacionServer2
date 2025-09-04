import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { RouterModule, Router, ActivatedRoute } from '@angular/router';
import { CoformacionService } from '../../../services/coformacion.service';
import { Coformacion } from '../../../models/coformacion.model';

@Component({
  selector: 'app-coformacion-form',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './coformacion-form.component.html',
  styleUrls: ['./coformacion-form.component.css']
})
export class CoformacionFormComponent implements OnInit {
  coformacionForm: FormGroup;
  isEditMode = false;
  coformacionId: number | null = null;

  constructor(
    private fb: FormBuilder,
    private coformacionService: CoformacionService,
    private router: Router,
    private route: ActivatedRoute
  ) {
    this.coformacionForm = this.fb.group({
      nombre_completo: ['', Validators.required],
      identificacion: ['', [Validators.required, Validators.pattern('^[0-9]{10}$')]],
      rol: ['', Validators.required],
      estado: [true]
    });
  }

  ngOnInit(): void {
    this.coformacionId = this.route.snapshot.params['id'];
    if (this.coformacionId) {
      this.isEditMode = true;
      this.loadCoformacion();
    }
  }

  loadCoformacion(): void {
    if (this.coformacionId) {
      this.coformacionService.getCoformacionById(this.coformacionId).subscribe(
        data => {
          this.coformacionForm.patchValue(data);
        },
        error => {
          console.error('Error al cargar la coformación:', error);
        }
      );
    }
  }

  onSubmit(): void {
    if (this.coformacionForm.valid) {
      const coformacion: Coformacion = this.coformacionForm.value;
      
      if (this.isEditMode && this.coformacionId) {
        this.coformacionService.updateCoformacion(this.coformacionId, coformacion).subscribe(
          () => {
            this.router.navigate(['/coformacion']);
          },
          error => {
            console.error('Error al actualizar la coformación:', error);
          }
        );
      } else {
        this.coformacionService.createCoformacion(coformacion).subscribe(
          () => {
            this.router.navigate(['/coformacion']);
          },
          error => {
            console.error('Error al crear la coformación:', error);
          }
        );
      }
    }
  }
} 