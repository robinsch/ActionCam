local addonName = ...

local defaults = {
    cameraActionAngle = 4.0,
    cameraActionAngleMin = 0.0,
    cameraActionAngleMax = 6.00,
    cameraActionDist = 1.25,
    cameraActionDistMin = 0.25,
    cameraActionDistMax = 2.00,
    cameraActionZ = 0.05,
    cameraActionZMin = -1.25,
    cameraActionZMax = 0.75,
    cameraActionMaxPitch = 0.20,
    cameraActionMaxPitchMin = 0.0,
    cameraActionMaxPitchMax = 1.55,
    cameraActionMinPitch = -0.05,
    cameraActionMinPitchMin = -1.55,
    cameraActionMinPitchMax = 0,
    cameraTargetFocusTurnSpeed = 3.15,
    cameraTargetFocusTurnSpeedMin = 0.5,
    cameraTargetFocusTurnSpeedMax = 16.5,
}

-- @robinsch: Option Panel
ActionCamPanelOptions = {
    ActionCam = { text = "Enable Action Camera" },
    AC_CameraAngle = { text = "Camera Angle", minValue = defaults.cameraActionAngle, minValue = defaults.cameraActionAngleMin, maxValue = defaults.cameraActionAngleMax, valueStep = 0.0025, },
    AC_CameraDist = { text = "Camera Distance", minValue = defaults.cameraActionDist, minValue = defaults.cameraActionDistMin, maxValue = defaults.cameraActionDistMax, valueStep = 0.0025, },
    AC_CameraZ = { text = "Camera Height", minValue = defaults.cameraActionZ, minValue = defaults.cameraActionZMin, maxValue = defaults.cameraActionZMax, valueStep = 0.0025, },
    AC_CameraMaxPitch = { text = "Camera Floor Pitch", minValue = defaults.cameraActionMaxPitch, minValue = defaults.cameraActionMaxPitchMin, maxValue = defaults.cameraActionMaxPitchMax, valueStep = 0.0025, },
    AC_CameraMinPitch = { text = "Camera Ceiling Pitch", minValue = defaults.cameraActionMinPitch, minValue = defaults.cameraActionMinPitchMin, maxValue = defaults.cameraActionMinPitchMax, valueStep = 0.0025, },
    AC_CameraTargetFocusTurnSpeed = { text = "Camera Turn Speed", minValue = defaults.cameraTargetFocusTurnSpeed, minValue = defaults.cameraTargetFocusTurnSpeedMin, maxValue = defaults.cameraTargetFocusTurnSpeedMax, valueStep = 0.0025, },
    
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
    elseif cvar == "AC_CameraTargetFocusTurnSpeed" then
        SetCVar("cameraTargetFocusTurnSpeed", ActionCamOptionsDB["AC_CameraTargetFocusTurnSpeed"])
    end
end

function ActionCamOptions_OnLoad(self)
    self:RegisterEvent("ADDON_LOADED")
    self.name = addonName
    self.options = ActionCamPanelOptions
end

function ActionCamOptions_OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addon = ...
        if addon == addonName then
            InterfaceOptionsPanel_OnLoad(self)

            ActionCamOptionsDB = ActionCamOptionsDB or {
                AC_CameraAngle = defaults.cameraActionAngle,
                AC_CameraDist = defaults.cameraActionDist,
                AC_CameraZ = defaults.cameraActionZ,
                AC_CameraMaxPitch = defaults.cameraMaxPitch,
                AC_CameraMinPitch = defaults.cameraMinPitch,
                AC_CameraTargetFocusTurnSpeed = defaults.cameraTargetFocusTurnSpeed,
            }

            ActionCamOptions_Load()
        end
    end
end

function ActionCamOptions_Load()
    RegisterCVar("AC_CameraAngle", ActionCamOptionsDB.AC_CameraAngle)
    RegisterCVar("AC_CameraDist", ActionCamOptionsDB.AC_CameraDist)
    RegisterCVar("AC_CameraZ", ActionCamOptionsDB.AC_CameraZ)
    RegisterCVar("AC_CameraMaxPitch", ActionCamOptionsDB.AC_CameraMaxPitch)
    RegisterCVar("AC_CameraMinPitch", ActionCamOptionsDB.AC_CameraMinPitch)
    RegisterCVar("AC_CameraTargetFocusTurnSpeed", ActionCamOptionsDB.AC_CameraTargetFocusTurnSpeed)

    ActionCamOptions_UpdateSettings("AC_CameraAngle", ActionCamOptionsDB.AC_CameraAngle)
    ActionCamOptions_UpdateSettings("AC_CameraDist", ActionCamOptionsDB.AC_CameraDist)
    ActionCamOptions_UpdateSettings("AC_CameraZ", ActionCamOptionsDB.AC_CameraZ)
    ActionCamOptions_UpdateSettings("AC_CameraMaxPitch", ActionCamOptionsDB.AC_CameraMaxPitch)
    ActionCamOptions_UpdateSettings("AC_CameraMinPitch", ActionCamOptionsDB.AC_CameraMinPitch)
    ActionCamOptions_UpdateSettings("AC_CameraTargetFocusTurnSpeed", ActionCamOptionsDB.AC_CameraTargetFocusTurnSpeed)
end

function ActionCamOptions_Reset()
    ActionCamOptions_UpdateSettings("AC_CameraAngle", defaults.cameraActionAngle)
    ActionCamOptions_UpdateSettings("AC_CameraDist", defaults.cameraActionDist)
    ActionCamOptions_UpdateSettings("AC_CameraZ", defaults.cameraActionZ)
    ActionCamOptions_UpdateSettings("AC_CameraMaxPitch", defaults.cameraMaxPitch)
    ActionCamOptions_UpdateSettings("AC_CameraMinPitch", defaults.cameraMinPitch)
    ActionCamOptions_UpdateSettings("AC_CameraTargetFocusTurnSpeed", defaults.cameraTargetFocusTurnSpeed)

    SetCVar("cameraActionHeadBobs", "0")
    SetCVar("cameraTargetFocusInteractEnable", "0")
    SetCVar("cameraTargetFocusEnemyEnable", "1")
end
