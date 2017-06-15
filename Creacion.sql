DROP DATABASE IF EXISTS SocialNetworks;

CREATE DATABASE SocialNetworks;
USE SocialNetworks;

CREATE TABLE Empresa (
	Nombre VARCHAR(255) NOT NULL,
	Direccion VARCHAR(255),
	CONSTRAINT PK_Empresa PRIMARY KEY (Nombre)
);

CREATE TABLE Fundador (
	Nombre VARCHAR(255) NOT NULL,
	Telefono VARCHAR(255),
	Correo VARCHAR(255),
	NombreEmpresa VARCHAR(255) NOT NULL,
	CONSTRAINT PK_Fundador PRIMARY KEY (Nombre),
	CONSTRAINT FK_Fundador_Empresa FOREIGN KEY (NombreEmpresa) REFERENCES Empresa (Nombre)
);

CREATE TABLE RedSocial (
	Nombre VARCHAR(255) NOT NULL,
	Descripcion VARCHAR(255),
	Tipo VARCHAR(255),
	NombreEmpresa VARCHAR(255) NOT NULL,
	FechaLanzamiento DATE,
	CONSTRAINT PK_RedSocial PRIMARY KEY (Nombre),
	CONSTRAINT FK_RedSocial_Empresa FOREIGN KEY (NombreEmpresa) REFERENCES Empresa (Nombre)
);

CREATE TABLE Administra (
	NombreFundador VARCHAR(255) NOT NULL,
	NombreRedSocial VARCHAR(255) NOT NULL,
	CONSTRAINT FK_Administra_Fundador FOREIGN KEY (NombreFundador) REFERENCES Fundador (Nombre),
	CONSTRAINT FK_Administra_RedSocial FOREIGN KEY (NombreRedSocial) REFERENCES RedSocial (Nombre)
);

CREATE TABLE Usuario (
	ID INT NOT NULL,
	NombreUsuario VARCHAR(255),
	Correo VARCHAR(255),
	ContrasenaEncriptada VARCHAR(255),
	FechaRegistro DATE,
	NombreRedSocial VARCHAR(255) NOT NULL,
	CONSTRAINT PK_Usuario PRIMARY KEY (ID),
	CONSTRAINT FK_Usuario_RedSocial FOREIGN KEY (NombreRedSocial) REFERENCES RedSocial (Nombre)
);

CREATE TABLE Interrelaciona (
	Correo VARCHAR(255) NOT NULL,
	NombreRedSocial1 VARCHAR(255),
	NombreRedSocial2 VARCHAR(255),
	UsuarioID INT NOT NULL,
	CONSTRAINT PK_Interrelaciona PRIMARY KEY (Correo),
	CONSTRAINT FK_RedSocial1 FOREIGN KEY (NombreRedSocial1) REFERENCES RedSocial (Nombre),
	CONSTRAINT FK_RedSocial2 FOREIGN KEY (NombreRedSocial2) REFERENCES RedSocial (Nombre),
	CONSTRAINT FK_Interrelaciona_Usuario FOREIGN KEY (UsuarioID) REFERENCES Usuario (ID)
);

CREATE TABLE Perfil (
	NombreCompleto VARCHAR(255) NOT NULL,
	Sexo VARCHAR(255),
	Telefono VARCHAR(255),
	FechaNacimiento DATE,
	Privado_Publico VARCHAR(255),
	Foto VARCHAR(255),
	UsuarioID INT NOT NULL,
	CONSTRAINT PK_Perfil PRIMARY KEY (NombreCompleto),
	CONSTRAINT FK_Perfil_Usuario FOREIGN KEY (UsuarioID) REFERENCES Usuario (ID)
);

CREATE TABLE Publicacion (
	ID INT NOT NULL,
	Contenido VARCHAR(255),
	CONSTRAINT PK_Publicacion PRIMARY KEY (ID)
);

CREATE TABLE Publica (
	Fecha DATE,
	UsuarioID INT NOT NULL,
	PublicacionID INT NOT NULL,
	CONSTRAINT FK_Publica_Usuario FOREIGN KEY(UsuarioID) REFERENCES Usuario (ID),
	CONSTRAINT FK_Publica_Publicacion FOREIGN KEY (PublicacionID) REFERENCES Publicacion (ID)
);

CREATE TABLE Comenta (
	UsuarioID1 INT NOT NULL,
	UsuarioID2 INT NOT NULL,
	PublicacionID INT NOT NULL,
	CONSTRAINT FK_Comenta_Usuario1 FOREIGN KEY(UsuarioID1) REFERENCES Usuario (ID),
	CONSTRAINT FK_Comenta_Usuario2 FOREIGN KEY(UsuarioID2) REFERENCES Usuario (ID),
	CONSTRAINT FK_Comenta_Publicacion FOREIGN KEY (PublicacionID) REFERENCES Publicacion (ID)
);

CREATE TABLE Contacto (
	UsuarioID1 INT NOT NULL,
	UsuarioID2 INT NOT NULL,
	Tipo VARCHAR(255),
	CONSTRAINT FK_Contacto_Usuario1 FOREIGN KEY(UsuarioID1) REFERENCES Usuario (ID),
	CONSTRAINT FK_Contacto_Usuario2 FOREIGN KEY(UsuarioID2) REFERENCES Usuario (ID)
);

CREATE TABLE Chat (
	UsuarioID1 INT NOT NULL,
	UsuarioID2 INT NOT NULL,
	Fecha DATE NOT NULL,
	Contenido VARCHAR(255),
	CONSTRAINT PK_Chat PRIMARY KEY (Fecha),
	CONSTRAINT FK_Chat_Usuario1 FOREIGN KEY(UsuarioID1) REFERENCES Usuario (ID),
	CONSTRAINT FK_Chat_Usuario2 FOREIGN KEY(UsuarioID2) REFERENCES Usuario (ID)
);

CREATE TABLE Multimedia (
	Codigo INT NOT NULL,
	Titulo VARCHAR(255),
	NombreArchivo VARCHAR(255),
	Descripcion VARCHAR(255),
	Fecha DATE,
	Tipo VARCHAR(255),
	Formato VARCHAR(255),
	Resolucion VARCHAR(255),
	Duracion TIME,
	CONSTRAINT PK_Multimedia PRIMARY KEY (Codigo)
);

CREATE TABLE Galeria (
	MultimediaCodigo INT NOT NULL,
	UsuarioID INT NOT NULL,
	CONSTRAINT FK_Galeria_Multimedia FOREIGN KEY(MultimediaCodigo) REFERENCES Multimedia (Codigo),
	CONSTRAINT FK_Galeria_Usuario FOREIGN KEY(UsuarioID) REFERENCES Usuario (ID)
);

CREATE TABLE Contiene (
	MultimediaCodigo INT NOT NULL,
	PublicacionID INT NOT NULL,
	TodoPublico VARCHAR(255),
	CONSTRAINT FK_Contiene_Multimedia FOREIGN KEY(MultimediaCodigo) REFERENCES Multimedia (Codigo),
	CONSTRAINT FK_Contiene_Publicacion FOREIGN KEY(PublicacionID) REFERENCES Publicacion (ID)
);


