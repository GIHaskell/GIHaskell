printOperats= "i:insertar\tb:borrar\ta:actualizar\t\te:salir\ns1:Select Tipo\ts2:Select Pieza\tn:cambiar nombre\tf:cambiar fabricante"
listaClases=["    nº","id","nombre","fabricante","id_tipo"]
datosPrueba1=[["1","123","aaaa","Avotillo","4"], ["2","77","aaaaaa","Martilleante","4"],["3","64","aaaaaa","no u","4"],["4","234","aaaaaa","no","4"]]
datosPrueba2=[["2","77","bbbbbb","Martilleante","4"],["1","123","bbbbbb","Avotillo","4"],["3","64","bbbbbbb","no u","4"],["4","234","bbbbbbb","no","4"]]
datosPrueba3=[["3","64","cccccc","no u","4"],["4","234","cccccccc","no","4"], ["1","123","ccccccc","Avotillo","4"], ["2","77","cccccc","Martilleante","4"]]
tiposPiezas=["martillo", "tornillo", "tu prima"]


main :: IO ()
main=do
    putStrLn "Introduzca su nombre de usuario:"
    usr<-getLine
    --putStrLn (usr++"\n")

    putStrLn "Introduzca su password"
    pass<-getLine
    --putStrLn (pass++"\n")

    --No hacer prints y comparar con la base de datos



    --if type==1 then print"
    limpiar
    do actualizarVista [1, 0] ["nombre", "fabricante"]




--while:: (a->Bool) -> (a->IO a) -> a->IO a
--while cond funcion x
--    | cond x = do
--       y <-funcion x
--        while cond funcion y
--    | otherwise = return x
    --principal:: IO ()
printPiezas:: [String]->Int->String
printPiezas (x:xs) n
    |(not (null xs))&&(n/=1)="( ) "++x++"\n"++printPiezas xs (n-1)
    |(not (null xs))&&(n==1)="(*) "++x++"\n"++printPiezas xs (n-1)
    |(null xs)&&(n==1)="(*) "++x++"\n\n"
    |otherwise="( ) "++x++"\n\n"
    --where contador=1;




printCabecera::[String]->String--print calses normal
printCabecera (x:xs)
    |(not (null xs))=x++"\t"++printCabecera xs
    |otherwise=x

datosTabla::[String]->String--printa las specs(datos)
datosTabla (x:xs)
    |(not (null xs))=x++"\t"++datosTabla xs
    |otherwise=x++""
    --se puede aplicar map para printar lineas de todas las cosas seleccionadas, y un filter para el proceso de seleccion

marcadorFila::[String]->Int->[String]--Le pasas todos los datos y marca el seleccionado
marcadorFila (x:xs) n
    |(not (null xs))&&(n==1)=["(*) "++x]++(marcadorFila xs (n-1))
    |(not (null xs))&&(n/=1)=["( ) "++x]++(marcadorFila xs (n-1))
    |(null xs)&&(n==1)=["(*) "++x]
    |(null xs)&&(n/=1)=["( ) "++x]

actualizarVista :: [Int]->[String]->IO ()--hay que ponerle 2 int
actualizarVista x y=do

    putStrLn "Piezas"
    putStrLn(printPiezas tiposPiezas (head x))

    putStrLn "Piezas del tipo seleccionado"

    putStrLn(printCabecera listaClases)
    --putStrLn (head (marcadorFila [(datosTabla ["12","123","maza","Avotillo","4"])] y))
    --printLista (marcadorFila (map datosTabla datosPrueba1) y)
    if (head x)==1 then
      printLista (marcadorFila (map datosTabla datosPrueba1) (head (tail x)))
    else if (head x)==2 then
      printLista (marcadorFila (map datosTabla datosPrueba2) (head (tail x)))
    else if (head x)==3 then
      printLista (marcadorFila (map datosTabla datosPrueba3) (head (tail x)))
    else
      printLista (marcadorFila (map datosTabla datosPrueba1) (head (tail x)))
    putStrLn ("\nNombre:"++(head y))
    putStrLn ("Fabricante:"++(head (tail y))++"\n")
    putStrLn(printOperats)

    putStrLn "\nSeleccione una operacion: "
    operacion<-getLine
    do logica x y operacion


logica::[Int]->[String]->String->IO()
logica x y val
    |val=="i" = do
        limpiar
        putStrLn "Insertando...\n\n"
        actualizarVista [(head x), 0] y
    |val=="b" = do
        limpiar
        putStrLn "Borrando seleccionado...\n\n"
        actualizarVista [(head x), 0] y
    |val=="a" = do
        limpiar
        putStrLn ("Actualizando valores de fila "++(show y)++"\n\n")
        actualizarVista x y
    |val=="e" = do
        limpiar
        putStrLn "| |\n| |__  _   _  ___\n| '_ \\| | | |/ _ \\\n| |_) | |_| |  __/\n|_.__/ \\__, |\\___|\n        __/ |     \n       |___/     :D\n\n\n"
    |val=="s1" = do
        putStrLn "\nInserte indice de tipo de pieza a seleccionar:"
        seleccion<-getLine
        limpiar
        putStrLn ("Seleccionada tipo de pieza "++seleccion++"\n\n")
        actualizarVista [(read seleccion), 0] y
    |val=="s2" = do
        putStrLn "\nInserte indice de pieza a seleccionar:"
        seleccion<-getLine
        limpiar
        putStrLn ("Seleccionada pieza "++seleccion++"\n\n")
        actualizarVista [(head x),(read seleccion)] y
    |val=="n" = do
        putStrLn "\nInserte el nuevo nombre:"
        nombre<-getLine
        limpiar
        putStrLn ("Actualizando nombre a: "++nombre++"\n\n")
        actualizarVista x [nombre,(head (tail y))]
    |val=="f" = do
        putStrLn "\nInserte el nuevo fabricante:"
        fabricante<-getLine
        limpiar
        putStrLn ("Actualizando fabricante a: "++fabricante++"\n\n")
        actualizarVista x [(head y),fabricante]
    |otherwise = do
        putStrLn "\nComando desconocido, intentelo de nuevo:"
        operacion<-getLine
        logica x y operacion

limpiar:: IO()
limpiar= do putStrLn "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

printLista::[String]->IO()
printLista [] = do putStrLn ""
printLista (x:xs) = do
    putStrLn x
    printLista xs
