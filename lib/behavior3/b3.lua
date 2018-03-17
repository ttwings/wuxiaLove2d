local json = require 'lib.behavior3.json'
_class = {}

b3 = {
	VERSION = "0.2.0",

	--Returning status
	SUCCESS = 1,
	FAILURE = 2,
	RUNNING = 3,
	ERROR 	= 4,

	--Node categories
	COMPOSITE = "composite",
	DECORATOR = "decorator",
	ACTION = "action",
	CONDITION = "condition",

	createUUID = function()
		local seed = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'}
		local tb = {}
		for i =1,32 do
			table.insert(tb, seed[math.random(1,16)])
		end
		return  table.concat(tb)
	end,

	Class = function(classname, super)
	   	local superType = type(super)
	    local cls

	    --如果父类既不是函数也不是table则说明父类为空
	    if superType ~= "function" and superType ~= "table" then
	        superType = nil
	        super = nil
	    end

	    --如果父类的类型是函数或者是C对象
	    if superType == "function" or (super and super.__ctype == 1) then
	        -- inherited from native C++ Object
	        cls = {}

	        --如果父类是表则复制成员并且设置这个类的继承信息
	        --如果是函数类型则设置构造方法并且设置ctor函数
	        if superType == "table" then
	            -- copy fields from super
	            for k,v in pairs(super) do cls[k] = v end
	            cls.__create = super.__create
	            cls.super    = super
	        else
	            cls.__create = super
	            cls.ctor = function() end
	        end

	        --设置类型的名称
	        cls.__cname = classname
	        cls.__ctype = 1

	        --定义该类型的创建实例的函数为基类的构造函数后复制到子类实例
	        --并且调用子数的ctor方法
	        function cls.new(...)
	            local instance = cls.__create(...)
	            -- copy fields from class to native object
	            for k,v in pairs(cls) do instance[k] = v end
	            instance.class = cls
	            instance:ctor(...)
	            return instance
	        end

	    else
	        --如果是继承自普通的lua表,则设置一下原型，并且构造实例后也会调用ctor方法
	        -- inherited from Lua Object
	        if super then
	            cls = {}
	            setmetatable(cls, {__index = super})
	            cls.super = super
	        else
	            cls = {ctor = function() end}
	        end

	        cls.__cname = classname
	        cls.__ctype = 2 -- lua
	        cls.__index = cls

	        function cls.new(...)
	            local instance = setmetatable({}, cls)
	            instance.class = cls
	            instance:ctor(...)
	            return instance
	        end
	    end

	    return cls
	end,

	decodeJson = function(str)
		return json.decode(str)
	end
}
