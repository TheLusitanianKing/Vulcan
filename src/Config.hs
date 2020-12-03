module Config (server) where

import GitLab (defaultGitLabServer)
import GitLab.Types (GitLabServerConfig(..))
import qualified Data.Text as T

server :: GitLabServerConfig
server = (defaultGitLabServer { url = T.pack "https://gitlab.com", token = T.pack "ELLAJvrdz2H3YoMzcPvm" })