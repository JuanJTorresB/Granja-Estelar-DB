-- 1. Obtener promedio de ventas de cada empleado

SELECT  e.nombre, AVG(v.total)
FROM Empleado e
JOIN Venta v ON e.idEmpleado=v.idEmpleado
GROUP BY e.nombre;

-- 2. Obtener los horarios de un dia de la semana para los trabajadores

SELECT e.nombre,h.horaInicio,h.horaFin
FROM Empleado e
JOIN EmpleadoXHorario eh ON e.idEmpleado=eh.idEmpleado
JOIN Horario h ON h.idHorario=eh.idHorario
WHERE h.idDia=2;

-- 3. Obtener el promedio de compras por cliente

SELECT c.nombre, AVG(v.total)
FROM Cliente c
JOIN Venta v ON v.idCliente=c.idCliente
GROUP BY c.nombre;

-- 4. Obtener cantidad de productos vendidos por producto

SELECT p.nombre, COUNT(pv.idProducto)
FROM Producto p
JOIN ProductoXVenta pv ON pv.idProducto=p.idProducto
GROUP BY p.nombre;

-- 5. Obtener la categoria de productos con la mayor suma de ventas

SELECT c.nombre, SUM(v.total)
FROM Venta v
JOIN ProductoXVenta pv ON v.idVenta=pv.idVenta
JOIN Producto p ON p.idProducto=pv.idProducto
JOIN Categoria c ON c.idCategoria=p.idCategoria
GROUP BY c.nombre
ORDER BY SUM(v.total) DESC
LIMIT 1;

-- 6. Obtener el tipo de insumo mas costoso con su precio

SELECT i.nombre, ip.costo
FROM Insumo i
JOIN InsumoXProveedor ip
WHERE ip.costo>=  (SELECT MAX(costo) FROM InsumoXProveedor);

-- 12. Obtener el dinero total que se ha gastado en consultas veterinarias

SELECT SUM(costo) FROM ConsultaVeterinaria;

-- 15. Obtener la cantidad de animales en un recinto

SELECT t.nombre, COUNT(a.idAnimal)
FROM Animal a
JOIN TipoAnimal t ON t.idTipoAnimal=a.idTipoAnimal
WHERE idRecinto=1
GROUP BY t.nombre;

-- 20. Obtener la cantidad de consultas veterinarias para un animal

SELECT COUNT(idAnimal) 
FROM ConsultaVeterinaria
WHERE idAnimal=1; 

-- 21. Obtener el promedio de ventas en un periodo de tiempo

SELECT AVG(total)
FROM Venta
WHERE fecha BETWEEN "2023-10-20 00:00:00" AND "2024-10-22 00:00:00";