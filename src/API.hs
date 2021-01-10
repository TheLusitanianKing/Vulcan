{-# LANGUAGE OverloadedStrings #-}

module API where

import Config (serverFromConfig, serverFromMergeRequest)
import Data.Either (fromRight)
import Data.Text (Text)
import qualified Data.Text as T
import GitLab (runGitLab)
import GitLab.API.Commits (projectCommits')
import GitLab.API.MergeRequests (mergeRequests)
import GitLab.API.Projects (projectsWithName)
import GitLab.WebRequests.GitLabWebCalls (gitlabOne)
import GitLab.Types (Commit(..), GitLab(..), Project(..), MergeRequest(..))
import MergeRequest (MergeRequestURI(..))

-- | Return the merge request
fetchMergeRequestFromID :: Int -- ^ Project ID
                        -> Int -- ^ Merge request ID
                        -> GitLab (Maybe MergeRequest)
fetchMergeRequestFromID pid mrid = do
  result <- gitlabOne $ "/projects/" <> T.pack (show pid) <> "/merge_requests/" <> T.pack (show mrid)
  return (fromRight (error "error fetching merge request from GitLab") result)

-- | From a merge request URI, try to get the actual merge request from GitLab
fetchMergeRequest :: MergeRequestURI -> GitLab (Maybe MergeRequest)
fetchMergeRequest mruri = do
    ps <- projectsWithName (T.pack $ mergeRequestProject mruri)
    case ps of
        [] -> return Nothing
        p:_ -> return $ fetchMergeRequestFromID p (mergeRequestId mruri)