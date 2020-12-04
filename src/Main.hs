module Main where

import API (fetchMergeRequest)
import MergeRequest (parseMergeRequest)
import System.Environment (getArgs)

main :: IO ()
main = do
    args <- getArgs
    case args of
        []      -> putStrLn "..."
        (arg:_) -> handleMergeRequest arg

handleMergeRequest :: String -> IO ()
handleMergeRequest m =
    case parsedMR of
        Nothing -> putStrLn "..."
        Just m -> do
            mr <- fetchMergeRequest m
            putStrLn . show $ mr
    where parsedMR = parseMergeRequest m