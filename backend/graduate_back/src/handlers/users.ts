import express, { Request, Response } from 'express';
import { Users, User, JwtUser } from '../models/users';
import verifyJWT from '../middleware/jwt';
import dotenv from 'dotenv';
import jwt from 'jsonwebtoken';

dotenv.config();

const us = new Users();

const index = async (req: Request, res: Response) => {
  try {
    const result = await us.index();
    res.status(200).json(result);
  } catch (err) {
    res.status(400).send('' + err);
  }
};

const show = async (req: Request, res: Response) => {
  try {
    const authorizationHeader = req.headers.authorization!;
    const token = authorizationHeader.split(' ')[0];
    const usr = jwt.decode(token) as JwtUser;
    const result = await us.show(usr.user.email);

    if (result.photo != null || result.photo != undefined) {
      result.photo = result.photo.toString();
    }
    res.status(200).json(result);
  } catch (err) {
    res.status(400).send('' + err);
  }
};
const create = async (req: Request, res: Response) => {
  const body = req.body;
  const usr: User = {
    email: body.email,
    firstname: body.firstname,
    lastname: body.lastname,
    birthday: body.birthday,
    photo: body.photo,
    password: body.password,
  };

  try {
    const result = await us.create(usr);
    const token = jwt.sign({ user: result }, process.env.TOKEN_SECRET!);

    res.status(200).json({ token: token });
  } catch (err) {
    res.status(400).send('' + err);
  }
};
const login = async (req: Request, res: Response) => {
  const body = req.params;
  try {
    const result = await us.auth(body.email, body.password);
    const token = jwt.sign({ user: result }, process.env.TOKEN_SECRET!);
    res.status(200).json({ token: token });
  } catch (err) {
    res.status(400).send('' + err);
  }
};
const user_routes = (app: express.Application) => {
  // show all users
  app.get('/users', verifyJWT, index);
  // show user info given valid jwt
  app.get('/users/account', verifyJWT, show);
  // register user
  app.post('/users', create);
  // login user
  app.get('/auth/:email/:password', login);
};
export default user_routes;
