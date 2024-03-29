﻿open System.IO
open Needle
open FParsec

let readFile (f: string) =
    if File.Exists(f) then
        Choice1Of2(System.IO.File.ReadAllText f)
    else
        Choice2Of2("File not found")

let needleParser = many1Chars (noneOf ".") .>> pstring "."

[<EntryPoint>]
let main argv =
    if Array.length argv > 1 then
        printf "Too many arguments, expected one argument"
        exit 1
    else
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
                    let result = Lib.count needle contents
                    printf "found %i" result
                    exit 0
