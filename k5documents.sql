CREATE TABLE `pedy_dokumentum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext,
  `ownerId` varchar(50),
  `isCopy` tinyint,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `pedy_dokumentum_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `data` longtext,
  `job` varchar(50),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;