---
--- Created by ttwings.
--- DateTime: 2017/10/20 0:58
--- 区域场景数据
--- @class Region
--local Class = require("lib.middleclass")
--Region = Class("Region")
--function Region:init(name)
--    self.npc = require("assets/data/" .. name .."Npc")
--    self.room = require("assets/data/" .. name .."Room")
--    self.obj = require("assets/data/" .. name .."Obj")
--    self.map = require("assets/data/" .. name .."Map")
--end
local r = {}
Region = r
function r:load(name)
    self.npc = require("assets/data/" .. name .."Npc")
    self.room = require("assets/data/" .. name .."Room")
    self.obj = require("assets/data/" .. name .."Obj")
    self.map = require("assets/data/" .. name .."Map")
end
function r:update(dt)
    self.map:update(dt)
end
function r:draw()
    self.map:draw()
end
--function Region:readData(data)
--    for k, v in pairs(data) do
--        self[k] = v
--    end
--end
--Region = {}
--Region.name="襄阳武馆"
---- 地图初始化时，可以把物品保存到这里
--Region.objs={}
------ 保存人物信息
--Region.actors={}
---- 保存工作信息
--Region.jobs={}
--Region.tiledMap = "wuguan"
return r