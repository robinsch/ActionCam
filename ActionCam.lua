local addonName = ...

local defaults = {
	cameraActionAngle = 4.0,
    cameraActionAngleMin = 0.0,
    cameraActionAngleMax = 6.00,
	cameraActionDist = 1.25,
    cameraActionDistMin = 0.0,
    cameraActionDistMax = 10.00,
	cameraActionZ = 0.05,
    cameraActionZMin = -1.25,
    cameraActionZMax = 0.75,
	cameraActionMaxPitch = 0.20,
    cameraActionMaxPitchMin = 0.0,
    cameraActionMaxPitchMax = 1.55,
	cameraActionMinPitch = -0.05,
    cameraActionMinPitchMin = -1.55,
    cameraActionMinPitchMax = 0,
}

RegisterCVar("AC_CameraAngle", defaults.cameraActionAngle)
RegisterCVar("AC_CameraDist", defaults.cameraActionDist)
RegisterCVar("AC_CameraZ", defaults.cameraActionZ)
RegisterCVar("AC_CameraMaxPitch", defaults.cameraActionMaxPitch)
RegisterCVar("AC_CameraMinPitch", defaults.cameraActionMinPitch)

-- @robinsch: Option Panel
ActionCamPanelOptions = {
	ActionCam = { text = "Enable Action Camera" },
    AC_CameraAngle = { text = "Camera Angle", minValue = defaults.cameraActionAngle, minValue = defaults.cameraActionAngleMin, maxValue = defaults.cameraActionAngleMax, valueStep = 0.0025, },
	AC_CameraDist = { text = "Camera Distance", minValue = defaults.cameraActionDist, minValue = defaults.cameraActionDistMin, maxValue = defaults.cameraActionDistMax, valueStep = 0.0025, },
	AC_CameraZ = { text = "Camera Height", minValue = defaults.cameraActionZ, minValue = defaults.cameraActionZMin, maxValue = defaults.cameraActionZMax, valueStep = 0.0025, },
	AC_CameraMaxPitch = { text = "Camera Floor Pitch", minValue = defaults.cameraActionMaxPitch, minValue = defaults.cameraActionMaxPitchMin, maxValue = defaults.cameraActionMaxPitchMax, valueStep = 0.0025, },
	AC_CameraMinPitch = { text = "Camera Ceiling Pitch", minValue = defaults.cameraActionMinPitch, minValue = defaults.cameraActionMinPitchMin, maxValue = defaults.cameraActionMinPitchMax, valueStep = 0.0025, },
	cameraTargetFocusInteractEnable = { text = "Focus Interact" },
	cameraTargetFocusEnemyEnable = { text = "Focus Enemy" },
	cameraActionHeadBobs = { text = "Camera Bob" },
}

function ActionCamOptions_UpdateSettings(cvar, value)
	ActionCamOptionsDB[cvar] = value

	if cvar == "AC_CameraAngle" then
		SetCVar("cameraActionAngle", ActionCamOptionsDB["AC_CameraAngle"])
	elseif cvar == "AC_CameraDist" then
		SetCVar("cameraActionDist", ActionCamOptionsDB["AC_CameraDist"])
	elseif cvar == "AC_CameraZ" then
		SetCVar("cameraActionZ", ActionCamOptionsDB["AC_CameraZ"])
	elseif cvar == "AC_CameraMaxPitch" then
		SetCVar("cameraActionMaxPitch", ActionCamOptionsDB["AC_CameraMaxPitch"])
	elseif cvar == "AC_CameraMinPitch" then
		SetCVar("cameraActionMinPitch", ActionCamOptionsDB["AC_CameraMinPitch"])
	end
end

function ActionCamOptions_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED")
	self.name = addonName;
	self.options = ActionCamPanelOptions;
end

function ActionCamOptions_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local addon = ...
		if addon == addonName then
			InterfaceOptionsPanel_OnLoad(self);

			ActionCamOptionsDB = ActionCamOptionsDB or {
				AC_CameraAngle = defaults.cameraActionAngle,
				AC_CameraDist = defaults.cameraActionDist,
				AC_CameraZ = defaults.cameraActionZ,
				AC_CameraMaxPitch = defaults.cameraMaxPitch,
				AC_CameraMinPitch = defaults.cameraMinPitch,
			}
		end
	end
end
