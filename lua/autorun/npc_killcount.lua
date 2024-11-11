-- NPC 名字池
local npcNames = {
    "约翰逊", "威廉姆斯", "史密斯",
    "安德森", "布朗", "米勒",
    "威尔逊", "泰勒", "托马斯",
    "杰克逊", "怀特", "哈里斯",
    "马丁", "汤普森", "加西亚",
    "马丁内斯", "罗宾逊", "克拉克",
    "罗德里格斯", "路易斯", "李",
    "沃克", "霍尔", "艾伦",
    "杨", "埃尔南德斯", "金",
    "赖特", "洛佩兹", "希尔"
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
    [11] = {name = "准将", color = Color(138, 43, 226)},  -- 紫罗兰色
    [12] = {name = "少将", color = Color(255, 215, 0)},   -- 金色
    [13] = {name = "中将", color = Color(255, 69, 0)},    -- 红橙色
    [14] = {name = "上将", color = Color(220, 20, 60)},   -- 猩红色
    [15] = {name = "元帅", color = Color(139, 0, 0)}      -- 深红色
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

-- 服务器端代码
if SERVER then
    util.AddNetworkString("SyncNPCData")
    util.AddNetworkString("BroadcastMessage")

    -- 同步 NPC 数据到客户端的函数
    local function SyncNPCData(ent, npcData)
        net.Start("SyncNPCData")
        net.WriteEntity(ent)
        net.WriteString(npcData.name)
        net.WriteUInt(npcData.level, 8)
        net.WriteUInt(npcData.kills, 8)
        net.WriteString(npcData.class or "")
        net.Broadcast()
    end

    -- 发送聊天消息的函数
    local function BroadcastMessage(message, color)
        net.Start("BroadcastMessage")
        net.WriteString(message)
        net.WriteTable(color or Color(255, 255, 255))
        net.Broadcast()
    end

    -- 当 NPC 生成时
    hook.Add("OnEntityCreated", "NPCLevelSystem", function(ent)
        if not IsValid(ent) or not ent:IsNPC() then return end
        if ent:GetClass() == "npc_bullseye" then return end
        
        timer.Simple(0, function()
            if not IsValid(ent) then return end
            
            local npcData = {
                name = npcNames[math.random(#npcNames)],
                level = 1,
                kills = 0,
                class = ent:GetClass()
            }
            
            npcs[ent:EntIndex()] = npcData
            SyncNPCData(ent, npcData)
        end)
    end)

    -- 当 NPC 击杀其他 NPC 时
    hook.Add("OnNPCKilled", "NPCLevelUp", function(npc, attacker, inflictor)
        if not IsValid(npc) or not IsValid(attacker) then return end
        if not npc:IsNPC() or not attacker:IsNPC() then return end
        if attacker:GetClass() == "npc_bullseye" or npc:GetClass() == "npc_bullseye" then return end
        
        local attackerIndex = attacker:EntIndex()
        local npcData = npcs[attackerIndex]
        if not npcData then return end
        
        local victimData = npcs[npc:EntIndex()]
        local victimName = victimData and victimData.name or "未知敌人"
        local victimRank = victimData and GetRank(victimData.level) or "未知军衔"
        local victimClass = victimData and victimData.class
        local attackerClass = npcData.class
        
        npcData.kills = npcData.kills + 1
        npcData.level = math.min(math.floor(npcData.kills / 2) + 1, 15)
        
        local rank = GetRank(npcData.level)
        local rankColor = GetRankColor(npcData.level)
        local message = string.format("%s %s[%s]击败了%s %s[%s]！", 
            rank, npcData.name, attackerClass, victimRank, victimName, victimClass)
        BroadcastMessage(message, rankColor)
        
        SyncNPCData(attacker, npcData)
            
        if npcData.kills % 2 == 0 and npcData.level < 15 then
            local newRank = GetRank(npcData.level)
            BroadcastMessage(string.format("%s[%s]晋升为%s！", 
                npcData.name, attackerClass, newRank), rankColor)
        end
        
        timer.Simple(0.1, function()
            npcs[npc:EntIndex()] = nil
        end)
    end)

    -- 当 NPC 被移除时清理数据
    hook.Add("EntityRemoved", "CleanupNPCData", function(ent)
        if IsValid(ent) and ent:IsNPC() then
            if ent:Health() > 0 then
                npcs[ent:EntIndex()] = nil
            end
        end
    end)
end

-- 客户端代码
if CLIENT then

    local xx,yy=ScrW()/1920,ScrH()/1080     --玩家屏幕分辨率与我的屏幕分辨率的比

    surface.CreateFont("ofkctextlarge", {
        font = "HONOR Sans CN Heavy",
        extended = true ,
        size = 35*yy
    })
    
    surface.CreateFont("ofkctext", {
        font = "HONOR Sans CN",
        extended = true ,
        size = 20*yy
    })

    -- 接收 NPC 数据
    net.Receive("SyncNPCData", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        
        npcs[ent:EntIndex()] = {
            name = net.ReadString(),
            level = net.ReadUInt(8),
            kills = net.ReadUInt(8),
            class = net.ReadString()
        }
    end)

    -- 接收聊天消息
    net.Receive("BroadcastMessage", function()
        local message = net.ReadString()
        local color = net.ReadTable()
        chat.AddText(color, message)
    end)

    -- 显示 NPC 信息
    hook.Add("HUDPaint", "DisplayNPCInfo", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        
        local tr = ply:GetEyeTrace()
        if not IsValid(tr.Entity) or not tr.Entity:IsNPC() then return end
        if tr.Entity:GetClass() == "npc_bullseye" then return end
        
        local npcData = npcs[tr.Entity:EntIndex()]
        if not npcData then return end
        
        local rank = GetRank(npcData.level)
        local rankColor = GetRankColor(npcData.level)
        local sw, sh = ScrW(), ScrH()
        
        local text = string.format("%s %s[%s]", rank, npcData.name, npcData.class)
        local x, y = sw / 2, sh / 1.87
        
        local r, g, b = rankColor.r, rankColor.g, rankColor.b
        local brightness = (r * 299 + g * 587 + b * 114) / 1000
        
        if brightness < 128 then
            for dx = -2, 2 do
                for dy = -2, 2 do
                    draw.SimpleText(text, "ofkctextlarge", x + dx, y + dy, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        else
            for dx = -2, 2 do
                for dy = -2, 2 do
                    draw.SimpleText(text, "ofkctextlarge", x + dx, y + dy, Color(0, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end
        
        draw.SimpleText(text, "ofkctextlarge", x, y, rankColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        
        local infoText = string.format("等级: %d | 击杀: %d", npcData.level, npcData.kills)
        draw.SimpleText(infoText, "ofkctext", x, y + 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end)
end