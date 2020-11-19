module Submodule where

import Data.ConfigFile (emptyCP, readfile, to_string)
import Data.Either.Utils (forceEither)

data Submodule = Submodule {
    submoduleId   :: Int,
    submoduleName :: String
} deriving (Eq, Show)

-- retrieveSubmodulesFromConfigurationFile :: FilePath -> IO (Maybe [Submodule])
retrieveSubmodulesFromConfigurationFile :: FilePath -> IO ()
retrieveSubmodulesFromConfigurationFile m = do
    val <- readfile emptyCP m
    putStrLn "Your setting is:"
    putStrLn . to_string . forceEither $ val