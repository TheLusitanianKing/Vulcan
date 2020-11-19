module Commit where

data Commit = Commit {
    commitHash   :: String,
    commitName   :: String,
    commitAuthor :: String
} deriving (Eq, Show)