module Main (main) where

import qualified NeedleSpec
import Test.Hspec.Formatters
import Test.Hspec.Runner
import Prelude

main :: IO ()
main = hspecWith defaultConfig {configFormatter = Just progress} NeedleSpec.spec
