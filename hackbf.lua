-- GOD UNOTHILES6 HUB V5.4 - BẢN ĐẦY ĐỦ NHẤT (KHÔNG CẦN DÁN THÊM)
if not table.find({2753915549, 4442272183, 7449423635, 994732206}, game.PlaceId) then return end

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- 1. XÓA UI CŨ TRÁNH CHỒNG CHÉO
if player.PlayerGui:FindFirstChild("GodHub_V54") then
    player.PlayerGui.GodHub_V54:Destroy()
end

local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "GodHub_V54"
sg.ResetOnSpawn = false

_G.HitboxSize = 25
_G.HakiE = false
_G.SuperInvis = false

-- 2. GIAO DIỆN ICON (+) VÀNG
local openBtn = Instance.new("TextButton", sg)
openBtn.Size, openBtn.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0, 10, 0.5, -25)
openBtn.BackgroundColor3, openBtn.Text, openBtn.TextColor3 = Color3.fromRGB(200, 160, 0), "+", Color3.new(1,1,1)
openBtn.TextSize, openBtn.Font = 35, Enum.Font.SourceSansBold
Instance.new("UICorner", openBtn)

-- 3. MENU CHÍNH
local main = Instance.new("Frame", sg)
main.Size, main.Position, main.Visible = UDim2.new(0, 220, 0, 280), UDim2.new(0, 70, 0.5, -140), false
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", main)

-- Ô NHẬP HITBOX
local label = Instance.new("TextLabel", main)
label.Text, label.Size, label.Position = "TẦM ĐÁNH (HITBOX):", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 10)
label.TextColor3, label.BackgroundTransparency = Color3.new(1, 1, 1), 1

local box = Instance.new("TextBox", main)
box.Size, box.Position, box.Text = UDim2.new(0, 180, 0, 40), UDim2.new(0, 20, 0, 45), tostring(_G.HitboxSize)
box.BackgroundColor3, box.TextColor3, box.TextSize = Color3.fromRGB(40, 40, 40), Color3.new(0, 1, 0), 25
Instance.new("UICorner", box)
box.FocusLost:Connect(function() _G.HitboxSize = tonumber(box.Text) or 25 end)

-- NÚT BẬT/TẮT TÍNH NĂNG
local function createBtn(text, yPos, varName)
    local btn = Instance.new("TextButton", main)
    btn.Text, btn.Size, btn.Position = text..": OFF", UDim2.new(0, 180, 0, 45), UDim2.new(0, 20, 0, yPos)
    btn.BackgroundColor3, btn.TextColor3 = Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        _G[varName] = not _G[varName]
        btn.Text = text..(_G[varName] and ": ON" or ": OFF")
        btn.BackgroundColor3 = _G[varName] and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 45)
    end)
end

createBtn("Bất tử/Hitbox (E)", 100, "HakiE")
createBtn("Tàng Hình", 160, "SuperInvis")

local closeBtn = Instance.new("TextButton", main)
closeBtn.Text, closeBtn.Size, closeBtn.Position = "DỪNG SCRIPT (X)", UDim2.new(0, 180, 0, 35), UDim2.new(0, 20, 0, 225)
closeBtn.BackgroundColor3, closeBtn.TextColor3 = Color3.fromRGB(150, 0, 0), Color3.new(1,1,1)
Instance.new("UICorner", closeBtn)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

openBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)

-- 4. LOGIC PHÍM TẮT & MULTI-PUNCH (1 CLICK = 20 PHÁT)
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.R then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(player:GetMouse().Hit.p + Vector3.new(0, 3, 0))
    elseif input.KeyCode == Enum.KeyCode.E then
        _G.HakiE = not _G.HakiE
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
        -- TÀNG HÌNH & HIỆU ỨNG (GHOST MODE)
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
            if hum then
                if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
                -- VÔ HIỆU HÓA ĐIỂM YẾU (PHANTOM)
                if player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.CanTouch = false
                end
            end
            
            -- QUÉT QUÁI VÀO VÙNG HITBOX
            local enemies = workspace:FindFirstChild("Enemies") or workspace
            for _, v in pairs(enemies:GetChildren()) do
                if v:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                    if dist <= _G.HitboxSize then
                        v.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                        v.HumanoidRootPart.Transparency = 0.8
                        v.HumanoidRootPart.CanCollide = false
                    else
                        v.HumanoidRootPart.Size = Vector3.new(2, 2, 2)
                        v.HumanoidRootPart.Transparency = 1
                    end
                end
            end
        elseif player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CanTouch = true
        end
    end
end)
