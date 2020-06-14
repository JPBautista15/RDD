clear all

import delimited C:\Users\sk8el\Desktop\RDD\Data\hansen_dwi.csv

****3)

gen D = 0
replace D = 1 if bac1>= 0.08 

**** 4)

rddensity bac1, c(0.08) all
twoway(hist bac1, freq bin(1000) col(gray))(scatteri 0 0.08 2000 0.08, c(l) m(i) lc(black)), title(BAC Histogram) xtitle(BAC) ytitle(Frequency)

**** 4)

foreach var of varlist male white aged acc {
reg `var' D,robust
estimates store `var'
}

outreg2 [male white aged acc]using table1.doc

*** 6)
cmogram male bac1, cut(0.08) scatter line(0.08) lfit
cmogram white bac1, cut(0.08) scatter line(0.08) lfit
cmogram aged bac1, cut(0.08) scatter line(0.08) lfit
cmogram acc bac1, cut(0.08) scatter line(0.08) lfit

*** 7)

reg recidivism D bac1 year white male aged  if bac1>=0.03 & bac1<=0.13, robust
estimates store reg1

gen bac1D = bac1*D
reg recidivism D bac1 bac1D year white male aged if bac1>=0.03 & bac1<=0.13, robust
estimates store reg2

gen bac2D = bac2*D
reg recidivism D bac1 bac1D bac2D year white male aged if bac1>=0.03 & bac1<=0.13, robust
estimates store reg3

outreg2 [reg1 reg2 reg3] using table7.doc


reg recidivism D bac1 year white male aged  if bac1>=0.055 & bac1<=0.105, robust
estimates store reg4

reg recidivism D bac1 bac1D year white male aged if bac1>=0.055 & bac1<=0.105, robust
estimates store reg5

reg recidivism D bac1 bac1D bac2D year white male aged if bac1>=0.055 & bac1<=0.105, robust
estimates store reg6

outreg2 [reg4 reg5 reg6] using table71.doc

*** 8)

drop if bac1>0.15
cmogram recidivism bac1, cut(0.08) scatter line(0.08) lfit
cmogram recidivism bac1, cut(0.08) scatter line(0.08) qfit




