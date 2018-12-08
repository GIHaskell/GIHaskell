{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.MySQL.Base
import qualified System.IO.Streams as Streams
import qualified Data.Text as T
import Data.Maybe

main = do
    conn <- connect
        ConnectInfo {ciHost = "jfaldanam.ddns.net", ciPort = 3306, ciDatabase = "GIHaskell",
                     ciUser = "usuario", ciPassword = "password", ciCharset = 33}
    (defs, is) <- query_ conn "SELECT * FROM tUsuario"

    xs <- Streams.toList is
    let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
    print rs


-- funciones auxiliarles
getString :: MySQLValue -> String
getString (MySQLText text) = T.unpack text
