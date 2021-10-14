local L = LANG.GetLanguageTableReference("en")

L["weapon_defi_name"] = "Defibrillator"
L["weapon_defi_desc"] = "A high energy device to revive other players."
L["revived_by_player"] = "You are revived by {name}. Prepare yourself!"
L["defi_hold_key_to_revive"] = "Hold [{key}] to revive player"
L["defi_revive_progress"] = "Time left: {time}s"
L["defi_charging"] = "Defibrillator is recharging, please wait"
L["defi_player_already_reviving"] = "Player is already reviving"
L["defi_error_braindead"] = "You can't revive a braindead player."
L["defi_error_no_space"] = "There is insufficient room available for this revival attempt."
L["defi_error_too_fast"] = "Defibrillator is recharging. Please wait."
L["defi_error_lost_target"] = "You lost your target. Please try again."
L["defi_error_no_valid_ply"] = "You can't revive this player since they are no longer valid."
L["defi_error_already_reviving"] = "You can't revive this player since they are already reviving."
L["defi_error_failed"] = "Revival attempt failed. Please try again."
L["defi_error_player_alive"] = "You can't revive this player since they are already alive."

L["submenu_server_addons_defibrillator_title"] = "Defibrillator"
L["header_server_addons_defibrillator"] = "General Settings"

L["label_defibrillator_play_sounds"] = "Enable defibrillator making sounds while reviving"
L["label_defibrillator_revive_braindead"] = "Enable reviving of braindead players"
L["label_defibrillator_distance"] = "Maximum distance for revival"
L["label_defibrillator_success_chance"] "Chance the revival is a success"
L["label_defibrillator_revive_time"] "Time it takes for revival"
L["label_defibrillator_error_time"] = "Timeout after failed revival"

L["help_defibrillator_revive_braindead"] = "A baindead player is a player that got killed by a headshot. If this setting is disabled, they can not be revived with this defibrillator."
L["help_defibrillator_time"] = [[
There are two variables for timing the defibrillator. One sets the time it takes for the revival to happen. The other time is the timeout after a failed revival attempt until it can be tried again.

Both values are in seconds.]]
