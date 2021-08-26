{-# LANGUAGE OverloadedStrings #-}

module Main where

import API
import Config
import Control.Monad (unless, when)
import Commit
import Data.Either (fromRight)
import Data.Text (Text)
import qualified Data.Text as T
import qualified Data.Text.IO as T.IO
import GitLab (runGitLab)
import GitLab.API.Commits (branchCommits')
import GitLab.Types (GitLabServerConfig(..), MergeRequest(..))
import MergeRequest
import Project
import System.Directory (doesFileExist)
import System.Environment (getArgs)

main :: IO ()
main = do
    -- read input
    args <- getArgs
    when (null args) $
        error "You should give a merge request or a branch name."

    -- retrieve configuration
    isConfigExisting <- doesFileExist configFilepath
    unless isConfigExisting $
        error "Missing configuration file, follow the instructions in the README."
    cfg <- readConfigFile configFilepath

    -- parsing
    let arg = head args -- keep only the first argument, ignoring the others
    case parseMergeRequest arg of
        Nothing    -> dealWithTargetBranch (defaultServer cfg) cfg (T.pack arg)
        Just mrurl -> dealWithMergeRequestURL mrurl cfg

dealWithMergeRequestURL :: MergeRequestURL -> Configuration -> IO ()
dealWithMergeRequestURL mrurl cfg = do
    let server = serverFromMergeRequest mrurl cfg
    maybeMr <- runGitLab server (mergeRequestFromURL mrurl)
    case maybeMr of
        Nothing -> putStrLn $
            "Could not fetch merge request: " ++ _mergeRequestBaseURL mrurl
        Just mr  -> dealWithTargetBranch server cfg (merge_request_target_branch mr)

dealWithTargetBranch :: GitLabServerConfig -> Configuration -> Text -> IO ()
dealWithTargetBranch server cfg targetBranch = do
    doesListingExist <- doesFileExist submodulesFilepath
    unless doesListingExist $
        error "Missing submodules listing, follow the instructions in the README."
    projectConfig <- readProjectConfigFile submodulesFilepath
    T.IO.putStrLn $ "Target branch is: " <> targetBranch <> "\n"
    mapM_ (lastCommits server targetBranch (nbCommitsFromConfig cfg)) projectConfig

-- | From a server config, a target branch and a project, print its last X commits
lastCommits :: GitLabServerConfig -> Text -> Int -> (ProjectName, ProjectID) -> IO ()
lastCommits server target nbCommits (pname, pid) = do
    ecs <- runGitLab server (branchCommits' pid target)
    let commits = fromRight (error "Could not retrieve commits.") ecs
    case take nbCommits commits of
        [] ->
            T.IO.putStrLn $ "No branch " <> target <> " on " <> pname <> ".\n"
        cs -> do
            T.IO.putStrLn $ "Last commits on " <> pname <> ":"
            T.IO.putStrLn . T.unlines . map (indent 8 . format) $ cs