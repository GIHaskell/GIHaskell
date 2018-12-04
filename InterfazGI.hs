main :: IO ()
main=do
    putStrLn "Usuario\n"
    usr<-getLine
    putStrLn (usr++"\n")
    
    putStrLn "password\n"
    pass<-getLine
    putStrLn (pass++"\n")
    
    --No hacer prints y comparar con la base de datos
    
    putStrLn "Seleccione el tipo de pieza deseado\n"
    putStrLn(printTypes ["martillo", "tornillo", "tu prima"] 1)
    --if type==1 then print"
    do pruebaIO
    
    --principal:: IO ()
printTypes:: [String]->Int->String
printTypes (x:xs) n
    |(not (null xs))&&(n/=1)="()  "++x++"\n"++printTypes xs (n-1)
    |(not (null xs))&&(n==1)="(*) "++x++"\n"++printTypes xs (n-1)
    |(null xs)&&(n==1)="(*) "++x++"\n\n"
    |otherwise="()  "++x++"\n\n"
    --where contador=1;
    
printClasses::String
printClasses="\tnº\tid\tnombre\tfabricante\tid_tipo"

listaClases=["nº","id","nombre","fabricante","id_tipo"]

printClasses2::[String]->Int->String
printClasses2 (x:xs) n
    |(not (null xs))&&(n/=1)="()"++x++"\t"++printClasses2 xs (n-1)
    |(not (null xs))&&(n==1)="(*)"++x++"\t"++printClasses2 xs (n-1)
    |(null xs)&&(n==1)="(*)"++x
    |otherwise="()"++x
    
printSpecs::[String]->String
printSpecs (x:xs)
    |(not (null xs))=x++"\t"++printSpecs xs
    |(null xs)=x++"\n\n"
    --se puede aplicar map para printar lineas de todas las cosas seleccionadas, y un filter para el proceso de seleccion
    
pruebaIO :: IO ()
pruebaIO=do
    putStrLn(printClasses2 listaClases 2)
    putStrLn(printSpecs ["12","123","martillo","Avotillo","4"])
    putStrLn(printOperats)
    
printOperats:: String
printOperats= "i: insertar\tb: borrar\ta: actualizar\ts:salir\nS1: Select1\tS2:Select2"

    
