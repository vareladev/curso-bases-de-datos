--1. Mostrar todos los libros que tengan un precio menor a $50. (4%)
--EJERCICIO:
SELECT codLibro, titulo, editorial, fechaEdicion, precio, IdCondicion
FROM libro
WHERE precio < 50;
 
--2. Mostrar los empleados con el departamento al que pertenece (nombre del departamento, no id). (5%)
--EJERCICIO:
SELECT E.idEmpleado, E.nombre, E.direccion, E.fechaIngreso, D.departamento
FROM EMPLEADO E, DEPARTAMENTO D
WHERE E.idDepartamento = D.idDepartamento;
	 
--3. Mostrar el libro con su condición (nombre de la condición, no id) (5%)
--EJERCICIO:
SELECT L.codLibro, L.titulo, L.editorial, L.fechaEdicion, C.condicion
FROM LIBRO L, CONDICION C
WHERE L.IdCondicion = C.idCondicion;

--4. Calcular el detalle de cada orden. (8%)
--EJERCICIO:
SELECT O.idOrden, D.codLibro, L.titulo, L.precio, D.cantidad, L.precio*D.cantidad as precio
FROM ORDEN O, ORDENDETALLE D, LIBRO L
WHERE O.idOrden = D.idOrden AND D.codLibro = L.codLibro;

--5. ¿Qué clientes inscritos aun no compran nada? mostrar estos clientes (utilice joins). (10%)
--EJERCICIO:
SELECT C.idCliente, C.nombre, O.idOrden
FROM ORDEN O RIGHT JOIN CLIENTE C ON O.idCliente = C.idCliente
WHERE O.idOrden IS NULL;

--6. ¿Qué libros en stock no se han vendido ninguna vez? mostrar estos libros (utilice joins). (10%)
--EJERCICIO:
SELECT L.codLibro, L.titulo, L.editorial, L.fechaEdicion, L.precio, L.IdCondicion, O.idOrden
FROM ORDENDETALLE O RIGHT JOIN LIBRO L ON O.codLibro = L.codLibro
WHERE O.idOrden IS NULL
