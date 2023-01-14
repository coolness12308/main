getgenv().DefaultColor = Color3.fromRGB(44, 111, 199)

getgenv().CurrentVersion = loadstring(game:HttpGet("https://raw.githubusercontent.com/phere4106/Scripts/main/lunarver/version/ver.lua"))()
getgenv().LatestVersion = loadstring(game:HttpGet("https://raw.githubusercontent.com/phere4106/Scripts/main/lunarver/version/ver.lua"))()

if getgenv().bindconnect then
  getgenv().bindconnect:Disconnect()
  getgenv().bindconnect = false
end

if not getgenv().SavedColor then
  getgenv().SavedColor = Color3.fromRGB(44, 111, 199)
end

if not isfolder('LunarFEStorage') then
  makefolder('LunarFEStorage')
end

if not isfolder("LunarFEStorage" .. "/Settings") then
  makefolder("LunarFEStorage" .. "/Settings")
end

if not isfile("LunarFEStorage" .. "/Settings" .. "/Settings.txt") then
  local content = {}
  writefile("LunarFEStorage" .. "/Settings" .. "/Settings.txt", tostring(game:GetService("HttpService"):JSONEncode(content)))
end

local Settings = game:GetService("HttpService"):JSONDecode(readfile("LunarFEStorage" .. "/Settings" .. "/Settings.txt"))

if game:GetService("CoreGui"):FindFirstChild("LunarFE") then
  game:GetService("CoreGui"):FindFirstChild("LunarFE"):Destroy()
end

local LunarFE = Instance.new("ScreenGui")
getgenv().GUI = LunarFE
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Sidebar = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")
local LunarFETitleTextLabel = Instance.new("TextLabel")
local SidebarPaddingTextLabel = Instance.new("TextLabel")
local OutlineFrame = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local Sample = Instance.new("ImageLabel")
local UIStroke = Instance.new("UIStroke")
local UIStroke_2 = Instance.new("UIStroke")

--Properties:

LunarFE.Name = "LunarFE"

if syn then
  syn.protect_gui(LunarFE)
elseif gethui then
  LunarFE.Parent = gethui()
end

LunarFE.Parent = game:GetService("CoreGui")

MainFrame.Name = "MainFrame"
MainFrame.Parent = LunarFE
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 420, 0, 260)
getgenv().MainFrame = MainFrame

UIStroke.Parent = MainFrame
UIStroke.Color = getgenv().SavedColor
UIStroke.Thickness = 3

UIStroke_2.Parent = OutlineFrame
UIStroke_2.Color = Color3.fromRGB(0,0,0)
UIStroke_2.Transparency = 0.8
UIStroke_2.Thickness = 4

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = MainFrame

Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Sidebar.Size = UDim2.new(0, 140, 1, 0)

UICorner_2.CornerRadius = UDim.new(0, 4)
UICorner_2.Parent = Sidebar

UIListLayout.Parent = Sidebar
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

UIPadding.Parent = Sidebar
UIPadding.PaddingLeft = UDim.new(0, 10)
UIPadding.PaddingTop = UDim.new(0, 10)

LunarFETitleTextLabel.Name = "LunarFETitleTextLabel"
LunarFETitleTextLabel.Parent = Sidebar
LunarFETitleTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
LunarFETitleTextLabel.BackgroundTransparency = 1.000
LunarFETitleTextLabel.BorderSizePixel = 0
LunarFETitleTextLabel.LayoutOrder = -100
LunarFETitleTextLabel.Size = UDim2.new(0, 110, 0, 15)
LunarFETitleTextLabel.Font = Enum.Font.GothamBlack
LunarFETitleTextLabel.Text = 'Lunar <font color="#7e14ff">FE</font> ' .. getgenv().CurrentVersion
LunarFETitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
LunarFETitleTextLabel.RichText = true
LunarFETitleTextLabel.TextSize = 14.000

SidebarPaddingTextLabel.Name = "SidebarPaddingTextLabel"
SidebarPaddingTextLabel.Parent = Sidebar
SidebarPaddingTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SidebarPaddingTextLabel.BackgroundTransparency = 1.000
SidebarPaddingTextLabel.BorderSizePixel = 0
SidebarPaddingTextLabel.LayoutOrder = -100
SidebarPaddingTextLabel.Position = UDim2.new(0, 0, 0.104166664, 0)
SidebarPaddingTextLabel.Size = UDim2.new(0, 100, 0, 5)
SidebarPaddingTextLabel.Font = Enum.Font.GothamBlack
SidebarPaddingTextLabel.Text = ""
SidebarPaddingTextLabel.RichText = true
SidebarPaddingTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SidebarPaddingTextLabel.TextSize = 16.000

local SidebarPaddingTextLabelClone = SidebarPaddingTextLabel:Clone()
SidebarPaddingTextLabelClone.Parent = Sidebar
SidebarPaddingTextLabelClone.LayoutOrder = -1000

OutlineFrame.Name = "OutlineFrame"
OutlineFrame.Parent = MainFrame
OutlineFrame.AnchorPoint = Vector2.new(0.5, 0.5)
OutlineFrame.BackgroundColor3 = getgenv().SavedColor
OutlineFrame.BackgroundTransparency = 1.000
OutlineFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
OutlineFrame.Size = UDim2.new(0, MainFrame.Size.X.Offset + 4, 0, MainFrame.Size.Y.Offset + 4)
OutlineFrame.ZIndex = -1

UICorner_3.CornerRadius = UDim.new(0, 4)
UICorner_3.Parent = OutlineFrame

-- Scripts:

local function DUIGF_fake_script() -- MainFrame.Dragify
  local script = Instance.new('LocalScript', MainFrame)

  local UIS = game:GetService("UserInputService")
  function dragify(Frame)
    dragToggle = nil
    dragSpeed = 0.15
    dragInput = nil
    dragStart = nil
    dragPos = nil
    function updateInput(input)
      Delta = input.Position - dragStart
      Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
      game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.15), {Position = Position}):Play()
    end
    Frame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
      dragToggle = true
      dragStart = input.Position
      startPos = Frame.Position
      input.Changed:Connect(function()
      if input.UserInputState == Enum.UserInputState.End then
        dragToggle = false
      end
      end)
    end
    end)
    Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
      dragInput = input
    end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragToggle then
      updateInput(input)
    end
    end)
  end
  dragify(script.Parent)

end
coroutine.wrap(DUIGF_fake_script)()
local function VLDWTYO_fake_script() -- MainFrame.Handler
  local script = Instance.new('LocalScript', MainFrame)
  script.Name = "Handler"

  local ms = game:GetService("Players").LocalPlayer:GetMouse()
  local sample = script:WaitForChild('Sample')

  function btnclicked(btn)
    local c = sample:Clone()
    c.ZIndex = 9001
    c.Parent = btn
    local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
    c.Position = UDim2.new(0, x, 0, y)
    local len, size = 0.7, nil
    if btn.AbsoluteSize.X >= btn.AbsoluteSize.Y then
      size = (btn.AbsoluteSize.X * 1.5)
    else
      size = (btn.AbsoluteSize.Y * 1.5)
    end
    c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
    for i = 1, 10 do
      c.ImageTransparency = c.ImageTransparency + 0.05
      wait(len / 12)
    end
    c:Destroy()
  end

  for _,v in pairs(script.Parent:GetDescendants()) do
    if v:IsA("TextButton") then
      v.ClipsDescendants = true
      v.MouseButton1Down:Connect(function()
      btnclicked(v)
      end)
    end
  end
end
coroutine.wrap(VLDWTYO_fake_script)()

Sample.Name = "Sample"
Sample.Parent = MainFrame.Handler
Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Sample.BackgroundTransparency = 1.000
Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
Sample.ImageColor3 = Color3.fromRGB(0, 0, 0)
Sample.ImageTransparency = 0.600


---------------- Main Variables -----------

local Sidebar = MainFrame.Sidebar

---------------- Variables ----------------

local SelectedColor = Color3.fromRGB(44, 111, 199)
local SidebarButtonCount = 0

---------------- UI Library ---------------

local NotificationHandler = game:GetObjects("rbxassetid://11810177299")[1]
NotificationHandler.Parent = LunarFE

local NotificationTemplate = game:GetObjects("rbxassetid://11810219894")[1]

local Notify
local Main = {}
local Sections = {}

function Main:Tab(Text0,Image0,Callback)
  local ImageToUse
  local TabAmt = 0

  if Image0 then ImageToUse = Image0 else ImageToUse = 105897927 end

  local SidebarButton = game:GetObjects("rbxassetid://11804865958")[1]
  SidebarButton.Parent = Sidebar
  SidebarButton.Visible = true
  SidebarButton.Text = Text0
  SidebarButton.RichText = true
  SidebarButton.ImageLabel.Image = "rbxassetid://"..ImageToUse
  SidebarButton.LayoutOrder = SidebarButtonCount
  SidebarButton.BackgroundColor3 = getgenv().SavedColor

  SidebarButtonCount = SidebarButtonCount + 1

  local HolderFrame = game:GetObjects("rbxassetid://11809415735")[1]
  --if MainAmt == 1 then
  HolderFrame.Visible = true
  --end
  HolderFrame.Parent = MainFrame
  HolderFrame.Position = UDim2.new(0.5,70,0.5,0)
  HolderFrame.Size = UDim2.new(0, (MainFrame.Size.X.Offset - Sidebar.Size.X.Offset) - 20,0, (MainFrame.Size.Y.Offset - Sidebar.Size.Y.Offset) - 20)
  HolderFrame.Name = "SectionFrame"

  for _,v in pairs(MainFrame:GetChildren()) do
    if v:IsA("Frame") then
      if v.Name:sub(1,13) == "SectionFrame" then
        v.Visible = false
      end
    end
  end

  local Frame = HolderFrame.ScrollingFrame
  Frame.ZIndex = 24

  function Sections:Section(Title)
    local ItemHold = {}

    local SectionLabel = game:GetObjects("rbxassetid://11804752786")[1]
    SectionLabel.Parent = Frame
    SectionLabel.Text = Title
    SectionLabel.RichText = true
    SectionLabel.ZIndex = 25
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.TextColor3 = Color3.fromRGB(160,160,160)
    SectionLabel.Size = UDim2.new(1, -10,0, 15)
    SectionLabel.Name = "SectionLabel_"..Title

    function ItemHold:Label(Text0)
      TextLabel = game:GetObjects("rbxassetid://11804752786")[1]
      TextLabel.Parent = Frame
      TextLabel.ZIndex = 25
      TextLabel.Text = Text0
      TextLabel.RichText = true
      TextLabel.Name = "Label_"..Text0

    end

    function ItemHold:Button(Text0, Callback)
      TextButton = game:GetObjects("rbxassetid://11804852685")[1]
      TextButton.Parent = Frame
      TextButton.ZIndex = 25
      TextButton.Text = Text0
      TextButton.RichText = true
      TextButton.Name = "Button_"..Text0
      TextButton.BackgroundColor3 = getgenv().SavedColor

      TextButton.MouseButton1Down:Connect(Callback or function() end)
    end

    function Main:ChangeKeyBind(KeyBind)
      getgenv().KeyBind = KeyBind
      local content = {UIKeybind = KeyBind, Hello = true}
      writefile("LunarFEStorage" .. "/Settings" .. "/Settings.txt", tostring(game:GetService("HttpService"):JSONEncode(content)))
    end
    
    local bindcooldown = false
    
    function ItemHold:BindButton(bind, text)
      local UIS = game:GetService("UserInputService")
      TextButton = game:GetObjects("rbxassetid://11804852685")[1]
      TextButton.Parent = Frame
      TextButton.ZIndex = 25
      if string.find(tostring(bind), "Enum.KeyCode.") then
        local split = string.split(tostring(bind), "Enum.KeyCode.")
        TextButton.Text = text .. split[2]
      end
      TextButton.RichText = true
      TextButton.Name = "BindButton_"..Text0
      TextButton.BackgroundColor3 = getgenv().SavedColor
        getgenv().bindconnect2 = TextButton.MouseButton1Down:Connect(function()
        TextButton.Text = "Press any key..."
        if getgenv().bindconnect then
            getgenv().bindconnect:Disconnect()
        end
        getgenv().bindconnect = UIS.InputBegan:Connect(function(key, gameProcessed)
        if not gameProcessed and key.KeyCode then
          local split = string.split(tostring(key.KeyCode), "Enum.KeyCode.")
          TextButton.Text = text .. split[2]
          getgenv().KeyBind = key.KeyCode
          local content = {UIKeybind = split[2], Hello = true}
          writefile("LunarFEStorage" .. "/Settings" .. "/Settings.txt", tostring(game:GetService("HttpService"):JSONEncode(content)))
        end
        end)
        end)
      end
    end

    function ItemHold:Toggle(Text0, DefaultState, Callback)
      local Toggle = {}

      function NilCallback() end
        if not Callback then Callback = NilCallback end

        local TextButton = game:GetObjects("rbxassetid://11809834234")[1]
        local ToggleFrame = TextButton.ToggleFrame

        local EnabledColor = Color3.fromRGB(47, 193, 37)
        local DisabledColor = Color3.fromRGB(40, 40, 40)

        TextButton.Parent = Frame
        TextButton.ZIndex = 25
        TextButton.Text = Text0
        TextButton.Name = "Toggle_"..Text0
        TextButton.RichText = true
        TextButton.BackgroundColor3 = getgenv().SavedColor
        ToggleFrame.ZIndex = 27

        local BoolValue = Instance.new("BoolValue")
        BoolValue.Parent = ToggleFrame
        BoolValue.Value = DefaultState
        BoolValue.Name = "IsEnabled"

        if DefaultState then
          ToggleFrame.BackgroundColor3 = EnabledColor
          Callback()
        else
          ToggleFrame.BackgroundColor3 = DisabledColor
        end

        function Toggle:Set(Value,ShouldCallback)
          if Value == true then
            BoolValue.Value = true

            task.spawn(function()
            game:GetService("TweenService"):Create(ToggleFrame, TweenInfo.new(0.15), {BackgroundColor3 = EnabledColor}):Play()
            end)

            if ShouldCallback then
              return Callback(true)
            end
          elseif Value == false then
            BoolValue.Value = false

            task.spawn(function()
            game:GetService("TweenService"):Create(ToggleFrame, TweenInfo.new(0.15), {BackgroundColor3 = DisabledColor}):Play()
            end)
            if ShouldCallback then
              return Callback(false)
            end
          end
        end

        TextButton.MouseButton1Down:Connect(function()
        if BoolValue.Value == true then
          BoolValue.Value = false

          task.spawn(function()
          game:GetService("TweenService"):Create(ToggleFrame, TweenInfo.new(0.15), {BackgroundColor3 = DisabledColor}):Play()
          end)

          return Callback(false)
        elseif BoolValue.Value == false then
          BoolValue.Value = true

          task.spawn(function()
          game:GetService("TweenService"):Create(ToggleFrame, TweenInfo.new(0.15), {BackgroundColor3 = EnabledColor}):Play()
          end)

          return Callback(true)
        end
        end)
        return Toggle
      end

      return ItemHold
    end

    SidebarButton.MouseButton1Down:Connect(Callback or function() end)
    SidebarButton.MouseButton1Down:Connect(function()
    for _,v in pairs(MainFrame:GetChildren()) do
      if string.find(v.Name,"SectionFrame") then
        v.Visible = false
      end
      end;
      if HolderFrame then HolderFrame.Visible = true end
      end)

      for _,v in pairs(MainFrame:GetChildren()) do
        if v:IsA("Frame") then
          if v.Name:sub(1,13) == "SectionFrame" then
            if penis == 1 then
              v.Visible = true
            end
          end
        end
      end

      return Sections
    end

    function Main:Notify(Text0)
      local CloseClickDetection
      local UIClosing = false

      local Speed = 0.3

      local Notif = NotificationTemplate:Clone()
      Notif.Parent = NotificationHandler
      Notif.Size = UDim2.new(0, 0,0,110)

      Notif.UIStroke.Color = getgenv().SavedColor
      Notif.UIStroke.Color = getgenv().SavedColor
      Notif.TopTitle.BackgroundColor3 = getgenv().SavedColor

      game:GetService("TweenService"):Create(Notif, TweenInfo.new(Speed), {Size = UDim2.new(0, 230,0,110)}):Play()

      Notif.InnerFrame.DescriptionText.RichText = true
      Notif.InnerFrame.DescriptionText.Text = tostring(Text0)

      CloseClickDetection = Notif.TopTitle.CloseButton.MouseButton1Down:Connect(function()
      UIClosing = true
      task.spawn(function()
      for _,v in pairs(Notif:GetDescendants()) do
        if v:IsA("Frame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("UIStroke") then
          if v.Parent.Name ~= "OutlineFrame" then
            if v.Name == "DescriptionText" then
              game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {TextTransparency = 1}):Play()
            else
              game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {Transparency = 1}):Play()
            end
          elseif v:IsA("UIStroke") and v.Parent.Name == "OutlineFrame" then
            game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {Transparency = 1}):Play()
          end
        elseif v:IsA("ImageLabel") then
          game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {ImageTransparency = 1}):Play()
        end
      end

      game:GetService("TweenService"):Create(Notif, TweenInfo.new(Speed), {Transparency = 1}):Play()
      game:GetService("TweenService"):Create(Notif, TweenInfo.new(Speed), {Size = UDim2.new(0, 230,0,0)}):Play()
      task.wait(Speed)
      Notif:Destroy()
      end)
      end)

      task.spawn(function()

      Notif.Transparency = 1
      for _,v in pairs(Notif:GetDescendants()) do
        if v:IsA("Frame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("UIStroke") then
          v.Transparency = 1
        elseif v:IsA("ImageLabel") then
          v.ImageTransparency = 1
        end
      end

      for _,v in pairs(Notif:GetDescendants()) do
        if v:IsA("Frame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("UIStroke") then
          if v.Parent.Name ~= "OutlineFrame" then
            if v.Name == "DescriptionText" then
              game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {TextTransparency = 0}):Play()
            else
              game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {Transparency = 0}):Play()
            end
          elseif v:IsA("UIStroke") and v.Parent.Name == "OutlineFrame" then
            game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {Transparency = 0.8}):Play()
          end
        elseif v:IsA("ImageLabel") then
          game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {ImageTransparency = 0}):Play()
        end
      end

      game:GetService("TweenService"):Create(Notif, TweenInfo.new(Speed), {Transparency = 0}):Play()
      end)

      task.spawn(function()
      pcall(function()
      for i = 1,5 do
        task.wait(1)
        if UIClosing then break end
        Notif.TopTitle.RichText = true
        Notif.TopTitle.Text = "Notification ("..5-i.."s)"
      end

      task.spawn(function()
      pcall(function()
      if not UIClosing then
        for _,v in pairs(Notif:GetDescendants()) do
          if v:IsA("Frame") or v:IsA("TextLabel") or v:IsA("TextButton") or v:IsA("UIStroke") then
            if v.Parent.Name ~= "OutlineFrame" then
              if v.Name == "DescriptionText" then
                game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {TextTransparency = 1}):Play()
              else
                game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {Transparency = 1}):Play()
              end
            elseif v:IsA("UIStroke") and v.Parent.Name == "OutlineFrame" then
              game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {Transparency = 1}):Play()
            end
          elseif v:IsA("ImageLabel") then
            game:GetService("TweenService"):Create(v, TweenInfo.new(Speed), {ImageTransparency = 1}):Play()
          end
        end

        game:GetService("TweenService"):Create(Notif, TweenInfo.new(Speed), {Transparency = 1}):Play()
        game:GetService("TweenService"):Create(Notif, TweenInfo.new(Speed), {Size = UDim2.new(0, 230,0,0)}):Play()
        task.wait(Speed)
        Notif:Destroy()
      end
      end)
      end)
      end)
      end)
    end

    function Main:ChangeUIColorTheme(Color,ButtonName)
      getgenv().SavedColor = Color
      for _,v in pairs(LunarFE:GetDescendants()) do
        if v:IsA("UIStroke") and v.Parent.Name ~= "ToggleFrame" and v.Parent.Name ~= "CloseButton" then
          game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {Color = Color}):Play()
        elseif v:IsA("TextButton") and v.Name ~= "CloseButton" then
          game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Color}):Play()
        elseif v.Name == "TopTitle" then
          game:GetService("TweenService"):Create(v, TweenInfo.new(0.3), {BackgroundColor3 = Color}):Play()
        end
      end
    end

    Main:ChangeUIColorTheme(getgenv().SavedColor,getgenv().SavedColorName)

    return Main
