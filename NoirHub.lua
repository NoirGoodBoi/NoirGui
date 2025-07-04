local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "NoirHubGui"

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 400, 0, 300)
Main.Position = UDim2.new(0.5, -200, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Tabs = {}
local CurrentTab = nil

local function createTab(name)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 80, 0, 30)
    Button.Text = name
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Button.Parent = Main

    local TabFrame = Instance.new("Frame")
    TabFrame.Size = UDim2.new(1, -10, 1, -50)
    TabFrame.Position = UDim2.new(0, 5, 0, 45)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false
    TabFrame.Parent = Main

    Button.MouseButton1Click:Connect(function()
        if CurrentTab then CurrentTab.Visible = false end
        TabFrame.Visible = true
        CurrentTab = TabFrame
    end)

    Tabs[#Tabs+1] = {Button = Button, Frame = TabFrame}
    return TabFrame
end

local function addToggle(parent, text, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(0, 180, 0, 30)
    Toggle.Text = text .. ": OFF"
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Toggle.Parent = parent

    local state = false
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.Text = text .. ": " .. (state and "ON" or "OFF")
        callback(state)
    end)
end

local function addButton(parent, text, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 180, 0, 30)
    Button.Text = text
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.Parent = parent
    Button.MouseButton1Click:Connect(callback)
end

local Tab1 = createTab("Di chuyển")
addToggle(Tab1, "No Clip", function(state)
    RunService.Stepped:Connect(function()
        if state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ChangeState(11)
        end
    end)
end)

addToggle(Tab1, "Fly", function(state)
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui"))()
    end
end)

addToggle(Tab1, "Infinite Jump", function(state)
    UIS.JumpRequest:Connect(function()
        if state and LocalPlayer.Character then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

local Tab2 = createTab("Aim & ESP")
addToggle(Tab2, "Aimbot", function(state)
    local Camera = workspace.CurrentCamera
    RunService.RenderStepped:Connect(function()
        if state then
            local closest = nil
            local shortest = math.huge
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local pos, onScreen = Camera:WorldToViewportPoint(p.Character.Head.Position)
                    if onScreen then
                        local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
                        if dist < shortest then
                            shortest = dist
                            closest = p
                        end
                    end
                end
            end
            if closest then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Character.Head.Position)
            end
        end
    end)
end)

addToggle(Tab2, "ESP", function(state)
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

local Tab3 = createTab("To6 by Noir")
addToggle(Tab3, "Spam To6", function(state)
    local messages = {"Cry about it", "Alt + F4 now", "Skill issue", "Get rekt"}
    spawn(function()
        while state do
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(messages[math.random(#messages)], "All")
            task.wait(2)
        end
    end)
end)

local Tab4 = createTab("Điều khiển")
addButton(Tab4, "Tự nổ (văng)" , function()
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
