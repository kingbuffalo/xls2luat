local function f(allFldName,allTblR)
	local ret = {}

	local lanR = allTblR.lan
	local lan = {}
	for k,v in pairs(lanR) do
		local regex = 0
		for i=1,7 do
			local key = "regex" .. i
			local regexV = v[key]
			regex = regex | (regexV << ((i-1)*4))
		end
		v.regex = regex
		lan[v.key] = v
	end
	ret.lan=lan

	return ret
end

return f
