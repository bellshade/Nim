if defined(release) or defined(danger):
  --opt: speed
  --passC: "-flto"
  --passL: "-flto"
  --passL: "-s"
else:
  --checks: on
  --assertions: on
  --spellSuggest
  --styleCheck: error

--mm:arc

import std/[os, sequtils]
from std/strutils import startsWith, endsWith
from std/strformat import `&`

const IgnorePathPrefixes = ["."]

func isIgnored(path: string): bool =
  IgnorePathPrefixes.mapIt(path.startsWith(it)).anyIt(it)

iterator modules(dir: string = getCurrentDir()): string =
  for path in walkDirRec(dir, relative = true):
    if not path.isIgnored() and path.endsWith(".nim"):
      yield path

############ Tasks
task test, "Test semuanya":
  --warning: "BareExcept:off"
  --hints: off
  var failedUnits: seq[string]

  for path in modules():
    echo &"Testing {path}:"
    try: selfExec(&"-f --warning[BareExcept]:off --hints:off r \"{path}\"")
    except OSError:
      failedUnits.add(path)
  if failedUnits.len > 0:
    echo "Test yang Gagal:"
    for path in failedUnits:
      echo &"- {path}"
    quit(1)
  else:
    echo "Semua Test Berjalan dengan baik"

task prettyfy, "Run nimpretty untuk semua file":
  for path in modules():
    exec(&"nimpretty --indent:2 \"{path}\"")
