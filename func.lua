-- List of functions: 

--[[

.add(x, y) -- add x with y (x+y)

.sub(x, y) -- subtract x with y (x-y)

.mul(x, y) -- multiply x with y (x*y)

.div(x, y) -- divide x with y (x/y)

.abs(x) -- absolute value x (math.abs(x))

.le(x, y) -- is x < y ?  

.me(x, y) -- is x > y ?

.eq(x, y) -- is x = y ?

.leeq(x, y) -- is x <= y ?

.meeq(x, y) -- is x >= y ?

.convert(x) -- convert x to eternitynum (x)

.floattobnum(x) -- convert x to eternitynum (x)

.errorcorrect(x) -- corrects a eternitynum (x)

.nocorrect(x) -- doesnt correct a eternitynum (x)

.log(x) -- gets natural log of x (math.log(x))

.neg(x) -- negates x (-x)

.exp(x) -- exp x (math.exp(x))

.maxabs(x, y) -- gets the biggest abs of x , y

.bnumtoeternity(x) -- convert bnum to eternitynum

.eternitytobnum(x) -- convert eternitynum to bnum

.recip(x) -- reciprocate x

.pow(x,y) -- x ^ y (math.pow(x,y))

.pow10(x) -- 10 ^ x (math.pow(10, x))

.abslog10(x) -- log10(abs(x))

.log10(x) -- log10(x)

.logx(x, y) -- log[y](x)

.tentetration(str) -- input: ^^x , = 10^^x or input: = ^^x;y = (10^^x)^y

.short(x) -- Convert x to suffix when possible else convert it to {X}E#X1

.strtobnum(x) -- inputs: XeN  = X * 10^N, XptY = 10^10..^10 ^ Y (X 10's),  X;YeZ = eee...eeeYeZ
                                     
.root(x, y) -- y√(x)

.sqrt(x) -- √(x) (math.sqrt(x))

.gamma(x) -- (x-1)!

.fact(x) -- x!

.floor(x) -- if decimal round down

.ceil(x) -- if decimal round up

.engineer(x) -- if > 1e1e308 convert to engineers notation

.totet(x) -- converts bnum to tet

.bnumtostr(x) -- converts bnum to string

.bnumtoe(x) -- for notation converts to ee...eeeX

.shift(x, y) -- rounds to y-1 amount of digits

.rand(min, max) -- random number

.bnumtoes(value) -- bnum to E(x)y = ee...eey (x e's)

.bnumtoscientific(value) -- convert bnum to XeN

.bnumtotet(value) -- Bnum to 10^^x;y

.globalshort(value, nota) -- shorts bnum (nota = string with notation name)

.lbencode(enum) -- encode a bnum to be used for leaderboards

.lbdecode(enum) -- decode a bnum to b used for leaderboards

.hyperpow(val) -- x^(10^x!)
--]]
