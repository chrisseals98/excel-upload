import { HttpClient } from '@angular/common/http';
import { Component } from '@angular/core';
import { FormControl, FormGroup } from '@angular/forms';
import * as xlsx from 'xlsx';
import { FileService } from '../services/file.service';
import { Result } from '../services/result.model';
import { Sample } from '../services/sample.model';

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
    locId: new FormControl("A"),
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
        let combinedDateTime = this.combineDateAndTime(row[this.columnMappings.value.date], row[this.columnMappings.value.time], row[this.columnMappings.value.timeZone])
        samples.push({
          sampleNumber: combinedDateTime.toISOString() + row[this.columnMappings.value.depth],
          locId: row[this.columnMappings.value.locId],
          datetime: combinedDateTime,
          depth: row[this.columnMappings.value.depth],
          results: this.createResults(row)
        });
      })
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
        if(property[0] == "results") {
          (property[1] as Result[]).forEach(result => {
            if(!result.value && result.resultName != "secchi") {
              errors.push({
                index: rowIndex,
                column: result.resultName
              })
            }
          })
        }
        else {
          if(!property[1]) {
            errors.push({
              index: rowIndex,
              column: property[0]
            });
          }
        }
      })
    });
    return errors;
  }

  constructor(private fileService: FileService, private http: HttpClient) {
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
    const string = `${date.getFullYear()} ${date.getMonth() + 1} ${date.getDate()} ${time.getHours()}:${time.getMinutes()}:${time.getSeconds()} ${timeZone ? timeZone : ''}`;
    return new Date(string);
  }

  createResults(row: any): Result[] {
    return [
      {
        locId: row[this.columnMappings.value.locId],
        resultName: "secchi",
        value: row[this.columnMappings.value.secchi]
      },
      {
        locId: row[this.columnMappings.value.locId],
        resultName: "temp",
        value: row[this.columnMappings.value.temp]
      },
      {
        locId: row[this.columnMappings.value.locId],
        resultName: "ph",
        value: row[this.columnMappings.value.ph]
      },
      {
        locId: row[this.columnMappings.value.locId],
        resultName: "spCond",
        value: row[this.columnMappings.value.spCond]
      },
      {
        locId: row[this.columnMappings.value.locId],
        resultName: "doPercent",
        value: row[this.columnMappings.value.doPercent]
      },
      {
        locId: row[this.columnMappings.value.locId],
        resultName: "do",
        value: row[this.columnMappings.value.do]
      }
    ];
  }

  upload() {
    this.http.post("/upload", this.importedSamples).subscribe({
      next: (response: any) => { alert("Upload Complete, response: "); console.log(response) },
      error: (error: any) => { alert("Server error"); console.log(error) }
    });
  }

  logData() {
    console.log(this.importedSamples);
  }
}
