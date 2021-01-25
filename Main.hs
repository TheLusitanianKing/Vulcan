{-# LANGUAGE OverloadedStrings #-}

module Main where

import Alias
import API
import Config
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
    args <- getArgs
    if null args then putStrLn "You should give a merge request or a branch name."
    else do
        -- retrieve configuration
        isConfigExisting <- doesFileExist configFilepath
        if isConfigExisting then do
            cfg <- readConfigFile configFilepath
            -- parsing
            let arg = head args -- keep only the first argument, ignoring the others
            case parseMergeRequest arg of
                Nothing    -> dealWithTargetBranch (defaultServer cfg) cfg (T.pack arg)
                Just mrurl -> dealWithMergeRequestURL mrurl cfg
        else error "Missing configuration file, please follow the configuration instructions."

dealWithMergeRequestURL :: MergeRequestURL -> Configuration -> IO ()
dealWithMergeRequestURL mrurl cfg = do
    -- retrieve server configuration from merge request
    let server = serverFromMergeRequest mrurl cfg
    -- retrieve actual merge request information GitLab API
    mr <- runGitLab server (mergeRequestFromURL mrurl)
    case mr of
        Nothing -> putStrLn "Could not fetch merge request."
        Just mr -> dealWithTargetBranch server cfg (merge_request_target_branch mr)

dealWithTargetBranch :: GitLabServerConfig -> Configuration -> Text -> IO ()
dealWithTargetBranch server cfg targetBranch = do
    -- retrieve configuration preferences for number of commits
    let nbCommits = nbCommitsFromConfig cfg
    -- retrieve configured projects
    doesListingExist <- doesFileExist submodulesFilepath
    if doesListingExist then do
        ps <- readProjectConfigFile submodulesFilepath
        -- time to retrieve commits for all projects on the target branch
        T.IO.putStrLn $ "Target branch is: " +-+ targetBranch +-+ "\n"
        -- print last commits on the configured projects
        mapM_ (lastCommits server targetBranch nbCommits) ps
    else error "Missing submodules listing, please follow the configuration instructions."

-- | From a server config, a target branch and a project, print its last X commits
lastCommits :: GitLabServerConfig -> Text -> Int -> (ProjectName, ProjectID) -> IO ()
lastCommits server target nbCommits (pname, pid) = do
    cs <- runGitLab server (branchCommits' pid target)
    let commits = fromRight (error "Could not retrieve commits.") cs
    case take nbCommits commits of
        [] ->
            T.IO.putStrLn $ "No branch " +-+ target +-+ " on " +-+ pname +-+ ".\n"
        cs -> do
            T.IO.putStrLn $ "Last commits on " +-+ pname +-+ ":"
            T.IO.putStrLn . T.unlines . map (indent 8 . format) $ cs