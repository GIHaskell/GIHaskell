{-# LANGUAGE OverloadedStrings #-}

module Piezas where

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
passwordBD = "password_"
databaseDB = "GIHaskell"
puertoBD = 3306

main = do
 print "Modulo de mapeo de Piezas"

type IdPiezaOriginal = Int32
type IdPieza = Int32
type NombrePieza = String
type FabricantePieza = String
type IdTipoPieza = String

piezas :: IdPieza -> NombrePieza -> FabricantePieza -> IdTipoPieza -> IO()
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
           MySQLText $ T.pack idTipo]]
  aux <- close conn
  print "Transaccion realizada"



listaPiezas :: IO [[String]]
listaPiezas = do
    conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

    (defs, is) <- query_ conn "SELECT * FROM tPiezas"
    aux <- close conn
    xs <- Streams.toList is
    let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String

    return rs

setIdPieza :: IdPiezaOriginal -> IdPieza -> IO()
setIdPieza pk id = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tPiezas SET ID = ? WHERE ID = ? "

  executeStmt conn updStmt [MySQLInt32 id,MySQLInt32 pk]
  aux <- close conn
  print "Transaccion realizada"



setNombre :: IdPiezaOriginal -> NombrePieza -> IO()
setNombre pk nombre = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tPiezas SET NOMBRE = ? WHERE ID = ? "

  executeStmt conn updStmt [MySQLText (T.pack nombre),MySQLInt32 pk]
  aux <- close conn
  print "Transaccion realizada"


setFabricante :: IdPiezaOriginal -> FabricantePieza -> IO()
setFabricante pk fabricante = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                     ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tPiezas SET FABRICANTE = ? WHERE ID = ? "

  executeStmt conn updStmt [MySQLText (T.pack fabricante),MySQLInt32 pk]
  aux <- close conn
  print "Transaccion realizada"


setTipoPieza :: IdPiezaOriginal -> IdTipoPieza -> IO()
setTipoPieza pk idTipo = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tPiezas SET ID_TIPO = ? WHERE ID = ? "
  aux <- close conn
  executeStmt conn updStmt [MySQLText (T.pack idTipo),MySQLInt32 pk]

  print "Transaccion realizada"


delete :: IdPiezaOriginal -> IO()
delete pk = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  delStmt <- prepareStmt conn "DELETE FROM tPiezas WHERE ID = ? "

  executeStmt conn delStmt [MySQLInt32 pk]
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
