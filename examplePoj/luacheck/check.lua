local function f(project_path,allFldName,allTblR,allTblW,enum)
	local c = require(project_path..".luacheck.heroCheck")
	c(project_path,allFldName,allTblR,allTblW,enum)

	c = require(project_path..".luacheck.armyCheck")
	c(project_path,allFldName,allTblR,allTblW,enum)

	c = require(project_path..".luacheck.itemCheck")
	c(project_path,allFldName,allTblR,allTblW,enum)

--	c = require(project_path..".luacheck.itemCheck")
--	c(project_path,allFldName,allTblR,allTblW,enum)

	return ret
end

return f
