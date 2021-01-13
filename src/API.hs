{-# LANGUAGE OverloadedStrings #-}

-- |
-- Module      : API
-- Description : Handle API requests
-- License     : MIT
-- Maintainer  : The Lusitanian King <alexlusitanian@gmail.com>
module API where

import Data.Either (fromRight)
import qualified Data.Text as T
import GitLab.API.MergeRequests (mergeRequest)
import GitLab.API.Projects (projectsWithName)
import GitLab.Types (GitLab(..), MergeRequest(..))
import MergeRequest (MergeRequestURI(..))

-- | From a merge request URI, try to get the actual merge request from GitLab
mergeRequestFromURI :: MergeRequestURI -> GitLab (Maybe MergeRequest)
mergeRequestFromURI mruri = do
    ps <- projectsWithName (T.pack $ mergeRequestProject mruri)
    case ps of
        [] -> return Nothing
        p:_ -> do
            mr <- mergeRequest p (mergeRequestId mruri)
            return (fromRight (error "Could not get the merge request from URI") mr)