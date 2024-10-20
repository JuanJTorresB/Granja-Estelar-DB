    DROP SCHEMA IF EXISTS GranjaEstelar;

    CREATE SCHEMA GranjaEstelar;

    USE GranjaEstelar;


    CREATE TABLE Zona (
        idZona INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        area DECIMAL(10, 2)
    );

    CREATE TABLE TipoRecinto (
        idTipoRecinto INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Recinto (
        idRecinto INTEGER PRIMARY KEY AUTO_INCREMENT,
        idTipoRecinto INTEGER,
        idZona INTEGER,
        nombre VARCHAR(100),
        FOREIGN KEY (idTipoRecinto) REFERENCES TipoRecinto(idTipoRecinto),
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE TipoInsumo (
        idTipoInsumo INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Insumo (
        idInsumo INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        stock INTEGER,
        idTipoInsumo INTEGER,
        FOREIGN KEY (idTipoInsumo) REFERENCES TipoInsumo(idTipoInsumo)
    );

    CREATE TABLE Proveedor (
        idProveedor INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100),
        activo ENUM('Activo', 'Inactivo')
    );

    CREATE TABLE InsumoXProveedor (
        idInsumoXProveedor INTEGER PRIMARY KEY AUTO_INCREMENT,
        idInsumo INTEGER,
        idProveedor INTEGER,
        costo DECIMAL(10, 2),
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo),
        FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
    );

    CREATE TABLE OrdenCompra (
        idOrdenCompra INTEGER PRIMARY KEY AUTO_INCREMENT,
        fecha DATE,
        total DECIMAL(10, 2)
    );

    CREATE TABLE InsumoXOrdenCompra (
        idInsumoXOrdenCompra INTEGER PRIMARY KEY AUTO_INCREMENT,
        idInsumo INTEGER,
        idOrdenCompra INTEGER,
        cantidad INTEGER,
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo),
        FOREIGN KEY (idOrdenCompra) REFERENCES OrdenCompra(idOrdenCompra)
    );

    CREATE TABLE OrdenCompraXProveedor (
        idOrdenCompraXProveedor INTEGER PRIMARY KEY AUTO_INCREMENT,
        idOrdenCompra INTEGER,
        idProveedor INTEGER,
        FOREIGN KEY (idOrdenCompra) REFERENCES OrdenCompra(idOrdenCompra),
        FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
    );

    CREATE TABLE TipoCultivo (
        idTipoCultivo INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        inicioTemporada DATE,
        fnTemporada DATE
    );

    CREATE TABLE Cultivo (
        idCultivo INTEGER PRIMARY KEY AUTO_INCREMENT,
        area DECIMAL(10, 2),
        fechaSiembra DATE,
        fechaCosecha DATE,
        idTipoCultivo INTEGER,
        idZona INTEGER,
        FOREIGN KEY (idTipoCultivo) REFERENCES TipoCultivo(idTipoCultivo),
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE CultivoXInsumo (
        idCultivoXInsumo INTEGER PRIMARY KEY AUTO_INCREMENT,
        idCultivo INTEGER,
        idInsumo INTEGER,
        cantidad INTEGER,
        FOREIGN KEY (idCultivo) REFERENCES Cultivo(idCultivo),
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo)
    );

    CREATE TABLE RecintoXInsumo (
        idRecintoXInsumo INTEGER PRIMARY KEY AUTO_INCREMENT,
        idRecinto INTEGER,
        idInsumo INTEGER,
        cantidad INTEGER,
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto),
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo)
    );

    CREATE TABLE Categoria (
        idCategoria INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Producto (
        idProducto INTEGER PRIMARY KEY AUTO_INCREMENT,
        idCategoria INTEGER,
        nombre VARCHAR(255),
        stock INTEGER,
        precio DECIMAL(10, 2),
        FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
    );

    CREATE TABLE RecintoXProducto (
        idRecintoXProducto INTEGER PRIMARY KEY AUTO_INCREMENT,
        idRecinto INTEGER,
        idProducto INTEGER,
        cantidad INTEGER,
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto),
        FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
    );

    CREATE TABLE Tarea (
        idTarea INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        fechaInicio DATETIME,
        fechaFin DATETIME,
        descripcion VARCHAR(500),
        estado ENUM("Pendiente","En Progreso","Terminada")
    );

    CREATE TABLE TareaXRecinto (
        idTareaXRecinto INTEGER PRIMARY KEY AUTO_INCREMENT,
        idTarea INTEGER,
        idRecinto INTEGER,
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea),
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto)
    );

    CREATE TABLE TipoAnimal (
        idTipoAnimal INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Animal (
        idAnimal INTEGER PRIMARY KEY AUTO_INCREMENT,
        idTipoAnimal INTEGER,
        idRecinto INTEGER,
        estado ENUM('Sano', 'Enfermo'),
        peso DECIMAL(10, 2),
        FOREIGN KEY (idTipoAnimal) REFERENCES TipoAnimal(idTipoAnimal),
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto)
    );

    CREATE TABLE ConsultaVeterinaria (
        idConsulta INTEGER PRIMARY KEY AUTO_INCREMENT,
        idAnimal INTEGER,
        fecha DATETIME,
        costo DECIMAL(10, 2),
        estado ENUM('Realizada', 'Por Realizar'),
        FOREIGN KEY (idAnimal) REFERENCES Animal(idAnimal)
    );


    CREATE TABLE Almacen (
        idAlmacen INTEGER PRIMARY KEY AUTO_INCREMENT,
        idZona INTEGER,
        nombre VARCHAR(255),
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE TipoHerramienta (
        idTipoHerramienta INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Herramienta (
        idHerramienta INTEGER PRIMARY KEY AUTO_INCREMENT,
        idTipoHerramienta INTEGER,
        FOREIGN KEY (idTipoHerramienta) REFERENCES TipoHerramienta(idTipoHerramienta)
    );

    CREATE TABLE TipoMaquinaria (
        idTipoMaquinaria INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255)
    );

    CREATE TABLE Maquinaria (
        idMaquinaria INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        idTipoMaquinaria INTEGER,
        fechaAdquisicion DATE,
        estado ENUM('En Mantenimiento', 'Disponible', 'Ocupada'),
        FOREIGN KEY (idTipoMaquinaria) REFERENCES TipoMaquinaria(idTipoMaquinaria)
    );

    CREATE TABLE Mantenimiento (
        idMantenimiento INTEGER PRIMARY KEY AUTO_INCREMENT,
        idMaquinaria INTEGER,
        fecha DATE,
        costo DECIMAL(10, 2),
        FOREIGN KEY (idMaquinaria) REFERENCES Maquinaria(idMaquinaria)
    );

    CREATE TABLE AlmacenXHerramienta (
        idAlmacenXHerramienta INTEGER PRIMARY KEY AUTO_INCREMENT,
        idAlmacen INTEGER,
        idHerramienta INTEGER,
        stock INTEGER,
        FOREIGN KEY (idAlmacen) REFERENCES Almacen(idAlmacen),
        FOREIGN KEY (idHerramienta) REFERENCES Herramienta(idHerramienta)
    );

    CREATE TABLE AlmacenXMaquinaria (
        idAlmacenXMaquinaria INTEGER PRIMARY KEY AUTO_INCREMENT,
        idAlmacen INTEGER,
        idMaquinaria INTEGER,
        FOREIGN KEY (idAlmacen) REFERENCES Almacen(idAlmacen),
        FOREIGN KEY (idMaquinaria) REFERENCES Maquinaria(idMaquinaria)
    );


    CREATE TABLE Cliente (
        idCliente INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        telefono CHAR(10)
    );


    CREATE TABLE Cargo (
        idCargo INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Empleado (
        idEmpleado INTEGER PRIMARY KEY AUTO_INCREMENT,
        idCargo INTEGER,
        nombre VARCHAR(255),
        estado ENUM('Activo', 'Inactivo', 'No Disponible'),
        fechaContratacion DATE,
        salario DECIMAL(10, 2),
        FOREIGN KEY (idCargo) REFERENCES Cargo(idCargo)
    );

    CREATE TABLE Venta (
        idVenta INTEGER PRIMARY KEY AUTO_INCREMENT,
        idCliente INTEGER,
        idEmpleado INTEGER,
        fecha DATETIME,
        total DECIMAL(10, 2),
        FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
    );

    CREATE TABLE ProductoXVenta (
        idProductoXVenta INTEGER PRIMARY KEY AUTO_INCREMENT,
        idVenta INTEGER,
        idProducto INTEGER,
        cantidad INTEGER,
        FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
        FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
    );

    CREATE TABLE TareaXCultivo (
        idTareaXCultivo INTEGER PRIMARY KEY AUTO_INCREMENT,
        idTarea INTEGER,
        idCultivo INTEGER,
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea),
        FOREIGN KEY (idCultivo) REFERENCES Cultivo(idCultivo)
    );

    CREATE TABLE Dia (
        idDia INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(10)
    );

    CREATE TABLE Horario (
        idHorario INTEGER PRIMARY KEY AUTO_INCREMENT,
        idDia INTEGER,
        horaInicio TIME,
        horaFin TIME,
        FOREIGN KEY (idDia) REFERENCES Dia(idDia)
    );

    CREATE TABLE Historico (
        idHistorico INTEGER PRIMARY KEY AUTO_INCREMENT,
        fecha DATE,
        total DECIMAL(10, 2)
    );

    CREATE TABLE Entidad (
        idEntidad INTEGER PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255)
    );

    CREATE TABLE Log (
        idLog INTEGER PRIMARY KEY AUTO_INCREMENT,
        idEntidad INTEGER,
        mensaje VARCHAR(500),
        fecha DATETIME,
        FOREIGN KEY (idEntidad) REFERENCES Entidad(idEntidad)
    );

    CREATE TABLE EmpleadoxTarea (
        idEmpleadoxTarea INTEGER PRIMARY KEY AUTO_INCREMENT,
        idEmpleado INTEGER NOT NULL,
        idTarea INTEGER NOT NULL,
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea)
    );

    CREATE TABLE EmpleadoxHorario (
        idEmpleadoxHorario INTEGER PRIMARY KEY AUTO_INCREMENT,
        idEmpleado INTEGER NOT NULL,
        idHorario INTEGER NOT NULL,
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
        FOREIGN KEY (idHorario) REFERENCES Horario(idHorario)
    );