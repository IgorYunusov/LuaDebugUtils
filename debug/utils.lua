local print = print
local pairs = pairs
local tostring = tostring
local tinsert = table.insert
local type = type
local next = next
local srep = string.rep
local tconcat = table.concat

--[[
	打印table结构
--]]
function print_r(root)
	if type(root) ~= "table" then
		print(root)
		return
	end
	print("{")
	local token = srep(" ", 4)
	local cache = { [root] = "." }
	local function _dump(t, space, name)
		local temp = {}
		for k, v in pairs(t) do
			local key = tostring(k)
			local vtype = (type(v) == "string" and "\"" or "")
			if cache[v] then
				tinsert(temp, key .. " = {" .. cache[v] .. "}")
			elseif type(v) == "table" then
				local new_key = name .. "." .. key
				cache[v] = new_key
				tinsert(temp, key .. " = {\n" .. space .. token .. _dump(v, space .. token, new_key) .. "\n" .. space .."}")
			else
				tinsert(temp, key .. " = " .. vtype .. tostring(v) .. vtype .. ",")
			end
		end
		return tconcat(temp, "\n" .. space)
	end
	print(token .. _dump(root, token, ""))
	print("}")
end
