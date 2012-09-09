local major = "DRData-1.0"
local minor = 1012
assert(LibStub, string.format("%s requires LibStub.", major))

local Data = LibStub:NewLibrary(major, minor)
if( not Data ) then return end

local L = {
	["Banish"] = "Banish",
	["Bind Elemental"] = "Bind Elemental",
	["Charge"] = "Charge",
	["Controlled roots"] = "Controlled roots",
	["Controlled stuns"] = "Controlled stuns",
	["Cyclone"] = "Cyclone",
	["Disarms"] = "Disarms",
	["Disorients"] = "Disorients",
	["Dragon's Breath"] = "Dragon's Breath",
	["Entrapment"] = "Entrapment",
	["Fears"] = "Fears",
	["Horrors"] = "Horrors",
	["Ice Ward"] = "Ice Ward",
	["Mind Control"] = "Mind Control",
	["Random stuns"] = "Random stuns",
	["Scatter Shot"] = "Scatter Shot",
	["Silences"] = "Silences",
	["Taunts"] = "Taunts",
}

if GetLocale() == "frFR" then
	L["Banish"] = "Bannissement"
	L["Bind Elemental"] = "Lier un élémentaire"
	L["Charge"] = "Charge"
	L["Controlled roots"] = "Immobilisations"
	L["Controlled stuns"] = "Etourdissements"
	L["Cyclone"] = "Cyclone"
	L["Disarms"] = "Désarmements"
	L["Disorients"] = "Désorientations"
	L["Dragon's Breath"] = "Souffle du dragon"
	L["Entrapment"] = "Piège"
	L["Fears"] = "Peurs"
	L["Horrors"] = "Horreurs"
	L["Ice Ward"] = "Garde glaciale"
	L["Mind Control"] = "Contrôle mental"
	L["Random stuns"] = "Etourdissemensts aléatoires"
	L["Scatter Shot"] = "Flèche de dispersion"
	L["Silences"] = "Silences"
	L["Taunts"] = "Provocations"
end

-- How long before DR resets
-- While everyone will tell you it's 15 seconds, it's actually 16 - 20 seconds with 18 being a decent enough average
Data.RESET_TIME = 18

-- List of spellID -> DR category
Data.spells = {
	--[[ TAUNT ]]--
	[   355] = "taunt", -- Taunt (Warrior)
	[ 53477] = "taunt", -- Taunt (Hunter tenacity pet)
	[  6795] = "taunt", -- Growl (Druid)
	[115546] = "taunt", -- Provoke (Monk)
	[ 56222] = "taunt", -- Dark Command
	[ 62124] = "taunt", -- Hand of Reckoning
	[ 31790] = "taunt", -- Righteous Defense
	[ 20736] = "taunt", -- Distracting Shot
	[ 57603] = "taunt", -- Death Grip
	[ 36213] = "taunt", -- Angered Earth -- FIXME: NPC ability ?
	[ 17735] = "taunt", -- Suffering (Voidwalker)

	--[[ DISORIENTS ]]--
	-- Druid
	[  2637] = "disorient", -- Hibernate
	[    99] = "disorient", -- Disorienting Roar (talent)
    -- Hunter
	[  3355] = "disorient", -- Freezing Trap
	[ 19386] = "disorient", -- Wyvern Sting
    -- Mage
	[   118] = "disorient", -- Polymorph
	[ 28272] = "disorient", -- Polymorph (pig)
	[ 28271] = "disorient", -- Polymorph (turtle)
	[ 61305] = "disorient", -- Polymorph (black cat)
	[ 61025] = "disorient", -- Polymorph (serpent) -- FIXME: gone ?
	[ 61721] = "disorient", -- Polymorph (rabbit)
	[ 61780] = "disorient", -- Polymorph (turkey)
	[ 82691] = "disorient", -- Ring of Frost
    -- Monk
	[115078] = "disorient", -- Paralysis
    -- Paladin
	[115750] = "disorient", -- Blinding Light
	[ 20066] = "disorient", -- Repentance
    -- Priest
	[  9484] = "disorient", -- Shackle Undead
    -- Rogue
	[  1776] = "disorient", -- Gouge
	[  6770] = "disorient", -- Sap
    -- Shaman
	[ 51514] = "disorient", -- Hex
    -- Pandaren
	[107079] = "disorient", -- Quaking Palm

	--[[ SILENCES ]]--
	-- Death Knight
	[ 47476] = "silence", -- Strangulate
    -- Druid
	[ 78675] = "silence", -- Solar Beam
	[ 81261] = "silence", -- Solar Beam -- FIXME: check id
    -- Hunter
	[ 34490] = "silence", -- Silencing Shot
	[ 50479] = "silence", -- Nether Shock (Nether ray)
    -- Mage
	[ 12598] = "silence", -- Improved Counterspell
	[102051] = "silence", -- Frostjaw (talent)
    -- Paladin
	[ 31935] = "silence", -- Avenger's Shield
    -- Priest
	[ 15487] = "silence", -- Silence
    -- Rogue
	[  1330] = "silence", -- Garrote
    -- Warlock
	[103135] = "silence", -- Spell Lock (Felhunter)
    -- Warrior
	[ 18498] = "silence", -- Glyph of Gag Order -- FIXME: check id
    -- Blood Elf
	[ 25046] = "silence", -- Arcane Torrent (Energy version)
	[ 28730] = "silence", -- Arcane Torrent (Mana version)
	[ 50613] = "silence", -- Arcane Torrent (Runic power version)
	[ 69179] = "silence", -- Arcane Torrent (Rage version)
	[ 80483] = "silence", -- Arcane Torrent (Focus version)

	--[[ DISARMS ]]--
	-- Hunter
	[ 91644] = "disarm", -- Snatch (Bird of Prey)
	[ 50541] = "disarm", -- Clench (Scorpid)
    -- Monk
	[117368] = "disarm", -- Grapple Weapon
	-- Priest
	[ 64058] = "disarm", -- Psychic Horror (Disarm effect)
    -- Rogue Dismantle
	[ 51722] = "disarm", -- Dismantle
    -- Warlock
	[124539] = "disarm", -- Voidwalker: Disarm
    -- Warrior Disarm
	[   676] = "disarm", -- Disarm

	--[[ FEARS ]]--
	-- Hunter
	[  1513] = "fear", -- Scare Beast
    -- Paladin
	[ 10326] = "fear", -- Turn Evil
    -- Priest
	[  8122] = "fear", -- Psychic Scream
	-- [] = "fear", -- Psyfiend Fear (ID ?)
    -- Rogue
	[  2094] = "fear", -- Blind
    -- Warlock
	[  5782] = "fear", -- Fear (Warlock)
	[111397] = "fear", -- Blood Fear (talent)
	[  5484] = "fear", -- Howl of Terror
	[  6358] = "fear", -- Seduction (Succubus)
    -- Warrior
	[  5246] = "fear", -- Intimidating Shout (main target)
	[ 20511] = "fear", -- Intimidating Shout (secondary targets)

	--[[ CONTROL STUNS ]]--
	-- Death Knight
	[108194] = "ctrlstun", -- Asphyxiate (talent)
	[ 91800] = "ctrlstun", -- Gnaw (Ghoul)
	[ 91797] = "ctrlstun", -- Monstrous Blow (Dark Transformation Ghoul)
    -- Druid
	[ 22570] = "ctrlstun", -- Maim
	[  9005] = "ctrlstun", -- Pounce
	[  5211] = "ctrlstun", -- Mighty Bash (talent)
	[102795] = "ctrlstun", -- Bear Hug
    -- Hunter
	[ 24394] = "ctrlstun", -- Intimidation
	[ 90337] = "ctrlstun", -- Bad Manner (Monkey)
	[ 50519] = "ctrlstun", -- Sonic Blast (Bat)
	[ 56626] = "ctrlstun", -- Sting (Wasp)
	[117526] = "ctrlstun", -- Binding Shot (talent)
    -- Mage
	[ 44572] = "ctrlstun", -- Deep Freeze
	[118271] = "ctrlstun", -- Combustion Impact (Combustion; Fire)
    -- Monk
	[119392] = "ctrlstun", -- Charging Ox Wave (talent)
	[119381] = "ctrlstun", -- Leg Sweep (talent)
	[122242] = "ctrlstun", -- Clash (Brewmaster)
	[120086] = "ctrlstun", -- Fists of Fury (Windwalker)
    -- Paladin
	[   853] = "ctrlstun", -- Hammer of Justice
	[119072] = "ctrlstun", -- Holy Wrath (Protection)
	[105593] = "ctrlstun", -- Fist of Justice (talent)
    -- Priest
	[ 88625] = "ctrlstun", -- Holy Word: Chastise
    -- Rogue
	[  1833] = "ctrlstun", -- Cheap Shot
	[   408] = "ctrlstun", -- Kidney Shot
    -- Shaman
	[118905] = "ctrlstun", -- Static Charge (Capacitor Totem)
	-- Warlock
	[ 30283] = "ctrlstun", -- Shadowfury
	[ 89766] = "ctrlstun", -- Axe Toss (Felguard)
	[ 22703] = "ctrlstun", -- Infernal Awakening (Infernal)
    -- Warrior
	[132168] = "ctrlstun", -- Shockwave
	[105771] = "ctrlstun", -- Warbringer (talent)
    -- Tauren
	[ 20549] = "ctrlstun", -- War Stomp

	--[[ RANDOM STUNS ]]--
	-- Rogue
	[ 35202] = "rndstun", -- Paralysis (Paralytic Poison five stack stun)
    -- Warrior
	[118000] = "rndstun", -- Dragon Roar (talent)

	--[[ ROOTS ]]--
	-- Death Knight
	[ 50041] = "ctrlroot", -- Chilblains
	-- Druid
	[   339] = "ctrlroot", -- Entangling Roots
	[ 19975] = "ctrlroot", -- Nature's Grasp (Uses different spellIDs than Entangling Roots for the same spell)
    -- Hunter
	[ 50245] = "ctrlroot", -- Pin (Crab)
	[  4167] = "ctrlroot", -- Web (Spider)
	[ 54706] = "ctrlroot", -- Venom Web Spray (Silithid)
	[ 90327] = "ctrlroot", -- Lock Jaw (Dog)
    -- Mage
	[   122] = "ctrlroot", -- Frost Nova
	[ 33395] = "ctrlroot", -- Freeze (Water Elemental)
    -- Monk
	[116095] = "ctrlroot", -- Disable
    -- Priest
	[108920] = "ctrlroot", -- Void Tendrils
    -- Shaman
	[ 51485] = "ctrlroot", -- Earth's Grasp
	[ 63374] = "ctrlroot", -- Frozen Power
    -- Warrior
	[107566] = "ctrlroot", -- Staggering Shout

	--[[ HORROR ]]--
	-- Priest
	[ 64044] = "horror", -- Psychic Horror
	-- Warlock
	[  6789] = "horror", -- Mortal Coil

	--[[ MISC ]]--
	-- Druid
	[ 33786] = "cyclone",       -- Cyclone
	-- Hunter
	[ 19503] = "scatters",      -- Scatter Shot
	[ 19185] = "entrapment",    -- Entrapment
	-- Mage
	[ 31661] = "dragons",       -- Dragon's Breath
	[111264] = "iceward",       -- Ice Ward
	-- Priest
	[   605] = "mc",            -- Mind Control
	-- Shaman
	[ 76780] = "bindelemental", -- Bind Elemental
	-- Warlock
	[   710] = "banish",        -- Banish
	-- Warrior
	[  7922] = "charge",        -- Charge
}

-- DR Category names
Data.categoryNames = {
	["banish"] = L["Banish"],
	["bindelemental"] = L["Bind Elemental"],
	["charge"] = L["Charge"],
	["ctrlroot"] = L["Controlled roots"],
	["ctrlstun"] = L["Controlled stuns"],
	["cyclone"] = L["Cyclone"],
	["disarm"] = L["Disarms"],
	["disorient"] = L["Disorients"],
	["dragons"] = L["Dragon's Breath"],
	["entrapment"] = L["Entrapment"],
	["fear"] = L["Fears"],
	["horror"] = L["Horrors"],
	["iceward"]= L["Ice Ward"],
	["mc"] = L["Mind Control"],
	["rndstun"] = L["Random stuns"],
	["scatters"] = L["Scatter Shot"],
	["silence"] = L["Silences"],
	["taunt"] = L["Taunts"],
}

-- Categories that have DR in PvE as well as PvP
Data.pveDR = {
	["ctrlstun"] = true,
	["rndstun"] = true,
	["taunt"] = true,
	["cyclone"] = true,
	["bindelemental"] = true,
}

-- Public APIs
-- Category name in something usable
function Data:GetCategoryName(cat)
	return cat and Data.categoryNames[cat] or nil
end

-- Spell list
function Data:GetSpells()
	return Data.spells
end

-- Seconds before DR resets
function Data:GetResetTime()
	return Data.RESET_TIME
end

-- Get the category of the spellID
function Data:GetSpellCategory(spellID)
	return spellID and Data.spells[spellID] or nil
end

-- Does this category DR in PvE?
function Data:IsPVE(cat)
	return cat and Data.pveDR[cat] or nil
end

-- List of categories
function Data:GetCategories()
	return Data.categoryNames
end

-- Next DR, if it's 1.0, next is 0.50, if it's 0.[50] = "ctrlroot",next is 0.[25] = "ctrlroot",and such
function Data:NextDR(diminished)
	if( diminished == 1 ) then
		return 0.50
	elseif( diminished == 0.50 ) then
		return 0.25
	end

	return 0
end

--[[ EXAMPLES ]]--
-- This is how you would track DR easily, you're welcome to do whatever you want with the below functions

--[[
local trackedPlayers = {}
local function debuffGained(spellID, destName, destGUID, isEnemy, isPlayer)
	-- Not a player, and this category isn't diminished in PVE, as well as make sure we want to track NPCs
	local drCat = DRData:GetSpellCategory(spellID)
	if( not isPlayer and not DRData:IsPVE(drCat) ) then
		return
	end

	if( not trackedPlayers[destGUID] ) then
		trackedPlayers[destGUID] = {}
	end

	-- See if we should reset it back to undiminished
	local tracked = trackedPlayers[destGUID][drCat]
	if( tracked and tracked.reset <= GetTime() ) then
		tracked.diminished = 1.0
	end
end

local function debuffFaded(spellID, destName, destGUID, isEnemy, isPlayer)
	local drCat = DRData:GetSpellCategory(spellID)
	if( not isPlayer and not DRData:IsPVE(drCat) ) then
		return
	end

	if( not trackedPlayers[destGUID] ) then
		trackedPlayers[destGUID] = {}
	end

	if( not trackedPlayers[destGUID][drCat] ) then
		trackedPlayers[destGUID][drCat] = { reset = 0, diminished = 1.0 }
	end

	local time = GetTime()
	local tracked = trackedPlayers[destGUID][drCat]

	tracked.reset = time + DRData:GetResetTime()
	tracked.diminished = DRData:NextDR(tracked.diminished)

	-- Diminishing returns changed, now you can do an update
end

local function resetDR(destGUID)
	-- Reset the tracked DRs for this person
	if( trackedPlayers[destGUID] ) then
		for cat in pairs(trackedPlayers[destGUID]) do
			trackedPlayers[destGUID][cat].reset = 0
			trackedPlayers[destGUID][cat].diminished = 1.0
		end
	end
end

local COMBATLOG_OBJECT_TYPE_PLAYER = COMBATLOG_OBJECT_TYPE_PLAYER
local COMBATLOG_OBJECT_REACTION_HOSTILE = COMBATLOG_OBJECT_REACTION_HOSTILE
local COMBATLOG_OBJECT_CONTROL_PLAYER = COMBATLOG_OBJECT_CONTROL_PLAYER

local eventRegistered = {["SPELL_AURA_APPLIED"] = true, ["SPELL_AURA_REFRESH"] = true, ["SPELL_AURA_REMOVED"] = true, ["PARTY_KILL"] = true, ["UNIT_DIED"] = true}
local function COMBAT_LOG_EVENT_UNFILTERED(self, event, timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, spellID, spellName, spellSchool, auraType)
	if( not eventRegistered[eventType] ) then
		return
	end

	-- Enemy gained a debuff
	if( eventType == "SPELL_AURA_APPLIED" ) then
		if( auraType == "DEBUFF" and DRData:GetSpellCategory(spellID) ) then
			local isPlayer = ( bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			debuffGained(spellID, destName, destGUID, (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE), isPlayer)
		end

	-- Enemy had a debuff refreshed before it faded, so fade + gain it quickly
	elseif( eventType == "SPELL_AURA_REFRESH" ) then
		if( auraType == "DEBUFF" and DRData:GetSpellCategory(spellID) ) then
			local isPlayer = ( bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			local isHostile = (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE)
			debuffFaded(spellID, destName, destGUID, isHostile, isPlayer)
			debuffGained(spellID, destName, destGUID, isHostile, isPlayer)
		end

	-- Buff or debuff faded from an enemy
	elseif( eventType == "SPELL_AURA_REMOVED" ) then
		if( auraType == "DEBUFF" and DRData:GetSpellCategory(spellID) ) then
			local isPlayer = ( bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) == COMBATLOG_OBJECT_TYPE_PLAYER or bit.band(destFlags, COMBATLOG_OBJECT_CONTROL_PLAYER) == COMBATLOG_OBJECT_CONTROL_PLAYER )
			debuffFaded(spellID, destName, destGUID, (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE), isPlayer)
		end

	-- Don't use UNIT_DIED inside arenas due to accuracy issues, outside of arenas we don't care too much
	elseif( ( eventType == "UNIT_DIED" and select(2, IsInInstance()) ~= "arena" ) or eventType == "PARTY_KILL" ) then
		resetDR(destGUID)
	end
end]]
