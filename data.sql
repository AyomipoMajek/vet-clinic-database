/* Populate database with sample data. */

vet_clinic=# INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
vet_clinic-# VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);
INSERT 0 1
vet_clinic=# INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
vet_clinic-# VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT 0 1
vet_clinic=# INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
vet_clinic-# VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT 0 1
vet_clinic=# INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg)
vet_clinic-# VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);
INSERT 0 1
vet_clinic=#