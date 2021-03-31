--######################################
--##   Raviv Resto Shaman Beta v0.9   ##
--##             ProfileUI            ##
--######################################
local TMW                                            = TMW 
local CNDT                                            = TMW.CNDT
local Env                                            = CNDT.Env
local A                                                = Action
local GetToggle                                        = A.GetToggle
local InterruptIsValid                                = A.InterruptIsValid
local UnitCooldown                                    = A.UnitCooldown
local Unit                                            = A.Unit 
local Player                                        = A.Player 
local Pet                                            = A.Pet
local LoC                                            = A.LossOfControl
local MultiUnits                                    = A.MultiUnits
local EnemyTeam                                        = A.EnemyTeam
local FriendlyTeam                                    = A.FriendlyTeam
local TeamCache                                        = A.TeamCache
local InstanceInfo                                    = A.InstanceInfo
local TR                                            = Action.TasteRotation
local select, setmetatable                            = select, setmetatable
-- Shadowlands Spell Info fix for empty spells
local GetSpellInfo_original                                = _G.GetSpellInfo
local function GetSpellInfo(...)
    return GetSpellInfo_original(...) or ""
end
A.Data.ProfileEnabled[Action.CurrentProfile] = true
A.Data.ProfileUI                                     = {    
    DateTime = "v1.7.0 (4 January 2021)",
    [2] = {        
        [ACTION_CONST_SHAMAN_ENHANCEMENT] = {             
            { -- GENERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ► ► ► GENERAL ◄ ◄ ◄ ",
                    },
                },
            }, 
            {
                {
                    E = "Checkbox", 
                    DB = "mouseover",
                    DBV = true,
                    L = { 
                        enUS = "Use @mouseover", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions for @mouseover units\nExample: Resuscitate, Healing", 
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use AoE", 
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                    }, 
                    M = {},
                },                   
            },
            { -- LAYOUT SPACE
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },                 
            { -- [2]  
                {
                    E = "Checkbox", 
                    DB = "UsePWS",
                    DBV = false,
                    L = { 
                        enUS = "DO NOT USE THIS PROFILE",
                    }, 
                    TT = { 
                        enUS = "PROFILE IS NOT ENABLED",
                    }, 
                    M = {},
                },
                {
                    E = "Slider",                                                     
                    MIN = 1, 
                    MAX = 7,                            
                    DB = "PWSMove",
                    DBV = 3, -- Set healthpercentage @60% life. 
                    ONOFF = true,
                    L = { 
                        ANY = "DO NOT USE THIS PROFILE",
                    }, 
                    TT = { 
                        enUS = "If " .. GetSpellInfo(17) .. " is talented and ready, will use it if moving for set value.", 
                        ruRU = "Если " .. GetSpellInfo(17) .. " изучен и готов, будет использовать его при переходе на заданное значение.", 
                        frFR = "Si " .. GetSpellInfo(17) .. " est prêt, l'utilisera s'il se déplace pour la valeur définie.", 
                    }, 
                    M = {},
                },                
            },
            { -- LAYOUT SPACE
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },             
            { -- ROTATION CHANGES
                {
                    E = "Header",
                    L = {
                        ANY = " ► ► ► UNUSED SPACE ◄ ◄ ◄ ",
                    },
                },
            },
            {
                {
                    E = "Checkbox", 
                    DB = "PWSAlways",
                    DBV = false,
                    L = { 
                        ANY = "THIS PROFILE DOES NOT WORK",
                    }, 
                    TT = { 
                        ANY = "DO NOT USE THIS PROFILE",
                    }, 
                    M = {},
                },
                {
                    E = "Checkbox", 
                    DB = "CombatMeditation",
                    DBV = false,
                    L = { 
                        ANY = "THIS PROFILE DOES NOTHING",
                    }, 
                    TT = { 
                        ANY = "DO NOT USE THIS PROFILE",
                    }, 
                    M = {},
                },
            },
            {
                {
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "MindgamesHP",
                    DBV = 100, -- Set healthpercentage @60% life. 
                    ONOFF = false,
                    L = { 
                        ANY = "DO NOT USE THIS PROFILE",
                    }, 
                    M = {},
                },            
            },
           
         
        },
        
        [ACTION_CONST_SHAMAN_ELEMENTAL] = {          
            LayoutOptions = { gutter = 5, padding = { left = 10, right = 10 } },    
            { -- General Header
                {
                    E = "Header",
                    L = {
                        ANY = " ► ► ► GENERAL ◄ ◄ ◄ ",
                    },
                },
            },
            { -- General Content            
                { -- TargetTarget Checkbox
                    E = "Checkbox", 
                    DB = "targettarget",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@targettarget", 
                        ruRU = "Использовать\n@targettarget", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions\nfor enemy @targettarget units", 
                        ruRU = "Разблокирует использование\nдействий для вражеских @targettarget юнитов", 
                    }, 
                    M = {},
                },
                { -- AoE Checkbox
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use\nAoE", 
                        ruRU = "Использовать\nAoE", 
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                    }, 
                    M = {},
                },  
                {
                    E = "Checkbox", 
                    DB = "UseRotationPassive",
                    DBV = true,
                    L = { 
                        enUS = "Use\nPassive\nRotation",
                        ruRU = "Включить\nПассивную\nРотацию" 
                    },
                    M = {},
                }, 
                { -- PW:S Tank
                    E = "Checkbox", 
                    DB = "UNUSED SPACE",
                    DBV = true,
                    L = { 
                        ANY = "THIS PROFILE DOES NOTHING CURRENTLY"
                    },
                    TT = { 
                        ANY = "DO NOT USE THIS PROFILE CURRENTLY",
                    },
                    M = {},
                },                 
            },     

        },
		--------------------------------------------------------------------------------------------------------------------
        [ACTION_CONST_SHAMAN_RESTORATION] = {          
            LayoutOptions = { gutter = 5, padding = { left = 10, right = 10 } },    
            { -- GENERAL HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ► ► ► GENERAL ◄ ◄ ◄ ",
                    },
                },
            },
            { -- GENERAL SETTINGS                            
                { -- TARGETTARGET
                    E = "Checkbox", 
                    DB = "targettarget",
                    DBV = true,
                    L = { 
                        enUS = "Use\n@targettarget", 
                        ruRU = "Использовать\n@targettarget", 
                    }, 
                    TT = { 
                        enUS = "Will unlock use actions\nfor enemy @targettarget units", 
                        ruRU = "Разблокирует использование\nдействий для вражеских @targettarget юнитов", 
                    }, 
                    M = {},
                },
                { -- AOE
                    E = "Checkbox", 
                    DB = "AoE",
                    DBV = true,
                    L = { 
                        enUS = "Use\nAoE", 
                        ruRU = "Использовать\nAoE", 
                    }, 
                    TT = { 
                        enUS = "Enable multiunits actions", 
                        ruRU = "Включает действия для нескольких целей", 
                    }, 
                    M = {},
                },  
                { -- MANA MANAGEMENT
                    E = "Checkbox", 
                    DB = "ManaManagement",
                    DBV = true,
                    L = { 
                        enUS = "Boss Fight\nManaSave\n(PvE)", 
                        ruRU = "Бой с Боссом\nУправление Маной\n(PvE)",
                    }, 
                    TT = { 
                        enUS = "Enable to keep small mana save tricks during boss fight\nMana will keep going to save phase if Boss HP >= our Mana", 
                        ruRU = "Включает сохранение малого количества маны с помощью некоторых манипуляций в течении боя против Босса\nМана будет переходить в фазу сохранения если ХП Босса >= нашей Маны", 
                    }, 
                    M = {},
                },             
                { -- MANA POTION
                    E = "Checkbox", 
                    DB = "ManaPotion",
                    DBV = true,
                    L = { 
                        enUS = "Use\nMana Potion",
                        ruRU = "Использовать\nЗелье Маны",
                    },
                    M = {},
                },                                   
            },
            { -- LAYOUT SPACE
                
                {
                    E = "LayoutSpace",                                                                         
                },
            },              
            { -- HEALING ENGINE HEADER
                {
                    E = "Header",
                    L = {
                        ANY = " ► ► ► HEALING ENGINE ◄ ◄ ◄ ",
                    },
                },
            },    
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },                 
            {
                { -- Healing
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "Healing",
                    DBV = 60,
                    ONLYOFF = true,
                    L = { 
                        ANY = "Healing (%)"
                    },
                    TT = {
                        ANY = "Target HP % to begin healing rotation."
                    },
                    M = {},
                },
            },
            {
                { -- AoE Healing
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "AoEHealing",
                    DBV = 90,
                    ONLYOFF = true,
                    L = { 
                        ANY = "AoE Healing (%)"
                    },
                    TT = {
                        ANY = "Group HP % to use AoE Spells."
                    },
                    M = {},
                },
            },
            {
                { -- Cooldowns
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "Cooldowns",
                    DBV = 80,
                    ONLYOFF = true,
                    L = { 
                        ANY = "Cooldowns (%)"
                    },
                    TT = {
                        ANY = "Group HP % to use Cooldowns."
                    },
                    M = {},
                },
            },
            { -- LAYOUT SPACE   
                {
                    E = "LayoutSpace",                                                                         
                },
            },             
            {
                { -- DOWNPOUR ON @PLAYER
                    E = "Checkbox", 
                    DB = "UseDownpourOnSelf ",
                    DBV = true,
                    L = { 
                        ANY = "Downpour on yourself"
                    },
                    TT = {
                        ANY = "IN BETA ONLY - DOES NOT TOGGLE ANYTHING CURRENTLY"
                    },
                    M = {},
                },
            },                      
            { -- LAYOUT SPACE               
                {
                    E = "LayoutSpace",                                                                         
                },
            },              
            { -- DEFENSIVES
                {
                    E = "Header",
                    L = {
                        ANY = " ► ► ► DEFENSIVES ◄ ◄ ◄ ",
                    },
                }, 
            },
            {
                { -- Astral Shift
                    E = "Slider",                                                     
                    MIN = 0, 
                    MAX = 100,                            
                    DB = "AstralShift",
                    DBV = 40,
                    ONLYOFF = true,
                    L = { 
                        ANY = "Astral Shift HP (%)"
                    },
                    M = {},
                },      
            },                                   
        },        
    },
}
function A.Main_CastBars(unit, list)
    if not A.IsInitialized or A.IamHealer or (A.Zone ~= "arena" and A.Zone ~= "pvp") then 
        return false 
    end 
    
    if A[A.PlayerSpec] and A[A.PlayerSpec].SpearHandStrike and A[A.PlayerSpec].SpearHandStrike:IsReadyP(unit, nil, true) and A[A.PlayerSpec].SpearHandStrike:AbsentImun(unit, {"KickImun", "TotalImun", "DamagePhysImun"}, true) and A.InterruptIsValid(unit, list) then 
        return true         
    end 
end 
function A.Second_CastBars(unit)
    if not A.IsInitialized or (A.Zone ~= "arena" and A.Zone ~= "pvp")  then 
        return false 
    end 
    
    local Toggle = A.GetToggle(2, "ParalysisPvP")    
    if Toggle and Toggle ~= "OFF" and A[A.PlayerSpec] and A[A.PlayerSpec].Paralysis and A[A.PlayerSpec].Paralysis:IsReadyP(unit, nil, true) and A[A.PlayerSpec].Paralysis:AbsentImun(unit, {"CCTotalImun", "TotalImun", "DamagePhysImun"}, true) and Unit(unit):IsControlAble("incapacitate", 0) then 
        if Toggle == "BOTH" then 
            return select(2, A.InterruptIsValid(unit, "Heal", true)) or select(2, A.InterruptIsValid(unit, "PvP", true)) 
        else
            return select(2, A.InterruptIsValid(unit, Toggle, true))         
        end 
    end 
end