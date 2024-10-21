-- 1. Trigger para verificar que el stock al insertar un producto sea mayor o igual a 0
DELIMITER //
CREATE TRIGGER beforeInsertProducto 
BEFORE INSERT ON Producto FOR EACH ROW
BEGIN
    IF NEW.stock <0 THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "Error: El stock no puede ser menor a 0";
    END IF;
END //
DELIMITER ;

-- 2. Trigger para verificar la fecha de contratacion de un empleado
DELIMITER //
CREATE TRIGGER beforeInsertEmpleado
BEFORE INSERT ON Empleado FOR EACH ROW
BEGIN
    IF NEW.fechaContratacion>CURDATE()
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Error: La fecha de contratacion no es valida";
    END IF;
END //
DELIMITER ;

-- 3. Trigger para actualizar el stock de un insumo al realizar una orden de compra
DELIMITER //
CREATE TRIGGER afterInsertInsumoxOrdenCompra
AFTER INSERT ON InsumoxOrdenCompra FOR EACH ROW
BEGIN
    UPDATE Insumo SET stock=stock+NEW.cantidad WHERE idInsumo=NEW.idInsumo;
END //
DELIMITER ;

-- 4. Trigger para actualizar el total de una venta al hacer un registro en ProductoxVenta

DELIMITER //
CREATE TRIGGER afterInsertProductoxVenta
AFTER INSERT ON ProductoxVenta FOR EACH ROW
BEGIN
    DECLARE subtotal DECIMAL(10,2);

    SELECT precio*NEW.cantidad INTO subtotal FROM Producto WHERE idProducto=NEW.idProducto;

    UPDATE Venta SET total=total+subtotal WHERE idVenta=NEW.idVenta;
END //
DELIMITER ;

-- 5. Trigger para no permitir eliminar un producto si tiene un stock mayor a 0
DELIMITER //
CREATE TRIGGER beforeDeleteProducto
BEFORE DELETE ON Producto FOR EACH ROW
BEGIN
    IF OLD.stock>0 THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Error: No se puede eliminar un producto que tiene un stock mayor a 0";
    END IF;
END //
DELIMITER ;

-- 6. Trigger para actualizar el stock de producto cuando se registra en CultivoxProducto

DELIMITER //
CREATE TRIGGER afterInsertCultivoxProducto
AFTER INSERT ON CultivoxProducto FOR EACH ROW
    UPDATE Producto SET stock=stock+NEW.cantidad WHERE idProducto=NEW.idProducto;
DELIMITER ;

-- 7. Trigger para registrar la actualizacion de salario de un empleado

DELIMITER //
CREATE TRIGGER afterUpdateEmpleadoSalario
AFTER UPDATE ON Empleado FOR EACH ROW
BEGIN
    IF NEW.salario<>OLD.salario THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(1,CONCAT("Actualizacion salario empleado idEmpleado: ",OLD.idEmpleado," salario anterior: ",OLD.salario," salario nuevo: ",NEW.salario), NOW());
    END IF;
END //
DELIMITER ;

-- 8. Trigger para no permitir actualizar el estado de una consulta veterinaria antes de que la fecha pase 

DELIMITER //
CREATE TRIGGER beforeUpdateConsultaVeterinariaEstado
BEFORE UPDATE ON ConsultaVeterinaria FOR EACH ROW
BEGIN 
    IF OLD.fecha<NOW() AND NEW.estado="Realizada" THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Error: No se puede marcar una consulta veteriaria como realizada cuando la fecha programada no ha pasado";
    END IF;
END //
DELIMITER ;

-- 9. Trigger para no permitir eliminar un tipo de animal si tiene animales relacionados
DELIMITER //
CREATE TRIGGER beforeDeleteTipoAnimal
BEFORE DELETE ON TipoAnimal FOR EACH ROW
BEGIN
    IF totalAnimales(OLD.idTipoAnimal)>0 THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Error: No se puede eliminar un tipo de animal que tiene animales relacionados";
    END IF;
END //
DELIMITER ;

-- 10. Trigger para actualizar el stock de un producto al realizar una venta
DELIMITER //
CREATE TRIGGER afterInsertProductoxVentaStock
AFTER INSERT ON ProductoxVenta FOR EACH ROW
BEGIN
    UPDATE Producto SET stock=stock-NEW.cantidad WHERE idProducto=NEW.idProducto;
END //
DELIMITER ;

-- 11. Trigger para actualizar el total de una orden al hacer un registro en InsumoxOrdenCompra

DELIMITER //
CREATE TRIGGER afterInsertInsumoxOrdenCompraTotal
AFTER INSERT ON InsumoxOrdenCompra FOR EACH ROW
BEGIN
    DECLARE subtotal DECIMAL(10,2);

    SELECT ip.costo*NEW.cantidad INTO subtotal
    FROM InsumoxOrdenCompra io
    JOIN ordenCompra o ON o.idOrdenCompra=o.idOrdenCompra
    JOIN OrdenCompraxProveedor op ON op.idOrdenCompra=o.idOrdenCompra
    JOIN Proveedor p ON p.idProveedor=op.idProveedor
    JOIN InsumoxProvedor ip ON p.idProveedor=ip.idProveedor
    WHERE io.idInsumo=NEW.idInsumo AND io.idOrdenCompra=NEW.idOrdenCompra;

    UPDATE OrdenCompra SET total=total+subtotal WHERE idOrdenCompra=NEW.idOrdenCompra;
END //
DELIMITER ;

-- 12. Trigger para actualizar el stock de un producto cuando se registre en RecintoxProducto
DELIMITER //
CREATE TRIGGER afterInsertRecintoxProducto
AFTER INSERT ON RecintoxProducto FOR EACH ROW
BEGIN 
    UPDATE Producto SET stock=stock+NEW.cantidad WHERE idProducto=NEW.idProducto;
END //
DELIMITER ;

-- 13. Trigger para registrar la actualizacion de precio de un producto

DELIMITER //
CREATE TRIGGER afterUpdateProductoPrecio
AFTER UPDATE ON Producto FOR EACH ROW
BEGIN
    IF NEW.precio<>OLD.precio THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(2,CONCAT("Actualizacion precio producto idProducto: ",OLD.idProducto," precio anterior: ",OLD.precio," precio nuevo: ",NEW.precio), NOW());
    END IF;
END //
DELIMITER ;

-- 14. Trigger para registrar la inserccion de un empleado

DELIMITER //
CREATE TRIGGER afterInsertEmpleado
AFTER INSERT ON Producto FOR EACH ROW
BEGIN
    INSERT INTO Log(idEntidad, mensaje, fecha)
    -- Revisar id de entidad
    VALUES(1,CONCAT("Inserccion empleado idEmpleado: ",NEW.idEmpleado," idCargo: ",NEW.idCargo," nombre: ",NEW.nombre," estado: ",NEW.estado," fechaContratacion: ",NEW.fechaContratacion," salario: ",NEW.salario), NOW());
END //
DELIMITER ;

-- 15. Trigger para registrar la novedad del estado de un animal

DELIMITER //
CREATE TRIGGER afterUpdateAnimalEstado
AFTER UPDATE ON Animal FOR EACH ROW
BEGIN
    IF NEW.estado<>OLD.estado THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(10,CONCAT("Actualizacion estado animal idAnimal: ",OLD.idAnimal," estado anterior: ",OLD.idEstado," estado nuevo: ",NEW.idEstado), NOW());
    END IF;
END //
DELIMITER ;

-- 16. Trigger para registrar la actualizacion de cargo de un empleado

DELIMITER //
CREATE TRIGGER afterUpdateEmpleadoCargo
AFTER UPDATE ON Empleado FOR EACH ROW
BEGIN
    IF NEW.idCargo<>OLD.idCargo THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(1,CONCAT("Actualizacion cargo empleado idEmpleado: ",OLD.idEmpleado," idCargo anterior: ",OLD.idCargo," idCargo nuevo: ",NEW.idCargo), NOW());
    END IF;
END //
DELIMITER ;

-- 17. Trigger para registrar la actualizacion de estado de un proveedor

DELIMITER //
CREATE TRIGGER afterUpdateProveedorEstado
AFTER UPDATE ON Proveedor FOR EACH ROW
BEGIN
    IF NEW.activo<>OLD.activo THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(11,CONCAT("Actualizacion activo proveedor idProveedor: ",OLD.idProveedor," activo anterior: ",OLD.activo," activo nuevo: ",NEW.activo), NOW());
    END IF;
END //
DELIMITER ;

-- 18. Trigger para registrar la realizacion de una orden de compra

DELIMITER //
CREATE TRIGGER afterInsertOrdenCompra
AFTER INSERT ON OrdenCompra FOR EACH ROW
BEGIN
    INSERT INTO Log(idEntidad, mensaje, fecha)
    -- Revisar id de entidad
    VALUES(4,CONCAT("Inserccion orden compra idOrdenCompra: ",NEW.idOrdenCompra," fecha: ",NEW.fecha," total: ",NEW.total), NOW());
END //
DELIMITER ;

-- 19. Trigger para evitar insertar valores erroneos en la fecha de cosecha de un cultivo

DELIMITER //
CREATE TRIGGER afterUpdateCultivoFechaCosecha
BEFORE UPDATE ON Cultivo FOR EACH ROW
BEGIN
    IF NEW.fechaCosecha<=OLD.fechaSiembra THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Error: La fecha de cosecha no puede ser menor a la fecha de siembra";
    END IF;
END //
DELIMITER ;

-- 20. Trigger para registrar el cambio de estado en una maquinaria

DELIMITER //
CREATE TRIGGER afterUpdateMaquinariaEstado
AFTER UPDATE ON Maquinaria FOR EACH ROW
BEGIN
    IF OLD.estado<>NEW.estado THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(15,CONCAT("Actualizacion estado maquinaria idMaquinaria: ",OLD.idMaquinaria," estado anterior: ",OLD.estado," estado nuevo: ",NEW.estado), NOW());
    END IF;
END //
DELIMITER ;