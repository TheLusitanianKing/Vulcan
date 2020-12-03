module Main where

import System.Environment (getArgs)
import MergeRequest (parseMergeRequest, printMergeRequest)

main :: IO ()
main = getArgs >>=
    (\args ->
        case args of
            [] -> putStrLn "I can't work if you don't give me something"
            _  -> putStrLn . unlines . map action $ args
    )

action :: String -> String
action m =
    case parsed of
        Nothing -> m ++ " isn't a merge request!"
        Just x  -> "Ok, this is a valid merge request: " ++ printMergeRequest x
    where parsed = parseMergeRequest m