if SERVER then
	AddCSLuaFile()

	resource.AddFile("")
end

local DEFI_IDLE = 0
local DEFI_BUSY = 1
local DEFI_ERROR = 2

local DEFI_ERROR_BRAINDEAD = 0
local DEFI_ERROR_NO_SPACE = 1
local DEFI_ERROR_TOO_FAST = 2
local DEFI_ERROR_LOST_TARGET = 3
local DEFI_ERROR_NO_VALID_PLY = 4

local sounds = {
	empty = Sound("Weapon_SMG1.Empty"),
	beep = Sound("buttons/button17.wav"),
	hum = "items/nvg_on.wav",
	zap = Sound("ambient/energy/zap7.wav"),
	revived = Sound("items/smallmedkit1.wav")
}

SWEP.Base = "weapon_tttbase"

if CLIENT then
	SWEP.ViewModelFOV = 78
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFlip = false

	SWEP.EquipMenuData = {
		type = "item_weapon",
		name = "weapon_defi_name",
		desc = "weapon_defi_desc"
	}

	SWEP.Icon = "vgui/ttt/icon_defibrillator"
end

SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/v_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"

SWEP.AutoSpawnable = false
SWEP.NoSights = true

SWEP.HoldType = "pistol"
SWEP.LimitedStock = true

SWEP.Primary.Recoil = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 1
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Recoil = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Delay = 0.5

SWEP.Charge = 0
SWEP.Timer = -1

if SERVER then
	function SWEP:SetState(state)
		self.defiState = state or DEFI_IDLE
	end

	function SWEP:IsState(state)
		return not self.defiState or self.defiState == state or false
	end

	function SWEP:GetState()
		return self.defiState or DEFI_IDLE
	end

	function SWEP:Reset()
		self:SetState(DEFI_IDLE)

		self.defiTarget = nil
		self.defiBone = nil
		self.defiStart = 0

		self.defiTimer = nil
	end

	function SWEP:Error(type)
		self:SetState(DEFI_ERROR)
		self:StopSound("hum")
		self:PlaySound("beep")

		self.defiTarget = nil
		self.defiTimer = "defi_reset_timer_" .. self:EntIndex()

		if timer.Exists(self.defiTimer) then return end

		timer.Create(self.defiTimer, GetConVar("ttt_defibrillator_error_time"):GetFloat(), 1, function()
			if not IsValid(self) then return end

			self:Reset()
		end)
	end

	function SWEP:BeginRevival(ragdoll, bone)
		local ply = CORPSE.GetPlayer(ragdoll)

		if not IsValid(ply) then
			self:Error(DEFI_ERROR_NO_VALID_PLY)

			return
		end

		self:SetState(DEFI_BUSY)
		self:SetStartTime(CurTime())
		self:PlaySound("hum")

		-- start revival
		ply:Revive(
			GetConVar("ttt_defibrillator_revive_time"):GetFloat(),
			nil,
			nil,
			true,
			false
		)
		ply:SetRevivalReason("revived_by_player", {name = self:GetOwner():Nick()})

		self.defiTarget = ragdoll
		self.defiBone = bone
	end

	function SWEP:FinishRevival()
		self:PlaySound("zap")

		if math.random(0, 1000) > GetConVar("ttt_defibrillator_success_chance"):GetInt() then
			self:CancelRevival()

			return
		end

		self:Reset()
		self:PlaySound("revived")

		--self:Remove()
		--RunConsoleCommand("lastinv")
	end

	function SWEP:CancelRevival()
		local ply = CORPSE.GetPlayer(self.defiTarget)

		self:Reset()
		print("cancel revival 1")

		if not IsValid(ply) then return end

		print("cancel revival")

		ply:CancelRevival()
		ply:SetRevivalReason(nil)
	end

	function SWEP:StopSound(soundName)
		if not GetConVar("ttt_defibrillator_play_sounds"):GetBool() then return end

		self:GetOwner():StopSound(sounds[soundName])
	end

	function SWEP:PlaySound(soundName)
		if not GetConVar("ttt_defibrillator_play_sounds"):GetBool() then return end

		self:GetOwner():EmitSound(sounds[soundName])
	end

	function SWEP:GetStartTime()
		return self.defiStartTime or 0
	end

	function SWEP:SetStartTime(time)
		self.defiStartTime = time
	end

	function SWEP:Think()
		if self:GetState() ~= DEFI_BUSY then return end

		local owner = self:GetOwner()

		if CurTime() >= self:GetStartTime() + GetConVar("ttt_defibrillator_revive_time"):GetFloat() - 0.01 then
			self:FinishRevival()
		elseif not owner:KeyDown(IN_ATTACK) or owner:GetEyeTrace(MASK_SHOT_HULL).Entity ~= self.defiTarget then
			self:CancelRevival()
			self:Error(DEFI_ERROR_LOST_TARGET)
		end
	end

	function SWEP:PrimaryAttack()
		local owner = self:GetOwner()

		local trace = owner:GetEyeTrace(MASK_SHOT_HULL)
		local distance = trace.HitPos:Distance(owner:GetPos())
		local ent = trace.Entity

		local spawnPoint = spawn.MakeSpawnPointSafe(ent:GetPos())

		if distance > GetConVar("ttt_defibrillator_dist"):GetInt()
			or not IsValid(ent) or ent:GetClass() ~= "prop_ragdoll"
			or not CORPSE.IsValidBody(ent)
		then
			self:PlaySound("empty")

			return
		end

		if not self:IsState(DEFI_IDLE) then
			self:Error(DEFI_ERROR_TOO_FAST)

			return
		end

		if CORPSE.WasHeadshot(ent) and not GetConVar("ttt_defibrillator_ignore_braindead"):GetBool() then
			self:Error(DEFI_ERROR_BRAINDEAD)
		elseif not spawnPoint then
			self:Error(DEFI_ERROR_NO_SPACE)
		else
			self:BeginRevival(ent, trace.PhysicsBone)
		end
	end
end

-- do not play sound when swep is empty
function SWEP:DryFire()
	return false
end
