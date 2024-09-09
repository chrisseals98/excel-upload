import { provideHttpClient, withInterceptorsFromDi } from '@angular/common/http';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatInputModule } from '@angular/material/input';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatButtonModule } from '@angular/material/button';
import { MatStepperModule } from '@angular/material/stepper';
import { MatSnackBarModule } from '@angular/material/snack-bar';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatCheckboxModule } from '@angular/material/checkbox';
import { provideRouter, RouterOutlet, RouterLink } from '@angular/router';
import { routes } from './app.routes';
import { HomeComponent } from './home/home.component';
import { SampleImportComponent } from './sample-import/sample-import.component';

@NgModule({ declarations: [
        AppComponent,
        HomeComponent,
        SampleImportComponent
    ],
    bootstrap: [AppComponent],
    imports: [
        BrowserModule,
        FormsModule,
        MatFormFieldModule,
        MatInputModule,
        MatButtonModule,
        MatStepperModule,
        MatSnackBarModule,
        ReactiveFormsModule,
        RouterOutlet,
        RouterLink,
        MatToolbarModule,
        MatCheckboxModule
    ],
    providers: [provideHttpClient(withInterceptorsFromDi()), provideAnimationsAsync(), provideRouter(routes)] })
export class AppModule { }
