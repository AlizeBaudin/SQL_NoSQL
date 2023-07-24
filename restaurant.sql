-- création de la table ingredient
CREATE TABLE ingredients (
  nom VARCHAR(255) PRIMARY KEY,
  empreinte_carbone FLOAT
);
-- création de la table repas 
CREATE TABLE repas (
  id int PRIMARY KEY,
  nom VARCHAR(255),
  total_empreinte_carbone FLOAT
);
-- creation de la table des plats
CREATE TABLE plats (
  id int PRIMARY KEY,
  nom VARCHAR(255),
  empreinte_carbone FLOAT
);
-- creation de la table des desserts
CREATE TABLE dessert (
  id int PRIMARY KEY,
  nom VARCHAR(255),
  empreinte_carbone FLOAT
);
-- creation de la table des entrees
CREATE TABLE entree (
  id int PRIMARY KEY,
  nom VARCHAR(255),
  empreinte_carbone FLOAT
);

-- table de liaison entre la table repas et plats
CREATE TABLE repas_entree_plat_dessert (
  repas_id INT,
  plat_id INT,
  dessert_id INT,
  entree_id INT,
  PRIMARY KEY (repas_id, plat_id, dessert_id, entree_id),
  FOREIGN KEY (repas_id) REFERENCES repas (id),
  FOREIGN KEY (plat_id) REFERENCES plats (id),
  FOREIGN KEY (dessert_id) REFERENCES dessert (id),
  FOREIGN KEY (entree_id) REFERENCES entree (id)
);


-- table de liaison entre les plats et les ingredients
CREATE TABLE plats_ingredients (
  plat_id INT,
  ingredient_nom VARCHAR(255),
  PRIMARY KEY (plat_id, ingredient_nom),
  FOREIGN KEY (plat_id) REFERENCES plats (id),
  FOREIGN KEY (ingredient_nom) REFERENCES ingredients (nom)
);

CREATE TABLE dessert_ingredients (
  plat_id INT,
  ingredient_nom VARCHAR(255),
  PRIMARY KEY (plat_id, ingredient_nom),
  FOREIGN KEY (plat_id) REFERENCES dessert (id),
  FOREIGN KEY (ingredient_nom) REFERENCES ingredients (nom)
);

CREATE TABLE entree_ingredients (
  plat_id INT,
  ingredient_nom VARCHAR(255),
  PRIMARY KEY (plat_id, ingredient_nom),
  FOREIGN KEY (plat_id) REFERENCES entree (id),
  FOREIGN KEY (ingredient_nom) REFERENCES ingredients (nom)
);
