/* 1 Listar cual(es) día(s) los usuarios AnnieS y ZackW conversaron acerca de MySQL, listar el
contenido de la información. La lista debe estar ordenada cronológicamente.*/

(SELECT C.Fecha, C.Contenido AS Conversaciones_de_MySQL_entre_AnnieS_y_ZackW
FROM Usuario AS U1, Chat AS C, Usuario AS U2 
WHERE U1.ID = C.UsuarioID1 AND
	  U2.ID = C.UsuarioID2 AND
	  U1.NombreUsuario LIKE 'AnnieS' AND
	  U2.NombreUsuario LIKE 'ZackW' AND
	  C.contenido LIKE '%MySQL%')	  
UNION	  
(SELECT CH.Fecha, CH.Contenido
FROM Usuario AS US1, Chat AS CH, Usuario AS US2 
WHERE US1.ID = CH.UsuarioID2 AND
	  US2.ID = CH.UsuarioID1 AND
	  US1.NombreUsuario LIKE 'AnnieS' AND
	  US2.NombreUsuario LIKE 'ZackW' AND
	  CH.contenido LIKE '%MySQL%')
ORDER BY Fecha ASC;
	
/* 2 Listar los primeros 7 usuarios registrados en Twitter en Mayo 2015.*/

(SELECT ID, NombreUsuario AS 7_primeros_usuarios_registrados_en_twitter
FROM Usuario
WHERE NombreRedSocial LIKE 'Twitter' AND
      FechaRegistro BETWEEN '2015/05/01' AND '2015/05/31'	
LIMIT 7
);	

/* 3 Dado el fundador Mark Zuckerberg, muestre los usuarios que tienen más de 10 contactos
en la red social Facebook.*/

(SELECT U.NombreUsuario AS Usuarios_con_mas_de_10_contactos_en_facebook
FROM Usuario AS U, Contacto AS C
WHERE U.NombreRedSocial LIKE 'Facebook' AND
	  (U.ID=C.UsuarioID1 OR U.ID=C.UsuarioID2) 
GROUP BY NombreUsuario
HAVING Count(*)>10
);	    

/* 4 Listar por red social las redes sociales con las cuales se encuentra interrelacionada,
indicando el creador de cada red social.*/

(SELECT I.NombreRedSocial1 AS Red_Social, I.NombreRedSocial2 AS Relacionada_con, A.NombreFundador AS Fundador   
FROM Administra AS A, Interrelaciona AS I
WHERE A.NombreRedSocial = I.NombreRedSocial1
);

/* 5 Listar la foto con la mayor cantidad de comentarios y el usuario que publicó dicha foto. */

(SELECT M.NombreArchivo AS Foto_con_mas_comentarios, U.NombreUsuario AS Publicada_por
FROM Multimedia AS M, Contiene AS C, Comenta AS Co, Publica AS P, Usuario AS U
WHERE M.Codigo= C.MultimediaCodigo AND
	  C.PublicacionID = Co.PublicacionID AND
	  C.PublicacionID = P.PublicacionID AND
	  M.Tipo LIKE 'Foto' AND
	  U.ID=P.UsuarioID
GROUP BY C.PublicacionID
ORDER BY Count(C.PublicacionID) DESC
LIMIT 1
); 

/*6 Mostrar la información de los primeros 4 usuarios que se encuentren registrados en todas
las redes sociales del sistema, ordenados alfabéticamente por el nombre de usuario. */
	
(SELECT U.ID, U.NombreUsuario, U.Correo, U.ContrasenaEncriptada, U.FechaRegistro
FROM Usuario AS U, RedSocial AS R
WHERE U.NombreRedSocial = R.Nombre
GROUP BY U.NombreUsuario
HAVING Count(U.NombreRedSocial) = (Select Count(*) From Redsocial))
ORDER BY U.NombreUsuario
LIMIT 4;

/*7. Listar los videos que tienen una duración mayor a la duración promedio de los videos en el
sistema y han sido publicados en el 2014.*/

SELECT M.NombreArchivo
FROM Multimedia as M
WHERE M.Fecha between '2014/01/01' and '2014/12/31' and
	  M.Tipo like 'Video' and
	  M.Duracion > (Select AVG(Duracion) From Multimedia);			
				  
/*8. Listar nombre de usuario y correo de los usuarios que han publicado más publicaciones
que el promedio de los usuarios, listar también el contenido de la publicación.*/
				  
SELECT U.NombreUsuario, U.Correo, P.Contenido
FROM Usuario as U, Publicacion as P, Publica as Pu
WHERE U.ID = Pu.UsuarioID and
	  P.ID= Pu.PublicacionID
GROUP BY Pu.UsuarioID
HAVING count(Pu.Fecha) > 0;


/*9. Listar los usuarios que tengan en la galería un multimedia con descripción #Like4Like
#NoFilter #CopaAmerica.*/

SELECT U.NombreUsuario
FROM Usuario as U, Multimedia as M, Galeria as G
WHERE U.ID = G.UsuarioID and
	  M.Codigo = G.MultimediaCodigo and
	  (M.Descripcion Like '%#Like4Like%' or
	   M.Descripcion Like '%#NoFilter' or
	   M.Descripcion Like '%#CopaAmerica%')
GROUP BY U.NombreUsuario;	   