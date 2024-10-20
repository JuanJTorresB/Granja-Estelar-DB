
-- Total de ventas en un periodo específico de tiempo

DELIMITER //
CREATE FUNCTION totalVentasPeriodo(fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
BEGIN
    DECLARE totalVentas DECIMAL(10,2);
    SELECT SUM(total) INTO totalVentas FROM Venta WHERE fechaInicial>=fecha AND fechaFinal<=fecha;
    RETURN totalVentas;
END //
DELIMITER ;