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


-- Create a table named vets
CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);


-- Create a "join table" called specializations
CREATE TABLE specializations (
  vet_id INTEGER REFERENCES vets (id),
  species_id INTEGER REFERENCES species (id),
  PRIMARY KEY (vet_id, species_id)
);


-- Create a "join table" called visits
CREATE TABLE visits (
  id SERIAL PRIMARY KEY,
  animal_id INTEGER REFERENCES animals(id),
  vet_id INTEGER REFERENCES vets(id),
  visit_date DATE
);
