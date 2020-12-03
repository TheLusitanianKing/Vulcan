module Commit where

data Commit = Commit {
    commitHash   :: String,
    commitName   :: String,
    commitAuthor :: String
} deriving (Eq, Show)

type ProjectId = Int
type BranchName = String

-- retrieveLastXCommitFromBranch :: ProjectId -> BranchName -> Int -> IO [Commit]
retrieveLastXCommitFromBranch :: ProjectId -> BranchName -> Int -> IO ()
retrieveLastXCommitFromBranch pid branch x = undefined