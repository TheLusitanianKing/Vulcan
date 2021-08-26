module TestMergeRequest where

import MergeRequest
import Test.Hspec

mergeRequestTests :: Spec
mergeRequestTests = do
    describe "Testing merge request URL parsing..." $ do
        it "Parsing correct merge request URL" $ do
            parseMergeRequest "https://git.test.com/project/api-backend/merge_requests/2101"
            `shouldBe`
            (Just $
                MergeRequestURL
                    { _mergeRequestId = 2101
                    , _mergeRequestProject = "api-backend"
                    , _mergeRequestBaseURL = "https://git.test.com"
                    })

        it "Parsing correct merge request URL (2)" $ do
            parseMergeRequest "https://gitlab.com/TheLusitanianKing/Lusitania/-/merge_requests/1"
            `shouldBe`
            (Just $
                MergeRequestURL
                    { _mergeRequestId = 1
                    , _mergeRequestProject = "Lusitania"
                    , _mergeRequestBaseURL = "https://gitlab.com"
                    })

        it "Parsing merge request URL with wrong number" $ do
            parseMergeRequest "https://gitlab.com/TheLusitanianKing/project/-/merge_requests/ekgkle"
            `shouldBe`
            Nothing

        it "Parsing malformed merge request URL" $ do
            parseMergeRequest "https://gitlab.com/merge_requests/ekgkle"
            `shouldBe`
            Nothing

        it "Parsing malformed merge request URL (2)" $ do
            parseMergeRequest "https://gitlab.com/TheLusitanianKing/merge_requests/ekgkle"
            `shouldBe`
            Nothing

        it "Parsing malformed merge request URL (3)" $ do
            parseMergeRequest "https://gitlab.com/TheLusitanianKing////merge_requests/ekgkle"
            `shouldBe`
            Nothing