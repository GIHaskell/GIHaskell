{-# LANGUAGE OverloadedStrings #-}

module TipoPiezas where

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
 print "Modulo de mapeo de Tipo de Piezas"

type IdTipoPiezaOriginAL = String
type IdTipoPieza = String
type NombreTipoPieza = String


tipoPiezas :: IdTipoPieza -> NombreTipoPieza -> IO()
tipoPiezas idTipoPieza nombre = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  withTransaction conn $ executeMany conn "INSERT INTO tTipoPieza VALUES (\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack idTipoPieza,
            MySQLText $ T.pack nombre]]
  aux <- close conn
  print "Transaccion realizada"



listaTipoPiezas :: IO [[String]]
listaTipoPiezas = do
    conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                    ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

    (defs, is) <- query_ conn "SELECT * FROM tTipoPieza"
    aux <- close conn
    xs <- Streams.toList is
    let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String

    return rs

setIdTipoPieza :: IdTipoPiezaOriginAL -> IdTipoPieza -> IO()
setIdTipoPieza pk idTipoPieza = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                     ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tTipoPieza SET ID_TIPO = ? WHERE ID_TIPO = ? "

  executeStmt conn updStmt [MySQLText (T.pack idTipoPieza),MySQLText (T.pack pk)]
  aux <- close conn

  print "Transaccion realizada"



setNombre :: IdTipoPiezaOriginAL -> NombreTipoPieza -> IO()
setNombre pk nombre = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                   ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  updStmt <- prepareStmt conn "UPDATE tTipoPieza SET NOMBRE = ? WHERE ID_TIPO = ? "

  executeStmt conn updStmt [MySQLText (T.pack nombre),MySQLText (T.pack pk)]
  aux <- close conn

  print "Transaccion realizada"



delete :: IdTipoPiezaOriginAL -> IO()
delete pk = do
  conn <- connect
      ConnectInfo {ciHost = servidorBD, ciPort = puertoBD, ciDatabase = databaseDB,
                      ciUser = usuarioBD, ciPassword = passwordBD, ciCharset = 33}

  delStmt <- prepareStmt conn "DELETE FROM tTipoPieza WHERE ID_TIPO = ? "

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
