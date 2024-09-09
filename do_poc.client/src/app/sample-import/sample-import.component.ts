import { Component } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import * as xlsx from 'xlsx';
import { FileService } from '../services/file.service';

type Sample = {
  stationId: string,
  datetime: Date,
  depth: number,
  secchi: number,
  temp: number,
  ph: number,
  spCond: number,
  doPercent: number,
  do: number
}

@Component({
  selector: 'app-sample-import',
  templateUrl: './sample-import.component.html',
  styleUrl: './sample-import.component.css'
})
export class SampleImportComponent {
  worksheet: xlsx.WorkSheet | undefined;
  showTable = new FormControl(false);
  columnMappings: FormGroup = new FormGroup({
    rowsToSkip: new FormControl(8),
    stationId: new FormControl("A"),
    date: new FormControl("C"),
    time: new FormControl("D"),
    timeZone: new FormControl("E"),
    depth: new FormControl("L"),
    secchi: new FormControl("B"),
    temp: new FormControl("F"),
    ph: new FormControl("G"),
    spCond: new FormControl("H"),
    doPercent: new FormControl("I"),
    do: new FormControl("J"),
  });

  protected get isFileRead(): boolean {
    return this.worksheet !== undefined;
  }

  protected get importedSamples(): Sample[] {
    if(this.worksheet) {
      let samples: Sample[] = [];
      const excelJSON = xlsx.utils.sheet_to_json<any>(this.worksheet, { header: "A" });
      const startingIndex = excelJSON.findIndex(row => row.__rowNum__ == (this.columnMappings.value.rowsToSkip ? this.columnMappings.value.rowsToSkip : 0));
      const slicedArray = excelJSON.slice(startingIndex);
      slicedArray.forEach(row => {
        samples.push({
          stationId: row[this.columnMappings.value.stationId],
          datetime: this.combineDateAndTime(row[this.columnMappings.value.date], row[this.columnMappings.value.time], row[this.columnMappings.value.timeZone]),
          depth: row[this.columnMappings.value.depth],
          secchi: row[this.columnMappings.value.secchi],
          temp: row[this.columnMappings.value.temp],
          ph: row[this.columnMappings.value.ph],
          spCond: row[this.columnMappings.value.spCond],
          doPercent: row[this.columnMappings.value.doPercent],
          do: row[this.columnMappings.value.do]
        });
      })
      console.log(excelJSON)
      console.log(samples);
      return samples;
    }
    else { 
      return [];
    }
  }

  protected get rowsMissingData(): { index: number, column: string }[] {
    const data = this.importedSamples;
    let errors: { index: number, column: string }[] = [];
    data.forEach((row, rowIndex) => {
      Object.entries(row).forEach(property => {
        if(!property[1] && property[0] != "secchi") {
          errors.push({
            index: rowIndex,
            column: property[0]
          })
        }
      })
    })
    console.log(errors)
    return errors;
  }

  constructor(private fileService: FileService) {
    this.showTable.valueChanges.subscribe(value => {
      if (value && this.worksheet) {
        const excelHTML = xlsx.utils.sheet_to_html(this.worksheet); //, { editable: true }
        document.getElementById("data")!.innerHTML = excelHTML;
      }
      else {
        document.getElementById("data")!.innerHTML = "";
      }
    })
  }

  async readFile(event: Event) {
    const fileInput = event.target as HTMLInputElement;
      if(fileInput.files!.length > 0) {
        const fileData = await this.fileService.readFile(fileInput.files![0]);
        this.worksheet = this.fileService.createWorkSheet(fileData);
      }
      else {
        this.worksheet = undefined;
        alert("A file needs to be attached to continue.");
      }
  }

  combineDateAndTime(date: Date, time: Date, timeZone: string): Date {
    debugger
    const string = `${date.getFullYear()} ${date.getMonth()} ${date.getDay()} ${time.getHours()}:${time.getMinutes()}:${time.getSeconds()} ${timeZone ? timeZone : ''}`;
    return new Date(string);
  }
}
