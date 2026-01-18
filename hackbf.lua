-- BLOX FRUITS V1.9: SUPER INVISIBLE (HIDE NAME & BODY) + ID CHECK
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- 1. CHỐT CHẶN ID GAME
if game.PlaceId ~= 994732206 then return end

_G.HakiE = false
_G.AutoChest = false
_G.SuperInvis = false
local lastTeleport = 0

-- --- 2. HÀM TÀNG HÌNH SIÊU CẤP (ẨN CẢ TÊN) ---
local function toggleSuperInvis()
    _G.SuperInvis = not _G.SuperInvis
    local char = player.Character
    if char then
        -- ẨN THÂN XÁC
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = _G.SuperInvis and 1 or 0
            end
        end
        -- MẸO ẨN TÊN: Đẩy bảng tên đi chỗ khác hoặc làm mờ Head
        if char:FindFirstChild("Head") then
            char.Head.CanCollide = false
            -- Khi tàng hình, ta cho cái tên biến mất bằng cách tác động vào Humanoid
            char.Humanoid.DisplayDistanceType = _G.SuperInvis and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
        end
    end
    return _G.SuperInvis
end

-- --- 3. GIAO DIỆN (GIỮ NGUYÊN STYLE CỦA BỐ) ---
local sg = Instance.new("ScreenGui", player.PlayerGui)
local iconOpen = Instance.new("ImageButton", sg)
iconOpen.Size = UDim2.new(0, 60, 0, 60)
iconOpen.Position = UDim2.new(0, 10, 0.5, -30)
iconOpen.Image = "https://i.postimg.cc/sDb66DZ8/avater.jpg"
iconOpen.BackgroundTransparency = 1

local mainFrame = Instance.new("Frame", sg)
mainFrame.Size = UDim2.new(0, 200, 0, 220)
mainFrame.Position = UDim2.new(0, 80, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.Visible = false

-- Thanh tiêu đề với nút - và X
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

local hideBtn = Instance.new("TextButton", titleBar)
hideBtn.Text = "-"
hideBtn.Size = UDim2.new(0.2, 0, 1, 0)
hideBtn.Position = UDim2.new(0.6, 0, 0, 0)
hideBtn.TextColor3 = Color3.new(1,1,1)
hideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0.2, 0, 1, 0)
closeBtn.Position = UDim2.new(0.8, 0, 0, 0)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

iconOpen.MouseButton1Click:Connect(function() mainFrame.Visible = true end)
hideBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local function createBtn(name, pos, callback)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Text = name .. ": TẮT"
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(function()
        local res = callback()
        btn.Text = name .. (res and ": BẬT" or ": TẮT")
        btn.BackgroundColor3 = res and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
    end)
end

-- --- 4. LOGIC (GIỮ PHÍM E, R VÀ AUTO CHEST) ---
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        _G.HakiE = not _G.HakiE
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Haki E", Text = _G.HakiE and "Bật Soi & Né" or "Tắt", Duration = 2})
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.R and not gpe then
        if tick() - lastTeleport >= 5 and mouse.Hit then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
            lastTeleport = tick()
        end
    end
end)

task.spawn(function()
    while true do
        if _G.AutoChest and player.Character then
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name:find("Chest") and v:IsA("Part") then
                    player.Character.HumanoidRootPart.CFrame = v.CFrame
                    task.wait(1)
                end
            end
        end
        task.wait(0.1)
    end
end)

RunService.Stepped:Connect(function()
    if _G.HakiE and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

createBtn("Auto Rương (G)", UDim2.new(0, 10, 0, 50), function() _G.AutoChest = not _G.AutoChest return _G.AutoChest end)
createBtn("Tàng Hình 100%", UDim2.new(0, 10, 0, 110), toggleSuperInvis)
