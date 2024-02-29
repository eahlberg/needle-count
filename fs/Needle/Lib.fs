namespace Needle

open System.IO

module Lib =
  let count (needle: string) (haystack: string) =
      let rec go (needle: string) (hay: string) (count: int) =
          let hayLength = String.length hay
          let hayEmpty = hayLength = 0
          if hayEmpty then count
          else
              match hay.IndexOf(needle) with
              | -1 -> count
              | needleIndex ->
                  let nextIndex = String.length needle + needleIndex
                  let rest = hay[nextIndex .. hayLength - 1]
                  go needle rest (count + 1)

      go needle haystack 0
