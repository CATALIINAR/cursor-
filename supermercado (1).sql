-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-04-2023 a las 13:42:52
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `supermercado`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `createnumlista`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createnumlista` (INOUT `numlista` VARCHAR(4000))   begin
	declare finished integer default 0;
	declare telefono int default "";
    
    declare curnum
		cursor for
    		select clientes.telefono from clientes, empleados
			where  clientes.id = empleados.id;
   
   declare continue handler
   for not found set finished = 1;
   open curnum;
	getnum: loop
		fetch curnum into telefono;
		if finished = 1 then 
			leave  getnum;
        end if;
        
        set numlista = concat(telefono,",",numlista);
        end loop;
        close curnum;
        
        end$$

DROP PROCEDURE IF EXISTS `saludo`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `saludo` ()   begin
	select "hola mundo";
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `telefono`) VALUES
(1, 'Juan', '555-1234'),
(2, 'Ana', '555-5678'),
(3, 'Pedro', '555-9012'),
(1000, 'juan', '3007766'),
(1200, 'andres', '8005430');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `departamento` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id`, `nombre`, `departamento`) VALUES
(1, 'Maria', 'Ventas'),
(2, 'Jose', 'Marketing'),
(3, 'Sofia', 'Contabilidad'),
(1000, 'juan', 'contador'),
(1200, 'camilo', 'administrador');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
