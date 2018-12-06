{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.MySQL.Base
import Database.MySQL.BinLog
import qualified System.IO.Streams as Streams
import qualified Data.Text as T
import Data.Maybe
import Data.Int (Int8, Int16, Int32, Int64)
import Data.Char

servidorBD = "jfaldanam.ddns.net"
usuarioBD = "usuario"
passwordBD = "password"
databaseDB = "GIHaskell"
puertoBD = 3306

main = do
 print "Modulo de insercion"


usuario :: String -> String -> String -> IO()
usuario nom pass rol = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  withTransaction conn $ executeMany conn "INSERT INTO tUsuario VALUES (\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack nom,
           MySQLText $ T.pack pass,
           MySQLText $ T.pack rol]]
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tUsuario"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs

rol :: String -> String -> Int8 -> IO()
rol nombre descripcion admin = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  withTransaction conn $ executeMany conn "INSERT INTO tRol VALUES (\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack nombre,
           MySQLText $ T.pack descripcion,
           MySQLInt8 admin]]
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tRol"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs


permiso :: String -> String -> Int8 -> Int8 -> IO()
permiso nombre pantalla acceso modificacion = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
  
  withTransaction conn $ executeMany conn "INSERT INTO tPermiso VALUES (\
          \?  ,\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack nombre,
            MySQLText $ T.pack pantalla,
            MySQLInt8 acceso,
            MySQLInt8 modificacion]]
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tPermiso"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs  

piezas :: Int32 -> String -> String -> String -> IO()
piezas id nombre fabricante idTipo = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
  
  withTransaction conn $ executeMany conn "INSERT INTO tPiezas VALUES (\
          \?  ,\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLInt32 id,
            MySQLText $ T.pack nombre,
            MySQLText $ T.pack fabricante,
            MySQLText $ T.pack  idTipo]]
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tPiezas"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs  

tipoPieza :: String -> String -> IO()
tipoPieza idTipo nombre = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
  
  withTransaction conn $ executeMany conn "INSERT INTO tTipoPieza VALUES (\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack idTipo,
            MySQLText $ T.pack nombre]]
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tTipoPieza"
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
  