{-# LANGUAGE OverloadedStrings #-}

import Test.Hspec
import Test.QuickCheck
import TestCommit (commitTests)
import TestConfig (configTests)
import TestMergeRequest (mergeRequestTests)

main :: IO ()
main = hspec $ do
    commitTests
    configTests
    mergeRequestTests