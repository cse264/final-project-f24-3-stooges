const express = require('express');
const session = require('express-session');
const pg = require('pg');
let app = express ();

let env;
try {
    env = require('../env.json');
} catch (error) {
    console.error('Error loading env.json:', error);
    process.exit(1);
}

const Pool = pg.Pool;
const pool = new Pool(env);

pool.connect().then(() => {
    console.log('Database connected successfully');
}).catch(err => {
    console.error('Database connection error:', err);
    process.exit(1);
});
