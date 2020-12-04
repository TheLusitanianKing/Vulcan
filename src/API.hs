module API where

import Config (server, serverFromMergeRequest)
import qualified Data.Text as T
import GitLab (runGitLab)
import GitLab.API.Commits (projectCommits')
import GitLab.API.MergeRequests (mergeRequests)
import GitLab.API.Projects (projectsWithName)
import GitLab.Types (Commit(..), Project(..), MergeRequest(..))
import MergeRequest (MergeRequestURI(..))

type ProjectId = Int
type BranchName = String

-- TODO: handle branch
fetchLastXCommitFromBranch :: ProjectId -> BranchName -> Int -> IO [Commit]
fetchLastXCommitFromBranch pid branch x = do
    let config = server
    commits <- runGitLab config (projectCommits' pid)
    case commits of
        Left s -> error $ "Could not retrieve commits, status: " ++ show s
        Right cs -> return (take x cs)

fetchProjectFromMergeRequest :: MergeRequestURI -> IO (Maybe Project)
fetchProjectFromMergeRequest m = do
    let config = serverFromMergeRequest m
    projects <- runGitLab config (projectsWithName $ T.pack $ mergeRequestProject m)
    case projects of
        [] -> return Nothing
        (p:_) -> return (Just p)

fetchMergeRequestWithProject :: MergeRequestURI -> Project -> IO (Maybe MergeRequest)
fetchMergeRequestWithProject m p = do
    let config = serverFromMergeRequest m
    mergeRequests <- runGitLab config (mergeRequests p)
    let filteredMergeRequests = filter (\mr -> merge_request_id mr == mergeRequestId m) mergeRequests
    case filteredMergeRequests of
        [] -> return Nothing
        (mr:_) -> return (Just mr)

fetchMergeRequest :: MergeRequestURI -> IO (Maybe MergeRequest)
fetchMergeRequest m = do
    project <- fetchProjectFromMergeRequest m
    -- TODO: remove this escalator
    case project of
        Nothing -> return Nothing
        Just project -> do
            mr <- fetchMergeRequestWithProject m project
            case mr of
                Nothing -> return Nothing
                Just mr -> return (Just mr)