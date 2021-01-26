{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import Test.QuickCheck
import TestMergeRequest (mergeRequestTests)

main :: IO ()
main = hspec $ do
  mergeRequestTests