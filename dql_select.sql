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

-- 7. Obtener numero de tipos de cultivo para una zona

SELECT tc.nombre, COUNT(c.idCultivo)
FROM TipoCultivo tc 
JOIN Cultivo c ON tc.idTipoCultivo=c.idTipoCultivo
WHERE c.idZona=1
GROUP BY tc.nombre;

-- 8. Obtener los productos con un precio mayor al promedio de precios de los productos

SELECT nombre, precio
FROM Producto
WHERE precio > (SELECT AVG(precio) FROM Producto);

-- 9. Obtener el numero de empleados que tiene cada cargo

SELECT c.nombre, COUNT(e.idEmpleado)
FROM Cargo c
JOIN Empleado e ON c.idCargo=e.idCargo
GROUP BY c.nombre;

-- 10. Obtener la cantidad de tareas que tiene asignadas cada empleado

SELECT e.nombre, COUNT(et.idTarea)
FROM Empleado e
JOIN EmpleadoxTarea et ON e.idEmpleado=et.idEmpleado
GROUP BY e.nombre;

-- 11. Obtener la cantidad de tareas por el tipo de tarea

SELECT tt.nombre, COUNT(t.idTarea)
FROM Tarea t
JOIN TipoTarea tt ON tt.idTipoTarea=t.idTipoTarea
GROUP BY tt.nombre;

-- 12. Obtener el dinero total que se ha gastado en consultas veterinarias

SELECT SUM(costo) FROM ConsultaVeterinaria;

-- 13. Obtener los insumos de un tipo con un costo menor al costo promedio de ese tipo

SELECT i.nombre, p.nombre, ip.costo
FROM Insumo i
JOIN InsumoXProveedor ip ON i.idInsumo=ip.idInsumo
JOIN Proveedor p ON p.idProveedor=ip.idProveedor
WHERE i.idTipoInsumo=1 AND ip.costo > (
	SELECT AVG(ip2.costo)
    FROM InsumoXProveedor ip2
    JOIN Insumo i2 ON i2.idInsumo=ip2.idInsumo
    WHERE i2.idTipoInsumo=1
);

-- 14. Obtner la cantidad de tipos de cultivo que se han realizado

SELECT tc.nombre, COUNT(c.idCultivo)
FROM Cultivo c
JOIN TipoCultivo tc ON tc.idTipoCultivo=c.idTipoCultivo
GROUP BY tc.nombre;

-- 15. Obtener la cantidad de animales en un recinto

SELECT t.nombre AS "Tipo Animal", COUNT(a.idAnimal) AS "Cantidad en Recinto"
FROM Animal a
JOIN TipoAnimal t ON t.idTipoAnimal=a.idTipoAnimal
WHERE idRecinto=1
GROUP BY t.nombre;

-- 16. Obtener los insumos que se utilizan para un tipo de cultivo especifico

SELECT i.nombre
FROM Insumo i
JOIN CultivoXInsumo ci ON ci.idInsumo=i.idInsumo
JOIN Cultivo c ON c.idCultivo=ci.idCultivo
WHERE c.idTipoCultivo=2
GROUP BY i.nombre;

-- 17. Obtener la cantidad de empleados que trabajan cada dia

SELECT d.nombre, COUNT(eh.idEmpleado)
FROM Dia d
JOIN Horario h ON h.idDia=d.idDia
JOIN EmpleadoXHorario eh ON eh.idHorario=h.idHorario
GROUP BY d.nombre;

-- 18. Obtener los dias de vacaciones que ha tenido un empleado

SELECT SUM(DATEDIFF(fechaFin,fechaInicio))
FROM Vacacion
WHERE idEmpleado=5;

-- 19. Obtener los clientes que han comprado un producto

SELECT c.nombre
FROM Cliente c
JOIN Venta v ON c.idCliente=v.idCliente
JOIN ProductoXVenta pv ON pv.idVenta=v.idVenta
WHERE pv.idProducto=1
GROUP BY c.nombre;

-- 20. Obtener la cantidad de consultas veterinarias para un animal

SELECT COUNT(idAnimal) 
FROM ConsultaVeterinaria
WHERE idAnimal=1; 

-- 21. Obtener el promedio de ventas en un periodo de tiempo

SELECT AVG(total)
FROM Venta
WHERE fecha BETWEEN "2023-10-20 00:00:00" AND "2024-10-22 00:00:00";

-- 22 Obtener la cantidad de animales enfermos en un recinto

SELECT R.nombre AS Recinto,COUNT(*) AS 'Numero de Animales Enfermos'
FROM Animal A JOIN Recinto R ON A.idRecinto = R.idRecinto
WHERE A.estado = 'Enfermo'
GROUP BY A.idRecinto;