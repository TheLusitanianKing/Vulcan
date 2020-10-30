-- Handle GitLab merge requests
module MergeRequest where
    -- export only interesting things

data MergeRequest = MergeRequest {
    mergeRequestId      :: Int,
    mergeRequestBaseURL :: String,
    mergeRequestProject :: String
} deriving (Show)

-- merge request typical examples :
-- https://git.kwankodev.net/kwanko/kwanko-members/merge_requests/2939/diffs
mr1 = MergeRequest 2939 "https://git.kwankodev.net/" "kwanko/kwanko-members"
-- https://git.kwankodev.net/kwanko/kwanko-api-backend/merge_requests/1993/diffs
mr2 = MergeRequest 1993 "https://git.kwankodev.net/" "kwanko/kwanko-api-backend"
-- https://git.kwankodev.net/addons/api-fronto/merge_requests/1580
mr3 = MergeRequest 1580 "https://git.kwankodev.net/" "addons/api-fronto"

parseMergeRequest :: String -> Maybe MergeRequest
parseMergeRequest = undefined

printMergeRequest :: MergeRequest -> String
printMergeRequest (MergeRequest id base project) = base ++ project ++ "/merge_requests/" ++ show id