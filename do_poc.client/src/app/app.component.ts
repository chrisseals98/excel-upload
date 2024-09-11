import { Component } from '@angular/core';
import * as xlsx from 'xlsx';
import { FileService } from './services/file.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  worksheet: xlsx.WorkSheet | undefined;
  showTable = false;

  protected get isFileRead(): boolean {
    return this.worksheet !== undefined;
  }

  constructor(private fileService: FileService) {}

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

  toggleTable() {
    this.showTable = !this.showTable;
    if (this.showTable && this.worksheet) {
      const excelHTML = xlsx.utils.sheet_to_html(this.worksheet, {

      });    
      document.getElementById("data")!.innerHTML = excelHTML;
    }
    else {
      document.getElementById("data")!.innerHTML = "";
    }
  }
}
