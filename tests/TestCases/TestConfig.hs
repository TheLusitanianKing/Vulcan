{-# LANGUAGE OverloadedStrings #-}

module TestConfig where

import Config
import GitLab (defaultGitLabServer)
import GitLab.Types (GitLabServerConfig(..))
import Test.Hspec

config, config', config'' :: Configuration
config  = [("token", "thisisatoken"), ("url", "https://gitlab.com"), ("favoriteClub", "Sport Lisboa e Benfica")]
config' = [("viriato", "Viseu"), ("Portugal", "Lusitania")]
config'' = [("nbCommits", "2")]

configTests :: Spec
configTests = do
  describe "Testing Vulcan configuration..." $ do
    it "Retrieve number of commit to display without custom configuration" $ do
      nbCommitsFromConfig config
      `shouldBe`
      (5 :: Int)

    it "Retrieve number of commit to display without custom configuration (2)" $ do
      nbCommitsFromConfig config'
      `shouldBe`
      (5 :: Int)

    it "Retrieve number of commit to display with custom configuration" $ do
      nbCommitsFromConfig config''
      `shouldBe`
      (2 :: Int)