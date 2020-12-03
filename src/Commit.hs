module Commit where

import qualified Data.Text as T
import GitLab.Types (Commit(..))

format :: Commit -> String
format c =
    "#"
    ++ T.unpack (short_id c)
    ++ " - "
    ++ T.unpack (title c)
    ++ " <"
    ++ T.unpack (committer_email c)
    ++ ">"