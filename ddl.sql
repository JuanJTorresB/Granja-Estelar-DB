    DROP SCHEMA IF EXISTS GranjaEstelar;

    CREATE SCHEMA GranjaEstelar;

    USE GranjaEstelar;


    CREATE TABLE Zona (
        idZona INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL,
        area DECIMAL(10, 2) NOT NULL
    );

    CREATE TABLE TipoRecinto (
        idTipoRecinto INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL
    );

    CREATE TABLE Recinto (
        idRecinto INT PRIMARY KEY AUTO_INCREMENT,
        idTipoRecinto INT NOT NULL,
        idZona INT NOT NULL,
        nombre VARCHAR(100) NOT NULL,
        FOREIGN KEY (idTipoRecinto) REFERENCES TipoRecinto(idTipoRecinto),
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE TipoInsumo (
        idTipoInsumo INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL
    );

    CREATE TABLE Insumo (
        idInsumo INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL,
        stock INT NOT NULL,
        idTipoInsumo INT NOT NULL,
        FOREIGN KEY (idTipoInsumo) REFERENCES TipoInsumo(idTipoInsumo)
    );

    CREATE TABLE Proveedor (
        idProveedor INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL,
        activo ENUM('Activo', 'Inactivo') NOT NULL
    );

    CREATE TABLE InsumoXProveedor (
        idInsumoXProveedor INT PRIMARY KEY AUTO_INCREMENT,
        idInsumo INT NOT NULL,
        idProveedor INT NOT NULL,
        costo DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo),
        FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
    );

    CREATE TABLE OrdenCompra (
        idOrdenCompra INT PRIMARY KEY AUTO_INCREMENT,
        fecha DATE NOT NULL,
        total DECIMAL(10, 2) NOT NULL
    );

    CREATE TABLE InsumoXOrdenCompra (
        idInsumoXOrdenCompra INT PRIMARY KEY AUTO_INCREMENT,
        idInsumo INT NOT NULL,
        idOrdenCompra INT NOT NULL,
        cantidad INT NOT NULL,
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo),
        FOREIGN KEY (idOrdenCompra) REFERENCES OrdenCompra(idOrdenCompra)
    );

    CREATE TABLE OrdenCompraXProveedor (
        idOrdenCompraXProveedor INT PRIMARY KEY AUTO_INCREMENT,
        idOrdenCompra INT NOT NULL,
        idProveedor INT NOT NULL,
        FOREIGN KEY (idOrdenCompra) REFERENCES OrdenCompra(idOrdenCompra),
        FOREIGN KEY (idProveedor) REFERENCES Proveedor(idProveedor)
    );

    CREATE TABLE TipoCultivo (
        idTipoCultivo INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL,
        inicioTemporada DATE NOT NULL,
        finTemporada DATE NOT NULL
    );

    CREATE TABLE Cultivo (
        idCultivo INT PRIMARY KEY AUTO_INCREMENT,
        area DECIMAL(10, 2) NOT NULL,
        fechaSiembra DATE NOT NULL,
        fechaCosecha DATE NOT NULL,
        idTipoCultivo INT NOT NULL,
        idZona INT NOT NULL,
        FOREIGN KEY (idTipoCultivo) REFERENCES TipoCultivo(idTipoCultivo),
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE CultivoXInsumo (
        idCultivoXInsumo INT PRIMARY KEY AUTO_INCREMENT,
        idCultivo INT NOT NULL,
        idInsumo INT NOT NULL,
        cantidad INT NOT NULL,
        FOREIGN KEY (idCultivo) REFERENCES Cultivo(idCultivo),
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo)
    );

    CREATE TABLE RecintoXInsumo (
        idRecintoXInsumo INT PRIMARY KEY AUTO_INCREMENT,
        idRecinto INT NOT NULL,
        idInsumo INT NOT NULL,
        cantidad INT NOT NULL,
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto),
        FOREIGN KEY (idInsumo) REFERENCES Insumo(idInsumo)
    );

    CREATE TABLE Categoria (
        idCategoria INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL NOT NULL
    );

    CREATE TABLE Producto (
        idProducto INT PRIMARY KEY AUTO_INCREMENT,
        idCategoria INT NOT NULL,
        nombre VARCHAR(255) NOT NULL,
        stock INT NOT NULL,
        precio DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
    );

    CREATE TABLE RecintoXProducto (
        idRecintoXProducto INT PRIMARY KEY AUTO_INCREMENT,
        idRecinto INT NOT NULL,
        idProducto INT NOT NULL,
        cantidad INT NOT NULL,
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto),
        FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
    );

    CREATE TABLE CultivoXProducto (
        idCultivoXProducto INT PRIMARY KEY AUTO_INCREMENT,
        idCultivo INT NOT NULL,
        idProducto INT NOT NULL,
        cantidad INT NOT NULL,
        FOREIGN KEY (idCultivo) REFERENCES Cultivo(idCultivo),
        FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
    );

        CREATE TABLE TipoTarea (
        idTipoTarea INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL NOT NULL
    );

    CREATE TABLE Tarea (
        idTarea INT PRIMARY KEY AUTO_INCREMENT,
        idTipoTarea INT NOT NULL,
        fechaInicio DATETIME NOT NULL,
        fechaFin DATETIME NOT NULL,
        descripcion VARCHAR(500) NOT NULL,
        estado ENUM("Pendiente","En Progreso","Terminada") NOT NULL,
        FOREIGN KEY (idTipoTarea) REFERENCES TipoTarea(idTipoTarea)
    );

    CREATE TABLE TareaXRecinto (
        idTareaXRecinto INT PRIMARY KEY AUTO_INCREMENT,
        idTarea INT NOT NULL,
        idRecinto INT NOT NULL,
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea),
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto)
    );

    CREATE TABLE TipoAnimal (
        idTipoAnimal INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL
    );

    CREATE TABLE Animal (
        idAnimal INT PRIMARY KEY AUTO_INCREMENT,
        idTipoAnimal INT NOT NULL,
        idRecinto INT NOT NULL,
        estado ENUM('Sano', 'Enfermo') NOT NULL,
        peso DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (idTipoAnimal) REFERENCES TipoAnimal(idTipoAnimal),
        FOREIGN KEY (idRecinto) REFERENCES Recinto(idRecinto)
    );

    CREATE TABLE ConsultaVeterinaria (
        idConsulta INT PRIMARY KEY AUTO_INCREMENT,
        idAnimal INT NOT NULL,
        fecha DATETIME NOT NULL,
        costo DECIMAL(10, 2) NOT NULL,
        estado ENUM('Realizada', 'Por Realizar') NOT NULL,
        FOREIGN KEY (idAnimal) REFERENCES Animal(idAnimal)
    );


    CREATE TABLE Almacen (
        idAlmacen INT PRIMARY KEY AUTO_INCREMENT,
        idZona INT NOT NULL,
        nombre VARCHAR(255) NOT NULL,
        FOREIGN KEY (idZona) REFERENCES Zona(idZona)
    );

    CREATE TABLE TipoHerramienta (
        idTipoHerramienta INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL
    );

    CREATE TABLE Herramienta (
        idHerramienta INT PRIMARY KEY AUTO_INCREMENT,
        idTipoHerramienta INT NOT NULL,
        FOREIGN KEY (idTipoHerramienta) REFERENCES TipoHerramienta(idTipoHerramienta)
    );

    CREATE TABLE TipoMaquinaria (
        idTipoMaquinaria INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL
    );

    CREATE TABLE Maquinaria (
        idMaquinaria INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL,
        idTipoMaquinaria INT NOT NULL,
        fechaAdquisicion DATE NOT NULL,
        estado ENUM('En Mantenimiento', 'Disponible', 'Ocupada') NOT NULL,
        FOREIGN KEY (idTipoMaquinaria) REFERENCES TipoMaquinaria(idTipoMaquinaria)
    );

    CREATE TABLE Mantenimiento (
        idMantenimiento INT PRIMARY KEY AUTO_INCREMENT,
        idMaquinaria INT NOT NULL,
        fecha DATE NOT NULL,
        costo DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (idMaquinaria) REFERENCES Maquinaria(idMaquinaria)
    );

    CREATE TABLE AlmacenXHerramienta (
        idAlmacenXHerramienta INT PRIMARY KEY AUTO_INCREMENT,
        idAlmacen INT NOT NULL,
        idHerramienta INT NOT NULL,
        stock INT NOT NULL,
        FOREIGN KEY (idAlmacen) REFERENCES Almacen(idAlmacen),
        FOREIGN KEY (idHerramienta) REFERENCES Herramienta(idHerramienta)
    );

    CREATE TABLE AlmacenXMaquinaria (
        idAlmacenXMaquinaria INT PRIMARY KEY AUTO_INCREMENT,
        idAlmacen INT NOT NULL,
        idMaquinaria INT NOT NULL,
        FOREIGN KEY (idAlmacen) REFERENCES Almacen(idAlmacen),
        FOREIGN KEY (idMaquinaria) REFERENCES Maquinaria(idMaquinaria)
    );


    CREATE TABLE Cliente (
        idCliente INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL,
        telefono CHAR(10) NOT NULL UNIQUE
    );


    CREATE TABLE Cargo (
        idCargo INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL
    );

    CREATE TABLE Empleado (
        idEmpleado INT PRIMARY KEY AUTO_INCREMENT,
        idCargo INT NOT NULL,
        nombre VARCHAR(255) NOT NULL,
        estado ENUM('Activo', 'Inactivo', 'No Disponible') NOT NULL,
        fechaContratacion DATE NOT NULL,
        salario DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (idCargo) REFERENCES Cargo(idCargo)
    );

    CREATE TABLE Venta (
        idVenta INT PRIMARY KEY AUTO_INCREMENT,
        idCliente INT NOT NULL,
        idEmpleado INT NOT NULL,
        fecha DATETIME NOT NULL,
        total DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
    );

    CREATE TABLE ProductoXVenta (
        idProductoXVenta INT PRIMARY KEY AUTO_INCREMENT,
        idVenta INT NOT NULL,
        idProducto INT NOT NULL,
        cantidad INT NOT NULL,
        FOREIGN KEY (idVenta) REFERENCES Venta(idVenta),
        FOREIGN KEY (idProducto) REFERENCES Producto(idProducto)
    );

    CREATE TABLE TareaXCultivo (
        idTareaXCultivo INT PRIMARY KEY AUTO_INCREMENT,
        idTarea INT NOT NULL,
        idCultivo INT NOT NULL,
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea),
        FOREIGN KEY (idCultivo) REFERENCES Cultivo(idCultivo)
    );

    CREATE TABLE Dia (
        idDia INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(10) NOT NULL
    );

    CREATE TABLE Horario (
        idHorario INT PRIMARY KEY AUTO_INCREMENT,
        idDia INT NOT NULL,
        horaInicio TIME NOT NULL,
        horaFin TIME NOT NULL,
        FOREIGN KEY (idDia) REFERENCES Dia(idDia)
    );

    CREATE TABLE Historico (
        idHistorico INT PRIMARY KEY AUTO_INCREMENT,
        fecha DATE NOT NULL,
        total DECIMAL(10, 2) NOT NULL
    );

    CREATE TABLE Entidad (
        idEntidad INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL
    );

    CREATE TABLE Log (
        idLog INT PRIMARY KEY AUTO_INCREMENT,
        idEntidad INT NOT NULL,
        mensaje VARCHAR(500) NOT NULL,
        fecha DATETIME NOT NULL,
        FOREIGN KEY (idEntidad) REFERENCES Entidad(idEntidad)
    );

    CREATE TABLE EmpleadoXTarea (
        idEmpleadoXTarea INT PRIMARY KEY AUTO_INCREMENT,
        idEmpleado INT NOT NULL,
        idTarea INT NOT NULL,
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
        FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea)
    );

    CREATE TABLE EmpleadoXHorario (
        idEmpleadoXHorario INT PRIMARY KEY AUTO_INCREMENT,
        idEmpleado INT NOT NULL,
        idHorario INT NOT NULL,
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado),
        FOREIGN KEY (idHorario) REFERENCES Horario(idHorario)
    );

    CREATE TABLE Vacacion (
        idVacacion INT PRIMARY KEY AUTO_INCREMENT,
        idEmpleado INT NOT NULL,
        fechaInicio DATE NOT NULL,
        fechaFin DATE NOT NULL,
        estado ENUM("Disfrutada","Pendiente","En Curso"),
        FOREIGN KEY (idEmpleado) REFERENCES Empleado(idEmpleado)
    );