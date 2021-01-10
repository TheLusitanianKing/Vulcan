{-# LANGUAGE OverloadedStrings #-}

module Project where

import Data.Char (isSpace)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T.IO

type ProjectName          = Text
type ProjectID            = Int
type ProjectConfigValue   = (ProjectName, ProjectID)
type ProjectConfiguration = [ProjectConfigValue]

-- | Retrieving project configuration from file
readProjectConfigFile :: FilePath -> IO ProjectConfiguration
readProjectConfigFile path = map parse . T.lines <$> T.IO.readFile path
    where parse :: Text -> ProjectConfigValue
          parse t
            | T.null v || T.null i = error $ "Wrong configuration line: " ++ T.unpack t
            | otherwise            = (T.strip i, read . T.unpack . T.strip $ v)
            where (i, v) = T.break isSpace t