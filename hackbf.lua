-- GOD UNOTHILES6 HUB V4.8 - (1 CLICK = 20 NHÁT ĐẤM)
if not table.find({2753915549, 4442272183, 7449423635, 994732206}, game.PlaceId) then return end

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "GodHub_V48"

_G.HitboxSize = 25
_G.HakiE = false

-- 1. LOGIC 1 CLICK = 20 PHÁT ĐẤM (MULTI-PUNCH)
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end -- Không chạy khi đang chat
    
    -- Khi bố nhấn chuột trái (M1)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and _G.HakiE then
        task.spawn(function()
            for i = 1, 20 do -- Vòng lặp 20 lần
                local tool = player.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate() -- Kích hoạt đòn đánh
                end
                task.wait(0.01) -- Khoảng nghỉ cực ngắn giữa các cú đấm
            end
        end)
    end
end)

-- 2. LOGIC BẤT TỬ & HITBOX (GIỮ NGUYÊN ĐỂ HỖ TRỢ CHIẾN ĐẤU)
RunService.Stepped:Connect(function()
    if _G.HakiE and player.Character then
        -- Hồi máu thần tốc
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
        
        -- Mở rộng tầm đánh để 20 cú đấm đều dính quái
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
end)

-- [PHẦN UI VÀ PHÍM TẮT R GIỮ NGUYÊN NHƯ CÁC BẢN TRƯỚC]
