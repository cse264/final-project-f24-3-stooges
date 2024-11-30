import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class EnvironmentService {
  private apiKey: string | undefined;

  constructor() {
    this.apiKey = this.getEnvVariable('OPENWEATHER_API_KEY');
  }

  private getEnvVariable(key: string): string | undefined {
    return process.env[key];
  }

  public getOpenWeatherApiKey(): string | undefined {
    return this.apiKey;
  }
}

