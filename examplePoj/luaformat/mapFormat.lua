local function xxx()
end

local function f(allFldName,allTblR)
	local ret = {}
	local global_map = {}
	local global_mapR = allTblR.global_map
	for k,v in pairs(global_mapR) do
		local xObj = global_map[v.x] or {}
		xObj[v.y] = v
		global_map[v.x] = xObj
	end
	ret.global_map = global_map
	
	local city = {}
	local cityR = allTblR.city
	for k,v in pairs(cityR) do
		city[v.city_id] = v
	end
	ret.city = city

--	local city = {}
--	local cityR = allTblR.city
--	for k,v in pairs(cityR) do
--		local t = city[v.map_id] or {}
--		t[v.city_id] = v
--		city[v.map_id] = t
--	end
--	ret.city = city

	local map_type = {}
	local map_typeR = allTblR.map_type
	for k,v in pairs(map_typeR) do
		local tyObj = map_type[v.type] or {}
		tyObj[v.army_type] = v
		map_type[v.type] = tyObj
	end
	ret.map_type = map_type

	local city_levelR = allTblR.city_level
	local city_level = {}
	for k,v in pairs(city_levelR) do
		local t = city_level[v.type] or {}
		t[v.level] = v
		city_level[v.type] = t
	end
	ret.city_level = city_level

	local buildR = allTblR.build
	local build = {}
	for k,v in pairs(buildR) do
		build[v.build_id] = v
	end
	ret.build=build

	local build_levelR = allTblR.build_level
	local build_level = {}
	local maxLv = {}
	for k,v in pairs(build_levelR) do
		local t = build_level[v.build_id] or {}
		t[v.level] = v
		build_level[v.build_id] = t
		t = maxLv[v.build_id] or 0
		if t < v.level then t = v.level end
		maxLv[v.build_id] = t
	end
	ret.build_level = build_level
	ret.build_max_level = maxLv

	ret.map_neighbor_odd = {
		{0,-1}, {-1,-1}, {-1,0},
		{0,1}, {1,0}, {1,-1},
	}

	ret.map_neighbor_even = {
		{0,-1}, {-1,0}, {-1,1},
		{0,1}, {1,1}, {1,0},
	}

--	local range = {
--		[1] = {
--			odd={
--				{-1,0},
--				{-1,-1},
--				{0,-1},
--				{0,1},
--				{1,-1},
--				{-1,-1},
--			},
--			even={
--				{-1,0},
--				{-1,1},
--				{0,-1},
--				{0,1},
--				{1,-1},
--				{-1,1},
--			},
--		},
--		[2] = {
--			odd={
--				{-1,0},
--				{-1,-1},
--				{0,-1},
--				{0,1},
--				{1,-1},
--				{-1,-1},
--			},
--			even={
--				{-1,0},
--				{-1,1},
--				{0,-1},
--				{0,1},
--				{1,-1},
--				{-1,1},
--			},
--		}
--	}

	return ret
end

return f
