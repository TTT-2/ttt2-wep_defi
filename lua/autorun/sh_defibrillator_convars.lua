if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
	CreateConVar("ttt_defibrillator_distance", "100", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	CreateConVar("ttt_defibrillator_revive_braindead", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	CreateConVar("ttt_defibrillator_play_sounds", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	CreateConVar("ttt_defibrillator_revive_time", "3.0", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	CreateConVar("ttt_defibrillator_error_time", "1.5", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	CreateConVar("ttt_defibrillator_success_chance", "75", {FCVAR_NOTIFY, FCVAR_ARCHIVE})

	hook.Add("TTTUlxInitCustomCVar", "ttt2_defibrillator_replicate_convars", function(name)
		ULib.replicatedWritableCvar(
			"ttt_defibrillator_distance",
			"rep_ttt_defibrillator_distance",
			GetConVar("ttt_defibrillator_distance"):GetInt(),
			true, false, name
		)

		ULib.replicatedWritableCvar(
			"ttt_defibrillator_revive_braindead",
			"rep_ttt_defibrillator_revive_braindead",
			GetConVar("ttt_defibrillator_revive_braindead"):GetBool(),
			true, false, name
		)

		ULib.replicatedWritableCvar(
			"ttt_defibrillator_play_sounds",
			"rep_ttt_defibrillator_play_sounds",
			GetConVar("ttt_defibrillator_play_sounds"):GetBool(),
			true, false, name
		)

		ULib.replicatedWritableCvar(
			"ttt_defibrillator_revive_time",
			"rep_ttt_defibrillator_revive_time",
			GetConVar("ttt_defibrillator_revive_time"):GetFloat(),
			true, false, name
		)

		ULib.replicatedWritableCvar(
			"ttt_defibrillator_error_time",
			"rep_ttt_defibrillator_error_time",
			GetConVar("ttt_defibrillator_error_time"):GetFloat(),
			true, false, name
		)

		ULib.replicatedWritableCvar(
			"ttt_defibrillator_success_chance",
			"rep_ttt_defibrillator_success_chance",
			GetConVar("ttt_defibrillator_success_chance"):GetInt(),
			true, false, name
		)
	end)
end

if CLIENT then
	hook.Add("TTTUlxModifyAddonSettings", "ttt2_defibrillator_add_to_ulx", function(name)
		local tttrspnl = xlib.makelistlayout{w = 415, h = 318, parent = xgui.null}

		-- Basic Settings
		local tttrsclp = vgui.Create("DCollapsibleCategory", tttrspnl)
		tttrsclp:SetSize(390, 140)
		tttrsclp:SetExpanded(1)
		tttrsclp:SetLabel("Basic Settings")

		local tttrslst = vgui.Create("DPanelList", tttrsclp)
		tttrslst:SetPos(5, 25)
		tttrslst:SetSize(390, 140)
		tttrslst:SetSpacing(5)

		tttrslst:AddItem(xlib.makeslider{
			label = "ttt_defibrillator_distance (def. 100)",
			repconvar = "rep_ttt_defibrillator_distance",
			min = 0,
			max = 250,
			decimal = 0,
			parent = tttrslst
		})

		tttrslst:AddItem(xlib.makeslider{
			label = "ttt_defibrillator_success_chance (def. 75)",
			repconvar = "rep_ttt_defibrillator_success_chance",
			min = 0,
			max = 100,
			decimal = 0,
			parent = tttrslst
		})

		tttrslst:AddItem(xlib.makeslider{
			label = "ttt_defibrillator_revive_time (def. 3.0)",
			repconvar = "rep_ttt_defibrillator_revive_time",
			min = 0,
			max = 15,
			decimal = 1,
			parent = tttrslst
		})

		tttrslst:AddItem(xlib.makeslider{
			label = "ttt_defibrillator_error_time (def. 1.5)",
			repconvar = "rep_ttt_defibrillator_error_time",
			min = 0,
			max = 15,
			decimal = 1,
			parent = tttrslst
		})

		tttrslst:AddItem(xlib.makecheckbox{
			label = "ttt_defibrillator_revive_braindead (def. 0)",
			repconvar = "rep_ttt_defibrillator_revive_braindead",
			parent = tttrslst
		})

		tttrslst:AddItem(xlib.makecheckbox{
			label = "ttt_defibrillator_play_sounds (def. 1)",
			repconvar = "rep_ttt_defibrillator_play_sounds",
			parent = tttrslst
		})

		-- add to ULX
		xgui.hookEvent("onProcessModules", nil, tttrspnl.processModules)
		xgui.addSubModule("Defibrillator", tttrspnl, nil, name)
	end)
end
