CREATE DATABASE db_vinos;

USE db_vinos;

CREATE TABLE provincias (
id INT AUTO_INCREMENT,
provincia VARCHAR(100) NOT NULL,
PRIMARY KEY (id),
INDEX idx_provincia_nombre (provincia)
);

CREATE TABLE bodegas (
id INT AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
id_provincia INT NOT NULL,
anio_fundacion INT,

PRIMARY KEY(id),
INDEX idx_bodega_nombre (nombre),
INDEX idx_anio_fundacion (anio_fundacion),
FOREIGN KEY (id_provincias) REFERENCES provincias(id)
);

CREATE TABLE cepas (
id INT AUTO_INCREMENT,
nombre VARCHAR(50) NOT NULL,

PRIMARY KEY (id),
INDEX idx_cepa_nombre (nombre)
);

CREATE TABLE regiones (
id INT AUTO_INCREMENT,
id_provincia INT NOT NULL,
region VARCHAR(80) NOT NULL,

PRIMARY KEY (id),
INDEX idx_region_nombre (region),
FOREIGN KEY (id_provincia) REFERENCES provincias(id)
);

CREATE TABLE estilos_de_vino (
id INT AUTO_INCREMENT,
estilo VARCHAR(60) NOT NULL,

PRIMARY KEY(id),
INDEX idx_estilo (estilo)
);

CREATE TABLE vinos (
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
FOREIGN KEY (id_bodega) REFERENCES bodegas(id),
FOREIGN KEY (id_region) REFERENCES regiones(id),
FOREIGN KEY (id_estilo) REFERENCES estilos_de_vino(id),

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
FOREIGN KEY (id_vino) REFERENCES vinos(id),
FOREIGN KEY (id_cepa) REFERENCES cepas(id),
FOREIGN KEY (id_region) REFERENCES regiones(id),
UNIQUE uq_vino_cepa_region (id_vino, id_cepa, id_region)
);