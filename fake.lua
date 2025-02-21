-- Create the GUI for the donation system
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 300)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 400, 0, 50)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.Text = "Fake Robux Donation System"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.BackgroundTransparency = 1
titleLabel.Parent = frame

-- Dropdown menu to select the player to donate to
local playerList = Instance.new("TextButton")
playerList.Size = UDim2.new(0, 380, 0, 50)
playerList.Position = UDim2.new(0, 10, 0, 60)
playerList.Text = "Select Player to Donate"
playerList.TextColor3 = Color3.fromRGB(255, 255, 255)
playerList.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
playerList.Parent = frame

local donateButton = Instance.new("TextButton")
donateButton.Size = UDim2.new(0, 380, 0, 50)
donateButton.Position = UDim2.new(0, 10, 0, 120)
donateButton.Text = "Start Donation"
donateButton.TextColor3 = Color3.fromRGB(255, 255, 255)
donateButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
donateButton.Parent = frame

local stopButton = Instance.new("TextButton")
stopButton.Size = UDim2.new(0, 380, 0, 50)
stopButton.Position = UDim2.new(0, 10, 0, 180)
stopButton.Text = "Stop Donation"
stopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stopButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
stopButton.Parent = frame

local donationActive = false
local currentPlayer = nil

-- Function to start the donation
donateButton.MouseButton1Click:Connect(function()
    if currentPlayer then
        donationActive = true
        donateButton.Text = "Donating..."
        while donationActive do
            -- Simulate donating 100 fake Robux
            game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(currentPlayer.Name .. " donated 100 fake Robux!", "All")
            wait(2) -- Wait for 2 seconds before donating again
        end
    else
        print("Select a player first!")
    end
end)

-- Function to stop the donation
stopButton.MouseButton1Click:Connect(function()
    donationActive = false
    donateButton.Text = "Start Donation"
end)

-- Function to select a player for donation
playerList.MouseButton1Click:Connect(function()
    local players = game.Players:GetPlayers()
    -- For simplicity, select the first player in the game as the recipient
    -- You can expand this part to allow players to choose from a list
    if #players > 1 then
        currentPlayer = players[2] -- Select the second player in the game as the donation recipient
        playerList.Text = "Selected: " .. currentPlayer.Name
    else
        playerList.Text = "No other players in the game"
    end
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
