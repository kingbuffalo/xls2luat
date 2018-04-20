local function f(allFldName,allTblR)
	local ret = {}

	local army_cfgR = allTblR.army_cfg
	local army_cfg = {}
	for k,v in pairs(army_cfgR) do
		local skill_type = {}
		for kk,vv in pairs(v.skill_type_arr) do
			skill_type[vv] = kk
		end
		v.skill_type = skill_type
		army_cfg[v.type] = v
	end
	ret.army_cfg = army_cfg

	local army_weaponR = allTblR.army_weapon
	local army_weapon = {}
	for k,v in pairs(army_weaponR) do
		for i=1,4 do
			local key = "attr_arr" .. i
			local attr = {}
			for kk,vv in pairs(v[key]) do
				attr[vv[1]] = vv[2]
			end
			key = "attr" .. i
			v[key] = attr
		end
		local t = army_weapon[v.type] or {}
		t[v.level] = v
		army_weapon[v.type] = t
	end
	ret.army_weapon = army_weapon

	local army_levelR = allTblR.army_level
	local maxLv = 0
	local army_level = {}
	for k,v in pairs(army_levelR) do
		local attr_arr = v.attr_arr
		local attr = {}
		for ii,vv in pairs(attr_arr) do
			attr[vv[1]] = vv[2]
		end
		v.attr = attr
		local t = army_level[v.type] or {}
		t[v.level] = v
		army_level[v.type] = t
		if maxLv < v.level then maxLv = v.level end
	end
	ret.army_level = army_level
	ret.army_max_level = maxLv

	local army_skillR = allTblR.army_skill
	local army_skill = {}
	local army_skill_start = {}
	for k,v in pairs(army_skillR) do
		local attr_arr = v.attr_arr
		local attr = {}
		for ii,vv in pairs(attr_arr) do
			attr[vv[1]] = vv[2]
		end
		v.attr = attr
		army_skill[v.skill_id] = v
	end
	local temp = {}
	for k,v in pairs(army_skill) do
		temp[v.next] = 1
	end
	for k,v in pairs(army_skill) do
		if temp[v.skill_id] == nil then
			army_skill_start[v.type] = v.skill_id
		end
	end
	ret.army_skill_start = army_skill_start
	ret.army_skill = army_skill

	local army_skill_cfgR = allTblR.army_skill_cfg
	local army_skill_cfg = {}
	for i,v in pairs(army_skill_cfgR) do
		army_skill_cfg[v.type] = v
	end
	ret.army_skill_cfg = army_skill_cfg

	return ret
end

return f
