-- NPC 名字池
local npcNames = {
    "约翰逊","杨", "金",
    "米勒","沃克", "霍尔",
    "威尔逊", "泰勒","加西亚",
    "马丁内斯", "罗宾逊", "弗兰克",
    "罗德里格斯", "路易吉", "李",
    "赖特", "洛佩兹", "希尔",
    "尤里","伊万诺夫","戈尔巴乔夫","朱可夫",
    "薄荷","迷迭香","鱼腥草",
    "百里香","鼠尾草","薰衣草",
    "芫荽","骇人鲨鱼","河豚",
    "探戈","猎狐者","狐狸",
    "无名氏","赭石","睡衣派对",
    "圣诞老人","邪恶降临","一只巴尼",
    "盖瑞猫咪","半条命3","柔软的床","进入梦乡","睡眠",
    "白色哀悼","遥远的桥","钓鱼人"
}

-- 对话池
local taunts = {
    "/victim/,你的战斗技巧还需要提高！",
    "看来/victim/今天状态不太好啊~",
    "抱歉了/victim/,这就是实力的差距！", 
    "下次记得带上脑子再来,/victim/！",
    "这就是你的全部实力吗,/victim/？",
    "再见了/victim/,安息吧！",
    "在这个美好的日子里送你上路,/victim/！",
    "让你见识一下什么叫真正的实力,/victim/！",
    "你太弱了/victim/,连热身都算不上！",
    "哈哈，/victim/,下辈子你可要当心啊！",
    "/victim/，你是怎么晋升到/victimrank/的？",
    "你的等级很高,可惜你遇上了我！",
    "你已经死了,我的朋友！",
    "按“F”键向/victim//victimrank/致敬！",
    "/victim//victimrank/？可惜你现在是/victim/“布娃娃”！",
    "你现在就像个布娃娃一样弱！",
    "我可是/rank/，你算老几？",
    "我可不会手下留情，/victim//victimrank/！",
    "你这种菜鸟也配和/name//rank/过招？",
    "作为/rank/，我有责任教训你这种新手！",
    "你熟悉/map/吗？/victim/，这就是高手对地图的理解！",
    "看来/victim/需要回新手训练营了！",
    "这一击是专门为/victim/准备的！",
    "连/victimrank/都保护不了你，/victim/！",
    "你这种水平也敢挑战/rank/？",
    "回去练练再来吧，/victim/！",
    "这就是/rank/的实力，/victim/！",
    "今天就让你见识一下什么叫天外有天！",
    "/victim/，你的技术还停留在上个世纪啊！",
    "一枪秒了，/victim/，有什么好说的？",
    "最讨厌玩沙盒时找人对战的人了。说的就是你，/victim/！",
    "该醒了，/victim//victimrank/，该醒了！",
    "你是在床上拿手柄跟我打的吗，/victim/？",
    "怎么回事，/victim/？我家的猫都能晋升至/victimrank/。",
    "哎呀，/victim/，你怎么死啦？",
    "哦，这不是/victim/本尊吗？",
    "大家看到我刚才的击杀了吗？真是牛逼！",
    "看起来你仅仅是嘴上功夫比较厉害，/victim/。",
    "兄弟，你太菜了，还是回新手村吧！",
    "哭吧，/victim//victimrank/。",
    "是啊，下次记得别死，/victim/", 
    "/rank/爆杀/victimrank/，这把炸鱼局。",
}

local idles = {
    "/map/真是个不错的战场！",
    "今天天气不错,适合在/map/散散心。",
    "听说/map/这地方闹鬼,有点意思。",
    "我觉得/map/这地方需要整修一下了。",
    "在/map/战斗的感觉真不错！",
    "不知道/map/的另一边是什么样子？",
    "希望/map/能一直这么混乱。",
    "你知道如何快速升等级吗？/rank/等级太低了！",
    "这里的空气中弥漫着火药味。",
    "我要让/map/响彻/name//rank/的威名！",
    "/map/的每个角落都值得探索。",
    "不知道/map/今天会发生什么有趣的事。",
    "/map/这张地图没有CSS也可以玩吗？",
    "天哪，帧数太低了，/map/都卡成PPT了！",
    "我们为什么要玩/map/？可以投票换图吗？",
    "听说有人上传了/map/的重置版本，但被删了。",
    "啊，Lost media ~ 你知道/map/这张地图曾经失传过一段时间吗？",
    "我听说/map/这张地图的作者已经80岁了。",
    "你知道我为什么起/name/这个名字吗？",
    "最近的创意工坊有什么新东西吗？",
    "你觉得那些劣质的FNAF存档毁了创意工坊吗？",
    "伙计们，你们应该看看这个https://www.bilibili.com/video/BV1GJ411x7h7/",
    "你喜欢我的模型吗？我下载了一个新皮肤！",
    "能给我做的模组点个赞吗？已经上传创意工坊了。",
    "我最近在玩一个新游戏，叫《半条命：老鼠》，你们玩过吗？",
    "我没有买CSS，所以地图里全都是紫黑格，真是服了！",
    "我想玩那个很火的 VR 模组，可惜我没有 VR 。",
    "折寿啦！刚刚ARC又发布新的武器包了！",
    "天哪，这张地图的导航网格太烂了，NPC简直寸步难行！",
    "是的，但那只是一个游戏理论",
    "你们在地图中看到过一个称着伞的男人吗？",
    "我想玩核弹模组了。我想玩核弹 ~ 想玩核弹 ~",
    "你知道“UC”武器包吗？我喜欢这些武器的手感，打起来很舒服。",
    "Steam 促销开始了，你们买了什么？",
    "我是这个服务器的主人！向我鞠躬！"
}

local levelups = {
    "感觉自己无所不能！",
    "颤抖吧！/rank/还不是我的最终形态！",
    "继续前进，/name//rank/！",
    "芜湖！/name//rank/来了！",
    "这份力量,让我感到兴奋！",
    "没想到我还能变得更强！",
    "这就是晋升的感觉吗？",
    "我现在就像开了挂一样强！",
    "我/name/也当上/rank/了！",
    "今天晋升为/rank/，明天就要当元帅！",
    "看来我离元帅又近了一步！",
    "现在的我已经今非昔比了！",
    "Gmod 现在太肝了，玩这么久才晋升到/rank/！",
    "终于晋升/rank/了，太棒了！",
    "这就是/rank/的实力吗？太棒了！",
    "早上起来打到现在，终于晋升/rank/了！",
    "再晋一级就躺床上睡觉了！",
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

-- 获取升级所需经验的函数
local function GetRequiredExp(level)
    if level >= 15 then
        return 0
    end
    
    local expTable = {
        [1] = 120,
        [2] = 140,
        [3] = 160,
        [4] = 180,
        [5] = 200,
        [6] = 240,
        [7] = 280,
        [8] = 320,
        [9] = 360,
        [10] = 400,
        [11] = 460,
        [12] = 520,
        [13] = 580,
        [14] = 640
    }
    
    return expTable[level] or 0
end

-- NPC 数据存储
local npcs = {}

-- 服务器端代码
if SERVER then
    util.AddNetworkString("SyncNPCData")
    util.AddNetworkString("BroadcastMessage")
    util.AddNetworkString("NPCLevelUpEffect")
    util.AddNetworkString("NPCTalk_Taunt")
    util.AddNetworkString("NPCTalk_Idle") 
    util.AddNetworkString("NPCTalk_LevelUp")

    -- 创建ConVar
    local ofkc_enabled = CreateConVar("ofkc_enabled", "1", FCVAR_ARCHIVE + FCVAR_REPLICATED, "是否启用NPC等级系统 (0=关闭, 1=开启)")
    local ofkc_npc_random_level = CreateConVar("ofkc_npc_random_level", "1", FCVAR_ARCHIVE + FCVAR_REPLICATED, "设置NPC是否随机等级 (0=从1级开始, 1=随机等级)")
    local ofkc_npc_text_mode = CreateConVar("ofkc_npc_text_mode", "1", FCVAR_ARCHIVE + FCVAR_REPLICATED, "设置NPC文字显示模式 (0=屏幕中心, 1=NPC头顶)")
    local ofkc_npc_levelup_effect = CreateConVar("ofkc_npc_levelup_effect", "1", FCVAR_ARCHIVE + FCVAR_REPLICATED, "是否启用晋级特效 (0=关闭, 1=开启)")
    local ofkc_npc_levelup_message = CreateConVar("ofkc_npc_levelup_message", "1", FCVAR_ARCHIVE + FCVAR_REPLICATED, "是否启用晋级播报 (0=关闭, 1=开启)")
    local ofkc_npc_kill_message = CreateConVar("ofkc_npc_kill_message", "1", FCVAR_ARCHIVE + FCVAR_REPLICATED, "是否启用击杀播报 (0=关闭, 1=开启)")
    local ofkc_npc_friendly_fire = CreateConVar("ofkc_npc_friendly_fire", "0", FCVAR_ARCHIVE + FCVAR_REPLICATED, "设置同类型NPC击杀是否获得经验 (0=惩罚经验, 1=获得经验)")
    local ofkc_npc_levelup_heal = CreateConVar("ofkc_npc_levelup_heal", "1", FCVAR_ARCHIVE + FCVAR_REPLICATED, "晋级时是否刷新血量 (0=关闭, 1=开启)")

    -- 处理消息替换的函数
    local function processMessage(message, replacements)
        for key, value in pairs(replacements) do
            message = message:gsub(key, value)
        end
        return message
    end

    -- 同步 NPC 数据到客户端的函数
    local function SyncNPCData(ent, npcData)
        net.Start("SyncNPCData")
        net.WriteEntity(ent)
        net.WriteString(npcData.name)
        net.WriteUInt(npcData.level, 8)
        net.WriteUInt(npcData.kills, 8)
        net.WriteUInt(npcData.exp, 16)
        net.WriteString(npcData.class or "")
        net.Broadcast()
    end

    -- 发送聊天消息的函数
    local function BroadcastMessage(messageType, data)
        if messageType == 1 and not ofkc_npc_levelup_message:GetBool() then return end
        if (messageType == 2 or messageType == 3) and not ofkc_npc_kill_message:GetBool() then return end
        
        net.Start("BroadcastMessage")
        net.WriteUInt(messageType, 4) -- 消息类型
        net.WriteTable(data)
        net.Broadcast()
    end

    -- NPC说话函数
    local function NPCTalk(talkType, attacker, victim)
        if talkType == "taunt" and IsValid(attacker) and IsValid(victim) then
            local attackerData = npcs[attacker:EntIndex()]
            local victimData = npcs[victim:EntIndex()]
            if attackerData and victimData then
                timer.Simple(math.random(2, 5), function()
                    if IsValid(attacker) then
                        local message = taunts[math.random(#taunts)]
                        local replacements = {
                            ["/victim/"] = victimData.name,
                            ["/victimrank/"] = GetRank(victimData.level),
                            ["/rank/"] = GetRank(attackerData.level),
                            ["/name/"] = attackerData.name,
                            ["/map/"] = game.GetMap()
                        }
                        local formattedMessage = processMessage(message, replacements)
                        local attackerRank = GetRank(attackerData.level)
                        local attackerColor = GetRankColor(attackerData.level)
                        
                        net.Start("NPCTalk_Taunt")
                        net.WriteString(formattedMessage)
                        net.WriteString(attackerRank)
                        net.WriteString(attackerData.name)
                        net.WriteColor(attackerColor)
                        net.Broadcast()
                    end
                end)
            end
        elseif talkType == "idle" and IsValid(attacker) then
            local npcData = npcs[attacker:EntIndex()]
            if npcData then
                local message = idles[math.random(#idles)]
                local replacements = {
                    ["/rank/"] = GetRank(npcData.level),
                    ["/name/"] = npcData.name,
                    ["/map/"] = game.GetMap()
                }
                local formattedMessage = processMessage(message, replacements)
                local npcRank = GetRank(npcData.level)
                local npcColor = GetRankColor(npcData.level)
                
                net.Start("NPCTalk_Idle")
                net.WriteString(formattedMessage)
                net.WriteString(npcRank)
                net.WriteString(npcData.name)
                net.WriteColor(npcColor)
                net.Broadcast()
            end
        elseif talkType == "levelup" and IsValid(attacker) then
            local npcData = npcs[attacker:EntIndex()]
            if npcData then
                local message = levelups[math.random(#levelups)]
                local replacements = {
                    ["/rank/"] = GetRank(npcData.level),
                    ["/name/"] = npcData.name,
                    ["/map/"] = game.GetMap()
                }
                local formattedMessage = processMessage(message, replacements)
                local npcRank = GetRank(npcData.level)
                local npcColor = GetRankColor(npcData.level)
                
                net.Start("NPCTalk_LevelUp")
                net.WriteString(formattedMessage)
                net.WriteString(npcRank)
                net.WriteString(npcData.name)
                net.WriteColor(npcColor)
                net.Broadcast()
            end
        end
    end

    -- 随机闲聊定时器
    timer.Create("NPCIdleChat", 10, 0, function()
        if not ofkc_enabled:GetBool() then return end
        
        local allNPCs = ents.FindByClass("npc_*")
        if #allNPCs > 0 then
            local randomNPC = allNPCs[math.random(#allNPCs)]
            if IsValid(randomNPC) and randomNPC:GetClass() ~= "npc_bullseye" then
                NPCTalk("idle", randomNPC)
            end
        end
    end)

    -- 当 NPC 生成时
    hook.Add("OnEntityCreated", "NPCLevelSystem", function(ent)
        if not ofkc_enabled:GetBool() then return end
        if not IsValid(ent) or not ent:IsNPC() then return end
        if ent:GetClass() == "npc_bullseye" then return end
        
        timer.Simple(0, function()
            if not IsValid(ent) then return end
            
            local initialLevel = 1
            if ofkc_npc_random_level:GetBool() then
                initialLevel = math.random(1, 15)
            end
            
            local npcData = {
                name = npcNames[math.random(#npcNames)],
                level = initialLevel,
                kills = 0,
                exp = 0,
                class = ent:GetClass()
            }
            
            npcs[ent:EntIndex()] = npcData
            SyncNPCData(ent, npcData)
        end)
    end)

    -- 当 NPC 击杀其他 NPC 时
    hook.Add("OnNPCKilled", "NPCLevelUp", function(npc, attacker, inflictor)
        if not ofkc_enabled:GetBool() then return end
        if not IsValid(npc) or not IsValid(attacker) then return end
        if not npc:IsNPC() or not attacker:IsNPC() then return end
        if attacker:GetClass() == "npc_bullseye" or npc:GetClass() == "npc_bullseye" then return end
        
        local attackerIndex = attacker:EntIndex()
        local npcData = npcs[attackerIndex]
        if not npcData then return end
        
        local victimData = npcs[npc:EntIndex()]
        local victimName = victimData and victimData.name or "未知敌人"
        local victimRank = victimData and GetRank(victimData.level) or "未知军衔"
        local victimLevel = victimData and victimData.level or 1
        local victimColor = victimData and GetRankColor(victimData.level) or Color(255, 255, 255)
        
        -- 发送嘲讽消息
        NPCTalk("taunt", attacker, npc)
        
        -- 计算获得的经验值
        local expGain = 0
        local isFriendlyFire = false
        
        -- 如果已经满级则不再获得经验
        if npcData.level >= 15 then
            expGain = 0
        else
            if attacker:GetClass() == npc:GetClass() then
                if ofkc_npc_friendly_fire:GetBool() then
                    -- 同类型NPC击杀获得经验
                    local baseExp = math.max(40, victimLevel * 50 * (2/3))
                    expGain = baseExp + math.random(-10, 10)
                    npcData.exp = npcData.exp + expGain
                else
                    -- 同类型NPC击杀扣除经验
                    expGain = -20 + math.random(-5, 5)
                    isFriendlyFire = true
                    npcData.exp = npcData.exp + expGain
                    
                    -- 如果经验为负，且等级大于1，则降级
                    if npcData.exp < 0 and npcData.level > 1 then
                        npcData.level = npcData.level - 1
                        npcData.exp = GetRequiredExp(npcData.level) - math.abs(npcData.exp)
                        
                        local newRank = GetRank(npcData.level)
                        local rankColor = GetRankColor(npcData.level)
                        
                        -- 发送降级消息
                        BroadcastMessage(1, {
                            name = npcData.name,
                            rank = newRank,
                            color = rankColor,
                            isDowngrade = true
                        })
                    else
                        npcData.exp = math.max(0, npcData.exp) -- 确保经验不会为负
                    end
                end
            else
                -- 不同类型NPC击杀获得经验
                local baseExp = math.max(80, victimLevel * 100 * (2/3))
                expGain = baseExp + math.random(-20, 20)
                npcData.exp = npcData.exp + expGain
            end
        end
        
        npcData.kills = npcData.kills + 1
        
        -- 检查是否升级
        local requiredExp = GetRequiredExp(npcData.level)
        while npcData.exp >= requiredExp and npcData.level < 15 do
            npcData.exp = npcData.exp - requiredExp
            npcData.level = npcData.level + 1
            
            -- 刷新NPC血量
            if ofkc_npc_levelup_heal:GetBool() then
                local maxHealth = attacker:GetMaxHealth()
                attacker:SetHealth(maxHealth)
            end
            
            local newRank = GetRank(npcData.level)
            local rankColor = GetRankColor(npcData.level)
            
            -- 发送升级消息和特效
            BroadcastMessage(1, {
                name = npcData.name,
                rank = newRank,
                color = rankColor,
                isDowngrade = false
            })
            
            -- 发送升级特效
            if ofkc_npc_levelup_effect:GetBool() then
                net.Start("NPCLevelUpEffect")
                net.WriteEntity(attacker)
                net.WriteColor(rankColor)
                net.Broadcast()
            end
            
            -- 发送升级对话
            NPCTalk("levelup", attacker)
                
            requiredExp = GetRequiredExp(npcData.level)
        end
        
        -- 如果已经满级，将经验设为0
        if npcData.level >= 15 then
            npcData.exp = 0
        end
        
        local rank = GetRank(npcData.level)
        local rankColor = GetRankColor(npcData.level)
        
        -- 发送击杀消息
        if isFriendlyFire then
            BroadcastMessage(2, {
                rank = rank,
                name = npcData.name,
                victimRank = victimRank,
                victimName = victimName,
                expGain = math.abs(expGain),
                color = rankColor,
                victimColor = victimColor
            })
        else
            BroadcastMessage(3, {
                rank = rank,
                name = npcData.name,
                victimRank = victimRank,
                victimName = victimName,
                expGain = expGain,
                level = npcData.level,
                color = rankColor,
                victimColor = victimColor
            })
        end
        
        SyncNPCData(attacker, npcData)
        
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

    net.Receive("NPCTalk_Taunt", function()
        local message = net.ReadString()
        local rank = net.ReadString()
        local name = net.ReadString()
        local color = net.ReadColor()
        
        chat.AddText(color, rank .. " " .. name .. ": ", Color(255, 255, 255), message)
    end)

    net.Receive("NPCTalk_Idle", function()
        local message = net.ReadString()
        local rank = net.ReadString()
        local name = net.ReadString()
        local color = net.ReadColor()
        
        chat.AddText(color, rank .. " " .. name .. ": ", Color(255, 255, 255), message)
    end)

    net.Receive("NPCTalk_LevelUp", function()
        local message = net.ReadString()
        local rank = net.ReadString()
        local name = net.ReadString()
        local color = net.ReadColor()
        
        chat.AddText(color, rank .. " " .. name .. ": ", Color(255, 255, 255), message)
    end)

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
    surface.CreateFont("ofkctextlarge3d", {
        font = "HONOR Sans CN Heavy",
        extended = true,
        size = 100
    })

    surface.CreateFont("ofkctext3d", {
        font = "HONOR Sans CN",
        extended = true,
        size = 60
    })

    -- 存储NPC升级特效数据
    local levelUpEffects = {}

    -- 接收升级特效
    net.Receive("NPCLevelUpEffect", function()
        local npc = net.ReadEntity()
        local color = net.ReadColor()
        
        if IsValid(npc) then
            levelUpEffects[npc] = {
                color = color,
                startTime = CurTime(),
                duration = 1 -- 持续1秒
            }
        end
    end)

    -- 渲染NPC升级特效
    hook.Add("PostDrawOpaqueRenderables", "RenderNPCLevelUpEffect", function()
        if not GetConVar("ofkc_enabled"):GetBool() then return end
        for npc, effectData in pairs(levelUpEffects) do
            if IsValid(npc) then
                local timeElapsed = CurTime() - effectData.startTime
                if timeElapsed <= effectData.duration then
                    local alpha = 255 * (1 - timeElapsed / effectData.duration)
                    
                    cam.Start3D()
                        render.SetColorModulation(effectData.color.r/255, effectData.color.g/255, effectData.color.b/255)
                        render.SuppressEngineLighting(true)
                        render.MaterialOverride(Material("models/debug/debugwhite"))
                        render.SetBlend(alpha/255)
                        npc:DrawModel()
                        render.MaterialOverride()
                        render.SuppressEngineLighting(false)
                        render.SetBlend(1)
                    cam.End3D()
                else
                    levelUpEffects[npc] = nil
                end
            else
                levelUpEffects[npc] = nil
            end
        end
    end)

    -- 接收 NPC 数据
    net.Receive("SyncNPCData", function()
        local ent = net.ReadEntity()
        if not IsValid(ent) then return end
        
        npcs[ent:EntIndex()] = {
            name = net.ReadString(),
            level = net.ReadUInt(8),
            kills = net.ReadUInt(8),
            exp = net.ReadUInt(16),
            class = net.ReadString()
        }
    end)

    -- 接收聊天消息
    net.Receive("BroadcastMessage", function()
        local messageType = net.ReadUInt(4)
        local data = net.ReadTable()
        
        if messageType == 1 then -- 升级/降级消息
            if data.isDowngrade then
                chat.AddText(data.color, string.format("%s 降级为 %s！", 
                    data.name, data.rank))
            else
                chat.AddText(data.color, string.format("%s 晋升为 %s！", 
                    data.name, data.rank))
            end
        elseif messageType == 2 then -- 误杀消息
            chat.AddText(Color(255, 255, 255), "友军伤害！",
                data.color, data.rank .. " " .. data.name,
                Color(255, 255, 255), " 误杀了同伴 ",
                data.victimColor, data.victimRank .. " " .. data.victimName,
                Color(255, 255, 255), string.format("，损失 %d 经验！", data.expGain))
        elseif messageType == 3 then -- 击杀消息
            if data.level >= 15 then
                chat.AddText(data.color, data.rank .. " " .. data.name,
                    Color(255, 255, 255), " 击败了 ",
                    data.victimColor, data.victimRank .. " " .. data.victimName)
            else
                chat.AddText(data.color, data.rank .. " " .. data.name,
                    Color(255, 255, 255), " 击败了 ",
                    data.victimColor, data.victimRank .. " " .. data.victimName,
                    Color(255, 255, 255), string.format("，获得 %d 经验！", data.expGain))
            end
        end
    end)

    -- 显示 NPC 信息
    hook.Add("HUDPaint", "DisplayNPCInfo", function()
        if not GetConVar("ofkc_enabled"):GetBool() then return end
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        
        local tr = ply:GetEyeTrace()
        if not IsValid(tr.Entity) or not tr.Entity:IsNPC() then return end
        if tr.Entity:GetClass() == "npc_bullseye" then return end
        
        -- 检查距离,超过1000单位不显示
        local distance = ply:GetPos():Distance(tr.Entity:GetPos())
        if distance > 1000 then return end
        
        local npcData = npcs[tr.Entity:EntIndex()]
        if not npcData then return end

        -- 如果npc_text_mode为1，则不在HUD上显示
        if GetConVar("ofkc_npc_text_mode"):GetInt() == 1 then return end
        
        local rank = GetRank(npcData.level)
        local rankColor = GetRankColor(npcData.level)
        local sw, sh = ScrW(), ScrH()
        
        local text = string.format("%s %s ", rank, npcData.name)
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
        
        local infoText
        if npcData.level >= 15 then
            infoText = string.format("等级: %d | 击杀: %d | 经验: 满级", 
                npcData.level, npcData.kills)
        else
            local requiredExp = GetRequiredExp(npcData.level)
            infoText = string.format("等级: %d | 击杀: %d | 经验: %d/%d", 
                npcData.level, npcData.kills, npcData.exp, requiredExp)
        end
        draw.SimpleText(infoText, "ofkctext", x, y + 30, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end)

    -- 在NPC头顶显示信息
    hook.Add("PostDrawTranslucentRenderables", "DrawNPCOverheadInfo", function()
        if not GetConVar("ofkc_enabled"):GetBool() then return end
        if GetConVar("ofkc_npc_text_mode"):GetInt() ~= 1 then return end

        local ply = LocalPlayer()
        if not IsValid(ply) then return end

        for _, ent in ipairs(ents.FindByClass("npc_*")) do
            if not IsValid(ent) or ent:GetClass() == "npc_bullseye" then continue end

            local distance = ply:GetPos():Distance(ent:GetPos())
            if distance > 500 then continue end

            local npcData = npcs[ent:EntIndex()]
            if not npcData then continue end

            local pos = ent:GetPos() + Vector(0, 0, ent:OBBMaxs().z + 10)
            local ang = Angle(0, ply:EyeAngles().y - 90, 90)

            -- 修改缩放计算方式,使用平方根函数使缩放变化更平缓
            local scale = math.Clamp(math.sqrt(1 - (distance / 1000)), 0.1, 1)

            cam.Start3D2D(pos, ang, 0.1 * scale)
                local rank = GetRank(npcData.level)
                local rankColor = GetRankColor(npcData.level)
                local text = string.format("%s %s", rank, npcData.name)

                -- 绘制文字阴影
                draw.SimpleText(text, "ofkctextlarge3d", 2, 2, Color(0, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                -- 绘制主文字
                draw.SimpleText(text, "ofkctextlarge3d", 0, 0, rankColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

                local infoText
                if npcData.level >= 15 then
                    infoText = string.format("等级: %d | 击杀: %d | 经验: 满级", 
                        npcData.level, npcData.kills)
                else
                    local requiredExp = GetRequiredExp(npcData.level)
                    infoText = string.format("等级: %d | 击杀: %d | 经验: %d/%d", 
                        npcData.level, npcData.kills, npcData.exp, requiredExp)
                end

                -- 绘制信息文字阴影
                draw.SimpleText(infoText, "ofkctext3d", 2, 72, Color(0, 0, 0, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                -- 绘制信息主文字
                draw.SimpleText(infoText, "ofkctext3d", 0, 70, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            cam.End3D2D()
        end
    end)
end
