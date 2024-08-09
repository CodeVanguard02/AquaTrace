const cors = require('cors');
const express = require('express');
const app = express();
const userRouter = require('./routes/user.routes');
const body_parser = require('body-parser');


app.use(cors());
app.use(body_parser.json());
app.use('/',userRouter);

module.exports = app;