if engine.ActiveGamemode() ~= "terrortown" then return end

if SERVER then
	local cvReviveDistance = CreateConVar("ttt_defibrillator_dist", "100", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	local cvReviveBraindead = CreateConVar("ttt_defibrillator_ignore_braindead", "0", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	local cvPlaySounds = CreateConVar("ttt_defibrillator_play_sounds", "1", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	local cvReviveTime = CreateConVar("ttt_defibrillator_revive_time", "3.0", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	local cvErrorTime = CreateConVar("ttt_defibrillator_error_time", "1.4", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
	local cvChance = CreateConVar("ttt_defibrillator_success_chance", "75", {FCVAR_NOTIFY, FCVAR_ARCHIVE})
end
