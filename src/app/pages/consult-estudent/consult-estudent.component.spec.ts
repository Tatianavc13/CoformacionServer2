import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ConsultEstudentComponent } from './consult-estudent.component';

describe('ConsultEstudentComponent', () => {
  let component: ConsultEstudentComponent;
  let fixture: ComponentFixture<ConsultEstudentComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [ConsultEstudentComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ConsultEstudentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
