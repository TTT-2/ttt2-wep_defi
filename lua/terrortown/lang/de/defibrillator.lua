local L = LANG.GetLanguageTableReference("de")

L["weapon_defi_name"] = "Defibrillator"
L["weapon_defi_desc"] = "Ein hochenergetisches Gerät zum Wiederbeleben anderer Spieler."
L["revived_by_player"] = "Du wirst von {name} wiederbelebt. Halte dich bereit!"
L["defi_hold_key_to_revive"] = "Halte [{key}] um Spieler wiederzubeleben"
L["defi_revive_progress"] = "Zeit übrig: {time}s"
L["defi_charging"] = "Defibrillator lädt sich auf, bitte warten"
L["defi_player_already_reviving"] = "Dieser Spieler wird bereits wiederbelebt"
L["defi_error_braindead"] = "Du kannst keinen hirntoten Spieler wiederbeleben."
L["defi_error_no_space"] = "Es ist nicht genügend Platz vorhanden um den Spieler wiederzubeleben."
L["defi_error_too_fast"] = "Defibrillator lädt sich auf. Bitte warten."
L["defi_error_lost_target"] = "Du hast dein Ziel verloren. Bitte versuche es erneut."
L["defi_error_no_valid_ply"] = "Du kannst diesen Spieler nicht wiederbeleben, da er nicht länger valide ist."
L["defi_error_already_reviving"] = "Du kannst diesen Spieler nicht wiederbeleben, da er bereits wiederbelebt wird."
L["defi_error_failed"] = "Wiederbeleben fehlgeschlagen. Bitte versuche es erneut."
L["defi_error_player_alive"] = "Du kannst diesen Spieler nicht wiederbeleben, da dieser noch am Leben ist."
L["defi_error_player_disconnected"] = "Du kannst diesen Spieler nicht wiederbeleben, da er das Spiel verlassen hat."

L["label_defibrillator_play_sounds"] = "Aktiviere Geräusche bei Wiederbelebung"
L["label_defibrillator_revive_braindead"] = "Aktiviere das Wiederbeleben von hirntoten Spielern"
L["label_defibrillator_distance"] = "Maximale Entfernung für Wiederbelebung"
L["label_defibrillator_success_chance"] = "Chance für erfolgreiche Wiederbelebung"
L["label_defibrillator_revive_time"] = "Dauer der Wiederbelebung"
L["label_defibrillator_error_time"] = "Pause nach Fehlschlag"

L["help_defibrillator_revive_braindead"] = "Ein hirntoter Spieler ist ein Spieler, der durch einen Kopfschuss getötet wurde. Wenn diese Einstellung deaktiviert ist, dann kann ein solcher Spieler nicht mit dem Defibrillator wiederbelebt werden."
L["help_defibrillator_time"] = [[
Es gibt zwei Variablen für die Zeiteinstellungen des Defibrillators. Die erste stellt ein, wie lange es dauert eine Wiederbelebung durchzuführen. Die zweite steht für die Pausenzeit nach einem fehlgeschlagenen Versuch, bevor es erneut probiert werden kann.

Beide Werte sind in Sekunden.]]
