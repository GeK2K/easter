##[
======
easter
======
The function of this module returns the **Gregorian 
Easter Sunday** of the year given to it as a parameter.

This calculation engine is useful because the day of 
Easter varies from year to year (unlike Christmas, 
for example, which is always December 25th).

From a historical point of view, the Gregorian calendar 
came into effect on October 15th, 1582. **The Gregorian 
Easter day therefore only makes sense from the year 1583**.
]##


# =========================     Imports / Exports     ======================== #

import  std/[math, options]
export  options


# ===============================     Proc     =============================== #

func  gregorianEasterSundayMMDD*(year: int): 
                                Option[tuple[month: int, monthday: int]] =
  ##[
  **Returns:**
    - The date of Gregorian Easter Sunday of the 
      year given in parameter if `year >= 1583`.
    - `none((int, int))` if `year < 1583`.
  
  **Algorithm:**
    - https://en.wikipedia.org/wiki/Date_of_Easter#Anonymous_Gregorian_algorithm
  
  **Notes:**

    The results provided by this procedure have been 
    **successfully compared** to the 518 Gregorian Easter 
    days of the **years 1583 to 2100**.
    These Gregorian Easter days can be viewed here:	    	
    - http://palluy.fr/index.php?page=1583-a-1600-apres-paques
    - https://www.census.gov/data/software/x13as/genhol/easter-dates.html
  ]##

  runnableExamples:
    doAssert:  gregorianEasterSundayMMDD(1200).isNone
    doAssert:  gregorianEasterSundayMMDD(1582).isNone
    doAssert:  gregorianEasterSundayMMDD(2000).get == (month: 4, monthday: 23)
    doAssert:  gregorianEasterSundayMMDD(2018).get == (month: 4, monthday: 1) 
    doAssert:  gregorianEasterSundayMMDD(2036).get == (month: 4, monthday: 13)
    doAssert:  gregorianEasterSundayMMDD(2054).get == (month: 3, monthday: 29)
    doAssert:  gregorianEasterSundayMMDD(2071).get == (month: 4, monthday: 19) 
    doAssert:  gregorianEasterSundayMMDD(2097).get == (month: 3, monthday: 31)

  if year >= 1583:
    let a = year mod 19
    let b = year div 100
    let c = year mod 100
    let (d,e) = divmod(b,4)  # instead of: d = b div 4; e = b mod 4
    #let f = (b+8) div 25
    let g = (8*b+13) div 25
    let h = (19*a+b-d-g+15) mod 30
    let (i,k) = divmod(c,4)  # instead of: i = c div 4; k = c mod 4
    let l = (32+2*e+2*i-h-k) mod 7
    let m = (a+11*h+19*l) div 433
    let n = (h+l-7*m+90) div 25
    #let o = (h+l-7*m+114) mod 31
    let p = (h+l-7*m+33*n+19) mod 32
    result = some((n, p))

func julianEasterSundayMMDD*(year: int):
                                  Option[tuple[month: int, monthday: int]]=
  #[
  The algorithm is taken from the same wikipedia article

    - https://en.wikipedia.org/wiki/Date_of_Easter#Meeus's_Julian_algorithm
    
  ]#

  if year > 33:
    let a = year mod 4
    let b = year mod 7
    let c = year mod 19
    let d = (19*c + 15) mod 30
    let e = (2*a+4*b-d+34) mod 7
    let month = (d+e+114) div 31
    let day = ((d+e+114) mod 31) + 1
    result = some((month, day))

let iooo = gregorianEasterSundayMMDD(2024)
let daaa = julianEasterSundayMMDD(2024)

echo iooo
echo daaa
