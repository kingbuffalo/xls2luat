local function c(allFldName,allTblR,allTblW,enum,locidcoFld)
	local itemW = allTblW.item
	local giftW = allTblW.gift
	local lotteryW = allTblW.lottery
	for i,v in ipairs(locidcoFld) do
		local loc,id,co = v[1],v[2],v[3]
		if loc == enum.LOC_BAG then
			if itemW[id] == nil then return false end
		end
		if loc == enum.LOC_GIFT then
			if giftW[id] == nil then return false end
		end
		if loc == enum.LOC_LOTTERY then
			if lottery[id] == nil then return false end
		end
		if loc == enum.LOC_CITY then
			if id ~= CITY_RES_COIN
				and id ~= CITY_RES_FOOD
				and id ~= CITY_RES_SOLDIER
				and id ~= CITY_RES_MORALE
				and id ~= CITY_RES_POLICE
				and id ~= CITY_RES_SPEAR
				and id ~= CITY_RES_ARROW
				and id ~= CITY_RES_HORSE
				and id ~= CITY_RES_SHIELD
				and id ~= CITY_RES_STICK
				and id ~= CITY_RES_STONE
				and id ~= CITY_RES_ARROW_TOWER then return false end
		end
		if loc == enum.LOC_BASE_RES then
			if id ~= BASE_RES_COIN
				and id ~= BASE_RES_GOLD
				and id ~= BASE_RES_BIND_GOLD
				and id ~= BASE_RES_ROUND then return false end
		end
	end
	return true
end
return c
