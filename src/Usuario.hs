{-# LANGUAGE OverloadedStrings #-}

module Usuario where

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
 print "Modulo de actualizacion de Usuario"

type NombreUsuarioOriginal = String
type NombreUsuario = String
type PasswordUsuario = String
type RolNameUsuario = String

usuario :: NombreUsuario -> PasswordUsuario -> RolNameUsuario -> IO()
usuario nombre password rolName = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  withTransaction conn $ executeMany conn "INSERT INTO tUsuario VALUES (\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack nombre,
           MySQLText $ T.pack password,
           MySQLText $ T.pack rolName]]
  aux <- close conn
  print "Transaccion realizada"



listaUsuario :: IO [[String]]
listaUsuario = do
    conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

    (defs, is) <- query_ conn "SELECT * FROM tUsuario"
    
    xs <- Streams.toList is
    let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
    aux <- close conn
    return rs

setNombre :: NombreUsuarioOriginal -> NombreUsuario -> IO()
setNombre pk nombre = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tUsuario SET nombre = ? WHERE nombre = ? "

  executeStmt conn updStmt [MySQLText (T.pack nombre),MySQLText (T.pack pk)]
  aux <- close conn
  print "Transaccion realizada"


setPassword :: NombreUsuarioOriginal -> PasswordUsuario -> IO()
setPassword pk password = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                     ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tUsuario SET password = ? WHERE nombre = ? "

  executeStmt conn updStmt [MySQLText (T.pack password),MySQLText (T.pack pk)]
  aux <- close conn
  print "Transaccion realizada"


setRolName :: NombreUsuarioOriginal -> RolNameUsuario -> IO()
setRolName pk rolName = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tUsuario SET rolName = ? WHERE nombre = ? "

  executeStmt conn updStmt [MySQLText (T.pack rolName),MySQLText (T.pack pk)]
  aux <- close conn
  print "Transaccion realizada"


delete :: NombreUsuarioOriginal -> IO()
delete pk = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  delStmt <- prepareStmt conn "DELETE FROM tUsuario WHERE nombre = ? "

  executeStmt conn delStmt [MySQLText (T.pack pk)]
  aux <- close conn
  print "Transaccion realizada"




getString :: MySQLValue -> String
getString (MySQLText text) = T.unpack text
getString (MySQLInt8 value) = show (fromInt8ToInt value)
getString (MySQLInt32 value) = show (fromInt32ToInt value)
getString (MySQLNull) = ""

fromInt8ToInt :: Int8 -> Int
fromInt8ToInt n = fromIntegral n

fromInt32ToInt :: Int32 -> Int
fromInt32ToInt n = fromIntegral n
