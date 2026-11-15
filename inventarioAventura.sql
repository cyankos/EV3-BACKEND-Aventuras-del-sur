-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-11-2026 a las 20:38:45
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `inventario_aventura_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 3, 'add_permission'),
(6, 'Can change permission', 3, 'change_permission'),
(7, 'Can delete permission', 3, 'delete_permission'),
(8, 'Can view permission', 3, 'view_permission'),
(9, 'Can add group', 2, 'add_group'),
(10, 'Can change group', 2, 'change_group'),
(11, 'Can delete group', 2, 'delete_group'),
(12, 'Can view group', 2, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_usuario'),
(22, 'Can change user', 6, 'change_usuario'),
(23, 'Can delete user', 6, 'delete_usuario'),
(24, 'Can view user', 6, 'view_usuario'),
(25, 'Can add categoria', 7, 'add_categoria'),
(26, 'Can change categoria', 7, 'change_categoria'),
(27, 'Can delete categoria', 7, 'delete_categoria'),
(28, 'Can view categoria', 7, 'view_categoria'),
(29, 'Can add experiencia', 8, 'add_experiencia'),
(30, 'Can change experiencia', 8, 'change_experiencia'),
(31, 'Can delete experiencia', 8, 'delete_experiencia'),
(32, 'Can view experiencia', 8, 'view_experiencia'),
(33, 'Can add reserva', 9, 'add_reserva'),
(34, 'Can change reserva', 9, 'change_reserva'),
(35, 'Can delete reserva', 9, 'delete_reserva'),
(36, 'Can view reserva', 9, 'view_reserva');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_usuario`
--

CREATE TABLE `cuentas_usuario` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `rol` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cuentas_usuario`
--

INSERT INTO `cuentas_usuario` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `rol`) VALUES
(1, 'pbkdf2_sha256$1500000$vUvufkwugH4CDsH0oNSzco$RGe2dgJFo8VX+T9rQ4ZzEDUpZ7KpsFOMy/+NGs6BF1U=', NULL, 1, 'admin', 'Rodrigo', 'Gonzales', 'admin@aventurasdelsur.cl', 1, 1, '2026-11-15 19:32:52.627371', 'admin'),
(2, 'pbkdf2_sha256$1500000$GreKsUvqZewuFw5FreXDPt$yDutHE9+Rqwcqi7z+pbKUYtDoPcKGaBxEmn35Y44K/M=', NULL, 0, 'guia1', 'Nicolás', 'Sánchez', 'guia1@aventurasdelsur.cl', 0, 1, '2026-11-15 19:32:53.461234', 'guia'),
(3, 'pbkdf2_sha256$1500000$VmSdsumsLnxP06qiNA0jG2$ZQvQGDi5+OcF34CvsqoEpEAHBs+co5u/e9OSoWNwZF4=', NULL, 0, 'guia2', 'Fernanda', 'Gómez', 'guia2@aventurasdelsur.cl', 0, 1, '2026-11-15 19:32:54.301005', 'guia'),
(4, 'pbkdf2_sha256$1500000$XuPI9dS7DI43kBB1mrOcFX$wsrj6You6ulHt5W3DoxkO+kVQFkA/N0nhd2lQxPifqQ=', NULL, 0, 'turista1', 'Diego', 'Perez', 'turista1@aventurasdelsur.cl', 0, 1, '2026-11-15 19:32:55.136478', 'turista'),
(5, 'pbkdf2_sha256$1500000$rlMBVdd1gvq6hy9rxnTQTp$ZG47rSj/CFgarEoK3kqzVAjfmqwFV60Lh3GcKBxaz8M=', NULL, 0, 'turista2', 'Camila', 'Navarro', 'turista2@aventurasdelsur.cl', 0, 1, '2026-11-15 19:32:55.962939', 'turista');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_usuario_groups`
--

CREATE TABLE `cuentas_usuario_groups` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuentas_usuario_user_permissions`
--

CREATE TABLE `cuentas_usuario_user_permissions` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(2, 'auth', 'group'),
(3, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(6, 'cuentas', 'usuario'),
(7, 'experiencias', 'categoria'),
(8, 'experiencias', 'experiencia'),
(9, 'experiencias', 'reserva'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-11-15 19:32:50.830898'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-11-15 19:32:50.870425'),
(3, 'auth', '0001_initial', '2026-11-15 19:32:51.038540'),
(4, 'auth', '0002_alter_permission_name_max_length', '2026-11-15 19:32:51.076156'),
(5, 'auth', '0003_alter_user_email_max_length', '2026-11-15 19:32:51.080214'),
(6, 'auth', '0004_alter_user_username_opts', '2026-11-15 19:32:51.084551'),
(7, 'auth', '0005_alter_user_last_login_null', '2026-11-15 19:32:51.088961'),
(8, 'auth', '0006_require_contenttypes_0002', '2026-11-15 19:32:51.090563'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2026-11-15 19:32:51.094098'),
(10, 'auth', '0008_alter_user_username_max_length', '2026-11-15 19:32:51.098115'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2026-11-15 19:32:51.101867'),
(12, 'auth', '0010_alter_group_name_max_length', '2026-11-15 19:32:51.111320'),
(13, 'auth', '0011_update_proxy_permissions', '2026-11-15 19:32:51.116064'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2026-11-15 19:32:51.120043'),
(15, 'cuentas', '0001_initial', '2026-11-15 19:32:51.336073'),
(16, 'admin', '0001_initial', '2026-11-15 19:32:51.467226'),
(17, 'admin', '0002_logentry_remove_auto_add', '2026-11-15 19:32:51.475145'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2026-11-15 19:32:51.482210'),
(19, 'cuentas', '0002_alter_usuario_options_alter_usuario_groups_and_more', '2026-11-15 19:32:51.497626'),
(20, 'experiencias', '0001_initial', '2026-11-15 19:32:51.788797'),
(21, 'experiencias', '0002_datos_demo', '2026-11-15 19:32:56.015554'),
(22, 'sessions', '0001_initial', '2026-11-15 19:32:56.039044');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencias_categoria`
--

CREATE TABLE `experiencias_categoria` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `descripcion` longtext NOT NULL,
  `activo` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `experiencias_categoria`
--

INSERT INTO `experiencias_categoria` (`id`, `nombre`, `descripcion`, `activo`) VALUES
(1, 'Trekking', 'Caminatas guiadas por senderos volcánicos, bosques de araucarias y lagunas.', 1),
(2, 'Canopy', 'Circuitos de tirolesas y puentes colgantes entre bosque nativo.', 1),
(3, 'Kayak', 'Travesías guiadas en aguas tranquilas de lagos y ríos del sector.', 1),
(4, 'Arriendo de equipos', 'Equipamiento de montaña, bastones, carpas y accesorios por jornada.', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencias_experiencia`
--

CREATE TABLE `experiencias_experiencia` (
  `id` bigint(20) NOT NULL,
  `titulo` varchar(120) NOT NULL,
  `descripcion` longtext NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cupo_maximo` int(10) UNSIGNED NOT NULL CHECK (`cupo_maximo` >= 0),
  `fecha_hora` datetime(6) NOT NULL,
  `categoria_id` bigint(20) NOT NULL,
  `creador_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `experiencias_experiencia`
--

INSERT INTO `experiencias_experiencia` (`id`, `titulo`, `descripcion`, `precio`, `cupo_maximo`, `fecha_hora`, `categoria_id`, `creador_id`) VALUES
(1, 'Trekking Los Lagos (Huerquehue)', 'Recorrido de jornada completa por lagunas Verde, Chico y Toro entre araucarias.', 22000.00, 14, '2026-11-21 19:32:55.975241', 1, 2),
(2, 'Canopy Río Trancura', 'Circuito de 7 líneas de tirolesa sobre bosque nativo con vista al volcán Villarrica.', 28000.00, 12, '2026-11-24 19:32:55.975241', 2, 2),
(3, 'Kayak Bahía La Poza', 'Travesía matinal en kayak doble por la ribera del lago Villarrica con equipo incluido.', 20000.00, 10, '2026-11-27 19:32:55.975241', 3, 2),
(4, 'Set Bastones + Mochila 30L', 'Arriendo diario de par de bastones telescópicos de aluminio y mochila impermeable.', 10000.00, 20, '2026-11-19 19:32:55.975241', 4, 2),
(5, 'Ascenso Mirador El Cañi', 'Caminata guiada hacia el mirador panorámico con vista a los volcanes de la zona.', 25000.00, 12, '2026-11-23 19:32:55.975241', 1, 3),
(6, 'Canopy Bosque de Coihues', 'Tramo familiar de baja altura con plataformas panorámicas e instrucción previa.', 24000.00, 15, '2026-11-29 19:32:55.975241', 2, 3),
(7, 'Kayak Laguna Tinquilco', 'Remada tranquila en aguas cristalinas rodeadas de bosque nativo.', 23000.00, 10, '2026-11-26 19:32:55.975241', 3, 3),
(8, 'Kit Camping Alta Montaña (2P)', 'Incluye carpa 4 estaciones, dos sacos de dormir térmicos y colchonetas aislantes.', 32000.00, 8, '2026-11-20 19:32:55.975241', 4, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `experiencias_reserva`
--

CREATE TABLE `experiencias_reserva` (
  `id` bigint(20) NOT NULL,
  `fecha_inscripcion` datetime(6) NOT NULL,
  `estado_pago` varchar(12) NOT NULL,
  `experiencia_id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `experiencias_reserva`
--

INSERT INTO `experiencias_reserva` (`id`, `fecha_inscripcion`, `estado_pago`, `experiencia_id`, `usuario_id`) VALUES
(1, '2026-11-15 19:32:56.000695', 'confirmado', 1, 4),
(2, '2026-11-15 19:32:56.002813', 'pendiente', 2, 4),
(3, '2026-11-15 19:32:56.006408', 'confirmado', 7, 4),
(4, '2026-11-15 19:32:56.008394', 'confirmado', 5, 5),
(5, '2026-11-15 19:32:56.011210', 'pendiente', 3, 5),
(6, '2026-11-15 19:32:56.013455', 'confirmado', 8, 5);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `cuentas_usuario`
--
ALTER TABLE `cuentas_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `cuentas_usuario_groups`
--
ALTER TABLE `cuentas_usuario_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cuentas_usuario_groups_usuario_id_group_id_f5ef6c73_uniq` (`usuario_id`,`group_id`),
  ADD KEY `cuentas_usuario_groups_group_id_e6725cc8_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `cuentas_usuario_user_permissions`
--
ALTER TABLE `cuentas_usuario_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cuentas_usuario_user_per_usuario_id_permission_id_26c0acea_uniq` (`usuario_id`,`permission_id`),
  ADD KEY `cuentas_usuario_user_permission_id_1753ad79_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_cuentas_usuario_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indices de la tabla `experiencias_categoria`
--
ALTER TABLE `experiencias_categoria`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `experiencias_experiencia`
--
ALTER TABLE `experiencias_experiencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `experiencias_experie_categoria_id_b03f452f_fk_experienc` (`categoria_id`),
  ADD KEY `experiencias_experie_creador_id_70b19025_fk_cuentas_u` (`creador_id`);

--
-- Indices de la tabla `experiencias_reserva`
--
ALTER TABLE `experiencias_reserva`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reserva_usuario_experiencia_unica` (`usuario_id`,`experiencia_id`),
  ADD KEY `experiencias_reserva_experiencia_id_ca702f09_fk_experienc` (`experiencia_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `cuentas_usuario`
--
ALTER TABLE `cuentas_usuario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `cuentas_usuario_groups`
--
ALTER TABLE `cuentas_usuario_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cuentas_usuario_user_permissions`
--
ALTER TABLE `cuentas_usuario_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `experiencias_categoria`
--
ALTER TABLE `experiencias_categoria`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `experiencias_experiencia`
--
ALTER TABLE `experiencias_experiencia`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `experiencias_reserva`
--
ALTER TABLE `experiencias_reserva`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `cuentas_usuario_groups`
--
ALTER TABLE `cuentas_usuario_groups`
  ADD CONSTRAINT `cuentas_usuario_groups_group_id_e6725cc8_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `cuentas_usuario_groups_usuario_id_251ff583_fk_cuentas_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `cuentas_usuario` (`id`);

--
-- Filtros para la tabla `cuentas_usuario_user_permissions`
--
ALTER TABLE `cuentas_usuario_user_permissions`
  ADD CONSTRAINT `cuentas_usuario_user_permission_id_1753ad79_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `cuentas_usuario_user_usuario_id_5a9718f1_fk_cuentas_u` FOREIGN KEY (`usuario_id`) REFERENCES `cuentas_usuario` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_cuentas_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `cuentas_usuario` (`id`);

--
-- Filtros para la tabla `experiencias_experiencia`
--
ALTER TABLE `experiencias_experiencia`
  ADD CONSTRAINT `experiencias_experie_categoria_id_b03f452f_fk_experienc` FOREIGN KEY (`categoria_id`) REFERENCES `experiencias_categoria` (`id`),
  ADD CONSTRAINT `experiencias_experie_creador_id_70b19025_fk_cuentas_u` FOREIGN KEY (`creador_id`) REFERENCES `cuentas_usuario` (`id`);

--
-- Filtros para la tabla `experiencias_reserva`
--
ALTER TABLE `experiencias_reserva`
  ADD CONSTRAINT `experiencias_reserva_experiencia_id_ca702f09_fk_experienc` FOREIGN KEY (`experiencia_id`) REFERENCES `experiencias_experiencia` (`id`),
  ADD CONSTRAINT `experiencias_reserva_usuario_id_8724df18_fk_cuentas_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `cuentas_usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
