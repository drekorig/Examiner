-- This updated talents and glyphs module was made by eusi.

local ex = Examiner;

-- Module
local mod = ex:CreateModule("Talents",TALENTS);
mod.help = "Talents and Glyphs";
mod:CreatePage(false,"Talents and Glyphs");
mod:HasButton(true);

local talents = {};
local glyphs = {};
local spec, role;
local RoleIcon = {
	[1] = {32/64, 48/64, 16/64, 32/64}, -- HEALER
	[2] = {48/64, 64/64,  0/64, 16/64}, -- TANK
	[3] = {32/64, 48/64,  0/64, 16/64}, -- DAMAGER
	[4] = {48/64, 64/64, 16/64, 32/64}, -- UNKNOWN / FAIL-SCAN
};

--------------------------------------------------------------------------------------------------------
--                                           Module Scripts                                           --
--------------------------------------------------------------------------------------------------------

-- OnInspectReady
function mod:OnInspectReady(unit)
	self:HasData(true);
	self:UpdateSpecRoleTalentsGlyphs();
end

-- OnClearInspect
function mod:OnClearInspect()
	self:HasData(nil);
end

--------------------------------------------------------------------------------------------------------
--                                                Code                                                --
--------------------------------------------------------------------------------------------------------

function mod:UpdateSpecRoleTalentsGlyphs()
	local unit = ex.unit;

	local numTalents = GetNumTalents(1);
	--Talents

	-- Talents
	for talentIndex = 1, numTalents do
		talents[talentIndex] = tal;
		local _, _, classID = UnitClass(INSPECTED_UNIT);

		local tal = talents[talentIndex];
		tal.missing = nil;
		tal.icon:SetTexture(iconTexture);

		 if ( selected ) then
			tal.icon.border:SetVertexColor(1,1,1);
			tal.icon:SetAlpha(1);
			SetDesaturation(tal.icon, false);
			tal.icon.border:Show();
		else
			tal.icon:SetAlpha(0.6);
			SetDesaturation(tal.icon, true);
			tal.icon.border:Hide();
		end

		tal:Show();
	end

end

--------------------------------------------------------------------------------------------------------
--                                          Widget Creation                                           --
--------------------------------------------------------------------------------------------------------


local tal = CreateFrame("Button",nil,mod.page);
local numTalents = GetNumTalents(1);
-- Talents
for talentIndex = 1, numTalents do

	tal:SetWidth(32);
	tal:SetHeight(32);
	tal:SetScript("OnClick",ex.ItemButton_OnClick);
	tal:SetScript("OnEnter",ex.ItemButton_OnEnter);
	tal:SetScript("OnLeave",ex.ItemButton_OnLeave);

	tal.icon = tal:CreateTexture(nil,"ARTWORK");
	tal.icon:SetAllPoints();
	tal.icon:SetTexture("Interface\Icons\INV_Misc_QuestionMark");

	tal.icon.border = tal:CreateTexture(nil,"OVERLAY");
	tal.icon.border:SetTexture("Interface\Addons\Examiner\Textures\Border");
	tal.icon.border:SetWidth(34);
	tal.icon.border:SetHeight(34);

	tal.level = tal:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
	tal.level:SetPoint("BOTTOM",0,2);
	tal.level:SetTextColor(1,1,1);
	tal.level:SetFont(GameFontNormal:GetFont(),10,"OUTLINE");

	if (talentIndex == 1) then
		tal:SetPoint("TOPLEFT",28,-47);
		tal.icon.border:SetPoint("TOPLEFT",0,0);
	elseif (talentIndex == 4 or talentIndex == 7 or talentIndex == 10 or talentIndex == 13 or talentIndex == 16) then
		tal:SetPoint("BOTTOM",talents[talentIndex - 3],"BOTTOM",0,-40);
		tal.icon.border:SetPoint("BOTTOM",talents[talentIndex - 3],"BOTTOM",0,-42);
	else
		tal:SetPoint("RIGHT",talents[talentIndex - 1],"RIGHT",40,0);
		tal.icon.border:SetPoint("RIGHT",talents[talentIndex - 1],"RIGHT",40,0);
	end
end

-- Spec
spec = mod.page:CreateFontString(nil,"ARTWORK","GameFontHighlightSmall");
spec:SetPoint("TOPLEFT",27,-32);

-- Role
role = CreateFrame("Button",nil,mod.page);
role:SetToplevel(true);
role:SetWidth(20);
role:SetHeight(20);
role:SetPoint("TOPLEFT",8,-11);
role.icon = role:CreateTexture(nil,"ARTWORK");
role.icon:SetAllPoints();
role.icon:SetTexture("Interface\Addons\Examiner\Textures\Role-Icons.tga");