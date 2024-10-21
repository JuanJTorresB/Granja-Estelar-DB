-- 1. Procedimiento para insertar un empleado
DELIMITER //
CREATE PROCEDURE insertarEmpleado(IN _idCargo INT, IN _nombre VARCHAR(255), IN _estado ENUM("Activo","Inactivo"), IN fechaContratacion DATE, IN salario DECIMAL(10,2))
BEGIN
    INSERT INTO Empleado(idCargo, nombre, estado, fechaContratacion, salario)
    VALUES (_idCargo, _nombre, _estado, _fechaContratacion, _salario);
END //
DELIMITER ;

-- 2. Procedimiento para consultar los empleados que estan trabajando en el momento
DELIMITER //
CREATE PROCEDURE empleadosDisponibles()
BEGIN
    SELECT e.idCargo AS "Cargo", e.nombre AS "Empleado", h.horaInicio AS "Hora entrada", h.horaFin AS "Hora salida"
    FROM Empleado e
    JOIN EmpleadoxHorario eh ON e.idEmpleado=eh.idEmpleado
    JOIN Horario h ON h.idHorario=eh.idHorario
    JOIN Dia d ON d.idDia=H.idDia
    WHERE d.idDia=DAYOFWEEK(NOW()) AND h.horaInicio<=TIME(NOW()) AND h.horaFin>TIME(NOW()) AND e.estado="Activo";
END //
DELIMITER ;

--3. Procedimiento para obtener las tareas relacionadas a un empleado en un dia especifico
DELIMITER //
CREATE PROCEDURE tareasRelacionadasEmpleado(IN _idEmpleado INT, IN dia DATE)
BEGIN
    SELECT t.nombre AS "Tarea", TIME(t.fechaInicio) AS "Hora inicio", TIME(t.fechaFin) AS "Hora fin", t.descripcion AS "Descripcion" 
    FROM Tarea t
    JOIN EmpleadoxTarea et ON t.idTarea=et.idTarea
    WHERE et.idEmpleado=_idEmpleado AND DATE(t.fechaInicio)=dia;
END //
DELIMITER ;

-- 4. Procedimiento para obtener la cantidad y tipo de animal por recinto
DELIMITER //
CREATE PROCEDURE obtenerCantidadAnimalRecinto()
BEGIN
    SELECT r.nombre AS "Recinto", t.nombre AS "Animal", COUNT(a.idAnimal) AS "Cantidad"
    FROM TipoAnimal t
    JOIN Animal a ON a.TipoAnimal=t.idTipoAnimal
    JOIN Recinto r ON r.idRecinto=a.idRecinto
    GROUP BY r.nombre, t.nombre;
END //
DELIMITER ;

-- 5. Procedimiento para obtener los cultivos que estan en temporada en una fecha especifica
DELIMITER //
CREATE PROCEDURE obtenerCultivosTemporada(IN fecha DATE)
BEGIN
    SELECT nombre AS "Cultivo", inicioTemporada, finTemporada FROM TipoCultivo
    WHERE inicioTemporada<=fecha AND finTemporada>=fecha;
END //
DELIMITER ;

-- 6. Procedimiento para obtener los proveedores para un determinado producto
DELIMITER //
CREATE PROCEDURE obtenerProveedoresProducto(IN _idInsumo INT)
BEGIN
    SELECT p.nombre AS "Proveedor",  ip.costo AS "Costo"
    FROM Proveedor p
    JOIN InsumoxProveedor ip ON ip.idProveedor=p.idProveedor
    WHERE ip.idInsumo=_idInsumo;
END //
DELIMITER ;

-- 7. Procedimiento para obtener las herramientas que estan en un determinado almacen

DELIMITER //
CREATE PROCEDURE herramientasAlmacen(IN _idAlmacen INT)
BEGIN
    SELECT t.nombre AS "Tipo herramienta", COUNT(ah.idHerramienta)
    FROM TipoHerramienta t
    JOIN Herramienta h ON t.idTipoHerramienta=h.idTipoHerramienta
    JOIN AlmacenxHerramienta ah ah.idHerramienta=h.idHerramienta
    WHERE ah.idAlmacen=_idAlmacen
    GROUP BY t.nombre;
END //
DELIMITER ;

-- 8. Procedimiento para registrar un mantenimiento a una maquinaria especifica

DELIMITER //
CREATE PROCEDURE registrarMantenimiento(IN _idMaquinaria INT, IN _fecha DATE, IN _costo DECIMAL(10,2))
BEGIN
    INSERT INTO Mantenimiento(idMaquinaria, fecha, costo)
    VALUES (_idMaquinaria,_fecha,_costo);
END //
DELIMITER ;

-- 9. Procedimiento para obtener los trabajadores asignados por cultivo

DELIMITER //
CREATE PROCEDURE trabajadoresCultivo()
BEGIN
    SELECT tc.nombre AS "Tipo cultivo", c.idCultivo AS "Cultivo", COUNT(et.idEmpleado) AS "Cantidad"
    FROM TipoCultivo tc
    JOIN Cultivo c ON tc.idTipoCultivo=c.idTipoCultivo
    JOIN TareaxCultivo txc ON c.idCultivo=txc.idCultivo
    JOIN Tarea t ON txc.idTarea=t.idTarea
    JOIN EmpleadoxTarea et ON et.idTarea=t.idTarea
    GROUP BY tc.nombre, c.idCultivo;
END //
DELIMITER ;

-- 10. Procedimiento para obtener el numero de cultivos en una zona de acuerdo a su tipo de cultivo

DELIMITER //
CREATE PROCEDURE cultivosZona(IN _idZona INT)
BEGIN
    SELECT tc.nombre AS "Tipo de cultivo", COUNT(c.idCultivo) AS "Cantidad"
    FROM TipoCultivo tc
    JOIN Cultivo c ON c.idTipoCultivo=tc.idTipoCultivo
    WHERE c.idZona=_idZona
    GROUP BY tc.nombre;
END //
DELIMITER ;

-- 11. Procedimiento para insertar un proveedor

DELIMITER //
CREATE PROCEDURE insertarProveedor(IN _nombre VARCHAR(100), IN _activo ENUM("Activo", "Inactivo"))
BEGIN
    INSERT INTO Proveedor(nombre,activo)
    VALUES(_nombre, _activo);
END //
DELIMITER ;

-- 12. Procedimiento para obtener la cantidad de productos obtenidos en un recinto especifico

DELIMITER //
CREATE PROCEDURE cantidadProductoRecinto(IN _idRecinto INT)
BEGIN
    SELECT p.nombre AS "Producto", SUM(rp.cantidad) AS "Cantidad"
    FROM Producto p
    JOIN RecintoxProducto rp ON rp.idProducto=p.idProducto
    WHERE rp.idRecinto=_idRecinto
    GROUP BY p.nombre;
END //
DELIMITER ;

-- 13. Procedimiento para obtener los insumos utilizados en un determinado tipo de cultivo

DELIMITER //
CREATE PROCEDURE insumosCultivo(IN _idTipoCultivo)
BEGIN
    SELECT ti.nombre AS "Tipo de insumo", i.nombre AS "Insumo", i.stock AS "Stock" 
    FROM TipoInsumo ti
    JOIN Insumo i ON i.idTipoInsumo=ti.idTipoInsumo
    JOIN CultivoxInsumo ci ON ci.idInsumo=i.idInsumo
    JOIN Cultivo c ON c.idCultivo=ci.idCultivo
    JOIN TipoCultivo tc ON tc.idTipoCultivo=c.idTipoCultivo
    WHERE tc.idTipoCultivo=_idTipoCultivo;
END //
DELIMITER ;

-- 14. Procedimiento para obtener los proveedores y el costo se tienen para un insumo

DELIMITER //
CREATE PROCEDURE proveedoresInsumo(IN _idInsumo INT)
BEGIN
    SELECT p.nombre AS "Proveedor", ip.costo AS "Costo"
    FROM Proveedor p
    JOIN InsumoxProveedor ip ON ip.idProveedor=p.idProveedor
    WHERE ip.idInsumo=_idInsumo;
END //
DELIMITER ;

-- 15. Procedimiento para obtener la maquinaria que esta en un determinado almacen

DELIMITER //
CREATE PROCEDURE maquinariaAlmacen(IN _idAlmacen INT)
BEGIN
    SELECT t.nombre AS "Tipo maquinaria", COUNT(am.idMaquinaria)
    FROM TipoMaquinaria t
    JOIN Maquinaria m ON t.idTipoMaquinaria=h.idTipoMaquinaria
    JOIN AlmacenxMaquinaria am am.idMaquinaria=h.idMaquinaria
    WHERE ah.idAlmacen=_idAlmacen
    GROUP BY t.nombre;
END //
DELIMITER ;

-- 16. Procedimiento para obtener los trabajadores asignados por recinto

DELIMITER //
CREATE PROCEDURE trabajadoresRecinto()
BEGIN
    SELECT tr.nombre AS "Tipo de recinto", r.nombre AS "Recinto", COUNT(et.idEmpleado) AS "Cantidad"
    FROM EmpleadoxTarea et
    JOIN Tarea t ON t.idTarea=et.idTarea
    JOIN TareaxRecinto txr ON txr.idTarea=t.idTarea
    JOIN Recinto r ON r.idRecinto=txr.idRecinto
    JOIN TipoRecinto tr ON tr.idTipoRecinto=r.idTipoRecinto
    GROUP BY tr.nombre, r.nombre;
END //
DELIMITER ;

-- 17. Procedimiento para obtener el numero de recintos en una zona de acuerdo a su tipo de recinto

DELIMITER //
CREATE PROCEDURE recintosZona(IN _idZona INT)
BEGIN
    SELECT tr.nombre AS "Tipo de recinto", COUNT(r.idRecinto) AS "Cantidad"
    FROM TipoRecinto tr
    JOIN Recinto r ON r.idTipoRecinto=tr.idTipoRecinto
    WHERE r.idZona=_idZona
    GROUP BY tr.nombre;
END //
DELIMITER ;

-- 18. Procedimiento para obtener la cantidad de producto por categoria

DELIMITER //
CREATE PROCEDURE cantidadProductoCategoria()
BEGIN
    SELECT c.nombre AS "Categoria", SUM(p.stock) AS "Stock"
    FROM Producto p
    JOIN Categoria c ON c.idCategoria=p.idCategoria
    GROUP BY c.nombre
END //
DELIMITER ;

-- 19. Procedimiento para obtener el rendimiento de los cultivos de un mismo tipo

DELIMITER //
CREATE PROCEDURE rendimientoTipoCultivo(IN _idTipoCultivo INT)
BEGIN
    SELECT idCultivo AS "Cultivo", idZona AS "Zona" fechaSiembra, fechaCosecha, rendimientoCultivo(idCultivo)
    FROM Cultivo
    WHERE idTipoCultivo=_idTipoCultivo;
END;
DELIMITER ;

-- 20. Procedimiento para obtener el tipo de animales y su cantidad en un determinado recinto

DELIMITER //
CREATE PROCEDURE animalesRecinto(IN _idRecinto INT)
BEGIN
    SELECT ta.nombre AS "Tipo de animal", COUNT(a.idAnimal) AS "Cantidad"
    FROM TipoAnimal ta
    JOIN Animal a ON a.idAnimal=ta.idAnimal
    WHERE a.idRecinto=_idRecinto;
END //
DELIMITER ;