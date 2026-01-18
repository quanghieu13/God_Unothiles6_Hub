-- GOD UNOTHILES6 HUB V2.0: ALL SEAS SUPPORT + PRO UI (BY GEMINI)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- 1. KIỂM TRA ID CẢ 3 SEA (SEA 1, 2, 3)
local seaIDs = {2753915549, 4442272183, 7449423635, 994732206}
if not table.find(seaIDs, game.PlaceId) then 
    print("Script khong ho tro ID game nay: " .. game.PlaceId)
    return 
end

-- Trạng thái tính năng
_G.HakiE = false
_G.AutoChest = false
_G.SuperInvis = false
local lastTeleport = 0

-- 2. HỆ THỐNG THÔNG BÁO TRÁI MỚI (3 GIÂY)
local function notifyFruit(name)
    local notice = Instance.new("ScreenGui", player.PlayerGui)
    local txt = Instance.new("TextLabel", notice)
    txt.Size = UDim2.new(1, 0, 0.2, 0)
    txt.Position = UDim2.new(0, 0, 0.1, 0)
    txt.Text = "🌟 PHÁT HIỆN: " .. name .. " 🌟"
    txt.TextColor3 = Color3.new(1, 1, 0)
    txt.TextScaled = true
    txt.BackgroundTransparency = 1
    txt.Font = Enum.Font.SourceSansBold
    task.delay(3, function() notice:Destroy() end)
end

workspace.ChildAdded:Connect(function(child)
    if child.Name:find("Fruit") or child.Name:find("Physical") then
        notifyFruit(child.Name)
    end
end)

-- 3. GIAO DIỆN MENU (LINK ẢNH AVATAR CỦA BỐ)
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "GodUnothiles6_V20"

local iconOpen = Instance.new("ImageButton", sg)
iconOpen.Size = UDim2.new(0, 60, 0, 60)
iconOpen.Position = UDim2.new(0, 10, 0.5, -30)
iconOpen.Image = "https://i.postimg.cc/sDb66DZ8/avater.jpg"
iconOpen.BackgroundTransparency = 1

local mainFrame = Instance.new("Frame", sg)
mainFrame.Size = UDim2.new(0, 200, 0, 220)
mainFrame.Position = UDim2.new(0, 80, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = false

local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Text = "GOD HUB V2.0"
titleText.Size = UDim2.new(0.6, 0, 1, 0)
titleText.TextColor3 = Color3.new(1, 1, 1)
titleText.BackgroundTransparency = 1

local hideBtn = Instance.new("TextButton", titleBar)
hideBtn.Text = "-"
hideBtn.Size = UDim2.new(0.2, 0, 1, 0)
hideBtn.Position = UDim2.new(0.6, 0, 0, 0)
hideBtn.TextColor3 = Color3.new(1, 1, 1)
hideBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0.2, 0, 1, 0)
closeBtn.Position = UDim2.new(0.8, 0, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

iconOpen.MouseButton1Click:Connect(function() mainFrame.Visible = true end)
hideBtn.MouseButton1Click:Connect(function() mainFrame.Visible = false end)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

local function createBtn(name, pos, callback)
    local btn = Instance.new("TextButton", mainFrame)
    btn.Text = name .. ": TẮT"
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.MouseButton1Click:Connect(function()
        local res = callback()
        btn.Text = name .. (res and ": BẬT" or ": TẮT")
        btn.BackgroundColor3 = res and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(45, 45, 45)
    end)
end

-- 4. LOGIC TÀNG HÌNH & AUTO RƯƠNG
local function toggleSuperInvis()
    _G.SuperInvis = not _G.SuperInvis
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = _G.SuperInvis and 1 or 0
            end
        end
        if char:FindFirstChild("Humanoid") then
            char.Humanoid.DisplayDistanceType = _G.SuperInvis and Enum.HumanoidDisplayDistanceType.None or Enum.HumanoidDisplayDistanceType.Viewer
        end
    end
    return _G.SuperInvis
end

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
        task.wait(0.5)
    end
end)

-- 5. PHÍM TẮT E VÀ R
UserInputService.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.E then
        _G.HakiE = not _G.HakiE
        game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Haki E", Text = _G.HakiE and "Bật Soi & Né" or "Tắt", Duration = 2})
    elseif input.KeyCode == Enum.KeyCode.R and not gpe then
        if tick() - lastTeleport >= 5 and mouse.Hit then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
            lastTeleport = tick()
        end
    end
end)

RunService.Stepped:Connect(function()
    if _G.HakiE and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- Tạo nút bấm trên Menu
createBtn("Auto Rương", UDim2.new(0, 10, 0, 50), function() _G.AutoChest = not _G.AutoChest return _G.AutoChest end)
createBtn("Tàng Hình 100%", UDim2.new(0, 10, 0, 110), toggleSuperInvis)
