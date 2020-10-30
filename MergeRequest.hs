-- Handle GitLab merge requests
module MergeRequest where
    -- export only interesting things

-- extracted data of a merge request URI
data MergeRequest = MergeRequest {
    mergeRequestId      :: Int, -- its ID, e.g. 18835
    mergeRequestBaseURL :: String, -- its base URL, e.g. "https://git.something.com/"
    mergeRequestProject :: String -- the concerned project, e.g. "myproject/subproject"
} deriving (Show)

-- merge request typical examples :
-- https://git.kwankodev.net/kwanko/kwanko-members/merge_requests/2939/diffs
mr1 = MergeRequest 2939 "https://git.kwankodev.net/" "kwanko/kwanko-members"
-- https://git.kwankodev.net/kwanko/kwanko-api-backend/merge_requests/1993/diffs
mr2 = MergeRequest 1993 "https://git.kwankodev.net/" "kwanko/kwanko-api-backend"
-- https://git.kwankodev.net/addons/api-fronto/merge_requests/1580
mr3 = MergeRequest 1580 "https://git.kwankodev.net/" "addons/api-fronto"

-- parse a merge request URI
parseMergeRequest :: String -> Maybe MergeRequest
parseMergeRequest = undefined

-- print a merge request
printMergeRequest :: MergeRequest -> String
printMergeRequest (MergeRequest id base project) = base ++ project ++ "/merge_requests/" ++ show id