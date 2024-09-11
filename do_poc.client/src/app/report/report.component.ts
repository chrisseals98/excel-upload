import { Component, ViewChild } from '@angular/core';
import { MatTable } from '@angular/material/table';
import { Location } from '../services/location.model';
import { LocationService } from '../services/location.service';
import { SampleService } from '../services/sample.service';

type rowData = {
  sampleNumber: string,
  locId: string,
  sampleTime: Date,
  sampleDepth: number,
  secchi: number,
  temp: number,
  ph: number,
  spCond: number,
  doPercent: number,
  do: number
}

@Component({
  selector: 'app-report',
  templateUrl: './report.component.html',
  styleUrl: './report.component.css'
})
export class ReportComponent {
  locations: Location[] = [];
  data: rowData[] = [];
  columns = [
    "sampleNumber",
    "locId",
    "sampleTime",
    "sampleDepth",
    "secchi",
    "temp",
    "ph",
    "spCond",
    "doPercent",
    "do"
  ];

  @ViewChild(MatTable) table!: MatTable<rowData>;

  constructor(private locationService: LocationService, private sampleService: SampleService) {
    this.locationService.getLocations().subscribe(locations => {
      this.locations = locations;
    });
    this.sampleService.getSamples().subscribe(samples => {
      samples.forEach(sample => {
        this.data.push({
          sampleNumber: sample.sampleNumber,
          locId: sample.locId,
          sampleTime: sample.datetime,
          sampleDepth: sample.depth,
          secchi: sample.results.find(result => result.resultName == "secchi")!.value,
          temp: sample.results.find(result => result.resultName == "temp")!.value,
          ph: sample.results.find(result => result.resultName == "ph")!.value,
          spCond: sample.results.find(result => result.resultName == "spCond")!.value,
          doPercent: sample.results.find(result => result.resultName == "doPercent")!.value,
          do: sample.results.find(result => result.resultName == "do")!.value,
        });
        this.table.renderRows();
      });
    });
  }

  
}
