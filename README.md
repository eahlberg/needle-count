# Needle count
Given a path to a file `foo.txt`, count how many times `foo` occurs in
`foo.txt`.

The Haskell implementation is in `hs/` and the FSharp implementation in `fs/`.

The code has been developed and tested on Linux.

The FSharp program has to be run using `dotnet run` either in Needle.CLI, or
using the `--project` flag, e.g.
`dotnet run --project Needle.CLI/Needle.CLI.fsproj`.

## Assumptions
- If the program is given a path in another directory, e.g. `foo/foo.txt`, the
  term is assumed to be `foo.txt`, not `foo/foo.txt`.
- If the program is given a file `a.txt` with contents `aa`, the expected count
  is 2.
- If the program is given a file `aa.txt` with contents `aaa`, "overlapping"
  matches are not counted, i.e. the expected count is 1.
- The user running the program has to have permissions to read the file.

## Dev environment
The Haskell project uses [cabal](https://cabal.readthedocs.io/en/stable/)
(specifically `ghc` version `9.4.8`, but it'll likely work with other versions
as well).

The FSharp project uses `dotnet` version `8.0.101`.

For Nix users, `shell.nix` provides all the tools needed.

For non-Nix users, the easiest way would probably be to follow the instructions
for the respective tools:
 - [cabal](https://cabal.readthedocs.io/en/stable/getting-started.html)
 - [dotnet](https://dotnet.microsoft.com/en-us/download)

## Tests
There are two types of tests:
- unit tests
- end-to-end (e2e) tests

Unit tests can be found in the respective project directories. E2E tests can be
found in `e2e-test.sh` and the files needed are in the `e2e-test` dir.

_N.B.: the e2e tests may not work on other platforms than Linux._

It should be possible to run the tests from the project directory, see
`Makefile`.

## Caveats
- The goal is that the code should lean more towards readability and simplicity
  rather than performance and complexity, e.g in the usage of advanced language
  features and extensions.
- The F# version doesn't use libraries for things where it could be warranted
  (e.g. argument parsing). This is mostly due to lack of familiarity with the
  ecosystem.
