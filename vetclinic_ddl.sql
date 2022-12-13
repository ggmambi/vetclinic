/*
Estos scripts sirven para generar la base de datos,
crear las tablas y definir la estructura de la misma.

Deben ser ejecutados todos, en el mismo orden en que
están definidos en este archivo.
*/

USE [master];
GO 
IF DB_ID('vetclinic') IS NOT NULL
BEGIN
	ALTER DATABASE vetclinic SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE vetclinic SET ONLINE;
	DROP DATABASE  vetclinic;
END
GO

/*Creación de la base de datos*/
CREATE DATABASE vetclinic;

GO

USE vetclinic;


/*Tabla para los doctores de la clínica*/
CREATE TABLE doctors (id INT NOT NULL PRIMARY KEY IDENTITY,
name NVARCHAR(50) NOT NULL, phone NVARCHAR(12) NOT 
NULL, email NVARCHAR(50) NOT NULL, created_at DATETIME
NOT NULL DEFAULT CURRENT_TIMESTAMP);

/*Tabla para los dueños de mascota*/
CREATE TABLE clients (id INT NOT NULL PRIMARY KEY IDENTITY,
name NVARCHAR(50) NOT NULL, phone NVARCHAR(12) NOT 
NULL, email NVARCHAR(50) NOT NULL, created_at DATETIME
NOT NULL DEFAULT CURRENT_TIMESTAMP);


/*Tabla para las mascotas*/
CREATE TABLE pets (id INT NOT NULL PRIMARY KEY IDENTITY,
name NVARCHAR(50) NOT NULL, age INT NOT NULL, 
specie NVARCHAR(10) NOT NULL CHECK (specie IN('gato',
'perro', 'loro', 'conejo', 'hamster', 'pez','otro')), 
client_id INT NOT NULL  FOREIGN KEY REFERENCES clients(id),
created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);
GO


/*Tabla para las consultas*/
CREATE TABLE consults (id INT NOT NULL PRIMARY KEY IDENTITY,
_day DATE NOT NULL, _from TIME NOT NULL, _to TIME NOT NULL, 
reason NVARCHAR(150) NOT NULL, cost
DECIMAL (8,2) NOT NULL, 
status NVARCHAR(10) CHECK (status IN('pendiente', 'realizada')), 
notes NVARCHAR(250), pet_id INT NOT NULL FOREIGN 
KEY REFERENCES pets(id), doctor_id INT FOREIGN KEY REFERENCES
doctors(id), created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);
GO

/*Tabla para tarjeta clínica de la mascota*/
CREATE TABLE cartillas (id INT NOT NULL PRIMARY KEY IDENTITY, 
pet_id INT NOT NULL FOREIGN KEY REFERENCES pets(id), weight 
DECIMAL(8,2) NOT NULL, height DECIMAL(8,2) NOT NULL, status 
NVARCHAR(10) CHECK (status IN('sano','enfermo')), notes NVARCHAR(250) 
NOT NULL, created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP);
GO


/*
Relaciones
clients 1:N pets;
pets 1:N consults;
pets 1:N cartillas,
doctors 1:N consults;
*/
