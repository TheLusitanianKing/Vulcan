-- Handle GitLab merge requests
module MergeRequest where
    -- TODO: import only wanted functions

import Text.Regex.PCRE ((=~))
import Network.HTTP.Simple
import Data.Aeson (Value)
import qualified Data.ByteString.Char8 as C8
import qualified Data.CaseInsensitive as CI

-- extracted data of a merge request URI
data MergeRequest = MergeRequest {
    mergeRequestId      :: Int, -- its ID, e.g. 18835
    mergeRequestBaseURL :: String, -- its base URL, e.g. "https://git.something.com"
    mergeRequestProject :: String -- the concerned project, e.g. "myproject/subproject"
} deriving (Show, Eq)

-- TODO: needed? move this stuff?
data Commit = Commit {
    commitHash   :: String,
    commitName   :: String,
    commitAuthor :: String
} deriving (Show, Eq)

-- TODO: do I really want this data type?
data MergeRequestData = MergeRequestData {
    mergeRequestTargetBranch :: String,
    mergeRequestSourceBranch :: String
    -- mergeRequestCommits      :: [Commit]
} deriving (Show, Eq)

-- merge request typical examples :
-- https://git.something.com/project/front/merge_requests/2939/diffs
mr1 = MergeRequest 2939 "https://git.something.com/" "project/front"
-- https://git.something.com/project/api/merge_requests/1993/diffs
mr2 = MergeRequest 1993 "https://git.something.com/" "project/api"
-- https://git.something.com/project/api-front/merge_requests/1580
mr3 = MergeRequest 1580 "https://git.something.com/" "project/api-front"

-- parse a merge request URI
parseMergeRequest :: String -> Maybe MergeRequest 
parseMergeRequest s =
    case matched of
        (_, _, _, base:project:id:_) -> Just (MergeRequest (read id) base project)
        _                            -> Nothing
    where matched = s =~ "(https?://[\\w.]*)/([\\w-]*/[\\w-]*)/merge_requests/(\\d+)" :: (String, String, String, [String])

-- print a merge request
printMergeRequest :: MergeRequest -> String
printMergeRequest (MergeRequest id base project) = base ++ "/" ++ project ++ "/merge_requests/" ++ show id

-- TODO: retrieve commit list from a merge request
-- mergeRequestCommits :: MergeRequest -> IO [Commit]
mergeRequestCommits :: MergeRequest -> IO ()
mergeRequestCommits m = do
    response <- httpJSON $ prepareGitLabRequest $ C8.pack "/projects"
    C8.putStrLn . C8.pack $ "The response was: " ++ show (getResponseBody response :: Value)
    C8.putStrLn . C8.pack $ "The status code was: " ++ show (getResponseStatusCode response)

prepareGitLabRequest :: C8.ByteString -> Request
prepareGitLabRequest path =
            setRequestPath (C8.pack "/api/v4" `C8.append` path)
            $ setRequestHost (C8.pack "gitlab.com")
            -- TODO: put authorization bearer into configuration file + revoke it as it has been disclosed
            $ setRequestHeaders [(CI.mk (C8.pack "Authorization"), C8.pack "Bearer ELLAJvrdz2H3YoMzcPvm")] 
            $ setRequestQueryString [(C8.pack "membership", Just (C8.pack "true"))]
            $ setRequestMethod (C8.pack "GET")
            $ setRequestSecure True
            $ setRequestPort 443
            $ defaultRequest

-- TODO: retrieve last X commits of a project by its project name
projectCommitsByProjectName :: String -> Int -> [Commit]
projectCommitsByProjectName = undefined