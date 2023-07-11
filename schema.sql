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

