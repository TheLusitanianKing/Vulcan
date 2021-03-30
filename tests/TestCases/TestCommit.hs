{-# LANGUAGE OverloadedStrings #-}

module TestCommit where

import Commit (fit, indent)
import Test.Hspec hiding (fit)

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
        
        it "Make commit title fit the wanted size" $ do
            fit 20 "Académico de Viseu"
            `shouldBe`
            "Académico de Viseu  "
        
        it "Make commit title shorter to fit the wanted size" $ do
            fit 15 "HNK Hajduk Split"
            `shouldBe`
            "HNK Hajduk S..."
        
        it "Use fit on a commit that is already the wanted size" $ do
            fit 8 "Portugal"
            `shouldBe`
            "Portugal"