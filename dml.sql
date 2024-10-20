INSERT INTO Dia (nombre) VALUES 
('Domingo'),
('Lunes'),
('Martes'),
('Miércoles'),
('Jueves'),
('Viernes'),
('Sábado');

INSERT INTO Zona (nombre, area) VALUES 
('Zona Norte', 10.00),
('Zona Sur', 15.50),
('Zona Este', 12.00),
('Zona Oeste', 8.75),
('Zona Central', 20.00);

INSERT INTO TipoRecinto (nombre) VALUES 
('Establo'),
('Gallinero'),
('Apiario');

INSERT INTO Recinto (idTipoRecinto, idZona, nombre) VALUES 
(1, 1, 'Establo 1'),
(1, 2, 'Establo 2'),
(2, 3, 'Gallinero 1'),
(2, 4, 'Gallinero 2'),
(3, 5, 'Apiario 1');

INSERT INTO TipoInsumo (nombre) VALUES 
('Alimento para animales'),
('Fertilizante'),
('Medicamentos'),
('Herramientas'),
('Semillas');

INSERT INTO Insumo (nombre, stock, idTipoInsumo) VALUES 
('Comida para vacas', 1000, 1),
('Comida para gallinas', 500, 1),
('Fertilizante orgánico', 300, 2),
('Antibióticos', 200, 3),
('Azadón', 50, 4);

INSERT INTO Proveedor (nombre, activo) VALUES 
('Proveedor A', 'Activo'),
('Proveedor B', 'Activo'),
('Proveedor C', 'Inactivo'),
('Proveedor D', 'Activo'),
('Proveedor E', 'Activo');

INSERT INTO InsumoXProveedor (idInsumo, idProveedor, costo) VALUES 
(1, 1, 200000),
(2, 2, 150000),
(3, 1, 100000),
(4, 3, 50000),
(5, 2, 30000);

INSERT INTO OrdenCompra (fecha, total) VALUES 
('2024-10-01', 1500000),
('2024-10-05', 800000),
('2024-10-10', 1200000),
('2024-10-15', 500000),
('2024-10-20', 900000);

INSERT INTO InsumoXOrdenCompra (idInsumo, idOrdenCompra, cantidad) VALUES 
(1, 1, 5),
(2, 2, 10),
(3, 3, 15),
(4, 4, 7),
(5, 5, 8);

INSERT INTO OrdenCompraXProveedor (idOrdenCompra, idProveedor) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO TipoCultivo (nombre, inicioTemporada, fnTemporada) VALUES 
('Trigo', '2024-10-01', '2024-12-15'),
('Maíz', '2024-10-10', '2025-01-20'),
('Soya', '2024-10-15', '2025-01-30'),
('Cebada', '2024-10-20', '2025-02-10'),
('Arroz', '2024-10-25', '2025-03-01');

INSERT INTO Cultivo (area, fechaSiembra, fechaCosecha, idTipoCultivo, idZona) VALUES 
(1.5, '2024-10-01', '2024-12-15', 1, 1),
(2.0, '2024-10-10', '2025-01-20', 2, 2),
(0.75, '2024-10-15', '2025-01-30', 3, 3),
(1.0, '2024-10-20', '2025-02-10', 4, 4),
(2.5, '2024-10-25', '2025-03-01', 5, 5);

INSERT INTO CultivoXInsumo (idCultivo, idInsumo, cantidad) VALUES 
(1, 1, 100),
(2, 2, 150),
(3, 3, 80),
(4, 4, 50),
(5, 5, 120);

INSERT INTO RecintoXInsumo (idRecinto, idInsumo, cantidad) VALUES 
(1, 1, 500),
(2, 2, 300),
(3, 3, 200),
(4, 4, 150),
(5, 5, 250);

INSERT INTO Categoria (nombre) VALUES 
('Lácteos'),
('Carnes'),
('Granos'),
('Verduras'),
('Frutas');

INSERT INTO Producto (idCategoria, nombre, stock, precio) VALUES 
(1, 'Leche', 1000, 5000),
(2, '', 500, 20000),
(3, '', 300, 3000),
(4, '', 200, 2000),
(5, 'Miel', 400, 1000);

INSERT INTO RecintoXProducto (idRecinto, idProducto, cantidad) VALUES 
(1, 1, 100),
(2, 2, 50),
(3, 3, 30),
(4, 4, 20),
(5, 5, 40);

INSERT INTO TipoTarea (nombre) VALUES 
('Alimentar animales'),
('Recolectar Produccion Animal'),
('Control de plagas'),
('Alimentar animales'),
('Recolectar Produccion Agricola');

INSERT INTO Tarea (idTipoTareas, fechaInicio, fechaFin, descripcion, estado) VALUES 
(1, '2024-10-01 08:00:00', '2024-10-01 10:00:00', 'Alimentar a los animales en el establo', 'Pendiente'),
(1, '2024-10-01 08:00:00', '2024-10-01 10:00:00', 'Alimentar a los animales en el establo', 'Pendiente'),
(1, '2024-10-01 08:00:00', '2024-10-01 10:00:00', 'Alimentar a los animales en el establo', 'Pendiente'),
(1, '2024-10-01 08:00:00', '2024-10-01 10:00:00', 'Alimentar a los animales en el establo', 'Pendiente'),
(2, '2024-10-01 08:00:00', '2024-10-01 10:00:00', 'Alimentar a los animales en el establo', 'Pendiente'),
(4, '2024-10-02 08:00:00', '2024-10-02 10:00:00', 'Revisar el estado de los cultivos de maíz', 'Pendiente'),
(4, '2024-10-03 08:00:00', '2024-10-03 10:00:00', 'Revisar el estado de los cultivos de Trigo', 'Pendiente'),
(5, '2025-02-10 08:00:00', '2025-02-10 13:00:00', 'Cosechar la cebada')

INSERT INTO TareaXRecinto (idTarea, idRecinto) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO TipoAnimal (nombre) VALUES 
('Vaca'),
('Gallina'),
('Caballo'),
('Oveja'),
('Perro');

INSERT INTO Animal (idTipoAnimal, idRecinto, estado, peso) VALUES 
(1, 1, 'Sano', 450.00),
(2, 2, 'Sano', 1.50),
(3, 1, 'Enfermo', 300.00),
(4, 3, 'Sano', 70.00),
(5, 4, 'Sano', 15.00);

INSERT INTO ConsultaVeterinaria (idAnimal, fecha, costo, estado) VALUES 
(1, '2024-10-01 10:00:00', 100000, 'Realizada'),
(2, '2024-10-02 10:00:00', 50000, 'Por Realizar'),
(3, '2024-10-03 10:00:00', 150000, 'Por Realizar'),
(4, '2024-10-04 10:00:00', 80000, 'Realizada'),
(5, '2024-10-05 10:00:00', 120000, 'Por Realizar');

INSERT INTO Almacen (idZona, nombre) VALUES 
(1,"Almacen 1"),
(2,"Almacen 2"),
(3,"Almacen 3"),
(4,"Almacen 4"),
(5,"Almacen 5");

INSERT INTO TipoHerramienta (nombre) VALUES 
('Pala'),
('Rastrillo'),
('Carretilla'),
('Motosierra'),
('Desmalezadora');

INSERT INTO Herramienta (idTipoHerramienta) VALUES 
(1),
(2),
(3),
(4),
(5);

INSERT INTO AlmacenXHerramienta (idAlmacen,idHerramienta, stock) VALUES 
(1, 1, 10),
(2, 2, 15),
(3, 3, 5),
(4, 4, 2),
(5, 5, 8),
(1, 2, 10),
(2, 3, 15),
(3, 4, 5),
(4, 5, 2),
(5, 1, 8),
(1, 3, 10),
(2, 4, 15),
(3, 5, 5),
(4, 1, 2),
(5, 2, 8);

INSERT INTO TipoMaquinaria (nombre) VALUES 
('Tractor'),
('Cosechadora'),
('Cultivadora'),
('Remolque'),
('Desmalezadora');

INSERT INTO Maquinaria (nombre, idTipoMaquinaria, fechaAdquisicion, estado) VALUES 
('Tractor John Deere', 1, '2024-01-01', 'Disponible'),
('Cosechadora Case IH', 2, '2024-02-15', 'Disponible'),
('Cultivadora Massey Ferguson', 3, '2024-03-10', 'En Mantenimiento'),
('Remolque Kubota', 4, '2024-04-20', 'Disponible'),
('Desmalezadora Stihl', 5, '2024-05-05', 'Disponible');

INSERT INTO AlmacenXMaquinaria (idAlmacen, idMaquinaria) VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Cargo (nombre) VALUES 
('Encargado de animales'),
('Encargado de cultivos'),
('Veterinario'),
('Mecánico de maquinaria'),
('Administrador');

INSERT INTO Empleado (nombre, idCargo, fechaContratacion, salario) VALUES 
('Juan Pérez', 1, '2023-01-15', 2000000),
('Ana Gómez', 2, '2023-02-20', 1800000),
('Carlos Martínez', 3, '2023-03-10', 2500000),
('Laura López', 4, '2023-04-05', 2200000),
('Pedro Ruiz', 5, '2023-05-15', 3000000);

INSERT INTO Cliente (nombre, telefono) VALUES 
('Claudia Rojas', '1234567891'),
('Miguel Rodríguez', '2345678912'),
('Sofía García', '3456789012'),
('Julio Fernández', '4567891230'),
('Luisa Morales', '5678901234');

INSERT INTO Venta (idCliente, fecha, total) VALUES 
(1, '2024-10-01', 50000),
(2, '2024-10-02', 100000),
(3, '2024-10-03', 75000),
(4, '2024-10-04', 125000),
(5, '2024-10-05', 60000);

INSERT INTO ProductoXVenta (idVenta, idProducto, cantidad) VALUES 
(1, 1, 10),
(2, 2, 5),
(3, 3, 25),
(4, 4, 50),
(5, 5, 60);

INSERT INTO horario (iddia, horainicio, horafin) VALUES
(1, '08:00:00', '12:00:00'),
(2, '09:00:00', '13:00:00'),
(3, '10:00:00', '14:00:00'),
(4, '11:00:00', '15:00:00'),
(5, '12:00:00', '16:00:00');

INSERT INTO empleadoxhorario (idempleado, idhorario) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO empleadoxtarea (idempleado, idtarea) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO mantenimiento (idmaquinaria, fecha, costo) VALUES
(1, '2024-10-01', 50000),
(2, '2024-10-02', 75000),
(3, '2024-10-03', 60000),
(4, '2024-10-04', 80000),
(5, '2024-10-05', 55000);

INSERT INTO tareaxcultivo (idtarea, idcultivo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);