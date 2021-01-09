{-# LANGUAGE OverloadedStrings #-}

-- |
-- Module      : Config
-- Description : Handle script configuration from config file
-- Copyright   : TODO
-- License     : TODO
-- Maintainer  : TODO
-- Stability   : TODO
module Config (
    readConfigFile,
    serverFromConfig,
    serverFromMergeRequest
) where

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

-- | Default GitLab server configuration
serverFromConfig :: Configuration -> Maybe GitLabServerConfig
serverFromConfig cfg = do
    url <- lookup "url" cfg
    token <- lookup "token" cfg
    return $ defaultGitLabServer { url = url, token = token }

-- | Get GitLab server config from a merge request URI
serverFromMergeRequest :: MergeRequestURI -> Configuration -> Maybe GitLabServerConfig
serverFromMergeRequest (MergeRequestURI _ url _) cfg = do
    token <- lookup "token" cfg
    return $ defaultGitLabServer { url = T.pack url, token = token }

-- | Retrieving configuration from file
readConfigFile :: FilePath -> IO Configuration
readConfigFile path = map parse . T.lines <$> T.IO.readFile path
    where parse :: Text -> ConfigurationValue
          parse t
            | T.null v || T.null i = error $ "Wrong configuration line: " ++ T.unpack t
            | otherwise            = (T.strip i, T.strip v)
            where (i, v) = T.break (=='=') t