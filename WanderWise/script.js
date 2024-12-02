const express = require('express');
const session = require('express-session');
const pg = require('pg');
const path = require('path');
const fs = require('fs');
let app = express();

app.use(express.static("./dist/wander-wise/browser"));

let env;
try {
    env = require('./env.json');
} catch (error) {
    console.error('Error loading env.json:', error);
    process.exit(1);
}

app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, 'dist/wander-wise/browser', 'index.html'));
});

const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});