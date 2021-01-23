DROP DATABASE IF EXISTS `aseguradora_db`;
CREATE DATABASE aseguradora_db;
USE aseguradora_db;
SET FOREIGN_KEY_CHECKS=0;
DROP USER IF EXISTS 'aseguradora_usr'@'localhost';
CREATE USER 'aseguradora_usr'@'localhost' IDENTIFIED BY 'aseguradora_pwd';
GRANT ALL PRIVILEGES ON aseguradora_db.* TO 'aseguradora_usr'@'localhost';
-- ----------------------------
-- Table structure for clientes
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `codigo` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_50FE07D7BF396750` FOREIGN KEY (`id`) REFERENCES `persona` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES ('1', '000111');
INSERT INTO `clientes` VALUES ('2', '000222');
INSERT INTO `clientes` VALUES ('3', '000333');
INSERT INTO `clientes` VALUES ('4', '000444');
INSERT INTO `clientes` VALUES ('5', '000555');

-- ----------------------------
-- Table structure for empleados
-- ----------------------------
DROP TABLE IF EXISTS `empleados`;
CREATE TABLE `empleados` (
  `id` int(11) NOT NULL,
  `legajo` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_9EB2266CBF396750` FOREIGN KEY (`id`) REFERENCES `persona` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of empleados
-- ----------------------------
INSERT INTO `empleados` VALUES ('6', '000999');

-- ----------------------------
-- Table structure for estado_incidente
-- ----------------------------
DROP TABLE IF EXISTS `estado_incidente`;
CREATE TABLE `estado_incidente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of estado_incidente
-- ----------------------------
INSERT INTO `estado_incidente` VALUES ('1', 'VISOR');
INSERT INTO `estado_incidente` VALUES ('2', 'FOTO y PRESUPUESTO');
INSERT INTO `estado_incidente` VALUES ('3', 'REVISOR');
INSERT INTO `estado_incidente` VALUES ('4', 'APROBADO');
INSERT INTO `estado_incidente` VALUES ('5', 'RECHAZADO');

-- ----------------------------
-- Table structure for incidentes
-- ----------------------------
DROP TABLE IF EXISTS `incidentes`;
CREATE TABLE `incidentes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_id` int(11) DEFAULT NULL,
  `estado_id` int(11) DEFAULT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `fechaCarga` datetime NOT NULL,
  `fechaIncidente` datetime NOT NULL,
  `cantidad` int(11) NOT NULL,
  `motivo` longtext COLLATE utf8_unicode_ci NOT NULL,
  `detalle` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_81A3F93DA9276E6C` (`tipo_id`),
  KEY `IDX_81A3F93D9F5A440B` (`estado_id`),
  KEY `IDX_81A3F93DDB38439E` (`usuario_id`),
  CONSTRAINT `FK_81A3F93D9F5A440B` FOREIGN KEY (`estado_id`) REFERENCES `estado_incidente` (`id`),
  CONSTRAINT `FK_81A3F93DA9276E6C` FOREIGN KEY (`tipo_id`) REFERENCES `tipo_incidente` (`id`),
  CONSTRAINT `FK_81A3F93DDB38439E` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of incidentes
-- ----------------------------

-- ----------------------------
-- Table structure for persona
-- ----------------------------
DROP TABLE IF EXISTS `persona`;
CREATE TABLE `persona` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `documento` int(11) NOT NULL,
  `discr` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of persona
-- ----------------------------
INSERT INTO `persona` VALUES ('1', 'Nombre Cliente 1', '111', 'cliente');
INSERT INTO `persona` VALUES ('2', 'Nombre Cliente 2', '222', 'cliente');
INSERT INTO `persona` VALUES ('3', 'Nombre Cliente 3', '333', 'cliente');
INSERT INTO `persona` VALUES ('4', 'Nombre Cliente 4', '444', 'cliente');
INSERT INTO `persona` VALUES ('5', 'Nombre Cliente 5', '555', 'cliente');
INSERT INTO `persona` VALUES ('6', 'Nombre Empleado 1', '999', 'empleado');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', 'CLIENTE');
INSERT INTO `roles` VALUES ('2', 'EMPLEADO');

-- ----------------------------
-- Table structure for tipo_incidente
-- ----------------------------
DROP TABLE IF EXISTS `tipo_incidente`;
CREATE TABLE `tipo_incidente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of tipo_incidente
-- ----------------------------
INSERT INTO `tipo_incidente` VALUES ('1', 'CASA');
INSERT INTO `tipo_incidente` VALUES ('2', 'OBJETO MUEBLE');
INSERT INTO `tipo_incidente` VALUES ('3', 'AUTO');

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `persona_id` int(11) DEFAULT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `password` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_email` (`email`),
  KEY `IDX_EF687F2F5F88DB9` (`persona_id`),
  KEY `IDX_EF687F24BAB96C` (`rol_id`),
  CONSTRAINT `FK_EF687F24BAB96C` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FK_EF687F2F5F88DB9` FOREIGN KEY (`persona_id`) REFERENCES `persona` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES ('1', '1', '1', '$2y$11$i.iXDVm9o8lI1zqqS12/JuW1pliRnOR96MZhI6dlM0QU.CTc8NxH2', 'canarioverde@zoho.com', '1');
INSERT INTO `usuarios` VALUES ('2', '2', '1', '$2y$11$96gMDGB2qY6O5zFaDodr9..q83MdcfOAAnNueQButgO57fXuuvHdm', 'usuario2@test.com', '1');
INSERT INTO `usuarios` VALUES ('3', '3', '1', '$2y$11$pB4XF.F66LpADhIK9M0Jx.jWOq47VOFKNEzXrlPt7L5aqwWKrCRCe', 'usuario3@test.com', '1');
INSERT INTO `usuarios` VALUES ('4', '4', '1', '$2y$11$ZPFqKNe7W5zxLQZr/NGR4OQgSrUqlHzhbVMXyulLekmob1Wj4nbk6', 'usuario4@test.com', '1');
INSERT INTO `usuarios` VALUES ('6', '6', '2', '$2y$11$w7NKM9mEgIKMScnXHDl0.eqU7BhptKwtzXGFtHWw0Gvd8InNjlgAu', 'aseguradorassa@zoho.com', '1');
