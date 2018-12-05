printOperats= "i:insertar\tb:borrar\ta:actualizar\t\ts:salir\nS1:Select1\tS2:Select2\tn:cambiar nombre\tf:cambiar fabricante"
listaClases=["    nº","id","nombre","fabricante","id_tipo"]

main :: IO ()
main=do
    putStrLn "Usuario"
    usr<-getLine
    --putStrLn (usr++"\n")
    
    putStrLn "password"
    pass<-getLine
    --putStrLn (pass++"\n")
    
    --No hacer prints y comparar con la base de datos
    
    
    
    --if type==1 then print"
    limpiar
    do actualizarVista 3 1
    
    
    
    
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
    |otherwise=x++"\n\n"
    --se puede aplicar map para printar lineas de todas las cosas seleccionadas, y un filter para el proceso de seleccion
    
marcadorFila::[String]->Int->[String]--Le pasas todos los datos y marca el seleccionado
marcadorFila (x:xs) n
    |(not (null xs))&&(n==1)=["(*) "++x]++(marcadorFila xs (n-1))
    |(not (null xs))&&(n/=1)=["( ) "++x]++(marcadorFila xs (n-1))
    |(null xs)&&(n==1)=["(*) "++x]
    |(null xs)&&(n/=1)=["( ) "++x]
    
actualizarVista :: Int->Int->IO ()--hay que ponerle 2 int
actualizarVista x y=do
    
    putStrLn "Piezas"
    putStrLn(printPiezas ["martillo", "tornillo", "tu prima"] x)
    
    putStrLn "Piezas del tipo seleccionado"
    
    putStrLn(printCabecera listaClases)
    putStrLn (head (marcadorFila [(datosTabla ["12","123","maza","Avotillo","4"])] y))  
    putStrLn "\nNombre:"--alasd
    putStrLn "Fabricante:\n"--asdasdasd
    putStrLn(printOperats)
    
    putStrLn "\nSeleccione una operacion: "
    operacion<-getLine
    do logica 2 1 operacion
    
    
logica::Int->Int->String->IO()
logica x y val
    |val=="i" = do
        limpiar
        putStrLn "Insertando...\n\n"
        actualizarVista x 0
    |val=="b" = do
        limpiar
        putStrLn "Borrando seleccionado...\n\n"
        actualizarVista x 0
    |val=="a" = do
        limpiar
        putStrLn ("Actualizando valores de fila "++(show y)++"\n\n")
        actualizarVista x 0
    |val=="s" =do
        limpiar
        putStrLn "| |\n| |__  _   _  ___\n| '_ \\| | | |/ _ \\\n| |_) | |_| |  __/\n|_.__/ \\__, |\\___|\n        __/ |     \n       |___/     :D\n\n\n"


limpiar:: IO()
limpiar= do putStrLn "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
