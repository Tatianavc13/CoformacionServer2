import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OfertasCoformacionComponent } from './ofertas-coformacion.component';

describe('OfertasCoformacionComponent', () => {
  let component: OfertasCoformacionComponent;
  let fixture: ComponentFixture<OfertasCoformacionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [OfertasCoformacionComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(OfertasCoformacionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
