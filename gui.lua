local TweenService = game:GetService("TweenService")

local function createTween(instance, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    return tween
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MovableGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

local roundedCorner = Instance.new("UICorner")
roundedCorner.CornerRadius = UDim.new(0, 15)
roundedCorner.Parent = frame

local createdByText = Instance.new("TextLabel")
createdByText.Name = "CreatedByText"
createdByText.Size = UDim2.new(0.7, 0, 0, 20)
createdByText.Position = UDim2.new(0, 10, 0, 0)
createdByText.BackgroundTransparency = 1
createdByText.Text = "Created by was_record"
createdByText.TextColor3 = Color3.fromRGB(180, 180, 180)
createdByText.Font = Enum.Font.GothamBold
createdByText.TextSize = 14
createdByText.TextXAlignment = Enum.TextXAlignment.Left
createdByText.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0.2, 0, 0, 15)
closeButton.Position = UDim2.new(0.78, 0, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeButton.Text = "Close"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.Parent = frame

local closeButtonCorner = Instance.new("UICorner")
closeButtonCorner.CornerRadius = UDim.new(0, 5)
closeButtonCorner.Parent = closeButton

local function closeGui()
    screenGui:Destroy()
end

closeButton.Activated:Connect(closeGui)

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(1, -150, 0.5, -25)
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.Text = "Toggle GUI"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.Gotham
toggleButton.TextSize = 18
toggleButton.Parent = screenGui

local toggleButtonCorner = Instance.new("UICorner")
toggleButtonCorner.CornerRadius = UDim.new(0, 10)
toggleButtonCorner.Parent = toggleButton

local function toggleGuiVisibility()
    if frame.Visible then
        local tweenFrame = createTween(frame, {Size = UDim2.new(0, 0, 0, 0)}, 0.5)
        local tweenText = createTween(createdByText, {Size = UDim2.new(0, 0, 0, 0)}, 0.5)
        local tweenCloseButton = createTween(closeButton, {Size = UDim2.new(0, 0, 0, 0)}, 0.5)
        tweenFrame:Play()
        tweenText:Play()
        tweenCloseButton:Play()
        tweenFrame.Completed:Connect(function()
            frame.Visible = false
            frame.Size = UDim2.new(0, 300, 0, 200)
            createdByText.Size = UDim2.new(0.7, 0, 0, 20)
            closeButton.Size = UDim2.new(0.2, 0, 0, 15)
        end)
    else
        frame.Visible = true
        local tweenFrame = createTween(frame, {Size = UDim2.new(0, 300, 0, 200)}, 0.5)
        local tweenText = createTween(createdByText, {Size = UDim2.new(0.7, 0, 0, 20)}, 0.5)
        local tweenCloseButton = createTween(closeButton, {Size = UDim2.new(0.2, 0, 0, 15)}, 0.5)
        tweenFrame:Play()
        tweenText:Play()
        tweenCloseButton:Play()
    end
end

toggleButton.Activated:Connect(toggleGuiVisibility)

local draggingToggleButton = false
local dragInputToggleButton = nil
local dragStartToggleButton = nil
local startPosToggleButton = nil

local function updateToggleButton(input)
    local delta = input.Position - dragStartToggleButton
    toggleButton.Position = UDim2.new(startPosToggleButton.X.Scale, startPosToggleButton.X.Offset + delta.X, startPosToggleButton.Y.Scale, startPosToggleButton.Y.Offset + delta.Y)
end

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingToggleButton = true
        dragStartToggleButton = input.Position
        startPosToggleButton = toggleButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                draggingToggleButton = false
            end
        end)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInputToggleButton = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInputToggleButton and draggingToggleButton then
        updateToggleButton(input)
    end
end)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local AutoFarm = Instance.new("TextButton")
AutoFarm.Name = "AutoFarm"
AutoFarm.Parent = frame
AutoFarm.BackgroundColor3 = Color3.new(0, 0, 0)
AutoFarm.BackgroundTransparency = 0.40000000596046
AutoFarm.Position = UDim2.new(0.0588235334, 0, 0.214285731, 0)
AutoFarm.Size = UDim2.new(0, 150, 0, 26)
AutoFarm.Font = Enum.Font.Gotham
AutoFarm.Text = "Auto Farm"
AutoFarm.TextColor3 = Color3.new(1, 1, 1)
AutoFarm.TextSize = 14
AutoFarm.MouseButton1Click:connect(function()
    _G.farm2 = not _G.farm2
    AutoFarm.Text = _G.farm2 and "Auto Farm (ON)" or "Auto Farm (OFF)"
    local targetColor = _G.farm2 and Color3.new(0, 0.5, 0) or Color3.new(0, 0, 0)
    local tween = createTween(AutoFarm, {BackgroundColor3 = targetColor}, 0.5)
    tween:Play()
end)

local groundDistance = 8
local Player = game:GetService("Players").LocalPlayer
local function getNearest()
    local nearest, dist = nil, 99999
    for _, v in pairs(game.Workspace.BossFolder:GetChildren()) do
        if v:FindFirstChild("Head") ~= nil then
            local m = (Player.Character.Head.Position - v.Head.Position).magnitude
            if m < dist then
                dist = m
                nearest = v
            end
        end
    end
    for _, v in pairs(game.Workspace.enemies:GetChildren()) do
        if v:FindFirstChild("Head") ~= nil then
            local m = (Player.Character.Head.Position - v.Head.Position).magnitude
            if m < dist then
                dist = m
                nearest = v
            end
        end
    end
    return nearest
end

_G.farm2 = false

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.farm2 == true then
        local target = getNearest()
        if target ~= nil then
            local currentGroundDistance = groundDistance
            if Player.Character.Humanoid.Health < Player.Character.Humanoid.MaxHealth * 0.50 then
                currentGroundDistance = groundDistance + 300
            end
            game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, target.Head.Position)
            Player.Character.HumanoidRootPart.CFrame = (target.HumanoidRootPart.CFrame * CFrame.new(0, currentGroundDistance + 1, 9))
            _G.globalTarget = target

            if target:FindFirstChildOfClass("Humanoid") then
                target:FindFirstChildOfClass("Humanoid").WalkSpeed = 0
                target:FindFirstChildOfClass("Humanoid").JumpPower = 0
            end

            if not Player.Character:FindFirstChildOfClass("Tool") then
                game:GetService("VirtualInputManager"):SendKeyEvent(true, "Two", false, game)
                game:GetService("VirtualInputManager"):SendKeyEvent(false, "Two", false, game)
            end
        end
    end
end)

spawn(function()
    while wait() do
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        game.Players.LocalPlayer.Character.Torso.Velocity = Vector3.new(0, 0, 0)
    end
end)

while true do
    if _G.farm2 == true and _G.globalTarget ~= nil and _G.globalTarget:FindFirstChild("Head") and Player.Character:FindFirstChildOfClass("Tool") then
        local target = _G.globalTarget
        if Player.Character.Humanoid.Health < Player.Character.Humanoid.MaxHealth * 0.50 then
        else
            game.ReplicatedStorage.Gun:FireServer({
                ["Normal"] = Vector3.new(0, 0, 0),
                ["Direction"] = target.Head.Position,
                ["Name"] = Player.Character:FindFirstChildOfClass("Tool").Name,
                ["Hit"] = target.Head,
                ["Origin"] = target.Head.Position,
                ["Pos"] = target.Head.Position,
            })
        end
    end
    wait(0.1)
end