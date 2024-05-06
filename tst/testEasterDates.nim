import  std/[options, strutils, times]
import  easter


# tests on the years 1583 to 1599 and the year 2100
doAssert:  gregorianEasterSundayMMDD(1583).get == (month: 4, monthday: 10)
doAssert:  gregorianEasterSundayMMDD(1584).get == (month: 4, monthday:  1)
doAssert:  gregorianEasterSundayMMDD(1585).get == (month: 4, monthday: 21)
doAssert:  gregorianEasterSundayMMDD(1586).get == (month: 4, monthday:  6)
doAssert:  gregorianEasterSundayMMDD(1587).get == (month: 3, monthday: 29)
doAssert:  gregorianEasterSundayMMDD(1588).get == (month: 4, monthday: 17)
doAssert:  gregorianEasterSundayMMDD(1589).get == (month: 4, monthday:  2)
doAssert:  gregorianEasterSundayMMDD(1590).get == (month: 4, monthday: 22)
doAssert:  gregorianEasterSundayMMDD(1591).get == (month: 4, monthday: 14)
doAssert:  gregorianEasterSundayMMDD(1592).get == (month: 3, monthday: 29)
doAssert:  gregorianEasterSundayMMDD(1593).get == (month: 4, monthday: 18)
doAssert:  gregorianEasterSundayMMDD(1594).get == (month: 4, monthday: 10)
doAssert:  gregorianEasterSundayMMDD(1595).get == (month: 3, monthday: 26)
doAssert:  gregorianEasterSundayMMDD(1596).get == (month: 4, monthday: 14)
doAssert:  gregorianEasterSundayMMDD(1597).get == (month: 4, monthday:  6)
doAssert:  gregorianEasterSundayMMDD(1598).get == (month: 3, monthday: 22)
doAssert:  gregorianEasterSundayMMDD(1599).get == (month: 4, monthday: 11)
doAssert:  gregorianEasterSundayMMDD(2100).get == (month: 3, monthday: 28)


# tests on the years 1600 to 2099
let file = open("EasterDaysObserved.txt")
try:
  var line : string
  while file.readLine(line):
    if line[0] == '#':  continue  # comment lines are ignored
    let splitLine = line.splitWhitespace
    doAssert: splitLine.len == 3
    let month = splitLine[0].parseInt.Month
    let monthday = splitLine[1].parseInt.MonthdayRange 
    let year = splitLine[2].parseInt
    let easterSundayObserved = (month: month, monthday: monthday)    
    let easterSundayCalculated = block:
      let easterSundayCalc = gregorianEasterSundayMMDD(year)
      doAssert: easterSundayCalc.isSome
      (month: easterSundayCalc.get.month.Month, 
       monthday: easterSundayCalc.get.monthDay.MonthdayRange)
    doAssert: easterSundayObserved == easterSundayCalculated
finally:
  close(file)