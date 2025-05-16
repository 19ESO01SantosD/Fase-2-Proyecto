CREATE DATABASE IF NOT EXISTS VertelProyectoFaseII;
USE VertelProyectoFaseII;

CREATE TABLE CategoriaCliente (
    id_Categoria INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_categoria VARCHAR(50)
);

CREATE TABLE Cliente (
    id_Cliente INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Correo VARCHAR(100),
    Telefono VARCHAR(20),
    id_Categoria INT,
    FOREIGN KEY (id_Categoria) REFERENCES CategoriaCliente(id_Categoria)
);

CREATE TABLE Empleado (
    id_Empleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Puesto VARCHAR(50),
    Salario DECIMAL(10, 2)
);

CREATE TABLE Proveedor (
    id_Proveedor INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100),
    Contacto VARCHAR(100),
    Telefono VARCHAR(20)
);

CREATE TABLE Articulo (
    id_Articulo INT AUTO_INCREMENT PRIMARY KEY,
    Descripcion VARCHAR(100),
    Precio DECIMAL(10, 2),
    Stock INT,
    id_Proveedor INT,
    FOREIGN KEY (id_Proveedor) REFERENCES Proveedor(id_Proveedor)
);

CREATE TABLE Venta (
    id_Venta INT AUTO_INCREMENT PRIMARY KEY,
    id_Cliente INT,
    Fecha DATE,
    Metodo_pago VARCHAR(50),
    Total DECIMAL(10, 2),
    FOREIGN KEY (id_Cliente) REFERENCES Cliente(id_Cliente)
);

CREATE TABLE DetalleVenta (
    id_Detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_Venta INT,
    id_Articulo INT,
    Cantidad INT,
    Precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (id_Venta) REFERENCES Venta(id_Venta),
    FOREIGN KEY (id_Articulo) REFERENCES Articulo(id_Articulo)
);

CREATE TABLE Compra (
    id_Compra INT AUTO_INCREMENT PRIMARY KEY,
    id_Proveedor INT,
    Fecha DATE,
    Total DECIMAL(10, 2),
    Tipo_pago VARCHAR(50),
    FOREIGN KEY (id_Proveedor) REFERENCES Proveedor(id_Proveedor)
);

CREATE TABLE DetalleCompra (
    id_Detallecompra INT AUTO_INCREMENT PRIMARY KEY,
    id_Compra INT,
    id_Articulo INT,
    Cantidad INT,
    Precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (id_Compra) REFERENCES Compra(id_Compra),
    FOREIGN KEY (id_Articulo) REFERENCES Articulo(id_Articulo)
);

CREATE TABLE PagoProveedor (
    id_Pago INT AUTO_INCREMENT PRIMARY KEY,
    id_Compra INT,
    Monto DECIMAL(10, 2),
    Fecha_limite DATE,
    FOREIGN KEY (id_Compra) REFERENCES Compra(id_Compra)
);

INSERT INTO CategoriaCliente (Nombre_categoria) 
VALUES 
('Regular'), ('VIP');

INSERT INTO Cliente (Nombre, Correo, Telefono, id_Categoria) 
VALUES 
('Carlos Pérez', 'carlos@email.com', '5551-1234', 1), ('Ana López', 'ana@email.com', '5552-5678', 2);

INSERT INTO Empleado (Nombre, Puesto, Salario) 
VALUES 
('Luis Martínez', 'Vendedor', 3500.00), ('Marta Gómez', 'Gerente', 5000.00);

INSERT INTO Proveedor (Nombre, Contacto, Telefono) 
VALUES 
('DistriTech', 'Juan Almanza', '156545'), ('CompuVenta', 'Lucía Pato', '455174');

INSERT INTO Articulo (Descripcion, Precio, Stock, id_Proveedor) 
VALUES 
('Mouse Inalámbrico', 150.00, 40, 1), ('Teclado Mecánico', 350.00, 20, 2);
INSERT INTO Venta (id_Cliente, Fecha, Metodo_pago, Total)
VALUES 
(1, '2025-05-10', 'Efectivo', 150.00), (2, '2025-05-12', 'Tarjeta', 350.00);

INSERT INTO DetalleVenta (id_Venta, id_Articulo, Cantidad, Precio_unitario) 
VALUES 
(1, 1, 1, 150.00), (2, 2, 1, 350.00);

INSERT INTO Compra (id_Proveedor, Fecha, Tipo_pago, Total) 
VALUES 
(1, '2025-04-30', 'Transferencia', 3000.00), (2, '2025-05-01', 'Efectivo', 2000.00);

INSERT INTO DetalleCompra (id_Compra, id_Articulo, Cantidad, Precio_unitario) 
VALUES 
(1, 1, 20, 150.00), (2, 2, 10, 200.00);

INSERT INTO PagoProveedor (id_Compra, Monto, Fecha_limite) VALUES 
(1, 3000.00, '2025-05-15'), (2, 2000.00, '2025-05-20');

SELECT v.id_Venta, c.Nombre, v.Fecha, v.Metodo_pago, v.Total
FROM Venta v
INNER JOIN Cliente c ON v.id_Cliente = c.id_Cliente;

SELECT a.Descripcion, a.Precio, p.Nombre AS Proveedor
FROM Articulo a
INNER JOIN Proveedor p ON a.id_Proveedor = p.id_Proveedor;


SELECT pr.Nombre, co.Fecha, co.Total
FROM Compra co
INNER JOIN Proveedor pr ON co.id_Proveedor = pr.id_Proveedor;

SELECT Nombre, Puesto, Salario FROM Empleado;