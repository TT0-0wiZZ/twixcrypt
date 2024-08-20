--[[

    MIT License

    Copyright (c) 2024 ttwiz_z

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

]]


local process = require("@lune/process")
local api = require("api")

local arguments: {[number]: string} = process.args


if not arguments[1] or string.lower(arguments[1]) ~= "encrypt" and string.lower(arguments[1]) ~= "decrypt" then
    warn("Unknown action (expected: encrypt or decrypt)")
elseif not arguments[2] or #arguments[2] ~= 16 and #arguments[2] ~= 24 and #arguments[2] ~= 32 then
    warn("Key must be either 16, 24 or 32 bytes long")
elseif not arguments[3] or string.lower(arguments[1]) == "encrypt" and #arguments[3] % 16 ~= 0 then
    warn("Input must be a multiple of 16 bytes in length")
elseif string.lower(arguments[1]) == "encrypt" then
    local output: {[number]: number} = api:Encrypt(arguments[2], arguments[3])
    local data: string = ""

    for _: number, byte: number in output do
        data ..= `!{byte}`
    end

    print(data)
elseif string.lower(arguments[1]) == "decrypt" then
    local data: {[number]: number?} = {}

    for byte: string in string.gmatch(arguments[3], "([^!]+)") do
        table.insert(data, tonumber(byte))
    end

    local success: boolean, output: {[number]: number} = pcall(api.Decrypt, api, arguments[2], data)

    if success then
        print(string.char(table.unpack(output)))
    else
        warn("Failed to decrypt")
    end
else
    warn("Unknown action (expected: encrypt or decrypt)")
end