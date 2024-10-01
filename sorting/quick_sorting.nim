{.push raises: [].}

runnableExamples:
  var array = @[3, 1, 2]
  quickSorting(array)

proc partition[T](a: var openArray[T], low, high: int): int =
  var i = low - 1
  let pivot = a[high]
  for j in low .. high:
    if a[j] < pivot:
      inc i
      swap a[i], a[j]
  swap a[i + 1], a[high]
  return i + 1

proc sort[T](a: var openArray[T], low, high: int) = 
  if low < high:
    var pi = partition(a, low, high)
    sort(a, low, pi - 1)
    sort(a, pi + 1, high)

proc quickSorting*[T](a: var openArray[T]) =
  if a.len == 0:
    raise newException(ValueError, "Nilai Tidak Boleh Kosong")
  sort(a, 0, a.high)

when isMainModule:
  import std/unittest

  suite "Testing Quick Sorting":
    test "test fungsi quick sorting":
      var array = @[3, 1, 2]
      quickSorting(array)
