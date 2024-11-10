-- NPC 名字池
local npcNames = {
    "战士", "猎手", "守卫", "斗士",
    "勇士", "卫兵", "先锋", "猛士",
    "武者", "护卫", "斥候", "勇者"
}

-- NPC 数据存储
local npcs = {}

-- 当 NPC 生成时
hook.Add("OnEntityCreated", "NPCLevelSystem", function(ent)
    if not IsValid(ent) or not ent:IsNPC() then return end
    
    -- 等待一帧确保 NPC 完全初始化
    timer.Simple(0, function()
        if not IsValid(ent) then return end
        
        -- 随机分配名字和初始化等级
        npcs[ent:EntIndex()] = {
            name = npcNames[math.random(#npcNames)],
            level = 1,
            kills = 0
        }
    end)
end)

-- 当 NPC 击杀其他 NPC 时
hook.Add("OnNPCKilled", "NPCLevelUp", function(npc, attacker, inflictor)
    if not IsValid(attacker) or not attacker:IsNPC() then return end
    
    local attackerIndex = attacker:EntIndex()
    if npcs[attackerIndex] then
        npcs[attackerIndex].kills = npcs[attackerIndex].kills + 1
        npcs[attackerIndex].level = math.floor(npcs[attackerIndex].kills / 2) + 1
        
        -- 添加击杀消息
        local attackerName = npcs[attackerIndex].name
        local attackerLevel = npcs[attackerIndex].level
        local message = string.format("Lv.%d的%s击败了一个敌人！", attackerLevel, attackerName)
        
        -- 发送消息到所有玩家的聊天栏
        for _, ply in ipairs(player.GetAll()) do
            ply:ChatPrint(message)
        end
        
        -- 如果刚好升级，发送升级消息
        if npcs[attackerIndex].kills % 2 == 0 then
            local levelUpMsg = string.format("%s升到了%d级！", attackerName, attackerLevel)
            for _, ply in ipairs(player.GetAll()) do
                ply:ChatPrint(levelUpMsg)
            end
        end
    end
end)

-- 当 NPC 被移除时清理数据
hook.Add("EntityRemoved", "CleanupNPCData", function(ent)
    if ent:IsNPC() then
        npcs[ent:EntIndex()] = nil
    end
end)

-- 显示 NPC 信息
hook.Add("HUDPaint", "DisplayNPCInfo", function()
    local sw, sh = ScrW(), ScrH()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    local tr = ply:GetEyeTrace()
    if not IsValid(tr.Entity) or not tr.Entity:IsNPC() then return end
    
    local npcData = npcs[tr.Entity:EntIndex()]
    if not npcData then return end
    
    -- 计算屏幕位置
    local pos = tr.Entity:GetPos() + Vector(0, 0, 80)
    local screenPos = pos:ToScreen()

    draw.SimpleText(
        npcData.name,
        "DermaLarge",
        sw / 2,
        sh / 1.87,
        Color(255, 255, 255),
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
    )
end)