import qualified Usuario
import qualified TipoPiezas
import qualified Rol
import qualified Piezas
import qualified Permiso

--printOperats= "i:insertar\tb:borrar\ta:actualizar\ne:salir\t\ts1:Select Tipo\ts2:Select Pieza\nn:cambiar nombre\tf:cambiar fabricante\tl:Limpiar"
printOperats= "Operaciones:\ns1:Select Tipo\t s2:Select Pieza l:Limpiar\ni:insertar\t b:borrar\t a:actualizar\te:salir\nn:cambiar nombre f:cambiar fabricante"
listaClases=["    nº","id","nombre","fabricante","id_tipo"]
--datosPrueba1=[["1","123","aaaa","Avotillo","4"], ["2","77","aaaaaa","Martilleante","4"],["3","64","aaaaaa","no u","4"],["4","234","aaaaaa","no","4"]]
--datosPrueba2=[["2","77","bbbbbb","Martilleante","4"],["1","123","bbbbbb","Avotillo","4"],["3","64","bbbbbbb","no u","4"],["4","234","bbbbbbb","no","4"]]
--datosPrueba3=[["3","64","cccccc","no u","4"],["4","234","cccccccc","no","4"], ["1","123","ccccccc","Avotillo","4"], ["2","77","cccccc","Martilleante","4"]]
--tiposPiezas=["martillo", "tornillo", "tu prima"]


main :: IO ()
main=do
    putStrLn "Introduzca su nombre de usuario:"
    usr<-getLine

    putStrLn "Introduzca su password"
    pass<-getLine
    usuarios<-Usuario.listaUsuario

    limpiar
    let rol = checkUsuarios usr pass usuarios
    if (rol /= "") then
      do actualizarVista [0, 0] ["", ""] rol
    else
      putStrLn "Log in erroneo"




printPiezas:: [String]->Int->String
printPiezas [] n = ""
printPiezas (x:xs) n
    |(not (null xs))&&(n/=1)="( ) "++x++"\n"++printPiezas xs (n-1)
    |(not (null xs))&&(n==1)="(*) "++x++"\n"++printPiezas xs (n-1)
    |(null xs)&&(n==1)="(*) "++x++"\n\n"
    |otherwise="( ) "++x++"\n\n"





printCabecera::[String]->String--print calses normal
printCabecera [] = ""
printCabecera (x:xs)
    |(not (null xs))=x++"\t"++printCabecera xs
    |otherwise=x

datosTabla::[String]->String--printa las specs(datos)
datosTabla [] = ""
datosTabla (x:xs)
    |(not (null xs))=x++"\t"++datosTabla xs
    |otherwise=x++""
    --se puede aplicar map para printar lineas de todas las cosas seleccionadas, y un filter para el proceso de seleccion

marcadorFila::[String]->Int->[String]--Le pasas todos los datos y marca el seleccionado
marcadorFila [] n = [""]
marcadorFila (x:xs) n
    |(not (null xs))&&(n==1)=["(*) "++x]++(marcadorFila xs (n-1))
    |(not (null xs))&&(n/=1)=["( ) "++x]++(marcadorFila xs (n-1))
    |(null xs)&&(n==1)=["(*) "++x]
    |otherwise=["( ) "++x]

actualizarVista :: [Int]->[String]->String->IO ()--hay que ponerle 2 int
actualizarVista x y rol=do

    putStrLn "Piezas"
    piezas <- nombresTiposPiezas
    putStrLn(printPiezas piezas (head x))
    putStrLn "Piezas del tipo seleccionado"

    putStrLn(printCabecera listaClases)

    codigoPieza <- (codigosTiposPiezas (head x))

    piezasQuery <- Piezas.listaPiezas
    let datosQuery = filter (\x -> (head (tail (tail (tail x))))==codigoPieza) piezasQuery

    if rol=="invitado" then
      putStrLn "No tiene permiso para ver piezas"
    else if (head x)==0 then
      putStrLn "Seleccione un tipo de piezas para mostrar su contenido"
    else
      printLista (marcadorFila (map datosTabla datosQuery) (head (tail x)))
    putStrLn ("\nNombre:"++(head y))
    putStrLn ("Fabricante:"++(head (tail y))++"\n")
    putStrLn(printOperats)

    putStrLn "\nSeleccione una operacion: "
    operacion<-getLine
    do logica x y rol operacion


logica::[Int]->[String]->String->String->IO()
logica x y rol val
    |val=="i" = if rol == "administrador" then do
                  limpiar
                  putStrLn "Insertando...\n\n"
                  actualizarVista [(head x), 0] y rol
                else do
                  limpiar
                  putStrLn "Necesita permisos de administrador para insertar...\n\n"
                  actualizarVista x y rol
    |val=="b" = if rol == "administrador" then do
                  limpiar
                  putStrLn "Borrando seleccionado...\n\n"
                  actualizarVista [(head x), 0] y rol
                else do
                  limpiar
                  putStrLn "Necesita permisos de administrador para borrar...\n\n"
                  actualizarVista x y rol
    |val=="a" = if rol == "administrador" then do
                  limpiar
                  putStrLn ("Actualizando valores de fila "++(show y)++"\n\n")
                  actualizarVista x y rol
                else do
                  limpiar
                  putStrLn "Necesita permisos de administrador para actualizar...\n\n"
                  actualizarVista x y rol
    |((val=="e") || (val=="q")) = do
        limpiar
        putStrLn "| |\n| |__  _   _  ___\n| '_ \\| | | |/ _ \\\n| |_) | |_| |  __/\n|_.__/ \\__, |\\___|\n        __/ |     \n       |___/     :D\n\n\n"
    |val=="s1" = do
        putStrLn "\nInserte indice de tipo de pieza a seleccionar:"
        seleccion<-getLine
        limpiar
        putStrLn ("Seleccionada tipo de pieza "++seleccion++"\n\n")
        actualizarVista [(read seleccion), 0] y rol
    |val=="s2" = do
        putStrLn "\nInserte indice de pieza a seleccionar:"
        seleccion<-getLine
        limpiar
        putStrLn ("Seleccionada pieza "++seleccion++"\n\n")
        actualizarVista [(head x),(read seleccion)] y rol
    |val=="n" = do
        putStrLn "\nInserte el nuevo nombre:"
        nombre<-getLine
        limpiar
        putStrLn ("Actualizando nombre a: "++nombre++"\n\n")
        actualizarVista x [nombre,(head (tail y))] rol
    |val=="f" = do
        putStrLn "\nInserte el nuevo fabricante:"
        fabricante<-getLine
        limpiar
        putStrLn ("Actualizando fabricante a: "++fabricante++"\n\n")
        actualizarVista x [(head y),fabricante] rol
    |val=="l" = do
        limpiar
        putStrLn ("Limpiando opciones...\n\n")
        actualizarVista [0,0] ["",""] rol
    |otherwise = do
        putStrLn "\nComando desconocido, intentelo de nuevo:"
        operacion<-getLine
        logica x y rol operacion

limpiar:: IO()
limpiar= do putStrLn "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

printLista::[String]->IO()
printLista [] = do putStrLn ""
printLista (x:xs) = do
    putStrLn x
    printLista xs

checkUsuarios::String->String->[[String]]->String
checkUsuarios user pass [] = ""
checkUsuarios user pass (x:xs)
  |((head x)==user)&&((head (tail x))==pass) = (head (tail (tail x)))
  |otherwise = checkUsuarios user pass xs

nombresTiposPiezas::IO [String]
nombresTiposPiezas = do
  tipos <- TipoPiezas.listaTipoPiezas
  let tiposString = (map head (map tail tipos))
  return tiposString

codigosTiposPiezas::Int->IO String
codigosTiposPiezas x = do
  tipos <- TipoPiezas.listaTipoPiezas
  let tiposString = (map head tipos)
  if x > (length tiposString) then
    return "Error"
  else
    return (aux x tiposString)
      where
        aux 0 list = "Error"
        aux 1 list = (head list)
        aux x list = aux (x-1) (tail list)
