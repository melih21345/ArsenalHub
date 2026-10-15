--[[
    ARSENAL HUB V3
    GUI SYSTEM

    Ozellikler:
    - Suruklenebilir panel
    - RightShift ile ac/kapat
    - X ile panel gizleme
    - ON/OFF butonlari
    - Eski GUI temizleme

    Not:
    AIMLOCK, ESP ve NO RECOIL
    su anda yalnizca arayuz butonlaridir.
]]

-- SERVISLER

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ESKI SISTEMI TEMIZLE

-- Onceki calistirmadan kalan event baglantilarini kapat
if _G.ArsenalHubCleanup then
    _G.ArsenalHubCleanup()
end

local connections = {}

local function Connect(signal, callback)
    local connection = signal:Connect(callback)

    table.insert(connections, connection)

    return connection
end

_G.ArsenalHubCleanup = function()

    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end

    local oldGui = PlayerGui:FindFirstChild("ArsenalHub")

    if oldGui then
        oldGui:Destroy()
    end

end

-- ANA GUI

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "ArsenalHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- ANA PANEL

local Frame = Instance.new("Frame")

Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 320, 0, 300)
Frame.Position = UDim2.new(0.5, -160, 0.5, -150)

Frame.BackgroundColor3 = Color3.fromRGB(22, 22, 28)

Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Parent = ScreenGui

-- YUVARLAK KOSELER

local Corner = Instance.new("UICorner")

Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = Frame

-- BASLIK

local Title = Instance.new("TextLabel")

Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 0, 50)
Title.Position = UDim2.new(0, 10, 0, 0)

Title.BackgroundTransparency = 1

Title.Text = "ARSENAL HUB V3"

Title.TextColor3 = Color3.fromRGB(255, 60, 60)

Title.TextSize = 22
Title.Font = Enum.Font.GothamBold

Title.Parent = Frame

-- SURUKLEME SISTEMI

local dragging = false
local dragStart = nil
local startPos = nil

Title.Active = true

-- Fareye basildiginda
Connect(Title.InputBegan, function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then

        dragging = true

        dragStart = input.Position
        startPos = Frame.Position

    end

end)

-- Fare birakildiginda
Connect(UIS.InputEnded, function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end

end)

-- Fare hareket ettiginde
Connect(UIS.InputChanged, function(input)

    if not dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement then
        return
    end

    if not dragStart or not startPos then
        return
    end

    local delta = input.Position - dragStart

    Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
    )

end)

-- BUTON SISTEMI

local Settings = {
    Aimlock = false,
    ESP = false,
    NoRecoil = false
}

local function CreateButton(text, settingName, y)

    local Button = Instance.new("TextButton")

    Button.Name = settingName .. "Button"

    Button.Size = UDim2.new(0, 280, 0, 45)
    Button.Position = UDim2.new(0, 20, 0, y)

    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 50)

    Button.TextColor3 = Color3.fromRGB(255, 255, 255)

    Button.TextSize = 16
    Button.Font = Enum.Font.GothamBold

    Button.Text = text .. " : OFF"

    Button.Parent = Frame

    -- Yuvarlak koseler

    local ButtonCorner = Instance.new("UICorner")

    ButtonCorner.CornerRadius = UDim.new(0, 6)
    ButtonCorner.Parent = Button

    -- Buton gorunumunu guncelle

    local function UpdateButton()

        if Settings[settingName] then

            Button.Text = text .. " : ON"

            Button.BackgroundColor3 =
            Color3.fromRGB(30, 120, 60)

        else

            Button.Text = text .. " : OFF"

            Button.BackgroundColor3 =
            Color3.fromRGB(45, 45, 50)

        end

    end

    -- Butona tiklandiginda

    Connect(Button.MouseButton1Click, function()

        Settings[settingName] = not Settings[settingName]

        UpdateButton()

        print(
                settingName,
                Settings[settingName] and "ON" or "OFF"
        )

    end)

    return Button

end

-- BUTONLARI OLUSTUR

CreateButton("AIMLOCK", "Aimlock", 65)

CreateButton("PLAYER ESP", "ESP", 120)

CreateButton("NO RECOIL", "NoRecoil", 175)

-- X KAPATMA BUTONU

local CloseButton = Instance.new("TextButton")

CloseButton.Name = "CloseButton"

CloseButton.Size = UDim2.new(0, 35, 0, 35)

CloseButton.Position = UDim2.new(1, -42, 0, 7)

CloseButton.BackgroundColor3 = Color3.fromRGB(180, 40, 40)

CloseButton.Text = "X"

CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)

CloseButton.TextSize = 18
CloseButton.Font = Enum.Font.GothamBold

CloseButton.Parent = Frame

-- Kose ayari

local CloseCorner = Instance.new("UICorner")

CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- X'e basildiginda paneli gizle

Connect(CloseButton.MouseButton1Click, function()

    Frame.Visible = false

end)

-- KLAVYE SISTEMI

Connect(UIS.InputBegan, function(input, processed)

    -- Oyuncu sohbet kutusuna yaziyorsa calisma
    if processed then
        return
    end

    -- RightShift ile paneli ac/kapat
    if input.KeyCode == Enum.KeyCode.RightShift then

        Frame.Visible = not Frame.Visible

    end

end)

-- BASLANGIC MESAJI

print("--------------------------------")
print("ARSENAL HUB V3")
print("GUI BASARIYLA YUKLENDI")
print("RIGHT SHIFT = PANEL AC/KAPAT")
print("--------------------------------")