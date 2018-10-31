use GIHaskell;
/****** Object:  Table `tPermiso`    Script Date: 31/10/2018 11:54:54 ******/



CREATE TABLE `tPermiso`(
	`rolName` varchar(50) NOT NULL,
	`pantalla` varchar(50) NOT NULL,
	`acceso` tinyint NOT NULL,
	`modificacion` tinyint NOT NULL,
 CONSTRAINT `PK_tPermiso` PRIMARY KEY 
(
	`rolName` ASC,
	`pantalla` ASC
)
)

;

/****** Object:  Table `tPiezas`    Script Date: 31/10/2018 11:54:54 ******/



CREATE TABLE `tPiezas`(
	`ID` int AUTO_INCREMENT NOT NULL,
	`NOMBRE` varchar(255) NOT NULL,
	`FABRICANTE` varchar(255) NOT NULL,
	`ID_TIPO` varchar(4) NOT NULL,
 CONSTRAINT `PK_Pieza` PRIMARY KEY 
(
	`ID` ASC
)
)

;

/****** Object:  Table `tRol`    Script Date: 31/10/2018 11:54:54 ******/



CREATE TABLE `tRol`(
	`rolName` varchar(50) NOT NULL,
	`rolDes` varchar(255) NULL,
	`admin` tinyint NOT NULL,
 CONSTRAINT `PK_tRol` PRIMARY KEY 
(
	`rolName` ASC
)
)

;

/****** Object:  Table `tTipoPieza`    Script Date: 31/10/2018 11:54:54 ******/



CREATE TABLE `tTipoPieza`(
	`ID_TIPO` varchar(4) NOT NULL,
	`NOMBRE` varchar(80) NOT NULL,
 CONSTRAINT `PK_tTipoPieza` PRIMARY KEY 
(
	`ID_TIPO` ASC
)
)

;

/****** Object:  Table `tUsuario`    Script Date: 31/10/2018 11:54:54 ******/



CREATE TABLE `tUsuario`(
	`nombre` varchar(50) NOT NULL,
	`password` varchar(50) NOT NULL,
	`rolName` varchar(50) NOT NULL,
 CONSTRAINT `PK_tUsuario` PRIMARY KEY 
(
	`nombre` ASC
)
)

;

ALTER TABLE `tPermiso` ADD  CONSTRAINT `FK_tPermiso_tRol` FOREIGN KEY (`rolName`)
REFERENCES `tRol` (`rolName`)
;

ALTER TABLE `tPiezas`  ADD  CONSTRAINT `FK_tPiezas_tTipoPieza` FOREIGN KEY (`ID_TIPO`)
REFERENCES `tTipoPieza` (`ID_TIPO`)
ON UPDATE CASCADE
ON DELETE CASCADE
;

ALTER TABLE `tUsuario` ADD  CONSTRAINT `FK_tUsuario_tRol` FOREIGN KEY (`rolName`)
REFERENCES `tRol` (`rolName`)
ON UPDATE CASCADE
ON DELETE CASCADE
;


DELETE from tRol;
INSERT INTO tRol VALUES('administrador', 'administrador',1);
INSERT INTO tRol VALUES('usuario', 'usuario',0);
INSERT INTO tRol VALUES('invitado', 'invitado',0);


DELETE from tUsuario;

INSERT INTO tUsuario VALUES('admin', 'admin','administrador');
INSERT INTO tUsuario VALUES('user', 'user','usuario');
INSERT INTO tUsuario VALUES('inv', 'inv','invitado');


DELETE from tPermiso;

INSERT INTO tPermiso VALUES('administrador','LOGIN',1,1);
INSERT INTO tPermiso VALUES('administrador','PIEZASTALLER',1,1);

INSERT INTO tPermiso VALUES('usuario','LOGIN',1,1);
INSERT INTO tPermiso VALUES('usuario','PIEZASTALLER',1,0);

INSERT INTO tPermiso VALUES('invitado','LOGIN',1,1);
INSERT INTO tPermiso VALUES('invitado','PIEZASTALLER',0,0);



Delete FROM `tTipoPieza`;


INSERT INTO tTipoPieza VALUES('A','Chapa');
INSERT INTO tTipoPieza VALUES('B','Motor');
INSERT INTO tTipoPieza VALUES('C','Iluminacion');
INSERT INTO tTipoPieza VALUES('D','Sensores');
INSERT INTO tTipoPieza VALUES('E','Cristales');
INSERT INTO tTipoPieza VALUES('F','Pintura');
INSERT INTO tTipoPieza VALUES('G','Otros');




INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('PARA;LPES DELANTERO NEGRO-LISO A IMPRIMAR','MAZDA','A');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('PARA;LPES TRASERO-IMPRIMADO','MAZDA','A');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('REJILLA NEGRA','MAZDA','A');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('ALETA DELANTERA DCH CON AUJERO PARA PILOTO CX3 16','MAZDA','A');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('ALETA DELANTERA IZQ CON AUJERO PARA PILOTO CX3 16','MAZDA','A');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Bombillas luz delantera','RENAULT','C');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Bombillas senializacion delantera','RENAULT','C');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Bombillas luz trasera','RENAULT','C');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Bombillas senializacion trasera','RENAULT','C');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Estuches de bombillas','RENAULT','C');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Iluminacion LED','RENAULT','C');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Bombillas interior','RENAULT','C');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Bombillas Xenon','RENAULT','C');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Juntas y otras piezas del motor','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Alimentacion','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Kits de distribucion','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Correas','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Poleas','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Kits','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Valvulas EGR','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Herramienta especifica','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Turbocompresores','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Sensores electronicos y medidores de flujo','FORD','B');
INSERT INTO tPiezas(NOMBRE,FABRICANTE,ID_TIPO) VALUES('Cable de acelerador y starter','FORD','B');
;
