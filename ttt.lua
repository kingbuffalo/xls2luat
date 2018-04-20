local npc = require("examplePoj.luat.npc")
local print_r = require("print_r")

for k,v in pairs(npc) do
	print(k,v)
	for key,value in pairs(v) do
		print(key,value)
		for kk,vv in pairs(value) do
			print(kk,vv)
		end
	end
end

