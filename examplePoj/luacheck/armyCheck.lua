local function c(project_path,allFldName,allTblR,allTblW,enum)
	local locidcocheck = require(project_path..".luacheck.locidcocheck")

	local army_skillR = allTblR.army_skill
	for i,v in pairs(army_skillR) do
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res) then
			print("army_weapon locidcocheck false")
			print_r(v)
			assert(false)
		end
	end

	local army_levelR = allTblR.army_level
	for i,v in pairs(army_levelR) do
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res) then
			print("army_weapon locidcocheck false")
			print_r(v)
			assert(false)
		end
	end

	local army_weaponR = allTblR.army_weapon
	for k,v in pairs(army_weaponR) do
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res1) then
			print("army_weapon locidcocheck false")
			print_r(v)
			assert(false)
		end
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res2) then
			print("army_weapon locidcocheck false")
			print_r(v)
			assert(false)
		end
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res3) then
			print("army_weapon locidcocheck false")
			print_r(v)
			assert(false)
		end
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res4) then
			print("army_weapon locidcocheck false")
			print_r(v)
			assert(false)
		end
	end
end

return c
