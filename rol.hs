{-# LANGUAGE OverloadedStrings #-}

module Rol where

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
 print "Modulo de mapeo de Rol"

type NombreRolOriginal = String
type NombreRol = String
type DescripcionRol = String
type AdminRol = Int8

rol :: NombreRol -> DescripcionRol -> AdminRol -> IO()
rol rolName rolDes admin = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  withTransaction conn $ executeMany conn "INSERT INTO tRol VALUES (\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack rolName,
           MySQLText $ T.pack rolDes,
           MySQLInt8  admin]]
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tRol"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs


listaRoles :: IO [[String]]
listaRoles = do
    conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
  
    (defs, is) <- query_ conn "SELECT * FROM tRol"
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

  updStmt <- prepareStmt conn "UPDATE tRol SET rolName = ? WHERE rolName = ? "
  
  executeStmt conn updStmt [MySQLText (T.pack rolName),MySQLText (T.pack pk)]

  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tRol"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs

setRolDes :: NombreRolOriginal -> DescripcionRol -> IO()
setRolDes pk rolDes = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                     ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
  
  updStmt <- prepareStmt conn "UPDATE tRol SET rolName = ? WHERE rolName = ? "
    
  executeStmt conn updStmt [MySQLText (T.pack password),MySQLText (T.pack pk)]
  
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tRol"
  --xs <- Streams.toList is
  --let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print rs

 

delete :: NombreRolOriginal -> IO()
delete pk = do 
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}
    
  delStmt <- prepareStmt conn "DELETE FROM tRol WHERE rolName = ? "
      
  executeStmt conn delStmt [MySQLText (T.pack pk)]
    
  print "Transaccion realizada"
  --(defs, is) <- query_ conn "SELECT * FROM tRol"
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
  
