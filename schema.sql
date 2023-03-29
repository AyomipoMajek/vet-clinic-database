/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id integer,
    name VARCHAR(255),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
);

-- to add the species column
ALTER TABLE animals ADD COLUMN species VARCHAR(255);
