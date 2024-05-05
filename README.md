Easter
======

The date of Easter varies from year to year but this date can be calculated 
for any year (past, present or future). This is what the main `proc` of this 
module does: for a given year, it returns the Gregorian Easter Sunday of the
corresponding year. The implemented algorithm is described [here][1].

Installation
------------

Use the [Nimble][2] package manager to add `easter` to an 
existing project. Add the following to its .nimble file:

```nim
requires "easter >= 0.1.0 & < 0.2.0"
```

Usage
-----

```nim
import easter

# the 'gregorianEasterSundayMMDD' proc returns an Option 
# so we use the 'get' proc to get the value
let easterSunday2054 = gregorianEasterSundayMMDD(2054).get

doAssert:  easterSunday2054 == (month: 3, monthday: 29)
```


[1]: https://en.wikipedia.org/wiki/Date_of_Easter#Anonymous_Gregorian_algorithm
[2]: https://github.com/nim-lang/nimble