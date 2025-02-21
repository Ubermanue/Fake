-- Create the GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 500)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Parent = screenGui

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 50, 0, 50)
closeButton.Position = UDim2.new(0, 250, 0, 10)
closeButton.Text = "X"
closeButton.Parent = frame

-- Function to close GUI
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Add admin commands and chat functionality
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 280, 0, 50)
textBox.Position = UDim2.new(0, 10, 0, 100)
textBox.PlaceholderText = "Enter command..."
textBox.Parent = frame

local fakeMessageBox = Instance.new("TextBox")
fakeMessageBox.Size = UDim2.new(0, 280, 0, 50)
fakeMessageBox.Position = UDim2.new(0, 10, 0, 160)
fakeMessageBox.PlaceholderText = "Enter fake system message..."
fakeMessageBox.Parent = frame

local commandButton = Instance.new("TextButton")
commandButton.Size = UDim2.new(0, 100, 0, 50)
commandButton.Position = UDim2.new(0, 10, 0, 220)
commandButton.Text = "Execute"
commandButton.Parent = frame

local messageLabel = Instance.new("TextLabel")
messageLabel.Size = UDim2.new(0, 280, 0, 50)
messageLabel.Position = UDim2.new(0, 10, 0, 280)
messageLabel.Text = ""
messageLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
messageLabel.BackgroundTransparency = 1
messageLabel.Parent = frame

-- Admin Chat and Fake Message Handling
commandButton.MouseButton1Click:Connect(function()
    local command = textBox.Text
    local fakeMessage = fakeMessageBox.Text
    if command:lower() == "admin" then
        -- Show admin chat message
        messageLabel.Text = "You are now an admin!"
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("You are now an admin!", "All")
    elseif command:lower() == "fake" then
        -- Send fake system message with custom input
        if fakeMessage ~= "" then
            messageLabel.Text = "Fake system message sent!"
            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Fake system message: " .. fakeMessage, "All")
        else
            messageLabel.Text = "Please enter a message!"
        end
    elseif command:lower() == "list" then
        -- List all players
        local playersList = "Players in the game:\n"
        for _, player in pairs(game.Players:GetPlayers()) do
            playersList = playersList .. player.Name .. "\n"
        end
        messageLabel.Text = playersList
    else
        messageLabel.Text = "Unknown command!"
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
