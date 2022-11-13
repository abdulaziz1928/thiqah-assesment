import { Programs, Program } from '../../models/programs';
import { User, Users } from '../../models/users';
const prg = new Programs();
const us = new Users();
let usr: User = {
  email: 'test1@test.com',
  firstname: 'first1',
  lastname: 'last1',
  birthday: '01/01/1900',
  photo: 'www.test.com/image1.png',
  password: 'test12344321',
};
const prog: Program = {
  user_email: 'test1@test.com',
  faculty: 'information',
  level_study: 'Bachelors',
  program: 'Software Engineering',
};
describe('Programs Model', () => {
  beforeAll(async () => {
    usr = await us.create(usr);
  });
  it('create method should add a new program', async () => {
    const res = await prg.create(prog);
    expect({
      email: res.user_email,
      faculty: res.faculty,
      level: res.level_study,
      program: res.program,
    }).toEqual({
      email: prog.user_email,
      faculty: prog.faculty,
      level: prog.level_study,
      program: prog.program,
    });
  });
  it('show method should should show a program given an email', async () => {
    const res = await prg.show(prog.user_email);

    expect({
      email: res.user_email,
      faculty: res.faculty,
      level: res.level_study,
      program: res.program,
    }).toEqual({
      email: prog.user_email,
      faculty: prog.faculty,
      level: prog.level_study,
      program: prog.program,
    });
  });
  it('index method should should show all programs', async () => {
    const res = await prg.index();
    expect(res.length).toBeGreaterThan(0);
  });
});
