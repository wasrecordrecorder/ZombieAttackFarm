-- Создаем новый ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MovableGui"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем Frame (основной контейнер)
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Parent = screenGui

-- Закругляем края Frame
local roundedCorner = Instance.new("UICorner")
roundedCorner.CornerRadius = UDim.new(0, 15)
roundedCorner.Parent = frame

-- Создаем надпись "Created by was_record"
local createdByText = Instance.new("TextLabel")
createdByText.Name = "CreatedByText"
createdByText.Size = UDim2.new(1, 0, 0, 20)
createdByText.Position = UDim2.new(0, 0, 0, 0)
createdByText.BackgroundTransparency = 1
createdByText.Text = "Created by was_record"
createdByText.TextColor3 = Color3.fromRGB(180, 180, 180) -- Светло-серый цвет
createdByText.Font = Enum.Font.GothamBold -- Жирный шрифт
createdByText.TextSize = 14
createdByText.TextXAlignment = Enum.TextXAlignment.Center
createdByText.Parent = frame

-- Создаем кнопку внутри GUI
local button = Instance.new("TextButton")
button.Name = "Button"
button.Size = UDim2.new(0, 100, 0, 50)
button.Position = UDim2.new(0, 10, 0, 30) -- Смещение кнопки ниже надписи
button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
button.Text = "Off"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.Gotham
button.TextSize = 18
button.Parent = frame

-- Закругляем края кнопки
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 10)
buttonCorner.Parent = button

-- Переменная для отслеживания состояния кнопки
local isOn = false

-- Получаем TweenService
local TweenService = game:GetService("TweenService")

-- Функция для создания анимации
local function createTween(instance, properties, duration)
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    return tween
end

-- Функция для переключения состояния кнопки
local function toggleButton()
    isOn = not isOn
    if isOn then
        local tween = createTween(button, {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}, 0.5)
        tween:Play()
        button.Text = "On"
    else
        local tween = createTween(button, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.5)
        tween:Play()
        button.Text = "Off"
    end
end

-- Обработчик нажатия кнопки
button.Activated:Connect(toggleButton)

-- Анимация нажатия кнопки
button.MouseButton1Down:Connect(function()
    local tween = createTween(button, {Size = UDim2.new(0, 90, 0, 45), BackgroundColor3 = Color3.fromRGB(80, 80, 80)}, 0.1)
    tween:Play()
end)

button.MouseButton1Up:Connect(function()
    local tween = createTween(button, {Size = UDim2.new(0, 100, 0, 50), BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.1)
    tween:Play()
end)

-- Создаем вторую кнопку для открытия/закрытия GUI
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(1, -150, 0.5, -25) -- По центру правой части экрана
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.Text = "Toggle GUI"
toggleButton.TextColor3 = Color3.fromRGB(180, 180, 180)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 18
toggleButton.Parent = screenGui

-- Закругляем края второй кнопки
local toggleButtonCorner = Instance.new("UICorner")
toggleButtonCorner.CornerRadius = UDim.new(0, 10)
toggleButtonCorner.Parent = toggleButton

-- Функция для переключения видимости GUI с анимацией
local function toggleGuiVisibility()
    if frame.Visible then
        local tweenFrame = createTween(frame, {BackgroundTransparency = 1}, 0.5)
        local tweenText = createTween(createdByText, {TextTransparency = 1}, 0.5)
        local tweenButton = createTween(button, {BackgroundTransparency = 1, TextTransparency = 1}, 0.5)
        tweenFrame:Play()
        tweenText:Play()
        tweenButton:Play()
        tweenFrame.Completed:Connect(function()
            frame.Visible = false
            frame.BackgroundTransparency = 0
            createdByText.TextTransparency = 0
            button.BackgroundTransparency = 0
            button.TextTransparency = 0
        end)
    else
        frame.Visible = true
        local tweenFrame = createTween(frame, {BackgroundTransparency = 0}, 1.5)
        local tweenText = createTween(createdByText, {TextTransparency = 0}, 3.0)
        local tweenButton = createTween(button, {BackgroundTransparency = 0, TextTransparency = 0}, 1.0)
        tweenFrame:Play()
        tweenText:Play()
        tweenButton:Play()
    end
end

-- Обработчик нажатия второй кнопки
toggleButton.Activated:Connect(toggleGuiVisibility)

-- Анимация нажатия второй кнопки
toggleButton.MouseButton1Down:Connect(function()
    local tween = createTween(toggleButton, {Size = UDim2.new(0, 90, 0, 45), BackgroundColor3 = Color3.fromRGB(80, 80, 80)}, 0.1)
    tween:Play()
end)

toggleButton.MouseButton1Up:Connect(function()
    local tween = createTween(toggleButton, {Size = UDim2.new(0, 100, 0, 50), BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, 0.1)
    tween:Play()
end)

-- Перемещение второй кнопки
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

-- Перемещение GUI
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