{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.MySQL.Base
import Database.MySQL.BinLog
import qualified System.IO.Streams as Streams
import qualified Data.Text as T
import Data.Maybe
import Data.Int (Int8, Int16, Int32, Int64)
import Data.Char

main = do
    conn <- connect
        ConnectInfo {ciHost = "jfaldanam.ddns.net", ciPort = 3306, ciDatabase = "speedTestGI",
                     ciUser = "usuario", ciPassword = "password", ciCharset = 33}
    (defs, is) <- query_ conn "SELECT * FROM selectMultiRow"

    xs <- Streams.toList is
    let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
    print rs


-- funciones auxiliarles
getString :: MySQLValue -> String
getString (MySQLText text) = T.unpack text
getString (MySQLInt8 value) = show (fromInt8ToInt value)
getString (MySQLInt32 value) = show (fromInt32ToInt value)
getString (MySQLNull) = ""

fromInt8ToInt :: Int8 -> Int
fromInt8ToInt n = fromIntegral n

fromInt32ToInt :: Int32 -> Int
fromInt32ToInt n = fromIntegral n
