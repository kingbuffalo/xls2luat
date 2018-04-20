local function f(project_path,allFldName,allTblR)
	local ret = {}
	local item = require(project_path..".luaformat.itemFormat")
	local itemW = item(allFldName,allTblR)
	for k,v in pairs(itemW) do
		ret[k] = v
	end
	local npc = require(project_path..".luaformat.npcFormat")
	local npcW = npc(allFldName,allTblR)
	for k,v in pairs(npcW) do
		ret[k] = v
	end

	local map = require(project_path.."luaformat.mapFormat")
	local mapw = map(allFldName,allTblR)
	for k,v in pairs(mapw) do
		ret[k] = v
	end
	
	local hero = require(project_path..".luaformat.heroFormat")
	local herow = hero(allFldName,allTblR)
	for k,v in pairs(herow) do
		ret[k] = v
	end

	local army = require(project_path..".luaformat.armyFormat")
	local armyW = army(allFldName,allTblR)
	for k,v in pairs(armyW) do
		ret[k] = v
	end

	local lan = require(project_path..".luaformat.lanFormat")
	local lanw=lan(allFldName,allTblR)
	for k,v in pairs(lanw) do
		ret[k] = v
	end

	return ret
end

return f
