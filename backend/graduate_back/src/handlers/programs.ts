import express, { Request, Response } from 'express';
import { Programs, Program } from '../models/programs';
import verifyJWT from '../middleware/jwt';
import dotenv from 'dotenv';
dotenv.config();
const prg = new Programs();
const index = async (req: Request, res: Response) => {
  try {
    const result = await prg.index();
    res.status(200).json(result);
  } catch (err) {
    res.status(400).send('' + err);
  }
};
const create = async (req: Request, res: Response) => {
  const body = req.body;
  const prog: Program = {
    user_email: body.email,
    level_study: body.level,
    program: body.program,
    faculty: body.faculty,
  };
  try {
    const result = await prg.create(prog);
    res.status(200).json(result);
  } catch (err) {
    console.log(err);
    res.status(400).send('' + err);
  }
};
const show = async (req: Request, res: Response) => {
  try {
    const emailHeader = req.headers.email! as string;

    const email = emailHeader.split(' ')[0];
    const result = await prg.show(email);
    res.status(200).json(result);
  } catch (err) {
    console.log(err);
    res.status(400).send('' + err);
  }
};
const program_routes = (app: express.Application) => {
  // get all programs
  app.get('/program', verifyJWT, index);
  // get a specific program by passing the email
  app.get('/program/show', verifyJWT, show);
  // create a new program and add it to user
  app.post('/program', verifyJWT, create);
};
export default program_routes;
