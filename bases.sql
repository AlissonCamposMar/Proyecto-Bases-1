-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-11-2024 a las 23:57:10
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
(5, 'exe'),
(17, 'Indefinida'),
(13, 'Mucosidad'),
(1, 'No reconocida'),
(2, 'Penisciliina'),
(9, 'Piquiña'),
(6, 'Rinitis'),
(8, 'Sinositis'),
(11, 'Sol'),
(12, 'Sola');

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
  `fecha` datetime NOT NULL COMMENT 'Fecha de la programación de la cita',
  `duracion` time NOT NULL COMMENT 'Duración de la cita',
  `id_Cliente` int(11) NOT NULL COMMENT 'Relación con la tabla de clientes',
  `id_Empleado` int(11) NOT NULL COMMENT 'Relación con la tabla empleados',
  `id_Producto` int(11) NOT NULL COMMENT 'Relación con la tabla de productos'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`id_Cita`, `fecha`, `duracion`, `id_Cliente`, `id_Empleado`, `id_Producto`) VALUES
(1, '2024-11-20 00:00:00', '02:00:00', 1, 1, 6);

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
(1, 'Alisson', 'Camila', 'Campos', 'Puertas', '2001-11-16', 'Calle 14 # 20-31'),
(2, 'Santiago', 'Alberto', 'Trujillo', 'Patiño', '2003-01-29', 'Calle 9 # 20-27'),
(3, 'Esteban', 'Camilo', 'Idarraga', 'Campos', '1999-11-15', 'Calle 2 # 14-06');

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
(1, 1, 1),
(2, 2, 1),
(3, 3, 1);

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
(1, 1, 2),
(2, 2, 1),
(3, 3, 1);

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
(1, '1008444442', 'Juan', 'José', 'Cardona', 'Cortes', 12000000, 'juanj@email.com', 1, 'Calle 5 Mz 3 # 02');

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
(10, 'Alopecia'),
(7, 'Diabetes'),
(1, 'ninguna'),
(2, 'Tiroidess');

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
(1, '2024-10-10 00:00:00', 250000.00, 1, 1);

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
(2, 1, 2, 10, 10000.00, 100000.00);

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
(1, '2024-11-15 23:21:06', 60000.00, 1, 1);

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
(1, 1, 6, 1, 60000.00, 60000.00);

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
(6, 'Cuidado estético de las uñas de manos y pies.', 60000.00, 'Manicura y Pedicura', 2);

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
(1, 'Mercado Libre', '900880401');

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
(31, '326986589', NULL, 3),
(39, '3692581470', 1, NULL),
(42, '98767899', NULL, 1);

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
  ADD KEY `FacturaVenta_Cliente_FK` (`id_Cliente`);

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
  MODIFY `id_Alergia` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la alergia', AUTO_INCREMENT=18;

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
  MODIFY `id_Cita` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la cita', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_Cliente` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de clientes', AUTO_INCREMENT=39844;

--
-- AUTO_INCREMENT de la tabla `clientealergia`
--
ALTER TABLE `clientealergia`
  MODIFY `id_ClienteAlergia` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la relación entre clientes y alergias', AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clienteenfermedad`
--
ALTER TABLE `clienteenfermedad`
  MODIFY `id_ClienteEnfermedad` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la relación entre clientes y enfermedades', AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_Empleado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de los empleados', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `enfermedad`
--
ALTER TABLE `enfermedad`
  MODIFY `id_Enfermedad` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de enfermedades', AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `facturacompra`
--
ALTER TABLE `facturacompra`
  MODIFY `id_FacturaCompra` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la factura', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `facturacompra_detalle`
--
ALTER TABLE `facturacompra_detalle`
  MODIFY `id_FacturaCompra_Detalle` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `facturacompra_estado`
--
ALTER TABLE `facturacompra_estado`
  MODIFY `id_FacturaCompra_Estado` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del estado factura de compra', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `facturaventa`
--
ALTER TABLE `facturaventa`
  MODIFY `id_FacturaVenta` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la factura', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `facturaventa_detalle`
--
ALTER TABLE `facturaventa_detalle`
  MODIFY `id_FacturaVenta_Detalle` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable del detalle de la factura de venta', AUTO_INCREMENT=2;

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
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_Producto` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de producto', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `producto_tipo`
--
ALTER TABLE `producto_tipo`
  MODIFY `id_Producto_Tipo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de los tipo de producto', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_Proveedor` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de proveedor', AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `telefono`
--
ALTER TABLE `telefono`
  MODIFY `id_Telefono` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Llave primaria autoincrementable de la tabla telefonos', AUTO_INCREMENT=46;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD CONSTRAINT `Calificacion_Cita_FK` FOREIGN KEY (`id_Cita`) REFERENCES `cita` (`id_Cita`);

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `Cita_Cliente_FK` FOREIGN KEY (`id_Cliente`) REFERENCES `cliente` (`id_Cliente`),
  ADD CONSTRAINT `Cita_Empleado_FK` FOREIGN KEY (`id_Empleado`) REFERENCES `empleado` (`id_Empleado`),
  ADD CONSTRAINT `Cita_Producto_FK` FOREIGN KEY (`id_Producto`) REFERENCES `producto` (`id_Producto`);

--
-- Filtros para la tabla `clientealergia`
--
ALTER TABLE `clientealergia`
  ADD CONSTRAINT `ClienteAlergia_Alergia_FK` FOREIGN KEY (`id_Alergia`) REFERENCES `alergia` (`id_Alergia`),
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
  ADD CONSTRAINT `FacturaCompra_FacturaCompra_Estado_FK` FOREIGN KEY (`id_FacturaCompra_Estado`) REFERENCES `facturacompra_estado` (`id_FacturaCompra_Estado`),
  ADD CONSTRAINT `FacturaCompra_Proveedor_FK` FOREIGN KEY (`id_Proveedor`) REFERENCES `proveedor` (`id_Proveedor`);

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
  ADD CONSTRAINT `FacturaVenta_FacturaVenta_Estado_FK` FOREIGN KEY (`id_FacturaVenta`) REFERENCES `facturaventa_estado` (`id_FacturaVenta_Estado`);

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
