local placeId = game.PlaceId
local creatorId = game.CreatorId

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 240, 0, 90)
frame.Position = UDim2.new(0.5, -120, 0.5, -45)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 0, 30)
label.Position = UDim2.new(0, 0, 0, 12)
label.BackgroundTransparency = 1
label.Text = "pls join in my discrod :3"
label.TextColor3 = Color3.fromRGB(230, 230, 230)
label.TextSize = 14
label.Font = Enum.Font.Gotham
label.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -24, 0, 28)
button.Position = UDim2.new(0, 12, 0, 50)
button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
button.Text = "copy link"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.TextSize = 13
button.Font = Enum.Font.Gotham
button.BorderSizePixel = 0
button.Parent = frame

Instance.new("UICorner", button).CornerRadius = UDim.new(0, 5)

button.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("discord.com/invite/4FXEsTyqvc")
    end

    gui:Destroy()

    if placeId == 7336302630 or (game.CreatorType == Enum.CreatorType.Group and creatorId == 3765739) then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/project_delta.lua"))()
    else
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/universal.lua"))()
    end
end)
