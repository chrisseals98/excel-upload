import { Routes } from "@angular/router";
import { HomeComponent } from "./home/home.component";
import { SampleImportComponent } from "./sample-import/sample-import.component";

export const routes: Routes = [
    {
        path: "",
        component: HomeComponent,
        title: "Home Page"
    },
    {
        path: "import",
        component: SampleImportComponent,
        title: "Sample Import"
    }
]