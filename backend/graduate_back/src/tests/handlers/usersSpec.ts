import request from 'supertest';
import { User, Users } from '../../models/users';
import app from '../../server';
import jwt from 'jsonwebtoken';

let token: string;
const usr: User = {
  email: 'testApi@test.com',
  firstname: 'first2',
  lastname: 'last2',
  birthday: '01/01/1900',
  photo: 'www.testApi.com/image.png',
  password: 'test12344321',
};
describe('User Endpoints', () => {
  it('POST /users should return status code 200 (success) if user can be created and return JWT token', async () => {
    const res = await request(app).post('/users').send(usr);
    expect(res.statusCode).toBe(200);
    expect(res.body.token).toBeDefined();
    token = res.body.token;
  });
  it('GET /users should return status code 200 (success) and index all users if user passes JWT token', async () => {
    const res = await request(app).get('/users').set({ authorization: token });
    expect(res.statusCode).toBe(200);
    expect(res.body).toBeDefined();
  });
  it('GET /users/account should return status code 200 (success) if user passes JWT token', async () => {
    const res = await request(app)
      .get('/users/account')
      .set({ authorization: token });
    expect(res.statusCode).toBe(200);
  });
  it('GET /auth/:email/:password should return status code 200 (success) and auth token if user passes a correct email and password combination', async () => {
    const res = await request(app).get(`/auth/${usr.email}/${usr.password}`);
    expect(res.statusCode).toBe(200);
    expect(res.body.token).toBeDefined();
  });
});
