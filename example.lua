function string.split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

curDate = os.date( "%x", os.time() - 5 * 60 * 60 )
currentDate = string.split(curDate,"/") --MM/DD/YY
printingDate = io.read("*l")
inputDate = string.split(printingDate,"/") -- MM/DD/YYYY

currentDateInDays = currentDate[1] * (365 / 12) + currentDate[2] + ((currentDate[3] + 2000) * 365)
inputDateInDays = inputDate[1] * (365 / 12) + inputDate[2] + ((inputDate[3]) * 365)

local function secConvert(num)
    local t = num

    local seconds = t % 60
    t = t-seconds

    local minutes = math.floor(t/60) % 60
    t = t-minutes*60

    local hours = math.floor(t/3600) % 24
    t = t-hours*3600

    local days = math.floor(t/(3600*24)) % 365
    t = t-days*86400

    local years = math.floor(t/(3600*24*365))

    if years > 0 then
        num = years.." Years, "..days.." Days, "..hours.." Hours, "..minutes.." Minutes and "..math.floor(seconds).." Seconds"
    else if days > 0 then
        num = days.." Days, "..hours.." Hours, "..minutes.." Minutes and "..math.floor(seconds).." Seconds"
    else if hours > 0 then
            num = hours.." Hours, "..minutes.." Minutes and "..math.floor(seconds).." Seconds"
        else if minutes > 0 then
                num = minutes.." Minutes and "..math.floor(seconds).." Seconds"
            else if seconds > 0 then
                    num = math.floor(seconds).." Seconds"
                end
            end
        end
    end
    end
return (num)
end

print("Current date is "..curDate)
if currentDateInDays > inputDateInDays then
print(printingDate.." was "..secConvert((currentDateInDays - inputDateInDays) * 86400).." ago.")
  else if inputDateInDays > currentDateInDays then 
    print(printingDate.." will be in "..secConvert((inputDateInDays - currentDateInDays) * 86400))
  end
end
