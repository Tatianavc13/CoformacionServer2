import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PublicarOfertaComponent } from './publicar-oferta.component';

describe('PublicarOfertaComponent', () => {
  let component: PublicarOfertaComponent;
  let fixture: ComponentFixture<PublicarOfertaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [PublicarOfertaComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(PublicarOfertaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
