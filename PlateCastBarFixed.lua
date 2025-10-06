local AddOn = "PlateCastBarFixed"
local select = select
local pairs = pairs
local tinsert = tinsert

-- Quick logger for debugging
local function log(...)
    local text = ""
    for i = 1, select("#", ...) do
        text = text .. " " .. tostring(select(i, ...))
    end
    DEFAULT_CHAT_FRAME:AddMessage(text)
end

local Table = {
    ["Nameplates"] = {},
    ["CastBar"] = {
        ["Blizzard"] = {
            Width = 123,
            Height = 30.73,
        },
    },
}

local Textures = {
    Font   = "Interface\\AddOns\\".. AddOn .."\\Textures\\DorisPP.ttf",
    CastBar= "Interface\\AddOns\\".. AddOn .."\\Textures\\media\\Blinkii.tga",
}

-- Full media inventories shipped with this addon
local ALL_FONT_FILES = {
    "Accidental Presidency.ttf","AccidentalPresidency.ttf","ActionMan.ttf","AdobeBlank.ttf","Adventure.ttf","AlbaSuper.ttf","AllHookedUp.ttf","AncientGeek.ttf","ArmWrestler.ttf","Augustus.ttf","Aurora.ttf","AuroraExtended.ttf","AvantGardeLTBold.ttf","AvantGardeLTMedium.ttf","Avanti.ttf","BaarSophia.ttf","Bavaria.ttf","BavariaExtended.ttf","Bazooka.ttf","BigNoodleTitling.ttf","BigNoodleTitlingCyr.ttf","BigNoodleToo.ttf","BlackChancery.ttf","Blazed.ttf","BlenderPro.ttf","BlenderProBold.ttf","BlenderProHeavy.ttf","BorisBlackBloxx.ttf","BorisBlackBloxxDirty.ttf","Caesar.ttf","CalibriBold.ttf","CapitalisTypeOasis.ttf","CelestiaMediumRedux.ttf","Collegiate.ttf","Continuum.ttf","ContinuumMedium.ttf","DejaVuLGCSans.ttf","DejaVuLGCSerif.ttf","DieDieDie.ttf","Diogenes.ttf","Disko.ttf","DorisPP.TTF","Enigmatic.ttf","Eurasia.ttf","ExocetBlizzardLight.ttf","ExocetBlizzardMedium.ttf","Expressway.ttf","FORCEDSQUARE.ttf","FRIZQT__.ttf","Favourite.ttf","FiraMono-Medium.ttf","FiraMonoMedium.ttf","Fitzgerald.ttf","FrakturikaSpamless.ttf","FrancoisOne.ttf","Frucade.ttf","FrucadeExtended.ttf","FrucadeMedium.ttf","FrucadeSmall.ttf","FuturaPTBold.ttf","FuturaPTBook.ttf","FuturaPTMedium.ttf","GentiumPlus.ttf","GermanicaEmbossed.ttf","GermanicaFluted.ttf","GermanicaShadowed.ttf","GothamUltra.ttf","Gros.ttf","GrosExtended.ttf","Hack.ttf","HarryP.ttf","Homespun.ttf","Hooge.ttf","Impact.ttf","KingArthurLegend.ttf","LiberationSans.ttf","LiberationSerif.ttf","MarkeEigenbau.ttf","Memoria.ttf","MemoriaExtended.ttf","Micro.ttf","Munica.ttf","MunicaExtended.ttf","Myriad-Pro.ttf","MysticOrbs.ttf","NuevaStdCond.ttf","OldeEnglish.ttf","Oswald.ttf","PT-Sans-Narrow-Bold.ttf","PT-Sans-Narrow-Regular.ttf","PTSansNarrow.ttf","PokemonSolid.ttf","Porky.ttf","Quicksand.ttf","RockShowWhiplash.ttf","RomanSD.ttf","RomanumEst.ttf","SFAtarianSystem.ttf","SFCovington.ttf","SFDiegoSans.ttf","SFMoviePoster.ttf","SFWonderComic.ttf","SWF!T.ttf","Semplice.ttf","SempliceExtended.ttf","Solange.ttf","StarCine.ttf","SteelfishRg.ttf","TGL.ttf","Taurus.ttf","TelluralAlt.ttf","TrashHand.ttf","Trashco.ttf","TriatlhonIn.ttf","UbuntuCondensed.ttf","UbuntuLight.ttf","WaltographUI.ttf","WenQuanYiZenHei.ttf","X360.ttf","YanoneKaffeesatzRegular.ttf","Yellowjacket.ttf","yanone.ttf",
}

local ALL_TEXTURE_FILES = {
    "Aluminium.tga","BantoBar.tga","Bars.tga","Blinkii.tga","Bumps.tga","Button.tga","Charcoal.tga","Cilo.tga","Cloud.tga","Comet.tga","Dabs.tga","DarkBottom.tga","Diagonal.tga","Falumn.tga","Ferous1.tga","Ferous10.tga","Ferous11.tga","Ferous12.tga","Ferous13.tga","Ferous14.tga","Ferous15.tga","Ferous16.tga","Ferous17.tga","Ferous18.tga","Ferous19.tga","Ferous2.tga","Ferous20.tga","Ferous21.tga","Ferous22.tga","Ferous23.tga","Ferous24.tga","Ferous25.tga","Ferous26.tga","Ferous27.tga","Ferous28.tga","Ferous29.tga","Ferous3.tga","Ferous30.tga","Ferous31.tga","Ferous32.tga","Ferous33.tga","Ferous34.tga","Ferous35.tga","Ferous36.tga","Ferous37.tga","Ferous4.tga","Ferous5.tga","Ferous6.tga","Ferous7.tga","Ferous8.tga","Ferous9.tga","Fifths.tga","Flat.tga","Fourths.tga","Frost.tga","Glamour.tga","Glamour2.tga","Glamour3.tga","Glamour4.tga","Glamour5.tga","Glamour6.tga","Glamour7.tga","Glass.tga","Glaze.tga","Glaze2.tga","Gloss.tga","Graphite.tga","Grid.tga","Hatched.tga","Healbot.tga","LiteStep.tga","LiteStepLite.tga","Lyfe.tga","Melli.tga","MelliDark.tga","MelliDarkRough.tga","Minimalist.tga","Norm.tga","Otravi.tga","Perl.tga","Perl2.tga","Pill.tga","Raeli1.tga","Raeli2.tga","Raeli3.tga","Raeli4.tga","Raeli5.tga","Raeli6.tga","Rain.tga","Rocks.tga","Round.tga","Ruben.tga","Runes.tga","Skewed.tga","Smooth.tga","Smoothv2.tga","Smudge.tga","Steel.tga","Striped.tga","ToxiUI-clean.tga","ToxiUI-dark.tga","ToxiUI-g1.tga","ToxiUI-g2.tga","ToxiUI-grad.tga","ToxiUI-half.tga","Tube.tga","Water.tga","Wglass.tga","Wisps.tga","Xeon.tga","bar_KuiNameplate.tga","bar_elvui.tga","bar_gradient.tga","bar_striped.tga","bar_tukui.tga","castbars.tga","half.tga","onepixel.tga","right.tga","statusbar.tga","whoa.tga",
}

if not _G[AddOn .. "_SavedVariables"] then
    _G[AddOn .. "_SavedVariables"] = {}
end

-- Default settings (do not overwrite user settings; only fill missing keys)
local DefaultSV = {
    CastBar = {
        Width  = 86,
        Height = 13,
        PointX = 0,
        PointY = 12,
    },
    Icon = {
        PointX = -62,
        PointY =  0,
    },
    Timer = {
        Anchor = "RIGHT",
        PointX =  52,
        PointY =  0,
        Format = "LEFT",
        Size   = 7,
    },
    Spell = {
        Anchor = "LEFT",
        PointX =  -53,
        PointY =  0,
        Size   = 7,
    },
    Enable = {
        NoFade         = false,
        ["Test"]       = false,
        ["Player Pet"] = true,
        Icon            = true,
        Timer           = true,
        Spell           = true,
    },
    Media = {
        Font    = "Fonts\\FRIZQT__.TTF",
        Texture = "Interface\\TargetingFrame\\UI-StatusBar",
    },
    Alpha = {
        NoTarget = 0.5, -- alpha to use for all when no target is selected (when NoFade is OFF)
    },
}

local function CopyDefaults(src, dst)
    if type(dst) ~= "table" then dst = {} end
    for k, v in pairs(src) do
        if type(v) == "table" then
            dst[k] = CopyDefaults(v, dst[k])
        elseif dst[k] == nil then
            dst[k] = v
        end
    end
    return dst
end

CopyDefaults(DefaultSV, _G[AddOn .. "_SavedVariables"])

-- This table will hold references to the castbar frames by unit
local castbarsByUnit = {}
-- Test mode state
local testCasts = {}

-- Keep child size consistent when reparented by matching effective scale to owner
local function SyncToOwnerScale(frame)
    local owner = frame and frame.owner
    local parent = frame and frame:GetParent()
    local ownerScale = (owner and owner.GetEffectiveScale and owner:GetEffectiveScale()) or 1
    local parentScale = (parent and parent.GetEffectiveScale and parent:GetEffectiveScale()) or 1
    local ratio = ownerScale / parentScale
    if ratio > 0 then frame:SetScale(ratio) end
end

---------------------------------------------------------------------
-- 1) A helper function to update size & positions consistently
---------------------------------------------------------------------
local function UpdateCastBarDimensions(CastBar)
    local sv = _G[AddOn .. "_SavedVariables"]

    local width  = (sv.CastBar and sv.CastBar.Width) or 105
    local height = (sv.CastBar and sv.CastBar.Height) or 11

    -- The castbar frame itself
    CastBar:SetWidth(width)
    CastBar:SetHeight(height)

    -- The actual bar texture
	CastBar.Texture:ClearAllPoints()
	CastBar.Texture:SetPoint("LEFT", CastBar, "LEFT", 0, 0)
	CastBar.Texture:SetWidth(width)
	CastBar.Texture:SetHeight(height)

    -- The border can scale relative to width or height
    CastBar.Border:SetWidth(width + 4)
    CastBar.Border:SetHeight(height + 4)

    -- The icon position is set by user offsets; size is your choice
    -- e.g. Icon is 1.4 * castbar height (40%)
    local iconSize = math.floor(height * 1.5)
    CastBar.Icon:SetWidth(iconSize)
    CastBar.Icon:SetHeight(iconSize)
    CastBar.Icon:ClearAllPoints()
    -- Tiny gap between icon and bar
    CastBar.Icon:SetPoint("RIGHT", CastBar, "LEFT", -1, 0)

	CastBar.IconBorder:ClearAllPoints()
    CastBar.IconBorder:SetPoint("CENTER", CastBar.Icon, "CENTER", 0, 0)
    CastBar.IconBorder:SetWidth(iconSize + 1)
    CastBar.IconBorder:SetHeight(iconSize + 1)
    -- Re-anchor SpellName and CastTime if you want them to shift
    -- with width/height changes, or they can remain absolute
    local SpellSV = sv.Spell
	CastBar.SpellName:ClearAllPoints()
    CastBar.SpellName:SetPoint("LEFT", CastBar, "LEFT", 0, 0)

    local TimerSV = sv.Timer
    CastBar.CastTime:ClearAllPoints()
    CastBar.CastTime:SetPoint("RIGHT", CastBar, "RIGHT", 0, 0)
end

-- Apply font and texture from SavedVariables to a castbar
local function ApplyMedia(CastBar)
    local sv = _G[AddOn .. "_SavedVariables"]
    local fontPath = (sv.Media and sv.Media.Font) or Textures.Font
    local texPath  = (sv.Media and sv.Media.Texture) or Textures.CastBar
    local spellSize = (sv.Spell and sv.Spell.Size) or 6
    local timerSize = (sv.Timer and sv.Timer.Size) or 7
    if CastBar.Texture and CastBar.Texture.SetTexture then
        CastBar.Texture:SetTexture(texPath)
    end
    if CastBar.SpellName and CastBar.SpellName.SetFont then
        CastBar.SpellName:SetFont(fontPath, spellSize, "OUTLINE")
    end
    if CastBar.CastTime and CastBar.CastTime.SetFont then
        CastBar.CastTime:SetFont(fontPath, timerSize, "OUTLINE")
    end
end

---------------------------------------------------------------------
-- 2) Creating a single castbar for a given unit's nameplate
---------------------------------------------------------------------
local function UnitCastBar_Create(unit, namePlate)
    local sv = _G[AddOn .. "_SavedVariables"]
    local frameName = AddOn .. "_Frame_" .. unit .. "CastBar"
    local CastBar = CreateFrame("Frame", frameName, namePlate)

    CastBar:SetFrameStrata("BACKGROUND")
    CastBar:SetPoint(
        "TOP",
        namePlate,
        "BOTTOM",
        (sv.CastBar and sv.CastBar.PointX) or 0,
        (sv.CastBar and sv.CastBar.PointY) or 10
    )
    CastBar:Hide()

    -- Bar texture
    local Texture = CastBar:CreateTexture(nil, "ARTWORK", nil, 1)
    local barTexturePath = (sv.Media and sv.Media.Texture) or Textures.CastBar
    Texture:SetTexture(barTexturePath)
    
	CastBar.Texture = Texture


    -- Icon
    local Icon = CastBar:CreateTexture(nil, "ARTWORK", nil, 2)
    Icon:Show()  -- We'll hide it if user disabled in a sec

    local IconBorder = CastBar:CreateTexture(nil, "BACKGROUND")
	

    -- SpellName
    local SpellName = CastBar:CreateFontString(nil)
    local fontPath = (sv.Media and sv.Media.Font) or Textures.Font
    local spellSizeInit = (sv.Spell and sv.Spell.Size) or 6
    SpellName:SetFont(fontPath, spellSizeInit, "OUTLINE")

    -- CastTime
    local CastTime = CastBar:CreateFontString(nil)
    local timerSizeInit = (sv.Timer and sv.Timer.Size) or 7
    CastTime:SetFont(fontPath, timerSizeInit, "OUTLINE")

    -- Border
    local Border = CastBar:CreateTexture(nil, "BACKGROUND")
    Border:SetPoint("CENTER", CastBar, "CENTER")

    -- Background
    local Background = CastBar:CreateTexture(nil,"BORDER")
    Background:SetTexture(1/10, 1/10, 1/10, 1)
    Background:SetAllPoints(CastBar)

    -- Store references
    CastBar.Texture    = Texture
    CastBar.Icon       = Icon
    CastBar.IconBorder = IconBorder
    CastBar.SpellName  = SpellName
    CastBar.CastTime   = CastTime
    CastBar.Border     = Border
    CastBar.unit       = unit
    CastBar.owner      = namePlate

    -- Respect fade option (and re-parent if needed to avoid inheriting alpha)
    if sv.Enable and sv.Enable.NoFade then
        if CastBar:GetParent() ~= UIParent then
            CastBar:SetParent(UIParent)
            CastBar:SetFrameStrata("BACKGROUND")
        end
        -- Match the owner's effective scale relative to our parent
        SyncToOwnerScale(CastBar)
        if CastBar.SetIgnoreParentAlpha then CastBar:SetIgnoreParentAlpha(true) end
        CastBar:SetAlpha(1)
    else
        if CastBar:GetParent() ~= namePlate then
            CastBar:SetParent(namePlate)
            CastBar:SetFrameStrata("BACKGROUND")
        end
        -- Inherit scale from parent again
        CastBar:SetScale(1)
        if CastBar.SetIgnoreParentAlpha then CastBar:SetIgnoreParentAlpha(false) end
    end

    -- Show/Hide sub-elements based on user "Enable"
    if not sv.Enable.Icon  then Icon:Hide() IconBorder:Hide() end
    if not sv.Enable.Spell then SpellName:Hide() end
    if not sv.Enable.Timer then CastTime:Hide() end

    -- Now call our dimension update
    ApplyMedia(CastBar)
    UpdateCastBarDimensions(CastBar)

    castbarsByUnit[unit] = CastBar
    return CastBar
end

---------------------------------------------------------------------
-- 3) The main OnUpdate logic, using the dimension function
--    to keep everything consistent
---------------------------------------------------------------------
local function UpdateCastBar(unit, isChannel)
    local CastBar = castbarsByUnit[unit]
    if not CastBar or not CastBar:IsShown() then return end
	
	local EXPANSION_LEVEL = GetAccountExpansionLevel()
	
	local name, _, text, texture, startTime, endTime, _, _, notInterruptible
	if isChannel then
        name, _, text, texture, startTime, endTime, _, notInterruptible = UnitChannelInfo(unit)
    else
        name, _, text, texture, startTime, endTime, _, _, notInterruptible = UnitCastingInfo(unit)
    end
	
	
		
    if name then
        if string.len(name) > 17 then
            name = string.sub(name,1,17) .. ".. "
        end
        CastBar.SpellName:SetText(name)
        CastBar.Icon:SetTexture(texture)
        CastBar.Border:SetTexture(0,0,0,1)
        CastBar.IconBorder:SetTexture(0,0,0,1)

        local currentTime = GetTime()
        local maxCastTime = (endTime - startTime) / 1000
        local castTime    = (isChannel)
                          and ((endTime/1000) - currentTime)
                           or (currentTime - (startTime/1000))

        local sv = _G[AddOn .. "_SavedVariables"]
        local barWidth = (sv.CastBar and sv.CastBar.Width) or 105
        -- "fill" the bar
        CastBar.Texture:SetWidth(barWidth * (castTime / maxCastTime))
        CastBar.Texture:ClearAllPoints()
        CastBar.Texture:SetPoint("CENTER", CastBar, "CENTER",
            -barWidth/2 + barWidth*(castTime/maxCastTime)/2, 0)
        
		if EXPANSION_LEVEL == 2 and notInterruptible then
			CastBar.Texture:SetVertexColor(0.5, 0.5, 0.5)
		else
			CastBar.Texture:SetVertexColor(1, 0.5, 0)
		end
		

        local total    = string.format("%.2f", maxCastTime)
        local leftTime = (isChannel)
                         and string.format("%.1f", castTime)
                          or string.format("%.1f", (maxCastTime - castTime))

        local timerFormat = sv.Timer.Format
        if timerFormat == "LEFT" then
            CastBar.CastTime:SetText(leftTime)
        elseif timerFormat == "TOTAL" then
            CastBar.CastTime:SetText(total)
        elseif timerFormat == "BOTH" then
            CastBar.CastTime:SetText(leftTime .. " / " .. total)
        end
    else
        -- no cast => hide
        CastBar:Hide()
    end
end

---------------------------------------------------------------------
-- Test mode: simulate casts on active nameplates
---------------------------------------------------------------------
local function UpdateTestCast(unit)
    local CastBar = castbarsByUnit[unit]
    if not CastBar then return end
    local sv = _G[AddOn .. "_SavedVariables"]
    local state = testCasts[unit]
    if not state then
        state = { start = GetTime(), dur = 2.5 }
        testCasts[unit] = state
    end
    local now = GetTime()
    local elapsed = (now - state.start)
    local progress = elapsed % state.dur
    local maxCastTime = state.dur

    local barWidth = (sv.CastBar and sv.CastBar.Width) or 105
    CastBar:Show()
    CastBar.SpellName:SetText("Test Spell")
    CastBar.Icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    CastBar.Border:SetTexture(0,0,0,1)
    CastBar.IconBorder:SetTexture(0,0,0,1)

    CastBar.Texture:SetWidth(barWidth * (progress / maxCastTime))
    CastBar.Texture:ClearAllPoints()
    CastBar.Texture:SetPoint("CENTER", CastBar, "CENTER",
        -barWidth/2 + barWidth*(progress/maxCastTime)/2, 0)
    CastBar.Texture:SetVertexColor(1, 0.5, 0)

    local total    = string.format("%.2f", maxCastTime)
    local leftTime = string.format("%.1f", (maxCastTime - progress))
    local timerFormat = sv.Timer and sv.Timer.Format or "LEFT"
    if timerFormat == "LEFT" then
        CastBar.CastTime:SetText(leftTime)
    elseif timerFormat == "TOTAL" then
        CastBar.CastTime:SetText(total)
    elseif timerFormat == "BOTH" then
        CastBar.CastTime:SetText(leftTime .. " / " .. total)
    end
end

---------------------------------------------------------------------
-- 4) The main frame events
---------------------------------------------------------------------
local Frame = CreateFrame("Frame")
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")
Frame:RegisterEvent("NAME_PLATE_UNIT_ADDED")
Frame:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
Frame:RegisterEvent("UNIT_SPELLCAST_START")
Frame:RegisterEvent("UNIT_SPELLCAST_DELAYED")
Frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
Frame:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
Frame:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")
Frame:RegisterEvent("UNIT_SPELLCAST_STOP")
Frame:RegisterEvent("UNIT_SPELLCAST_FAILED")
Frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

Frame:SetScript("OnEvent", function(self, event, unit, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        -- Usually, you'd do initialization, etc.
        if not _G[AddOn .. "_PlayerEnteredWorld"] then
            _G[AddOn .. "_PlayerEnteredWorld"] = true
        end

    elseif event == "NAME_PLATE_UNIT_ADDED" then
        local namePlate = C_NamePlate.GetNamePlateForUnit(unit)
        if namePlate then
			local CastBar = castbarsByUnit[unit]
			if not CastBar then
				CastBar = UnitCastBar_Create(unit, namePlate)
			end
			 local sv = _G[AddOn .. "_SavedVariables"]
			 if (UnitCastingInfo(unit) or UnitChannelInfo(unit)) or (sv.Enable and sv.Enable.Test) then
                CastBar:Show()
                UpdateCastBar(unit, UnitChannelInfo(unit) ~= nil)
            end 
        end

    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        if castbarsByUnit[unit] then
            castbarsByUnit[unit]:Hide()
            castbarsByUnit[unit] = nil
            testCasts[unit] = nil
        end

    elseif event == "UNIT_SPELLCAST_START"
        or event == "UNIT_SPELLCAST_DELAYED"
        or event == "UNIT_SPELLCAST_CHANNEL_START"
        or event == "UNIT_SPELLCAST_CHANNEL_UPDATE"
    then
        if castbarsByUnit[unit] then
            local isChannel = (event == "UNIT_SPELLCAST_CHANNEL_START" 
                            or event == "UNIT_SPELLCAST_CHANNEL_UPDATE")
            castbarsByUnit[unit]:Show()
            UpdateCastBar(unit, isChannel)
        end

    elseif event == "UNIT_SPELLCAST_INTERRUPTED"
        or event == "UNIT_SPELLCAST_STOP"
        or event == "UNIT_SPELLCAST_FAILED"
    then
        if castbarsByUnit[unit] then
            castbarsByUnit[unit]:Hide()
        end

    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        -- typically we do nothing special; the castbar fades on its own
    end
end)

---------------------------------------------------------------------
-- 6) Apply settings helper (update all live castbars)
---------------------------------------------------------------------
local function ApplySettings()
    local sv = _G[AddOn .. "_SavedVariables"]
    for unit, CastBar in pairs(castbarsByUnit) do
        if CastBar and CastBar:GetParent() then
            CastBar:ClearAllPoints()
            local owner = CastBar.owner or CastBar:GetParent() or UIParent
            CastBar:SetPoint(
                "TOP",
                owner,
                "BOTTOM",
                (sv.CastBar and sv.CastBar.PointX) or 0,
                (sv.CastBar and sv.CastBar.PointY) or 10
            )

            if sv.Enable and sv.Enable.Icon then
                CastBar.Icon:Show(); CastBar.IconBorder:Show()
            else
                CastBar.Icon:Hide(); CastBar.IconBorder:Hide()
            end
            if sv.Enable and sv.Enable.Spell then
                CastBar.SpellName:Show()
            else
                CastBar.SpellName:Hide()
            end
            if sv.Enable and sv.Enable.Timer then
                CastBar.CastTime:Show()
            else
                CastBar.CastTime:Hide()
            end

            -- Apply selected font and texture
            ApplyMedia(CastBar)

            -- Apply fade override per user setting
            if sv.Enable and sv.Enable.NoFade then
                if CastBar.owner and CastBar:GetParent() ~= UIParent then
                    CastBar:SetParent(UIParent)
                    CastBar:SetFrameStrata("BACKGROUND")
                end
                -- Keep scale in sync with the owner while detached
                SyncToOwnerScale(CastBar)
                if CastBar.SetIgnoreParentAlpha then CastBar:SetIgnoreParentAlpha(true) end
                CastBar:SetAlpha(1)
            else
                if CastBar.owner and CastBar:GetParent() ~= CastBar.owner then
                    CastBar:SetParent(CastBar.owner)
                    CastBar:SetFrameStrata("BACKGROUND")
                end
                -- Reset scale; will inherit parent's scale
                if CastBar.GetScale and CastBar:GetScale() ~= 1 then
                    CastBar:SetScale(1)
                end
                if CastBar.SetIgnoreParentAlpha then CastBar:SetIgnoreParentAlpha(false) end
            end

            UpdateCastBarDimensions(CastBar)
        end
    end
end

---------------------------------------------------------------------
-- 7) Configuration UI (3.3.5a Interface Options)
---------------------------------------------------------------------
local Options = CreateFrame("Frame", AddOn .. "Options", UIParent)
Options.name = "PlateCastBarFixed"
Options:Hide()

Options:SetScript("OnShow", function(panel)
    local sv = _G[AddOn .. "_SavedVariables"]

    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("PlateCastBarFixed")

    -- Helper to attach a numeric input box to a slider
    local function MakeNumberBox(anchor, init, minv, maxv, onCommit)
        local box = CreateFrame("EditBox", nil, panel, "InputBoxTemplate")
        box:SetSize(50, 20)
        box:SetAutoFocus(false)
        box:SetPoint("LEFT", anchor, "RIGHT", 16, 0)
        box:SetText(tostring(init))
        local function commit()
            local v = tonumber(box:GetText())
            if not v then
                box:SetText(tostring(init))
                box:ClearFocus()
                return
            end
            if v < minv then v = minv elseif v > maxv then v = maxv end
            v = math.floor(v + 0.5)
            box:SetText(tostring(v))
            onCommit(v)
            box:ClearFocus()
        end
        box:SetScript("OnEnterPressed", commit)
        box:SetScript("OnEditFocusLost", commit)
        return box
    end

    -- Width slider
    local widthSlider = CreateFrame("Slider", AddOn .. "WidthSlider", panel, "OptionsSliderTemplate")
    widthSlider:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -24)
    widthSlider:SetMinMaxValues(50, 300)
    widthSlider:SetValueStep(1)
    if widthSlider.SetObeyStepOnDrag then widthSlider:SetObeyStepOnDrag(true) end
    local wsText = _G[widthSlider:GetName() .. "Text"]
    if wsText then
        wsText:SetText("Width")
    else
        local wlbl = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        wlbl:SetPoint("BOTTOM", widthSlider, "TOP", 0, 2)
        wlbl:SetText("Width")
    end
    local wsLow  = _G[widthSlider:GetName() .. "Low"];  if wsLow  then wsLow:SetText("50") end
    local wsHigh = _G[widthSlider:GetName() .. "High"]; if wsHigh then wsHigh:SetText("300") end
    widthSlider:SetValue((sv.CastBar and sv.CastBar.Width) or 105)
    widthSlider:SetScript("OnValueChanged", function(self, value)
        sv.CastBar = sv.CastBar or {}
        value = math.floor(value + 0.5)
        sv.CastBar.Width = value
        if widthBox and not widthBox:HasFocus() then widthBox:SetText(tostring(value)) end
        ApplySettings()
    end)

    -- Width numeric box
    local widthBox = MakeNumberBox(widthSlider, widthSlider:GetValue(), 50, 300, function(v)
        widthSlider:SetValue(v)
    end)

    -- Height slider
    local heightSlider = CreateFrame("Slider", AddOn .. "HeightSlider", panel, "OptionsSliderTemplate")
    heightSlider:SetPoint("TOPLEFT", widthSlider, "BOTTOMLEFT", 0, -24)
    heightSlider:SetMinMaxValues(6, 40)
    heightSlider:SetValueStep(1)
    if heightSlider.SetObeyStepOnDrag then heightSlider:SetObeyStepOnDrag(true) end
    local hsText = _G[heightSlider:GetName() .. "Text"]
    if hsText then
        hsText:SetText("Height")
    else
        local hlbl = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        hlbl:SetPoint("BOTTOM", heightSlider, "TOP", 0, 2)
        hlbl:SetText("Height")
    end
    local hsLow  = _G[heightSlider:GetName() .. "Low"];  if hsLow  then hsLow:SetText("6") end
    local hsHigh = _G[heightSlider:GetName() .. "High"]; if hsHigh then hsHigh:SetText("40") end
    heightSlider:SetValue((sv.CastBar and sv.CastBar.Height) or 11)
    heightSlider:SetScript("OnValueChanged", function(self, value)
        sv.CastBar = sv.CastBar or {}
        value = math.floor(value + 0.5)
        sv.CastBar.Height = value
        if heightBox and not heightBox:HasFocus() then heightBox:SetText(tostring(value)) end
        ApplySettings()
    end)

    -- Height numeric box
    local heightBox = MakeNumberBox(heightSlider, heightSlider:GetValue(), 6, 40, function(v)
        heightSlider:SetValue(v)
    end)

    -- X offset slider
    local xSlider = CreateFrame("Slider", AddOn .. "XOffsetSlider", panel, "OptionsSliderTemplate")
    xSlider:SetPoint("TOPLEFT", heightSlider, "BOTTOMLEFT", 0, -24)
    xSlider:SetMinMaxValues(-200, 200)
    xSlider:SetValueStep(1)
    if xSlider.SetObeyStepOnDrag then xSlider:SetObeyStepOnDrag(true) end
    local xsText = _G[xSlider:GetName() .. "Text"]
    if xsText then
        xsText:SetText("X Offset")
    else
        local xlbl = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        xlbl:SetPoint("BOTTOM", xSlider, "TOP", 0, 2)
        xlbl:SetText("X Offset")
    end
    local xsLow  = _G[xSlider:GetName() .. "Low"];  if xsLow  then xsLow:SetText("-200") end
    local xsHigh = _G[xSlider:GetName() .. "High"]; if xsHigh then xsHigh:SetText("200") end
    xSlider:SetValue((sv.CastBar and sv.CastBar.PointX) or 0)
    xSlider:SetScript("OnValueChanged", function(self, value)
        sv.CastBar = sv.CastBar or {}
        value = math.floor(value + 0.5)
        sv.CastBar.PointX = value
        if xBox and not xBox:HasFocus() then xBox:SetText(tostring(value)) end
        ApplySettings()
    end)

    -- X offset numeric box
    local xBox = MakeNumberBox(xSlider, xSlider:GetValue(), -200, 200, function(v)
        xSlider:SetValue(v)
    end)

    -- Y offset slider
    local ySlider = CreateFrame("Slider", AddOn .. "YOffsetSlider", panel, "OptionsSliderTemplate")
    ySlider:SetPoint("TOPLEFT", xSlider, "BOTTOMLEFT", 0, -24)
    ySlider:SetMinMaxValues(-200, 200)
    ySlider:SetValueStep(1)
    if ySlider.SetObeyStepOnDrag then ySlider:SetObeyStepOnDrag(true) end
    local ysText = _G[ySlider:GetName() .. "Text"]
    if ysText then
        ysText:SetText("Y Offset")
    else
        local ylbl = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall")
        ylbl:SetPoint("BOTTOM", ySlider, "TOP", 0, 2)
        ylbl:SetText("Y Offset")
    end
    local ysLow  = _G[ySlider:GetName() .. "Low"];  if ysLow  then ysLow:SetText("-200") end
    local ysHigh = _G[ySlider:GetName() .. "High"]; if ysHigh then ysHigh:SetText("200") end
    ySlider:SetValue((sv.CastBar and sv.CastBar.PointY) or 10)
    ySlider:SetScript("OnValueChanged", function(self, value)
        sv.CastBar = sv.CastBar or {}
        value = math.floor(value + 0.5)
        sv.CastBar.PointY = value
        if yBox and not yBox:HasFocus() then yBox:SetText(tostring(value)) end
        ApplySettings()
    end)

    -- Y offset numeric box
    local yBox = MakeNumberBox(ySlider, ySlider:GetValue(), -200, 200, function(v)
        ySlider:SetValue(v)
    end)

    -- Checkboxes
    local cbIcon = CreateFrame("CheckButton", AddOn .. "EnableIcon", panel, "InterfaceOptionsCheckButtonTemplate")
    cbIcon:SetPoint("TOPLEFT", ySlider, "BOTTOMLEFT", 0, -18)
    _G[cbIcon:GetName() .. "Text"]:SetText("Show Icon")
    cbIcon:SetChecked(sv.Enable and sv.Enable.Icon)
    cbIcon:SetScript("OnClick", function(self)
        sv.Enable = sv.Enable or {}
        sv.Enable.Icon = self:GetChecked()
        ApplySettings()
    end)

    local cbSpell = CreateFrame("CheckButton", AddOn .. "EnableSpell", panel, "InterfaceOptionsCheckButtonTemplate")
    cbSpell:SetPoint("TOPLEFT", cbIcon, "BOTTOMLEFT", 0, -8)
    _G[cbSpell:GetName() .. "Text"]:SetText("Show Spell Name")
    cbSpell:SetChecked(sv.Enable and sv.Enable.Spell)
    cbSpell:SetScript("OnClick", function(self)
        sv.Enable = sv.Enable or {}
        sv.Enable.Spell = self:GetChecked()
        ApplySettings()
    end)

    local cbTimer = CreateFrame("CheckButton", AddOn .. "EnableTimer", panel, "InterfaceOptionsCheckButtonTemplate")
    cbTimer:SetPoint("TOPLEFT", cbSpell, "BOTTOMLEFT", 0, -8)
    _G[cbTimer:GetName() .. "Text"]:SetText("Show Timer")
    cbTimer:SetChecked(sv.Enable and sv.Enable.Timer)
    cbTimer:SetScript("OnClick", function(self)
        sv.Enable = sv.Enable or {}
        sv.Enable.Timer = self:GetChecked()
        ApplySettings()
    end)

    -- Disable fading on non-targets
    local cbNoFade = CreateFrame("CheckButton", AddOn .. "NoFade", panel, "InterfaceOptionsCheckButtonTemplate")
    cbNoFade:SetPoint("TOPLEFT", cbTimer, "BOTTOMLEFT", 0, -8)
    _G[cbNoFade:GetName() .. "Text"]:SetText("Disable fading on non-targets")
    cbNoFade:SetChecked(sv.Enable and sv.Enable.NoFade)
    cbNoFade:SetScript("OnClick", function(self)
        sv.Enable = sv.Enable or {}
        sv.Enable.NoFade = self:GetChecked()
        ApplySettings()
    end)

    -- Timer format dropdown
    local dd = CreateFrame("Frame", AddOn .. "TimerFormatDropDown", panel, "UIDropDownMenuTemplate")
    dd:SetPoint("TOPLEFT", cbNoFade, "BOTTOMLEFT", -15, -26)
    local formats = { "LEFT", "TOTAL", "BOTH" }
    UIDropDownMenu_Initialize(dd, function(self, level)
        local info
        for _, fmt in ipairs(formats) do
            info = UIDropDownMenu_CreateInfo()
            info.text = "Timer: " .. fmt
            info.value = fmt
            info.func = function()
                sv.Timer = sv.Timer or {}
                sv.Timer.Format = fmt
                UIDropDownMenu_SetSelectedValue(dd, fmt)
                UIDropDownMenu_SetText(dd, "Timer: " .. fmt)
                ApplySettings()
            end
            info.checked = (sv.Timer and sv.Timer.Format == fmt)
            UIDropDownMenu_AddButton(info, level)
        end
    end)
    UIDropDownMenu_SetWidth(dd, 140)
    UIDropDownMenu_SetSelectedValue(dd, sv.Timer and sv.Timer.Format or "LEFT")
    UIDropDownMenu_SetText(dd, "Timer: " .. (sv.Timer and sv.Timer.Format or "LEFT"))

    -- Media selections
    local function findMediaText(list, value)
        if not value then return "Custom" end
        local function norm(p)
            return tostring(p):gsub("/", "\\"):lower()
        end
        local nv = norm(value)
        -- Full path, case-insensitive
        for _, item in ipairs(list) do
            if norm(item.value) == nv then
                return item.text
            end
        end
        -- Filename-only fallback match
        local fname = nv:match("([^\\]+)$")
        if fname then
            for _, item in ipairs(list) do
                if norm(item.value):match("([^\\]+)$") == fname then
                    return item.text
                end
            end
        end
        return "Custom"
    end

    local function buildMediaLists()
        -- Build textures list from ALL_TEXTURE_FILES plus Blizzard default
        local textures = {}
        table.insert(textures, { text = "Blizzard (UI-StatusBar)", value = "Interface\\TargetingFrame\\UI-StatusBar" })
        for _, file in ipairs(ALL_TEXTURE_FILES) do
            local name = file:gsub("%.tga$", "")
            table.insert(textures, {
                text = name,
                value = "Interface\\AddOns\\".. AddOn .."\\Textures\\media\\" .. file,
            })
        end
        table.sort(textures, function(a,b) return a.text:lower() < b.text:lower() end)

        -- Build fonts list from ALL_FONT_FILES plus Blizzard default
        local fonts = {}
        local seen = {}
        table.insert(fonts, { text = "Friz Quadrata (default)", value = "Fonts\\FRIZQT__.TTF" })
        for _, file in ipairs(ALL_FONT_FILES) do
            local nameNoExt = file:gsub("%.TTF$", ""):gsub("%.ttf$", "")
            local key = nameNoExt:lower()
            if not seen[key] then
                seen[key] = true
                table.insert(fonts, {
                    text = nameNoExt,
                    value = "Interface\\AddOns\\".. AddOn .."\\Textures\\" .. file,
                })
            end
        end
        table.sort(fonts, function(a,b) return a.text:lower() < b.text:lower() end)

        return textures, fonts
    end

    local mediaTextures, mediaFonts = buildMediaLists()
    -- Forward declarations for pickers so dropdown handlers can toggle them
    local texPicker
    local fontPicker

    -- Scrollable pickers (limit visible rows; add scrollbar)
    local function CreateScrollableList(name, anchorFrame, items, onPick)
        local frame = CreateFrame("Frame", AddOn .. name, panel)
        frame:SetPoint("TOPLEFT", anchorFrame, "BOTTOMLEFT", 0, -4)
        frame:SetSize(260, 210)
        frame:SetFrameStrata("DIALOG")
        frame:SetToplevel(true)
        frame:EnableMouse(true)
        if frame.SetBackdrop then
            frame:SetBackdrop({
                bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
                edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
                tile = true, tileSize = 16, edgeSize = 16,
                insets = { left = 3, right = 3, top = 5, bottom = 3 },
            })
        end
        frame:Hide()

        local ROW_HEIGHT = 18
        local VISIBLE_ROWS = 10

        local scroll = CreateFrame("ScrollFrame", AddOn .. name .. "Scroll", frame, "FauxScrollFrameTemplate")
        scroll:SetPoint("TOPLEFT", 8, -8)
        scroll:SetPoint("BOTTOMRIGHT", -26, 8)
        scroll:EnableMouseWheel(true)
        scroll:SetScript("OnMouseWheel", function(self, delta)
            local sb = _G[self:GetName() .. "ScrollBar"]
            if not sb then return end
            local step = ROW_HEIGHT
            if delta > 0 then
                sb:SetValue(sb:GetValue() - step)
            else
                sb:SetValue(sb:GetValue() + step)
            end
        end)

        -- Also allow scrolling when mouse is over the list frame or rows
        frame:EnableMouseWheel(true)
        frame:SetScript("OnMouseWheel", function(_, delta)
            local sb = _G[scroll:GetName() .. "ScrollBar"]
            if not sb then return end
            local step = ROW_HEIGHT
            if delta > 0 then sb:SetValue(sb:GetValue() - step) else sb:SetValue(sb:GetValue() + step) end
        end)

        local rows = {}
        for i = 1, VISIBLE_ROWS do
            local row = CreateFrame("Button", nil, frame)
            row:SetHeight(ROW_HEIGHT)
            row:SetPoint("TOPLEFT", 12, -8 - (i - 1) * ROW_HEIGHT)
            row:SetPoint("RIGHT", -30, 0)
            row:EnableMouse(true)
            row:RegisterForClicks("LeftButtonUp")
            row.text = row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
            row.text:SetPoint("LEFT", 2, 0)
            row.text:SetJustifyH("LEFT")
            row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
            row:GetHighlightTexture():SetBlendMode("ADD")
            row:SetScript("OnClick", function(self)
                local idx = self.index
                local item = items[idx]
                if item then
                    onPick(item)
                end
                frame:Hide()
            end)
            rows[i] = row
        end

        local function Update()
            local total = #items
            local offset = FauxScrollFrame_GetOffset(scroll)
            for i = 1, VISIBLE_ROWS do
                local idx = i + offset
                local row = rows[i]
                if idx <= total then
                    row.index = idx
                    row.text:SetText(items[idx].text)
                    row:Show()
                else
                    row:Hide()
                end
            end
            FauxScrollFrame_Update(scroll, total, VISIBLE_ROWS, ROW_HEIGHT)
        end

        scroll:SetScript("OnVerticalScroll", function(self, offset)
            FauxScrollFrame_OnVerticalScroll(self, offset, ROW_HEIGHT, Update)
        end)
        scroll:SetScript("OnShow", function()
            Update()
        end)

        -- Ensure dragging the scrollbar updates the rows
        local sb = _G[scroll:GetName() .. "ScrollBar"]
        if sb then
            sb:HookScript("OnValueChanged", function(_, value)
                FauxScrollFrame_OnVerticalScroll(scroll, value, ROW_HEIGHT, Update)
            end)
        end

        -- Up/Down buttons as alternative scrolling controls
        local btnUp = CreateFrame("Button", nil, frame, "UIPanelScrollUpButtonTemplate")
        btnUp:SetPoint("TOPRIGHT", -6, -6)
        btnUp:SetScript("OnClick", function()
            local off = FauxScrollFrame_GetOffset(scroll)
            if off > 0 then
                off = off - 1
                if FauxScrollFrame_SetOffset then
                    FauxScrollFrame_SetOffset(scroll, off)
                end
                local sb = _G[scroll:GetName() .. "ScrollBar"]
                if sb then sb:SetValue(off * ROW_HEIGHT) end
                Update()
            end
        end)

        local btnDown = CreateFrame("Button", nil, frame, "UIPanelScrollDownButtonTemplate")
        btnDown:SetPoint("BOTTOMRIGHT", -6, 6)
        btnDown:SetScript("OnClick", function()
            local total = #items
            local off = FauxScrollFrame_GetOffset(scroll)
            if off + VISIBLE_ROWS < total then
                off = off + 1
                if FauxScrollFrame_SetOffset then
                    FauxScrollFrame_SetOffset(scroll, off)
                end
                local sb = _G[scroll:GetName() .. "ScrollBar"]
                if sb then sb:SetValue(off * ROW_HEIGHT) end
                Update()
            end
        end)

        -- Close button
        local btnClose = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
        btnClose:SetPoint("TOPRIGHT", 0, 0)
        btnClose:SetScript("OnClick", function() frame:Hide() end)

        frame.Update = Update
        return frame
    end

    -- Texture dropdown
    local ddTex = CreateFrame("Frame", AddOn .. "TextureDropDown", panel, "UIDropDownMenuTemplate")
    ddTex:SetPoint("TOPLEFT", dd, "BOTTOMLEFT", 0, -18)
    UIDropDownMenu_Initialize(ddTex, function(self, level)
        local info
        -- Title with current selection
        info = UIDropDownMenu_CreateInfo()
        info.isTitle = true
        info.notCheckable = true
        info.text = "Current: " .. findMediaText(mediaTextures, (sv.Media and sv.Media.Texture) or Textures.CastBar)
        UIDropDownMenu_AddButton(info, level)

        -- Default Blizzard option
        info = UIDropDownMenu_CreateInfo()
        info.text = "Blizzard (UI-StatusBar)"
        info.value = "Interface\\TargetingFrame\\UI-StatusBar"
        info.func = function()
            sv.Media = sv.Media or {}
            sv.Media.Texture = info.value
            UIDropDownMenu_SetText(ddTex, "Texture: Blizzard (UI-StatusBar)")
            ApplySettings()
        end
        info.checked = (sv.Media and sv.Media.Texture == info.value)
        UIDropDownMenu_AddButton(info, level)

        -- Open scrollable browser
        info = UIDropDownMenu_CreateInfo()
        info.text = "Browse..."
        info.notCheckable = true
        info.func = function()
            if texPicker:IsShown() then texPicker:Hide() else texPicker:Show(); texPicker.Update() end
            if CloseDropDownMenus then CloseDropDownMenus() end
        end
        UIDropDownMenu_AddButton(info, level)
    end)
    UIDropDownMenu_SetWidth(ddTex, 200)
    local texVal = (sv.Media and sv.Media.Texture) or Textures.CastBar
    UIDropDownMenu_SetSelectedValue(ddTex, texVal)
    UIDropDownMenu_SetText(ddTex, "Texture: " .. findMediaText(mediaTextures, texVal))

    -- Texture Browse (scrollable)
    texPicker = CreateScrollableList("TexturePicker", ddTex, mediaTextures, function(item)
        sv.Media = sv.Media or {}
        sv.Media.Texture = item.value
        UIDropDownMenu_SetSelectedValue(ddTex, item.value)
        UIDropDownMenu_SetText(ddTex, "Texture: " .. item.text)
        ApplySettings()
    end)
    local btnTexBrowse = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    btnTexBrowse:SetSize(80, 20)
    btnTexBrowse:SetPoint("LEFT", ddTex, "RIGHT", 8, 0)
    btnTexBrowse:SetText("Browse...")
    btnTexBrowse:SetScript("OnClick", function()
        if texPicker:IsShown() then texPicker:Hide() else texPicker:Show(); texPicker.Update() end
        if CloseDropDownMenus then CloseDropDownMenus() end
    end)

    -- Font dropdown
    local ddFont = CreateFrame("Frame", AddOn .. "FontDropDown", panel, "UIDropDownMenuTemplate")
    ddFont:SetPoint("TOPLEFT", ddTex, "BOTTOMLEFT", 0, -18)
    UIDropDownMenu_Initialize(ddFont, function(self, level)
        local info
        -- Title with current selection
        info = UIDropDownMenu_CreateInfo()
        info.isTitle = true
        info.notCheckable = true
        info.text = "Current: " .. findMediaText(mediaFonts, (sv.Media and sv.Media.Font) or Textures.Font)
        UIDropDownMenu_AddButton(info, level)

        -- Default Blizzard option
        info = UIDropDownMenu_CreateInfo()
        info.text = "Friz Quadrata (default)"
        info.value = "Fonts\\FRIZQT__.TTF"
        info.func = function()
            sv.Media = sv.Media or {}
            sv.Media.Font = info.value
            UIDropDownMenu_SetText(ddFont, "Font: Friz Quadrata (default)")
            ApplySettings()
        end
        info.checked = (sv.Media and sv.Media.Font == info.value)
        UIDropDownMenu_AddButton(info, level)

        -- Open scrollable browser
        info = UIDropDownMenu_CreateInfo()
        info.text = "Browse..."
        info.notCheckable = true
        info.func = function()
            if fontPicker:IsShown() then fontPicker:Hide() else fontPicker:Show(); fontPicker.Update() end
            if CloseDropDownMenus then CloseDropDownMenus() end
        end
        UIDropDownMenu_AddButton(info, level)
    end)
    UIDropDownMenu_SetWidth(ddFont, 200)
    local fontVal = (sv.Media and sv.Media.Font) or Textures.Font
    UIDropDownMenu_SetSelectedValue(ddFont, fontVal)
    UIDropDownMenu_SetText(ddFont, "Font: " .. findMediaText(mediaFonts, fontVal))

    -- No-target fade alpha slider (only used when NoFade is OFF)
    local ntSlider = CreateFrame("Slider", AddOn .. "NoTargetAlphaSlider", panel, "OptionsSliderTemplate")
    -- Will be positioned after the text size row
    ntSlider:SetMinMaxValues(0, 1)
    ntSlider:SetValueStep(0.05)
    if ntSlider.SetObeyStepOnDrag then ntSlider:SetObeyStepOnDrag(true) end
    local ntText = _G[ntSlider:GetName() .. "Text"]
    local function SetNTLabel(val)
        if ntText then ntText:SetText("No Target Fade (alpha)") end
        local low  = _G[ntSlider:GetName() .. "Low"];  if low  then low:SetText("0.0") end
        local high = _G[ntSlider:GetName() .. "High"]; if high then high:SetText("1.0") end
    end
    SetNTLabel()
    local function Round2(x) return math.floor(x * 100 + 0.5) / 100 end
    ntSlider:SetValue(((sv.Alpha and sv.Alpha.NoTarget) or 0.5))
    ntSlider:SetScript("OnValueChanged", function(self, value)
        sv.Alpha = sv.Alpha or {}
        sv.Alpha.NoTarget = Round2(value)
        ApplySettings() -- next frame OnUpdate will use the new alpha
    end)

    -- Give the slider a predictable width so text/knob don't collide on 3.3.5a
    ntSlider:SetWidth(220)

    -- Spell Text Size slider
    local spellSizeSlider = CreateFrame("Slider", AddOn .. "SpellSizeSlider", panel, "OptionsSliderTemplate")
    -- Start a new row directly under the Font dropdown
    spellSizeSlider:SetPoint("TOPLEFT", ddFont, "BOTTOMLEFT", 0, -28)
    spellSizeSlider:SetMinMaxValues(6, 18)
    spellSizeSlider:SetValueStep(1)
    if spellSizeSlider.SetObeyStepOnDrag then spellSizeSlider:SetObeyStepOnDrag(true) end
    spellSizeSlider:SetWidth(160)
    local sst = _G[spellSizeSlider:GetName() .. "Text"]; if sst then sst:SetText("Spell Text Size") end
    local ssl = _G[spellSizeSlider:GetName() .. "Low"];  if ssl then ssl:SetText("6") end
    local ssh = _G[spellSizeSlider:GetName() .. "High"]; if ssh then ssh:SetText("18") end
    spellSizeSlider:SetValue((sv.Spell and sv.Spell.Size) or 6)
    spellSizeSlider:SetScript("OnValueChanged", function(self, value)
        sv.Spell = sv.Spell or {}
        sv.Spell.Size = math.floor(value + 0.5)
        if spellSizeBox and not spellSizeBox:HasFocus() then spellSizeBox:SetText(tostring(sv.Spell.Size)) end
        ApplySettings()
    end)
    -- Numeric box for spell size
    local spellSizeBox = MakeNumberBox(spellSizeSlider, spellSizeSlider:GetValue(), 6, 18, function(v)
        spellSizeSlider:SetValue(v)
    end)

    -- Timer Text Size slider
    local timerSizeSlider = CreateFrame("Slider", AddOn .. "TimerSizeSlider", panel, "OptionsSliderTemplate")
    -- place on the same row to the right of the Spell slider's numeric box (dynamic width-safe)
    timerSizeSlider:ClearAllPoints()
    timerSizeSlider:SetPoint("TOPLEFT", spellSizeBox, "RIGHT", 40, 0)
    timerSizeSlider:SetMinMaxValues(6, 18)
    timerSizeSlider:SetValueStep(1)
    if timerSizeSlider.SetObeyStepOnDrag then timerSizeSlider:SetObeyStepOnDrag(true) end
    timerSizeSlider:SetWidth(160)
    local tst = _G[timerSizeSlider:GetName() .. "Text"]; if tst then tst:SetText("Timer Text Size") end
    local tsl = _G[timerSizeSlider:GetName() .. "Low"];  if tsl then tsl:SetText("6") end
    local tsh = _G[timerSizeSlider:GetName() .. "High"]; if tsh then tsh:SetText("18") end
    timerSizeSlider:SetValue((sv.Timer and sv.Timer.Size) or 7)
    timerSizeSlider:SetScript("OnValueChanged", function(self, value)
        sv.Timer = sv.Timer or {}
        sv.Timer.Size = math.floor(value + 0.5)
        if timerSizeBox and not timerSizeBox:HasFocus() then timerSizeBox:SetText(tostring(sv.Timer.Size)) end
        ApplySettings()
    end)
    -- Numeric box for timer size
    local timerSizeBox = MakeNumberBox(timerSizeSlider, timerSizeSlider:GetValue(), 6, 18, function(v)
        timerSizeSlider:SetValue(v)
    end)

    -- Now position the No Target slider as a full row below the size controls
    ntSlider:SetPoint("TOPLEFT", spellSizeSlider, "BOTTOMLEFT", 0, -24)

    -- Font Browse (scrollable)
    fontPicker = CreateScrollableList("FontPicker", ddFont, mediaFonts, function(item)
        sv.Media = sv.Media or {}
        sv.Media.Font = item.value
        UIDropDownMenu_SetSelectedValue(ddFont, item.value)
        UIDropDownMenu_SetText(ddFont, "Font: " .. item.text)
        ApplySettings()
    end)
    local btnFontBrowse = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    btnFontBrowse:SetSize(80, 20)
    -- Place the browse button to the right of the font dropdown
    btnFontBrowse:SetPoint("LEFT", ddFont, "RIGHT", 8, 0)
    btnFontBrowse:SetText("Browse...")
    btnFontBrowse:SetScript("OnClick", function()
        if fontPicker:IsShown() then fontPicker:Hide() else fontPicker:Show(); fontPicker.Update() end
        if CloseDropDownMenus then CloseDropDownMenus() end
    end)

    -- Blizzard media defaults button
    local blizzBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    blizzBtn:SetSize(140, 20)
    blizzBtn:SetPoint("LEFT", btnFontBrowse, "RIGHT", 8, 0)
    blizzBtn:SetText("Blizzard Defaults")
    blizzBtn:SetScript("OnClick", function()
        sv.Media = sv.Media or {}
        sv.Media.Texture = "Interface\\TargetingFrame\\UI-StatusBar"
        sv.Media.Font    = "Fonts\\FRIZQT__.TTF"
        UIDropDownMenu_SetSelectedValue(ddTex, sv.Media.Texture)
        UIDropDownMenu_SetText(ddTex, "Texture: Blizzard (UI-StatusBar)")
        UIDropDownMenu_SetSelectedValue(ddFont, sv.Media.Font)
        UIDropDownMenu_SetText(ddFont, "Font: Friz Quadrata (default)")
        if texPicker then texPicker:Hide() end
        if fontPicker then fontPicker:Hide() end
        ApplySettings()
    end)

    -- Reflow size + alpha controls to a right-side column near the top
    if spellSizeSlider and timerSizeSlider and ntSlider then
        -- Spell size at top-right
        spellSizeSlider:ClearAllPoints()
        spellSizeSlider:SetPoint("TOPLEFT", title, "TOPLEFT", 340, -24)

        -- No Target Fade directly under Spell size
        ntSlider:ClearAllPoints()
        ntSlider:SetPoint("TOPLEFT", spellSizeSlider, "BOTTOMLEFT", 0, -12)
        ntSlider:SetWidth(200)

        -- Timer size under No Target Fade
        timerSizeSlider:ClearAllPoints()
        timerSizeSlider:SetPoint("TOPLEFT", ntSlider, "BOTTOMLEFT", 0, -16)
    end

    -- Reset to defaults button (bottom-left of panel)
    local defaultsBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    defaultsBtn:SetSize(140, 22)
    defaultsBtn:SetPoint("BOTTOMLEFT", 16, 16)
    defaultsBtn:SetText("Reset to Defaults")
    defaultsBtn:SetScript("OnClick", function()
        -- Reset known groups to defaults
        for k, v in pairs(DefaultSV.CastBar) do sv.CastBar[k] = v end
        for k, v in pairs(DefaultSV.Icon)    do sv.Icon[k]    = v end
        for k, v in pairs(DefaultSV.Timer)   do sv.Timer[k]   = v end
        for k, v in pairs(DefaultSV.Spell)   do sv.Spell[k]   = v end
        for k, v in pairs(DefaultSV.Enable)  do sv.Enable[k]  = v end
        for k, v in pairs(DefaultSV.Media)   do sv.Media[k]   = v end
        for k, v in pairs(DefaultSV.Alpha)   do sv.Alpha[k]   = v end
        -- Refresh widgets
        widthSlider:SetValue(sv.CastBar.Width)
        heightSlider:SetValue(sv.CastBar.Height)
        xSlider:SetValue(sv.CastBar.PointX)
        ySlider:SetValue(sv.CastBar.PointY)
        cbIcon:SetChecked(sv.Enable.Icon)
        cbSpell:SetChecked(sv.Enable.Spell)
        cbTimer:SetChecked(sv.Enable.Timer)
        UIDropDownMenu_SetSelectedValue(dd, sv.Timer.Format)
        UIDropDownMenu_SetText(dd, "Timer: " .. sv.Timer.Format)
        UIDropDownMenu_SetSelectedValue(ddTex, sv.Media.Texture)
        UIDropDownMenu_SetText(ddTex, "Texture: " .. findMediaText(mediaTextures, sv.Media.Texture))
        UIDropDownMenu_SetSelectedValue(ddFont, sv.Media.Font)
        UIDropDownMenu_SetText(ddFont, "Font: " .. findMediaText(mediaFonts, sv.Media.Font))
        ntSlider:SetValue(sv.Alpha.NoTarget)
        spellSizeSlider:SetValue(sv.Spell.Size)
        timerSizeSlider:SetValue(sv.Timer.Size)
        ApplySettings()
    end)

    -- Keep advanced sliders (No Target Fade, Spell/Timer Size) stacked under the Font dropdown
    -- so bottom buttons (Reset/Test) stay unobstructed on smaller screens.

    -- Test mode button (bottom row next to Reset)
    local testBtn = CreateFrame("Button", nil, panel, "UIPanelButtonTemplate")
    testBtn:SetSize(140, 22)
    testBtn:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 170, 16)
    local function UpdateTestBtnText()
        testBtn:SetText((sv.Enable and sv.Enable.Test) and "Stop Test" or "Start Test")
    end
    UpdateTestBtnText()
    testBtn:SetScript("OnClick", function()
        sv.Enable = sv.Enable or {}
        sv.Enable.Test = not sv.Enable.Test
        UpdateTestBtnText()
        ApplySettings()
        if sv.Enable.Test then
            DEFAULT_CHAT_FRAME:AddMessage("PlateCastBarFixed: Test mode ON")
            for unit, CastBar in pairs(castbarsByUnit) do
                CastBar:Show()
            end
        else
            DEFAULT_CHAT_FRAME:AddMessage("PlateCastBarFixed: Test mode OFF")
            for unit, CastBar in pairs(castbarsByUnit) do
                if not UnitCastingInfo(unit) and not UnitChannelInfo(unit) then
                    CastBar:Hide()
                end
            end
        end
    end)

    panel:SetScript("OnShow", nil)
end)

InterfaceOptions_AddCategory(Options)

---------------------------------------------------------------------
-- 8) Slash command to open options and toggle test mode
---------------------------------------------------------------------
SLASH_PLATECASTBAR1 = "/pcb"
SlashCmdList["PLATECASTBARFIXED"] = function(msg)
    if type(msg) == "string" and msg:lower():find("test") then
        local sv = _G[AddOn .. "_SavedVariables"]
        sv.Enable = sv.Enable or {}
        sv.Enable.Test = not sv.Enable.Test
        DEFAULT_CHAT_FRAME:AddMessage("PlateCastBarFixed: Test mode " .. (sv.Enable.Test and "ON" or "OFF"))
        -- Re-apply layout and fade settings immediately
        if ApplySettings then ApplySettings() end
    end
    InterfaceOptionsFrame_OpenToCategory(Options)
    InterfaceOptionsFrame_OpenToCategory(Options)
end
---------------------------------------------------------------------
-- 9) OnUpdate to keep updating times
---------------------------------------------------------------------
Frame:SetScript("OnUpdate", function(self, elapsed)
    local sv = _G[AddOn .. "_SavedVariables"]
    local testOn = sv.Enable and sv.Enable.Test
    for unit, CastBar in pairs(castbarsByUnit) do
        if testOn or CastBar:IsShown() then
            if sv.Enable and sv.Enable.NoFade then
                if CastBar.SetIgnoreParentAlpha then CastBar:SetIgnoreParentAlpha(true) end
                CastBar:SetAlpha(1)
                -- Ensure effective scale matches owner while detached
                SyncToOwnerScale(CastBar)
            else
                if CastBar.SetIgnoreParentAlpha then CastBar:SetIgnoreParentAlpha(false) end
                local parent = CastBar:GetParent()
                local parentAlpha = parent and parent:GetAlpha() or 1
                -- When no target selected, still fade all to configured alpha (if NoFade is OFF)
                if not UnitExists("target") then
                    local ntAlpha = (sv.Alpha and sv.Alpha.NoTarget) or 0.5
                    CastBar:SetAlpha(ntAlpha)
                else
                    CastBar:SetAlpha(parentAlpha)
                end
                -- Reset scale to inherit from parent
                if CastBar:GetScale() ~= 1 then
                    CastBar:SetScale(1)
                end
            end
            if testOn then
                UpdateTestCast(unit)
            else
                local isChannel = (UnitChannelInfo(unit) ~= nil)
                UpdateCastBar(unit, isChannel)
            end
        end
    end
end)