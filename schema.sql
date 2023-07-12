/* Database schema to keep the structure of entire database. */

-- recreate the table with adding primary keys
CREATE TABLE animals (
  id INT NOT NULL GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(250),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOL,
  weight_kg DECIMAL
);

PRIMARY KEY (id)



--add species
ALTER TABLE animals ADD COLUMN species VARCHAR;

--create owners table
CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INT
);

 -- create species table
CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

-- update animals table
ALTER TABLE animals DROP COLUMN species;


ALTER TABLE animals ADD species_id INT,
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species(id)
ON DELETE CASCADE;


ALTER TABLE animals ADD owner_id INT,
ADD CONSTRAINT fk_owners
FOREIGN KEY (owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;
