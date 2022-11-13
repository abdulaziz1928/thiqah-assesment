import client from '../database';
import dotenv from 'dotenv';
import bcrypt from 'bcrypt';

dotenv.config();

const pepper = process.env.BCRYPT_PASSWORD;
const salt = process.env.SALT_ROUNDS;

export type User = {
  id?: string;
  email: string;
  firstname: string;
  lastname: string;
  birthday: string;
  photo?: string;
  password: string;
};
export type JwtUser = {
  user: User;
  iat: number;
};

export class Users {
  async index(): Promise<User[]> {
    try {
      const conn = await client.connect();
      const sql = 'SELECT * FROM users';
      const res = await conn.query(sql);
      conn.release();
      return res.rows;
    } catch (err) {
      throw new Error(`cannot get users: ${err}`);
    }
  }
  async show(email: string): Promise<User> {
    try {
      const conn = await client.connect();
      const sql = `SELECT * FROM users WHERE email=($1)`;
      const res = await conn.query(sql, [email]);
      conn.release();
      return res.rows[0];
    } catch (err) {
      throw new Error(`cannot find user: ${err}`);
    }
  }
  async create(u: User): Promise<User> {
    try {
      const conn = await client.connect();
      const hash = bcrypt.hashSync(u.password + pepper, parseInt(salt!));
      let res;
      if (u.photo === undefined || u.photo === null) {
        const sql = `INSERT INTO users (email,firstName,lastName,birthday,password) VALUES ($1,$2,$3,$4,$5) RETURNING *`;
        res = await conn.query(sql, [
          u.email,
          u.firstname,
          u.lastname,
          u.birthday,
          hash,
        ]);
      } else {
        const sql = `INSERT INTO users (email,firstName,lastName,birthday,photo,password) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *`;
        res = await conn.query(sql, [
          u.email,
          u.firstname,
          u.lastname,
          u.birthday,
          u.photo,
          hash,
        ]);
      }
      conn.release();
      return res.rows[0];
    } catch (err) {
      throw new Error(`cannot create user ${err}`);
    }
  }
  async auth(email: string, password: string): Promise<User> {
    const conn = await client.connect();
    const sql = `SELECT * FROM users WHERE email=($1)`;
    const result = await conn.query(sql, [email]);
    conn.release();
    if (result.rows.length) {
      const user = result.rows[0];
      user.photo = undefined;
      if (bcrypt.compareSync(password + pepper, user.password)) {
        return user;
      }
    }
    throw new Error('invalid email/password');
  }
}
