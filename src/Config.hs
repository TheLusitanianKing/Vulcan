{-# LANGUAGE OverloadedStrings #-}

-- |
-- Module      : Config
-- Description : Handle script configuration from config file
-- License     : MIT
-- Maintainer  : The Lusitanian King <alexlusitanian@gmail.com>
module Config where

import Data.Maybe (fromMaybe)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T.IO
import GitLab (defaultGitLabServer)
import GitLab.Types (GitLabServerConfig(..))
import MergeRequest (MergeRequestURL(..))
import Text.Read (readMaybe)

type ID = Text
type Value = Text
type ConfigurationValue = (ID, Value)
type Configuration = [ConfigurationValue]

-- | Configuration filepath
configFilepath :: String
configFilepath = "conf/vulcan.conf"

-- | Get GitLab server config from a merge request URI
serverFromMergeRequest :: MergeRequestURL -> Configuration -> GitLabServerConfig
serverFromMergeRequest (MergeRequestURL _ baseUrl _) cfg =
    case lookup "token" cfg of
        Nothing -> error "Missing token to create server from merge request URL"
        Just tk -> defaultGitLabServer { url = T.pack baseUrl, token = tk }

defaultServer :: Configuration -> GitLabServerConfig
defaultServer cfg =
    case looksups cfg of
        Nothing         -> error "Could not create default server from config"
        Just (tk, base) -> defaultGitLabServer { url = base, token = tk }
    where looksups :: Configuration -> Maybe (Text, Text)
          looksups c = do
              tk   <- lookup "token" c
              base <- lookup "url" c
              return (tk, base)

-- | Retrieving configuration from file
readConfigFile :: FilePath -> IO Configuration
readConfigFile path = map parse . T.lines <$> T.IO.readFile path
    where parse :: Text -> ConfigurationValue
          parse t
            | T.null v || T.null i = error $ "Could not parse configuration line: " ++ T.unpack t
            | otherwise            = (T.strip i, T.strip (T.tail v))
            where (i, v) = T.break (=='=') (T.takeWhile (/='#') t)

-- | Retrieve number of commits to display for each submodules from configuration
nbCommitsFromConfig :: Configuration -> Int
nbCommitsFromConfig cfg = case lookup "nbCommits" cfg of
    Nothing -> defaultValue
    Just nb -> fromMaybe defaultValue (readMaybe . T.unpack $ nb)
    where defaultValue = 5