local function c(project_path,allFldName,allTblR,allTblW,enum)
	local giftR = allTblR.gift
	local locidcocheck = require(project_path..".luacheck.locidcocheck")
	for k,v in pairs(giftR) do
		local out_res = v.out_res
		if not locidcocheck(allFldName,allTblR,allTblW,enum,out_res) then
			print("locidcocheck false")
			print_r(v)
			assert(false)
		end
		for ii,vv in ipairs(out_res) do
			local loc,id,co = vv[1],vv[2],vv[3]
			if loc == enum.LOC_GIFT then
				assert(id ~= v.gift_id,"circle gift:"..id )
			end
		end
	end

	local lotteryR = allTblR.lottery
	for k,v in pairs(lotteryR) do
		local out_res = v.out_res
		if not locidcocheck(allFldName,allTblR,allTblW,enum,out_res) then
			print("locidcocheck false")
			print_r(v)
			assert(false)
		end
		for ii,vv in ipairs(out_res) do
			local loc,id,co = vv[1],vv[2],vv[3]
			if loc == enum.LOC_LOTTERY then
				assert(id ~= v.lottery_id,"circle lottery:"..id)
			end
		end
	end


	local shopR = allTblR.shop
	for i,v in pairs(shopR) do
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res) then
			print("army_weapon locidcocheck false")
			print_r(v)
			assert(false)
		end
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.out_res) then
			print("army_weapon locidcocheck false")
			print_r(v)
			assert(false)
		end
	end
end

return c
