import client from '../database';
export type Program = {
  user_email: string;
  level_study: string;
  program: string;
  faculty: string;
};
export class Programs {
  async index(): Promise<Program[]> {
    try {
      const conn = await client.connect();
      const sql = 'SELECT * FROM programs';
      const res = await conn.query(sql);
      conn.release();
      return res.rows;
    } catch (err) {
      throw new Error(`cannot get program: ${err}`);
    }
  }
  async show(email: string): Promise<Program> {
    try {
      const conn = await client.connect();
      const sql = `SELECT * FROM programs WHERE user_email=($1)`;
      const res = await conn.query(sql, [email.trim()]);
      conn.release();
      if (res.rows.length) {
        return res.rows[0];
      }
      throw new Error('No Program is associated with user');
    } catch (err) {
      throw new Error(`cannot find program: ${err}`);
    }
  }
  async create(p: Program): Promise<Program> {
    try {
      const conn = await client.connect();
      const sql = `INSERT INTO programs (user_email,level_study,program,faculty) VALUES ($1,$2,$3,$4) RETURNING *`;
      const res = await conn.query(sql, [
        p.user_email,
        p.level_study,
        p.program,
        p.faculty,
      ]);
      conn.release();
      return res.rows[0];
    } catch (err) {
      throw new Error(`cannot insert Program: ${err}`);
    }
  }
}
