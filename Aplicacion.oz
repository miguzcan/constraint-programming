%%%%%%%%%%%%%%%%%%    Script Principal    %%%%%%%%%%%%%%%%%%
% Planeacion Automatica de Horas de Descarga Para un puerto Naval Comercial
%
% Michell Guzman Cancimance
% Cod. 0910016
%
% Script Principal que contiene la interfaz grafica, y que realiza el llamado
% a los diferentes functors de la aplicacion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
functor
   
import
   QTk at 'x-oz://system/wp/QTk.ozf'
   Application
   LeerArchivo
   Solver
   Explorer
   
   
define
   
   proc{HacerVentana}

      D
      Toolbar
      InfoBarcos
      InfoMuelles
    

      % Procedimiento para cargar los Barcos
      proc{CargarArchivoBarcos}
	 Nombre = {QTk.dialogbox load($)}
      in
	 if Nombre \= nil then {InfoBarcos set(Nombre)} end	 
      end

      % Procedimiento para cargar los Muelles
      proc{CargarArchivoMuelles}
	 Nombre = {QTk.dialogbox load($)}
      in
	 if Nombre \= nil then {InfoMuelles set(Nombre)} end
      end

      % Procedimiento encargado de buscar la solucion
      proc{PrepararYSolucionar}
	 IBarcos
	 IMuelles
      in
	 IBarcos = {LeerArchivo.leerArchivoBarcos {InfoBarcos get($)}}
	 IMuelles = {LeerArchivo.leerArchivoMuelles{InfoMuelles get($)}}

	 {Explorer.object one({Solver.solucionar IBarcos IMuelles})}
      end

   in

      Toolbar = td(lr(label(text:"Informacion de Barcos:")
		      entry(glue:we handle:InfoBarcos width:40)		      
		      button(text:"..." glue:w action:CargarArchivoBarcos))
		   lr(label(init:""))
		   lr(label(text:"Informacion de Muelles:")		     
		      entry(glue:we handle:InfoMuelles width:40)
		      button(text:"..." glue:w action:CargarArchivoMuelles))
		   lr(label(init:""))
		   button(text:"Solucionar" glue:w action:PrepararYSolucionar))


      D = td(Toolbar
	    button(text:"Salir" glue:w action:proc{$} {Application.exit 0}end))
      
     {{QTk.build D} show}

%       Titulo = {QTk.build D}
%       {Titulo set(title:"Planeacion para un puerto naval")}
%       {Titulo show} 


      
   end
   
   {HacerVentana}
end