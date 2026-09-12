local placeId = game.PlaceId
local creatorId = game.CreatorId

if placeId == 7336302630 or (game.CreatorType == Enum.CreatorType.Group and creatorId == 3765739) then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/project_delta.lua"))()
else
    loadstring(game:HttpGet("https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/universal.lua"))()
end
