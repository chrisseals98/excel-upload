import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Sample } from './sample.model';

@Injectable({
  providedIn: 'root'
})
export class SampleService {

  constructor(private http: HttpClient) { }

  getSamples(): Observable<Sample[]> {
    return this.http.get<Sample[]>("/samples");
  }
}
