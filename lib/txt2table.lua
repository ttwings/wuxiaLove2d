------------------------------
--功能：字符串按格式分解
--输入：字符串，格式符号
--输出：分割好的字符串table
function trimstr(str,c)
	local t={}
	if nil~=str then
		local s=string.gsub(str,"^%s*(.-)%s*$","%1")  --去除字符串首位空格
		if nil==string.find(c," ") then     --分隔符不为空格
			local strtmp=string.gsub(s," ","") --消除所有空格
			local strall=string.gsub(strtmp,c," ") --用空格代替分割符
			s=strall
		end
		for k,v in string.gmatch(s,"%S*") do  -- 泛型循环
			if 0~=string.len(k) then
				t[#t+1]=k
			end
		end
	end
	return t
end
--------------------------------------------------
--功能：解析非字段名
--输入：字段名table，读取第一行字符串即表头
--输出：解析后的字符串
function parseLine(tFieldName,rLine)
	local t={}
	local title={}
	local strInfo=""
	local num=0
	t=trimstr(rLine,"\t") --
	-- title=trimstr(tFiledName,"\t")
	num=#(tFieldName)>#(t) and #(t) or #(tFieldName)
	for i=1,num do
		local strInFotmp=string.format("%s=\"%s\",",tFieldName[i],t[i])
		strInfo=string.format("%s%s",strInfo,strInFotmp)
	end
	return strInfo
end
------------------------------------------------------------------
-- 将excel文本文件数据转化为table，表头为table的key
-- 文本数据用tab间隔
-- txtName txtFilename,luaName,luaName.
function excel2Table(dirName,txtName,luaName)
	local name=luaName and luaName or txtName
	local readFile=io.open(dirName..txtName..".txt","r")
	assert(readFile)
	local writeFile=io.open(dirName..name..".lua","w")
	assert(writeFile)

	local tFieldName={}
	for strField in readFile:lines() do
		local tmp=string.gsub(strField,"^%s*(.-)%s*$","%1")
		if 0~=string.len(tmp) then
			if 1~=select(1,string.find(tmp,"#")) then
				tFieldName=trimstr(tmp,"\t")
			break
			end
		end
	end

	local i=1
	writeFile:write(txtName.."={\n")
	for rowline in readFile:lines() do
		local tmp=string.gsub(rowline,"^%s*(.-)%s*$","%1")
		if 1~=select(1,string.find(tmp,"#")) then
			local t=""
			t = trimstr(rowline,"\t")[1]
			local strInfo=parseLine(tFieldName,rowline)
			local titleName ={}
			titleName = "{"..strInfo.."}"
			local writeInfo=string.format("\t[\"%s\"]={%s},\n",t,strInfo)
			writeFile:write(writeInfo)
			i=i+1
		end
	end
	writeFile:write("\t}")
	readFile:close()
	writeFile:close()
end

return txt2table
