import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConsultEmpresaComponent } from './consult-empresa.component';

describe('ConsultEmpresaComponent', () => {
  let component: ConsultEmpresaComponent;
  let fixture: ComponentFixture<ConsultEmpresaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ConsultEmpresaComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ConsultEmpresaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
