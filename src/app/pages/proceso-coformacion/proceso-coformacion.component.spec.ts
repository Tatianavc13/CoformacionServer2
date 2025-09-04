import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ProcesoCoformacionComponent } from './proceso-coformacion.component';

describe('ProcesoCoformacionComponent', () => {
  let component: ProcesoCoformacionComponent;
  let fixture: ComponentFixture<ProcesoCoformacionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ProcesoCoformacionComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ProcesoCoformacionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
