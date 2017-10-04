love.system.run=love.system.openURL
function love.graphics.roundrectangle(mode, x, y, w, h, rd, s)
   local r, g, b, a = love.graphics.getColor()
   local rd = rd or math.min(w, h)/4
   local s = s or 32
   local l = love.graphics.getLineWidth()
   
   local corner = 1
   local function mystencil()
      love.graphics.setColor(255, 255, 255, 255)
      if corner == 1 then
         love.graphics.rectangle("fill", x-l, y-l, rd+l, rd+l)
      elseif corner == 2 then
         love.graphics.rectangle("fill", x+w-rd+l, y-l, rd+l, rd+l)
      elseif corner == 3 then
         love.graphics.rectangle("fill", x-l, y+h-rd+l, rd+l, rd+l)
      elseif corner == 4 then
         love.graphics.rectangle("fill", x+w-rd+l, y+h-rd+l, rd+l, rd+l)
      elseif corner == 0 then
         love.graphics.rectangle("fill", x+rd, y-l, w-2*rd+l, h+2*l)
         love.graphics.rectangle("fill", x-l, y+rd, w+2*l, h-2*rd+l)
      end
   end
   
   love.graphics.setStencil(mystencil)
   love.graphics.setColor(r, g, b, a)
   love.graphics.circle(mode, x+rd, y+rd, rd, s)
   love.graphics.setStencil()
   corner = 2
   love.graphics.setStencil(mystencil)
   love.graphics.setColor(r, g, b, a)
   love.graphics.circle(mode, x+w-rd, y+rd, rd, s)
   love.graphics.setStencil()
   corner = 3
   love.graphics.setStencil(mystencil)
   love.graphics.setColor(r, g, b, a)
   love.graphics.circle(mode, x+rd, y+h-rd, rd, s)
   love.graphics.setStencil()
   corner = 4
   love.graphics.setStencil(mystencil)
   love.graphics.setColor(r, g, b, a)
   love.graphics.circle(mode, x+w-rd, y+h-rd, rd, s)
   love.graphics.setStencil()
   corner = 0
   love.graphics.setStencil(mystencil)
   love.graphics.setColor(r, g, b, a)
   love.graphics.rectangle(mode, x, y, w, h)
   love.graphics.setStencil()
end
function love.graphics.roundScissor(x, y, w, h, r, s)
   local r = r or false
   if w and h and not r then
      r = math.min(w, h)/4
   end
   local s = s or 32
   local cr, cg, cb, ca = love.graphics.getColor()
   
   local function myStencil()
      if x and y and w and h then
         love.graphics.setColor(255, 255, 255, 255)
         love.graphics.circle("fill", x+r, y+r, r, s)
         love.graphics.circle("fill", x+w-r, y+r, r, s)
         love.graphics.circle("fill", x+r, y+h-r, r, s)
         love.graphics.circle("fill", x+w-r, y+h-r, r, s)
         love.graphics.rectangle("fill", x+r, y, w-2*r, h)
         love.graphics.rectangle("fill", x, y+r, w, h-2*r)
      end
   end
   
   if x and y and w and h then
      love.graphics.setStencil(myStencil)
   else
      love.graphics.setStencil()
   end
   love.graphics.setColor(cr, cg, cb, ca)
end
function love.graphics.hexagon(mode, x,y,l)
    local i=(l/2)*3^0.5
    love.graphics.polygon(mode, x,y,x+l,y,x+1.5*l,y+i,x+l,y+2*i,x,y+2*i,x-l*0.5,y+i)
end
function math.getDistance(x1,y1,x2,y2)
	
   return ((x1-x2)^2+(y1-y2)^2)^0.5
end
function math.axisRot(x,y,rot)
	local xx=math.cos(rot)*x-math.sin(rot)*y
	local yy=math.cos(rot)*y+math.sin(rot)*x
	return xx,yy
end
function math.axisRot_P(x,y,x1,y1,rot)
  x=x -x1
  y=y- y1
  local xx=math.cos(rot)*x-math.sin(rot)*y
  local yy=math.cos(rot)*y+math.sin(rot)*x
  return xx+x1,yy+y1
end
function math.sign(x)
	if x>0 then return 1
	elseif x<0 then return -1
	else return 0 end
end
function math.getRot(x1,y1,x2,y2,toggle)
	if x1==x2 and y1==y2 then return 0 end 
	local angle=math.atan((x1-x2)/(y1-y2))
	if y1-y2<0 then angle=angle-math.pi end
	if toggle==true then angle=angle+math.pi end
	if angle>0 then angle=angle-2*math.pi end
	if angle==0 then return 0 end
	return -angle
end
function love.graphics.rect(x,y,w,h)
	local r,g,b = love.graphics.getColor()
	love.graphics.setColor(r,g,b,100)
	love.graphics.rectangle('fill', x,y,w,h)
	love.graphics.setColor(r,g,b)
	love.graphics.rectangle('line', x,y,w,h)
end
local polygon=love.graphics.polygon
function love.graphics.polygon(mode,...)
	if mode=="outline" then
		local r,g,b,a = love.graphics.getColor()
		love.graphics.setColor(r/2,g/2,b/2,a)
		love.graphics.polygon('fill', ...)
		if r+100<256 then r=r+100 end
		if g+100<256 then g=g+100 end
		if b+100<256 then b=b+100 end
		love.graphics.setColor(r,g,b,a)
		love.graphics.polygon('line', ...)
	else
		polygon(mode,...)
	end
end
local circle=love.graphics.circle
function love.graphics.circle(mode,...)
	if mode=="outline" then
		local r,g,b,a = love.graphics.getColor()
		love.graphics.setColor(r/2,g/2,b/2,a)
		love.graphics.circle('fill', ...)
		if r+100<256 then r=r+100 end
		if g+100<256 then g=g+100 end
		if b+100<256 then b=b+100 end
		love.graphics.setColor(r,g,b,a)
		love.graphics.circle('line', ...)
	else
		circle(mode,...)
	end
end
function love.graphics.randomColor()
	local r=math.random(0,255)
	local g=math.random(0,255)
	local b=math.random(0,255)
	return {r,g,b,255}
end
function math.polygonTrans(x,y,rot,size,v)
	local tab={}
	for i=1,#v/2 do
		tab[2*i-1],tab[2*i]=math.axisRot(v[2*i-1],v[2*i],rot)
		tab[2*i-1]=tab[2*i-1]*size+x
		tab[2*i]=tab[2*i]*size+y
	end
	return tab
end
function math.randomPolygon(count,size)
	local v={}
	local rt={}
	local lastK=0
	local lastX=0
	local lastY=0
	local lastRad=0
	local v_c=count
	for i=1,v_c do
		v[i]={}
		v[i].x=love.math.random(-50,50)*size
		v[i].y=love.math.random(-50,50)*size
	end
	local maxY=-50*size
	local oK=0
	for k,v in pairs(v) do
		if v.y>maxY then
			maxY=v.y
			oK=k
		end	
	end
	lastK=oK
	lastX=v[lastK].x
	lastY=v[lastK].y
	table.insert(rt,v[lastK].x)
	table.insert(rt,v[lastK].y)
	local i=0
	while i<100 do
		i=i+1
		local minRad=2*math.pi
		local minK=0
		for k,v in pairs(v) do
			local rad=math.getRot(lastX,lastY,v.x,v.y,true)
			if rad and rad>lastRad then
				if rad<minRad then
					minRad=rad
					minK=k
				end
			end
		end
		if minK==maxK or minK==0 then return rt end
		lastK=minK
		lastRad=minRad
		lastX=v[lastK].x
		lastY=v[lastK].y
		table.insert(rt,v[lastK].x)
		table.insert(rt,v[lastK].y)
	end
end
function math.round(num, n)
	if n > 0 then
		local scale = math.pow(10, n-1)
		return math.floor(num * scale + 0.5) / scale
	elseif n < 0 then
		local scale = math.pow(10, n)
		return math.floor(num * scale + 0.5) / scale
	elseif n == 0 then
		return num
	end
end
function math.clamp(a,low,high) --取三者中间的
	if a>math.pi then a=a-2*math.pi; end
	return math.max(low,math.min(a,high))
end

function math.getLoopDist(p1,p2,loop)
	local dist=math.abs(p1-p2)
	local dist2=loop-math.abs(p1-p2)
	if dist>dist2 then dist=dist2 end
	return dist
end

function table.getIndex(tab,item)
	for k,v in pairs(tab) do
		if v==item then return k end
	end
end

function table.removeItem(tab,item)
	
   table.remove(tab,table.getIndex(tab,item))
end

function string.splite(str,keyword)
	local tab={}
	local index=1
	local from=1
	local to=1
	while true do
		if string.sub(str,index,index)==keyword then
			to=index-1
			if from>to then 
				table.insert(tab, "")
			else
				table.insert(tab, string.sub(str,from,to))
			end
			from=index+1
		end
		index=index+1
		if index>string.len(str) then
			if from<=string.len(str) then
				table.insert(tab, string.sub(str,from,string.len(str)))
			end
			return tab
		end
	end
end

function table.copy(st,copyto,ifcopyfunction)
    copyto=copyto or {}
    for k, v in pairs(st or {}) do
        if type(v) == "table" then
            copyto[k] = table.copy(v,copyto[k])          
        elseif type(v) == "function" then 
        	if ifcopyfunction then
        		copyto[k] = v
        	end
        else 
            copyto[k] = v
        end
    end
    return copyto
end

function string.generateName(num,seed)
   local list = {}
   list[1] = {{'b','c','d','f','g','h','j','l','m','n','p','r','s','t','v','x','z','k','w','y'},{'qu','th','ll','ph'}} --21,4
   list[2] = {'a','e','i','o','u'} --v
   random = love.math.newRandomGenerator(os.time())
   random:setSeed(love.math.random(1,9999))
   local first = random:random(2)
   local name = ''
   local char = ''
   local nchar = ''
   --creates first letter(s)
   if first == 2 then --v
      for i=1, random:random(2) do
         char = list[2][random:random(#list[2])]
         if i == 2 then
            while char == name do
               char = list[2][random:random(#list[2])]
            end
            name = name .. char
         else
            name = name .. char
         end
      end
   else --c
      if random:random(2) == 1 then
         for i=1, random:random(2) do
            char = list[1][1][random:random(#list[1][1])]
            if i == 2 then
               while char == name do
                  char = list[1][1][random:random(#list[1][1])]
               end
               name = name .. char
            else
               name = char
            end
         end
      else
         char = list[1][2][random:random(#list[1][2])]
         if char == 'qu' then
            nchar = list[2][random:random(2,3)]
            first = 2
         end
         name = char .. nchar
      end
   end

   --creates the rest of the name
   local add = ''
   for i=1,num do
      first = first == 1 and 2 or 1 -- change between v and c
      add = ''
      if first == 2 then --v
         for i=1, random:random(2) do
            char = list[2][random:random(#list[2])]
            if i == 2 then
               while char == add do
                  char = list[2][random:random(#list[2])]
               end
               add = add .. char
            else
               add = add .. char
            end
         end
      else --c
         if random:random(2) == 1 then
            for i=1, random:random(2) do
               char = list[1][1][random:random(#list[1][1])]
               if i == 2 then
                  while char == add do
                     char = list[1][1][random:random(#list[1][1])]
                  end
                  add = add .. char
               else
                  add = add .. char
               end
            end
         else
            char = list[1][2][random:random(#list[1][2])]
            if char == 'qu' then
               nchar = list[2][random:random(2,3)]
            end
            add = char .. nchar
         end
      end
      name = name .. add
   end

   return name
end
function table.save(tab,name)
    name=name or "test"
    local output="local "..name.."=\n"
    local function ergodic(target,time)
        time=time+1
        output=output.."{\n"
        for k,v in pairs(target) do
            output=output .. string.rep("\t",time)
            if type(v)=="table" then
                if type(k)=="number" then
                    output=output.."["..k.."]".."="
                elseif type(k)=="string" then
                    output=output.."[\""..k.."\"]="
                end 
                ergodic(v,time)
                output=output .. string.rep("\t",time)
                output=output.."},\n"
            elseif type(v)=="string" then
                if type(k)=="number" then
                    output=output.."["..k.."]".."=\""..v.."\",\n"
                elseif type(k)=="string" then
                    output=output.."[\""..k.."\"]=\""..v.."\",\n"
                end 
            elseif type(v)=="number" then
                if type(k)=="number" then
                    output=output.."["..k.."]".."="..v..",\n"
                elseif type(k)=="string" then
                    output=output.."[\""..k.."\"]="..v..",\n"
                end 
            end
        end
    end
    ergodic(tab,0)
    output=output.."}\n return "..name
    return output 
end

function math.pointTest(x,y,verts)
    local pX={}
    local pY={}
    for i=1,#verts,2 do
        table.insert(pX, verts[i])
        table.insert(pY, verts[i+1])
    end
    local oddNodes=false
    local pCount=#pX
    local j=pCount
    for i=1,pCount do
        if ((pY[i]<y and pY[j]>=y) or (pY[j]<y and pY[i]>=y))
            and (pX[i]<=x or pX[j]<=x) then
            if pX[i]+(y-pY[i])/(pY[j]-pY[i])*(pX[j]-pX[i])<x then
                oddNodes=not oddNodes
            end
        end
        j=i
    end
    return oddNodes
end

function math.pointTest_xy(x,y,pX,pY)
    local oddNodes=false
    local pCount=#pX
    local j=pCount
    for i=1,pCount do
        if ((pY[i]<y and pY[j]>=y) or (pY[j]<y and pY[i]>=y))
            and (pX[i]<=x or pX[j]<=x) then
            if pX[i]+(y-pY[i])/(pY[j]-pY[i])*(pX[j]-pX[i])<x then
                oddNodes=not oddNodes
            end
        end
        j=i
    end
    return oddNodes
end


function math.polar(x,y) 
  return math.getDistance(x,y,0,0),math.atan2(y, x)
end

function math.cartesian(r,phi)
  return r*math.cos(phi),r*math.sin(phi)
end

function table.insertM(tab,...)
  for i,v in ipairs({...}) do
    table.insert(tab, v)
  end
end