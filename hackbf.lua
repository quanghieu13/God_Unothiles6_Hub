-- GOD UNOTHILES6 HUB V5.0 - FULL FIX (ICON + UI + HITBOX + IMMORTAL)
if not table.find({2753915549, 4442272183, 7449423635, 994732206}, game.PlaceId) then return end

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- XÓA UI CŨ NẾU CÓ
if player.PlayerGui:FindFirstChild("GodHub_V50") then
    player.PlayerGui.GodHub_V50:Destroy()
end

local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "GodHub_V50"
sg.ResetOnSpawn = false

_G.HitboxSize = 25
_G.HakiE = false
_G.SuperInvis = false

-- 1. ICON (+) VÀNG (CÁI NÀY PHẢI HIỆN ĐẦU TIÊN)
local openBtn = Instance.new("TextButton", sg)
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 10, 0.5, -25)
openBtn.BackgroundColor3 = Color3.fromRGB(200, 160, 0)
openBtn.Text = "+"
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.TextSize = 35
openBtn.Font = Enum.Font.SourceSansBold
local corner = Instance.new("UICorner", openBtn)
corner.CornerRadius = UDim.new(0, 10)

-- 2. MENU CHÍNH (MẶC ĐỊNH ẨN)
local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 220, 0, 280)
main.Position = UDim2.new(0, 70, 0.5, -140)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Visible = false
Instance.new("UICorner", main)

-- Ô NHẬP HITBOX
local label = Instance.new("TextLabel", main)
label.Text = "TẦM ĐÁNH (HITBOX):"
label.Size = UDim2.new(1, 0, 0, 30)
label.Position = UDim2.new(0, 0, 0, 10)
label.TextColor3 = Color3.new(1, 1, 1)
label.BackgroundTransparency = 1

local box = Instance.new("TextBox", main)
box.Size = UDim2.new(0, 180, 0, 40)
box.Position = UDim2.new(0, 20, 0, 45)
box.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
box.TextColor3 = Color3.new(0, 1, 0)
box.Text = "25"
box.TextSize = 25
Instance.new("UICorner", box)
box.FocusLost:Connect(function()
    _G.HitboxSize = tonumber(box.Text) or 25
end)

-- HÀM TẠO NÚT
local function createBtn(text, yPos, varName)
    local btn = Instance.new("TextButton", main)
    btn.Text = text..": OFF"
    btn.Size = UDim2.new(0, 180, 0, 45)
    btn.Position = UDim2.new(0, 20, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        _G[varName] = not _G[varName]
        btn.Text = text..(_G[varName] and ": ON" or ": OFF")
        btn.BackgroundColor3 = _G[varName] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
    end)
end

createBtn("Bất tử/Hitbox (E)", 100, "HakiE")
createBtn("Tàng Hình", 160, "SuperInvis")

-- NÚT ĐÓNG MENU
local close = Instance.new("TextButton", main)
close.Text = "TẮT SCRIPT (X)"
close.Size = UDim2.new(0, 180, 0, 35)
close.Position = UDim2.new(0, 20, 0, 225)
close.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
close.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", close)
close.MouseButton1Click:Connect(function() sg:Destroy() end)

-- 3. LOGIC KÉO THẢ & CLICK ICON
openBtn.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- 4. LOGIC CHIẾN ĐẤU & MULTI-PUNCH (1 CLICK = 20)
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    -- R = Teleport
    if input.KeyCode == Enum.KeyCode.R then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(player:GetMouse().Hit.p + Vector3.new(0, 3, 0))
    -- E = Toggle
    elseif input.KeyCode == Enum.KeyCode.E then
        _G.HakiE = not _G.HakiE
    -- M1 = Multi Punch
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 and _G.HakiE then
        task.spawn(function()
            for i = 1, 20 do
                local tool = player.Character:FindFirstChildOfClass("Tool")
                if tool then tool:Activate() end
                task.wait(0.01)
            end
        end)
    end
end)

-- 5. VÒNG LẶP STEPPED (BẤT TỬ + TÀNG HÌNH + HITBOX)
RunService.Stepped:Connect(function()
    if player.Character then
        -- TÀNG HÌNH
        for _, v in pairs(player.Character:GetDescendants()) do
            if _G.SuperInvis then
                if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = 1 end
                if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = false end
            else
                if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = (v.Name == "HumanoidRootPart" and 1 or 0) end
                if v:IsA("ParticleEmitter") or v:IsA("Trail") then v.Enabled = true end
            end
        end
        -- BẤT TỬ & HITBOX
        if _G.HakiE then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
            
            local enemies = workspace:FindFirstChild("Enemies") or workspace
            for _, v in pairs(enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if dist <= _G.HitboxSize then
                        v.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                        v.HumanoidRootPart.Transparency = 0.8
                        v.HumanoidRootPart.CanCollide = false
                    end
                end
            end
        end
    end
end)
