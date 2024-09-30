{.push raises: [].}

runnableExamples:
  var array = @[3, 1, 2]
  bogoSorting(array)
  doAssert telahDisorting(array)

import random

func telahDisorting[T](array: openArray[T]): bool =
  for i in 0..<array.len - 1:
    if array[i] > array[i + 1]:
      return false
  return true

proc bogoSorting*[T](array: var openArray[T]) =
  while not telahDisorting(array):
    shuffle(array)

when isMainModule:
  import std/unittest
  suite "BogoSortingTest":
    test "test fungsi dari bogoSorting integer":
      var array = @[3, 1, 2]
      bogoSorting(array)
      check telahDisorting(array)

    test "sorting array dari string":
      var array = @["b", "c", "a"]
      bogoSorting(array)
      check telahDisorting(array)
