import request from 'supertest';
import { User, JwtUser } from '../../models/users';
import app from '../../server';
import jwt from 'jsonwebtoken';
import { Program } from '../../models/programs';

let token: string;

let user: User = {
  email: 'testApi111@test.com',
  firstname: 'first3',
  lastname: 'last3',
  birthday: '01/01/1900',
  photo: 'www.testApi1.com/image.png',
  password: 'test12344321',
};
const prog: Program = {
  user_email: 'testApi1@test.com',
  faculty: 'information',
  level_study: 'Bachelors',
  program: 'Software Engineering',
};
describe('Programs Endpoints', () => {
  beforeAll(async () => {
    token = (await request(app).post('/users').send(user)).body.token;
    user = (jwt.decode(token) as JwtUser).user;
  });
  it('POST /program should return status code 200 (success) if program can be created and auth token provided', async () => {
    const res = await request(app)
      .post('/program')
      .send(prog)
      .set({ authorization: token });
    expect(res.statusCode).toBe(200);
  });
  it('GET /program should return status code 200 (success) and index all programs if auth token is provided', async () => {
    const res = await request(app)
      .get('/program')
      .set({ authorization: token });
    expect(res.statusCode).toBe(200);
    expect(res.body).toBeDefined();
  });
});
