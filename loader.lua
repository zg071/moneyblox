local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/assets/lib.lua"))()

Library.FontColor = Color3.fromRGB(255, 255, 255)
Library.MainColor = Color3.fromRGB(26, 26, 26)
Library.BackgroundColor = Color3.fromRGB(16, 18, 19)
Library.OutlineColor = Color3.fromRGB(38, 40, 41)
Library.AccentColor = Color3.fromRGB(220, 100, 110)
Library.Black = Color3.fromRGB(0, 0, 0)
Library.RiskColor = Color3.fromRGB(255, 50, 50)

Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor)

local Window = Library:CreateWindow({
    Title = "swimhub",
    AutoShow = true,
    Center = true,
    Size = UDim2.fromOffset(450, 260),
})

local Tab = Window:AddTab("")

local Left = Tab:AddLeftGroupbox("Scripts")
local Right = Tab:AddRightGroupbox(".gg/YMyHNx2rqZ")

local Games = {
    ["Project Delta"] = "https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/project_delta.lua",
    ["State of Anarchy"] = "https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/state_of_anarchy.lua",
    ["Universal"] = "https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/universal.lua",
}

local GameOrder = {
    "Project Delta",
    "State of Anarchy",
    "Universal"
}

local SelectedGame = nil
local SelectedLabel = Right:AddLabel("Selected: none")

for _, name in ipairs(GameOrder) do
    Left:AddButton({
        Text = name,
        Func = function()
            SelectedGame = name
            SelectedLabel:SetText("Selected: " .. name)
        end,
    })
end

Right:AddDivider()

Right:AddButton({
    Text = "Load",
    Func = function()
        if not SelectedGame then 
            return Library:Notify("No script selected.", 3) 
        end
        
        if Games[SelectedGame] and Games[SelectedGame] ~= "" then
            local ok, err = pcall(function()
                loadstring(game:HttpGet(Games[SelectedGame]))()
            end)
            if not ok then
                Library:Notify("Load failed: " .. tostring(err), 4)
            else
                Window.Holder.Visible = false
                Library.Toggled = false
                Library:Notify("Loaded: " .. SelectedGame, 3)
            end
        end
    end,
})
