import { Users, User } from '../../models/users';
import JasmineExpect from 'jasmine-expect';
const us = new Users();

const usr: User = {
  email: 'test@test.com',
  firstname: 'first',
  lastname: 'last',
  birthday: '01/01/1900',
  photo: 'www.test.com/image.png',
  password: 'test12344321',
};

describe('Users Model', () => {
  it('create method should add a new user', async () => {
    const res = await us.create(usr);
    usr.id = res.id;
    expect({
      email: res.email,
      firstName: res.firstname,
      birthday: res.birthday,
      lastName: res.lastname,
    }).toEqual({
      email: usr.email,
      firstName: usr.firstname,
      birthday: usr.birthday,
      lastName: usr.lastname,
    });
  });
  it('auth method should should return user if email and password match', async () => {
    const res = await us.auth(usr.email, usr.password);
    expect(res).not.toBeNull();
  });
  it('index method should should show all users', async () => {
    const res = await us.index();
    expect(res.length).toBeGreaterThan(0);
  });
  it('show method should should show a user given an email', async () => {
    const res = await us.show(usr.email);
    expect({
      email: res.email,
      firstName: res.firstname,
      birthday: res.birthday,
      lastName: res.lastname,
    }).toEqual({
      email: usr.email,
      firstName: usr.firstname,
      birthday: usr.birthday,
      lastName: usr.lastname,
    });
  });
});
