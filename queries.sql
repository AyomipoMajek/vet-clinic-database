/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals WHERE neutered = True AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


-- Begin transaction
BEGIN;

-- Update animals table by setting species to unspecified
UPDATE animals SET species = 'unspecified';

-- Verify change
SELECT * FROM animals;

-- Rollback transaction
ROLLBACK;

-- Verify that species column went back to the state before the transaction
SELECT * FROM animals;


-- Begin transaction
BEGIN;

-- Update animals table by setting species to digimon for all animals whose name ends in mon
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update animals table by setting species to pokemon for all animals that don't have a species already set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verify change
SELECT * FROM animals;

-- Commit transaction
COMMIT;

-- Verify change
SELECT * FROM animals;

-- Begin transaction
BEGIN;

-- Delete all records in the animals table
DELETE FROM animals;

-- Verify change
SELECT * FROM animals;

--  Roll back the transaction.
ROLLBACK;

-- Verify change
SELECT * FROM animals;



-- Begin transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT update_weights;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO update_weights;

-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;


-- Queries to answer the given questions

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) AS avg_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY avg_escape_attempts DESC
LIMIT 1;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;


-- Animals belonging to Melody pond
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- Animals that are pokemon
SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- list of all owners
SELECT owners.full_name, animals.name
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

-- number of animals per specie
SELECT species.name, COUNT(animals.id)
FROM species
JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- list of Digimon owned by Jennifer Orwell
SELECT animals.name
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- list of animals owned by Dean Winchestee that haven't tried to escape
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
LEFT JOIN escapes ON animals.id = escapes.animal_id
WHERE owners.full_name = 'Dean Winchester' AND escapes.animal_id IS NULL;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.id) as num_animals
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY num_animals DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets v2 ON v.vet_id = v2.id
WHERE v2.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animal_id) AS num_animals
FROM visits
WHERE vet_id = (
  SELECT id FROM vets WHERE name = 'Stephanie Mendez'
);

-- List all vets and their specialties, including vets with no specialties.
SELECT v.name AS vet_name, s.name AS species_name
FROM vets v
LEFT JOIN specializations sp ON v.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id
ORDER BY v.name ASC;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal_name, v.visit_date
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vet ON v.vet_id = vet.id AND vet.name = 'Stephanie Mendez'
WHERE v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT name
FROM animals
WHERE id = (
  SELECT animal_id
  FROM visits
  GROUP BY animal_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
);

-- Who was Maisy Smith's first visit?
SELECT animals.name AS animal_name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.visit_date ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal_name, vets.name AS vet_name, visits.visit_date
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
ORDER BY visits.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS num_visits_without_specialization
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations s ON vt.id = s.vet_id AND a.species_id = s.species_id
WHERE s.vet_id IS NULL;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS species_name, COUNT(*) AS visit_count
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN species ON animals.species_id = species.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species_name
ORDER BY visit_count DESC
LIMIT 1;
