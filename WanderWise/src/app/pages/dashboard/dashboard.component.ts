import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HttpClientModule } from '@angular/common/http';
import { EnvironmentService } from '../../services/environment.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [HttpClientModule, CommonModule],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css'],
})
export class DashboardComponent implements OnInit {
  weatherData: any;
  error: string | null = null;

  constructor(private http: HttpClient, public envService: EnvironmentService) {}

  ngOnInit(): void {
    const apiKey = this.envService.getOpenWeatherApiKey();

    if (apiKey) {
      this.fetchWeatherData('New York', apiKey);
    } else {
      this.error = 'API key not found. Please check your .env file.';
    }
  }

  fetchWeatherData(city: string, apiKey: string): void {
    const apiUrl = `https://api.openweathermap.org/data/2.5/weather?q=${city}&units=metric&appid=${apiKey}`;
    this.http.get(apiUrl).subscribe({
      next: (data: any) => {
        this.weatherData = data;
        this.error = null;
      },
      error: (err) => {
        this.error = 'Failed to load weather data. Please try again.';
        console.error(err);
      },
    });
  }
}
