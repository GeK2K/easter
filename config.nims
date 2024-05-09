import  std/[os, sequtils, strformat, strutils]


# script parameters
# =================
const
  srcDir = "./src"
  binDir = "./bin"
  tstDir = "./tst"
  docDir = "./docs"
  mainfile = srcDir.joinPath("easter.nim")
  runTestsTasks = "runTests"
  gitUrl = "https://github.com/GeK2K/easter.git"


# procs
# =====
proc  nimCompilation(options = "", comment = "") =
  let taskStartBegin = "Start of task:  "
  let length = taskStartBegin.len + comment.len
  let line = '='.repeat(length)
  echo "\n", line, "\n", taskStartBegin, comment, "\n", line
  exec fmt"""nim  c  {options}  --mm:orc  """ &
       fmt"""--path:{srcDir}  --outdir:{binDir}  {mainfile}"""
  echo "==========="
  echo "End of task"
  echo "==========="


proc  runNimDoc() =
  echo "\n\n"
  echo "====================================="
  echo "Start of task:  document generation.."
  echo "====================================="
  exec "nim  doc  --project  --index:on  " &
       fmt"""--outdir:{docDir}  --git.url:{gitUrl}  {mainfile}""""
  exec fmt"""nim  buildindex  -o:{docDir}/index.html  {docDir}""""
  echo "==========="
  echo "End of task"
  echo "==========="


# tasks
# =====
task  buildApp, "":
  # user menu
  let usrMenu = """
What task(s) do you want to accomplish?

-1 = exit
 0 = compilation in danger mode
 1 = compilation in default mode
 2 = compilation in release mode
 3 = run tests
 4 = run nimdoc
"""
  # valid choices
  let validUsrChoices = (-1..4).mapIt($it)
  let validUsrChoicesStr = join(validUsrChoices, " ")
  while true:  # we stop only at the user's request
    # reading and validating user choices
    echo "\n", usrMenu
    let usrChoices = block:
      var usrChoices: seq[string]
      while true:
        echo "\n\nWaiting for your keyboard input..\n"
        let line = readLineFromStdin()
        if line.strip == "":
          echo "\nNothing has been entered. Please try again.\n\n"
          continue
        usrChoices = line.splitWhitespace()  
        let invalidUsrChoices = usrChoices.filterIt(it notin validUsrChoices).deduplicate
        let invalidUsrChoicesLen = invalidUsrChoices.len  
        if invalidUsrChoicesLen > 0:
          let invalidUsrChoicesStr = join(invalidUsrChoices, " ")
          echo fmt("\n\n{invalidUsrChoicesLen} invalid choice(s):  {invalidUsrChoicesStr}"),
               fmt("    (valid choices are:  {validUsrChoicesStr})\n\nPlease try again.")
          continue 
        break
      usrChoices
    # processing of user choices
    for c in usrChoices:
      if c == "-1":
        quit(QuitSuccess)
      elif c == "0":
        nimCompilation(options = "-d:danger", comment = "Nim compilation in danger mode..")
      elif c == "1":
        nimCompilation(options = "", comment = "Nim compilation in default mode..")
      elif c == "2":
        nimCompilation(options = "-d:release", comment = "Nim compilation in release mode..")
      elif c == "3": 
        # execution of the 'runTests' task defined in the './tst/config.nims' file
        withDir tstDir:
          selfExec runTestsTasks
      elif c == "4":
        runNimDoc()
      else:
        raise newException(ValueError, fmt("\nThe value {c} is not supported by the system !"))


# begin Nimble config (version 2)
when withDir(thisDir(), system.fileExists("nimble.paths")):
  include "nimble.paths"
# end Nimble config
