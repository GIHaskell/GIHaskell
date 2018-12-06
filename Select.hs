{-# LANGUAGE OverloadedStrings #-}

module Select where

import Database.MySQL.Base
import Database.MySQL.BinLog
import qualified System.IO.Streams as Streams
import qualified Data.Text as T
import Data.Maybe
import Data.Int (Int8, Int16, Int32, Int64)
import Data.Char

--El select lo he hecho de dos modos:
-- main pide la consulta a realizar por teclado
-- la función consulta toma el valor por parametro


main = do
  putStrLn "Introduzca el nombre de la consulta:"
  t <- getLine

  conn <- connect
      ConnectInfo {ciHost = "jfaldanam.ddns.net", ciPort = 3306, ciDatabase = "GIHaskell",
                   ciUser = "usuario", ciPassword = "password", ciCharset = 33}

  (defs, is) <- query_ conn $ q t
  xs <- Streams.toList is
  let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print xs
  print rs

consulta :: [Char] -> IO [[String]]
consulta str = do

  conn <- connect
      ConnectInfo {ciHost = "jfaldanam.ddns.net", ciPort = 3306, ciDatabase = "GIHaskell",
                   ciUser = "usuario", ciPassword = "password", ciCharset = 33}

  (defs, is) <- query_ conn $ q str
  xs <- Streams.toList is
  let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  --print xs
  --putStrLn rs
  return rs

getString :: MySQLValue -> String
getString (MySQLText text) = T.unpack text
getString (MySQLInt8 value) = show (fromInt8ToInt value)
getString (MySQLInt32 value) = show (fromInt32ToInt value)
getString (MySQLNull) = ""

fromInt8ToInt :: Int8 -> Int
fromInt8ToInt n = fromIntegral n

fromInt32ToInt :: Int32 -> Int
fromInt32ToInt n = fromIntegral n

q :: [Char] -> Query
q ['A'] = "SELECT * FROM tUsuario"
q ['B'] = "SELECT * FROM tRol"
q ['C'] = "SELECT * FROM tPermiso"
q ['D'] = "SELECT * FROM tPiezas"
q ['E'] = "SELECT * FROM tTipoPieza"
q ['a'] = "SELECT nombre FROM tUsuario"
q ['b'] = "SELECT password FROM tUsuario"
q ['c'] = "SELECT rolName FROM tUsuario"
q ['d'] = "SELECT rolName FROM tRol"
q ['e'] = "SELECT rolDes FROM tRol"
q ['f'] = "SELECT admin FROM tRol"
q ['g'] = "SELECT rolName FROM tPermiso"
q ['h'] = "SELECT pantalla FROM tPermiso"
q ['i'] = "SELECT acceso FROM tPermiso"
q ['j'] = "SELECT modificacion FROM tPermiso"
q ['k'] = "SELECT ID FROM tPiezas"
q ['l'] = "SELECT NOMBRE FROM tPiezas"
q ['m'] = "SELECT FABRICANTE FROM tPiezas"
q ['n'] = "SELECT ID_TIPO FROM tPiezas"
q ['o'] = "SELECT ID_TIPO FROM tTipoPieza"
q ['p'] = "SELECT NOMBRE FROM tTipoPieza"
