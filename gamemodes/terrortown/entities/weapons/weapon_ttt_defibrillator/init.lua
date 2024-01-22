if SERVER then
	AddCSLuaFile()
	AddCSLuaFile("shared.lua")

	resource.AddFile("materials/gui/ttt/icon_defibrillator.vmt")

	local flags = {FCVAR_NOTIFY, FCVAR_ARCHIVE}
	CreateConVar("ttt_defibrillator_distance", "100", flags)
	CreateConVar("ttt_defibrillator_revive_braindead", "0", flags)
	CreateConVar("ttt_defibrillator_play_sounds", "1", flags)
	CreateConVar("ttt_defibrillator_revive_time", "3.0", flags)
	CreateConVar("ttt_defibrillator_error_time", "1.5", flags)
	CreateConVar("ttt_defibrillator_success_chance", "75", flags)
	CreateConVar("ttt_defibrillator_reset_confirm", "0", flags)

	include("shared.lua")
end
