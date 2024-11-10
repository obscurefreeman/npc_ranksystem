-- NPC 名字池
local npcNames = {
    "战士", "猎手", "守卫", "斗士",
    "勇士", "卫兵", "先锋", "猛士", 
    "武者", "护卫", "斥候", "勇者"
}

-- 军衔系统和对应颜色
local ranks = {
    [1] = {name = "列兵", color = Color(255, 255, 255)},  -- 白色
    [2] = {name = "下士", color = Color(255, 127, 80)},   -- 珊瑚色
    [3] = {name = "中士", color = Color(255, 165, 0)},    -- 橙色
    [4] = {name = "上士", color = Color(255, 215, 0)},    -- 金色
    [5] = {name = "少尉", color = Color(144, 238, 144)},  -- 浅绿色
    [6] = {name = "中尉", color = Color(0, 255, 127)},    -- 春绿色
    [7] = {name = "上尉", color = Color(34, 139, 34)},    -- 森林绿
    [8] = {name = "少校", color = Color(135, 206, 250)},  -- 天蓝色
    [9] = {name = "中校", color = Color(30, 144, 255)},   -- 道奇蓝
    [10] = {name = "上校", color = Color(0, 0, 205)},     -- 中蓝色
    [11] = {name = "大校", color = Color(138, 43, 226)},  -- 紫罗兰色
    [12] = {name = "少将", color = Color(255, 215, 0)},   -- 金色
    [13] = {name = "中将", color = Color(255, 69, 0)},    -- 红橙色
    [14] = {name = "上将", color = Color(220, 20, 60)},   -- 猩红色
    [15] = {name = "大将", color = Color(139, 0, 0)}      -- 深红色
}

-- 获取军衔的函数
local function GetRank(level)
    return ranks[math.min(level, 15)].name
end

-- 获取军衔颜色的函数
local function GetRankColor(level)
    return ranks[math.min(level, 15)].color
end

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
local function BroadcastMessage(message, color)
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
    npcData.level = math.min(math.floor(npcData.kills / 2) + 1, 15)
    
    local rank = GetRank(npcData.level)
    local message = string.format("%s %s击败了一个敌人！", rank, npcData.name)
    BroadcastMessage(message)
    
    if SERVER then
        SyncNPCData(attacker, npcData)
    end
    
    if npcData.kills % 2 == 0 and npcData.level < 15 then
        local newRank = GetRank(npcData.level)
        BroadcastMessage(string.format("%s晋升为%s！", npcData.name, newRank))
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
    
    local rank = GetRank(npcData.level)
    local rankColor = GetRankColor(npcData.level)
    local sw, sh = ScrW(), ScrH()
    draw.SimpleText(
        string.format("%s %s", rank, npcData.name),
        "DermaLarge",
        sw / 2,
        sh / 1.87,
        rankColor,
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
    )
end)