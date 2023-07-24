-- Table "ingredients"
CREATE TABLE ingredient (
  id SERIAL PRIMARY KEY,
  data JSONB
);


-- Table "entree"
CREATE TABLE entree (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  ingredient JSONB NOT NULL
);

-- Table "plat"
CREATE TABLE plat (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  ingredient JSONB NOT NULL
);

-- Table "dessert"
CREATE TABLE dessert (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  ingredient JSONB NOT NULL
);

-- Table "menu"
CREATE TABLE menu (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  entree_id INT,
  plat_id INT,
  dessert_id INT,
  FOREIGN KEY (entree_id) REFERENCES entree(id),
  FOREIGN KEY (plat_id) REFERENCES plat(id),
  FOREIGN KEY (dessert_id) REFERENCES dessert(id)
);

-- Insertion des ingrédients
INSERT INTO ingredient (data) VALUES
  ('{"nom": "légume de saison", "emission": 53.4}'),
  ('{"nom": "huile d''olive (1/2 cuillérée)", "emission": 18.2}'),
  ('{"nom": "poulet", "emission": 774}'),
  ('{"nom": "riz", "emission": 84.6}'),
  ('{"nom": "beurre", "emission": 94.9}'),
  ('{"nom": "fromage à pâte molle", "emission": 107}'),
  ('{"nom": "fromage à pâte dure", "emission": 140}'),
  ('{"nom": "pain", "emission": 76}'),
  ('{"nom": "yaourt", "emission": 360}'),
  ('{"nom": "concombre", "emission": 129}'),
  ('{"nom": "bifteck", "emission": 5370}'),
  ('{"nom": "frite", "emission": 260}'),
  ('{"nom": "farine", "emission": 46.9}'),
  ('{"nom": "poire", "emission": 71}'),
  ('{"nom": "huile (1 cuillère)", "emission": 32.3}'),
  ('{"nom": "deux œufs", "emission": 276.7}'),
  ('{"nom": "pomme de terre", "emission": 15.5}'),
  ('{"nom": "huile ½ cuillérée", "emission": 17.1}'),
  ('{"nom": "fruits de saison", "emission": 53.4}'),
  ('{"nom": "pain", "emission": 76}');

-- Insertion des entrées
INSERT INTO entree (name, ingredient) VALUES
  ('légumes à la grecque', '{"légume de saison": 53.4, "huile d''olive (1/2 cuillérée)": 18.2}'),
  ('tzatziki', '{"yaourt": 360, "concombre": 129, "huile d''olive (1/2 cuillérée)": 18.2}'),
  ('soupe de légumes', '{"légume de saison": 53.4, "huile ½ cuillérée": 15.1}');

-- Insertion des plats
INSERT INTO plat (name, ingredient) VALUES
  ('poulet au riz', '{"poulet": 774, "riz": 84.6, "beurre": 94.9}'),
  ('bifteck-frite', '{"bifteck": 5370, "frite": 260}'),
  ('omelette aux pommes de terre', '{"deux œufs": 276.7, "pomme de terre": 15.5, "huile ½ cuillérée": 17.1}');

-- Insertion des desserts
INSERT INTO dessert (name, ingredient) VALUES
  ('plateau de fromage', '{"fromage à pâte molle": 107, "fromage à pâte dure": 140, "pain": 76}'),
  ('tarte aux poires', '{"farine": 46.9, "poire": 71, "huile (1 cuillère)": 32.3}'),
  ('salade de fruits', '{"fruits de saison": 53.4, "pain": 76}');

-- Insertion des menus
INSERT INTO menu (name, entree_id, plat_id, dessert_id) VALUES
  ('Repas classique', 1, 1, 1),
  ('Repas classique bis', 2, 2, 2),
  ('Repas végétarien', 3, 3, 3);


----- Question 1
EXPLAIN ANALYZE
SELECT data->>'nom' AS nom_ingredient, data->>'emission' AS empreinte_carbone
FROM ingredient
WHERE data->>'nom' = 'farine';


--- Question 2 
EXPLAIN ANALYZE
SELECT p.name AS nom_plat, 
i.data->>'nom' AS nom_ingredient, 
i.data->>'emission' AS empreinte_carbone
FROM plat p
JOIN ingredient i ON i.data->>'nom' = ANY(SELECT jsonb_object_keys(p.ingredients))
WHERE p.name = 'omelette aux pommes de terre';

-- Question 3 
EXPLAIN ANALYZE
SELECT m.name AS nom_menu, p.name AS nom_plat, i.data->>'nom' AS nom_ingredient, i.data->>'emission' AS empreinte_carbone
FROM menu m
JOIN plat p ON p.id = m.plat_id
JOIN ingredient i ON i.data->>'nom' = ANY(SELECT jsonb_object_keys(p.ingredients));
--WHERE m.name = 'Repas classique';

--- Question 4 :
EXPLAIN ANALYZE
SELECT p.name AS nom_plat, i.data->>'nom' AS nom_ingredient, i.data->>'emission' AS empreinte_carbone
FROM plat p
JOIN ingredient i ON i.data->>'nom' = ANY(SELECT jsonb_object_keys(p.ingredients))
WHERE i.data->>'nom' = 'frite';

--- Question 5 :
-- Ingrédients ayant la plus faible empreinte carbone
EXPLAIN ANALYZE
SELECT data->>'nom' AS nom_ingredient, data->>'emission' AS empreinte_carbone
FROM ingredient
WHERE data->>'emission' = (SELECT MIN(data->>'emission') FROM ingredient);

-- Plats ayant la plus faible empreinte carbone
EXPLAIN ANALYZE
SELECT p.name AS nom_plat, i.data->>'nom' AS nom_ingredient, i.data->>'emission' AS empreinte_carbone
FROM plat p
JOIN ingredient i ON i.data->>'nom' = ANY(SELECT jsonb_object_keys(p.ingredient))
WHERE i.data->>'emission' = (SELECT MIN(data->>'emission') FROM ingredient);

-- Menus ayant la plus faible empreinte carbone
EXPLAIN ANALYZE
SELECT m.name AS nom_menu, p.name AS nom_plat, i.data->>'nom' AS nom_ingredient, i.data->>'emission' AS empreinte_carbone
FROM menu m
JOIN plat p ON p.id = m.plat_id
JOIN ingredient i ON i.data->>'nom' = ANY(SELECT jsonb_object_keys(p.ingredient))
WHERE i.data->>'emission' = (SELECT MIN(data->>'emission') FROM ingredient);

-- Ingrédients ayant une empreinte carbone inférieure à un seuil donné
EXPLAIN ANALYZE
SELECT data->>'nom' AS nom_ingredient, data->>'emission' AS empreinte_carbone
FROM ingredient
WHERE (data->>'emission')::numeric < 50
UNION ALL
SELECT p.name AS nom_plat, (i.data->>'emission')::text AS empreinte_carbone
FROM plat p
JOIN ingredient i ON i.data->>'nom' = ANY(SELECT jsonb_object_keys(p.ingredients))
WHERE (i.data->>'emission')::numeric < 500
UNION ALL
SELECT m.name AS nom_menu, (i.data->>'emission')::text AS empreinte_carbone
FROM menu m
JOIN plat p ON p.id = m.plat_id
JOIN ingredient i ON i.data->>'nom' = ANY(SELECT jsonb_object_keys(p.ingredients))
WHERE (i.data->>'emission')::numeric < 550;


