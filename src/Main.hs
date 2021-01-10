module Main where

import API
import Config
import Data.Maybe (fromMaybe)
import qualified Data.Text as T
import GitLab (runGitLab)
import GitLab.API.Projects (projectsWithName)
import GitLab.Types (GitLabServerConfig(..), MergeRequest(..))
import MergeRequest
import Project
import System.Environment (getArgs)

main :: IO ()
main = do
    cfg <- readConfigFile "vulcan.conf"
    ps  <- readProjectConfigFile "projects.conf"
    args <- getArgs
    case args of
        []      -> putStrLn "./vulcan ..." -- TODO: give help here
        (uri:_) -> do
            case parseMergeRequest uri of
                Nothing -> putStrLn "URI isn't a valid merge request"
                Just mruri -> do
                    mr <- runGitLab (serverFromMergeRequest mruri cfg) (mergeRequestFromURI mruri)
                    print mr