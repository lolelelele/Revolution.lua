--[[
 Base
]]--
RevolutionBase={}RevolutionBase.debug=false;local a={}local b={up=172,down=173,left=174,right=175,select=176,back=177}local c=0;local d=nil;local e=nil;local f=0.11;local g=0.03;local h=1.0;local i=0.038;local j=0;local k=0.365;local l=0.005;local m=0.005;local function n(o)if RevolutionBase.debug then Citizen.Trace('[RevolutionBase] '..tostring(o))end end;local function p(q,r,s)if q and a[q]then a[q][r]=s;n(q..' menu property changed: { '..tostring(r)..', '..tostring(s)..' }')end end;local function t(q)if q and a[q]then return a[q].visible else return false end end;local function u(q,v,w)if q and a[q]then p(q,'visible',v)if not w and a[q]then p(q,'currentOption',1)end;if v then if q~=e and t(e)then u(e,false)end;e=q end end end;local function x(o,y,z,A,B,C,D,E,F)SetTextColour(B.r,B.g,B.b,B.a)SetTextFont(A)SetTextScale(C,C)if E then SetTextDropShadow(2,2,0,0,0)end;local G=a[e]if G then if D then SetTextCentre(D)elseif F then SetTextWrap(G.x,G.x+G.width-l)SetTextRightJustify(true)end end;Citizen.InvokeNative(0x25FBB336DF1804CB,"STRING")Citizen.InvokeNative(0x6C188BE134E074AA,tostring(o))Citizen.InvokeNative(0xCD015E5BB0D96A57,y,z)end;local function H(y,z,I,J,B)DrawRect(y,z,I,J,B.r,B.g,B.b,B.a)end;local function K()local G=a[e]if G then local y=G.x+G.width/2;local z=G.y+f/2;if G.titleBackgroundSprite then DrawSprite(G.titleBackgroundSprite.dict,G.titleBackgroundSprite.name,y,z,G.width,f,0.,255,255,255,255)else H(y,z,G.width,f,G.titleBackgroundColor)end;x(G.title,y,z-f/2+g,G.titleFont,G.titleColor,h,true)end end;local function L()local G=a[e]if G then local y=G.x+G.width/2;local z=G.y+f+i/2;local M={r=G.titleBackgroundColor.r,g=G.titleBackgroundColor.g,b=G.titleBackgroundColor.b,a=255}H(y,z,G.width,i,G.subTitleBackgroundColor)x(G.subTitle,G.x+l,z-i/2+m,j,M,k,false)if c>G.maxOptionCount then x(tostring(G.currentOption)..' / '..tostring(c),G.x+G.width,z-i/2+m,j,M,k,false,false,true)end end end;local function N(o,O)local G=a[e]local y=G.x+G.width/2;local P=nil;if G.currentOption<=G.maxOptionCount and c<=G.maxOptionCount then P=c elseif c>G.currentOption-G.maxOptionCount and c<=G.currentOption then P=c-(G.currentOption-G.maxOptionCount)end;if P then local z=G.y+f+i+i*P-i/2;local Q=nil;local R=nil;local S=nil;local E=false;if G.currentOption==c then Q=G.menuFocusBackgroundColor;R=G.menuFocusTextColor;S=G.menuFocusTextColor else Q=G.menuBackgroundColor;R=G.menuTextColor;S=G.menuSubTextColor;E=true end;H(y,z,G.width,i,Q)x(o,G.x+l,z-i/2+m,j,R,k,false,E)if O then x(O,G.x+l,z-i/2+m,j,S,k,false,E,true)end end end;function RevolutionBase.FixThread(T)Citizen.CreateThreadNow(T,"fix_thread")end;function RevolutionBase.CreateMenu(q,U)a[q]={}a[q].title=U;a[q].subTitle='INTERACTION MENU'a[q].visible=false;a[q].previousMenu=nil;a[q].aboutToBeClosed=false;a[q].x=0.0175;a[q].y=0.025;a[q].width=0.23;a[q].currentOption=1;a[q].maxOptionCount=10;a[q].titleFont=1;a[q].titleColor={r=0,g=0,b=0,a=255}a[q].titleBackgroundColor={r=245,g=127,b=23,a=255}a[q].titleBackgroundSprite=nil;a[q].menuTextColor={r=255,g=255,b=255,a=255}a[q].menuSubTextColor={r=189,g=189,b=189,a=255}a[q].menuFocusTextColor={r=0,g=0,b=0,a=255}a[q].menuFocusBackgroundColor={r=245,g=245,b=245,a=255}a[q].menuBackgroundColor={r=0,g=0,b=0,a=160}a[q].subTitleBackgroundColor={r=a[q].menuBackgroundColor.r,g=a[q].menuBackgroundColor.g,b=a[q].menuBackgroundColor.b,a=255}a[q].buttonPressedSound={name="SELECT",set="HUD_FRONTEND_DEFAULT_SOUNDSET"}n(tostring(q)..' menu created')end;function RevolutionBase.CreateSubMenu(q,V,W)if a[V]then RevolutionBase.CreateMenu(q,a[V].title)if W then p(q,'subTitle',string.upper(W))else p(q,'subTitle',string.upper(a[V].subTitle))end;p(q,'previousMenu',V)p(q,'x',a[V].x)p(q,'y',a[V].y)p(q,'maxOptionCount',a[V].maxOptionCount)p(q,'titleFont',a[V].titleFont)p(q,'titleColor',a[V].titleColor)p(q,'titleBackgroundColor',a[V].titleBackgroundColor)p(q,'titleBackgroundSprite',a[V].titleBackgroundSprite)p(q,'menuTextColor',a[V].menuTextColor)p(q,'menuSubTextColor',a[V].menuSubTextColor)p(q,'menuFocusTextColor',a[V].menuFocusTextColor)p(q,'menuFocusBackgroundColor',a[V].menuFocusBackgroundColor)p(q,'menuBackgroundColor',a[V].menuBackgroundColor)p(q,'subTitleBackgroundColor',a[V].subTitleBackgroundColor)else n('Failed to create '..tostring(q)..' submenu: '..tostring(V)..' parent menu doesn\'t exist')end end;function RevolutionBase.CurrentMenu()return e end;function RevolutionBase.OpenMenu(q)if q and a[q]then PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",true)u(q,true)n(tostring(q)..' menu opened')else n('Failed to open '..tostring(q)..' menu: it doesn\'t exist')end end;function RevolutionBase.IsMenuOpened(q)return t(q)end;function RevolutionBase.IsAnyMenuOpened()for q,X in pairs(a)do if t(q)then return true end end;return false end;function RevolutionBase.IsMenuAboutToBeClosed()local G=a[e]if G then return G.aboutToBeClosed else return false end end;function RevolutionBase.CloseMenu()local G=a[e]if G then if G.aboutToBeClosed then G.aboutToBeClosed=false;u(e,false)n(tostring(e)..' menu closed')PlaySoundFrontend(-1,"QUIT","HUD_FRONTEND_DEFAULT_SOUNDSET",true)c=0;e=nil;d=nil else G.aboutToBeClosed=true;n(tostring(e)..' menu about to be closed')end end end;function RevolutionBase.Button(o,O)local Y=o;if O then Y='{ '..tostring(Y)..', '..tostring(O)..' }'end;local G=a[e]if G then c=c+1;local Z=G.currentOption==c;N(o,O)if Z then if d==b.select then PlaySoundFrontend(-1,G.buttonPressedSound.name,G.buttonPressedSound.set,true)n(Y..' button pressed')return true elseif d==b.left or d==b.right then PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",true)end end;return false else n('Failed to create '..Y..' button: '..tostring(e)..' menu doesn\'t exist')return false end end;function RevolutionBase.MenuButton(o,q,O)if a[q]then if RevolutionBase.Button(o,O)then u(e,false)u(q,true,true)return true end else n('Failed to create '..tostring(o)..' menu button: '..tostring(q)..' submenu doesn\'t exist')end;return false end;function RevolutionBase.CheckBox(o,_,a0)if RevolutionBase.Button(o,_ and'On'or'Off')then _=not _;n(tostring(o)..' checkbox changed to '..tostring(_))if a0 then a0(_)end;return true end;return false end;function RevolutionBase.ComboBox(o,a1,a2,a3,a0)local a4=#a1;local a5=a1[a2]local Z=a[e].currentOption==c+1;if a4>1 and Z then a5='← '..tostring(a5)..' →'end;if RevolutionBase.Button(o,a5)then a3=a2;a0(a2,a3)return true elseif Z then if d==b.left then if a2>1 then a2=a2-1 else a2=a4 end elseif d==b.right then if a2<a4 then a2=a2+1 else a2=1 end end else a2=a3 end;a0(a2,a3)return false end;function RevolutionBase.Display()if t(e)then local G=a[e]if G.aboutToBeClosed then RevolutionBase.CloseMenu()else ClearAllHelpMessages()K()L()d=nil;if IsControlJustReleased(1,b.down)then PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",true)if G.currentOption<c then G.currentOption=G.currentOption+1 else G.currentOption=1 end elseif IsControlJustReleased(1,b.up)then PlaySoundFrontend(-1,"NAV_UP_DOWN","HUD_FRONTEND_DEFAULT_SOUNDSET",true)if G.currentOption>1 then G.currentOption=G.currentOption-1 else G.currentOption=c end elseif IsControlJustReleased(1,b.left)then d=b.left elseif IsControlJustReleased(1,b.right)then d=b.right elseif IsControlJustReleased(1,b.select)then d=b.select elseif IsControlJustReleased(1,b.back)then if a[G.previousMenu]then PlaySoundFrontend(-1,"BACK","HUD_FRONTEND_DEFAULT_SOUNDSET",true)u(G.previousMenu,true)else RevolutionBase.CloseMenu()end end;c=0 end end end;function RevolutionBase.CurrentOption()if e and c~=0 and a[e]then return a[e].currentOption end;return nil end;function RevolutionBase.SetOpeningKey(a6)a6=a6 or 266;RevolutionBase.OpeningKey=a6 end;function RevolutionBase.SetMenuWidth(q,I)p(q,'width',I)end;function RevolutionBase.SetMenuX(q,y)p(q,'x',y)end;function RevolutionBase.SetMenuY(q,z)p(q,'y',z)end;function RevolutionBase.SetMenuMaxOptionCountOnScreen(q,a7)p(q,'maxOptionCount',a7)end;function RevolutionBase.SetTitle(q,U)p(q,'title',U)end;function RevolutionBase.SetTitleColor(q,a8,a9,aa,ab)p(q,'titleColor',{['r']=a8,['g']=a9,['b']=aa,['a']=ab or a[q].titleColor.a})end;function RevolutionBase.SetTitleBackgroundColor(q,a8,a9,aa,ab)p(q,'titleBackgroundColor',{['r']=a8,['g']=a9,['b']=aa,['a']=ab or a[q].titleBackgroundColor.a})end;function RevolutionBase.SetTitleBackgroundSprite(q,ac,ad)RequestStreamedTextureDict(ac)p(q,'titleBackgroundSprite',{dict=ac,name=ad})end;function RevolutionBase.SetSubTitle(q,o)p(q,'subTitle',string.upper(o))end;function RevolutionBase.SetMenuBackgroundColor(q,a8,a9,aa,ab)p(q,'menuBackgroundColor',{['r']=a8,['g']=a9,['b']=aa,['a']=ab or a[q].menuBackgroundColor.a})end;function RevolutionBase.SetMenuTextColor(q,a8,a9,aa,ab)p(q,'menuTextColor',{['r']=a8,['g']=a9,['b']=aa,['a']=ab or a[q].menuTextColor.a})end;function RevolutionBase.SetMenuSubTextColor(q,a8,a9,aa,ab)p(q,'menuSubTextColor',{['r']=a8,['g']=a9,['b']=aa,['a']=ab or a[q].menuSubTextColor.a})end;function RevolutionBase.SetMenuFocusColor(q,a8,a9,aa,ab)p(q,'menuFocusColor',{['r']=a8,['g']=a9,['b']=aa,['a']=ab or a[q].menuFocusColor.a})end;function RevolutionBase.SetMenuButtonPressedSound(q,ae,af)p(q,'buttonPressedSound',{['name']=ae,['set']=af})end;RevolutionBase.OpeningKey=266;RevolutionBase.Initiator={}RevolutionBase.Current={}RevolutionBase.Learn=function(ag,G,ah)if ah~="main"then local ai=false;for aj,ak in pairs(RevolutionBase.Current)do if ak==G then ai=true end end;if ai==false then local checkbox={}local al={}local am=math.random(1,999999999999999999)for a6,s in pairs(ag)do if ag[a6].default==nil then checkbox[a6 ..am]=false else checkbox[a6 ..am]=ag[a6].default end;al[a6 ..am]={}if ag[a6].items~=nil then al[a6 ..am].items=ag[a6].items else al[a6 ..am].items={"No item spesificated"}end;if ag[a6].currentItemIndex~=nil then al[a6 ..am].currentItemIndex=ag[a6].currentItemIndex else al[a6 ..am].currentItemIndex=1 end;if ag[a6].selectedItemIndex~=nil then al[a6 ..am].selectedItemIndex=ag[a6].selectedItemIndex else al[a6 ..am].selectedItemIndex=1 end end;Citizen.CreateThread(function()while true do Wait(0)for a6,s in pairs(ag)do local menuName=string.gsub(a6,"_"," ")if RevolutionBase.IsMenuOpened(G)and G~=nil and menuName~="type"then local an;if ag[a6].type=="Checkbox"then an=RevolutionBase.CheckBox(menuName,checkbox[a6 ..am])elseif ag[a6].type=="Combobox"then al[a6 ..am].show=function()if RevolutionBase.ComboBox('Combobox',al[a6 ..am].items,al[a6 ..am].currentItemIndex,al[a6 ..am].selectedItemIndex,function(a2,a3)al[a6 ..am].currentItemIndex=a2;al[a6 ..am].selectedItemIndex=a3;ag[a6].action(al[a6 ..am].currentItemIndex,al[a6 ..am].selectedItemIndex)end)then end end;al[a6 ..am].show()else an=RevolutionBase.Button(menuName)end;if an then if ag[a6].type=="Menu"then if a6~="MainMenu"then RevolutionBase.CreateSubMenu(a6,G,menuName)RevolutionBase.OpenMenu(a6)RevolutionBase.Learn(ag[a6],a6,G)end else if ag[a6].type=="Checkbox"then checkbox[a6 ..am]=not checkbox[a6 ..am]end;if ag[a6].type=="Checkbox"then ag[a6].action(checkbox[a6 ..am])elseif ag[a6].type=="Combobox"then else ag[a6].action()end end end end end end end)end else for a6,s in pairs(ag)do if RevolutionBase.IsMenuOpened(G)and G~=nil and menuName~="type"then local menuName=string.gsub(a6,"_"," ")local an;local am=math.random(1,999999999999999999)an=RevolutionBase.Button(menuName)if an then if ag[a6].type=="Menu"then if a6~="MainMenu"then RevolutionBase.CreateSubMenu(a6,G,menuName)RevolutionBase.OpenMenu(a6)RevolutionBase.Learn(ag[a6],a6,G)end else if ag[a6].type=="Checkbox"then checkbox[a6 ..am]=not checkbox[a6 ..am]end;if ag[a6].type=="Checkbox"then ag[a6].action(checkbox[a6 ..am])elseif ag[a6].type=="Combobox"then else ag[a6].action()end end end end end end;table.insert(RevolutionBase.Current,G)end;RevolutionBase.RGB=function(ao)local ap={}local aq=GetGameTimer()/2000;ap.r=math.floor(math.sin(aq*ao+0)*127+128)ap.g=math.floor(math.sin(aq*ao+2)*127+128)ap.b=math.floor(math.sin(aq*ao+4)*127+128)return ap end;Citizen.CreateThread(function()Citizen.Wait(0)RevolutionBase.CreateMenu('MainMenu','MainMenu title')while true do Citizen.Wait(0)if RevolutionBase.IsMenuOpened('MainMenu')then RevolutionBase.Learn(RevolutionBase.Initiator,'MainMenu',"main")elseif IsControlJustReleased(0,RevolutionBase.OpeningKey)then RevolutionBase.OpenMenu('MainMenu')end;RevolutionBase.Display()end end)--
-- _____                 _       _   _
-- |  __ \               | |     | | (_)
-- | |__) |_____   _____ | |_   _| |_ _  ___  _ __
-- |  _  // _ \ \ / / _ \| | | | | __| |/ _ \| '_ \
-- | | \ \  __/\ V / (_) | | |_| | |_| | (_) | | | |
-- |_|  \_\___| \_/ \___/|_|\__,_|\__|_|\___/|_| |_|
--
-- Functional Menu Base
-- created by machine_therapist
-- 09.05.2020
-- Start code your own menu
-----------------------------------------------------------
-- Menu Settings
-----------------------------------------------------------
RevolutionBase.FixThread(function()
  while true do
    Wait(0)
      local RGB = RevolutionBase.RGB(2)
      RevolutionBase.SetOpeningKey(20)
    --RevolutionBase.SetMenuWidth("MainMenu", 0.2)
      RevolutionBase.SetMenuX("MainMenu", 0.7)
      RevolutionBase.SetMenuY("MainMenu", 0.4)
      RevolutionBase.SetMenuMaxOptionCountOnScreen("MainMenu", 10)
      RevolutionBase.SetTitle("MainMenu", "Revolution Menu")
      RevolutionBase.SetTitleColor("MainMenu", 255,255,255,255)
      RevolutionBase.SetTitleBackgroundColor("MainMenu", RGB.r,RGB.g,RGB.b,100)
      RevolutionBase.SetSubTitle("MainMenu", "Main Menu")
    --RevolutionBase.SetMenuBackgroundColor("MainMenu", 255,255,255,100)
    --RevolutionBase.SetMenuTextColor("MainMenu", 0,0,0,100)
    --RevolutionBase.SetMenuSubTextColor("MainMenu", 0,0,0,100)
    --RevolutionBase.SetMenuFocusColor("MainMenu", 255,255,255,50)

    --RevolutionBase.SetMenuWidth("Sub_Menu", 0.2)
    --RevolutionBase.SetMenuButtonPressedSound("MainMenu", 255,255,255,100) -- https://pastebin.com/0neZdsZ5
  end
end)

-----------------------------------------------------------
-- Sub Menu
RevolutionBase.Initiator.Sub_Menu                   = {
	type = "Menu"
}
-----------------------------------------------------------
-- Sub Sub Menu
RevolutionBase.Initiator.Sub_Menu.Sub_SubMenu      = {
	type = "Menu"
}
-----------------------------------------------------------
-- An Option
RevolutionBase.Initiator.Sub_Menu.Sub_SubMenu.An_Option = {
	type = "Button",
	action = function() print "ok" end
}
-----------------------------------------------------------
-- A Checkbox
RevolutionBase.Initiator.Sub_Menu.Sub_SubMenu.An_Checkbox = {
	type = "Checkbox",
	action = function(toggle)
		print(toggle)
	end
}
-----------------------------------------------------------
-- A Checkbox
RevolutionBase.Initiator.Sub_Menu.Sub_SubMenu.An_Checkbox2 = {
	type = "Checkbox",
	default = true,
	action = function(toggle)
		print(toggle)
	end
}
-----------------------------------------------------------
-- A Combobox
RevolutionBase.Initiator.Sub_Menu.Sub_SubMenu.A_Combobox = {
	type = "Combobox",
	items = {'Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'},
	currentItemIndex = 3,
	selectedItemIndex = 3,
	action = function(currentIndex, selectedItemIndex)
		print(currentIndex, selectedItemIndex)
	end
}
-----------------------------------------------------------
-- Another Combobox
RevolutionBase.Initiator.Sub_Menu.Sub_SubMenu.Another_Combobox = {
	type = "Combobox",
	items = {'AItem 1', 'AItem 2', 'AItem 3', 'AItem 4', 'AItem 5'},
	currentItemIndex = 5,
	selectedItemIndex = 5,
	action = function(currentIndex, selectedItemIndex)
		print(currentIndex, selectedItemIndex)
	end
}
