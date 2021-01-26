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
import GitLab.Types (GitLab, MergeRequest(..))
import MergeRequest (MergeRequestURL(..))

-- | From a merge request URI, try to get the actual merge request from GitLab
mergeRequestFromURL :: MergeRequestURL -> GitLab (Maybe MergeRequest)
mergeRequestFromURL mrurl = do
    ps <- projectsWithName (T.pack $ mergeRequestProject mrurl)
    case ps of
        [] -> return Nothing
        p:_ -> do
            mr <- mergeRequest p (mergeRequestId mrurl)
            return (fromRight (error "Could not fetch merge request from the URI") mr)