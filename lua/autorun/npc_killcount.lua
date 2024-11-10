-- NPC 名字池
local npcNames = {
    "战士", "猎手", "守卫", "斗士",
    "勇士", "卫兵", "先锋", "猛士", 
    "武者", "护卫", "斥候", "勇者"
}

-- NPC 数据存储
local npcs = {}

-- 网络通信相关
if SERVER then
    util.AddNetworkString("SyncNPCData")
end

-- 同步 NPC 数据到客户端的函数
local function SyncNPCData(ent, npcData)
    if not SERVER then return end
    net.Start("SyncNPCData")
    net.WriteEntity(ent)
    net.WriteString(npcData.name)
    net.WriteUInt(npcData.level, 8)
    net.WriteUInt(npcData.kills, 8)
    net.Broadcast()
end

-- 发送聊天消息的函数
local function BroadcastMessage(message)
    for _, ply in ipairs(player.GetAll()) do
        ply:ChatPrint(message)
    end
end

-- 当 NPC 生成时
hook.Add("OnEntityCreated", "NPCLevelSystem", function(ent)
    if not IsValid(ent) or not ent:IsNPC() then return end
    
    timer.Simple(0, function()
        if not IsValid(ent) then return end
        
        local npcData = {
            name = npcNames[math.random(#npcNames)],
            level = 1,
            kills = 0
        }
        
        npcs[ent:EntIndex()] = npcData
        
        if SERVER then
            SyncNPCData(ent, npcData)
        end
    end)
end)

-- 在客户端接收数据
if CLIENT then
    net.Receive("SyncNPCData", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        
        npcs[ent:EntIndex()] = {
            name = net.ReadString(),
            level = net.ReadUInt(8),
            kills = net.ReadUInt(8)
        }
    end)
end

-- 当 NPC 击杀其他 NPC 时
hook.Add("OnNPCKilled", "NPCLevelUp", function(npc, attacker, inflictor)
    if not IsValid(attacker) or not attacker:IsNPC() then return end
    
    local attackerIndex = attacker:EntIndex()
    local npcData = npcs[attackerIndex]
    if not npcData then return end
    
    npcData.kills = npcData.kills + 1
    npcData.level = math.floor(npcData.kills / 2) + 1
    
    local message = string.format("Lv.%d的%s击败了一个敌人！", npcData.level, npcData.name)
    BroadcastMessage(message)
    
    if SERVER then
        SyncNPCData(attacker, npcData)
    end
    
    if npcData.kills % 2 == 0 then
        BroadcastMessage(string.format("%s升到了%d级！", npcData.name, npcData.level))
    end
end)

-- 当 NPC 被移除时清理数据
hook.Add("EntityRemoved", "CleanupNPCData", function(ent)
    if IsValid(ent) and ent:IsNPC() then
        npcs[ent:EntIndex()] = nil
    end
end)

-- 显示 NPC 信息
hook.Add("HUDPaint", "DisplayNPCInfo", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end
    
    local tr = ply:GetEyeTrace()
    if not IsValid(tr.Entity) or not tr.Entity:IsNPC() then return end
    
    local npcData = npcs[tr.Entity:EntIndex()]
    if not npcData then return end
    
    local sw, sh = ScrW(), ScrH()
    draw.SimpleText(
        string.format("Lv.%d %s", npcData.level, npcData.name),
        "DermaLarge",
        sw / 2,
        sh / 1.87,
        Color(255, 255, 255),
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
    )
end)