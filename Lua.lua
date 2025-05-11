-- Enhanced Tubers93 Universal Backdoor Script v3
-- Created based on the original by 5x5x5x50 and AndreyHelloKitty
-- Version optimized for loadstring execution
-- Usage: loadstring(game:HttpGet("https://raw.githubusercontent.com/0xlove/Lua/main/٢٠٢٥٠٥١١_٠٣٠٤١٤_٩٠٧.lua"))()

-- Immediately invoked function to encapsulate the code
local Success, Error = pcall(function()
    -- Print initialization message
    print("▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄")
    print("► Tubers93 Backdoor v3.0 Loading...◄")
    print("▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀")
    
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
        ActivationKey = "T93",        -- Type this in chat to activate the backdoor
        SecretCommand = "/t93",       -- Alternative command for activating from chat
        AutoShowToAll = true,         -- Show the GUI to all players automatically
        Version = "v3.0 BACKDOOR",
        HideFromLogs = true,          -- Try to hide activity from game logs
        GUID = HttpService:GenerateGUID(false), -- Unique identifier for this backdoor instance
        Creator = "Enhanced by Tubers93 Team"
    }
    
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
    
    -- Function to create the main GUI
    local function createMainGUI()
        local Player = Players.LocalPlayer
        local me = Player.Name
        
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
        title.Text = "Tubers93 " .. BackdoorSettings.Version
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
        
        -- Add more backdoor admin buttons (everyone gets access in backdoor version)
        local serverControlBtn = createButton("ServerControlBtn", "Server Control", adminContent, UDim2.new(0.05, 0, 0.9, 0))
        local scriptInjectBtn = createButton("ScriptInjectBtn", "Execute Script", adminContent, UDim2.new(0.55, 0, 0.9, 0))
        local fpsUnlockerBtn = createButton("FPSUnlockerBtn", "Unlock FPS", adminContent, UDim2.new(0.3, 0, 0.8, 0))
        
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
        
        -- Button Functions
        
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
                            
                            -- Create visual effect to show god mode
                            local highlight = Instance.new("Highlight")
                            highlight.FillColor = Color3.fromRGB(255, 215, 0) -- Gold color
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- White outline
                            highlight.FillTransparency = 0.7
                            highlight.OutlineTransparency = 0.3
                            highlight.Parent = char
                        end
                    end
                    
                    applyGodMode(character)
                    showNotification("God Mode activated for you", Color3.fromRGB(255, 215, 0))
                else
                    showNotification("Your character doesn't exist yet", 3)
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
        
        -- Script injection
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
        
        -- Server control
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
        
        -- Return the created GUI
        return screenGui
    end
    
    -- Wait for player to be ready
    local Player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    
    -- Create the GUI
    local gui = createMainGUI()
    if gui then
        print("Tubers93 Backdoor GUI created successfully!")
        
        -- Show initialization notification
        local notificationFrame = gui:FindFirstChild("NotificationFrame", true)
        local notificationText = notificationFrame and notificationFrame:FindFirstChild("NotificationText", true)
        
        if notificationFrame and notificationText then
            notificationText.Text = "Enhanced Tubers93 BACKDOOR activated!"
            notificationFrame.Position = UDim2.new(1, 10, 0.5, 0)
            notificationFrame.Visible = true
            
            -- Animate notification
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            local tween = TweenService:Create(notificationFrame, tweenInfo, {Position = UDim2.new(0.85, 0, 0.5, 0)})
            tween:Play()
        end
    end
end)

-- Output result
if not Success then
    warn("Tubers93 Backdoor Error: " .. tostring(Error))
else
    print("▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄")
    print("█ Tubers93 Backdoor v3.0 successfully loaded! █")
    print("▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀")
end
