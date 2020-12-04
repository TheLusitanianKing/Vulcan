-- Handle GitLab merge requests
module MergeRequest where

import Text.Regex.PCRE ((=~))

-- extracted data of a merge request URI
data MergeRequestURI = MergeRequestURI {
    mergeRequestId      :: Int, -- its ID, e.g. 18835
    mergeRequestBaseURL :: String, -- its base URL, e.g. "https://git.something.com"
    mergeRequestProject :: String -- the concerned project, e.g. "myproject/subproject"
} deriving (Eq, Show)

-- parse a merge request URI
parseMergeRequest :: String -> Maybe MergeRequestURI 
parseMergeRequest s =
    case matched of
        (_, _, _, base:project:id:_) -> Just (MergeRequestURI (read id) base project)
        _                            -> Nothing
    where matched = s =~ "(https?://[\\w.]*)/([\\w-]*/[\\w-]*)/merge_requests/(\\d+)"
                    :: (String, String, String, [String])

-- print a merge request
printMergeRequest :: MergeRequestURI -> String
printMergeRequest (MergeRequestURI id base project) = base ++ "/" ++ project ++ "/merge_requests/" ++ show id