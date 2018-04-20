local function c(project_path,allFldName,allTblR,allTblW,enum)
	local heroR = allTblR.hero
	local itemW = allTblW.item
	local locidcocheck = require(project_path..".luacheck.locidcocheck")

	for k,v in pairs(heroR) do
		if itemW[v.star_item_id] == nil then
			print("star_item_id not found")
			print_r(v)
			assert(false)
		end
	end

	local hero_starR=allTblR.hero_star
	for k,v in pairs(hero_starR) do
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res) then
			print("locidcocheck false")
			print_r(v)
			assert(false)
		end
	end
end

return c
