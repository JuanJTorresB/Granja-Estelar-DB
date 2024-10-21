-- 1. Trigger para verificar que el stock al insertar un producto sea mayor o igual a 0
DROP TRIGGER IF EXISTS beforeInsertProducto;

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
DROP TRIGGER IF EXISTS beforeInsertEmpleado;

DELIMITER //
CREATE TRIGGER beforeInsertEmpleado
BEFORE INSERT ON Empleado FOR EACH ROW
BEGIN
    IF NEW.fechaContratacion>CURDATE() THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Error: La fecha de contratacion no es valida";
    END IF;
END //
DELIMITER ;

-- 3. Trigger para actualizar el stock de un insumo al realizar una orden de compra
DROP TRIGGER IF EXISTS afterInsertInsumoXOrdenCompraStock;

DELIMITER //
CREATE TRIGGER afterInsertInsumoXOrdenCompraStock
AFTER INSERT ON InsumoXOrdenCompra FOR EACH ROW
BEGIN
    UPDATE Insumo SET stock=stock+NEW.cantidad WHERE idInsumo=NEW.idInsumo;
END //
DELIMITER ;

-- 4. Trigger para actualizar el total de una venta al hacer un registro en ProductoXVenta
DROP TRIGGER IF EXISTS afterInsertProductoXVenta;

DELIMITER //
CREATE TRIGGER afterInsertProductoXVenta
AFTER INSERT ON ProductoXVenta FOR EACH ROW
BEGIN
    DECLARE subtotal DECIMAL(10,2);

    SELECT precio*NEW.cantidad INTO subtotal FROM Producto WHERE idProducto=NEW.idProducto;

    UPDATE Venta SET total=total+subtotal WHERE idVenta=NEW.idVenta;
END //
DELIMITER ;

-- 5. Trigger para no permitir eliminar un producto si tiene un stock mayor a 0
DROP TRIGGER IF EXISTS beforeDeleteProducto;

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

-- 6. Trigger para actualizar el stock de producto cuando se registra en CultivoXProducto
DROP TRIGGER IF EXISTS afterInsertCultivoXProducto;

DELIMITER //
CREATE TRIGGER afterInsertCultivoXProducto
AFTER INSERT ON CultivoXProducto FOR EACH ROW
BEGIN 
    UPDATE Producto SET stock=stock+NEW.cantidad WHERE idProducto=NEW.idProducto;
END //
DELIMITER ;

-- 7. Trigger para registrar la actualizacion de salario de un empleado
DROP TRIGGER IF EXISTS afterUpdateEmpleadoSalario;

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
DROP TRIGGER IF EXISTS beforeUpdateConsultaVeterinariaEstado;

DELIMITER //
CREATE TRIGGER beforeUpdateConsultaVeterinariaEstado
BEFORE UPDATE ON ConsultaVeterinaria FOR EACH ROW
BEGIN 
    IF (NEW.fecha>NOW() AND NEW.estado="Realizada") THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Error: No se puede marcar una consulta veteriaria como realizada cuando la fecha programada no ha pasado";
    END IF;
END //
DELIMITER ;

-- 9. Trigger para no permitir eliminar un tipo de animal si tiene animales relacionados
DROP TRIGGER IF EXISTS beforeDeleteTipoAnimal;

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
DROP TRIGGER IF EXISTS afterInsertProductoXVentaStock;

DELIMITER //
CREATE TRIGGER afterInsertProductoXVentaStock
AFTER INSERT ON ProductoXVenta FOR EACH ROW
BEGIN
    UPDATE Producto SET stock=stock-NEW.cantidad WHERE idProducto=NEW.idProducto;
END //
DELIMITER ;

-- 11. Trigger para registrar la actualizacion del costo de un insumo
DROP TRIGGER IF EXISTS afterUpdateInsumoXProveedorCosto;

DELIMITER //
CREATE TRIGGER afterUpdateInsumoXProveedorCosto
AFTER UPDATE ON InsumoXProveedor FOR EACH ROW
BEGIN
    IF NEW.costo<>OLD.costo THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(1,CONCAT("Actualizacion costo insumo idInsumo: ",OLD.idInsumo," idProveedor: ",OLD.idProveedor," costo anterior: ",OLD.costo," costo nuevo: ",NEW.costo), NOW());
    END IF;
END //
DELIMITER ;

-- 12. Trigger para actualizar el stock de un producto cuando se registre en RecintoXProducto
DROP TRIGGER IF EXISTS afterInsertRecintoXProducto;

DELIMITER //
CREATE TRIGGER afterInsertRecintoXProducto
AFTER INSERT ON RecintoXProducto FOR EACH ROW
BEGIN 
    UPDATE Producto SET stock=stock+NEW.cantidad WHERE idProducto=NEW.idProducto;
END //
DELIMITER ;

-- 13. Trigger para registrar la actualizacion de precio de un producto
DROP TRIGGER IF EXISTS afterUpdateProductoPrecio;

DELIMITER //
CREATE TRIGGER afterUpdateProductoPrecio
AFTER UPDATE ON Producto FOR EACH ROW
BEGIN
    IF NEW.precio<>OLD.precio THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(1,CONCAT("Actualizacion precio producto idProducto: ",OLD.idProducto," precio anterior: ",OLD.precio," precio nuevo: ",NEW.precio), NOW());
    END IF;
END //
DELIMITER ;

-- 14. Trigger para registrar la inserccion de un empleado
DROP TRIGGER IF EXISTS afterInsertEmpleado;

DELIMITER //
CREATE TRIGGER afterInsertEmpleado
AFTER INSERT ON Empleado FOR EACH ROW
BEGIN
    INSERT INTO Log(idEntidad, mensaje, fecha)
    -- Revisar id de entidad
    VALUES(1,CONCAT("Inserccion empleado idEmpleado: ",NEW.idEmpleado," idCargo: ",NEW.idCargo," nombre: ",NEW.nombre," estado: ",NEW.estado," fechaContratacion: ",NEW.fechaContratacion," salario: ",NEW.salario), NOW());
END //
DELIMITER ;

-- 15. Trigger para registrar la novedad del estado de un animal
DROP TRIGGER IF EXISTS afterUpdateAnimalEstado;

DELIMITER //
CREATE TRIGGER afterUpdateAnimalEstado
AFTER UPDATE ON Animal FOR EACH ROW
BEGIN
    IF NEW.estado<>OLD.estado THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(1,CONCAT("Actualizacion estado animal idAnimal: ",OLD.idAnimal," estado anterior: ",OLD.estado," estado nuevo: ",NEW.estado), NOW());
    END IF;
END //
DELIMITER ;

-- 16. Trigger para registrar la actualizacion de cargo de un empleado
DROP TRIGGER IF EXISTS afterUpdateEmpleadoCargo;

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
DROP TRIGGER IF EXISTS afterUpdateProveedorEstado;

DELIMITER //
CREATE TRIGGER afterUpdateProveedorEstado
AFTER UPDATE ON Proveedor FOR EACH ROW
BEGIN
    IF NEW.activo<>OLD.activo THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(1,CONCAT("Actualizacion activo proveedor idProveedor: ",OLD.idProveedor," activo anterior: ",OLD.activo," activo nuevo: ",NEW.activo), NOW());
    END IF;
END //
DELIMITER ;

-- 18. Trigger para registrar la realizacion de una orden de compra
DROP TRIGGER IF EXISTS afterInsertOrdenCompra;

DELIMITER //
CREATE TRIGGER afterInsertOrdenCompra
AFTER INSERT ON OrdenCompra FOR EACH ROW
BEGIN
    INSERT INTO Log(idEntidad, mensaje, fecha)
    -- Revisar id de entidad
    VALUES(1,CONCAT("Inserccion orden compra idOrdenCompra: ",NEW.idOrdenCompra," fecha: ",NEW.fecha," total: ",NEW.total), NOW());
END //
DELIMITER ;

-- 19. Trigger para evitar insertar valores erroneos en la fecha de cosecha de un cultivo
DROP TRIGGER IF EXISTS afterUpdateCultivoFechaCosecha;

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
DROP TRIGGER IF EXISTS afterUpdateMaquinariaEstado;

DELIMITER //
CREATE TRIGGER afterUpdateMaquinariaEstado
AFTER UPDATE ON Maquinaria FOR EACH ROW
BEGIN
    IF OLD.estado<>NEW.estado THEN
        INSERT INTO Log(idEntidad, mensaje, fecha)
        -- Revisar id de entidad
        VALUES(1,CONCAT("Actualizacion estado maquinaria idMaquinaria: ",OLD.idMaquinaria," estado anterior: ",OLD.estado," estado nuevo: ",NEW.estado), NOW());
    END IF;
END //
DELIMITER ;