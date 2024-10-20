
--Evitar que los productos puedan ser añadidos con un stock menor a 0

DELIMITER //
CREATE TRIGGER beforeInsertProducto 
BEFORE INSERT ON Producto FOR EACH ROW
    IF NEW.stock <0 THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT = "El stock no puede ser menor a 0";
    END IF //
DELIMITER ;