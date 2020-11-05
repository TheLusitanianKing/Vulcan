module Main where

import System.Environment (getArgs)

main :: IO ()
main = interact $ action
    
action :: String -> String
action = undefined