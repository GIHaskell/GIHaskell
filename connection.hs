{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.MySQL.Base
import qualified System.IO.Streams as Streams

main :: IO () 
main = do
    conn <- connect
        ConnectInfo {ciHost = "jfaldanam.ddns.net", ciPort = 3306, ciDatabase = "GIHaskell",
                     ciUser = "martin", ciPassword = "password_martin", ciCharset = 33}
    (defs, is) <- query_ conn "SELECT * FROM tUsuario"
    print =<< Streams.toList is