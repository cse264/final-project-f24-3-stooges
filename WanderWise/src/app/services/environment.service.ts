import { Injectable } from '@angular/core';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class EnvironmentService {
  public getOpenWeatherApiKey(): string {
    return environment.openWeatherApiKey;
  }
}


