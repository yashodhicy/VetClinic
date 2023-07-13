/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

-- Transactions
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals WHERE species = 'unspecified';
ROLLBACK;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;


BEGIN;
DELETE FROM animals;
ROLLBACK;


BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

--queries for questions

SELECT count(id) as Count FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) as average_Weight FROM animals;

SELECT name, neutered FROM animals 
WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals)
GROUP BY name, neutered;

SELECT species, MIN(weight_kg) AS min, MAX(weight_kg) AS max FROM animals GROUP BY species;

SELECT species,AVG(escape_attempts) FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;

--- animals belongs to melody pond
SELECT animals.name
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT a.name
FROM animals AS a
JOIN species AS s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name AS species_name, COUNT(*) AS animal_count
FROM animals a
JOIN species s ON a.species_id = s.id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(*) AS animal_count
FROM owners o
JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;

--day4

SELECT (SELECT name FROM animals WHERE id = visits.animal_id) AS animal , visit_date
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'William Tatcher')
ORDER BY visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT animal_id) AS animal_count
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Stephanie Mendez');

SELECT vets.name as vet , (SELECT name FROM species WHERE id = specializations.species_id) as species FROM vets 
LEFT JOIN specializations ON specializations.vet_id =vets.id;

SELECT (SELECT name FROM animals WHERE id = visits.animal_id) AS animal 
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = ' Stephanie Mendez')
AND visits.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT (SELECT name FROM animals WHERE id = visits.animal_id) , COUNT(animal_id) FROM visits
GROUP BY animal_id
ORDER BY count DESC
LIMIT 1;

SELECT (SELECT name FROM animals WHERE id = visits.animal_id) AS animal, visit_date
FROM visits
WHERE vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
ORDER BY visit_date ASC
LIMIT 1;

SELECT animals.*, vets.*, visits.visit_date
FROM visits
JOIN animals ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
ORDER BY visits.visit_date DESC
LIMIT 1;

SELECT COUNT(*)
FROM visits as v
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations AS s ON v.vet_id = s.vet_id AND a.species_id = s.species_id
WHERE s.species_id is NULL;

SELECT sp.name
FROM visits as v
JOIN animals AS a ON v.animal_id = a.id
JOIN species  AS sp ON sp.id = a.species_id
WHERE v.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith') 
GROUP BY sp.name
ORDER BY COUNT(sp.name) DESC
LIMIT 1;

