module Config (
    server,
    serverFromMergeRequest
) where

import qualified Data.Text as T
import GitLab (defaultGitLabServer)
import GitLab.Types (GitLabServerConfig(..))
import MergeRequest (MergeRequestURI(..))

-- TODO: handle configuration to get default URI and token
server :: GitLabServerConfig
server = (defaultGitLabServer { url = T.pack "https://gitlab.com", token = T.pack "ELLAJvrdz2H3YoMzcPvm" })

serverFromMergeRequest :: MergeRequestURI -> GitLabServerConfig
serverFromMergeRequest (MergeRequestURI _ url _) =
    (defaultGitLabServer { url = T.pack url, token = T.pack "ELLAJvrdz2H3YoMzcPvm" })