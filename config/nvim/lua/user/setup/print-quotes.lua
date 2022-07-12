#!/usr/bin/lua
local quotes = dofile("quotes.lua")
local max_length = 0
for _, line in pairs(quotes[math.random(#quotes)]) do
	max_length = #line>max_length and #line or max_length
	if line:match("^-") then
		local author = string.format("%"..max_length.."s", line)
		print()
		print(author)
	else
		print(line)
	end
end
