module Submodule where

data Submodule = Submodule {
    submoduleId   :: Int,
    submoduleName :: String
} deriving (Eq, Show)


fromRaw :: (String, Int) -> Submodule
fromRaw (s, i) = Submodule i s

-- TODO: get this from configuration, not from here
submodulesRaw :: [(String, Int)]
submodulesRaw = [
        ("something", 39),
        ("something/else", 72)
    ]

submodules :: [Submodule]
submodules = map fromRaw submodulesRaw

    
-- TODO: improve this
retrieveSubmodulesFromConfiguration :: FilePath -> IO (Maybe [Submodule])
retrieveSubmodulesFromConfiguration = undefined