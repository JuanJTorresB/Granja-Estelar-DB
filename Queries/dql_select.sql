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
WHERE i.idTipoInsumo=1 AND ip.costo < (
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

-- 23. Obtener el promedio de ventas de los empleados que es mayor a 100000

SELECT e.nombre, AVG(v.total)
FROM Empleado e
JOIN Venta v ON v.idEmpleado=e.idEmpleado
GROUP BY e.nombre
HAVING AVG(v.total)>100000;

-- 24. Obtener la cantidad de un producto que ha vendido cada empleado

SELECT e.nombre, SUM(pv.cantidad)
FROM Empleado e
JOIN Venta v ON v.idEmpleado=e.idEmpleado
JOIN ProductoXVenta pv ON pv.idVenta=v.idVenta
WHERE pv.idProducto=1
GROUP BY e.nombre;

-- 25. Obtener la cantidad de maquinaria que se encuentra en mantenimiento

SELECT COUNT(idMaquinaria)
FROM Maquinaria
WHERE estado="En Mantenimiento";

-- 26. Obtener la cantidad de maquinaria por tipo de maquinaria

SELECT t.nombre,COUNT(idMaquinaria)
FROM Maquinaria m
JOIN TipoMaquinaria t ON t.idTipoMaquinaria=m.idTipoMaquinaria
GROUP BY t.nombre;

-- 27. Obtener las herramientas que estan en un determinado almacen

SELECT th.nombre, COUNT(ah.idHerramienta)
FROM AlmacenXHerramienta ah
JOIN Herramienta h ON h.idHerramienta=ah.idHerramienta
JOIN TipoHerramienta th ON th.idTipoHerramienta=h.idTipoHerramienta
WHERE ah.idAlmacen=1
GROUP BY th.nombre;

-- 28. Obtener animales de un tipo con un peso mayor al promedio de ese tipo

SELECT idAnimal, peso
FROM Animal
WHERE idTipoAnimal=1 AND peso>(
	SELECT AVG(peso) FROM Animal WHERE idTipoAnimal=1
);

-- 29. Obtener el animal de un tipo con el mayor peso

SELECT idAnimal, peso
FROM Animal
WHERE peso = (SELECT MAX(peso) FROM Animal);

-- 30. Obtener la cantidad de recintos por tipo de recinto

SELECT t.nombre, COUNT(r.idRecinto)
FROM Recinto r
JOIN TipoRecinto t ON t.idTipoRecinto=r.idTipoRecinto
GROUP BY t.nombre;

-- 31. Obtener la cantidad de almacenes por zona

SELECT idZona, COUNT(idAlmacen)
FROM Almacen
GROUP BY idZona;

-- 32. Obtener los cultivos con un area mayor al promedio

SELECT idCultivo, area
FROM Cultivo
WHERE area > (SELECT AVG(area) FROM Cultivo);

-- 33. Obtener la cantidad de insumos que hay en un determinado recinto

SELECT i.nombre, ri.cantidad
FROM Insumo i
JOIN RecintoXInsumo ri ON ri.idInsumo=i.idInsumo
WHERE ri.idRecinto=1;

-- 34. Obtener la cantidad de un producto que se ha obtenido de los cultivos
SELECT idCultivo, cantidad
FROM CultivoXProducto
WHERE idProducto=2;

-- 35. Obtener la cantidad de mantenimientos que se han realizado por tipo de maquinaria
SELECT tm.nombre, COUNT(mt.idMaquinaria)
FROM TipoMaquinaria tm
JOIN Maquinaria m ON m.idTipoMaquinaria=tm.idTipoMaquinaria
JOIN Mantenimiento mt ON mt.idMaquinaria=m.idMaquinaria
GROUP BY tm.nombre;

-- 36. Obtener las tareas pendientes del dia
SELECT tt.nombre,t.descripcion
FROM Tarea t
JOIN TipoTarea tt ON t.idTipoTarea=tt.idTipoTarea
WHERE DATE(t.fechaInicio)=CURDATE() AND t.estado="Pendiente";

-- 37. Obtener los empleados que no se encuentran disponibles en el momento
SELECT nombre
FROM Empleado
WHERE estado="No Disponible";

-- 38. Obtener el numero de tareas por cargo
SELECT c.nombre, COUNT(et.idEmpleado)
FROM Cargo c
JOIN Empleado e ON c.idCargo=e.idCargo
JOIN EmpleadoXTarea et ON et.idEmpleado=e.idEmpleado
GROUP BY c.nombre;

-- 39. Obtener los empleados que tienen un salario mayor al promedio de salarios
SELECT nombre
FROM Empleado
WHERE salario>(SELECT AVG(salario) FROM Empleado);

-- 40. Obtener las tareas que se deben realizar para un determinado cultivo
SELECT tt.nombre,t.descripcion
FROM TareaXCultivo tc
JOIN Tarea t ON tc.idTarea=t.idTarea
JOIN TipoTarea tt ON t.idTipoTarea=tt.idTipoTarea
WHERE tc.idCultivo=1;

-- 41. Obtener los empleados asignados a un recinto
SELECT e.nombre
FROM Empleado e
JOIN EmpleadoXTarea et ON et.idEmpleado=e.idEmpleado
JOIN Tarea t ON t.idTarea=et.idTarea
JOIN TareaXRecinto tr ON tr.idTarea=t.idTarea
WHERE tr.idRecinto=1;

-- 42. Obtener el costo total de las ordenes de compra
SELECT SUM(total)
FROM OrdenCompra;

-- 43. Obtener las ordenes de compra donde se pidio un determinado insumo y la cantidad que se pidio
SELECT o.idOrdenCompra, io.cantidad
FROM OrdenCompra o
JOIN InsumoXOrdenCompra io ON io.idOrdenCompra=o.idOrdenCompra
WHERE io.idInsumo=1;

-- 44. Obtener la venta mas costosa
SELECT idVenta,fecha,total
FROM Venta
WHERE total=(SELECT MAX(total) FROM Venta);

-- 45. Obtener la fecha del ultimo mantenimiento realizado a una maquinaria
SELECT MAX(fecha)
FROM Mantenimiento
WHERE idMaquinaria=1; 

-- 46. Obtener el mayor historico
SELECT total, fecha
FROM Historico
WHERE total=(SELECT MAX(total) FROM Historico);

-- 47. Obtener los logs registrados para una determinada entidad
SELECT mensaje,fecha
FROM Log
WHERE idEntidad=1;

-- 48. Obtener la orden de compra mas costosa
SELECT idOrdenCompra,fecha,total
FROM OrdenCompra
WHERE total=(SELECT MAX(total) FROM OrdenCompra);

-- 49. Obtener la cantidad de logs por entidad
SELECT e.nombre, COUNT(l.idEntidad)
FROM Entidad e
JOIN Log l ON l.idEntidad=e.idEntidad
GROUP BY e.nombre;

-- 50. Obtener los productos con un stock menor al promedio
SELECT nombre, stock
FROM Producto
WHERE stock<(SELECT AVG(stock) FROM Producto);

-- 51. Obtener la fecha de la ultima consulta veterinaria realizada para un animal
SELECT MAX(fecha)
FROM ConsultaVeterinaria
WHERE idAnimal=1 AND estado="Realizada";

-- 52. Obtener la cantidad de ordenes de compra por proveedor
SELECT p.nombre, COUNT(op.idProveedor)
FROM Proveedor p
JOIN OrdenCompraXProveedor op ON op.idProveedor=p.idProveedor
GROUP BY p.nombre;

-- 53. Obtener el dinero gastado por tipo de insumo
SELECT ti.nombre, SUM(o.total)
FROM OrdenCompra o
JOIN InsumoXOrdenCompra io ON o.idOrdenCompra=io.idOrdenCompra
JOIN Insumo i ON i.idInsumo=io.idInsumo
JOIN TipoInsumo ti ON ti.idTipoInsumo=i.idTipoInsumo
GROUP BY ti.nombre;

-- 54. Obtener la fecha de la ultima orden de compra hecha para un insumo y su cantidad
SELECT o.idOrdenCompra, io.cantidad, o.fecha
FROM OrdenCompra o
JOIN InsumoXOrdenCompra io ON io.idOrdenCompra=o.idOrdenCompra
WHERE io.idInsumo=1 AND o.fecha=(
	SELECT MAX(o2.fecha)
    FROM OrdenCompra o2
    JOIN InsumoXOrdenCompra io2 ON io2.idOrdenCompra=o2.idOrdenCompra
    WHERE io2.idInsumo=1
    )
GROUP BY o.idOrdenCompra, io.cantidad;

-- 55. Obtener el numero de ventas que ha hecho cada empleado
SELECT e.nombre, COUNT(v.idEmpleado)
FROM Empleado e
JOIN Venta v ON v.idEmpleado=e.idEmpleado
GROUP BY e.nombre;

-- 56. Obtener la ultima fecha en la que un empleado realizo una venta
SELECT fecha, total
FROM Venta
WHERE idEmpleado=1 AND fecha=(
	SELECT MAX(fecha) 
    FROM Venta 
    WHERE idEmpleado=1);

-- 57. Obtener los productos y su cantidad de una venta
SELECT p.nombre, pv.cantidad
FROM Producto p
JOIN ProductoXVenta pv ON pv.idProducto=p.idProducto
WHERE pv.idVenta=1;

-- 58. Obtener las ultimas vacaciones que disfruto un empleado
SELECT fechaInicio,fechaFin, DATEDIFF(fechaFin,fechaInicio)
FROM Vacacion
WHERE idEmpleado=1 AND estado="Disfrutada" AND fechaFin=(
	SELECT MAX(fechaFin)
    FROM Vacacion
    WHERE idEmpleado=1 AND estado="Disfrutada"
);

-- 59. Obtener la ultima fecha en la que se vendio un producto y su cantidad
SELECT v.idVenta, v.fecha, pv.cantidad
FROM Venta v
JOIN ProductoXVenta pv ON v.idVenta=pv.idVenta
WHERE pv.idProducto=1 AND v.fecha=(
	SELECT MAX(v2.fecha)
    FROM Venta v2
    JOIN ProductoXVenta pv2 ON v2.idVenta=pv2.idVenta
    WHERE pv2.idProducto=1
);

-- 60. Obtener la cantidad de tipos de recinto en un zona
SELECT tr.nombre, COUNT(r.idRecinto)
FROM TipoRecinto tr
JOIN Recinto r ON r.idTipoRecinto=tr.idTipoRecinto
WHERE r.idZona=1
GROUP BY tr.nombre;

-- 61. Obtener el ultimo empleado que fue contratado
SELECT e.nombre, c.nombre, e.fechaContratacion
FROM Empleado e
JOIN Cargo c ON c.idCargo=e.idCargo
WHERE e.fechaContratacion=(SELECT MAX(fechaContratacion) FROM Empleado);

-- 62. Obtener las tareas relacionadas a un cargo
SELECT tt.nombre, t.descripcion
FROM TipoTarea tt
JOIN Tarea t ON tt.idTipoTarea=t.idTipoTarea
JOIN EmpleadoXTarea et ON et.idTarea=t.idTarea
JOIN Empleado e ON e.idEmpleado=et.idEmpleado
WHERE e.idCargo=1
GROUP BY tt.nombre, t.descripcion;

-- 63. Obtener el tipo de maquinaria y la cantidad que se encuentra en un determinado almacen
SELECT tm.nombre, COUNT(am.idMaquinaria)
FROM TipoMaquinaria tm
JOIN Maquinaria m ON m.idTipoMaquinaria=tm.idTipoMaquinaria
JOIN AlmacenXMaquinaria am ON am.idMaquinaria=m.idMaquinaria
WHERE am.idAlmacen=1
GROUP BY tm.nombre;

-- 64. Obtener los tipos de animales y su cantidad en una zona
SELECT ta.nombre, COUNT(a.idAnimal)
FROM TipoAnimal ta
JOIN Animal a ON ta.idTipoAnimal=a.idTipoAnimal
JOIN Recinto r ON r.idRecinto=a.idRecinto
WHERE r.idZona=1
GROUP BY ta.nombre;

-- 65. Obtener la cantidad total de productos producidos de los recintos
SELECT p.nombre, SUM(rp.cantidad)
FROM Producto p
JOIN RecintoXProducto rp ON rp.idProducto=p.idProducto
GROUP BY p.nombre;

-- 66. Obtener la cantidad de un determinado producto que han producto los recintos
SELECT r.nombre, SUM(rp.cantidad)
FROM Recinto r
JOIN RecintoXProducto rp ON rp.idRecinto=r.idRecinto
WHERE rp.idProducto=1
GROUP BY r.nombre;

-- 67. Obtener el cliente que ha realizado la ultima compra
SELECT c.nombre, v.fecha
FROM Cliente c
JOIN Venta v ON v.idCliente=c.idCliente
WHERE v.fecha=(SELECT MAX(fecha) FROM Venta);

-- 68. Obtener el numero de compras que ha hecho cada cliente
SELECT c.nombre, COUNT(v.idCliente)
FROM Cliente c
JOIN Venta v ON v.idCliente=c.idCliente
GROUP BY c.nombre;

-- 69. Obtener la ultima maquinaria que fue adquirida y su tipo
SELECT tm.nombre, m.nombre, m.fechaAdquisicion
FROM Maquinaria m 
JOIN TipoMaquinaria tm ON tm.idTipoMaquinaria=m.idTipoMaquinaria
WHERE m.fechaAdquisicion=(SELECT MAX(fechaAdquisicion) FROM Maquinaria);

-- 70. Obtener la ultima tarea que fue terminada
SELECT tt.nombre, t.fechaFin
FROM TipoTarea tt
JOIN Tarea t ON t.idTipoTarea=tt.idTipoTarea
WHERE t.fechaFin=(SELECT MAX(fechaFin) FROM Tarea);

-- 71. Obtener el ultimo log que se ha registrado para una entidad
SELECT mensaje, fecha
FROM Log
WHERE idEntidad=1 AND fecha = (SELECT MAX(fecha) FROM Log WHERE idEntidad=1); 

-- 72. Obtener los proveedores que se encuentran inactivos
SELECT idProveedor, nombre
FROM Proveedor
WHERE activo="Inactivo";

-- 73. Obtener el mantenimiento que ha tenido el menor costo
SELECT mt.idMantenimiento, m.nombre, mt.fecha, mt.costo
FROM Mantenimiento mt
JOIN Maquinaria m ON m.idMaquinaria=mt.idMaquinaria
WHERE mt.costo=(SELECT MIN(costo) FROM Mantenimiento);

-- 74. Obtener el ciente que hizo la compra con el menor valor
SELECT v.idVenta, c.nombre, v.total
FROM Venta v
JOIN Cliente c ON v.idCliente=c.idCliente
WHERE v.total=(SELECT MIN(total) FROM Venta);

-- 75. Obtener el ultimo historico que se registro
SELECT fecha, total
FROM Historico
WHERE fecha = (SELECT MAX(fecha) FROM Historico);

-- 76. Obtener la cantidad de insumos que se pueden solicitar a cada proveedor
SELECT p.nombre, COUNT(ip.idProveedor)
FROM Proveedor p
JOIN InsumoXProveedor ip ON p.idProveedor=ip.idProveedor
GROUP BY p.nombre;

-- 77. Obtener la cantidad de animales por tipo de recinto
SELECT t.nombre, COUNT(a.idAnimal)
FROM TipoRecinto t
JOIN Recinto r ON r.idTipoRecinto=t.idTipoRecinto
JOIN Animal a ON a.idRecinto=r.idRecinto
GROUP BY t.nombre;

-- 78. Obtener la cantidad de insumos por tipo de recinto
SELECT t.nombre, i.nombre, COUNT(ri.cantidad)
FROM TipoRecinto t
JOIN Recinto r ON r.idTipoRecinto=t.idTipoRecinto
JOIN RecintoXInsumo ri ON ri.idRecinto=r.idRecinto
JOIN Insumo i ON i.idInsumo=ri.idInsumo
GROUP BY t.nombre, i.nombre;

-- 79. Obtener la cantidad de veces que ha estado cada producto en una venta
SELECT p.nombre, COUNT(pv.idProducto)
FROM Producto p
JOIN ProductoXVenta pv ON p.idProducto=pv.idProducto
GROUP BY p.nombre;

-- 80. Obtener el tipo de herramienta que tiene el menor stock
SELECT th.nombre, ah.stock
FROM TipoHerramienta th
JOIN Herramienta h ON th.idTipoHerramienta=h.idTipoHerramienta
JOIN AlmacenXHerramienta ah ON ah.idHerramienta=h.idHerramienta
WHERE ah.stock=(SELECT MIN(stock) FROM AlmacenXHerramienta);

-- 81. Obtener la cantidad de maquinarias por zona
SELECT z.nombre, COUNT(am.idMaquinaria)
FROM Zona z
JOIN Almacen a ON a.idZona=z.idZona
JOIN AlmacenXMaquinaria am ON am.idAlmacen=a.idAlmacen
GROUP BY z.nombre;

-- 82. Obtener la consulta veterinaria que ha tenido el mayor costo y para que tipo de animal fue
SELECT c.idConsulta, t.nombre, c.fecha, c.costo
FROM TipoAnimal t
JOIN Animal a ON a.idTipoAnimal=t.idTipoAnimal
JOIN ConsultaVeterinaria c ON c.idAnimal=a.idAnimal
WHERE c.costo=(SELECT MAX(costo) FROM ConsultaVeterinaria);

-- 83. Obtener el empleado que tiene el mayor salario
SELECT nombre, salario
FROM Empleado
WHERE salario=(SELECT MAX(salario) FROM Empleado);

-- 84. Obtener el numero de productos por categoria
SELECT c.nombre, COUNT(p.idProducto)
FROM Categoria c
JOIN Producto p ON p.idCategoria=c.idCategoria
GROUP BY c.nombre;

-- 85. Obtener el ultimo cultivo que fue sembrado y su tipo
SELECT c.idCultivo,t.nombre,c.fechaSiembra
FROM Cultivo c
JOIN TipoCultivo t ON t.idTipoCultivo=c.idTipoCultivo
WHERE c.fechaSiembra=(SELECT MAX(fechaSiembra) FROM Cultivo);

-- 86. Obtener los cultivos que fueron sembrados pero no han sido cosechados
SELECT idCultivo, fechaSiembra
FROM Cultivo
WHERE fechaCosecha>CURDATE();

-- 87. Obtener el tipo de herramienta y su cantidad en una zona
SELECT th.nombre, ah.stock
FROM TipoHerramienta th
JOIN Herramienta h ON th.idTipoHerramienta=h.idTipoHerramienta
JOIN AlmacenXHerramienta ah ON ah.idHerramienta=h.idHerramienta
JOIN Almacen a ON a.idAlmacen=ah.idAlmacen
WHERE a.idZona=2;

-- 88. Obtener los productos y su cantidad en una determinada zona
SELECT p.nombre, SUM(cp.cantidad)
FROM Producto p 
JOIN CultivoXProducto cp ON cp.idProducto=p.idProducto
JOIN Cultivo c ON c.idCultivo=cp.idCultivo
WHERE c.idZona=1
GROUP BY p.nombre
UNION
SELECT p.nombre, SUM(rp.cantidad)
FROM Producto p 
JOIN RecintoXProducto rp ON rp.idProducto=p.idProducto
JOIN Recinto r ON r.idRecinto=rp.idRecinto
WHERE r.idZona=1
GROUP BY p.nombre;

-- 89. Obtener el promedio de salario por cargo
SELECT c.nombre, AVG(e.salario)
FROM Empleado e
JOIN Cargo c ON c.idCargo=e.idCargo
GROUP BY c.nombre;

-- 90. Obtener el stock por tipo de herramienta
SELECT t.nombre, SUM(ah.stock)
FROM TipoHerramienta t
JOIN Herramienta h ON h.idTipoHerramienta=t.idTipoHerramienta
JOIN AlmacenXHerramienta ah ON ah.idHerramienta=h.idHerramienta
GROUP BY t.nombre;

-- 91. Obtener el numero de consultas veterinarias por realizar
SELECT COUNT(idConsulta)
FROM ConsultaVeterinaria
WHERE estado="Por Realizar";

-- 92. Obtener la duracion de cada tarea en horas
SELECT tt.nombre, t.descripcion, TIMESTAMPDIFF(HOUR,fechaInicio,fechaFin)
FROM TipoTarea tt
JOIN Tarea t ON t.idTipoTarea=tt.idTipoTarea;

-- 93. Obtener el tipo de cultivo con la temporada mas grande
SELECT nombre, DATEDIFF(FinTemporada,inicioTemporada)
FROM TipoCultivo
WHERE DATEDIFF(FinTemporada,inicioTemporada)=(SELECT MAX(DATEDIFF(FinTemporada,inicioTemporada)) FROM TipoCultivo);

-- 94. Obtener el empleado que ha tenido la vacacion mas larga
SELECT e.nombre, DATEDIFF(v.fechaFin,v.fechaInicio)
FROM Empleado e
JOIN Vacacion v ON v.idEmpleado=e.idEmpleado
WHERE DATEDIFF(v.fechaFin,v.fechaInicio)=(SELECT MAX(DATEDIFF(v.fechaFin,v.fechaInicio)) FROM Vacacion v);

-- 95. Obtener el numero de empleados que tienen vacaciones pendientes
SELECT COUNT(idEmpleado)
FROM Vacacion
WHERE estado="Pendiente";

-- 96. Obtener las horas trabajadas por cada empleado en un dia
SELECT e.nombre, TIME_TO_SEC(TIMEDIFF(horaFin,horaInicio))/3600
FROM Empleado e
JOIN EmpleadoXHorario eh ON eh.idEmpleado=e.idEmpleado
JOIN Horario h ON h.idHorario=eh.idHorario
WHERE h.idDia=DAYOFWEEK("2024-10-20");

-- 97. Obtener los insumos y la cantidad de una orden de compra
SELECT i.nombre,io.cantidad
FROM Insumo i
JOIN InsumoXOrdenCompra io ON i.idInsumo=io.idInsumo
WHERE io.idOrdenCompra=1;

-- 98. Obtener la cantidad de logs que hay registrados para cada entidad
SELECT e.nombre, COUNT(l.idEntidad)
FROM Entidad e
JOIN Log l ON l.idEntidad=e.idEntidad
GROUP BY e.nombre;

-- 99. Obtener la tarea que tarda mas tiempo en realizarse
SELECT tt.nombre, t.descripcion, TIMESTAMPDIFF(HOUR,fechaInicio,fechaFin)
FROM TipoTarea tt
JOIN Tarea t ON t.idTipoTarea=tt.idTipoTarea
WHERE TIMESTAMPDIFF(HOUR,fechaInicio,fechaFin)=(SELECT MAX(TIMESTAMPDIFF(HOUR,fechaInicio,fechaFin)) FROM Tarea)
GROUP BY tt.nombre, t.descripcion, TIMESTAMPDIFF(HOUR,fechaInicio,fechaFin);

-- 100. Obtener las fechas donde el historico fue mayor al promedio
SELECT fecha, total
FROM Historico
WHERE total>(SELECT AVG(total) FROM Historico);