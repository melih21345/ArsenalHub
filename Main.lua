-- ARSENAL HUB V2
-- GUI + DRAG SYSTEM

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Eski paneli sil
local old = PlayerGui:FindFirstChild("ArsenalHub")
if old then old:Destroy() end

-- Ana GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArsenalHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Panel
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 300)
Frame.Position = UDim2.new(0.5, -160, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Frame

-- Baslik
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "ARSENAL HUB V2"
Title.TextColor3 = Color3.fromRGB(255, 60, 60)
Title.TextSize = 23
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- PANEL SURUKLEME
local dragging = false
local dragStart
local startPos

Title.Active = true

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
    end
end)

Title.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- BUTON SISTEMI
local function CreateButton(text, y)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 280, 0, 45)
    Button.Position = UDim2.new(0, 20, 0, y)
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.Font = Enum.Font.GothamBold
    Button.Text = text .. " : OFF"
    Button.Parent = Frame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = Button

    local enabled = false

    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Button.Text = text .. " : ON"
            Button.BackgroundColor3 = Color3.fromRGB(30, 120, 60)
        else
            Button.Text = text .. " : OFF"
            Button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        end
    end)

    return Button
end

CreateButton("AIMLOCK", 65)
CreateButton("PLAYER ESP", 120)
CreateButton("NO RECOIL", 175)

-- PANEL AC / KAPAT
UIS.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        Frame.Visible = not Frame.Visible
    end
end)

print("ARSENAL HUB V2 YUKLENDI!")