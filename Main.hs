module Main where

import System.Environment (getArgs)
import MergeRequest (parseMergeRequest, printMergeRequest)

main :: IO ()
main = getArgs >>= (\args ->
    case args of
        [] -> putStrLn "Please give a merge request.."
        _  -> putStrLn . action . head $ args
    )

    
action :: String -> String
action m =
    case parsed of
        Nothing -> "This isn't a merge request!"
        Just x  -> "This is a valid merge request: " ++ printMergeRequest x
    where parsed = parseMergeRequest m