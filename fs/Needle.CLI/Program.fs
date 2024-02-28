open System.IO
open Needle
open FParsec

let readFile (f:string) =
  if File.Exists(f)
    then
      Choice1Of2(System.IO.File.ReadAllText f)
    else
      Choice2Of2("File does not exist: " + f)

let needleParser = many1Chars (noneOf ".") .>> pstring "."

[<EntryPoint>]
let main argv =
     match Array.tryHead argv with
      | None ->
        printf "Argument missing"
        exit 1
      | Some path ->
        match readFile path with
          | Choice2Of2(errorMsg) ->
            printf "%s" errorMsg
            exit 1
          | Choice1Of2(contents) ->
            let fileName = Path.GetFileName(path)
            match run needleParser fileName with
            | Failure(errorMsg, _, _) ->
              printf "%s" errorMsg
              exit 1
            | Success(needle, _, _) ->
              let result = Count.needles needle contents
              printf "found %i" result
              exit 0
