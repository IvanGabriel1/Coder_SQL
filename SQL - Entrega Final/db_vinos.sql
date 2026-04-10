CREATE DATABASE db_vinos;

USE db_vinos;

CREATE TABLE provincia (
id INT AUTO_INCREMENT,
provincia VARCHAR(100) NOT NULL,
PRIMARY KEY (id),
INDEX idx_provincia_nombre (provincia)
);

CREATE TABLE bodega (
id INT AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
id_provincia INT NOT NULL,
anio_fundacion INT,

PRIMARY KEY(id),
INDEX idx_bodega_nombre (nombre),
INDEX idx_anio_fundacion (anio_fundacion),
FOREIGN KEY (id_provincia) REFERENCES provincia(id)
);

CREATE TABLE cepa (
id INT AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,

PRIMARY KEY (id),
INDEX idx_cepa_nombre (nombre)
);

CREATE TABLE region (
id INT AUTO_INCREMENT,
id_provincia INT NOT NULL,
region VARCHAR(80) NOT NULL,

PRIMARY KEY (id),
INDEX idx_region_nombre (region),
FOREIGN KEY (id_provincia) REFERENCES provincia(id)
);

CREATE TABLE estilo_de_vino (
id INT AUTO_INCREMENT,
estilo VARCHAR(60) NOT NULL,

PRIMARY KEY(id),
INDEX idx_estilo (estilo)
);

CREATE TABLE vino (
id INT AUTO_INCREMENT,
nombre VARCHAR(150) NOT NULL,
id_bodega INT NOT NULL,
id_region INT NOT NULL,
id_estilo INT NOT NULL,
anio INT NOT NULL,
potencial INT NOT NULL,
tiempo_madera INT NOT NULL,
tiempo_concreto INT NOT NULL,
precio DECIMAL(10,2),

PRIMARY KEY (id),
FOREIGN KEY (id_bodega) REFERENCES bodega(id),
FOREIGN KEY (id_region) REFERENCES region(id),
FOREIGN KEY (id_estilo) REFERENCES estilo_de_vino(id),

INDEX idx_vino_nombre (nombre),
INDEX idx_vino_anio (anio),
INDEX idx_vino_potencial (potencial),
INDEX idx_vino_madera (tiempo_madera),
INDEX idx_vino_concreto (tiempo_concreto),
INDEX idx_precio (precio)
);

CREATE TABLE vino_cepa_region (
id INT AUTO_INCREMENT,
id_vino INT NOT NULL,
id_cepa INT NOT NULL,
id_region INT NOT NULL,
porcentaje DECIMAL(5,2),

PRIMARY KEY (id),
FOREIGN KEY (id_vino) REFERENCES vino(id),
FOREIGN KEY (id_cepa) REFERENCES cepa(id),
FOREIGN KEY (id_region) REFERENCES region(id),
UNIQUE uq_vino_cepa_region (id_vino, id_cepa, id_region)
);

-- ----------------------------------
-- ----------------------------------
-- ----------------------------------

USE db_vinos;

INSERT INTO provincia (provincia) VALUES
("Mendoza"),
("Salta"),
("San Juan"),
("Rio Negro"),
("Neuquen");

INSERT INTO bodega (nombre, id_provincia, anio_fundacion) VALUES
("Catena Zapata", 1, 1902),
("La Rural", 1, 1885),
("Salentein", 1, 1996),
("Zuccardi", 1, 1993),
("Escorihuela Gascón", 1, 1884),
("Colomé", 2, 1831),
("El Esteco", 2, 1892),
("Etchart", 2, 1850),
("Domingo Molina", 2, 1997),
("El Porvenir de Cafayate", 2, 2000),
("Callia", 3, 2000),
("Graffigna", 3, 1870),
("Finca Las Moras", 3, 1998),
("Bodega del Fin del Mundo", 5, 2002),
("Familia Schroeder", 5, 2001),
("Humberto Canale", 4, 1909),
("Bodega Chacra", 4, 2003);

INSERT INTO cepa (nombre) VALUES 
("Malbec"),
("Cabernet Sauvignon"),
("Cabernet Franc"),
("Merlot"),
("Sauvignon Blanc"),
("Bonarda"),
("Chardonnay"),
("Tannat"),
("Pinot Noir"),
("Criolla"), 
("Sangiovese"),
("Petit Verdot"),
("Riesling"),
("Albarinio"),
("Verdejo"),
("Moscatel"),
("Chenin blanc"),
("Tempranillo"),
("Semillon"),
("Pinot Meunier"),
("Syrah");

INSERT INTO region (id_provincia, region) VALUES
(1, 'Luján de Cuyo'),
(1, 'Valle de Uco'),
(1, 'Maipú'),
(1, 'San Rafael'),
(1, 'Este Mendocino'),
(2, 'Cafayate'),
(2, 'Valles Calchaquíes'),
(2, 'Molinos'),
(2, 'Cachi'),
(3, 'Valle de Tulum'),
(3, 'Valle de Zonda'),
(3, 'Valle de Pedernal'),
(3, 'Calingasta'),
(4, 'Alto Valle del Río Negro'),
(4, 'Valle Medio'),
(4, 'General Roca'),
(5, 'San Patricio del Chañar'),
(5, 'Añelo');

INSERT INTO estilo_de_vino (estilo) VALUES 
("Tinto"),
("Blanco"),
("Rosado"),
("Espumante"),
("Naranjo"),
("Cosecha Tardía"),
("Fortificados");

INSERT INTO vino 
(nombre, id_bodega, id_region, id_estilo, anio, potencial, tiempo_madera, tiempo_concreto, precio) VALUES

-- CATENA ZAPATA (1) - Luján / Valle de Uco
('Catena DV Malbec - Malbec', 1, 1, 1, 2021, 15, 12, 0, 28500.00),
('Catena Alta Malbec', 1, 2, 1, 2020, 20, 18, 0, 42000.00),
('Catena DV Chardonnay - Chardonnay', 1, 2, 2, 2022, 8, 6, 0, 21000.00),

-- LA RURAL (2) - Maipú
('Rutini Cabernet Sauvignon', 2, 3, 1, 2020, 15, 12, 0, 25000.00),
('Trumpeter Malbec', 2, 3, 1, 2022, 10, 6, 0, 9500.00),
('Rutini Chardonnay', 2, 3, 2, 2021, 6, 4, 0, 18000.00),

-- SALENTEIN (3) - Valle de Uco
('Salentein Reserva Malbec', 3, 2, 1, 2021, 12, 12, 0, 11000.00),
('Numina Gran Corte', 3, 2, 1, 2019, 18, 16, 0, 22000.00),
('Salentein Brut Nature', 3, 2, 4, 2022, 5, 0, 0, 14000.00),

-- ZUCCARDI (4) - Valle de Uco
('Zuccardi Concreto Malbec', 4, 2, 1, 2022, 12, 0, 12, 29000.00),
('Finca Piedra Infinita', 4, 2, 1, 2020, 20, 18, 0, 140000.00),
('Zuccardi Serie A Torrontés', 4, 2, 2, 2023, 4, 0, 0, 9000.00),

-- ESCORIHUELA GASCON (5) - Luján
('Escorihuela Gascón Gran Reserva Malbec', 5, 1, 1, 2021, 12, 10, 0, 17000.00),
('Pequeñas Producciones Syrah', 5, 1, 1, 2020, 15, 14, 0, 29000.00),

-- COLOMÉ (6) - Molinos
('Colomé Malbec Estate', 6, 8, 1, 2021, 15, 12, 0, 21000.00),
('Colomé Torrontés', 6, 6, 2, 2023, 4, 0, 0, 11000.00),

-- EL ESTECO (7) - Cafayate
('El Esteco Don David Malbec', 7, 6, 1, 2022, 10, 8, 0, 9500.00),
('El Esteco Torrontés', 7, 6, 2, 2023, 4, 0, 0, 8500.00),

-- ETCHART (8) - Cafayate
('Etchart Privado Malbec', 8, 6, 1, 2021, 10, 6, 0, 7200.00),
('Etchart Torrontés', 8, 6, 2, 2023, 3, 0, 0, 6000.00),

-- DOMINGO MOLINA (9) - Cafayate
('Domingo Molina Malbec', 9, 6, 1, 2020, 12, 12, 0, 13000.00),
('Domingo Molina Tannat', 9, 6, 1, 2020, 15, 14, 0, 16000.00),

-- EL PORVENIR (10) - Cafayate
('Amauta Absoluto', 10, 6, 1, 2020, 14, 14, 0, 19000.00),
('Laborum Torrontés', 10, 6, 2, 2023, 4, 0, 0, 9800.00),

-- CALLIA (11) - Valle de Tulum
('Callia Magna Malbec', 11, 10, 1, 2021, 10, 8, 0, 8200.00),
('Callia Alta Syrah', 11, 10, 1, 2020, 12, 10, 0, 9500.00),

-- GRAFFIGNA (12) - Valle de Pedernal
('Graffigna Reserva Malbec', 12, 12, 1, 2021, 12, 12, 0, 11000.00),
('Graffigna Chardonnay', 12, 10, 2, 2022, 6, 4, 0, 9000.00),

-- FINCA LAS MORAS (13) - Pedernal
('Las Moras Black Label', 13, 12, 1, 2020, 14, 14, 0, 12500.00),
('Las Moras Sauvignon Blanc', 13, 10, 2, 2023, 3, 0, 0, 7500.00),

-- FIN DEL MUNDO (14) - San Patricio del Chañar
('Fin del Mundo Reserva Malbec', 14, 17, 1, 2021, 12, 10, 0, 10500.00),
('Fin del Mundo Reserva Pinot Noir', 14, 17, 1, 2022, 8, 6, 0, 9800.00),

-- FAMILIA SCHROEDER (15) - San Patricio
('Saurus Pinot Noir', 15, 17, 1, 2022, 8, 6, 0, 11500.00),
('Saurus Barrel Fermented', 15, 17, 2, 2021, 6, 6, 0, 14000.00),

-- HUMBERTO CANALE (16) - General Roca
('Humberto Canale Estate Malbec', 16, 16, 1, 2021, 10, 8, 0, 16000.00),
('Old Vineyard Pinot Noir', 16, 14, 1, 2020, 12, 10, 0, 29000.00),

-- BODEGA CHACRA (17) - Alto Valle
('Chacra 32 Pinot Noir', 17, 14, 1, 2020, 18, 12, 0, 120000.00),
('Chacra Chardonnay', 17, 14, 2, 2022, 10, 8, 0, 55000.00);

INSERT INTO vino 
(nombre, id_bodega, id_region, id_estilo, anio, potencial, tiempo_madera, tiempo_concreto, precio) VALUES

-- CATENA ZAPATA (1)
('Angelica Zapata Cabernet Franc', 1, 2, 1, 2021, 15, 14, 0, 35000.00),
('DV Catena Tinto Histórico', 1, 1, 1, 2020, 18, 16, 0, 36000.00),
('Angelica Zapata Malbec', 1, 1, 1, 2019, 20, 18, 0, 44000.00),

-- LA RURAL (2)
('Rutini Apartado Malbec', 2, 3, 1, 2019, 20, 18, 0, 92000.00),
('Trumpeter Rosado de Malbec', 2, 3, 3, 2023, 3, 0, 0, 7800.00),

-- SALENTEIN (3)
('Primus Pinot Noir', 3, 2, 1, 2021, 10, 10, 0, 59000.00),
('Salentein Reserva Sauvignon Blanc', 3, 2, 2, 2023, 4, 0, 0, 13000.00),

-- ZUCCARDI (4)
('Zuccardi Q Malbec', 4, 2, 1, 2021, 14, 12, 0, 21000.00),
('Zuccardi Polígonos San Pablo', 4, 2, 1, 2020, 18, 14, 6, 48000.00),
('Zuccardi Naranjo de Altura', 4, 2, 5, 2022, 6, 0, 8, 17500.00),

-- ESCORIHUELA GASCON (5)
('Escorihuela Cabernet Sauvignon', 5, 1, 1, 2021, 12, 10, 0, 16500.00),
('Gascón Extra Brut', 5, 1, 4, 2022, 5, 0, 0, 13500.00),

-- COLOMÉ (6)
('Colomé Auténtico Malbec', 6, 8, 1, 2021, 14, 0, 12, 26000.00),
('Colomé Altura Máxima', 6, 8, 1, 2019, 25, 18, 0, 125000.00),

-- EL ESTECO (7)
('El Esteco Old Vines 1945', 7, 6, 1, 2020, 18, 16, 0, 28000.00),
('El Esteco Cosecha Tardía', 7, 6, 6, 2023, 8, 0, 0, 12000.00),

-- ETCHART (8)
('Etchart Privado Tannat', 8, 6, 1, 2021, 12, 10, 0, 9800.00),
('Etchart Torrontés Reserva', 8, 6, 2, 2022, 5, 4, 0, 8500.00),

-- DOMINGO MOLINA (9)
('Domingo Molina Cabernet Sauvignon', 9, 6, 1, 2020, 14, 12, 0, 15000.00),
('Domingo Molina Rosado', 9, 6, 3, 2023, 3, 0, 0, 8200.00),

-- EL PORVENIR (10)
('Laborum Malbec', 10, 6, 1, 2021, 12, 10, 0, 11500.00),
('Amauta Torrontés', 10, 6, 2, 2023, 4, 0, 0, 8900.00),

-- CALLIA (11)
('Callia Dolce', 11, 10, 7, 2022, 15, 12, 0, 14000.00),
('Callia Rosado', 11, 10, 3, 2023, 3, 0, 0, 6500.00),

-- GRAFFIGNA (12)
('Graffigna Gran Reserva', 12, 12, 1, 2019, 18, 16, 0, 24000.00),
('Graffigna Espumante Brut', 12, 10, 4, 2022, 5, 0, 0, 9500.00),

-- FINCA LAS MORAS (13)
('Las Moras Dadá Art Wine', 13, 12, 1, 2021, 8, 6, 0, 7800.00),
('Las Moras Cosecha Tardía', 13, 10, 6, 2023, 6, 0, 0, 7200.00),

-- FIN DEL MUNDO (14)
('Special Blend Fin del Mundo', 14, 17, 1, 2020, 16, 14, 0, 19000.00),
('Fin del Mundo Reserva Chardonnay', 14, 17, 2, 2022, 8, 6, 0, 12500.00),

-- FAMILIA SCHROEDER (15)
('Saurus Select Malbec', 15, 17, 1, 2021, 12, 12, 0, 14500.00),
('Saurus Extra Brut', 15, 17, 4, 2022, 5, 0, 0, 13000.00),

-- HUMBERTO CANALE (16)
('Humberto Canale Gran Reserva', 16, 14, 1, 2019, 20, 18, 0, 32000.00),
('Canale Cosecha Tardía', 16, 16, 6, 2023, 6, 0, 0, 10500.00),

-- BODEGA CHACRA (17)
('Chacra Rosé Pinot Noir', 17, 14, 3, 2023, 4, 0, 0, 29000.00);

INSERT INTO vino_cepa_region (id_vino, id_cepa, id_region, porcentaje) VALUES

-- 100% MALBEC
(1,1,1,100.00),
(2,1,2,100.00),
(5,1,3,100.00),
(7,1,2,100.00),
(10,1,2,100.00),
(13,1,1,100.00),
(15,1,8,100.00),
(17,1,6,100.00),
(19,1,6,100.00),
(21,1,6,100.00),
(25,1,10,100.00),
(27,1,12,100.00),
(31,1,17,100.00),
(35,1,16,100.00),
(41,1,1,100.00),
(46,1,2,100.00),
(51,1,8,100.00),
(52,1,8,100.00),
(59,1,6,100.00),
(69,1,17,100.00),

-- 100% CABERNET SAUVIGNON
(4,2,3,100.00),
(49,2,1,100.00),
(57,2,6,100.00),

-- 100% CABERNET FRANC
(39,3,2,100.00),

-- 100% CHARDONNAY
(3,7,2,100.00),
(6,7,3,100.00),
(28,7,10,100.00),
(38,7,14,100.00),
(68,7,17,100.00),

-- 100% SAUVIGNON BLANC
(30,5,10,100.00),
(45,5,2,100.00),

-- 100% TANNAT
(22,8,6,100.00),
(55,8,6,100.00),

-- 100% PINOT NOIR
(32,9,17,100.00),
(33,9,17,100.00),
(36,9,14,100.00),
(37,9,14,100.00),
(44,9,2,100.00),

-- 100% SYRAH
(14,21,1,100.00),
(26,21,10,100.00),

-- 100% ROSADOS (Malbec base)
(43,1,3,100.00),
(58,1,6,100.00),
(62,1,10,100.00),
(73,9,14,100.00),

-- 100% COSECHA TARDIA (asumimos Moscatel / Chenin)
(54,16,6,100.00),
(66,17,10,100.00),
(72,17,16,100.00),

-- ESPUMANTES (blend clásico)
(9,7,2,60.00),
(9,9,2,40.00),

(50,7,1,50.00),
(50,9,1,30.00),
(50,20,1,20.00),

(64,7,10,60.00),
(64,9,10,40.00),

(70,7,17,60.00),
(70,9,17,40.00),

-- BLENDS / GRAN CORTE

-- Numina Gran Corte (Malbec 40, CS 30, Merlot 20, Petit Verdot 10)
(8,1,2,40.00),
(8,2,2,30.00),
(8,4,2,20.00),
(8,12,2,10.00),

-- Finca Piedra Infinita (Malbec dominante)
(11,1,2,85.00),
(11,12,2,15.00),

-- Amauta Absoluto
(23,1,6,50.00),
(23,2,6,30.00),
(23,4,6,20.00),

-- Rutini Apartado Malbec
(42,1,3,70.00),
(42,2,3,20.00),
(42,12,3,10.00),

-- Zuccardi Polígonos
(47,1,2,90.00),
(47,12,2,10.00),

-- Special Blend Fin del Mundo
(67,1,17,50.00),
(67,2,17,30.00),
(67,21,17,20.00),

-- Graffigna Gran Reserva
(63,1,12,60.00),
(63,2,12,30.00),
(63,4,12,10.00),

-- Humberto Canale Gran Reserva
(71,9,14,60.00),
(71,1,14,40.00),

-- Las Moras Black Label
(29,1,12,70.00),
(29,2,12,30.00),

-- Las Moras Dadá
(65,1,12,60.00),
(65,21,12,40.00);

-- ---------------------------------------------------------
-- ---------------------------------------------------------
-- ---------------------------------------------------------

USE db_vinos;

-- Vista 1 Filtra vinos de mendoza:
CREATE VIEW VistaVinosMendocinos AS SELECT
v.id,
v.nombre,
v.precio,
r.region,
p.provincia
FROM vino v
JOIN region r ON v.id_region = r.id
JOIN provincia p ON r.id_provincia = p.id
WHERE p.provincia = "Mendoza" 
ORDER BY v.precio ASC;

SELECT * FROM VistaVinosMendocinos;

-- Chequeo cantidad de vinos de mendoza: 26
 SELECT COUNT(*) AS cantidadVinos FROM VistaVinosMendocinos;

-- Chequeo cantidad de vinos por provincia. (Mendoza: 26)
SELECT p.provincia, COUNT(*) AS cantidad_vinos
FROM vino v
JOIN region r ON v.id_region = r.id
JOIN provincia p ON r.id_provincia = p.id
GROUP BY p.provincia;

-- Vista 2: Promedio de precio de la base de datos.
CREATE VIEW vistaPrecioPromedio AS 
SELECT 
COUNT(v.precio) AS CantidadVinos,
ROUND(AVG(v.precio)) AS precioPromedio
FROM vino v;

SELECT * FROM vistaPrecioPromedio;

-- Vista 3: Vinos blend. 
CREATE VIEW vistaVinosBlend AS 
SELECT
v.id,
v.nombre AS vino,
v.precio,
b.nombre AS bodega,
COUNT(DISTINCT vcr.id_cepa) AS cantidad_cepas,
GROUP_CONCAT(DISTINCT c.nombre ORDER BY c.nombre SEPARATOR ", ") AS cepas
FROM vino v
JOIN vino_cepa_region vcr ON v.id = vcr.id_vino
JOIN bodega b ON v.id_bodega = b.id
JOIN cepa c ON vcr.id_cepa = c.id
GROUP BY v.id, v.nombre, v.precio, b.nombre
HAVING COUNT(DISTINCT vcr.id_cepa) > 1
ORDER BY v.precio ASC;

SELECT * FROM vistaVinosBlend;

-- Vista 4: Vinos Espumantes (id = 4)
CREATE VIEW vistaVinosEspumantes AS SELECT
v.nombre,
v.precio,
e.estilo
FROM vino v
JOIN estilo_de_vino e ON v.id_estilo = e.id
WHERE e.estilo = "Espumante"
ORDER BY v.precio ASC;

SELECT * FROM vistaVinosEspumantes;

-- Vista 5:  Vinos ordenados por mayor potencial de guarda.
CREATE VIEW vistaVinosConMasPotencial AS SELECT
v.nombre,
v.precio,
v.potencial,
b.nombre AS bodega,
r.region
FROM vino v
JOIN bodega b ON v.id_bodega = b.id
JOIN region r ON v.id_region = r.id
WHERE v.potencial >= 10
ORDER BY v.potencial DESC;

SELECT * FROM vistaVinosConMasPotencial;

-- ---------------------------------------------------
-- ---------------------------------------------------
-- ---------------------------------------------------


 SELECT * FROM bodega;
 USE db_vinos;

 -- Funcion donde la pasamos el id de la bodega y devuelve el promedio de precios de los vinos de esa bodega que tenemos en la base de datos.
DELIMITER //
CREATE FUNCTION fn_precio_promedio_bodega (parametro_bodega INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE valorRetorno DECIMAL(10,2);

SELECT AVG(precio) INTO valorRetorno
FROM vino
WHERE id_bodega = parametro_bodega;

RETURN valorRetorno;
END;
//

SELECT fn_precio_promedio_bodega(1);

SELECT nombre, fn_precio_promedio_bodega(3) AS PrecioPromedio
FROM bodega
WHERE id = 3;


-- Función que devuelve el nombre de una bodega a partir de su ID (puede reemplazar un JOIN).
USE db_vinos;

DELIMITER //
CREATE FUNCTION fn_nombre_bodega(parametro_id INT)
RETURNS VARCHAR(80)
DETERMINISTIC
BEGIN

DECLARE valorRetorno VARCHAR(80);

SELECT b.nombre INTO valorRetorno
FROM bodega b 
WHERE b.id = parametro_id;

RETURN valorRetorno;
END;
//

SELECT fn_nombre_bodega(2);

SELECT nombre, fn_nombre_bodega(id_bodega) AS bodega
FROM vino;

-- -------------------------------------------------------
-- -------------------------------------------------------
-- -------------------------------------------------------

-- PROCEDIMIENTOS / STORED PROCEDURES:

-- sp que ordena los vinos, eligiendo que campo de ordenamiento y de que forma (ASC o DESC):
-- Los campos pueden ser id, nombre, id_bodega, id_region, id_estilo, anio, potencial, tiempo_madera, tiempo_concreto o precio.
USE db_vinos;

DELIMITER //
DROP PROCEDURE IF EXISTS sp_ordenar_vinos //
CREATE PROCEDURE sp_ordenar_vinos(
IN _campo VARCHAR(50),
IN _orden VARCHAR(4) )
BEGIN 

DECLARE consulta_dinamica TEXT;

SET @consulta_dinamica = CONCAT('SELECT * FROM vino ORDER BY ', _campo, ' ', _orden);

PREPARE stmt FROM @consulta_dinamica;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END
// 
DELIMITER ; 

CALL sp_ordenar_vinos("tiempo_madera", "DESC");
CALL sp_ordenar_vinos("precio", "ASC");

-- 2)
-- sp para ingresar un nuevo vino a la tabla vino.
-- Parametros: nombre, id_bodega, id_region, id_estilo, año (de la cosecha), potencial (expresado en años), tiempo medera (expresado en meses), tiempo concreto (expresado en meses), precio

DELIMITER //
DROP PROCEDURE IF EXISTS sp_insertar_nuevo_vino //
CREATE PROCEDURE sp_insertar_nuevo_vino (
IN _nombre VARCHAR(100),
IN _id_bodega INT,
IN _id_region INT,
IN _id_estilo INT,
IN _anio INT,
IN _potencial INT,
IN _tiempo_madera INT,
IN _tiempo_concreto INT,
IN _precio DECIMAL(10, 2)
)
BEGIN

INSERT INTO vino(
nombre,
id_bodega,
id_region,
id_estilo,
anio,
potencial,
tiempo_madera,
tiempo_concreto,
precio
)

VALUES(
_nombre,
_id_bodega,
_id_region,
_id_estilo,
_anio,
_potencial,
_tiempo_madera,
_tiempo_concreto,
_precio);

END
//
DELIMITER ;

SELECT * FROM bodega;
SELECT * FROM region;
SELECT * FROM estilo_de_vino;

CALL sp_insertar_nuevo_vino(
'The President Malbec',
5,
2,
1,
2020,
15,
18,
0,
38000
);

SELECT * FROM vino
WHERE id_bodega = 5;

-- ---------------------------------------------
-- ---------------------------------------------
-- ---------------------------------------------

USE db_vinos;

-- Crea usuario user_lectura, solo se conecta de localhost y tiene como contraseña 1234:
CREATE USER 'user_lectura'@'localhost' IDENTIFIED BY '1234';
-- Otorga permisos de lectura 'Select' al usuario sobre todas las tablas de la base de datos db_vinos
GRANT SELECT ON db_vinos.* TO 'user_lectura'@'localhost';


-- Crea usuario user_leeModIns que lee, modifica e inserta datos, solo se conecta de localhost y tiene como contraseña ABCD:
CREATE USER 'user_leeModIns'@'localhost' IDENTIFIED BY 'ABCD';
-- Otorga permisos 'Select', 'Update' y 'Insert' al usuario sobre todas las tablas de la base de datos db_vinos
GRANT SELECT, UPDATE, INSERT  ON db_vinos.* TO 'user_leeModIns'@'localhost';

-- Comprobaciones:
SHOW GRANTS FOR 'user_lectura'@'localhost';
SHOW GRANTS FOR 'user_leeModIns'@'localhost';

-- *************** Separador **************
-- *************** Separador **************
-- *************** Separador **************
 
 
 SET AUTOCOMMIT = 0;
 
 -- Primera Tabla
 START TRANSACTION;
 
 DELETE FROM vino_cepa_region
WHERE id_vino IN (10, 25);
 
 DELETE FROM vino 
 WHERE id IN (10, 25);
 -- ROLLBACK;
 -- COMMIT;
 
 SELECT * FROM vino; -- Comprobamos y usamos ROLLBACK para no eliminar definitivamente los datos.
 
 -- ***********Separador*********
 
 -- Segunda tabla
 START TRANSACTION;
INSERT INTO cepa (nombre) VALUES ('Garnacha');
INSERT INTO cepa (nombre) VALUES ('Nebbiolo');
INSERT INTO cepa (nombre) VALUES ('Barbera');
INSERT INTO cepa (nombre) VALUES ('Zinfandel');

SAVEPOINT actualizacion4;

INSERT INTO cepa (nombre) VALUES ('Carmenere');
INSERT INTO cepa (nombre) VALUES ('Viognier');
INSERT INTO cepa (nombre) VALUES ('Gewurztraminer');
INSERT INTO cepa (nombre) VALUES ('Gruner Veltliner'); 

SAVEPOINT actualizacion8;
 
-- ROLLBACK TO actualizacion4; -- revierte los últimos 4 inserts
-- RELEASE SAVEPOINT actualizacion4; -- elimina el savepoint

SELECT * FROM cepa; -- Para comprobar el funcionamiento de los safepoint

-- ROLLBACK;
-- COMMIT;

SET AUTOCOMMIT = 1;
