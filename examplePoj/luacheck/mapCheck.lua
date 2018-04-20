local function c(project_path,allFldName,allTblR,allTblW,enum)
	local locidcocheck = require(project_path..".luacheck.locidcocheck")

	local city_levelR = allTblR.city_level
	for i,v in pairs(city_levelR) do
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res) then
			print("locidcocheck false")
			print_r(v)
			assert(false)
		end
	end

	local build_levelR = allTblR.build_level
	for i,v in pairs(build_levelR) do
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.need_res) then
			print("locidcocheck false")
			print_r(v)
			assert(false)
		end
		if not locidcocheck(allFldName,allTblR,allTblW,enum,v.out_res) then
			print("locidcocheck false")
			print_r(v)
			assert(false)
		end
	end
end

return c
