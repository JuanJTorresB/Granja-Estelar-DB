-- 1. Funcion para calcular el total de ventas entre dos fechas
DROP FUNCTION IF EXISTS totalVentasPeriodo;

DELIMITER //
CREATE FUNCTION totalVentasPeriodo(fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalVentas DECIMAL(10,2);
    SELECT SUM(total) INTO totalVentas FROM Venta WHERE fechaInicial<=DATE(fecha) AND fechaFinal>=DATE(fecha);
    RETURN totalVentas;
END //
DELIMITER ;

-- 2. Funcion para calcular la cantidad de animales de un tipo en especifico
DROP FUNCTION IF EXISTS totalAnimales;

DELIMITER //
CREATE FUNCTION totalAnimales(_idTipoAnimal INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SELECT COUNT(idAnimal) INTO cantidad FROM Animal WHERE idTipoAnimal=_idTipoAnimal;
    RETURN cantidad;
END //
DELIMITER ;

-- 3. Funcion para obtener el total de producto obtenido en un periodo de tiempo
DROP FUNCTION IF EXISTS totalProducto;

DELIMITER //
CREATE FUNCTION totalProducto(_idProducto INT, fechaInicio DATE, fechaFin DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidadProducto INT;
    SELECT SUM(cp.cantidad) INTO cantidadProducto
    FROM CultivoXProducto cp
    JOIN Cultivo c ON c.idCultivo=cp.idCultivo
    WHERE cp.idProducto=_idProducto AND c.fechaCosecha BETWEEN fechaInicio AND fechaFin;
    RETURN cantidadProducto;
END//
DELIMITER ;

-- 4. Funcion para obtener el total de ventas de un producto en un periodo de tiempo
DROP FUNCTION IF EXISTS totalVentasProducto;

DELIMITER //
CREATE FUNCTION totalVentasProducto(_idProducto INT, fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE cantidadProducto INT;
    DECLARE ventaProducto DECIMAL(10,2);

    SELECT SUM(pv.cantidad) INTO cantidadProducto
    FROM ProductoXVenta pv
    JOIN Venta v ON pv.idVenta=v.idVenta
    WHERE DATE(v.fecha) BETWEEN fechaInicial AND fechaFinal AND pv.idProducto=_idProducto;

    SELECT precio*cantidadProducto INTO ventaProducto FROM Producto WHERE idProducto=_idProducto;

    RETURN ventaProducto;
END //
DELIMITER ;

-- 5. Funcion para calcular el rendimiento del cultivo
DROP FUNCTION IF EXISTS rendimientoCultivo;

DELIMITER //
CREATE FUNCTION rendimientoCultivo(_idCultivo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE areaCultivo DECIMAL(10,2);
    DECLARE rendimiento DECIMAL(10,2);

    SELECT area INTO areaCultivo FROM Cultivo WHERE idCultivo=_idCultivo LIMIT 1;
    
	IF areaCultivo = 0 THEN
		RETURN 0;
	END IF;

    SELECT (cantidad/areaCultivo) INTO rendimiento FROM CultivoXProducto WHERE idCultivo=_idCultivo LIMIT 1;

    RETURN rendimiento;
END //
DELIMITER ;


-- 6. Funcion para calcular salario de empleado en un periodo de tiempo
DROP FUNCTION IF EXISTS salarioEmpleado;

DELIMITER //
CREATE FUNCTION salarioEmpleado(_idEmpleado INT, fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    DECLARE salarioDia DECIMAL(10,2);

    IF fechaInicial<(SELECT fechaContratacion FROM Empleado WHERE idEmpleado=_idEmpleado) THEN
        SIGNAL SQLSTATE "45000"
        SET MESSAGE_TEXT="Error: La fecha inicial no puede ser menor a la fecha de contratacion";
    END IF;

    SELECT (salario/30) INTO salarioDia FROM Empleado WHERE idEmpleado=_idEmpleado;

    SELECT salarioDia*DATEDIFF(FechaFinal,fechaInicial) INTO total;

    RETURN total;
END //
DELIMITER ;

-- 7. Funcion para calcular el valor total de compras realizadas por un cliente en un periodo
DROP FUNCTION IF EXISTS totalComprasCliente;

DELIMITER //
CREATE FUNCTION totalComprasCliente(_idCliente INT,fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalVentas DECIMAL(10,2);
    SELECT SUM(total) INTO totalVentas FROM Venta WHERE fechaInicial<=DATE(fecha) AND fechaFinal>=DATE(fecha) AND idCliente=_idCliente;
    RETURN totalVentas;
END //
DELIMITER ;

-- 8. Funcion para obtener el id del proveedor que tiene el menor precio de un insumo
DROP FUNCTION IF EXISTS obtenerProveedorMenorPrecio;

DELIMITER //
CREATE FUNCTION obtenerProveedorMenorPrecio(_idInsumo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE id INT;

    SELECT idProveedor INTO id
    FROM InsumoXProveedor
    WHERE idInsumo=_idInsumo AND costo=(
        SELECT MIN(costo)
        FROM InsumoXProveedor
        WHERE idInsumo=_idInsumo
    ) 
    LIMIT 1;

    RETURN id;
END //
DELIMITER ;

-- 9. Funcion para calcular la cantidad de consultas veterinarias programadas para un animal
DROP FUNCTION IF EXISTS consultasProgramadasAnimal;

DELIMITER //
CREATE FUNCTION consultasProgramadasAnimal(_idAnimal INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(idAnimal) INTO cantidad 
    FROM ConsultaVeterinaria
    WHERE idAnimal=_idAnimal AND fecha>NOW();

    RETURN cantidad;
END //
DELIMITER ;

-- 10. Funcion para obtener el dinero gastado en insumos en un periodo de tiempo
DROP FUNCTION IF EXISTS costoInsumos;

DELIMITER //
CREATE FUNCTION costoInsumos(fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE costo DECIMAL(10,2);
    SELECT SUM(total) INTO costo FROM OrdenCompra
    WHERE fecha BETWEEN fechaInicial AND fechaFinal;
    RETURN costo;
END //
DELIMITER ;

-- 11. Funcion para calcular el numero de proveedores que hay para un insumo
DROP FUNCTION IF EXISTS numeroProveedores;

DELIMITER //
CREATE FUNCTION numeroProveedores(_idInsumo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SET cantidad=0;

    SELECT COUNT(ip.idProveedor) INTO cantidad
    FROM InsumoXProveedor ip
    JOIN Proveedor p ON p.idProveedor=ip.idProveedor
    WHERE ip.idInsumo=_idInsumo AND p.activo="Activo";

    RETURN cantidad;
END //
DELIMITER ;

-- 12. Funcion para calcular el numero de compras hechas a un proveedor en un periodo
DROP FUNCTION IF EXISTS numeroComprasProveedor;

DELIMITER //
CREATE FUNCTION numeroComprasProveedor(_idProveedor INT,fechaInicial DATE, fechaFinal DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numeroCompras INT;
    
    SELECT COUNT(op.idProveedor) INTO numeroCompras 
    FROM OrdenCompraXProveedor op 
    JOIN OrdenCompra o ON o.idOrdenCompra=op.idOrdenCompra
    WHERE fechaInicial<=DATE(o.fecha) AND fechaFinal>=DATE(o.fecha) AND op.idProveedor=_idProveedor;
    
    RETURN numeroCompras;
END //
DELIMITER ;

-- 13. Función para obtener el último mantenimiento de una máquina
DROP FUNCTION IF EXISTS ultimoMantenimientoMaquinaria;

DELIMITER //
CREATE FUNCTION ultimoMantenimientoMaquinaria(_idMaquinaria INT)
RETURNS DATE
DETERMINISTIC
BEGIN
    DECLARE fechaRetornar DATE;

    SELECT MAX(fecha) INTO fechaRetornar
    FROM Mantenimiento
    WHERE idMaquinaria=_idMaquinaria;

    RETURN fechaRetornar;
END //
DELIMITER ;

-- 14. Funcion para obtener el numero de veces que se ha utilizado un tipo de cultivo
DROP FUNCTION IF EXISTS cantidadTipoCultivo;

DELIMITER //
CREATE FUNCTION cantidadTipoCultivo(_idTipoCultivo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(idCultivo) INTO cantidad
    FROM Cultivo
    WHERE idTipoCultivo=_idTipoCultivo;

    RETURN cantidad;
END //
DELIMITER ;

-- 15. Funcion para calcular el numero de compras realizadas por un cliente en un periodo
DROP FUNCTION IF EXISTS numeroComprasCliente;

DELIMITER //
CREATE FUNCTION numeroComprasCliente(_idCliente INT,fechaInicial DATE, fechaFinal DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numeroCompras INT;
    SELECT COUNT(idCliente) INTO numeroCompras FROM Venta WHERE fechaInicial<=DATE(fecha) AND fechaFinal>=DATE(fecha) AND idCliente=_idCliente;
    RETURN numeroCompras;
END //
DELIMITER ;

-- 16. Funcion para obtener el total de ventas que ha realizado un empleado en un periodo de tiempo
DROP FUNCTION IF EXISTS totalVentasEmpleado;

DELIMITER //
CREATE FUNCTION  totalVentasEmpleado(_idEmpleado INT, fechaInicial DATE, fechaFinal DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalVenta DECIMAL(10,2);

    SELECT SUM(total) INTO totalVenta
    FROM Venta
    WHERE idEmpleado=_idEmpleado AND fecha BETWEEN fechaInicial AND fechaFinal;

    RETURN totalVenta;
END //
DELIMITER ;

-- 17. Funcion para obtener la cantidad comprada de un insumo en un periodo de tiempo
DROP FUNCTION IF EXISTS cantidadInsumo;

DELIMITER //
CREATE FUNCTION cantidadInsumo(_idInsumo INT, fechaInicial DATE, fechaFinal DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidadInsumo INT;

    SELECT SUM(io.cantidad) INTO cantidadInsumo
    FROM InsumoXOrdenCompra io
    JOIN OrdenCompra oc ON oc.idOrdenCompra=io.idOrdenCompra
    WHERE io.idInsumo=_idInsumo AND oc.fecha BETWEEN fechaInicial AND fechaFinal;

    RETURN cantidadInsumo;
END //
DELIMITER ;

-- 18. Funcion para calcular los dias que lleva en la empresa un trabajador
DROP FUNCTION IF EXISTS diasEmpresaEmpleado;

DELIMITER //
CREATE FUNCTION diasEmpresaEmpleado(_idEmpleado INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT DATEDIFF(CURDATE(), DATE(fechaContratacion)) INTO cantidad
    FROM Empleado
    WHERE idEmpleado=_idEmpleado;

    RETURN cantidad;
END //
DELIMITER ;

-- 19. Funcion para obtener el total de ventas de una categoria
DROP FUNCTION IF EXISTS totalVentasCategoria;

DELIMITER //
CREATE FUNCTION totalVentasCategoria(_idCategoria INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalVentas DECIMAL(10,2);

    SELECT SUM(v.total) INTO totalVentas
    FROM Venta v
    JOIN ProductoXVenta pv ON v.idVenta=pv.idVenta
    JOIN Producto p ON p.idProducto=pv.idProducto
    JOIN Categoria c ON c.idCategoria=p.idCategoria
    WHERE C.idCategoria=_idCategoria;

    RETURN totalVentas;
END //
DELIMITER ;

-- 20. Funcion para calcular el total gastado en consultas veterinarias en un intervalo de fechas
DROP FUNCTION IF EXISTS costoConsultasVeterinarias;

DELIMITER //
CREATE FUNCTION costoConsultasVeterinarias(fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(costo) INTO total FROM ConsultaVeterinaria WHERE DATE(fecha) BETWEEN fechaInicial AND fechaFinal;
    RETURN total;
END //
DELIMITER ;