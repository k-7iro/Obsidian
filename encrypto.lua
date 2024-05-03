local obsidian = require("obsidian")
local args = {...}

from, freason = fs.open(args[1], "r")
to, treason = fs.open(args[2], "w")

if not from then
    error(freason)
elseif not to then
    error(treason)
elseif not args[3] then
    error("Need Password")
end

to.write(obsidian.encryption(from.readAll(), args[3]))

from.close()
to.close()