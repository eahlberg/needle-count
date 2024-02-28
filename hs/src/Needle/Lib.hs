module Needle.Lib
  ( count,
    parseNeedle,
    unNeedle,
    NeedleError (..),
    Needle,
  )
where

import qualified Data.List as List
import Data.Text (Text)
import qualified Data.Text as Text
import Numeric.Natural (Natural)
import Prelude

data NeedleError = NeedleEmpty deriving (Eq, Show)

parseNeedle :: Text -> Either NeedleError Needle
parseNeedle needle = if Text.null needle then Left NeedleEmpty else Right $ Needle needle

newtype Needle = Needle {unNeedle :: Text} deriving (Eq, Show)

-- | N.B. We require a Needle since breakOnAll throws error on an empty needle.
count :: Needle -> Text -> Natural
count needle haystack =
  List.genericLength (Text.breakOnAll (unNeedle needle) haystack)
