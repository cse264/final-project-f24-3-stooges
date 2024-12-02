CREATE A env.json inside WanderWise with this inside:

{
    "user": "postgres",
    "host": "localhost",
    "database": "wanderwise",
    "password": "PASSWORD_HERE",
    "port": 5432
}

INSTALL TIPS for initial installs:
npm install
npm install express
npm install express-session
npm install pg
npm install postgres
npm install -g @angular/cli

npm run setup

WHENEVER CHANGES ARE MADE IN src
RUN "ng build --configuration production"