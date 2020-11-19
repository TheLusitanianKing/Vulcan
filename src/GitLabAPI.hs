module GitLabAPI (
  prepareGitLabRequest  
) where

import qualified Data.ByteString.Char8 as C8
import qualified Data.CaseInsensitive as CI
import Network.HTTP.Simple (
    defaultRequest,
    setRequestHeaders,
    setRequestHost,
    setRequestMethod,
    setRequestPath,
    setRequestPort,
    setRequestQueryString,
    setRequestSecure,
    Request)

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