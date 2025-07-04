local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()
local Window = Rayfield:CreateWindow({
    Name = "NoirHub V6",
    LoadingTitle = "NoirHub Loading",
    LoadingSubtitle = "Tung hoành roblox 😎",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "NoirHubV6",
        FileName = "NoirSettings"
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local Tab1 = Window:CreateTab("🏃 Di chuyển", 4483362458)
local Tab2 = Window:CreateTab("🎯 Aim & ESP", 4483362458)
local Tab3 = Window:CreateTab("🗯️ To6 by Noir", 4483362458)
local Tab4 = Window:CreateTab("👑 Điều khiển", 4483362458)

Tab1:CreateToggle("🎯 No Clip", false, function(state)
    getgenv().NoClip = state
    game:GetService("RunService").Stepped:Connect(function()
        if getgenv().NoClip and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(11)
        end
    end)
end)

Tab1:CreateToggle("🛫 Fly", false, function(state)
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui"))()
    end
end)

Tab1:CreateToggle("🦘 Infinite Jump", false, function(state)
    getgenv().InfJump = state
    game:GetService("UserInputService").JumpRequest:Connect(function()
        if getgenv().InfJump and LocalPlayer.Character then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

Tab1:CreateSlider("⚡ WalkSpeed", 16, 100, 16, function(val)
    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
end)

Tab1:CreateSlider("🦵 JumpPower", 50, 150, 50, function(val)
    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = val
end)

Tab2:CreateToggle("🎯 Aimbot (Head)", false, function(state)
    getgenv().AimEnabled = state
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    RunService.RenderStepped:Connect(function()
        if getgenv().AimEnabled then
            local closest = nil
            local shortest = math.huge
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                    local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).magnitude
                        if dist < shortest then
                            shortest = dist
                            closest = plr
                        end
                    end
                end
            end
            if closest and closest.Character and closest.Character:FindFirstChild("Head") then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Character.Head.Position)
            end
        end
    end)
end)

Tab2:CreateToggle("🧿 ESP (Name + Highlight)", false, function(state)
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
            if state then
                local esp = Instance.new("BillboardGui", v.Character)
                esp.Name = "NoirESP"
                esp.Size = UDim2.new(0, 100, 0, 40)
                esp.AlwaysOnTop = true
                local txt = Instance.new("TextLabel", esp)
                txt.Size = UDim2.new(1,0,1,0)
                txt.BackgroundTransparency = 1
                txt.Text = v.Name
                txt.TextColor3 = Color3.fromRGB(0,255,0)
                txt.TextScaled = true

                local hl = Instance.new("Highlight", v.Character)
                hl.Name = "NoirHL"
                hl.FillColor = Color3.fromRGB(0,255,0)
                hl.OutlineTransparency = 1
            else
                if v.Character:FindFirstChild("NoirESP") then v.Character.NoirESP:Destroy() end
                if v.Character:FindFirstChild("NoirHL") then v.Character.NoirHL:Destroy() end
            end
        end
    end
end)

Tab3:CreateToggle("💬 To6 spam", false, function(state)
    getgenv().To6 = state
    local messages = {"Cry about it", "Alt + F4 now", "Skill issue", "You mad?", "Get rekt", "That's what I thought"}
    while getgenv().To6 do
        game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer(messages[math.random(#messages)], "All")
        task.wait(1.5)
    end
end)

Tab3:CreateInput("Tự nhập câu To6", "", function(text)
    getgenv().CustomTo6 = text
end)

Tab3:CreateButton("📢 Bắt đầu spam", function()
    spawn(function()
        while true do
            if getgenv().CustomTo6 then
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getgenv().CustomTo6, "All")
            end
            task.wait(1.5)
        end
    end)
end)

Tab4:CreateButton("💣 Tự nổ (văng tất cả)", function()
    local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - root.Position).magnitude
            if distance < 25 then
                player.Character.HumanoidRootPart.Velocity = (player.Character.HumanoidRootPart.Position - root.Position).Unit * 150
            end
        end
    end
    LocalPlayer.Character:BreakJoints()
end)

Tab4:CreateInput("Nhập tên để Kick", "Một phần tên cũng được", function(text)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():find(text:lower()) then
            p:Kick("You have been kicked.")
        end
    end
end)

Tab4:CreateInput("Kill player", "Nhập tên gần đúng", function(text)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Name:lower():find(text:lower()) then
            p.Character:BreakJoints()
        end
    end
end)

Tab4:CreateInput("Teleport tới người chơi", "Nhập tên gần đúng", function(text)
    for _, p in pairs(Players:GetPlayers()) do
        if p.Name:lower():find(text:lower()) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:MoveTo(p.Character.HumanoidRootPart.Position + Vector3.new(2,0,2))
        end
    end
end)
