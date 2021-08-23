{-# LANGUAGE OverloadedStrings #-}

-- |
-- Module      : Commit
-- Description : Handle commits display
-- License     : MIT
-- Maintainer  : The Lusitanian King <alexlusitanian@gmail.com>
module Commit where

import Data.Text (Text)
import qualified Data.Text as T
import GitLab.Types (Commit(..))

-- | Formatting a commit to display
format :: Commit -> Text
format c = "#"
    <> short_id c
    <> " - "
    <> fit 40 (title c)
    <> " <"
    <> committer_email c
    <> ">"

-- | Fit the title in X characters
fit :: Int  -- ^ size
    -> Text -- ^ title to fit
    -> Text
fit n t | remaining < 0 = T.take (n-3) t <> "..."
        | otherwise     = t <> T.replicate remaining " "
        where remaining = n - T.length t

-- | Indenting
indent :: Int -> Text -> Text
indent n = (T.replicate n " " <>)