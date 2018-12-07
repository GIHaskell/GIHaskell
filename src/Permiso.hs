{-# LANGUAGE OverloadedStrings #-}

module Permiso where

import Database.MySQL.Base
import Database.MySQL.BinLog
import qualified System.IO.Streams as Streams
import qualified Data.Text as T
import Data.Maybe
import Data.Int (Int8, Int16, Int32, Int64)
import Data.Char
import qualified Insert

servidorBD = "jfaldanam.ddns.net"
usuarioBD = "usuario"
passwordBD = "password"
databaseDB = "GIHaskell"
puertoBD = 3306

main = do
 print "Modulo de mapeo de Permiso"

type NombreRolOriginal = String
type NombreRol = String
type PantallaPermiso = String
type AccesoPermiso = Int8
type ModificacionPermiso = Int8
 
permiso :: NombreRol -> PantallaPermiso -> AccesoPermiso -> ModificacionPermiso -> IO()
permiso rolName pantalla acceso modificacion = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                  ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
 
  withTransaction conn $ executeMany conn "INSERT INTO tPermiso VALUES (\
          \?  ,\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack rolName,
          MySQLText $ T.pack pantalla,
          MySQLInt8  acceso,
          MySQLInt8  modificacion]]
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tPermiso"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs
 
 
listaPermisos :: IO [[String]]
listaPermisos = do
    conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
   
    (defs, is) <- query_ conn "SELECT * FROM tPermiso"
    xs <- Streams.toList is
    let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
    --print xs
    --putStrLn rs
    return rs
 
setRolName :: NombreRolOriginal -> NombreRol -> IO()
setRolName pk rolName = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                  ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
 
  updStmt <- prepareStmt conn "UPDATE tPermiso SET rolName = ? WHERE rolName = ? "
   
  executeStmt conn updStmt [MySQLText (T.pack rolName),MySQLText (T.pack pk)]
 
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tPermiso"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs
 
setPantalla :: NombreRolOriginal -> PantallaPermiso -> IO()
setPantalla pk pantalla = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
   
  updStmt <- prepareStmt conn "UPDATE tPermiso SET pantalla = ? WHERE rolName = ? "
     
  executeStmt conn updStmt [MySQLText (T.pack pantalla),MySQLText (T.pack pk)]
   
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tPermiso"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs
 
 
setAcceso :: NombreRolOriginal -> AccesoPermiso -> IO()
setAcceso pk acceso = do
  conn <- connect
       ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
   
   updStmt <- prepareStmt conn "UPDATE tPermiso SET acceso = ? WHERE rolName = ? "
     
   executeStmt conn updStmt [MySQLInt8 acceso,MySQLText (T.pack pk)]
   
   print "Transaccion realizada"
   --(defs, is) <- query_ conn "SELECT * FROM tPermiso"
   --xs <- Streams.toList is
   --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
   --print rs

setModificacion :: NombreRolOriginal -> ModificacionPermiso -> IO()
setModificacion pk modificacion = do
  conn <- connect
       ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
   
   updStmt <- prepareStmt conn "UPDATE tPermiso SET modificacion = ? WHERE rolName = ? "
     
   executeStmt conn updStmt [MySQLInt8 modificacion,MySQLText (T.pack pk)]
   
   print "Transaccion realizada"
   --(defs, is) <- query_ conn "SELECT * FROM tPermiso"
   --xs <- Streams.toList is
   --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
   --print rs

delete :: NombreRolOriginal -> IO()
delete pk = do 
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
     
  delStmt <- prepareStmt conn "DELETE FROM tPermiso WHERE rolName = ? "
       
  executeStmt conn delStmt [MySQLText (T.pack pk)]
     
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tPermiso"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs
     
       
 
getString :: MySQLValue -> String
getString (MySQLText text) = T.unpack text
getString (MySQLInt8 value) = show (fromInt8ToInt value)
getString (MySQLInt32 value) = show (fromInt32ToInt value)
getString (MySQLNull) = ""
   
fromInt8ToInt :: Int8 -> Int
fromInt8ToInt n = fromIntegral n
   
fromInt32ToInt :: Int32 -> Int
fromInt32ToInt n = fromIntegral n
   
