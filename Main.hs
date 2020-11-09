module Main where

import System.Environment (getArgs)
import MergeRequest (parseMergeRequest, printMergeRequest)

main :: IO ()
main = getArgs >>=
    (\args ->
        case args of
            [] -> putStrLn "Give me a merge request you little punk"
            _  -> putStrLn . action . head $ args
    )

    
action :: String -> String
action m =
    case parsed of
        Nothing -> "This isn't a merge request punk!"
        Just x  -> "Ok, this is a valid merge request: " ++ printMergeRequest x
    where parsed = parseMergeRequest m