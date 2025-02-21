-- Create the GUI for the Donation and Admin Chat functionality
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 500)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(0, 350, 0, 10)
closeButton.Text = "X"
closeButton.Parent = frame

-- Function to close GUI
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Donate GUI Elements
local donateButton = Instance.new("TextButton")
donateButton.Size = UDim2.new(0, 150, 0, 50)
donateButton.Position = UDim2.new(0, 10, 0, 100)
donateButton.Text = "Donate"
donateButton.Parent = frame

local userTextBox = Instance.new("TextBox")
userTextBox.Size = UDim2.new(0, 280, 0, 50)
userTextBox.Position = UDim2.new(0, 10, 0, 160)
userTextBox.PlaceholderText = "Enter player name..."
userTextBox.Parent = frame

local amountTextBox = Instance.new("TextBox")
amountTextBox.Size = UDim2.new(0, 280, 0, 50)
amountTextBox.Position = UDim2.new(0, 10, 0, 220)
amountTextBox.PlaceholderText = "Enter donation amount..."
amountTextBox.Parent = frame

local messageLabel = Instance.new("TextLabel")
messageLabel.Size = UDim2.new(0, 280, 0, 50)
messageLabel.Position = UDim2.new(0, 10, 0, 280)
messageLabel.Text = ""
messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
messageLabel.BackgroundTransparency = 1
messageLabel.Parent = frame

-- Fake Admin Chat Functionality
local fakeChatButton = Instance.new("TextButton")
fakeChatButton.Size = UDim2.new(0, 150, 0, 50)
fakeChatButton.Position = UDim2.new(0, 10, 0, 350)
fakeChatButton.Text = "Fake Chat"
fakeChatButton.Parent = frame

-- Variable for Ultimate Donation
local isDonating = false
local donationConnection

-- Function for Ultimate Donation (continuous until stopped)
local function startUltimateDonation(playerName, amount)
    isDonating = true
    donationConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if isDonating then
            local player = game.Players:FindFirstChild(playerName)
            if player then
                -- Simulate a donation (Modify this to work with your game)
                -- Example: Fire the donation event for a specific player
                -- FireServer would be part of the game’s donation system
                -- (replace with actual donation code)
                -- game.ReplicatedStorage.DonateEvent:FireServer(player, amount)
                messageLabel.Text = "Donating " .. amount .. " to " .. playerName
            end
        else
            messageLabel.Text = "Donation stopped."
            donationConnection:Disconnect()
        end
    end)
end

-- Function to stop the ultimate donation
local function stopUltimateDonation()
    isDonating = false
end

-- Donate Button Action
donateButton.MouseButton1Click:Connect(function()
    local playerName = userTextBox.Text
    local donationAmount = tonumber(amountTextBox.Text)
    
    if playerName and donationAmount then
        messageLabel.Text = "Donating " .. donationAmount .. " to " .. playerName
        -- Start the donation process
        startUltimateDonation(playerName, donationAmount)
    else
        messageLabel.Text = "Invalid player or amount!"
    end
end)

-- Fake Chat Button Action (FE - Fake system message visible to all players)
fakeChatButton.MouseButton1Click:Connect(function()
    local fakeMessage = "Admin Message: This is a fake chat!"
    -- Broadcast fake chat message
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(fakeMessage, "All")
end)

-- Make GUI draggable
local dragging = false
local dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
