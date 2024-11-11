AddCSLuaFile( )

local function ofkc( pnl )

	pnl:ControlHelp( "NPC 等级系统设置" )

	local Default = {

		["ofkc_player"] = 1,
        ["ofkc_npc"] = 1,
        ["ofkc_realname"] = 0,
        ["ofkc_detail"] = 0
	}

	pnl:AddControl( "ComboBox" , { ["MenuButton"] = 1 , ["Folder"] = "ofkc" , ["Options"] = { [ "#preset.default" ] = Default } , ["CVars"] = table.GetKeys( Default ) } )
	
	pnl:CheckBox( "开启模组" , "ofkc_enabled" )
    pnl:Help("是否启用NPC等级系统。")

	pnl:CheckBox( "NPC随机等级" , "ofkc_npc_random_level" )
    pnl:Help("设置NPC是否随机等级，若不勾选，所有 NPC 初始均为列兵。")
    
    pnl:CheckBox( "NPC 信息显示在头顶" , "ofkc_npc_text_mode" )
    pnl:Help("设置NPC文字显示模式，开启后NPC头顶会显示信息，关闭后只有准心对准NPC时才会显示信息。")
    
    pnl:CheckBox( "晋级特效" , "ofkc_npc_levelup_effect" )
    pnl:Help("是否启用晋级特效。")
    
    pnl:CheckBox( "晋级播报" , "ofkc_npc_levelup_message" )
    pnl:Help("是否启用晋级播报。")
    
    pnl:CheckBox( "击杀播报" , "ofkc_npc_kill_message" )
    pnl:Help("是否启用击杀播报。")
    
    pnl:CheckBox( "友伤无惩罚" , "ofkc_npc_friendly_fire" )
    pnl:Help("击杀同类型 NPC 击杀是否获得经验。")

	pnl:CheckBox( "晋级增益" , "ofkc_npc_levelup_heal" )
    pnl:Help("晋级时是否刷新血量。")

    pnl:CheckBox( "NPC 文字嘲讽" , "ofkc_npc_taunt" )
    pnl:Help("是否启用NPC嘲讽。")

    pnl:CheckBox( "NPC 文字闲聊" , "ofkc_npc_idle_chat" )
    pnl:Help("是否启用NPC闲聊。")

    pnl:CheckBox( "NPC 晋级文字" , "ofkc_npc_levelup_chat" )
    pnl:Help("NPC晋级时是否讲话。")

end

hook.Add( "PopulateToolMenu", "OFKCMenus", function( )
	if ( GetConVarNumber( "of_populatetoolmenu" ) == nil or GetConVarNumber( "of_populatetoolmenu" ) == 0 ) then
		spawnmenu.AddToolMenuOption( "Options" , "Obscurefreeman's mod" , "ofkc" , "NPC Rank System" , "" , "" , ofkc )
	else
		spawnmenu.AddToolMenuOption( "OFmod" , "Tools" , "ofkc" , " NPC Rank System" , "" , "" , ofkc )
		
	end
end )