import qualified Usuario
import qualified TipoPiezas
import qualified Rol
import qualified Piezas
import qualified Permiso
import Data.Int (Int8, Int16, Int32, Int64)

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




printPiezas:: [String]->Int->Int->String
printPiezas [] n m= ""
printPiezas (x:xs) n m
    |(n/=1)="( ) "++(show m)++". "++x++"\n"++printPiezas xs (n-1) (m+1)
    |(n==1)="(*) "++(show m)++". "++x++"\n"++printPiezas xs (n-1) (m+1)


listToString::[String]->String--print calses normal
listToString [] = ""
listToString (x:xs)=x++"\t|| "++listToString xs

marcadorFila::[String]->Int->Int->[String]--Le pasas todos los datos y marca el seleccionado
marcadorFila [] n m= [""]
marcadorFila (x:xs) n m
    |(n==1)=["(*) "++(show m)++".\t||"++x]++(marcadorFila xs (n-1) (m+1))
    |(n/=1)=["( ) "++(show m)++".\t||"++x]++(marcadorFila xs (n-1) (m+1))


actualizarVista :: [Int]->[String]->String->IO ()--hay que ponerle 2 int
actualizarVista x y rol=do

    putStrLn "Piezas"
    piezas <- nombresTiposPiezas
    putStrLn(printPiezas piezas (head x) 1)
    putStrLn "Piezas del tipo seleccionado"

    putStrLn(listToString listaClases)

    codigoPieza <- (codigosTiposPiezas (head x))

    piezasQuery <- Piezas.listaPiezas
    let datosQuery = filter (\x -> (head (tail (tail (tail x))))==codigoPieza) piezasQuery

    if rol=="invitado" then
      putStrLn "No tiene permiso para ver piezas"
    else if (head x)==0 then
      putStrLn "Seleccione un tipo de piezas para mostrar su contenido"
    else
      printLista (marcadorFila (map listToString datosQuery) (getPosInt x 2) 1)

    let elemSeleccinado = getPosList datosQuery (getPosInt x 2)

    if ((getPosString y 1)=="") then
      putStrLn ("\nNombre:"++(getPosString elemSeleccinado 2))
    else
      putStrLn ("\nNombre:"++(getPosString y 1))

    if ((getPosString y 2)=="") then
      putStrLn ("Fabricante:"++(getPosString elemSeleccinado 3)++"\n")
    else
      putStrLn ("Fabricante:"++(getPosString y 2)++"\n")
    putStrLn(printOperats)

    putStrLn "\nSeleccione una operacion: "
    operacion<-getLine

    --if (elemSeleccinado /= []) then
    --    let idElemento = (getPosInt32 elemSeleccinado 1)
    --else
    --    let idElemento = 0
    let idElemento = (getPosInt32 elemSeleccinado 1)
    --putStrLn (show idElemento)
    do logica x y rol operacion idElemento codigoPieza


logica::[Int]->[String]->String->String->Int32->String->IO()
logica x y rol val idSeleccionado tipoSeleccionado
    |val=="i" = if rol == "administrador" then do
                  limpiar
                  Piezas.piezas (head y) (getPosString y 2) tipoSeleccionado
                  putStrLn "Insertando...\n\n"
                  actualizarVista [(head x), 0] ["",""] rol
                else do
                  limpiar
                  putStrLn "Necesita permisos de administrador para insertar...\n\n"
                  actualizarVista x y rol
    |val=="b" = if rol == "administrador" then do
                  limpiar
                  Piezas.delete idSeleccionado
                  putStrLn "Borrando seleccionado...\n\n"
                  actualizarVista [(head x), 0] ["",""] rol
                else do
                  limpiar
                  putStrLn "Necesita permisos de administrador para borrar...\n\n"
                  actualizarVista x y rol
    |val=="a" = if rol == "administrador" then do
                  limpiar
                  if ((head y)/="") then do
                    Piezas.setNombre idSeleccionado (head y)
                  else do
                    return ()
                  if ((getPosString y 2)/="") then do
                    Piezas.setFabricante idSeleccionado (getPosString y 2)
                  else do
                    return ()
                  putStrLn ("Actualizando valores de fila "++(show y)++"\n\n")
                  actualizarVista x ["",""] rol
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
        if seleccion=="" then do
          putStrLn "Valor no valido, volver a seleccionar operacion"
          operacion<-getLine
          logica x y rol operacion idSeleccionado tipoSeleccionado
        else
          return ()
        limpiar
        putStrLn ("Seleccionada tipo de pieza "++seleccion++"\n\n")
        actualizarVista [(read seleccion), 0] ["",""] rol
    |val=="s2" = do
        putStrLn "\nInserte indice de pieza a seleccionar:"
        seleccion<-getLine
        if seleccion=="" then do
          putStrLn "Valor no valido, volver a seleccionar operacion"
          operacion<-getLine
          logica x y rol operacion idSeleccionado tipoSeleccionado
        else
          return ()
        limpiar
        putStrLn ("Seleccionada pieza "++seleccion++"\n\n")
        actualizarVista [(head x),(read seleccion)] ["",""] rol
    |val=="n" = do
        putStrLn "\nInserte el nuevo nombre:"
        nombre<-getLine
        if nombre=="" then do
          putStrLn "Valor no valido, volver a seleccionar operacion"
          operacion<-getLine
          logica x y rol operacion idSeleccionado tipoSeleccionado
        else
          return ()
        limpiar
        putStrLn ("Actualizando nombre a: "++nombre++"\n\n")
        actualizarVista x [nombre, (getPosString y 2)] rol
    |val=="f" = do
        putStrLn "\nInserte el nuevo fabricante:"
        fabricante<-getLine
        if fabricante=="" then do
          putStrLn "Valor no valido, volver a seleccionar operacion"
          operacion<-getLine
          logica x y rol operacion idSeleccionado tipoSeleccionado
        else
          return ()
        limpiar
        putStrLn ("Actualizando fabricante a: "++fabricante++"\n\n")
        actualizarVista x [(getPosString y 1), fabricante] rol
    |val=="l" = do
        limpiar
        putStrLn ("Limpiando opciones...\n\n")
        actualizarVista [0,0] ["", ""] rol
    |otherwise = do
        putStrLn "\nComando desconocido, intentelo de nuevo:"
        operacion<-getLine
        logica x y rol operacion idSeleccionado tipoSeleccionado

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
  else if x<0 then
    return "error"
  else
    return (aux x tiposString)
      where
        aux 0 list = "Error"
        aux 1 list = (head list)
        aux x list = aux (x-1) (tail list)

getPosInt::[Int]->Int->Int
getPosInt [] _ = 0
getPosInt (x:xs) n
  |(n<0)=0
  |(n==1)=x
  |(n/=1)= getPosInt xs (n-1)

getPosInt32::[String]->Int32->Int32
getPosInt32 [] _ = 0
getPosInt32 (x:xs) n
  |(n<0)=0
  |(n==1)=(read x)
  |(n/=1)= getPosInt32 xs (n-1)

getPosString::[String]->Int->String
getPosString [] _ = ""
getPosString (x:xs) n
  |(n<0)= ""
  |(n==1)=x
  |(n/=1)= getPosString xs (n-1)

getPosList::[[String]]->Int->[String]
getPosList [] _ = []
getPosList (x:xs) n
  |(n<0)=[]
  |(n==1)=x
  |(n/=1)= getPosList xs (n-1)
