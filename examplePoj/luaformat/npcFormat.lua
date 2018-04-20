local function f(allFldName,allTblR)
	local ret = {}
	local npc = {}
	local npcR = allTblR.npc
	for k,v in pairs(npcR) do
		local hero_attr = {}
		for ii,vv in ipairs(v.hero_attr_arr) do
			hero_attr[vv[1]] = vv[2]
		end
		local army_attr = {}
		for ii,vv in ipairs(v.army_attr_arr) do
			army_attr[vv[1]] = vv[2]
		end
		v.hero_attr = hero_attr
		v.army_attr = army_attr
		local t = npc[v.map_id] or {}
		local npcArr = t[v.npc_id] or {}
		npcArr[#npcArr+1] = v
		t[v.npc_id] = npcArr
		npc[v.map_id] = t
	end
	ret.npc = npc
	return ret
end

return f
