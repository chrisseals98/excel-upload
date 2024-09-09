import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SampleImportComponent } from './sample-import.component';

describe('SampleImportComponent', () => {
  let component: SampleImportComponent;
  let fixture: ComponentFixture<SampleImportComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [SampleImportComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SampleImportComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
