%%%%%%%%%%%%%%%%%% Restricciones a satisfacer %%%%%%%%%%%%%%%%%%
% Planeacion Automatica de Horas de Descarga Para un puerto Naval Comercial
%
% Michell Guzman Cancimance
% Cod. 0910016
%
% Script que contiene las restricciones basicas de la aplicacion.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functor

import

   FD
  % Browser
   Distribuidor

export

   Solucionar

define
   

   fun{Solucionar InfoBarcos InfoMuelles}


     % variables a utilizar
     


      % Funcion auxiliar isMember que me devuelve true o false
      % si un elemento pertenece a una lista o no
      fun{Member E Xs} case Xs
		       of nil then false
		       [] X|Xr then
			  if X==E then true else {Member E Xr} end
		       end
      end  

   in
        

      proc{$ Solucion}

	 ListaMuelles      
	 ListaHoras
	 TuplaMuelles
	 TuplaHoras
	 H = InfoBarcos.horas
	 N = InfoBarcos.cantidadB
	 M = InfoMuelles.cantidadM
	 Barcos = InfoBarcos.barcos 
	 Muelles = InfoMuelles.muelles
	

	 
 	

      in
	 
         % Tuplas que van a representar los muelles, los barcos y la tupla que va a
         % contener la solucion del problema	 
	 Solucion = {MakeTuple solucion N}
	 TuplaMuelles = {MakeTuple muelles N}
	 TuplaHoras = {MakeTuple barcos N}

      

        % Creo una tupla de barcos
	 for I in 1..N do	
	    Solucion.I = {MakeTuple barco 2}
	    Solucion.I.1::1#M  % Todos los barcos son atendidos
	    Solucion.I.2::1#H	
	 end






 	%  for I in 1..N do
%  	    Rtiempo := (Barcos.I.2.1 + Barcos.I.2.3)
%  	    for J in 1..M do
%  	       for K in 1..H do     
		 
%  		  if {List.member {List.nth Muelles.J.2 K} Barcos.I.2.2} then
%  		     Celda := @Celda + 1	     
%  		     Cont := @Cont + 1
%  		  else
%  		     Celda := 0
%  		     Cont := @Cont + 1
%  		  end		

%  		  if @Celda == Rtiempo then
%  		     skip
%  		  else
%  		     if @Cont == H then
%  			Solucion.I.1 \=: J
%  		     end
%  		  end	
%  	       end      
%  	    end    
% 	 end
	 %%
	 



        % Restriccion que me garantiza que el estado de tiempo y de marea de un muelle en
	% durante el rango de tiempo en el que llego hasta que me voy debe coincidir con
	% la lista de estado de tiempo y de marea del barco en particular
   	  thread
   	    for I in 1..N do
   	       for J in 1..M do
		  for K in (Solucion.I.2)..(Barcos.I.2.1 + Barcos.I.2.3 + Solucion.I.2) do
		    {List.member {List.nth Muelles.J.2 K} Barcos.I.2.2 true}
		    {List.member {List.nth Muelles.J.3 K} Barcos.I.3 true} 		   
  		  end  
  	       end
  	    end
	  end

	  

	  % Restriccion que garantiza de que si dos barcos tienen el mismo tiempo de llegada
	  % al puerto, entonces sus muelles deben ser diferentes
	   thread
    	    for I in 1..N do
    	       for J in 1..N do
    		  if {Bool.and (Solucion.I.2 == Solucion.J.2) (I \= J)} then
    		     Solucion.I.1 \=: Solucion.J.1
 		  end
    	       end
 	    end
	   end
	 


	   % Restriccion que me garantiza que se respete el tiempo de demora de descarga
	   % de cada barco
	    thread
	      for I in 1..N do
		 for J in 1..N do
		    if {Bool.and (Solucion.I.1 == Solucion.J.1) (I \= J)} then
		       {FD.disjoint Solucion.I.2 Barcos.I.2.3 Solucion.J.2 Barcos.J.2.3}     
		    end
		 end
	      end
	   end

 % ((Barcos.I.2.3 + Solucion.J.2) - (Barcos.J.2.1 + Solucion.I.2)) =<: 1


        %Se crea la tupla de muelles y la tupla de horas a distribuir
	 for I in 1..N do
	    TuplaMuelles.I = Solucion.I.1
	    TuplaHoras.I = Solucion.I.2
	 end 	
	
	 
   	       


         %Se pasan la tupla de muelles y horas a listas a distribuir
	 {Record.toList TuplaMuelles ListaMuelles}
	 {Record.toList TuplaHoras ListaHoras}

	 
	 

         %Se realiza la distribucion por horas y luego por muelles	 
	 {Distribuidor.distribuidor ListaHoras}
	 {Distribuidor.distribuidor ListaMuelles}
	 
	
	
      end
   end
end





      