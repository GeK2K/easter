# Easter

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


## Introduction

Unlike Christmas which is always on December 25, the date of Easter Sunday varies from year to year. However, there are algorithms that allow you to calculate this date for any past, present or future year.

The algorithm that was implemented in this module is described [here][1] and its results were **successfully compared to the 518 Easter Sunday dates** that can be found on these webpages:

  - http://palluy.fr/index.php?page=1583-a-1600-apres-paques
  - https://www.census.gov/data/software/x13as/genhol/easter-dates.html


## Compatibility

Nim +2.0.0


## Main dependencies

Nim standard library only.

## Getting started

Install `easter` using `nimble`:

```text
nimble install easter
```

or add a dependency to the `.nimble` file of your project:

```text
requires "easter >= 0.1.0"
```

and start using it:

```nim
import easter

let easterSunday2054 = gregorianEasterSundayMMDD(2054)

# the 'gregorianEasterSundayMMDD' proc returns an Option
# for the reasons given in the documentation

doAssert:  easterSunday2054 is Option[(int, int)]
doAssert:  get(easterSunday2054) == (month: 3, monthday: 29)
```


## Documentation

[API Reference](https://gek2k.github.io/easter/)


[1]: https://en.wikipedia.org/wiki/Date_of_Easter#Anonymous_Gregorian_algorithm
[2]: https://github.com/nim-lang/nimble
