%%%%%%%%%%%%%%%%%%    Distribuidor    %%%%%%%%%%%%%%%%%%
% Planeacion Automatica de Horas de Descarga Para un puerto Naval Comercial
%
% Michell Guzman Cancimance
% Cod. 0910016
%
% Este Distribuidor utiliza una estrategia de distribucion basada en Naive
% En la cual se escoge la variable a distribuir que tiene el menor dominio
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

functor

import

   FD
   Space

export

   Distribuidor

define
       proc {Distribuidor ListaMuelles}
	  {Space.waitStable}
	  local
	     % Calcula los dominios que no son valuacion
	     Fs={Filter ListaMuelles fun {$ I} {FD.reflect.size I}>1 end}
	  in
	     case Fs
	     of nil then skip
	     % En M almacena el valor del dominio de menor tamanio 
	     [] F|Fr then M={FD.reflect.min F} in
		choice F=M   {Distribuidor Fr}
		[]     F\=:M {Distribuidor Fs}
		end
	     end
	  end
       end
end






		  
		  
		  
	       
	 