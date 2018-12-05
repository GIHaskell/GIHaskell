{-# LANGUAGE OverloadedStrings #-}

module Main where

import Database.MySQL.Base
import Database.MySQL.BinLog
import qualified System.IO.Streams as Streams
import qualified Data.Text as T
import Data.Maybe

insertar = do
  r <- getLine
  conn <- connect
      ConnectInfo {ciHost = "jfaldanam.ddns.net", ciPort = 3306, ciDatabase = "GIHaskell",
                   ciUser = "martin", ciPassword = "password_martin", ciCharset = 33}

  withTransaction conn $ executeMany conn "INSERT INTO tUsuario VALUES (\
          \?  ,\
          \?  ,\
          \?)"
          [[MySQLText $ T.pack r,
           MySQLText "test2",
           MySQLText "invitado"]]
