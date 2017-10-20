-- 窗口配置表格文件
guiData={
	["头像"]={visible=true,type="image",x=0,y=0,width=192,height=192,contant="",color="RED",image=nil},
	["世家"]={visible=true,type="txt",x=100,y=0,contant="",color=""},
	["称号"]={visible=true,type="txt",x=100,y=20,contant="",color=""},
	["名称"]={visible=true,type="txt",x=100,y=40,contant="",color=""},
	["气血"]={visible=true,title="气血",type="barHP",x=100,y=60,contant="0",max=100,now=100,color="RED"},
	["真气"]={visible=true,title="真气",type="barMP",x=100,y=80,contant="0",max=100,now=100,color="BLUE"},
	["精力"]={visible=true,title="精力",type="barAP",x=100,y=100,contant="",max=100,now=100,color="WHITE"},
	["食物"]={visible=true,title="食物",type="barFood",x=100,y=120,contant="",max=100,now=100,color="YELLOW"},
	["饮水"]={visible=true,title="饮水",type="barWater",x=100,y=140,contant="",max=100,now=100,color="SKY"},
	["状态"]={visible=true,title="状态",type="state",x=0,y=100,contant="",max=100,now=100,color="SKY"},
	["国家"]={visible=true,type="txt",x=100,y=180,contant="",color="RED"},
	["门派"]={visible=true,type="txt",x=100,y=200,contant="",color="RED"},
	["区域"]={visible=true,type="txt",x=400,y=20,contant="",color="GREEN"},
	["房间"]={visible=true,type="txt",x=500,y=20,contant="",color="GREEN"},
	["行为"]={visible=true,type="txt",x=600,y=20,contant="",color="蓝色"},
	["描述"]={visible=true,type="long",x=8,y=160,width=280,height=200,alpha=64,contant="",color=nil},
	-- ["时间"]={visible=true,type="txt",x=500,y=0,contant="虎年 十二月 十日 子时 晴朗",color=nil},
	["对话"]={visible=false,type="dialog",x=500,y=160,width=280,height=100,alpha=64,contant="对话测试文本这是一段长文本的对话测试",color="WHITE",image=nil},
	["地图"]={visible=true,title="测试",type="map",x=1080,y=0,width=200,height=200,alpha=64,contant="",color=nil},
	["技能"]={visible=true,type="skill",x=4,y=752,width=1280,height=48,alpha=64,contant="技能栏测试",align="center",color=nil,image=nil},
	["发现"]={visible=true,type="txt",x=440,y=40,contant="",color=nil},
	["坐标"]={visible=true,type="txt",x=200,y=40,contant="",color=nil},
	["信息"]={visible=true,title="讯息",type="long",x=8,y=400,width=280,height=340,alpha=64,contant="",color=nil},
	["商铺"]={visible=false,type="shop",x=320,y=200,width=640,height=400,alpha=200,contant="",color=nil,image=""},
	["口袋"]={visible=true,title="口袋",type="bag",x=1080,y=500,width=200,height=200,alpha=64,contant=nil,align="center",color=nil},

}

return guiData