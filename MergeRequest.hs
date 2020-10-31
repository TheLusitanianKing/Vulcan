-- Handle GitLab merge requests
module MergeRequest where
    -- TODO: export only what we want

-- extracted data of a merge request URI
data MergeRequest = MergeRequest {
    mergeRequestId      :: Int, -- its ID, e.g. 18835
    mergeRequestBaseURL :: String, -- its base URL, e.g. "https://git.something.com/"
    mergeRequestProject :: String -- the concerned project, e.g. "myproject/subproject"
} deriving (Show)

-- merge request typical examples :
-- https://git.something.com/project/front/merge_requests/2939/diffs
mr1 = MergeRequest 2939 "https://git.something.com/" "project/front"
-- https://git.something.com/project/api/merge_requests/1993/diffs
mr2 = MergeRequest 1993 "https://git.something.com/" "project/api"
-- https://git.something.com/project/api-front/merge_requests/1580
mr3 = MergeRequest 1580 "https://git.something.com/" "project/api-front"

-- parse a merge request URI
parseMergeRequest :: String -> Maybe MergeRequest
parseMergeRequest = undefined

-- print a merge request
printMergeRequest :: MergeRequest -> String
printMergeRequest (MergeRequest id base project) = base ++ project ++ "/merge_requests/" ++ show id