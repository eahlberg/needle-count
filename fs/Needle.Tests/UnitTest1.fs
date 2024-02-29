namespace Needle.Tests

open System
open NUnit.Framework
open Needle

[<TestFixture>]
type TestClass() =

    [<Test>]
    member this.EmptyHaystack() = Assert.True(Lib.count "a" "" = 0)

    [<Test>]
    member this.DoesntCountOverlappingMatch() = Assert.True(Lib.count "aa" "aaa" = 1)

    [<Test>]
    member this.NoMatch() = Assert.True(Lib.count "a" "b" = 0)

    [<Test>]
    member this.ExactMatch() = Assert.True(Lib.count "a" "a" = 1)

    [<Test>]
    member this.PrefixMatch() = Assert.True(Lib.count "a" "ab" = 1)

    [<Test>]
    member this.InfixMatch() = Assert.True(Lib.count "a" "bac" = 1)

    [<Test>]
    member this.PostfixMatch() = Assert.True(Lib.count "a" "bca" = 1)

    [<Test>]
    member this.MultipleMatches() = Assert.True(Lib.count "a" "a a" = 2)

    [<Test>]
    member this.ConcatenatedMatch() = Assert.True(Lib.count "a" "aa" = 2)
