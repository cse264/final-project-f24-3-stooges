import { HttpClient } from '@angular/common/http';
import { Component, NO_ERRORS_SCHEMA } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { Router } from '@angular/router';


@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule, HttpClientModule],
  templateUrl: './login.component.html',
  styleUrl: './login.component.css'
})
export class LoginComponent {
  loginObj: Login;

  constructor(private http: HttpClient, private router: Router) {
    this.loginObj = new Login();
  }

  onLogin() {
    this.http.post(`requestURL`, this.loginObj).subscribe((res:any)=> {
      if(res.result) {
        alert("Login Success")
        this.router.navigateByUrl(`/dashboard`)
      } else {
        alert(res.message)
      }
    })
  }
}

export class Login {
  emailId: string;
  password: string;
  constructor() {
    this.emailId = '';
    this.password = '';
  }
}
