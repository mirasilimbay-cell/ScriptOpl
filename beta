-- LocalScript -> StarterPlayerScripts
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Bowl CFrame (your values)
local bowlCFrame = CFrame.new(
    1993.2998, 218.693359, 563.104553,
    1, 0, 0,
    0, 1, 0,
    0, 0, 1
)

-- Create GUI (idempotent)
local function createGUI()
    if PlayerGui:FindFirstChild("FluentTPGui") then
        return PlayerGui:FindFirstChild("FluentTPGui")
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FluentTPGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = PlayerGui

    -- Window
    local window = Instance.new("Frame")
    window.Name = "Window"
    window.Size = UDim2.new(0, 340, 0, 120)
    window.Position = UDim2.new(0.5, -170, 0.85, -60) -- centered bottom by default
    window.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    window.BorderSizePixel = 0
    window.Parent = screenGui

    -- Rounded corners + stroke (Fluent-ish)
    local corner = Instance.new("UICorner", window)
    corner.CornerRadius = UDim.new(0, 12)
    local stroke = Instance.new("UIStroke", window)
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(40, 40, 40)
    stroke.Transparency = 0.12

    -- Subtle top gradient (acrylic feel)
    local grad = Instance.new("UIGradient", window)
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    }
    grad.Rotation = 90

    -- Header (draggable)
    local header = Instance.new("Frame", window)
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 36)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundTransparency = 1

    local title = Instance.new("TextLabel", header)
    title.Size = UDim2.new(1, -12, 1, 0)
    title.Position = UDim2.new(0, 12, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Yaniez — Teleport"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Color3.fromRGB(226, 226, 226)
    title.TextXAlignment = Enum.TextXAlignment.Left

    -- Small subtitle
    local subtitle = Instance.new("TextLabel", header)
    subtitle.Size = UDim2.new(1, -12, 1, 0)
    subtitle.Position = UDim2.new(0, 12, 0, 18)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Click button to TP to Bowl"
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextSize = 12
    subtitle.TextColor3 = Color3.fromRGB(170, 170, 170)
    subtitle.TextXAlignment = Enum.TextXAlignment.Left

    -- TP Button
    local tpBtn = Instance.new("TextButton", window)
    tpBtn.Name = "TPButton"
    tpBtn.Size = UDim2.new(0, 140, 0, 40)
    tpBtn.Position = UDim2.new(0, 18, 0, 56)
    tpBtn.AutoButtonColor = true
    tpBtn.BackgroundColor3 = Color3.fromRGB(28, 120, 230)
    tpBtn.TextColor3 = Color3.fromRGB(255,255,255)
    tpBtn.Font = Enum.Font.GothamBold
    tpBtn.TextSize = 14
    tpBtn.Text = "TP to Bowl"

    local tpCorner = Instance.new("UICorner", tpBtn)
    tpCorner.CornerRadius = UDim.new(0, 8)

    -- Small hint text
    local hint = Instance.new("TextLabel", window)
    hint.Size = UDim2.new(0, 160, 0, 36)
    hint.Position = UDim2.new(0, 176, 0, 56)
    hint.BackgroundTransparency = 1
    hint.Text = "Drag the header to move"
    hint.Font = Enum.Font.Gotham
    hint.TextSize = 12
    hint.TextColor3 = Color3.fromRGB(160,160,160)
    hint.TextXAlignment = Enum.TextXAlignment.Left

    -- Teleport logic (robust to respawns)
    local function teleportToCFrame(cf)
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
        -- Try to set CFrame safely:
        pcall(function()
            hrp.CFrame = cf
        end)
    end

    tpBtn.MouseButton1Click:Connect(function()
        teleportToCFrame(bowlCFrame)
    end)

    -- Draggable behavior (drag by header)
    local dragging = false
    local dragStart = Vector2.new()
    local startPos = UDim2.new()

    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = window.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            -- keep a reference to movement input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            window.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    return screenGui
end

local gui = createGUI()

-- Recreate GUI if PlayerGui gets cleared on respawn (safe-guard)
player.CharacterAdded:Connect(function()
    task.delay(0.8, function()
        if not PlayerGui:FindFirstChild("FluentTPGui") then
            createGUI()
        end
    end)
end)
