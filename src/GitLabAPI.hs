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
    Request,
    QueryItem)

prepareGitLabRequest :: String -> [(String, Maybe String)] -> Request
prepareGitLabRequest path queries =
            setRequestPath (C8.pack "/api/v4" `C8.append` C8.pack path)
            $ setRequestHost (C8.pack "gitlab.com")
            -- TODO: put authorization bearer into configuration file + revoke it as it has been disclosed
            $ setRequestHeaders [(CI.mk (C8.pack "Authorization"), C8.pack "Bearer ELLAJvrdz2H3YoMzcPvm")] 
            $ setRequestQueryString (map transformQueryToByteString queries)
            $ setRequestMethod (C8.pack "GET")
            $ setRequestSecure True
            $ setRequestPort 443
            $ defaultRequest
    
transformQueryToByteString :: (String, Maybe String) -> QueryItem
transformQueryToByteString (s, x) =
    case x of
        Just v  -> (C8.pack s, Just (C8.pack v))
        Nothing -> (C8.pack s, Nothing)