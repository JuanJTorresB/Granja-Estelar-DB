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
10. [Roles de Usuario y Permisos](#roles-de-usuario-y-permisos-)
11. [Como Aportar](#autor-)
12. [Contacto](#autor-)

## Información General 📒
Granja Estelar Database es una base de datos creada en MySQL que busca llevar un registro y facilitar el acceso a informacion sobre la produccion agricola de una granja

## Requisitos del Sistema 📋
-

## Instalación y Configuración 📦
```bash
git clone https://github.com/JuanJTorresB/Granja-Estelar-DB.git
```
Desde MySQL Workbench o Dbeaver:

1. Ejecuta el (ddl.sql) para la creacion de la tablas
2. Ejecuta el (dml.sql) para hacer incersiones dentro de las tablas

Apartir de aqui puedes ejecutar los distintos eventos(dql_eventos.sql), procedimientos(dql_procedimientos.sql), funciones(dql_funciones.sql), triggers(dql_triggers.sql) y consultas(dql_select.sql) desde los archivos o desde este mismo archivo en secciones mas abajo

## Estructura de la Base de Datos 🗃️

<img src="Granja Estelar UML E-R JPG.jpg">


## Algunas Consultas 🔎

```sql

```

## Procedimientos ⚙️

#### 1. Procedimiento para insertar un empleado

```sql
DELIMITER //
CREATE PROCEDURE insertarEmpleado(IN _idCargo INT, IN _nombre VARCHAR(255), IN _estado ENUM("Activo","Inactivo"), IN fechaContratacion DATE, IN salario DECIMAL(10,2))
BEGIN
    INSERT INTO Empleado(idCargo, nombre, estado, fechaContratacion, salario)
    VALUES (_idCargo, _nombre, _estado, _fechaContratacion, _salario);
END //
DELIMITER ;
```
#### 2. Procedimiento para consultar los empleados que estan trabajando en el momento
```sql
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
```
####3. Procedimiento para obtener las tareas relacionadas a un empleado en un dia especifico
```sql
DELIMITER //
CREATE PROCEDURE tareasRelacionadasEmpleado(IN _idEmpleado INT, IN dia DATE)
BEGIN
    SELECT t.nombre AS "Tarea", TIME(t.fechaInicio) AS "Hora inicio", TIME(t.fechaFin) AS "Hora fin", t.descripcion AS "Descripcion" 
    FROM Tarea t
    JOIN EmpleadoxTarea et ON t.idTarea=et.idTarea
    WHERE et.idEmpleado=_idEmpleado AND DATE(t.fechaInicio)=dia;
END //
DELIMITER ;
```
#### 4. Procedimiento para obtener la cantidad y tipo de animal por recinto
```sql
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
```
#### 5. Procedimiento para obtener los cultivos que estan en temporada en una fecha especifica
```sql
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
DELIMITER //
CREATE PROCEDURE obtenerProveedoresProducto(IN _idInsumo INT)
BEGIN
    SELECT p.nombre AS "Proveedor",  ip.costo AS "Costo"
    FROM Proveedor p
    JOIN InsumoxProveedor ip ON ip.idProveedor=p.idProveedor
    WHERE ip.idInsumo=_idInsumo;
END //
DELIMITER ;
```
#### 7. Procedimiento para obtener las herramientas que estan en un determinado almacen
```sql
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
```
#### 8. Procedimiento para registrar un mantenimiento a una maquinaria especifica
```sql
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
```
#### 10. Procedimiento para obtener el numero de cultivos en una zona de acuerdo a su tipo de cultivo
```sql
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
```
#### 13. Procedimiento para obtener los insumos utilizados en un determinado tipo de cultivo
```sql
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
```
#### 14. Procedimiento para obtener los proveedores y el costo se tienen para un insumo
```sql
DELIMITER //
CREATE PROCEDURE proveedoresInsumo(IN _idInsumo INT)
BEGIN
    SELECT p.nombre AS "Proveedor", ip.costo AS "Costo"
    FROM Proveedor p
    JOIN InsumoxProveedor ip ON ip.idProveedor=p.idProveedor
    WHERE ip.idInsumo=_idInsumo;
END //
DELIMITER ;
```
#### 15. Procedimiento para obtener la maquinaria que esta en un determinado almacen
```sql
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
```
#### 16. Procedimiento para obtener los trabajadores asignados por recinto
```sql
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
```
#### 17. Procedimiento para obtener el numero de recintos en una zona de acuerdo a su tipo de recinto
```sql
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
DELIMITER //
CREATE PROCEDURE cantidadProductoCategoria()
BEGIN
    SELECT c.nombre AS "Categoria", SUM(p.stock) AS "Stock"
    FROM Producto p
    JOIN Categoria c ON c.idCategoria=p.idCategoria
    GROUP BY c.nombre
END //
DELIMITER ;
```
#### 19. Procedimiento para obtener el rendimiento de los cultivos de un mismo tipo
```sql
DELIMITER //
CREATE PROCEDURE rendimientoTipoCultivo(IN _idTipoCultivo INT)
BEGIN
    SELECT idCultivo AS "Cultivo", idZona AS "Zona" fechaSiembra, fechaCosecha, rendimientoCultivo(idCultivo)
    FROM Cultivo
    WHERE idTipoCultivo=_idTipoCultivo;
END;
DELIMITER ;
```
#### 20. Procedimiento para obtener el tipo de animales y su cantidad en un determinado recinto
```sql
DELIMITER //
CREATE PROCEDURE animalesRecinto(IN _idRecinto INT)
BEGIN
    SELECT ta.nombre AS "Tipo de animal", COUNT(a.idAnimal) AS "Cantidad"
    FROM TipoAnimal ta
    JOIN Animal a ON a.idAnimal=ta.idAnimal
    WHERE a.idRecinto=_idRecinto;
END //
DELIMITER ;
```

## Funciones 📈

#### 1. Funcion para calcular el total de ventas entre dos fechas

```sql
CREATE FUNCTION totalVentasPeriodo(fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalVentas DECIMAL(10,2);
    SELECT SUM(total) INTO totalVentas FROM Venta WHERE fechaInicial>=DATE(fecha) AND fechaFinal<=DATE(fecha);
    RETURN totalVentas;
END //
DELIMITER ;

```
#### 2. Funcion para calcular la cantidad de animales de un tipo en especifico

```sql

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

DELIMITER //
CREATE FUNCTION totalProducto(_idProducto INT, fechaInicio DATE, fechaFin DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidadProducto INT;
    SELECT SUM(cp.cantidad) INTO cantidadProducto
    FROM CultivoxProducto cp
    JOIN Cultivo c ON c.idCultivo=cp.idCultivo
    WHERE cp.idProducto=_idProducto AND c.fechaCosecha BETWEEN fechaInicio AND fechaFin;
    RETURN cantidadProducto;
END//
DELIMITER ;

```
#### 4. Funcion para obtener el total de ventas de un producto en un periodo de tiempo

```sql

DELIMITER //
CREATE FUNCTION totalVentasProducto(_idProducto INT, fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE cantidadProducto INT;
    DECLARE ventaProducto DECIMAL(10,2);

    SELECT SUM(pv.cantidad) INTO cantidadProducto
    FROM ProductoxVenta pv
    JOIN Venta v ON pv.idVenta=v.idVenta
    WHERE DATE(v.fecha) BETWEEN fechaInicial AND fechaFinal AND pv.idProducto=_idProducto;

    SELECT precio*cantidadProducto INTO ventaProducto FROM Producto WHERE idProducto=_idProducto;

    RETURN ventaProducto;
END //
DELIMITER ;

```
#### 5. Funcion para calcular el rendimiento del cultivo

```sql
DELIMITER //
CREATE FUNCTION rendimientoCultivo(_idCultivo INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE areaCultivo DECIMAL(10,2);
    DECLARE rendimiento DECIMAL(10,2);

    SELECT area INTO areaCultivo FROM Cultivo WHERE idCultivo=_idCultivo;

    SELECT (cantidad/areaCultivo) INTO rendimiento FROM CultivoxProducto WHERE idCultivo=_idCultivo;

    RETURN rendimiento;
END ;
DELIMITER ;

```
#### 6. Funcion para calcular salario de empleado en un periodo de tiempo

```sql

DELIMITER //
CREATE FUNCTION salarioEmpleado(IN _idEmpleado INT, IN fechaInicial DATE, IN fechaFinal DATE)
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

    SELECT salarioDia*DAYDIFF(FechaFinal,fechaInicial) INTO total;

    RETURN total;
END //
DELIMITER ;

```
#### 7. Funcion para calcular el total de compras realizadas por un cliente en un periodo

```sql
DELIMITER //
CREATE FUNCTION totalComprasCliente(_idCliente INT,fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalVentas DECIMAL(10,2);
    SELECT SUM(total) INTO totalVentas FROM Venta WHERE fechaInicial>=DATE(fecha) AND fechaFinal<=DATE(fecha) AND idCliente=_idCliiente;
    RETURN totalVentas;
END //
DELIMITER ;

```
#### 8. Funcion para obtener el id del proveedor que tiene el menor precio de un insumo

```sql

DELIMITER //
CREATE FUNCTION obtenerProveedorMenorPrecio(_idInsumo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE id INT;

    SELECT idProveedor INTO id
    FROM InsumoxProveedor
    WHERE idInsumo=_idInsumo AND costo=(
        SELECT MIN(costo)
        FROM InsumoxProveedor
        WHERE idInsumo=_idInsumo
    ) 
    LIMIT 1;

    RETURN id;
END //
DELIMITER ;

```
#### 9. Funcion para calcular la cantidad de consultas veterinarias programadas para un animal

```sql
DELIMITER //
CREATE FUNCTION consultasProgramadasAnimal(_idAnimal INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;

    SELECT COUNT(idAnimal) INTO cantidad 
    FROM ConsultaVeterinaria
    WHERE idAnimal=_idAnimal AND fecha>NOW();

    RETURNS cantidad;
END //
DELIMITER;

```
#### 10. Funcion para obtener el dinero gastado en insumos en un periodo de tiempo

```sql

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

DELIMITER //
CREATE FUNCTION numeroProveedores(_idInsumo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad INT;
    SET cantidad=0;

    SELECT COUNT(ip.idProveedor) INTO cantidad
    FROM InsumoxProveedor ip
    JOIN Proveedor p ON p.idProveedor=ip.idProveedor
    WHERE ip.idInsumo=_idInsumo AND p.activo="Activo";

    RETURN cantidad;
END //
DELIMITER ;

```
#### 12. Funcion para calcular el numero de compras hechas a un proveedor en un periodo

```sql
DELIMITER //
CREATE FUNCTION numeroComprasProveedor(_idProveedor INT,fechaInicial DATE, fechaFinal DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numeroCompras INT;
    SELECT COUNT(idProvedor) INTO numeroCompras FROM OrdenCompraxProveedor WHERE fechaInicial<=DATE(fecha) AND fechaFinal>=DATE(fecha) AND idProveedor=_idProveedor;
    RETURN numeroCompras;
END //
DELIMITER ;

```
#### 13. Función para obtener el último mantenimiento de una máquina

```sql

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

DELIMITER //
CREATE FUNCTION cantidadTipoCultivo(_idTipoCultivo)
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
DELIMITER //
CREATE FUNCTION numeroComprasCliente(_idCliente INT,fechaInicial DATE, fechaFinal DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE numeroCompras INT;
    SELECT COUNT(idCliente) INTO numeroCompras FROM Venta WHERE fechaInicial<=DATE(fecha) AND fechaFinal>=DATE(fecha) AND idCliente=_idCliiente;
    RETURN numeroCompras;
END //
DELIMITER ;

```
#### 16. Funcion para obtener el total de ventas que ha realizado un empleado en un periodo de tiempo

```sql
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
DELIMITER //
CREATE FUNCTION cantidadInsumo(_idInsumo INT, fechaInicial DATE, fechaFinal DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidadInsumo INT;

    SELECT SUM(io.cantidad) INT cantidadInsumo
    FROM InsumoxOrdenCompra io
    JOIN OrdenCompra oc.idOrdenCompra=io.idOrdenCompra
    WHERE io.idInsumo=_idInsumo AND oc.fecha BETWEEN fechaInicial AND fechaFinal;

    RETURN cantidadInsumo;
END //
DELIMITER ;

```
#### 18. Funcion para calcular los dias que lleva en la empresa un trabajador

```sql

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

DELIMITER //
CREATE FUNCTION totalVentasCategoria(_idCategoria INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE totalVentas DECIMAL(10,2);

    SELECT SUM(v.total) INTO totalVentas
    FROM Venta v
    JOIN ProductoxVenta pv ON v.idVenta=pv.idVenta
    JOIN Producto p ON p.idProducto=pv.idProducto
    JOIN Categoria c ON c.idCategoria=p.idCategoria
    WHERE C.idCategoria=_idCategoria;

    RETURN totalVentas;
END //
DELIMITER ;

```
#### 20. Funcion para calcular el total gastado en consultas veterinarias en un intervalo de fechas

```sql
DELIMITER //
CREATE FUNCTION costoConsultasVeterinarias(fechaInicial DATE, fechaFinal DATE)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM (costo) INTO total FROM ConsultaVeterinaria WHERE DATE(fecha) BETWEEN fechaInicial AND fechaFinal
END //
DELIMITER ;

```

## Triggers 🔫

```sql

```

## Eventos 📅

```sql

```

## Roles de Usuario y Permisos 👷‍♂️

## Como Aportar 🛠

> Restructurar los archivos Json

> Crear CRUDS para mas productos o servicios

## Autor 🐦‍🔥

### Juan José Torres Becerra

## [JuanJTorresB](https://github.com/JuanJTorresB)

#### Email:
> juanjtorresbecerra@gmail.com
### Joan Sebastian Ruiz Angarita

## [JoanSebastianRuiz](https://github.com/JoanSebastianRuiz)

#### Email
> joansebastianruizangarita10@gmail.com