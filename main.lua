local string=string
local ipairs = iparis
local io=io
local floor=math.floor
local assert=assert
local print = print
local require = require
local tonumber = tonumber
local loadstring = loadstring
local serpent = require("serpent")
local allTblR = {}
local allTblW = {}
local allFldName = {}
local project_path
local enum = {}
local enumTy = {}
print_r = require("print_r")

local function string_split(s,sep)
     local t = {}
     string.gsub(s,'[^'..sep..']+',function(w)
 		t[#t+1]=w 
	end)
     return t
end

local function format(fn,i,ty,strv)
    if ty == "i" then return floor(tonumber(strv)) end
    if ty == "t" then
        local s = "do local _= " .. strv .. ";return _ end"
		local ok,v = serpent.load(s)
		if ok ~= true then
			print(ok)
			print(s)
			print(fn,i)
			assert(false)
		end
        return v
    end
	if ty == "s" then return strv end
	return strv
end

local function formatCsvLine2LuaT(fn,fldNameArr,fldTArr,line)
    local ret = {}
    line = string.gsub(line,"\"","")
    line = string.gsub(line,"[1-9A-Z_]+",function(w) 
		if enum[w] ~= nil then return enum[w] end
		return w
	end)
    line = string.gsub(line,"%b{}",function(a)
          return string.gsub(a,',','_buffalo_comma_')
     end)
    local strArr = string_split(line,',')
    for i=1,#strArr do
        local s = strArr[i]
        s = string.gsub(s,"_buffalo_comma_",",")
        ret[fldNameArr[i]] = format(fn,i,fldTArr[i],s)
    end
    return ret
end

local function readcsv(fp)
	local fn = fp
	local fp = assert(io.open(fp,"r"))
	if fp == nil then return end
	local allStr = fp:read("*a")
	fp:close()
	local lineT = string_split(allStr,"\r\n")
    local fldNameArr = string_split(lineT[2],",")
    local fldTArr = string_split(lineT[3],",")
    local ret = {}
    for i=4,#lineT do
        ret[#ret+1] = formatCsvLine2LuaT(fn,fldNameArr,fldTArr,lineT[i])
    end
    return ret,fldNameArr
end

local function singleCmd(fn)
	local lt,fldNameArr = readcsv(project_path .. "/csv/"..fn)
	local key = string.sub(fn,1,-5)
	allTblR[key] = lt
	allFldName[key] = fldNameArr
end

local function dealwithEnum(enumfp)
    local fp = assert(io.open(enumfp,"r"))
    if fp == nil then return end
    local allStr = fp:read("*a")
    fp:close()
	local lineT = string_split(allStr,'\r\n')
	for i=2,#lineT do
		local line = lineT[i]
		line = string.gsub(line,"\"","")
		local strArr = string_split(line,',')
		if strArr[2] == "i" then
			enum[strArr[1]] = floor(tonumber(strArr[3]))
			enumTy[strArr[1]] = "number"
		else
			enum[strArr[1]] = strArr[3]
			enumTy[strArr[1]] = "string"
		end
	end
	local HERO_ATTR_MAP_MOIDX = {}
	for i=1,enum.HERO_ATTR_MAX do
		local key = "MOIDX_ARMY_HERO_ATTR_" .. i
		HERO_ATTR_MAP_MOIDX[i] = enum[key]
	end

	local ARMY_ATTR_MAP_MOIDX = {}
	for i=1,enum.ARMY_ATTR_MAX do
		local key ="MOIDX_ARMY_ARMY_ATTR_"..i
		ARMY_ATTR_MAP_MOIDX[i] = enum[key]
	end
	enum.HERO_ATTR_MAP_MOIDX = HERO_ATTR_MAP_MOIDX
	enum.ARMY_ATTR_MAP_MOIDX = ARMY_ATTR_MAP_MOIDX

end

local function isfileexist(f)
	local fp = io.open(f,"r")
	local bexit = fp ~= nil
	if fp then fp:close() end
	return bexit
end

local function formatAll()
	local f = project_path .. "luaformat.format"
	f = require(f)
	allTblW = f(project_path,allFldName,allTblR)
end

--local function formatAll()
--	for k,tblvos in pairs(allTblR) do
--		if isfileexist(project_path.."/luaformat/"..k..".lua") then
--			local formatOutputF = require(project_path.."/luaformat/"..k)
--			allTblW[k] = formatOutputF(tblvos)
--		else
--			local keyName = allFldName[k][1]
--			local tbl = {}
--			for i,v in pairs(tblvos) do
--				tbl[v[keyName]]= v
--			end
--			allTblW[k] = tbl
--		end
--	end
--end

local function writeEnum()
	local enumStrT = {"local M = {"}
	for k,v in pairs(enum) do
		if enumTy[k] ~= nil then
			if enumTy[k] == "string" then
				enumStrT[#enumStrT+1] = k.."=\""..v.."\","
			else
				enumStrT[#enumStrT+1] = k.."="..v..","
			end
		else
			local vStr = serpent.dump(v)
			vStr = string.sub(vStr,12,-14)
			enumStrT[#enumStrT+1] = k.."="..vStr..","
		end
	end
	enumStrT[#enumStrT+1] = "}\nreturn M"
	local s = table.concat(enumStrT,"\n")
	local f = project_path.."/luat/enum.lua"
	local wf = io.open(f,"w")
	wf:write(s)
	wf:close()
end
local function writeF()
	for k,v in pairs(allTblW) do
		local f = project_path.."/luat/"..k..".lua"
		local s = serpent.dump(v)
		local wf = io.open(f,"w")
		wf:write(s)
		wf:close()
	end
	writeEnum()
end

local function readAllCsvF()
	local path = arg[1]
	local allFp = arg[2]
	local csvp = "csv"
	local fnarr = string_split(allFp,",")
	project_path = path
	local enumfp = path .. "/"..csvp .. "/enum.csv"
	dealwithEnum(enumfp)

	for k,v in pairs(fnarr) do
		if string.find(v,"enum") == nil then
			singleCmd(v)
		end
	end
end

local function checkF()
	local f = project_path .. "luacheck.check"
	f = require(f)
	f(project_path,allFldName,allTblR,allTblW,enum)
end

local function main()
	readAllCsvF()
	formatAll()
	writeF()
	checkF()
end
main()
