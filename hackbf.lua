-- GOD UNOTHILES6 HUB V4.5 - (ẨN CẢ HIỆU ỨNG TRÁI ÁC QUỶ)
if not table.find({2753915549, 4442272183, 7449423635, 994732206}, game.PlaceId) then return end

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "GodHub_V45"

_G.HitboxSize = 25
_G.HakiE = false

-- 1. LOGIC BẤT TỬ & ẨN HIỆU ỨNG TUYỆT ĐỐI
RunService.Stepped:Connect(function()
    if player.Character then
        -- XỬ LÝ TÀNG HÌNH & HIỆU ỨNG
        for _, v in pairs(player.Character:GetDescendants()) do
            if _G.SuperInvis then
                -- ẨN THÂN XÁC
                if v:IsA("BasePart") or v:IsA("Decal") then 
                    v.Transparency = 1 
                end
                -- ẨN HIỆU ỨNG (Lửa, khói, hào quang của Trái Ác Quỷ)
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                    v.Enabled = false
                end
                if v:IsA("PointLight") or v:IsA("SpotLight") then
                    v.Enabled = false
                end
            else
                -- HIỆN LẠI KHI TẮT
                if v:IsA("BasePart") or v:IsA("Decal") then 
                    v.Transparency = 0 
                end
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("PointLight") then
                    v.Enabled = true
                end
            end
        end

        -- LOGIC BẤT TỬ (E)
        if _G.HakiE then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
                hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            end
            
            -- HITBOX TẦM ĐÁNH
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
        end
    end
end)

-- 2. GIAO DIỆN (+) VÀNG KÉO THẢ (GIỮ NGUYÊN BẢN 4.4)
local openBtn = Instance.new("TextButton", sg)
openBtn.Size, openBtn.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0, 10, 0.5, -25)
openBtn.BackgroundColor3, openBtn.Text, openBtn.TextColor3 = Color3.fromRGB(200, 160, 0), "+", Color3.new(1,1,1)
openBtn.TextSize, openBtn.Font = 35, Enum.Font.SourceSansBold
Instance.new("UICorner", openBtn)

local main = Instance.new("Frame", sg)
main.Size, main.Position, main.Visible = UDim2.new(0, 220, 0, 260), UDim2.new(0, 70, 0.5, -130), false
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", main)

local function createBtn(text, yPos, varName)
    local btn = Instance.new("TextButton", main)
    btn.Text, btn.Size, btn.Position = text..": OFF", UDim2.new(0, 180, 0, 45), UDim2.new(0, 20, 0, yPos)
    btn.BackgroundColor3, btn.TextColor3 = Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        _G[varName] = not _G[varName]
        btn.Text = text..(_G[varName] and ": ON" or ": OFF")
        btn.BackgroundColor3 = _G[varName] and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(45, 45, 45)
    end)
end

createBtn("Bất tử & Hitbox (E)", 100, "HakiE")
createBtn("Tàng Hình", 160, "SuperInvis")

-- PHÍM TẮT R (TỐC BIẾN) & E (BẬT/TẮT)
UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.R then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(player:GetMouse().Hit.p + Vector3.new(0, 3, 0))
    elseif input.KeyCode == Enum.KeyCode.E then
        _G.HakiE = not _G.HakiE
    end
end)

openBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
