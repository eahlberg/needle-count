# Needle count
Given a path to a file `foo.txt`, count how many times `foo` occurs in
`foo.txt`.

The Haskell implementation is in `hs/` and the FSharp implementation in `fs/`.

The code has been developed and tested on Linux.

## Dev environment
The Haskell project uses [cabal](https://cabal.readthedocs.io/en/stable/)
(specifically `ghc` version `9.4.8, but it'll likely work with other versions
as well).

The FSharp project uses `dotnet` version `8.0.101`.

For Nix users, `shell.nix` provides all the tools needed.

For non-Nix users, the easiest way would probably be to follow the instructions
at the respective tools:
 - [cabal](https://cabal.readthedocs.io/en/stable/getting-started.html)
 - [dotnet](https://dotnet.microsoft.com/en-us/download)

## Tests
There are two types of tests:
- unit tests
- end-to-end (e2e) tests

Unit tests can be found in the respective project directories. E2E tests can be
found in `e2e-test.sh` and the files needed are in the `e2e-test` dir. N.B.:
the e2e tests may not work on other platforms than Linux.

It should be possible to run the tests from the project directory, see
`Makefile`.