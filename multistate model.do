*Multistatet modeling
use "data.dta", clear
mat tmat = (., 1, .\., ., 2\., ., .)
mat colnames tmat = to:start to:fcm to:cmm
mat rownames tmat = from:start from:fcm from:cmm
mat list tmat
msset, id(n_eid) states(fcm cmm) times(fcm_date cmm_date) transm(tmat)
mat tmat = r(transmatrix)
mat list tmat
stset _stop, enter(_start) failure(_status==1) scale(365.25)
local exposures "rc tg"
foreach exp of local exposures {
    stmerlin `exp'_cat2 `exp'_cat3 `exp'_cat4 `exp'_cat5  if _trans == 1, dist(rp) df(3) tvc(age) dftvc(1)
    est store m1
    stmerlin `exp'_cat2 `exp'_cat3 `exp'_cat4 `exp'_cat5  if _trans == 2, dist(rp) df(3) tvc(age) dftvc(1)
    est store m2
}


