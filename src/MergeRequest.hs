-- Handle GitLab merge requests
module MergeRequest where
    -- TODO: import only wanted functions

import Text.Regex.PCRE ((=~))
import GitLab (runGitLab)
import GitLab.API.Commits (projectCommits')
import GitLab.Types (Commit(..))
import Config (server)
import qualified Data.Text as T

-- extracted data of a merge request URI
data MergeRequestURL = MergeRequestURL {
    mergeRequestId      :: Int, -- its ID, e.g. 18835
    mergeRequestBaseURL :: String, -- its base URL, e.g. "https://git.something.com"
    mergeRequestProject :: String -- the concerned project, e.g. "myproject/subproject"
} deriving (Eq, Show)

-- parse a merge request URI
parseMergeRequest :: String -> Maybe MergeRequestURL 
parseMergeRequest s =
    case matched of
        (_, _, _, base:project:id:_) -> Just (MergeRequestURL (read id) base project)
        _                            -> Nothing
    where matched = s =~ "(https?://[\\w.]*)/([\\w-]*/[\\w-]*)/merge_requests/(\\d+)"
                    :: (String, String, String, [String])

-- print a merge request
printMergeRequest :: MergeRequestURL -> String
printMergeRequest (MergeRequestURL id base project) = base ++ "/" ++ project ++ "/merge_requests/" ++ show id

-- TODO: retrieve commit list from a merge request
-- mergeRequestCommits :: MergeRequest -> IO [Commit]
-- mergeRequestCommits :: MergeRequestURL -> IO ()
-- mergeRequestCommits (MergeRequestURL id _ _)= do
--     let config = server
--     mergeRequest <- runGitLab config (mergeRequest' pid)
--     case commits of
--         Left s -> error $ "Could not retrieve commits, status: " ++ show s
--         Right cs -> return ()
    