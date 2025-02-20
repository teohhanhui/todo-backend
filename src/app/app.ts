import cookieParser from 'cookie-parser';
import express from 'express';
import morgan from 'morgan';
import { join } from 'node:path';
import { packageDirectory } from 'pkg-dir';

import indexRouter from '#app/routes/index';
import usersRouter from '#app/routes/users';

const app = express();

app.use(morgan('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(join((await packageDirectory())!, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

export default app;
