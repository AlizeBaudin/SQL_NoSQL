---- table JSON ingredient
CREATE TABLE ingredient (
    nom TEXT PRIMARY KEY,
    empreinte_carbone FLOAT,
    data JSONB
);

--- création des tables JSON plat
CREATE TABLE entree (
    id INT PRIMARY KEY,
    nom TEXT,
    empreinte_carbone FLOAT,
    data JSONB
);
CREATE TABLE plat (
    id INT PRIMARY KEY,
    nom TEXT,
    empreinte_carbone FLOAT,
    data JSONB
);
CREATE TABLE dessert (
    id INT PRIMARY KEY,
    nom TEXT,
    empreinte_carbone FLOAT,
    data JSONB
);

--- Table JSON repas
CREATE TABLE repas (
    id INT PRIMARY KEY,
    nom TEXT,
    empreinte_carbone FLOAT,
    data JSONB
);


---- les table de jointures

CREATE TABLE entree_ingredient (
    id SERIAL PRIMARY KEY,
    ingredient_nom TEXT REFERENCES ingredient (nom),
    entree_id INT REFERENCES entree (id)
);

CREATE TABLE plat_ingredient (
    id SERIAL PRIMARY KEY,
    ingredient_nom TEXT REFERENCES ingredient (nom),
    plat_id INT REFERENCES plat (id)
);

CREATE TABLE dessert_ingredient (
    id SERIAL PRIMARY KEY,
    ingredient_nom TEXT REFERENCES ingredient (nom),
    dessert_id INT REFERENCES dessert (id)
);


--- détailes des repas 
CREATE TABLE repas_complet (
    id SERIAL PRIMARY KEY,
    entree_id INT REFERENCES entree (id),
	plat_id INT REFERENCES plat (id),
	dessert_id INT REFERENCES dessert (id),
    repas_id INT REFERENCES repas (id)
);



------ remplissage des tables
INSERT INTO ingredient (nom, empreinte_carbone, data)
VALUES ('legume_de_saison', 53.4, '{"type": "légume", "catégorie": "de saison"}'),
       ('huile', 18.2, '{"type": "huile", "catégorie": "général"}'),
       ('poulet', 774, '{"type": "viande", "catégorie": "poulet"}'),
       ('riz', 84.6, '{"type": "céréale", "catégorie": "de base"}'),
       ('beurre', 94.9, '{"type": "produit laitier", "catégorie": "beurre"}'),
       ('fromage_a_pate_molle', 107, '{"type": "produit laitier", "catégorie": "fromage à pâte molle"}'),
       ('fromage_a_pate_dure', 140, '{"type": "produit laitier", "catégorie": "fromage à pâte dure"}'),
       ('pain', 76, '{"type": "céréale", "catégorie": "pain"}'),
       ('yaourt', 360, '{"type": "produit laitier", "catégorie": "yaourt"}'),
       ('concombre', 129, '{"type": "légume", "catégorie": "concombre"}'),
       ('bifteck', 5370, '{"type": "viande", "catégorie": "bœuf"}'),
       ('frite', 260, '{"type": "accompagnement", "catégorie": "frites"}'),
       ('farine', 46.9, '{"type": "céréale", "catégorie": "farine"}'),
       ('poire', 71, '{"type": "fruit", "catégorie": "poire"}'),
       ('huile_cuilleree', 32.3, '{"type": "huile", "catégorie": "cuillère à soupe"}'),
       ('huile_demi_cuilleree', 15.1, '{"type": "huile", "catégorie": "demi cuillère à soupe"}'),
       ('deux_oeufs', 276.7, '{"type": "œuf", "catégorie": "deux"}'),
       ('pomme_de_terre', 15.5, '{"type": "légume", "catégorie": "pomme de terre"}'),
       ('huile_demi_cuil_vegan', 17.1, '{"type": "huile", "catégorie": "demi cuillère à soupe végétalienne"}'),
       ('fruits_saison', 53.4, '{"type": "fruit", "catégorie": "de saison"}');

-- Insertion des entrées
INSERT INTO entree (id, nom, empreinte_carbone, data)
VALUES (11, 'legumes_a_la_grecque', 71.6, '{"type": "entrée", "catégorie": "légumes à la grecque"}'),
	   (21, 'tzatziki', 507.2, '{"type": "entrée", "catégorie": "tzatziki"}'),
	   (31, 'soupe_de_legume', 68.5, '{"type": "entrée", "catégorie": "soupe de légume"}');

-- Insertion des ingrédients pour les entrées
INSERT INTO entree_ingredient (entree_id, ingredient_nom)
VALUES
  (21, 'legume_de_saison'),
  (21, 'huile'),
  (11, 'legume_de_saison'),
  (11, 'huile_demi_cuilleree'),
  (31, 'yaourt'),
  (31, 'concombre'),
  (31, 'huile');
  
  
-- Insertion des plats
INSERT INTO plat (id, nom, empreinte_carbone, data)
VALUES 
  (12, 'omelette_pomme_de_terre', 309.3, '{"type": "plat", "catégorie": "omelette aux pommes de terre"}'),
  (22, 'poulet_au_riz', 952.1, '{"type": "plat", "catégorie": "poulet au riz"}'),
  (32, 'bifteck_frite', 5630, '{"type": "plat", "catégorie": "bifteck et frites"}');

-- Insertion des ingrédients pour les plats
INSERT INTO plat_ingredient (plat_id, ingredient_nom)
VALUES
  (22, 'poulet'),
  (22, 'riz'),
  (22, 'beurre'),
  (12, 'deux_oeufs'),
  (12, 'pomme_de_terre'),
  (12, 'huile_demi_cuil_vegan'),
  (32, 'bifteck'),
  (32, 'frite');
  
  
  
-- Insertion des desserts
INSERT INTO dessert (id, nom, empreinte_carbone, data)
VALUES 
  (23, 'plateau_de_fromage', 323, '{"type": "dessert", "catégorie": "plateau de fromage"}'),
  (13, 'salade_de_fruit', 129.4, '{"type": "dessert", "catégorie": "salade de fruit"}'),
  (33, 'tarte_poire', 153.1, '{"type": "dessert", "catégorie": "tarte à la poire"}');

-- Insertion des ingrédients pour les desserts
INSERT INTO dessert_ingredient (dessert_id, ingredient_nom)
VALUES
  (23, 'fromage_a_pate_molle'),
  (23, 'fromage_a_pate_dure'),
  (23, 'pain'),
  (13, 'fruits_saison'),
  (13, 'pain'),
  (33, 'farine'),
  (33, 'poire'),
  (33, 'huile_cuilleree');


-- Insertion des repas
INSERT INTO repas (id, nom, empreinte_carbone, data)
VALUES 
  (1, 'repas_vegetarien', 510, '{"type": "repas", "catégorie": "repas végétarien"}'),
  (2, 'repas_classique', 1350, '{"type": "repas", "catégorie": "repas classique"}'),
  (3, 'repas_classique_bis', 6290, '{"type": "repas", "catégorie": "repas classique bis"}');

-- Insertion des associations repas-plat-dessert-entrée
INSERT INTO repas_complet (repas_id, entree_id, plat_id, dessert_id)
VALUES
  (1, 11, 12, 13), -- repas végétarien et ses plats
  (2, 21, 22, 23), -- repas classique et ses plats
  (3, 31, 32, 33); -- repas classique bis et ses plats




---- les requêtes JSON
--------------------------------- Question 1 : 
-- Sélectionner l'empreinte carbone de tous les ingrédients
EXPLAIN SELECT jsonb_build_object('empreinte_carbone', empreinte_carbone) AS data
FROM ingredient;
-- Sélectionner l'empreinte carbone d'un ingrédient spécifique 
EXPLAIN SELECT jsonb_build_object('empreinte_carbone', empreinte_carbone) AS data
FROM ingredient
WHERE nom = 'poire';


--------------------------------- Question 2 : 
EXPLAIN ANALYZE SELECT jsonb_build_object(
           'nom_plat', plat.nom,
           'empreinte_carbone_plat', plat.empreinte_carbone,
           'nom_ingredient', ingredient.nom,
           'empreinte_carbone_ingredient', ingredient.empreinte_carbone
       ) AS data
FROM plat
JOIN plat_ingredient ON plat.id = plat_ingredient.plat_id
JOIN ingredient ON plat_ingredient.ingredient_nom = ingredient.nom
WHERE plat.nom = 'omelette_pomme_de_terre';



--------------------------------- Question 3 : 
EXPLAIN ANALYZE SELECT jsonb_build_object(
           'nom_repas', repas.nom,
           'nom_plat', plat.nom,
           'empreinte_carbone_plat', plat.empreinte_carbone
       ) AS data
FROM repas_complet AS rp
JOIN repas ON repas.id = rp.repas_id
JOIN plat ON plat.id = rp.plat_id;


--------------------------------- Question 4 : 
EXPLAIN ANALYZE SELECT json_build_object(
    'nom_plat', plat.nom,
    'empreinte_carbone', plat.empreinte_carbone
) AS json_result
FROM plat 
JOIN plat_ingredient ON plat_ingredient.plat_id = plat.id
JOIN ingredient ON ingredient.nom = plat_ingredient.ingredient_nom
WHERE ingredient.nom = 'frite';


--------------------------------- Question 5 : 
EXPLAIN ANALYZE SELECT json_build_object(
    'nom_ingredient', ingredient.nom,
    'empreinte_carbone', ingredient.empreinte_carbone,
	'type', 'ingredient'
) AS data
FROM ingredient 
WHERE ingredient.empreinte_carbone < 50
UNION ALL
SELECT json_build_object(
    'nom_plat', plat.nom,
    'empreinte_carbone', plat.empreinte_carbone,
    'type', 'plat'
) AS data
FROM plat 
WHERE plat.empreinte_carbone < 500
UNION ALL
SELECT json_build_object(
    'nom_menu', repas.nom,
    'empreinte_carbone', repas.empreinte_carbone,
    'type', 'menu'
) AS data
FROM repas
WHERE repas.empreinte_carbone < 550;





