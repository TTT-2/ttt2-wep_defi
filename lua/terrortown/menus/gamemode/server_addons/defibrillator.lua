
CLGAMEMODESUBMENU.base = "base_gamemodesubmenu"

CLGAMEMODESUBMENU.priority = 0
CLGAMEMODESUBMENU.title = "submenu_server_addons_defibrillator_title"

function CLGAMEMODESUBMENU:Populate(parent)
	local form = vgui.CreateTTT2Form(parent, "header_server_addons_defibrillator")

	form:MakeCheckBox({
		label = "label_defibrillator_play_sounds",
		serverConvar = "ttt_defibrillator_play_sounds"
	})

	form:MakeCheckBox({
		label = "label_defibrillator_revive_braindead",
		serverConvar = "ttt_defibrillator_revive_braindead"
	})

	form:MakeSlider({
		label = "label_defibrillator_distance",
		serverConvar = "ttt_defibrillator_distance",
		min = 0,
		max = 250,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_defibrillator_success_chance",
		serverConvar = "ttt_defibrillator_success_chance",
		min = 0,
		max = 100,
		decimal = 0
	})

	form:MakeSlider({
		label = "label_defibrillator_revive_time",
		serverConvar = "ttt_defibrillator_revive_time",
		min = 0,
		max = 15,
		decimal = 1
	})

	form:MakeSlider({
		label = "label_defibrillator_error_time",
		serverConvar = "ttt_defibrillator_error_time",
		min = 0,
		max = 15,
		decimal = 1
	})
end
