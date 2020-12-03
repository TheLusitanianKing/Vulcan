module Commit where

import GitLabAPI (prepareGitLabRequest)
import Network.HTTP.Simple (getResponseBody, getResponseStatusCode, httpJSON)
import Data.Aeson (FromJSON(..))

data Commit = Commit {
    commitHash   :: String,
    commitName   :: String,
    commitAuthor :: String
} deriving (Eq, Show)

type ProjectId = Int
type BranchName = String

instance FromJSON Commit where
    parseJSON = undefined

-- retrieveLastXCommitFromBranch :: ProjectId -> BranchName -> Int -> IO [Commit]
retrieveLastXCommitFromBranch :: ProjectId -> BranchName -> Int -> IO ()
retrieveLastXCommitFromBranch pid branch x = do
    response <- httpJSON $ prepareGitLabRequest ("/projects/" ++ show pid ++ "/repository/commits") [("ref_name", Just branch)]
    putStrLn $ "The response was: " ++ show (getResponseBody response :: [Commit])
    putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)