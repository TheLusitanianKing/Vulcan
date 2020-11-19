-- Handle GitLab merge requests
module MergeRequest where
    -- TODO: import only wanted functions

import GitLabAPI (prepareGitLabRequest)
import Text.Regex.PCRE ((=~))
import Network.HTTP.Simple (getResponseBody, getResponseStatusCode, httpJSON)
import Data.Aeson (Value)

-- extracted data of a merge request URI
data MergeRequest = MergeRequest {
    mergeRequestId      :: Int, -- its ID, e.g. 18835
    mergeRequestBaseURL :: String, -- its base URL, e.g. "https://git.something.com"
    mergeRequestProject :: String -- the concerned project, e.g. "myproject/subproject"
} deriving (Eq, Show)

-- parse a merge request URI
parseMergeRequest :: String -> Maybe MergeRequest 
parseMergeRequest s =
    case matched of
        (_, _, _, base:project:id:_) -> Just (MergeRequest (read id) base project)
        _                            -> Nothing
    where matched = s =~ "(https?://[\\w.]*)/([\\w-]*/[\\w-]*)/merge_requests/(\\d+)"
                    :: (String, String, String, [String])

-- print a merge request
printMergeRequest :: MergeRequest -> String
printMergeRequest (MergeRequest id base project) = base ++ "/" ++ project ++ "/merge_requests/" ++ show id

-- TODO: retrieve commit list from a merge request
-- mergeRequestCommits :: MergeRequest -> IO [Commit]
mergeRequestCommits :: MergeRequest -> IO ()
mergeRequestCommits m = do
    response <- httpJSON $ prepareGitLabRequest "/projects" []
    putStrLn $ "The response was: " ++ show (getResponseBody response :: Value)
    putStrLn $ "The status code was: " ++ show (getResponseStatusCode response)