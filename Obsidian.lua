--[[
    Obsidian - Common Key Cryptosystem for ComputerCraft
    License: MIT License

    Copyright 2024 K-Nana
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local function ByteRotator(num)
    if num < 0 then
        num = num + 256
    elseif num > 255 then
        num = num - 256
    end
    return num
end

function encryption(text, key)
    local result = ""
    local prev = 0
    for t = 1, #text do
        local processed = string.byte(string.sub(text, t, t))
        for k = 1, #key do
            processed = ByteRotator(processed + string.byte(string.sub(key, k, k)))
        end
        processed = ByteRotator(processed + (#key * t % 256))
        processed = ByteRotator(processed + prev)
        prev = processed
        result = result..string.char(processed)
    end
    return result
end

function decryption(text, key)
    local result = ""
    for t = 1, #text do
        local processed = string.byte(string.sub(text, #text-t+1, #text-t+1))
        if t ~= #text then
            processed = ByteRotator(processed - string.byte(string.sub(text, #text-t, #text-t)))
        end
        for k = 1, #key do
            processed = ByteRotator(processed - string.byte(string.sub(key, #key-k+1, #key-k+1)))
        end
        processed = ByteRotator(processed - (#key * (#text-t+1) % 256))
        result = string.char(processed)..result
    end
    return result
end

function randomKey(length)
    local result = ""
    for i = 1, length do
        result = result..string.char(math.random(0, 255))
    end
    return result
end

return {encryption = encryption, decryption = decryption, randomKey = randomKey}