 
-- Madde by: FoundForces  (CommanderSalty#4975) --

-- Note: if you get as awnser back {1, -1, 1} then either math domain error or no solution.
 
-- Example: logx(50 , 1) = {1, -1, 1} because 1^x = always 1 

-------------------------------------------

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

.ceil(x) -- if decimal roundd up

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

.mod(x,y) -- x mod y

.hyperpow(val) -- x^(10^x!)

.cos(val) -- cos(val)


]]

-------------------------------------------
--[[

How to use:

Every function accepts all types of inputs, Example: add(1, 1) , add({1,0,1},1) ect.

If you want to convert a Bignum ( {x, y} ) to Eternitynum ( {x,y,z} ) use function .bnumtoeternity(bnum)

Examples:

(Spaces are just to make it better readable)

-- How do i multiply 1 + 5 by 3? :

.mul( .add (1, 5), 3 )

-- How do i do 10 ^ log6(10) ?

.pow10( .logx( 10, 6 ) )

-- How do i do 14 ^ log(3)  * 3 ?

.mul( .pow( 14, .log(3) ), 3)


internal number stored as {sign, layer, exp}

]]
------------------------------------------- CONFIG -------------------------------------------

local BN = require(script:WaitForChild("Bnum"))

local msd = 100 -- max sig digits
local expl = 1e10 -- exponent limit
local ldown = math.log10(1e10) -- value of layerdown
local fnl = 1/1e10 -- layer stuff
local breakpointe = 12 -- breaking point of bnumtoe (when does it switch over to E(x)x1)
local suffixlim = '1e9E15' -- where suffixes convert to E(x)x1
local digitsdisplay = 2 -- amount of digits when you convert bnum to notation

----------------------------------------- After this point dont touch unless you know what you are doing -------------------------------------------






trunc = function (n) -- math function
	if math.ceil(n) == n then return n end
	if n < 0 then
		return -(math.floor(n))
	end
	return math.floor(n)
end


function fgamma(n)
	
	if n >1.79e308 then return n end -- check if inf
	
	if n < -50 then
		if n == trunc(n) then -- no
			return -(1.8e308)
		end
		return 0
	end
	
	local scal1 = 1
	
	while n < 10 do
		
		scal1 = scal1*n
		
		n=n+1
		
	end
	
	n = n - 1
	
	local l = 0.9189385332046727
	l = l + (n+0.5)*math.log(n)
	l = l - n
	
	local n2 = n * n
	local np = n
	
	l = l+1/(12*np)
	np = np*n2
	
	l = l+1/(360*np)
	np = np*n2
	l = l+1/(1260*np)
	np = np*n2
	l = l+1/(1680*np)
    np = np*n2
    l = l+1/(1188*np)
    np = np*n2
    l = l+691/(360360*np)
    np = np*n2
    l = l+7/(1092*np)
    np = np*n2
    l = l+3617/(122400*np)

   return math.exp(l)/scal1

end

local twopi = 6.2831853071795864769252842  --2*pi
local EXPN1 = 0.36787944117144232159553  --exp(-1)
local OMEGA = 0.56714329040978387299997  --W(1, 0)

function f_lambertw(z)
	
	local tol = 1e-10
	local w,wn = nil
	
	if z > 1.79e308 then return z
		
	end
	
	if z == 0 then
		return z
	end
	
	if z == 1 then
		return OMEGA
	end
	
	if z < 10 then
		w = 0
	else
			w = math.log(z)-math.log(math.log(z))
	end
	
	for i=1,100 do
		
		wn = (z * math.exp(-w) + w * w)/(w + 1)
		
		if math.abs(wn - w) < tol*math.abs(wn) then
			
			return wn
			
		else
				w = wn
		end
		
	end
	error('Failed to itterate z.... at function: f_lambertw, line = ?')
end

-------------- Start if eternitynum

local ree = {}

function ree.convert(input)

return ree.floattobnum(input)

end


function ree.floattobnum(value) -- convert input to EternityNum
	
	if type(value) == 'number' then 
	
	local num = {}
	
	num[1] = math.sign(value)
	num[2] = 0
	num[3] = math.abs(value)
	return ree.errorcorrect(num)
	end
	
	if type(value) == 'string' then
		
		
		return ree.strtobnum(value)
		
	end
	
	if type(value) == 'table' then
		
		if #value == 2 then
			
			return ree.bnumtoeternity(value)
			
		end
		
		return ree.errorcorrect(value)
		
	end
	
	return {1, -1, 1}
	
end




function ree.strtobnum(value) -- first input = XeN, -- XptY = 10^10..^10 ^ Y (X 10's), X;YeZ = eee...eeeYeZ
	
	
	local lol = nil
	
	lol = string.split(value, 'e')
	
	if #lol == 2 then
		
	
		
		
		if string.find(lol[1], ';') or string.find(lol[2], ';') then
			 
		else
			
			return ree.bnumtoeternity(BN.convert(value))
				
		end
		
	end
	
	lol = string.split(value, 'pt')
	
	if #lol == 2 then
		
		
		local str = '^^'.. lol[1] .. ';' .. lol[2]
		
		return ree.tentetration(str)
		
	end
	
	lol = string.split(value, ';')
	
	if #lol == 2 then
	
		local idk = tonumber(lol[2])
		
		local sign = 1
		
	
	    if tonumber(lol[1]) < 0 then
		
		
		lol[1] = math.abs(lol[1])
	
		sign = -1
		
	end
		
		return ree.errorcorrect({sign, tonumber(lol[1]), idk})
		
		
	end
	
	
	lol = string.split(value, '^^')
	
	if #lol == 2 then
		
		return ree.tentetration(value)
		
	end
	
	
	
	return ree.floattobnum(tonumber(value))

 end




function ree.errorcorrect(bnum)
	
	local first = bnum[1]
	local layers = bnum[2]
	local last = bnum[3]
	
	if first == 0 or (last == 0 and layers == 0) then
		
		return {0,0,0}
		
	end
	
	if layers == 0 and last < 0 then
		
		last = -last
		first = -first
		
	end
	
	if layers == 0 and last < fnl then
		
		layers = layers + 1
		
		last = math.log10(last)
		return {first, layers, last}	
	end
	
	local absm = math.abs(last)
	local signm = math.sign(last)
	
	if absm >= expl then
		
		layers = layers + 1
		
		last = signm * math.log10(absm)
		
		return {first, layers, last}
		
	else
		
	while absm < ldown and layers > 0 do
		
		layers = layers - 1
		
		if layers == 0 then
			last = math.pow(10, last)
			
			
			else
			
			last = signm*math.pow(10, absm)
			absm = math.abs(last)
				signm = math.sign(last)
				
		end
		
	end
	
	if layers == 0 then
		
		if last < 0 then
			
			last = -last
			first = -first
			
		end
		
		elseif last == 0 then
			
			first = 0
		
	end
		
	end
	return {first, layers, last}
end

function ree.nocorrect(first, layers , last)
	
	return {first, layers, last}
	
end




function ree.log(value)
	
	value = ree.floattobnum(value)
	
	if ree.le(value, 0) then
		
		return {1, -1, 1}
		
	end
	
	if ree.eq(value, 0) then
		
		return {1, -1, 1}
		
	end
	
	if value[1] <= 0 then
		
		return  0
		
	elseif value[2] == 0 then
		
		return ree.errorcorrect({value[1], 0, math.log(value[3])})
		
	elseif value[2]	== 1 then
		
		
		return ree.errorcorrect({math.sign(value[3]), 0, math.abs(value[3])*2.302585092994046})
		
	elseif value[2] == 2 then
		
		
		return ree.errorcorrect({math.sign(value[3]), 1, math.abs(value[3])+0.36221568869946325})

	else
	
	return ree.errorcorrect({math.sign(value[3]), value[2]-1, math.abs(value[3])})
	
	end
	
	
end

function ree.neg(value)
	return {-value[1], value[2], value[3]}
end


function ree.le(value, value2)
	
	value = ree.floattobnum(value)
	 value2 = ree.floattobnum(value2)
	
	if cmp(value, value2) == -1 then
		return true
	end
	return false
end


function ree.me(value, value2)
	
	value = ree.floattobnum(value)
	 value2 = ree.floattobnum(value2)
	
	if cmp(value, value2) == 1 then
		return true
	end
	return false
end



function ree.eq(value, value2)
	
	value = ree.floattobnum(value)
	 value2 = ree.floattobnum(value2)
	
	if cmp(value, value2) == 0 then
		return true
	end
	return false
end


function ree.leeq(value, value2)
	
	value = ree.floattobnum(value)
	 value2 = ree.floattobnum(value2)
	
	if cmp(value, value2) == -1 or cmp(value, value2) == 0 then
		return true
	end
	return false
end


function ree.meeq(value, value2)
	
	value = ree.floattobnum(value)
	 value2 = ree.floattobnum(value2)
	
	if cmp(value, value2) == 1 or cmp(value, value2) == 0 then
		return true
	end
	return false
end


function cmp(value, value2)
	
	value = ree.floattobnum(value)
	 value2 = ree.floattobnum(value2)
	
	 if value[1] > value2[1] then  return 1 end
     if value[1] < value2[1] then return -1 end

    return value[1]*cmpabs(value, value2)
	
	
end


function cmpabs(value, value2) -- finish this then move back to lambertw
	
	 value = ree.floattobnum(value)
	 value2 = ree.floattobnum(value2)
	
	local layera = nil
	if value[3]  > 0 then
		
		 layera = value[2]
	else
		layera = -value[2]
	end
	
	local layerb = nil
	if value2[3]  > 0 then
		
		 layerb = value2[2]
	else
		layerb = -value2[2]
	end
	
	if layera > layerb then return 1 end
	
	if layera < layerb then return -1 end
	
	if value[3] > value2[3] then return 1 end
	
	if value[3] < value2[3] then return -1 end
	
	return 0
	
end

function ree.bnumtofloat(value)
	

	value = ree.floattobnum(value)
	
	if value[2] > 1.79e308 then
		
		return 1.8e309
		
	end
	
	if value[2] == 0 then
		
		
		return value[1] * value[3]
		
	elseif value[2] == 1 then
			
			return value[1] * math.pow(10, value[3])
		
	else	
		
		return 1.8e309
		
	end
	
end




function ree.abs(value)
	
	value = ree.floattobnum(value)
	
	if value[1] == 0 then
		
		return 0
		
	else
			
		return {1, value[2], value[3]}	
			
	end
	
end


function ree.exp(value)
	
	value = ree.floattobnum(value)
	
	if value[3] < 0 then return {1, 0, 1} end
	
	if value[2] == 0 and value[3] <= 709.7 then
		
		return ree.floattobnum(math.exp(value[1]*value[3]))
	
	elseif value[2] == 0 then
		
		return {1,1, value[1]*math.log10(2.718281828459045)*value[3]}
	
	elseif value[2] == 1 then
		
		return {1, 2, value[1]*(math.log10(0.4342944819032518)+value[3])}
	
	else
		
	return {1, value[2]+1, value[1]*value[3]}	
																																																						
	end
	
end


function ree.sub(value, value2)
	
	
	value = ree.floattobnum(value)
	
	value2 = ree.floattobnum(value2)
	
	

	
	return ree.add(value, ree.neg(value2))
	
	
end



function ree.add(value, value2)
	
	value = ree.floattobnum(value)
	
	value2 = ree.floattobnum(value2)
	
	
	if value[2] > 1.79e308 then return value end
	
	if value2[2] > 1.79e308 then return value2 end
	
	if value[1] == 0 then return value2 end
	
	if value2[1] == 0 then return value end
	
	
	if value[1] == -(value2[1]) and value[2] == value2[2] and value[3] == value2[3] then
		return {0,0,0}
		end
		
	local a,b = nil	
	
	if value[2] >= 2 or value2[2] >=2 then
		
		return ree.maxabs(value, value2)
		
	end	
	
	if cmpabs(value, value2) > 0 then
		
		a = value
		b = value2
		else
		
		a = value2
		b = value	
				
	end
	
	
	
	if a[2] == 0 and b[2] == 0 then
		
		return ree.floattobnum(a[1]*a[3]+b[1]*b[3])
		
	end			
	
	local layera = a[2]*math.sign(a[3])																		
	local layerb = b[2]*math.sign(b[3])	
	
	if layera - layerb >= 2 then  return a end
	
	if layera == 0 and layerb == -1 then
		
		if math.abs(b[3]-math.log10(a[3])) > msd then
			
		return a
			
		else
			
		local magdif = math.pow(10, math.log10(a[3])-b[3])
		local mantissa = (b[1]) + (a[1]*magdif)
		
		return ree.errorcorrect({math.sign(mantissa), 1, b[3]+math.log10(math.abs(mantissa))})
								
		end
		
	end

	if layera == 1 and layerb == 0 then
		
		
		if math.abs(a[3]-math.log10(b[3])) > msd then
			
			return a
			
		else
				
		local magdif = math.pow(10, a[3]-math.log10(b[3]))
		
		local mantissa = (b[1]) + (a[1]*magdif)
			
		return ree.errorcorrect({math.sign(mantissa), 1, math.log10(b[3])+math.log10(math.abs(mantissa))})
			
		end
		
	end
	
	if math.abs(a[3]- b[3]) > msd then
		
		return a
		
	else
			
					
		local magdif = math.pow(10, a[3]-b[3])
		
		local mantissa = (b[1]) + (a[1]*magdif)
			
		return ree.errorcorrect({math.sign(mantissa), 1, b[3]+math.log10(math.abs(mantissa))})
			
		
	end
	 
			
end


function ree.maxabs(value, value2) 
	
	value = ree.floattobnum(value)
	
	value2 = ree.floattobnum(value2)
	
	if cmpabs(value, value2) < 0 then
		
		return value2
		
	end
	
	return value
	
	end
	

function ree.bnumtoeternity(bnum)

    if bnum[2] == 0 then

        return {1, 0, bnum[1]}

    end


    bnum = BN.errorcorrection(bnum)

    local numbaa = nil

    local layers = nil

    local sign = nil

    local rees = 1

    sign = math.sign(bnum[1])


    if bnum[1] == 0 then
        return {0,0,0}
    end

    if bnum[1] < 0 then

        bnum[1] = bnum[1] * -1

    end

    if bnum[2] < 0 then

      local idkdk =  BN.bnumtofloat(BN.log10(BN.mul( BN.floattobnum(bnum[1]) , BN.pow({1,1}, BN.floattobnum(bnum[2])))))
         
        return {sign, 1, idkdk}

    end

    numbaa = bnum[2] + math.log10(bnum[1])
    layers = math.log10(numbaa)-(math.log10(numbaa)-1)
    numbaa = numbaa * rees

    return ree.errorcorrect({sign, layers, numbaa})
end

function ree.eternitytobnum(value)
	
	value = ree.errorcorrect(value)
	
	local sign = value[1]
	local layer = value[2]
	local mag = value[3]
	
	if sign == 0 then
		
		return {0,0}
		
	end
	
	if layer >= 2 and mag > 307.99 then
		
		return {sign*1, 1.79e308}
		
	end
	
	if layer > 2 and mag > math.log10(308) then
		
		return {sign*1, 1.79e308}
		
	end
	
	
	
	if layer == 0 then
		
		return BN.floattobnum(sign*mag)
		
	end
	
	if layer == 1 then -- 10^n * x
		
	local big = BN.mul(BN.pow({1,1}, BN.floattobnum(mag)), BN.floattobnum(sign))
		return big
	end
	
	if layer == 2 and mag <= 308 then -- 10^(10^n)*x
		
		local big = BN.mul(BN.pow({1,1}, BN.pow({1,1}, BN.floattobnum(mag))), BN.floattobnum(sign))
		return big
	end
	
	if layer == 3 and mag <= math.log10(308) then -- 10^(10^(10^n))*x
		
		local big = BN.mul(BN.pow({1,1}, BN.pow({1,1}, BN.pow({1,1}, BN.floattobnum(mag ))), BN.floattobnum(sign)))
		return big
		
	end
	
	return {1, 1.79e308}
	
end


function ree.mul(value, value2)
	
	value = ree.floattobnum(value)
	
	value2 = ree.floattobnum(value2)
	
	if value[2] > 1.79e308 then return value end
	
	if value2[2] > 1.79e308 then return value end
	
	if value[1] == 0 or value2[1] == 0 then
		return {0,0,0}
		
	end
	
	if ree.eq(value, 0) then
		
		return 0
		
	end
	
	if value[2] == value2[2] and value[3] == -value2[3] then
		
		return {value[1]*value2[1], 0, 1}
		
	end
	
	local a,b = nil
	
	if (value[2] > value2[2]) or (value[2] == value2[2] and math.abs(value[3]) > math.abs(value2[3])) then
		
		
		a = value
		b= value2
		
	else
			
		a = value2
		b= value	
		
	end
	
	if a[2] == 0 and b[2] == 0 then
		
		return ree.floattobnum(a[1]*b[1]*a[3]*b[3])
		
	end
	
	if a[2] >= 3 or (a[2] - b[2] >= 2) then
		
		return ree.errorcorrect({a[1]*b[1], a[2], a[3]})
		
	end
	
	if a[2] == 1 and b[2] == 0 then
		
		
		return ree.errorcorrect({a[1]*b[1], 1, a[3]+math.log10(b[3])})
		
	end
	
	if a[2] == 1 and b[2] == 1 then
		
		return ree.errorcorrect({a[1]*b[1], 1, a[3]+b[3]})
		
	end
	
	if (a[2] == 2 and b[2] == 1) or ((a[2] == 2 and b[2] == 2)) then
		
		
		
		
		local nmag = ree.add(ree.errorcorrect({math.sign(a[3]), a[2]-1, math.abs(a[3])}), ree.errorcorrect({math.sign(b[3]),b[2]-1, math.abs(b[3])}))
		return ree.errorcorrect({a[1]*b[1], nmag[2]+1, nmag[1]*nmag[3]})
		
	end
	

	return {1, -1, 1} 
	
end


function ree.div(value, value2) 
	
	value = ree.floattobnum(value)
	
	value2 = ree.floattobnum(value2)
	
	local x = ree.recip(value2)
	
	
	return ree.mul(value, ree.recip(value2))
	
end


function ree.recip(value)
	
	value = ree.floattobnum(value)
	
	if value[3] == 0 then return {1, -1, 1} 
	
	
	elseif value[2] == 0 then
		
		return ree.errorcorrect({value[1], 0, 1/value[3]})
		
	else
			
			return ree.errorcorrect({value[1], value[2], -value[3]})
		
		end
	
end


function ree.pow(value, value2)
    
    value = ree.floattobnum(value)
    
    value2 = ree.floattobnum(value2)
    
    local a = value
    local b = value2
    
    if a[1] == 0 then return {0,0,0} end -- cuz ya know 0^x = 0
    
    if a[1] == 1 and a[2] == 0 and a[3] == 1 then -- cuz 1^x = 1
        
        return {1,0,1}
        
    end
    
    if b[1] == 0 then return {1,0,1} end -- x^0 = 1
    
    if b[1] == 1 and b[2] == 0 and b[3] == 1 then -- cuz x^1 = x
        
        return a
        
    end
    
    local calc = ree.pow10(ree.mul(ree.abslog10(a), b)) 
    
    if value[1] == -1 and ree.bnumtofloat(b) % 2 == 1 then
        
        return ree.neg(calc)
        
elseif value[1] == -1 and ree.bnumtofloat(b) < 1e20 then

local shit = ree.floattobnum(math.cos(ree.bnumtofloat(b) * math.pi))

  return ree.mul(calc, shit)

    end
    
    
    
    return calc
    
end


function ree.abslog10(value)
	
	value = ree.floattobnum(value)
	
	
	if value[1] == 0 then return {1 , -1, 1}
		
	elseif value[2] > 0 then
		return ree.errorcorrect({math.sign(value[3]), value[2]-1, math.abs(value[3])})
	
	else
		
		return ree.errorcorrect({1, 0, math.log10(math.abs(value[3]))})
		
	end
end


function ree.pow10(value)
	
	value = ree.floattobnum(value)
	
	if value[2] > 1.79e308 or value[3] > 1.79e308 then
		
		return {1, -1 ,1}
		
	end
	
	local a = value
	
	if a[2] == 0 then
		
		local nmag = math.pow(10, a[1]*a[3])
		
		if nmag < 1.8e308 and math.abs(nmag) > 0.1 then
			
			return ree.errorcorrect({1, 0, nmag})
		else
				
				if a[1] == 0 then return {1, 0 ,1}
					
					
				else	
					
					a = {a[1], a[2]+1, math.log10(a[3])} end
					
				end
			
		end
		
		if a[1] > 0 and a[3] > 0 then
			
			
			return {a[1], a[2]+1, a[3]}	
						
	end
	
	if a[1] < 0 and a[3] > 0 then
		
		return {-a[1], a[2]+1, -a[3]}	
		
	end
	
	return {1,0,1}
	
end



function ree.log10(value)
	
	value = ree.floattobnum(value)
	
	if value[1] <= 0 then
		
		return {1, -1, 1}
	
		
	elseif value[2]	> 0 then
				
				return ree.errorcorrect({math.sign(value[3]), value[2]-1, math.abs(value[3])})
	else
		
		return ree.errorcorrect({value[1], 0 , math.log10(value[3])})
		
	end
	
	
	
end

function ree.logx(value , base)

value = ree.floattobnum(value)

base = ree.floattobnum(base)

if value[1] <= 0 then
	
	return {1 ,-1, 1}
	
end

if base[1] <= 0 then
	
	return {1, -1, 1}
	
end

if base[1] == 1 and base[2] == 0 and base[3] == 1 then
	
	return {1, -1, 1}
	
	elseif value[2] == 0 and base[2] == 0 then
		
		return ree.errorcorrect({value[1], 0, math.log(value[3])/math.log(base[3])})
	
end

 return ree.div(ree.log10(value), ree.log10(base))

end



function ree.short(value) -- {X}E#X1
	
		value = ree.shift(ree.floattobnum(value), digitsdisplay)
		
		if ree.me(value, 0) and ree.le(value, 1) then
			
			return "1 / " .. ree.short(ree.div(1, value))
			
		end
		
	if ree.meeq(value, suffixlim) then
		
		return ree.bnumtoe(value)
		
	end	
	
	if value[1] == 1 and ree.le(value, {1, 2, 308}) then
		
		return BN.short(ree.eternitytobnum(value))
		
	end
	if value[1] == -1 and ree.me(value, {-1, 2, 308}) then
		
		return BN.short(ree.eternitytobnum(value))
		
	end
	
	return ree.bnumtoe(value)
	
end


function ree.display(value)
	
	value = ree.shift(ree.floattobnum(value), digitsdisplay)
	
	local es,sign,x1 = nil
	
	es = value[2]
	
	sign = value[1]
	
	x1 = value[3]
	
	if sign == 1 then
		
		return '{' .. es .. '}E#' .. x1
		
	end
	
	if sign == 0 then
		
		return '{0}E#0'
		
	end
	
	if sign == -1 then
		
		return '-{' .. es .. '}E#' .. x1
		
		
	end
	
	return '{X}E#X1'
	
end


function ree.totet(value) -- x*((10^^y)^z)
	value = ree.shift(ree.floattobnum(value), digitsdisplay)
	return value[1] ..'((10^^'.. value[2] .. ')'.. value[3] ..')'
	end


function ree.tentetration(str) -- 10^^x;y = {math.sign(x),math.abs(x),y}
	
	local lol = string.split(str, '^^')
	
	
	local hieght, pay = nil
	
	if #lol == 2 then
		
		local lol2 = string.split(lol[2], ';')
		
		if #lol2 == 2 then
			
			pay = lol2[2]
			hieght = lol2[1]
		else
				pay = 1
			hieght = lol[2]
		end
		
		
		return ree.errorcorrect({math.sign(hieght), math.abs(hieght), pay})
		
	end
	
	return {1, -1, 1}
	
end


function ree.root(value, value2)
	
	value = ree.floattobnum(value)
	value2 = ree.floattobnum(value2)
	
	return ree.pow(value, ree.recip(value2))
	
end


function ree.sqrt(value)
	
	value = ree.floattobnum(value)
	
	return ree.root(value, 2)
	
end


function ree.gamma(value)
	
	value = ree.floattobnum(value)
	
	if ree.leeq(value, 0) then
		
		return {1, -1, 1}
		
	end
	
	if value[3] < 0 then
		
		return ree.recip(value)
	
	elseif value[2] == 0 then
		
		if ree.le(value, {1, 0, 24}) then
			
			return ree.floattobnum( fgamma(value[1]*value[3]) )
			
		end
		
		local t = value[3] - 1
		
		local l = 0.9189385332046727
        l = (l+((t+0.5)*math.log(t)))
        l = l-t
        local n2 = t*t
        local np = t
        local lm = 12*np
        local adj = 1/lm
        local l2 = l+adj
		
		if (l2 == l) then
			
			return ree.exp(l)
			
		end
		
		  l = l2
        np = np*n2
        lm = 360*np
        adj = 1/lm
        l2 = l-adj

		if l2 == l then
			
			return ree.exp(l)
			
		end
		
		 l = l2
        np = np*n2
        lm = 1260*np
        local lt = 1/lm
        l = l+lt
        np = np*n2
        lm = 1680*np
        lt = 1/lm
        l = l-lt

		return ree.exp(l)
	
	elseif value[2] == 1 then 
		
		return ree.exp( ree.mul( value, ree.sub( ree.log(value), 1  )   )   )
	
	else
		
		return ree.exp(value)
										
	end
	
	
	
end


function ree.fact(value)
	
	value = ree.floattobnum(value)
	
	return ree.gamma(  ree.add(value, 1) )
	
end

function ree.floor(value)
	
	value = ree.floattobnum(value)
	if value[3] < 0 then 
		
		return {0,0,0}
		
	end
	
	if ree.le(value, 0) then
		
		local lols = ree.ceil( {1, value[2], value[3]} )
		
		return {-1, lols[2], lols[3]}
		
	end
	
	if ree.le(value, 1e16) and ree.me(value, -1e16) then
		
		
		if value[2] > 0 then
		for i=1,5 do
			
			value[2] = value[2] -1
			
			value[3] = 10 ^ value[3]
		if value[2] == 0 then
			break
		end	
			
		end	
		end
		
		
		return ree.errorcorrect({value[1], value[2], math.floor(value[3])})
		
		
	end
	
	return value
	
	
end


function ree.ceil(value)
	
	value = ree.floattobnum(value)
	
	if value[3] < 0 then 
		
		return {0,0,0}
		
	end
	
	if ree.le(value, 0) then
		
		local lols = ree.floor( {1, value[2], value[3]} )
		
		return {-1, lols[2], lols[3]}
		
	end
	
	if ree.le(value, 1e16) and ree.me(value, -1e16) then
		
		if value[2] > 0 then
		for i=1,5 do
			
			value[2] = value[2] -1
			
			value[3] = 10 ^ value[3]
		if value[2] == 0 then
			break
		end	
			
		end	
		end
		
		return ree.errorcorrect({value[1], value[2], math.ceil(value[3])})
		
		
	end
	
	return value
	
	
end


function ree.engineer(value)
	
	value = ree.floattobnum(value)
	
	if ree.le(value, {1, 2, 308}) then
		
		
		return BN.engineer(ree.eternitytobnum(value))
		
	end
	
	return ree.bnumtoe(value)
	
end


function es(amo)
	
	if amo  < 1 then
		
		return ''
		
	end
	
	local lol = 'e'
	
	for i=1,amo-1 do
		
		
		lol = lol .. 'e'
		
	end
	
	return lol
	
end



function ree.bnumtostr(value) -- X;YeZ
	
	
	value = ree.shift(ree.floattobnum(value), 16)
	
	
	if value[1] == 1 then
		
		
		return value[2] .. ';' .. value[3]
		
	end
	
	
	if value[1] == 0 then
		
		
		return '0;0e0'
		
	end
	
	
	if value[1] == -1 then
		
		
		return -value[2] .. ';' .. value[3]
		
	end
	
	return 'INVALID;INVALID'
	
	
end



function ree.bnumtoe(value)
	
	
	value = ree.shift(ree.floattobnum(value), digitsdisplay)
	
	local e = value[2]
	
	if e > breakpointe then
		
		
		return ree.bnumtoes(value)
		
	end
	
	local isneg = value[1]
	
	local numbaa = value[3]
	
	if isneg == 1 then
		
		local p1 = es(e)
		
		return p1 .. tostring(numbaa)
		
	end
	
	if isneg == 0 then
		
		return '0'	
		
	end
	
	if isneg == -1 then
		
		
		local p1 = es(e-1)
		
		return 'e-' .. p1 .. tostring(numbaa)
		
	end
	
	return ree.short(value)
	
end


function ree.shift(value , digits)
	
	value = ree.floattobnum(value)
	
	if ree.me(value, {1, 2, 20}) then
		
		return value
		
	end
	
	if digits > 20 then
		
		return value
		
	end
	
	if ree.le(value, {1, 2, -20}) then
		
		return value
		
	end
	if value[1] == -1 and ree.me(value, {-1, 2, -20}) then
		
		return value
		
	end
	if value[1] == -1 and ree.le(value, {-1, 2, 20}) then
		
		return value
		
	end
	
	
	
	if ree.le(value, 0) then
		
		--convert it o negative
		value[1] = 1
		local Z = ree.eternitytobnum(value)
		Z = BN.shift(Z, digits)
		Z = ree.bnumtoeternity(Z)
		Z[1] = -1
		return Z
	end
	local Z = ree.eternitytobnum(value)
		Z = BN.shift(Z, digits)
		Z = ree.bnumtoeternity(Z) return Z
end


function shift2(value, digits)
	value = ree.floattobnum(value)
	local numbaa = math.floor(value[3] * 10^digits) / 10^digits 
	
	return {value[1], value[2], numbaa}
	
end


function ree.rand(min, max)
local seed = math.random()
local even = ree.sub(max, min)
even = ree.mul(even, seed)
return ree.add(even, min)
end


function ree.bnumtoes(value) -- E(x)y = ee...eey (x e's)
	
value = ree.shift(ree.floattobnum(value), digitsdisplay)
	
	local ess = value[2]
	
	local sign = value[1]
	
	local numbaa = value[3]
	
	if sign == 1 then
		
      if numbaa < 0 then
	
	return 'E(' .. ess .. '-' ..  ')' .. math.abs(numbaa)
	
end
	return 'E(' .. ess ..  ')' .. numbaa
	
	end
	
	if sign == 0 then
		
		return 'E(0)0'
		
	end
	
	if sign == -1 then
		
		
		return '-' .. ree.bnumtoes({-value[1], value[2], value[3]})
		
	end
	
	return 'E(INVALID)INVALID)'
	
	
end

function ree.bnumtoscientific(value)
	value = ree.floattobnum(value)

   if ree.me(value, {1, 2, 308}) then
	
	return ree.bnumtoe(value)
	
end

return BN.bnumtostr(BN.shift(ree.eternitytobnum(value), digitsdisplay))

end


function ree.bnumtotet(value)
	
	value = ree.shift(ree.floattobnum(value), digitsdisplay)
	if value[2] == 0 then
		
		return tostring(value[1]*value[3])
		
	end
	
	if value[1] == 1 then
		
		return '10^^' .. value[2] .. ';' .. value[3]
		
	end
	
	if value[1] == 0 then
		
		return '10^^0;0'
		
	end
	
	if value[1] == -1 then
		
		return '-10^^' .. value[2] .. ';' .. value[3]
		
	end
	
	return 'INVALID^^INVALID;INVALID'
	
end



--[[function ree.globalshort(value, nota) -- optional
	
	value = ree.shift(ree.floattobnum(value), digitsdisplay)
		
	if nota == 'Suffix' then
		
		
	  return ree.short(value)
		
	end
	
	if nota == 'Scientific' then
		
		
		return ree.bnumtoscientific(value)
		
	end
	
	if nota == 'E Notation' then
		
		
		return ree.bnumtoes(value)
		
	end
	
	if nota == 'Row of E' then
		
		
		return ree.bnumtoe(value)
		
	end
	
	if nota == 'X;YeZ' then
		
		
		return ree.bnumtostr(value)
		
	end
	
	if nota == '{x}E#x1' then
		
		
		return ree.display(value)
		
	end
	
	if nota == 'Tetrated Math' then
		
		
		return ree.totet(value)
		
	end
	
	if nota == 'Tentetrated' then
		
		
		return ree.bnumtotet(value)
		
	end
	
	return ree.short(value)
	
	
end]]





function ree.lbencode(enum) -- encode cool!
	enum = ree.floattobnum(enum)
	local mode = 0
	if enum[1] == -1 and enum[2] > 9999  and math.sign(enum[3]) == 1 then
		mode = 0
	elseif enum[1] == -1 and enum[2] < 9999 and math.sign(enum[3]) == 1 then
		mode = 1
	elseif enum[1] == -1 and enum[2] > 9999 and math.sign(enum[3]) == -1 then
		mode = 2
	elseif enum[1] == -1 and enum[2] < 9999 and math.sign(enum[3]) == -1 then
		mode = 3
	elseif enum[1] == 0 then
		return 4E18
		
	elseif enum[1] == 1 and enum[2] < 9999 and math.sign(enum[3]) == -1 then
		mode = 5
	elseif enum[1] == 1 and enum[2] > 9999 and math.sign(enum[3]) == -1 then
		mode = 6
	elseif enum[1] == 1 and enum[2] < 9999 and math.sign(enum[3]) == 1 then
		mode = 7
	elseif enum[1] == 1 and enum[2] > 9999 and math.sign(enum[3]) == 1 then
		mode = 8
	
	end
	local VAL = mode*1E18
	if mode == 8 then
		VAL = VAL + ((math.log10(enum[2] + (math.log10(enum[3]) / 10))) * 3.2440674117208e+15)
	elseif mode == 7 then
		VAL = VAL + (enum[2]*1e14)
		VAL = VAL + (math.log10(enum[3])*1e13)
	elseif mode == 6 then
		VAL = VAL + 1e18
		VAL = VAL - ((math.log10(enum[2] + (math.log10(math.abs(enum[3])) / 10))) * 3.2440674117208e+15)
	elseif mode == 5 then
		VAL = VAL + (enum[2]*1e14) + 1e14
		VAL = VAL - (math.log10(math.abs(enum[3]))*1e13)
	elseif mode == 3 then
		local VOFFSET = 0
		VOFFSET = VOFFSET + (enum[2]*1e14) + 1e14
		VOFFSET = VOFFSET - (math.log10(math.abs(enum[3]))*1e13)
		VOFFSET = (1e18 - VOFFSET)
		VAL = VAL + VOFFSET
	elseif mode == 2 then
		local VOFFSET = 0
		VOFFSET = VOFFSET + 1e18
		VOFFSET = VOFFSET - ((math.log10(enum[2] + (math.log10(math.abs(enum[3])) / 10))) * 3.2440674117208e+15)
	VOFFSET = (1e18 - VOFFSET)
		VAL = VAL + VOFFSET
	elseif mode == 1 then
		local VOFFSET = 0
		VOFFSET = VOFFSET + (enum[2]*1e14)
		VOFFSET = VOFFSET + (math.log10(enum[3])*1e13)
	VOFFSET = (1e18 - VOFFSET)
		VAL = VAL + VOFFSET
	elseif mode == 0 then
		local VOFFSET = ((math.log10(enum[2] + (math.log10(enum[3]) / 10))) * 3.2440674117208e+15)
		
	VOFFSET = (1e18 - VOFFSET)
		VAL = VAL + VOFFSET
	
	end
	return VAL
end


function ree.lbdecode(enum) -- decodes numbers for extra spice
	
	if enum==2e18 then
		return {-1, 0, 1}
	elseif enum==3e18 then
		return {-1, 10000, -1}
	elseif enum==1e18 then
		return {-1, 0, -1}
	elseif enum==6e18 then
		return {1, 0, 1}
	elseif enum==7e18 then
		return {1, 10000, 1}
	elseif enum==5e18 then
		return {1, 10000, -1}
	
	end
	local mode = math.floor(enum/1e18)
	if mode == 4 then
		return {0,0,0}
	end
	if mode== 0 then
		local v=enum
		v=1e18-v
		v=v/3.2440674117208e+15
		v=10^v
		local layers=math.floor(v)
		local numbaa=10^(math.fmod(v, 1)*10)
		return {-1, layers, numbaa}
	elseif mode== 8 then
		local v=enum-8e18
		
		v=v/3.2440674117208e+15
		v=10^v
		local layers=math.floor(v)
		local numbaa=10^(math.fmod(v, 1)*10)
		return {1, layers, numbaa}
	
	elseif mode== 1 then
		local v=enum-1e18
		v=1e18-v
		
		local layers=math.floor(v / 1E14)
		local numbaa=10^(math.fmod(v, 1e14)/1e13)
		return {-1, layers, numbaa}
	elseif mode== 7 then
		local v=enum-7e18
		
		
		local layers=math.floor(v / 1E14)
		local numbaa=10^(math.fmod(v, 1e14)/1e13)
		return {1, layers, numbaa}
	
	elseif mode== 2 then
		local v=enum-2e18
		
		v=v/3.2440674117208e+15
		
		v=10^v
		local layers=math.floor(v)
		local e=10^(math.fmod(v,1)*10)
		return {-1, layers, -e}
	elseif mode== 6 then
		local v=enum-6e18
		v=(1e18-v)
		v=v/3.2440674117208e+15
		
		v=10^v
		local layers=math.floor(v)
		local e=10^(math.fmod(v,1)*10)
		return {1, layers, -e}
	
	elseif mode== 5 then
		local v=enum-5e18
		
		--[[
		
		VAL = VAL + (enum[2]*1e14) + 1e14
		VAL = VAL - (math.log10(math.abs(enum[3]))*1e13)
		]]
		--v=(1e18-v)
		
		local layers=math.floor((v) / 1E14)
		local e=10^((1e14 - math.fmod(v, 1e14)) / 1e13)
		return {1, layers, -e}
	
	elseif mode== 3 then
		local v=enum-3e18
		v=(1e18-v)
		--[[
		
		VAL = VAL + (enum[2]*1e14) + 1e14
		VAL = VAL - (math.log10(math.abs(enum[3]))*1e13)
		]]
		--v=(1e18-v)
		
		local layers=math.floor((v) / 1E14)
		local e=10^((1e14 - math.fmod(v, 1e14)) / 1e13)
		return {-1, layers, -e}
	
	
	end
	return {1, -1, 1}
end


function ree.hyperpow(val) -- if u want smth to grow fast ok lol! : x^(10^x!)
	val = ree.floattobnum(val)
	local val1 = ree.fact(val)
	val1 = ree.pow10(val1)
	return ree.pow(val, val1)
end


function ree.mod(x,y) -- abs(y*math.floor(x/y) - x) inaccurate for high numbers so :/
	
	x = ree.floattobnum(x)
	
	y = ree.floattobnum(y)
	
	if BN.bnumtofloat(x) < 1e308 and BN.bnumtofloat(y) < 1e308 then
		
		return BN.convert(math.fmod(BN.bnumtofloat(x), BN.bnumtofloat(y)))
		
	end
	
	local first = BN.abs(BN.sub(BN.mul(y, BN.floor(BN.div(x, y))),x))
	
	return first
	
end


function ree.cos(x) -- if u want cos ok:/
	
	x = ree.floattobnum(x)
	
	if x[3] < 0 then
		
		return	{1, 0, 1}
		
	end
	
	if x[2] == 0 then
		return ree.floattobnum(math.cos(x[1],x[3]))
	end
	
	return {1,0,1}
	
end



return ree
