--do logowania
--tabelki
CREATE TABLE `tbl_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `activkey` varchar(128) NOT NULL DEFAULT '',
  `create_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lastvisit_at` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `superuser` int(1) NOT NULL DEFAULT '0',
  `status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`),
  KEY `superuser` (`superuser`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;
--1 user 1 profil
CREATE TABLE `tbl_profiles` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `lastname` varchar(50) NOT NULL DEFAULT '',
  `firstname` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;
--relacja 1 user 1 profil (1:1)
ALTER TABLE `tbl_profiles`
  ADD CONSTRAINT `user_profile_id` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`) ON DELETE CASCADE;

CREATE TABLE `tbl_profiles_fields` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `varname` varchar(50) NOT NULL,
  `title` varchar(255) NOT NULL,
  `field_type` varchar(50) NOT NULL,
  `field_size` varchar(15) NOT NULL DEFAULT '0',
  `field_size_min` varchar(15) NOT NULL DEFAULT '0',
  `required` int(1) NOT NULL DEFAULT '0',
  `match` varchar(255) NOT NULL DEFAULT '',
  `range` varchar(255) NOT NULL DEFAULT '',
  `error_message` varchar(255) NOT NULL DEFAULT '',
  `other_validator` varchar(5000) NOT NULL DEFAULT '',
  `default` varchar(255) NOT NULL DEFAULT '',
  `widget` varchar(255) NOT NULL DEFAULT '',
  `widgetparams` varchar(5000) NOT NULL DEFAULT '',
  `position` int(3) NOT NULL DEFAULT '0',
  `visible` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `varname` (`varname`,`widget`,`visible`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;


INSERT INTO `tbl_users` (`id`, `username`, `password`, `email`, `activkey`, `superuser`, `status`) VALUES
(1, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'webmaster@example.com', '9a24eff8c15a6a141ece27eb6947da0f', 1, 1),
(2, 'demo', 'fe01ce2a7fbac8fafaed7c982a04e229', 'demo@example.com', '099f825543f7850cc038b90aaff39fac', 0, 1);

INSERT INTO `tbl_profiles` (`user_id`, `lastname`, `firstname`) VALUES
(1, 'Admin', 'Administrator'),
(2, 'Demo', 'Demo');

INSERT INTO `tbl_profiles_fields` (`id`, `varname`, `title`, `field_type`, `field_size`, `field_size_min`, `required`, `match`, `range`, `error_message`, `other_validator`, `default`, `widget`, `widgetparams`, `position`, `visible`) VALUES
(1, 'lastname', 'Last Name', 'VARCHAR', 50, 3, 1, '', '', 'Incorrect Last Name (length between 3 and 50 characters).', '', '', '', '', 1, 3),
(2, 'firstname', 'First Name', 'VARCHAR', 50, 3, 1, '', '', 'Incorrect First Name (length between 3 and 50 characters).', '', '', '', '', 0, 3);
--(relacja 1 wojewodztwo ma wiele miast)
CREATE TABLE IF NOT EXISTS `tbl_wojewodztwa`
(
`id` INTEGER NOT NULL AUTO_INCREMENT,
`nazwa` varchar(256) NOT NULL,
PRIMARY KEY(`id`)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;
--
CREATE TABLE IF NOT EXISTS `tbl_miasta`
(
`id` INTEGER NOT NULL AUTO_INCREMENT,
`nazwa` varchar(256) NOT NULL,
`id_wojewodztwo` INTEGER NOT NULL,
PRIMARY KEY(`id`)
FOREIGN KEY (`id_wojewodztwo`) REFERENCES `tbl_wojewodztwa`(`id`)
)ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;
--
CREATE TABLE IF NOT EXISTS `tbl_kategorie` (relacja 1 do wielu tbl_podkategorie) HAS_MANY
(
`id` INTEGER NOT NULL AUTO_INCREMENT,
`nazwa` Varchar(256) NOT NULL, 
`id_user` INTEGER NOT NULL,
PRIMARY KEY (`id`),
//KEY `id_user` (`id_user`)//?
) ENGINE = InnoDB
--dodanie do tablicy
INSERT INTO `tbl_kategorie`(`id`, `nazwa`, `id_user`) VALUES (1,'Posiedzieć',1)
INSERT INTO `tbl_kategorie`(`id`, `nazwa`, `id_user`) VALUES (2,'Pobawić się',1)
INSERT INTO `tbl_kategorie`(`id`, `nazwa`, `id_user`) VALUES (3,'Zobaczyć',1)
INSERT INTO `tbl_kategorie`(`id`, `nazwa`, `id_user`) VALUES (4,'Wyspać się',1)
INSERT INTO `tbl_kategorie`(`id`, `nazwa`, `id_user`) VALUES (5,'Przeżyć',1)
INSERT INTO `tbl_kategorie`(`id`, `nazwa`, `id_user`) VALUES (6,'Zdobyć',1)

--
CREATE TABLE IF NOT EXISTS `tbl_podkategorie` 
(
`id` INTEGER NOT NULL AUTO_INCREMENT, 
`nazwa` Varchar(256) NOT NULL,
`id_kategorie` INTEGER NOT NULL,
PRIMARY KEY (`id`),
KEY `id_kategorie` (`id_kategorie`)
FOREIGN KEY (`id_kategorie`) REFERENCES `tbl_kategorie`(`id`)
) ENGINE = InnoDB
--dodanie do tablicy
INSERT INTO `tbl_podkategorie`(`id`, `nazwa`, `id_kategorie`) VALUES (1,'romantyczna kolacja',1)
INSERT INTO `tbl_podkategorie`(`id`, `nazwa`, `id_kategorie`) VALUES (2,'uroczystość',1)
INSERT INTO `tbl_podkategorie`(`id`, `nazwa`, `id_kategorie`) VALUES (3,'coś na szybko',1)
INSERT INTO `tbl_podkategorie`(`id`, `nazwa`, `id_kategorie`) VALUES (4,'wypad ze znajomymi',1)
-- 1 kategoria 1 waga?
CREATE TABLE IF NOT EXISTS `tbl_waga` 
(
`id` INTEGER NOT NULL AUTO_INCREMENT, 
`id_kategorie` INTEGER NOT NULL,
`nazwa` Varchar(256) NOT NULL,
`ocena` INTEGER NOT NULL,--czy to ma byc?
PRIMARY KEY (`id`),
KEY `id_kategorie` (`id_kategorie`)
FOREIGN KEY (`id_kategorie`) REFERENCES `tbl_kategorie`(`id`)
) ENGINE = InnoDB
--dodanie do tablicy
INSERT INTO `tbl_waga`(`id`,`id_kategorie`,`nazwa`,`ocena`) VALUES (1,1,'wystrój',6);
INSERT INTO `tbl_waga`(`id`,`id_kategorie`,`nazwa`,`ocena`) VALUES (2,1,'cena',5);
INSERT INTO `tbl_waga`(`id`,`id_kategorie`,`nazwa`,`ocena`) VALUES (3,1,'dania',4);
INSERT INTO `tbl_waga`(`id`,`id_kategorie`,`nazwa`,`ocena`) VALUES (4,1,'napoje',3);
INSERT INTO `tbl_waga`(`id`,`id_kategorie`,`nazwa`,`ocena`) VALUES (5,1,'obsługa',2);
INSERT INTO `tbl_waga`(`id`,`id_kategorie`,`nazwa`,`ocena`) VALUES (6,1,'porządek',1);
--
CREATE TABLE IF NOT EXISTS `tbl_miejsce`
(
`id` INTEGER NOT NULL AUTO_INCREMENT,
`id_kategorie` INTEGER NOT NULL,
`id_podkategorie` INTEGER NOT NULL,
`id_wojewodztwo` INTEGER NOT NULL,//???
`id_miasto` INTEGER NOT NULL,//?
`id_usera` INTEGER NOT NULL,
`nazwa_miejsca` varchar(256) NOT NULL,
PRIMARY KEY(`id`)
)ENGINE=InnoDB
--
--1 miejsce wiele ocen
--Tablica ocena wagi/ocena ogolna
--
CREATE TABLE IF NOT EXISTS `tbl_ocena`
(
`id` INTEGER NOT NULL AUTO_INCREMENT,
`id_miejsce` INTEGER NOT NULL,
`id_usera` INTEGER NOT NULL,
`last_vote` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`ocena` INTEGER NOT NULL,
PRIMARY KEY(`id`)
FOREIGN KEY (`id_miejsce`) REFERENCES `tbl_miejsce`(`id`)
)ENGINE=InnoDB
--1 do wielu
CREATE TABLE IF NOT EXISTS `tbl_waga_ocena`//?
(
`id` INTEGER NOT NULL AUTO_INCREMENT,
`id_miejsce` INTEGER NOT NULL,
`id_usera` INTEGER NOT NULL,
`last_vote` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
`waga` INTEGER NOT NULL,
PRIMARY KEY(`id`)
FOREIGN KEY (`id_miejsce`) REFERENCES `tbl_miejsce`(`id`) 
)ENGINE=InnoDB
--zdjecie z logiem?(1 miejsce 1 zdjecie 1:1)

CREATE TABLE IF NOT EXISTS `tbl_image`
(
`id` INTEGER NOT NULL AUTO_INCREMENT,
`id_miejsce` INTEGER NOT NULL,
`file_content` blob,
`file_type` varchar(10),
`file_size` INTEGER
PRIMARY KEY(`id`)
FOREIGN KEY (`id`) REFERENCES `tbl_miejsce`(`id`)
)ENGINE=InnoDB
--dane adresowe
CREATE TABLE IF NOT EXISTS `tbl_adress`
(
`id` INTEGER NOT NULL AUTO_INCREMENT,
`id_miejsce` INTEGER NOT NULL,//czy to musi tu byc?
`ulica` varchar(255) NOT NULL,
`id_wojewodztwa` INTEGER,
`id_miasto` INTEGER,
`współrzedne_na_mapie` INTEGER
FOREIGN KEY (`id`) REFERENCES `tbl_miejsce`(`id`)
)