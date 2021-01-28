{-# LANGUAGE OverloadedStrings #-}

module TestCommit where

import Commit (indent)
import Test.Hspec

commitTests :: Spec
commitTests = do
    describe "Testing commit formatting..." $ do
        it "No indentation" $ do
            indent 0 "Sport Lisboa e Benfica"
            `shouldBe`
            "Sport Lisboa e Benfica"

        it "Simple indentation" $ do
            indent 4 "West Ham United"
            `shouldBe`
            "    West Ham United"