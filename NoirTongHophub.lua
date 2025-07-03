local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "🌌 NoirGoodBoi Hub",
   LoadingTitle = "Đợi xíu đang nấu GUI...",
   LoadingSubtitle = "by NoirGoodBoi 😈",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "NoirGUI",
      FileName = "NoirHub"
   },
   KeySystem = false
})

-- Tab Di chuyển
local TabMovement = Window:CreateTab("🚀 Di chuyển", 4483362458)

local noclipEnabled = false
TabMovement:CreateToggle({
   Name = "Noclip (anti void)",
   CurrentValue = false,
   Callback = function(Value)
      noclipEnabled = Value
      if Value then
         game:GetService("RunService").Stepped:Connect(function()
            if noclipEnabled and game.Players.LocalPlayer.Character then
               for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                  if part:IsA("BasePart") then
                     part.CanCollide = false
                  end
               end
            end
         end)
      end
   end
})

TabMovement:CreateToggle({
   Name = "Invisible",
   CurrentValue = false,
   Callback = function(v)
      local char = game.Players.LocalPlayer.Character
      if v and char then
         for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
               part.Transparency = 1
            end
         end
      elseif char then
         for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
               part.Transparency = 0
            end
         end
      end
   end
})

TabMovement:CreateButton({
   Name = "Bay (mở GUI bay riêng)",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui'))()
   end
})

-- Tab Combat & ESP
local TabCombat = Window:CreateTab("🎯 Combat & ESP", 4483362458)

TabCombat:CreateButton({
   Name = "Aimbot (head)",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Aimbot%20V2.lua'))()
   end
})

TabCombat:CreateToggle({
   Name = "Định vị tên (có khoảng cách)",
   CurrentValue = false,
   Callback = function(v)
      _G.ShowNames = v
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/UnnamedESP.lua"))()
   end
})

TabCombat:CreateToggle({
   Name = "Highlight người chơi",
   CurrentValue = false,
   Callback = function(v)
      _G.HighlightESP = v
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Ryn06/RobloxScripts/main/HighlightESP.lua"))()
   end
})

-- Tab to6 by Noir
local TabToxic = Window:CreateTab("💀 to6 by Noir", 4483362458)

local toxicEnabled = false
local toxicLines = {
   "Alt + F4 now 👋",
   "Cry harder 💦",
   "Skill issue detected 😎",
   "That's what I thought 😂",
   "No cap you bad 🤡"
}

TabToxic:CreateToggle({
   Name = "Auto spam chat toxic",
   CurrentValue = false,
   Callback = function(v)
      toxicEnabled = v
      task.spawn(function()
         while toxicEnabled do
            local msg = toxicLines[math.random(1, #toxicLines)]
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            wait(5)
         end
      end)
   end
})

TabToxic:CreateParagraph({Title = "📜 Danh sách câu sẽ chat:", Content = table.concat(toxicLines, "\n")})

local customSpam = ""
local customOn = false
TabToxic:CreateInput({
   Name = "Nhập câu spam riêng",
   PlaceholderText = "Ví dụ: ez game noobs 😈",
   RemoveTextAfterFocusLost = false,
   Callback = function(txt)
      customSpam = txt
   end
})

TabToxic:CreateToggle({
   Name = "Bật spam câu tuỳ chỉnh",
   CurrentValue = false,
   Callback = function(v)
      customOn = v
      task.spawn(function()
         while customOn do
            if customSpam ~= "" then
               game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(customSpam, "All")
            end
            wait(5)
         end
      end)
   end
})

TabToxic:CreateButton({
   Name = "Spam thử 1 lần",
   Callback = function()
      if customSpam ~= "" then
         game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(customSpam, "All")
      end
   end
})

TabToxic:CreateButton({
   Name = "💣 Tự nổ (xoá character)",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      if char then
         char:BreakJoints()
      end
   end
})
