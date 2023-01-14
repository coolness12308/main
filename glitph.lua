  if not getgenv().Reanimated then
    getgenv().Reanimated = true
    spawn(function()
    if getgenv().NetLoop then
      getgenv().NetLoop:Disconnect()
      wait()
    end

    getgenv().NetLoop = game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
    settings().Physics.AllowSleep = false
    settings().Physics.DisableCSGv2 = true
    workspace.FallenPartsDestroyHeight = -math.huge / -math.huge
    sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.random(600, 800))
    end)
    end)

    local plr = game.Players.LocalPlayer
    local oldchar = plr.Character.Parent[plr.Name]
    local oldPos = plr.Character.HumanoidRootPart.Position

    oldchar:BreakJoints()

    addedconnect = plr.CharacterAdded:Connect(function(addedchar)
    spawn(function()
    repeat wait()
      addedchar:MoveTo(oldPos)
    until addedchar:WaitForChild("Animate").Disabled == true
    end)
    addedchar:WaitForChild("Animate").Disabled = true
    addedchar:WaitForChild("Humanoid"):ChangeState("Physics")
    addedconnect:Disconnect()
    end)

    plr.CharacterAppearanceLoaded:Wait()
    wait(.1)
    oldchar = plr.Character.Parent[plr.Name]
    oldchar.Archivable = true

    local hatname = {}
    for _, v in next, oldchar:GetChildren() do
      if v:IsA("Accessory") then
        if hatname[v.Name] then
          if hatname[v.Name] == "s" then
            hatname[v.Name] = {}
          end
          table.insert(hatname[v.Name], v)
        else
          hatname[v.Name] = "s"
        end
      end
    end

    for _, v in pairs(hatname) do
      if type(v) == "table" then
        local num = 1
        for _, w in pairs(v) do
          w.Name = w.Name .. num
          num = num + 1
        end
      end
    end

    local newchar = oldchar:Clone()
    newchar.Name = "LUNAR " .. newchar.Name
    oldchar.Archivable = false
    local addedconnect
    local mainloop
    local noclip1
    local noclip2
    local removing
    local removing2
    local died
    local died2
    newchar.Parent = workspace
    local Neck = oldchar:WaitForChild("Torso").Neck
    local targetNeck = newchar:WaitForChild("Torso").Neck

    noclip1 = game:GetService("RunService").Stepped:Connect(function()
    for i, v in pairs(oldchar:GetChildren()) do
      if v:IsA("BasePart") or v:IsA("Part") or v:IsA("MeshPart") then
        v.CanCollide = false
        v.CanTouch = false
        v.CanQuery = false
      elseif v:IsA("Accessory") then
        v.Handle.CanCollide = false
        v.Handle.CanTouch = false
        v.Handle.CanQuery = false
      end
    end
    end)

    noclip2 = game:GetService("RunService").RenderStepped:Connect(function()
    for i, v in pairs(newchar:GetChildren()) do
      if v:IsA("BasePart") or v:IsA("Part") or v:IsA("MeshPart") then
        v.CanCollide = false
        v.CanTouch = false
        v.CanQuery = false
      elseif v:IsA("Accessory") then
        v.Handle.CanCollide = false
        v.Handle.CanTouch = false
        v.Handle.CanQuery = false
      end
    end
    end)

    for i, v in pairs(oldchar["Torso"]:GetChildren()) do
      if v:IsA("Motor6D") and v.Name ~= "Neck" then
        v:Destroy()
      end
    end

    function CreateVar()
      local ABC = math.random(1, 2)
      local FullValue = "0." .. "0" .. ABC
      return tonumber(FullValue)
    end

    local Unit = function(vel, clamp)
    local vel = vel
    local x, y, z =
    math.clamp(vel.X, -clamp, clamp),
    math.clamp(vel.Y, -clamp, clamp),
    math.clamp(vel.Z, -clamp, clamp)
    vel = Vector3.new(x, y, z).Unit
    return vel
  end

  function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end

  local LastPosition = newchar.PrimaryPart.Position

  Neck.MaxVelocity = math.huge
  Neck.CurrentAngle = targetNeck.CurrentAngle

  oldchar["HumanoidRootPart"]:Destroy()
  mainloop = game:GetService("RunService").Heartbeat:Connect(function()
  pcall(function()
  local ping = (round(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue(), 0))
  local antiSleepCF = CFrame.new( 0+0.08*math.sin(os.clock()*1.5), 0, 0+0.08*math.cos(os.clock()*1.5) )
  if Neck and targetNeck then
    local headdirct =
    newchar.HumanoidRootPart.CFrame:ToObjectSpace(newchar.Head.CFrame).RightVector
    Neck.MaxVelocity = math.huge
    Neck.DesiredAngle = targetNeck.CurrentAngle
    Neck.CurrentAngle = targetNeck.CurrentAngle
    for i, v in pairs(oldchar:GetChildren()) do
      if v:IsA("BasePart") or v:IsA("Part") then
        if isnetworkowner(v) then
          if not newchar:FindFirstChild("FlingPart") then
            if v.Name ~= "Head" then
              v.Velocity = Unit(newchar[v.Name].Velocity, 500) * 500
            elseif v.Name == "Torso" then
              v.Velocity = Unit(newchar[v.Name].Velocity, 35) * 35
            end
            v.CFrame = newchar[v.Name].CFrame * antiSleepCF
          else
            if v.Name ~= "Head" then
              v.Velocity = Unit(newchar[v.Name].Velocity, 500) * 500
            elseif v.Name == "Torso" then
              v.Velocity = Unit(newchar[v.Name].Velocity, 35) * 35
            end
            if v.Name ~= "Left Leg" then
              v.CFrame = newchar[v.Name].CFrame * antiSleepCF
            elseif v.Name == "Left Leg" then
              v.CFrame = newchar[v.Name].CFrame * antiSleepCF
              v.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
              if newchar:FindFirstChild("Fling6D", true).Part0.Parent ~= newchar then
                if newchar:FindFirstChild("Fling6D", true).Part0.Velocity.Magnitude > 1 then
                  v.CFrame = CFrame.new((newchar:FindFirstChild("Fling6D", true).Part0.Position + newchar:FindFirstChild("Fling6D", true).Part0.Velocity * (ping / 350)) + Vector3.new(0+math.random(-0.5, 2)*math.cos(os.clock()*25), 0+math.random(-0.5, 2)*math.sin(os.clock()*20), 0+math.random(-0.5, 2)*math.cos(os.clock()*25))) * antiSleepCF * CFrame.Angles( math.rad( math.random(90, 180) ), math.rad( math.random(90, 180) ), math.rad( math.random(90, 180) ) )
                else
                  v.CFrame = CFrame.new((newchar:FindFirstChild("Fling6D", true).Part0.Position + Vector3.new(0+math.random(-0.5, 2)*math.cos(os.clock()*25), 0+math.random(-0.5, 2)*math.sin(os.clock()*20), 0+math.random(-0.5, 2)*math.cos(os.clock()*25)))) * antiSleepCF * CFrame.Angles( math.rad( math.random(90, 180) ), math.rad( math.random(90, 180) ), math.rad( math.random(90, 180) ) )
                end
              else
                v.CFrame = newchar["Left Leg"].CFrame * antiSleepCF
              end
            end
          end
        end
      elseif v:IsA("Accessory") then
        if not newchar[v.Name]:FindFirstChild("AccessoryWeld", true) then
          if v.Handle:FindFirstChild("AccessoryWeld") then
            v.Handle:FindFirstChild("AccessoryWeld"):Destroy()
          end
        end
        if not newchar[v.Name]:FindFirstChild("SpecialMesh", true) then
          if v.Handle:FindFirstChild("SpecialMesh") then
            v.Handle:FindFirstChild("SpecialMesh"):Destroy()
          end
        end
        if not newchar[v.Name]:FindFirstChild("Mesh", true) then
          if v.Handle:FindFirstChild("Mesh") then
            v.Handle:FindFirstChild("Mesh"):Destroy()
          end
        end
        if isnetworkowner(v.Handle) then
          v.Handle.CFrame = newchar[v.Name].Handle.CFrame * antiSleepCF
          v.Handle.Velocity = Unit(newchar[v.Name].Handle.Velocity, 500) * 500
        end
      end
    end
  else
    mainloop:Disconnect()
  end
  end)
  end)

  workspace.CurrentCamera.CameraSubject = newchar.Humanoid
  newchar:MoveTo(oldPos)
  oldchar.Parent = newchar
  plr.Character = newchar
  for _, accessory in pairs(newchar:GetDescendants()) do
    if accessory:IsA("ForceField") then
      accessory:Destroy()
    end
    if not accessory:IsDescendantOf(oldchar) then
      pcall(function()
      accessory.Transparency = 1
      end)
    end
  end

  removing = newchar.Parent.ChildRemoved:Connect(function(child)
  if child == newchar then
    mainloop:Disconnect()
    noclip1:Disconnect()
    noclip2:Disconnect()
    removing:Disconnect()
    removing2:Disconnect()
    died:Disconnect()
    died2:Disconnect()
    plr.Character = oldchar
    oldchar.Parent = workspace
    oldchar:BreakJoints()
    getgenv().Reanimated = false
  end
  end)

  removing2 = oldchar.Parent.ChildRemoved:Connect(function(child)
  if child == oldchar then
    mainloop:Disconnect()
    noclip1:Disconnect()
    noclip2:Disconnect()
    removing:Disconnect()
    removing2:Disconnect()
    died:Disconnect()
    died2:Disconnect()
    newchar:Destroy()
    getgenv().Reanimated = false
  end
  end)

  died = newchar.Humanoid.Died:Connect(function()
  mainloop:Disconnect()
  noclip1:Disconnect()
  noclip2:Disconnect()
  removing:Disconnect()
  removing2:Disconnect()
  died:Disconnect()
  died2:Disconnect()
  plr.Character = oldchar
  oldchar.Parent = workspace
  newchar:Destroy()
  oldchar:BreakJoints()
  getgenv().Reanimated = false
  end)

  died2 = oldchar.Humanoid.Died:Connect(function()
  mainloop:Disconnect()
  noclip1:Disconnect()
  noclip2:Disconnect()
  removing:Disconnect()
  removing2:Disconnect()
  died:Disconnect()
  died2:Disconnect()
  plr.Character = oldchar
  oldchar.Parent = workspace
  newchar:Destroy()
  oldchar:BreakJoints()
  getgenv().Reanimated = false
  end)
  task.wait()
  wait(1)
  if getgenv().AnimationTemplateRunning then
    getgenv().AnimationTemplateRunning = false
    wait()
  end

  getgenv().AnimationTemplateRunning = true

  local Loops = {}

  local Attack = false
  local Taunting = false

  local WalkSpeed = 16

  local KeyPressCheck
  local KeyReleaseCheck
  local State

  local LookVel
  local RightVel
  local SideVel

  local CF = {n = CFrame.new, a = CFrame.Angles}
  local rad = math.rad

  local EasingStyles = Enum.EasingStyle
  local EasingDirs = Enum.EasingDirection

  local function sin(N)
    return math.sin(os.clock()*N)
  end

  local function cos(N)
    return math.cos(os.clock()*N)
  end

  local Services = {RunService = game:GetService("RunService"), UserInputService = game:GetService("UserInputService"),TweenService = game:GetService("TweenService"), Debris = game:GetService("Debris")}

  local Player = game:GetService("Players").LocalPlayer
  local Mouse = Player:GetMouse()

  local Character = workspace.CurrentCamera.CameraSubject.Parent

  if Character:FindFirstChild("FlingPart", true) then
    Character:FindFirstChild("FlingPart", true):Destroy()
    wait()
  end

  local Humanoid = Character:FindFirstChildOfClass("Humanoid")
  local RootPart = Character.HumanoidRootPart
  local Torso = Character.Torso

  local RaycastParams = RaycastParams.new()
  RaycastParams.FilterDescendantsInstances = {Character}
  RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist

  local Motors = {
    RootJoint = {
      ["Motor"] = RootPart.RootJoint,
      ["C0"] =  CFrame.new(0,0,0);
      ["C1"] =  CFrame.new(0,0,0);
    };
    ["Left Shoulder"] = {
      ["Motor"] = Torso["Left Shoulder"];
      ["C0"] =  CFrame.new(-1.5,0.5,0);
      ["C1"] =  CFrame.new(0,0.5,0);
    };
    ["Right Shoulder"] = {
      ["Motor"] = Torso["Right Shoulder"];
      ["C0"] =  CFrame.new(1.5,0.5,0);
      ["C1"] =  CFrame.new(0,0.5,0);
    };
    ["Left Hip"] = {
      ["Motor"] = (Torso["Left Hip"] or RootPart["Left Hip"]);
      ["C0"] =  CFrame.new(-0.5,-1,0);
      ["C1"] =  CFrame.new(0,1,0);
    };
    ["Right Hip"] = {
      ["Motor"] = (Torso["Right Hip"] or RootPart["Right Hip"]);
      ["C0"] =  CFrame.new(0.5,-1,0);
      ["C1"] =  CFrame.new(0,1,0);
    };
  }

  for _,v in pairs(Character:GetDescendants()) do
    if v:IsA("Motor6D") then
      if Motors[v.Name] and v.Name ~= "Neck" then
        if string.find(string.lower(v.Part1.Name), "leg") then
          v.Part0 = RootPart
        end
        v.Parent = v.Parent
        v.C0 = Motors[v.Name]["C0"]
        v.C1 = Motors[v.Name]["C1"]
      end
    end
  end

  local MotorNames = {
    ["HEAD"] = Character.Torso.Neck;
    ["TRSO"] = Character.HumanoidRootPart.RootJoint;
    ["LA"] = Character.Torso["Left Shoulder"];
    ["RA"] = Character.Torso["Right Shoulder"];
    ["LL"] = Character.Torso["Left Hip"];
    ["RL"] = Character.Torso["Right Hip"];
  }

  local function AddHatToRig(MotorName, Hat, AlignTo, RemoveMesh)
    if Hat:FindFirstChild("AccessoryWeld") then
      Hat:FindFirstChild("AccessoryWeld"):Destroy()
    end

    if RemoveMesh and Hat:FindFirstChild("SpecialMesh") then
      Hat:FindFirstChild("SpecialMesh"):Destroy()
    end

    if RemoveMesh and Hat:FindFirstChild("Mesh") then
      Hat:FindFirstChild("Mesh"):Destroy()
    end

    local NewMotor = Instance.new("Motor6D")
    NewMotor.Parent = AlignTo
    NewMotor.Part0 = AlignTo
    NewMotor.Part1 = Hat

    if Hat.Name == "FlingPart" then
      NewMotor.Name = "Fling6D"
    end

    MotorNames[MotorName] = NewMotor
  end

  if Character:FindFirstChild("PartsFolder") then
    Character:FindFirstChild("PartsFolder"):Destroy()
  end

  local function NewPart(Name,Parent,Anchored,CanCollide,Size,CF,Transparency)
    local PartsFolder

    if not Character:FindFirstChild("PartsFolder") then
      PartsFolder = Instance.new("Folder")
      PartsFolder.Parent = Character
      PartsFolder.Name = "PartsFolder"
    else
      PartsFolder = Character.PartsFolder
    end

    local Part = Instance.new("Part")
    Part.Parent = Parent or PartsFolder
    Part.Name = Name
    Part.Anchored = Anchored
    Part.CanCollide = CanCollide
    Part.Size = Size
    Part.CFrame = CF or CFrame.new()
    Part.Transparency = Transparency
    return Part
  end

  local function NewWeld(Part0,Part1,CFrame,Angles)
    local Weld = Instance.new("Weld")
    Weld.Parent = Part0
    Weld.Part0 = Part0
    Weld.Part1 = Part1
    Weld.C0 = CFrame or CFrame.new()
    Weld.C1 = Angles or CFrame.Angles()
    return Weld
  end

  local deltaTime = 0
  local deltaLoop
  deltaLoop = Services.RunService.RenderStepped:Connect(function(delta)
  deltaTime = 10 * delta
  end)

  local function Lerp(Motor, CFrame, Angles)
    if MotorNames[Motor] then
      pcall(function()
      MotorNames[Motor].Transform = MotorNames[Motor].Transform:lerp(CFrame * Angles, deltaTime)
      end)
    end
  end

  local function CheckState()
    local RootPartVelocity = (RootPart.Velocity * Vector3.new(1,0,1)).magnitude
    local RootPartVelocityY = RootPart.Velocity.Y

    local FloorCast = workspace:Raycast(RootPart.Position, ((CF.n(RootPart.Position,RootPart.Position - Vector3.new(0,1,0))).lookVector).unit * 4, RaycastParams)

    if RootPartVelocity < 1 and FloorCast ~= nil then
      return "Idle"
    elseif RootPartVelocity > 2 and FloorCast ~= nil then
      return "Walk"
    elseif RootPartVelocityY > 1 and FloorCast == nil then
      return "Jump"
    elseif RootPartVelocityY < -1 and FloorCast == nil then
      return "Fall"
    end
  end

  local Poses = {
    ["TestPose"] = {
      [1] = {
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
      },
      [2] = {
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},
        ["TRSO"] = {CF.n(0, 0, 0) * CF.a(rad(0), rad(0), rad(0)), EasingStyles.Bounce, EasingDirs.InOut, 0.2},


      },
    }
  }

  function fling(hum)
    Targetting = true
    if hum then
      if hum.Health == 0 then
        local fake = Instance.new("Part", workspace)
        fake.Name = "Fake"
        fake.Size = Vector3.new(0.001, 0.001, 0.001)
        fake.CanCollide = false
        fake.CanTouch = false
        fake.CanQuery = false
        fake.Massless = true
        fake.Position = Mouse.Hit.Position
        fake.Anchored = true
        Targetting = true
        MotorNames["FlingPart"].Part0 = fake
      elseif hum.Parent:FindFirstChild("Torso") and hum.Health > 0 then
        MotorNames["FlingPart"].Part0 = hum.Parent:FindFirstChild("Torso")
      elseif hum.Parent:FindFirstChild("UpperTorso") and hum.Health > 0 then
        MotorNames["FlingPart"].Part0 = hum.Parent:FindFirstChild("UpperTorso")
      elseif hum.Parent:FindFirstChild("LowerTorso") and hum.Health > 0 then
        MotorNames["FlingPart"].Part0 = hum.Parent:FindFirstChild("LowerTorso")
      elseif hum.RigType == Enum.HumanoidRigType.R6 and (not hum.Parent:FindFirstChild("Left Shoulder") or not hum.Parent:FindFirstChild("Right Shoulder") or not hum.Parent:FindFirstChild("Right Hip") or not hum.Parent:FindFirstChild("Left Hip")) and hum.Health > 0 then
        local fake = Instance.new("Part", workspace)
        fake.Name = "Fake"
        fake.Size = Vector3.new(0.001, 0.001, 0.001)
        fake.CanCollide = false
        fake.CanTouch = false
        fake.CanQuery = false
        fake.Massless = true
        fake.Position = Mouse.Hit.Position
        fake.Anchored = true
        Targetting = true
        MotorNames["FlingPart"].Part0 = fake
      elseif hum.RigType == Enum.HumanoidRigType.R15 and (not hum.Parent:FindFirstChild("LeftShoulder") or not hum.Parent:FindFirstChild("RightShoulder") or not hum.Parent:FindFirstChild("RightHip") or not hum.Parent:FindFirstChild("LeftHip") or not hum.Parent:FindFirstChild("LeftAnkle") or not hum.Parent:FindFirstChild("RightAnkle") or not hum.Parent:FindFirstChild("LeftWrist") or not hum.Parent:FindFirstChild("RightWrist") or not hum.Parent:FindFirstChild("LeftKnee") or not hum.Parent:FindFirstChild("RightKnee") or not hum.Parent:FindFirstChild("LeftElbow") or not hum.Parent:FindFirstChild("RightElbow")) and hum.Health > 0 then
        local fake = Instance.new("Part", workspace)
        fake.Name = "Fake"
        fake.Size = Vector3.new(0.001, 0.001, 0.001)
        fake.CanCollide = false
        fake.CanTouch = false
        fake.CanQuery = false
        fake.Massless = true
        fake.Position = Mouse.Hit.Position
        fake.Anchored = true
        Targetting = true
        MotorNames["FlingPart"].Part0 = fake
      end
    end
    MotorNames["bulleteffect"].Part0 = Character[Player.Name]["Left Arm"]
    wait(1.25)
    MotorNames["FlingPart"].Part0 = Character:FindFirstChild("Torso")
    Targetting = false
    if Character:FindFirstChild("Fake", true) then
      Character:FindFirstChild("Fake"):Destroy()
    end
  end

  local function Tween(TweenSpeed, EasingStyle, EasingDirection, LoopCount, Instance, GoalInfo)
    local tweenInfo = TweenInfo.new(
    TweenSpeed,
    EasingStyle,
    EasingDirection,
    LoopCount
    )
    local goals = GoalInfo
    local anim = Services.TweenService:Create(Instance, tweenInfo, goals)
    anim:Play()
  end

  local function Pose(Name,Speed,Index)
    for i,v in pairs(Poses[Name][Index]) do
      if MotorNames[i] then
        Tween(
        v[4]*Speed,
        v[2],
        v[3],
        0,
        MotorNames[i],
        {Transform = v[1]}
        )
      end
    end
  end

  local Targetting = false

  local function PoseAnimThing(Speed,Alpha)
    if not Targetting and not Attack then
      Attack = true
      Humanoid.WalkSpeed = 4
      for i = 1,#Poses["TestPose"] do
        Pose("TestPose",1,i)
        task.wait(Speed)
      end
      Attack = false
    end
  end

  KeyPressCheck = Services.UserInputService.InputBegan:Connect(function(Input, gameProcessed)
  if Input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed and not Attack and not Targetting then
    --PoseAnimThing(1,100 * deltaTime)
  end
  end)

  KeyReleaseCheck = Services.UserInputService.InputEnded:Connect(function(Input, gameProcessed)
  if Input.KeyCode == Enum.KeyCode.E and not gameProcessed then

  end
  end)

  for i, v in ipairs(Character:GetChildren()) do
    if v:IsA("Accessory") and v:FindFirstChild("Handle") then
      if v.Name == "MeshPartAccessory" and v.Handle.Size == Vector3.new(4, 4, 1) then
        AddHatToRig("Wing1", v.Handle, Character["HumanoidRootPart"], false)
      end
    end
  end

  for i, v in ipairs(Character:GetChildren()) do
    if v:IsA("Accessory") and v:FindFirstChild("Handle") then
      if v.Name == "MeshPartAccessory1" and v.Handle.Size == Vector3.new(4, 4, 1) then
        AddHatToRig("Wing2", v.Handle, MotorNames["Wing1"].Part1, false)
      end
    end
  end

  for i, v in ipairs(Character:GetChildren()) do
    if v:IsA("Accessory") and v:FindFirstChild("Handle") then
      if v.Name == "ShadowBladeMasterAccessory" and v.Handle.Size == Vector3.new(5, 5, 0.5) then
        AddHatToRig("Wing3", v.Handle, MotorNames["Wing2"].Part1, false)
      end
    end
  end

  for i, v in ipairs(Character:GetChildren()) do
    if v:IsA("Accessory") and v:FindFirstChild("Handle") then
      if v.Name == "MeshPartAccessory2" and v.Handle.Size == Vector3.new(4, 4, 1) then
        AddHatToRig("Wing4", v.Handle, Character["HumanoidRootPart"], false)
      end
    end
  end

  for i, v in ipairs(Character:GetChildren()) do
    if v:IsA("Accessory") and v:FindFirstChild("Handle") then
      if v.Name == "MeshPartAccessory3" and v.Handle.Size == Vector3.new(4, 4, 1) then
        AddHatToRig("Wing5", v.Handle, MotorNames["Wing4"].Part1, false)
      end
    end
  end

  for i, v in ipairs(Character:GetChildren()) do
    if v:IsA("Accessory") and v:FindFirstChild("Handle") then
      if v.Name == "BladeMasterAccessory" and v.Handle.Size == Vector3.new(5, 5, 0.5) then
        AddHatToRig("Wing6", v.Handle, MotorNames["Wing5"].Part1, false)
      end
    end
  end

  repeat Services.RunService.Stepped:Wait()
    State = CheckState()

    local RootPartVel = Vector3.new(RootPart.AssemblyLinearVelocity.X, 0, RootPart.AssemblyLinearVelocity.Z).Magnitude
    local LookV = RootPart.CFrame:VectorToObjectSpace(Humanoid.MoveDirection) / 2

    if LookV.X < 0.05 then
      FootVal = LookV.X/4
    else
      FootVal = LookV.X/2
    end

    local MouseLookHead = {
      ["RotX"] = -math.asin((Mouse.Origin.p - Mouse.Hit.p).unit.x);
      ["RotY"] = -math.asin((Mouse.Origin.p - Mouse.Hit.p).unit.y);
      ["RotZ"] = -math.asin((Mouse.Origin.p - Mouse.Hit.p).unit.z);
      ["PosY"] = -math.abs(-math.asin((Mouse.Origin.p - Mouse.Hit.p).unit.y)/6);
      ["PosZ"] =  -math.asin((Mouse.Origin.p - Mouse.Hit.p).unit.y)/2;
    }
    local MouseLookArms = -math.asin((Mouse.Origin.p - Mouse.Hit.p).unit.y) / 1.75

    local MouseLookResult = {
      ["Head"] = --[[CF.n(0, MouseLookHead["PosY"], MouseLookHead["PosZ"]/2)--]] CF.a(rad(0), rad(0),-MouseLookHead["RotX"]);
      ["Arm"] = CF.a(MouseLookArms, 0, 0);
    }

    if State == "Idle" and not Attack then
      local Speed = 1.5

      Humanoid.WalkSpeed = WalkSpeed
      Lerp("Wing1", CF.n(-2, 2+0.5*sin(Speed), 2), CF.a(rad(0), rad(0), rad(45-5*cos(Speed))))
      Lerp("Wing2", CF.n(0, 0.5+0.25*sin(Speed), 0.5), CF.a(rad(0), rad(0), rad(0-5*cos(Speed))))
      Lerp("Wing3", CF.n(0, 0.5+0.25*sin(Speed), 0.5), CF.a(rad(0), rad(0), rad(0-5*cos(Speed))))
      Lerp("Wing4", CF.n(4, 3-0.5*cos(Speed), 1), CF.a(-rad(20-10*cos(Speed)), -rad(20-40*cos(Speed)), -rad(-15+15*cos(Speed))))
      Lerp("Wing5", CF.n(2, 0-0.5*cos(Speed), 0-0.5*cos(Speed)), CF.a(-rad(0), -rad(20-40*cos(Speed)), -rad(15*sin(Speed))))
      Lerp("Wing6", CF.n(2, 0-0.5*cos(Speed), 0-0.5*cos(Speed)), CF.a(-rad(0), -rad(20-40*cos(Speed)), -rad(15*sin(Speed))))
      Lerp("HEAD", CF.n(0, 0, 0), CF.a(rad(0), rad(0), rad(-10+25*cos(Speed*0.50))))
      Lerp("TRSO", CF.n(0, 0+0.10*cos(Speed), 0), CF.a(rad(-5+5.15*sin(Speed)), rad(0), rad(-2.5+2*cos(Speed))))
      Lerp("LA",   CF.n(0.5, -0.5+0.10*cos(Speed), -0.75), CF.a(rad(0), rad(25), rad(130-5*cos(Speed))))
      Lerp("RA",   CF.n(0, 0+0.10*cos(Speed), 0+0.10*sin(Speed)), CF.a(rad(-5), rad(25), rad(15+5*cos(Speed))))
      Lerp("LL",   CF.n(0, 0, -0.25+0.35*cos(Speed)), CF.a(rad(0+-10+10*cos(Speed)), rad(25), rad(0)))
      Lerp("RL",   CF.n(0, -0.10+0.10*cos(Speed), -0.25+0.15*cos(Speed)), CF.a(rad(-25+-5+5*cos(Speed)), rad(0), rad(15)))

    elseif State == "Walk" and not Attack then
      local Speed = Humanoid.WalkSpeed / 2

      Humanoid.WalkSpeed = WalkSpeed
      Lerp("Wing1", CF.n(-2, 2+0.5*sin(1.5), 2), CF.a(rad(0), rad(0), rad(45-5*cos(1.5))))
      Lerp("Wing2", CF.n(0, 0.5+0.25*sin(1.5), 0.5), CF.a(rad(0), rad(0), rad(0-5*cos(1.5))))
      Lerp("Wing3", CF.n(0, 0.5+0.25*sin(1.5), 0.5), CF.a(rad(0), rad(0), rad(0-5*cos(1.5))))
      Lerp("Wing4", CF.n(4, 3-0.5*cos(1.5), 1), CF.a(-rad(20-10*cos(1.5)), -rad(20-40*cos(1.5)), -rad(-15+15*cos(1.5))))
      Lerp("Wing5", CF.n(2, 0-0.5*cos(1.5), 0-0.5*cos(1.5)), CF.a(-rad(0), -rad(20-40*cos(1.5)), -rad(15*sin(1.5))))
      Lerp("Wing6", CF.n(2, 0-0.5*cos(1.5), 0-0.5*cos(1.5)), CF.a(-rad(0), -rad(20-40*cos(1.5)), -rad(15*sin(1.5))))
      Lerp("HEAD", CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(rad(0), rad(0),-LookV.X*2))
      Lerp("TRSO", CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(LookV.Z/3+0.05*sin(Speed), 0, -LookV.X/3+0.05*sin(Speed)))
      Lerp("LA",   CF.n(0, -0.10 + -0.2*sin(Speed),-LookV.Z*sin(Speed)/2), CF.a(LookV.Z/3 + -LookV.Z*2.5*cos(Speed), rad(0), rad(0)))
      Lerp("RA",   CF.n(0, -0.10 - -0.2*sin(Speed), LookV.Z*sin(Speed)/2), CF.a(LookV.Z/3 - -LookV.Z*2.5*cos(Speed), rad(0), rad(0)))
      Lerp("LL",   CF.n(0, -0.10 - -0.2*sin(Speed), LookV.Z*sin(Speed)/2) * CF.n(0,math.abs(LookV.X/2),0), CF.a(LookV.Z/3 - -LookV.Z*2*cos(Speed), rad(0),-LookV.X*0.90*cos(Speed)))
      Lerp("RL",   CF.n(0, -0.10 + -0.2*sin(Speed),-LookV.Z*sin(Speed)/2) * CF.n(0,math.abs(LookV.X/2),0), CF.a(LookV.Z/3 + -LookV.Z*2*cos(Speed), rad(0),LookV.X*0.90*cos(Speed)))

    elseif State == "Jump" and not Attack then
      local Speed = 10

      Humanoid.WalkSpeed = WalkSpeed
      Lerp("Wing1", CF.n(-2, 2+0.5*sin(Speed), 2), CF.a(rad(0), rad(0), rad(45-5*cos(Speed))))
      Lerp("Wing2", CF.n(0, 0.5+0.25*sin(Speed), 0.5), CF.a(rad(0), rad(0), rad(0-5*cos(Speed))))
      Lerp("Wing3", CF.n(0, 0.5+0.25*sin(Speed), 0.5), CF.a(rad(0), rad(0), rad(0-5*cos(Speed))))
      Lerp("Wing4", CF.n(4, 3-0.5*cos(Speed), 1), CF.a(-rad(20-10*cos(Speed)), -rad(20-40*cos(Speed)), -rad(-15+15*cos(Speed))))
      Lerp("Wing5", CF.n(2, 0-0.5*cos(Speed), 0-0.5*cos(Speed)), CF.a(-rad(0), -rad(20-40*cos(Speed)), -rad(15*sin(Speed))))
      Lerp("Wing6", CF.n(2, 0-0.5*cos(Speed), 0-0.5*cos(Speed)), CF.a(-rad(0), -rad(20-40*cos(Speed)), -rad(15*sin(Speed))))
      Lerp("HEAD", CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(rad(0), rad(0),-LookV.X*2))
      Lerp("TRSO", CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(LookV.Z/3+0.10*sin(Speed), 0, -LookV.X/3+0.05*sin(Speed)))
      Lerp("LA",   CF.n(0, -0.25, 0), CF.a(rad(25), rad(0),rad(-35)))
      Lerp("RA",   CF.n(0, -0.25, 0), CF.a(rad(25), rad(0),rad(35)))
      Lerp("LL",   CF.n(0, 0.25, -0.5), CF.a(rad(-30), rad(0),rad(0)))
      Lerp("RL",   CF.n(0, 0.25, -0.5), CF.a(rad(-30), rad(0),rad(0)))

    elseif State == "Fall" and not Attack then
      local Speed = 10

      Humanoid.WalkSpeed = WalkSpeed
      Lerp("Wing1", CF.n(-2, 2+0.5*sin(Speed), 2), CF.a(rad(0), rad(0), rad(45-5*cos(Speed))))
      Lerp("Wing2", CF.n(0, 0.5+0.25*sin(Speed), 0.5), CF.a(rad(0), rad(0), rad(0-5*cos(Speed))))
      Lerp("Wing3", CF.n(0, 0.5+0.25*sin(Speed), 0.5), CF.a(rad(0), rad(0), rad(0-5*cos(Speed))))
      Lerp("Wing4", CF.n(4, 3-0.5*cos(Speed), 1), CF.a(-rad(20-10*cos(Speed)), -rad(20-40*cos(Speed)), -rad(-15+15*cos(Speed))))
      Lerp("Wing5", CF.n(2, 0-0.5*cos(Speed), 0-0.5*cos(Speed)), CF.a(-rad(0), -rad(20-40*cos(Speed)), -rad(15*sin(Speed))))
      Lerp("Wing6", CF.n(2, 0-0.5*cos(Speed), 0-0.5*cos(Speed)), CF.a(-rad(0), -rad(20-40*cos(Speed)), -rad(15*sin(Speed))))
      Lerp("HEAD", CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(rad(0), rad(0),-LookV.X*2))
      Lerp("TRSO", CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(LookV.Z/3+0.05*sin(Speed), 0, -LookV.X/3+0.05*sin(Speed)))
      Lerp("LA",   CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(rad(0), rad(0),rad(-35)))
      Lerp("RA",   CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(rad(0), rad(0),rad(35)))
      Lerp("LL",   CF.n(0*0*sin(0), 0*0*sin(0), 0*0*sin(0)), CF.a(rad(0), rad(0),rad(0)))
      Lerp("RL",   CF.n(0, 0.5, -0.5), CF.a(rad(-45), rad(0),rad(0)))

    end
  until not getgenv().AnimationTemplateRunning

  KeyPressCheck:Disconnect()
  KeyReleaseCheck:Disconnect()
  end)
end
