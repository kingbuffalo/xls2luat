local function f(allFldName,allTblR)
	local ret = {}
	local heroR = allTblR.hero
	local hero = {}
	for k,v in pairs(heroR) do
		hero[v.hero_id] = v
	end
	ret.hero = hero

	local hero_levelR = allTblR.hero_level
	local maxLv = 0
	local hero_level = {}
	for k,v in pairs(hero_levelR) do
		hero_level[v.level] = v
		if maxLv < v.level then maxLv = v.level end
	end
	ret.hero_level = hero_level
	ret.hero_max_level = maxLv

	local hero_starR = allTblR.hero_star
	local hero_star = {}
	local maxStar = 0
	for k,v in pairs(hero_starR) do
		hero_star[v.star] = v
		if maxStar < v.star then maxStar = v.star end
	end
	ret.hero_star = hero_star
	ret.hero_max_star = maxStar

	local hero_level_attrR = allTblR.hero_level_attr
	local hero_level_attr = {}
	for k,v in pairs(hero_level_attrR) do
		local t = hero_level_attr[v.hero_id] or {}
		local arr = v.attrArr
		local nattr = {}
		for ii,vv in ipairs(arr) do
			nattr[vv[1]] = vv[2]
		end
		v.attr = nattr
		t[v.level] = v
		hero_level_attr[v.hero_id] = t
	end
	ret.hero_level_attr = hero_level_attr

	local hero_star_attrR = allTblR.hero_star_attr
	local hero_star_attr = {}
	for k,v in pairs(hero_star_attrR) do
		local t = hero_star_attr[v.hero_id] or {}
		local arr = v.attrArr
		local nattr = {}
		for ii,vv in ipairs(arr) do
			nattr[vv[1]] = vv[2]
		end
		v.attr = nattr
		t[v.star] = v
		hero_star_attr[v.hero_id] = t
	end
	ret.hero_star_attr = hero_star_attr

	local hero_add_expR = allTblR.hero_add_exp
	local hero_add_exp = {}
	for k,v in pairs(hero_add_expR) do
		hero_add_exp[v.item_id] = v
	end
	ret.hero_add_exp = hero_add_exp

	return ret
end

return f
