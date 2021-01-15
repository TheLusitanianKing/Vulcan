{-# LANGUAGE OverloadedStrings #-}

module Main where

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
import System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    case args of
        []      -> do
            putStrLn "You should give a merge request"
            putStrLn "Help: ./vulcan https://your.mergerequest.url"
        (arg:_) -> do
            -- retrieve configurations
            cfg <- readConfigFile "vulcan.conf"
            case parseMergeRequest arg of
                              -- should check that it is a plausible branch name
                Nothing    -> dealWithTargetBranch (defaultServer cfg) (T.pack arg)
                Just mrurl -> dealWithMergeRequestURL mrurl cfg

dealWithMergeRequestURL :: MergeRequestURL -> Configuration -> IO ()
dealWithMergeRequestURL mrurl cfg = do
    -- retrieve server configuration from merge request
    let server = serverFromMergeRequest mrurl cfg
    -- retrieve actual merge request information GitLab API
    mr <- runGitLab server (mergeRequestFromURL mrurl)
    case mr of
        Nothing -> putStrLn "Could not fetch merge request"
        Just mr -> dealWithTargetBranch server (merge_request_target_branch mr)

dealWithTargetBranch :: GitLabServerConfig -> Text -> IO ()
dealWithTargetBranch server targetBranch = do
    -- retrieve configured projects
    ps <- readProjectConfigFile "submodules.conf"
    -- time to retrieve commits for all projects on the target branch
    T.IO.putStrLn $ "Target branch is: " +-+ targetBranch +-+ "\n"
    -- print last commits on the configured projects
    mapM_ (lastCommits server targetBranch) ps

-- | From a server config, a target branch and a project, print its last 5 commits
lastCommits :: GitLabServerConfig -> Text -> (ProjectName, ProjectID) -> IO ()
lastCommits server target (pname, pid) = do
    cs <- runGitLab server (branchCommits' pid target)
    let commits = fromRight (error "Could not retrieve commits") cs
    case take 5 commits of
        [] ->
            T.IO.putStrLn $ "No branch " +-+ target +-+ " on " +-+ pname +-+ "\n"
        cs -> do
            T.IO.putStrLn $ "Last commits on " +-+ pname
            T.IO.putStrLn . T.unlines . map (indent 8 . format) $ cs

-- To make it overall a bit more concise
(+-+) = T.append