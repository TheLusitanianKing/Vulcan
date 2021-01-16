{-# LANGUAGE OverloadedStrings #-}

-- |
-- Module      : Commit
-- Description : Handle commits display
-- License     : MIT
-- Maintainer  : The Lusitanian King <alexlusitanian@gmail.com>
module Commit where

import Alias
import Data.Text (Text)
import qualified Data.Text as T
import GitLab.Types (Commit(..))

-- | Formatting a commit to display
format :: Commit -> Text
format c = "#"
       +-+ short_id c
       +-+ " - "
       +-+ title c
       +-+ " <"
       +-+ committer_email c
       +-+ ">"

indent :: Int -> Text -> Text
indent n = (T.replicate n " " +-+)