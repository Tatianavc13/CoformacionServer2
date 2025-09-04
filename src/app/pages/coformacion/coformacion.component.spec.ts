import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CoformacionComponent } from './coformacion.component';

describe('CoformacionComponent', () => {
  let component: CoformacionComponent;
  let fixture: ComponentFixture<CoformacionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CoformacionComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(CoformacionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
