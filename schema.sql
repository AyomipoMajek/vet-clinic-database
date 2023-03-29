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


-- Create owners table
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255) NOT NULL,
  age INTEGER NOT NULL
);

-- Create species table
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- Modify animals table
ALTER TABLE animals
  DROP COLUMN species,
  ADD COLUMN species_id INTEGER REFERENCES species(id),
  ADD COLUMN owner_id INTEGER REFERENCES owners(id);
