%%%%%%%%%%%%%%%%%%    Lectura del Archivo    %%%%%%%%%%%%%%%%%%
% Planeacion Automatica de Horas de Descarga Para un puerto Naval Comercial
%
% Michell Guzman Cancimance
% Cod. 0910016
%
% Script que contiene los datos de entrada, obtenidos desde el archivo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor

import

   Open

export

   LeerArchivoBarcos
   LeerArchivoMuelles
   
define
   

   class TextFile from Open.file Open.text end


   % Se lee la informacion de entrada del archivo InfoBarcos, que contiene la
   % informacion de los barcos
   fun {LeerArchivoBarcos NombreArchivo}

      F
      Barcos
      InfoBarcos
      N
      H

      fun{LeerEntero}
	 Cadena H
      in
	 Cadena = {String.tokens {F getS($)} 32}
	 H = {String.toInt Cadena.2.1}
	 H
      end

      fun{LeerNumeroBarcos}
	 Cadena N
      in
	 Cadena  = {String.tokens {F getS($)} 32}
	 N = {String.toInt Cadena.2.1}
	 N
      end      
      

      fun {LeerListas}
	 Lista1  Tupla1 Tupla2 Lista2
      in
	 Lista1 = {String.tokens {F getS($)} 32}
	 {List.toTuple li Lista1 Tupla1}
	 Tupla2 =  {MakeTuple tupl  {List.length Lista1}}
	 for I in 1..{List.length Lista1} do
	    Tupla2.I =  {String.toInt Tupla1.I}
	 end
	 {Record.toList Tupla2 Lista2}   

	 Lista2
      end

      fun {LeerDescripcion}
	 TiempoMax Estado Demora Tupla
      in
	 TiempoMax = {LeerEntero}
	 Estado = {LeerListas}
	 Demora = {LeerEntero}

	 Tupla = {MakeTuple descripcion 3}
	 Tupla.1 = TiempoMax
	 Tupla.2 = Estado
	 Tupla.3 = Demora

	 Tupla
      end
      

   

   in
      
      F={New TextFile init(name:NombreArchivo)}
      

      H = {LeerEntero} % Leer la hora   
      N = {LeerNumeroBarcos}
      Barcos = {MakeTuple barcos N}
 




      for K in 1..N do
	 Barcos.K = {MakeTuple ship 3}
      end


      for J in 1..N do
	 Barcos.J.1 = {LeerEntero} 
	 Barcos.J.2 = {LeerDescripcion}
	 Barcos.J.3 = {LeerListas} 
      end

      InfoBarcos = infoBarcos(cantidadB:N barcos:Barcos horas:H)

      InfoBarcos
   
  
   end


   % Se lee los parametros de entrada del archivo InfoMuelles, que contiene
   % la informacion de los muelles
   fun {LeerArchivoMuelles NombreArchivo}
      

      F
      Muelles
      InfoMuelles
     
      M
      

      fun{LeerNumeroMuelles}
	 Cadena M
      in
	 Cadena = {String.tokens {F getS($)} 32}
	 M = {String.toInt Cadena.2.1}
	 M
      end


      fun {LeerListas}
	 Lista1  Tupla1 Tupla2 Lista2
      in
	 

	 Lista1 = {String.tokens {F getS($)} 32}
	 {List.toTuple li Lista1 Tupla1}
	 Tupla2 =  {MakeTuple tupl  {List.length Lista1}}
	 for I in 1..{List.length Lista1} do
	    Tupla2.I =  {String.toInt Tupla1.I}
	 end
	 {Record.toList Tupla2 Lista2}   

	 Lista2   
      end
   

   in      

      F={New TextFile init(name:NombreArchivo)}
      

      M = {LeerNumeroMuelles}
      Muelles = {MakeTuple muelles M}


      for K in 1..M do
	 Muelles.K = {MakeTuple muelle 3}
      end



      for J in 1..M do  
	 Muelles.J.1 = {LeerNumeroMuelles}
	 Muelles.J.2 = {LeerListas}
	 Muelles.J.3 = {LeerListas}
      end


      InfoMuelles = infoMuelles(cantidadM:M muelles:Muelles)
      InfoMuelles


   end
end

