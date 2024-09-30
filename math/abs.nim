{.push raises: [].}

runnableExamples:
  assert absVal(-5.1) == 5.1
  assert absMin(@[-1, 2, -3]) == 1
  assert absMax(@[-1, 2, -3]) == 3

func absVal*[T: SomeFloat](angka: T): T =
  # mengembalikan nilai absolut dari angka
  return if angka < 0.0: -angka else: angka

func absVal*[T: SomeInteger](angka: T): Natural = (if angka <
    0: -angka else: angka)

func absMin*(x: openArray[int]): Natural {.raises: [ValueError].} =
  # mengembalikan nilai element terkecil dari nilai absolute dalam sebuah sekuens
  if x.len == 0:
    raise newException(ValueError, "Tidak bisa menemukan nilai absolut terkecil")
  result = absVal(x[0])
  for i in 1 ..< x.len:
    if absVal(x[i]) < result:
      result = absVal(x[i])

func absMax*(x: openArray[int]): Natural {.raises: [ValueError].} =
  # mengembalikan nilai element terbesar dari nilai absolute dalam sebuah sekuens
  if x.len == 0:
    raise newException(ValueError, "Tidak bisa menemukan nilai absolut maksimum dari sekuens yang kosong")
  result = absVal(x[0])
  for i in 1 ..< x.len:
    if absVal(x[i]) > result:
      result = absVal(x[i])

when isMainModule:
  import std/[unittest, random]
  randomize()

  suite "Test AbsVal":
    test "test fungsi absVal":
      check:
        absVal(11.2) == 11.2
        absVal(5) == 5
        absVal(-5.1) == 5.1

  suite "Test absMin":
    test "test fungsi absMin":
      check:
        absMin(@[-1, 2, -3]) == 1
        absMin(@[3, -10, -2]) == 2
        absMin([3, -10, -2]) == 2

    test "absMin jika sekuensnya kosong":
      doAssertRaises(ValueError):
        discard absMin(@[])

  suite "Test absMax":
    test "test fungsi absMax":
      check:
        absMax(@[0, 5, 1, 11]) == 11
        absMax(@[-1, 2, -3]) = 3

    test "`absMax` jika sekuensnya kosong":
      doAssertRaises(ValueError):
        discard absMax(@[])
