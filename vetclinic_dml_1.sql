/*Las siguientes consultas sirven para insertar
datos en las distintas tablas de la DB, en orden*/


USE vetclinic;

/*Llenado de la tabla doctors*/
INSERT INTO doctors (name, phone, email) VALUES
('Dr. Juan Zapata','8097654321','drzapata@vetclinic.com'),
('Dra. Andrea Hidalgo','8297551423','drahidalgo@vetclinic.com'),
('Dr. Nicolás Hernández','8095879669','drhernandez@vetclinic.com'),
('Dr. Néstor Santana','8493589896','drsantana@vetclinic.com'),
('Dra. Carmen Páez','8292586699','drapaez@vetclinic.com'),
('Dra. Estebanía Araujo','8493351225','draaraujo@vetclinic.com'),
('Dr. Claudio Mella','8099987854','drmella@vetclinic.com'),
('Dra. Sara Ramírez','8292741245','draramirez@vetclinic.com'),
('Dr. Miguel Caamaño','8093698995','drcaamano@vetclinic.com'),
('Dra. Teresa Alcantara','8293361425','draalcantara@vetclinic.com'),
('Dra. Nancy Ortega','8098851423','draortega@vetclinic.com');


/*Llenado de la tabla doctors*/
INSERT INTO clients (name, phone, email) VALUES
('Vidal Santana','8097654321','vsantana@gmail.com'),
('Santan Castro','8297551423','scastro@outlook.com'),
('César Arturo Pinales','8095879669','cpinales@hotmail.com'),
('Yokairy Candelario','8493589896','ycandelario@gmail.com'),
('Sorible Castillo','8292586699','scastillo@gmail.com'),
('Yomar Campos','8493351225','ycampos@gmail.com'),
('John Mariñez','8099987854','ymarinez@outlook.com'),
('Casandra Tavárez','8292741245','ctavarez@gmail.com'),
('Tamairys Mateo','8093698995','tmateo@hotmail.com'),
('Tania Masiel Durán','8293361425','tmduran@gmail.com'),
('Antonio Santos','8093325445','asantos@gmail.com'),
('Andrés López','8098851423','alopez@gmail.com');



/*Llenado de la tabla pets*/

INSERT INTO pets (name, age, specie, client_id) VALUES
('Bartolito', 2, 'loro',1),
('Lola',3,'gato',3),
('Percherón',3,'perro',2),
('Bunny',1,'conejo',4),
('Beto',4,'perro',5),
('Nemo',1,'pez',6),
('Tom',2,'hamster',7),
('Petete',3,'loro',8),
('Conrad',5,'otro',9),
('Pinto',3,'perro',10),
('Nenín',4,'gato',11),
('Piolín',2,'otro',12);



INSERT INTO consults (_day, _from, _to, reason, cost, status, notes, 
pet_id, doctor_id) VALUES 
('2023-01-14','09:45','10:30', 
'Rutina', 750,'pendiente','Ninguna', 1,10),
('2023-12-11','10:30','11:15', 
'Rutina', 750,'realizada','Cita mensual', 3,6),
('2023-12-08','09:15','10:00', 
'Rutina', 750,'realizada','Ninguna', 9,2),
('2023-12-09','10:00','10:45', 
'Vacunación', 700,'realizada','Ninguna', 10,1),
('2023-01-14','10:45','11:30', 
'Seguimiento', 600,'pendiente','Verificar resultados de tratamiento', 2,9),
('2023-01-16','09:30','10:15', 
'Rutina', 750,'pendiente','Cita mensual', 3,8),
('2023-01-16','10:30','11:15', 
'Rutina', 750,'pendiente','Cita mensual', 4,7),
('2023-01-22','09:00','09:30', 
'Vacunación', 700,'pendiente','Vacuna trimestral', 5,6),
('2023-01-22','10:15','11:00', 
'Vacunación', 700,'pendiente','Primera vacuna', 6,5),
('2023-01-23','09:30','10:30', 
'Desparasitación', 800,'pendiente','Cambiar medicamento', 7,4),
('2023-01-23','09:30','10:30', 
'Desparasitación', 800,'pendiente','Ninguna', 8,3)
; 



INSERT INTO cartillas (pet_id, weight, height, status, notes) VALUES
(1, 0.3, 8, 'sano', 'Es un loro muy alegre'),
(2,4,20,'sano','Le cambiaron la alimentación'),
(3,14,40,'enfermo','Tiene una patita herida'),
(4,6,19,'sano','Falta vacuna'),
(5,16,46,'sano','Ninguna'),
(6,1,8,'sano','Hay que cambiarle la pecera'),
(7,2,16,'enfermo','No gira en su rueda'),
(8,0.7,8,'enfermo','Tiene una patita herida'),
(9,4,25,'sano','Falta una vacuna'),
(10,14,34,'sano','Ninguna'),
(11,8,20,'sano','Cambiar medicinas'),
(12,4,12,'sano','Ninguna');


/*Consulta de cada tabla*/
SELECT * FROM doctors;
SELECT * FROM clients;
SELECT * FROM pets;
SELECT * FROM consults;
SELECT * FROM cartillas;

/*Lista de mascotas con sus dueños y sus detalles*/
SELECT pet.name AS Mascota, pet.specie AS Tipo, pet.age AS Edad,
cart.weight AS Peso, cart.height AS Medida, cart.status AS Estado,
clt.name AS Dueño, clt.phone AS Teléfono, clt.email AS Correo
FROM pets pet LEFT JOIN clients clt ON pet.client_id=clt.id
LEFT JOIN cartillas cart ON cart.pet_id=pet.id ORDER BY pet.name;


/*Lista de consultas de cada mascota, con su doctor*/
SELECT pet.name AS Mascota, cons._day AS Fecha, doc.name AS Doctor,
cons._from AS Desde, cons._to AS Hasta,
cons.reason AS Motivo, cons.cost AS Costo, cons.status AS Estado
FROM pets pet RIGHT JOIN consults cons on cons.pet_id=pet.id
LEFT JOIN doctors doc on cons.doctor_id=doc.id
