namespace Needle.Tests

open System
open NUnit.Framework
open Needle

[<TestFixture>]
type TestClass () =

    [<Test>]
     member this.EmptyHaystack() = Assert.True(Count.needles "a" "" = 0)

    [<Test>]
     member this.DoesntCountOverlappingMatch() = Assert.True(Count.needles "aa" "aaa" = 1)

    [<Test>]
     member this.NoMatch() = Assert.True(Count.needles "a" "b" = 0)

    [<Test>]
     member this.ExactMatch() = Assert.True(Count.needles "a" "a" = 1)

    [<Test>]
     member this.PrefixMatch() = Assert.True(Count.needles "a" "ab" = 1)

    [<Test>]
     member this.InfixMatch() = Assert.True(Count.needles "a" "bac" = 1)

    [<Test>]
     member this.PostfixMatch() = Assert.True(Count.needles "a" "bca" = 1)

    [<Test>]
     member this.MultipleMatches() = Assert.True(Count.needles "a" "a a" = 2)

    [<Test>]
     member this.ConcatenatedMatch() = Assert.True(Count.needles "a" "aa" = 2)
