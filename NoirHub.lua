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
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local clone = nil
local controllingClone = false
local originalCameraSubject = workspace.CurrentCamera.CameraSubject

local Tab1 = Window:CreateTab("🕹 Di chuyển", 4483362458)

Tab1:CreateToggle({
    Name = "🏃‍♂️ Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            infiniteJumpConn = UserInputService.JumpRequest:Connect(function()
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
            end)
        else
            if infiniteJumpConn then infiniteJumpConn:Disconnect() end
        end
    end
})

Tab1:CreateToggle({
    Name = "🚶‍♂️ Tăng tốc độ",
    CurrentValue = false,
    Callback = function(val)
        if val then
            humanoid.WalkSpeed = speedVal or 32
        else
            humanoid.WalkSpeed = 16
        end
    end
})

Tab1:CreateSlider({
    Name = "🔧 Tốc độ chạy",
    Range = {16, 120},
    Increment = 1,
    CurrentValue = 32,
    Callback = function(v)
        speedVal = v
        if humanoid.WalkSpeed > 16 then
            humanoid.WalkSpeed = speedVal
        end
    end
})

Tab1:CreateButton({
    Name = "🛸 Bay (bấm để bật GUI bay)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui"))()
    end
})

Tab1:CreateToggle({
    Name = "🫥 Invisible (ẩn khỏi hitbox)",
    CurrentValue = false,
    Callback = function(val)
        if val then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 1
                    if part:FindFirstChildOfClass("Decal") then
                        part:FindFirstChildOfClass("Decal").Transparency = 1
                    end
                end
            end
        else
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 0
                    if part:FindFirstChildOfClass("Decal") then
                        part:FindFirstChildOfClass("Decal").Transparency = 0
                    end
                end
            end
        end
    end
})

local Tab2 = Window:CreateTab("👁 ESP", 4483362458)

Tab2:CreateButton({
    Name = "👀 Hiện tên và khoảng cách",
    Callback = function()
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local billboard = Instance.new("BillboardGui", player.Character)
                billboard.Name = "DistanceTag"
                billboard.Size = UDim2.new(0, 200, 0, 50)
                billboard.Adornee = player.Character.HumanoidRootPart
                billboard.AlwaysOnTop = true

                local label = Instance.new("TextLabel", billboard)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(0, 255, 0)
                label.TextStrokeTransparency = 0.5
                label.Font = Enum.Font.GothamBold
                label.TextScaled = true

                RunService.RenderStepped:Connect(function()
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = math.floor((player.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude)
                        label.Text = "[" .. dist .. "] " .. player.DisplayName
                    end
                end)
            end
        end
    end
})

local Tab3 = Window:CreateTab("🎭 Emote", 4483362458)

Tab3:CreateButton({
    Name = "🎒 Animation Pack (R6 + R15)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Emerson2-creator/Scripts-Roblox/main/ScriptR6/AnimGuiV2.lua"))()
    end
})

local Tab4 = Window:CreateTab("🎽 Outfit", 4483362458)

Tab4:CreateButton({
    Name = "🎭 Mặc R6 Headless",
    Callback = function()
        LocalPlayer.Character.Head.Transparency = 1
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.HeadScale = 0.001
        end
    end
})

Tab4:CreateButton({
    Name = "🎭 Mặc R6 Korblox",
    Callback = function()
        local leg = LocalPlayer.Character:FindFirstChild("RightLowerLeg")
        if leg then
            leg:Destroy()
        end
    end
})

local Tab5 = Window:CreateTab("🌀 Clone & Aura", 4483362458)

Tab5:CreateButton({
    Name = "📦 Spawn Clone",
    Callback = function()
        if clone then clone:Destroy() end
        clone = character:Clone()
        clone.Name = "NoirClone"
        clone.Parent = workspace
        clone:SetPrimaryPartCFrame(character:GetPrimaryPartCFrame() * CFrame.new(3, 0, 0))

        Tab5:CreateButton({
            Name = "👁 Control Clone",
            Callback = function()
                if clone then
                    controllingClone = true
                    workspace.CurrentCamera.CameraSubject = clone:FindFirstChild("Humanoid")
                    RunService:BindToRenderStep("ControlClone", Enum.RenderPriority.Input.Value, function()
                        if not controllingClone or not clone or not clone:FindFirstChild("HumanoidRootPart") then return end
                        local moveVector = Vector3.new()
                        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveVector = moveVector + Vector3.new(0, 0, -1) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveVector = moveVector + Vector3.new(0, 0, 1) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveVector = moveVector + Vector3.new(-1, 0, 0) end
                        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveVector = moveVector + Vector3.new(1, 0, 0) end
                        local hrp = clone:FindFirstChild("HumanoidRootPart")
                        if moveVector.Magnitude > 0 then
                            hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * moveVector.Z + hrp.CFrame.RightVector * moveVector.X) * 0.5
                        end
                    end)
                end
            end
        })
    end
})

Tab5:CreateButton({
    Name = "🌀 Slip Aura (văng xa 4x)",
    Callback = function()
        local root = character:FindFirstChild("HumanoidRootPart")
        game:GetService("RunService").Stepped:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (player.Character.HumanoidRootPart.Position - root.Position).Magnitude
                    if dist < 10 then
                        player.Character.HumanoidRootPart.Velocity = (player.Character.HumanoidRootPart.Position - root.Position).Unit * 60
                    end
                end
            end
        end)
    end
})
