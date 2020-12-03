module Commit where

import GitLab (runGitLab)
import GitLab.API.Commits (projectCommits')
import GitLab.Types (Commit(..))
import Config (server)
import qualified Data.Text as T

type ProjectId = Int
type BranchName = String

-- TODO: handle branch
retrieveLastXCommitFromBranch :: ProjectId -> BranchName -> Int -> IO [Commit]
retrieveLastXCommitFromBranch pid branch x = do
    let config = server
    commits <- runGitLab config (projectCommits' pid)
    case commits of
        Left s -> error $ "Could not retrieve commits, status: " ++ show s
        Right cs -> return (take x cs)

format :: Commit -> String
format c = "#" ++ T.unpack (short_id c) ++ " - " ++ T.unpack (title c)