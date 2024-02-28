module LibSpec (spec) where

import Data.Text (Text)
import Needle.Lib (Needle, NeedleError (..), unNeedle)
import qualified Needle.Lib as Lib
import Test.Hspec
import Prelude

-- N.B. helper to make test cases cleaner
mkNeedleOrError :: Text -> Needle
mkNeedleOrError s =
  case Lib.parseNeedle s of
    Left e -> error $ show e
    Right needle -> needle

spec :: Spec
spec = do
  describe "parseNeedle" $ do
    it "errors if needle is empty" $ do
      Lib.parseNeedle "" `shouldBe` Left NeedleEmpty

    it "parse valid needle" $ do
      case Lib.parseNeedle "a" of
        Left e -> fail $ show e
        Right needle -> unNeedle needle `shouldBe` "a"

  describe "count" $ do
    it "returns 0 if haystack is empty" $ do
      Lib.count (mkNeedleOrError "a") "" `shouldBe` 0

    it "doesn't count overlapping matches" $ do
      Lib.count (mkNeedleOrError "aa") "aaa" `shouldBe` 1

    it "returns 0 if there's no match" $ do
      Lib.count (mkNeedleOrError "a") "b" `shouldBe` 0

    it "count exact match" $ do
      Lib.count (mkNeedleOrError "a") "a" `shouldBe` 1

    it "count prefix" $ do
      Lib.count (mkNeedleOrError "a") "ab" `shouldBe` 1

    it "count infix" $ do
      Lib.count (mkNeedleOrError "a") "bac" `shouldBe` 1

    it "count postfix" $ do
      Lib.count (mkNeedleOrError "a") "bca" `shouldBe` 1

    it "count multiple matches" $ do
      Lib.count (mkNeedleOrError "a") "a a" `shouldBe` 2

    it "count concatenated matches" $ do
      Lib.count (mkNeedleOrError "a") "aa" `shouldBe` 2
