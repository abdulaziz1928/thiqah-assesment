## API Endpoints

#### Programs

#### - Index [JWT required]

- headers: authorization
- route: /program
- http verb: GET
- body: None

#### - Show [JWT required]

- headers: authorization,email
- route: /program/show
- http verb: GET
- body: None

#### - Create [token required]

- headers: authorization
- route: /program
- http verb: POST
- body:

```json
{
  email: "",
  level: "",
  program: "",
  faculty: "",
};
```

#### Users

#### - Index [token required]

- headers: authorization
- route: /users
- http verb: GET
- body:None

#### - Show [token required]

- headers: authorization
- route: /users/account
- http verb: GET
- body:None

#### - Create [token required]

- headers: None
- route: /users
- http verb: POST
- body:

```json
{
  email: "",
  firstname: "",
  lastname: "",
  birthday: "",
  photo: "can be null",
  password: "" ,
};
```

#### - Auth [token required]

- headers: None
- route: /auth/:email/:password
- http verb: POST
- body: None

## Data Shapes

#### User

- id
- email
- firstName
- lastName
- birthday
- photo (photo address)
- password

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR UNIQUE NOT NULL,
    firstName VARCHAR NOT NULL,
    lastName VARCHAR NOT NULL,
    birthday VARCHAR NOT NULL,
    photo VARCHAR,
    password VARCHAR NOT NULL
    );
```

#### Programs

- id
- user_email
- level_study
- program
- faculty

```sql
CREATE TABLE programs (
    id SERIAL PRIMARY KEY,
    user_email VARCHAR REFERENCES users(email),
    level_study VARCHAR,
    program VARCHAR,
    faculty VARCHAR
    );
```
