CREATE TABLE programs (
    id SERIAL PRIMARY KEY,
    user_email VARCHAR REFERENCES users(email),
    level_study VARCHAR,
    program VARCHAR,
    faculty VARCHAR
    );