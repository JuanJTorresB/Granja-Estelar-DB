    DROP SCHEMA IF EXISTS GranjaEstelar;

    CREATE SCHEMA GranjaEstelar;

    USE GranjaEstelar;


    CREATE TABLE Zona (
        idZona INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        area DECIMAL(10, 2)
    );

    CREATE TABLE TipoRecinto (
        idTipoRecinto INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Recinto (
        idRecinto INT PRIMARY KEY AUTO_INCREMENT,
        idTipoRecinto INT,
        idZona INT,
        nombre VARCHAR(100),
        FOREIGN KEY (idTipoRecinto) REFERENCES TipoRecinto(idTipoRecinto),
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE TipoInsumo (
        idTipoInsumo INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Insumo (
        idInsumo INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        stock INT,
        idTipoInsumo INT,
        FOREIGN KEY (idTipoInsumo) REFERENCES TipoInsumo(idTipoInsumo)
    );

    CREATE TABLE Proveedor (
        idProveedor INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100),
        activo ENUM('Activo', 'Inactivo')
    );

    CREATE TABLE InsumoXProveedor (
        idInsumoXProveedor INT PRIMARY KEY AUTO_INCREMENT,
        idInsumo INT,
        idProveedor INT,
        costo DECIMAL(10, 2),
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo),
        FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
    );

    CREATE TABLE OrdenCompra (
        idOrdenCompra INT PRIMARY KEY AUTO_INCREMENT,
        fecha DATE,
        total DECIMAL(10, 2)
    );

    CREATE TABLE InsumoXOrdenCompra (
        idInsumoXOrdenCompra INT PRIMARY KEY AUTO_INCREMENT,
        idInsumo INT,
        idOrdenCompra INT,
        cantidad INT,
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo),
        FOREIGN KEY (idOrdenCompra) REFERENCES OrdenCompra(idOrdenCompra)
    );

    CREATE TABLE OrdenCompraXProveedor (
        idOrdenCompraXProveedor INT PRIMARY KEY AUTO_INCREMENT,
        idOrdenCompra INT,
        idProveedor INT,
        FOREIGN KEY (idOrdenCompra) REFERENCES OrdenCompra(idOrdenCompra),
        FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
    );

    CREATE TABLE TipoCultivo (
        idTipoCultivo INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        inicioTemporada DATE,
        fnTemporada DATE
    );

    CREATE TABLE Cultivo (
        idCultivo INT PRIMARY KEY AUTO_INCREMENT,
        area DECIMAL(10, 2),
        fechaSiembra DATE,
        fechaCosecha DATE,
        idTipoCultivo INT,
        idZona INT,
        FOREIGN KEY (idTipoCultivo) REFERENCES TipoCultivo(idTipoCultivo),
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE CultivoXInsumo (
        idCultivoXInsumo INT PRIMARY KEY AUTO_INCREMENT,
        idCultivo INT,
        idInsumo INT,
        cantidad INT,
        FOREIGN KEY (idCultivo) REFERENCES Cultivo(idCultivo),
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo)
    );

    CREATE TABLE RecintoXInsumo (
        idRecintoXInsumo INT PRIMARY KEY AUTO_INCREMENT,
        idRecinto INT,
        idInsumo INT,
        cantidad INT,
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto),
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo)
    );

    CREATE TABLE Categoria (
        idCategoria INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Producto (
        idProducto INT PRIMARY KEY AUTO_INCREMENT,
        idCategoria INT,
        nombre VARCHAR(255),
        stock INT,
        precio DECIMAL(10, 2),
        FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
    );

    CREATE TABLE RecintoXProducto (
        idRecintoXProducto INT PRIMARY KEY AUTO_INCREMENT,
        idRecinto INT,
        idProducto INT,
        cantidad INT,
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto),
        FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
    );

        CREATE TABLE TipoTarea (
        idTipoTarea INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255)
    );

    CREATE TABLE Tarea (
        idTarea INT PRIMARY KEY AUTO_INCREMENT,
        idTipoTarea INT,
        fechaInicio DATETIME,
        fechaFin DATETIME,
        descripcion VARCHAR(500),
        estado ENUM("Pendiente","En Progreso","Terminada"),
        FOREIGN KEY (idTipoTarea) REFERENCES TipoTarea(idTipoTarea)
    );

    CREATE TABLE TareaXRecinto (
        idTareaXRecinto INT PRIMARY KEY AUTO_INCREMENT,
        idTarea INT,
        idRecinto INT,
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea),
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto)
    );

    CREATE TABLE TipoAnimal (
        idTipoAnimal INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Animal (
        idAnimal INT PRIMARY KEY AUTO_INCREMENT,
        idTipoAnimal INT,
        idRecinto INT,
        estado ENUM('Sano', 'Enfermo'),
        peso DECIMAL(10, 2),
        FOREIGN KEY (idTipoAnimal) REFERENCES TipoAnimal(idTipoAnimal),
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto)
    );

    CREATE TABLE ConsultaVeterinaria (
        idConsulta INT PRIMARY KEY AUTO_INCREMENT,
        idAnimal INT,
        fecha DATETIME,
        costo DECIMAL(10, 2),
        estado ENUM('Realizada', 'Por Realizar'),
        FOREIGN KEY (idAnimal) REFERENCES Animal(idAnimal)
    );


    CREATE TABLE Almacen (
        idAlmacen INT PRIMARY KEY AUTO_INCREMENT,
        idZona INT,
        nombre VARCHAR(255),
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE TipoHerramienta (
        idTipoHerramienta INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Herramienta (
        idHerramienta INT PRIMARY KEY AUTO_INCREMENT,
        idTipoHerramienta INT,
        FOREIGN KEY (idTipoHerramienta) REFERENCES TipoHerramienta(idTipoHerramienta)
    );

    CREATE TABLE TipoMaquinaria (
        idTipoMaquinaria INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255)
    );

    CREATE TABLE Maquinaria (
        idMaquinaria INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        idTipoMaquinaria INT,
        fechaAdquisicion DATE,
        estado ENUM('En Mantenimiento', 'Disponible', 'Ocupada'),
        FOREIGN KEY (idTipoMaquinaria) REFERENCES TipoMaquinaria(idTipoMaquinaria)
    );

    CREATE TABLE Mantenimiento (
        idMantenimiento INT PRIMARY KEY AUTO_INCREMENT,
        idMaquinaria INT,
        fecha DATE,
        costo DECIMAL(10, 2),
        FOREIGN KEY (idMaquinaria) REFERENCES Maquinaria(idMaquinaria)
    );

    CREATE TABLE AlmacenXHerramienta (
        idAlmacenXHerramienta INT PRIMARY KEY AUTO_INCREMENT,
        idAlmacen INT,
        idHerramienta INT,
        stock INT,
        FOREIGN KEY (idAlmacen) REFERENCES Almacen(idAlmacen),
        FOREIGN KEY (idHerramienta) REFERENCES Herramienta(idHerramienta)
    );

    CREATE TABLE AlmacenXMaquinaria (
        idAlmacenXMaquinaria INT PRIMARY KEY AUTO_INCREMENT,
        idAlmacen INT,
        idMaquinaria INT,
        FOREIGN KEY (idAlmacen) REFERENCES Almacen(idAlmacen),
        FOREIGN KEY (idMaquinaria) REFERENCES Maquinaria(idMaquinaria)
    );


    CREATE TABLE Cliente (
        idCliente INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255),
        telefono CHAR(10)
    );


    CREATE TABLE Cargo (
        idCargo INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100)
    );

    CREATE TABLE Empleado (
        idEmpleado INT PRIMARY KEY AUTO_INCREMENT,
        idCargo INT,
        nombre VARCHAR(255),
        estado ENUM('Activo', 'Inactivo', 'No Disponible'),
        fechaContratacion DATE,
        salario DECIMAL(10, 2),
        FOREIGN KEY (idCargo) REFERENCES Cargo(idCargo)
    );

    CREATE TABLE Venta (
        idVenta INT PRIMARY KEY AUTO_INCREMENT,
        idCliente INT,
        idEmpleado INT,
        fecha DATETIME,
        total DECIMAL(10, 2),
        FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
    );

    CREATE TABLE ProductoXVenta (
        idProductoXVenta INT PRIMARY KEY AUTO_INCREMENT,
        idVenta INT,
        idProducto INT,
        cantidad INT,
        FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
        FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
    );

    CREATE TABLE TareaXCultivo (
        idTareaXCultivo INT PRIMARY KEY AUTO_INCREMENT,
        idTarea INT,
        idCultivo INT,
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea),
        FOREIGN KEY (idCultivo) REFERENCES Cultivo(idCultivo)
    );

    CREATE TABLE Dia (
        idDia INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(10)
    );

    CREATE TABLE Horario (
        idHorario INT PRIMARY KEY AUTO_INCREMENT,
        idDia INT,
        horaInicio TIME,
        horaFin TIME,
        FOREIGN KEY (idDia) REFERENCES Dia(idDia)
    );

    CREATE TABLE Historico (
        idHistorico INT PRIMARY KEY AUTO_INCREMENT,
        fecha DATE,
        total DECIMAL(10, 2)
    );

    CREATE TABLE Entidad (
        idEntidad INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255)
    );

    CREATE TABLE Log (
        idLog INT PRIMARY KEY AUTO_INCREMENT,
        idEntidad INT,
        mensaje VARCHAR(500),
        fecha DATETIME,
        FOREIGN KEY (idEntidad) REFERENCES Entidad(idEntidad)
    );

    CREATE TABLE EmpleadoxTarea (
        idEmpleadoxTarea INT PRIMARY KEY AUTO_INCREMENT,
        idEmpleado INT NOT NULL,
        idTarea INT NOT NULL,
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea)
    );

    CREATE TABLE EmpleadoxHorario (
        idEmpleadoxHorario INT PRIMARY KEY AUTO_INCREMENT,
        idEmpleado INT NOT NULL,
        idHorario INT NOT NULL,
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
        FOREIGN KEY (idHorario) REFERENCES Horario(idHorario)
    );