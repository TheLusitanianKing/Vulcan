{-# LANGUAGE OverloadedStrings #-}

module Commit where

import Data.Text (Text)
import qualified Data.Text as T
import GitLab.Types (Commit(..))

-- | Formatting a commit to display
format :: Commit -> Text
format c =     "#"
    `T.append` short_id c
    `T.append` " - "
    `T.append` title c
    `T.append` " <"
    `T.append` committer_email c
    `T.append` ">"