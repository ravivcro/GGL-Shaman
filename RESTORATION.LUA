--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
--▫▫   Raviv Resto Shaman Beta v0.9   ▫▫
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
local _G, setmetatable                          = _G, setmetatable
local A                                         = _G.Action
local Covenant                                  = _G.LibStub("Covenant")
local TMW                                       = _G.TMW
local Listener                                  = Action.Listener
local Create                                    = Action.Create
local GetToggle                                 = Action.GetToggle
local SetToggle                                 = Action.SetToggle
local GetGCD                                    = Action.GetGCD
local GetCurrentGCD                             = Action.GetCurrentGCD
local GetPing                                   = Action.GetPing
local ShouldStop                                = Action.ShouldStop
local BurstIsON                                 = Action.BurstIsON
local CovenantIsON                              = Action.CovenantIsON
local AuraIsValid                               = Action.AuraIsValid
local InterruptIsValid                          = Action.InterruptIsValid
local FrameHasSpell                             = Action.FrameHasSpell
local Utils                                     = Action.Utils
local TeamCache                                 = Action.TeamCache
local EnemyTeam                                 = Action.EnemyTeam
local FriendlyTeam                              = Action.FriendlyTeam
local LoC                                       = Action.LossOfControl
local Player                                    = Action.Player 
local MultiUnits                                = Action.MultiUnits
local UnitCooldown                              = Action.UnitCooldown
local Unit                                      = Action.Unit 
local IsUnitEnemy                               = Action.IsUnitEnemy
local IsUnitFriendly                            = Action.IsUnitFriendly
local ActiveUnitPlates                          = MultiUnits:GetActiveUnitPlates()
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local pairs                                     = pairs
local HealingEngine                             = Action.HealingEngine
local HealingEngineMembersALL                 = HealingEngine.Data.SortedUnitIDs
local HealingEngineGetMinimumUnits            = HealingEngine.GetMinimumUnits
local HealingEngineGetIncomingDMGAVG          = HealingEngine.GetIncomingDMGAVG
local HealingEngineGetIncomingHPSAVG          = HealingEngine.GetIncomingHPSAVG
local HealingEngineGetTimeToFullHealth        = HealingEngine.GetTimeToFullHealth
local HealingEngineGetTimeToDieUnits          = HealingEngine.GetTimeToDieUnits
local HealingEngineGetHealthFrequency         = HealingEngine.GetHealthFrequency
local HealingEngineGetHealthAVG               = HealingEngine.GetHealthAVG
local HealingEngineGetOptionsByUnitID         = HealingEngine.GetOptionsByUnitID
local HealingEngineSetTarget                  = HealingEngine.SetTarget
local HealingEngineSetTargetMostlyIncDMG      = HealingEngine.SetTargetMostlyIncDMG
local HealingEngineIsMostlyIncDMG             = HealingEngine.IsMostlyIncDMG
local HealingEngineIsManaSave                 = HealingEngine.IsManaSave
local TeamCacheFriendly                         = TeamCache.Friendly
local IsIndoors, UnitIsUnit                     = IsIndoors, UnitIsUnit
local UnitExists, UnitIsPlayer, UnitClass, UnitCreatureType, UnitInRange, UnitInRaid, UnitInParty, UnitGUID, UnitPower, UnitPowerMax = 
UnitExists, UnitIsPlayer, UnitClass, UnitCreatureType, UnitInRange, UnitInRaid, UnitInParty, UnitGUID, UnitPower, UnitPowerMax
--For Toaster
local Toaster                                    = _G.Toaster
local GetSpellTexture                            = _G.TMW.GetSpellTexture
--- ▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫ CONTENT ▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
-- Spell ID List --
Action[ACTION_CONST_SHAMAN_RESTORATION] = {
    ---Racial---
    ArcaneTorrent                             = Create({ Type = "Spell", ID = 50613                    }),
    BloodFury                                 = Create({ Type = "Spell", ID = 20572                    }),
    Fireblood                                 = Create({ Type = "Spell", ID = 265221                   }),
    AncestralCall                             = Create({ Type = "Spell", ID = 274738                   }),
    Berserking                                = Create({ Type = "Spell", ID = 26297                    }),
    ArcanePulse                               = Create({ Type = "Spell", ID = 260364                   }),
    QuakingPalm                               = Create({ Type = "Spell", ID = 107079                   }),
    Haymaker                                  = Create({ Type = "Spell", ID = 287712                   }), 
    WarStomp                                  = Create({ Type = "Spell", ID = 20549                    }),
    BullRush                                  = Create({ Type = "Spell", ID = 255654                   }),    
    BagofTricks                               = Create({ Type = "Spell", ID = 312411                   }),    
    GiftofNaaru                               = Create({ Type = "Spell", ID = 59544                    }),
    LightsJudgment                            = Create({ Type = "Spell", ID = 255647                   }),
    Shadowmeld                                = Create({ Type = "Spell", ID = 58984                    }),
    Stoneform                                 = Create({ Type = "Spell", ID = 20594                    }), 
    WilloftheForsaken                         = Create({ Type = "Spell", ID = 7744                     }),
    EscapeArtist                              = Create({ Type = "Spell", ID = 20589                    }), 
    EveryManforHimself                        = Create({ Type = "Spell", ID = 59752                    }),
    Regeneratin                               = Create({ Type = "Spell", ID = 291944                   }),
    ---Resto---
    WaterShield                               = Create({ Type = "Spell", ID = 79949                    }),
    EarthShield                               = Create({ Type = "Spell", ID = 974                      }),
    Riptide                                	  = Create({ Type = "Spell", ID = 61295                    }),
    HealingRain                               = Create({ Type = "Spell", ID = 73920                    }),
    UnleashLife                               = Create({ Type = "Spell", ID = 73685                    }),
    Wellspring                                = Create({ Type = "Spell", ID = 197995                   }),
    HealingStreamTotem                        = Create({ Type = "Spell", ID = 5394                     }),
    CloudBurstTotem                           = Create({ Type = "Spell", ID = 157153                   }),
    Downpour                                  = Create({ Type = "Spell", ID = 207778                   }),
    EarthWallTotem                            = Create({ Type = "Spell", ID = 198838                   }),
    HealingWave                               = Create({ Type = "Spell", ID = 77472                    }),
    ChainHeal                                 = Create({ Type = "Spell", ID = 1064                     }),
    HealingSurge                              = Create({ Type = "Spell", ID = 8004                     }),
    HealingTideTotem                          = Create({ Type = "Spell", ID = 108280                   }),
    AncestralVision                           = Create({ Type = "Spell", ID = 212048                   }),
    TidalWave                                 = Create({ Type = "Spell", ID = 53390                    }),	
    ManaTideTotem                             = Create({ Type = "Spell", ID = 16191                    }),	
    AstralShift                               = Create({ Type = "Spell", ID = 108271                   }),	
    Ascendance                                = Create({ Type = "Spell", ID = 114052                   }),		
    WindShear                                 = Create({ Type = "Spell", ID = 57994                    }),		
	---Dispel---
    PurifySpirit                              = Create({ Type = "Spell", ID = 77130                    }),
    WindShear                                 = Create({ Type = "Spell", ID = 57994                    }),
    Purge                                	  = Create({ Type = "Spell", ID = 370                      }),
    ---DPS---
    LightningBolt                             = Create({ Type = "Spell", ID = 188196                   }),
    FlameShock                                = Create({ Type = "Spell", ID = 188389                   }),
    LavaBurst                                 = Create({ Type = "Spell", ID = 51505                    }),
    ---Items---
    PotionofUnbridledFury                     = Create({ Type = "Potion",  ID = 169299                 }), 
    GalecallersBoon                           = Create({ Type = "Trinket", ID = 159614                 }),    
    LustrousGoldenPlumage                     = Create({ Type = "Trinket", ID = 159617                 }),    
    PocketsizedComputationDevice              = Create({ Type = "Trinket", ID = 167555                 }),    
    AshvanesRazorCoral                        = Create({ Type = "Trinket", ID = 169311                 }),    
    AzsharasFontofPower                       = Create({ Type = "Trinket", ID = 169314                 }),    
    RemoteGuidanceDevice                      = Create({ Type = "Trinket", ID = 169769                 }),    
    WrithingSegmentofDrestagath               = Create({ Type = "Trinket", ID = 173946                 }),    
    DribblingInkpod                           = Create({ Type = "Trinket", ID = 169319                 }),    
	---Mythic---
    WindShearYellow                           = Create({ Type = "SpellSingleColor", ID = 5211, Color = "YELLOW", Desc = "[1] CC", QueueForbidden = true         }),
    PoolResource                              = Create({ Type = "Spell", ID = 209274, Hidden = true     }),
    DummyTest                                 = Create({ Type = "Spell", ID = 159999, Hidden = true     }),   
    Quake                                     = Create({ Type = "Spell", ID = 240447, Hidden = true     }), 
    Burst                                     = Create({ Type = "Spell", ID = 240443, Hidden = true     }), 
    GrievousWound                             = Create({ Type = "Spell", ID = 240559, Hidden = true     }), 
}
Action:CreateEssencesFor(ACTION_CONST_SHAMAN_RESTORATION)

local A = setmetatable(Action[ACTION_CONST_SHAMAN_RESTORATION], { __index = Action })
local Temp = {
    TotalAndPhys                            = {"TotalImun", "DamagePhysImun"},
    TotalAndCC                              = {"TotalImun", "CCTotalImun"},
    TotalAndPhysKick                        = {"TotalImun", "DamagePhysImun", "KickImun"},
    TotalAndPhysAndCC                       = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    TotalAndPhysAndStun                     = {"TotalImun", "DamagePhysImun", "StunImun"},
    TotalAndPhysAndCCAndStun                = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},
    TotalAndMag                             = {"TotalImun", "DamageMagicImun"},
    TotalAndMagKick                         = {"TotalImun", "DamageMagicImun", "KickImun"},
    DisablePhys                             = {"TotalImun", "DamagePhysImun", "Freedom", "CCTotalImun"},
    DisableMag                              = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    AttackTypes                             = {"TotalImun", "DamageMagicImun"},
    AuraForStun                             = {"TotalImun", "DamagePhysImun", "CCTotalImun", "StunImun"},    
    AuraForCC                               = {"TotalImun", "DamagePhysImun", "CCTotalImun"},
    AuraForOnlyCCAndStun                    = {"CCTotalImun", "StunImun"},
    AuraForDisableMag                       = {"TotalImun", "DamageMagicImun", "Freedom", "CCTotalImun"},
    AuraForInterrupt                        = {"TotalImun", "DamagePhysImun", "KickImun"},
}
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
local GetTotemInfo, IsMouseButtonDown, UnitIsUnit = GetTotemInfo, IsMouseButtonDown, UnitIsUnit
local player = "player"
local targettarget = "targettarget"
local target = "target"
local mouseover = "mouseover"
local function RotationsVariables()
    UseDBM = GetToggle(1 ,"DBM")
    Potion = GetToggle(1, "Potion")
    Racial = GetToggle(1, "Racial")
    ManaManagement = GetToggle(2, "ManaManagement")
    ManaPotion = GetToggle(2, "ManaPotion")
    Healing = A.GetToggle(2, "Healing")
    AoEHealing = A.GetToggle(2, "AoEHealing")
    Cooldowns = A.GetToggle(2, "Cooldowns")
    
    ----> Rotation Stuff <----
    notMoving = notMoving
    inCombat = Unit(player):CombatTime() ~= 0
    ReadyToCast = Unit("target"):GetRange() < 40 and Unit(player):CastTime() == 0 and GetCurrentGCD() == 0 
    Emergency =  Unit("target"):HealthPercent() <= 25
    PartyGroup = TeamCache.Friendly.Size <= 5
    RaidGroup = TeamCache.Friendly.Size > 5
    getmembersAll = HealingEngine.Data.SortedUnitIDs
    UseDownpourOnSelf = A.GetToggle(2, "UseDownpourOnSelf")
end
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
local function IsEnoughHPS(unitID)
    return Unit(player):GetHPS() > max(Unit(unitID):GetDMG() - Unit(unitID):GetHEAL(), 0)
end
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
TMW:RegisterCallback("TMW_ACTION_HEALINGENGINE_UNIT_UPDATE", function(callbackEvent, thisUnit, db, QueueOrder)  
    if thisUnit.isSelf and thisUnit.HP >= 85 then
        thisUnit.Enabled = false
    end         
end)
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
local function CanAoEHealing(unit)
    AoEHealingUnits = HealingEngineGetMinimumUnits(HealingEngineIsManaSave() and 0 or 1, 6)
    if AoEHealingUnits < 3 then 
        return false 
    end 
    if AoEHealingUnits >= TeamCacheFriendly.Size then  
        AoEHealingUnits = TeamCacheFriendly.Size 
    end
    local counter = 0 
    for i = 1, #HealingEngineMembersALL do 
        if Unit(HealingEngineMembersALL[i].Unit):GetRange() <= 40 then 
            
            if AoEHealing < 100 and HealingEngineMembersALL[i].realHP <= AoEHealing then 
                counter = counter + 1
            end 
            
            if counter >= AoEHealingUnits then 
                return true 
            end 
        end 
    end 
end 
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
local function CanCooldowns(unit)
    local CooldownsUnits = HealingEngineGetMinimumUnits(1)
    -- Reduce size in raid by 25%
    if CooldownsUnits > 5 then 
        CooldownsUnits = CooldownsUnits - (#HealingEngineMembersALL * 0.25)
    end 
    
    if CooldownsUnits < 3 then 
        return false 
    end 
    
    local counter = 0 
    for i = 1, #HealingEngineMembersALL do 
        if Cooldowns < 100 and HealingEngineMembersALL[i].realHP <= Cooldowns then 
            counter = counter + 1
        end 
        
        if counter >= CooldownsUnits then 
            return true 
        end 
    end 
end
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
local function GetByRange(count, range, isStrictlySuperior, isStrictlyInferior, isStrictlyEqual, isCheckEqual, isCheckCombat) -- Range check function
    -- @return boolean 
    local c = 0 
    
    if isStrictlySuperior == nil then
        isStrictlySuperior = false
    end
    
    if isStrictlyInferior == nil then
        isStrictlyInferior = false
    end    
    
    if isStrictlyEqual == nil then
        isStrictlyEqual = false
    end
    
    for unit in pairs(ActiveUnitPlates) do 
        if (not isCheckEqual or not UnitIsUnit("target", unit)) and (not isCheckCombat or Unit(unit):CombatTime() > 0) then 
            if InRange(unit) then 
                c = c + 1
            elseif range then 
                local r = Unit(unit):GetRange()
                if r > 0 and r <= range then 
                    c = c + 1
                end 
            end 
            -- Strictly superior than >
            if isStrictlySuperior and not isStrictlyInferior and not isStrictlyEqual then
                if c > count then
                    return true
                end
            end
            
            -- Strictly inferior <
            if isStrictlyInferior and not isStrictlySuperior and not isStrictlyEqual then
                if c < count then
                    return true
                end
            end
            
            -- Strictly equal ==
            if not isStrictlyInferior and not isStrictlySuperior and isStrictlyEqual then
                if c == count then
                    return true
                end
            end    
            
            -- Classic >=
            if not isStrictlyInferior and not isStrictlySuperior and not isStrictlyEqual then
                if c >= count then 
                    return true 
                end 
            end
        end 
        
    end
    
end  
GetByRange = A.MakeFunctionCachedDynamic(GetByRange)
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
    if Unit(player):CombatTime() == 0 then  
        return 
    end
    
    local AstralShift = A.GetToggle(2, "AstralShift")
    if    AstralShift >= 0 and A.AstralShift:IsReady(player) and 
    (
        (     -- Auto 
            AstralShift >= 100 and 
            (
                (
                    not A.IsInPvP and 
                    Unit(player):HealthPercent() < 80 and 
                    Unit(player):TimeToDieX(20) < 8 
                ) or 
                (
                    A.IsInPvP and 
                    (
                        Unit(player):UseDeff() or 
                        (
                            Unit(player, 5):HasFlags() and 
                            Unit(player):GetRealTimeDMG() > 0 and 
                            Unit(player):IsFocused(nil, true)                                 
                        )
                    )
                )
            ) and 
            Unit(player):HasBuffs("DeffBuffs") == 0
        ) or 
        (    -- Custom
            AstralShift < 100 and 
            Unit(player):HealthPercent() <= AstralShift
        )
    ) 
    then 
        return A.AstralShift
    end 
SelfDefensives = A.MakeFunctionCachedStatic(SelfDefensives)
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
--- PvE
-- local function WipeAgro()
    -- local units = MultiUnits:GetActiveUnitPlates()
    -- if tableexist(units) then
        -- for k, unit in pairs(units) do
            -- if CombatTime(unit) > 0 and Unit("player"):IsTanking(unit) then
                -- return true
            -- end
        -- end
    -- end
    -- return false
-- end
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
------------------------------------------------------------------------------------------------------------
-- StopQuake --
------------------------------------------------------------------------------------------------------------
local function StopQuake()
    if Unit(player):HasDeBuffs(A.Quake.ID) ~= 0 and Unit(player):HasDeBuffs(A.Quake.ID) <= GetLatency() + GetCurrentGCD() then
        return true
    end
end   
------------------------------------------------------------------------------------------------------------ 
--- ▫▫▫▫▫▫▫ ACTION LISTS ▫▫▫▫▫▫▫
A[3] = function(icon, isMulti) -- Single target icon displayer
    RotationsVariables()
    
    -- 'Quaking' --
    if StopQuake() then
        return A.PoolResource:Show(icon)
    end 	
    -- Water Shield
    if A.WaterShield:IsSpellLearned() and A.WaterShield:IsReady(player) and Unit(player):HasBuffs(A.WaterShield.ID, true) == 0 then
        return A.WaterShield:Show(icon)
    end
    
    
    --▫▫▫▫▫▫▫▫▫▫▫▫▫   
    --▫▫▫Purge  ▫▫▫
    --▫▫▫▫▫▫▫▫▫▫▫▫▫
    
    if inCombat and A.Purge:IsReady(unit) and not Unit(unit):IsBoss() and not RaidGroup() and AuraIsValid(unit, "UsePurge", "MagicMovement") then
        return A.Purge:Show(icon)
    end
    if inCombat and A.Purge:IsReady(unit) and not Unit(unit):IsBoss() and not RaidGroup() and AuraIsValid(unit, "UsePurge", "PurgeHigh") then
        return A.Purge:Show(icon)
    end
    if inCombat and A.Purge:IsReady(unit) and not Unit(unit):IsBoss() and not RaidGroup() and AuraIsValid(unit, "UsePurge", "PurgeLow") then
        return A.Purge:Show(icon)
    end
    
    
    --▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫ 
    --▫▫▫DPS ROTATION ▫▫▫
    --▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
    
    local function DamageRotation(unit)
        
        if ReadyToCast then       
            
			-- LavaBurst
			if A.LavaBurst:IsReady(unitID) and (notMoving or Unit(player):HasBuffs(A.SpiritwalkersGrace.ID, true) > 0) and A.LavaBurst:AbsentImun(unitID, Temp.TotalAndMag) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) > 0 then 
				return A.LavaBurst:Show(icon)
			end 

			-- FlameShock
			if A.FlameShock:IsReady(unitID) and A.FlameShock:AbsentImun(unitID, Temp.TotalAndMag) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) < 3 then 
				return A.FlameShock:Show(icon)
			end 

			-- ChainLightning
			if A.ChainLightning:IsReady(unitID) and UseAoE and (notMoving or Unit(player):HasBuffs(A.SpiritwalkersGrace.ID, true) > 0) and A.ChainLightning:AbsentImun(unitID, Temp.TotalAndMag) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) > 0 and A.MultiUnits:GetActiveEnemies() > ChainLightningTargets then 
				return A.ChainLightning:Show(icon)
			end 

			-- LightningBolt
			if A.LightningBolt:IsReady(unitID) and (notMoving or Unit(player):HasBuffs(A.SpiritwalkersGrace.ID, true) > 0) and A.LightningBolt:AbsentImun(unitID, Temp.TotalAndMag) and Unit(unitID):HasDeBuffs(A.FlameShock.ID, true) > 0 then 
				return A.LightningBolt:Show(icon)
			end
        end
    end
    
    --▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫   
    --▫▫▫HPS ROTATION ▫▫▫
    --▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫ 
    
    local function HealingRotation(unit)
        local useDispel, useShields, useHoTs, useUtils = HealingEngine.GetOptionsByUnitID(unit)
        local unitGUID = UnitGUID(unit)    
        
        if ReadyToCast then
           	-- 'EarthShield' --
			if A.EarthShield:IsSpellLearned() and A.EarthShield:IsReady(unitID, true) and Unit(unit):IsTank() and Unit(player):CombatTime() ~= 0 then
					return A.EarthShield:Show(icon)
			end 
            -- Rez Single
            -- 'AncestralVision' --
            if A.AncestralVision:IsReady(unitID, true) and Unit(player):CombatTime() == 0 and Unit("player"):GetCurrentSpeed() == 0 and((Unit("target"):IsDead() and A.Resurrection:IsSpellInRange("target"))) then
                return A.AncestralVision:Show(icon)
            end                 
				--Healing Engine Dispel Target
				if A.NaturesCure:IsReady() then
					for i = 1, #getmembersAll do 
						if Unit(getmembersAll[i].Unit):GetRange() <= 40 and AuraIsValid(getmembersAll[i].Unit, "UseDispel", "Dispel") and Unit(getmembersAll[i].Unit):TimeToDie() > 5 and not Unit(getmembersAll[i].Unit):IsTank() then  
							if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
								HealingEngine.SetTarget(getmembersAll[i].Unit) 
								break
							end                                                                         
						end                
					end
				end
            
            --Purify
            if A.NaturesCure:IsReady(unit) and A.NaturesCure:AbsentImun(unit) and A.AuraIsValid(unit, "UseDispel", "Dispel") and Unit(unit):TimeToDie() > 5 then 
                return A.NaturesCure:Show(icon)
            end 
            
            --▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫ 

            --▫▫BURST SECTION▫▫--
            if inCombat and A.BurstIsON(unit) and CanCooldowns() then

				-- 'PrimordialWave'
				if A.PrimordialWave:IsReady(unitID, true) then
					return A.PrimordialWave:Show(icon)
				end 

				-- 'ChainHarvest'
				if A.ChainHarvest:IsReady(unitID, true) and notMoving then
					return A.ChainHarvest:Show(icon)
				end 
				
				-- 'Berserking' --
				if A.Berserking:IsReady(unit) then
					return A.Berserking:Show(icon)
				end
				
				-- 'HealingTideTotem' 
				if A.HealingTideTotem:IsReady(unitID, true) then
					return A.HealingTideTotem:Show(icon)
				end   
				
				-- 'SpiritLinkTotem' 
				if A.SpiritLinkTotem:IsReady(unitID, true) then
					return A.SpiritLinkTotem:Show(icon)
				end

				-- 'Mana Tide Totem' 
				if A.ManaTideTotem:IsReady(unitID, true) and Player:Mana() <= 85 then
					return A.ManaTideTotem:Show(icon)
				end		
     
            end  
			--▫▫END BURST SECTION▫▫--
            
			--▫▫EMERGENCY SECTION▫▫--
            if inCombat and A.BurstIsON(unit) and Emergency then
				-- 'CloudBurstTotem' 
                if A.CloudBurstTotem:IsSpellLearned() and A.CloudBurstTotem:IsReady(unitID, true) then
                        return A.CloudBurstTotem:Show(icon)
				end  			

				-- 'Ancestral Protection Totem' 
				if A.AncestralProtectionTotem:IsSpellLearned() and A.AncestralProtectionTotem:IsReady(unitID, true) then
						return A.AncestralProtectionTotem:Show(icon)
				end				
				
				-- 'Ascendance' Talent
				if A.Ascendance:IsSpellLearned() and A.Ascendance:IsReady(unitID, true) then 
						return A.Ascendance:Show(icon)
				end			
				
				-- 'UnleashLife' 
                if A.UnleashLife:IsSpellLearned() and A.UnleashLife:IsReady(unitID, true) then
                        return A.UnleashLife:Show(icon)
				end
		
				-- 'Healing Surge'
				if A.HealingSurge:IsReady(unitID, true) and notMoving then
						return A.HealingSurge:Show(icon)
				end

                -- Trinket 1
                if inCombat and A.Trinket1:IsReady(unit) then
                    return A.Trinket1:Show(icon)    
                end
                
                -- Trinket 2
                if inCombat and A.Trinket2:IsReady(unit) then
                    return A.Trinket2:Show(icon)    
                end    
            end
            --▫▫END EMERGENCY SECTION▫▫--
			
			--▫▫HPS SECTION▫▫--
			
			-- 'Riptide' -- 
			if A.Riptide:IsReady(unitID, true) and Unit(unit):HasBuffs(A.TidalWave.ID, true) <= 2 and inCombat then
				return A.Riptide:Show(icon)
			end
				
			-- 'EarthWallTotem' 
			if A.EarthWallTotem:IsSpellLearned() and A.EarthWallTotem:IsReady(unitID, true) and inCombat then
					return A.EarthWallTotem:Show(icon)
			end
			
			-- 'HealingStreamTotem' 
			if A.HealingStreamTotem:IsReady(unitID, true) and inCombat and Unit(unit):HealthPercent() <= Healing then
					return A.HealingStreamTotem:Show(icon)
			end

			-- 'Healing Surge'
			if A.HealingSurge:IsReady(unitID, true) and inCombat and notMoving and Player:Mana() >= 85 and Unit(unit):HealthPercent() <= 85 then
					return A.HealingSurge:Show(icon)
			end
			
			-- 'Healing Wave' -- 
			if A.HealingWave:IsReady(unitID, true) and Unit(unit):HasBuffs(A.TidalWave.ID, true) >= 1 and notMoving and Unit(unit):HealthPercent() <= Healing then
				return A.HealingWave:Show(icon)
			end
									
             
            --▫▫AOE HEALING SECTION▫▫--
            if inCombat and CanAoEHealing() then
			
				-- 'ChainHeal'
				if A.ChainHeal:IsReady(unitID, true) and Player:Mana() >= 85 and CanAoEHealing() and notMoving and Unit(unit):HealthPercent() <= Healing then
					return A.HealingRain:Show(icon)
				end 			

				-- 'Downpour' 
                if A.Downpour:IsSpellLearned() and A.Downpour:IsReady(unitID, true) and notMoving and Unit(unit):HealthPercent() <= Healing then
                        return A.Downpour:Show(icon)
				end
				
            end
            --▫▫END AOE HEALING SECTION▫▫--
			
			-- 'Wellspring' 
			if A.Wellspring:IsSpellLearned() and A.Wellspring:IsReady(unitID, true) and notMoving and Unit(unit):GetRange() <= 20 then
					return A.Wellspring:Show(icon)
			end		
			
            -- Spread Riptide in Dungeons    
            if A.Riptide:IsReady(unit) and PartyGroup then 
                for i = 1, #getmembersAll do 
                    if Unit(getmembersAll[i].Unit):GetRange() <= 40 and Unit(getmembersAll[i].Unit):HasBuffs(A.Riptide.ID, true) == 0 then  
                        if UnitGUID(getmembersAll[i].Unit) ~= currGUID then
                            HealingEngine.SetTarget(getmembersAll[i].Unit) 
                            break
                        end                                                                         
                    end                
                end
            end 
			--▫▫END HPS SECTION▫▫--
        end
    end
    
    --▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
    --▫▫▫MAIN ACTION CALLS ▫▫▫
    --▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
    
    -- Defensive
    local SelfDefensive = SelfDefensives()
    if SelfDefensive then 
        return SelfDefensive:Show(icon)
    end 
    
    -- Heal Target 
    if A.IsUnitFriendly(target) then 
        unit = target 
        
        if HealingRotation(unit) then 
            return true 
        end 
    end    
    
    -- DPS Target     
    if A.IsUnitEnemy(target) then 
        unit = target
        
        if DamageRotation(unit) then 
            return true 
        end 
    end 
    
    -- DPS targettarget     
    if A.IsUnitEnemy(targettarget) then 
        unit = targettarget
        
        if DamageRotation(unit) then 
            return true 
        end 
    end     
end 
--▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫▫
local function RotationPassive(icon) 
    RotationsVariables()
    if GetToggle(1, "StopCast") then
        
        ----> Stop if Target is dead <----
        if IsUnitEnemy("target") and Unit("target"):IsDead() then
            return A:Show(icon, ACTION_CONST_STOPCAST)
        end 
        
        ----> Stop Healing Abilities  <----
        if PartyGroup and IsUnitFriendly("target") and Unit(player):IsCastingRemains(A.Heal.ID) ~= 0 then 
            -- 'if target is above 90% health and we cast 'Regrowth'
            if Unit("target"):HealthPercent() <= Healing then
                return A:Show(icon, ACTION_CONST_STOPCAST)
            end 
        end
        if PartyGroup then
            -- Stop Damage Abilities --
			if Unit(player):HasDeBuffs(A.Quake.ID) == 0 and IsUnitFriendly("target") and (Unit(player):IsCastingRemains(A.HealingWave.ID) ~= 0 or Unit(player):IsCastingRemains(A.HealingSurge.ID) ~= 0 or Unit(player):IsCastingRemains(A.HealingRain.ID) ~= 0 or Unit(player):IsCastingRemains(A.ChainHeal.ID) ~= 0 or Unit(player):IsCastingRemains(A.Hex.ID) ~= 0 or Unit(player):IsCastingRemains(A.LavaBurst.ID) ~= 0 or Unit(player):IsCastingRemains(A.LightningBolt.ID) ~= 0 or Unit(player):IsCastingRemains(A.ChainLightning.ID) ~= 0 or Unit(player):IsCastingRemains(A.Wellspring.ID) ~= 0 or Unit(player):IsCastingRemains(A.ChainHarvest.ID) ~= 0) then 
                -- 'if target is below slider value'
                if Unit("target"):HealthPercent() <= Healing then
                    return A:Show(icon, ACTION_CONST_STOPCAST)
                end   
            end
            
            -- Quaking --
            if (Unit(player):IsCastingRemains(A.HealingWave.ID) ~= 0 or Unit(player):IsCastingRemains(A.HealingSurge.ID) ~= 0 or Unit(player):IsCastingRemains(A.HealingRain.ID) ~= 0 or Unit(player):IsCastingRemains(A.ChainHeal.ID) ~= 0 or Unit(player):IsCastingRemains(A.Hex.ID) ~= 0 or Unit(player):IsCastingRemains(A.LavaBurst.ID) ~= 0 or Unit(player):IsCastingRemains(A.LightningBolt.ID) ~= 0 or Unit(player):IsCastingRemains(A.ChainLightning.ID) ~= 0 or Unit(player):IsCastingRemains(A.Wellspring.ID) ~= 0 or Unit(player):IsCastingRemains(A.ChainHarvest.ID) ~= 0) then 
                if Unit(player):HasDeBuffs(A.Quake.ID) ~= 0 and Unit(player):HasDeBuffs(A.Quake.ID) <= GetLatency() + GetCurrentGCD() then
                    return A:Show(icon, ACTION_CONST_STOPCAST)
                end   
            end  
        end        
    end
end 
A[1] = nil
A[2] = nil  
A[4] = nil 
A[5] = nil
A[6] = function(icon)
    if RotationPassive(icon) then 
        return true 
    end 
end 
A[7] = nil
A[8] = nil