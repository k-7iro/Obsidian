local obsidian = require("obsidian")
local args = {...}

from, freason = fs.open(shell.resolve(args[1]), "r")
to, treason = fs.open(shell.resolve(args[2]), "w")

if not from then
    error(freason)
elseif not to then
    error(treason)
elseif not args[3] then
    error("Need Password")
end

to.write(obsidian.decryption(from.readAll(), args[3]))

from.close()
to.close()