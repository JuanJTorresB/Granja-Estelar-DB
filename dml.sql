INSERT INTO Dia (nombre) VALUES 
('Domingo'),
('Lunes'),
('Martes'),
('Miércoles'),
('Jueves'),
('Viernes'),
('Sábado');

INSERT INTO Zona (nombre, area) VALUES 
('Zona Norte', 30.00),
('Zona Sur', 40.00),
('Zona Este', 20.00),
('Zona Oeste', 20.00),
('Zona Central', 50.00);

INSERT INTO TipoRecinto (nombre) VALUES 
('Establo'),
('Gallinero'),
('Apiario'),
('Porqueriza');

INSERT INTO Recinto (idTipoRecinto, idZona, nombre) VALUES 
(1, 1, 'Establo 1'),
(1, 2, 'Establo 2'),
(2, 3, 'Gallinero 1'),
(2, 4, 'Gallinero 2'),
(3, 5, 'Apiario 1'),
(4, 1, 'Porqueriza 1'),
(4, 2, 'Porqueriza 2');

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
('Azadón', 50, 4),
('Pala', 75, 4),
('Semillas de maíz', 100, 1),
('Insecticida', 150, 2),
('Herbicida', 250, 2),
('Vacuna bovina', 500, 3),
('Vacuna aviar', 400, 3),
('Comida para ovejas', 600, 1),
('Comida para cerdos', 700, 1),
('Alimento para peces', 450, 1),
('Abono químico', 350, 2),
('Rastrillo', 60, 4),
('Comida para caballos', 800, 1),
('Sueros', 150, 3),
('Pesticida natural', 120, 2),
('Compost', 180, 2),
('Antiinflamatorios', 90, 3),
('Hormonas de crecimiento', 130, 3),
('Semillas de trigo', 200, 1),
('Guantes de trabajo', 300, 4),
('Antiparasitarios', 250, 3),
('Comida para conejos', 350, 1),
('Comida para patos', 270, 1),
('Desinfectante', 200, 3),
('Herramienta multiusos', 20, 4),
('Comida para abejas', 100, 1),
('Fertilizante de nitrógeno', 130, 2),
('Repelente de plagas', 90, 2),
('Machete', 60, 4),
('Antibacterianos', 110, 3),
('Insecticida biológico', 220, 2),
('Semillas de avena', 130, 1),
('Casco de seguridad', 40, 4),
('Gafas protectoras', 80, 4),
('Antifúngico', 90, 3),
('Semillas de arroz', 300, 1),
('Desinfectante animal', 250, 3),
('Comida para cabras', 400, 1),
('Fertilizante potásico', 220, 2),
('Pinzas para alambre', 50, 4),
('Antimicrobianos', 150, 3),
('Comida para pavos', 250, 1),
('Herbicida ecológico', 180, 2),
('Antiséptico', 90, 3),
('Tijeras de podar', 30, 4);

INSERT INTO Proveedor (nombre, activo) VALUES
('Proveedor A', 'Activo'),
('Proveedor B', 'Activo'),
('Proveedor C', 'Inactivo'),
('Proveedor D', 'Activo'),
('Proveedor E', 'Activo'),
('Proveedor F', 'Inactivo'),
('Proveedor G', 'Activo'),
('Proveedor H', 'Activo'),
('Proveedor I', 'Inactivo'),
('Proveedor J', 'Activo'),
('Proveedor K', 'Activo'),
('Proveedor L', 'Inactivo'),
('Proveedor M', 'Activo'),
('Proveedor N', 'Activo'),
('Proveedor O', 'Inactivo'),
('Proveedor P', 'Activo'),
('Proveedor Q', 'Activo'),
('Proveedor R', 'Inactivo'),
('Proveedor S', 'Activo'),
('Proveedor T', 'Activo'),
('Proveedor U', 'Inactivo'),
('Proveedor V', 'Activo'),
('Proveedor W', 'Activo'),
('Proveedor X', 'Inactivo'),
('Proveedor Y', 'Activo'),
('Proveedor Z', 'Activo'),
('Proveedor AA', 'Inactivo'),
('Proveedor AB', 'Activo'),
('Proveedor AC', 'Activo'),
('Proveedor AD', 'Inactivo'),
('Proveedor AE', 'Activo'),
('Proveedor AF', 'Activo'),
('Proveedor AG', 'Inactivo'),
('Proveedor AH', 'Activo'),
('Proveedor AI', 'Activo'),
('Proveedor AJ', 'Inactivo'),
('Proveedor AK', 'Activo'),
('Proveedor AL', 'Activo'),
('Proveedor AM', 'Inactivo'),
('Proveedor AN', 'Activo'),
('Proveedor AO', 'Activo'),
('Proveedor AP', 'Inactivo'),
('Proveedor AQ', 'Activo'),
('Proveedor AR', 'Activo'),
('Proveedor AS', 'Inactivo'),
('Proveedor AT', 'Activo'),
('Proveedor AU', 'Activo'),
('Proveedor AV', 'Inactivo'),
('Proveedor AW', 'Activo'),
('Proveedor AX', 'Activo');


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

INSERT INTO TipoCultivo (nombre, inicioTemporada, finTemporada) VALUES
('Trigo', '2024-10-01', '2024-12-15'),
('Maíz', '2024-10-10', '2025-01-20'),
('Soya', '2024-10-15', '2025-01-30'),
('Cebada', '2024-10-20', '2025-02-10'),
('Arroz', '2024-10-25', '2025-03-01'),
('Caña de Azúcar', '2024-11-01', '2025-03-15'),
('Avena', '2024-11-05', '2025-02-20'),
('Algodón', '2024-11-10', '2025-03-25'),
('Girasol', '2024-11-15', '2025-04-05'),
('Papa', '2024-11-20', '2025-04-15'),
('Remolacha', '2024-11-25', '2025-05-01'),
('Café', '2024-12-01', '2025-06-15'),
('Té', '2024-12-05', '2025-06-20'),
('Cacao', '2024-12-10', '2025-07-01'),
('Frijol', '2024-12-15', '2025-05-15'),
('Maní', '2024-12-20', '2025-06-01'),
('Trigo Duro', '2025-01-01', '2025-04-15'),
('Mijo', '2025-01-05', '2025-06-10'),
('Sorgo', '2025-01-10', '2025-06-25'),
('Arroz de Riego', '2025-01-15', '2025-07-01'),
('Lenteja', '2025-01-20', '2025-05-25'),
('Chía', '2025-01-25', '2025-06-10'),
('Linaza', '2025-02-01', '2025-06-20'),
('Garbanzos', '2025-02-05', '2025-06-25'),
('Cebolla', '2025-02-10', '2025-07-01'),
('Ajo', '2025-02-15', '2025-07-15'),
('Zanahoria', '2025-02-20', '2025-07-30'),
('Tomate', '2025-02-25', '2025-08-15'),
('Pepino', '2025-03-01', '2025-08-25'),
('Pimiento', '2025-03-05', '2025-09-05'),
('Lechuga', '2025-03-10', '2025-09-20'),
('Espinaca', '2025-03-15', '2025-09-30'),
('Brócoli', '2025-03-20', '2025-10-10'),
('Coliflor', '2025-03-25', '2025-10-20'),
('Rábano', '2025-04-01', '2025-10-30'),
('Cilantro', '2025-04-05', '2025-11-10'),
('Perejil', '2025-04-10', '2025-11-20'),
('Albahaca', '2025-04-15', '2025-12-01'),
('Orégano', '2025-04-20', '2025-12-10'),
('Menta', '2025-04-25', '2025-12-20'),
('Romero', '2025-05-01', '2026-01-01'),
('Tomillo', '2025-05-05', '2026-01-10'),
('Lavanda', '2025-05-10', '2026-01-20'),
('Manzanilla', '2025-05-15', '2026-01-30'),
('Berenjena', '2025-05-20', '2026-02-10'),
('Calabaza', '2025-05-25', '2026-02-20'),
('Sandía', '2025-06-01', '2026-03-01'),
('Melón', '2025-06-05', '2026-03-10'),
('Uva', '2025-06-10', '2026-03-20');


INSERT INTO Cultivo (area, fechaSiembra, fechaCosecha, idTipoCultivo, idZona) VALUES
(1.5, '2024-10-01', '2024-12-15', 1, 1),  -- Trigo en Zona Norte
(2.0, '2024-10-10', '2025-01-20', 2, 2),  -- Maíz en Zona Sur
(0.75, '2024-10-15', '2025-01-30', 3, 3),  -- Soya en Zona Este
(1.0, '2024-10-20', '2025-02-10', 4, 4),  -- Cebada en Zona Oeste
(2.5, '2024-10-25', '2025-03-01', 5, 5),  -- Arroz en Zona Central
(1.5, '2024-11-01', '2025-03-15', 6, 1),  -- Caña de Azúcar en Zona Norte
(2.0, '2024-11-05', '2025-02-20', 7, 2),  -- Avena en Zona Sur
(1.25, '2024-11-10', '2025-03-25', 8, 3), -- Algodón en Zona Este
(1.5, '2024-11-15', '2025-04-05', 9, 4),  -- Girasol en Zona Oeste
(3.0, '2024-11-20', '2025-04-15', 10, 5), -- Papa en Zona Central
(2.0, '2024-12-01', '2025-06-15', 11, 1), -- Remolacha en Zona Norte
(3.0, '2024-12-05', '2025-06-20', 12, 2), -- Café en Zona Sur
(1.0, '2024-12-10', '2025-07-01', 13, 3), -- Té en Zona Este
(0.75, '2024-12-15', '2025-05-15', 14, 4), -- Cacao en Zona Oeste
(3.5, '2024-12-20', '2025-06-01', 15, 5), -- Frijol en Zona Central
(1.25, '2025-01-01', '2025-04-15', 16, 1), -- Maní en Zona Norte
(2.0, '2025-01-05', '2025-06-10', 17, 2), -- Trigo Duro en Zona Sur
(1.0, '2025-01-10', '2025-06-25', 18, 3), -- Mijo en Zona Este
(1.5, '2025-01-15', '2025-07-01', 19, 4), -- Sorgo en Zona Oeste
(4.0, '2025-01-20', '2025-05-25', 20, 5), -- Arroz de Riego en Zona Central
(1.5, '2025-01-25', '2025-06-10', 21, 1), -- Lenteja en Zona Norte
(2.5, '2025-02-01', '2025-06-20', 22, 2), -- Chía en Zona Sur
(1.0, '2025-02-05', '2025-06-25', 23, 3), -- Linaza en Zona Este
(1.25, '2025-02-10', '2025-07-01', 24, 4), -- Garbanzos en Zona Oeste
(5.0, '2025-02-15', '2025-07-15', 25, 5), -- Cebolla en Zona Central
(2.0, '2025-02-20', '2025-07-30', 26, 1), -- Ajo en Zona Norte
(3.0, '2025-02-25', '2025-08-15', 27, 2), -- Zanahoria en Zona Sur
(1.5, '2025-03-01', '2025-08-25', 28, 3), -- Tomate en Zona Este
(1.25, '2025-03-05', '2025-09-05', 29, 4), -- Pepino en Zona Oeste
(6.0, '2025-03-10', '2025-09-20', 30, 5), -- Pimiento en Zona Central
(2.0, '2025-03-15', '2025-09-30', 31, 1), -- Lechuga en Zona Norte
(3.5, '2025-03-20', '2025-10-10', 32, 2), -- Espinaca en Zona Sur
(1.0, '2025-03-25', '2025-10-20', 33, 3), -- Brócoli en Zona Este
(1.25, '2025-04-01', '2025-10-30', 34, 4), -- Coliflor en Zona Oeste
(5.0, '2025-04-05', '2025-11-10', 35, 5), -- Rábano en Zona Central
(1.5, '2025-04-10', '2025-11-20', 36, 1), -- Cilantro en Zona Norte
(2.0, '2025-04-15', '2025-12-01', 37, 2), -- Perejil en Zona Sur
(1.0, '2025-04-20', '2025-12-10', 38, 3), -- Albahaca en Zona Este
(0.75, '2025-04-25', '2025-12-20', 39, 4), -- Orégano en Zona Oeste
(6.0, '2025-05-01', '2026-01-01', 40, 5), -- Menta en Zona Central
(2.0, '2025-05-05', '2026-01-10', 41, 1), -- Romero en Zona Norte
(3.0, '2025-05-10', '2026-01-20', 42, 2), -- Tomillo en Zona Sur
(1.5, '2025-05-15', '2026-01-30', 43, 3), -- Lavanda en Zona Este
(1.0, '2025-05-20', '2026-02-10', 44, 4), -- Manzanilla en Zona Oeste
(6.5, '2025-05-25', '2026-02-20', 45, 5); -- Berenjena en Zona Central


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
(2, 'Huevos', 500, 20000),
(3, 'Maíz', 300, 3000),
(4, 'Arroz', 200, 2000),
(5, 'Miel', 400, 1000);

INSERT INTO RecintoXProducto (idRecinto, idProducto, cantidad) VALUES 
(1, 1, 100),
(2, 1, 50),
(3, 2, 30),
(4, 2, 20),
(5, 5, 40);

INSERT INTO TipoTarea (nombre) VALUES
('Alimentar animales'),
('Recolectar Produccion Animal'),
('Regar Cultivos'),
('Control de plagas'),
('Recolectar Produccion Agricola'),
('Podar Árboles'),
('Fertilizar Cultivos'),
('Limpieza de Corrales'),
('Ordenar el Establo'),
('Sembrar Nuevos Cultivos'),
('Desinfectar Establos'),
('Trasladar Animales'),
('Limpieza de Canaletas de Riego'),
('Mantenimiento de Equipos Agrícolas'),
('Rotación de Pastizales'),
('Reparar Vallas y Cercas'),
('Mantener el Sistema de Riego'),
('Reparar Maquinaria'),
('Cosecha Manual'),
('Arar la Tierra'),
('Control de Maleza'),
('Vacunación de Animales'),
('Monitoreo de la Salud Animal'),
('Cultivo Hidropónico'),
('Control de Temperatura en Invernaderos'),
('Siembra Directa'),
('Manejo de Almacenamiento de Grano'),
('Control de Humedad en Cultivos'),
('Desbrozar Terreno'),
('Cargar y Descargar Productos'),
('Clasificar Productos Cosechados'),
('Preparar Terreno para Siembra'),
('Pastoreo Supervisado'),
('Reproducción Animal'),
('Mantenimiento de Invernaderos'),
('Limpieza de Equipos Agrícolas'),
('Distribución de Alimentos para Animales'),
('Supervisión de Trabajadores'),
('Control de Calidad en la Producción'),
('Instalación de Sistemas de Riego'),
('Monitoreo de Condiciones Climáticas'),
('Cuidado de Animales Recién Nacidos'),
('Planificación de Cosechas'),
('Optimización de Recursos Agrícolas'),
('Rotación de Cosechas'),
('Monitoreo de Plagas y Enfermedades'),
('Recolección de Semillas'),
('Venta y Distribución de Productos'),
('Capacitación de Personal'),
('Mantenimiento de Infraestructuras Agrícolas');

INSERT INTO Tarea (idTipoTarea, fechaInicio, fechaFin, descripcion, estado) VALUES
(1, '2024-10-01 08:00:00', '2024-10-01 10:00:00', 'Alimentar a los animales en el establo', 'Pendiente'),
(1, '2024-10-02 08:00:00', '2024-10-02 10:00:00', 'Alimentar a los animales en el corral', 'Pendiente'),
(1, '2024-10-03 08:00:00', '2024-10-03 10:00:00', 'Alimentar a los animales en el establo', 'Terminada'),
(1, '2024-10-04 08:00:00', '2024-10-04 10:00:00', 'Alimentar a los animales en el corral', 'Pendiente'),
(2, '2024-10-01 08:00:00', '2024-10-01 10:00:00', 'Recolectar Producción de los animales en el establo', 'Pendiente'),
(2, '2024-10-02 08:00:00', '2024-10-02 10:00:00', 'Recolectar huevos de las gallinas', 'Pendiente'),
(2, '2024-10-03 08:00:00', '2024-10-03 10:00:00', 'Recolectar leche de las vacas', 'Terminada'),
(2, '2024-10-04 08:00:00', '2024-10-04 10:00:00', 'Recolectar Producción de los animales en el establo', 'Pendiente'),
(3, '2024-10-05 08:00:00', '2024-10-05 12:00:00', 'Regar los cultivos de maíz', 'Pendiente'),
(3, '2024-10-06 08:00:00', '2024-10-06 12:00:00', 'Regar los cultivos de trigo', 'Pendiente'),
(3, '2024-10-07 08:00:00', '2024-10-07 12:00:00', 'Regar los cultivos de cebada', 'Pendiente'),
(3, '2024-10-08 08:00:00', '2024-10-08 12:00:00', 'Regar los cultivos de arroz', 'Terminada'),
(4, '2024-10-02 08:00:00', '2024-10-02 10:00:00', 'Revisar el estado de los cultivos de maíz', 'Pendiente'),
(4, '2024-10-03 08:00:00', '2024-10-03 10:00:00', 'Revisar el estado de los cultivos de trigo', 'Terminada'),
(4, '2024-10-04 08:00:00', '2024-10-04 10:00:00', 'Revisar el estado de los cultivos de cebada', 'Pendiente'),
(4, '2024-10-05 08:00:00', '2024-10-05 10:00:00', 'Revisar el estado de los cultivos de arroz', 'Pendiente'),
(5, '2024-10-06 08:00:00', '2024-10-06 13:00:00', 'Recolectar producción agrícola de maíz', 'Pendiente'),
(5, '2024-10-07 08:00:00', '2024-10-07 13:00:00', 'Recolectar producción agrícola de trigo', 'Pendiente'),
(5, '2024-10-08 08:00:00', '2024-10-08 13:00:00', 'Recolectar producción agrícola de cebada', 'Pendiente'),
(5, '2024-10-09 08:00:00', '2024-10-09 13:00:00', 'Recolectar producción agrícola de arroz', 'Pendiente'),
(6, '2024-10-10 08:00:00', '2024-10-10 11:00:00', 'Podar los árboles frutales', 'Pendiente'),
(6, '2024-10-11 08:00:00', '2024-10-11 11:00:00', 'Podar los árboles de olivo', 'Pendiente'),
(6, '2024-10-12 08:00:00', '2024-10-12 11:00:00', 'Podar los viñedos', 'Pendiente'),
(6, '2024-10-13 08:00:00', '2024-10-13 11:00:00', 'Podar los árboles de manzana', 'Terminada'),
(7, '2024-10-14 08:00:00', '2024-10-14 12:00:00', 'Fertilizar los cultivos de maíz', 'Pendiente'),
(7, '2024-10-15 08:00:00', '2024-10-15 12:00:00', 'Fertilizar los cultivos de trigo', 'Pendiente'),
(7, '2024-10-16 08:00:00', '2024-10-16 12:00:00', 'Fertilizar los cultivos de cebada', 'Pendiente'),
(7, '2024-10-17 08:00:00', '2024-10-17 12:00:00', 'Fertilizar los cultivos de arroz', 'Pendiente'),
(8, '2024-10-18 08:00:00', '2024-10-18 10:00:00', 'Limpieza de corrales', 'Pendiente'),
(8, '2024-10-19 08:00:00', '2024-10-19 10:00:00', 'Limpieza de establos', 'Terminada'),
(8, '2024-10-20 08:00:00', '2024-10-20 10:00:00', 'Limpieza de corrales', 'Pendiente'),
(8, '2024-10-21 08:00:00', '2024-10-21 10:00:00', 'Limpieza de establos', 'Pendiente'),
(9, '2024-10-22 08:00:00', '2024-10-22 09:30:00', 'Ordenar el establo', 'Pendiente'),
(9, '2024-10-23 08:00:00', '2024-10-23 09:30:00', 'Ordenar el corral', 'Pendiente'),
(9, '2024-10-24 08:00:00', '2024-10-24 09:30:00', 'Ordenar el establo', 'Terminada'),
(9, '2024-10-25 08:00:00', '2024-10-25 09:30:00', 'Ordenar el corral', 'Pendiente'),
(10, '2024-10-26 08:00:00', '2024-10-26 12:00:00', 'Sembrar nuevos cultivos de maíz', 'Pendiente'),
(10, '2024-10-27 08:00:00', '2024-10-27 12:00:00', 'Sembrar nuevos cultivos de trigo', 'Pendiente'),
(10, '2024-10-28 08:00:00', '2024-10-28 12:00:00', 'Sembrar nuevos cultivos de cebada', 'Terminada'),
(10, '2024-10-29 08:00:00', '2024-10-29 12:00:00', 'Sembrar nuevos cultivos de arroz', 'Pendiente');

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
('Administrador'),
('Capataz'),
('Contador');

INSERT INTO Empleado (nombre, idCargo, fechaContratacion, salario) VALUES
('Juan Pérez', 1, '2023-01-15', 2000000),
('Ana Gómez', 2, '2023-02-20', 1800000),
('Carlos Martínez', 3, '2023-03-10', 2500000),
('Laura López', 4, '2023-04-05', 2200000),
('Nate Gentile', 6, '2023-04-05', 2200000),
('Pedro Ruiz', 5, '2023-05-15', 3000000),
('María Fernández', 2, '2023-06-01', 1900000),
('Jorge Ramírez', 1, '2023-06-10', 2100000),
('Sofía Méndez', 4, '2023-07-01', 2300000),
('Luis Ortega', 3, '2023-07-15', 2600000),
('Gabriela Sánchez', 5, '2023-08-01', 2900000),
('David Torres', 2, '2023-08-15', 1800000),
('Elena Castro', 1, '2023-09-01', 2000000),
('Hugo Morales', 3, '2023-09-10', 2400000),
('Isabel Ramos', 4, '2023-10-01', 2250000),
('Santiago Silva', 6, '2023-10-15', 2150000),
('Alejandra Castillo', 5, '2023-11-01', 3100000),
('Manuel Vega', 2, '2023-11-10', 1850000),
('Patricia Gómez', 1, '2023-12-01', 2050000),
('Mario Calderón', 3, '2023-12-15', 2550000),
('Luisa Acosta', 4, '2023-12-20', 2200000),
('Fernando Reyes', 5, '2024-01-05', 3200000),
('Andrea Duarte', 6, '2024-01-10', 2100000),
('Ricardo Pineda', 2, '2024-01-20', 1950000),
('Lucía Hernández', 1, '2024-02-01', 2000000),
('Tomás Cabrera', 3, '2024-02-15', 2450000),
('Camila Vargas', 4, '2024-02-20', 2300000),
('José Jiménez', 5, '2024-03-01', 3100000),
('Paola Flores', 2, '2024-03-15', 1800000),
('Enrique Guzmán', 1, '2024-04-01', 2100000),
('Carla Núñez', 3, '2024-04-10', 2500000),
('Miguel Serrano', 4, '2024-04-15', 2250000),
('Sara Medina', 6, '2024-05-01', 2150000),
('Daniela Romero', 5, '2024-05-10', 2950000),
('Cristian Peña', 2, '2024-06-01', 1900000),
('Esteban López', 1, '2024-06-15', 2050000),
('Verónica Vázquez', 3, '2024-07-01', 2600000),
('Julián Álvarez', 4, '2024-07-10', 2350000),
('Carmen Suárez', 5, '2024-07-20', 3050000),
('Sebastián Palacios', 6, '2024-08-01', 2200000),
('Marcos León', 2, '2024-08-10', 1850000),
('Antonia Reyes', 1, '2024-08-20', 2100000),
('Guillermo Rojas', 3, '2024-09-01', 2550000),
('Natalia Paredes', 4, '2024-09-10', 2250000),
('Julio Peralta', 5, '2024-09-20', 3150000),
('Beatriz Molina', 2, '2024-10-01', 1950000),
('Rodrigo Figueroa', 1, '2024-10-10', 2150000),
('Silvia Lara', 3, '2024-10-20', 2600000);

INSERT INTO Cliente (nombre, telefono) VALUES
('Claudia Rojas', '1234567891'),
('Miguel Rodríguez', '2345678912'),
('Sofía García', '3456789012'),
('Julio Fernández', '4567891230'),
('Luisa Morales', '5678901234'),
('Carlos Méndez', '6789012345'),
('Ana Torres', '7890123456'),
('Jorge González', '8901234567'),
('María López', '9012345678'),
('Pablo Suárez', '0123456789'),
('Fernanda Castillo', '1234567800'),
('José Ruiz', '2345678901'),
('Isabel Gutiérrez', '3456789011'),
('Gabriel Vargas', '4567890122'),
('Lucía Gómez', '5678901233'),
('Antonio Pérez', '6789012344'),
('Valeria Romero', '7890123455'),
('Felipe Ortega', '8901234566'),
('Natalia Medina', '9012345677'),
('Emilio Ramírez', '0123456788'),
('Cristina Martínez', '1234567899'),
('Diego Silva', '2345678910'),
('Lorena Jiménez', '3456789020'),
('Ricardo Hernández', '4567891231'),
('Susana Vega', '5678901241'),
('Javier Ramos', '6789012351'),
('Andrea León', '7890123461'),
('Mauricio Paredes', '8901234571'),
('Patricia Serrano', '9012345681'),
('Roberto Cruz', '0123456791'),
('Laura Vargas', '1234567811'),
('Enrique Castillo', '2345678913'),
('Elena Reyes', '3456789023'),
('Pedro Morales', '4567891243'),
('Carmen Fernández', '5678901253'),
('Daniel Martínez', '6789012363'),
('Monica Torres', '7890123473'),
('Víctor Gómez', '8901234583'),
('Silvia Flores', '9012345693'),
('Raúl Soto', '0123456702'),
('Gabriela Mendoza', '1234567822'),
('Tomás Aguirre', '2345678923'),
('Alejandra Peña', '3456789033'),
('Esteban Navarro', '4567891254'),
('Paola Guerrero', '5678901264'),
('Ignacio Vásquez', '6789012374'),
('Daniela Bustamante', '7890123484'),
('Julián Cárdenas', '8901234594'),
('Verónica Miranda', '9012345605'),
('Francisco Campos', '0123456715');

INSERT INTO Venta (idCliente, idEmpleado, fecha, total) VALUES 
(1, 1, '2024-10-01', 50000),
(2, 2, '2024-10-02', 100000),
(3, 3, '2024-10-03', 75000),
(4, 4, '2024-10-04', 125000),
(5, 5, '2024-10-05', 60000);

INSERT INTO Vacacion (idEmpleado, fechaInicio, fechaFin, estado) VALUES 
(1, '2024-10-01', '2024-10-08', "Disfrutada"),
(2, '2024-10-02', '2024-10-09', "Disfrutada"),
(3, '2024-10-03', '2024-10-10', "Disfrutada"),
(4, '2024-10-20', '2024-10-27', "Pendiente"),
(5, '2024-10-20', '2024-10-28', "Pendiente");

INSERT INTO ProductoXVenta (idVenta, idProducto, cantidad) VALUES 
(1, 1, 10),
(2, 2, 5),
(3, 3, 25),
(4, 4, 50),
(5, 5, 60);

INSERT INTO Horario (idDia, horainicio, horafin) VALUES
(1, '08:00:00', '12:00:00'),
(2, '09:00:00', '13:00:00'),
(3, '10:00:00', '14:00:00'),
(4, '11:00:00', '15:00:00'),
(5, '12:00:00', '16:00:00');

INSERT INTO EmpleadoXHorario (idEmpleado, idhorario) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO EmpleadoXTarea (idEmpleado, idtarea) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO Mantenimiento (idMaquinaria, fecha, costo) VALUES
(1, '2024-10-01', 50000),
(2, '2024-10-02', 75000),
(3, '2024-10-03', 60000),
(4, '2024-10-04', 80000),
(5, '2024-10-05', 55000);

INSERT INTO TareaXCultivo (idTarea, idCultivo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);