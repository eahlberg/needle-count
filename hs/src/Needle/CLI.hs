module Needle.CLI (main) where

import qualified Data.ByteString as BS
import Data.Text (Text)
import qualified Data.Text as Text
import qualified Data.Text.Encoding as Text
import Data.Text.Encoding.Error (UnicodeException (..))
import Needle.Lib (NeedleError (..), parseNeedle)
import qualified Needle.Lib as NeedleLib
import Options.Applicative
import qualified System.Directory as Dir
import System.Exit as System
import qualified System.FilePath as FilePath
import Prelude hiding (readFile)

newtype Arg = Arg {argFilePath :: String} deriving (Show)

data ReadFileError = FileNotFound | EncodingError UnicodeException

readFile :: String -> IO (Either ReadFileError Text)
readFile filePath = do
  fileExists <- Dir.doesFileExist filePath
  if not fileExists
    then pure $ Left FileNotFound
    else do
      eContents <- Text.decodeUtf8' <$> BS.readFile filePath
      case eContents of
        Left e -> pure $ Left $ EncodingError e
        Right contents -> pure $ Right contents

runApp :: Arg -> IO ()
runApp arg = do
  let filePath = argFilePath arg
  eContents <- readFile filePath
  case eContents of
    Left FileNotFound -> System.die "File not found"
    Left (EncodingError e) -> System.die $ show e
    Right haystack -> do
      let eNeedle = parseNeedle $ Text.pack $ FilePath.takeBaseName filePath
      case eNeedle of
        Left NeedleEmpty -> System.die "Search term missing"
        Right needle ->
          putStrLn $ "found " <> show (NeedleLib.count needle haystack)

main :: IO ()
main = execParser opts >>= runApp
  where
    argParser :: Parser Arg
    argParser = do
      Arg <$> strArgument (metavar "FILENAME")

    opts :: ParserInfo Arg
    opts =
      info
        (argParser <**> helper)
        ( fullDesc
            <> progDesc "Count occurences of search term in a given file"
        )
