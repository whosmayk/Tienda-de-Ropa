-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-02-2026 a las 02:39:19
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
-- Base de datos: `tienda_ropa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actualizacion`
--

CREATE TABLE `actualizacion` (
  `id_actualizacion` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `precio_anterior` decimal(10,2) NOT NULL,
  `precio_nuevo` decimal(10,2) NOT NULL,
  `id_prenda` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `actualizacion`
--

INSERT INTO `actualizacion` (`id_actualizacion`, `fecha`, `precio_anterior`, `precio_nuevo`, `id_prenda`, `id_empleado`) VALUES
(1, '2026-02-07 20:24:25', 420.00, 450.00, 1, 1),
(2, '2026-02-07 20:24:25', 600.00, 650.50, 2, 4),
(3, '2026-02-07 20:24:25', 1100.00, 1200.00, 3, 1),
(4, '2026-02-07 20:24:25', 320.00, 350.00, 4, 4),
(5, '2026-02-07 20:24:25', 380.00, 400.00, 5, 1),
(6, '2026-02-18 21:55:06', 1200.00, 1350.00, 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nombre`, `descripcion`) VALUES
(1, 'Caballero', 'Ropa formal, informal, casual y de etiqueta para hombres'),
(2, 'Dama', 'Vestidos, blusas y tendencias de temporada para mujeres'),
(3, 'Infantil', 'Prendas cómodas y duraderas para niños de 2 a 12 años'),
(4, 'Deportiva', 'Ropa técnica de alto rendimiento'),
(5, 'Accesorios', 'Complementos como cinturones, bufandas y joyería básica');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `color`
--

CREATE TABLE `color` (
  `id_color` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `color`
--

INSERT INTO `color` (`id_color`, `nombre`) VALUES
(1, 'Negro Nocturno'),
(2, 'Blanco Pureza'),
(3, 'Azul Marino'),
(4, 'Rojo Pasión'),
(5, 'Gris Oxford');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `puesto` varchar(20) NOT NULL
) ;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `nombre`, `puesto`) VALUES
(1, 'Karina Sánchez', 'gerente'),
(2, 'Miguel Esparza', 'empleado'),
(3, 'Kennia De luna', 'gerente'),
(4, 'Mariana Juárez', 'gerente'),
(5, 'Guadalupe Hernández', 'empleado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movimiento_stock`
--

CREATE TABLE `movimiento_stock` (
  `id_movimiento` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `tipo_movimiento` varchar(10) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `id_prenda` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `movimiento_stock`
--

INSERT INTO `movimiento_stock` (`id_movimiento`, `fecha`, `tipo_movimiento`, `cantidad`, `id_prenda`, `id_empleado`) VALUES
(1, '2026-02-07 20:24:25', 'entrada', 10, 1, 2),
(2, '2026-02-07 20:24:25', 'salida', 5, 2, 3),
(3, '2026-02-07 20:24:25', 'ajuste', -2, 3, 1),
(4, '2026-02-07 20:24:25', 'entrada', 20, 4, 5),
(5, '2026-02-07 20:24:25', 'salida', 1, 5, 2),
(66, '2025-10-20 09:00:00', 'entrada', 10, 21, 2),
(67, '2025-10-20 14:30:00', 'salida', 2, 22, 3),
(68, '2025-10-21 08:15:00', 'entrada', 50, 23, 1),
(70, '2025-10-21 16:45:00', 'ajuste', -1, 25, 4),
(71, '2025-10-22 10:20:00', 'entrada', 20, 26, 1),
(72, '2026-01-22 13:10:00', 'salida', 3, 27, 5),
(73, '2026-01-23 09:45:00', 'entrada', 15, 28, 2),
(74, '2026-01-23 18:20:00', 'salida', 1, 29, 3),
(75, '2026-01-24 07:30:00', 'entrada', 30, 30, 4),
(76, '2026-01-24 15:00:00', 'salida', 10, 31, 2),
(77, '2026-01-25 11:15:00', 'entrada', 5, 32, 1),
(78, '2026-01-25 12:00:00', 'salida', 2, 33, 5),
(79, '2026-01-26 10:00:00', 'entrada', 12, 34, 2),
(80, '2026-01-26 16:30:00', 'salida', 4, 35, 3),
(81, '2026-02-18 22:11:01', 'ajuste', 5, 34, 1),
(82, '2026-02-24 07:26:22', 'entrada', 15, 36, 2),
(83, '2026-02-24 10:26:42', 'entrada', 10, 38, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prenda`
--

CREATE TABLE `prenda` (
  `id_prenda` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `stock_actual` int(11) DEFAULT 0,
  `id_categoria` int(11) NOT NULL,
  `id_talla` int(11) NOT NULL,
  `id_color` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `prenda`
--

INSERT INTO `prenda` (`id_prenda`, `nombre`, `precio`, `stock_actual`, `id_categoria`, `id_talla`, `id_color`) VALUES
(1, 'Camisa Oxford Slim', 450.00, 25, 1, 2, 3),
(2, 'Pantalón Jean Clásico', 650.50, 40, 1, 3, 1),
(3, 'Vestido de Gala Rojo', 1350.00, 10, 2, 2, 4),
(4, 'Playera Deportiva Pro', 350.00, 50, 4, 1, 2),
(5, 'Sudadera Infantil Hoodie', 400.00, 15, 3, 2, 5),
(21, 'Blusa Seda Elegante', 550.00, 15, 2, 1, 2),
(22, 'Chaqueta Cuero Sintético', 1200.00, 8, 1, 3, 1),
(23, 'Short Deportivo Runner', 280.00, 45, 4, 2, 3),
(25, 'Jeans Skinny Fit Dama', 750.00, 22, 2, 2, 3),
(26, 'Playera Básica Cuello V', 190.00, 60, 1, 2, 2),
(27, 'Vestido Midi Estampado', 890.00, 12, 2, 3, 4),
(28, 'Sudadera con Capucha Gris', 500.00, 18, 1, 3, 5),
(29, 'Pijama Térmica Infantil', 350.00, 30, 3, 2, 3),
(30, 'Gorra Deportiva Ajustable', 250.00, 25, 5, 3, 1),
(31, 'Suéter Lana Merino', 950.00, 10, 1, 3, 5),
(32, 'Falda Plisada Coreana', 480.00, 20, 2, 1, 4),
(33, 'Conjunto Deportivo Yoga', 720.00, 15, 4, 2, 1),
(34, 'Camiseta Manga Larga', 320.00, 45, 3, 3, 2),
(35, 'Cinturón Cuero Café', 300.00, 25, 5, 3, 5),
(36, 'Conjunto Pijama Negra', 250.00, 30, 1, 3, 1),
(38, 'Conjunto Pijama Negra', 220.00, 20, 1, 8, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedor`
--

CREATE TABLE `proveedor` (
  `id_proveedor` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` char(10) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedor`
--

INSERT INTO `proveedor` (`id_proveedor`, `nombre`, `telefono`, `direccion`) VALUES
(1, 'Casimires y Trajes Lucerna', '4499156551', 'Calle Francisco I. Madero 102 A, Aguascalientes'),
(2, 'Uniformes América', '4494357284', 'Av. Convención 1914 Ote. 105-A, Aguascalientes'),
(3, 'La Charrita de Aguascalientes', '4493110929', 'Calle Del Carmen 313, Aguascalientes'),
(4, 'Maquilas Textiles Arenas', '4492994799', 'Paseo de la Explanada 145, Aguascalientes'),
(5, 'Fábrica de Tejido de Punto y Confecciones Ofelia S.A. de C.V.', '4499730249', 'Av. Francisco I. Madero 810, Aguascalientes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro`
--

CREATE TABLE `registro` (
  `id_registro` int(11) NOT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `id_prenda` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `registro`
--

INSERT INTO `registro` (`id_registro`, `fecha_registro`, `id_prenda`, `id_empleado`, `id_proveedor`) VALUES
(1, '2026-02-07 20:24:25', 1, 1, 1),
(2, '2026-02-07 20:24:25', 2, 4, 2),
(3, '2026-02-07 20:24:25', 3, 1, 3),
(4, '2026-02-07 20:24:25', 4, 4, 4),
(5, '2026-02-07 20:24:25', 5, 1, 5),
(7, '2026-02-24 07:34:28', 36, 2, 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talla`
--

CREATE TABLE `talla` (
  `id_talla` int(11) NOT NULL,
  `talla` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `talla`
--

INSERT INTO `talla` (`id_talla`, `talla`) VALUES
(1, 'ch'),
(2, 'm'),
(3, 'g'),
(7, 'ech'),
(8, 'eg');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actualizacion`
--
ALTER TABLE `actualizacion`
  ADD PRIMARY KEY (`id_actualizacion`),
  ADD KEY `fk_act_prenda` (`id_prenda`),
  ADD KEY `fk_act_emp` (`id_empleado`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `color`
--
ALTER TABLE `color`
  ADD PRIMARY KEY (`id_color`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`);

--
-- Indices de la tabla `movimiento_stock`
--
ALTER TABLE `movimiento_stock`
  ADD PRIMARY KEY (`id_movimiento`),
  ADD KEY `fk_mov_prenda` (`id_prenda`),
  ADD KEY `fk_mov_emp` (`id_empleado`),
  ADD KEY `idx_movimiento_fecha` (`fecha`);

--
-- Indices de la tabla `prenda`
--
ALTER TABLE `prenda`
  ADD PRIMARY KEY (`id_prenda`),
  ADD KEY `fk_prenda_talla` (`id_talla`),
  ADD KEY `fk_prenda_color` (`id_color`),
  ADD KEY `idx_prenda_nombre` (`nombre`),
  ADD KEY `idx_prenda_cat_talla` (`id_categoria`,`id_talla`);

--
-- Indices de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`id_proveedor`),
  ADD UNIQUE KEY `telefono` (`telefono`);

--
-- Indices de la tabla `registro`
--
ALTER TABLE `registro`
  ADD PRIMARY KEY (`id_registro`),
  ADD KEY `fk_reg_prenda` (`id_prenda`),
  ADD KEY `fk_reg_emp` (`id_empleado`),
  ADD KEY `fk_reg_prov` (`id_proveedor`);

--
-- Indices de la tabla `talla`
--
ALTER TABLE `talla`
  ADD PRIMARY KEY (`id_talla`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actualizacion`
--
ALTER TABLE `actualizacion`
  MODIFY `id_actualizacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `color`
--
ALTER TABLE `color`
  MODIFY `id_color` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `movimiento_stock`
--
ALTER TABLE `movimiento_stock`
  MODIFY `id_movimiento` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `prenda`
--
ALTER TABLE `prenda`
  MODIFY `id_prenda` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `registro`
--
ALTER TABLE `registro`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `talla`
--
ALTER TABLE `talla`
  MODIFY `id_talla` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `actualizacion`
--
ALTER TABLE `actualizacion`
  ADD CONSTRAINT `fk_act_emp` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `fk_act_prenda` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`);

--
-- Filtros para la tabla `movimiento_stock`
--
ALTER TABLE `movimiento_stock`
  ADD CONSTRAINT `fk_mov_emp` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `fk_mov_prenda` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`);

--
-- Filtros para la tabla `prenda`
--
ALTER TABLE `prenda`
  ADD CONSTRAINT `fk_prenda_cat` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`),
  ADD CONSTRAINT `fk_prenda_color` FOREIGN KEY (`id_color`) REFERENCES `color` (`id_color`),
  ADD CONSTRAINT `fk_prenda_talla` FOREIGN KEY (`id_talla`) REFERENCES `talla` (`id_talla`);

--
-- Filtros para la tabla `registro`
--
ALTER TABLE `registro`
  ADD CONSTRAINT `fk_reg_emp` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `fk_reg_prenda` FOREIGN KEY (`id_prenda`) REFERENCES `prenda` (`id_prenda`),
  ADD CONSTRAINT `fk_reg_prov` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedor` (`id_proveedor`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
