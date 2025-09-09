-- Roblox Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI через Fluent
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawiddevr/Fluent/master/source.lua"))()

local Window = Fluent:CreateWindow({
    Title = "YanGUI | Collector",
    SubTitle = "By Dev",
    TabWidth = 120,
    Size = UDim2.fromOffset(500, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Collect = Window:AddTab({ Title = "Auto Collect", Icon = "Box" }),
    Fruits = Window:AddTab({ Title = "Auto Fruits", Icon = "Apple" }),
}

-- Тогглы
local autoCollect = false
local autoFruits = false

Tabs.Collect:AddToggle("CollectToggle", {
    Title = "Enable Auto Collect (Barrels/Crates)",
    Default = false,
    Callback = function(state)
        autoCollect = state
    end
})

Tabs.Fruits:AddToggle("FruitToggle", {
    Title = "Enable Auto Fruits",
    Default = false,
    Callback = function(state)
        autoFruits = state
    end
})

-- Функция тп и клика
local function tpAndClick(obj)
    if obj and obj:IsA("BasePart") then
        hrp.CFrame = obj.CFrame + Vector3.new(0, 3, 0)
        local cd = obj:FindFirstChildOfClass("ClickDetector")
        if cd then
            fireclickdetector(cd)
        end
    elseif obj:IsA("Model") and obj.PrimaryPart then
        hrp.CFrame = obj.PrimaryPart.CFrame + Vector3.new(0, 3
