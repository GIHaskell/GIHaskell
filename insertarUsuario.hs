{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.MySQL.Base
import Database.MySQL.BinLog
import qualified System.IO.Streams as Streams
import qualified Data.Text as T
import Data.Maybe

main = do
  putStrLn "Introduzca el nombre del usuario:"
  u <- getLine
  putStrLn "Introduzca la contraseña del usuario:"
  p <- getLine
  putStrLn "Introduzca el rol del usuario:"
  r <- getLine
  conn <- connect
      ConnectInfo {ciHost = "jfaldanam.ddns.net", ciPort = 3306, ciDatabase = "GIHaskell",
                   ciUser = "usuario", ciPassword = "password", ciCharset = 33}

  withTransaction conn $ executeMany conn "INSERT INTO tUsuario VALUES (\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack u,
           MySQLText $ T.pack p,
           MySQLText $ T.pack r]]

  (defs, is) <- query_ conn "SELECT * FROM tUsuario"

  xs <- Streams.toList is
  let rs = [ [getString x | x <- y ] | y <- xs] -- unpack convierte Text a String
  print rs


getString :: MySQLValue -> String
getString (MySQLText text) = T.unpack text
