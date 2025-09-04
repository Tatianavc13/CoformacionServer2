import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ResumenEmpresaComponent } from './resumen-empresa.component';

describe('ResumenEmpresaComponent', () => {
  let component: ResumenEmpresaComponent;
  let fixture: ComponentFixture<ResumenEmpresaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ResumenEmpresaComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ResumenEmpresaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
