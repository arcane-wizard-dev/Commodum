local _, COM = ...

if COM.State and COM.State.libraryIncompatible then return end

COM.UIConfig.AutoSell = {
	tooltipIcon = "|TInterface\\MoneyFrame\\UI-GoldIcon:14:14:0:0|t"
}
