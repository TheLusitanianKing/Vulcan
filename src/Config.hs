{-# LANGUAGE OverloadedStrings #-}

-- |
-- Module      : Config
-- Description : Handle script configuration from config file
-- License     : MIT
-- Maintainer  : The Lusitanian King <alexlusitanian@gmail.com>
module Config where

import Data.Char (isSpace)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T.IO
import GitLab (defaultGitLabServer)
import GitLab.Types (GitLabServerConfig(..))
import MergeRequest (MergeRequestURI(..))

type ID = Text
type Value = Text
type ConfigurationValue = (ID, Value)
type Configuration = [ConfigurationValue]

-- | Get GitLab server config from a merge request URI
serverFromMergeRequest :: MergeRequestURI -> Configuration -> GitLabServerConfig
serverFromMergeRequest (MergeRequestURI _ url _) cfg =
    case lookup "token" cfg of
        Nothing    -> error "Could not found server configuration from file"
        Just token -> defaultGitLabServer { url = T.pack url, token = token }

-- | Retrieving configuration from file
readConfigFile :: FilePath -> IO Configuration
readConfigFile path = map parse . T.lines <$> T.IO.readFile path
    where parse :: Text -> ConfigurationValue
          parse t
            | T.null v || T.null i = error $ "Could not parse configuration line: " ++ T.unpack t
            | otherwise            = (T.strip i, T.strip (T.tail v))
            where (i, v) = T.break (=='=') t