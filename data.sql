/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
  VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
  VALUES (5, 'Charmander', '2020-02-08', 0, false, -11, 'unknown');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
  VALUES (6, 'Plantmon', '2021-11-15', 2, true, -5.7, 'unknown');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
  VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13, 'unknown');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
  VALUES (8, 'Angemon', '2005-12-06', 1, true, -45, 'unknown');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
  VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4, 'unknown');
INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg, species)
  VALUES (10, 'Blossom', '1998-10-13', 3, true, 17, 'unknown');
  VALUES (11, 'Ditto', '2022-05-14', 4, true, 22, 'unknown');

-- Insert data into owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
       ('Jennifer Orwell', 19),
       ('Bob', 45),
       ('Melody Pond', 77),
       ('Dean Winchester', 14),
       ('Jodie Whittaker', 38);

-- Insert data into species table
INSERT INTO species (name)
VALUES ('Pokemon'),
       ('Digimon');


-- Adding owner information to the animals section
UPDATE animals
SET owner_id = (
    SELECT owners.id
    FROM owners
    WHERE
        (animals.name = 'Agumon' AND owners.full_name = 'Sam Smith') OR
        (animals.name IN ('Gabumon', 'Pikachu') AND owners.full_name = 'Jennifer Orwell') OR
        (animals.name IN ('Devimon', 'Plantmon') AND owners.full_name = 'Bob') OR
        (animals.name IN ('Charmander', 'Squirtle', 'Blossom') AND owners.full_name = 'Melody Pond') OR
        (animals.name IN ('Angemon', 'Boarmon') AND owners.full_name = 'Dean Winchester')
);
