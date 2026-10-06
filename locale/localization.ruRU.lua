local _, COM = ...

if GetLocale() ~= "ruRU" then return end

local L = COM.Localization

-- Options

L["options.general"] = "Общие параметры"
L["options.general.minimap-button.name"] = "Кнопка у мини-карты"
L["options.general.minimap-button.tooltip"] = "Если этот параметр включен, кнопка отображается у мини-карты."
L["options.general.debug-mode.name"] = "Режим отладки"
L["options.general.debug-mode.tooltip"] = "Если режим отладки включен, в чате отображается дополнительная информация."

L["options.quality-of-life"] = "Удобство игры"
L["options.quality-of-life.section.interface"] = "Интерфейс"
L["options.quality-of-life.section.merchant"] = "Действия у торговцев"
L["options.quality-of-life.military-time.name"] = "24-часовой формат времени"
L["options.quality-of-life.military-time.tooltip"] = "Использует 24-часовой формат для отображения игрового времени."
L["options.quality-of-life.watched-faction.name"] = "Автоотслеживание репутации"
L["options.quality-of-life.watched-faction.tooltip"] = "Автоматически включает отслеживание фракции, репутация с которой изменилась."
L["options.quality-of-life.hide-loot-toasts.name"] = "Скрывать уведомления о добыче"
L["options.quality-of-life.hide-loot-toasts.tooltip"] = "Позволяет отдельно скрывать обычные уведомления о получении предметов, денег и валют персонажа."
L["options.quality-of-life.hide-loot-toasts.item.name"] = "Предметы"
L["options.quality-of-life.hide-loot-toasts.item.tooltip"] = "Скрывает обычные уведомления о получении предметов."
L["options.quality-of-life.hide-loot-toasts.money.name"] = "Деньги"
L["options.quality-of-life.hide-loot-toasts.money.tooltip"] = "Скрывает обычные уведомления о получении денег."
L["options.quality-of-life.hide-loot-toasts.currency.name"] = "Валюты"
L["options.quality-of-life.hide-loot-toasts.currency.tooltip"] = "Скрывает обычные уведомления о получении валют персонажа."
L["options.quality-of-life.auto-repair.name"] = "Автоматический ремонт"
L["options.quality-of-life.auto-repair.tooltip"] = "Автоматически ремонтирует повреждённые предметы за личные средства при открытии окна торговца, предоставляющего ремонт."
L["options.quality-of-life.auto-sell.name"] = "Продавать отмеченные предметы"
L["options.quality-of-life.auto-sell.tooltip"] = "Автоматически продаёт все экземпляры отмеченных предметов при открытии окна торговца. Чтобы поставить или снять отметку, щёлкните по предмету в сумке правой кнопкой мыши, удерживая выбранную клавишу-модификатор. Отметки предметов всегда сохраняются отдельно для каждого персонажа."

L["options.auto-sell.marking-modifier.name"] = "Клавиша-модификатор"
L["options.auto-sell.marking-modifier.tooltip"] = "Выберите клавишу, которая вместе с правой кнопкой мыши ставит или снимает отметку предмета. По умолчанию используется Alt, поскольку эта клавиша реже вызывает конфликты. Ctrl и Shift также могут выполнять стандартные действия World of Warcraft."
L["options.auto-sell.poor.name"] = "Продавать предметы низкого качества"
L["options.auto-sell.poor.tooltip"] = "Автоматически продаёт все предметы низкого качества (серые) при открытии окна торговца. Этот параметр работает независимо от продажи предметов, отмеченных вручную."

-- General

L["minimap-button.tooltip"] = "|cnLINK_FONT_COLOR:Щелкните правой кнопкой мыши|r, чтобы открыть настройки."

-- Chat

L["auto-repair.chat.repaired"] = "Все предметы автоматически отремонтированы за %s."
L["auto-repair.chat.insufficient-funds"] = "Не удалось автоматически отремонтировать предметы: недостаточно денег."
L["auto-sell.chat.marked"] = "%s теперь будет продаваться автоматически."
L["auto-sell.chat.unmarked"] = "%s больше не будет продаваться автоматически."
L["auto-sell.chat.cannot-mark"] = "%s нельзя отметить для автоматической продажи: торговцы не покупают этот предмет."
L["auto-sell.chat.sold-one"] = "Автоматически продан 1 предмет за %s."
L["auto-sell.chat.sold-many"] = "Автоматически продано предметов: %d. Выручено: %s."

-- Quality of Life

L["auto-sell.tooltip.marked"] = "Отмечено для автоматической продажи. %s + правая кнопка мыши: снять отметку."
L["auto-sell.tooltip.unmarked"] = "%s + правая кнопка мыши: отметить для автоматической продажи."
L["auto-sell.marking-modifier.alt"] = "Alt"
L["auto-sell.marking-modifier.ctrl"] = "Ctrl"
L["auto-sell.marking-modifier.shift"] = "Shift"
