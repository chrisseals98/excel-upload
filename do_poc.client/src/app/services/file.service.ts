import { Injectable } from '@angular/core';
import * as xlsx from 'xlsx';

@Injectable({
  providedIn: 'root'
})
export class FileService {

  constructor() { }

  readFile(file: File): Promise<string | ArrayBuffer | null> {
    const fileReader = new FileReader();

    return new Promise((resolve, reject) => {
      fileReader.onerror = () => reject(new Error("There was an error reading the attached file."));

      fileReader.onload = () => resolve(fileReader.result);

      fileReader.readAsArrayBuffer(file);
    });
  }

  createWorkSheet(fileData: string | ArrayBuffer | null): xlsx.WorkSheet {
    const workbook = xlsx.read(fileData, {
      cellDates: true,
    });
    return workbook.Sheets[workbook.SheetNames[0]];
  }
}
