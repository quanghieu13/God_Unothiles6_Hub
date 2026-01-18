-- GOD UNOTHILES6 HUB V3.6 - ULTIMATE EDITION (FULL FEATURES)
if not table.find({2753915549, 4442272183, 7449423635, 994732206}, game.PlaceId) then return end

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")
local RunService = game:GetService("RunService")
local sg = Instance.new("ScreenGui", player.PlayerGui)
sg.Name = "GodHub_V36_Ultimate"

-- 1. THÔNG BÁO XẾP HÀNG (FONT 20, WRAPPED)
local notifyHolder = Instance.new("Frame", sg)
notifyHolder.Size, notifyHolder.Position = UDim2.new(0, 280, 0, 300), UDim2.new(0.5, -140, 0.05, 0)
notifyHolder.BackgroundTransparency = 1
local layout = Instance.new("UIListLayout", notifyHolder)
layout.Padding, layout.SortOrder = UDim.new(0, 5), Enum.SortOrder.LayoutOrder

local function notify(msg)
    local txt = Instance.new("TextLabel", notifyHolder)
    txt.Size, txt.BackgroundColor3, txt.BackgroundTransparency = UDim2.new(1, 0, 0, 45), Color3.new(0,0,0), 0.4
    txt.Text, txt.TextColor3, txt.TextSize = msg, Color3.new(1, 1, 0), 20
    txt.Font, txt.TextWrapped = Enum.Font.SourceSansBold, true
    Instance.new("UICorner", txt)
    task.delay(4, function() txt:Destroy() end)
end

-- 2. SOI TRÁI ÁC QUỶ (FRUIT NOTIFIER)
task.spawn(function()
    while task.wait(5) do
        for _, v in pairs(workspace:GetChildren()) do
            if v:IsA("Tool") and (v.Name:find("Fruit") or v:FindFirstChild("Handle")) then
                local dist = math.floor((player.Character.HumanoidRootPart.Position - v.Handle.Position).Magnitude)
                notify("🍎 PHÁT HIỆN: " .. v.Name .. " (" .. dist .. "m)")
            end
        end
    end
end)

-- 3. FIX PHÍM E (NÉ) & PHÍM R (TELEPORT) - CHẶN CHIÊU GAME
local function handleActions(actionName, inputState, inputObj)
    if inputState == Enum.UserInputState.Begin then
        if actionName == "HakiAction" then
            _G.HakiE = not _G.HakiE
            notify("Haki Né: " .. (_G.HakiE and "BẬT" or "TẮT"))
        elseif actionName == "TeleportAction" then
            local mouse = player:GetMouse()
            player.Character.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 3, 0))
            notify("Đã Tốc Biến!")
        end
    end
    return Enum.ContextActionResult.Sink
end
CAS:BindAction("HakiAction", handleActions, false, Enum.KeyCode.E)
CAS:BindAction("TeleportAction", handleActions, false, Enum.KeyCode.R)

RunService.Stepped:Connect(function()
    if _G.HakiE and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

-- 4. GIAO DIỆN CHÍNH & KÉO THẢ
local openBtn = Instance.new("TextButton", sg)
openBtn.Size, openBtn.Position = UDim2.new(0, 50, 0, 50), UDim2.new(0, 10, 0.5, -25)
openBtn.BackgroundColor3, openBtn.Text = Color3.fromRGB(200, 160, 0), "+"
openBtn.TextColor3, openBtn.TextSize = Color3.new(1,1,1), 30
Instance.new("UICorner", openBtn)

local dragging, dragStart, startPos
openBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging, dragStart, startPos = true, input.Position, openBtn.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        openBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local main = Instance.new("Frame", sg)
main.Size, main.Position, main.Visible = UDim2.new(0, 200, 0, 240), UDim2.new(0, 70, 0.5, -120), false
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", main)

local bar = Instance.new("Frame", main)
bar.Size, bar.BackgroundColor3 = UDim2.new(1, 0, 0, 35), Color3.fromRGB(40, 40, 40)
local closeBtn = Instance.new("TextButton", bar)
closeBtn.Text, closeBtn.Size, closeBtn.Position, closeBtn.TextColor3 = "X", UDim2.new(0.2,0,1,0), UDim2.new(0.8,0,0,0), Color3.new(1,0,0)
closeBtn.BackgroundTransparency = 1
closeBtn.MouseButton1Click:Connect(function() sg:Destroy() CAS:UnbindAction("HakiAction") CAS:UnbindAction("TeleportAction") end)

local function createBtn(text, yPos, varName, func)
    local btn = Instance.new("TextButton", main)
    btn.Text, btn.Size, btn.Position = text..": OFF", UDim2.new(0, 180, 0, 45), UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3, btn.TextColor3 = Color3.fromRGB(45, 45, 45), Color3.new(1, 1, 1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        _G[varName] = not _G[varName]
        if func then func(_G[varName]) end
        btn.Text = text..(_G[varName] and ": ON" or ": OFF")
        btn.BackgroundColor3 = _G[varName] and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(45, 45, 45)
        notify(text .. " đã " .. (_G[varName] and "BẬT" or "TẮT"))
    end)
end

-- 5. LOGIC AUTO CHEST
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

openBtn.MouseButton1Click:Connect(function() if not dragging then main.Visible = not main.Visible end end)

createBtn("Auto Rương", 50, "AutoChest")
createBtn("Tàng Hình", 110, "SuperInvis", function(s)
    if player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then v.Transparency = s and 1 or 0 end
        end
    end
end)
createBtn("Haki Né (E)", 170, "HakiE")

notify("GOD HUB V3.6 DA SAN SANG!")
