<div align="center">
  <a href="https://github.com/JuanJTorresB/Granja-Estelar-DB.git">
    <img src="Granja Estelar Logo.png">
  </a>
<h1 text-align="center">Granja Estelar DataBase</h1>
</div>

## Tabla de Contenidos 🔗
1. [Información General](#información-general-)
2. [Requisitos del Sistema](#requisitos-del-sistema-)
3. [Instalación y Configuración](#instalación-y-configuración-)
4. [Estructura de la Base de Datos](#estructura-de-la-base-de-datos-)
5. [Algunas Consultas](#algunas-consultas-)
6. [Procedimientos](#procedimientos-)
7. [Funciones](#funciones-)
8. [Triggers](#triggers-)
9. [Eventos](#eventos-)
10. [Roles de Usuario y Permisos](#roles-de-usuario-y-permisos-%EF%B8%8F)
11. [Como Aportar](#como-aportar-)
12. [Autores](#autores-)

## Información General 📒
Granja Estelar Database es una base de datos creada en MySQL que busca llevar un registro y facilitar el acceso a informacion sobre la produccion agricola de una granja

## Requisitos del Sistema 📋

- MySQL versión 8.0
- Cliente MySQL Workbench
ó
- CLiente Dbeaver

## Instalación y Configuración 📦
```bash
git clone https://github.com/JuanJTorresB/Granja-Estelar-DB.git
```
Desde MySQL Workbench o Dbeaver:

1. Ejecuta el (ddl.sql) para la creacion de la tablas
2. Ejecuta el (dml.sql) para hacer incersiones dentro de las tablas

- Apartir de aqui puedes ejecutar los distintos eventos(dql_eventos.sql), procedimientos(dql_procedimientos.sql), funciones(dql_funciones.sql), triggers(dql_triggers.sql) y consultas(dql_select.sql) desde los archivos o desde este mismo archivo en secciones mas abajo

## Estructura de la Base de Datos 🗃️

<img src="Granja Estelar UML E-R JPG.jpg">

En este Documento se especifican las entidades, sus propiedades y las relaciones

[HTML DOCS](https://juanjtorresb.github.io/Granja-Estelar-HTML-Docs/)


## Algunas Consultas 🔎

```sql

```

## Procedimientos ⚙️

#### 1. Procedimiento para insertar un empleado

```sql
DROP PROCEDURE IF EXISTS insertarEmpleado;

DELIMITER //
CREATE PROCEDURE insertarEmpleado(IN _idCargo INT, IN _nombre VARCHAR(255), IN _estado ENUM("Activo","Inactivo"), IN _fechaContratacion DATE, IN _salario DECIMAL(10,2))
BEGIN
    INSERT INTO Empleado(idCargo, nombre, estado, fechaContratacion, salario)
    VALUES (_idCargo, _nombre, _estado, _fechaContratacion, _salario);
END //
DELIMITER ;
```
#### 2. Procedimiento para consultar los empleados que estan trabajando en el momento
```sql
DROP PROCEDURE IF EXISTS empleadosDisponibles;

DELIMITER //
CREATE PROCEDURE empleadosDisponibles()
BEGIN
    SELECT c.nombre AS "Cargo", e.nombre AS "Empleado", h.horaInicio AS "Hora entrada", h.horaFin AS "Hora salida"
    FROM Cargo c
    JOIN Empleado e ON c.idCargo=e.idCargo
    JOIN EmpleadoXHorario eh ON e.idEmpleado=eh.idEmpleado
    JOIN Horario h ON h.idHorario=eh.idHorario
    JOIN Dia d ON d.idDia=H.idDia
    WHERE d.idDia=DAYOFWEEK(NOW()) AND h.horaInicio<=TIME(NOW()) AND h.horaFin>TIME(NOW()) AND e.estado="Activo";
END //
DELIMITER ;
```
#### 3. Procedimiento para obtener las tareas relacionadas a un empleado en un dia especifico
```sql
DROP PROCEDURE IF EXISTS tareasRelacionadasEmpleado;

DELIMITER //
CREATE PROCEDURE tareasRelacionadasEmpleado(IN _idEmpleado INT, IN dia DATE)
BEGIN
    SELECT t.descripcion AS "Tarea", TIME(t.fechaInicio) AS "Hora inicio", TIME(t.fechaFin) AS "Hora fin", t.descripcion AS "Descripcion" 
    FROM Tarea t
    JOIN EmpleadoXTarea et ON t.idTarea=et.idTarea
    WHERE et.idEmpleado=_idEmpleado AND DATE(t.fechaInicio)=dia;
END //
DELIMITER ;
```
#### 4. Procedimiento para obtener la cantidad y tipo de animal por recinto
```sql
DROP PROCEDURE IF EXISTS obtenerCantidadAnimalRecinto;

DELIMITER //
CREATE PROCEDURE obtenerCantidadAnimalRecinto()
BEGIN
    SELECT r.nombre AS "Recinto", t.nombre AS "Animal", COUNT(a.idAnimal) AS "Cantidad"
    FROM TipoAnimal t
    JOIN Animal a ON a.idTipoAnimal=t.idTipoAnimal
    JOIN Recinto r ON r.idRecinto=a.idRecinto
    GROUP BY r.nombre, t.nombre;
END //
DELIMITER ;
```
#### 5. Procedimiento para obtener los cultivos que estan en temporada en una fecha especifica
```sql
DROP PROCEDURE IF EXISTS obtenerCultivosTemporada;

DELIMITER //
CREATE PROCEDURE obtenerCultivosTemporada(IN fecha DATE)
BEGIN
    SELECT nombre AS "Cultivo", inicioTemporada, finTemporada FROM TipoCultivo
    WHERE inicioTemporada<=fecha AND finTemporada>=fecha;
END //
DELIMITER ;
```
#### 6. Procedimiento para obtener los proveedores para un determinado producto
```sql
DROP PROCEDURE IF EXISTS obtenerProveedoresInsumo;

DELIMITER //
CREATE PROCEDURE obtenerProveedoresInsumo(IN _idInsumo INT)
BEGIN
    SELECT p.nombre AS "Proveedor",  ip.costo AS "Costo"
    FROM Proveedor p
    JOIN InsumoXProveedor ip ON ip.idProveedor=p.idProveedor
    WHERE ip.idInsumo=_idInsumo;
END //
DELIMITER ;
```
#### 7. Procedimiento para obtener las herramientas que estan en un determinado almacen
```sql
DROP PROCEDURE IF EXISTS herramientasAlmacen;

DELIMITER //
CREATE PROCEDURE herramientasAlmacen(IN _idAlmacen INT)
BEGIN
    SELECT t.nombre AS "Tipo herramienta", COUNT(ah.idHerramienta) AS "Cantidad"
    FROM TipoHerramienta t
    JOIN Herramienta h ON t.idTipoHerramienta=h.idTipoHerramienta
    JOIN AlmacenXHerramienta ah ON ah.idHerramienta=h.idHerramienta
    WHERE ah.idAlmacen=_idAlmacen
    GROUP BY t.nombre;
END //
DELIMITER ;
```
#### 8. Procedimiento para registrar un mantenimiento a una maquinaria especifica
```sql
DROP PROCEDURE IF EXISTS registrarMantenimiento;

DELIMITER //
CREATE PROCEDURE registrarMantenimiento(IN _idMaquinaria INT, IN _fecha DATE, IN _costo DECIMAL(10,2))
BEGIN
    INSERT INTO Mantenimiento(idMaquinaria, fecha, costo)
    VALUES (_idMaquinaria,_fecha,_costo);
END //
DELIMITER ;
```
#### 9. Procedimiento para obtener los trabajadores asignados por cultivo
```sql
DROP PROCEDURE IF EXISTS trabajadoresCultivo;

DELIMITER //
CREATE PROCEDURE trabajadoresCultivo()
BEGIN
    SELECT tc.nombre AS "Tipo cultivo", c.idCultivo AS "Cultivo", COUNT(et.idEmpleado) AS "Cantidad"
    FROM TipoCultivo tc
    JOIN Cultivo c ON tc.idTipoCultivo=c.idTipoCultivo
    JOIN TareaXCultivo txc ON c.idCultivo=txc.idCultivo
    JOIN Tarea t ON txc.idTarea=t.idTarea
    JOIN EmpleadoXTarea et ON et.idTarea=t.idTarea
    GROUP BY tc.nombre, c.idCultivo;
END //
DELIMITER ;
```
#### 10. Procedimiento para obtener el numero de cultivos en una zona de acuerdo a su tipo de cultivo
```sql
DROP PROCEDURE IF EXISTS cultivosZona;

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
```
#### 11. Procedimiento para insertar un proveedor
```sql
DROP PROCEDURE IF EXISTS insertarProveedor;

DELIMITER //
CREATE PROCEDURE insertarProveedor(IN _nombre VARCHAR(100), IN _activo ENUM("Activo", "Inactivo"))
BEGIN
    INSERT INTO Proveedor(nombre,activo)
    VALUES(_nombre, _activo);
END //
DELIMITER ;
```
#### 12. Procedimiento para obtener la cantidad de productos obtenidos en un recinto especifico
```sql
DROP PROCEDURE IF EXISTS cantidadProductoRecinto;

DELIMITER //
CREATE PROCEDURE cantidadProductoRecinto(IN _idRecinto INT)
BEGIN
    SELECT p.nombre AS "Producto", SUM(rp.cantidad) AS "Cantidad"
    FROM Producto p
    JOIN RecintoXProducto rp ON rp.idProducto=p.idProducto
    WHERE rp.idRecinto=_idRecinto
    GROUP BY p.nombre;
END //
DELIMITER ;
```
#### 13. Procedimiento para obtener los insumos utilizados en un determinado tipo de cultivo
```sql
DROP PROCEDURE IF EXISTS insumosCultivo;

DELIMITER //
CREATE PROCEDURE insumosCultivo(IN _idTipoCultivo INT)
BEGIN
    SELECT ti.nombre AS "Tipo de insumo", i.nombre AS "Insumo", i.stock AS "Stock" 
    FROM TipoInsumo ti
    JOIN Insumo i ON i.idTipoInsumo=ti.idTipoInsumo
    JOIN CultivoXInsumo ci ON ci.idInsumo=i.idInsumo
    JOIN Cultivo c ON c.idCultivo=ci.idCultivo
    JOIN TipoCultivo tc ON tc.idTipoCultivo=c.idTipoCultivo
    WHERE tc.idTipoCultivo=_idTipoCultivo;
END //
DELIMITER ;
```
#### 14. Procedimiento para obtener los proveedores y el costo se tienen para un insumo
```sql
DROP PROCEDURE IF EXISTS proveedoresInsumo;

DELIMITER //
CREATE PROCEDURE proveedoresInsumo(IN _idInsumo INT)
BEGIN
    SELECT p.nombre AS "Proveedor", ip.costo AS "Costo"
    FROM Proveedor p
    JOIN InsumoXProveedor ip ON ip.idProveedor=p.idProveedor
    WHERE ip.idInsumo=_idInsumo;
END //
DELIMITER ;
```
#### 15. Procedimiento para obtener la maquinaria que esta en un determinado almacen
```sql
DROP PROCEDURE IF EXISTS maquinariaAlmacen;

DELIMITER //
CREATE PROCEDURE maquinariaAlmacen(IN _idAlmacen INT)
BEGIN
    SELECT t.nombre AS "Tipo maquinaria", COUNT(am.idMaquinaria) AS "Cantidad"
    FROM TipoMaquinaria t
    JOIN Maquinaria m ON t.idTipoMaquinaria=m.idTipoMaquinaria
    JOIN AlmacenXMaquinaria am ON am.idMaquinaria=m.idMaquinaria
    WHERE am.idAlmacen=_idAlmacen
    GROUP BY t.nombre;
END //
DELIMITER ;
```
#### 16. Procedimiento para obtener los trabajadores asignados por recinto
```sql
DROP PROCEDURE IF EXISTS trabajadoresRecinto;

DELIMITER //
CREATE PROCEDURE trabajadoresRecinto()
BEGIN
    SELECT tr.nombre AS "Tipo de recinto", r.nombre AS "Recinto", COUNT(et.idEmpleado) AS "Cantidad"
    FROM EmpleadoXTarea et
    JOIN Tarea t ON t.idTarea=et.idTarea
    JOIN TareaXRecinto txr ON txr.idTarea=t.idTarea
    JOIN Recinto r ON r.idRecinto=txr.idRecinto
    JOIN TipoRecinto tr ON tr.idTipoRecinto=r.idTipoRecinto
    GROUP BY tr.nombre, r.nombre;
END //
DELIMITER ;
```
#### 17. Procedimiento para obtener el numero de recintos en una zona de acuerdo a su tipo de recinto
```sql
DROP PROCEDURE IF EXISTS recintosZona;

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
```
#### 18. Procedimiento para obtener la cantidad de producto por categoria
```sql
DROP PROCEDURE IF EXISTS cantidadProductoCategoria;

DELIMITER //
CREATE PROCEDURE cantidadProductoCategoria()
BEGIN
    SELECT c.nombre AS "Categoria", SUM(p.stock) AS "Stock"
    FROM Producto p
    JOIN Categoria c ON c.idCategoria=p.idCategoria
    GROUP BY c.nombre;
END //
DELIMITER ;
```
#### 19. Procedimiento para obtener el rendimiento de los cultivos de un mismo tipo
```sql
DROP PROCEDURE IF EXISTS rendimientoTipoCultivo;

DELIMITER //
CREATE PROCEDURE rendimientoTipoCultivo(IN _idTipoCultivo INT)
BEGIN
    SELECT idCultivo AS "Cultivo", idZona AS "Zona", fechaSiembra, fechaCosecha, rendimientoCultivo(idCultivo) AS "Rendimiento"
    FROM Cultivo
    WHERE idTipoCultivo=_idTipoCultivo;
END //
DELIMITER ;
```
#### 20. Procedimiento para obtener el tipo de animales y su cantidad en un determinado recinto
```sql
DROP PROCEDURE IF EXISTS consultasTipoAnimal;

DELIMITER //
CREATE PROCEDURE consultasTipoAnimal(IN _idTipoAnimal INT)
BEGIN
    SELECT ta.nombre AS "Tipo de animal", COUNT(c.idAnimal) AS "Cantidad"
    FROM TipoAnimal ta
    JOIN Animal a ON a.idTipoAnimal=ta.idTipoAnimal
    JOIN ConsultaVeterinaria c ON c.idAnimal=a.idAnimal
    WHERE ta.idTipoAnimal=_idTipoAnimal
    GROUP BY ta.nombre;
END //
DELIMITER ;
```

## Funciones 📈

#### 1. Funcion para calcular el total de ventas entre dos fechas

```sql
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

```
#### 2. Funcion para calcular la cantidad de animales de un tipo en especifico

```sql

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

```
#### 3. Funcion para obtener el total de producto obtenido en un periodo de tiempo

```sql

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

```
#### 4. Funcion para obtener el total de ventas de un producto en un periodo de tiempo

```sql

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
```
#### 5. Funcion para calcular el rendimiento del cultivo

```sql
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

```
#### 6. Funcion para calcular salario de empleado en un periodo de tiempo

```sql

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
```
#### 7. Funcion para calcular el total de compras realizadas por un cliente en un periodo

```sql
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

```
#### 8. Funcion para obtener el id del proveedor que tiene el menor precio de un insumo

```sql

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

```
#### 9. Funcion para calcular la cantidad de consultas veterinarias programadas para un animal

```sql
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

```
#### 10. Funcion para obtener el dinero gastado en insumos en un periodo de tiempo

```sql

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

```
#### 11. Funcion para calcular el numero de proveedores que hay para un insumo

```sql

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
```
#### 12. Funcion para calcular el numero de compras hechas a un proveedor en un periodo

```sql
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
```
#### 13. Función para obtener el último mantenimiento de una máquina

```sql

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

```
#### 14. Funcion para obtener el numero de veces que se ha utilizado un tipo de cultivo

```sql

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

```
#### 15. Funcion para calcular el numero de compras realizadas por un cliente en un periodo

```sql
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

```
#### 16. Funcion para obtener el total de ventas que ha realizado un empleado en un periodo de tiempo

```sql
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

```
#### 17. Funcion para obtener la cantidad comprada de un insumo en un periodo de tiempo

```sql
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
```
#### 18. Funcion para calcular los dias que lleva en la empresa un trabajador

```sql

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

```
#### 19. Funcion para obtener el total de ventas de una categoria

```sql

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

```
#### 20. Funcion para calcular el total gastado en consultas veterinarias en un intervalo de fechas

```sql
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

```

## Triggers 🔫

#### 1. Trigger para verificar que el stock al insertar un producto sea mayor o igual a 0
```sql
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

```
#### 2. Trigger para verificar la fecha de contratacion de un empleado
```sql
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

```
#### 3. Trigger para actualizar el stock de un insumo al realizar una orden de compra
```sql
DELIMITER //
CREATE TRIGGER afterInsertInsumoxOrdenCompra
AFTER INSERT ON InsumoxOrdenCompra FOR EACH ROW
BEGIN
    UPDATE Insumo SET stock=stock+NEW.cantidad WHERE idInsumo=NEW.idInsumo;
END //
DELIMITER ;

```
#### 4. Trigger para actualizar el total de una venta al hacer un registro en ProductoxVenta
```sql
DELIMITER //
CREATE TRIGGER afterInsertProductoxVenta
AFTER INSERT ON ProductoxVenta FOR EACH ROW
BEGIN
    DECLARE subtotal DECIMAL(10,2);

    SELECT precio*NEW.cantidad INTO subtotal FROM Producto WHERE idProducto=NEW.idProducto;

    UPDATE Venta SET total=total+subtotal WHERE idVenta=NEW.idVenta;
END //
DELIMITER ;

```
#### 5. Trigger para no permitir eliminar un producto si tiene un stock mayor a 0
```sql
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

```
#### 6. Trigger para actualizar el stock de producto cuando se registra en CultivoxProducto
```sql

DELIMITER //
CREATE TRIGGER afterInsertCultivoxProducto
AFTER INSERT ON CultivoxProducto FOR EACH ROW
    UPDATE Producto SET stock=stock+NEW.cantidad WHERE idProducto=NEW.idProducto;
DELIMITER ;

```
#### 7. Trigger para registrar la actualizacion de salario de un empleado
```sql
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

```
#### 8. Trigger para no permitir actualizar el estado de una consulta veterinaria antes de que la fecha pase 
```sql
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

```
#### 9. Trigger para no permitir eliminar un tipo de animal si tiene animales relacionados
```sql
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

```
#### 10. Trigger para actualizar el stock de un producto al realizar una venta
```sql
DELIMITER //
CREATE TRIGGER afterInsertProductoxVentaStock
AFTER INSERT ON ProductoxVenta FOR EACH ROW
BEGIN
    UPDATE Producto SET stock=stock-NEW.cantidad WHERE idProducto=NEW.idProducto;
END //
DELIMITER ;

```
#### 11. Trigger para actualizar el total de una orden al hacer un registro en InsumoxOrdenCompra
```sql
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

```
#### 12. Trigger para actualizar el stock de un producto cuando se registre en RecintoxProducto
```sql
DELIMITER //
CREATE TRIGGER afterInsertRecintoxProducto
AFTER INSERT ON RecintoxProducto FOR EACH ROW
BEGIN 
    UPDATE Producto SET stock=stock+NEW.cantidad WHERE idProducto=NEW.idProducto;
END //
DELIMITER ;

```
#### 13. Trigger para registrar la actualizacion de precio de un producto
```sql
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

```
#### 14. Trigger para registrar la inserccion de un empleado
```sql
DELIMITER //
CREATE TRIGGER afterInsertEmpleado
AFTER INSERT ON Producto FOR EACH ROW
BEGIN
    INSERT INTO Log(idEntidad, mensaje, fecha)
    -- Revisar id de entidad
    VALUES(1,CONCAT("Inserccion empleado idEmpleado: ",NEW.idEmpleado," idCargo: ",NEW.idCargo," nombre: ",NEW.nombre," estado: ",NEW.estado," fechaContratacion: ",NEW.fechaContratacion," salario: ",NEW.salario), NOW());
END //
DELIMITER ;

```
#### 15. Trigger para registrar la novedad del estado de un animal
```sql
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

```
#### 16. Trigger para registrar la actualizacion de cargo de un empleado
```sql
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

```
#### 17. Trigger para registrar la actualizacion de estado de un proveedor
```sql
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

```
#### 18. Trigger para registrar la realizacion de una orden de compra
```sql
DELIMITER //
CREATE TRIGGER afterInsertOrdenCompra
AFTER INSERT ON OrdenCompra FOR EACH ROW
BEGIN
    INSERT INTO Log(idEntidad, mensaje, fecha)
    -- Revisar id de entidad
    VALUES(4,CONCAT("Inserccion orden compra idOrdenCompra: ",NEW.idOrdenCompra," fecha: ",NEW.fecha," total: ",NEW.total), NOW());
END //
DELIMITER ;

```
#### 19. Trigger para evitar insertar valores erroneos en la fecha de cosecha de un cultivo
```sql
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

```
#### 20. Trigger para registrar el cambio de estado en una maquinaria
```sql
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

```

## Eventos 📅

#### 1. Evento para registrar las ventas hechas durante el dia

```sql
DROP EVENT IF EXISTS registroVentasDia;

CREATE EVENT registroVentasDia
ON SCHEDULE EVERY 1 DAY
DO
    INSERT INTO Historico(fecha, total)
    VALUES(NOW(), totalVentasPeriodo(CURDATE(),CURDATE()));
```
#### 2. Evento para subir sueldo de los empleados un 5% cada año

```sql
DROP EVENT IF EXISTS subirSueldos;

CREATE EVENT subirSueldos
ON SCHEDULE EVERY 1 YEAR
DO
    UPDATE Empleado SET salario=salario+(salario*0.05);
```
#### 3. Evento para eliminar los clientes que no hacen compras hace mas de un año

```sql
DROP EVENT IF EXISTS eliminarClientesInactivos;

CREATE EVENT eliminarClientesInactivos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Cliente WHERE numeroComprasCliente(idCliente,CURDATE()-INTERVAL 1 YEAR, CURDATE())=0;
```
#### 4. Evento para eliminar los log de hace mas de dos años

```sql
DROP EVENT IF EXISTS eliminarLogsAntiguos;

CREATE EVENT eliminarLogsAntiguos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Log WHERE fecha<=(NOW()-INTERVAL 2 YEAR);
```
#### 5. Evento para realizar mantenimiento cada 6 meses a una maquinaria

```sql
DROP EVENT IF EXISTS mantenimientoMaquinaria;

CREATE EVENT mantenimientoMaquinaria
ON SCHEDULE EVERY 6 MONTH
DO
    INSERT INTO Mantenimiento(idMaquinaria,fecha,costo)
    VALUES (1,CURDATE(),100000);
```
#### 6. Evento para eliminar las consultas veterinarias de hace mas de 2 años

```sql
DROP EVENT IF EXISTS eliminarConsultasVeterinarias;

CREATE EVENT eliminarConsultasVeterinarias
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM ConsultaVeterinaria WHERE fecha<(NOW()-INTERVAL 2 YEAR);
```
#### 7. Evento para subir el precio a los productos un 10% cada año

```sql
-- 7. Evento para subir el precio a los productos un 10% cada año
DROP EVENT IF EXISTS subirPrecioProductos;

CREATE EVENT subirPrecioProductos
ON SCHEDULE EVERY 1 YEAR
DO
    UPDATE Producto SET precio=precio+(precio*0.10);
```
#### 8. Evento para programar una consulta veterinaria para los animales enfermos

```sql
DROP EVENT IF EXISTS programarConsulta;

CREATE EVENT programarConsulta
ON SCHEDULE EVERY 1 DAY
DO
    INSERT INTO ConsultaVeterinaria(idAnimal,fecha,costo,estado)
    SELECT a.idAnimal, NOW()+ INTERVAL 1 WEEK, 50000, "Por realizar"
    FROM Animal a
    JOIN ConsultaVeterinaria cv ON cv.idAnimal=a.idAnimal
    WHERE a.estado="Enfermo" AND consultasProgramadasAnimal(a.idAnimal)=0;
```
#### 9. Actualizar estado de empleados que se encuentran en vacaciones

```sql
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
```
#### 10. Evento para eliminar los proveedores que estan inactivos y no se han utilizado en mas de un año

```sql
DROP EVENT IF EXISTS eliminarProveedoresInactivos;

CREATE EVENT eliminarProveedoresInactivos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Proveedor WHERE numeroComprasProveedor(idProveedor, CURDATE()-INTERVAL 1 YEAR, CURDATE())=0 AND activo="Inactivo";
```
#### 11. Evento para actualizar el estado de los empleados luego que vuelvan de vacaciones

```sql
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
```
#### 12. Evento para actualizar el estado de una vacacion de empleado a en curso

```sql
DROP EVENT IF EXISTS actualizarEstadoVacacionEnCurso;

CREATE EVENT actualizarEstadoVacacionEnCurso
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE Vacacion SET estado="En curso"
    WHERE fechaInicio<=CURDATE() AND fechaFin>=CURDATE()
    AND estado="Pendiente";
```
#### 13. Evento para actualizar el estado de una maquinaria cuando le van a realizar un mantenimiento

```sql
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
```
#### 14. Evento para generar registrar una alerta cuando un insumo tenga bajo stock

```sql
DROP EVENT IF EXISTS registrarBajoStockInsumo;

CREATE EVENT registrarBajoStockInsumo
ON SCHEDULE EVERY 1 WEEK
DO

    INSERT INTO Log(idEntidad,mensaje,fecha)
    SELECT 2,CONCAT("Insumo con stock bajo ","idInsumo: ",idInsumo," nombre: ",nombre," stock: ",stock), NOW()
    FROM Insumo
    WHERE stock<20;
```
#### 15. Evento para eliminar los mantenimientos hechos hace mas de dos años

```sql
DROP EVENT IF EXISTS eliminarMantenimientos;

CREATE EVENT eliminarMantenimientos
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Mantenimiento WHERE fecha<(NOW()-INTERVAL 2 YEAR);
```
#### 16. Evento para actualizar el estado de una vacacion de empleado a disfrutada

```sql
DROP EVENT IF EXISTS actualizarEstadoVacacionDisfrutada;

CREATE EVENT actualizarEstadoVacacionDisfrutada
ON SCHEDULE EVERY 1 DAY
DO
    UPDATE Vacacion SET estado="Disfrutada"
    WHERE fechaFin<CURDATE()
    AND estado="En Curso";
```
#### 17. Evento para actualizar el estado de una maquinaria cuando termino un mantenimiento

```sql
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
```
#### 18. Evento para registrar una alerta de producto bajo en stock

```sql
DROP EVENT IF EXISTS registrarBajoStockProducto;

CREATE EVENT registrarBajoStockProducto
ON SCHEDULE EVERY 1 DAY
DO

    INSERT INTO Log(idEntidad,mensaje,fecha)
    SELECT 3, CONCAT("Producto con stock bajo ", "id producto: ",idProducto," nombre: ",nombre," stock: ",stock), NOW()
    FROM Producto
    WHERE stock<30;
```
#### 19. Evento para registrar una alerta de pocos proveedores para un insumo

```sql
DROP EVENT IF EXISTS registrarPocosProveedoresInsumo;

CREATE EVENT registrarPocosProveedoresInsumo
ON SCHEDULE EVERY 1 WEEK
DO

    INSERT INTO Log(idEntidad,mensaje,fecha)
    SELECT 2, CONCAT("Pocos proveedores para insumo ","idInsumo ",idInsumo," nombre insumo: ",nombre,"numero de proveedores: ",numeroProveedores(idInsumo)),NOW()
    FROM Insumo
    WHERE numeroProveedores(idInsumo)<=2;
```
#### 20. Evento para eliminar vacaciones de los empleados de hace mas de dos años

```sql
DROP EVENT IF EXISTS eliminarVacaciones;

CREATE EVENT eliminarVacaciones
ON SCHEDULE EVERY 1 MONTH
DO
    DELETE FROM Vacacion WHERE fechaFin<CURDATE()-INTERVAL 2 YEAR;
```

## Roles de Usuario y Permisos 👷‍♂️

### Administrador

Tiene control total sobre la base de datos, incluso puede otorgar permisos a otros usuarios

```sql
DROP USER IF EXISTS 'administrador'@'localhost';
CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON granjaestelar.* TO 'administrador'@'localhost' WITH GRANT OPTION;
```

### Encargado de Animales

Tiene la capacidad de ver la informacion que esta relacionada con los animales y puede reportar la produccion de productos animales

```sql
DROP USER IF EXISTS 'EncargadoDeAnimales'@'localhost';
CREATE USER 'EncargadoDeAnimales'@'localhost' IDENTIFIED BY 'animales123';
-- Nos asegurarnos de revocar todos los permisos y asi tener total control de que permisos tiene el usuario (Si da error en la consola es perfecto pues significa que nuestro usuario no tiene permisos)
REVOKE ALL PRIVILEGES ON granjaestelar.* FROM 'EncargadoDeAnimales'@'localhost';
-- Revocamos todos los permisos
-- Ahora insertamos lo verdaderos permisos
-- Permisos para animales y recintos
GRANT SELECT ON GranjaEstelar.ConsultaVeterinaria TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.TipoAnimal TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.Animal TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.Recinto TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.TipoRecinto TO 'EncargadoDeAnimales'@'localhost';

-- Permisos para insumos
GRANT SELECT ON GranjaEstelar.RecintoXInsumo TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.TipoInsumo TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.Insumo TO 'EncargadoDeAnimales'@'localhost';

-- Permisos para maquinaria y herramientas
GRANT SELECT ON GranjaEstelar.Almacen TO 'EncargadoDeAnimales'@'localhost';

GRANT SELECT ON GranjaEstelar.TipoMaquinaria TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.Maquinaria TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.Mantenimiento TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.AlmacenXMaquinaria TO 'EncargadoDeAnimales'@'localhost';

GRANT SELECT ON GranjaEstelar.TipoHerramienta TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.Herramienta TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.AlmacenXHerramienta TO 'EncargadoDeAnimales'@'localhost';

-- Permisos para zonas
GRANT SELECT ON GranjaEstelar.Zona TO 'EncargadoDeAnimales'@'localhost';

-- Permisos para tareas
GRANT SELECT ON GranjaEstelar.Tarea TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.TipoTarea TO 'EncargadoDeAnimales'@'localhost';
GRANT SELECT ON GranjaEstelar.TareaXRecinto TO 'EncargadoDeAnimales'@'localhost';

-- Permisos para Reportar produccion
GRANT SELECT, INSERT, UPDATE ON GranjaEstelar.RecintoXProducto TO 'EncargadoDeAnimales'@'localhost';
```

### Encargado de Cultivos

Tiene la capacidad de ver la informacion que esta relacionada con los cultivos y puede reportar la produccion de productos agricolas

```sql
DROP USER IF EXISTS 'EncargadoDeCultivos'@'localhost';
CREATE USER 'EncargadoDeCultivos'@'localhost' IDENTIFIED BY 'cultivos123';
-- Nos asegurarnos de revocar todos los permisos y asi tener total control de que permisos tiene el usuario (Si da error en la consola es perfecto pues significa que nuestro usuario no tiene permisos)
REVOKE ALL PRIVILEGES ON granjaestelar.* FROM 'EncargadoDeCultivos'@'localhost';
-- Revocamos todos los permisos
-- Ahora insertamos lo verdaderos permisos
-- Permisos para cultivos
GRANT SELECT ON GranjaEstelar.TipoCultivo TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.Cultivo TO 'EncargadoDeCultivos'@'localhost';

-- Permisos para insumos
GRANT SELECT ON GranjaEstelar.CultivoXInsumo TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.TipoInsumo TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.Insumo TO 'EncargadoDeCultivos'@'localhost';

-- Permisos para maquinaria y herramientas
GRANT SELECT ON GranjaEstelar.Almacen TO 'EncargadoDeCultivos'@'localhost';

GRANT SELECT ON GranjaEstelar.TipoMaquinaria TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.Maquinaria TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.Mantenimiento TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.AlmacenXMaquinaria TO 'EncargadoDeCultivos'@'localhost';

GRANT SELECT ON GranjaEstelar.TipoHerramienta TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.Herramienta TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.AlmacenXHerramienta TO 'EncargadoDeCultivos'@'localhost';

-- Permisos para zonas
GRANT SELECT ON GranjaEstelar.Zona TO 'EncargadoDeCultivos'@'localhost';

-- Permisos para tareas
GRANT SELECT ON GranjaEstelar.Tarea TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.TipoTarea TO 'EncargadoDeCultivos'@'localhost';
GRANT SELECT ON GranjaEstelar.TareaXCultivo TO 'EncargadoDeCultivos'@'localhost';

-- Permisos para Reportar produccion
GRANT SELECT, INSERT, UPDATE ON GranjaEstelar.CultivoXProducto TO 'EncargadoDeCultivos'@'localhost';
```

### Contador

Tiene la capacidad de ver la informacion que esta relacionada a los costos de produccion y a los beneficios de las ventas

```sql
DROP USER IF EXISTS 'Contador'@'localhost';
CREATE USER 'Contador'@'localhost' IDENTIFIED BY 'contador123';
-- Nos asegurarnos de revocar todos los permisos y asi tener total control de que permisos tiene el usuario (Si da error en la consola es perfecto pues significa que nuestro usuario no tiene permisos)
REVOKE ALL PRIVILEGES ON granjaestelar.* FROM 'Contador'@'localhost';
-- Revocamos todos los permisos
-- Ahora insertamos lo verdaderos permisos

-- Permisos para empleados

GRANT SELECT ON GranjaEstelar.Empleado TO 'Contador'@'localhost';

-- Permisos para insumos

GRANT SELECT ON GranjaEstelar.Proveedor TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.InsumoXProveedor TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.OrdenCompra TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.InsumoXOrdenCompra TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.OrdenCompraXProveedor TO 'Contador'@'localhost';

-- Permisos para productos

GRANT SELECT ON GranjaEstelar.Producto TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.Categoria TO 'Contador'@'localhost';

-- Permisos para ventas

GRANT SELECT ON GranjaEstelar.Venta TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.Cliente TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.ProductoXVenta TO 'Contador'@'localhost';

-- Permisos para ver la tabla historico

GRANT SELECT ON GranjaEstelar.Historico TO 'Contador'@'localhost';

-- Permisos para ver las Consultas Veterinarias

GRANT SELECT ON GranjaEstelar.ConsultaVeterinaria TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.Animal TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.TipoAnimal TO 'Contador'@'localhost';

-- Permisos para las tablas de mantenimiento

GRANT SELECT ON GranjaEstelar.Mantenimiento TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.Maquinaria TO 'Contador'@'localhost';
GRANT SELECT ON GranjaEstelar.TipoMaquinaria TO 'Contador'@'localhost';
```

### Capataz

Tiene la capacidad de ver la informacion que esta relacionada en general a las tareas de la granja y puede asignar tareas a los empleados

```sql
DROP USER IF EXISTS 'Capataz'@'localhost';
CREATE USER 'Capataz'@'localhost' IDENTIFIED BY 'capataz123';
-- Nos asegurarnos de revocar todos los permisos y asi tener total control de que permisos tiene el usuario (Si da error en la consola es perfecto pues significa que nuestro usuario no tiene permisos)
REVOKE ALL PRIVILEGES ON granjaestelar.* FROM 'Capataz'@'localhost';
-- Revocamos todos los permisos
-- Ahora insertamos lo verdaderos permisos

-- Permisos para empleados (Y asi saber a quien asignarle la tarea)

GRANT SELECT ON GranjaEstelar.Empleado TO 'Capataz'@'localhost';

-- Permisos para tareas

GRANT ALL PRIVILEGES ON GranjaEstelar.Tarea TO 'Capataz'@'localhost';
GRANT ALL PRIVILEGES ON GranjaEstelar.TipoTarea TO 'Capataz'@'localhost';
GRANT ALL PRIVILEGES ON GranjaEstelar.TareaXRecinto TO 'Capataz'@'localhost';
GRANT ALL PRIVILEGES ON GranjaEstelar.TareaXCultivo TO 'Capataz'@'localhost';
GRANT ALL PRIVILEGES ON GranjaEstelar.EmpleadoxTarea TO 'Capataz'@'localhost';


-- Permisos para maquinarias y herramientas
GRANT SELECT ON GranjaEstelar.Almacen TO 'Capataz'@'localhost';

GRANT SELECT ON GranjaEstelar.TipoMaquinaria TO 'Capataz'@'localhost';
GRANT SELECT ON GranjaEstelar.Maquinaria TO 'Capataz'@'localhost';
GRANT SELECT ON GranjaEstelar.Mantenimiento TO 'Capataz'@'localhost';
GRANT SELECT ON GranjaEstelar.AlmacenXMaquinaria TO 'Capataz'@'localhost';

GRANT SELECT ON GranjaEstelar.TipoHerramienta TO 'Capataz'@'localhost';
GRANT SELECT ON GranjaEstelar.Herramienta TO 'Capataz'@'localhost';
GRANT SELECT ON GranjaEstelar.AlmacenXHerramienta TO 'Capataz'@'localhost';

-- Permisos para zonas
GRANT SELECT ON GranjaEstelar.Zona TO 'Capataz'@'localhost';

```

## Como Aportar 🛠

> Generando Nuevas Inserciones

> Ideando Nuevas Consultas, Eventos, Funciones, Triggers y Procedimientos

> Creando Nuevas Entidades y Relaciones generando una aun mayor robustes al sistema

## Autores 🐦‍🔥

### Juan José Torres Becerra

## [JuanJTorresB](https://github.com/JuanJTorresB)

#### Email:
> juanjtorresbecerra@gmail.com
### Joan Sebastian Ruiz Angarita

## [JoanSebastianRuiz](https://github.com/JoanSebastianRuiz)

#### Email
> joansebastianruizangarita10@gmail.com