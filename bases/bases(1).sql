-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-11-2024 a las 02:53:58
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bases`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id_Administrador` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de administradores',
  `nombreAdministrador` varchar(11) NOT NULL COMMENT 'Nombre del administrador del sistema',
  `claveAdministrador` varchar(11) NOT NULL COMMENT 'Clave del administrador del sistema'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id_Administrador`, `nombreAdministrador`, `claveAdministrador`) VALUES
(1, 'bases1', 'bases1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alergia`
--

CREATE TABLE `alergia` (
  `id_Alergia` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de la alergia',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre de la alergia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alergia`
--

INSERT INTO `alergia` (`id_Alergia`, `nombre`) VALUES
(21, ''),
(3, 'Ácaros del polvo'),
(22, 'Array'),
(4, 'Cáscara de nuez'),
(13, 'Citrus (frutas cítricas)'),
(14, 'Cobre'),
(11, 'Frutillas'),
(6, 'Huevo'),
(16, 'Látex'),
(5, 'Leche'),
(12, 'Maní'),
(7, 'Mariscos'),
(1, 'No reconocida'),
(8, 'Pescado'),
(15, 'Plástico'),
(2, 'Polen'),
(18, 'Prueba alergia'),
(10, 'Soja'),
(9, 'Trigo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

CREATE TABLE `calificacion` (
  `id_Calificacion` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de calificaciones de cita',
  `calificacion` int(11) NOT NULL COMMENT 'Grado de calificación de la cita',
  `descripcion` varchar(125) NOT NULL COMMENT 'Descripción adicional de la cita',
  `id_Cita` int(11) NOT NULL COMMENT 'Relación con la tabla de cita'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificacion`
--

INSERT INTO `calificacion` (`id_Calificacion`, `calificacion`, `descripcion`, `id_Cita`) VALUES
(1, 5, 'Excelente servicio, me atendieron demasiado bien... Recomendados!!!', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cargo`
--

CREATE TABLE `cargo` (
  `id_Cargo` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del cargo',
  `nombre` varchar(50) NOT NULL COMMENT 'Nombre del cargo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cargo`
--

INSERT INTO `cargo` (`id_Cargo`, `nombre`) VALUES
(4, 'Cirujano Plástico'),
(1, 'Dermatólogo'),
(2, 'Esteticista'),
(3, 'Recepcionista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `id_Cita` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de la cita',
  `fecha` date NOT NULL COMMENT 'Fecha de la programación de la cita',
  `duracion` time NOT NULL COMMENT 'Duración de la cita',
  `id_Cliente` int(11) NOT NULL COMMENT 'Relación con la tabla de clientes',
  `id_Empleado` int(11) NOT NULL COMMENT 'Relación con la tabla empleados',
  `id_Producto` int(11) NOT NULL COMMENT 'Relación con la tabla de productos'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_Cita`, `fecha`, `duracion`, `id_Cliente`, `id_Empleado`, `id_Producto`) VALUES
(17, '2024-11-22', '01:00:00', 1, 2, 1),
(18, '2024-11-22', '01:00:00', 2, 3, 2),
(19, '2024-11-23', '01:30:00', 3, 1, 3),
(20, '2024-11-23', '00:45:00', 4, 4, 4),
(21, '2024-11-24', '01:00:00', 5, 2, 5),
(22, '2024-11-24', '00:30:00', 6, 3, 6),
(23, '2024-11-25', '01:00:00', 7, 4, 8),
(24, '2024-11-22', '01:30:00', 1, 2, 1),
(25, '2024-11-23', '02:00:00', 3, 1, 3),
(26, '2024-11-23', '01:15:00', 4, 4, 4),
(27, '2024-11-24', '01:30:00', 5, 2, 5),
(28, '2024-11-25', '02:30:00', 7, 4, 8),
(29, '2024-11-21', '01:00:00', 1, 1, 1),
(30, '2024-11-21', '00:45:00', 2, 1, 2),
(31, '2024-11-21', '00:30:00', 3, 1, 3),
(32, '2024-11-21', '01:30:00', 4, 1, 4),
(33, '2024-11-21', '01:00:00', 5, 1, 5),
(34, '2024-11-21', '00:45:00', 6, 1, 6),
(35, '2024-11-21', '00:30:00', 7, 1, 8),
(36, '2024-11-22', '01:00:00', 8, 1, 1),
(37, '2024-11-22', '00:45:00', 9, 1, 2),
(38, '2024-11-22', '00:30:00', 10, 1, 3),
(39, '2024-11-22', '01:30:00', 11, 1, 4),
(40, '2024-11-22', '01:00:00', 12, 1, 5),
(41, '2024-11-22', '00:45:00', 13, 1, 6),
(42, '2024-11-22', '00:30:00', 14, 1, 8),
(43, '2024-11-23', '01:00:00', 15, 1, 1),
(44, '2024-11-23', '00:45:00', 16, 1, 2),
(45, '2024-11-23', '00:30:00', 17, 1, 3),
(46, '2024-11-23', '01:30:00', 18, 1, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_Cliente` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de clientes',
  `nombre01` varchar(50) NOT NULL COMMENT 'Primer nombre del cliente',
  `nombre02` varchar(50) DEFAULT NULL COMMENT 'Segundo nombre del cliente',
  `apellido01` varchar(50) NOT NULL COMMENT 'Primer apellido del cliente',
  `apellido02` varchar(50) DEFAULT NULL COMMENT 'Segundo apellido del cliente',
  `fecha_nacimiento` date NOT NULL COMMENT 'Fecha de nacimiento del cliente',
  `residencia` varchar(50) NOT NULL COMMENT 'Residencia del cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_Cliente`, `nombre01`, `nombre02`, `apellido01`, `apellido02`, `fecha_nacimiento`, `residencia`) VALUES
(1, 'Alisson', 'Camila', 'Campos', 'Rendon', '2001-11-16', 'Calle 14 # 20-31'),
(2, 'Santiago', 'Alberto', 'Trujillo', 'Patiño', '2003-01-29', 'Calle 9 # 20-27'),
(3, 'Esteban', 'Camilo', 'Idarraga', 'Campos', '1999-11-15', 'Calle 2 # 14-06'),
(4, 'karen', '', 'Castaño', '', '2024-10-30', 'calle 28'),
(5, 'Juan', 'Carlos', 'Castaño', '', '2024-10-31', 'calle 2'),
(6, 'Juan', 'Carlos', 'Pérez', 'Gómez', '1995-05-12', 'Bogotá'),
(7, 'María', 'Fernanda', 'Rodríguez', 'López', '1987-03-22', 'Medellín'),
(8, 'Ana', 'Isabel', 'Ramírez', 'Torres', '1990-07-09', 'Cali'),
(9, 'Pedro', 'Alejandro', 'Morales', 'Martínez', '1985-10-18', 'Bucaramanga'),
(10, 'Laura', 'Camila', 'Martínez', 'Vargas', '1975-08-05', 'Barranquilla'),
(11, 'Jorge', 'Andrés', 'Sánchez', 'Castillo', '1992-12-30', 'Cartagena'),
(12, 'Diego', 'Armando', 'Ramírez', 'Paredes', '2001-06-14', 'Bogotá'),
(13, 'Camila', 'Andrea', 'López', 'Morales', '2002-11-03', 'Medellín'),
(14, 'Andrés', 'Felipe', 'Castro', 'Peña', '2005-04-20', 'Cali'),
(15, 'Daniela', 'Sofía', 'Gutiérrez', 'Orozco', '1999-09-08', 'Barranquilla'),
(16, 'Sebastián', 'David', 'Vargas', 'Torres', '1988-01-15', 'Cartagena'),
(17, 'Luar', 'La L', 'Maradona', 'Pele', '2024-11-09', 'Buenos aires'),
(18, 'Luar', 'Arcangel', '3 letras', 'La maravilla', '2024-11-08', 'Bogota'),
(19, 'Sandra', 'Maria', 'Idarraga', 'Lopez', '2024-11-07', 'Armenia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientealergia`
--

CREATE TABLE `clientealergia` (
  `id_ClienteAlergia` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de la relación entre clientes y alergias',
  `id_Cliente` int(11) NOT NULL COMMENT 'Relación con la tabla cliente',
  `id_Alergia` int(11) NOT NULL COMMENT 'Relación con la tabla alergia'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientealergia`
--

INSERT INTO `clientealergia` (`id_ClienteAlergia`, `id_Cliente`, `id_Alergia`) VALUES
(36, 1, 9),
(2, 2, 1),
(3, 3, 1),
(37, 4, 10),
(21, 6, 3),
(22, 7, 5),
(23, 8, 2),
(24, 9, 7),
(25, 10, 9),
(26, 11, 6),
(27, 12, 1),
(28, 13, 4),
(29, 14, 8),
(30, 15, 11),
(31, 16, 10),
(38, 19, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clienteenfermedad`
--

CREATE TABLE `clienteenfermedad` (
  `id_ClienteEnfermedad` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de la relación entre clientes y enfermedades',
  `id_Cliente` int(11) NOT NULL COMMENT 'Relación con la tabla cliente',
  `id_Enfermedad` int(11) NOT NULL COMMENT 'Relación con la tabla enfermedad'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clienteenfermedad`
--

INSERT INTO `clienteenfermedad` (`id_ClienteEnfermedad`, `id_Cliente`, `id_Enfermedad`) VALUES
(63, 1, 11),
(2, 2, 1),
(15, 3, 7),
(64, 4, 10),
(43, 6, 7),
(44, 7, 7),
(45, 8, 7),
(46, 9, 7),
(47, 10, 7),
(48, 11, 7),
(49, 12, 3),
(50, 13, 4),
(51, 14, 5),
(52, 15, 6),
(53, 16, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_Empleado` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de los empleados',
  `identificacion` varchar(10) NOT NULL COMMENT 'Identificación del empleado',
  `nombre01` varchar(50) NOT NULL COMMENT 'Primer nombre del empleado',
  `nombre02` varchar(50) DEFAULT NULL COMMENT 'Segundo nombre del empleado',
  `apellido01` varchar(50) NOT NULL COMMENT 'Primer nombre del empleado',
  `apellido02` varchar(50) DEFAULT NULL COMMENT 'Segundo nombre del empleado',
  `salario` float NOT NULL COMMENT 'Salario del empleado',
  `correo_electronico` varchar(100) DEFAULT NULL COMMENT 'Correo electrónico del empleado',
  `id_Cargo` int(11) NOT NULL COMMENT 'Relación con la tabla de cargos',
  `residencia` varchar(50) NOT NULL COMMENT 'Residencia del empleado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_Empleado`, `identificacion`, `nombre01`, `nombre02`, `apellido01`, `apellido02`, `salario`, `correo_electronico`, `id_Cargo`, `residencia`) VALUES
(1, '12345678', 'Maria', 'Elena', 'Gonzalez', 'Perez', 55000, 'maria.gonzalez@email.com', 1, 'Bogotá'),
(2, '', 'Fabio', 'Ernesto', 'Cortez', '', 120000000, 'santi@mail.com', 4, 'calle 2'),
(3, '', 'Diego', 'Armando', 'Maradona', 'Diez', 500000, 'dieg@gmail.com', 3, 'ANTIOQUIA'),
(4, '45678901', 'Manuel', 'Antonio', 'Martinez', 'Hernandez', 75000, 'manuel.martinez@email.com', 4, 'Barranquilla'),
(5, '56789012', 'Margarita', 'Rosa', 'Perez', 'Gutierrez', 55000, 'margarita.perez@email.com', 1, 'Cartagena'),
(6, '67890123', 'Martin', 'Javier', 'Fernandez', 'Lozano', 80000, 'martin.fernandez@email.com', 2, 'Medellín'),
(7, '78901234', 'María', 'José', 'Jimenez', 'Sanchez', 85000, 'maria.jimenez@email.com', 3, 'Pereira'),
(8, '23456789', 'Marta', 'Lucia', 'Rodriguez', 'Jimenez', 60000, 'marta.rodriguez@email.com', 2, 'Medellín'),
(9, '34567890', 'Miguel', 'Angel', 'Lopez', 'Molina', 70000, 'miguel.lopez@email.com', 3, 'Cali');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enfermedad`
--

CREATE TABLE `enfermedad` (
  `id_Enfermedad` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de enfermedades',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre de la enfermedad'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `enfermedad`
--

INSERT INTO `enfermedad` (`id_Enfermedad`, `nombre`) VALUES
(22, ''),
(10, 'Alopecia'),
(23, 'Array'),
(5, 'Artritis'),
(4, 'Asma'),
(6, 'Cáncer'),
(7, 'Diabetes'),
(12, 'Epilepsia'),
(8, 'Gripe'),
(14, 'Hepatitis'),
(3, 'Hipertensión'),
(11, 'Insuficiencia renal'),
(1, 'ninguna'),
(19, 'Prueba enfermedad'),
(9, 'Resfriado común'),
(2, 'Tiroidess'),
(13, 'Tuberculosis');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacompra`
--

CREATE TABLE `facturacompra` (
  `id_FacturaCompra` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de la factura',
  `fecha_compra` datetime NOT NULL COMMENT 'Fecha de compra de la factura',
  `total` decimal(10,2) NOT NULL COMMENT 'Valor total de la factura de compra',
  `id_FacturaCompra_Estado` int(11) NOT NULL COMMENT 'Relación con la tabla de estados de factura de compra',
  `id_Proveedor` int(11) NOT NULL COMMENT 'Relación con la tabla proveedores'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturacompra`
--

INSERT INTO `facturacompra` (`id_FacturaCompra`, `fecha_compra`, `total`, `id_FacturaCompra_Estado`, `id_Proveedor`) VALUES
(1, '2024-10-10 00:00:00', 250000.00, 1, 1),
(12, '2024-11-01 00:00:00', 1200.50, 1, 1),
(13, '2024-11-05 00:00:00', 2500.75, 2, 2),
(14, '2024-11-10 00:00:00', 1500.00, 1, 3),
(15, '2024-11-15 00:00:00', 800.25, 2, 4),
(16, '2024-11-18 00:00:00', 4500.80, 1, 5),
(17, '2024-11-20 00:00:00', 3000.40, 1, 6),
(18, '2024-11-22 00:00:00', 2700.60, 2, 7),
(19, '2024-11-25 00:00:00', 3200.90, 1, 8),
(20, '2024-11-28 00:00:00', 2200.30, 2, 9),
(21, '2024-11-30 00:00:00', 1100.00, 1, 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacompra_detalle`
--

CREATE TABLE `facturacompra_detalle` (
  `id_FacturaCompra_Detalle` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta',
  `id_FacturaCompra` int(11) NOT NULL COMMENT 'Relación con la tabla factura de venta',
  `id_Producto` int(11) NOT NULL COMMENT 'Relación con la tabla producto',
  `cantidad` int(11) NOT NULL COMMENT 'Cantidad de productos',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio unitario del producto o servicio',
  `sub_total` decimal(10,2) NOT NULL COMMENT 'Precio total del detalle'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturacompra_detalle`
--

INSERT INTO `facturacompra_detalle` (`id_FacturaCompra_Detalle`, `id_FacturaCompra`, `id_Producto`, `cantidad`, `precio_unitario`, `sub_total`) VALUES
(1, 1, 1, 10, 15000.00, 150000.00),
(2, 1, 2, 10, 10000.00, 100000.00),
(45, 1, 1, 3, 12000.00, 36000.00),
(46, 1, 2, 2, 25000.00, 50000.00),
(47, 1, 3, 4, 15000.00, 60000.00),
(48, 12, 4, 5, 10000.00, 50000.00),
(49, 12, 5, 3, 30000.00, 90000.00),
(50, 13, 6, 2, 5000.00, 10000.00),
(51, 14, 1, 1, 12000.00, 12000.00),
(52, 14, 8, 7, 7000.00, 49000.00),
(53, 15, 2, 3, 25000.00, 75000.00),
(54, 15, 3, 2, 15000.00, 30000.00),
(55, 16, 4, 4, 10000.00, 40000.00),
(56, 16, 5, 5, 30000.00, 150000.00),
(57, 17, 6, 1, 5000.00, 5000.00),
(58, 18, 1, 6, 12000.00, 72000.00),
(59, 18, 2, 5, 25000.00, 125000.00),
(60, 19, 3, 8, 15000.00, 120000.00),
(61, 19, 4, 3, 10000.00, 30000.00),
(62, 20, 5, 2, 30000.00, 60000.00),
(63, 20, 6, 4, 5000.00, 20000.00),
(64, 21, 8, 3, 7000.00, 21000.00),
(65, 21, 1, 4, 12000.00, 48000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturacompra_estado`
--

CREATE TABLE `facturacompra_estado` (
  `id_FacturaCompra_Estado` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del estado factura de compra',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del estado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturacompra_estado`
--

INSERT INTO `facturacompra_estado` (`id_FacturaCompra_Estado`, `nombre`) VALUES
(1, 'Paga'),
(2, 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturaventa`
--

CREATE TABLE `facturaventa` (
  `id_FacturaVenta` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de la factura',
  `fecha_venta` datetime NOT NULL COMMENT 'Fecha de venta de la factura',
  `total` decimal(10,2) NOT NULL COMMENT 'Valor total de la factura de venta',
  `id_FacturaVenta_Estado` int(11) NOT NULL COMMENT 'Relación con la tabla de estados de factura de venta',
  `id_Cliente` int(11) NOT NULL COMMENT 'Relación con la tabla cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturaventa`
--

INSERT INTO `facturaventa` (`id_FacturaVenta`, `fecha_venta`, `total`, `id_FacturaVenta_Estado`, `id_Cliente`) VALUES
(1, '2024-11-15 23:21:06', 60000.00, 1, 1),
(82, '2024-11-21 18:54:56', 45000.50, 1, 1),
(83, '2024-11-21 18:54:56', 120000.00, 2, 2),
(84, '2024-11-21 18:54:56', 32000.00, 1, 3),
(85, '2024-11-21 18:54:56', 89000.75, 2, 4),
(86, '2024-11-21 18:54:56', 150000.00, 1, 5),
(87, '2024-11-21 18:54:56', 78000.00, 2, 6),
(88, '2024-11-21 18:54:56', 20000.00, 1, 7),
(89, '2024-11-21 18:54:56', 500000.00, 2, 8),
(90, '2024-11-21 18:54:56', 98000.25, 1, 9),
(91, '2024-11-21 18:54:56', 43000.00, 2, 10),
(92, '2024-11-21 18:54:56', 125000.50, 1, 1),
(93, '2024-11-21 18:54:56', 55000.00, 2, 2),
(94, '2024-11-21 18:54:56', 67000.75, 1, 3),
(95, '2024-11-21 18:54:56', 92000.00, 2, 4),
(96, '2024-11-21 18:54:56', 31000.00, 1, 5),
(97, '2024-11-21 18:54:56', 85000.25, 2, 6),
(98, '2024-11-21 18:54:56', 46000.00, 1, 7),
(99, '2024-11-21 18:54:56', 57000.50, 2, 8),
(100, '2024-11-21 18:54:56', 74000.00, 1, 9),
(101, '2024-11-21 18:54:56', 123000.75, 2, 10);

--
-- Disparadores `facturaventa`
--
DELIMITER $$
CREATE TRIGGER `BI_FacturaVenta` BEFORE INSERT ON `facturaventa` FOR EACH ROW BEGIN
	SET NEW.fecha_venta = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturaventa_detalle`
--

CREATE TABLE `facturaventa_detalle` (
  `id_FacturaVenta_Detalle` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta',
  `id_FacturaVenta` int(11) NOT NULL COMMENT 'Relación con la tabla factura de venta',
  `id_Producto` int(11) NOT NULL COMMENT 'Relación con la tabla producto',
  `cantidad` int(11) NOT NULL COMMENT 'Cantidad de productos',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio unitario del producto o servicio',
  `sub_total` decimal(10,2) NOT NULL COMMENT 'Precio total del detalle'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturaventa_detalle`
--

INSERT INTO `facturaventa_detalle` (`id_FacturaVenta_Detalle`, `id_FacturaVenta`, `id_Producto`, `cantidad`, `precio_unitario`, `sub_total`) VALUES
(1, 1, 6, 1, 60000.00, 60000.00),
(44, 82, 1, 2, 15000.25, 30000.50),
(45, 82, 2, 1, 15000.00, 15000.00),
(46, 83, 3, 4, 30000.00, 120000.00),
(47, 84, 4, 1, 32000.00, 32000.00),
(48, 85, 2, 3, 29666.91, 89000.75),
(49, 86, 5, 2, 75000.00, 150000.00),
(50, 87, 1, 3, 26000.00, 78000.00),
(51, 88, 6, 4, 5000.00, 20000.00),
(52, 89, 3, 10, 50000.00, 500000.00),
(53, 90, 8, 1, 43000.00, 43000.00),
(54, 91, 2, 5, 25000.10, 125000.50),
(55, 92, 3, 2, 27500.00, 55000.00),
(56, 93, 4, 3, 22333.58, 67000.75),
(57, 94, 5, 5, 18400.00, 92000.00),
(58, 95, 6, 2, 15500.00, 31000.00),
(59, 96, 8, 5, 17000.05, 85000.25),
(60, 97, 8, 2, 23000.00, 46000.00),
(61, 98, 1, 3, 19000.17, 57000.50),
(62, 99, 2, 4, 18500.00, 74000.00),
(63, 100, 3, 5, 24600.15, 123000.75);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturaventa_estado`
--

CREATE TABLE `facturaventa_estado` (
  `id_FacturaVenta_Estado` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del estado factura de venta',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del estado'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturaventa_estado`
--

INSERT INTO `facturaventa_estado` (`id_FacturaVenta_Estado`, `nombre`) VALUES
(1, 'Paga'),
(2, 'Pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inventario`
--

CREATE TABLE `inventario` (
  `id_Inventario` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del inventario de producto',
  `id_Producto` int(11) NOT NULL COMMENT 'Relación con la tabla producto',
  `cantidad` int(11) NOT NULL COMMENT 'Cantidad del produco',
  `fecha_movimiento` datetime NOT NULL COMMENT 'Fecha de realización del movimiento',
  `id_Movimiento` int(11) NOT NULL COMMENT 'Relación con la tabla Movimiento',
  `id_FacturaCompra_Detalle` int(11) NOT NULL COMMENT 'Relación con el detalle de la factura de compra'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inventario`
--

INSERT INTO `inventario` (`id_Inventario`, `id_Producto`, `cantidad`, `fecha_movimiento`, `id_Movimiento`, `id_FacturaCompra_Detalle`) VALUES
(1, 1, 10, '2024-11-15 23:17:47', 1, 1),
(2, 2, 10, '2024-11-15 23:17:47', 1, 2);

--
-- Disparadores `inventario`
--
DELIMITER $$
CREATE TRIGGER `BI_INVENTARIO` BEFORE INSERT ON `inventario` FOR EACH ROW BEGIN
	SET NEW.fecha_movimiento = NOW(); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento`
--

CREATE TABLE `movimiento` (
  `id_Movimiento` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de los tipos de movimiento',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del movimiento'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `movimiento`
--

INSERT INTO `movimiento` (`id_Movimiento`, `nombre`) VALUES
(1, 'Entrada'),
(2, 'Salida');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_Pago` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de pago',
  `monto` decimal(10,2) NOT NULL COMMENT 'Monto del pago realizado a la factura',
  `fecha` date NOT NULL COMMENT 'Fecha de pago de la factura',
  `id_FacturaVenta` int(11) NOT NULL COMMENT 'Relación la tabla de factura de venta',
  `id_Cliente` int(11) NOT NULL COMMENT 'Relación de la tabla de cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`id_Pago`, `monto`, `fecha`, `id_FacturaVenta`, `id_Cliente`) VALUES
(1, 60000.00, '2024-11-15', 1, 1);

--
-- Disparadores `pago`
--
DELIMITER $$
CREATE TRIGGER `BI_Pago` BEFORE INSERT ON `pago` FOR EACH ROW BEGIN 
	SET NEW.fecha = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_Pedido` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del pedido',
  `id_Proveedor` int(11) NOT NULL COMMENT 'Relación con la tabla proveedor',
  `fecha_pedido` datetime NOT NULL COMMENT 'Fecha del pedido',
  `total` decimal(10,2) NOT NULL COMMENT 'Total del pedidio',
  `id_Pedido_Estado` int(11) NOT NULL COMMENT 'Relación con los estado de pedido'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_Pedido`, `id_Proveedor`, `fecha_pedido`, `total`, `id_Pedido_Estado`) VALUES
(1, 1, '2024-10-10 00:00:00', 250.00, 4),
(2, 1, '2024-11-21 16:37:50', 1500.75, 1),
(3, 2, '2024-11-21 16:37:50', 2000.50, 2),
(4, 3, '2024-11-21 16:37:50', 1200.25, 3),
(5, 4, '2024-11-21 16:37:50', 2800.80, 4),
(6, 5, '2024-11-21 16:37:50', 950.40, 1),
(7, 6, '2024-11-21 16:37:50', 2200.60, 5),
(8, 7, '2024-11-21 16:37:50', 1700.35, 2),
(9, 8, '2024-11-21 16:37:50', 3300.90, 3),
(10, 9, '2024-11-21 16:37:50', 2500.15, 4),
(11, 10, '2024-11-21 16:37:50', 3000.55, 1);

--
-- Disparadores `pedido`
--
DELIMITER $$
CREATE TRIGGER `BI_Pedido` BEFORE INSERT ON `pedido` FOR EACH ROW BEGIN
	SET NEW.fecha_Pedido = NOW();
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_detalle`
--

CREATE TABLE `pedido_detalle` (
  `id_Pedido_Detalle` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta',
  `id_Pedido` int(11) NOT NULL COMMENT 'Relación con la tabla de pedidos',
  `id_Producto` int(11) NOT NULL COMMENT 'Relación con la tabla producto',
  `cantidad` int(11) NOT NULL COMMENT 'Cantidad de productos',
  `precio_unitario` decimal(10,2) NOT NULL COMMENT 'Precio unitario del producto o servicio',
  `sub_total` decimal(10,2) NOT NULL COMMENT 'Precio total del detalle'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido_detalle`
--

INSERT INTO `pedido_detalle` (`id_Pedido_Detalle`, `id_Pedido`, `id_Producto`, `cantidad`, `precio_unitario`, `sub_total`) VALUES
(1, 1, 1, 10, 15000.00, 150000.00),
(2, 1, 2, 10, 10000.00, 100000.00),
(108, 1, 1, 5, 12000.00, 60000.00),
(109, 1, 2, 3, 25000.00, 75000.00),
(110, 2, 3, 2, 15000.00, 30000.00),
(111, 2, 4, 4, 10000.00, 40000.00),
(112, 3, 5, 1, 30000.00, 30000.00),
(113, 3, 6, 5, 5000.00, 25000.00),
(114, 4, 1, 2, 12000.00, 24000.00),
(115, 4, 8, 3, 7000.00, 21000.00),
(116, 5, 2, 6, 25000.00, 150000.00),
(117, 5, 3, 3, 15000.00, 45000.00),
(118, 6, 4, 7, 10000.00, 70000.00),
(119, 6, 5, 4, 30000.00, 120000.00),
(120, 7, 6, 2, 5000.00, 10000.00),
(121, 7, 1, 3, 12000.00, 36000.00),
(122, 8, 2, 4, 25000.00, 100000.00),
(123, 8, 3, 2, 15000.00, 30000.00),
(124, 9, 4, 5, 10000.00, 50000.00),
(125, 9, 6, 3, 5000.00, 15000.00),
(126, 10, 5, 2, 30000.00, 60000.00),
(127, 10, 8, 1, 7000.00, 7000.00),
(128, 11, 1, 6, 12000.00, 72000.00);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido_estado`
--

CREATE TABLE `pedido_estado` (
  `id_Pedido_Detalle` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable del detalle del pedido',
  `nombre` varchar(20) NOT NULL COMMENT 'Relación con el estado del pedido'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido_estado`
--

INSERT INTO `pedido_estado` (`id_Pedido_Detalle`, `nombre`) VALUES
(1, 'Pendiente'),
(2, 'Aprobado'),
(3, 'Recibido'),
(4, 'Facturado'),
(5, 'Cancelado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_Producto` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de producto',
  `descripcion` varchar(255) NOT NULL COMMENT 'Descripción del producto',
  `precio` decimal(10,2) NOT NULL COMMENT 'Precio del producto',
  `nombre` varchar(50) NOT NULL COMMENT 'Nombre del producto o servicio',
  `id_Producto_Tipo` int(11) NOT NULL COMMENT 'Relación con la tabla tipos de producto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_Producto`, `descripcion`, `precio`, `nombre`, `id_Producto_Tipo`) VALUES
(1, 'Pond\'s Crema Facial C Original 95g', 18507.00, 'POND\'S 95g', 1),
(2, 'Shampoo Amatic Con Keratina 400 mL', 12000.00, 'BERHLAN', 1),
(3, 'Un masaje que ayuda a reducir el estrés y relajar los músculos.', 20000.00, 'Masaje Relajante', 2),
(4, 'Limpieza profunda de la piel con productos especializados.', 30000.00, 'Tratamiento Facial', 2),
(5, 'Eliminación permanente del vello mediante láser.', 35000.00, 'Depilación Láser', 2),
(6, 'Cuidado estético de las uñas de manos y pies.', 60000.00, 'Manicura y Pedicura', 2),
(8, 'Es una cirugía enfocada en reducir signos de envejecimiento por medio del estiramiento de la piel del rostro. En el procedimiento, el cirujano hace cortes por encima de la frente (en el cuero cabelludo) y procede a estirar la piel, logrando un efecto reju', 17100000.00, 'Lifting', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto_tipo`
--

CREATE TABLE `producto_tipo` (
  `id_Producto_Tipo` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de los tipo de producto',
  `tipo` varchar(100) NOT NULL COMMENT 'Tipo de producto'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto_tipo`
--

INSERT INTO `producto_tipo` (`id_Producto_Tipo`, `tipo`) VALUES
(1, 'Producto'),
(2, 'Servicio');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_Proveedor` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de proveedor',
  `nombre` varchar(100) NOT NULL COMMENT 'Nombre del proveedor',
  `identificacion` varchar(10) NOT NULL COMMENT 'Número de identificación del proveedor'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_Proveedor`, `nombre`, `identificacion`) VALUES
(1, 'Mercado Libre', '900880401'),
(2, 'Beautystock', '123456789'),
(3, 'Alfaparf Milano', '987654321'),
(4, 'KRYOLAN', '1122334455'),
(5, 'Estética Profesional', '6677889900'),
(6, 'Beautech', '9988776655'),
(7, 'Sothys', '5566778899'),
(8, 'Germaine de Capuccini', '4433221100'),
(9, 'Biologique Recherche', '2233445566'),
(10, 'Oster Professional', '1010101010'),
(11, 'María Dúo', '2020202020');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono`
--

CREATE TABLE `telefono` (
  `id_Telefono` int(11) NOT NULL COMMENT 'Llave primaria autoincrementable de la tabla telefonos',
  `numero` varchar(15) NOT NULL COMMENT 'Número telefonico de la persona',
  `id_Empleado` int(11) DEFAULT NULL COMMENT 'Relación con la tabla empleado',
  `id_Cliente` int(11) DEFAULT NULL COMMENT 'Relación con la tabla cliente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `telefono`
--

INSERT INTO `telefono` (`id_Telefono`, `numero`, `id_Empleado`, `id_Cliente`) VALUES
(17, '3107281790', NULL, NULL),
(18, '3107281790', NULL, NULL),
(19, '3107281790', NULL, NULL),
(30, '315896542', NULL, 2),
(47, '1234567890', NULL, 5),
(50, '45743356', 2, NULL),
(58, '326986589', NULL, 3),
(71, '3001234567', NULL, 6),
(72, '3102345678', NULL, 7),
(73, '3203456789', NULL, 8),
(74, '3304567890', NULL, 9),
(75, '3405678901', NULL, 10),
(76, '3506789012', NULL, 11),
(77, '3607890123', NULL, 12),
(78, '3708901234', NULL, 13),
(79, '3809012345', NULL, 14),
(80, '3900123456', NULL, 15),
(81, '4001234567', NULL, 16),
(85, '3698521470', NULL, 17),
(86, '5236987712', NULL, 17),
(89, '325697413', NULL, 1),
(90, '36597451', 3, NULL),
(91, '12342', NULL, 4),
(92, '9696999', NULL, 4);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_Administrador`);

--
-- Indices de la tabla `alergia`
--
ALTER TABLE `alergia`
  ADD PRIMARY KEY (`id_Alergia`),
  ADD UNIQUE KEY `Alergia_UNIQUE` (`nombre`);

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`id_Calificacion`),
  ADD KEY `Calificacion_Cita_FK` (`id_Cita`);

--
-- Indices de la tabla `cargo`
--
ALTER TABLE `cargo`
  ADD PRIMARY KEY (`id_Cargo`),
  ADD UNIQUE KEY `Cargo_UNIQUE` (`nombre`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`id_Cita`),
  ADD KEY `Cita_Empleado_FK` (`id_Empleado`),
  ADD KEY `Cita_Cliente_FK` (`id_Cliente`),
  ADD KEY `Cita_Producto_FK` (`id_Producto`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_Cliente`);

--
-- Indices de la tabla `clientealergia`
--
ALTER TABLE `clientealergia`
  ADD PRIMARY KEY (`id_ClienteAlergia`),
  ADD UNIQUE KEY `ClienteAlergia_UNIQUE` (`id_Cliente`,`id_Alergia`),
  ADD KEY `ClienteAlergia_Alergia_FK` (`id_Alergia`);

--
-- Indices de la tabla `clienteenfermedad`
--
ALTER TABLE `clienteenfermedad`
  ADD PRIMARY KEY (`id_ClienteEnfermedad`),
  ADD UNIQUE KEY `ClienteEnfermedad_UNIQUE` (`id_Cliente`,`id_Enfermedad`),
  ADD KEY `ClienteEnfermedad_Enfermedad_FK` (`id_Enfermedad`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_Empleado`),
  ADD KEY `Empleado_Cargo_FK` (`id_Cargo`);

--
-- Indices de la tabla `enfermedad`
--
ALTER TABLE `enfermedad`
  ADD PRIMARY KEY (`id_Enfermedad`),
  ADD UNIQUE KEY `Enfermeda_UNIQUE` (`nombre`);

--
-- Indices de la tabla `facturacompra`
--
ALTER TABLE `facturacompra`
  ADD PRIMARY KEY (`id_FacturaCompra`),
  ADD KEY `FacturaCompra_Proveedor_FK` (`id_Proveedor`),
  ADD KEY `FacturaCompra_FacturaCompra_Estado_FK` (`id_FacturaCompra_Estado`);

--
-- Indices de la tabla `facturacompra_detalle`
--
ALTER TABLE `facturacompra_detalle`
  ADD PRIMARY KEY (`id_FacturaCompra_Detalle`),
  ADD KEY `FacturaVenta_Detalle_FacturaVenta_FK` (`id_FacturaCompra`) USING BTREE,
  ADD KEY `FacturaVenta_Detalle_Producto_FK` (`id_Producto`) USING BTREE;

--
-- Indices de la tabla `facturacompra_estado`
--
ALTER TABLE `facturacompra_estado`
  ADD PRIMARY KEY (`id_FacturaCompra_Estado`),
  ADD UNIQUE KEY `FacturaVenta_Estado_UNIQUE` (`nombre`);

--
-- Indices de la tabla `facturaventa`
--
ALTER TABLE `facturaventa`
  ADD PRIMARY KEY (`id_FacturaVenta`),
  ADD KEY `FacturaVenta_Cliente_FK` (`id_Cliente`),
  ADD KEY `facturaventa_facturaventa_estado_FK` (`id_FacturaVenta_Estado`);

--
-- Indices de la tabla `facturaventa_detalle`
--
ALTER TABLE `facturaventa_detalle`
  ADD PRIMARY KEY (`id_FacturaVenta_Detalle`),
  ADD KEY `FacturaVenta_Detalle_FacturaVenta_FK` (`id_FacturaVenta`),
  ADD KEY `FacturaVenta_Detalle_Producto_FK` (`id_Producto`);

--
-- Indices de la tabla `facturaventa_estado`
--
ALTER TABLE `facturaventa_estado`
  ADD PRIMARY KEY (`id_FacturaVenta_Estado`),
  ADD UNIQUE KEY `FacturaVenta_Estado_UNIQUE` (`nombre`);

--
-- Indices de la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD PRIMARY KEY (`id_Inventario`),
  ADD KEY `Inventario_Producto_FK` (`id_Producto`),
  ADD KEY `Inventario_Movimiento_FK` (`id_Movimiento`),
  ADD KEY `Inventario_FacturaCompra_Detalle_FK` (`id_FacturaCompra_Detalle`);

--
-- Indices de la tabla `movimiento`
--
ALTER TABLE `movimiento`
  ADD PRIMARY KEY (`id_Movimiento`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_Pago`),
  ADD KEY `Pago_Cliente_FK` (`id_Cliente`),
  ADD KEY `Pago_FacturaVenta_FK` (`id_FacturaVenta`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_Pedido`),
  ADD KEY `Pedido_Proveedor_FK` (`id_Proveedor`),
  ADD KEY `Pedido_Pedido_Estado_FK` (`id_Pedido_Estado`);

--
-- Indices de la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  ADD PRIMARY KEY (`id_Pedido_Detalle`),
  ADD KEY `FacturaVenta_Detalle_FacturaVenta_FK` (`id_Pedido`) USING BTREE,
  ADD KEY `FacturaVenta_Detalle_Producto_FK` (`id_Producto`) USING BTREE;

--
-- Indices de la tabla `pedido_estado`
--
ALTER TABLE `pedido_estado`
  ADD PRIMARY KEY (`id_Pedido_Detalle`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_Producto`),
  ADD KEY `Producto_Producto_Tipo_FK` (`id_Producto_Tipo`);

--
-- Indices de la tabla `producto_tipo`
--
ALTER TABLE `producto_tipo`
  ADD PRIMARY KEY (`id_Producto_Tipo`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_Proveedor`),
  ADD UNIQUE KEY `Proveedor_UNIQUE` (`identificacion`);

--
-- Indices de la tabla `telefono`
--
ALTER TABLE `telefono`
  ADD PRIMARY KEY (`id_Telefono`),
  ADD KEY `Telefono_Empleado_FK` (`id_Empleado`),
  ADD KEY `Telefono_Cliente_FK` (`id_Cliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_Administrador` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de administradores', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `alergia`
--
ALTER TABLE `alergia`
  MODIFY `id_Alergia` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la alergia', AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  MODIFY `id_Calificacion` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de calificaciones de cita', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cargo`
--
ALTER TABLE `cargo`
  MODIFY `id_Cargo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del cargo', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `id_Cita` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la cita', AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_Cliente` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de clientes', AUTO_INCREMENT=39844;

--
-- AUTO_INCREMENT de la tabla `clientealergia`
--
ALTER TABLE `clientealergia`
  MODIFY `id_ClienteAlergia` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la relación entre clientes y alergias', AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT de la tabla `clienteenfermedad`
--
ALTER TABLE `clienteenfermedad`
  MODIFY `id_ClienteEnfermedad` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la relación entre clientes y enfermedades', AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_Empleado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de los empleados', AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `enfermedad`
--
ALTER TABLE `enfermedad`
  MODIFY `id_Enfermedad` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de enfermedades', AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `facturacompra`
--
ALTER TABLE `facturacompra`
  MODIFY `id_FacturaCompra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la factura', AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `facturacompra_detalle`
--
ALTER TABLE `facturacompra_detalle`
  MODIFY `id_FacturaCompra_Detalle` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta', AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de la tabla `facturacompra_estado`
--
ALTER TABLE `facturacompra_estado`
  MODIFY `id_FacturaCompra_Estado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del estado factura de compra', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `facturaventa`
--
ALTER TABLE `facturaventa`
  MODIFY `id_FacturaVenta` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la factura', AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT de la tabla `facturaventa_detalle`
--
ALTER TABLE `facturaventa_detalle`
  MODIFY `id_FacturaVenta_Detalle` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta', AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de la tabla `facturaventa_estado`
--
ALTER TABLE `facturaventa_estado`
  MODIFY `id_FacturaVenta_Estado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del estado factura de venta', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `inventario`
--
ALTER TABLE `inventario`
  MODIFY `id_Inventario` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del inventario de producto', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `movimiento`
--
ALTER TABLE `movimiento`
  MODIFY `id_Movimiento` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de los tipos de movimiento', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_Pago` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de pago', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_Pedido` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del pedido', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  MODIFY `id_Pedido_Detalle` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta', AUTO_INCREMENT=129;

--
-- AUTO_INCREMENT de la tabla `pedido_estado`
--
ALTER TABLE `pedido_estado`
  MODIFY `id_Pedido_Detalle` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del detalle del pedido', AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_Producto` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de producto', AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `producto_tipo`
--
ALTER TABLE `producto_tipo`
  MODIFY `id_Producto_Tipo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de los tipo de producto', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_Proveedor` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de proveedor', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `telefono`
--
ALTER TABLE `telefono`
  MODIFY `id_Telefono` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la tabla telefonos', AUTO_INCREMENT=98;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `Cita_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `cliente` (`id_Cliente`),
  ADD CONSTRAINT `Cita_Producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `producto` (`id_Producto`);

--
-- Filtros para la tabla `clientealergia`
--
ALTER TABLE `clientealergia`
  ADD CONSTRAINT `ClienteAlergia_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `cliente` (`id_Cliente`);

--
-- Filtros para la tabla `clienteenfermedad`
--
ALTER TABLE `clienteenfermedad`
  ADD CONSTRAINT `ClienteEnfermedad_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `cliente` (`id_Cliente`),
  ADD CONSTRAINT `ClienteEnfermedad_Enfermedad_FK` FOREIGN KEY (`id_Enfermedad`) REFERENCES `enfermedad` (`id_Enfermedad`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `Empleado_Cargo_FK` FOREIGN KEY (`id_Cargo`) REFERENCES `cargo` (`id_Cargo`);

--
-- Filtros para la tabla `facturacompra`
--
ALTER TABLE `facturacompra`
  ADD CONSTRAINT `FacturaCompra_Proveedor_FK` FOREIGN KEY (`id_Proveedor`) REFERENCES `proveedor` (`id_Proveedor`),
  ADD CONSTRAINT `facturacompra_facturacompra_estado_FK` FOREIGN KEY (`id_FacturaCompra_Estado`) REFERENCES `facturacompra_estado` (`id_FacturaCompra_Estado`);

--
-- Filtros para la tabla `facturacompra_detalle`
--
ALTER TABLE `facturacompra_detalle`
  ADD CONSTRAINT `FacturaCompra_Detalle_FacturaCompra_FK` FOREIGN KEY (`id_FacturaCompra`) REFERENCES `facturacompra` (`id_FacturaCompra`),
  ADD CONSTRAINT `FacturaCompra_Detalle_Producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `producto` (`id_Producto`);

--
-- Filtros para la tabla `facturaventa`
--
ALTER TABLE `facturaventa`
  ADD CONSTRAINT `FacturaVenta_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `cliente` (`id_Cliente`),
  ADD CONSTRAINT `facturaventa_facturaventa_estado_FK` FOREIGN KEY (`id_FacturaVenta_Estado`) REFERENCES `facturaventa_estado` (`id_FacturaVenta_Estado`);

--
-- Filtros para la tabla `facturaventa_detalle`
--
ALTER TABLE `facturaventa_detalle`
  ADD CONSTRAINT `FacturaVenta_Detalle_FacturaVenta_FK` FOREIGN KEY (`id_FacturaVenta`) REFERENCES `facturaventa` (`id_FacturaVenta`),
  ADD CONSTRAINT `FacturaVenta_Detalle_Producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `producto` (`id_Producto`);

--
-- Filtros para la tabla `inventario`
--
ALTER TABLE `inventario`
  ADD CONSTRAINT `Inventario_FacturaCompra_Detalle_FK` FOREIGN KEY (`id_FacturaCompra_Detalle`) REFERENCES `facturacompra_detalle` (`id_FacturaCompra_Detalle`),
  ADD CONSTRAINT `Inventario_Movimiento_FK` FOREIGN KEY (`id_Movimiento`) REFERENCES `movimiento` (`id_Movimiento`),
  ADD CONSTRAINT `Inventario_Producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `producto` (`id_Producto`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `Pago_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `cliente` (`id_Cliente`),
  ADD CONSTRAINT `Pago_FacturaVenta_FK` FOREIGN KEY (`id_FacturaVenta`) REFERENCES `facturaventa` (`id_FacturaVenta`);

--
-- Filtros para la tabla `pedido_detalle`
--
ALTER TABLE `pedido_detalle`
  ADD CONSTRAINT `pedido_detalle_pedido_FK` FOREIGN KEY (`id_Pedido`) REFERENCES `pedido` (`id_Pedido`),
  ADD CONSTRAINT `pedido_detalle_producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `producto` (`id_Producto`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `Producto_Producto_Tipo_FK` FOREIGN KEY (`id_Producto_Tipo`) REFERENCES `producto_tipo` (`id_Producto_Tipo`);

--
-- Filtros para la tabla `telefono`
--
ALTER TABLE `telefono`
  ADD CONSTRAINT `Telefono_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `cliente` (`id_Cliente`),
  ADD CONSTRAINT `Telefono_Empleado_FK` FOREIGN KEY (`id_Empleado`) REFERENCES `empleado` (`id_Empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
