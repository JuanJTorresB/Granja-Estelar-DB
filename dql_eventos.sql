-- 1. Evento para registrar las ventas hechas durante el dia
DROP EVENT IF EXISTS registroVentasDia;

CREATE EVENT registroVentasDia
ON SCHEDULE EVERY 1 DAY
DO
    INSERT INTO Historico(fecha, total)
    VALUES(NOW(), totalVentasPeriodo(CURDATE(),CURDATE()));

-- 2. Evento para subir sueldo de los empleados un 5% cada año
DROP EVENT IF EXISTS subirSueldos;

CREATE EVENT subirSueldos
ON SCHEDULE EVERY 1 YEAR
DO
    UPDATE Empleado SET salario=salario+(salario*0.05);

-- 3. Evento para eliminar los clientes que no hacen compras hace mas de un año
DROP EVENT IF EXISTS eliminarClientesInactivos;

CREATE EVENT eliminarClientesInactivos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Cliente WHERE numeroComprasCliente(idCliente,CURDATE()-INTERVAL 1 YEAR, CURDATE())=0;

-- 4. Evento para eliminar los log de hace mas de dos años
DROP EVENT IF EXISTS eliminarLogsAntiguos;

CREATE EVENT eliminarLogsAntiguos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Log WHERE fecha<=(NOW()-INTERVAL 2 YEAR);
    
-- 5. Evento para realizar mantenimiento cada 6 meses a una maquinaria
DROP EVENT IF EXISTS mantenimientoMaquinaria;

CREATE EVENT mantenimientoMaquinaria
ON SCHEDULE EVERY 6 MONTH
DO
    INSERT INTO Mantenimiento(idMaquinaria,fecha,costo)
    VALUES (1,CURDATE(),100000);


-- 6. Evento para eliminar las consultas veterinarias de hace mas de 2 años
DROP EVENT IF EXISTS eliminarConsultasVeterinarias;

CREATE EVENT eliminarConsultasVeterinarias
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM ConsultaVeterinaria WHERE fecha<(NOW()-INTERVAL 2 YEAR);

-- 7. Evento para subir el precio a los productos un 10% cada año
DROP EVENT IF EXISTS subirPrecioProductos;

CREATE EVENT subirPrecioProductos
ON SCHEDULE EVERY 1 YEAR
DO
    UPDATE Producto SET precio=precio+(precio*0.10);

-- 8. Evento para programar una consulta veterinaria para los animales enfermos
DROP EVENT IF EXISTS programarConsulta;

CREATE EVENT programarConsulta
ON SCHEDULE EVERY 1 DAY
DO
    INSERT INTO ConsultaVeterinaria(idAnimal,fecha,costo,estado)
    SELECT a.idAnimal, NOW()+ INTERVAL 1 WEEK, 50000, "Por realizar"
    FROM Animal a
    JOIN ConsultaVeterinaria cv ON cv.idAnimal=a.idAnimal
    WHERE a.estado="Enfermo" AND consultasProgramadasAnimal(a.idAnimal)=0;

-- 9. Actualizar estado de empleados que se encuentran en vacaciones
DROP EVENT IF EXISTS actualizarEstadoEmpleadoSalirVacaciones;

CREATE EVENT actualizarEstadoEmpleadoSalirVacaciones
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE Empleado SET estado="No disponible"
    WHERE idEmpleado IN (
        SELECT idEmpleado 
        FROM Vacacion
        WHERE CURDATE() BETWEEN fechaInicio AND fechaFin
    );

-- 10. Evento para eliminar los proveedores que estan inactivos y no se han utilizado en mas de un año
DROP EVENT IF EXISTS eliminarProveedoresInactivos;

CREATE EVENT eliminarProveedoresInactivos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Proveedor WHERE numeroComprasProveedor(idProveedor, CURDATE()-INTERVAL 1 YEAR, CURDATE())=0 AND activo="Inactivo";

-- 11. Evento para actualizar el estado de los empleados luego que vuelvan de vacaciones
DROP EVENT IF EXISTS actualizarEstadoEmpleadoEntrarVacaciones;

CREATE EVENT actualizarEstadoEmpleadoEntrarVacaciones
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE Empleado SET estado="Activo"
    WHERE idEmpleado IN (
        SELECT idEmpleado 
        FROM Vacacion
        WHERE fechaFin<CURDATE()
    ) AND estado="No disponible";

-- 12. Evento para actualizar el estado de una vacacion de empleado a en curso
DROP EVENT IF EXISTS actualizarEstadoVacacionEnCurso;

CREATE EVENT actualizarEstadoVacacionEnCurso
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE Vacacion SET estado="En curso"
    WHERE fechaInicio<=CURDATE() AND fechaFin>=CURDATE()
    AND estado="Pendiente";

-- 13. Evento para actualizar el estado de una maquinaria cuando le van a realizar un mantenimiento
DROP EVENT IF EXISTS ActualizarEstadoMaquinariaMantenimiento;

CREATE EVENT ActualizarEstadoMaquinariaMantenimiento
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE Maquinaria SET estado="En mantenimiento"
    WHERE idMaquinaria IN(
        SELECT idMaquinaria
        FROM Mantenimiento
        WHERE fecha=CURDATE()
    );

-- 14. Evento para generar registrar una alerta cuando un insumo tenga bajo stock
DROP EVENT IF EXISTS registrarBajoStockInsumo;

CREATE EVENT registrarBajoStockInsumo
ON SCHEDULE EVERY 1 WEEK
DO
    -- Revisar id entidad
    INSERT INTO Log(idEntidad,mensaje,fecha)
    SELECT 1,CONCAT("Insumo con stock bajo ","idInsumo: ",idInsumo," nombre: ",nombre," stock: ",stock), NOW()
    FROM Insumo
    WHERE stock<20;

-- 15. Evento para eliminar los mantenimientos hechos hace mas de dos años
DROP EVENT IF EXISTS eliminarMantenimientos;

CREATE EVENT eliminarMantenimientos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Mantenimiento WHERE fecha<(NOW()-INTERVAL 2 YEAR);

-- 16. Evento para actualizar el estado de una vacacion de empleado a disfrutada
DROP EVENT IF EXISTS actualizarEstadoVacacionDisfrutada;

CREATE EVENT actualizarEstadoVacacionDisfrutada
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE Vacacion SET estado="Disfrutada"
    WHERE fechaFin<CURDATE()
    AND estado="En Curso";

-- 17. Evento para actualizar el estado de una maquinaria cuando termino un mantenimiento
DROP EVENT IF EXISTS ActualizarEstadoMaquinariaDisponible;

CREATE EVENT ActualizarEstadoMaquinariaDisponible
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE Maquinaria SET estado="Disponible"
    WHERE idMaquinaria IN(
        SELECT idMaquinaria
        FROM Mantenimiento
        WHERE ultimoMantenimientoMaquinaria(idMaquinaria)<CURDATE()
    ) AND estado="En Mantenimiento";

-- 18. Evento para registrar una alerta de producto bajo en stock
DROP EVENT IF EXISTS registrarBajoStockProducto;

CREATE EVENT registrarBajoStockProducto
ON SCHEDULE EVERY 1 DAY
DO
    -- Revisar id entidad
    INSERT INTO Log(idEntidad,mensaje,fecha)
    SELECT 1, CONCAT("Producto con stock bajo ", "id producto: ",idProducto," nombre: ",nombre," stock: ",stock), NOW()
    FROM Producto
    WHERE stock<30;

-- 19. Evento para registrar una alerta de pocos proveedores para un insumo
DROP EVENT IF EXISTS registrarPocosProveedoresInsumo;

CREATE EVENT registrarPocosProveedoresInsumo
ON SCHEDULE EVERY 1 WEEK
DO
    -- Revisar id entidad
    INSERT INTO Log(idEntidad,mensaje,fecha)
    SELECT 1, CONCAT("Pocos proveedores para insumo ","idInsumo ",idInsumo," nombre insumo: ",nombre,"numero de proveedores: ",numeroProveedores(idInsumo)),NOW()
    FROM Insumo
    WHERE numeroProveedores(idInsumo)<=2;

-- 20. Evento para eliminar vacaciones de los empleados de hace mas de dos años
DROP EVENT IF EXISTS eliminarVacaciones;

CREATE EVENT eliminarVacaciones
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Vacacion WHERE fechaFin<CURDATE()-INTERVAL 2 YEAR;