-- GOD UNOTHILES6 HUB V3.4 - (THÔNG BÁO XẾP HÀNG, KHÔNG CHE NHAU)
if not table.find({2753915549, 4442272183, 7449423635, 994732206}, game.PlaceId) then return end

local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "GodHub_V34"

-- 1. KHUNG CHỨA THÔNG BÁO (XẾP HÀNG TỰ ĐỘNG)
local notifyHolder = Instance.new("Frame", sg)
notifyHolder.Size = UDim2.new(0, 250, 0, 300)
notifyHolder.Position = UDim2.new(0.5, -125, 0.05, 0) -- Hiện ở giữa phía trên
notifyHolder.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", notifyHolder)
layout.Padding = UDim.new(0, 5) -- Khoảng cách 5px giữa các dòng
layout.SortOrder = Enum.SortOrder.LayoutOrder

local function notify(msg)
    local txt = Instance.new("TextLabel", notifyHolder)
    txt.Size = UDim2.new(1, 0, 0, 40) -- Chiều cao mỗi dòng
    txt.BackgroundColor3 = Color3.new(0, 0, 0)
    txt.BackgroundTransparency = 0.4
    txt.Text = msg
    txt.TextColor3 = Color3.new(1, 1, 0)
    txt.TextSize = 20 -- Font size 20 theo ý bố
    txt.Font = Enum.Font.SourceSansBold
    txt.TextWrapped = true
    
    local corner = Instance.new("UICorner", txt)
    
    -- Tự xóa sau 4 giây
    task.delay(4, function()
        txt:Destroy()
    end)
end

-- 2. NÚT DẤU CỘNG KÉO THẢ
local openBtn = Instance.new("TextButton", sg)
openBtn.Size, openBtn.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0, 10, 0.5, -25)
openBtn.BackgroundColor3, openBtn.Text = Color3.fromRGB(200, 160, 0), "+"
openBtn.TextColor3, openBtn.TextSize = Color3.new(1, 1, 1), 30
openBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", openBtn)

local dragging, dragStart, startPos
openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, openBtn.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        openBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- 3. MENU CHÍNH
local main = Instance.new("Frame", sg)
main.Size, main.Position = UDim2.new(0, 200, 0, 220), UDim2.new(0, 70, 0.5, -110)
main.BackgroundColor3, main.Visible = Color3.fromRGB(20, 20, 20), false
Instance.new("UICorner", main)

local bar = Instance.new("Frame", main)
bar.Size, bar.BackgroundColor3 = UDim2.new(1, 0, 0, 35), Color3.fromRGB(40, 40, 40)
Instance.new("UICorner", bar)

local hideBtn = Instance.new("TextButton", bar)
hideBtn.Text, hideBtn.Size, hideBtn.Position = "-", UDim2.new(0.2, 0, 1, 0), UDim2.new(0.6, 0, 0, 0)
hideBtn.TextColor3, hideBtn.BackgroundTransparency = Color3.new(1,1,1), 1

local closeBtn = Instance.new("TextButton", bar)
closeBtn.Text, closeBtn.Size, closeBtn.Position = "X", UDim2.new(0.2, 0, 1, 0), UDim2.new(0.8, 0, 0, 0)
closeBtn.TextColor3, closeBtn.BackgroundTransparency = Color3.new(1,0,0), 1

openBtn.MouseButton1Click:Connect(function() if not dragging then main.Visible = not main.Visible end end)
hideBtn.MouseButton1Click:Connect(function() main.Visible = false end)
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

-- 4. TẠO NÚT VỚI THÔNG BÁO XẾP HÀNG
local function createBtn(text, yPos, varName, func)
    local btn = Instance.new("TextButton", main)
    btn.Text = text..": OFF"
    btn.Size, btn.Position = UDim2.new(0, 180, 0, 45), UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3, btn.TextColor3 = Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        _G[varName] = not _G[varName]
        if func then func(_G[varName]) end
        btn.Text = text..(_G[varName] and ": ON" or ": OFF")
        btn.BackgroundColor3 = _G[varName] and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(45, 45, 45)
        notify(text .. " da " .. (_G[varName] and "BAT" or "TAT"))
    end)
end

-- Logic treo máy
task.spawn(function()
    while task.wait(1.5) do
        if _G.AutoChest and player.Character then
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name:find("Chest") and v:IsA("Part") then
                    player.Character.HumanoidRootPart.CFrame = v.CFrame
                    task.wait(1)
                end
            end
        end
    end
end)

createBtn("Auto Rương", 55, "AutoChest")
createBtn("Tàng Hình", 115, "SuperInvis", function(s)
    local char = player.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = s and 1 or 0 end
        end
    end
end)
