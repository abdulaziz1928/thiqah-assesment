CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR UNIQUE NOT NULL,  
    firstName VARCHAR NOT NULL, 
    lastName VARCHAR NOT NULL,
    birthday VARCHAR NOT NULL, 
    photo VARCHAR,
    password VARCHAR NOT NULL
    );