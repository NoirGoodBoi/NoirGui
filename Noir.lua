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
local savedAnimationPack = nil
local savedOutfits = {}

local Tab1 = Window:CreateTab("🚀 Di chuyển", 4483362458)
local Tab2 = Window:CreateTab("🎯 Combat & ESP", 4483362458)
local Tab3 = Window:CreateTab("💀 to6 by Noir", 4483362458)
local Tab4 = Window:CreateTab("👑 Điều khiển", 4483362458)
local Tab5 = Window:CreateTab("🎭 Animation", 4483362458)
local Tab6 = Window:CreateTab("👕 Outfit", 4483362458)

Tab1:CreateButton({
    Name = "🧚 Fly (VehicleFly style)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui"))()
    end
})

Tab1:CreateToggle({
    Name = "🧱 NoClip + AntiVoid",
    CurrentValue = false,
    Callback = function(state)
        if state then
            game:GetService("RunService").Stepped:Connect(function()
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
                if LocalPlayer.Character.HumanoidRootPart.Position.Y < -10 then
                    LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
                end
            end)
        end
    end
})

Tab1:CreateToggle({
    Name = "👻 Invisible",
    CurrentValue = false,
    Callback = function(state)
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = state and 1 or 0
            end
        end
    end
})

Tab2:CreateButton({
    Name = "🎯 Aimbot (đầu)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ZepsyyCodes/FE/main/Aimbot"))()
    end
})

Tab2:CreateButton({
    Name = "📍 ESP Tên + Highlight (Xanh)",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/itsnoirdev/ESP-GreenHighlight/main/ESP.lua"))()
    end
})

Tab3:CreateToggle({
    Name = "🗯️ Tự động spam toxic",
    CurrentValue = false,
    Callback = function(state)
        if state then
            while wait(3) do
                local msg = "Cry about it 😭"
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            end
        end
    end
})

Tab3:CreateInput({
    Name = "Custom spam text",
    PlaceholderText = "Nhập câu cần spam",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
    end
})

Tab4:CreateInput({
    Name = "Nhập tên gần đúng",
    PlaceholderText = "Ví dụ: djdb",
    RemoveTextAfterFocusLost = false,
    Callback = function(input)
        for _, plr in pairs(Players:GetPlayers()) do
            if string.find(string.lower(plr.Name), string.lower(input)) then
                Tab4:CreateButton({
                    Name = "💀 Kill " .. plr.Name,
                    Callback = function()
                        plr.Character:BreakJoints()
                    end
                })

                Tab4:CreateButton({
    Name = "💣 Tự nổ (văng tất cả)",
    Callback = function()
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
    end
})
})

Tab5:CreateDropdown({
    Name = "🎭 Emote",
    Options = {"Griddy", "Cartwheel", "Moon Dance", "Moon Dance (Nhanh)", "Tập bơi", "Tập bơi (Nhanh)"},
    Callback = function(animName)
        local id = "rbxassetid://"
        if animName == "Griddy" then id = id.."10727422650"
        elseif animName == "Moon Dance" then id = id.."8568578708"
        elseif animName == "Moon Dance (Nhanh)" then id = id.."14413564813"
        elseif animName == "Cartwheel" then id = id.."7828414984"
        elseif animName == "Tập bơi" then id = id.."11830420595"
        elseif animName == "Tập bơi (Nhanh)" then id = id.."11831111885" end

        local anim = Instance.new("Animation")
        anim.AnimationId = id
        local track = humanoid:LoadAnimation(anim)
        track:Play()
    end
})

Tab5:CreateToggle({
    Name = "🔁 Loop Emote",
    CurrentValue = false,
    Callback = function(loop)
        -- sẽ thêm sau nếu cần
    end
})

Tab5:CreateDropdown({
    Name = "📦 Animation Pack",
    Options = {"Levitate", "Zombie", "Stylish", "Ninja"},
    Callback = function(pack)
        local packs = {
            ["Levitate"] = 10180612145,
            ["Zombie"] = 6160882117,
            ["Stylish"] = 6161367901,
            ["Ninja"] = 6561197213
        }
        savedAnimationPack = packs[pack]
        local desc = Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
        desc.AnimationPack = "rbxassetid://"..packs[pack]
        humanoid:ApplyDescription(desc)
    end
})

Tab5:CreateToggle({
    Name = "💾 Ghi nhớ animation pack khi chết",
    CurrentValue = true,
    Callback = function() end
})

LocalPlayer.CharacterAdded:Connect(function(char)
    if savedAnimationPack then
        local hum = char:WaitForChild("Humanoid")
        local desc = Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
        desc.AnimationPack = "rbxassetid://"..savedAnimationPack
        hum:ApplyDescription(desc)
    end
end)

Tab6:CreateInput({
    Name = "📥 Nhập UserId để copy outfit",
    PlaceholderText = "VD: 1 (bacon) hoặc 261",
    RemoveTextAfterFocusLost = false,
    Callback = function(uid)
        table.insert(savedOutfits, uid)
        local desc = Players:GetHumanoidDescriptionFromUserId(tonumber(uid))
        humanoid:ApplyDescription(desc)
    end
})

Tab6:CreateDropdown({
    Name = "📜 Lịch sử đã từng copy",
    Options = savedOutfits,
    Callback = function(uid)
        local desc = Players:GetHumanoidDescriptionFromUserId(tonumber(uid))
        humanoid:ApplyDescription(desc)
    end
})

Tab6:CreateDropdown({
    Name = "🎭 Outfit preset",
    Options = {"👑 Admin Giả", "🤑 Tryhard Rich Kid", "🤣 Noob Troll", "🧍 Mặc đồ trống"},
    Callback = function(preset)
        local ids = {
            ["👑 Admin Giả"] = 261,
            ["🤑 Tryhard Rich Kid"] = 139221015,
            ["🤣 Noob Troll"] = 1,
            ["🧍 Mặc đồ trống"] = 0
        }
        local desc = Players:GetHumanoidDescriptionFromUserId(ids[preset])
        humanoid:ApplyDescription(desc)
    end
})

Tab6:CreateButton({
    Name = "🔄 Reset outfit gốc",
    Callback = function()
        local desc = Players:GetHumanoidDescriptionFromUserId(LocalPlayer.UserId)
        humanoid:ApplyDescription(desc)
    end
})
