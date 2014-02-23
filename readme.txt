Para ejecutar la aplicacion se debe hacer lo siguiente

1. Compilar los archivos con extension .oz para generarar los ozf

	ozc -c LeerArchivo.oz

	ozc -c Solver.oz

	ozc -c Distribuidor.oz

2. y se debe ejecutar el archivo principal (el que contiene la interfaz)


	ozc -x Aplicacion.oz -o Aplicacion

Luego se cargan los archivos de prueba (recordar que hay dos archivos con la informacion de los
barcos y de los muelles respectivamente).

