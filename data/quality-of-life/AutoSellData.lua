local _, COM = ...

if COM.State and COM.State.libraryIncompatible then return end

local inventoryConstants = Constants and Constants.InventoryConstants
local numBagSlots = (inventoryConstants and inventoryConstants.NumBagSlots) or rawget(_G, "NUM_BAG_FRAMES")
local numReagentBagSlots = (inventoryConstants and inventoryConstants.NumReagentBagSlots) or rawget(_G, "NUM_REAGENTBAG_FRAMES") or 0

COM.AUTO_SELL_FIRST_BAG_ID = Enum.BagIndex.Backpack
COM.AUTO_SELL_LAST_BAG_ID = COM.AUTO_SELL_FIRST_BAG_ID
	+ (numBagSlots and numBagSlots + numReagentBagSlots or 0)
COM.AUTO_SELL_BUYBACK_TAB_ID = 2
COM.AUTO_SELL_DELAY = 0.1
COM.AUTO_SELL_CONFIRMATION_ATTEMPTS = 3
COM.AUTO_SELL_DEFAULT_MARKING_MODIFIER = COM.OPTIONS_DEFAULTS["quality-of-life"]["auto-sell-marking-modifier"]
