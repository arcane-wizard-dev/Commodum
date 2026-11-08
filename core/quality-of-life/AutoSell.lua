local addonName, COM = ...

if COM.State and COM.State.libraryIncompatible then return end

-- Localization
local L = COM.Localization

-- Current module
local QualityOfLife = COM.Modules.QualityOfLife

-- Module imports
local Utils = COM.Modules.Utils
local AutoSellConfig = COM.UIConfig.AutoSell

-- Variables
local saleSession = nil

-----------------------
--- Local Functions ---
-----------------------

local function GetPressedModifier()
	local pressedModifier = nil

	if IsAltKeyDown() then
		pressedModifier = "ALT"
	end

	if IsControlKeyDown() then
		if pressedModifier then
			return nil
		end

		pressedModifier = "CTRL"
	end

	if IsShiftKeyDown() then
		if pressedModifier then
			return nil
		end

		pressedModifier = "SHIFT"
	end

	return pressedModifier
end

local function GetItemSellPrice(containerInfo)
	if not containerInfo or containerInfo.hasNoValue then
		return 0
	end

	return select(11, C_Item.GetItemInfo(containerInfo.hyperlink or containerInfo.itemID)) or 0
end

local function IsMerchantAvailable()
	return MerchantFrame and MerchantFrame:IsShown() and MerchantFrame.selectedTab ~= COM.AUTO_SELL_BUYBACK_TAB_ID
end

local function ResetSaleState()
	local session = saleSession
	saleSession = nil

	if session and session.timer then
		session.timer:Cancel()
	end
end

local function ScheduleSaleStep(session, delay, callback)
	if saleSession ~= session then
		return
	end

	session.timer = C_Timer.NewTimer(delay, function()
		if saleSession ~= session then
			return
		end

		session.timer = nil
		callback()
	end)
end

local function FinishSelling(session)
	ResetSaleState()

	if session.soldItemCount == 1 then
		Utils:PrintMessage(L["auto-sell.chat.sold-one"]:format(GetMoneyString(session.soldValue)))
	elseif session.soldItemCount > 1 then
		Utils:PrintMessage(L["auto-sell.chat.sold-many"]:format(session.soldItemCount, GetMoneyString(session.soldValue)))
	end
end

------------------------
--- Module Functions ---
------------------------

function QualityOfLife:GetMarkedItems()
	return COM.Data.autoSell
end

function QualityOfLife:IsItemMarked(itemID)
	return itemID and self:GetMarkedItems()[itemID] == true
end

function QualityOfLife:IsItemSellable(containerInfo)
	return GetItemSellPrice(containerInfo) > 0
end

function QualityOfLife:GetMarkingModifier()
	local modifier = COM.Settings.qualityOfLife["auto-sell-marking-modifier"]

	if modifier ~= "ALT" and modifier ~= "CTRL" and modifier ~= "SHIFT" then
		return COM.AUTO_SELL_DEFAULT_MARKING_MODIFIER
	end

	return modifier
end

function QualityOfLife:GetMarkingModifierLabel()
	return L["auto-sell.marking-modifier." .. self:GetMarkingModifier():lower()]
end

function QualityOfLife:IsMarkingModifierDown()
	return GetPressedModifier() == self:GetMarkingModifier()
end

function QualityOfLife:IsAnyAutomaticSellingEnabled()
	return COM.Settings.qualityOfLife["auto-sell"] or COM.Settings.qualityOfLife["auto-sell-poor"]
end

function QualityOfLife:ShouldSellItem(containerInfo)
	if not containerInfo then
		return false
	end

	local sellMarkedItem = COM.Settings.qualityOfLife["auto-sell"] and self:IsItemMarked(containerInfo.itemID)
	local sellPoorItem = COM.Settings.qualityOfLife["auto-sell-poor"] and containerInfo.quality == Enum.ItemQuality.Poor

	return sellMarkedItem or sellPoorItem
end

function QualityOfLife:AddButtonTooltip(button)
	if not COM.Settings.qualityOfLife["auto-sell"] or GameTooltip:GetOwner() ~= button then
		return
	end

	local containerInfo = C_Container.GetContainerItemInfo(button:GetBagID(), button:GetID())

	if not self:IsItemSellable(containerInfo) then
		return
	end

	if self:IsItemMarked(containerInfo.itemID) then
		local itemNameLine = _G[GameTooltip:GetName() .. "TextLeft1"]
		local itemName = itemNameLine and itemNameLine:GetText()

		if itemName and not itemName:find(AutoSellConfig.tooltipIcon, 1, true) then
			itemNameLine:SetText(itemName .. " " .. AutoSellConfig.tooltipIcon)
		end

		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["auto-sell.tooltip.marked"]:format(self:GetMarkingModifierLabel()), unpack(AutoSellConfig.markedColor))
	else
		GameTooltip:AddLine(" ")
		GameTooltip:AddLine(L["auto-sell.tooltip.unmarked"]:format(self:GetMarkingModifierLabel()), unpack(AutoSellConfig.unmarkedColor))
	end

	GameTooltip:Show()
end

function QualityOfLife:OnModifiedItemClick(button, mouseButton)
	if not COM.Settings.qualityOfLife["auto-sell"]
		or mouseButton ~= "RightButton"
		or not self:IsMarkingModifierDown()
	then
		return
	end

	local containerInfo = C_Container.GetContainerItemInfo(button:GetBagID(), button:GetID())

	if not containerInfo or not containerInfo.itemID then
		return
	end

	if not self:IsItemSellable(containerInfo) then
		Utils:PrintMessage(L["auto-sell.chat.cannot-mark"]:format(containerInfo.hyperlink or containerInfo.itemName))

		return
	end

	local markedItems = self:GetMarkedItems()
	local itemID = containerInfo.itemID

	if markedItems[itemID] then
		markedItems[itemID] = nil
		Utils:PrintMessage(L["auto-sell.chat.unmarked"]:format(containerInfo.hyperlink))
	else
		markedItems[itemID] = true
		Utils:PrintMessage(L["auto-sell.chat.marked"]:format(containerInfo.hyperlink))
	end

	if GameTooltip:GetOwner() == button then
		button:OnUpdate()
	end
end

function QualityOfLife:TryInitializeContainerHooks()
	if self.containerHooksInitialized or not ContainerFrameItemButtonMixin then
		return
	end

	hooksecurefunc(ContainerFrameItemButtonMixin, "OnModifiedClick", function(button, mouseButton)
		QualityOfLife:OnModifiedItemClick(button, mouseButton)
	end)

	hooksecurefunc(ContainerFrameItemButtonMixin, "OnUpdate", function(button)
		QualityOfLife:AddButtonTooltip(button)
	end)

	self.containerHooksInitialized = true
end

function QualityOfLife:ProcessNextSale()
	local session = saleSession
	if not session or not self:IsAnyAutomaticSellingEnabled() or not IsMerchantAvailable() then
		ResetSaleState()

		return
	end

	local entry = session.queue[session.queueIndex]

	if not entry then
		FinishSelling(session)

		return
	end

	session.queueIndex = session.queueIndex + 1

	local containerInfo = C_Container.GetContainerItemInfo(entry.bagID, entry.slotID)
	local sellPrice = 0

	if containerInfo
		and containerInfo.itemID == entry.itemID
		and not containerInfo.isLocked
		and self:ShouldSellItem(containerInfo)
	then
		sellPrice = GetItemSellPrice(containerInfo)
	end

	if not containerInfo or sellPrice <= 0 then
		ScheduleSaleStep(session, 0, function()
			QualityOfLife:ProcessNextSale()
		end)

		return
	end

	session.pendingSale = {
		bagID = entry.bagID,
		slotID = entry.slotID,
		itemID = entry.itemID,
		stackCount = containerInfo.stackCount,
		sellPrice = sellPrice,
		confirmationAttempts = 0
	}

	C_Container.UseContainerItem(entry.bagID, entry.slotID)

	ScheduleSaleStep(session, COM.AUTO_SELL_DELAY, function()
		QualityOfLife:ConfirmPendingSale()
	end)
end

function QualityOfLife:ConfirmPendingSale()
	local session = saleSession
	local pendingSale = session and session.pendingSale
	if not session or not pendingSale then
		return
	end

	local containerInfo = C_Container.GetContainerItemInfo(pendingSale.bagID, pendingSale.slotID)
	local remainingCount = 0

	if containerInfo and containerInfo.itemID == pendingSale.itemID then
		remainingCount = containerInfo.stackCount
	end

	local soldCount = math.max(pendingSale.stackCount - remainingCount, 0)

	if soldCount == 0 and pendingSale.confirmationAttempts < COM.AUTO_SELL_CONFIRMATION_ATTEMPTS then
		pendingSale.confirmationAttempts = pendingSale.confirmationAttempts + 1

		ScheduleSaleStep(session, COM.AUTO_SELL_DELAY, function()
			QualityOfLife:ConfirmPendingSale()
		end)

		return
	end

	if soldCount > 0 then
		session.soldItemCount = session.soldItemCount + soldCount
		session.soldValue = session.soldValue + pendingSale.sellPrice * soldCount
	end

	session.pendingSale = nil
	self:ProcessNextSale()
end

function QualityOfLife:BuildSaleQueue()
	local saleQueue = {}

	for bagID = COM.AUTO_SELL_FIRST_BAG_ID, COM.AUTO_SELL_LAST_BAG_ID do
		for slotID = 1, C_Container.GetContainerNumSlots(bagID) do
			local containerInfo = C_Container.GetContainerItemInfo(bagID, slotID)

			if self:ShouldSellItem(containerInfo) then
				table.insert(saleQueue, {
					bagID = bagID,
					slotID = slotID,
					itemID = containerInfo.itemID
				})
			end
		end
	end

	return saleQueue
end

function QualityOfLife:StartAutoSell()
	ResetSaleState()

	if not self:IsAnyAutomaticSellingEnabled() then
		return
	end

	local saleQueue = self:BuildSaleQueue()

	if #saleQueue == 0 then
		return
	end

	local session = {
		queue = saleQueue,
		queueIndex = 1,
		soldItemCount = 0,
		soldValue = 0
	}
	saleSession = session

	ScheduleSaleStep(session, COM.AUTO_SELL_DELAY, function()
		QualityOfLife:ProcessNextSale()
	end)
end

function QualityOfLife:StopAutoSell()
	ResetSaleState()
end

function QualityOfLife:InitializeAutoSell()
	self:TryInitializeContainerHooks()
end
