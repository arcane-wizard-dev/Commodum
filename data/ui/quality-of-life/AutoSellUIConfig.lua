local _, COM = ...

if COM.State and COM.State.libraryIncompatible then return end

COM.UIConfig.AutoSell = {
	markedColor = {1, 0.82, 0},
	unmarkedColor = {0.53, 0.81, 0.98},
	tooltipIcon = "|TInterface\\MoneyFrame\\UI-GoldIcon:14:14:0:0|t"
}
