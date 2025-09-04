import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HistorialCoformacionComponent } from './historial-coformacion.component';

describe('HistorialCoformacionComponent', () => {
  let component: HistorialCoformacionComponent;
  let fixture: ComponentFixture<HistorialCoformacionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [HistorialCoformacionComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(HistorialCoformacionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
