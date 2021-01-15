-- |
-- Module      : MergeRequest
-- Description : Handle merge requests URI parsing the information it can get only from the URL
-- License     : MIT
-- Maintainer  : The Lusitanian King <alexlusitanian@gmail.com>
module MergeRequest where

import Text.Regex.PCRE ((=~))

-- | Extracted data from a merge request URI
data MergeRequestURL = MergeRequestURL {
    mergeRequestId      :: Int,    -- ^ its ID, e.g. 18835
    mergeRequestBaseURL :: String, -- ^ its base URL, e.g. "https://git.something.com"
    mergeRequestProject :: String  -- ^ the project name
} deriving (Eq)

instance Show MergeRequestURL where
    show (MergeRequestURL id base project) = base ++ "/" ++ project ++ "/merge_requests/" ++ show id

-- | Parse a merge request URL
parseMergeRequest :: String -> Maybe MergeRequestURL
parseMergeRequest s =
    case matched of
        (_, _, _, b:p:id:_) -> Just (MergeRequestURL (read id) b (projectName p))
        _                   -> Nothing
    where matched = s =~ "(https?://[\\w.]*)/([\\w-]+/[\\w-]+)[/-]*/merge_requests/(\\d+)"
                    :: (String, String, String, [String])
          projectName p = tail name
                where (_, name) = break (=='/') p