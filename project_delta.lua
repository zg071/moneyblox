--!native
--!optimize 2





if not LPH_OBFUSCATED then
	LPH_JIT = function(...)
		return ...;
	end;
	LPH_JIT_MAX = function(...)
		return ...;
	end;
	LPH_NO_VIRTUALIZE = function(...)
		return ...;
	end;
	LPH_NO_UPVALUES = function(f)
		return (function(...)
			return f(...);
		end);
	end;
	LPH_ENCSTR = function(...)
		return ...;
	end;
	LPH_ENCNUM = function(...)
		return ...;
	end;
	LPH_ENCFUNC = function(func, key1, key2)
		if key1 ~= key2 then return print("LPH_ENCFUNC mismatch") end
		return func
	end
	LPH_CRASH = function()
		return print(debug.traceback());
	end;
	SWG_DiscordUser = "furra"
	SWG_DiscordID = 1337
	SWG_SecondsLeft = 9999999999999999999999999999999
	SWG_Note = "scp,alpha"
	SWG_IsLifetime = true
end;


if (getgenv and getgenv() or _G).Library then
	(getgenv and getgenv() or _G).Library.Unload()
end

local Folder = "moneyblox"
makefolder(Folder)

local ImagesFolder = string.format( "%s\\%s\\", Folder, "Images" )
makefolder(ImagesFolder)

local FontsFolder = string.format( "%s\\%s\\", Folder, "FontsFolder" )
makefolder(FontsFolder)

local HitsoundFolder = string.format( "%s\\%s\\", Folder, "Hitsounds" )
makefolder(HitsoundFolder)

local SoundsFolder = string.format( "%s\\%s\\", Folder, "Sounds" )
makefolder(SoundsFolder)

local PicturesOnKillFolder = string.format( "%s\\%s\\", Folder, "PicturesOnKill" )

local CREATE_PRESET_IMAGES = isfolder(PicturesOnKillFolder)
makefolder(PicturesOnKillFolder)

local TempFolder = string.format( "%s\\%s\\", Folder, "TempFolder" )
makefolder(TempFolder)

local ConfigFolder = string.format( "%s\\%s\\", Folder, "Configs" )
makefolder(ConfigFolder)

local ThemeFolder = string.format( "%s\\%s\\", Folder, "Themes" )
makefolder(ThemeFolder)

local admin_join_asset, admin_leave_asset = "", ""
local Fonts, Images = LPH_JIT(function()
	local RunService = game:GetService("RunService")
	local HttpService = game:GetService("HttpService")

	local Fonts = {
		URL = "https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/assets/",

		Names = {
			"Tahoma",
			"TahomaXP",
			"Comfortaa",
			"Verdana",
			"SmallestPixel7",
			"Proggy",
		},

		Data = {}
	}; do
		function Fonts.Load(font)
			if not RunService:IsStudio() then
				local TTF = string.format("%s%s.ttf", FontsFolder, font)
				local JSON = string.format("%s%s.json", FontsFolder, font)

				if not isfile(TTF) then
					local success, data = pcall(function()
						return game:HttpGet( string.format("%s%s.txt", Fonts.URL, font) )
					end)

					if success and data then
						writefile(TTF, base64_decode(data))
					else
						return
					end
				end

				if not isfile(JSON) then
					local Font = {
						name = font,
						faces = {{
							name = "Regular",
							weight = 400,
							style = "normal",
							assetId = getcustomasset(TTF)
						}}
					}

					writefile(JSON, HttpService:JSONEncode(Font))
				end

				local temp_TTF = string.format("%s%s.ttf", TempFolder, font)
				local temp_JSON = string.format("%s%s.json", TempFolder, font)
				writefile(temp_TTF, readfile(TTF))
				writefile(temp_JSON, HttpService:JSONEncode({
					name = font,
					faces = {{
						name = "Regular",
						weight = 400,
						style = "normal",
						assetId = getcustomasset(temp_TTF)
					}}
				}))

				Fonts.Data[font] = Font.new(getcustomasset(temp_JSON), Enum.FontWeight.Regular)
			end
		end

		function Fonts.Get(font)
			return Fonts.Data[font]
		end

		for _,font in Fonts.Names do
			Fonts.Load(font)
		end
	end

	local Images = {
		URL = "https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/assets/",

		Names = {
			"combat",
			"visuals",
			"misc",
			"config",
			"checkers",
			"saturation",
			"scrollbar",
			"lines"
		},

		Data = {}
	}; do
		function Images.Load(image)
			if not RunService:IsStudio() then
				local PNG = string.format("%s%s.png", ImagesFolder, image)

				if not isfile(PNG) then
					local success, data = pcall(function()
						return game:HttpGet( string.format( "%s%s.txt", Images.URL, image ) )
					end)

					if success and data then
						writefile(PNG, base64_decode(data))
					else
						return
					end
				end

				Images.Data[image] = getcustomasset(PNG)
			end
		end

		function Images.Get(image)
			return Images.Data[image]
		end

		for _,image in Images.Names do
			Images.Load(image)
		end
	end

	local Boykisser = {
		URL = "https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/assets/",
	}; do
		function Boykisser.Load()
			if RunService:IsStudio() then return end
			local PNG = string.format("%s%s.png", ImagesFolder, "boykisser")
			if not isfile(PNG) then
				local done = false
				local success, data = pcall(function()
					return game:HttpGet(string.format("%s%s.txt", Boykisser.URL, "boykisser"))
				end)
				if success and data then
					local ok, decoded = pcall(function()
						return base64_decode(data)
					end)
					if ok and decoded then
						writefile(PNG, decoded)
						done = true
					end
				end
				if not done then
					local s2, d2 = pcall(function()
						return game:HttpGet(string.format("%s%s.png", Boykisser.URL, "boykisser"))
					end)
					if s2 and d2 then
						writefile(PNG, d2)
						done = true
					end
				end
				if not done then
					return
				end
			end
			local ok, asset = pcall(function()
				return getcustomasset(PNG)
			end)
			if ok and asset then
				boykisser_asset = asset
			end
		end
		Boykisser.Load()
	end

	local AdminSounds = {
		URL = "https://github.com/zg071/moneyblox/raw/refs/heads/main/assets/",
		Names = {"admjoin", "admleave"},
		Data = {}
	}; do
		function AdminSounds.Load(name)
			if RunService:IsStudio() then return "" end
			local MP3 = string.format("%s%s.mp3", SoundsFolder, name)
			if not isfile(MP3) then
				local success, data = pcall(function()
					return game:HttpGet(AdminSounds.URL .. name .. ".mp3")
				end)
				if success and data then
					local ok, decoded = pcall(function()
						return base64_decode(data)
					end)
					if ok and decoded then
						writefile(MP3, decoded)
					else
						writefile(MP3, data)
					end
				else
					return ""
				end
			end
			if isfile(MP3) then
				local ok, asset = pcall(function()
					return getcustomasset(MP3)
				end)
				if ok and asset then
					AdminSounds.Data[name] = asset
					return asset
				end
			end
			return ""
		end
		admin_join_asset = AdminSounds.Load("admjoin")
		admin_leave_asset = AdminSounds.Load("admleave")
	end
	return Fonts, Images
end)();
local boykisser_asset = ""
local Library, Utility = LPH_JIT(function()
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local HttpService = game:GetService("HttpService")
	local GuiService = game:GetService("GuiService")
	local TweenService = game:GetService("TweenService")
	local Stats = game:GetService("Stats")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local Camera = workspace.CurrentCamera

	local Env = RunService:IsStudio() and _G or getgenv()
	local HiddenUI = RunService:IsStudio() and game.Players.LocalPlayer.PlayerGui  or game:GetService("CoreGui")
	local Converts = {
		[0] = "0",
		"1",
		"2",
		"3",
		"4",
		"5",
		"6",
		"7",
		"8",
		"9",
	}
	local KeyConverters = {
		escape = "ESC",
		backquote = "`",
		backspace = "BSP",
		slash = "/",
		leftquote = "'",
		rightquote = '"',
		leftbracket = "[",
		rightbracket = "]",
		semicolon = ";",
		comma = ",",
		period = ".",
		backslash = "\\",
		minus = "-",
		equals = "=",
		space = "SPC",
		[ "return" ] = "ENT",
		tab = "TAB",
		capslock = "CAP",
		leftshift = "LSH",
		mousebutton1 = "MB1",
		mousebutton2 = "MB2",
		mousebutton3 = "MB3",
		rightshift = "RSH",
		leftcontrol = "CTRL",
		leftalt = "ALT",
		leftsuper = "WIN",
		rightcontrol = "CTRL",
		rightalt = "ALT",
		rightsuper = "WIN",
		insert = "INS",
		delete = "DEL",
		home = "HME",
		pageup = "PUD",
		pagedown = "PDN",
		up = "UP",
		down = "DWN",
		left = "LFT",
		right = "RGT",
		numlock = "NUM",
		numpad0 = "N0",
		numpad1 = "N1",
		numpad2 = "N2",
		numpad3 = "N3",
		numpad4 = "N4",
		numpad5 = "N5",
		numpad6 = "N6",
		numpad7 = "N7",
		numpad8 = "N8",
		numpad9 = "N9",
	}
	local Library = {
		TweenSpeed = 0.4,
		TweenStyle = Enum.EasingStyle.Exponential,

		ThemeObjects = {},

		Font = Fonts.Get("Verdana"),
		FontSize = 16,

		Flags = {},
		ConfigFlags = {},

		Popups = {},

		CopiedColor = nil,

		Fps = 0,

		Images = {
			Lines = Images.Get("lines"),
			ScrollBar = Images.Get("scrollbar"),
			Saturation = Images.Get("saturation"),
			Checkers = Images.Get("checkers")
		},

		Theme = {
			outline = Color3.fromRGB(0, 0, 0),
			inline = Color3.fromRGB(40, 42, 44),
			["inline hovering"] = Color3.fromRGB(50, 52, 54),

			background = Color3.fromRGB(23, 25, 26),
			["dock background"] = Color3.fromRGB(19, 19, 19),

			accent = Color3.fromRGB(220, 100, 100),

			text = Color3.fromRGB(230, 230, 230),
			["dark text"] = Color3.fromRGB(86, 86, 86),
		},

	}; Library.__index = Library
	do
		Library.Utility = { Objects = {}, Connections = {} }; local Utility = Library.Utility do
			function Utility.New(object, props, theme)
				local Obj = Instance.new(object)

				if object == "TextButton" then
					Obj.AutoButtonColor = false
					Obj.Text = ""
					Obj.Style = Enum.ButtonStyle.Custom
				end

				if props then
					for prop, val in props do



						Obj[prop] = val
					end
				end

				if theme then
					Library.AddObjectTheme(Obj, theme)
				end

				table.insert(Utility.Objects, Obj)

				return Obj
			end

			function Utility.Signal(connection)
				table.insert(Utility.Connections, connection)

				return connection
			end

			function Utility.GetTransparency(obj)
				if obj:IsA("Frame") then
					return "BackgroundTransparency"
				elseif obj:IsA("TextLabel") or obj:IsA("TextButton") then
					return { "TextTransparency", "BackgroundTransparency" }
				elseif obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
					return { "BackgroundTransparency", "ImageTransparency" }
				elseif obj:IsA("ScrollingFrame") then
					return { "BackgroundTransparency", "ScrollBarImageTransparency" }
				elseif obj:IsA("TextBox") then
					return { "TextTransparency", "BackgroundTransparency" }
				elseif obj:IsA("UIStroke") then
					return "Transparency"
				end

				return nil
			end

			function Utility.Round(number, float)
				local Mult = 1 / (float or 1)

				return math.floor(number * Mult + 0.5) / Mult
			end


			function Utility.PositionOver(position, object, addedy)
				addedy = addedy or 0

				local posX, posY = object.AbsolutePosition.X, (object.AbsolutePosition.Y - addedy)
				local size = object.AbsoluteSize
				local sizeX, sizeY = posX + size.X, posY + size.Y + addedy

				if position.X >= posX and position.Y >= posY and position.X <= sizeX and position.Y <= sizeY then
					return true
				end

				return false
			end

			function Utility.MouseOver(object, input)
				local posX, posY = object.AbsolutePosition.X, object.AbsolutePosition.Y
				local size = object.AbsoluteSize
				local sizeX, sizeY = posX + size.X, posY + size.Y
				local position = input.Position

				if position.X >= posX and position.Y >= posY and position.X <= sizeX and position.Y <= sizeY then
					return true
				end

				return false
			end

			function Utility.Lerp(a, b, c)
				c = c or 1 / 8

				local offset = math.abs(b - a)
				if (offset < c) then
					return b
				end

				return a + (b - a) * c
			end

			function Utility.StringToEnum(enumstring)
				local EnumType, EnumValue = enumstring:match("Enum%.([^%.]+)%.(.+)")

				if EnumType and EnumValue then
					return Enum[EnumType][EnumValue]
				end

				return nil
			end

			function Utility.TextTriggers(text)
				local Triggers = {
					["{hour}"] = os.date("%H"),
					["{minute}"] = os.date("%M"),
					["{second}"] = os.date("%S"),
					["{ap}"] = os.date("%p"),
					["{month}"] = os.date("%b"),
					["{day}"] = os.date("%d"),
					["{year}"] = os.date("%Y"),
					["{fps}"] = Library.Fps,
					["{user}"] = SWG_DiscordUser or "admin",
					["{ping}"] = RunService:IsStudio() and 0 or math.floor(Stats.PerformanceStats.Ping:GetValue() or 0),
					["{time}"] = os.date("%H:%M:%S"),
					["{date}"] = os.date("%b. %d, %Y"),
					["{game}"] = Game and Game.Name or "Universal",
					["{n}"] = "\n"
				}

				for i,v in Triggers do
					text = string.gsub(text, i, v)
				end

				return text
			end

			function Utility.ToTitleCase(str)
				return str:gsub("(%a)([%w_']*)", function(first, rest)
					return first:upper() .. rest:lower()
				end)
			end

			function Utility.IsScrollable(frame)
				local CanvasSize = frame.AbsoluteCanvasSize
				local WindowSize = frame.AbsoluteWindowSize

				return CanvasSize.Y > WindowSize.Y
			end

			function Utility.IsAtBottom(frame)
				return frame.CanvasPosition.Y == frame.AbsoluteCanvasSize.Y - frame.AbsoluteWindowSize.Y
			end

			function Utility.RichText(text, color)
				return string.format('<font color="rgb(%s, %s, %s)">%s</font>', math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), text)
			end

			function Utility.GetFiles(folder, extensions)
				if not isfolder(folder) then
					makefolder(folder)
				end

				local Files = isfolder(folder) and listfiles(folder) or {}
				local StoredFiles = {}
				local FileNames = {}

				for _,v in Files do
					for _,ext in extensions do
						if v:find(ext) then
							StoredFiles[#StoredFiles + 1] = v
							FileNames[#FileNames + 1] = v:gsub(folder, ""):gsub(ext, "")
						end
					end
				end

				return StoredFiles, FileNames
			end
		end

		Library.ScreenGui = Utility.New("ScreenGui", {
			Name = "\0",
			DisplayOrder = 1,
			Parent = HiddenUI,
			IgnoreGuiInset = true,
		})

		Library.ScreenGuiPopups = Utility.New("ScreenGui", {
			Name = "\0",
			DisplayOrder = -1,
			Parent = HiddenUI,
			IgnoreGuiInset = true,
		})

		local ItemsHolder = Utility.New("Frame", {
			Name = "leftholder",
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			Position = UDim2.new(0, 0, 0, 60),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 1,
			Parent = Library.ScreenGuiPopups,
		})

		Utility.New("UIListLayout", {
			Padding = UDim.new(0, 0),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = ItemsHolder
		})

		Library.NotificationHolder = ItemsHolder

		function Library.Tween(obj, props, tweeninfo)
			tweeninfo = tweeninfo or TweenInfo.new(Library.TweenSpeed, Library.TweenStyle)

			local Tween = TweenService:Create(obj, tweeninfo, props)

			Tween:Play()

			return Tween
		end

		function Library.Fade(obj, prop, vis)
			if not ((obj:IsA("UIStroke") and obj.Enabled or obj.Visible) and prop) then
				return
			end

			local OldTransparency = obj[prop]
			obj[prop] = vis and 1 or OldTransparency

			local Tween = Library.Tween(obj, { [prop] = vis and OldTransparency or 1 })

			Utility.Signal(Tween.Completed:Connect(function()
				if not vis then
					task.wait()
					obj[prop] = OldTransparency
				end
			end))

			return Tween
		end

		function Library.AddObjectTheme(object, props)
			local Theme = {
				Props = props,
				Object = object
			}

			for prop,v in props do
				if type(v) == "string" then
					object[prop] = Library.Theme[v]
				elseif type(v) == "function" then
					object[prop] = v()
				end
			end

			Library.ThemeObjects[object] = Theme
		end

		function Library.ChangeObjectTheme(object, props, tweened)
			local Theme = Library.ThemeObjects[object]

			if Theme then
				Theme.Props = props

				for prop,v in props do
					if type(v) == "string" then
						if tweened then
							Theme.Tween = Library.Tween(object, {
								[prop] = Library.Theme[v]
							})
						else
							object[prop] = Library.Theme[v]
						end
					elseif type(v) == "function" then
						object[prop] = v()
					end
				end
			end
		end

		function Library.UpdateTheme(theme, color)
			if not Library.Theme[theme] then
				return
			end

			Library.Theme[theme] = color

			for _,themeobj in Library.ThemeObjects do
				for prop,val in themeobj.Props do
					if val == theme then
						if themeobj.Tween then
							themeobj.Tween:Cancel()
						end

						themeobj.Object[prop] = color
					end
				end
			end
		end

		function Library.Config(cfg, default)
			local Table = { }

			for name, val in cfg do
				Table[name:lower()] = val
			end

			for name, val in default do
				if Table[name] == nil then
					Table[name] = val
				end
			end

			return Table
		end

		function Library.Resize(holder, box)
			local Start, StartSize, Resizing;
			local CurrentSize = holder.Size
			local OriginalSize = holder.Size

			Utility.Signal(box.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Resizing = true
					Start = input.Position
					StartSize = holder.Size
				end
			end))

			Utility.Signal(UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and Resizing then
					local ViewportSize = Camera.ViewportSize
					CurrentSize = UDim2.new(0, math.clamp(StartSize.X.Offset + (input.Position.X - Start.X), OriginalSize.X.Offset, ViewportSize.x), 0, math.clamp(StartSize.Y.Offset + (input.Position.Y - Start.Y), OriginalSize.Y.Offset, ViewportSize.y))
					holder.Size = CurrentSize
				end
			end))

			Utility.Signal(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Resizing = false
				end
			end))
		end

		function Library.Dragging(holder, box, useinset)
			useinset = useinset == nil and true or useinset

			local Start, StartPos, Dragging;
			local CurrentPos;
			local Inset = GuiService:GetGuiInset( );

			Utility.Signal(box.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = true
					Start = input.Position
					StartPos = holder.AbsolutePosition
				end
			end))

			Utility.Signal(UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
					local MaxSize = holder.AbsoluteSize
					local ViewportSize = Camera.ViewportSize
					CurrentPos = UDim2.new(0, math.clamp(StartPos.X + (input.Position.X - Start.X), 0, ViewportSize.x - MaxSize.x), 0, math.clamp(StartPos.Y + (input.Position.Y - Start.Y + 36), 0, ViewportSize.y - MaxSize.y) + ( useinset and (Inset.Y / 2) or 0 ))
					holder.Position = CurrentPos
				end
			end))

			Utility.Signal(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Dragging = false
				end
			end))
		end

		function Library.CreateList(cfg)
			cfg = cfg or {}; cfg = Library.Config(cfg, {
				namestart = "Key",
				nameend = "binds",
				size = 150,
			})

			local List = {
				Objects = { },

				Items = { },

				ShowMode = cfg.showmode,

				View = "All",
			}

			function List.Refresh()
				for _, item in List.Items do
					if item.LastText ~= nil then
						item.Set(item.LastValue, item.LastText, item.LastMode, item.LastKey, item.LastOn)
					end
				end
			end

			function List.FitWidth()
				if not List.Objects.accent then return end
				local w = 150
				for _, item in List.Items do
					if item.LastText ~= nil then
						local s = "[" .. (item.LastKey or "-") .. "] " .. item.LastText .. " [" .. (item.LastMode or "") .. "]"
						w = math.max(w, #s * 7 + 50)
					end
				end
				List.Objects.accent.Size = UDim2.new(0, w, 0, 0)
			end

			local Objects = List.Objects; do
			Objects.accent = Utility.New("Frame", {
				Name = "accent",
				Position = UDim2.new(0, 20, 0.5, 0),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				Size = UDim2.new(0, cfg.size, 0, 0),
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundColor3 = Color3.fromRGB(19, 19, 19),
				BackgroundTransparency = 0.5,
				Parent = Library.ScreenGuiPopups,
			})

				Library.Dragging(Objects.accent, Objects.accent, true)

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(19, 19, 19),
					BackgroundTransparency = 0.5,
					Parent = Objects.accent,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 4),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.background,
				})

				Objects.dock_background = Utility.New("Frame", {
					Name = "dock_background",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 23),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(19, 19, 19),
					Parent = Objects.background,
				}, { BackgroundColor3 = "dock background" })

				Objects.textholder = Utility.New("Frame", {
					Name = "textholder",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.dock_background,
				})

				Utility.New("UIPadding", {
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					Parent = Objects.textholder,
				})

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.textholder,
				})

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.namestart,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "text",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "text" })

				Objects.text2 = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(220, 100, 100),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.nameend,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "accent",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "accent" })

				Objects.content = Utility.New("Frame", {
					Name = "content",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.content,
					Padding = UDim.new(0, 0),
				})
			end

			function List.Add()
				local Item = {}

				local Holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					Visible = false,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.content,
				})

				Utility.New("UIPadding", {
					Parent = Holder,
					PaddingBottom = UDim.new(0, 8),
				})

				local Text = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					Name = "text",
					TextStrokeTransparency = 0,
					Size = UDim2.new(1, -16, 0, 0),
					Position = UDim2.new(0, 8, 0, 0),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Holder,
				}, { TextColor3 = "text" })

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Parent = Text,
				})

				local Accent = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(220, 100, 100),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "[]",
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "accent",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Text,
				}, { TextColor3 = "accent" })

				function Item.Set(value, text, mode, key, funcOn)
					Item.LastValue, Item.LastText, Item.LastMode, Item.LastKey, Item.LastOn = value, text, mode, key, funcOn
					local showAll = List.View == "All"
					Holder.Visible = showAll and funcOn or value
					Text.Text = string.format("[%s] %s", key or "-", text)
					Text.TextSize = 12
					Accent.Text = string.format("[%s]", mode)
					Accent.Visible = value
					if showAll and funcOn and not value then
						Text.TextColor3 = Color3.fromRGB(126, 126, 126)
					else
						Text.TextColor3 = Color3.fromRGB(230, 230, 230)
					end
					List.FitWidth()
				end

				table.insert(List.Items, Item)

				return Item
			end

			function List.Status(value)
				Objects.accent.Visible = value
			end

			return List
		end

		local KeybindList = Library.CreateList()
		Library.KeybindsList = KeybindList



		function Library.ColorpickerWindow(self)
			local Popup = {
				Visible = false,

				Tweening = false,

				Objects = { },

				Flag = nil,

				SetFunc = function() end,

				Alpha = 1,

				Color = Color3.new(1, 1, 1),

				HuePos = nil,
			}

			local Objects = Popup.Objects; do
				Objects.accent = Utility.New("Frame", {
					Size = UDim2.new(0, 200, 0, 200),
					Name = "accent",
					Position = UDim2.new(0, 0, 0, 0),
					Visible = false,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Library.ScreenGui,
				}, { BackgroundColor3 = "accent" })

				Objects.outline = Utility.New("Frame", {
					Name = "outline",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "outline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.outline,
				}, { BackgroundColor3 = "background" })

				Utility.New("UIPadding", {
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.background,
				})

				Objects.satholder = Utility.New("Frame", {
					Name = "satholder",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 0, 186),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 6),
					SortOrder = Enum.SortOrder.LayoutOrder,
					FillDirection = Enum.FillDirection.Horizontal,
					Parent = Objects.satholder,
				})

				Objects.saturation = Utility.New("TextButton", {
					Name = "saturation",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 186, 0, 186),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 0, 4),
					Parent = Objects.satholder,
				})

				Objects.saturationimage = Utility.New("ImageLabel", {
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Image = Library.Images.Saturation,
					BackgroundTransparency = 1,
					Name = "saturationimage",
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.saturation,
				})

				Objects.saturationpickeroutline = Utility.New("Frame", {
					Name = "saturationpickeroutline",
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 3, 0, 3),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.saturationimage,
				})

				Objects.saturationpicker = Utility.New("Frame", {
					Name = "saturationpicker",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.saturationpickeroutline,
				})

				Objects.hue = Utility.New("TextButton", {
					Name = "hue",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 12, 0, 186),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.satholder,
				})

				Objects.huepickeroutline = Utility.New("Frame", {
					Name = "huepickeroutline",
					Position = UDim2.new(0, 0, 0.5, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 3),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.hue,
				})

				Objects.huepicker = Utility.New("Frame", {
					Name = "huepicker",
					Position = UDim2.new(0, 0, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.huepickeroutline,
				})

				Utility.New("UIGradient", {
					Rotation = -90,
					Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
						ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 0, 255)),
						ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 0, 255)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
						ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 255, 0)),
						ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 255, 0)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
					},
					Parent = Objects.hue,
				})

				Objects.alphaimage = Utility.New("ImageLabel", {
					ScaleType = Enum.ScaleType.Tile,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Name = "alphaimage",
					Image = Library.Images.Checkers,
					TileSize = UDim2.new(0, 6, 0, 6),
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(0, 186, 0, 12),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.alpha = Utility.New("TextButton", {
					Name = "alpha",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.alphaimage,
				})

				Objects.UIGradient = Utility.New("UIGradient", {
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(1, 0)
					},
					Parent = Objects.alpha,
				})

				Objects.alphapickeroutline = Utility.New("Frame", {
					Name = "alphapickeroutline",
					Position = UDim2.new(0.5, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 3, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.alpha,
				})

				Objects.alphapicker = Utility.New("Frame", {
					Name = "alphapicker",
					Position = UDim2.new(0, 1, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.alphapickeroutline,
				})

				Objects.buttonline = Utility.New("Frame", {
					Name = "buttonline",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 186, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 5),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.buttonline,
				})

				Library.Button({
					holder = Objects.buttonline,
				}, {Name = "Copy", Callback = function()
					Library.CopiedColor = Popup.Color
				end})

				Library.Button({
					holder = Objects.buttonline,
				}, {Name = "Paste", Callback = function()
					if not Library.CopiedColor then
						Library.Notification("Please copy a color first.", 5)
						return
					end

					Popup.Set(Library.CopiedColor, Popup.Alpha, false)
				end})
			end

			local Hue, Sat, Val;
			function Popup.Set(color, alpha, ignore)
				alpha = alpha or Popup.Alpha

				Hue, Sat, Val = color:ToHSV()

				Popup.Color = color
				Popup.Alpha = alpha

				if not ignore then
					Library.Tween(Objects.saturationpickeroutline, {
						Position = UDim2.new(
							Sat,
							0,
							1 - Val,
							0
						),
						AnchorPoint = Vector2.new(Sat, 1 - Val)
					})

					Popup.HuePos = Hue

					Library.Tween(Objects.huepickeroutline, {
						Position = UDim2.new(
							0,
							0,
							Hue,
							0
						),
						AnchorPoint = Vector2.new(0, Hue)
					})

					Library.Tween(Objects.alphapickeroutline, {
						Position = UDim2.new(
							1 - alpha,
							0,
							0,
							0
						),
						AnchorPoint = Vector2.new(1 - alpha, 0)
					})
				end

				Popup.SetFunc(color, alpha)

				Objects.huepicker.BackgroundColor3 = Color3.fromHSV(Popup.HuePos, 1, 1)
				Objects.saturationpicker.BackgroundColor3 = color
				Objects.alphapicker.BackgroundColor3 = color
				Objects.saturation.BackgroundColor3 = Color3.fromHSV(Popup.HuePos, 1, 1)
			end

			function Popup.Open(visibility, position)
				if Popup.Tweening or Popup.Visible == visibility then
					return
				end

				Popup.Tweening = true

				Popup.Visible = visibility

				if Popup.Visible then
					Objects.accent.Visible = true

					Objects.saturationpickeroutline.Position = UDim2.new(0, 0, 0, 0)
					Objects.alphapickeroutline.Position = UDim2.new(0, 0, 0, 0)
					Objects.huepickeroutline.Position = UDim2.new(0, 0, 0, 0)
				end

				local ParentObjects = Objects.accent:GetDescendants()

				table.insert(ParentObjects, Objects.accent)

				local Tween;
				for _, obj in ParentObjects do
					local Index = Utility.GetTransparency(obj)
					if not Index then continue end

					if type(Index) == "table" then
						for _, prop in Index do
							Tween = Library.Fade(obj, prop, Popup.Visible)
						end
					else
						Tween = Library.Fade(obj, Index, Popup.Visible)
					end
				end

				if not Popup.Visible then
					Library.Tween(Objects.saturationpickeroutline, {
						Position = UDim2.new(
							0,
							0,
							0,
							0
						),
						AnchorPoint = Vector2.new(0, 0)
					})

					Library.Tween(Objects.huepickeroutline, {
						Position = UDim2.new(
							0,
							0,
							0,
							0
						),
						AnchorPoint = Vector2.new(0, 0)
					})

					Library.Tween(Objects.alphapickeroutline, {
						Position = UDim2.new(
							0,
							0,
							0,
							0
						),
						AnchorPoint = Vector2.new(0, 0)
					})
				end

				if position then
					Objects.accent.Position = UDim2.new(0, position.X, 0, position.Y)
				end

				Utility.Signal(Tween.Completed:Connect(function()
					Objects.accent.Visible = Popup.Visible

					Popup.Tweening = false
				end))
			end

			function Popup.SlideSaturation(input)
				if Popup.Tweening or not Popup.Visible then return end

				local SizeX = math.clamp((input.Position.X - Objects.saturation.AbsolutePosition.X) / Objects.saturation.AbsoluteSize.X, 0, 1)
				local SizeY = 1 - math.clamp((input.Position.Y - Objects.saturation.AbsolutePosition.Y) / Objects.saturation.AbsoluteSize.Y, 0, 1)

				Objects.saturationpickeroutline.Position = UDim2.new(SizeX, 0, 1 - SizeY, 0)
				Objects.saturationpickeroutline.AnchorPoint = Vector2.new(SizeX, 1 - SizeY)

				Popup.Set(Color3.fromHSV(Popup.HuePos, SizeX, SizeY), Popup.Alpha, true)
			end

			Utility.Signal(Objects.saturation.MouseButton1Down:Connect(function()
				Popup.SlidingSaturation = true
				Popup.SlideSaturation({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset( ).Y) })
			end))

			function Popup.SlideHue(input)
				if Popup.Tweening or not Popup.Visible then return end

				local SizeY = math.clamp((input.Position.Y - Objects.hue.AbsolutePosition.Y) / Objects.hue.AbsoluteSize.Y, 0, 1)

				Objects.huepickeroutline.Position = UDim2.new(0, 0, SizeY, 0)
				Objects.huepickeroutline.AnchorPoint = Vector2.new(0, SizeY)
				Popup.HuePos = SizeY

				Popup.Set(Color3.fromHSV(SizeY, Sat, Val), Popup.Alpha, true)
			end

			Utility.Signal(Objects.hue.MouseButton1Down:Connect(function()
				Popup.SlidingHue = true
				Popup.SlideHue({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset( ).Y) })
			end))

			function Popup.SlideAlpha(input)
				if Popup.Tweening or not Popup.Visible then return end

				local SizeX = math.clamp((input.Position.X - Objects.alpha.AbsolutePosition.X) / Objects.alpha.AbsoluteSize.X, 0, 1)

				Objects.alphapickeroutline.Position = UDim2.new(SizeX, 0, 0, 0)
				Objects.alphapickeroutline.AnchorPoint = Vector2.new(SizeX, 0)
				Popup.Set(Popup.Color, 1 - SizeX, true)
			end

			Utility.Signal(Objects.alpha.MouseButton1Down:Connect(function()
				Popup.SlidingAlpha = true
				Popup.SlideAlpha({ Position = UserInputService:GetMouseLocation() })
			end))

			Utility.Signal(UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					if Popup.SlidingSaturation then Popup.SlideSaturation({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset( ).Y) }) end
					if Popup.SlidingHue then Popup.SlideHue({ Position = UserInputService:GetMouseLocation() - Vector2.new(0, GuiService:GetGuiInset( ).Y) }) end
					if Popup.SlidingAlpha then Popup.SlideAlpha({ Position = UserInputService:GetMouseLocation() }) end
				end
			end))

			Utility.Signal(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					Popup.SlidingSaturation, Popup.SlidingHue, Popup.SlidingAlpha = false, false, false
				end
			end))

			return Popup
		end

		function Library.Window(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				size = UDim2.fromOffset(602, 502),
				open = true,
				namestart = "swim",
				nameend = "hub",
			})

			local Window = {
				Objects = { },

				Visible = cfg.open,

				Tweening = false,

				TabsTweening = false,

				Tabs = { },

				CurrentPage = nil,
			}

			local Objects = Window.Objects; do
				Objects.ScreenGui = Utility.New("ScreenGui", {
					Name = "\0",
					Parent = HiddenUI,
					IgnoreGuiInset = true,
				})

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(0.5, -cfg.size.X.Offset / 2, 0.5, -cfg.size.Y.Offset / 2),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = cfg.size,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.ScreenGui,
				}, { BackgroundColor3 = "accent" })

				Objects.outline = Utility.New("Frame", {
					Name = "outline",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "outline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.outline,
				}, { BackgroundColor3 = "background" })

				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 44),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -14, 1, -58),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.dock_background = Utility.New("Frame", {
					Name = "dock_background",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 30),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(19, 19, 19),
					Parent = Objects.background,
				}, { BackgroundColor3 = "dock background" })

				Library.Dragging(Objects.accent, Objects.dock_background, true)

				Objects.textholder = Utility.New("Frame", {
					Name = "textholder",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.dock_background,
				})

				Utility.New("UIPadding", {
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					Parent = Objects.textholder,
				})

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.textholder,
				})

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.namestart,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "text",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "text" })

				Objects.text2 = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(220, 100, 100),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.nameend,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "accent",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "accent" })

				Objects.shadow = Utility.New("Frame", {
					Name = "shadow",
					Position = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 8),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(16, 16, 16),
					Parent = Objects.dock_background,
				})

				Utility.New("UIGradient", {
					Rotation = 90,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(1, 1)
					},
					Parent = Objects.shadow,
				})

				Objects.tabsholder = Utility.New("Frame", {
					BackgroundTransparency = 1,
					Name = "tabsholder",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 105, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					VerticalFlex = Enum.UIFlexAlignment.Fill,
					Parent = Objects.tabsholder,
				})

				Window.tabsholder = Objects.tabsholder

				Window.pageholder = Objects.holder
			end

			function Window.Open()
				if Window.Tweening then
					return
				end

				Window.Tweening = true

				Library.ColorpickerWindow.Open(false)

				Window.Visible = not Window.Visible

				if Window.Visible then
					Objects.accent.Visible = true
				end

				for _,popup in Library.Popups do
					popup.Open(false)
				end

				local Tween;
				for _,obj in Objects.ScreenGui:GetDescendants() do
					local Index = Utility.GetTransparency(obj)

					if not Index then continue end

					if type(Index) == "table" then
						for _,prop in Index do
							Tween = Library.Fade(obj, prop, Window.Visible)
						end
					else
						Tween = Library.Fade(obj, Index, Window.Visible)
					end
				end

				Utility.Signal(Tween.Completed:Connect(function()
					Window.Tweening = false
					Objects.accent.Visible = Window.Visible
				end))
			end

			return setmetatable(Window, Library)
		end

		function Library.Tab(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "Tab",
				image = "rbxassetid://12941020168",
				size = 45,
				side = false,
			})

			local Tab = {
				Selected = false,

				Objects = { },

				Name = cfg.name,

				Tabs = {}
			}

			local Objects = Tab.Objects; do
				Objects.holder = Utility.New("TextButton", {
					BackgroundTransparency = 1,
					Name = "holder",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 105, 0, 88),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.tabsholder,
				})

				Objects.icon = Utility.New("ImageLabel", {
					ImageColor3 = Color3.fromRGB(215, 215, 215),
					ScaleType = Enum.ScaleType.Fit,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Name = "icon",
					AnchorPoint = Vector2.new(0.5, 0.5),
					Image = cfg.image,
					BackgroundTransparency = 1,
					Position = UDim2.new(0.5, -2, 0.5, 0),
					Size = UDim2.new(0, cfg.size, 0, cfg.size),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				}, { ImageColor3 = "text" })

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(1, -2, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 2, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.holder,
				}, { BackgroundColor3 = "accent" })

				Objects.pagetabsholder = Utility.New("Frame", {
					Name = "pagetabsholder",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 115, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -115, 0, 32),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.pageholder,
				})

				Utility.New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Parent = Objects.pagetabsholder,
				})

				Tab.pagetabsholder = Objects.pagetabsholder

				Objects.page = Utility.New("Frame", {
					Name = "page",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 115, 0, 42),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -115, 1, -42),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.pageholder,
				})

				Tab.pageholder = Objects.page
			end

			function Tab.Set(status, nested)
				Library.ChangeObjectTheme(Objects.accent, {
					BackgroundColor3 = status and "accent" or "inline",
				}, true)

				Library.ChangeObjectTheme(Objects.icon, {
					ImageColor3 = status and "text" or "dark text",
				}, true)

				Objects.pagetabsholder.Parent = status and self.pageholder or HiddenUI
				Objects.page.Parent = status and self.pageholder or HiddenUI

				Tab.Selected = status

				if not nested then
					for _,tab in self.Tabs do
						if tab == Tab then continue end

						tab.Set(false, true)
					end
				end
			end

			Utility.Signal(Objects.holder.MouseButton1Click:Connect(function()
				Tab.Set(true)
			end))

			table.insert(self.Tabs, Tab)

			return setmetatable(Tab, Library)
		end

		function Library.SubTab(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "Tab",
			})

			local Tab = {
				Selected = false,

				Objects = { },
			}

			local Objects = Tab.Objects; do
				Objects.holder = Utility.New("TextButton", {
					BackgroundTransparency = 1,
					Name = "holder",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.pagetabsholder,
				})

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(0, 0, 1, -2),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.holder,
				}, { BackgroundColor3 = "accent" })

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.name,
					TextStrokeTransparency = 0,
					Name = "text",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 18),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.holder,
				}, { TextColor3 = "text" })

				Objects.page = Utility.New("Frame", {
					Name = "page",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.pageholder,
				})

				Utility.New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.page,
				})

				Objects.left = Utility.New("Frame", {
					BackgroundTransparency = 1,
					Name = "left",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.page,
				})

				Tab.left = Objects.left

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.left,
				})

				Objects.right = Utility.New("Frame", {
					BackgroundTransparency = 1,
					Name = "right",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.page,
				})

				Tab.right = Objects.right

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.right,
				})
			end

			function Tab.Set(status, nested)
				Library.ChangeObjectTheme(Objects.accent, {
					BackgroundColor3 = status and "accent" or "inline",
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = status and "text" or "dark text",
				}, true)

				Tab.Selected = status

				Objects.page.Parent = status and self.pageholder or HiddenUI

				if not nested then
					for _,tab in self.Tabs do
						if tab == Tab then continue end

						tab.Set(false, true)
					end
				end
			end

			Utility.Signal(Objects.holder.MouseButton1Click:Connect(function()
				Tab.Set(true)
			end))

			table.insert(self.Tabs, Tab)

			return setmetatable(Tab, Library)
		end

		function Library.Section(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "Section",
				tabs = false,
				side = "left",
				size = UDim2.new(1, 0, 1, 0)
			})

			local Side = cfg.side:lower() == "left" and self.left or self.right

			local Section = {
				Objects = {},

				Tabs = {},
			}

			local Objects = Section.Objects; do
				Objects.outline = Utility.New("Frame", {
					Name = "outline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = cfg.size,
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Side,
				}, { BackgroundColor3 = "outline" })

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.outline,
				}, { BackgroundColor3 = "accent" })

				Objects.outline = Utility.New("Frame", {
					Name = "outline",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "outline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.outline,
				}, { BackgroundColor3 = "background" })

				Objects.dock_background = Utility.New("Frame", {
					Name = "dock_background",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 28),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(19, 19, 19),
					Parent = Objects.background,
				}, { BackgroundColor3 = "dock background" })

				Objects.shadow = Utility.New("Frame", {
					Name = "shadow",
					Position = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 8),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(16, 16, 16),
					Parent = Objects.dock_background,
				})

				Utility.New("UIGradient", {
					Rotation = 90,
					Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(1, 1)
					},
					Parent = Objects.shadow,
				})

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.name,
					TextStrokeTransparency = 0,
					Name = "text",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, -2),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.dock_background,
				}, { TextColor3 = "text" })

				Objects.accent = Utility.New("ScrollingFrame", {
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					ScrollBarImageColor3 = Color3.fromRGB(220, 100, 100),
					MidImage = Library.Images.ScrollBar,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 1,
					Name = "accent",
					Size = UDim2.new(1, -12, 1, -28),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 12, 0, 28),
					BottomImage = Library.Images.ScrollBar,
					TopImage = Library.Images.ScrollBar,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				}, { ScrollBarImageColor3 = "accent" })

				Objects.content = Utility.New("Frame", {
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Name = "content",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 12),
					Size = UDim2.new(1, -12, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.accent,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 9),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.content,
				})

				Utility.New("UIPadding", {
					Parent = Objects.accent,
					PaddingBottom = UDim.new(0, 4),
				})

				Section.holder = Objects.content
			end

			function Section.State(value)
				Objects.outline.Visible = value
			end

			return setmetatable(Section, Library)
		end

		function Library.Toggle(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Toggle",
				value = false,
				callback = function() end,
				flag = nil,
			})



			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Toggle = {
				Objects = { },

				Tweening = false,

				Value = false,
			}

			local Objects = Toggle.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("TextButton", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 17, 0, 17),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

			Objects.accent = Utility.New("Frame", {
				Name = "accent",
				Position = UDim2.new(0, 1, 0, 1),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				Size = UDim2.new(1, -2, 1, -2),
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(220, 100, 100),
				Parent = Objects.background,
			}, { BackgroundColor3 = "accent" })

			Objects.text = Utility.New("TextLabel", {
				FontFace = Library.Font,
				TextColor3 = Color3.fromRGB(230, 230, 230),
				BorderColor3 = Color3.fromRGB(0, 0, 0),
				Text = cfg.name,
				TextStrokeTransparency = 0,
				Name = "text",
				Size = UDim2.new(1, -25, 1, -3),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				Position = UDim2.new(0, 25, 0, 0),
				BorderSizePixel = 0,
				TextSize = Library.FontSize,
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				Parent = Objects.line,
			}, { TextColor3 = "text" })

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					Padding = UDim.new(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.text,
				})

				Toggle.childholder = Objects.text
			end

			function Toggle.Set(value)
				Toggle.Value = value

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = value and "text" or "dark text"
				}, true)

				Library.Tween(Objects.accent, {
					BackgroundTransparency = value and 0 or 1
				})

				cfg.callback(value)

				Library.Flags[cfg.flag] = value

				if Library.KeybindsList then
					for _, item in Library.KeybindsList.Items do
						if item.LinkFlag and item.LinkFlag == cfg.flag and item.LastText ~= nil then
							local funcOn = Library.Flags[cfg.flag] and true or false
							item.Set(item.LastValue, item.LastText, item.LastMode, item.LastKey, funcOn)
						end
					end
				end
			end

			function Toggle.Enable()
				Toggle.Set(not Toggle.Value)
			end

			function Toggle.State(value)
				Objects.holder.Visible = value
			end

			Utility.Signal(Objects.line.MouseButton1Click:Connect(Toggle.Enable))

			Utility.Signal(Objects.line.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				if not Toggle.Value then
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end
			end))

			Toggle.Set(cfg.value)

			Library.ConfigFlags[cfg.flag] = Toggle.Set

			return setmetatable(Toggle, Library)
		end

		function Library.Slider(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Slider",
				value = 50,
				min = 0,
				max = 100,
				float = 1,
				suffix = "%s",
				callback = function() end,
				flag = nil,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Slider = {
				Tweening = false,

				Objects = { },

				Value = cfg.value,

				Sliding = false,
			}

			local Objects = Slider.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("TextButton", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				if cfg.name ~= "" then
					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Slider.childholder = Objects.text

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})
				end

				Objects.value = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "50%",
					TextStrokeTransparency = 0,
					Name = "text",
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.text,
				}, { TextColor3 = "dark text" })

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					FillDirection = Enum.FillDirection.Horizontal,
					Parent = Objects.value,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.line,
				})

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 14),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0.5, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.background,
				}, { BackgroundColor3 = "accent" })

				Utility.New("UIPadding", {
					PaddingTop = UDim.new(0, 1),
					PaddingBottom = UDim.new(0, 1),
					PaddingRight = UDim.new(0, 1),
					PaddingLeft = UDim.new(0, 1),
					Parent = Objects.background,
				})
			end

			function Slider.Set(value)
				Slider.Value = math.clamp(Utility.Round(value, cfg.float), cfg.min, cfg.max)

				if Objects.value then
					Objects.value.Text = string.format(cfg.suffix, tostring(Slider.Value))
				end

				Objects.accent.Size = UDim2.new((Slider.Value - cfg.min) / (cfg.max - cfg.min), 0, 1, 0)

				cfg.callback(Slider.Value)

				Library.Flags[cfg.flag] = Slider.Value
			end

			function Slider.State(value)
				Objects.holder.Visible = value
			end

			Utility.Signal(Objects.line.MouseButton1Down:Connect(function(input)
				local MouseLocation = UserInputService:GetMouseLocation()

				Slider.Sliding = true

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "text"
				}, true)

				Slider.Set( ((cfg.max - cfg.min) * ((MouseLocation.x - Objects.inline.AbsolutePosition.x) / Objects.inline.AbsoluteSize.x)) + cfg.min )
			end))

			Utility.Signal(Objects.line.MouseEnter:Connect(function(input)
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function(input)
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				if not Slider.Sliding then
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)

					Library.ChangeObjectTheme(Objects.value, {
						TextColor3 = "dark text"
					}, true)
				end
			end))

			Utility.Signal(UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Sliding then
					Slider.Sliding = false

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)

					Library.ChangeObjectTheme(Objects.value, {
						TextColor3 = "dark text"
					}, true)
				end
			end))

			Utility.Signal(UserInputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and Slider.Sliding then
					Slider.Set( ((cfg.max - cfg.min) * ((input.Position.x - Objects.inline.AbsolutePosition.x) / Objects.inline.AbsoluteSize.x)) + cfg.min )
				end
			end))

			Slider.Set(cfg.value)

			Library.ConfigFlags[cfg.flag] = Slider.Set

			return setmetatable(Slider, Library)
		end

		function Library.Button(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Button",
				confirm = false,
				callback = function() end,
			})

			local Button = {
				Clicked = false,

				Time = 0,

				Objects = { },
			}

			local Objects = Button.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("TextButton", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 27),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.text = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.name,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "dark_text",
					Size = UDim2.new(1, 0, 1, -2),
					BorderSizePixel = 0,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.background,
				}, { TextColor3 = "dark text" })
			end

			function Button.StartConfirmation()
				Button.Clicked = true

				Button.Time = 5

				Objects.text.Text = string.format("Confirm %s? (%s)", cfg.name, Button.Time)

				Button.Coroutine = coroutine.create(function()
					for i = 1, 5 do
						task.wait(1)

						Button.Time -= 1

						if Button.Time > 0 then
							Objects.text.Text = string.format("Confirm %s? (%s)", cfg.name, Button.Time)
						else
							Objects.text.Text = cfg.name

							if Button.Clicked then
								Library.ChangeObjectTheme(Objects.text, {
									TextColor3 = "dark text"
								}, true)

								Button.Clicked = false
							end

							break
						end
					end
				end); coroutine.resume(Button.Coroutine)
			end

			function Button.Click()
				if cfg.confirm then
					if Button.Clicked then
						Library.ChangeObjectTheme(Objects.text, {
							TextColor3 = "dark text"
						}, true)

						coroutine.close(Button.Coroutine)

						Objects.text.Text = cfg.name

						Button.Clicked = false

						cfg.callback()
					else
						Library.ChangeObjectTheme(Objects.text, {
							TextColor3 = "text"
						}, true)

						Button.StartConfirmation()
					end
				else
					cfg.callback()

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)

					task.wait(Library.TweenSpeed)

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end
			end

			function Button.State(value)
				Objects.holder.Visible = value
			end

			Utility.Signal(Objects.line.MouseButton1Click:Connect(Button.Click))

			Utility.Signal(Objects.line.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				if not Button.Clicked then
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)
				end
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				if not Button.Clicked then
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end
			end))

			return setmetatable(Button, Library)
		end

		function Library.Dropdown(self, cfg)
			cfg = cfg or {}; cfg = Library.Config(cfg, {
				name = "New Dropdown",
				values = { "value1", "value2", "value3", "value4", "value5", "value6" },
				value = "value1",
				multi = false,
				flag = nil,
				callback = function() end,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Dropdown = {
				Tweening = false,

				Visible = false,

				Objects = { },

				Popup = { Objects = {} },

				Items = { },

				Value = nil,
			}

			local Objects = Dropdown.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("TextButton", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.line,
				})

				if cfg.name ~= "" then
					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Dropdown.childholder = Objects.text

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})
				end

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 27),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.value = Utility.New("TextLabel", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "-",
					TextStrokeTransparency = 0,
					Name = "dark_text",
					Size = UDim2.new(1, -4, 1, -2),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					Position = UDim2.new(0, 4, 0, 0),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.background,
				}, { TextColor3 = "dark text" })

				Objects.ImageLabel = Utility.New("ImageLabel", {
					ImageColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					AnchorPoint = Vector2.new(1, 0.5),
					Image = Library.Images.Lines,
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -8, 0.5, 0),
					Size = UDim2.new(0, 10, 0, 7),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.value.Size = UDim2.new(1, -(4 + Objects.ImageLabel.AbsoluteSize.X + 12), 1, -2)
			end

			local Popup = Dropdown.Popup; do
				local Objects = Popup.Objects

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					Position = UDim2.new(0, 618, 0, 464),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 199, 0, 60),
					BorderSizePixel = 0,
					Visible = false,
					ClipsDescendants = true,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Library.ScreenGui,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -1),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.accent = Utility.New("ScrollingFrame", {
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					ScrollBarImageColor3 = Color3.fromRGB(220, 100, 100),
					MidImage = Library.Images.ScrollBar,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 1,
					Name = "accent",
					Size = UDim2.new(1, 1, 1, 0),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, -1, 0, 0),
					BottomImage = Library.Images.ScrollBar,
					TopImage = Library.Images.ScrollBar,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				}, { ScrollBarImageColor3 = "accent" })

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.accent,
				})
			end


			Utility.Signal(Objects.inline:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
				if Dropdown.Visible then
					local Size = Objects.inline.AbsoluteSize

					local Position = Objects.inline.AbsolutePosition

					Popup.Objects.inline.Position = UDim2.new(0, math.round(Position.X), 0, math.round(Position.Y) + math.round(Size.Y) + GuiService:GetGuiInset().Y - 2)
				end
			end))

			Utility.Signal(UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and Dropdown.Visible and not Utility.MouseOver(Popup.Objects.inline, input) then
					Dropdown.Open(false)
				end
			end))


			function Dropdown.Display()
				local Value = Dropdown.Value

				if cfg.multi then
					local CurrentText = {}

					if #Value > 0 then
						for _,item in Value do
							table.insert(CurrentText, item)

							Objects.value.Text = table.concat(CurrentText, ", ")
						end
					else
						Objects.value.Text = "-"
					end
				else
					Objects.value.Text = type(Value) == "string" and Value or "-"
				end
			end

			function Dropdown.Size()
				local Size = 0

				local Count = 0

				for _,v in Popup.Objects.accent:GetChildren() do
					Count += 1

					if v:IsA("TextButton") then
						Size += v.AbsoluteSize.y
					end

					if Count > 5 then
						break
					end
				end

				return Size
			end

			function Dropdown.Open(visbility)
				if Dropdown.Tweening or Dropdown.Visible == visbility then
					return
				end

				Dropdown.Tweening = true

				Dropdown.Visible = visbility

				if Dropdown.Visible then
					Popup.Objects.inline.Visible = true
				end

				local ParentObjects = Popup.Objects.inline:GetDescendants()

				table.insert(ParentObjects, Popup.Objects.inline)

				for _, obj in ParentObjects do
					local Index = Utility.GetTransparency(obj)
					if not Index then continue end

					if type(Index) == "table" then
						for _, prop in Index do
							Library.Fade(obj, prop, Dropdown.Visible)
						end
					else
						Library.Fade(obj, Index, Dropdown.Visible)
					end
				end

				local Size = Vector2.new(Objects.inline.AbsoluteSize.x, math.round(Objects.inline.AbsoluteSize.y))

				local Position = Vector2.new(math.round(Objects.inline.AbsolutePosition.x), math.round(Objects.inline.AbsolutePosition.y))

				Popup.Objects.inline.Position = UDim2.new(0, Position.X, 0, Position.Y + Size.Y + 1 + GuiService:GetGuiInset().Y - 2)

				Popup.Objects.inline.Size = Dropdown.Visible and UDim2.new(0, Size.X, 0, 10) or UDim2.new(0, Size.X + 1, 0, Dropdown.Size())

				local Tween = Library.Tween(Popup.Objects.inline, {
					Size = Dropdown.Visible and UDim2.new(0, Size.X, 0, Dropdown.Size()) or UDim2.new(0, Size.X + 1, 0, 10),
				})

				Utility.Signal(Tween.Completed:Connect(function()
					Popup.Objects.inline.Visible = Dropdown.Visible

					Dropdown.Tweening = false
				end))
			end

			function Dropdown.Set(value, ignore)
				if cfg.multi then
					if type(value) == "table" then
						for _,item in Dropdown.Items do
							item.Select(false)
						end

						for _,item in value do
							for _,item2 in Dropdown.Items do
								if item2.Name == item then
									item2.Select(true)
								end
							end
						end

						Dropdown.Value = value

						Dropdown.Display()

						if not ignore then
							cfg.callback(Dropdown.Value)
						end

						Library.Flags[cfg.flag] = Dropdown.Value
					else
						local Index = table.find(Dropdown.Value, value)

						if Index then
							table.remove(Dropdown.Value, Index)

							for _,item in Dropdown.Items do
								if item.Name == value then
									item.Select(false)
								end
							end

							Dropdown.Display()

							if not ignore then
								cfg.callback(Dropdown.Value)
							end

							Library.Flags[cfg.flag] = Dropdown.Value
						else
							table.insert(Dropdown.Value, value)

							for _,item in Dropdown.Items do
								if item.Name == value then
									item.Select(true)
								end
							end

							Dropdown.Display()

							if not ignore then
								cfg.callback(Dropdown.Value)
							end

							Library.Flags[cfg.flag] = Dropdown.Value
						end
					end
				else
					for _,item in Dropdown.Items do
						item.Select(item.Name == value)
					end

					Dropdown.Value = value

					Dropdown.Display()

					if not ignore then
						cfg.callback(Dropdown.Value)
					end

					Library.Flags[cfg.flag] = Dropdown.Value
				end
			end

			function Dropdown.Add(name)
				local Item = {
					Objects = {},

					Name = name,

					Selected = false,
				}

				local Objects = Item.Objects; do
					Objects.holder = Utility.New("TextButton", {
						Name = "holder",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = Popup.Objects.accent,
					})

					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(230, 230, 230),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = name,
						TextStrokeTransparency = 0,
						Name = "text",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 5, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.XY,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.holder,
					}, { TextColor3 = "dark text" })

					Utility.New("UIPadding", {
						PaddingBottom = UDim.new(0, 4),
						PaddingTop = UDim.new(0, 4),
						PaddingRight = UDim.new(0, 6),
						Parent = Objects.text,
					})

					Objects.accent = Utility.New("Frame", {
						Name = "accent",
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Size = UDim2.new(0, 1, 1, 0),
						BorderSizePixel = 0,
						BackgroundColor3 = Color3.fromRGB(220, 100, 100),
						Parent = Objects.holder,
					}, { BackgroundColor3 = "accent" })

					Utility.New("UIListLayout", {
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.accent,
					})
				end

				function Item.Select(value)
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = value and "text" or "dark text"
					}, true)

					Library.Tween(Objects.accent, {
						BackgroundTransparency = value and 0 or 1
					})

					Item.Selected = value
				end

				Utility.Signal(Objects.holder.MouseButton1Click:Connect(function()
					Dropdown.Set(name)
				end))

				Utility.Signal(Objects.holder.MouseEnter:Connect(function()
					if Item.Selected then return end

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)
				end))

				Utility.Signal(Objects.holder.MouseLeave:Connect(function()
					if Item.Selected then return end

					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end))

				table.insert(Dropdown.Items, Item)

				return Item
			end

			function Dropdown.Refresh(tbl)
				for _,item in Dropdown.Items do
					item.Objects.holder:Destroy()
				end

				Dropdown.Items = { }

				Dropdown.Value = cfg.multi and { } or nil

				for _,item in tbl do
					Dropdown.Add(item)
				end

				Dropdown.Display()
			end

			function Dropdown.State(value)
				Objects.holder.Visible = value
				Dropdown.Open(false)
			end

			for _,item in cfg.values do
				Dropdown.Add(item)
			end

			Dropdown.Set(cfg.value)

			Utility.Signal(Objects.line.MouseButton1Click:Connect(function()
				Dropdown.Open(not Dropdown.Visible)
			end))

			Utility.Signal(Objects.line.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "dark text"
				}, true)

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "dark text"
				}, true)
			end))

			Library.ConfigFlags[cfg.flag] = Dropdown.Set

			table.insert(Library.Popups, Dropdown)

			return setmetatable(Dropdown, Library)
		end

		function Library.List(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New List",
				value = "value1",
				values = { "value1", "value2", "value3", "value4", "value5", "value6" },
				multi = false,
				size = 100,
				search = false,
				callback = function() end,
				flag = nil,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local List = {
				Objects = { },

				Items = { },

				Value = nil,
			}

			function List.SearchFunc(text)
				text = text:lower()

				for _,item in List.Items do
					local Holder = item.Objects.text

					Holder.Visible = text == "" and true or item.Name:lower():find(text)
				end
			end

			local Objects = List.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("Frame", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.line,
				})

				if cfg.name ~= "" then
					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})

					List.childholder = Objects.text
				end

				Objects.box = Utility.New("Frame", {
					Name = "box",
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.line,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, -1),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.box,
				})

				if cfg.search then
					Library.Textbox({
						holder = Objects.box
					}, {
						name = "",
						callback = function(value)
							List.SearchFunc(value)
						end,
						flag = "list_search_" .. cfg.name,
					})
				end

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, cfg.size),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.box,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.accent = Utility.New("ScrollingFrame", {
					Active = true,
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0, 0, 0, 0),
					ScrollBarImageColor3 = Color3.fromRGB(220, 100, 100),
					MidImage = Library.Images.ScrollBar,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					ScrollBarThickness = 1,
					Name = "accent",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					BottomImage = Library.Images.ScrollBar,
					TopImage = Library.Images.ScrollBar,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				}, { ScrollBarImageColor3 = "accent" })

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 10),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.accent,
				})

				Utility.New("UIPadding", {
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 4),
					PaddingRight = UDim.new(0, 4),
					PaddingLeft = UDim.new(0, 4),
					Parent = Objects.accent,
				})
			end

			function List.Set(value)
				if cfg.multi then
					if type(value) == "table" then
						for _,item in List.Items do
							item.Select(false)
						end

						for _,item in value do
							for _,item2 in List.Items do
								if item2.Name == item then
									item2.Select(true)
								end
							end
						end

						List.Value = value

						cfg.callback(List.Value)

						Library.Flags[cfg.flag] = List.Value
					else
						local Index = table.find(List.Value, value)

						if Index then
							table.remove(List.Value, Index)

							for _,item in List.Items do
								if item.Name == value then
									item.Select(false)
								end
							end

							cfg.callback(List.Value)

							Library.Flags[cfg.flag] = List.Value
						else
							table.insert(List.Value, value)

							for _,item in List.Items do
								if item.Name == value then
									item.Select(true)
								end
							end

							cfg.callback(List.Value)

							Library.Flags[cfg.flag] = List.Value
						end
					end
				else
					for _,item in List.Items do
						item.Select(item.Name == value)
					end

					List.Value = value

					cfg.callback(List.Value)

					Library.Flags[cfg.flag] = List.Value
				end
			end

			function List.Add(name)
				local Item = {
					Objects = {},

					Name = name,

					Selected = false,
				}

				local Objs = Item.Objects; do
					Objs.text = Utility.New("TextButton", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.accent,
					}, { TextColor3 = "dark text" })
				end

				function Item.Select(value)
					Library.ChangeObjectTheme(Objs.text, {
						TextColor3 = value and "text" or "dark text"
					}, true)

					Item.Selected = value
				end

				Utility.Signal(Objs.text.MouseButton1Click:Connect(function()
					List.Set(name)
				end))

				Utility.Signal(Objs.text.MouseEnter:Connect(function()
					if Item.Selected then return end

					Library.ChangeObjectTheme(Objs.text, {
						TextColor3 = "text"
					}, true)
				end))

				Utility.Signal(Objs.text.MouseLeave:Connect(function()
					if Item.Selected then return end

					Library.ChangeObjectTheme(Objs.text, {
						TextColor3 = "dark text"
					}, true)
				end))

				table.insert(List.Items, Item)

				return Item
			end

			function List.Refresh(tbl)
				for _,item in List.Items do
					item.Objects.text:Destroy()
				end

				List.Items = { }

				List.Value = cfg.multi and { } or nil

				for _,item in tbl do
					List.Add(item)
				end
			end

			function List.State(value)
				Objects.holder.Visible = value
			end

			for _,item in cfg.values do
				List.Add(item)
			end

			Utility.Signal(Objects.inline.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)
			end))

			Utility.Signal(Objects.inline.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)
			end))

			List.Set(cfg.value)

			Library.ConfigFlags[cfg.flag] = List.Set

			return setmetatable(List, Library)
		end

		function Library.Textbox(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "Textbox",
				value = "",
				callback = function() end,
				flag = nil,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Textbox = {
				Objects = { },
			}

			local Objects = Textbox.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = self.holder,
				})

				Objects.line = Utility.New("Frame", {
					Name = "line",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.holder,
				})

				Utility.New("UIListLayout", {
					Padding = UDim.new(0, 3),
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.line,
				})

				if cfg.name ~= "" then
					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Textbox.childholder = Objects.text

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})
				end

				Objects.inline = Utility.New("Frame", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 0, 27),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Objects.line,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.textbox = Utility.New("TextBox", {
					FontFace = Library.Font,
					Name = "text",
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.value,
					Size = UDim2.new(1, -5, 1, 0),
					TextStrokeTransparency = 0,
					Position = UDim2.new(0, 4, 0, 0),
					ClipsDescendants = true,
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					TextSize = Library.FontSize,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				}, { TextColor3 = "dark text" })
			end

			function Textbox.Set(value)
				Objects.textbox.Text = value

				Library.Flags[cfg.flag] = value
				cfg.callback(value)
			end

			function Textbox.State(value)
				Objects.holder.Visible = value
			end

			Utility.Signal(Objects.textbox.FocusLost:Connect(function()
				Textbox.Set(Objects.textbox.Text)

				Library.ChangeObjectTheme(Objects.textbox, {
					TextColor3 = "dark text"
				}, true)
			end))

			Utility.Signal(Objects.textbox.Focused:Connect(function()
				Library.ChangeObjectTheme(Objects.textbox, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "text"
				}, true)
			end))

			Utility.Signal(Objects.line.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)

				Library.ChangeObjectTheme(Objects.text, {
					TextColor3 = "dark text"
				}, true)
			end))

			Textbox.Set(cfg.value)

			Library.ConfigFlags[cfg.flag] = Textbox.Set

			return setmetatable(Textbox, Library)
		end

		function Library.Colorpicker(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Colorpicker",
				value = Color3.new(1, 1, 1),
				alpha = 0,
				usealpha = true,
				flag = nil,
				ignore = false,
				callback = function() end,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Colorpicker = {
				Tweening = false,

				ZIndex = self.ZIndex,

				Objects = { },

				OriginalColor = cfg.value,

				Popup = { },

				Value = cfg.value,

				Alpha = cfg.alpha,
			}

			local ZIndex = Colorpicker.ZIndex

			local Objects = Colorpicker.Objects; do
				if not self.childholder then
					Objects.holder = Utility.New("Frame", {
						Name = "holder",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = self.holder,
					})

					Objects.line = Utility.New("Frame", {
						Name = "line",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = Objects.holder,
					})

					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})

					Colorpicker.childholder = Objects.text
				end

				local Parent = self.childholder or Objects.text

				Objects.inline = Utility.New("TextButton", {
					Name = "inline",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 24, 0, 12),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Parent,
				}, { BackgroundColor3 = "inline" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.inline,
				}, { BackgroundColor3 = "background" })

				Objects.alphaimage = Utility.New("ImageLabel", {
					ScaleType = Enum.ScaleType.Tile,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Name = "alphaimage",
					Image = Library.Images.Checkers,
					TileSize = UDim2.new(0, 6, 0, 6),
					Position = UDim2.new(0, 1, 0, 1),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.color = Utility.New("Frame", {
					BackgroundTransparency = 0,
					Name = "color",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(0, 151, 197),
					Parent = Objects.alphaimage,
				})
			end

			local ColorpickerWindow = Library.ColorpickerWindow

			function Colorpicker.Set(value, alpha)
				local Color, Alpha;

				if type(value) == "table" then
					Color = value.c
					Alpha = value.a
				else
					Color = value
					Alpha = alpha or Colorpicker.Alpha
				end

				Colorpicker.Value = Color

				if Alpha then
					Colorpicker.Alpha = Alpha

					Objects.color.BackgroundTransparency = Alpha
				end

				Objects.color.BackgroundColor3 = Color

				if not cfg.ignore then
					Library.Flags[cfg.flag] = {
						c = Color,
						a = Alpha
					}
				end

				cfg.callback({
					c = Color,
					a = Alpha
				})
			end

			function Colorpicker.State(state)
				if Objects.holder then Objects.holder.Visible = state end
				Objects.inline.Visible = state
				ColorpickerWindow.Open(false)
			end

			Utility.Signal(Objects.inline.MouseButton1Click:Connect(function(input)
				ColorpickerWindow.Flag = cfg.flag

				ColorpickerWindow.SetFunc = Colorpicker.Set

				ColorpickerWindow.OriginalColor = Colorpicker.OriginalColor

				ColorpickerWindow.Set(Colorpicker.Value, Colorpicker.Alpha)

				ColorpickerWindow.Open(not ColorpickerWindow.Visible, Objects.inline.AbsolutePosition + Vector2.new(0, Objects.inline.AbsoluteSize.Y + 2 + GuiService:GetGuiInset().Y) )

				ColorpickerWindow.Objects.alphaimage.Visible = cfg.usealpha
			end))

			Utility.Signal(UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and ColorpickerWindow.Visible and ColorpickerWindow.Flag == cfg.flag and not (Utility.MouseOver(ColorpickerWindow.Objects.accent, input) or Utility.MouseOver(Objects.inline, input)) then
					ColorpickerWindow.Open(false, Objects.inline.AbsolutePosition + Vector2.new(0, Objects.inline.AbsoluteSize.Y + 2 + GuiService:GetGuiInset().Y) )
				end
			end))

			Utility.Signal(Objects.inline.MouseEnter:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline hovering"
				}, true)
			end))

			Utility.Signal(Objects.inline.MouseLeave:Connect(function()
				Library.ChangeObjectTheme(Objects.inline, {
					BackgroundColor3 = "inline"
				}, true)
			end))

			if Objects.line then
				Utility.Signal(Objects.line.MouseEnter:Connect(function()
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)
				end))

				Utility.Signal(Objects.line.MouseLeave:Connect(function()
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end))
			end

			Colorpicker.Set(cfg.value, cfg.alpha)

			if not cfg.ignore then
				Library.ConfigFlags[cfg.flag] = Colorpicker.Set
			end

			return setmetatable(Colorpicker, Library)
		end

		function Library.Keybind(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				name = "New Keybind",
				value = false,
				key = nil,
				mode = "Toggle",
				ignore = false,
				callback = function() end,
				flag = nil,
			})

			if not cfg.flag then
				cfg.flag = cfg.name
			end

			local Keybind = {
				Tweening = false,

				Visible = false,

				Objects = { },

				Popup = { Objects = {}, Items = {} },

				Key = nil,

				Mode = nil,

				Value = false,

				OnHold = nil,

				Listener = nil,
			}

			local Objects = Keybind.Objects; do
				if not self.childholder then
					Objects.holder = Utility.New("Frame", {
						Name = "holder",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = self.holder,
					})

					Objects.line = Utility.New("Frame", {
						Name = "line",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 0),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						BackgroundColor3 = Color3.fromRGB(255, 255, 255),
						Parent = Objects.holder,
					})

					Objects.text = Utility.New("TextLabel", {
						FontFace = Library.Font,
						TextColor3 = Color3.fromRGB(86, 86, 86),
						BorderColor3 = Color3.fromRGB(0, 0, 0),
						Text = cfg.name,
						TextStrokeTransparency = 0,
						Name = "text",
						Size = UDim2.new(1, 0, 0, 0),
						BackgroundTransparency = 1,
						TextXAlignment = Enum.TextXAlignment.Left,
						BorderSizePixel = 0,
						AutomaticSize = Enum.AutomaticSize.Y,
						TextSize = Library.FontSize,
						BackgroundColor3 = Color3.fromRGB(25, 25, 25),
						Parent = Objects.line,
					}, { TextColor3 = "dark text" })

					Utility.New("UIListLayout", {
						VerticalAlignment = Enum.VerticalAlignment.Center,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						Padding = UDim.new(0, 2),
						SortOrder = Enum.SortOrder.LayoutOrder,
						Parent = Objects.text,
					})

					Keybind.childholder = Objects.text
				end

				local Parent = self.childholder or Objects.text

				Objects.value = Utility.New("TextButton", {
					FontFace = Library.Font,
					TextColor3 = Color3.fromRGB(86, 86, 86),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "[-]",
					TextStrokeTransparency = 0,
					Name = "text",
					Size = UDim2.new(0, 0, 1, 0),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.X,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Parent,
				}, { TextColor3 = "dark text" })

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					HorizontalAlignment = Enum.HorizontalAlignment.Right,
					FillDirection = Enum.FillDirection.Horizontal,
					Parent = Objects.value,
				})
			end

			local Popup = Keybind.Popup; do
				Popup.Objects.inline = Utility.New("Frame", {
					Name = "inline",
					Position = UDim2.new(0, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Visible = false,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(40, 42, 44),
					Parent = Library.ScreenGui,
				}, { BackgroundColor3 = "inline" })

				Popup.Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Popup.Objects.inline,
				}, { BackgroundColor3 = "background" })

				Utility.New("UIPadding", {
					PaddingBottom = UDim.new(0, 1),
					Parent = Popup.Objects.background,
				})

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Popup.Objects.background,
				})

				function Popup.SetMode(mode)
					for _,item in Popup.Items do
						item.Select(item.Mode == mode)
					end
				end

				function Popup.Add(mode)
					local Item = {
						Objects = {},

						Mode = mode,

						Selected = false,
					}

					local Objs = Item.Objects; do
						Objs.holder = Utility.New("TextButton", {
							BackgroundTransparency = 1,
							Name = "holder",
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							BorderSizePixel = 0,
							AutomaticSize = Enum.AutomaticSize.XY,
							BackgroundColor3 = Color3.fromRGB(255, 255, 255),
							Parent = Popup.Objects.background,
						})

						Objs.text = Utility.New("TextLabel", {
							FontFace = Library.Font,
							TextColor3 = Color3.fromRGB(230, 230, 230),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							Text = mode,
							TextStrokeTransparency = 0,
							Name = "text",
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 4, 0, 0),
							BorderSizePixel = 0,
							AutomaticSize = Enum.AutomaticSize.XY,
							TextSize = 12,
							BackgroundColor3 = Color3.fromRGB(25, 25, 25),
							Parent = Objs.holder,
						}, { TextColor3 = "dark text" })

						Utility.New("UIPadding", {
							PaddingBottom = UDim.new(0, 4),
							PaddingTop = UDim.new(0, 4),
							PaddingRight = UDim.new(0, 6),
							Parent = Objs.text,
						})

						Objs.accent = Utility.New("Frame", {
							Name = "accent",
							Position = UDim2.new(0, -1, 0, 0),
							BorderColor3 = Color3.fromRGB(0, 0, 0),
							Size = UDim2.new(0, 1, 1, 0),
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							BackgroundColor3 = Color3.fromRGB(220, 100, 100),
							Parent = Objs.holder,
						}, { BackgroundColor3 = "accent" })
					end

					function Item.Select(value)
						Library.ChangeObjectTheme(Objs.text, {
							TextColor3 = value and "text" or "dark text"
						})

						Library.Tween(Objs.accent, {
							BackgroundTransparency = value and 0 or 1
						})

						Item.Selected = value
					end

					Utility.Signal(Objs.holder.MouseButton1Click:Connect(function()
						Keybind.Set(mode)
					end))

					Utility.Signal(Objs.holder.MouseEnter:Connect(function()
						if Item.Selected then return end

						Library.ChangeObjectTheme(Objs.text, {
							TextColor3 = "text"
						})
					end))

					Utility.Signal(Objs.holder.MouseLeave:Connect(function()
						if Item.Selected then return end

						Library.ChangeObjectTheme(Objs.text, {
							TextColor3 = "dark text"
						})
					end))

					Popup.Items[mode] = Item

					return Item
				end

				Utility.Signal(Objects.value:GetPropertyChangedSignal("AbsolutePosition"):Connect(function()
					if Keybind.Visible then
						local Size = Objects.value.AbsoluteSize
						local Position = Objects.value.AbsolutePosition

						Popup.Objects.inline.Position = UDim2.new(0, math.round(Position.X), 0, math.round(Position.Y) + math.round(Size.Y) + 2 + GuiService:GetGuiInset().Y)
					end
				end))
			end; Keybind.ZIndex = ZIndex

			for _,mode in cfg.modes or {"Always on", "Hold", "Toggle"} do
				Popup.Add(mode)
			end

			local Item;
			if not cfg.ignore then
				Item = Library.KeybindsList.Add()
				Item.LinkFlag = cfg.link
			end

			function Keybind.Set(value, ignore)
				if type(value) == "table" then
					for _,v in value do
						Keybind.Set(v, true)
					end

					return
				end

				local Type = typeof(value)
				if Type == "EnumItem" then
					Keybind.Key = value

					value = ( value == Enum.KeyCode.Unknown and "-" or value.Name )

					Objects.value.Text = string.format("[%s]", KeyConverters[ value:lower() ] or value)
				elseif Type == "boolean" then

					if Keybind.Mode == "Always on" and not value then
						value = true
					end

					Keybind.Value = value
				elseif Type == "string" then

					if cfg.modes and not table.find(cfg.modes, value) then
						value = cfg.modes[1]
					end

					if Keybind.OnHold and value ~= "Hold" then
						Keybind.OnHold:Disconnect( )
						Keybind.OnHold = nil
					end

					Keybind.Mode = value

					Popup.SetMode(value)

					if value == "Always on" then
						Keybind.Value = true
					end
				end

				if Item then
					local keyname = Keybind.Key and Keybind.Key.Name or "-"
					local funcOn = true
					if cfg.link then
						funcOn = Library.Flags[cfg.link] and true or false
					end
					Item.Set(Keybind.Value, cfg.name, Keybind.Mode or "Toggle", keyname, funcOn)
				end

				if not ignore then
					Library.Flags[cfg.flag] = Keybind.Value
					cfg.callback(Keybind.Value)
				end

				Library.Flags[string.format("%s_data", cfg.flag)] = {
					value = Keybind.Value,
					key = Keybind.Key,
					mode = Keybind.Mode
				}
			end

			function Keybind.Open(visibility)
				if Keybind.Tweening or Keybind.Visible == visibility then
					return
				end

				Keybind.Tweening = true

				Keybind.Visible = visibility

				if Keybind.Visible then
					Popup.Objects.inline.Visible = true
				end

				local ParentObjects = Popup.Objects.inline:GetDescendants()

				table.insert(ParentObjects, Popup.Objects.inline)

				local Tween;
				for _, obj in ParentObjects do
					local Index = Utility.GetTransparency(obj)
					if not Index then continue end

					if type(Index) == "table" then
						for _, prop in Index do
							Tween = Library.Fade(obj, prop, Keybind.Visible)
						end
					else
						Tween = Library.Fade(obj, Index, Keybind.Visible)
					end
				end

				Popup.Objects.inline.Position = UDim2.new(0, Objects.value.AbsolutePosition.X, 0, Objects.value.AbsolutePosition.Y + Objects.value.AbsoluteSize.Y + 2 + GuiService:GetGuiInset().Y)

				Utility.Signal(Tween.Completed:Connect(function()
					Keybind.Tweening = false

					Popup.Objects.inline.Visible = Keybind.Visible
				end))
			end

			function Keybind.State(state)
				if Objects.holder then Objects.holder.Visible = state end
				Objects.inline.Visible = state
				Keybind.Open(false)
			end

			Utility.Signal(Objects.value.MouseButton1Click:Connect(function(input)
				if Keybind.Listener then
					Keybind.Listener:Disconnect( )
					Keybind.Listener = nil

					return
				end

				Objects.value.Text = string.format("[%s]", "...")

				Library.ChangeObjectTheme(Objects.value, {
					TextColor3 = "text"
				}, true)

				task.wait( 1/50 )

				Keybind.Listener = Utility.Signal(UserInputService.InputBegan:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
						Keybind.Set( Enum.KeyCode.Unknown )

						Library.ChangeObjectTheme(Objects.value, {
							TextColor3 = "dark text"
						}, true)

						Keybind.Listener:Disconnect( )
						Keybind.Listener = nil

						return
					end

					if input.UserInputType == Enum.UserInputType.Keyboard or table.find({ Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3 }, input.UserInputType ) then
						local Key = input.KeyCode ~= Enum.KeyCode.Unknown and input.KeyCode or input.UserInputType or Enum.KeyCode.Unknown

						Keybind.Set( Key )

						Library.ChangeObjectTheme(Objects.value, {
							TextColor3 = "dark text"
						}, true)

						Keybind.Listener:Disconnect( )
						Keybind.Listener = nil
					end
				end))
			end))

			Utility.Signal(Objects.value.MouseButton2Click:Connect(function(input)
				Keybind.Open(not Keybind.Visible)
			end))

			Utility.Signal(UserInputService.InputBegan:Connect(function(input)
				if input.KeyCode == Keybind.Key or input.UserInputType == Keybind.Key then
					local Value = Keybind.Mode ~= "Toggle" or not Keybind.Value
					Keybind.Set( Value )

					if Keybind.Mode == "Hold" then
						if Keybind.OnHold then
							Keybind.OnHold:Disconnect( )
						end

						Keybind.OnHold = Utility.Signal(UserInputService.InputEnded:Connect(function(input)
							if input.KeyCode == Keybind.Key or input.UserInputType == Keybind.Key then
								Keybind.Set( false )

								if Keybind.OnHold then
									Keybind.OnHold:Disconnect( )
									Keybind.OnHold = nil
								end
							end
						end))


					end
				end
			end))

			Utility.Signal(UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and Keybind.Visible and not Utility.MouseOver(Popup.Objects.inline, input) then
					Keybind.Open(false)
				end
			end))

			if Objects.line then
				Utility.Signal(Objects.line.MouseEnter:Connect(function(input)
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "text"
					}, true)
				end))

				Utility.Signal(Objects.line.MouseLeave:Connect(function(input)
					Library.ChangeObjectTheme(Objects.text, {
						TextColor3 = "dark text"
					}, true)
				end))
			end

			Keybind.Set({ cfg.key, cfg.mode, cfg.value }, true)

			Library.ConfigFlags[string.format("%s_data", cfg.flag)] = Keybind.Set

			table.insert(Library.Popups, Keybind)

			return setmetatable(Keybind, Library)
		end


		function Library.Watermark(self, cfg)
			cfg = cfg or { }; cfg = Library.Config(cfg, {
				text = "ping: {ping}ms | user: admin | {date}",
				titlestart = "swim",
				titleend = "bot",
				visible = true,
				rate = 1 / 20,
			})

			local Watermark = {
				Objects = {},

				Visible = cfg.visible,

				Rate = cfg.rate,

				Text = cfg.text,

				Clock = os.clock(),
			}

			local Objects = Watermark.Objects; do
				Objects.accent = Utility.New("Frame", {
					Size = UDim2.new(0, 250, 0, 0),
					Name = "accent",
					Position = UDim2.new(0, 5, 0, 60),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Library.NotificationHolder,
				}, { BackgroundColor3 = "accent" })

				Objects.background = Utility.New("Frame", {
					Name = "background",
					Position = UDim2.new(0, 1, 0, 1),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(1, -2, 1, -2),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Parent = Objects.accent,
				}, { BackgroundColor3 = "background" })

				Utility.New("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.background,
				})

				Objects.topbar = Utility.New("Frame", {
					Name = "topbar",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Objects.textholder = Utility.New("Frame", {
					Name = "textholder",
					BackgroundTransparency = 1,
					Size = UDim2.new(0, 0, 1, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.topbar,
				})

				Utility.New("UIPadding", {
					PaddingBottom = UDim.new(0, 2),
					PaddingTop = UDim.new(0, 4),
					Parent = Objects.topbar,
				})

				Utility.New("UIPadding", {
					PaddingRight = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					Parent = Objects.textholder,
				})

				Utility.New("UIListLayout", {
					VerticalAlignment = Enum.VerticalAlignment.Center,
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.textholder,
				})

				Objects.text = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.titlestart,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "text",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "text" })

				Objects.text2 = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(220, 100, 100),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = cfg.titleend,
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "accent",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.textholder,
				}, { TextColor3 = "accent" })

				Objects.bottombar = Utility.New("Frame", {
					Name = "bottombar",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 0),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Objects.background,
				})

				Utility.New("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					HorizontalAlignment = Enum.HorizontalAlignment.Center,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Parent = Objects.bottombar,
				})

				Utility.New("UIPadding", {
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 8),
					PaddingRight = UDim.new(0, 14),
					PaddingLeft = UDim.new(0, 14),
					Parent = Objects.bottombar,
				})

				Objects.bottomtext = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = "",
					TextStrokeTransparency = 0,
					BackgroundTransparency = 1,
					Name = "text",
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.bottombar,
				}, { TextColor3 = "text" })
			end

			function Watermark.SetText(text)
				Watermark.Text = text
			end

			function Watermark.SetVisible(visibility)
				Objects.accent.Visible = visibility
				Watermark.Visible = visibility
			end

			function Watermark.SetRate(rate)
				Watermark.Rate = rate
			end

			local LastTime = 0
			local Frames = 0
			function Watermark.Think(step)
				Frames += 1
				if tick() - LastTime >= 1 then
					Library.Fps = Frames
					LastTime = tick()
					Frames = 0
				end

				if Watermark.Visible and os.clock() - Watermark.Clock >= Watermark.Rate then
					Watermark.Clock = os.clock()

					Objects.bottomtext.Text = Utility.TextTriggers(Watermark.Text)
				end
			end

			Utility.Signal(RunService.RenderStepped:Connect(Watermark.Think))

			return Watermark
		end

		function Library.Notification(text, time)
			local Notification = {
				Objects = { },
			}

			local Objects = Notification.Objects; do
				Objects.holder = Utility.New("Frame", {
					Name = "holder",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 0, 0, 70),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					Parent = Library.NotificationHolder,
				})

				Objects.background = Utility.New("Frame", {
					BackgroundTransparency = 0.5,
					Name = "background",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundColor3 = Color3.fromRGB(23, 25, 26),
					Position = UDim2.new(-1, 0, 0, 0),
					Parent = Objects.holder,
				}, { BackgroundColor3 = "background" })

				Objects.text = Utility.New("TextLabel", {
					FontFace = Fonts.Get("TahomaXP"),
					TextColor3 = Color3.fromRGB(230, 230, 230),
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Text = text,
					RichText = true,
					TextStrokeTransparency = 0,
					Name = "text",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 4, 0, 0),
					BorderSizePixel = 0,
					AutomaticSize = Enum.AutomaticSize.XY,
					TextSize = 12,
					BackgroundColor3 = Color3.fromRGB(25, 25, 25),
					Parent = Objects.background,
				}, { TextColor3 = "text" })

				Utility.New("UIPadding", {
					PaddingBottom = UDim.new(0, 8),
					PaddingTop = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
					Parent = Objects.text,
				})

				Objects.accent = Utility.New("Frame", {
					Name = "accent",
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					Size = UDim2.new(0, 2, 1, 0),
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(220, 100, 100),
					Parent = Objects.background,
				}, { BackgroundColor3 = "accent" })
			end

			task.spawn(function()
				Library.Tween(Objects.background, {
					Position = UDim2.new(0, 0, 0, 0),
				})

				task.wait(time)

				Library.Tween(Objects.background, {
					Position = UDim2.new(-1, 0, 0, 0),
				})

				task.wait(Library.TweenSpeed)

				local Size = Objects.holder.AbsoluteSize

				Objects.holder.AutomaticSize = Enum.AutomaticSize.None

				Objects.background:Destroy()

				Objects.holder.Size = UDim2.new(0, Size.X, 0, Size.Y)

				Library.Tween(Objects.holder, {
					Size = UDim2.new(0, Size.X, 0, 0),
				})

				task.wait(Library.TweenSpeed)

				Notification.Objects.holder:Destroy()
			end)

			return Notification
		end

		Library.ColorpickerWindow = Library.ColorpickerWindow()



		function Library.GetConfig()
			local Config = { }

			for _, v in Library.ConfigFlags do
				local Value = Library.Flags[_]

				if type(Value) == "table" and Value["key"] then
					Config[_] = {value = Value.value, mode = Value.mode, key = tostring(Value.key)}
				elseif type(Value) == "table" and Value["a"] and Value["c"] then
					Config[_] = {a = Value.a, c = Value.c:ToHex()}
				else
					Config[_] = Value
				end
			end

			return HttpService:JSONEncode(Config)
		end

		function Library.GetTheme()
			local Theme = { }

			for theme,v in Library.Theme do
				if typeof(v) == "Color3" then
					Theme[theme] = v:ToHex()
				end
			end

			return HttpService:JSONEncode(Theme)
		end

		function Library.GetThemeData(data)
			data = HttpService:JSONDecode(data)

			local RawData = {  }
			for theme,v in data do
				RawData[theme] = Color3.fromHex(v)
			end

			return RawData
		end

		function Library.LoadConfig(data)
			data = HttpService:JSONDecode(data)

			for i,v in data do
				local Config = Library.ConfigFlags[i]

				if Config then
					if type(v) == "table" and v["a"] and v["c"] then
						Config({
							a = v.a,
							c = type(v.c) == "string" and Color3.fromHex(v.c) or v.c
						})
					elseif type(v) == "table" and v["key"] then
						Config({
							value = v.value,
							mode = v.mode,
							key = Utility.StringToEnum(v.key)
						}, true)
					else
						Config(v)
					end
				end
			end
			pcall(function()
				Library.KeybindsList.Refresh()
			end)
		end

		function Library.Unload()
			for _,obj in Utility.Connections do
				obj:Disconnect()
			end

			for _,obj in Utility.Objects do
				obj:Destroy()
			end

			Env.Library = nil
		end
	end;
	Env.Library = Library
	Env.Utility = Library.Utility
	return Library, Library.Utility
end)();
local PicturesOnKill = LPH_JIT(function()
	local RunService = game:GetService("RunService")
	local HttpService = game:GetService("HttpService")
	local TweenService = game:GetService("TweenService")


	local PicturesOnKill = {
		URL = "https://raw.githubusercontent.com/zg071/moneyblox/refs/heads/main/assets/",

		DefaultImages = {
			"sigil.png",
			"cat.jpg"
		},

		Data = {}
	}
	do
		local current_image_index = 1
		local max_image_index = 1

		function PicturesOnKill.Reload()
			table.clear(PicturesOnKill.Data)
			current_image_index = 1
			max_image_index = 0

			local Pictures = Utility.GetFiles(PicturesOnKillFolder, { ".png", ".jpg", ".jpeg", ".webm" })

			for i, Picture in Pictures do
				max_image_index += 1
				PicturesOnKill.Data[max_image_index] = getcustomasset(Picture)
			end
		end

		function PicturesOnKill.GetNextPicture()
			if max_image_index < 1 then
				return
			end

			local Picture = PicturesOnKill.Data[current_image_index]

			current_image_index += 1

			if current_image_index > max_image_index then
				current_image_index = 1
			end

			return Picture
		end

		if not CREATE_PRESET_IMAGES then
			for _, image in PicturesOnKill.DefaultImages do
				local Picture = string.format("%s%s", PicturesOnKillFolder, image)
				if not isfile(Picture) then
					local success, data = pcall(function()
						return game:HttpGet( string.format( "%s%s", Images.URL, image ) )
					end)
					if success and data then
						writefile(Picture, base64_decode(data))
					end
				end
			end
		end

		PicturesOnKill.Reload()
	end

	return PicturesOnKill
end)();


local cloneref = cloneref or function(...) return ... end
local checkcaller = checkcaller
local getnamecallmethod = getnamecallmethod
local getcallingscript = getcallingscript
local tablecreate = table.create
local mathfloor = math.floor
local mathround = math.round
local mathrandom = math.random
local tostring = tostring
local unpack = table.unpack
local getupvalues = debug.getupvalues
local getupvalue = debug.getupvalue
local setupvalue = debug.setupvalue
local getconstants = debug.getconstants
local getconstant = debug.getconstant
local setconstant = debug.setconstant
local getstack = debug.getstack
local setstack = debug.setstack
local getinfo = debug.getinfo
local debugtraceback = debug.traceback
local rawget = rawget
local tick = tick

local workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local GuiInset = game:GetService("GuiService"):GetGuiInset()
local Lighting = game:GetService("Lighting")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Camera = workspace.CurrentCamera

local _CFramenew = CFrame.new
local _Vector2new = Vector2.new
local _Vector3new = Vector3.new
local _IsDescendantOf = game.IsDescendantOf
local _FindFirstChild = game.FindFirstChild
local _FindFirstChildOfClass = game.FindFirstChildOfClass
local _Raycast = workspace.Raycast
local _IsKeyDown = UserInputService.IsKeyDown
local _WorldToViewportPoint = Camera.WorldToViewportPoint
local _Vector3zeromin = Vector3.zero.Min
local _Vector2zeromin = Vector2.zero.Min
local _Vector3zeromax = Vector3.zero.Max
local _Vector2zeromax = Vector2.zero.Max
local _VectorToObjectSpace = CFrame.new().VectorToObjectSpace
local _IsA = game.IsA

local cheat = {
	Library = nil,
	Toggles = nil,
	Options = nil,
	ThemeManager = nil,
	SaveManager = nil,
	connections = {
		heartbeats = {},
		renderstepped = {}
	},
	drawings = {},
	hooks = {},
	hitsounds = {}
}

do
	local sounds = {}
	for name, id in {
        Bameware = "rbxassetid://3124331820",
        Bell = "rbxassetid://6534947240",
        Bubble = "rbxassetid://6534947588",
        Pick = "rbxassetid://1347140027",
        Pop = "rbxassetid://198598793",
        Rust = "rbxassetid://1255040462",
        Sans = "rbxassetid://3188795283",
        Fart = "rbxassetid://130833677",
        Big = "rbxassetid://5332005053",
        Vine = "rbxassetid://5332680810",
        Bruh = "rbxassetid://4578740568",
        Skeet = "rbxassetid://5633695679",
        Neverlose = "rbxassetid://6534948092",
        Fatality = "rbxassetid://6534947869",
        Bonk = "rbxassetid://5766898159",
        Minecraft = "rbxassetid://4018616850",
    } do
		local sound = Instance.new("Sound")
		sound.SoundId = id
		cheat.hitsounds[name] = sound
		table.insert(sounds, sound)
	end

	task.spawn(function()
		game:GetService("ContentProvider"):PreloadAsync(sounds, function(...)end)
	end)
end

local project_delta = {
	fps_object = nil,
	fps_hooks = {},
	fps_module = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("FPS")),
	universaltable_module = require(game:GetService("ReplicatedStorage").Modules:WaitForChild("UniversalTables")),
	reload_remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Reload"),
	equip_remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Equip"),
	updatetilt_remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpdateTilt"),
	inventorymove_remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("InventoryMove"),
	aizones = workspace:WaitForChild("AiZones"),
	droppeditems = workspace:WaitForChild("DroppedItems"),
	itemslist = game:GetService("ReplicatedStorage"):WaitForChild("ItemsList"),
	hitboxes_priority = {
		"FaceHitBox",
		"HeadTopHitBox",
		"Head",
		"UpperTorso",
		"LowerTorso",
		"LeftUpperArm",
		"LeftLowerArm",
		"LeftHand",
		"RightUpperArm",
		"RightLowerArm",
		"RightHand",
		"RightUpperLeg",
		"RightLowerLeg",
		"RightFoot",
		"LeftUpperLeg",
		"LeftLowerLeg",
		"LeftFoot"
	},
	hitboxes = {
		["FaceHitBox"] = true,
		["HeadTopHitBox"] = true,
		["Head"] = true,
		["UpperTorso"] = true,
		["LowerTorso"] = true,
		["LeftUpperArm"] = true,
		["LeftLowerArm"] = true,
		["LeftHand"] = true,
		["RightUpperArm"] = true,
		["RightLowerArm"] = true,
		["RightHand"] = true,
		["RightUpperLeg"] = true,
		["RightLowerLeg"] = true,
		["RightFoot"] = true,
		["LeftUpperLeg"] = true,
		["LeftLowerLeg"] = true,
		["LeftFoot"] = true
	}
}

for i, v in getgc(true) do
	if type(v) == "table" then
		if rawget(v, "springs") and rawget(v, "characterAnimations") then
			project_delta.fps_object = v
		end
		if type(rawget(v, "RangedWeaponDefault")) == "function" and type(rawget(v, "MeleeWeaponDefault")) == "function" then
			project_delta.fps_usetypes = v
		end
		if rawget(v, "loadByHand") and type(rawget(v, "magazine")) == "function" then


			project_delta.fps_reloadtypes = v
		end
	end
end


local desync_enabled, desync_enabled_key = false, false
local old_cframe, old_velocity, replicated_hrp_cframe, forced_cframe

do
	project_delta.fps_bindable = Instance.new("BindableEvent")

	project_delta.add_fps_hook = function(f)
		project_delta.fps_bindable.Event:Connect(f)
	end

	local fps_module = project_delta.fps_module
	local old = fps_module.new

	project_delta.update_fps = getupvalue(old, 5)
	if type(project_delta.update_fps) ~= "function" then
		project_delta.update_fps = function(...) end
	end
	project_delta.remove_bullet = getupvalue(project_delta.fps_usetypes.RangedWeaponDefault, 4)

	fps_module.new = function(player, character)
		local returns = old(player, character)
		task.delay(0.5, function()
			project_delta.fps_object = returns
			project_delta.fps_bindable:Fire()
		end)
		return returns
	end

	local player_folder = game:GetService("ReplicatedStorage"):WaitForChild("Players")
	local local_game_data = player_folder:WaitForChild(LocalPlayer.Name, 9e9)

	project_delta.local_game_data = local_game_data

	project_delta.FindFirstChildOfSlotType = LPH_NO_VIRTUALIZE(function(instance, slottype)
		for _, v in instance:GetChildren() do
			if v:GetAttribute("SlotType") == slottype then
				return v
			end
			if v:GetAttribute("Slot") == slottype then
				return v
			end
		end
	end)

	local findfirstchildofslottype = project_delta.FindFirstChildOfSlotType
	project_delta.get_visor_status = LPH_NO_VIRTUALIZE(function(inventory)
		local helmet_visor = findfirstchildofslottype(inventory, "ClothingHeadware")
		if not helmet_visor then
			return false
		end

		local attachments = _FindFirstChild(helmet_visor, "Attachments")
		if not attachments then
			return false
		end

		if not attachments:GetAttribute("Visor") then
			return false
		end

		helmet_visor = findfirstchildofslottype(attachments, "Visor")

		return (helmet_visor and helmet_visor:GetAttribute("Toggle") or false)
	end)

	project_delta.get_current_magazine = LPH_NO_VIRTUALIZE(function(gun)
		return findfirstchildofslottype(gun, "Magazine")
	end)


	project_delta.calculate_speed = LPH_NO_VIRTUALIZE(function(hrp)
		local external_mod = hrp:GetAttribute("MovementModifier")
		local movement_mod = project_delta.fps_object and project_delta.fps_object.movementModifier or 0
		local total_mod = external_mod + math.clamp(movement_mod, -10, 0)
		if local_game_data.Status.GameplayVariables.Buffs:GetAttribute("SerumRed") then
			total_mod = total_mod * 0.5 + 1
		end
		return 18.2 + total_mod
	end)

	project_delta.get_compatible_mag = LPH_NO_VIRTUALIZE(function(fps_object)
		local chosen_mag, loaded_mag_ammo = nil, 0
		local compatable_mags = fps_object.itemProperties.CompatibleMagazines
		for _, container in local_game_data.Inventory:GetChildren() do
			local inventory = _FindFirstChild(container, "Inventory")
			if not inventory then continue end
			for _, item in inventory:GetChildren() do
				if not compatable_mags:GetAttribute(item.Name) then continue end

				local loaded_ammo = item:GetAttribute("LoadedAmmo") or 0
				if chosen_mag and (loaded_ammo <= 0 or loaded_mag_ammo >= loaded_ammo) then continue end

				chosen_mag = item
				loaded_mag_ammo = loaded_ammo
			end
		end
		return chosen_mag, loaded_mag_ammo
	end)

	project_delta.get_compatible_ammo = LPH_NO_VIRTUALIZE(function(fps_object, arg_ammo)
		local needed_ammo = fps_object.MaxAmmo - fps_object.Bullets
		local chosen_ammo, ammo_amount = arg_ammo, arg_ammo and arg_ammo:GetAttribute("Amount") or 0

		if needed_ammo <= 0 or (chosen_ammo and ammo_amount) then
			return chosen_ammo, needed_ammo > ammo_amount and ammo_amount or needed_ammo
		end

		local item_properties = fps_object.itemProperties
		local compatible_ammo = item_properties.CompatibleAmmo
		local preferred_ammo = item_properties:GetAttribute("PreferredAmmo")
		for _, container in local_game_data.Inventory:GetChildren() do
			local inventory = _FindFirstChild(container, "Inventory")
			if not inventory then continue end

			for _, item in inventory:GetChildren() do
				if not compatible_ammo:GetAttribute(item.Name) then continue end
				if preferred_ammo and preferred_ammo ~= item.Name then continue end

				local loaded_ammo = (item:GetAttribute("Amount") or 0)
				if chosen_ammo and ammo_amount >= loaded_ammo then continue end

				ammo_amount = loaded_ammo
				chosen_ammo = item
			end
		end

		return chosen_ammo, needed_ammo > ammo_amount and ammo_amount or needed_ammo
	end)

	project_delta.get_mags_ammo = LPH_NO_VIRTUALIZE(function()
		local mags, ammo = {}, {}
		for _, container in local_game_data.Inventory:GetChildren() do
			local inventory = _FindFirstChild(container, "Inventory")
			if not inventory then continue end
			for _, item in inventory:GetChildren() do
				local item_prop = item.Value
				if not item_prop then continue end

				local item_type = item_prop:GetAttribute("ItemType")
				if item_type == "Magazine" then
					table.insert(mags, {item:GetAttribute("LoadedAmmo"), item:GetAttribute("AmmoType"), item:GetAttribute("Slot"), item, item_prop})
				elseif item_type == "Ammo" then
					table.insert(ammo, {item:GetAttribute("Amount"), item:GetAttribute("SlotType"), item:GetAttribute("Slot"), item, item_prop})
				end
			end
		end
		return mags, ammo
	end)

	local wallpen_params = RaycastParams.new()
	wallpen_params.FilterType = Enum.RaycastFilterType.Include
	wallpen_params.IgnoreWater = true
	wallpen_params.CollisionGroup = "WeaponRay"

	local material_ballistics = project_delta.universaltable_module.UniversalTable.MaterialBallistics
	local global_ignorelist_proj = project_delta.universaltable_module.UniversalTable.GlobalIgnoreListProjectile

	project_delta.calculate_penetration = LPH_NO_VIRTUALIZE(function(hit_part, hit_position, direction_vector, penetration_power)
		if hit_part:GetAttribute("NoPen") then return 0 end

		wallpen_params.FilterDescendantsInstances = { hit_part }

		local backwards_ray_origin = hit_position + direction_vector * 5
		local reverse_direction = -direction_vector

		local exit_ray_result = _Raycast(workspace, backwards_ray_origin, reverse_direction * 5, wallpen_params)

		if not exit_ray_result then return 0 end

		local exit_part = exit_ray_result.Instance
		local exit_position = exit_ray_result.Position
		local exit_normal = exit_ray_result.Normal
		local exit_material = exit_ray_result.Material
		local thickness = (exit_position - hit_position).Magnitude
		local material_properties = material_ballistics[exit_material.Name]

		if not material_properties then return 0 end

		local penetration_cost = hit_part:GetAttribute("PenResistance") and hit_part:GetAttribute("PenResistance") * thickness or material_properties.StrengthPerStud * thickness

		if not (penetration_cost and penetration_cost < penetration_power) then return 0 end

		return penetration_power - penetration_cost, hit_position + direction_vector * 0.03
	end)

	local weapon_params = RaycastParams.new()
	weapon_params.FilterType = Enum.RaycastFilterType.Exclude
	weapon_params.IgnoreWater = false
	weapon_params.CollisionGroup = "WeaponRay"

	local calculate_penetration, hitboxes = project_delta.calculate_penetration, project_delta.hitboxes

	project_delta.target_wall_penetration = LPH_NO_VIRTUALIZE(function(origin, target_character, target_part, target_position, bullet_stats)
		local character = LocalPlayer.Character
		weapon_params.FilterDescendantsInstances = { character, Camera, global_ignorelist_proj }

		local penetration_power, muzzle_velocity = bullet_stats:GetAttribute("ArmorPen"), bullet_stats:GetAttribute("MuzzleVelocity")

		local direction = (target_position - origin).Unit * muzzle_velocity * 1/120
		while true do
			local raycast_result = _Raycast(workspace, origin, direction, weapon_params)

			if not raycast_result then
				origin += direction
				continue
			end

			local hit_instance, hit_pos = raycast_result.Instance, raycast_result.Position

			if _IsDescendantOf(hit_instance, target_character) and hitboxes[hit_instance.Name] then
				return true
			end

			local pen_rem, pen_pos = calculate_penetration(hit_instance, hit_pos, direction, penetration_power)
			penetration_power = pen_rem

			if penetration_power <= 0 then
				return false
			end

			origin = pen_pos
		end

		return false
	end)

	local noclip_params = RaycastParams.new()
	noclip_params.FilterType = Enum.RaycastFilterType.Exclude
	noclip_params.IgnoreWater = true
	noclip_params.CollisionGroup = "NoclipRay"

	project_delta.get_estimated_origin = LPH_NO_VIRTUALIZE(function(player, position)
		local character = player.Character
		local leaning_factor = character:GetAttribute("Leaning") or 0
		local hrp = character.HumanoidRootPart
		local hum = character.Humanoid;
		local estimated_camera = (position or (
			player == LocalPlayer and replicated_hrp_cframe and replicated_hrp_cframe.Position or hrp.Position)
		) + (hum:GetAttribute("Crouch") and _Vector3new(0, 0.6, 0, 0) or _Vector3new(0, 1.6, 0, 0))
		if leaning_factor == 0 then
			return estimated_camera
		else
			noclip_params.FilterDescendantsInstances = { workspace.NoCollision, workspace.DroppedItems, Camera }
			local new_camera = _CFramenew(estimated_camera - hrp.CFrame.RightVector * leaning_factor * 1.18).Position
			local result = _Raycast(workspace, estimated_camera, (new_camera - estimated_camera), noclip_params)
			if result then
				return (estimated_camera + result.Position) * 0.8
			else
				return new_camera
			end
		end
	end)
end

cheat.utility = {} do
	cheat.utility.new_heartbeat = function(func)
		local obj = {}
		cheat.connections.heartbeats[func] = func
		function obj:Disconnect()
			if func then
				cheat.connections.heartbeats[func] = nil
				func = nil
			end
		end
		return obj
	end
	cheat.utility.new_renderstepped = function(func)
		local obj = {}
		cheat.connections.renderstepped[func] = func
		function obj:Disconnect()
			if func then
				cheat.connections.renderstepped[func] = nil
				func = nil
			end
		end
		return obj
	end
	cheat.utility.new_drawing = function(drawobj, args)
		local obj = Drawing.new(drawobj)
		for i, v in (args) do
			obj[i] = v
		end
		cheat.drawings[obj] = obj
		return obj
	end
	cheat.utility.new_hook = function(f, newf, usecclosure) LPH_NO_VIRTUALIZE(function()
			if usecclosure then
				local old; old = hookfunction(f, newcclosure(function(...)
					return newf(old, ...)
				end))
				cheat.hooks[f] = old
				return old
			else
				local old; old = hookfunction(f, function(...)
					return newf(old, ...)
				end)
				cheat.hooks[f] = old
				return old
			end
		end)() end
	local connection; connection = RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function(delta)
		for _, func in (cheat.connections.heartbeats) do
			func(delta)
		end
	end))
	local connection1; connection1 = RunService.PreRender:Connect(LPH_NO_VIRTUALIZE(function(delta)
		for _, func in (cheat.connections.renderstepped) do
			func(delta)
		end
	end))
	cheat.utility.unload = function()
		connection:Disconnect()
		connection1:Disconnect()
		for key, _ in (cheat.connections.heartbeats) do
			cheat.connections.heartbeats[key] = nil
		end
		for key, _ in (cheat.connections.renderstepped) do
			cheat.connections.heartbeats[key] = nil
		end
		for _, drawing in (cheat.drawings) do
			drawing:Remove()
			cheat.drawings[_] = nil
		end
		for hooked, original in (cheat.hooks) do
			if type(original) == "function" then
				hookfunction(hooked, clonefunction(original))
			else
				hookmetamethod(original["instance"], original["metamethod"], clonefunction(original["func"]))
			end
		end
	end
end

local notification_queue = {}

do
    cheat.utility.new_renderstepped(function()
        for i, v in notification_queue do
			Library.Notification(v.text, v.duration)
            notification_queue[i] = nil
        end
    end)
	cheat.utility.new_heartbeat(function()
		Camera = workspace.CurrentCamera
	end)
end


if setfflag then
	setfflag("AdornShadingAPI", "true")
end

LPH_NO_VIRTUALIZE(function()
	local esp_table = {}
	local workspace = game:GetService("Workspace")
	local rservice = game:GetService("RunService")
	local plrs = game:GetService("Players")
	local lplr = plrs.LocalPlayer
	local container = Instance.new("Folder", game:GetService("CoreGui").RobloxGui)
	local gui_inset = game:GetService("GuiService"):GetGuiInset()

	esp_table = {
		__loaded = false,
		registered_flags = {},
		settings = {
			enemy = {
				main_settings = {
					fade_time = 1,
					team_check = false,
					dead_check = false,
					dist_check = false,
					npc_check = false,
					visible_check = false,
					max_distance = 1000,
					skeleton_rate = 1e-10,
					gradient_spin = false,
					gradient_speed = 360,
					holder_spin = false,
					holder_speed = 360
				},

				enabled = false,

				box = false,
				box_outline = false,
				health_bar = false,
				name = false,
				health_text = false,
				distance = false,
				weapon = false,
				skeleton = false,
				flags = false,

				box_color = { Color3.new(1, 1, 1), Color3.new(1, 1, 1), 0 },
				box_outline_color = { Color3.new(1, 1, 1), 0, Color3.new(1, 1, 1), 0 },
				health_bar_color = { Color3.new(1, 1, 1), Color3.new(1, 1, 1) },
				name_color = { Color3.new(1, 1, 1), 0 },
				health_text_color = { Color3.new(1, 1, 1), 0 },
				dist_color = { Color3.new(1, 1, 1), 0 },
				weapon_color = { Color3.new(1, 1, 1), 0 },
				skeleton_color = { Color3.new(1, 1, 1), 0 },
				flags_color = { Color3.new(1, 1, 1), 0 },

				box_rotation = 0,

				chams = false,
				chams_color = { Color3.new(1, 1, 1), 0 },
				chams_glow_factor = 2,
				chams_visible_only = false
			},
			item = {
				main_settings = {
					dist_check = true,
					max_distance = 100
				},

				enabled = true,

				distance = true,
				amount = true,
				durability = true,
				durability_bar = true,

				text_color = { Color3.new(1, 1, 1), 0.7 }
			},
			corpse = {
				main_settings = {
					dist_check = false,
					max_distance = 100
				},

				enabled = true,

				distance = true,

				text_color = { Color3.new(1, 1, 1), 0.5 }
			}
		}
	}

	local loaded_plrs = {}

	local VERTICES = {
		_Vector3new(-1, -1, -1),
		_Vector3new(-1, 1, -1),
		_Vector3new(-1, 1, 1),
		_Vector3new(-1, -1, 1),
		_Vector3new(1, -1, -1),
		_Vector3new(1, 1, -1),
		_Vector3new(1, 1, 1),
		_Vector3new(1, -1, 1)
	}
	local skeleton_order = {
		["LeftFoot"] = "LeftLowerLeg",
		["LeftLowerLeg"] = "LeftUpperLeg",
		["LeftUpperLeg"] = "LowerTorso",

		["RightFoot"] = "RightLowerLeg",
		["RightLowerLeg"] = "RightUpperLeg",
		["RightUpperLeg"] = "LowerTorso",

		["LeftHand"] = "LeftLowerArm",
		["LeftLowerArm"] = "LeftUpperArm",
		["LeftUpperArm"] = "UpperTorso",

		["RightHand"] = "RightLowerArm",
		["RightLowerArm"] = "RightUpperArm",
		["RightUpperArm"] = "UpperTorso",

		["LowerTorso"] = "UpperTorso",
		["UpperTorso"] = "Head"
	}
	local esp = {}
	esp.create_obj = function(new, args, tbl)
		local obj = Instance.new(new)
		for i, v in args do
			obj[i] = v
		end
		if tbl then table.insert(tbl, obj) end
		return obj
	end

	local valid_parts = {
		["LeftFoot"] = true,
		["LeftLowerLeg"] = true,
		["LeftUpperLeg"] = true,
		["RightFoot"] = true,
		["RightLowerLeg"] = true,
		["RightUpperLeg"] = true,
		["LeftHand"] = true,
		["LeftLowerArm"] = true,
		["LeftUpperArm"] = true,
		["RightHand"] = true,
		["RightLowerArm"] = true,
		["RightUpperArm"] = true,
		["LowerTorso"] = true,
		["UpperTorso"] = true,
		["Head"] = true
	}

	local function isBodyPart(name)
		return valid_parts[name]
	end

	local function getBoundingBox(parts)
		local min, max
		for i, part in parts do
			local cframe, size = part[1], part[2]

			min = _Vector3zeromin(min or cframe.Position, (cframe - size * 0.5).Position)
			max = _Vector3zeromax(max or cframe.Position, (cframe + size * 0.5).Position)
		end

		local center = (min + max) * 0.5
		local front = _Vector3new(center.X, center.Y, max.Z)
		return _CFramenew(center, front), max - min
	end

	local function worldToScreen(world)
		local screen, inBounds = Camera:WorldToScreenPoint(world)
		return _Vector2new(screen.X, screen.Y) + gui_inset, inBounds, screen.Z
	end

	local function calculateCorners(cframe, size)
		local corners = table.create(#VERTICES)
		for i, vertice in VERTICES do
			corners[i] = worldToScreen((cframe + size * 0.5 * vertice).Position)
		end

		return _Vector2zeromin(Camera.ViewportSize, unpack(corners)), _Vector2zeromax(Vector2.zero, unpack(corners))
	end

	local create_esp, create_object_esp, create_corpse_esp, create_item_esp, destroy_esp;

	create_esp = function(plr_instance)
		local is_npc = plr_instance.ClassName == "Model"
		local is_helicopter = is_npc and plr_instance.Name == "MI24V"

		loaded_plrs[plr_instance] = {
			obj = {},
			connections = {}
		}





		local flags_table = {}
		local chams_table = {}

		local registered_flags = esp_table.registered_flags

		local plr = loaded_plrs[plr_instance]
		local obj = plr.obj

		local main_holder = esp.create_obj("Frame", {
			Parent = container,
			ZIndex = 2,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(0, 0),
			Position = UDim2.fromScale(0, 0),
			BackgroundTransparency = 1,
			Visible = false
		}, obj)
		local box_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			ZIndex = -1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, -2, 1, -2),
			Position = UDim2.new(0, 1, 0, 1),
			BackgroundTransparency = 1
		}, obj)
		local box_outline_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			ZIndex = -1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(1, 1, 1),
			Size = UDim2.new(1, -4, 1, -4),
			Position = UDim2.new(0, 2, 0, 2),
			BackgroundTransparency = 1
		}, obj)

		local main_box = esp.create_obj("UIStroke", {
			Parent = box_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new(1, 1, 1)
		}, obj)
		local main_box_color = esp.create_obj("UIGradient", {
			Parent = main_box,
			Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
			}
		}, obj)
		local main_box_outline_1 = esp.create_obj("UIStroke", {
			Parent = main_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)
		local main_box_outline_2 = esp.create_obj("UIStroke", {
			Parent = box_outline_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		local main_name = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 12,
			FontFace = Fonts.Get("TahomaXP"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 13),
			Text = plr_instance.Name,
			Position = UDim2.new(0.5, 0, 0, -17)
		}, obj)

		local main_distance = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 12,
			FontFace = Fonts.Get("TahomaXP"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 13),
			Text = "0m",
			Position = UDim2.new(0.5, 0, 1, 1)
		}, obj)

		local main_weapon = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 12,
			FontFace = Fonts.Get("TahomaXP"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 13),
			Text = "",
			Position = UDim2.new(0.5, 0, 1, 14)
		}, obj)

		esp.create_obj("UIStroke", {
			Parent = main_name,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		esp.create_obj("UIStroke", {
			Parent = main_distance,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		esp.create_obj("UIStroke", {
			Parent = main_weapon,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		local health_bar_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			BackgroundColor3 = Color3.new(0, 0, 0),
			Size = UDim2.new(0, 1, 1, 0),
			Position = UDim2.new(0, -5, 0, 0),
			BorderSizePixel = 0
		}, obj)

		local health_bar_outline = esp.create_obj("UIStroke", {
			Parent = health_bar_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		local main_health_bar = esp.create_obj("Frame", {
			Parent = health_bar_holder,
			ZIndex = 2,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(0, 0, 0),
			Size = UDim2.new(1, 0, 0, 0)
		}, obj)

		local main_health_text = esp.create_obj("TextLabel", {
			Parent = main_health_bar,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Right,
			FontFace = Fonts.Get("TahomaXP"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(1, 0),
			Size = UDim2.new(50, 0, 0, 6),
			Text = "100",
			Position = UDim2.new(-2, 0, 1, 0)
		}, obj)

		esp.create_obj("UIStroke", {
			Parent = main_health_text,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
			LineJoinMode = Enum.LineJoinMode.Miter,
			Color = Color3.new()
		}, obj)

		local health_bar_thing = esp.create_obj("Frame", {
			Parent = health_bar_holder,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.new(1, 1, 1),
			AnchorPoint = Vector2.new(0, 1),
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0, 0, 1, 0)
		}, obj)

		local main_health_bar_color = esp.create_obj("UIGradient", {
			Parent = health_bar_thing,
			Rotation = 90,
			Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
				ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
			}
		}, obj)

		local flag_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(1, 3, 0, -4),
			BackgroundTransparency = 1,
		}, obj)

		esp.create_obj("UIListLayout", {
			Parent = flag_holder,
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalFlex = Enum.UIFlexAlignment.None,
			Padding = UDim.new(0, -2)
		}, obj)


		for i, v in registered_flags do
			local flag = esp.create_obj("TextLabel", {
				Parent = flag_holder,
				TextStrokeTransparency = 0,
				BorderSizePixel = 0,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = Fonts.Get("SmallestPixel7"),
				TextColor3 = Color3.fromRGB(255, 255, 255),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 10),
				Text = v[1],
				Position = UDim2.new(0, 0, 0, -1)
			}, flags_table)
			table.insert(obj, flag)
			esp.create_obj("UIStroke", {
				Parent = flag,
				ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
				LineJoinMode = Enum.LineJoinMode.Miter,
				Color = Color3.new()
			}, obj)
		end

		local main_wireframe = esp.create_obj("WireframeHandleAdornment", {
			Parent = container,
			Color3 = Color3.new(1, 1, 1),
			Transparency = 0,
			AlwaysOnTop = true,
			CFrame = CFrame.new(),
			Scale = Vector3.one,
			Thickness = 1,
			AdornCullingMode = Enum.AdornCullingMode.Automatic
		}, obj)



		local settings = esp_table.settings.enemy
		local main_settings = settings.main_settings

		local character, humanoid, head, root


		local team_check, dead_check, dist_check, npc_check, visible_check = main_settings.team_check, main_settings.dead_check, main_settings.dist_check, main_settings.npc_check, main_settings.visible_check
		local skeleton_rate = main_settings.skeleton_rate <= 0 and 1e-10 or main_settings.skeleton_rate
		local max_distance, update_skeleton = main_settings.max_distance, settings.skeleton
		local weapon_enabled, box_rotation = settings.weapon, settings.box_rotation

		local gradient_spin, gradient_speed = main_settings.gradient_spin, main_settings.gradient_speed
		local holder_spin, holder_speed = main_settings.holder_spin, main_settings.holder_speed

		local get_team, get_gun = esp_table.get_team, esp_table.get_gun

		local setvis_cache, skeleton_tick = false, 0
		local cham_vis_ok = true

		function plr:forceupdate()
			team_check, dead_check, dist_check, npc_check, visible_check = main_settings.team_check, main_settings.dead_check, main_settings.dist_check, main_settings.npc_check, main_settings.visible_check
			skeleton_rate = main_settings.skeleton_rate <= 0 and 1e-10 or main_settings.skeleton_rate
			max_distance, update_skeleton = main_settings.max_distance, settings.skeleton
			weapon_enabled, box_rotation = settings.weapon, settings.box_rotation

			gradient_spin, gradient_speed = main_settings.gradient_spin, main_settings.gradient_speed
			holder_spin, holder_speed = main_settings.holder_spin, main_settings.holder_speed

			main_box_outline_1.Enabled = settings.box_outline
			main_box_outline_1.Color = settings.box_outline_color[1]
			main_box_outline_1.Transparency = settings.box_outline_color[2]

			main_box_outline_2.Enabled = settings.box_outline
			main_box_outline_2.Color = settings.box_outline_color[3]
			main_box_outline_2.Transparency = settings.box_outline_color[4]

			main_box.Enabled = settings.box
			main_box.Transparency = settings.box_color[3]
			main_box_color.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, settings.box_color[1]),
				ColorSequenceKeypoint.new(1, settings.box_color[2])
			}
			main_box_color.Rotation = box_rotation + (gradient_spin and tick() % 1 * gradient_speed or 0)

			health_bar_holder.Visible = settings.health_bar
			main_health_bar_color.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, settings.health_bar_color[1]),
				ColorSequenceKeypoint.new(1, settings.health_bar_color[2])
			}

			main_health_text.Visible = settings.health_text
			main_health_text.TextColor3 = settings.health_text_color[1]
			main_health_text.TextTransparency = settings.health_text_color[2]

			main_name.Visible = settings.name
			main_name.TextColor3 = settings.name_color[1]
			main_name.TextTransparency = settings.name_color[2]

			main_distance.Visible = settings.distance
			main_distance.TextColor3 = settings.distance_color[1]
			main_distance.TextTransparency = settings.distance_color[2]

			main_weapon.Visible = settings.weapon
			main_weapon.TextColor3 = settings.weapon_color[1]
			main_weapon.TextTransparency = settings.weapon_color[2]

			main_wireframe.Visible = settings.skeleton
			main_wireframe.Color3 = settings.skeleton_color[1]
			main_wireframe.Transparency = settings.skeleton_color[2]

			flag_holder.Visible = settings.flags
			for _, flag in flags_table do
				flag.TextColor3 = settings.flags_color[1]
				flag.TextTransparency = settings.flags_color[2]
			end

			for part, cham in chams_table do
				cham.cham.Adornee = setvis_cache and settings.chams and (not settings.chams_visible_only or cham_vis_ok) and part or nil
				cham.cham.Color3 = Color3.new(
					settings.chams_color[1].R * settings.chams_glow_factor,
					settings.chams_color[1].G * settings.chams_glow_factor,
					settings.chams_color[1].B * settings.chams_glow_factor
				)
			end
		end

		local destroy_cham_object = function(part)
			if not chams_table[part] then
				return
			end
			chams_table[part].connection:Disconnect()
			chams_table[part].cham:Destroy()
			chams_table[part] = nil
		end

		local create_cham_object = function(part)
			if not (_IsA(part, "BasePart") and isBodyPart(part.Name)) then return end
			if chams_table[part] then destroy_cham_object(part) end

			local cham = esp.create_obj("BoxHandleAdornment", {
				Parent = container,
				Size = part.Size * .95,
				Adornee = setvis_cache and settings.chams and (not settings.chams_visible_only or cham_vis_ok) and part or nil,
				Color3 = Color3.new(
					settings.chams_color[1].R * settings.chams_glow_factor,
					settings.chams_color[1].G * settings.chams_glow_factor,
					settings.chams_color[1].B * settings.chams_glow_factor
				),
				Transparency = -1,
				Shading = Enum.AdornShading.XRayShaded,
				ZIndex = -1,
				AlwaysOnTop = false
			}, obj)

			local conn = part:GetPropertyChangedSignal("Size"):Connect(function()
				if not (cham and part) then return print("MEMORY LEAK!!!!!!", cham, part) end
				cham.Size = part.Size * .95
			end)

			chams_table[part] = {
				cham = cham,
				connection = conn
			}
		end

		function plr:togglevis(bool, fade)
			if setvis_cache == bool then return end
			setvis_cache = bool

			main_holder.Visible = bool
			for part, cham in chams_table do
				cham.cham.Adornee = bool and settings.chams and (not settings.chams_visible_only or cham_vis_ok) and part or nil
			end
		end

		function plr:unload()
			if not loaded_plrs[plr_instance] then return end
			for i,v in chams_table do
				v.connection:Disconnect()
				chams_table[i] = nil
			end
			for i,v in plr.connections do
				v:Disconnect()
				plr.connections[i] = nil
			end
			for i,v in plr.obj do
				v:Remove()
				plr.obj[i] = nil
			end
			for i,v in plr do
				plr[i] = nil
			end
			loaded_plrs[plr_instance] = nil
		end

		local character_added = function(character)
			for _, part in character:GetChildren() do
				create_cham_object(part)
			end
			plr.connections["character_childadded"] = character.ChildAdded:Connect(function(part)
				create_cham_object(part)
			end)
			plr.connections["character_childremoved"] = character.ChildRemoved:Connect(function(part)
				destroy_cham_object(part)
			end)
		end

		local character_removing = function(character)
			if plr.connections["character_childadded"] then plr.connections["character_childadded"]:Disconnect() end
			if plr.connections["character_childremoved"] then plr.connections["character_childremoved"]:Disconnect() end
			for part, _ in chams_table do
				destroy_cham_object(part)
			end
		end

		if is_npc or plr_instance.Character then character_added(is_npc and plr_instance or plr_instance.Character) end
		if not is_npc then
			plr.connections["character_added"] = plr_instance.CharacterAdded:Connect(character_added)
			plr.connections["character_removing"] = plr_instance.CharacterRemoving:Connect(character_removing)
		end

		plr.render = function(delta, camera_position, current_tick)
			skeleton_tick += delta

			if skeleton_tick > skeleton_rate then
				main_wireframe:Clear()
			end

			if not settings.enabled then
				return plr:togglevis(false)
			end

			if (npc_check) and (is_npc) then
				return plr:togglevis(false)
			end

			character = is_npc and plr_instance or plr_instance.Character
			root = is_helicopter and character.PrimaryPart or character and _FindFirstChild(character, "HumanoidRootPart")
			humanoid = character and _FindFirstChildOfClass(character, "Humanoid")

			if not (character and root and humanoid) then
				return plr:togglevis(false)
			end

			local humanoid_health = is_helicopter and root:GetAttribute("Health") or humanoid.Health
			local humanoid_max_health = is_helicopter and root:GetAttribute("MaxHealth") or humanoid.MaxHealth
			local humanoid_distance = (camera_position - root.Position).Magnitude

			if (not is_npc and team_check) and get_team(plr_instance, character, humanoid) then
				return plr:togglevis(false)
			end

			if (dead_check) and (humanoid_health <= 0) then
				return plr:togglevis(false)
			end

			if (dist_check) and (humanoid_distance > max_distance) then
				return plr:togglevis(false)
			end

			if (visible_check) and not cheat.is_pos_visible(camera_position, root.Position, character) then
				return plr:togglevis(false)
			end

			local _, on_screen = _WorldToViewportPoint(Camera, root.Position)

			if not on_screen then
				return plr:togglevis(false)
			end

			local topLeft, bottomRight, cache = nil, nil, table.create(15)
			do
				local count = 0
				for _, part in character:GetChildren() do
					if _IsA(part, "BasePart") and isBodyPart(part.Name) then
						cache[part.Name] = {part.CFrame, part.Size}
						count += 1
					end
				end
				if is_helicopter then
					cache[root.Name] = {root.CFrame, root.Size}
				end
				if count <= 0 then
					return plr:togglevis(false)
				end
				topLeft, bottomRight = calculateCorners(getBoundingBox(cache))
			end

			plr:togglevis(true)

			cham_vis_ok = true
			if settings.chams and settings.chams_visible_only and not is_npc then
				local po = cheat.player_list and cheat.player_list[plr_instance]
				cham_vis_ok = po and po.visible or false
				for part, cham in chams_table do
					cham.cham.Adornee = cham_vis_ok and part or nil
				end
			end

			do
				main_holder.Rotation = holder_spin and current_tick * holder_speed % 360 or 0
				main_box_color.Rotation = box_rotation + (gradient_spin and current_tick * gradient_speed % 360 or 0)
			end

			do
				local pos = topLeft
				local size = bottomRight - topLeft
				main_holder.Position = UDim2.fromOffset(pos.X - gui_inset.X, pos.Y - gui_inset.Y)
				main_holder.Size = UDim2.fromOffset(size.X, size.Y)
			end

			do
				main_distance.Text = mathround(humanoid_distance / 3) .. "m"
				if weapon_enabled then
					local gun = is_npc and "???" or get_gun(plr_instance, character, humanoid)
					if gun then
						main_weapon.Text = gun
						main_weapon.Position = main_distance.Visible and UDim2.new(0.5, 0, 1, 14) or UDim2.new(0.5, 0, 1, 1)
						main_weapon.Visible = true
					else
						main_weapon.Visible = false
					end
				end
			end

			main_health_text.Text = tostring(mathfloor(humanoid_health))
			main_health_bar.Size = UDim2.fromScale(1, 1 - humanoid_health / humanoid_max_health)

			for i, v in registered_flags do
				local show_flag, flag_text = v[2](plr_instance, character, humanoid)
				local flag = flags_table[i]
				if not show_flag then
					flag.Visible = false
					continue
				end
				flag.Visible = true
				if flag_text then flag.Text = flag_text end
			end

			if not is_helicopter and update_skeleton and skeleton_tick > skeleton_rate then
				skeleton_tick = skeleton_tick % skeleton_rate
				local root_pos = root.CFrame
				main_wireframe.Adornee = root

				local points = table.create(15 * 2)
				local counter = 0

				for part_name, info in cache do
					local parent_part = skeleton_order[part_name]
					local parent_info = parent_part and cache[parent_part]
					if not (parent_info) then
						continue
					end

					local part_pos, parent_pos = info[1], parent_info[1]

					points[counter + 1] = _VectorToObjectSpace(root_pos, part_pos.Position - root_pos.Position)
					points[counter + 2] = _VectorToObjectSpace(root_pos, parent_pos.Position - root_pos.Position)

					counter += 2
				end

				main_wireframe:AddLines(points)
			end
		end

		plr:forceupdate()
	end
	create_object_esp = function(model)






		local s = tick()
		while task.wait() and (tick() - s < 1) do
			if _FindFirstChildOfClass(model, "Humanoid") then
				return create_corpse_esp(model)
			end
			if _FindFirstChildOfClass(model, "ObjectValue") then
				return create_item_esp(model)
			end
		end

		print("unidentified object:", model:GetFullName())
	end
	create_corpse_esp = function(object)
		loaded_plrs[object] = {
			obj = {},
			connections = {}
		}

		local plr = loaded_plrs[object]
		local obj = plr.obj

		local main_holder = esp.create_obj("Frame", {
			Parent = container,
			ZIndex = 2,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(0, 0),
			Position = UDim2.fromScale(0, 0),
			BackgroundTransparency = 1,
			Visible = false
		}, obj)

		esp.create_obj("UIListLayout", {
			Parent = main_holder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder
		}, obj)

		local main_text = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 9,
			FontFace = Fonts.Get("SmallestPixel7"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 10),
			Text = object.Name
		}, obj)




		local settings = esp_table.settings.corpse
		local main_settings = settings.main_settings

		local main_part = _FindFirstChild(object, "UpperTorso")
		local corpse_name = object.Name


		local dist_check, max_distance = main_settings.dist_check, main_settings.max_distance
		local distance_enabled = settings.distance

		local setvis_cache = false

		function plr:forceupdate()
			dist_check, max_distance = main_settings.dist_check, main_settings.max_distance
			distance_enabled = settings.distance

			main_holder.Visible = settings.enabled and setvis_cache

			main_text.TextColor3 = settings.text_color[1]
			main_text.TextTransparency = settings.text_color[2]
		end

		function plr:togglevis(bool, fade)
			if setvis_cache == bool then return end
			setvis_cache = bool

			main_holder.Visible = bool
		end

		plr.render = function(delta, camera_position, current_tick)
			if not settings.enabled then
				return plr:togglevis(false)
			end

			main_part = _FindFirstChild(object, "UpperTorso")
			if not (main_part) then
				return plr:togglevis(false)
			end

			local corpse_position = main_part.Position
			local screen_pos, on_screen = _WorldToViewportPoint(Camera, corpse_position)

			if not on_screen then
				return plr:togglevis(false)
			end

			screen_pos = _Vector2new(screen_pos.X, screen_pos.Y)

			local corpse_distance = (camera_position - corpse_position).Magnitude

			if (dist_check) and (corpse_distance > max_distance) then
				return plr:togglevis(false)
			end

			plr:togglevis(true)

			do
				main_holder.Position = UDim2.fromOffset(screen_pos.X - gui_inset.X, screen_pos.Y - gui_inset.Y)

				local text_buffer = ("%*'s corpse"):format(corpse_name)

				if distance_enabled then
					text_buffer ..= (" (%*m)"):format(mathround(corpse_distance / 3))
				end

				main_text.Text = text_buffer
			end
		end

		plr:forceupdate()
	end
	create_item_esp = function(object)
		loaded_plrs[object] = {
			obj = {},
			connections = {}
		}

		local plr = loaded_plrs[object]
		local obj = plr.obj

		local main_holder = esp.create_obj("Frame", {
			Parent = container,
			ZIndex = 2,
			BorderSizePixel = 0,
			Size = UDim2.fromScale(0, 0),
			Position = UDim2.fromScale(0, 0),
			BackgroundTransparency = 1,
			Visible = false
		}, obj)

		esp.create_obj("UIListLayout", {
			Parent = main_holder,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder
		}, obj)

		local main_text = esp.create_obj("TextLabel", {
			Parent = main_holder,
			TextStrokeTransparency = 0,
			BorderSizePixel = 0,
			TextSize = 9,
			FontFace = Fonts.Get("SmallestPixel7"),
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0),
			Size = UDim2.new(0, 10000, 0, 10),
			Text = object.Name
		}, obj)

		local durability_holder = esp.create_obj("Frame", {
			Parent = main_holder,
			BackgroundColor3 = Color3.new(),
			BorderSizePixel = 0,
			Size = UDim2.new(0, 50, 0, 3),
			Visible = false
		})

		local current_durability = esp.create_obj("Frame", {
			Parent = durability_holder,
			BackgroundColor3 = Color3.fromRGB(206, 206, 206),
			BorderSizePixel = 0,
			Position = UDim2.new(0, 1, 0, 1),
			Size = UDim2.new(0, -1, 0, 1)
		})

		local max_durability = esp.create_obj("Frame", {
			Parent = durability_holder,
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Color3.fromRGB(197, 60, 62),
			BorderSizePixel = 0,
			Position = UDim2.new(1, -1, 0, 1),
			Size = UDim2.new(0, 1, 0, 1)
		})

		esp.create_obj("UIStroke", {
			Parent = durability_holder,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			LineJoinMode = Enum.LineJoinMode.Miter,
			BorderOffset = UDim.new(0, -1),
			Thickness = 1
		})




		local settings = esp_table.settings.item
		local main_settings = settings.main_settings

		local main_part, main_value = object.PrimaryPart, _FindFirstChildOfClass(object, "ObjectValue")
		local item_name = object.Name


		local dist_check, max_distance = main_settings.dist_check, main_settings.max_distance
		local distance_enabled, amount_enabled, durability_enabled = settings.distance, settings.amount, settings.durability
		local durability_bar_enabled = settings.durability_bar

		local setvis_cache = false

		function plr:forceupdate()
			dist_check, max_distance = main_settings.dist_check, main_settings.max_distance
			distance_enabled, amount_enabled, durability_enabled = settings.distance, settings.amount, settings.durability
			durability_bar_enabled = settings.durability_bar

			main_holder.Visible = settings.enabled and setvis_cache

			durability_holder.Visible = durability_bar_enabled

			main_text.TextColor3 = settings.text_color[1]
			main_text.TextTransparency = settings.text_color[2]
		end

		function plr:togglevis(bool, fade)
			if setvis_cache == bool then return end
			setvis_cache = bool

			main_holder.Visible = bool
		end

		plr.render = function(delta, camera_position, current_tick)
			local main_part, main_value = object.PrimaryPart, _FindFirstChildOfClass(object, "ObjectValue")

			if not (main_part and main_value) then
				return plr:togglevis(false)
			end

			if not settings.enabled then
				return plr:togglevis(false)
			end

			local item_position = main_part.Position
			local screen_pos, on_screen = _WorldToViewportPoint(Camera, item_position)

			if not on_screen then
				return plr:togglevis(false)
			end

			screen_pos = _Vector2new(screen_pos.X, screen_pos.Y)

			local item_distance = (camera_position - item_position).Magnitude

			if (dist_check) and (item_distance > max_distance) then
				return plr:togglevis(false)
			end

			plr:togglevis(true)

			local item_itemlist = main_value.Value
			local item_properties = item_itemlist and _FindFirstChild(item_itemlist, "ItemProperties")
			local item_amount = main_value:GetAttribute("Amount")
			local item_durability = main_value:GetAttribute("Durability")
			local item_maxdurability = main_value:GetAttribute("MaxDurability")
			local item_originalmaxdurability = item_properties and item_properties:GetAttribute("OriginalMaxDurability")
			do
				main_holder.Position = UDim2.fromOffset(screen_pos.X - gui_inset.X, screen_pos.Y - gui_inset.Y)

				local text_buffer = item_name

				if distance_enabled then
					text_buffer ..= (" (%*m)"):format(mathround(item_distance / 3))
				end
				if amount_enabled and item_amount then
					text_buffer ..= (" (%*x)"):format(item_amount)
				end
				if durability_enabled and item_durability and item_maxdurability then
					text_buffer ..= (" (%*/%*)"):format(item_durability, item_maxdurability)
				end

				main_text.Text = text_buffer
			end

			local should_durability = durability_bar_enabled and item_durability and item_maxdurability
			durability_holder.Visible = should_durability
			if should_durability then
				local curr_size = item_durability / item_originalmaxdurability
				local max_size = 1 - item_maxdurability / item_originalmaxdurability
				current_durability.Size = UDim2.new(curr_size, -2, 0, 1)
				max_durability.Size = UDim2.new(max_size, max_size == 0 and 0 or -1, 0, 1)
			end
		end

		plr:forceupdate()
	end

	destroy_esp = function(player)
		if not loaded_plrs[player] then return end
		if loaded_plrs[player].unload then
			return loaded_plrs[player]:unload()
		end
		local plr = loaded_plrs[player]
		if plr.connections then
			for i,v in plr.connections do
				v:Disconnect()
				plr.connections[i] = nil
			end
		end
		if plr.obj then
			for i,v in plr.obj do
				v:Remove()
				plr.obj[i] = nil
			end
		end
		for i,v in loaded_plrs[player] do
			loaded_plrs[player][i] = nil
		end
		loaded_plrs[player] = nil
	end

	function esp_table.load()
		assert(not esp_table.__loaded, "[ESP] already loaded");

		for _, player in plrs:GetPlayers() do
			if lplr ~= player then
				create_esp(player)
			end
		end

		for _, object in project_delta.droppeditems:GetChildren() do
			create_object_esp(object)
		end

		for _, aizone in project_delta.aizones:GetChildren() do
			for _, npc in aizone:GetChildren() do
				create_esp(npc)
			end
		end

		esp_table.connections = {}
		table.insert(esp_table.connections, plrs.PlayerAdded:Connect(create_esp))
		table.insert(esp_table.connections, plrs.PlayerRemoving:Connect(destroy_esp))
		table.insert(esp_table.connections, project_delta.droppeditems.ChildAdded:Connect(create_object_esp))
		table.insert(esp_table.connections, project_delta.droppeditems.ChildRemoved:Connect(destroy_esp))
		for _, aizone in project_delta.aizones:GetChildren() do
			table.insert(esp_table.connections, aizone.ChildAdded:Connect(create_esp))
			table.insert(esp_table.connections, aizone.ChildRemoved:Connect(destroy_esp))
		end

		table.insert(esp_table.connections, cheat.utility.new_renderstepped(function(delta)
			local camera_position = Camera.CFrame.Position
			local current_tick = tick()
			for _, plr in loaded_plrs do
				plr.render(delta, camera_position, current_tick)
			end
		end))

		esp_table.__loaded = true;
	end

	function esp_table.unload()
		assert(esp_table.__loaded, "[ESP] not loaded yet");

		for player, v in next, loaded_plrs do
			destroy_esp(player)
		end

		for _, connection in esp_table.connections do
			connection:Disconnect()
		end

		esp_table.__loaded = false;
	end

	esp_table.get_team = function(player, character, humanoid)
		return LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team
	end

	esp_table.get_gun = function(player, character, humanoid)
		if not character then
			return
		end
		local tool = _FindFirstChildOfClass(character, "Tool")
		return tool and tool.Name
	end

	function esp_table.icaca()
		for _, v in loaded_plrs do
			task.spawn(function() v:forceupdate() end)
		end
	end

	function esp_table.register_flag(flag, func)
		assert(not esp_table.__loaded, "[ESP] tried adding flag after loading, add before loading")
		local registered_flags = esp_table.registered_flags
		registered_flags[#registered_flags + 1] = {flag, func}
	end

	cheat.EspLibrary = esp_table
end)();
LPH_NO_VIRTUALIZE(function()
	local camera = workspace.CurrentCamera

	local indicatorlib = {
		indicators = {}
	}

	function indicatorlib:new_indicator()
		local indicator = {
			enabled = false,

			followpart = false,
			target_part = nil,

			scale_x = 0.5,
			scale_y = 0.5,
			offset_x = 0,
			offset_y = 0,

			blink = false,
			blink_speed = 1,
			blink_cycle = false,

			text = "",
			transparency = 1
		}

		indicator.drawing = cheat.utility.new_drawing("Text", { Visible = false })
		indicator.text = `indicator {tostring(indicator)}`

		indicatorlib.indicators[indicator] = indicator

		return indicator
	end


	cheat.utility.new_renderstepped(function(delta)
		local viewportsize = camera and camera.ViewportSize
		if not viewportsize then
			camera = workspace.CurrentCamera;
			for _, indicator in indicatorlib.indicators do
				local drawing = indicator.drawing
				if not drawing then continue end

				drawing.Visible = false
			end
			return
		end
		local viewport_x = viewportsize.X
		local viewport_y = viewportsize.Y
		for _, indicator in indicatorlib.indicators do

			local drawing = indicator.drawing
			if not drawing then continue end

			if not indicator.enabled then
				drawing.Visible = false
				continue
			end

			drawing.Visible = true
			drawing.Text = indicator.text

			if indicator.followpart then
				local target_part = indicator.target_part
				if not target_part then
					drawing.Visible = false
					continue
				end
				local pos, on_screen = _WorldToViewportPoint(camera, target_part.CFrame.Position)
				if not on_screen then
					drawing.Visible = false
					continue
				end
				drawing.Position = _Vector2new(pos.X + indicator.offset_x, pos.Y + indicator.offset_y)
			else
				local calculated_x = viewport_x * indicator.scale_x + indicator.offset_x
				local calculated_y = viewport_y * indicator.scale_y + indicator.offset_y
				drawing.Position = _Vector2new(calculated_x, calculated_y)
			end

			if not indicator.blink then
				drawing.Transparency = indicator.transparency
				continue
			end

			local blink_speed = indicator.blink_speed

			if drawing.Transparency <= 0 then
				indicator.blink_cycle = true
			elseif drawing.Transparency >= 1 then
				indicator.blink_cycle = false
			end

			drawing.Transparency = drawing.Transparency + (blink_speed * (indicator.blink_cycle and 1 or -1)) * delta
		end
	end)


	cheat.IndicatorLibrary = indicatorlib
end)();

do
	local vischeck_params = RaycastParams.new()
	vischeck_params.FilterType = Enum.RaycastFilterType.Exclude
	vischeck_params.CollisionGroup = "WeaponRay"
	vischeck_params.IgnoreWater = true

	cheat.is_visible = LPH_NO_VIRTUALIZE(function(origin, target, target_part)
		vischeck_params.FilterDescendantsInstances = { workspace.NoCollision, Camera, LocalPlayer.Character }
		local castresults = _Raycast(workspace, origin, target_part.Position - origin, vischeck_params)
		return castresults and castresults.Instance and _IsDescendantOf(castresults.Instance, target), castresults
	end)

	cheat.is_pos_visible = LPH_NO_VIRTUALIZE(function(origin, target_pos, target)
		vischeck_params.FilterDescendantsInstances = { workspace.NoCollision, Camera, LocalPlayer.Character }
		local castresults = _Raycast(workspace, origin, target_pos - origin, vischeck_params)
		return castresults and castresults.Instance and _IsDescendantOf(castresults.Instance, target), castresults
	end)
end

cheat.make_beam = function(Origin, Position, Color)
	local part1, part2 = Instance.new("Part", workspace.NoCollision), Instance.new("Part", workspace.NoCollision)
	part1.CFrame = _CFramenew(Origin);
	part2.CFrame = _CFramenew(Origin);
	part1.Transparency = 1; part2.Transparency = 1;
	part1.CanCollide = false; part2.CanCollide = false;
	part1.Size = Vector3.zero; part2.Size = Vector3.zero;
	part1.Anchored = true; part2.Anchored = true;
	local OriginAttachment = Instance.new("Attachment", part1)
	local PositionAttachment = Instance.new("Attachment", part2)
	local Beam = Instance.new("Beam", workspace.NoCollision)
	Beam.Name = "Beam"
	Beam.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0,Color),
		ColorSequenceKeypoint.new(1,Color)
	};
	Beam.LightEmission = 9e9
	Beam.LightInfluence = 9e9
	Beam.TextureMode = Enum.TextureMode.Static
	Beam.TextureSpeed = 0

	Beam.Transparency = NumberSequence.new(0)
	Beam.Attachment0 = OriginAttachment
	Beam.Attachment1 = PositionAttachment
	Beam.FaceCamera = true
	Beam.Segments = 1
	Beam.Width0 = 0.2
	Beam.Width1 = 0.2
	local start_tick = tick()
	local speed = 50
	local connection; connection = cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function()
		local passed = tick() - start_tick
		local lv = (Position - Origin)
		local dist = passed * speed
		local newpos = (Position - Origin).Unit * dist
		part2.CFrame = _CFramenew(Origin + newpos)

		local dist_left = lv.Magnitude - dist
		local tp1 = math.clamp((dist - lv.Magnitude + speed) / speed, 0, 1)
		local tp2 = math.clamp((passed - (5 / 2)) * (5 * 2), 0, 1)
		local ctp = tp1 > tp2 and tp1 or tp2
		Beam.Transparency = NumberSequence.new(ctp)

		if ctp > 1 then
			Beam:Destroy()
			OriginAttachment:Destroy()
			PositionAttachment:Destroy()
			part1:Destroy()
			part2:Destroy()
			connection:Disconnect()
		end
	end))
end

cheat.report_list = {}
do
	local report_list = game:GetService("ReplicatedStorage").ReportList
	local most_wanted = report_list.MostWanted
	local recent_reports = report_list.Recent

	local player_report_list = cheat.report_list
	task.spawn(LPH_NO_VIRTUALIZE(function()
		while task.wait(0.25) do
			for i, v in player_report_list do
				v.rr = 0
				v.mw = 0
			end
			for i, v in recent_reports:GetChildren() do
				local username, report_id = v.Name:match("(.+)_([^_]+)$")
				local player_object = player_report_list[username]

				if not player_object then
					player_report_list[username] = {rr = 0, mw = 0}
					player_object = player_report_list[username]
				end

				player_object.rr += 1
			end
			for i, v in most_wanted:GetChildren() do
				local username, user_id = v.Name:match("(.+)_([^_]+)$")
				local player_object = player_report_list[username]

				if not player_object then
					player_report_list[username] = {rr = 0, mw = 0}
					player_object = player_report_list[username]
				end

				player_object.mw += 1
			end
		end
	end))
end

cheat.player_list = {}
local hit_detection = function(...)end
do
	local is_visible, get_visor_status = cheat.is_visible, project_delta.get_visor_status
	local player_list = cheat.player_list
	local player_folder = game:GetService("ReplicatedStorage"):WaitForChild("Players")
	local add_player = function(player)
		player_list[player] = {}
		local player_object = player_list[player]
		local game_data, game_uac, game_clan, game_inventory
		local character, humanoid
		local old_health
		player_object.premium = player.MembershipType == Enum.MembershipType.Premium
		player_object.update_loop = LPH_NO_VIRTUALIZE(function(delta, bullet_origin)

			local game_data = _FindFirstChild(player_folder, player.Name)
			local game_inventory = game_data and _FindFirstChild(game_data, "Inventory")
			local game_status = game_data and _FindFirstChild(game_data, "Status")
			local game_journey = game_data and _FindFirstChild(game_data, "Journey")
			local game_uac = game_status and _FindFirstChild(game_status, "UAC")
			local game_clan = game_journey and _FindFirstChild(game_journey, "Clan")

			player_object.game_data = game_data
			player_object.inventory = game_inventory

			if game_clan then
				local clan = game_clan:GetAttribute("CurrentClan")
				player_object.current_clan = clan ~= "nil" and clan
			end

			if game_uac then
				player_object.server_position = game_uac:GetAttribute("LastVerifiedPos")
				local reports = _FindFirstChild(game_uac, "Reports")
				if reports then
					local total_reports = 0
					for report_type, count in reports:GetAttributes() do
						total_reports += count
					end
					player_object.reports = total_reports
				end
			end

			if game_data then
				local status = _FindFirstChild(game_data, "Status")
				local gameplay = status and _FindFirstChild(status, "GameplayVariables")
				local equipped_tool = gameplay and _FindFirstChild(gameplay, "EquippedTool")
				player_object.current_weapon = equipped_tool and equipped_tool.Value
			end

			if game_inventory then
				player_object.visor = get_visor_status(game_inventory)
			end

			character = player.Character
			if not character then return end

			if bullet_origin then
				local hrp, head = _FindFirstChild(character, "HumanoidRootPart"), _FindFirstChild(character, "Head")
				player_object.visible = (hrp and is_visible(bullet_origin, character, hrp)) or (head and is_visible(bullet_origin, character, head))
			end

			humanoid = _FindFirstChildOfClass(character, "Humanoid")
			if not humanoid then return end
			if not old_health then old_health = humanoid.Health end
			local new_health = humanoid.Health
			if new_health ~= old_health then
				hit_detection(player, new_health, old_health)
				old_health = new_health
			end
		end)
		local ok_friend, is_friend = pcall(function()
			return player:IsFriendsWith(LocalPlayer.UserId)
		end)
		player_object.friend = ok_friend and is_friend or false
	end

	for _, player in Players:GetPlayers() do
		task.spawn(add_player, player)
	end
	Players.PlayerAdded:Connect(add_player)

	Players.PlayerRemoving:Connect(function(player)
		local object = player_list[player]
		player_list[player] = nil
	end)

	local get_estimated_origin = project_delta.get_estimated_origin
	cheat.utility.new_heartbeat(LPH_NO_VIRTUALIZE(function(delta)
		local character = LocalPlayer.Character
		local hrp = character and _FindFirstChild(character, "HumanoidRootPart")
		local hmm_origin = hrp and get_estimated_origin(LocalPlayer)
		for i, v in player_list do
			v.update_loop(delta, hmm_origin)
		end
	end))

	local lp = player_list[LocalPlayer]
	local clan_cache, clan_cache_tick = {}, 0
	local function clan_of(name)
		local now = os.clock()
		if now - clan_cache_tick > 2 then
			clan_cache_tick = now
			table.clear(clan_cache)
			local clans = game:GetService("ReplicatedStorage"):FindFirstChild("Clans")
			if clans then
				for _, clan in clans:GetChildren() do
					for _, member in clan:GetChildren() do
						clan_cache[member.Name] = clan.Name
					end
				end
			end
		end
		return clan_cache[name]
	end
	cheat.EspLibrary.get_team = LPH_NO_VIRTUALIZE(function(player, character, humanoid)
		if not player or player == LocalPlayer then return true end
		local mine = clan_of(LocalPlayer.Name)
		local his = clan_of(player.Name)
		return mine ~= nil and mine == his
	end)

	cheat.EspLibrary.get_gun = LPH_NO_VIRTUALIZE(function(player, character, humanoid)
		local tp = player_list[player]
		local current_weapon = tp and tp.current_weapon
		return current_weapon and current_weapon.Name
	end)
end

cheat.bullet_infos = {}

local ui = {
	window = Library:Window({
		namestart = "swim",
		nameend = "hub"
	})
}

ui.tabs = {
	combat = ui.window:Tab({name = "Combat", image = Images.Get("combat")}),
	visuals = ui.window:Tab({name = "Visuals", image = Images.Get("visuals")}),
		skins = ui.window:Tab({name = "Skins", image = "rbxassetid://17415964540", size = 76}),
	misc = ui.window:Tab({name = "Misc", image = Images.Get("misc")}),
	settings = ui.window:Tab({name = "Settings", image = Images.Get("config")})
}
ui.subtabs = {
	combat_aimbot = ui.tabs.combat:SubTab({Name = "Aimbot"}),
	combat_misc = ui.tabs.combat:SubTab({Name = "Misc"}),
	visuals_esp = ui.tabs.visuals:SubTab({Name = "Player ESP"}),
	visuals_esp_misc = ui.tabs.visuals:SubTab({Name = "Misc ESP"}),
	visuals_lighting = ui.tabs.visuals:SubTab({Name = "Lighting"}),
	visuals_misc = ui.tabs.visuals:SubTab({Name = "Misc"}),
	misc_main = ui.tabs.misc:SubTab({Name = "Main"}),
	misc_antiaim = ui.tabs.misc:SubTab({Name = "Anti-aim"}),
	misc_exploit = ui.tabs.misc:SubTab({Name = "Exploits"}),
	settings_main = ui.tabs.settings:SubTab({Name = "Main"}),
	skins_changer = ui.tabs.skins:SubTab({Name = "Skin Changer"}),
	skins_weapon = ui.tabs.skins:SubTab({Name = "Weapon Editor"}),
	settings_theme = ui.tabs.settings:SubTab({Name = "Themeing"})
}
ui.sections = {
	aimbot_main = ui.subtabs.combat_aimbot:Section({Name = "Aimbot", Side = "Left"}),
	aimbot_misc = ui.subtabs.combat_aimbot:Section({Name = "Misc", Side = "Right"}),

	aimbot_effects = ui.subtabs.combat_misc:Section({Name = "Effects/Logs", Side = "Left"}),
	gunmods = ui.subtabs.combat_misc:Section({Name = "Gun mods", Side = "Right"}),

	player_esp = ui.subtabs.visuals_esp:Section({Name = "Players", Side = "Left"}),
	esp_settings = ui.subtabs.visuals_esp:Section({Name = "Settings", Side = "Right"}),
	item_esp = ui.subtabs.visuals_esp_misc:Section({Name = "Items", Side = "Left"}),
	other_esp = ui.subtabs.visuals_esp_misc:Section({Name = "Other", Side = "Right"}),
	world_main_changer = ui.subtabs.visuals_lighting:Section({Name = "Lighting", Side = "Left"}),
	world_misc_changer = ui.subtabs.visuals_lighting:Section({Name = "Misc", Side = "Right"}),
	visuals_misc = ui.subtabs.visuals_misc:Section({Name = "View", Side = "Left"}),
	visuals_local = ui.subtabs.visuals_misc:Section({Name = "Local", Side = "Right"}),

	movement = ui.subtabs.misc_main:Section({Name = "Movement", Side = "Left"}),
	misc = ui.subtabs.misc_main:Section({Name = "Misc", Side = "Right"}),
	antiaim = ui.subtabs.misc_antiaim:Section({Name = "Antiaim", Side = "Left"}),
	antiaim_animations = ui.subtabs.misc_antiaim:Section({Name = "Animation", Side = "Right"}),
	custom_desync = ui.subtabs.misc_exploit:Section({Name = "Custom desync", Side = "Left"}),
	exploit = ui.subtabs.misc_exploit:Section({Name = "Exploit", Side = "Right"}),

	settings_config = ui.subtabs.settings_main:Section({Name = "Config", Side = "Left"}),	settings_personalization = ui.subtabs.settings_main:Section({Name = "Personalization", Side = "Right"}),
	theme_config = ui.subtabs.settings_theme:Section({Name = "Config", Side = "Left"}),
	theme_colors = ui.subtabs.settings_theme:Section({Name = "Colors", Side = "Right"}),

	skins_browser = ui.subtabs.skins_changer:Section({Name = "Weapons", Side = "Left"}),
	skins_actions = ui.subtabs.skins_changer:Section({Name = "Skins", Side = "Right"}),
	weapon_mods = ui.subtabs.skins_weapon:Section({Name = "Attachments", Side = "Left"}),
	weapon_list = ui.subtabs.skins_weapon:Section({Name = "Weapons", Side = "Right"})
}

do
	ui.tabs.combat.Set(true)

	ui.subtabs.combat_aimbot.Set(true)
	ui.subtabs.visuals_esp.Set(true)
	ui.subtabs.skins_changer.Set(true)
	ui.subtabs.misc_main.Set(true)
	ui.subtabs.settings_main.Set(true)
	do
		local skins_tab = ui.tabs.skins
		local skins_icon = skins_tab.Objects.icon
		local skins_idle = Color3.fromHex("565656")
		local skins_active = Color3.fromHex("ffffff")
		Library.ThemeObjects[skins_icon] = nil
		local skins_apply = function(status)
			skins_icon.ImageColor3 = status and skins_active or skins_idle
		end
		local skins_set = skins_tab.Set
		skins_tab.Set = function(status, nested)
			skins_set(status, nested)
			skins_apply(status)
		end
		local update_theme = Library.UpdateTheme
		Library.UpdateTheme = function(theme, color)
			update_theme(theme, color)
			skins_apply(skins_tab.Selected)
		end
		skins_apply(skins_tab.Selected)
	end
end

local hit_chances = {Head = 100, UpperTorso = 100}

local get_targets_in_fov = LPH_NO_VIRTUALIZE(function(
	fov_size,
	aimbot_part,
	aimbot_team_check,
	aimbot_dead_check,
	aimbot_dist_check,
	aimbot_max_distance,
	aimbot_npc_check,
	aimbot_screen_check
)
	local player_list = Players:GetPlayers()
	local target_list = table.create(#player_list)

	local maximum_distance = fov_size

	local mousepos = UserInputService:GetMouseLocation()
	local campos = Camera.CFrame.Position

	local get_team = cheat.EspLibrary.get_team

	for _, player in player_list do
		if not (player and player ~= LocalPlayer) then continue end

		local character = player.Character
		local root = character and _FindFirstChild(character, "HumanoidRootPart")
		local humanoid = character and _FindFirstChildOfClass(character, "Humanoid")

		if not (root) then continue end

		if (aimbot_team_check) and get_team(player) then
			continue
		end
		if (aimbot_dead_check) and (not humanoid or humanoid.Health <= 0) then
			continue
		end

		local parts = (typeof(aimbot_part) == "table" and #aimbot_part > 0) and aimbot_part or {"Head"}



		local total_w = 0
		for _, pn in ipairs(parts) do
			total_w = total_w + (hit_chances[pn] or 0)
		end
		local pick = parts[1]
		if total_w > 0 then
			local roll = math.random() * total_w
			local acc = 0
			for _, pn in ipairs(parts) do
				acc = acc + (hit_chances[pn] or 0)
				if roll <= acc then
					pick = pn
					break
				end
			end
		end

		local aimpart = character and _FindFirstChild(character, pick)
		local mainpart = aimpart or root

		if not (mainpart) then continue end

		if (aimbot_dist_check) and ((campos - mainpart.Position).Magnitude > aimbot_max_distance) then
			continue
		end

		local position, on_screen = _WorldToViewportPoint(Camera, mainpart.Position)
		local distance = (
			_Vector2new(
				position.X, position.Y
			) - mousepos
		).Magnitude

		if (aimbot_screen_check or on_screen) and distance <= maximum_distance then
			table.insert(target_list, {mainpart, player, character, distance})
		end
	end

	if aimbot_npc_check then
		table.sort(target_list, function(a, b)
			return a[4] < b[4]
		end)
		return target_list
	end

	for _, aizone in project_delta.aizones:GetChildren() do
		for _, npc in aizone:GetChildren() do
			local root = _FindFirstChild(npc, "HumanoidRootPart")
			local humanoid = _FindFirstChildOfClass(npc, "Humanoid")
			local npc_parts = (typeof(aimbot_part) == "table" and #aimbot_part > 0) and aimbot_part or {"Head"}
			local aimpart = _FindFirstChild(npc, npc_parts[1] or "Head")
			local mainpart = aimpart or root

			if not (mainpart) then continue end

			if (aimbot_dead_check) and (not humanoid or humanoid.Health <= 0) then
				continue
			end
			if (aimbot_dist_check) and ((campos - mainpart.Position).Magnitude > aimbot_max_distance) then
				continue
			end

			local position, on_screen = _WorldToViewportPoint(Camera, mainpart.Position)
			local distance = (
				_Vector2new(
					position.X, position.Y
				) - mousepos
			).Magnitude

			if (aimbot_screen_check or on_screen) and distance <= maximum_distance then
				table.insert(target_list, {mainpart, npc, npc, distance})
			end
		end
	end

	table.sort(target_list, function(a, b)
		return a[4] < b[4]
	end)
	return target_list
end)


local aimbot_mode = "Camera"
local target_part, target_player, target_character
cheat.feat = {ac_bypass = true, multibullet = false, hit_chams = false, kill_sound = false, resolver = false, bring_vehicle = false, flashlight_override = false, laser_override = false, manipulation = false, mine_manipulation = false, instant_nade = false, hover_loot = false, spotify = false}
local silent_forcehit = false
local instant_reload, instant_equip, instant_aim = false, false, false
local hit_sound, hit_sound_instance, hit_sound_speed, hit_sound_volume = false, cheat.hitsounds["Bameware"], 1, 1
local kill_sound, kill_sound_instance, kill_sound_volume, kill_sound_speed = false, cheat.hitsounds["Bameware"], 1, 1
local hit_logs, hit_logs_duration = false, 0
	local no_recoil = false
	local no_spread = false
	local no_bullet_drop = false
	local instant_lean = false
do
	local aimsec = ui.sections.aimbot_main
	local mscsec = ui.sections.aimbot_misc
	local samsec = ui.sections.aimbot_silent
	local effsec = ui.sections.aimbot_effects
	local gunsec = ui.sections.gunmods

	local aimbot_enabled, aimbot_enabled_key, aimbot_smoothness = false, false, 0.7
	local aimbot_part = {"Head"}
	local head_hitchance, torso_hitchance = 100, 100
	local syncing_hitchance = false
	local head_hitchance_slider, torso_hitchance_slider = nil, nil
	local aimbot_team_check, aimbot_dead_check, aimbot_dist_check, aimbot_max_distance, aimbot_npc_check, aimbot_visible_check, aimbot_screen_check = false, false, false, 600, false, false, false
	local fov_show, fov_color, fov_outline, fov_size, fov_sides = false, Color3.new(1,1,1), false, 100, 67
	local snapline_show, snapline_color = false, Color3.new(1,1,1)
	local autoshoot, autoshoot_key, autowall = false, false, false
		local hitscan_hitboxes = {"FaceHitBox", "HeadTopHitBox", "Head"}

	local indicator = cheat.IndicatorLibrary:new_indicator()

	do
		local desync_resolver, angle_resolver = false, false

		local aim_keybind; aim_keybind = aimsec:Toggle({Name = "Enabled", Value = false, Flag = "aimbot_enable", Callback = function(bool)
			aimbot_enabled = bool
		end}):Keybind({Name = "Aimbot", Mode = "Hold", Key = Enum.KeyCode.E, Value = false, Flag = "aimbot_enabled_keybind", Link = "aimbot_enable", Callback = function(bool)
			aimbot_enabled_key = aimbot_enabled and bool
			aim_keybind.Set(aimbot_enabled_key, true)
		end})
		aimsec:Dropdown({Name = "Aim part", Values = {"Head", "UpperTorso"}, Value = {"Head"}, Flag = "aimbot_hitpart", Multi = true, Callback = function(tbl)
			aimbot_part = (tbl and #tbl > 0) and tbl or {"Head"}
			local multi = #aimbot_part > 1
			if head_hitchance_slider then head_hitchance_slider.State(multi) end
			if torso_hitchance_slider then torso_hitchance_slider.State(multi) end

			local scan = {}
			for _, p in ipairs(aimbot_part) do
				if p == "Head" then
					table.insert(scan, "FaceHitBox")
					table.insert(scan, "HeadTopHitBox")
					table.insert(scan, "Head")
				elseif p == "UpperTorso" then
					table.insert(scan, "UpperTorso")
				end
			end
			if #scan > 0 then
				hitscan_hitboxes = scan
			end
		end})
		head_hitchance_slider = aimsec:Slider({Name = "Head hitchance", Min = 0, Max = 100, Float = 1, Value = 100, Flag = "aimbot_head_hitchance", suffix = "%s%%", Callback = function(int)
			head_hitchance = int
			hit_chances.Head = int

			if not syncing_hitchance and torso_hitchance_slider and head_hitchance + torso_hitchance > 100 then
				syncing_hitchance = true
				torso_hitchance_slider.Set(100 - head_hitchance)
				syncing_hitchance = false
			end
		end})
		head_hitchance_slider.State(false)
		torso_hitchance_slider = aimsec:Slider({Name = "Torso hitchance", Min = 0, Max = 100, Float = 1, Value = 0, Flag = "aimbot_torso_hitchance", suffix = "%s%%", Callback = function(int)
			torso_hitchance = int
			hit_chances.UpperTorso = int

			if not syncing_hitchance and head_hitchance_slider and head_hitchance + torso_hitchance > 100 then
				syncing_hitchance = true
				head_hitchance_slider.Set(100 - torso_hitchance)
				syncing_hitchance = false
			end
		end})
		torso_hitchance_slider.State(false)
		aimsec:Dropdown({Name = "Aim mode", Values = {"Camera", "Mouse", "Silent"}, Value = "Camera", Flag = "aimbot_mode", Multi = false, Callback = function(str)
			aimbot_mode = str
		end})
		aimsec:Slider({Name = "Aim smoothness", Min = 0.01, Max = 1, Float = 0.01, Value = 0.7, Flag = "aimbot_smoothness", Suffix = "%sx" , Callback = function(int)
			aimbot_smoothness = int
		end})


		aimsec:Toggle({Name = "Desync resolver", Value = false, Flag = "desync_resolver", Callback = function(bool)
			desync_resolver = bool
		end})
		aimsec:Toggle({Name = "Angle resolver", Value = false, Flag = "angle_resolver", Callback = function(bool)
			angle_resolver = bool
		end})
		local ugres_on, ugres_key, ugres_depth, ugres_sit = false, false, 30, false
		local ugres_saved = nil
		local ug_depth_slider, ug_sit_toggle = nil, nil
		local ug_keybind; ug_keybind = aimsec:Toggle({Name = "Underground resolver", Value = false, Flag = "ugres_enabled", Callback = function(bool)
			ugres_on = bool
			if ug_depth_slider then ug_depth_slider.State(bool) end
			if ug_sit_toggle then ug_sit_toggle.State(bool) end
		end}):Keybind({Name = "Underground resolver", Mode = "Hold", Key = Enum.KeyCode.H, Value = false, Flag = "ugres_key", Link = "ugres_enabled", Callback = function(bool)
			ugres_key = ugres_on and bool
			ug_keybind.Set(ugres_key, true)
		end})
		ug_depth_slider = aimsec:Slider({Name = "Underground depth", Min = 5, Max = 100, Float = 1, Value = 30, Flag = "ugres_depth", Callback = function(int)
			ugres_depth = int
		end})
		ug_depth_slider.State(false)
		ug_sit_toggle = aimsec:Toggle({Name = "Underground sit", Value = false, Flag = "ugres_sit", Callback = function(bool)
			ugres_sit = bool
		end})
		ug_sit_toggle.State(false)
		cheat.utility.new_renderstepped(function()
			local active = ugres_on and ugres_key
			local char = LocalPlayer.Character
			local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
			local hum = char and _FindFirstChildOfClass(char, "Humanoid")
			if active and hrp and hum and hum.Health > 0 then
				if not ugres_saved then
					ugres_saved = hrp.CFrame
					if ugres_sit then pcall(function() hum.Sit = true end) end
				end
				hrp.CFrame = ugres_saved - _Vector3new(0, ugres_depth, 0)
				hrp.AssemblyLinearVelocity = Vector3.zero
				hrp.AssemblyAngularVelocity = Vector3.zero
			elseif ugres_saved then
				if hrp then
					hrp.CFrame = ugres_saved
					hrp.AssemblyLinearVelocity = Vector3.zero
				end
				if hum then pcall(function() hum.Sit = false end) end
				ugres_saved = nil
			end
		end)

		local player_list = cheat.player_list
		RunService.PreRender:Connect(LPH_JIT(function()
			for player, player_object in player_list do
				if player == LocalPlayer then continue end
				local server_position = player_object.server_position
				local character = player.Character
				local hrp = character and _FindFirstChild(character, "HumanoidRootPart")
				if desync_resolver and hrp and server_position then
					hrp.CFrame = _CFramenew(server_position) * hrp.CFrame.Rotation
				end
				if angle_resolver and character then
					character:SetAttribute("UpAngle", 0)
				end
			end
		end))
	end
	do
		mscsec:Dropdown({Name = "Checks", Values = {"Team check", "Dead check", "Distance check", "NPC check", "Include off-screen"}, Value = {}, Flag = "aimbot_checks", Multi = true, Callback = function(tbl)
			local funny = {
				["Team check"] = "team_check",
				["Dead check"] = "dead_check",
				["Distance check"] = "dist_check",
				["NPC check"] = "npc_check",
				["Include off-screen"] = "screen_check"
			}
			local uhh = {}
			for flag_text, esp_var in funny do
				uhh[esp_var] = false
			end
			for flag_text, esp_var in funny do
				for _, check_name in tbl do
					if (check_name ~= flag_text or uhh[esp_var]) then
						continue
					end
					uhh[esp_var] = true
				end
			end
			aimbot_team_check = uhh["team_check"]
			aimbot_dead_check = uhh["dead_check"]
			aimbot_dist_check = uhh["dist_check"]
			aimbot_npc_check = uhh["npc_check"]
			aimbot_screen_check = uhh["screen_check"]
		end})
		mscsec:Slider({Name = "Max distance", Min = 0, Max = 2000, Float = 10, Value = 200, Flag = "aimbot_max_distance", Callback = function(int)
			aimbot_max_distance = int * 3
		end})
		mscsec:Slider({Name = "Aim size", Min = 0, Max = 180, Float = 1, Value = 10, Flag = "aimbot_fov_size", Suffix = "%s\194\176" , Callback = function(int)
			fov_size = int
		end})

		mscsec:Toggle({Name = "Silent force-hit", Value = false, Flag = "silent_forcehit", Callback = function(bool)
			silent_forcehit = bool
		end})


		local autoshoot_keybind; autoshoot_keybind = mscsec:Toggle({Name = "Silent auto-shoot", Value = false, Flag = "aimbot_autoshoot", Callback = function(bool)
			autoshoot = bool
		end}):Keybind({Name = "Auto-shoot", Mode = "Toggle", Key = Enum.KeyCode.G, Value = false, Flag = "aimbot_autoshoot_keybind", Link = "aimbot_autoshoot", Callback = function(bool)
			autoshoot_key = autoshoot and bool
			autoshoot_keybind.Set(autoshoot_key, true)
		end})

		mscsec:Toggle({Name = "Auto-wall penetration", Value = false, Flag = "silent_autowall", Callback = function(bool)
			autowall = bool
		end})

		local tpkill_on, tpkill_height, tpkill_saved, tpkill_target, tpkill_platform, tpkill_cd = false, 200, nil, nil, nil, 0
		local tpkill_uptime, tpkill_cooldown, tpkill_face, tpkill_track, tpkill_go = 3, 6, false, false, 0
		local tpkill_toggle
		local function tpkill_find()
			local mouse = UserInputService:GetMouseLocation()
			local campos = Camera.CFrame.Position
			local fov = cheat.aim_fov or 120
			local best_part, best_score = nil, math.huge
			for _, player in Players:GetPlayers() do
				if player ~= LocalPlayer and player.Character then
					local hum = _FindFirstChildOfClass(player.Character, "Humanoid")
					local part = _FindFirstChild(player.Character, "HumanoidRootPart") or _FindFirstChild(player.Character, "UpperTorso") or _FindFirstChild(player.Character, "Head")
					if hum and hum.Health > 0 and part then
						local sp, on = _WorldToViewportPoint(Camera, part.Position)
						if on then
							local d = (_Vector2new(sp.X, sp.Y) - mouse).Magnitude
							if d <= fov then
								local mdist = (campos - part.Position).Magnitude
								if mdist < 600 then
									local score = d + mdist * 0.4
									if score < best_score then
										best_score = score
										best_part = part
									end
								end
							end
						end
					end
				end
			end
			return best_part
		end
		local function tpkill_launch(tgt, hrp, char)
			tpkill_target = tgt
			tpkill_saved = hrp.CFrame
			tpkill_go = tick()
			tpkill_platform = Instance.new("Part")
			tpkill_platform.Size = _Vector3new(10, 1, 10)
			tpkill_platform.Anchored = true
			tpkill_platform.CanCollide = true
			tpkill_platform.Transparency = 1
			tpkill_platform.Name = "TPKillPlatform"
			tpkill_platform.Parent = char
			hrp.CFrame = _CFramenew(tgt.Position + _Vector3new(0, tpkill_height, 0)) * (hrp.CFrame - hrp.CFrame.Position)
			Library.Notification("TP Kill: Teleported above targeted enemy", 2.5)
		end
		local function tpkill_set(state)
			if tpkill_on == state then return end
			tpkill_on = state
			local char = LocalPlayer.Character
			local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
			if not hrp then return end
			if not state then
				if tpkill_saved then
					tpkill_cd = tick()
				end
				if tpkill_saved then
					hrp.CFrame = tpkill_saved + _Vector3new(0, 2, 0)
					tpkill_saved = nil
					tpkill_target = nil
					Library.Notification("TP Kill: Returned to original position", 2.5)
					if tpkill_platform then
						pcall(function() tpkill_platform:Destroy() end)
						tpkill_platform = nil
					end
					local hum = _FindFirstChildOfClass(char, "Humanoid")
					if hum then
						hum:ChangeState(Enum.HumanoidStateType.Landed)
					end
					hrp.AssemblyLinearVelocity = Vector3.zero
				end
			else
				if tick() - tpkill_cd < tpkill_cooldown then
					tpkill_on = false
					tpkill_toggle.Set(false)
					Library.Notification("TP Kill: On cooldown!", 2.5)
					return
				end
				local tgt = tpkill_find()
				if not tgt then
					tpkill_go = tick()
					Library.Notification("TP Kill: Armed, waiting for target in FOV", 2.5)
				else
					tpkill_launch(tgt, hrp, char)
				end
			end
		end
		local tpkill_height_slider, tpkill_uptime_slider, tpkill_cd_slider, tpkill_face_toggle, tpkill_track_toggle = nil, nil, nil, nil, nil
		tpkill_toggle = mscsec:Toggle({Name = "TP kill", Value = false, Flag = "tpkill", Callback = function(bool)
			tpkill_set(bool)
			if not tpkill_on and tpkill_keybind then tpkill_keybind.Set(false, true) end
			local vis = tpkill_on and true or false
			if tpkill_height_slider then tpkill_height_slider.State(vis) end
			if tpkill_uptime_slider then tpkill_uptime_slider.State(vis) end
			if tpkill_cd_slider then tpkill_cd_slider.State(vis) end
			if tpkill_face_toggle then tpkill_face_toggle.State(vis) end
			if tpkill_track_toggle then tpkill_track_toggle.State(vis) end
		end})
		local tpkill_keybind; tpkill_keybind = tpkill_toggle:Keybind({Name = "TP kill", Mode = "Toggle", Modes = {"Hold", "Toggle"}, Key = Enum.KeyCode.T, Value = false, Flag = "tpkill_key", Link = "tpkill", Callback = function(bool)
			tpkill_toggle.Set(bool)
			tpkill_keybind.Set(bool, true)
		end})
		tpkill_height_slider = mscsec:Slider({Name = "TP kill height", Min = 5, Max = 300, Float = 1, Value = 200, Flag = "tpkill_height", Callback = function(int)
			tpkill_height = int
			if tpkill_on and tpkill_target and tpkill_target.Parent then
				local char = LocalPlayer.Character
				local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
				if hrp then
					hrp.CFrame = _CFramenew(tpkill_target.Position + _Vector3new(0, tpkill_height, 0)) * (hrp.CFrame - hrp.CFrame.Position)
				end
			end
		end})
		tpkill_height_slider.State(false)
		tpkill_uptime_slider = mscsec:Slider({Name = "TP kill uptime", Min = 0.5, Max = 15, Float = 0.1, Value = 3, Flag = "tpkill_uptime", Suffix = "%ss", Callback = function(int)
			tpkill_uptime = int
		end})
		tpkill_uptime_slider.State(false)
		tpkill_cd_slider = mscsec:Slider({Name = "TP kill cooldown", Min = 0, Max = 30, Float = 1, Value = 6, Flag = "tpkill_cooldown", Suffix = "%ss", Callback = function(int)
			tpkill_cooldown = int
		end})
		tpkill_cd_slider.State(false)
		tpkill_face_toggle = mscsec:Toggle({Name = "TP kill face target", Value = false, Flag = "tpkill_face", Callback = function(bool)
			tpkill_face = bool
		end})
		tpkill_face_toggle.State(false)
		tpkill_track_toggle = mscsec:Toggle({Name = "TP kill track target", Value = false, Flag = "tpkill_track", Callback = function(bool)
			tpkill_track = bool
		end})
		tpkill_track_toggle.State(false)
		cheat.utility.new_renderstepped(function()
			if not tpkill_on then return end
			local char = LocalPlayer.Character
			local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
			if not hrp then return end
			if not (tpkill_target and tpkill_target.Parent) then
				if tick() - tpkill_go > 0.5 then
					tpkill_go = tick()
					local tgt = tpkill_find()
					if tgt then
						tpkill_launch(tgt, hrp, char)
					end
				end
				return
			end
			if tick() - tpkill_go > tpkill_uptime then
				tpkill_toggle.Set(false)
				return
			end
			if tpkill_track then
				hrp.CFrame = _CFramenew(tpkill_target.Position + _Vector3new(0, tpkill_height, 0)) * (hrp.CFrame - hrp.CFrame.Position)
				hrp.AssemblyLinearVelocity = _Vector3new(0, 0, 0)
			end
			if tpkill_face then
				Camera.CFrame = _CFramenew(Camera.CFrame.Position, tpkill_target.Position)
			end
		end)

		mscsec:Dropdown({Name = "Auto-shoot hitscan", Values = {
			"FaceHitBox",
			"HeadTopHitBox",
			"Head",
			"UpperTorso",
			"LowerTorso",
			"LeftUpperArm",
			"LeftLowerArm",
			"LeftHand",
			"RightUpperArm",
			"RightLowerArm",
			"RightHand",
			"RightUpperLeg",
			"RightLowerLeg",
			"RightFoot",
			"LeftUpperLeg",
			"LeftLowerLeg",
			"LeftFoot"
		}, Value = {"FaceHitBox", "HeadTopHitBox", "Head"}, Flag = "aimbot_autoshoot_hitscan", Multi = true, Callback = function(tbl)
			hitscan_hitboxes = {}
			for index, hitbox in project_delta.hitboxes_priority do
				for _, chosen in tbl do
					if chosen ~= hitbox then
						continue
					end
					table.insert(hitscan_hitboxes, chosen)
				end
			end
		end})

		do
			local holdbullets_keybind; holdbullets_keybind = mscsec:Toggle({Name = "Hold bullets", Value = false, Flag = "aimbot_holdbullets", Callback = function(bool)
				holdbullets = bool
			end}):Keybind({Name = "Hold bullets", Mode = "Toggle", Key = Enum.KeyCode.X, Value = false, Flag = "aimbot_holdbullets_keybind", Link = "aimbot_holdbullets", Callback = function(bool)
				holdbullets_key = holdbullets and bool
				holdbullets_keybind.Set(holdbullets_key, true)
			end})

			local main_wireframe = Instance.new("WireframeHandleAdornment")
			main_wireframe.Parent = game:GetService("CoreGui").RobloxGui
			main_wireframe.Adornee = workspace
			main_wireframe.Color3 = Color3.new(1, 1, 1)
			main_wireframe.Transparency = 0
			main_wireframe.AlwaysOnTop = true
			main_wireframe.CFrame = CFrame.new()
			main_wireframe.Scale = Vector3.one
			main_wireframe.Thickness = 1
			main_wireframe.AdornCullingMode = Enum.AdornCullingMode.Automatic

			cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
				main_wireframe:Clear()
			end))
		end
	end
	do
		local bullet_tracers, bullet_tracers_color = false, Color3.new(1, 1, 1)


		local fov_outline_toggle, fov_sides_slider = nil, nil
		local fov_toggle = effsec:Toggle({Name = "Aimbot fov", Value = false, Flag = "fov_enabled", Callback = function(bool)
			fov_show = bool
			local vis = bool and true or false
			if fov_outline_toggle then fov_outline_toggle.State(vis) end
			if fov_sides_slider then fov_sides_slider.State(vis) end
		end})
		fov_toggle:Colorpicker({Name = "FOV color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "fov_color", Callback = function(color)
			fov_color = color.c
		end})
		fov_outline_toggle = effsec:Toggle({Name = "FOV outline", Value = false, Flag = "fov_outline", Callback = function(bool)
			fov_outline = bool
		end})
		fov_outline_toggle.State(false)
		fov_sides_slider = effsec:Slider({Name = "FOV sides", Min = 3, Max = 100, Float = 1, Value = 67, Flag = "fov_sides", Suffix = "%s", Callback = function(int)
			fov_sides = int
		end})
		fov_sides_slider.State(false)
		effsec:Toggle({Name = "Snapline", Value = false, Flag = "fov_snapline", Callback = function(bool)
			snapline_show = bool
		end}):Colorpicker({Name = "Snapline color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "fov_snapline_color", Callback = function(color)
			snapline_color = color.c
		end})

		cheat.crosshair = false
		cheat.crosshair_color = Color3.fromRGB(0, 255, 150)
		cheat.crosshair_pos = "Center"
		cheat.crosshair_tween = false
		cheat.crosshair_tween_speed = 10
		cheat.crosshair_len = 6
		cheat.crosshair_thick = 1
		cheat.crosshair_gap = 3
		cheat.crosshair_op = 100
		cheat.crosshair_outline = false
		cheat.crosshair_outline_color = Color3.fromRGB(0, 0, 0)
		cheat.crosshair_spin = false
		cheat.crosshair_spin_speed = 3
		local cross_pos_dropdown, cross_tween_toggle, cross_tweenspeed_slider, cross_len_slider, cross_thick_slider, cross_gap_slider, cross_op_slider, cross_outline_toggle, cross_spin_toggle, cross_spinspeed_slider = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
		local cross_toggle = effsec:Toggle({Name = "Custom crosshair", Value = false, Flag = "crosshair_enabled", Callback = function(bool)
			cheat.crosshair = bool
			local vis = bool and true or false
			if cross_pos_dropdown then cross_pos_dropdown.State(vis) end
			if cross_tween_toggle then cross_tween_toggle.State(vis) end
			if cross_tweenspeed_slider then cross_tweenspeed_slider.State(vis) end
			if cross_len_slider then cross_len_slider.State(vis) end
			if cross_thick_slider then cross_thick_slider.State(vis) end
			if cross_gap_slider then cross_gap_slider.State(vis) end
			if cross_op_slider then cross_op_slider.State(vis) end
			if cross_outline_toggle then cross_outline_toggle.State(vis) end
			if cross_spin_toggle then cross_spin_toggle.State(vis) end
			if cross_spinspeed_slider then cross_spinspeed_slider.State(vis) end
		end})
		cross_toggle:Colorpicker({Name = "Crosshair color", Value = Color3.fromRGB(0, 255, 150), Usealpha = false, Flag = "crosshair_color", Callback = function(color)
			cheat.crosshair_color = color.c
		end})
		cross_pos_dropdown = effsec:Dropdown({Name = "Crosshair position", Values = {"Center", "Mouse", "Target"}, Value = "Center", Flag = "crosshair_pos", Multi = false, Callback = function(str)
			cheat.crosshair_pos = str
		end})
		cross_pos_dropdown.State(false)
		cross_tween_toggle = effsec:Toggle({Name = "Crosshair tween", Value = false, Flag = "crosshair_tween", Callback = function(bool)
			cheat.crosshair_tween = bool
		end})
		cross_tween_toggle.State(false)
		cross_tweenspeed_slider = effsec:Slider({Name = "Crosshair tween speed", Min = 1, Max = 30, Float = 1, Value = 10, Flag = "crosshair_tween_speed", Callback = function(int)
			cheat.crosshair_tween_speed = int
		end})
		cross_tweenspeed_slider.State(false)
		cross_len_slider = effsec:Slider({Name = "Crosshair length", Min = 1, Max = 60, Float = 1, Value = 6, Flag = "crosshair_length", Callback = function(int)
			cheat.crosshair_len = int
		end})
		cross_len_slider.State(false)
		cross_thick_slider = effsec:Slider({Name = "Crosshair thickness", Min = 1, Max = 12, Float = 1, Value = 1, Flag = "crosshair_thickness", Callback = function(int)
			cheat.crosshair_thick = int
		end})
		cross_thick_slider.State(false)
		cross_gap_slider = effsec:Slider({Name = "Crosshair gap", Min = 0, Max = 10, Float = 1, Value = 3, Flag = "crosshair_gap", Callback = function(int)
			cheat.crosshair_gap = int
		end})
		cross_gap_slider.State(false)
		cross_op_slider = effsec:Slider({Name = "Crosshair opacity", Min = 0, Max = 100, Float = 1, Value = 100, Flag = "crosshair_opacity", Callback = function(int)
			cheat.crosshair_op = int
		end})
		cross_op_slider.State(false)
		cross_outline_toggle = effsec:Toggle({Name = "Crosshair outline", Value = false, Flag = "crosshair_outline", Callback = function(bool)
			cheat.crosshair_outline = bool
		end})
		cross_outline_toggle:Colorpicker({Name = "Outline color", Value = Color3.fromRGB(0, 0, 0), Usealpha = false, Flag = "crosshair_outline_color", Callback = function(color)
			cheat.crosshair_outline_color = color.c
		end})
		cross_outline_toggle.State(false)
		cross_spin_toggle = effsec:Toggle({Name = "Crosshair spin", Value = false, Flag = "crosshair_spin", Callback = function(bool)
			cheat.crosshair_spin = bool
		end})
		cross_spin_toggle.State(false)
		cross_spinspeed_slider = effsec:Slider({Name = "Crosshair spin speed", Min = 0.1, Max = 20, Float = 0.1, Value = 3, Flag = "crosshair_spin_speed", Callback = function(int)
			cheat.crosshair_spin_speed = int
		end})
		cross_spinspeed_slider.State(false)
		do
			local ch_gui = Instance.new("ScreenGui")
			ch_gui.Name = "SwimCrosshair"
			ch_gui.ResetOnSpawn = false
			ch_gui.IgnoreGuiInset = true
			ch_gui.DisplayOrder = 10
			ch_gui.Parent = game:GetService("CoreGui")
			local ch_root = Instance.new("Frame")
			ch_root.AnchorPoint = Vector2.new(0.5, 0.5)
			ch_root.Size = UDim2.fromOffset(1, 1)
			ch_root.Position = UDim2.fromScale(0.5, 0.5)
			ch_root.BackgroundTransparency = 1
			ch_root.BorderSizePixel = 0
			ch_root.Parent = ch_gui
			local arms = {}
			for _, side in {"Top", "Right", "Bottom", "Left"} do
				local f = Instance.new("Frame")
				f.Name = side
				f.BorderSizePixel = 0
				f.Parent = ch_root
				local s = Instance.new("UIStroke")
				s.Thickness = 1
				s.Parent = f
				arms[side] = {f = f, s = s}
			end
			local ch_pos = _Vector2new(0, 0)
			local ch_rot = 0
			local ch_style = {}
			local function muzzle_part()
				local vm = Camera and Camera:FindFirstChildOfClass("Model")
				local item = vm and _FindFirstChild(vm, "Item")
				local m = item and _FindFirstChild(item, "Muzzle")
				if m then return m end
				local ch = LocalPlayer.Character
				local tool = ch and _FindFirstChildOfClass(ch, "Tool")
				return tool and _FindFirstChild(tool, "Muzzle")
			end
			cheat.utility.new_renderstepped(function(delta)
				if not cheat.crosshair then
					ch_root.Visible = false
					return
				end
				ch_root.Visible = true
				local len, th, gap = cheat.crosshair_len, cheat.crosshair_thick, cheat.crosshair_gap
				local col, op = cheat.crosshair_color, 1 - cheat.crosshair_op / 100
				local oon, ocol = cheat.crosshair_outline, cheat.crosshair_outline_color
				if ch_style.len ~= len or ch_style.th ~= th or ch_style.gap ~= gap or ch_style.col ~= col or ch_style.op ~= op or ch_style.oon ~= oon or ch_style.ocol ~= ocol then
					ch_style.len, ch_style.th, ch_style.gap, ch_style.col, ch_style.op, ch_style.oon, ch_style.ocol = len, th, gap, col, op, oon, ocol
					arms.Top.f.Size = UDim2.new(0, th, 0, len)
					arms.Bottom.f.Size = UDim2.new(0, th, 0, len)
					arms.Left.f.Size = UDim2.new(0, len, 0, th)
					arms.Right.f.Size = UDim2.new(0, len, 0, th)
					local off = gap + len / 2
					arms.Top.f.AnchorPoint = Vector2.new(0.5, 0.5)
					arms.Bottom.f.AnchorPoint = Vector2.new(0.5, 0.5)
					arms.Left.f.AnchorPoint = Vector2.new(0.5, 0.5)
					arms.Right.f.AnchorPoint = Vector2.new(0.5, 0.5)
					arms.Top.f.Position = UDim2.new(0.5, 0, 0.5, -off)
					arms.Bottom.f.Position = UDim2.new(0.5, 0, 0.5, off)
					arms.Left.f.Position = UDim2.new(0.5, -off, 0.5, 0)
					arms.Right.f.Position = UDim2.new(0.5, off, 0.5, 0)
					for _, side in {"Top", "Right", "Bottom", "Left"} do
						arms[side].f.BackgroundColor3 = col
						arms[side].f.BackgroundTransparency = op
						arms[side].s.Enabled = oon
						arms[side].s.Color = ocol
					end
				end
				local vs = Camera.ViewportSize
				local dest = _Vector2new(vs.X / 2, vs.Y / 2)
				if cheat.crosshair_pos == "Mouse" then
					dest = UserInputService:GetMouseLocation()
				elseif cheat.crosshair_pos == "Target" then
					local aim_point = (target_part and target_part.Parent) and target_part.Position or nil
					if typeof(aimbot_part) == "table" and #aimbot_part > 1 and target_character then
						local torso = _FindFirstChild(target_character, "UpperTorso") or _FindFirstChild(target_character, "LowerTorso") or _FindFirstChild(target_character, "HumanoidRootPart")
						if torso then aim_point = torso.Position end
					end
					if aim_point then
						local sp, on = _WorldToViewportPoint(Camera, aim_point)
						if on then
							dest = _Vector2new(sp.X, sp.Y)
						end
					end
				end
				if cheat.crosshair_tween then
					local k = 1 - math.exp(-cheat.crosshair_tween_speed * (delta or 0.016))
					ch_pos = ch_pos + (dest - ch_pos) * k
				else
					ch_pos = dest
				end
				ch_root.Position = UDim2.new(0, ch_pos.X, 0, ch_pos.Y)
				if cheat.crosshair_spin then
					ch_rot = (ch_rot + cheat.crosshair_spin_speed * delta * 60) % 360
				else
					ch_rot = 0
				end
				ch_root.Rotation = ch_rot
			end)
		end

		cheat.hud = {
			enabled = false,
			show = {viewport = true, name = true, dist = true, vis = true, kdr = true, kd = true, reps = true, time = true, hp = true, guns = true, visor = true},
			target = nil,
			seen = {},
			stat_cache = {name = nil, t = 0, kd = "?", kstr = "", hours = 0, reports = 0, visor = nil, tool = "NONE", tool_name = nil, tool_t = 0},
			tick = 0
		}
		local hud_rows
		do
			local acc = Library.Theme.accent
			cheat.hud.gui = Instance.new("ScreenGui")
			cheat.hud.gui.Name = "TargetHUD"
			cheat.hud.gui.DisplayOrder = 0
			cheat.hud.gui.IgnoreGuiInset = true
			cheat.hud.gui.ResetOnSpawn = false
			cheat.hud.gui.Enabled = false
			cheat.hud.gui.Parent = game:GetService("CoreGui")
			local hud_w = 190
			cheat.hud.w = hud_w
			local outer = Instance.new("Frame")
			outer.Name = "Panel"
			local vp0 = Camera.ViewportSize
			outer.Size = UDim2.fromOffset(hud_w, 120)
			outer.Position = UDim2.fromOffset(math.max(vp0.X - hud_w - 24, 0), math.max(vp0.Y - 150, 0))
			outer.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
			outer.BorderSizePixel = 0
			outer.Active = true
			outer.Parent = cheat.hud.gui
			cheat.hud.outer = outer
			cheat.hud.stroke = Instance.new("UIStroke")
			cheat.hud.stroke.Thickness = 1
			cheat.hud.stroke.Color = Color3.fromRGB(40, 42, 44)
			cheat.hud.stroke.Parent = outer
			do
				local dragging = false
				local grab = Vector2.new()
				outer.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						local p = input.Position - outer.AbsolutePosition
						grab = Vector2.new(p.X, p.Y)
						dragging = true
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						local vs = Camera.ViewportSize
						local nx = math.clamp(input.Position.X - grab.X, 0, math.max(vs.X - outer.AbsoluteSize.X, 0))
						local ny = math.clamp(input.Position.Y - grab.Y, 0, math.max(vs.Y - outer.AbsoluteSize.Y, 0))
						outer.Position = UDim2.fromOffset(nx, ny)
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end)
			end
			local strip = Instance.new("Frame")
			strip.Name = "accent"
			strip.Size = UDim2.fromOffset(2, 1)
			strip.Position = UDim2.fromOffset(0, 0)
			strip.BackgroundColor3 = acc
			strip.BorderSizePixel = 0
			strip.Parent = outer
			cheat.hud.strip = strip
			local avframe = Instance.new("Frame")
			avframe.Name = "avatar"
			avframe.Position = UDim2.fromOffset(10, 8)
			avframe.Size = UDim2.fromOffset(26, 26)
			avframe.BackgroundColor3 = Color3.fromRGB(40, 42, 44)
			avframe.BorderSizePixel = 0
			avframe.Parent = outer
			cheat.hud.av = Instance.new("ImageLabel")
			cheat.hud.av.Position = UDim2.fromOffset(1, 1)
			cheat.hud.av.Size = UDim2.fromOffset(24, 24)
			cheat.hud.av.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
			cheat.hud.av.BorderSizePixel = 0
			cheat.hud.av.ScaleType = Enum.ScaleType.Crop
			cheat.hud.av.Image = ""
			cheat.hud.av.Parent = avframe
			cheat.hud.avframe = avframe
			cheat.hud.rows = {}
			for i = 1, 9 do
				local bg = Instance.new("Frame")
				bg.BackgroundColor3 = Color3.fromRGB(40, 42, 44)
				bg.BorderSizePixel = 0
				bg.Size = UDim2.fromOffset(140, 13)
				bg.Visible = false
				bg.Parent = outer
				local lbl = Instance.new("TextLabel")
				lbl.BackgroundTransparency = 1
				lbl.FontFace = Fonts.Get("TahomaXP")
				lbl.TextSize = 10
				lbl.TextXAlignment = Enum.TextXAlignment.Left
				lbl.TextColor3 = Color3.fromRGB(150, 150, 150)
				lbl.TextStrokeTransparency = 1
				lbl.Position = UDim2.fromOffset(5, 0)
				lbl.Size = UDim2.new(1, -10, 1, 0)
				lbl.Parent = bg
				local val = Instance.new("TextLabel")
				val.BackgroundTransparency = 1
				val.FontFace = Fonts.Get("TahomaXP")
				val.TextSize = 10
				val.TextXAlignment = Enum.TextXAlignment.Right
				val.TextColor3 = Color3.fromRGB(230, 230, 230)
				val.TextStrokeTransparency = 1
				val.TextTruncate = Enum.TextTruncate.AtEnd
				val.Position = UDim2.fromOffset(5, 0)
				val.Size = UDim2.new(1, -10, 1, 0)
				val.Parent = bg
				bg.MouseEnter:Connect(function() bg.BackgroundColor3 = Color3.fromRGB(50, 52, 54) end)
				bg.MouseLeave:Connect(function() bg.BackgroundColor3 = Color3.fromRGB(40, 42, 44) end)
				cheat.hud.rows[i] = {bg = bg, lbl = lbl, val = val}
			end
			local hpbg = Instance.new("Frame")
			hpbg.BackgroundColor3 = Color3.fromRGB(40, 42, 44)
			hpbg.BorderSizePixel = 0
			hpbg.Size = UDim2.fromOffset(140, 13)
			hpbg.Visible = false
			hpbg.ClipsDescendants = true
			hpbg.Parent = outer
			cheat.hud.hp_fill = Instance.new("Frame")
			cheat.hud.hp_fill.Size = UDim2.new(1, 0, 1, 0)
			cheat.hud.hp_fill.BackgroundColor3 = Color3.fromRGB(75, 215, 95)
			cheat.hud.hp_fill.BorderSizePixel = 0
			cheat.hud.hp_fill.Parent = hpbg
			cheat.hud.hp_t = Instance.new("TextLabel")
			cheat.hud.hp_t.Size = UDim2.new(1, -10, 1, 0)
			cheat.hud.hp_t.BackgroundTransparency = 1
			cheat.hud.hp_t.FontFace = Fonts.Get("TahomaXP")
			cheat.hud.hp_t.TextSize = 10
			cheat.hud.hp_t.Position = UDim2.fromOffset(5, 0)
			cheat.hud.hp_t.TextXAlignment = Enum.TextXAlignment.Right
			cheat.hud.hp_t.TextColor3 = Color3.fromRGB(255, 255, 255)
			cheat.hud.hp_t.TextStrokeTransparency = 1
			cheat.hud.hp_t.Text = ""
			cheat.hud.hp_t.Parent = hpbg
			cheat.hud.hp_bg = hpbg
		end
		local hud_elements_dropdown = nil
		local hud_toggle = effsec:Toggle({Name = "Target hud", Value = false, Flag = "hud_enabled", Callback = function(bool)
			cheat.hud.enabled = bool
			if hud_elements_dropdown then hud_elements_dropdown.State(bool) end
		end})
		local hud_element_keys = {
			["Avatar"] = "viewport",
			["Name"] = "name",
			["Distance"] = "dist",
			["Vis"] = "vis",
			["KDR"] = "kdr",
			["KD"] = "kd",
			["Reports"] = "reps",
			["Time"] = "time",
			["Health"] = "hp",
			["Weapons"] = "guns",
			["Visor"] = "visor"
		}
		hud_elements_dropdown = effsec:Dropdown({Name = "HUD elements", Values = {"Avatar", "Name", "Distance", "Vis", "KDR", "KD", "Reports", "Time", "Health", "Weapons", "Visor"}, Value = {"Avatar", "Name", "Distance", "Vis", "KDR", "KD", "Reports", "Time", "Health", "Weapons", "Visor"}, Flag = "hud_elements", Multi = true, Callback = function(tbl)
			for k, _ in cheat.hud.show do
				cheat.hud.show[k] = false
			end
			for _, name in tbl do
				local key = hud_element_keys[name]
				if key then
					cheat.hud.show[key] = true
				end
			end
		end})
		hud_elements_dropdown.State(false)


		do
			local inventory_holder = Instance.new("Frame")
			inventory_holder.Parent = game:GetService("CoreGui").RobloxGui
			inventory_holder.BackgroundTransparency = 1
			inventory_holder.BorderSizePixel = 0
			inventory_holder.Position = UDim2.new(0, -GuiInset.X, 0, -GuiInset.Y)
			inventory_holder.ZIndex = 2

			local default_font = Fonts.Get("SmallestPixel7")

			local inventory_text = Instance.new("TextLabel")
			inventory_text.Parent = inventory_holder
			inventory_text.AnchorPoint = Vector2.new(0, 0)
			inventory_text.BackgroundTransparency = 1
			inventory_text.BorderSizePixel = 0
			inventory_text.Position = UDim2.new(0, 2, 0, 0)
			inventory_text.FontFace = default_font
			inventory_text.Text = ""
			inventory_text.RichText = true
			inventory_text.TextColor3 = Color3.new(1, 1, 1)
			inventory_text.TextSize = 9
			inventory_text.TextStrokeTransparency = 0
			inventory_text.TextXAlignment = Enum.TextXAlignment.Left
			inventory_text.TextYAlignment = Enum.TextYAlignment.Top


			local inv_bg_picker, inv_font_dropdown, inv_size_slider, inv_x_slider, inv_y_slider = nil, nil, nil, nil, nil
			local inv_toggle = effsec:Toggle({Name = "Inventory viewer", Value = false, Flag = "inventory_viewer", Callback = function(bool)
				inventory_holder.Visible = bool
				local vis = bool and true or false
				if inv_bg_picker then inv_bg_picker.State(vis) end
				if inv_font_dropdown then inv_font_dropdown.State(vis) end
				if inv_size_slider then inv_size_slider.State(vis) end
				if inv_x_slider then inv_x_slider.State(vis) end
				if inv_y_slider then inv_y_slider.State(vis) end
			end})
			inv_toggle:Colorpicker({Name = "Viewer color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "inventory_viewer_color", Callback = function(color)
				inventory_text.TextColor3 = color.c
				inventory_text.TextTransparency = color.a
			end})
			inv_bg_picker = effsec:Colorpicker({Name = "Background", Value = Color3.new(), Alpha = 0.7, Usealpha = true, Flag = "inventory_viewer_background", Callback = function(color)
				inventory_holder.BackgroundColor3 = color.c
				inventory_holder.BackgroundTransparency = color.a
			end})
			inv_bg_picker.State(false)
			inv_font_dropdown = effsec:Dropdown({Name = "Viewer font", Values = {
				"Tahoma",
				"TahomaXP",
				"Comfortaa",
				"Verdana",
				"SmallestPixel7",
				"Proggy",
			}, Value = {"SmallestPixel7"}, Flag = "inventory_viewer_font", Multi = false, Callback = function(str)
					inventory_text.FontFace = Fonts.Get(str or "SmallestPixel7") or default_font
				end})
			inv_font_dropdown.State(false)
			inv_size_slider = effsec:Slider({Name = "Viewer size", Min = 1, Max = 30, Float = 1, Value = 9, Flag = "inventory_viewer_size", Suffix = "%spx", Callback = function(int)
				inventory_text.TextSize = int
			end})
			inv_size_slider.State(false)
			inv_x_slider = effsec:Slider({Name = "Viewer X", Min = 0, Max = 100, Float = 1, Value = 5, Flag = "inventory_viewer_x", Suffix = "%s%%", Callback = function(int)
				inventory_holder.Position = UDim2.new(int / 100, -GuiInset.X, inventory_holder.Position.Y.Scale, -GuiInset.Y)
			end})
			inv_x_slider.State(false)
			inv_y_slider = effsec:Slider({Name = "Viewer Y", Min = 0, Max = 100, Float = 1, Value = 5, Flag = "inventory_viewer_y", Suffix = "%s%%", Callback = function(int)
				inventory_holder.Position = UDim2.new(inventory_holder.Position.X.Scale, -GuiInset.X, int / 100, -GuiInset.Y)

			end})
			inv_y_slider.State(false)

			local player_list = cheat.player_list

			local function flare_name(item_name)
				if item_name == "FlareGun" then
					return "<font color=\"rgb(255,60,60)\">FlareGun</font>"
				end
				return item_name
			end

			local weapon_slots = {
				ItemBack1 = 1,
				ItemBack2 = 2,
				ItemHip1 = 3,
				Melee = 4
			}

			local armor_slots = {
				ClothingHeadware = 1,
				ClothingChestRig = 2,
				ClothingMask = 3,
				ClothingLegArmor = 4
			}

			local get_weapon_loadedammo = LPH_NO_VIRTUALIZE(function(weapon)
				local weapon_loadedammo = weapon:GetAttribute("LoadedAmmo")
				if weapon_loadedammo then
					return weapon_loadedammo
				end

				local attachments = _FindFirstChild(weapon, "Attachments")
				if not attachments then
					return 0
				end

				for _, attachment in attachments:GetChildren() do
					local loadedammo = attachment:GetAttribute("LoadedAmmo")
					if loadedammo then
						return loadedammo
					end
				end

				return 0
			end)

			local get_player_inventory = LPH_NO_VIRTUALIZE(function(player)
				local player_object = player_list[player]
				local game_data = player_object and player_object.game_data
				if not game_data then
					return ""
				end

				local inventory = _FindFirstChild(game_data, "Inventory")
				if not (inventory) then
					return ""
				end


























				local weapon, armor, inventoried, last = {}, {}, {}, {}
				for _, item in inventory:GetChildren() do
					local item_name = item.Name
					local slot = item:GetAttribute("Slot")
					if not slot then
						last[#last + 1] = {item_name}
						continue
					end

					local found_slot = weapon_slots[slot]
					if found_slot then
						local durability = item:GetAttribute("Durability") or 1
						local max_durability = item:GetAttribute("MaxDurability") or 1
						weapon[found_slot] = {item_name, get_weapon_loadedammo(item), mathfloor(durability / max_durability * 100)}
						continue
					end

					found_slot = armor_slots[slot]
					if found_slot then
						armor[found_slot] = {item_name}
					end

					local inventory = _FindFirstChild(item, "Inventory")
					if not inventory then
						if not found_slot then
							last[#last + 1] = {item_name}
						end
						continue
					end

					local current_inventory = {}
					inventoried[#inventoried + 1] = {item_name, current_inventory}

					for _, subitem in inventory:GetChildren() do
						local subitem_name = subitem.Name
						local amount = subitem:GetAttribute("Amount") or 1
						if current_inventory[subitem_name] then
							current_inventory[subitem_name] += amount
						else
							current_inventory[subitem_name] = amount
						end
					end
				end

				table.sort(inventoried, function(a, b)
					return a[1] < b[1]
				end)
				table.sort(last, function(a, b)
					return a[1] < b[1]
				end)

				local text_buffer = ("%*'s Inventory\n"):format(player.Name)

			text_buffer ..= "[Hotbar]\n"
			for _, item in weapon do
				text_buffer ..= ("\t%* - %* (%*%%)\n"):format(flare_name(item[1]), item[2], item[3])
			end

			text_buffer ..= "[Armor]\n"
			for _, item in armor do
				text_buffer ..= ("\t%*\n"):format(flare_name(item[1]))
			end

			text_buffer ..= "[Inventory]\n"
			for _, item in inventoried do
				text_buffer ..= ("\t%* =>\n"):format(flare_name(item[1]))
				for subitem_name, subitem_amount in item[2] do
					text_buffer ..= ("\t\t%* => %*x\n"):format(flare_name(subitem_name), subitem_amount)
				end
			end

			text_buffer ..= "[Other]\n"
			for _, item in last do
				text_buffer ..= ("\t%*\n"):format(flare_name(item[1]))
			end




















				return text_buffer:gsub("[\r\n]$", "")
			end)
			cheat.utility.new_heartbeat(LPH_JIT(function()
				local inventory = target_player and get_player_inventory(target_player) or ""
				inventory_text.Text = inventory
				inventory_holder.Size = inventory ~= "" and UDim2.new(0, inventory_text.TextBounds.X + 4, 0, inventory_text.TextBounds.Y + 2) or UDim2.new(0, 0, 0, 0)
			end))
		end

		effsec:Toggle({Name = "Bullet tracers", Value = false, Flag = "bullet_tracers", Callback = function(bool)
			bullet_tracers = bool
		end}):Colorpicker({Name = "FOV color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "bullet_tracers_color", Callback = function(color)
			bullet_tracers_color = color.c
		end})

		local hitsound_volume_slider, hitsound_speed_slider, hitsound_selection_dropdown = nil, nil, nil
		local hitsound_toggle = effsec:Toggle({Name = "Hit sound", Value = false, Flag = "hit_sound", Callback = function(bool)
			hit_sound = bool
			local vis = bool and true or false
			if hitsound_volume_slider then hitsound_volume_slider.State(vis) end
			if hitsound_speed_slider then hitsound_speed_slider.State(vis) end
			if hitsound_selection_dropdown then hitsound_selection_dropdown.State(vis) end
		end})
		hitsound_volume_slider = effsec:Slider({Name = "Hit sound volume", Min = 0.1, Max = 10, Float = 0.1, Value = 1, Flag = "hit_sound_volume", Suffix = "%s", Callback = function(int)
			hit_sound_volume = int
		end})
		hitsound_volume_slider.State(false)
		hitsound_speed_slider = effsec:Slider({Name = "Hit sound speed", Min = 0.1, Max = 3, Float = 0.1, Value = 1, Flag = "hit_sound_speed", Suffix = "%s", Callback = function(int)
			hit_sound_speed = int
		end})
		hitsound_speed_slider.State(false)

		hitsound_selection_dropdown = effsec:Dropdown({Name = "Hit sound selection", Values = (function()
			local hitsounds = {}
			for name, _ in cheat.hitsounds do
				table.insert(hitsounds, name)
			end
			return hitsounds
		end)(), Value = "Bameware", Flag = "hit_sound_id", Multi = false, Callback = function(str)
			hit_sound_instance = cheat.hitsounds[str]
		end})
		hitsound_selection_dropdown.State(false)

		local killsound_selection_dropdown, killsound_volume_slider, killsound_speed_slider = nil, nil, nil
		local killsound_toggle = effsec:Toggle({Name = "Kill sound", Value = false, Flag = "kill_sound", Callback = function(bool)
			kill_sound = bool
			cheat.feat.kill_sound = bool
			local vis = bool and true or false
			if killsound_selection_dropdown then killsound_selection_dropdown.State(vis) end
			if killsound_volume_slider then killsound_volume_slider.State(vis) end
			if killsound_speed_slider then killsound_speed_slider.State(vis) end
		end})
		killsound_selection_dropdown = effsec:Dropdown({Name = "Kill sound selection", Values = (function()
			local hitsounds = {}
			for name, _ in cheat.hitsounds do
				table.insert(hitsounds, name)
			end
			return hitsounds
		end)(), Value = "Bameware", Flag = "kill_sound_id", Multi = false, Callback = function(str)
			kill_sound_instance = cheat.hitsounds[str]
		end})
		killsound_selection_dropdown.State(false)
		killsound_volume_slider = effsec:Slider({Name = "Kill sound volume", Min = 0.1, Max = 10, Float = 0.1, Value = 1, Flag = "kill_sound_volume", Suffix = "%s", Callback = function(int)
			kill_sound_volume = int
		end})
		killsound_volume_slider.State(false)
		killsound_speed_slider = effsec:Slider({Name = "Kill sound speed", Min = 0.1, Max = 3, Float = 0.1, Value = 1, Flag = "kill_sound_speed", Suffix = "%s", Callback = function(int)
			kill_sound_speed = int
		end})
		killsound_speed_slider.State(false)

		local hitlogs_duration_slider = nil
		local hitlogs_toggle = effsec:Toggle({Name = "Hit logs", Value = false, Flag = "hit_logs", Callback = function(bool)
			hit_logs = bool
			if hitlogs_duration_slider then hitlogs_duration_slider.State(bool) end
		end})
		hitlogs_duration_slider = effsec:Slider({Name = "Log duration", Min = 0, Max = 10, Float = 0.1, Value = 5, Flag = "hit_logs_duration", Suffix = "%ss", Callback = function(int)
			hit_logs_duration = int
		end})
		hitlogs_duration_slider.State(false)

		do
			local picture_on_kill, picture_on_kill_no_background, picture_duration, fade_duration = false, false, 0.05, 0.5
			local pok_nobg_toggle, pok_duration_slider, pok_fade_slider = nil, nil, nil

			local pok_toggle = effsec:Toggle({Name = "Picture on kill", Value = false, Flag = "picture_on_kill", Callback = function(bool)
				picture_on_kill = bool
				local vis = bool and true or false
				if pok_nobg_toggle then pok_nobg_toggle.State(vis) end
				if pok_duration_slider then pok_duration_slider.State(vis) end
				if pok_fade_slider then pok_fade_slider.State(vis) end
			end})
			pok_nobg_toggle = effsec:Toggle({Name = "No picture background", Value = false, Flag = "picture_on_kill_no_background", Callback = function(bool)
				picture_on_kill_no_background = bool
			end})
			pok_nobg_toggle.State(false)
			pok_duration_slider = effsec:Slider({Name = "Picture duration", Min = 0, Max = 10, Float = 0.1, Value = 0.05, Flag = "picture_on_kill_duration", Suffix = "%ss", Callback = function(int)
				picture_duration = int
			end})
			pok_duration_slider.State(false)
			pok_fade_slider = effsec:Slider({Name = "Picture fade duration", Min = 0, Max = 10, Float = 0.1, Value = 5, Flag = "picture_on_kill_fade_duration", Suffix = "%ss", Callback = function(int)
				fade_duration = int
			end})
			pok_fade_slider.State(false)
			effsec:Button({Name = "Reload pictures", Confirm = false, Callback = function()
				PicturesOnKill.Reload()
			end})
			effsec:Button({Name = "Download furries", Confirm = false, Callback = function()
				Library.Notification("no", 2.5)
			end})
			if firesignal then
				effsec:Button({Name = "Test picture on kill", Confirm = false, Callback = function()
					local success = pcall(firesignal, game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("NotificationMessage").OnClientEvent, "Killed", 1, 5)
					if not success then
						Library.Notification("Failed to test. (firesignal errored)", 2.5)
					end
				end})
			end

			local TweenService = game:GetService("TweenService")

			local PictureHolder = Instance.new("ScreenGui", game:GetService("CoreGui"))
			PictureHolder.ResetOnSpawn = false
			PictureHolder.IgnoreGuiInset = true

			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("NotificationMessage").OnClientEvent:Connect(function(text, duration, color)
				if text:find("Killed") or text:find("Incapacitated") then
					if kill_sound then
						task.defer(function()
							local sound = kill_sound_instance:Clone()
							sound.Volume = kill_sound_volume
							sound.PlaybackSpeed = kill_sound_speed
							sound.Parent = SoundService
							sound.PlayOnRemove = true
							sound:Destroy()
						end)
					end
				end
				if picture_on_kill and (text:find("Killed") or text:find("Incapacitated")) then
				task.spawn(function()
					local imagelabel = Instance.new("ImageLabel")
					imagelabel.Image = PicturesOnKill.GetNextPicture()
						imagelabel.Size = UDim2.new(1, 0, 1, 0)
						imagelabel.Position = UDim2.new(0, 0, 0, 0)
						imagelabel.BackgroundTransparency = picture_on_kill_no_background and 1 or 0
						imagelabel.ImageTransparency = 0
						imagelabel.Parent = PictureHolder

						task.wait(picture_duration)

						local connection; connection = RunService.RenderStepped:Connect(function(d)
							if imagelabel.BackgroundTransparency < 1 then
								imagelabel.BackgroundTransparency += d * (1/fade_duration)
							end
							if imagelabel.ImageTransparency < 1 then
								imagelabel.ImageTransparency += d * (1/fade_duration)
							else
								connection:Disconnect()
								imagelabel:Destroy()
							end
						end)
					end)
				end
			end)
		end

		local make_beam = cheat.make_beam
		local bullet_module = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("FPS"):WaitForChild("Bullet"))
		local old_createbullet = bullet_module.CreateBullet
		local drop_proto, drop_index, drop_original, drop_applied = nil, nil, nil, false
		local function apply_no_drop()
			if drop_applied or not no_bullet_drop or not debug or not debug.getconstants or not debug.setconstant then return end
			local function scan(fn, depth)
				if drop_proto or depth > 5 or type(fn) ~= "function" then return end
				local ok, constants = pcall(debug.getconstants, fn)
				if ok and type(constants) == "table" then
					for index, value in constants do
						if value == -70 then
							drop_proto, drop_index, drop_original = fn, index, value
							return
						end
					end
				end
				if debug.getproto then
					for index = 1, 8 do
						local ok_proto, proto = pcall(debug.getproto, fn, index)
						if not ok_proto or type(proto) ~= "function" then break end
						scan(proto, depth + 1)
						if drop_proto then return end
					end
				end
			end
			scan(old_createbullet, 0)
			if drop_proto then
				drop_applied = pcall(debug.setconstant, drop_proto, drop_index, 0)
			end
		end

		local fake_part = Instance.new("Part")
		fake_part.Anchored = true
		fake_part.Parent = game:GetService("ReplicatedStorage")

		bullet_module.CreateBullet = LPH_NO_VIRTUALIZE(function(...)
			apply_no_drop()
			if not no_bullet_drop and drop_applied and drop_proto then
				pcall(debug.setconstant, drop_proto, drop_index, drop_original)
				drop_applied = false
			end
			local args = {...}
			fake_part.CFrame = args[5].CFrame
			args[5] = fake_part

			local origin = project_delta.get_estimated_origin(LocalPlayer)

			if aimbot_mode == "Silent" and target_part then
				fake_part.CFrame = CFrame.lookAt(origin, target_part.Position)
			end
			if bullet_tracers then
				make_beam(origin, origin + fake_part.CFrame.LookVector * 3300, bullet_tracers_color)
			end
			return old_createbullet(unpack(args))
		end)
	end
	do
		local force_auto, rapid_fire, rapid_fire_speed, loadbyhand_delay, loadbyhand_async = false, false, 1/60, 0.15, false

		local spring_disablers = {
			["sprintCycle"] = false,
			["leanAlpha"] = false,
			["strafeTilt"] = false,
			["walkCycle"] = false,
			["jumpCameraTilt"] = false,
			["recoilRot"] = false,
			["gunSway"] = false,
			["jumpTilt"] = false,
			["cameraRecoil"] = false,
			["recoilPos"] = false,
			["wallTouchTilt"] = false,
			["sway"] = false
		}
		local aliases = {
			["Recoil"] = {"recoilPos", "recoilRot", "cameraRecoil"},
			["Bobbing"] = {"sprintCycle", "walkCycle", "jumpTilt"},
			["Sway"] = {"gunSway", "sway", "strafeTilt"},
			["Jump shake"] = {"jumpCameraTilt"},
			["Wall touch"] = {"wallTouchTilt"}
		}
		gunsec:Dropdown({Name = "Removals", Values = (function()
			local new = {}
			for i, v in aliases do
				new[#new + 1] = i
			end
			return new
		end)(), Value = {}, Flag = "gunmods_removals", Multi = true, Callback = function(tbl)
			no_recoil = false
			for spring_name, value in spring_disablers do
				spring_disablers[spring_name] = false
			end
			for _, alias in tbl do
				if alias == "Recoil" then
					no_recoil = true
				end
				for _, spring_name in aliases[alias] do
					spring_disablers[spring_name] = true
				end
			end
		end})
		gunsec:Toggle({Name = "No spread", Value = false, Flag = "spread_enabled", Callback = function(bool)
			no_spread = bool
		end})
		gunsec:Toggle({Name = "No bullet Drop", Value = false, Flag = "nodrop_enabled", Callback = function(bool)
			no_bullet_drop = bool
		end})
		gunsec:Toggle({Name = "Instant lean", Value = false, Flag = "instant_lean", Callback = function(bool)
			instant_lean = bool
		end})
		gunsec:Toggle({Name = "Manipulation", Value = false, Flag = "manipulation", Callback = function(bool)
			cheat.feat.manipulation = bool
		end})
		gunsec:Toggle({Name = "Insta nade Throw", Value = false, Flag = "instant_nade", Callback = function(bool)
			cheat.feat.instant_nade = bool
		end})
		gunsec:Toggle({Name = "Instant reload", Value = false, Flag = "gunmods_instant_reload", Callback = function(bool)
			instant_reload = bool
		end})
		gunsec:Toggle({Name = "LBH async delay", Value = false, Flag = "gunmods_loadbyhand_async", Callback = function(bool)
			loadbyhand_async = bool
		end})
		gunsec:Slider({Name = "LBH delay", Min = 0, Max = 0.5, Float = 0.01, Value = 0.15, Flag = "gunmods_loadbyhand_delay", Suffix = "%ss", Callback = function(int)
			loadbyhand_delay = int
		end})
		gunsec:Toggle({Name = "Instant equip", Value = false, Flag = "gunmods_instant_equip", Callback = function(bool)
			instant_equip = bool
		end})
		gunsec:Toggle({Name = "Instant aim", Value = false, Flag = "gunmods_instant_aim", Callback = function(bool)
			instant_aim = bool
		end})

		gunsec:Toggle({Name = "Force auto", Value = false, Flag = "gunmods_force_auto", Callback = function(bool)
			force_auto = bool
		end})
		local rapid_speed_slider = nil
		local rapid_toggle = gunsec:Toggle({Name = "Rapid fire", Value = false, Flag = "gunmods_rapid_fire", Callback = function(bool)
			rapid_fire = bool
			if rapid_speed_slider then rapid_speed_slider.State(bool) end
		end})
		rapid_speed_slider = gunsec:Slider({Name = "Rounds per second", Min = 10, Max = 100, Float = 1, Value = 60, Flag = "gunmods_rapid_fire_speed", Suffix = "1s/%s", Callback = function(int)
			rapid_fire_speed = 1/int
		end})
		rapid_speed_slider.State(false)

		do
			local auto_reload, auto_refill = false

			local newlclosure = newlclosure or LPH_NO_VIRTUALIZE(function(f)
				return function(...)
					return f(...)
				end
			end)

			local success, old_remove
			success, old_remove = pcall(hookfunction, project_delta.remove_bullet, newlclosure(function(fps_object, ...)
				local hmm = {old_remove(fps_object, ...)}

				if not auto_reload then
					return unpack(hmm)
				end
				if fps_object.Bullets > 0 then
					return unpack(hmm)
				end

				task.spawn(fps_object.reload, fps_object)

				return unpack(hmm)
			end))

			if not success then
				print("failed to hook remove_bullet", old_remove, getgenv().newlclosure)
			else

				gunsec:Toggle({Name = "Auto reload", Value = false, Flag = "gunmods_auto_reload", Callback = function(bool)
					auto_reload = bool
				end})



			end
		end

		local old_reload_magazine, old_reload_loadbyhand = project_delta.fps_reloadtypes.magazine, project_delta.fps_reloadtypes.loadByHand
		local get_compatible_mag, get_compatible_ammo = project_delta.get_compatible_mag, project_delta.get_compatible_ammo
		local update_fps = project_delta.update_fps

		local reload_remote, inventorymove_remote, equip_remote = project_delta.reload_remote, project_delta.inventorymove_remote, project_delta.equip_remote

		cheat.auto_refill_mag = false
		cheat.grenade_predict = false
		cheat.grenade_predict_color = Color3.fromRGB(255, 80, 80)
		cheat.grenade_impact_color = Color3.fromRGB(255, 200, 50)
		cheat.grenade_bounces = 3
		cheat.grenade_lineup = false
		cheat.grenade_lineup_color = Color3.fromRGB(80, 220, 255)
		cheat.grenade_arc = 1
		local traj_bounces_slider, traj_lineup_toggle, traj_arc_dropdown = nil, nil, nil
		local traj_toggle = gunsec:Toggle({Name = "Predict trajectory", Value = false, Flag = "gunmods_grenade_predict", Callback = function(bool)
			cheat.grenade_predict = bool
			local vis = bool and true or false
			if traj_bounces_slider then traj_bounces_slider.State(vis) end
			if traj_lineup_toggle then traj_lineup_toggle.State(vis) end
			if traj_arc_dropdown then traj_arc_dropdown.State(vis) end
		end})
		traj_toggle:Colorpicker({Name = "Trajectory color", Value = Color3.fromRGB(255, 80, 80), Usealpha = false, Flag = "gunmods_grenade_predict_color", Callback = function(color)
			cheat.grenade_predict_color = color.c
		end})
		traj_toggle:Colorpicker({Name = "Impact color", Value = Color3.fromRGB(255, 200, 50), Usealpha = false, Flag = "gunmods_grenade_impact_color", Callback = function(color)
			cheat.grenade_impact_color = color.c
		end})
		traj_bounces_slider = gunsec:Slider({Name = "Grenade bounces", Min = 1, Max = 10, Float = 1, Value = 3, Flag = "gunmods_grenade_bounces", Callback = function(int)
			cheat.grenade_bounces = int
		end})
		traj_bounces_slider.State(false)
		traj_lineup_toggle = gunsec:Toggle({Name = "Target lineup", Value = false, Flag = "gunmods_grenade_lineup", Callback = function(bool)
			cheat.grenade_lineup = bool
		end})
		traj_lineup_toggle:Colorpicker({Name = "Lineup color", Value = Color3.fromRGB(80, 220, 255), Usealpha = false, Flag = "gunmods_grenade_lineup_color", Callback = function(color)
			cheat.grenade_lineup_color = color.c
		end})
		traj_lineup_toggle.State(false)
		traj_arc_dropdown = gunsec:Dropdown({Name = "Lineup arc", Values = {"Auto (Best Lineup)", "Low Arc (Direct)", "High Arc (Mortar Lob)", "Airburst (Fuse Timed)"}, Value = "Auto (Best Lineup)", Flag = "gunmods_grenade_arc", Multi = false, Callback = function(str)
			if str == "Low Arc (Direct)" then
				cheat.grenade_arc = 2
			elseif str == "High Arc (Mortar Lob)" then
				cheat.grenade_arc = 3
			elseif str == "Airburst (Fuse Timed)" then
				cheat.grenade_arc = 4
			else
				cheat.grenade_arc = 1
			end
		end})
		traj_arc_dropdown.State(false)
		do
			local grenade_data = {
				F1 = {name = "F1", overhand_speed = 92, underhand_speed = 40, fuse_time = 3, is_impact = false, radius = 8.5, bounciness = 0.3},
				RGD5 = {name = "RGD-5", overhand_speed = 108, underhand_speed = 46, fuse_time = 3, is_impact = false, radius = 8.5, bounciness = 0.38},
				RGO = {name = "RGO", overhand_speed = 98, underhand_speed = 42, fuse_time = 3.2, is_impact = true, radius = 17, bounciness = 0.25},
				M84 = {name = "M84 Flashbang", overhand_speed = 116, underhand_speed = 50, fuse_time = 1.2, is_impact = false, radius = 4.5, bounciness = 0.45},
				Snowball = {name = "Snowball", overhand_speed = 122, underhand_speed = 54, fuse_time = 2.5, is_impact = true, radius = 3, bounciness = 0.05}
			}
			local traj_params = RaycastParams.new()
			traj_params.FilterType = Enum.RaycastFilterType.Exclude
			traj_params.IgnoreWater = false
			traj_params.CollisionGroup = "WeaponRay"
			local function traj_ignore()
				local list = {LocalPlayer.Character, Camera, workspace.NoCollision, traj_folder}
				pcall(function()
					for _, v in require(game:GetService("ReplicatedStorage").Modules.UniversalTables).ReturnTable("GlobalIgnoreListProjectile") do
						table.insert(list, v)
					end
				end)
				return list
			end
			local function grenade_info()
				local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
				local data = folder and folder:FindFirstChild(LocalPlayer.Name)
				local status = data and data:FindFirstChild("Status")
				local vars = status and status:FindFirstChild("GameplayVariables")
				local tool = vars and vars:FindFirstChild("EquippedTool")
				local equipped = tool and tool.Value
				if not equipped then return nil end
				if grenade_data[equipped.Name] then
					local g = grenade_data[equipped.Name]
					return {name = g.name, fuse = g.fuse_time, is_rgo = g.is_impact, radius = g.radius, overhand_speed = g.overhand_speed, underhand_speed = g.underhand_speed, bounciness = g.bounciness}
				end
				local props = equipped:FindFirstChild("ItemProperties") or equipped
				local itype = props and (props:GetAttribute("ItemType") or props:GetAttribute("SlotType"))
				local nm = string.lower(equipped.Name)
				if itype ~= "Grenade" and not string.find(nm, "grenade") and not string.find(nm, "f1") and not string.find(nm, "rgd") and not string.find(nm, "rgo") and not string.find(nm, "m84") then
					return nil
				end
				local desc = props and props:GetAttribute("Description") or ""
				local fuse = tonumber(string.match(desc, "Fuze length is set to%s*(%d+%.?%d*)%s*sec")) or 3
				local impact = string.find(string.lower(desc), "impact") ~= nil
				local radius = 8.5
				local rm = string.match(desc, "fatality radius of around%s*(%d+%.?%d*)%s*metre")
				if rm then radius = (tonumber(rm) or 3) * 2.83 end
				return {name = props and props:GetAttribute("ItemName") or equipped.Name, fuse = fuse, is_rgo = impact, radius = radius, overhand_speed = 100, underhand_speed = 44, bounciness = 0.35}
			end
			local function grenade_sim(origin, vel, fuse, bounces, bounciness, is_impact)
				local t, pos, v = 0, origin, vel
				local normal = Vector3.new(0, 1, 0)
				local points = {pos}
				local grav = Vector3.new(0, -(workspace.Gravity or 80), 0)
				local n = 0
				while t < fuse and n <= bounces and #points < 120 do
					local next_pos = pos + v * 0.035 + 0.5 * grav * 0.035 * 0.035
					local next_v = (v + grav * 0.035) * 0.995
					local delta = next_pos - pos
					if delta.Magnitude < 0.01 then break end
					traj_params.FilterDescendantsInstances = traj_ignore()
					local hit = workspace:Raycast(pos, delta, traj_params)
					if not hit then
						pos, v = next_pos, next_v
						table.insert(points, pos)
					else
						normal = hit.Normal
						table.insert(points, hit.Position)
						if is_impact then break end
						local mat = hit.Instance.Material and hit.Instance.Material.Name or "Default"
						local keep, damp = 1, 0.75
						if mat == "Grass" or mat == "Ground" or mat == "Mud" or mat == "Sand" or mat == "Terrain" then
							keep, damp = 0.7, 0.5
						elseif mat == "Metal" or mat == "DiamondPlate" or mat == "CorrodedMetal" then
							keep, damp = 1.15, 0.85
						elseif mat == "Wood" or mat == "WoodPlanks" then
							keep, damp = 0.9, 0.65
						end
						local d = v:Dot(normal)
						if d < 0 then
							local ncomp = normal * d
							v = (v - ncomp) * damp - ncomp * (bounciness * keep)
						end
						n += 1
						if v.Magnitude < 6 or (normal.Y > 0.5 and math.abs(d) < 4 and v.Magnitude < 10) then break end
						pos = hit.Position + normal * 0.08
					end
					t += 0.035
				end
				return points, normal, t
			end
			local function lineup_target()
				local campos = Camera.CFrame.Position
				local mouse = UserInputService:GetMouseLocation()
				local inset = game:GetService("GuiService"):GetGuiInset()
				local best, best_name, best_score = nil, "Target", math.huge
				for _, player in Players:GetPlayers() do
					if player ~= LocalPlayer and player.Character then
						local hum = _FindFirstChildOfClass(player.Character, "Humanoid")
						local part = _FindFirstChild(player.Character, "HumanoidRootPart") or _FindFirstChild(player.Character, "UpperTorso") or _FindFirstChild(player.Character, "Head")
						if hum and hum.Health > 0 and part then
							local sp, on = _WorldToViewportPoint(Camera, part.Position)
							local d = math.sqrt((sp.X - mouse.X) ^ 2 + (sp.Y - inset.Y - mouse.Y) ^ 2)
							local mdist = (campos - part.Position).Magnitude
							if mdist < 600 then
								local score = d + mdist * 0.4
								if score < best_score then
									best_score = score
									best = part
									best_name = player.Name
								end
							end
						end
					end
				end
				return best, best_name
			end
			local function solve_arc(origin, target, speed, move_vel, fuse, bounciness, is_impact, mode)
				local flat = target - origin
				flat = Vector3.new(flat.X, 0, flat.Z)
				local dist = flat.Magnitude
				if dist <= 0.5 then return nil, 0 end
				local dir = flat / dist
				local g = workspace.Gravity or 80
				local v2 = speed * speed
				local dy = (target - origin).Y
				local cands = {}
				local disc = v2 * v2 - g * (g * dist * dist + 2 * dy * v2)
				if disc >= 0 then
					local sq = math.sqrt(disc)
					table.insert(cands, math.deg(math.atan((v2 - sq) / (g * dist))))
					table.insert(cands, math.deg(math.atan((v2 + sq) / (g * dist))))
				end
				local lo, hi, step = -10, 75, 2.5
				if mode == 2 then
					lo, hi, step = -10, 38, 2
				elseif mode == 3 then
					lo, hi, step = 38, 75, 2
				elseif mode == 4 then
					lo, hi, step = 5, 75, 3
				end
				for a = lo, hi, step do
					table.insert(cands, a)
				end
				local best_dir, best_err = nil, math.huge
				for _, deg in cands do
					local rad = math.rad(deg)
					local look = dir * math.cos(rad) + Vector3.new(0, 1, 0) * math.sin(rad)
					local pts = grenade_sim(origin, look * speed + move_vel * 0.45, fuse, 3, bounciness, is_impact)
					local final = pts[#pts]
					if final then
						local err = (final - target).Magnitude
						if err < best_err then
							best_err = err
							best_dir = look
						end
					end
				end
				return best_dir, best_err
			end
			cheat.grenade_aim_direction = function(overhand)
				local info = grenade_info()
				if not info then return nil end
				local tgt = lineup_target()
				if not tgt then return nil end
				local campos = Camera.CFrame.Position
				local origin = campos + Camera.CFrame.LookVector * 1.3
				local char = LocalPlayer.Character
				local mvel = char and char.PrimaryPart and char.PrimaryPart.AssemblyLinearVelocity or Vector3.zero
				local speed = overhand and (info.overhand_speed or 105) or (info.underhand_speed or 45)
				local dir = solve_arc(origin, tgt.Position - Vector3.new(0, 1.2, 0), speed, mvel, info.fuse or 3, info.bounciness or 0.35, info.is_rgo, cheat.grenade_arc)
				return dir
			end
			traj_folder = Instance.new("Model")
			traj_folder.Name = "TrajFolder"
			traj_folder.Parent = workspace
			local traj_segs = {}
			for i = 1, 120 do
				local p = Instance.new("Part")
				p.Name = "TrajSeg"
				p.Anchored = true
				p.CanCollide = false
				p.CanTouch = false
				p.CanQuery = false
				p.CastShadow = false
				p.Material = Enum.Material.Neon
				p.Transparency = 1
				p.Size = Vector3.new(0.12, 0.12, 1)
				p.Parent = traj_folder
				traj_segs[i] = p
			end
			local traj_ball = Instance.new("SphereHandleAdornment")
			traj_ball.Adornee = workspace.Terrain
			traj_ball.AlwaysOnTop = true
			traj_ball.ZIndex = 6
			traj_ball.Radius = 0.55
			traj_ball.Transparency = 0.05
			traj_ball.Visible = false
			traj_ball.Parent = traj_folder
			local traj_ring = Instance.new("CylinderHandleAdornment")
			traj_ring.Adornee = workspace.Terrain
			traj_ring.AlwaysOnTop = true
			traj_ring.ZIndex = 5
			traj_ring.Height = 0.08
			traj_ring.Transparency = 0.05
			traj_ring.Visible = false
			traj_ring.Parent = traj_folder
			local traj_fill = Instance.new("CylinderHandleAdornment")
			traj_fill.Adornee = workspace.Terrain
			traj_fill.AlwaysOnTop = true
			traj_fill.ZIndex = 4
			traj_fill.Height = 0.04
			traj_fill.Transparency = 0.78
			traj_fill.Visible = false
			traj_fill.Parent = traj_folder
			local traj_pillar = Instance.new("Part")
			traj_pillar.Name = "ImpactPillar"
			traj_pillar.Anchored = true
			traj_pillar.CanCollide = false
			traj_pillar.CanTouch = false
			traj_pillar.CanQuery = false
			traj_pillar.CastShadow = false
			traj_pillar.Material = Enum.Material.Neon
			traj_pillar.Transparency = 1
			traj_pillar.Size = Vector3.new(0.3, 40, 0.3)
			traj_pillar.Parent = traj_folder
			local traj_hl = Instance.new("Highlight")
			traj_hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			traj_hl.FillTransparency = 0.1
			traj_hl.OutlineTransparency = 1
			traj_hl.Adornee = traj_folder
			traj_hl.Parent = traj_folder
			local traj_txt = cheat.utility.new_drawing("Text", {Visible = false, Size = 13, Center = true, Outline = true})
			local line_segs = {}
			for i = 1, 80 do
				local p = Instance.new("Part")
				p.Name = "LineupSeg"
				p.Anchored = true
				p.CanCollide = false
				p.CanTouch = false
				p.CanQuery = false
				p.CastShadow = false
				p.Material = Enum.Material.Neon
				p.Transparency = 1
				p.Size = Vector3.new(0.09, 0.09, 1)
				p.Parent = traj_folder
				line_segs[i] = p
			end
			local line_dot = cheat.utility.new_drawing("Circle", {Visible = false, Radius = 7, Thickness = 1.5})
			local line_cdot = cheat.utility.new_drawing("Circle", {Visible = false, Radius = 2, Thickness = 1})
			local line_txt = cheat.utility.new_drawing("Text", {Visible = false, Size = 13, Center = true, Outline = true})
			local function traj_hide()
				for i = 1, 120 do traj_segs[i].Transparency = 1 end
				for i = 1, 80 do line_segs[i].Transparency = 1 end
				traj_ball.Visible = false
				traj_ring.Visible = false
				traj_fill.Visible = false
				traj_pillar.Transparency = 1
				traj_hl.Enabled = false
				traj_txt.Visible = false
				line_dot.Visible = false
				line_cdot.Visible = false
				line_txt.Visible = false
			end
			local function traj_hide_line()
				for i = 1, 80 do line_segs[i].Transparency = 1 end
				line_dot.Visible = false
				line_cdot.Visible = false
				line_txt.Visible = false
			end
			cheat.utility.new_renderstepped(function()
				if not cheat.grenade_predict and not cheat.grenade_lineup then
					traj_hide()
					return
				end
				local info = grenade_info()
				if not info then
					traj_hide()
					return
				end
				local char = LocalPlayer.Character
				if not char or not Camera then
					traj_hide()
					return
				end
				local rmb = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
				local speed = rmb and (info.underhand_speed or 45) or (info.overhand_speed or 105)
				local origin = Camera.CFrame.Position + Camera.CFrame.LookVector * 1.3
				local mvel = char.PrimaryPart and char.PrimaryPart.AssemblyLinearVelocity or Vector3.zero
				if cheat.grenade_predict then
					local pts, _, impact_t = grenade_sim(origin, Camera.CFrame.LookVector * speed + mvel * 0.45, info.fuse or 3, cheat.grenade_bounces, info.bounciness or 0.35, info.is_rgo)
					local n = 1
					local total = #pts - 1
					for i = 1, total do
						if n > 120 then break end
						local a, b2 = pts[i], pts[i + 1]
						if (b2 - a).Magnitude > 0.001 then
							local s = traj_segs[n]
							local k = i / math.max(total, 1)
							s.Size = Vector3.new(0.12, 0.12, (b2 - a).Magnitude)
							s.CFrame = CFrame.lookAt((a + b2) * 0.5, b2)
							s.Color = cheat.grenade_predict_color:Lerp(cheat.grenade_impact_color, k)
							s.Transparency = 0.05 + k * 0.35
							n += 1
						end
					end
					for i = n, 120 do traj_segs[i].Transparency = 1 end
					local final = pts[#pts]
					if final then
						local radius = info.radius or 8.5
						local pulse = 1 + 0.06 * math.sin(tick() * 6)
						traj_ball.CFrame = CFrame.new(final)
						traj_ball.Color3 = cheat.grenade_impact_color
						traj_ball.Visible = true
						traj_ring.Radius = radius * pulse
						traj_ring.InnerRadius = math.max(0, radius * pulse - 0.45)
						traj_ring.Color3 = cheat.grenade_impact_color
						traj_ring.Transparency = 0.05 + 0.15 * math.abs(math.sin(tick() * 6))
						traj_ring.CFrame = CFrame.new(final)
						traj_ring.Visible = true
						traj_fill.Radius = radius
						traj_fill.InnerRadius = 0
						traj_fill.Color3 = cheat.grenade_impact_color
						traj_fill.CFrame = CFrame.new(final)
						traj_fill.Visible = true
						traj_pillar.CFrame = CFrame.new(final + _Vector3new(0, 20, 0))
						traj_pillar.Color = cheat.grenade_impact_color
						traj_pillar.Transparency = 0.25
						traj_hl.FillColor = cheat.grenade_predict_color
						traj_hl.OutlineColor = cheat.grenade_predict_color
						traj_hl.Enabled = true
						local sp, on = _WorldToViewportPoint(Camera, final)
						if on and sp.Z > 0 then
							traj_txt.Position = _Vector2new(sp.X, sp.Y - 20)
							traj_txt.Text = info.name .. " [T-" .. ("%.1fs"):format(math.max((info.fuse or 3) - impact_t, 0)) .. " | Lethal: " .. ("%.1f"):format(radius / 2.8) .. "m | " .. math.floor((final - Camera.CFrame.Position).Magnitude / 2.8) .. "m]"
							traj_txt.Color = cheat.grenade_impact_color
							traj_txt.Visible = true
						else
							traj_txt.Visible = false
						end
					else
						traj_ball.Visible = false
						traj_ring.Visible = false
						traj_fill.Visible = false
						traj_pillar.Transparency = 1
						traj_txt.Visible = false
					end
				else
					for i = 1, 120 do traj_segs[i].Transparency = 1 end
					traj_ball.Visible = false
					traj_ring.Visible = false
					traj_fill.Visible = false
					traj_pillar.Transparency = 1
					traj_hl.Enabled = false
					traj_txt.Visible = false
				end
				if cheat.grenade_lineup then
					local tgt, tname = lineup_target()
					if tgt then
						local dir, err = solve_arc(origin, tgt.Position - Vector3.new(0, 1.2, 0), speed, mvel, info.fuse or 3, info.bounciness or 0.35, info.is_rgo, cheat.grenade_arc)
						if dir then
							local pts = grenade_sim(origin, dir * speed + mvel * 0.45, info.fuse or 3, cheat.grenade_bounces, info.bounciness or 0.35, info.is_rgo)
							local n = 1
							local total = #pts - 1
							for i = 1, total do
								if n > 80 then break end
								local a, b2 = pts[i], pts[i + 1]
								if (b2 - a).Magnitude > 0.001 then
									local s = line_segs[n]
									local k = i / math.max(total, 1)
									s.Size = Vector3.new(0.09, 0.09, (b2 - a).Magnitude)
									s.CFrame = CFrame.lookAt((a + b2) * 0.5, b2)
									s.Color = cheat.grenade_lineup_color:Lerp(Color3.new(1, 1, 1), k * 0.7)
									s.Transparency = 0.1 + k * 0.3
									n += 1
								end
							end
							for i = n, 80 do line_segs[i].Transparency = 1 end
							local sp, on = _WorldToViewportPoint(Camera, Camera.CFrame.Position + dir * 100)
							if on and sp.Z > 0 then
								local pulse = 1 + 0.15 * math.sin(tick() * 8)
								line_dot.Position = _Vector2new(sp.X, sp.Y)
								line_dot.Color = cheat.grenade_lineup_color
								line_dot.Radius = 7 * pulse
								line_dot.Visible = true
								line_cdot.Position = _Vector2new(sp.X, sp.Y)
								line_cdot.Color = cheat.grenade_lineup_color
								line_cdot.Visible = true
								local flat = (tgt.Position - Vector3.new(0, 1.2, 0)) - origin
								local mdist = math.floor(Vector3.new(flat.X, 0, flat.Z).Magnitude / 2.8)
								line_txt.Position = _Vector2new(sp.X, sp.Y - 18)
								line_txt.Text = "[AIM HERE] " .. tname .. " (" .. mdist .. "m | Err: " .. ("%.1f"):format(err / 2.8) .. "m)"
								line_txt.Color = cheat.grenade_lineup_color
								line_txt.Visible = true
							else
								line_dot.Visible = false
								line_cdot.Visible = false
								line_txt.Visible = false
							end
						else
							traj_hide_line()
						end
					else
						traj_hide_line()
					end
				else
					traj_hide_line()
				end
			end)
		end
		task.spawn(function()
			while task.wait(0.5) do
				if cheat.auto_refill_mag and project_delta.fps_object then
					pcall(function()
						local fps_object = project_delta.fps_object
						local mag = get_compatible_mag(fps_object)
						if not mag then return end
						local loaded = mag:GetAttribute("LoadedAmmo") or 0
						local maxloaded = mag:GetAttribute("MaxLoadedAmmo") or 30
						if loaded >= maxloaded then return end
						local ammo = get_compatible_ammo(fps_object, nil)
						if not ammo then return end
						inventorymove_remote:FireServer(ammo:GetAttribute("Slot"), mag:GetAttribute("Slot"), ammo.Parent, mag.Parent, nil)
					end)
				end
			end
		end)

		local local_gameplayvars, lpo = project_delta.local_game_data.Status.GameplayVariables, cheat.player_list[LocalPlayer]

		project_delta.fps_reloadtypes.magazine = LPH_JIT(function(fps_object, arg_mag)
			if not instant_reload then
				return old_reload_magazine(fps_object, arg_mag)
			end

			local mag = arg_mag or get_compatible_mag(fps_object)
			if not mag then
				return
			end

			local equipped_item = lpo.current_weapon
			local equip_id = local_gameplayvars:GetAttribute("EquipId")
			if not (equipped_item and equip_id) then
				return
			end



			equip_remote:FireServer()
			task.defer(function()
				local s = 0
				local oldparent = mag.Parent
				repeat
					s += task.wait()
				until s > 1 or (mag and oldparent and mag.Parent and mag.Parent ~= oldparent)
				if s > 1 then
					return print('reload timeout, terminating...')
				end
				update_fps(project_delta.fps_object)
			end)
			inventorymove_remote:FireServer(
				mag:GetAttribute("Slot") or mag:GetAttribute("SlotType"),
				"Magazine",
				mag.Parent,
				equipped_item.Attachments,
				nil
			)
			equip_remote:FireServer(equipped_item, equip_id)
		end)

		project_delta.fps_reloadtypes.loadByHand = LPH_JIT(function(fps_object, arg_ammo)
			if not instant_reload then
				return old_reload_loadbyhand(fps_object, arg_ammo)
			end

			local ammo, ammo_amount = get_compatible_ammo(fps_object, arg_ammo)

			if not ammo then
				return
			end
			for i = 0, ammo_amount - 1 do
				if loadbyhand_async then
					reload_remote:InvokeServer(nil, 1, ammo)
					update_fps(fps_object)
				else
					task.delay(i * loadbyhand_delay, function()
						reload_remote:InvokeServer(nil, 1, ammo)
						update_fps(fps_object)
					end)
				end
			end
		end)

		project_delta.add_fps_hook(function()
			local fps_object = project_delta.fps_object
			for name, spring in fps_object.springs do
				local old_shove, old_update = spring.shove, spring.update
				spring.shove = LPH_NO_VIRTUALIZE(function(...)
					if spring_disablers[name] then return end
					return old_shove(...)
				end)
				spring.update = LPH_NO_VIRTUALIZE(function(...)
					if spring_disablers[name] then return Vector3.zero end
					return old_update(...)
				end)
			end
		end)

		local old_updateclient
		local new_update = LPH_NO_VIRTUALIZE(function(fps_object, delta)
			if instant_aim then
				fps_object.AimInSpeed = 0
				fps_object.AimOutSpeed = 0
			end
			local lean_spring = fps_object.springs and fps_object.springs.leanAlpha
			if lean_spring and type(lean_spring) == "table" then
				if instant_lean then
					if cheat.lean_base == nil then
						cheat.lean_base = lean_spring.Speed
					end
					lean_spring.Speed = 50
				elseif cheat.lean_base ~= nil then
					lean_spring.Speed = cheat.lean_base
					cheat.lean_base = nil
				end
			end
			if force_auto or rapid_fire then
				if rapid_fire then fps_object.FireRate = rapid_fire_speed end
				local firemodes = fps_object.FireModes or {"Auto"}
				for i = 1, #firemodes do
					firemodes[i] = "Auto"
				end
				fps_object.FireModes = firemodes
			end
			return old_updateclient(fps_object, delta)
		end)

		project_delta.add_fps_hook(function()
			local fps_object = project_delta.fps_object
			old_updateclient = fps_object.updateClient
			fps_object.updateClient = new_update
		end)
	end

	local CircleOutline = cheat.utility.new_drawing("Circle", {
		Thickness = 3,
		Color = Color3.new(),
		ZIndex = 1
	})
	local CircleInline = cheat.utility.new_drawing("Circle", {
		Transparency = 1,
		Thickness = 1,
		ZIndex = 2
	})
	local SnapLine = cheat.utility.new_drawing("Line", {
		Visible = false,
		Thickness = 1,
		ZIndex = 2
	})

	local ammo_types = {}
	for i, v in game:GetService("ReplicatedStorage").AmmoTypes:GetChildren() do
		ammo_types[v.Name] = v
	end

	local fps_usetypes, get_estimated_origin = project_delta.fps_usetypes, project_delta.get_estimated_origin
	local is_visible, valid_hitboxes = cheat.is_visible, project_delta.hitboxes
	local target_wall_penetration = project_delta.target_wall_penetration
	task.spawn(LPH_NO_VIRTUALIZE(function()
		while task.wait() do
			local indtxt = ""

			target_part, target_player, target_character = nil, nil, nil

			if not aimbot_enabled then
				indicator.text = indtxt
				continue
			end

			local viewport_size, field_of_view = Camera.ViewportSize, Camera.FieldOfView
			local new_fov_size = (viewport_size.X * (fov_size / field_of_view)) / 2
			cheat.aim_fov = new_fov_size

			local maximum_distance = math.huge
			local target_list = get_targets_in_fov(new_fov_size, aimbot_part, aimbot_team_check, aimbot_dead_check, aimbot_dist_check, aimbot_max_distance, aimbot_npc_check, aimbot_screen_check)
			if #target_list > 0 then
				target_part, target_player, target_character = unpack(target_list[1])
			end

			if aimbot_mode ~= "Silent" then continue end

			if not (autoshoot and autoshoot_key and target_part) then continue end

			local character = LocalPlayer.Character
			local hrp = character and _FindFirstChild(character, "HumanoidRootPart")
			local hmm_origin = hrp and get_estimated_origin(LocalPlayer)

			if not hmm_origin then continue end

			local picked_target = false

			local fps_object = project_delta.fps_object
			local bullet_type, penetration_power
			if autowall then
				local bullets_list = fps_object.BulletsList
				if (fps_object.Bullets or 0) > 0 and bullets_list then
					local last = #bullets_list
					local entry = bullets_list[last]
					if entry and (entry.Amount or 0) > 0 then
						bullet_type = entry.AmmoType
					else
						local prev = bullets_list[last - 1]
						if prev then
							bullet_type = prev.AmmoType
						end
					end
				end
				if bullet_type then
					bullet_stats = ammo_types[bullet_type]
				end
			end

			for _, target in target_list do
				local aimpart, player, character, distance = unpack(target)

				local scan = hitscan_hitboxes
				local aname = aimpart.Name
				if aname == "Head" or aname == "FaceHitBox" or aname == "HeadTopHitBox" then
					scan = {"FaceHitBox", "HeadTopHitBox", "Head"}
				elseif aname == "UpperTorso" then
					scan = {"UpperTorso"}
				end

				for _, hitbox in scan do
					local hitscan_part = _FindFirstChild(character, hitbox)
					if not hitscan_part then continue end

					if autowall and bullet_stats then
						if not target_wall_penetration(hmm_origin, character, hitscan_part, hitscan_part.Position, bullet_stats) then continue end

						target_part, target_player, target_character = hitscan_part, player, character
						picked_target = true

						break
					end
					local vis, res = is_visible(hmm_origin, character, hitscan_part)
					if not (vis and valid_hitboxes[res.Instance.Name]) then continue end

					target_part, target_player, target_character = hitscan_part, player, character
					picked_target = true

					break
				end

				if picked_target then
					break
				end
			end

			if not picked_target then
				continue
			end

			local fps_object = project_delta.fps_object
			local use_module_name = fps_object and fps_object.useModuleName
			local use_func = use_module_name and fps_usetypes[use_module_name]
			if type(fps_object) == "table" and use_module_name == "RangedWeaponDefault" then
				pcall(use_func, fps_object)
			end
		end
	end))
		cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function()
			local mpos = UserInputService:GetMouseLocation()
		if fov_show then
			local viewportsize = Camera.ViewportSize
			local new_fov_size = (viewportsize.X * (fov_size / Camera.FieldOfView)) / 2

			CircleInline.Position = mpos
			CircleInline.Radius = new_fov_size
			CircleInline.Color = fov_color
			CircleInline.Visible = true
			CircleInline.NumSides = fov_sides

			CircleOutline.Position = mpos
			CircleOutline.Radius = new_fov_size
			CircleOutline.Visible = fov_outline
			CircleOutline.NumSides = fov_sides
		else
			CircleInline.Visible = false
			CircleOutline.Visible = false
		end
		if snapline_show and aimbot_enabled and (aimbot_mode == "Silent" or aimbot_enabled_key) and target_part and target_character then
			local anchor_part = target_part
			if typeof(aimbot_part) == "table" and #aimbot_part > 1 then
				anchor_part = _FindFirstChild(target_character, "UpperTorso") or _FindFirstChild(target_character, "LowerTorso") or target_part
			end
			local pos, on_screen = _WorldToViewportPoint(Camera, anchor_part.Position)
			if on_screen then
				local viewportsize = Camera.ViewportSize
				SnapLine.From = _Vector2new(viewportsize.X / 2, viewportsize.Y / 2)
				SnapLine.To = _Vector2new(pos.X, pos.Y)
				SnapLine.Color = snapline_color
				SnapLine.Visible = true
			else
				SnapLine.Visible = false
			end
		else
			SnapLine.Visible = false
		end
		local hud_on = cheat.hud.enabled and aimbot_enabled and (aimbot_mode == "Silent" or aimbot_enabled_key) and target_part and target_character and target_player
		cheat.hud.gui.Enabled = hud_on and true or false
		if hud_on then
			local now = os.clock()
			if now - cheat.hud.tick < 0.1 then return end
			cheat.hud.tick = now
			local ch, pl = target_character, target_player
			local hrp = ch and _FindFirstChild(ch, "HumanoidRootPart")
			local hum = ch and _FindFirstChildOfClass(ch, "Humanoid")
			if cheat.hud.target ~= ch then
				cheat.hud.target = ch
			end
			if typeof(pl) == "Instance" and pl:IsA("Player") and cheat.hud.seen[pl] == nil then
				cheat.hud.seen[pl] = os.clock()
			end
			local tp = (typeof(pl) == "Instance" and pl:IsA("Player")) and cheat.player_list[pl] or nil
			local is_player = tp ~= nil
			local vis = false
			if tp and tp.visible ~= nil then
				vis = tp.visible
			elseif hrp then
				vis = cheat.is_visible(Camera.CFrame.Position, ch, hrp) and true or false
			end
			local white = Color3.fromRGB(230, 230, 230)
			local gray = Color3.fromRGB(150, 150, 150)
			local green = Color3.fromRGB(110, 220, 110)
			local red = Color3.fromRGB(220, 90, 90)
			local orange = Color3.fromRGB(255, 170, 60)
			local fields = {}
			if is_player then
				local sc = cheat.hud.stat_cache
				if sc.name ~= pl.Name or now - sc.t > 0.5 then
					sc.name = pl.Name
					sc.t = now
					sc.kd, sc.kstr, sc.hours, sc.reports, sc.visor = "?", "", 0, 0, nil
					pcall(function()
						local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
						local data = folder and folder:FindFirstChild(pl.Name)
						local stats = data and data.Status.Journey.Statistics
						if stats then
							local k = stats:GetAttribute("K_PVP") or stats:GetAttribute("Kills") or 0
							local d = stats:GetAttribute("D_PVP") or stats:GetAttribute("Deaths") or 0
							sc.kd = d == 0 and string.format("%.2f", k) or string.format("%.2f", k / d)
							sc.kstr = string.format("(%d / %d)", k, d)
							sc.hours = (stats:GetAttribute("TimePlayed") or 0) / 3600
							local uac = data.Status:FindFirstChild("UAC")
							local repf = uac and uac:FindFirstChild("Reports")
							if repf then
								sc.reports = repf:GetAttribute("1") or 0
							end
						end
						local inv = data and data:FindFirstChild("Inventory")
						if inv then
							for _, obj in inv:GetDescendants() do
								if obj.Name:lower():find("visor", 1, true) then
									local tog = obj:GetAttribute("Toggle")
									if type(tog) == "boolean" then
										sc.visor = tog
										break
									end
								end
							end
						end
					end)
				end
				if cheat.hud.show.name then
					table.insert(fields, {"user", pl.Name, white})
				end
				if cheat.hud.show.kdr or cheat.hud.show.kd then
					table.insert(fields, {"kd", sc.kd .. " " .. sc.kstr, white})
				end
				if cheat.hud.show.time then
					table.insert(fields, {"play time", string.format("%.0fh", sc.hours), white})
				end
				if cheat.hud.show.guns then
					local tool = "NONE"
					pcall(function()
						local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
						local data = folder and folder:FindFirstChild(pl.Name)
						local eq = data and data.Status.GameplayVariables:FindFirstChild("EquippedTool")
						if eq and eq.Value then tool = eq.Value.Name end
					end)
					if tool == "NONE" and tp and tp.current_weapon then
						tool = tp.current_weapon.Name or "NONE"
					end
					table.insert(fields, {"tool", string.lower(tool), white})
				end
				if cheat.hud.show.dist and hrp then
					table.insert(fields, {"dist", math.floor((Camera.CFrame.Position - hrp.Position).Magnitude / 3) .. "m", white})
				end
				if cheat.hud.show.vis then
					table.insert(fields, {"status", vis and "visible" or "hidden", vis and green or red})
				end
				if cheat.hud.show.reps then
					table.insert(fields, {"reports", tostring(sc.reports), white})
				end
				if cheat.hud.show.visor then
					if sc.visor == nil then
						table.insert(fields, {"visor", "n/a", gray})
					else
						table.insert(fields, {"visor", sc.visor and "on" or "off", sc.visor and green or orange})
					end
				end
			else
				table.insert(fields, {"user", ch and ch.Name or "?", white})
				if cheat.hud.show.dist and hrp then
					table.insert(fields, {"dist", math.floor((Camera.CFrame.Position - hrp.Position).Magnitude / 3) .. "m", white})
				end
				if cheat.hud.show.vis then
					table.insert(fields, {"status", vis and "visible" or "hidden", vis and green or red})
				end
			end
			local hp_c, hp_m = 0, 100
			if hum then
				hp_c = math.floor(hum.Health)
				hp_m = math.floor(hum.MaxHealth)
			end
			local show_hp = cheat.hud.show.hp
			local show_av = cheat.hud.show.viewport and is_player
			local n = #fields
			local row_h, gap, pad, x0 = 13, 2, 8, 10
			local right = cheat.hud.w - pad
			local top = pad
			local col_x, col_w = x0, right - x0
			if show_av then
				cheat.hud.avframe.Position = UDim2.fromOffset(x0, top)
				col_x = x0 + 26 + 6
				col_w = right - col_x
			end
			for i = 1, n do
				local row = cheat.hud.rows[i]
				local f = fields[i]
				row.bg.Visible = f ~= nil
				row.bg.Position = UDim2.fromOffset(col_x, top + (i - 1) * (row_h + gap))
				row.bg.Size = UDim2.fromOffset(col_w, row_h)
				if f then
					row.lbl.Text = f[1]
					row.val.Text = f[2]
					row.val.TextColor3 = f[3]
				end
			end
			local body_h = math.max(show_av and 26 or 0, n > 0 and (n * row_h + (n - 1) * gap) or 0)
			local h = top + body_h + pad
			if show_hp then
				local hy = top + body_h + gap + 2
				cheat.hud.hp_bg.Visible = true
				cheat.hud.hp_bg.Position = UDim2.fromOffset(x0, hy)
				cheat.hud.hp_bg.Size = UDim2.fromOffset(right - x0, row_h)
				local k = math.clamp(hp_c / math.max(hp_m, 1), 0, 1)
				cheat.hud.hp_fill.Size = UDim2.new(k, 0, 1, 0)
				cheat.hud.hp_fill.BackgroundColor3 = k < 0.5 and Color3.fromRGB(225, 65, 65):Lerp(Color3.fromRGB(235, 200, 70), k / 0.5) or Color3.fromRGB(235, 200, 70):Lerp(Color3.fromRGB(75, 215, 95), (k - 0.5) / 0.5)
				cheat.hud.hp_t.Text = hp_c .. " / " .. hp_m
				h = hy + row_h + pad
			else
				cheat.hud.hp_bg.Visible = false
			end
			cheat.hud.avframe.Visible = show_av
			if show_av and typeof(pl) == "Instance" and pl:IsA("Player") then
				local thumb = "rbxthumb://type=AvatarBust&id=" .. pl.UserId .. "&w=150&h=150"
				if cheat.hud.av.Image ~= thumb then
					cheat.hud.av.Image = thumb
				end
			end
			cheat.hud.outer.Size = UDim2.fromOffset(cheat.hud.w, h)
			cheat.hud.strip.BackgroundColor3 = Library.Theme.accent
		else
			cheat.hud.target = nil
			table.clear(cheat.hud.seen)
		end
		if aimbot_enabled and aimbot_enabled_key and target_part and target_character then
			local new_pos = target_part.Position
			if aimbot_mode == "Mouse" then
				local pos = _WorldToViewportPoint(Camera, new_pos)
				local mpos = UserInputService:GetMouseLocation()
				mousemoverel(math.ceil((pos.X - mpos.X) * aimbot_smoothness), math.ceil((pos.Y - mpos.Y) * aimbot_smoothness))
			end
			if aimbot_mode == "Camera" then
				Camera.CFrame = Camera.CFrame:Lerp(CFrame.lookAt(Camera.CFrame.Position, new_pos), aimbot_smoothness)
			end
		end
	end))
end

local fov_changer, fov_changer_size = false, 100
local zoom, zoom_key, zoom_size = false, false, 10
local aspect_ratio, aspect_ratio_x, aspect_ratio_y = false, 1, 1
local thirdperson, thirdperson_key, thirdperson_distance = false, false, 10
do

	local espsec = ui.sections.player_esp
	local setsec = ui.sections.esp_settings
	local itmsec = ui.sections.item_esp
	local othsec = ui.sections.other_esp
	local mscsec = ui.sections.visuals_misc
	local lclsec = ui.sections.visuals_local

	local enemy_sets = cheat.EspLibrary.settings.enemy
	local enemy_main_sets = cheat.EspLibrary.settings.enemy.main_settings

	local item_sets = cheat.EspLibrary.settings.item
	local item_main_sets = cheat.EspLibrary.settings.item.main_settings

	local corpse_sets = cheat.EspLibrary.settings.corpse
	local corpse_main_sets = cheat.EspLibrary.settings.corpse.main_settings


	do
		espsec:Toggle({Name = "Enabled", Value = false, Flag = "esp_enabled", Callback = function(bool)
			enemy_sets.enabled = bool
			cheat.EspLibrary.icaca()
		end})

		do
			local rotation_slider = nil
			local outline_toggle = nil
			local toggle = espsec:Toggle({Name = "Box", Value = false, Flag = "esp_box", Callback = function(bool)
				enemy_sets.box = bool
				if rotation_slider then rotation_slider.State(bool) end
				if outline_toggle then outline_toggle.State(bool) end
				cheat.EspLibrary.icaca()
			end})
			toggle:Colorpicker({Name = "Box color left", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "esp_box_color_left", Callback = function(color)
				enemy_sets.box_color[1] = color.c
				enemy_sets.box_color[3] = color.a
				cheat.EspLibrary.icaca()
			end})
			toggle:Colorpicker({Name = "Box color right", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "esp_box_color_right", Callback = function(color)
				enemy_sets.box_color[2] = color.c
				cheat.EspLibrary.icaca()
			end})
			rotation_slider = espsec:Slider({Name = "Box rotation", Min = 0, Max = 20, Float = 0.1, Value = 0, Flag = "esp_box_rotation", Callback = function(int)
				enemy_sets.box_rotation = int * 18
				cheat.EspLibrary.icaca()
			end})
			rotation_slider.State(false)
			outline_toggle = espsec:Toggle({Name = "Box outline", Value = false, Flag = "esp_box_outline", Callback = function(bool)
				enemy_sets.box_outline = bool
				cheat.EspLibrary.icaca()
			end})
			outline_toggle:Colorpicker({Name = "Box outline color left", Value = Color3.new(), Usealpha = true, Flag = "esp_box_outline_color_left", Callback = function(color)
				enemy_sets.box_outline_color[1] = color.c
				enemy_sets.box_outline_color[2] = color.a
				cheat.EspLibrary.icaca()
			end})
			outline_toggle:Colorpicker({Name = "Box outline color right", Value = Color3.new(), Usealpha = true, Flag = "esp_box_outline_color_right", Callback = function(color)
				enemy_sets.box_outline_color[3] = color.c
				enemy_sets.box_outline_color[4] = color.a
				cheat.EspLibrary.icaca()
			end})
			outline_toggle.State(false)
		end

		do
			local toggle = espsec:Toggle({Name = "Health bar", Value = false, Flag = "esp_health_bar", Callback = function(bool)
				enemy_sets.health_bar = bool
				cheat.EspLibrary.icaca()
			end})
			toggle:Colorpicker({Name = "Bar color top", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "esp_health_bar_color_top", Callback = function(color)
				enemy_sets.health_bar_color[1] = color.c
				cheat.EspLibrary.icaca()
			end})
			toggle:Colorpicker({Name = "Bar color bottom", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "esp_health_bar_color_bottom", Callback = function(color)
				enemy_sets.health_bar_color[2] = color.c
				cheat.EspLibrary.icaca()
			end})
		end

		for _, element in {
			{"Name", "name"},
			{"Distance", "distance"},
			{"Weapon", "weapon"},
			{"Health text", "health_text"},
			{"Flags", "flags"},
			} do
			espsec:Toggle({Name = element[1], Value = false, Flag = `esp_{element[2]}`, Callback = function(bool)
				enemy_sets[element[2]] = bool
				cheat.EspLibrary.icaca()
			end}):Colorpicker({Name = `{element[1]} color`, Value = Color3.new(1, 1, 1), Usealpha = true, Flag = `esp_{element[2]}_color`, Callback = function(color)
				enemy_sets[`{element[2]}_color`] = {color.c, color.a}
				cheat.EspLibrary.icaca()
			end})
		end

		local skeleton_rate_slider = nil
		espsec:Toggle({Name = "Skeleton", Value = false, Flag = "esp_skeleton", Callback = function(bool)
			enemy_sets.skeleton = bool
			if skeleton_rate_slider then skeleton_rate_slider.State(bool) end
			cheat.EspLibrary.icaca()
		end}):Colorpicker({Name = "Skeleton color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "esp_skeleton_color", Callback = function(color)
			enemy_sets.skeleton_color = {color.c, color.a}
			cheat.EspLibrary.icaca()
		end})
		skeleton_rate_slider = espsec:Slider({Name = "Skeleton update rate", Min = 0, Max = 1, Float = 0.01, Value = 0, Flag = "esp_skeleton_rate", Callback = function(int)
			enemy_main_sets.skeleton_rate = int
			cheat.EspLibrary.icaca()
		end})
		skeleton_rate_slider.State(false)

		local chams_visible_toggle = nil
		local chams_glow_slider = nil
		local toggle = espsec:Toggle({Name = "Chams", Value = false, Flag = "esp_chams", Callback = function(bool)
			enemy_sets.chams = bool
			if chams_visible_toggle then chams_visible_toggle.State(bool) end
			if chams_glow_slider then chams_glow_slider.State(bool) end
			cheat.EspLibrary.icaca()
		end})
		toggle:Colorpicker({Name = "Chams color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "esp_chams_color", Callback = function(color)
			enemy_sets.chams_color = {color.c, color.a}
			cheat.EspLibrary.icaca()
		end})
		chams_visible_toggle = espsec:Toggle({Name = "Visible only", Value = false, Flag = "esp_chams_visible_only", Callback = function(bool)
			enemy_sets.chams_visible_only = bool
			cheat.EspLibrary.icaca()
		end})
		chams_visible_toggle.State(false)
		chams_glow_slider = espsec:Slider({Name = "Chams glow factor", Min = 0, Max = 100, Float = 0.1, Value = 3, Flag = "esp_chams_glow_factor", Callback = function(int)
			enemy_sets.chams_glow_factor = int
			cheat.EspLibrary.icaca()
		end})
		chams_glow_slider.State(false)
	end
	do
		local player_list = cheat.player_list
		local report_list = cheat.report_list
		local flag_settings = {
			["Target"] = false,
			["Team"] = false,
			["Friend"] = false,
			["Visor"] = false,
			["Desynced"] = false,
			["Visible"] = false,
			["NPC"] = false,
			["KD"] = false,
			["Suspiciousness"] = false
		}
		setsec:Dropdown({Name = "Flags", Values = {"Target", "Team", "Friend", "Visor", "Desynced", "Visible", "NPC", "KD", "Suspiciousness"}, Value = {}, Flag = "esp_selected_flags", Multi = true, Callback = function(tbl)
			for flag, value in flag_settings do
				flag_settings[flag] = false
			end
			for _, flag in tbl do
				flag_settings[flag] = true
			end
		end})

		local get_team = cheat.EspLibrary.get_team
		cheat.EspLibrary.register_flag("TARGET", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["Target"] and player == target_player
		end))
		cheat.EspLibrary.register_flag("TEAM", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["Team"] and get_team(player)
		end))
		cheat.EspLibrary.register_flag("FRIEND", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]
			return flag_settings["Friend"] and tp and tp.friend
		end))
		cheat.EspLibrary.register_flag("VISOR", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]
			return flag_settings["Visor"] and tp and tp.visor
		end))
		cheat.EspLibrary.register_flag("DSYNC", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]
			local server_position = tp and tp.server_position
			local hrp = _FindFirstChild(character, "HumanoidRootPart")
			return flag_settings["Desynced"] and server_position and hrp and (server_position - hrp.CFrame.Position).Magnitude > 3
		end))
		cheat.EspLibrary.register_flag("VIS", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]
			return flag_settings["Visible"] and tp and tp.visible
		end))
		cheat.EspLibrary.register_flag("NPC", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			return flag_settings["NPC"] and player == character
		end))
		cheat.EspLibrary.register_flag("... KD", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			local tp = player_list[player]
			if not (flag_settings["KD"] and tp) then
				return false
			end
			local status = _FindFirstChild(tp.game_data, "Status")
			local journey = status and _FindFirstChild(status, "Journey")
			local stats = journey and _FindFirstChild(journey, "Statistics")
			if not stats then
				return true, ("??? KD (%* %* %* %*)"):format(tp.game_data, status, journey, stats)
			end
			local kills = stats:GetAttribute("Kills")
			local deaths = stats:GetAttribute("Deaths")
			if not (kills and deaths) then
				return true, ("? KD (%* %*)"):format(kills, deaths)
			end

			deaths = deaths and (deaths == 0 and 1 or deaths) or 1
			return true, ("%.1f KD"):format(kills/deaths)
		end))

		cheat.EspLibrary.register_flag("SUSSY", LPH_NO_VIRTUALIZE(function(player, character, humanoid)
			if not flag_settings["Suspiciousness"] then
				return false
			end


			local player_object = player_list[player]
			if not player_object then
				return false
			end

			local report_object = report_list[player.Name]

			local text = ""

			if report_object then
				if report_object.mw > 0 then
					text ..= "!! CHEATER !!"
				end
				if report_object.rr > 0 then
					text ..= ("%*RR: %*"):format(text ~= "" and " " or "", report_object.rr)
				end
			end

			if player_object.reports then
				local reports = player_object.reports
				text ..= ("%*%*"):format(text ~= "" and " " or "", `:: {reports}`)
			end

			return true, text
		end))
	end
	do
		setsec:Dropdown({Name = "Checks", Values = {"Team check", "Dead check", "Distance check", "NPC check", "Visible check"}, Value = {}, Flag = "esp_checks", Multi = true, Callback = function(tbl)
			local funny = {
				["Team check"] = "team_check",
				["Dead check"] = "dead_check",
				["Distance check"] = "dist_check",
				["NPC check"] = "npc_check",
				["Visible check"] = "visible_check"
			}
			for flag_text, esp_var in funny do
				enemy_main_sets[esp_var] = false
			end
			for flag_text, esp_var in funny do
				for _, check_name in tbl do
					if (check_name ~= flag_text or enemy_main_sets[esp_var]) then
						continue
					end
					enemy_main_sets[esp_var] = true

				end
			end
			cheat.EspLibrary.icaca()
		end})
		setsec:Slider({Name = "Max distance", Min = 0, Max = 2000, Float = 10, Value = 200, Flag = "esp_max_distance", Callback = function(int)
			enemy_main_sets.max_distance = int * 3
			cheat.EspLibrary.icaca()
		end})
		setsec:Toggle({Name = "Gradient spin", Value = false, Flag = "esp_gradient_spin", Callback = function(bool)
			enemy_main_sets.gradient_spin = bool
			cheat.EspLibrary.icaca()
		end})
		setsec:Slider({Name = "Gradient speed", Min = -20, Max = 20, Float = 0.1, Value = 0, Flag = "esp_gradient_speed", Callback = function(int)
			enemy_main_sets.gradient_speed = int * 18
			cheat.EspLibrary.icaca()
		end})
		setsec:Toggle({Name = "Holder spin", Value = false, Flag = "esp_holder_spin", Callback = function(bool)
			enemy_main_sets.holder_spin = bool
			cheat.EspLibrary.icaca()
		end})
		setsec:Slider({Name = "Holder speed", Min = -20, Max = 20, Float = 0.1, Value = 0, Flag = "esp_holder_speed", Callback = function(int)
			enemy_main_sets.holder_speed = int * 18
			cheat.EspLibrary.icaca()
		end})
	end
	do
		local item_maxdist_slider = nil
		local item_toggle = itmsec:Toggle({Name = "Item esp", Value = false, Flag = "esp_item", Callback = function(bool)
			item_sets.enabled = bool
			if item_maxdist_slider then item_maxdist_slider.State(bool) end
			cheat.EspLibrary.icaca()
		end})
		item_toggle:Colorpicker({Name = "Item color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "esp_item_color", Callback = function(color)
			item_sets.text_color = {color.c, color.a}
			cheat.EspLibrary.icaca()
		end})
		itmsec:Toggle({Name = "Show distance", Value = false, Flag = "esp_item_distance", Callback = function(bool)
			item_sets.distance = bool
			cheat.EspLibrary.icaca()
		end})
		itmsec:Toggle({Name = "Show amount", Value = false, Flag = "esp_item_amount", Callback = function(bool)
			item_sets.amount = bool
			cheat.EspLibrary.icaca()
		end})
		itmsec:Toggle({Name = "Show durability", Value = false, Flag = "esp_item_durability", Callback = function(bool)
			item_sets.durability = bool
			cheat.EspLibrary.icaca()
		end})
		itmsec:Toggle({Name = "Show durability bar", Value = false, Flag = "esp_item_durability_bar", Callback = function(bool)
			item_sets.durability_bar = bool
			cheat.EspLibrary.icaca()
		end})
		item_maxdist_slider = itmsec:Slider({Name = "Max distance (0 = inf)", Min = 0, Max = 200, Float = 1, Value = 10, Flag = "esp_item_max_distance", Callback = function(int)
			item_main_sets.dist_check = int > 0
			item_main_sets.max_distance = int * 3
			cheat.EspLibrary.icaca()
		end})
		item_maxdist_slider.State(false)
	end
	do
		local corpse_maxdist_slider = nil
		local corpse_toggle = othsec:Toggle({Name = "Corpse esp", Value = false, Flag = "esp_corpse", Callback = function(bool)
			corpse_sets.enabled = bool
			if corpse_maxdist_slider then corpse_maxdist_slider.State(bool) end
			cheat.EspLibrary.icaca()
		end})
		corpse_toggle:Colorpicker({Name = "Corpse color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "esp_corpse_color", Callback = function(color)
			corpse_sets.text_color = {color.c, color.a}
			cheat.EspLibrary.icaca()
		end})
		othsec:Toggle({Name = "Show distance", Value = false, Flag = "esp_corpse_distance", Callback = function(bool)
			corpse_sets.distance = bool
			cheat.EspLibrary.icaca()
		end})
		corpse_maxdist_slider = othsec:Slider({Name = "Max distance (0 = inf)", Min = 0, Max = 1000, Float = 10, Value = 100, Flag = "esp_corpse_max_distance", Callback = function(int)
			corpse_main_sets.dist_check = int > 0
			corpse_main_sets.max_distance = int * 3
			cheat.EspLibrary.icaca()
		end})
		corpse_maxdist_slider.State(false)
	end
	do
		cheat.vehicle_esp = false
		cheat.vehicle_color = Color3.fromRGB(95, 25, 21)
		cheat.vehicle_size = 11
		cheat.vehicle_icon = 44
		cheat.vehicle_maxdist = 0
		local function vehicle_anchor(obj)
			if obj:IsA("BasePart") then
				return obj
			end
			if obj:IsA("Model") then
				local p = obj.PrimaryPart or _FindFirstChild(obj, "HumanoidRootPart") or _FindFirstChild(obj, "Head") or obj:FindFirstChildWhichIsA("BasePart", true)
				if p then return p end
			end
			return obj:FindFirstChildWhichIsA("BasePart", true)
		end
		local function vehicle_build(vehicle)
			local anchor = vehicle_anchor(vehicle)
			if not anchor then return end
			if vehicle:FindFirstChild("VehicleESP") then return end
			local gui = Instance.new("BillboardGui")
			gui.Name = "VehicleESP"
			gui.Adornee = anchor
			gui.AlwaysOnTop = true
			gui.StudsOffset = Vector3.new(0, 2.25, 0)
			gui.Parent = vehicle
			local icon = Instance.new("ImageLabel")
			icon.Name = "Icon"
			icon.AnchorPoint = Vector2.new(0.5, 0)
			icon.BackgroundTransparency = 1
			icon.Image = "rbxassetid://72334306153050"
			icon.Position = UDim2.new(0.5, 0, 0, 0)
			icon.ScaleType = Enum.ScaleType.Fit
			icon.Parent = gui
			local text = Instance.new("TextLabel")
			text.Name = "Text"
			text.BackgroundTransparency = 1
			text.Font = Enum.Font.SourceSansBold
			text.Text = "0m"
			text.TextColor3 = cheat.vehicle_color
			text.TextStrokeTransparency = 0
			text.TextStrokeColor3 = Color3.new(0, 0, 0)
			text.Parent = gui
			vehicle_size_apply(gui, text, icon)
		end
		function vehicle_size_apply(gui, text, icon)
			local isize = math.clamp(cheat.vehicle_icon, 16, 120)
			gui.Size = UDim2.new(0, math.max(96, isize + 52), 0, (isize + 2) + math.max(18, cheat.vehicle_size + 10) + 4)
			icon.Size = UDim2.fromOffset(isize, isize)
			text.Position = UDim2.new(0, 0, 0, isize + 2)
			text.Size = UDim2.new(1, 0, 0, math.max(18, cheat.vehicle_size + 10))
			text.TextSize = cheat.vehicle_size
		end
		local vehicle_text_slider, vehicle_icon_slider, vehicle_maxdist_slider = nil, nil, nil
		local vehicle_toggle = othsec:Toggle({Name = "Vehicle esp", Value = false, Flag = "esp_vehicles", Callback = function(bool)
			cheat.vehicle_esp = bool
			local vis = bool and true or false
			if vehicle_text_slider then vehicle_text_slider.State(vis) end
			if vehicle_icon_slider then vehicle_icon_slider.State(vis) end
			if vehicle_maxdist_slider then vehicle_maxdist_slider.State(vis) end
			if not bool then
				local folder = workspace:FindFirstChild("Vehicles")
				if folder then
					for _, v in folder:GetChildren() do
						local g = v:FindFirstChild("VehicleESP")
						if g then
							pcall(function() g:Destroy() end)
						end
					end
				end
			end
		end})
		vehicle_toggle:Colorpicker({Name = "Vehicles color", Value = Color3.fromRGB(95, 25, 21), Usealpha = false, Flag = "esp_vehicles_color", Callback = function(color)
			cheat.vehicle_color = color.c
		end})
		vehicle_text_slider = othsec:Slider({Name = "Vehicle text size", Min = 1, Max = 20, Float = 1, Value = 11, Flag = "esp_vehicles_size", Callback = function(int)
			cheat.vehicle_size = int
		end})
		vehicle_text_slider.State(false)
		vehicle_icon_slider = othsec:Slider({Name = "Vehicle icon size", Min = 16, Max = 120, Float = 1, Value = 44, Flag = "esp_vehicles_icon", Callback = function(int)
			cheat.vehicle_icon = int
		end})
		vehicle_icon_slider.State(false)
		vehicle_maxdist_slider = othsec:Slider({Name = "Max distance (0 = inf)", Min = 0, Max = 3000, Float = 10, Value = 0, Flag = "esp_vehicles_max_distance", Callback = function(int)
			cheat.vehicle_maxdist = int
		end})
		vehicle_maxdist_slider.State(false)
		local vehicle_tick = 0
		cheat.utility.new_renderstepped(function()
			if not cheat.vehicle_esp then return end
			local now = os.clock()
			if now - vehicle_tick < 0.25 then return end
			vehicle_tick = now
			local char = LocalPlayer.Character
			local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
			if not hrp then return end
			local folder = workspace:FindFirstChild("Vehicles")
			if not folder then return end
			for _, vehicle in folder:GetChildren() do
				local gui = vehicle:FindFirstChild("VehicleESP")
				if not gui then
					vehicle_build(vehicle)
					gui = vehicle:FindFirstChild("VehicleESP")
				end
				if gui then
					local text = gui:FindFirstChild("Text")
					local icon = gui:FindFirstChild("Icon")
					local anchor = vehicle_anchor(vehicle)
					if text and anchor then
						local dist = math.floor((hrp.Position - anchor.Position).Magnitude / 3)
						if cheat.vehicle_maxdist > 0 and dist > cheat.vehicle_maxdist then
							gui.Enabled = false
						else
							gui.Enabled = true
							text.Text = tostring(dist) .. "m"
							text.TextColor3 = cheat.vehicle_color
							vehicle_size_apply(gui, text, icon)
						end
					end
				end
			end
		end)
	end

	local no_screen_effects, viewmodel_changer, gun_changer, arm_changer = false, false, false, false
	local gun_color, gun_material, arm_color, arm_material = Color3.new(1, 1, 1), Enum.Material.ForceField, Color3.new(1, 1, 1), Enum.Material.ForceField
	local viewmodel_x, viewmodel_y, viewmodel_z = 0, 0, 0
	local leftarm_old, rightarm_old, itemroot_old, motor6d_old

	local function vmpos(vm)
		if not viewmodel_changer then return end
		local hrp = _FindFirstChild(vm, "HumanoidRootPart")
		local vec = _Vector3new(viewmodel_x, thirdperson_key and -100 or viewmodel_y, thirdperson_key and 100 or viewmodel_z)
		local leftarm_weld = hrp and _FindFirstChild(hrp, "LeftUpperArm")
		local rightarm_weld = hrp and _FindFirstChild(hrp, "RightUpperArm")
		local itemroot_weld = hrp and _FindFirstChild(hrp, "ItemRoot")
		local motor6d_weld = hrp and _FindFirstChild(hrp, "Motor6D")
		if leftarm_weld then
			if not leftarm_old then leftarm_old = leftarm_weld.C0 end
			leftarm_weld.C0 = leftarm_old + vec
		end
		if rightarm_weld then
			if not rightarm_old then rightarm_old = rightarm_weld.C0 end
			rightarm_weld.C0 = rightarm_old + vec
		end
		if itemroot_weld then
			if not itemroot_old then itemroot_old = itemroot_weld.C0 end
			itemroot_weld.C0 = itemroot_old + vec
		end
		if motor6d_weld then
			if not motor6d_old then motor6d_old = motor6d_weld.C0 end
			motor6d_weld.C0 = motor6d_old + vec
		end
	end
	local function vmunpos()
		if not viewmodel_changer then return end
		leftarm_old, rightarm_old, motor6d_old = nil, nil, nil
	end
	local vmchams = LPH_NO_VIRTUALIZE(function()
		local vm = _FindFirstChildOfClass(Camera, "Model")
		if not vm then return end
		local viewmodel_item = _FindFirstChild(vm, "Item")
		if gun_changer and viewmodel_item then
			for _, v in viewmodel_item:GetDescendants() do
				local surfaceappearance = _FindFirstChildOfClass(v, "SurfaceAppearance")
				if _IsA(v, "BasePart") then
					v.Material = gun_material
					v.Color = gun_color
				end
				if surfaceappearance then
					surfaceappearance:Destroy()
				end
			end
		end
		if arm_changer then
			for _, vm_item in vm:GetChildren() do
				if _IsA(vm_item, "BasePart") then
					if vm_item.Name:find("Hand") or vm_item.Name:find("Arm") then
						vm_item.Material = arm_material
						vm_item.Color = arm_color
					end
				end
				if vm_item.ClassName == "Model" and (_FindFirstChild(vm_item, "LL") or _FindFirstChild(vm_item, "LH")) then
					for _, shirt_item in (vm_item:GetChildren()) do
						local surfaceappearance = _FindFirstChildOfClass(shirt_item, "SurfaceAppearance")
						shirt_item.Material = arm_material
						shirt_item.Color = arm_color
						if surfaceappearance then
							surfaceappearance:Destroy()
						end
					end
				end
			end
		end
	end)

	do
		local old_fov = Camera.FieldOfView
		mscsec:Toggle({Name = "FOV changer", Value = false, Flag = "view_fov_changer", Callback = function(bool)
			fov_changer = bool
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		mscsec:Slider({Name = "Desired fov", Min = 50, Max = 120, Float = 1, Value = 100, Flag = "view_fov_changer_size", Callback = function(int)
			fov_changer_size = int
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		local zoom_size_slider = nil
		local zoom_toggle = mscsec:Toggle({Name = "Zoom", Value = false, Flag = "view_zoom", Callback = function(bool)
			zoom = bool
			if zoom_size_slider then zoom_size_slider.State(bool) end
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		local zoom_keybind; zoom_keybind = zoom_toggle:Keybind({Name = "Zoom", Mode = "Toggle", Key = Enum.KeyCode.Z, Value = false, Flag = "view_zoom_keybind", Link = "view_zoom", Callback = function(bool)
			zoom_key = zoom and bool
			zoom_keybind.Set(zoom_key, true)
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		zoom_size_slider = mscsec:Slider({Name = "Desired zoom", Min = 1, Max = 50, Float = 1, Value = 20, Flag = "view_zoom_size", Callback = function(int)
			zoom_size = int
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size) or old_fov
		end})
		zoom_size_slider.State(false)

		do
			local freecam, freecam_speed = false, 750
			local freecam_key = false
			local freecam_speed_slider = nil
			local fc_toggle = mscsec:Toggle({Name = "Freecam", Value = false, Flag = "view_freecam", Callback = function(bool)
				freecam = bool
				if freecam_speed_slider then freecam_speed_slider.State(bool) end
			end})
			local fc_keybind; fc_keybind = fc_toggle:Keybind({Name = "Freecam", Mode = "Toggle", Key = Enum.KeyCode.L, Value = false, Flag = "view_freecam_keybind", Link = "view_freecam", Callback = function(bool)
				freecam_key = freecam and bool
				fc_keybind.Set(freecam_key, true)
			end})
			freecam_speed_slider = mscsec:Slider({Name = "Freecam speed", Min = 100, Max = 1000, Float = 10, Value = 750, Flag = "view_freecam_speed", Callback = function(int)
				freecam_speed = int
			end})
			freecam_speed_slider.State(false)

			local new_camera_pos

	task.spawn(function()
		while task.wait(1/5) do
					local closest, distance = nil, math.huge
					if (freecam and freecam_key and new_camera_pos) then
						LPH_NO_VIRTUALIZE(function()
							for i, model in workspace:GetDescendants() do
								if not _IsA(model, "Model") then continue end
								local primarypart = model.PrimaryPart
								if not primarypart then continue end
								local pos = primarypart.Position
								local ts_dist = (new_camera_pos - pos).Magnitude
								if ts_dist < distance then
									closest, distance = primarypart, ts_dist
								end
							end
						end)()
					end
					LocalPlayer.ReplicationFocus = closest
				end
			end)

			game:GetService("RunService").PreRender:Connect(LPH_NO_VIRTUALIZE(function(delta)
				local character = LocalPlayer.Character
				local hrp = character and _FindFirstChild(character, "HumanoidRootPart")

				if not (freecam and freecam_key) then
					new_camera_pos = nil
					if hrp then
						hrp.Anchored = false
					end
					return
				end
				if not new_camera_pos then
					new_camera_pos = Camera.CFrame.Position
				end

				local cameralook = Camera.CFrame.LookVector
				local direction = _Vector3new(0, 0, 0)
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.W)         and direction + cameralook or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.S)         and direction - cameralook or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.D)         and direction + _Vector3new(-cameralook.Z, 0, cameralook.X) or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.A)         and direction + _Vector3new(cameralook.Z, 0, -cameralook.X) or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.Space)     and direction + Vector3.yAxis or direction;
				direction = _IsKeyDown(UserInputService, Enum.KeyCode.LeftControl) and direction - Vector3.yAxis or direction;

				if direction.Magnitude > 0 then direction = direction.Unit end
				new_camera_pos += direction * delta * (_IsKeyDown(UserInputService, Enum.KeyCode.LeftShift) and freecam_speed / 10 or freecam_speed)
				Camera.CFrame = CFrame.new(new_camera_pos) * Camera.CFrame.Rotation
				if hrp then
					hrp.Anchored = true
				end
			end))
		end

		local tp_dist_slider = nil
		local tp_toggle = mscsec:Toggle({Name = "Thirdperson", Value = false, Flag = "view_thirdperson", Callback = function(bool)
			thirdperson = bool
			if tp_dist_slider then tp_dist_slider.State(bool) end
		end})
		local tp_keybind; tp_keybind = tp_toggle:Keybind({Name = "Thirdperson", Mode = "Toggle", Key = Enum.KeyCode.N, Value = false, Flag = "view_thirdperson_keybind", Link = "view_thirdperson", Callback = function(bool)
			thirdperson_key = thirdperson and bool
			tp_keybind.Set(thirdperson_key, true)

			local viewmodel = _FindFirstChildOfClass(Camera, "Model")
			if viewmodel then
				vmpos(viewmodel)
			end
		end})
		tp_dist_slider = mscsec:Slider({Name = "Thirdperson distance", Min = 0, Max = 15, Float = 0.1, Value = 5, Flag = "view_thirdperson_distance", Callback = function(int)
			thirdperson_distance = int
		end})
		tp_dist_slider.State(false)

		cheat.custom_skybox = false
		cheat.skybox_preset = "Purple Nebula"
		cheat.skybox_brightness = 100
		cheat.skybox_rotx = 0
		cheat.skybox_rotz = 0
		local skybox_presets = {
			["Purple Nebula"] = {"rbxassetid://159454299", "rbxassetid://159454296", "rbxassetid://159454293", "rbxassetid://159454286", "rbxassetid://159454300", "rbxassetid://159454288"},
			["Vaporwave"] = {"rbxassetid://600832720", "rbxassetid://600833821", "rbxassetid://600835177", "rbxassetid://600833341", "rbxassetid://600834603", "rbxassetid://600835727"},
			["Deep Space"] = {"rbxassetid://265805434", "rbxassetid://265805423", "rbxassetid://265805445", "rbxassetid://265805466", "rbxassetid://265805481", "rbxassetid://265805502"},
			["Night Sky"] = {"rbxassetid://12064107", "rbxassetid://12064152", "rbxassetid://12064121", "rbxassetid://12064131", "rbxassetid://12064115", "rbxassetid://12064143"},
			["Sunset"] = {"rbxassetid://924373456", "rbxassetid://924373468", "rbxassetid://924373479", "rbxassetid://924373497", "rbxassetid://924373508", "rbxassetid://924373523"},
			["Blood Moon"] = {"rbxassetid://401664839", "rbxassetid://401664861", "rbxassetid://401664883", "rbxassetid://401664901", "rbxassetid://401664916", "rbxassetid://401664936"},
			["Purple Planet"] = {"rbxassetid://16262356578", "rbxassetid://16262358026", "rbxassetid://16262360469", "rbxassetid://16262362003", "rbxassetid://16262363873", "rbxassetid://16262366016"}
		}
		local sky_obj, sky_lat, sky_hidden_clouds = nil, nil, {}
		local function sky_clouds(off)
			if not off then
				for c, _ in sky_hidden_clouds do
					pcall(function()
						c.Enabled = true
					end)
				end
				table.clear(sky_hidden_clouds)
				return
			end
			local t = workspace.Terrain:FindFirstChildOfClass("Clouds")
			if t then
				sky_hidden_clouds[t] = true
				t.Enabled = false
			end
			for _, c in game:GetService("Lighting"):GetChildren() do
				if c:IsA("Clouds") then
					sky_hidden_clouds[c] = true
					c.Enabled = false
				end
			end
		end
		local function sky_apply()
			local lighting = game:GetService("Lighting")
			if not cheat.custom_skybox then
				if sky_obj then
					pcall(function() sky_obj:Destroy() end)
					sky_obj = nil
				end
				if sky_lat then
					lighting.GeographicLatitude = sky_lat
					sky_lat = nil
				end
				sky_clouds(false)
				return
			end
			if not sky_obj or sky_obj.Parent ~= lighting then
				sky_obj = Instance.new("Sky")
				sky_obj.Parent = lighting
			end
			for _, c in lighting:GetChildren() do
				if c:IsA("Sky") and c ~= sky_obj then
					pcall(function() c:Destroy() end)
				end
			end
			local preset = skybox_presets[cheat.skybox_preset]
			if preset then
				local q = math.floor(((cheat.skybox_rotz % 360) + 45) / 90) % 4
				local bk, ft, lf, rt = preset[1], preset[3], preset[4], preset[5]
				if q == 1 then
					bk, ft, lf, rt = preset[4], preset[5], preset[3], preset[1]
				elseif q == 2 then
					bk, ft, lf, rt = preset[3], preset[1], preset[5], preset[4]
				elseif q == 3 then
					bk, ft, lf, rt = preset[5], preset[4], preset[1], preset[3]
				end
				sky_obj.SkyboxBk = bk
				sky_obj.SkyboxFt = ft
				sky_obj.SkyboxLf = lf
				sky_obj.SkyboxRt = rt
				sky_obj.SkyboxDn = preset[2]
				sky_obj.SkyboxUp = preset[6]
			end
			if sky_lat == nil then
				sky_lat = lighting.GeographicLatitude
			end
			lighting.GeographicLatitude = math.clamp(cheat.skybox_rotx, -90, 90)
			for _, c in lighting:GetChildren() do
				if c:IsA("Atmosphere") then
					if cheat.skybox_brightness == 100 then
						c.Density = 0
						c.Haze = 0
						c.Glare = 0
						c.Offset = 0
					elseif cheat.skybox_brightness > 100 then
						local v = (cheat.skybox_brightness - 100) / 100
						c.Density = 0.001
						c.Haze = v * 1.5
						c.Glare = v * 3
						c.Offset = v * 0.2
						c.Color = Color3.fromRGB(255, 255, 255)
					else
						c.Density = 0.001
						c.Haze = 0
						c.Glare = 0
						c.Offset = 0
						local g = math.floor(255 * (1 - cheat.skybox_brightness / 100))
						c.Color = Color3.fromRGB(g, g, g)
					end
				end
			end
			sky_clouds(true)
		end
		local sky_preset_dropdown, sky_bright_slider, sky_rotx_slider, sky_rotz_slider = nil, nil, nil, nil
		local sky_toggle = mscsec:Toggle({Name = "Custom skybox", Value = false, Flag = "view_custom_skybox", Callback = function(bool)
			cheat.custom_skybox = bool
			local vis = bool and true or false
			if sky_preset_dropdown then sky_preset_dropdown.State(vis) end
			if sky_bright_slider then sky_bright_slider.State(vis) end
			if sky_rotx_slider then sky_rotx_slider.State(vis) end
			if sky_rotz_slider then sky_rotz_slider.State(vis) end
			sky_apply()
		end})
		sky_preset_dropdown = mscsec:Dropdown({Name = "Skybox preset", Values = {"Purple Nebula", "Vaporwave", "Deep Space", "Night Sky", "Sunset", "Blood Moon", "Purple Planet"}, Value = "Purple Nebula", Flag = "view_skybox_preset", Multi = false, Callback = function(str)
			cheat.skybox_preset = str
			sky_apply()
		end})
		sky_preset_dropdown.State(false)
		sky_bright_slider = mscsec:Slider({Name = "Skybox brightness", Min = 10, Max = 1000, Float = 1, Value = 100, Flag = "view_skybox_brightness", Suffix = "%s%%", Callback = function(int)
			cheat.skybox_brightness = int
			sky_apply()
		end})
		sky_bright_slider.State(false)
		sky_rotx_slider = mscsec:Slider({Name = "Skybox rotation X", Min = -90, Max = 90, Float = 1, Value = 0, Flag = "view_skybox_rotx", Callback = function(int)
			cheat.skybox_rotx = int
			sky_apply()
		end})
		sky_rotx_slider.State(false)
		sky_rotz_slider = mscsec:Slider({Name = "Skybox rotation Z", Min = 0, Max = 360, Float = 1, Value = 0, Flag = "view_skybox_rotz", Callback = function(int)
			cheat.skybox_rotz = int
			sky_apply()
		end})
		sky_rotz_slider.State(false)
		game:GetService("Lighting").ChildAdded:Connect(function(child)
			if cheat.custom_skybox and (child:IsA("Atmosphere") or child:IsA("Clouds")) then
				sky_apply()
			end
		end)
		cheat.no_leafs = false
		local function sweep_leafs()
			local sz = workspace:FindFirstChild("SpawnerZones")
			local fol = sz and sz:FindFirstChild("Foliage")
			if not fol then return end
			local stack = {fol}
			local n = 0
			while #stack > 0 do
				local node = table.remove(stack)
				for _, child in node:GetChildren() do
					table.insert(stack, child)
					if child:FindFirstChildOfClass("SurfaceAppearance") then
						child.Transparency = cheat.no_leafs and 1 or 0
					end
				end
				n += 1
				if n % 150 == 0 then
					task.wait()
				end
			end
		end
		mscsec:Toggle({Name = "No leafs", Value = false, Flag = "view_no_leafs", Callback = function(bool)
			cheat.no_leafs = bool
			sweep_leafs()
			if bool then
				task.spawn(function()
					while task.wait(10) do
						if not cheat.no_leafs then return end
						sweep_leafs()
					end
				end)
			end
		end})

		mscsec:Toggle({Name = "Aspect ratio", Value = false, Flag = "view_aspect_ratio", Callback = function(bool)
			aspect_ratio = bool
		end})
		mscsec:Slider({Name = "Aspect X", Min = 0.5, Max = 1.1, Float = 0.01, Value = 1, Flag = "aspect_ratio_x", Callback = function(int)
			aspect_ratio_x = int
		end})
		mscsec:Slider({Name = "Aspect Y", Min = 0.5, Max = 1.1, Float = 0.01, Value = 1, Flag = "aspect_ratio_y", Callback = function(int)
			aspect_ratio_y = int
		end})

		cheat.raid_info = false
		mscsec:Toggle({Name = "Raid info", Value = false, Flag = "raid_info", Callback = function(bool)
			cheat.raid_info = bool
		end})
		do
			local raid_tick = 0
			local price_cache = {}
			local raid_gui = Instance.new("ScreenGui")
			raid_gui.Name = "SwimRaidInfo"
			raid_gui.ResetOnSpawn = false
			raid_gui.IgnoreGuiInset = true
			raid_gui.DisplayOrder = -1
			raid_gui.Enabled = false
			raid_gui.Parent = game:GetService("CoreGui")
			local raid_outer = Instance.new("Frame")
			raid_outer.Name = "Panel"
			raid_outer.Size = UDim2.fromOffset(220, 132)
			raid_outer.Position = UDim2.new(0, 40, 0, 120)
			raid_outer.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
			raid_outer.BorderSizePixel = 0
			raid_outer.AnchorPoint = Vector2.new(0, 0)
			raid_outer.Active = true
			raid_outer.Parent = raid_gui
			do
				local drag, ox, oy, mx, my = false, 0, 0, 0, 0
				raid_outer.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						drag = true
						ox, oy = raid_outer.Position.X.Offset, raid_outer.Position.Y.Offset
						mx, my = input.Position.X, input.Position.Y
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if drag and input.UserInputType == Enum.UserInputType.MouseMovement then
						local vs = Camera.ViewportSize
						raid_outer.Position = UDim2.new(0, math.clamp(ox + input.Position.X - mx, 0, math.max(vs.X - raid_outer.AbsoluteSize.X, 0)), 0, math.clamp(oy + input.Position.Y - my, 0, math.max(vs.Y - raid_outer.AbsoluteSize.Y, 0)))
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
				end)
			end
			local raid_stroke = Instance.new("UIStroke")
			raid_stroke.Thickness = 1
			raid_stroke.Color = Library.Theme.accent
			raid_stroke.Parent = raid_outer
			local raid_title = Instance.new("TextLabel")
			raid_title.BackgroundTransparency = 1
			raid_title.BorderSizePixel = 0
			raid_title.Position = UDim2.new(0, 8, 0, 4)
			raid_title.Size = UDim2.new(1, -16, 0, 16)
			raid_title.FontFace = Fonts.Get("TahomaXP")
			raid_title.TextSize = 12
			raid_title.TextXAlignment = Enum.TextXAlignment.Left
			raid_title.TextColor3 = Library.Theme.accent
			raid_title.Text = "Raid info"
			raid_title.Parent = raid_outer
			local raid_rows = {}
			local raid_defs = {"Players", "Loot", "Top item", "K/D", "Reports", "HSR"}
			for i, name in raid_defs do
				local l = Instance.new("TextLabel")
				l.BackgroundTransparency = 1
				l.BorderSizePixel = 0
				l.Position = UDim2.new(0, 8, 0, 22 + (i - 1) * 16)
				l.Size = UDim2.new(0.5, -8, 0, 16)
				l.FontFace = Fonts.Get("TahomaXP")
				l.TextSize = 12
				l.TextXAlignment = Enum.TextXAlignment.Left
				l.TextColor3 = Color3.fromRGB(230, 230, 230)
				l.Text = name
				l.Parent = raid_outer
				local v = Instance.new("TextLabel")
				v.BackgroundTransparency = 1
				v.BorderSizePixel = 0
				v.Position = UDim2.new(0.5, 0, 0, 22 + (i - 1) * 16)
				v.Size = UDim2.new(0.5, -8, 0, 16)
				v.FontFace = Fonts.Get("TahomaXP")
				v.TextSize = 12
				v.TextXAlignment = Enum.TextXAlignment.Right
				v.TextColor3 = Color3.fromRGB(230, 230, 230)
				v.TextTruncate = Enum.TextTruncate.AtEnd
				v.Text = "-"
				v.Parent = raid_outer
				raid_rows[name] = v
			end
			local function item_base(name)
				return tostring(name):gsub("_unlocked$", ""):gsub("_T%d+$", "")
			end
			local function item_price(name)
				if price_cache[name] ~= nil then return price_cache[name] end
				local list = game:GetService("ReplicatedStorage"):FindFirstChild("ItemsList")
				local item = list and (list:FindFirstChild(name) or list:FindFirstChild(item_base(name)))
				local props = item and item:FindFirstChild("ItemProperties")
				local price = props and tonumber(props:GetAttribute("Price")) or 0
				if #price_cache < 2000 then price_cache[name] = price end
				return price
			end
			local function inventory_value(folder, depth)
				if not folder or depth > 6 then return 0, nil, 0 end
				local total, best_name, best_value = 0, nil, 0
				for _, obj in folder:GetChildren() do
					local amount = tonumber(obj:GetAttribute("Amount")) or 1
					local value = item_price(obj.Name) * math.max(1, math.floor(amount))
					total += value
					if value > best_value then
						best_value, best_name = value, obj.Name
					end
					local nested = obj:FindFirstChild("Inventory")
					local child_value, child_name, child_best = inventory_value(nested, depth + 1)
					total += child_value
					if child_best > best_value then
						best_value, best_name = child_best, child_name
					end
				end
				return total, best_name, best_value
			end
			cheat.utility.new_renderstepped(function()
				if not cheat.raid_info then
					raid_gui.Enabled = false
					return
				end
				raid_gui.Enabled = true
				local now = os.clock()
				if now - raid_tick < 1.5 then return end
				raid_tick = now
				local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
				local data = folder and folder:FindFirstChild(LocalPlayer.Name)
				local status = data and data:FindFirstChild("Status")
				local journey = status and status:FindFirstChild("Journey")
				local stats = journey and journey:FindFirstChild("Statistics")
				local gameplay = status and status:FindFirstChild("GameplayVariables")
				local kills = stats and (stats:GetAttribute("K_PVP") or stats:GetAttribute("Kills")) or 0
				local deaths = stats and (stats:GetAttribute("D_PVP") or stats:GetAttribute("Deaths")) or 0
				local kd = kills / math.max(1, deaths or 0)
				local reps = 0
				local uac = status and status:FindFirstChild("UAC")
				local repf = uac and uac:FindFirstChild("Reports")
				if repf then
					local amount = repf:GetAttribute("Amount")
					if typeof(amount) == "number" then
						reps = math.max(0, math.floor(amount))
					else
						for i = 0, 10 do
							local value = repf:GetAttribute(tostring(i))
							if typeof(value) == "number" then reps += value end
						end
					end
				end
				local hs, bs = 0, 0
				local combat = gameplay and gameplay:FindFirstChild("Combat")
				if combat then
					hs = combat:GetAttribute("Headshots") or 0
					bs = combat:GetAttribute("Bodyshots") or 0
				end
				local hsr = (hs + bs) > 0 and math.ceil(hs / (hs + bs) * 100) or 0
				local total_value, best_name, best_value = inventory_value(data and data:FindFirstChild("Inventory"), 0)
				local hotbar_value = inventory_value(data and data:FindFirstChild("Hotbar"), 0)
				total_value += hotbar_value
				raid_rows["Players"].Text = tostring(#Players:GetPlayers())
				raid_rows["Loot"].Text = tostring(total_value)
				raid_rows["Top item"].Text = (best_name or "-") .. " (" .. best_value .. ")"
				raid_rows["K/D"].Text = kills .. "/" .. deaths .. " (" .. ("%.1f"):format(kd) .. ")"
				raid_rows["Reports"].Text = tostring(reps)
				raid_rows["HSR"].Text = hsr .. "%"
			end)
		end
		local boss_toggle = mscsec:Toggle({Name = "Boss tracker", Value = false, Flag = "boss_tracker", Callback = function(bool)
			cheat.boss_tracker = bool
		end})
		cheat.boss_notify = false
		mscsec:Toggle({Name = "Boss spawn notify", Value = false, Flag = "boss_notify", Callback = function(bool)
			cheat.boss_notify = bool
		end})
		do
			local boss_defs = {
				Anton = Color3.fromRGB(255, 140, 50),
				Dozer = Color3.fromRGB(255, 112, 112),
				Whisper = Color3.fromRGB(180, 100, 255),
				ScavKing = Color3.fromRGB(255, 192, 50),
				Grif = Color3.fromRGB(90, 190, 255),
				BTR80 = Color3.fromRGB(100, 255, 150),
				MI24V = Color3.fromRGB(100, 255, 150),
				Death = Color3.fromRGB(220, 20, 60)
			}
			local boss_order = {"Anton", "Dozer", "Whisper", "ScavKing", "Grif", "BTR80", "MI24V", "Death"}
			local boss_gui = Instance.new("ScreenGui")
			boss_gui.Name = "SwimBossTracker"
			boss_gui.ResetOnSpawn = false
			boss_gui.IgnoreGuiInset = true
			boss_gui.DisplayOrder = -1
			boss_gui.Enabled = false
			boss_gui.Parent = game:GetService("CoreGui")
			local boss_outer = Instance.new("Frame")
			boss_outer.Name = "Panel"
			boss_outer.AnchorPoint = Vector2.new(0, 0)
			do
				local vs = Camera and Camera.ViewportSize or Vector2.new(1280, 720)
				boss_outer.Position = UDim2.new(0, math.max(vs.X - 270, 0), 0, 120)
			end
			boss_outer.Size = UDim2.fromOffset(230, 190)
			boss_outer.BackgroundColor3 = Color3.fromRGB(19, 19, 19)
			boss_outer.BorderSizePixel = 0
			boss_outer.Active = true
			boss_outer.Parent = boss_gui
			do
				local drag, ox, oy, mx, my = false, 0, 0, 0, 0
				boss_outer.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						drag = true
						ox, oy = boss_outer.Position.X.Offset, boss_outer.Position.Y.Offset
						mx, my = input.Position.X, input.Position.Y
					end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if drag and input.UserInputType == Enum.UserInputType.MouseMovement then
						local vs = Camera.ViewportSize
						boss_outer.Position = UDim2.new(0, math.clamp(ox + input.Position.X - mx, 0, math.max(vs.X - boss_outer.AbsoluteSize.X, 0)), 0, math.clamp(oy + input.Position.Y - my, 0, math.max(vs.Y - boss_outer.AbsoluteSize.Y, 0)))
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
				end)
			end
			local boss_stroke = Instance.new("UIStroke")
			boss_stroke.Thickness = 1
			boss_stroke.Color = Library.Theme.accent
			boss_stroke.Parent = boss_outer
			local boss_title = Instance.new("TextLabel")
			boss_title.BackgroundTransparency = 1
			boss_title.BorderSizePixel = 0
			boss_title.Position = UDim2.new(0, 8, 0, 4)
			boss_title.Size = UDim2.new(1, -16, 0, 16)
			boss_title.FontFace = Fonts.Get("TahomaXP")
			boss_title.TextSize = 12
			boss_title.TextXAlignment = Enum.TextXAlignment.Left
			boss_title.TextColor3 = Library.Theme.accent
			boss_title.Text = "Boss tracker"
			boss_title.Parent = boss_outer
			local boss_empty = Instance.new("TextLabel")
			boss_empty.BackgroundTransparency = 1
			boss_empty.BorderSizePixel = 0
			boss_empty.Position = UDim2.new(0, 8, 0, 22)
			boss_empty.Size = UDim2.new(1, -16, 0, 16)
			boss_empty.FontFace = Fonts.Get("TahomaXP")
			boss_empty.TextSize = 12
			boss_empty.TextXAlignment = Enum.TextXAlignment.Left
			boss_empty.TextColor3 = Color3.fromRGB(230, 230, 230)
			boss_empty.TextTruncate = Enum.TextTruncate.AtEnd
			boss_empty.Text = "no bosses alive"
			boss_empty.Visible = false
			boss_empty.Parent = boss_outer
			local boss_rows = {}
			for i, name in boss_order do
				local row = Instance.new("Frame")
				row.BackgroundTransparency = 1
				row.BorderSizePixel = 0
				row.Position = UDim2.new(0, 8, 0, 22 + (i - 1) * 20)
				row.Size = UDim2.new(1, -16, 0, 20)
				row.Visible = false
				row.Parent = boss_outer
				local pip = Instance.new("Frame")
				pip.AnchorPoint = Vector2.new(0, 0.5)
				pip.Position = UDim2.new(0, 0, 0.5, 0)
				pip.Size = UDim2.fromOffset(6, 6)
				pip.BorderSizePixel = 0
				pip.BackgroundColor3 = boss_defs[name]
				pip.Parent = row
				local n = Instance.new("TextLabel")
				n.BackgroundTransparency = 1
				n.BorderSizePixel = 0
				n.Position = UDim2.new(0, 10, 0, 0)
				n.Size = UDim2.new(0.45, -10, 1, 0)
				n.FontFace = Fonts.Get("TahomaXP")
				n.TextSize = 12
				n.TextXAlignment = Enum.TextXAlignment.Left
				n.TextColor3 = boss_defs[name]
				n.TextTruncate = Enum.TextTruncate.AtEnd
				n.Text = name
				n.Parent = row
				local info = Instance.new("TextLabel")
				info.BackgroundTransparency = 1
				info.BorderSizePixel = 0
				info.Position = UDim2.new(0.45, 0, 0, 0)
				info.Size = UDim2.new(0.55, 0, 1, 0)
				info.FontFace = Fonts.Get("TahomaXP")
				info.TextSize = 12
				info.TextXAlignment = Enum.TextXAlignment.Right
				info.TextColor3 = Color3.fromRGB(230, 230, 230)
				info.TextTruncate = Enum.TextTruncate.AtEnd
				info.Text = ""
				info.Parent = row
				local barbg = Instance.new("Frame")
				barbg.Position = UDim2.new(0, 10, 1, -4)
				barbg.Size = UDim2.new(1, -10, 0, 3)
				barbg.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
				barbg.BorderSizePixel = 0
				barbg.Parent = row
				local bar = Instance.new("Frame")
				bar.Size = UDim2.new(1, 0, 1, 0)
				bar.BackgroundColor3 = boss_defs[name]
				bar.BorderSizePixel = 0
				bar.Parent = barbg
				boss_rows[name] = {row = row, info = info, bar = bar}
			end
			local boss_seen = {}
			local boss_tick = 0
			local function boss_anchor(model)
				return _FindFirstChild(model, "HumanoidRootPart") or _FindFirstChild(model, "Head") or _FindFirstChild(model, "UpperTorso") or _FindFirstChild(model, "Chassis") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart", true)
			end
			cheat.utility.new_renderstepped(function()
				if not cheat.boss_tracker then
					boss_gui.Enabled = false
					return
				end
				boss_gui.Enabled = true
				local now = os.clock()
				if now - boss_tick < 0.5 then return end
				boss_tick = now
				local campos = Camera.CFrame.Position
				local found = {}
				local zones = workspace:FindFirstChild("AiZones")
				local function scan_boss_zone(zone, depth)
					if depth > 6 then return end
					for _, model in zone:GetChildren() do
							if model:IsA("Model") and boss_defs[model.Name] then
								local hum = _FindFirstChildOfClass(model, "Humanoid")
								local alive = false
								local hp, maxhp = 0, 0
								if hum then
									alive = hum.Health > 0
									hp, maxhp = math.floor(hum.Health), math.floor(hum.MaxHealth)
								else
									local root = boss_anchor(model)
									local h = root and root:GetAttribute("Health")
									if h then
										hp = math.floor(h)
										alive = hp ~= 0
									end
								end
								if alive then
									local anchor = boss_anchor(model)
									if anchor then
										found[model.Name] = true
										if not boss_seen[model.Name] then
											boss_seen[model.Name] = true
											if cheat.boss_notify then
												Library.Notification("BOSS SPAWNED: " .. model.Name .. " (" .. zone.Name .. ")", 5)
											end
										end
										local dist = math.floor((campos - anchor.Position).Magnitude / 3)
										local hps = maxhp > 0 and (" " .. math.floor(hp / maxhp * 100) .. "%") or (hp > 0 and (" " .. hp) or "")
										local brow = boss_rows[model.Name]
										if brow then
											brow.info.Text = (zone.Name or "?") .. "  " .. dist .. "m" .. hps
											brow.row.Visible = true
											local k = maxhp > 0 and math.clamp(hp / maxhp, 0, 1) or 1
											brow.bar.Size = UDim2.new(k, 0, 1, 0)
											brow.bar.BackgroundColor3 = k < 0.5 and Color3.fromRGB(225, 65, 65):Lerp(Color3.fromRGB(235, 200, 70), k / 0.5) or Color3.fromRGB(235, 200, 70):Lerp(Color3.fromRGB(75, 215, 95), (k - 0.5) / 0.5)
										end
									end
								end
							end
							if #model:GetChildren() > 0 then
								scan_boss_zone(model, depth + 1)
							end
						end
					end
				if zones then
					scan_boss_zone(zones, 0)
				end
				for _, name in boss_order do
					local brow = boss_rows[name]
					if brow and not found[name] then
						brow.row.Visible = false
					end
				end
				boss_empty.Visible = next(found) == nil
				for name, _ in boss_seen do
					if not found[name] then
						boss_seen[name] = nil
					end
				end
			end)
		end
		cheat.map_esp = false
		cheat.map_esp_names = false
		mscsec:Toggle({Name = "Map esp", Value = false, Flag = "map_esp", Callback = function(bool)
			cheat.map_esp = bool
		end})
		mscsec:Toggle({Name = "Map esp names", Value = false, Flag = "map_esp_names", Callback = function(bool)
			cheat.map_esp_names = bool
		end})
			do
			local map_marks = {}
			local map_names = {}
			local map_tick = 0
			local map_origin = Vector2.new(208, -203)
			local map_layer
			local function map_hide()
				for _, m in map_marks do
					m.Visible = false
				end
				for _, t in map_names do
					t.Visible = false
				end
			end
			local function map_layer_setup(mapf)
				if map_layer and map_layer.Parent == mapf then
					return true
				end
				map_layer = nil
				map_marks = {}
				map_names = {}
				local old = mapf:FindFirstChild("DeltaMapMarkers")
				if old then old:Destroy() end
				local layer = Instance.new("Frame")
				layer.Name = "DeltaMapMarkers"
				layer.BackgroundTransparency = 1
				layer.Size = UDim2.fromScale(1, 1)
				local markers = mapf:FindFirstChild("Markers")
				if markers and markers:IsA("GuiObject") then
					layer.Size = markers.Size
					layer.Position = markers.Position
					layer.AnchorPoint = markers.AnchorPoint
				end
				local z = 6
				for _, child in mapf:GetChildren() do
					if child:IsA("GuiObject") and child.Name ~= "DeltaMapMarkers" and child.ZIndex >= z then
						z = child.ZIndex + 1
					end
				end
				layer.ZIndex = z
				layer.Parent = mapf
				map_layer = layer
				return true
			end
			cheat.utility.new_renderstepped(function()
				if not cheat.map_esp then
					map_hide()
					return
				end
				local now = os.clock()
				if now - map_tick < 0.25 then return end
				map_tick = now
				local gui = LocalPlayer.PlayerGui
				local main = gui and _FindFirstChild(gui, "MainGui")
				main = main and _FindFirstChild(main, "MainFrame")
				local mapf = main and _FindFirstChild(main, "MapFrame")
				mapf = mapf and _FindFirstChild(mapf, "MainFrame")
				if not mapf or not mapf.Visible then
					map_hide()
					return
				end
				local maps = _FindFirstChild(mapf, "Maps")
				if not maps then
					map_hide()
					return
				end
				local frame = nil
				for _, f in maps:GetChildren() do
					if f:IsA("GuiObject") and f.Visible then
						frame = f
						break
					end
				end
				if not frame then
					local want = workspace:GetAttribute("MapName")
					if want then
						for _, f in maps:GetChildren() do
							if f:GetAttribute("MapName") == want then frame = f break end
						end
					end
				end
				if not frame then
					for _, f in maps:GetChildren() do
						if type(f:GetAttribute("SizeReal")) == "number" then frame = f break end
					end
				end
				if not frame then
					map_hide()
					return
				end
				local k = frame:GetAttribute("SizeReal")
				if typeof(k) ~= "number" or k == 0 then
					map_hide()
					return
				end
				map_layer_setup(mapf)
				local dot_n, name_n = 0, 0
				local show_names = cheat.map_esp_names
				local function mark(worldpos, color, name, size)
					dot_n += 1
					local m = map_marks[dot_n]
					if not m then
						m = Instance.new("Frame")
						m.AnchorPoint = Vector2.new(0.5, 0.5)
						m.BorderSizePixel = 0
						m.Parent = map_layer
						local corner = Instance.new("UICorner")
						corner.CornerRadius = UDim.new(1, 0)
						corner.Parent = m
						local stroke = Instance.new("UIStroke")
						stroke.Thickness = 1
						stroke.Color = Color3.fromRGB(0, 0, 0)
						stroke.Parent = m
						map_marks[dot_n] = m
					end
					local d = 0.5 + (worldpos.X - map_origin.X) / k
					local y = 0.5 + (worldpos.Z - map_origin.Y) / k
					local sz = size or 8
					m.Position = UDim2.new(d, 0, y, 0)
					m.Size = UDim2.fromOffset(sz, sz)
					m.BackgroundColor3 = color
					m.Visible = true
					if show_names and name then
						name_n += 1
						local t = map_names[name_n]
						if not t then
							t = Instance.new("TextLabel")
							t.AnchorPoint = Vector2.new(0.5, 1)
							t.BackgroundTransparency = 1
							t.BorderSizePixel = 0
							t.FontFace = Fonts.Get("TahomaXP")
							t.TextSize = 12
							t.TextColor3 = color
							t.TextStrokeTransparency = 0
							t.Parent = map_layer
							map_names[name_n] = t
						end
						t.Position = UDim2.new(d, 0, y, -(sz * 0.5 + 2))
						t.Size = UDim2.fromOffset(160, 16)
						t.Text = name
						t.TextColor3 = color
						t.Visible = true
					end
				end
				for _, player in Players:GetPlayers() do
					if player ~= LocalPlayer and player.Character then
						local hrp = _FindFirstChild(player.Character, "HumanoidRootPart")
						local hum = _FindFirstChildOfClass(player.Character, "Humanoid")
						if hrp and hum and hum.Health > 0 then
							mark(hrp.Position, Color3.fromRGB(255, 60, 60), player.Name)
						end
					end
				end
				for i = dot_n + 1, #map_marks do
					map_marks[i].Visible = false
				end
				for i = name_n + 1, #map_names do
					map_names[i].Visible = false
				end
			end)
		end













































































































		local avatar_changer = false
		local avatar_changer_used = false

		local change_avatar = function()
			if not avatar_changer then return end

			avatar_changer_used = true

			local user_id = Library.Flags["view_avatar_userid"]
			local success, result = pcall(tonumber, user_id)
			if not success then
				return Library.Notification("Invalid number inputted", 2.5)
			end

			local valid_parts = {
				["Head"] = true,
				["LeftFoot"] = true,
				["LeftHand"] = true,
				["LeftLowerArm"] = true,
				["LeftLowerLeg"] = true,
				["LeftUpperArm"] = true,
				["LeftUpperLeg"] = true,
				["RightFoot"] = true,
				["RightHand"] = true,
				["RightLowerArm"] = true,
				["RightLowerLeg"] = true,
				["RightUpperArm"] = true,
				["RightUpperLeg"] = true,
				["LowerTorso"] = true,
				["UpperTorso"] = true
			}

			local success, wanted_plr_model = pcall(Players.CreateHumanoidModelFromUserId, Players, user_id)
			if not success then
				return Library.Notification("Invalid UserId inputted or try again later.", 2.5)
			end

			local character = LocalPlayer.Character

			if not character then
				return
			end

			for _, child in character:GetChildren() do
				local class = child.ClassName

				if class == "Accessory" then
					child:Destroy()
				end

				if child:GetAttribute("ItemType") then
					child:Destroy()
				end
			end

			for _, child in wanted_plr_model:GetChildren() do
				local class = child.ClassName

				if class == "Shirt" or class == "Pants" then
					local stuff = character:FindFirstChildOfClass(class)
					if not stuff then continue end

					stuff[class.."Template"] = child[class.."Template"]
				end

				if class == "Accessory" then
					local handle = child:FindFirstChild("Handle")
					local weld = handle and handle:FindFirstChild("AccessoryWeld")
					if not weld then continue end

					local weld_part = character:FindFirstChild(weld.Part1.Name)
					if not weld_part then continue end

					weld.Part1 = weld_part
					child.Parent = character
				end

				if class == "MeshPart" and valid_parts[child.Name] then
					local grrr = character:FindFirstChild(child.Name)
					if not grrr then continue end

					grrr.Color = child.Color
				end
			end

			wanted_plr_model:Destroy()
		end

		local avatar_userid_textbox = nil
		local avatar_toggle = mscsec:Toggle({Name = "Avatar changer", Value = false, Flag = "view_avatar_changer", Callback = function(bool)
			avatar_changer = bool
			if avatar_userid_textbox then avatar_userid_textbox.State(bool) end
			task.spawn(change_avatar)
		end})
		avatar_userid_textbox = mscsec:Textbox({
			Name = "Avatar UserId",
			Value = "80254",
			Flag = "view_avatar_userid",
			Callback = function()
				task.spawn(change_avatar)
			end
		})
		avatar_userid_textbox.State(false)

		local character_childadded
		if LocalPlayer.Character then
			task.spawn(change_avatar)
			character_childadded = LocalPlayer.Character.ChildAdded:Connect(function(child)
				if avatar_changer_used and child:GetAttribute("ItemType") then child:Destroy() end
			end)
		end
		LocalPlayer.CharacterAdded:Connect(function(character)
			avatar_changer_used = false
			task.spawn(change_avatar)
			character_childadded = character.ChildAdded:Connect(function(child)
				if avatar_changer_used and child:GetAttribute("ItemType") then child:Destroy() end
			end)
		end)

		LocalPlayer.CharacterRemoving:Connect(function(character)
			if character_childadded then character_childadded:Disconnect() end
		end)

		Camera.DescendantAdded:Connect(function()
			if not avatar_changer_used then return end
			local vm = _FindFirstChildOfClass(Camera, "Model")
			if not vm then return end
			for _, vm_item in vm:GetChildren() do
				if vm_item.ClassName == "Model" and (_FindFirstChild(vm_item, "LL") or _FindFirstChild(vm_item, "LH")) then
					vm_item:Destroy()
				end
			end
		end)

		Camera:GetPropertyChangedSignal("FieldOfView"):Connect(function()
			if Camera.FieldOfView ~= zoom_size and Camera.FieldOfView ~= fov_changer_size then
				old_fov = Camera.FieldOfView
			end
			if not (zoom and zoom_key or fov_changer) then return end
			Camera.FieldOfView = (zoom and zoom_key and zoom_size) or (fov_changer and fov_changer_size)
		end)

		local NeckDefaultC0 = CFrame.new(0, 0.8, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local WaistDefaultC0 = CFrame.new(0, 0.2, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local RightShoulderDefaultC0 = CFrame.new(1, 0.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
		local LeftShoulderDefaultC0 = CFrame.new(-1, 0.5, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)

		local update_neck_loop = function(Character)
			while Character and LocalPlayer.Character == Character do
				local Delta, Head
				repeat
					Delta = task.wait(1/60) / 0.2
					Head = _FindFirstChild(Character, "Head")
				until Head
				local Humanoid = _FindFirstChild(Character, "Humanoid")
				if not (Humanoid and Humanoid.Health ~= 0) then
					continue
				end
				local UpperTorso	= _FindFirstChild(Character, "UpperTorso")
				local RightUpperArm = _FindFirstChild(Character, "RightUpperArm")
				local LeftUpperArm  = _FindFirstChild(Character, "LeftUpperArm")
				if not (UpperTorso and RightUpperArm and LeftUpperArm) then continue end
				local Waist		 = _FindFirstChild(UpperTorso, "Waist")
				local Neck		  = _FindFirstChild(Head, "Neck")
				local RightShoulder = _FindFirstChild(RightUpperArm, "RightShoulder")
				local LeftShoulder  = _FindFirstChild(LeftUpperArm, "LeftShoulder")
				if not (Waist and Neck and RightShoulder and LeftShoulder) then continue end

				local LookAt = _FindFirstChild(Character, "LookAt")
				if LookAt then
					local NewUpAngle
					if LookAt.Value then
						local FunnyMath = _CFramenew(Character:GetPivot().Position, LookAt.Value:GetPivot().Position).lookVector.Y * 0.55
						NewUpAngle = math.asin(FunnyMath) or 0
					else
						NewUpAngle = 0
					end
					Character:SetAttribute("UpAngle", NewUpAngle)
				end
				local UpAngle	   = (thirdperson and thirdperson_key) and Character:GetAttribute("UpAngle") or 0
				local SideAngle	 = (thirdperson and thirdperson_key) and Character:GetAttribute("SideAngle") or 0
				local HeadUpAngle   = (thirdperson and thirdperson_key) and Character:GetAttribute("HeadUpAngle") or 0
				local HeadSideAngle = (thirdperson and thirdperson_key) and Character:GetAttribute("HeadSideAngle") or 0
				local CalculatedCFrame = nil
				if Humanoid.SeatPart then
					if Humanoid.SeatPart.ClassName == "VehicleSeat" then
						CalculatedCFrame = CFrame.Angles(UpAngle, SideAngle / 3, 0)
						Neck.C0 = Neck.C0:lerp(NeckDefaultC0 * CalculatedCFrame, Delta)
					else
						CalculatedCFrame = CFrame.Angles(UpAngle, SideAngle / 4, 0)
						Waist.C0 = Waist.C0:lerp(WaistDefaultC0 * CFrame.Angles(UpAngle / 4, SideAngle / 3, 0), Delta)
						Neck.C0 = Neck.C0:lerp(NeckDefaultC0 * CalculatedCFrame, Delta)
						RightShoulder.C0 = RightShoulder.C0:lerp(RightShoulderDefaultC0 * CalculatedCFrame, Delta)
						LeftShoulder.C0 = LeftShoulder.C0:lerp(LeftShoulderDefaultC0 * CalculatedCFrame, Delta)
					end
				elseif HeadSideAngle == 0 then
					CalculatedCFrame = CFrame.Angles(UpAngle, 0, 0)
					Waist.C0 = Waist.C0:lerp(WaistDefaultC0 * CalculatedCFrame, Delta)
					Neck.C0 = Neck.C0:lerp(NeckDefaultC0 * CalculatedCFrame, Delta)
					RightShoulder.C0 = RightShoulder.C0:lerp(RightShoulderDefaultC0 * CalculatedCFrame, Delta)
					LeftShoulder.C0 = LeftShoulder.C0:lerp(LeftShoulderDefaultC0 * CalculatedCFrame, Delta)
				else
					Neck.C0 = Neck.C0:lerp(NeckDefaultC0 * CFrame.Angles(HeadUpAngle, HeadSideAngle, 0), Delta)
				end
				if CalculatedCFrame then
					for _, part in Character:GetChildren() do
						if part.ClassName == "Model" and part:FindFirstChild("ItemRoot") then
							local Motor6D = part.ItemRoot:FindFirstChild("Motor6D")
							if Motor6D then
								Motor6D.C0 = Motor6D.C0:lerp(CFrame.new(0, 0, -UpAngle * 0.5) * CalculatedCFrame, Delta)
							end
						end
					end
				end
			end
		end

		if LocalPlayer.Character then task.spawn(update_neck_loop, LocalPlayer.Character) end
		LocalPlayer.CharacterAdded:Connect(update_neck_loop)
	end
	do
		do
			local indicator_holder = Instance.new("Frame")
			indicator_holder.Parent = game:GetService("CoreGui").RobloxGui
			indicator_holder.BackgroundTransparency = 1
			indicator_holder.BorderSizePixel = 0
			indicator_holder.Position = UDim2.new(0, -GuiInset.X, 0, -GuiInset.Y)
			indicator_holder.ZIndex = 2

			local default_font = Fonts.Get("SmallestPixel7")

			local indicator_text = Instance.new("TextLabel")
			indicator_text.Parent = indicator_holder
			indicator_text.AnchorPoint = Vector2.new(0, 0)
			indicator_text.BackgroundTransparency = 1
			indicator_text.BorderSizePixel = 0
			indicator_text.Position = UDim2.new(0, 2, 0, 0)
			indicator_text.FontFace = default_font
			indicator_text.Text = ""
			indicator_text.TextColor3 = Color3.new(1, 1, 1)
			indicator_text.TextSize = 9
			indicator_text.TextStrokeTransparency = 0
			indicator_text.TextXAlignment = Enum.TextXAlignment.Left
			indicator_text.TextYAlignment = Enum.TextYAlignment.Top

			local off_color, on_color = Color3.new(1, 0.1, 0.1), Color3.new(0.1, 1, 0.1)
			local off_transparency, on_transparency = 0, 0

			do
				local visor_font_dropdown, visor_size_slider, visor_x_slider, visor_y_slider = nil, nil, nil, nil
				local toggle = lclsec:Toggle({Name = "Visor indicator", Value = false, Flag = "visor_indicator", Callback = function(bool)
					indicator_holder.Visible = bool
					local vis = bool and true or false
					if visor_font_dropdown then visor_font_dropdown.State(vis) end
					if visor_size_slider then visor_size_slider.State(vis) end
					if visor_x_slider then visor_x_slider.State(vis) end
					if visor_y_slider then visor_y_slider.State(vis) end
				end})
				toggle:Colorpicker({Name = "Indicator off Color", Value = Color3.new(1, 0.3, 0.3), Usealpha = true, Flag = "visor_indicator_off_color", Callback = function(color)
					off_color = color.c
					off_transparency = color.a
				end})
				toggle:Colorpicker({Name = "Indicator on Color", Value = Color3.new(0.3, 1, 0.3), Usealpha = true, Flag = "visor_indicator_on_color", Callback = function(color)
					on_color = color.c
					on_transparency = color.a
				end})
				visor_font_dropdown = lclsec:Dropdown({Name = "Indicator font", Values = {
					"Tahoma",
					"TahomaXP",
					"Comfortaa",
					"Verdana",
					"SmallestPixel7",
					"Proggy",
				}, Value = {"SmallestPixel7"}, Flag = "visor_indicator_font", Multi = false, Callback = function(str)
					indicator_text.FontFace = Fonts.Get(str or "SmallestPixel7") or default_font
				end})
				visor_font_dropdown.State(false)
				visor_size_slider = lclsec:Slider({Name = "Indicator size", Min = 1, Max = 30, Float = 1, Value = 9, Flag = "visor_indicator_size", Suffix = "%spx", Callback = function(int)
					indicator_text.TextSize = int
				end})
				visor_size_slider.State(false)
				visor_x_slider = lclsec:Slider({Name = "Indicator X", Min = 0, Max = 100, Float = 1, Value = 5, Flag = "visor_indicator_x", Suffix = "%s%%", Callback = function(int)
					indicator_holder.Position = UDim2.new(int / 100, -GuiInset.X, indicator_holder.Position.Y.Scale, -GuiInset.Y)
					indicator_text.TextXAlignment = int < 50 and Enum.TextXAlignment.Left or int > 50 and Enum.TextXAlignment.Right or Enum.TextXAlignment.Center
					indicator_text.Position = UDim2.new(int < 50 and 0 or int > 50 and 1 or 0.5, 0, 0, 0)
					indicator_text.AnchorPoint = Vector2.new(int < 50 and 0 or int > 50 and 1 or 0.5, 0)
				end})
				visor_x_slider.State(false)
				visor_y_slider = lclsec:Slider({Name = "Indicator Y", Min = 0, Max = 100, Float = 1, Value = 5, Flag = "visor_indicator_y", Suffix = "%s%%", Callback = function(int)
					indicator_holder.Position = UDim2.new(indicator_holder.Position.X.Scale, -GuiInset.X, int / 100, -GuiInset.Y)

				end})
				visor_y_slider.State(false)
			end

			local lpo = cheat.player_list[LocalPlayer]
			cheat.utility.new_heartbeat(LPH_JIT(function()
				if lpo.visor then
					indicator_text.Text = "visor on"
					indicator_text.TextColor3 = on_color
					indicator_text.TextTransparency = on_transparency
				else
					indicator_text.Text = "visor off"
					indicator_text.TextColor3 = off_color
					indicator_text.TextTransparency = off_transparency
				end
			end))
		end
		lclsec:Toggle({Name = "Remove screen effects", Value = false, Flag = "no_screen_effects", Callback = function(bool)
			no_screen_effects = bool
		end})

		cheat.mute_breathing = false
		local breath_sound = nil
		local breath_tick = 0
		local function mute_breath(deep)
			if breath_sound and breath_sound.Parent then
				breath_sound.Playing = false
				breath_sound.Volume = 0
				pcall(function() breath_sound:Stop() end)
				return true
			end
			local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
			local main = gui and _FindFirstChild(gui, "NoInsetGui")
			main = main and _FindFirstChild(main, "MainFrame")
			local fx = main and _FindFirstChild(main, "ScreenEffects")
			local mask = fx and _FindFirstChild(fx, "Mask")
			local gp5 = mask and _FindFirstChild(mask, "GP5")
			local gas = gp5 and _FindFirstChild(gp5, "GasMask")
			if gas and gas:IsA("Sound") then
				breath_sound = gas
				gas.Playing = false
				gas.Volume = 0
				pcall(function() gas:Stop() end)
				return true
			elseif deep and fx then
				for _, d in fx:GetDescendants() do
					if d:IsA("Sound") then
						local nm = string.lower(d.Name)
						if string.find(nm, "gas", 1, true) or string.find(nm, "breath", 1, true) then
							breath_sound = d
							d.Playing = false
							d.Volume = 0
							pcall(function() d:Stop() end)
						end
					end
				end
				return false
			end
			return false
		end
		lclsec:Toggle({Name = "Mute breathing", Value = false, Flag = "lcl_mute_breathing", Callback = function(bool)
			cheat.mute_breathing = bool
			if bool then
				mute_breath(true)
			end
		end})
		cheat.utility.new_heartbeat(function()
			if cheat.mute_breathing and tick() - breath_tick > 0.25 then
				breath_tick = tick()
				mute_breath(not (breath_sound and breath_sound.Parent))
			end
		end)

		local gun_color_picker, gun_mat_dropdown = nil, nil
		local gun_toggle = lclsec:Toggle({Name = "Gun changer", Value = false, Flag = "gun_changer", Callback = function(bool)
			gun_changer = bool
			local vis = bool and true or false
			if gun_color_picker then gun_color_picker.State(vis) end
			if gun_mat_dropdown then gun_mat_dropdown.State(vis) end
		end})
		gun_color_picker = lclsec:Colorpicker({Name = "Gun color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "gun_color", Callback = function(color)
			gun_color = color.c
		end})
		gun_color_picker.State(false)
		gun_mat_dropdown = lclsec:Dropdown({Name = "Gun material", Values = {"ForceField", "Neon", "SmoothPlastic", "Glass"}, Value = "ForceField", Flag = "gun_material", Multi = false, Callback = function(str)
			gun_material = str and Enum.Material[str] or Enum.Material.ForceField
		end})
		gun_mat_dropdown.State(false)
		cheat.dressSkin = function(model, item_name, selected_skin)
			local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Skins")
			if not model or not folder then return end
			local item = folder:FindFirstChild(item_name)
			local skin = item and item:FindFirstChild(selected_skin)
			if not skin then return end
			local textures = skin:FindFirstChild("Textures")
			local materials = skin:FindFirstChild("Materials")
			if not textures and not materials then return end
			local parts = {}
			for _, child in model:GetChildren() do
				table.insert(parts, child)
				for _, nested in child:GetChildren() do
					table.insert(parts, nested)
				end
			end
			for _, part in parts do
				local key = part:GetAttribute("Skinnable")
				local texture = key and textures and textures:FindFirstChild(key)
				if texture then
					pcall(function()
						for _, old in part:GetChildren() do
							if old:IsA(texture.ClassName) then old:Destroy() end
						end
						local copy = texture:Clone()
						copy.Name = "SurfaceAppearance"
						copy.Parent = part
						local transparency = copy:GetAttribute("Transparency")
						if transparency and part:IsA("BasePart") and part.Transparency ~= 1 then part.Transparency = transparency end
					end)
				end
				local material = key and materials and materials:FindFirstChild(key)
				if material and part:IsA("BasePart") then
					pcall(function()
						for _, old in part:GetChildren() do
							if old:IsA("SurfaceAppearance") then old:Destroy() end
						end
						local color = material:GetAttribute("Color")
						local transparency = material:GetAttribute("Transparency")
						local material_name = material:GetAttribute("Name")
						if color then part.Color = color end
						if transparency then part.Transparency = transparency end
						if material_name and Enum.Material[material_name] then part.Material = Enum.Material[material_name] end
					end)
				end
			end
		end
		local arm_color_picker, arm_mat_dropdown = nil, nil
		local arm_toggle = lclsec:Toggle({Name = "Arm changer", Value = false, Flag = "arm_changer", Callback = function(bool)
			arm_changer = bool
			local vis = bool and true or false
			if arm_color_picker then arm_color_picker.State(vis) end
			if arm_mat_dropdown then arm_mat_dropdown.State(vis) end
		end})
		arm_color_picker = lclsec:Colorpicker({Name = "Arm color", Value = Color3.new(1, 1, 1), Usealpha = false, Flag = "arm_color", Callback = function(color)
			arm_color = color.c
		end})
		arm_color_picker.State(false)
		arm_mat_dropdown = lclsec:Dropdown({Name = "Arm material", Values = {"ForceField", "Neon", "SmoothPlastic", "Glass"}, Value = "ForceField", Flag = "arm_material", Multi = false, Callback = function(str)
			arm_material = str and Enum.Material[str] or Enum.Material.ForceField
		end})
		arm_mat_dropdown.State(false)

		local vm_x_slider, vm_y_slider, vm_z_slider = nil, nil, nil
		local vm_toggle = lclsec:Toggle({Name = "Viewmodel changer", Value = false, Flag = "viewmodel_changer", Callback = function(bool)
			viewmodel_changer = bool
			local vis = bool and true or false
			if vm_x_slider then vm_x_slider.State(vis) end
			if vm_y_slider then vm_y_slider.State(vis) end
			if vm_z_slider then vm_z_slider.State(vis) end
		end})
		vm_x_slider = lclsec:Slider({Name = "X offset", Min = -5, Max = 5, Float = 0.1, Value = 0, Flag = "viewmodel_x", Callback = function(int)
			viewmodel_x = int
			if not viewmodel_changer then
				return
			end
			local viewmodel = _FindFirstChildOfClass(Camera, "Model")
			if viewmodel then
				vmpos(viewmodel)
			end
		end})
		vm_x_slider.State(false)
		vm_y_slider = lclsec:Slider({Name = "Y offset", Min = -5, Max = 5, Float = 0.1, Value = 0, Flag = "viewmodel_y", Callback = function(int)
			viewmodel_y = int
			if not viewmodel_changer then
				return
			end
			local viewmodel = _FindFirstChildOfClass(Camera, "Model")
			if viewmodel then
				vmpos(viewmodel)
			end
		end})
		vm_y_slider.State(false)
		vm_z_slider = lclsec:Slider({Name = "Z offset", Min = -5, Max = 5, Float = 0.1, Value = 0, Flag = "viewmodel_z", Callback = function(int)
			viewmodel_z = int
			if not viewmodel_changer then
				return
			end
			local viewmodel = _FindFirstChildOfClass(Camera, "Model")
			if viewmodel then
				vmpos(viewmodel)
			end
		end})
		vm_z_slider.State(false)

		Camera.ChildAdded:Connect(vmpos)
		Camera.DescendantAdded:Connect(vmchams)
		Camera.ChildRemoved:Connect(vmunpos)

	task.spawn(function()
		while task.wait(0.5) do
				local playergui = LocalPlayer.PlayerGui
				local noinsetgui = playergui and _FindFirstChild(playergui, "NoInsetGui")
				local mainframe = noinsetgui and _FindFirstChild(noinsetgui, "MainFrame")
				local screeneffects = mainframe and _FindFirstChild(mainframe, "ScreenEffects")
				if screeneffects then screeneffects.Visible = not no_screen_effects end
			end
		end)
	end
end

local antiaim, antiaim_pitch, antiaim_pitch_value = false, false, 0

do
	local movebox = ui.sections.movement
	local miscbox = ui.sections.misc
	local antibox = ui.sections.antiaim
	local animbox = ui.sections.antiaim_animations

	local speedhack, speedhack_speed = false, 18.2
	local speedhack_autospeed, speedhack_autospeed_offset = false, 3.5

	local jumphack, jumphack_height = false, 5

	local flyhack, flyhack_key, flyhack_speed, flyhack_speed_y = false, false, 100, 100

	cheat.nc_state = {on = false, key = false, speed = 1, kinds = {"Floors", "Walls"}, layers = 1}
	cheat.clipActive = false
	local spiderman, spiderman_key = false, false

	local anti_drown = false

	local antiaim_yaw, antiaim_jitter, antiaim_spin = false, false, false
	local antiaim_yaw_value, antiaim_jitter_value, antiaim_spin_value = 180, 0, 0
	do
		miscbox:Button({Name = "Rejoin", Confirm = true, Callback = function()
			if #Players:GetPlayers() <= 1 then
				LocalPlayer:Kick("\nRejoining...")
				wait()
				game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
			else
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
			end
		end})

		miscbox:Toggle({Name = "Hide server info", Value = false, Flag = "hide_server_info", Callback = function(bool)
			local playergui = LocalPlayer.PlayerGui
			local serverinfo = _FindFirstChild(playergui, "ServerInfo")
			local frame = serverinfo and _FindFirstChild(serverinfo, "Frame")
			local textlabel = frame and _FindFirstChild(frame, "serverInfo")
			if textlabel then
				textlabel.Visible = not bool
			end
		end})

		local shitcode, shitcode_tick, shitcode_factor = false, tick(), (mathrandom() - 0.5) * 5
		miscbox:Toggle({Name = "Old swimhub mode", Flag = "old_swimhub_mode", Value = false, Callback = function(v)
			shitcode = v
			shitcode_tick = tick()
			task.spawn(function()
				while shitcode do
					if tick() - shitcode_tick > 1/(24 + shitcode_factor) then
						shitcode_tick = tick()
						shitcode_factor = (mathrandom() - 0.5) * 5
						RunService.RenderStepped:Wait()
					end
				end
			end)
		end})

		local cross_script_chat; cross_script_chat = miscbox:Toggle({Name = "Cross-script chat", Flag = "cross_script_chat", Value = false, Callback = function(v)
			if v and not cheat.CrossScriptChat then
				cross_script_chat.Set(false, true)
				return Library.Notification("Cross-script chat is loading at the moment. Please wait.", 2.5)
			end
			if cheat.CrossScriptChat then
				cheat.CrossScriptChat.SetSendingEnabled(v)
			end
		end})
	end
	do
		local nofall = false

		movebox:Toggle({Name = "No fall damage", Value = false, Flag = "no_fall_damage", Callback = function(bool)
			nofall = bool
		end})

		local falling_states = {
			Enum.HumanoidStateType.FallingDown,
			Enum.HumanoidStateType.Freefall,
			Enum.HumanoidStateType.PlatformStanding
		}

		local character = LocalPlayer.Character
		local hum = character and _FindFirstChildOfClass(character, "Humanoid")
		local old_nofall_pos, should_no_fall = nil, false
























	task.spawn(function()
		while RunService.Heartbeat:Wait() do
				local character = LocalPlayer.Character
				if not character then
					continue
				end

				local hrp = _FindFirstChild(character, "HumanoidRootPart")
				local hum = _FindFirstChildOfClass(character, "Humanoid")
				if not (hrp and hum) then
					continue
				end

				local currpos = hrp.CFrame.Position

				if not nofall or not table.find(falling_states, hum:GetState()) then
					should_no_fall = false
					continue
				end

				hum:ChangeState(Enum.HumanoidStateType.Running)
				should_no_fall = true
			end
		end)

		local state_changed = LPH_NO_VIRTUALIZE(function(old, new)
			if should_no_fall and table.find(falling_states, new) then
				hum:ChangeState(Enum.HumanoidStateType.Running)
			end
		end)
		local state_connection
		if hum then
			state_connection = hum.StateChanged:Connect(state_changed)
		end
		LocalPlayer.CharacterAdded:Connect(function(character)
			local humanoid = character:WaitForChild("Humanoid")
			if state_connection then state_connection:Disconnect() end
			state_connection = humanoid.StateChanged:Connect(state_changed)
		end)
	end
	do
		antibox:Toggle({Name = "Enabled", Value = false, Flag = "antiaim_enabled", Callback = function(bool)
			antiaim = bool
		end})

		local pitch_value_slider = nil
		local pitch_toggle = antibox:Toggle({Name = "Pitch modifier", Value = false, Flag = "antiaim_pitch", Callback = function(bool)
			antiaim_pitch = bool
			if pitch_value_slider then pitch_value_slider.State(bool) end
		end})
		pitch_value_slider = antibox:Slider({Name = "Pitch value", Min = -1, Max = 1, Float = 0.05, Value = 0, Flag = "antiaim_pitch_value", Callback = function(int)
			antiaim_pitch_value = int
		end})
		pitch_value_slider.State(false)

		local yaw_value_slider = nil
		local yaw_toggle = antibox:Toggle({Name = "Yaw modifier", Value = false, Flag = "antiaim_yaw", Callback = function(bool)
			antiaim_yaw = bool
			if yaw_value_slider then yaw_value_slider.State(bool) end
		end})
		yaw_value_slider = antibox:Slider({Name = "Yaw value", Min = -180, Max = 180, Float = 5, Value = 0, Flag = "antiaim_yaw_value", Callback = function(int)
			antiaim_yaw_value = math.rad(int)
		end})
		yaw_value_slider.State(false)

		local jitter_value_slider = nil
		local jitter_toggle = antibox:Toggle({Name = "Yaw jitter", Value = false, Flag = "antiaim_jitter", Callback = function(bool)
			antiaim_jitter = bool
			if jitter_value_slider then jitter_value_slider.State(bool) end
		end})
		jitter_value_slider = antibox:Slider({Name = "Jitter strength", Min = 0, Max = 90, Float = 1, Value = 45, Flag = "antiaim_jitter_value", Callback = function(int)
			antiaim_jitter_value = math.rad(int)
		end})
		jitter_value_slider.State(false)

		local spin_value_slider = nil
		local spin_toggle = antibox:Toggle({Name = "Yaw spin", Value = false, Flag = "antiaim_spin", Callback = function(bool)
			antiaim_spin = bool
			if spin_value_slider then spin_value_slider.State(bool) end
		end})
		spin_value_slider = antibox:Slider({Name = "Spin speed", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "antiaim_spin_value", Callback = function(int)
			antiaim_spin_value = math.rad(int * 36)
		end})
		spin_value_slider.State(false)
		local updatetilt_remote = project_delta.updatetilt_remote
		local jitter_side, jitter_timer, spin_timer = false, 0, 0
		cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
			local char = LocalPlayer.Character
			local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
			local hum = char and _FindFirstChildOfClass(char, "Humanoid")

			if not (hrp and hum) then return end

			hum.AutoRotate = not antiaim
			if antiaim then
				local _, calc_yaw, _ = Camera.CFrame:ToOrientation()

				if antiaim_pitch then
					updatetilt_remote:FireServer(antiaim_pitch_value, 0)
				end
				if antiaim_yaw then
					calc_yaw += antiaim_yaw_value
				end
				if antiaim_jitter then
					jitter_timer += delta
					if jitter_side then
						calc_yaw += antiaim_jitter_value
					else
						calc_yaw -= antiaim_jitter_value
					end
					if jitter_timer > 1/32 then
						jitter_side = not jitter_side
						jitter_timer = jitter_timer % (1/32)
					end
				end
				if antiaim_spin then
					calc_yaw += ((tick() * antiaim_spin_value) % 1) * (math.pi * 2)
				end

				local hrp_x, _, hrp_z = hrp.CFrame:ToOrientation()
				hrp.CFrame = _CFramenew(hrp.Position) * CFrame.Angles(hrp_x, calc_yaw, hrp_z)
			end
		end))
	end
	do
		local speed_toggle = movebox:Toggle({Name = "Speedhack", Value = false, Flag = "speedhack", Callback = function(bool)
			speedhack = bool
		end})
		movebox:Toggle({Name = "Speedhack auto speed", Value = false, Flag = "speedhack_autospeed", Callback = function(bool)
			speedhack_autospeed = bool
		end})
		movebox:Slider({Name = "Speedhack speed", Min = 1, Max = 24, Float = 0.1, Value = 18.2, Flag = "speedhack_speed", Callback = function(int)
			speedhack_speed = int
		end})
		movebox:Slider({Name = "Auto speed offset", Min = -5, Max = 5, Float = 0.1, Value = 3.5, Flag = "speedhack_autospeed_offset", Callback = function(int)
			speedhack_autospeed_offset = int
		end})

		local jump_toggle = movebox:Toggle({Name = "Jumphack", Value = false, Flag = "jumphack", Callback = function(bool)
			jumphack = bool
		end})
		movebox:Slider({Name = "Jumphack height", Min = 1, Max = 10, Float = 0.1, Value = 5, Flag = "jumphack_height", Callback = function(int)
			jumphack_height = int
		end})

		local fh_keybind; fh_keybind = movebox:Toggle({Name = "Flyhack", Value = false, Flag = "flyhack", Callback = function(bool)
			flyhack = bool
		end}):Keybind({Name = "Flyhack", Mode = "Toggle", Key = Enum.KeyCode.X, Value = false, Flag = "flyhack_key", Link = "flyhack", Callback = function(bool)
			flyhack_key = flyhack and bool
			fh_keybind.Set(flyhack_key, true)
		end})
		movebox:Slider({Name = "Flyhack speed", Min = 0, Max = 50, Float = 1, Value = 25, Flag = "flyhack_speed", Callback = function(int)
			flyhack_speed = int
		end})
		movebox:Slider({Name = "Flyhack speed Y", Min = 0, Max = 50, Float = 1, Value = 25, Flag = "flyhack_speed_y", Callback = function(int)
			flyhack_speed_y = int
		end})

		local nc_kinds_dropdown, nc_layers_slider, nc_speed_slider = nil, nil, nil
		local nc_toggle = movebox:Toggle({Name = "Noclip", Value = false, Flag = "noclip", Callback = function(bool)
			cheat.nc_state.on = bool
			local vis = bool and true or false
			if nc_kinds_dropdown then nc_kinds_dropdown.State(vis) end
			if nc_layers_slider then nc_layers_slider.State(vis) end
			if nc_speed_slider then nc_speed_slider.State(vis) end
		end})
		local nc_keybind; nc_keybind = nc_toggle:Keybind({Name = "Noclip", Mode = "Toggle", Modes = {"Hold", "Toggle"}, Key = Enum.KeyCode.C, Value = false, Flag = "noclip_key", Link = "noclip", Callback = function(bool)
			cheat.nc_state.key = cheat.nc_state.on and bool
			nc_keybind.Set(cheat.nc_state.key, true)
		end})
		nc_kinds_dropdown = movebox:Dropdown({Name = "Clip through", Values = {"Floors", "Walls"}, Value = {"Floors", "Walls"}, Flag = "noclip_kinds", Multi = true, Callback = function(tbl)
			cheat.nc_state.kinds = (tbl and #tbl > 0) and tbl or {"Floors", "Walls"}
		end})
		nc_kinds_dropdown.State(false)
		nc_layers_slider = movebox:Slider({Name = "Max layers", Min = 1, Max = 4, Float = 1, Value = 1, Flag = "noclip_layers", Callback = function(int)
			cheat.nc_state.layers = math.max(1, math.floor(int))
		end})
		nc_layers_slider.State(false)
		nc_speed_slider = movebox:Slider({Name = "Clip speed", Min = 0.5, Max = 8, Float = 0.5, Value = 1, Flag = "noclip_speed", Callback = function(int)
			cheat.nc_state.speed = int
		end})
		nc_speed_slider.State(false)

		local sp_keybind; sp_keybind = movebox:Toggle({Name = "Spiderman", Value = false, Flag = "spiderman", Callback = function(bool)
			spiderman = bool
		end}):Keybind({Name = "Spiderman", Mode = "Hold", Key = Enum.KeyCode.F, Value = false, Flag = "spiderman_key", Link = "spiderman", Callback = function(bool)
			spiderman_key = spiderman and bool
			sp_keybind.Set(spiderman_key, true)
		end})

		movebox:Toggle({Name = "Anti drown", Value = false, Flag = "anti_drown", Callback = function(bool)
			anti_drown = bool
			cheat.anti_drown = bool
		end})
		local swim_override, ignore_water = false, false
		cheat.ignore_water = false
		local swim_platform
		local swim_mode_dropdown = nil
		local swim_toggle = movebox:Toggle({Name = "Swim override", Value = false, Flag = "swim_override", Callback = function(bool)
			swim_override = bool
			if swim_mode_dropdown then swim_mode_dropdown.State(bool) end
			if not bool and swim_platform then
				pcall(function() swim_platform:Destroy() end)
				swim_platform = nil
			end
		end})
		swim_mode_dropdown = movebox:Dropdown({Name = "Swim mode", Values = {"Jesus", "Moses"}, Value = "Jesus", Flag = "swim_mode", Multi = false, Callback = function() end})
		swim_mode_dropdown.State(false)
		movebox:Toggle({Name = "Ignore water", Value = false, Flag = "ignore_water", Callback = function(bool)
			ignore_water = bool
			cheat.ignore_water = bool
		end})
		movebox:Toggle({Name = "Omni sprint", Value = false, Flag = "omni_sprint", Callback = function(bool)
			omni_sprint = bool
		end})

	cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
		local char = LocalPlayer.Character
		local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
		local hum = char and _FindFirstChildOfClass(char, "Humanoid")

		if not (hrp and hum) then return end

		local calcspeed = speedhack_autospeed and project_delta.calculate_speed(hrp) + speedhack_autospeed_offset or speedhack_speed
		if omni_sprint and hum.MoveDirection.Magnitude > 0 then
			local gui = LocalPlayer.PlayerGui
			if gui and gui:FindFirstChild("MainGui") then
				hum.WalkSpeed = 18
			end
		end
		if speedhack then
			hum.WalkSpeed = calcspeed
		end
		if jumphack then
			hum.JumpHeight = jumphack_height
		end
		if swim_override and Library.Flags["swim_mode"] == "Jesus" then
			local water = workspace:Raycast(hrp.Position, _Vector3new(0, -16, 0), RaycastParams.new())
			if water and water.Material == Enum.Material.Water then
				if not swim_platform then
					swim_platform = Instance.new("Part")
					swim_platform.Anchored = true
					swim_platform.CanCollide = true
					swim_platform.Transparency = 1
					swim_platform.Parent = workspace
				end
				swim_platform.Size = _Vector3new(16, 0.4, 16)
				swim_platform.Position = _Vector3new(hrp.Position.X, water.Position.Y, hrp.Position.Z)
			end
		elseif swim_platform then
			pcall(function() swim_platform:Destroy() end)
			swim_platform = nil
		end

		local cameralook = (_Vector3new(1, 0, 1) * Camera.CFrame.LookVector).Unit
		local direction = _Vector3new(0, 0, 0)
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.W) and direction + cameralook or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.S) and direction - cameralook or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.D) and direction + _Vector3new(-cameralook.Z, 0, cameralook.X) or direction;
		direction = _IsKeyDown(UserInputService, Enum.KeyCode.A) and direction + _Vector3new(cameralook.Z, 0, -cameralook.X) or direction;
		if direction ~= Vector3.zero then
			direction = direction.Unit
		end
		if flyhack and flyhack_key then
			local ydir = Vector3.zero
			ydir = _IsKeyDown(UserInputService, Enum.KeyCode.Space)	      and ydir + Vector3.yAxis or ydir;
			ydir = _IsKeyDown(UserInputService, Enum.KeyCode.LeftControl) and ydir - Vector3.yAxis or ydir;
			hrp.AssemblyLinearVelocity = _Vector3new(0, 0, 0)
			hrp.CFrame = hrp.CFrame + (_Vector3new(1, 0, 1) * direction * flyhack_speed * delta + flyhack_speed_y * ydir * delta)
		elseif speedhack then
			local hmm = direction * calcspeed
			hrp.AssemblyLinearVelocity = _Vector3new(hmm.X, hrp.AssemblyLinearVelocity.Y, hmm.Z)
		end
		if spiderman and spiderman_key then
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = {char, workspace.NoCollision}
			params.IgnoreWater = true
			local hit = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 2, params)
			if hit and hit.Instance then
				local flat = _Vector3new(hrp.CFrame.LookVector.X, 0, hrp.CFrame.LookVector.Z)
				if flat.Magnitude > 0.01 then
					hrp.AssemblyLinearVelocity = _Vector3new(flat.Unit.X * hrp.AssemblyLinearVelocity.X, 30, flat.Unit.Z * hrp.AssemblyLinearVelocity.Z)
				else
					hrp.AssemblyLinearVelocity = _Vector3new(0, 30, 0)
				end
				if hum:GetState() ~= Enum.HumanoidStateType.Climbing then
					hum:ChangeState(Enum.HumanoidStateType.Climbing)
				end
			end
		end
	end))
	cheat.utility.new_heartbeat(function()
		if not anti_drown then return end
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
		local data = folder and folder:FindFirstChild(LocalPlayer.Name)
		local status = data and data:FindFirstChild("Status")
		local vars = status and status:FindFirstChild("GameplayVariables")
		if vars and vars:GetAttribute("Drowning") ~= false then
			pcall(function()
				vars:SetAttribute("Drowning", false)
			end)
		end
	end)
end
end

do
	local NC_PROBE_WAIT = 0.05
	local NC_SINK = 0.35
	local NC_RISE = 0.25
	local NC_REACH = 3
	local NC_MAXDROP = 6
	local NC_DROP_SEARCH = 10
	local NC_DWELL = 0.25
	local NC_HELD_DIST = 4
	local NC_HELD_TIME = 4
	local NC_WALL_ROT = CFrame.Angles(math.pi / 2, 0, 0)
	local NC_OK = Color3.fromRGB(130, 255, 170)
	local NC_BAD = Color3.fromRGB(255, 93, 120)
	local NC_MID = Color3.fromRGB(255, 210, 120)
	local NC_IDLE = Color3.fromRGB(210, 210, 210)
	local function nc_rig()
		local c = LocalPlayer.Character
		local h = c and _FindFirstChild(c, "HumanoidRootPart")
		local hm = c and _FindFirstChildOfClass(c, "Humanoid")
		return c, h, hm
	end
	local function nc_uac_pos()
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
		local data = folder and folder:FindFirstChild(LocalPlayer.Name)
		local status = data and data:FindFirstChild("Status")
		local uac = status and status:FindFirstChild("UAC")
		local pos = uac and uac:GetAttribute("LastVerifiedPos")
		if typeof(pos) == "Vector3" then return pos end
		return nil
	end
	local nc_ray = RaycastParams.new()
	nc_ray.FilterType = Enum.RaycastFilterType.Exclude
	nc_ray.IgnoreWater = true
	pcall(function() nc_ray.RespectCanCollide = true end)
	local nc_over = OverlapParams.new()
	nc_over.FilterType = Enum.RaycastFilterType.Exclude
	pcall(function() nc_over.RespectCanCollide = true end)
	pcall(function() nc_over.MaxParts = 8 end)
	local function nc_filter(char)
		nc_ray.FilterDescendantsInstances = {char, workspace:FindFirstChild("NoCollision"), workspace:FindFirstChild("DroppedItems")}
	end
	cheat.groundBelow = function(pos, char)
		if char then nc_filter(char) end
		return workspace:Raycast(pos + _Vector3new(0, 2, 0), _Vector3new(0, -4096, 0), nc_ray)
	end
	local nc_probe_part = Instance.new("Part")
	nc_probe_part.Name = "NoclipProbe"
	nc_probe_part.Anchored = true
	nc_probe_part.CanCollide = false
	nc_probe_part.CanTouch = false
	nc_probe_part.CanQuery = false
	nc_probe_part.CastShadow = false
	nc_probe_part.Transparency = 1
	nc_probe_part.Size = _Vector3new(1, 1, 1)
	nc_probe_part.Parent = workspace.Terrain
	local function nc_box_free(cf, size, char)
		nc_over.FilterDescendantsInstances = {char, workspace:FindFirstChild("NoCollision"), workspace:FindFirstChild("DroppedItems"), workspace.Terrain}
		if nc_probe_part.Parent ~= workspace.Terrain then nc_probe_part.Parent = workspace.Terrain end
		nc_probe_part.Size = size
		nc_probe_part.CFrame = cf
		for _, p in workspace:GetPartsInPart(nc_probe_part, nc_over) do
			local s = p.Size
			if math.max(s.X, s.Y, s.Z) >= 1 then return p end
		end
	end
	local function nc_fit(char, cf, feet, top)
		return nc_box_free(cf * _CFramenew(0, (top - feet) / 2, 0), _Vector3new(1.2, math.max(1, feet + top - 0.7), 1), char)
	end
	local nc_old_gui = game:GetService("CoreGui"):FindFirstChild("SwimNoclip")
	if nc_old_gui then nc_old_gui:Destroy() end
	local nc_gui = Instance.new("ScreenGui")
	nc_gui.Name = "SwimNoclip"
	nc_gui.ResetOnSpawn = false
	nc_gui.IgnoreGuiInset = true
	nc_gui.DisplayOrder = 10
	nc_gui.Parent = game:GetService("CoreGui")
	local nc_label = Instance.new("TextLabel")
	nc_label.AnchorPoint = _Vector2new(0.5, 0)
	nc_label.Position = UDim2.new(0.5, 0, 0.5, 24)
	nc_label.Size = UDim2.fromOffset(300, 14)
	nc_label.BackgroundTransparency = 1
	nc_label.Font = Enum.Font.Gotham
	nc_label.TextSize = 12
	nc_label.TextStrokeTransparency = 0.35
	nc_label.TextColor3 = NC_IDLE
	nc_label.Text = ""
	nc_label.Visible = false
	nc_label.Parent = nc_gui
	local function nc_status(text, color)
		if nc_label.Text ~= text then nc_label.Text = text end
		if nc_label.TextColor3 ~= color then nc_label.TextColor3 = color end
	end
	local nc_clip, nc_plan, nc_plan_err, nc_last_probe, nc_last_part, nc_part_time, nc_cooling, nc_cool_until = nil, nil, nil, 0, nil, 0, false, 0
	local function nc_kind_allowed(kind)
		if type(cheat.nc_state.kinds) ~= "table" then return true end
		return table.find(cheat.nc_state.kinds, kind) ~= nil
	end
	local function nc_dims(char, hrp, hum)
		local feet = hum.HipHeight > 0 and hum.HipHeight + hrp.Size.Y / 2 or 3
		local neck = 1
		local top = 6
		local head = char and _FindFirstChild(char, "Head")
		if head and head:IsA("BasePart") then
			local y = hrp.CFrame:PointToObjectSpace(head.Position).Y
			neck = y - head.Size.Y / 2
			top = y + head.Size.Y / 2
		end
		local min_neck = math.max(0.2, neck)
		return feet, min_neck, math.max(min_neck + 0.5, top)
	end
	local function nc_scan_layer(origin, dir, from_d, to_d)
		local lo = from_d
		for _ = 1, 8 do
			local hit = workspace:Raycast(origin + dir * (lo + 0.02), dir * math.max(0.05, to_d - lo - 0.02), nc_ray)
			local edge = hit and (hit.Position - origin):Dot(dir) - 0.02 or to_d
			if lo + 0.005 < edge then
				local back = workspace:Raycast(origin + dir * edge, -dir * (edge - from_d + 0.01), nc_ray)
				if back then
					local t = (back.Position - origin):Dot(dir)
					if from_d + 0.01 < t then return t end
				end
			end
			if not hit then return nil end
			lo = (hit.Position - origin):Dot(dir)
			if to_d <= lo then return nil end
		end
	end
	local function nc_scan_stack(origin, dir, first_len, need_room, max_dist, max_layers)
		local d = 0
		local layers = 0
		while true do
			local thick = nc_scan_layer(origin, dir, d, first_len)
			if not thick then
				return nil, layers == 0 and "too thick" or "a layer below is too thick"
			end
			layers += 1
			local fwd = workspace:Raycast(origin + dir * (thick + 0.02), dir * max_dist, nc_ray)
			local room = fwd and (fwd.Position - origin):Dot(dir) - thick or nil
			if not room or room >= need_room then
				return thick, room, layers
			end
			if max_layers <= layers then break end
			d = thick + room
		end
		return nil, ("%d+ floors thick, raise Max Floors"):format(layers + 1)
	end
	local function nc_cf_at(plan, d)
		return _CFramenew(plan.surf + plan.n * d) * plan.rot
	end
	local function nc_snap_ground(char, hrp, feet)
		if not (hrp and hrp.Parent) then return end
		if char then nc_filter(char) end
		local p = hrp.Position
		local hit = workspace:Raycast(p + _Vector3new(0, 1, 0), _Vector3new(0, -256, 0), nc_ray)
		if not hit then return end
		local drop = p.Y - hit.Position.Y + feet
		if drop > 0.05 then hrp.CFrame = hrp.CFrame - _Vector3new(0, drop, 0) end
	end
	local function nc_finish(mode, msg)
		local c = nc_clip
		if not c then return end
		nc_clip = nil
		cheat.clipActive = false
		local char, hrp = nc_rig()
		if hrp and hrp.Parent then
			pcall(function()
				if mode == "back" then
					hrp.CFrame = c.start
				elseif mode == "finish" then
					hrp.CFrame = c.kind == "floor" and nc_cf_at(c, c.uEnd) or c.final
				end
				local done = mode ~= "back" and (mode == "finish" or (c.phase or 0) >= 2)
				if done then
					nc_snap_ground(char, hrp, c.feet or 3)
					local cf = hrp.CFrame
					local lv = cf.LookVector
					local flat = _Vector3new(lv.X, 0, lv.Z)
					if flat.Magnitude < 0.001 then flat = cf.RightVector end
					hrp.CFrame = CFrame.lookAt(cf.Position, cf.Position + flat.Unit)
				end
				hrp.AssemblyLinearVelocity = Vector3.zero
				hrp.AssemblyAngularVelocity = Vector3.zero
			end)
		end
		for _, p in c.parts do
			if p.Parent then pcall(function() p.CanCollide = true end) end
		end
		if c.hum and c.hum.Parent then
			pcall(function() c.hum.PlatformStand = c.stood == true end)
		end
		nc_cooling = true
		nc_cool_until = os.clock() + 0.75
		nc_plan = nil
		if msg then Library.Notification("Noclip: " .. msg, 3) end
	end
	local function nc_start(plan, char, hrp, hum)
		plan.start = hrp.CFrame
		plan.hum = hum
		plan.stood = hum.PlatformStand
		if plan.kind == "floor" then
			plan.u = plan.surf.Y - hrp.Position.Y
			plan.phase = 1
		else
			plan.u = math.max((hrp.Position - plan.surf):Dot(plan.n), -plan.feet)
			plan.phase = 0
		end
		plan.uStart = plan.u
		plan.phaseAt = os.clock()
		plan.waited = 0
		local base = nc_uac_pos()
		plan.uacBase = base and base - hrp.Position or nil
		plan.parts = {}
		for _, p in char:GetDescendants() do
			if p:IsA("BasePart") and p.CanCollide then
				plan.parts[#plan.parts + 1] = p
				p.CanCollide = false
			end
		end
		hum.PlatformStand = true
		nc_clip = plan
		cheat.clipActive = true
	end
	local function nc_step(dt, hrp)
		local c = nc_clip
		local now = os.clock()
		local target
		if c.phase == 0 then
			local k = math.min(1, (now - c.phaseAt) / NC_SINK)
			target = c.start:Lerp(nc_cf_at(c, c.u), 1 - (1 - k) ^ 4)
			if k >= 1 then c.phase = 1 c.phaseAt = now end
		elseif c.phase == 3 then
			local k = math.min(1, (now - c.phaseAt) / NC_RISE)
			target = nc_cf_at(c, c.uEnd):Lerp(c.final, 1 - (1 - k) ^ 4)
			if k >= 1 then
				hrp.CFrame = c.final
				return nc_finish(nil)
			end
		else
			local uac = c.uacBase and nc_uac_pos()
			c.held = uac and (uac - hrp.Position - c.uacBase).Magnitude > NC_HELD_DIST or false
			if c.held then
				c.waited = c.waited + dt
				if NC_HELD_TIME < c.waited then
					return nc_finish("back", "the server never caught up, put you back")
				end
			else
				c.waited = 0
				c.u = c.u + math.max(0.5, cheat.nc_state.speed) * math.min(dt, 0.1)
				if c.phase == 1 and c.u >= c.neck then c.phase = 2 c.phaseAt = now end
				if c.phase == 2 and c.u >= c.uEnd then
					c.u = c.uEnd
					if c.kind == "floor" then
						hrp.CFrame = nc_cf_at(c, c.uEnd)
						return nc_finish(nil)
					end
					c.phase = 3
					c.phaseAt = now
				end
			end
			target = nc_cf_at(c, c.u)
		end
		hrp.CFrame = target
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero
	end
	local function nc_probe(char, hrp, hum)
		if hum.Sit then return nil, "seated" end
		local cam_cf = Camera.CFrame
		local pos = hrp.Position
		nc_filter(char)
		local feet, neck, top = nc_dims(char, hrp, hum)
		local down = workspace:Raycast(pos, _Vector3new(0, -(feet + 3), 0), nc_ray)
		if hum.FloorMaterial == Enum.Material.Air and not down then
			return nil, "not on the ground"
		end
		local cam_hit = workspace:Raycast(cam_cf.Position, cam_cf.LookVector * math.min(80, (cam_cf.Position - pos).Magnitude + NC_REACH + 6), nc_ray)
		if not cam_hit then return nil end
		local look = hrp.CFrame.LookVector
		local flat = _Vector3new(look.X, 0, look.Z)
		local yaw = CFrame.lookAt(Vector3.zero, flat.Magnitude > 0.001 and flat.Unit or _Vector3new(0, 0, -1))
		local plan = {part = cam_hit.Instance, feet = feet, neck = neck, top = top}
		local layers = math.max(1, math.floor(cheat.nc_state.layers or 1))
		local dist2d = _Vector3new(cam_hit.Position.X - pos.X, 0, cam_hit.Position.Z - pos.Z).Magnitude
		if cam_hit.Normal.Y > 0.5 then
			if dist2d > NC_REACH + 3 or math.abs(cam_hit.Position.Y - pos.Y - feet) > 3 then return nil end
			if not nc_kind_allowed("Floors") then return nil, "floors are off" end
			if not (down and down.Normal.Y > 0.5) then return nil, "not standing on it" end
			plan.kind = "floor"
			plan.n = _Vector3new(0, -1, 0)
			plan.rot = yaw
			plan.surf = _Vector3new(pos.X, down.Position.Y, pos.Z)
			plan.part = down.Instance
			local need = feet + top + 0.3
			local thick, room, n = nc_scan_stack(plan.surf, plan.n, NC_MAXDROP + 0.5, need, NC_DROP_SEARCH + need + 1, layers)
			if not thick then return nil, room end
			if not room then return nil, "drop is past Max Drop" end
			plan.t = thick
			plan.layers = n
			local floor_y = plan.surf.Y - thick - top - 0.3
			plan.uEnd = plan.surf.Y - floor_y
			plan.final = _CFramenew(_Vector3new(pos.X, floor_y, pos.Z)) * yaw
			local blocked = nc_fit(char, plan.final, feet, top)
			if blocked then return nil, "blocked by " .. blocked.Name end
			return plan
		end
		if math.abs(cam_hit.Normal.Y) < 0.6 then
			if dist2d > NC_REACH + 3 or cam_hit.Position.Y < pos.Y - feet - 1 or cam_hit.Position.Y > pos.Y + top + 3 then return nil end
			if not nc_kind_allowed("Walls") then return nil, "walls are off" end
			local nrm = _Vector3new(-cam_hit.Normal.X, 0, -cam_hit.Normal.Z)
			if nrm.Magnitude < 0.001 then return nil, "too steep" end
			local dir = nrm.Unit
			local side = nil
			for _, h in {0, -feet * 0.6, neck} do
				local r = workspace:Raycast(pos + _Vector3new(0, h, 0), dir * (NC_REACH + 1.5), nc_ray)
				if r and math.abs(r.Normal.Y) < 0.6 then side = r break end
			end
			if not side then return nil, "too far to reach" end
			local out = _Vector3new(-side.Normal.X, 0, -side.Normal.Z).Unit
			plan.kind = "wall"
			plan.n = out
			plan.rot = CFrame.lookAt(Vector3.zero, out) * NC_WALL_ROT
			plan.surf = pos + out * (side.Position - pos):Dot(out)
			plan.part = side.Instance
			local thick, room, n = nc_scan_stack(plan.surf, out, NC_MAXDROP + 0.5, 1.6, top + 3.5, layers)
			if not thick then return nil, room end
			plan.t = thick
			plan.layers = n
			plan.uEnd = thick + top + 0.3
			local blocked_name = nil
			local nofloor = false
			for _, lift in {0, 0.75, 1.5, 2.5} do
				local d = thick + 0.9 + lift
				if room and d - thick + 0.6 > room then break end
				local beyond = plan.surf + out * d
				local floor_hit = workspace:Raycast(beyond + _Vector3new(0, 2.5, 0), _Vector3new(0, -(feet + 7), 0), nc_ray)
				local fy = floor_hit and floor_hit.Position.Y + feet
				if fy and fy <= pos.Y + 2.5 and fy >= pos.Y - 4 then
					local fpos = _Vector3new(beyond.X, fy, beyond.Z)
					local fcf = CFrame.lookAt(fpos, fpos + out)
					local b = nc_fit(char, fcf, feet, top)
					if not b then plan.final = fcf return plan end
					blocked_name = b
				else
					nofloor = true
				end
			end
			if blocked_name then return nil, "blocked by " .. blocked_name.Name end
			return nil, nofloor and "no floor behind it" or "no room behind it"
		end
		return nil, "too steep"
	end
	RunService.Stepped:Connect(function()
		local c = nc_clip
		if not c then return end
		for _, p in c.parts do
			if p.CanCollide then p.CanCollide = false end
		end
	end)
	RunService.Heartbeat:Connect(function(dt)
		local active = cheat.nc_state.on and cheat.nc_state.key
		local char, hrp, hum = nc_rig()
		local alive = hrp ~= nil and hum ~= nil and hum.Health > 0
		nc_label.Visible = active and alive
		if nc_clip then
			if not (alive and nc_clip.hum == hum) then
				nc_finish(nil)
			elseif not active then
				nc_finish((nc_clip.phase or 0) >= 2 and "finish" or "back")
			else
				local ok = pcall(nc_step, dt, hrp)
				if not ok then nc_finish("back", "stopped on an error, put you back") end
			end
			local c = nc_clip
			if c then
				local h = math.max(0.001, c.uEnd - c.uStart)
				local pct = math.floor(math.clamp((c.u - c.uStart) / h, 0, 1) * 100)
				nc_status(c.held and ("CLIPPING %d%%  waiting on server"):format(pct) or ("CLIPPING %d%%"):format(pct), NC_MID)
			end
			return
		end
		if not (active and alive) then nc_plan = nil return end
		local now = os.clock()
		if now - nc_last_probe >= NC_PROBE_WAIT then
			nc_last_probe = now
			local ok, plan, err = pcall(nc_probe, char, hrp, hum)
			nc_plan, nc_plan_err = ok and plan or nil, ok and err or "probe failed"
		end
		if nc_cooling then
			if nc_plan then
				nc_status("LOOK AWAY TO CLIP AGAIN", NC_IDLE)
				return
			end
			nc_cooling = false
		end
		if not nc_plan then
			nc_status(nc_plan_err and "NOT CLIPPABLE  " .. nc_plan_err or "NOT CLIPPABLE", nc_plan_err and NC_BAD or NC_IDLE)
			return
		end
		nc_status(("CLIPPABLE  %s %.1fst%s"):format(nc_plan.kind, nc_plan.t, (nc_plan.layers or 1) > 1 and (("  %d floors"):format(nc_plan.layers)) or ""), NC_OK)
		if nc_plan.part ~= nc_last_part then nc_last_part, nc_part_time = nc_plan.part, now end
		if now - nc_part_time >= NC_DWELL and now >= nc_cool_until then
			local q = nc_plan
			nc_plan = nil
			if not pcall(nc_start, q, char, hrp, hum) then
				nc_clip = q.parts and q or nil
				nc_finish("back", "could not start")
			end
		end
	end)
	LocalPlayer.CharacterAdded:Connect(function()
		nc_clip = nil
		nc_plan = nil
		nc_last_part = nil
		cheat.clipActive = false
	end)
end

local character, hrp, head

do
	local dscsec = ui.sections.custom_desync
	local expsec = ui.sections.exploit

	local desync_visualize = false
	local desync_x_offset, desync_y_offset, desync_z_offset = 0, 0, 0
	local desync_x_rotate, desync_y_rotate, desync_z_rotate = 0, 0, 0
	local desync_random_rotation, desync_random_position = false, false
	local desync_random_position_range = 5

	local desync_velocity = false
	local desync_velocity_x, desync_velocity_y, desync_velocity_z = 0, 0, 0

	local raksync, raksync_key, raksync_replicate_next = false, false, false

	local main_wireframe = Instance.new("WireframeHandleAdornment")
	main_wireframe.Parent = game:GetService("CoreGui").RobloxGui
	main_wireframe.Adornee = workspace
	main_wireframe.Color3 = Color3.new(1, 1, 1)
	main_wireframe.Transparency = 0
	main_wireframe.AlwaysOnTop = true
	main_wireframe.CFrame = CFrame.new()
	main_wireframe.Scale = Vector3.one
	main_wireframe.Thickness = 1
	main_wireframe.AdornCullingMode = Enum.AdornCullingMode.Automatic

	do
		local original_rate, original_bandwidth = getfflag("S2PhysicsSenderRate"), getfflag("PhysicsSenderMaxBandwidthBps")

		local desync_freeze, desync_freeze_key, desync_freeze_factor = false, false, 100
		local desync_ready, desync_turned_on = true, false

		local set_physics_rate = function(rate, bandwidth)
			setfflag("S2PhysicsSenderRate", tostring(rate))
			setfflag("PhysicsSenderMaxBandwidthBps", tostring(bandwidth))
		end

		local get_hrp = function()
			local character = LocalPlayer.Character
			return character and _FindFirstChild(character, "HumanoidRootPart")
		end

		local toggle_desync = function(state, reason)
			if not state then
				desync_turned_on = false
				if reason then
					Library.Notification(reason, 2.5)
				end
				return set_physics_rate(original_rate, original_bandwidth)
			end

			local hrp = get_hrp()
			if not hrp then return toggle_desync(false, "No character found.") end

			forced_cframe = nil

			set_physics_rate(32767, 32767 * 32)

			desync_turned_on = true
			RunService.Heartbeat:Wait()

			for _ = 1, 3 do
				hrp.AssemblyLinearVelocity += Vector3.new(0, 1, 0)
				RunService.Heartbeat:Wait()
				if not hrp then
					return toggle_desync(false, "Character destroyed in preparation process.")
				end
			end

			desync_ready = false
			forced_cframe = hrp.CFrame

			local recorded_time = tick()
			repeat until tick() - recorded_time > 0.8

			Library.Notification("Don't move for until this notification goes away.", 3)

			task.wait(3)

			set_physics_rate(15, 15 * 32)

			desync_ready = true
			forced_cframe = nil
		end

		local old = 0
		local isSleeping = false
		RunService.Heartbeat:Connect(function()
			if not (desync_turned_on) then
				return
			end

			local hrp = get_hrp()
			if not hrp then return end

			local now = tick()
			local factor = 1 / desync_freeze_factor
			if now - old >= factor then
				old = now
				isSleeping = not isSleeping
				sethiddenproperty(hrp, "NetworkIsSleeping", isSleeping)




			end
		end)

















	end

	getgenv().animbreaker_x = 0
	getgenv().animbreaker_y = 0
	getgenv().animbreaker_z = 0

	expsec:Slider({Name = "X animbreaker", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "animbreaker_x_offset", Callback = function(int)
		getgenv().animbreaker_x = int
	end})
	expsec:Slider({Name = "Y animbreaker", Min = -1.4, Max = 1.4, Float = 0.1, Value = 0, Flag = "animbreaker_y_offset", Callback = function(int)
		getgenv().animbreaker_y = int
	end})
	expsec:Slider({Name = "Z animbreaker", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "animbreaker_z_offset", Callback = function(int)
		getgenv().animbreaker_z = int * 100000
	end})

	local shitcode, shitcode_tick, shitcode_factor = false, tick(), 60
	local fps_limit_slider = nil
	local fps_toggle = expsec:Toggle({Name = "FPS limiter", Flag = "old_swimhub_mode", Value = false, Callback = function(v)
		shitcode = v
		shitcode_tick = tick()
		if fps_limit_slider then fps_limit_slider.State(v) end
		task.spawn(function()
			while shitcode do
				if tick() - shitcode_tick > 1/shitcode_factor then
					shitcode_tick = tick()
					RunService.RenderStepped:Wait()
				end
			end
		end)
	end})
	fps_limit_slider = expsec:Slider({Name = "FPS limit", Min = 2, Max = 60, Float = 0.1, Value = 0, Flag = "shitcode_factor", Callback = function(int)
		shitcode_factor = int
	end})
	fps_limit_slider.State(false)
	local bring_keybind; bring_keybind = expsec:Toggle({Name = "Bring vehicle", Value = false, Flag = "bring_vehicle", Callback = function(bool)
		cheat.feat.bring_vehicle = bool
	end}):Keybind({Name = "Bring vehicle", Mode = "Toggle", Key = Enum.KeyCode.V, Value = false, Flag = "bring_vehicle_key", Link = "bring_vehicle", Callback = function(bool)
		if bool and cheat.feat.bring_vehicle then
			task.spawn(function()
				local char = LocalPlayer.Character
				local hum = char and _FindFirstChildOfClass(char, "Humanoid")
				local hrp = char and _FindFirstChild(char, "HumanoidRootPart")
				if not (hum and hrp) then
					Library.Notification("Vehicle: be spawned in", 3)
					return
				end
				local folder = workspace:FindFirstChild("Vehicles")
				if not folder then
					Library.Notification("Vehicle: no Vehicles folder", 3)
					return
				end
				local best_seat, best_vehicle, best_d = nil, nil, math.huge
				for _, v in folder:GetChildren() do
					local seat = v:FindFirstChildWhichIsA("VehicleSeat", true) or v:FindFirstChildWhichIsA("Seat", true)
					if seat then
						local d = (seat.Position - hrp.Position).Magnitude
						if d < best_d then
							best_d = d
							best_seat = seat
							best_vehicle = v
						end
					end
				end
				if not best_seat then
					Library.Notification("Vehicle: none in loading radius", 3)
					return
				end
				Library.Notification("Vehicle: bringing " .. best_vehicle.Name, 3)
				pcall(function()
					hrp.CFrame = best_seat.CFrame + Vector3.new(0, 3, 0)
					task.wait(0.1)
					best_seat:Sit(hum)
				end)
			end)
			bring_keybind.Set(false, true)
		end
	end})
	local hover_keybind; hover_keybind = expsec:Toggle({Name = "Hover loot", Value = false, Flag = "hover_loot", Callback = function(bool)
		cheat.hover_loot_on = bool
		cheat.feat.hover_loot = bool
	end}):Keybind({Name = "Hover loot", Mode = "Hold", Key = Enum.KeyCode.M, Value = false, Flag = "hover_loot_key", Link = "hover_loot", Callback = function(bool)
		cheat.hover_loot_key = cheat.hover_loot_on and bool
		cheat.feat.hover_loot = cheat.hover_loot_on and bool
		hover_keybind.Set(cheat.hover_loot_key, true)
	end})
	do
		cheat.hover_loot_on, cheat.hover_loot_key = false, false
		local quickmove = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
		quickmove = quickmove and quickmove:FindFirstChild("QuickMove")
		local hover_last, hover_tick = nil, 0
		task.spawn(function()
			while task.wait() do
				if cheat.hover_loot_on and cheat.hover_loot_key and quickmove then
					local now = tick()
					if now - hover_tick >= 0.05 then
						hover_tick = now
						local mouse = LocalPlayer:GetMouse()
						local pg = LocalPlayer:FindFirstChild("PlayerGui")
						local frame = nil
						if pg then
							for _, obj in pg:GetGuiObjectsAtPosition(mouse.X, mouse.Y) do
								if obj:IsA("Frame") then
									local item = obj:FindFirstChild("Item")
									if item and item.Value then
										frame = obj
										break
									end
								end
							end
						end
						local item = frame and frame:FindFirstChild("Item")
						local ref = item and item.Value
						if frame and ref and ref.Parent and ref ~= hover_last then
							local data = project_delta.local_game_data
							local status = data and data:FindFirstChild("Status")
							local vars = status and status:FindFirstChild("GameplayVariables")
							local cont = vars and vars:FindFirstChild("CurrentContainer")
							if cont and cont.Value ~= nil then
								pcall(function()
									quickmove:FireServer(frame.Name, ref.Parent)
								end)
								hover_last = ref
							end
						elseif not frame then
							hover_last = nil
						end
					end
				else
					hover_last = nil
				end
			end
		end)
	end
	expsec:Toggle({Name = "Flashlight override", Value = false, Flag = "flashlight_override", Callback = function(bool)
		cheat.feat.flashlight_override = bool
	end})
	expsec:Toggle({Name = "Laser override", Value = false, Flag = "laser_override", Callback = function(bool)
		cheat.feat.laser_override = bool
	end})


		local ds_x_slider, ds_y_slider, ds_z_slider, ds_rx_slider, ds_ry_slider, ds_rz_slider = nil, nil, nil, nil, nil, nil
		local ds_randr_toggle, ds_randp_toggle, ds_range_slider, ds_vel_toggle, ds_vx_slider, ds_vy_slider, ds_vz_slider, ds_vis_toggle = nil, nil, nil, nil, nil, nil, nil, nil
		local ds_keybind; ds_keybind = dscsec:Toggle({Name = "Enabled", Value = false, Flag = "desync_enabled", Callback = function(bool)
			desync_enabled = bool
			local vis = bool and true or false
			if ds_x_slider then ds_x_slider.State(vis) end
			if ds_y_slider then ds_y_slider.State(vis) end
			if ds_z_slider then ds_z_slider.State(vis) end
			if ds_rx_slider then ds_rx_slider.State(vis) end
			if ds_ry_slider then ds_ry_slider.State(vis) end
			if ds_rz_slider then ds_rz_slider.State(vis) end
			if ds_randr_toggle then ds_randr_toggle.State(vis) end
			if ds_randp_toggle then ds_randp_toggle.State(vis) end
			if ds_range_slider then ds_range_slider.State(vis) end
			if ds_vel_toggle then ds_vel_toggle.State(vis) end
			if ds_vx_slider then ds_vx_slider.State(vis) end
			if ds_vy_slider then ds_vy_slider.State(vis) end
			if ds_vz_slider then ds_vz_slider.State(vis) end
			if ds_vis_toggle then ds_vis_toggle.State(vis) end
		end}):Keybind({Name = "Desync", Mode = "Toggle", Key = Enum.KeyCode.B, Value = false, Flag = "desync_enabled_key", Link = "desync_enabled", Callback = function(bool)
			desync_enabled_key = desync_enabled and bool
			ds_keybind.Set(desync_enabled_key, true)
		end})
		ds_vis_toggle = dscsec:Toggle({Name = "Visualize desync", Value = false, Flag = "desync_visualize", Callback = function(bool)
			desync_visualize = bool
		end})
		ds_vis_toggle:Colorpicker({Name = "Visualization color", Value = Color3.new(1, 1, 1), Usealpha = true, Flag = "desync_visualize_color", Callback = function(color)
			main_wireframe.Color3 = color.c
			main_wireframe.Transparency = color.a
		end})
		ds_vis_toggle.State(false)

		ds_x_slider = dscsec:Slider({Name = "X offset", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "desync_x_offset", Callback = function(int)
			desync_x_offset = int
		end})
		ds_x_slider.State(false)
		ds_y_slider = dscsec:Slider({Name = "Y offset", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "desync_y_offset", Callback = function(int)
			desync_y_offset = int
		end})
		ds_y_slider.State(false)
		ds_z_slider = dscsec:Slider({Name = "Z offset", Min = -10, Max = 10, Float = 0.1, Value = 0, Flag = "desync_z_offset", Callback = function(int)
			desync_z_offset = int
		end})
		ds_z_slider.State(false)

		ds_rx_slider = dscsec:Slider({Name = "X rotate", Min = 0, Max = 20, Float = 0.1, Value = 0, Flag = "desync_x_rotate", Callback = function(int)
			desync_x_rotate = math.rad(int * 18)
		end})
		ds_rx_slider.State(false)
		ds_ry_slider = dscsec:Slider({Name = "Y rotate", Min = 0, Max = 20, Float = 0.1, Value = 0, Flag = "desync_y_rotate", Callback = function(int)
			desync_y_rotate = math.rad(int * 18)
		end})
		ds_ry_slider.State(false)
		ds_rz_slider = dscsec:Slider({Name = "Z rotate", Min = 0, Max = 20, Float = 0.1, Value = 0, Flag = "desync_z_rotate", Callback = function(int)
			desync_z_rotate = math.rad(int * 18)
		end})
		ds_rz_slider.State(false)

		ds_randr_toggle = dscsec:Toggle({Name = "Random rotation", Value = false, Flag = "desync_random_rotation", Callback = function(bool)
			desync_random_rotation = bool
		end})
		ds_randr_toggle.State(false)
		ds_randp_toggle = dscsec:Toggle({Name = "Random position", Value = false, Flag = "desync_random_position", Callback = function(bool)
			desync_random_position = bool
		end})
		ds_randp_toggle.State(false)
		ds_range_slider = dscsec:Slider({Name = "Random range", Min = 0, Max = 25, Float = 0.1, Value = 0, Flag = "desync_random_position_range", Callback = function(int)
			desync_random_position_range = int
		end})
		ds_range_slider.State(false)

		ds_vel_toggle = dscsec:Toggle({Name = "Velocity desync", Value = false, Flag = "desync_velocity", Callback = function(bool)
			desync_velocity = bool
		end})
		ds_vel_toggle.State(false)
		ds_vx_slider = dscsec:Slider({Name = "Velocity X", Min = -16384, Max = 16384, Float = 512, Value = 0, Flag = "desync_velocity_x", Callback = function(int)
			desync_velocity_x = int
		end})
		ds_vx_slider.State(false)
		ds_vy_slider = dscsec:Slider({Name = "Velocity Y", Min = -16384, Max = 16384, Float = 512, Value = 0, Flag = "desync_velocity_y", Callback = function(int)
			desync_velocity_y = int
		end})
		ds_vy_slider.State(false)
		ds_vz_slider = dscsec:Slider({Name = "Velocity Z", Min = -16384, Max = 16384, Float = 512, Value = 0, Flag = "desync_velocity_z", Callback = function(int)
			desync_velocity_z = int
		end})
		ds_vz_slider.State(false)

	RunService.Heartbeat:Connect(LPH_NO_VIRTUALIZE(function()
		replicated_hrp_cframe = nil

		character = LocalPlayer.Character
		if not character then return end
		humanoid = _FindFirstChildOfClass(character, "Humanoid")
		hrp = _FindFirstChild(character, "HumanoidRootPart")
		head = _FindFirstChild(character, "Head")

		if not (humanoid and hrp) then return end
		if not (desync_enabled and desync_enabled_key) then return end

		old_cframe = hrp.CFrame
		old_velocity = hrp.AssemblyLinearVelocity

		local hrp_offset = _CFramenew()

		if not (forced_cframe) then
			hrp_offset = _CFramenew(
				desync_x_offset,
				desync_y_offset,
				desync_z_offset
			) * CFrame.Angles(
				desync_x_rotate,
				desync_y_rotate,
				desync_z_rotate
			)
			if desync_random_position then
				hrp_offset = hrp_offset + (
					CFrame.Angles(
						(mathrandom() - mathrandom()) * 2 * math.pi,
						(mathrandom() - mathrandom()) * 2 * math.pi,
						(mathrandom() - mathrandom()) * 2 * math.pi
					) * CFrame.new(0, 0, -desync_random_position_range)
				).Position
			end
			if desync_random_rotation then
				hrp_offset = hrp_offset * CFrame.Angles(
					(mathrandom() - mathrandom()) * 2 * math.pi,
					(mathrandom() - mathrandom()) * 2 * math.pi,
					(mathrandom() - mathrandom()) * 2 * math.pi
				)
			end
		end

		replicated_hrp_cframe = forced_cframe or old_cframe * hrp_offset

		hrp.CFrame = replicated_hrp_cframe

		if desync_velocity then
			hrp.AssemblyLinearVelocity = _Vector3new(
				desync_velocity_x,
				desync_velocity_y,
				desync_velocity_z
			)
		end

		RunService.RenderStepped:Wait()
		if not hrp then return end

		hrp.CFrame = old_cframe
		if desync_velocity then
			hrp.AssemblyLinearVelocity = old_velocity
		end
	end))

	local VERTICES = {

		_Vector3new(-1,-1,-1), _Vector3new(-1, 1,-1),
		_Vector3new(-1, 1,-1), _Vector3new(-1, 1, 1),
		_Vector3new(-1, 1, 1), _Vector3new(-1,-1, 1),
		_Vector3new(-1,-1, 1), _Vector3new(-1,-1,-1),

		_Vector3new( 1,-1,-1), _Vector3new( 1, 1,-1),
		_Vector3new( 1, 1,-1), _Vector3new( 1, 1, 1),
		_Vector3new( 1, 1, 1), _Vector3new( 1,-1, 1),
		_Vector3new( 1,-1, 1), _Vector3new( 1,-1,-1),

		_Vector3new(-1,-1,-1), _Vector3new( 1,-1,-1),
		_Vector3new(-1, 1,-1), _Vector3new( 1, 1,-1),
		_Vector3new(-1, 1, 1), _Vector3new( 1, 1, 1),
		_Vector3new(-1,-1, 1), _Vector3new( 1,-1, 1),
	}

	local skeleton_order = {
		["LeftFoot"] = true,
		["LeftLowerLeg"] = true,
		["LeftUpperLeg"] = true,
		["RightFoot"] = true,
		["RightLowerLeg"] = true,
		["RightUpperLeg"] = true,
		["LeftHand"] = true,
		["LeftLowerArm"] = true,
		["LeftUpperArm"] = true,
		["RightHand"] = true,
		["RightLowerArm"] = true,
		["RightUpperArm"] = true,
		["LowerTorso"] = true,
		["UpperTorso"] = true
	}

	local valid_parts = {
		["LeftFoot"] = true,
		["LeftLowerLeg"] = true,
		["LeftUpperLeg"] = true,
		["RightFoot"] = true,
		["RightLowerLeg"] = true,
		["RightUpperLeg"] = true,
		["LeftHand"] = true,
		["LeftLowerArm"] = true,
		["LeftUpperArm"] = true,
		["RightHand"] = true,
		["RightLowerArm"] = true,
		["RightUpperArm"] = true,
		["LowerTorso"] = true,
		["UpperTorso"] = true,
		["Head"] = true
	}

	local function isBodyPart(name)
		return valid_parts[name]
	end

	cheat.utility.new_renderstepped(LPH_NO_VIRTUALIZE(function(delta)
		main_wireframe:Clear()

		if not (desync_visualize) then return end
		if not (desync_enabled and desync_enabled_key) then return end
		if not (replicated_hrp_cframe) then return end

		local character = LocalPlayer.Character
		if not (character) then return end

		local parts = table.create(15)
		local c = 0
		for _, v in character:GetChildren() do
			if _IsA(v, "BasePart") and isBodyPart(v.Name) then
				c += 1
				parts[c] = {v.CFrame, v.Size}
			end
		end
		if c == 0 then return end

		local points = table.create(24 * c)
		c = 0
		for _, part in parts do
			for _, vertex in VERTICES do
				c += 1
				points[c] = (replicated_hrp_cframe):PointToWorldSpace(
					old_cframe:PointToObjectSpace(part[1]:PointToWorldSpace(vertex * part[2] * 0.5))
				) - workspace.WorldPivot.Position
			end
		end

		main_wireframe:AddLines(points)
	end))
end

do
	local worldbox = ui.sections.world_main_changer
	local miscbox = ui.sections.world_misc_changer
	do
		local lighting_changer, lighting_changing = false, false
		local old_lighting = {
			Ambient = Lighting.Ambient,
			OutdoorAmbient = Lighting.OutdoorAmbient,
			Brightness = Lighting.Brightness,
			ColorShift_Bottom = Lighting.ColorShift_Bottom,
			ColorShift_Top = Lighting.ColorShift_Top,
			GlobalShadows = Lighting.GlobalShadows,
			FogColor = Lighting.FogColor,
			FogEnd = Lighting.FogEnd,
			FogStart = Lighting.FogStart,
			ClockTime = Lighting.ClockTime,
		}
		local lighting_values = {
			Ambient = Color3.fromRGB(70, 70, 70),
			OutdoorAmbient = Color3.fromRGB(70, 70, 70),
			Brightness = 3,
			ColorShift_Bottom = Color3.new(),
			ColorShift_Top = Color3.new(),
			GlobalShadows = true,
			FogColor = Color3.fromRGB(192, 192, 192),
			FogEnd = 10000,
			FogStart = 0,
			ClockTime = 14.5,
		}

		local append_changes = function()
			lighting_changing = true
			for k, v in (lighting_changer and lighting_values or old_lighting) do
				Lighting[k] = v
			end
			lighting_changing = false
		end

		local light_ambient_picker, light_outdoor_picker, light_bright_slider, light_csb_picker, light_cst_picker, light_shadows_toggle, light_fogc_picker, light_foge_slider, light_fogs_slider, light_clock_slider = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
		local function light_gate(vis)
			if light_ambient_picker then light_ambient_picker.State(vis) end
			if light_outdoor_picker then light_outdoor_picker.State(vis) end
			if light_bright_slider then light_bright_slider.State(vis) end
			if light_csb_picker then light_csb_picker.State(vis) end
			if light_cst_picker then light_cst_picker.State(vis) end
			if light_shadows_toggle then light_shadows_toggle.State(vis) end
			if light_fogc_picker then light_fogc_picker.State(vis) end
			if light_foge_slider then light_foge_slider.State(vis) end
			if light_fogs_slider then light_fogs_slider.State(vis) end
			if light_clock_slider then light_clock_slider.State(vis) end
		end
		local light_toggle = worldbox:Toggle({Name = 'Lighting changer', Flag = 'world_lighting_changer', Value = false, Callback = function(first)
			lighting_changer = first
			light_gate(first)
			append_changes()
		end})
		light_ambient_picker = worldbox:Colorpicker({Name = 'Ambient', Flag = 'world_lighting_ambient', Value = Color3.fromRGB(70, 70, 70), Usealpha = false, Callback = function(Value)
			lighting_values.Ambient = Value.c
			append_changes()
		end})
		light_ambient_picker.State(false)
		light_outdoor_picker = worldbox:Colorpicker({Name = 'OutdoorAmbient', Flag = 'world_lighting_outdoorambient', Value = Color3.fromRGB(70, 70, 70), Usealpha = false, Callback = function(Value)
			lighting_values.OutdoorAmbient = Value.c
			append_changes()
		end})
		light_outdoor_picker.State(false)
		light_bright_slider = worldbox:Slider({Name = 'Brightness', Flag = 'world_lighting_brightness', Value = 1, Min = -5, Max = 15, Float = 0.01, Callback = function(State)
			lighting_values.Brightness = State
			append_changes()
		end})
		light_bright_slider.State(false)
		light_csb_picker = worldbox:Colorpicker({Name = 'ColorShift_Bottom', Flag = 'world_lighting_colorshift_bottom', Value = Color3.new(), Usealpha = false, Callback = function(Value)
			lighting_values.ColorShift_Bottom = Value.c
			append_changes()
		end})
		light_csb_picker.State(false)
		light_cst_picker = worldbox:Colorpicker({Name = 'ColorShift_Top', Flag = 'world_lighting_colorshift_top', Value = Color3.new(), Usealpha = false, Callback = function(Value)
			lighting_values.ColorShift_Bottom = Value.c
			append_changes()
		end})
		light_cst_picker.State(false)
		light_shadows_toggle = worldbox:Toggle({Name = 'GlobalShadows', Flag = 'world_lighting_globalshadows', Value = false, Callback = function(first)
			lighting_values.GlobalShadows = first
			append_changes()
		end})
		light_shadows_toggle.State(false)

		light_fogc_picker = worldbox:Colorpicker({Name = 'FogColor', Flag = 'world_lighting_fogcolor', Value = Color3.fromRGB(192, 192, 192), Usealpha = false, Callback = function(Value)
			lighting_values.FogColor = Value.c
			append_changes()
		end})
		light_fogc_picker.State(false)
		light_foge_slider = worldbox:Slider({Name = 'FogEnd', Flag = 'world_lighting_fogend', Value = 100,Min = 0,Max = 10000,Float = 100,Callback = function(State)
			lighting_values.FogEnd = State
			append_changes()
		end})
		light_foge_slider.State(false)
		light_fogs_slider = worldbox:Slider({Name = 'FogStart', Flag = 'world_lighting_fogstart', Value = 0,Min = 0,Max = 10000,Float = 100,Callback = function(State)
			lighting_values.FogStart = State
			append_changes()
		end})
		light_fogs_slider.State(false)
		light_clock_slider = worldbox:Slider({Name = 'ClockTime', Flag = 'world_lighting_clocktime', Value = 14.5,Min = 0,Max = 24,Float = 0.1,Callback = function(State)
			lighting_values.ClockTime = State
			append_changes()
		end})
		light_clock_slider.State(false)
		local no_fog = false
		worldbox:Toggle({Name = 'No fog', Flag = 'no_fog', Value = false, Callback = function(first)
			no_fog = first
			if no_fog then
				Lighting.FogStart = 0
				Lighting.FogEnd = 100000
			elseif lighting_changer then
				append_changes()
			else
				Lighting.FogStart = old_lighting.FogStart
				Lighting.FogEnd = old_lighting.FogEnd
			end
		end})

		for _, method in {"Ambient", "OutdoorAmbient", "Brightness", "ColorShift_Bottom", "ColorShift_Top", "GlobalShadows", "FogColor", "FogEnd", "FogStart", "ClockTime"} do
			Lighting:GetPropertyChangedSignal(method):Connect(function()
				if not lighting_changing then
					old_lighting[method] = Lighting[method]
				end
				if no_fog and (method == "FogStart" or method == "FogEnd") then
					Lighting.FogStart = 0
					Lighting.FogEnd = 100000
					return
				end
				if not lighting_changer then return end
				Lighting[method] = lighting_values[method]
			end)
		end
	end

	do
		miscbox:Toggle({Name = 'No grass', Flag = 'no_grass', Value = false, Callback = function(first)
			sethiddenproperty(workspace.Terrain, "Decoration", not first)
		end})
		local weather_mode, weather_on, grass_color, terrain_colors = "No Weather", false, Color3.fromRGB(90, 170, 90), false
		local weather_effect
		local weather_dropdown = nil
		local weather_toggle = miscbox:Toggle({Name = "Weather control", Value = false, Flag = "weather_enabled", Callback = function(bool)
			weather_on = bool
			if weather_dropdown then weather_dropdown.State(bool) end
		end})
		weather_dropdown = miscbox:Dropdown({Name = "Weather", Values = {"No Weather", "Clear", "Rain", "Snow", "Fog"}, Value = "No Weather", Flag = "weather_mode", Multi = false, Callback = function(value)
			weather_mode = value
		end})
		weather_dropdown.State(false)
		local terrain_grass_picker = nil
		local terrain_toggle = miscbox:Toggle({Name = "Terrain material Colors", Value = false, Flag = "terrain_colors", Callback = function(bool)
			terrain_colors = bool
			if terrain_grass_picker then terrain_grass_picker.State(bool) end
		end})
		terrain_grass_picker = miscbox:Colorpicker({Name = "Terrain grass color", Value = Color3.fromRGB(90, 170, 90), Usealpha = false, Flag = "terrain_grass_color", Callback = function(value)
			grass_color = value.c
			if terrain_colors then workspace.Terrain:SetMaterialColor(Enum.Material.Grass, value.c) end
		end})
		terrain_grass_picker.State(false)
		cheat.utility.new_renderstepped(function()
			if not weather_on then
				if weather_effect then weather_effect.Enabled = false end
				return
			end
			if not weather_effect then
				weather_effect = Instance.new("ColorCorrectionEffect")
				weather_effect.Name = "DeltaWeather"
				weather_effect.Parent = Lighting
			end
			weather_effect.Enabled = true
			weather_effect.TintColor = weather_mode == "Rain" and Color3.fromRGB(170, 190, 220) or weather_mode == "Snow" and Color3.fromRGB(220, 230, 255) or weather_mode == "Fog" and Color3.fromRGB(190, 190, 190) or Color3.new(1, 1, 1)
			weather_effect.Brightness = weather_mode == "Fog" and -0.05 or 0
			if terrain_colors and grass_color then
				workspace.Terrain:SetMaterialColor(Enum.Material.Grass, grass_color)
			end
		end)
		do
			local atmosphere = _FindFirstChildOfClass(Lighting, "Atmosphere")
			if not atmosphere then
				atmosphere = Instance.new("Atmosphere")
				atmosphere.Parent = Lighting
			end
			local atmosphere_changer, atmosphere_changing = false, false
			local old_atmosphere = {
				Density = atmosphere.Density,
				Offset = atmosphere.Offset,
				Color = atmosphere.Color,
				Decay = atmosphere.Decay,
				Glare = atmosphere.Glare,
				Haze = atmosphere.Haze
			}
			local atmosphere_values = {
				Density = 0.28,
				Offset = 1,
				Color = Color3.new(1, 1, 1),
				Decay = Color3.new(0.8, 0.8, 0.8),
				Glare = 1,
				Haze = 1
			}

			local append_changes = function()
				atmosphere_changing = true
				for k, v in (atmosphere_changer and atmosphere_values or old_atmosphere) do
					atmosphere[k] = v
				end
				atmosphere_changing = false
			end

			local atmo_density_slider, atmo_offset_slider, atmo_color_picker, atmo_decay_picker, atmo_glare_slider, atmo_haze_slider = nil, nil, nil, nil, nil, nil
			local atmo_toggle = miscbox:Toggle({Name = 'Atmosphere changer', Flag = 'world_atmosphere_changer', Value = false,Callback = function(first)
				atmosphere_changer = first
				local vis = first and true or false
				if atmo_density_slider then atmo_density_slider.State(vis) end
				if atmo_offset_slider then atmo_offset_slider.State(vis) end
				if atmo_color_picker then atmo_color_picker.State(vis) end
				if atmo_decay_picker then atmo_decay_picker.State(vis) end
				if atmo_glare_slider then atmo_glare_slider.State(vis) end
				if atmo_haze_slider then atmo_haze_slider.State(vis) end
				append_changes()
			end})
			atmo_density_slider = miscbox:Slider({Name = 'Density', Flag = 'world_atmosphere_density', Value = 0.9,Min = 0,Max = 1,Float = 0.01,Callback = function(State)
				atmosphere_values.Density = State
				append_changes()
			end})
			atmo_density_slider.State(false)
			atmo_offset_slider = miscbox:Slider({Name = 'Offset', Flag = 'world_atmosphere_offset', Value = 1,Min = 0,Max = 1,Float = 0.01,Callback = function(State)
				atmosphere_values.Offset = State
				append_changes()
			end})
			atmo_offset_slider.State(false)
			atmo_color_picker = miscbox:Colorpicker({Name = 'Color', Flag = 'world_atmosphere_color', Value = Color3.new(1, 1, 1), Usealpha = false, Callback = function(Value)
				atmosphere_values.Color = Value.c
				append_changes()
			end})
			atmo_color_picker.State(false)
			atmo_decay_picker = miscbox:Colorpicker({Name = 'Decay', Flag = 'world_atmosphere_decay', Value = Color3.new(0.8, 0.8, 0.8), Usealpha = false, Callback = function(Value)
				atmosphere_values.Decay = Value.c
				append_changes()
			end})
			atmo_decay_picker.State(false)
			atmo_glare_slider = miscbox:Slider({Name = 'Glare', Flag = 'world_atmosphere_glare', Value = 1,Min = 0,Max = 20,Float = 0.1,Callback = function(State)
				atmosphere_values.Glare = State
				append_changes()
			end})
			atmo_glare_slider.State(false)
			atmo_haze_slider = miscbox:Slider({Name = 'Haze', Flag = 'world_atmosphere_haze', Value = 1,Min = 0,Max = 20,Float = 0.1,Callback = function(State)
				atmosphere_values.Haze = State
				append_changes()
			end})
			atmo_haze_slider.State(false)

			for _, method in {"Density", "Offset", "Color", "Decay", "Glare", "Haze"} do
				atmosphere:GetPropertyChangedSignal(method):Connect(function()
					if not atmosphere_changing then
						old_atmosphere[method] = atmosphere[method]
					end
					if not atmosphere_changer then return end
					atmosphere[method] = atmosphere_values[method]
				end)
			end
		end
		do
			local bloom = _FindFirstChildOfClass(Lighting, "BloomEffect")
			if not bloom then
				bloom = Instance.new("BloomEffect")
				bloom.Parent = Lighting

			end
			local bloom_changer, bloom_changing = false, false
			local old_bloom = {
				Enabled = bloom.Enabled,
				Intensity = bloom.Intensity,
				Size = bloom.Size,
				Threshold = bloom.Threshold
			}
			local bloom_values = {
				Enabled = 0.28,
				Intensity = 1,
				Size = 56,
				Threshold = 2
			}

			local append_changes = function()
				bloom_changing = true
				for k, v in (bloom_changer and bloom_values or old_bloom) do
					bloom[k] = v
				end
				bloom_changing = false
			end

			local bloom_enabled_toggle, bloom_intensity_slider, bloom_size_slider, bloom_threshold_slider = nil, nil, nil, nil
			local bloom_toggle = miscbox:Toggle({Name = 'Bloom changer', Flag = 'world_bloom_changer', Value = false,Callback = function(first)
				bloom_changer = first
				local vis = first and true or false
				if bloom_enabled_toggle then bloom_enabled_toggle.State(vis) end
				if bloom_intensity_slider then bloom_intensity_slider.State(vis) end
				if bloom_size_slider then bloom_size_slider.State(vis) end
				if bloom_threshold_slider then bloom_threshold_slider.State(vis) end
				append_changes()
			end})
			bloom_enabled_toggle = miscbox:Toggle({Name = 'Enabled', Flag = 'world_bloom_enabled', Value = false,Callback = function(first)
				bloom_values.Enabled = first
				append_changes()
			end})
			bloom_enabled_toggle.State(false)
			bloom_intensity_slider = miscbox:Slider({Name = 'Intensity', Flag = 'world_bloom_intensity', Value = 1,Min = 0,Max = 5,Float = 0.01,Callback = function(State)
				bloom_values.Intensity = State
				append_changes()
			end})
			bloom_intensity_slider.State(false)
			bloom_size_slider = miscbox:Slider({Name = 'Size', Flag = 'world_bloom_size', Value = 56,Min = 0,Max = 80,Float = 1,Callback = function(State)
				bloom_values.Size = State
				append_changes()
			end})
			bloom_size_slider.State(false)
			bloom_threshold_slider = miscbox:Slider({Name = 'Threshold', Flag = 'world_bloom_threshold', Value = 2,Min = 0,Max = 10,Float = 0.1,Callback = function(State)
				bloom_values.Threshold = State
				append_changes()
			end})
			bloom_threshold_slider.State(false)

			for _, method in {"Intensity", "Size", "Threshold"} do
				bloom:GetPropertyChangedSignal(method):Connect(function()
					if not bloom_changing then
						old_bloom[method] = bloom[method]
					end
					if not bloom_changer then return end
					bloom[method] = bloom_values[method]
				end)
			end
		end
	end
end

do
	local skin_weapons_sec = ui.sections.skins_browser
	local skin_list_sec = ui.sections.skins_actions
	local mods_sec = ui.sections.weapon_mods
	local guns_sec = ui.sections.weapon_list

	local function skins_folder()
		return game:GetService("ReplicatedStorage"):FindFirstChild("Skins")
	end
	local function items_list()
		return game:GetService("ReplicatedStorage"):FindFirstChild("ItemsList")
	end
	local function items_models()
		return game:GetService("ReplicatedStorage"):FindFirstChild("ItemsListModels")
	end
	local function skin_item_names()
		local f = skins_folder()
		local out = {}
		if f then
			for _, i in f:GetChildren() do out[#out + 1] = i.Name end
		end
		table.sort(out)
		return out
	end
	local function item_icon(name)
		local list = items_list()
		if not list then return "" end
		local function icon_of(entry)
			if not entry then return nil end
			local props = entry:FindFirstChild("ItemProperties")
			if props then
				local attr = props:GetAttribute("ItemIcon") or props:GetAttribute("Icon")
				if type(attr) == "string" and attr:find("://", 1, true) then return attr end
				local icon = props:FindFirstChild("ItemIcon")
				if icon and icon.Image ~= "" then return icon.Image end
			end
			local deep = entry:FindFirstChild("ItemIcon", true)
			if deep and deep:IsA("ImageLabel") and deep.Image ~= "" then return deep.Image end
			return nil
		end
		local direct = list:FindFirstChild(name)
		local img = icon_of(direct)
		if img then return img end
		local f = skins_folder()
		local folder = f and f:FindFirstChild(name)
		if folder then
			for _, skn in folder:GetChildren() do
				local attr = skn:GetAttribute("ItemIcon")
				if type(attr) == "string" and attr:find("://", 1, true) then return attr end
				local sic = skn:FindFirstChild("ItemIcon", true)
				if sic and sic:IsA("ImageLabel") and sic.Image ~= "" then return sic.Image end
			end
		end
		local base = tostring(name):gsub("_unlocked$", ""):gsub("_T%d+$", "")
		if base ~= name then
			img = icon_of(list:FindFirstChild(base))
			if img then return img end
		end
		for _, entry in list:GetChildren() do
			if entry.Name == base or string.find(entry.Name, base, 1, true) or string.find(base, entry.Name, 1, true) then
				img = icon_of(entry)
				if img then return img end
			end
		end
		return ""
	end
	local function skin_icon(item, skin)
		local f = skins_folder()
		local folder = f and f:FindFirstChild(item)
		local skn = folder and folder:FindFirstChild(skin)
		if skn then
			local attr = skn:GetAttribute("ItemIcon")
			if type(attr) == "string" and attr:find("://", 1, true) then return attr end
			local icon = skn:FindFirstChild("ItemIcon", true)
			if icon and icon:IsA("ImageLabel") and icon.Image ~= "" then return icon.Image end
		end
		return item_icon(item)
	end
	local function skin_names_of(item, filter)
		local f = skins_folder()
		local folder = f and f:FindFirstChild(item)
		local out = {}
		if folder then
			for _, s in folder:GetChildren() do
				if not filter or filter == "" or string.find(string.lower(s.Name), string.lower(filter), 1, true) then
					out[#out + 1] = s.Name
				end
			end
		end
		table.sort(out)
		if #out == 0 then out = {"Default"} end
		return out
	end
	local skin_choices = {}
	local skin_item, skin_name, skin_filter = nil, "Default", ""
	local skin_auto = true
	local skin_last_model = nil
	local function skin_key_of(obj)
		if typeof(obj) ~= "Instance" or not obj:IsA("ObjectValue") then return nil end
		local ref = obj.Value
		if not ref then return nil end
		local props = ref:FindFirstChild("ItemProperties")
		local special = props and props:GetAttribute("SpecialSkinItem")
		if type(special) == "string" and special ~= "" then return special end
		return ref.Name
	end
	local function skin_owned(item)
		local out = {}
		local seen = {}
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
		local data = folder and folder:FindFirstChild(LocalPlayer.Name)
		if not data then return out end
		local valid = {[item] = true}
		local f = skins_folder()
		local skins = f and f:FindFirstChild(item)
		if skins then
			for _, s in skins:GetChildren() do
				local ms = s:GetAttribute("ModelSkin")
				if type(ms) == "string" and ms ~= "" then valid[ms] = true end
			end
		end
		local function scan(root)
			if not root then return end
			for _, v in root:GetChildren() do
				if not seen[v] and v:IsA("ObjectValue") then
					if valid[v.Name] or valid[skin_key_of(v) or ""] then
						seen[v] = true
						out[#out + 1] = v
					end
				end
				local inner = v:FindFirstChild("Inventory")
				if inner then scan(inner) end
			end
		end
		scan(data:FindFirstChild("Inventory"))
		scan(data:FindFirstChild("Hotbar"))
		return out
	end
	local function skin_stamp(obj, item, skin)
		local list = items_list()
		local f = skins_folder()
		local sk = f and f:FindFirstChild(item)
		local skn = sk and sk:FindFirstChild(skin)
		local model_skin = skn and skn:GetAttribute("ModelSkin")
		local target = (type(model_skin) == "string" and model_skin ~= "" and model_skin) or nil
		if not target and list and list:FindFirstChild(item) then target = item end
		if obj:GetAttribute("Skin") == skin and (not target or obj.Name == target) then return false end
		if target and obj.Name ~= target then
			obj.Name = target
			local ref = list and list:FindFirstChild(target)
			if ref then obj.Value = ref end
		end
		obj:SetAttribute("Skin", skin)
		return true
	end
	local function skin_apply(item, skin)
		local n = 0
		for _, obj in skin_owned(item) do
			if skin_stamp(obj, item, skin) then n += 1 end
		end
		local vm = Camera and _FindFirstChildOfClass(Camera, "Model")
		if vm then cheat.dressSkin(vm, item, skin) end
		local char = LocalPlayer.Character
		local tool = char and _FindFirstChildOfClass(char, "Tool")
		if tool then cheat.dressSkin(tool, item, skin) end
		return n
	end
	local function skin_serialize()
		local out = {}
		for item, skin in skin_choices do
			out[#out + 1] = item .. "/" .. skin
		end
		table.sort(out)
		return table.concat(out, ";")
	end
	Library.Flags["skins_saves"] = Library.Flags["skins_saves"] or ""
	Library.ConfigFlags["skins_saves"] = function(v)
		if type(v) ~= "string" or v == "" then return end
		local n = 0
		for chunk in v:gmatch("[^;]+") do
			local item, skin = chunk:match("^%s*([^/]+)/([^/]+)%s*$")
			if item and skin then
				skin_choices[item] = skin
				n += skin_apply(item, skin)
			end
		end
		Library.Flags["skins_saves"] = v
		Library.Notification("Skins loaded (" .. n .. " applied)", 3)
	end
	local function make_grid(parent)
		local f = Instance.new("Frame")
		f.Name = "IconGrid"
		f.BackgroundTransparency = 1
		f.BorderSizePixel = 0
		f.Size = UDim2.new(1, 0, 0, 0)
		f.AutomaticSize = Enum.AutomaticSize.Y
		f.Parent = parent
		local layout = Instance.new("UIGridLayout")
		layout.CellSize = UDim2.fromOffset(52, 52)
		layout.CellPadding = UDim2.fromOffset(4, 4)
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Parent = f
		local pad = Instance.new("UIPadding")
		pad.PaddingLeft = UDim.new(0, 10)
		pad.Parent = f
		return f
	end
	local function grid_cell(grid, image, caption, order)
		local b = Instance.new("ImageButton")
		b.Name = caption
		b.LayoutOrder = order or 0
		b.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
		b.BorderSizePixel = 0
		b.Image = image or ""
		b.ScaleType = Enum.ScaleType.Fit
		b.Parent = grid
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 1
		stroke.Color = Color3.fromRGB(70, 70, 70)
		stroke.Parent = b
		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.BorderSizePixel = 0
		label.AnchorPoint = Vector2.new(0, 1)
		label.Position = UDim2.new(0, 0, 1, 0)
		label.Size = UDim2.new(1, 0, 0, 14)
		label.Font = Enum.Font.Gotham
		label.TextSize = 9
		label.TextColor3 = Color3.fromRGB(220, 220, 220)
		label.TextStrokeTransparency = 0.5
		label.TextTruncate = Enum.TextTruncate.AtEnd
		label.Text = caption
		label.Parent = b
		return b, stroke
	end
	local skin_weapon_grid = make_grid(skin_weapons_sec.holder)
	local skin_grid = make_grid(skin_list_sec.holder)
	local skin_weapon_buttons, skin_buttons = {}, {}
	local function skin_select_weapon(item)
		skin_item = item
		for name, pair in skin_weapon_buttons do
			pair[2].Color = (name == item) and Library.Theme.accent or Color3.fromRGB(70, 70, 70)
		end
		for _, c in skin_grid:GetChildren() do
			if c:IsA("ImageButton") then c:Destroy() end
		end
		table.clear(skin_buttons)
		local names = skin_names_of(item, "")
		skin_name = names[1]
		for idx, name in names do
			local b, stroke = grid_cell(skin_grid, skin_icon(item, name), name, idx)
			skin_buttons[name] = {b, stroke}
			b.MouseButton1Click:Connect(function()
				skin_name = name
				for n2, pair in skin_buttons do
					pair[2].Color = (n2 == name) and Library.Theme.accent or Color3.fromRGB(70, 70, 70)
				end
			end)
		end
		local first = skin_buttons[skin_name]
		if first then first[2].Color = Library.Theme.accent end
	end
	local function skin_rebuild_weapons()
		for _, c in skin_weapon_grid:GetChildren() do
			if c:IsA("ImageButton") then c:Destroy() end
		end
		table.clear(skin_weapon_buttons)
		local items = skin_item_names()
		local idx = 0
		for _, item in items do
			if skin_filter == "" or string.find(string.lower(item), string.lower(skin_filter), 1, true) then
				idx += 1
				local b, stroke = grid_cell(skin_weapon_grid, item_icon(item), item, idx)
				skin_weapon_buttons[item] = {b, stroke}
				b.MouseButton1Click:Connect(function()
					skin_select_weapon(item)
				end)
			end
		end
		if skin_item and not skin_weapon_buttons[skin_item] then skin_item = nil end
	end
	skin_list_sec:Textbox({Name = "Search", Value = "", Flag = "skins_search", Callback = function()
		skin_filter = Library.Flags["skins_search"] or ""
		skin_rebuild_weapons()
		if skin_item and skin_weapon_buttons[skin_item] then skin_select_weapon(skin_item) end
	end})
	skin_list_sec:Button({Name = "Apply skin", Callback = function()
		if not skin_item or not skin_name then
			Library.Notification("Pick a weapon and a skin", 2.5)
			return
		end
		skin_choices[skin_item] = skin_name
		local n = skin_apply(skin_item, skin_name)
		Library.Flags["skins_saves"] = skin_serialize()
		Library.Notification("Skin set on " .. n .. " item(s): " .. skin_item, 3)
	end})
	skin_list_sec:Button({Name = "Remove skin", Callback = function()
		if not skin_item then
			Library.Notification("Pick a weapon first", 2.5)
			return
		end
		skin_choices[skin_item] = nil
		local n = skin_apply(skin_item, "Default")
		Library.Flags["skins_saves"] = skin_serialize()
		Library.Notification("Skin cleared on " .. n .. " item(s)", 3)
	end})
	skin_rebuild_weapons()
	cheat.utility.new_heartbeat(function()
		if not skin_auto then return end
		local vm = Camera and _FindFirstChildOfClass(Camera, "Model")
		if vm and vm ~= skin_last_model then
			skin_last_model = vm
			local it = _FindFirstChild(vm, "Item")
			local name = (it and skin_choices[it.Name] and it.Name) or (skin_choices[vm.Name] and vm.Name)
			if name then cheat.dressSkin(vm, name, skin_choices[name]) end
		end
	end)
	local skin_attr_tick = 0
	cheat.utility.new_heartbeat(function()
		if not skin_auto or os.clock() - skin_attr_tick < 2 then return end
		skin_attr_tick = os.clock()
		for item, skin in skin_choices do
			local owned = skin_owned(item)
			if #owned > 0 then
				local need = false
				for _, obj in owned do
					if obj:GetAttribute("Skin") ~= skin then need = true break end
				end
				if need then skin_apply(item, skin) end
			end
		end
	end)
	local attach_defaults = {
		AKMN = {Stock = "StockAKMN", Front = "FrontAKMN", Handle = "HandleAKMN", Magazine = "762x39MAG"},
		AKM = {Stock = "ImprStockAKM", Handle = "ImprHandleAKM", Magazine = "762x39ImprMAG"},
		SKS = {Stock = "StockSKS", Front = "FrontSKS"},
		M4 = {Stock = "StockM4", Front = "FrontM4", Handle = "HandleM4", Magazine = "Mag556"},
		ADAR15 = {Stock = "StockADAR", Front = "FrontADAR", Magazine = "Mag556"},
		FAL = {Stock = "StockFAL", Front = "FrontFAL", Handle = "HandleFAL"},
		AsVal = {Stock = "StockAsVal", Front = "FrontAsVal", Handle = "HandleAsVal", Magazine = "9x39Mag"},
		SOCOM556 = {Magazine = "Mag556"},
		SVD = {Stock = "StockSVD", Front = "FrontSVD", Magazine = "762x54Rnd10Mag"},
		Mosin = {Stock = "DefaultStockMosin", Front = "DefaultFrontMosin"},
		R700 = {Front = "FrontTimberwolf", Magazine = "MagR700"},
		TFZ98S = {Magazine = "MagTFZ98"},
		PPSH41 = {Stock = "StockPPSH41", Magazine = "762x25Rnd71Mag"},
		VZ61 = {Magazine = "9x18vzMag"},
		Saiga12 = {Front = "FrontSaiga", Magazine = "SaigaMag5rnd"},
		IZh81 = {Stock = "StockIZh81", Front = "FrontIZh81"},
		IZh12 = {Stock = "StockIZh12", Front = "FrontIZh12"},
		TOZ106 = {Magazine = "MagTOZ106"},
		Makarov = {Magazine = "9x18MakarovMAG"},
		GoldenMakarov = {Magazine = "9x18MakarovMAG"},
		MP443 = {Magazine = "9x19MP443MAG"},
		TT33 = {Magazine = "762x25TTMAG"},
		MK23 = {Magazine = "MK23ExtMag"}
	}
	local wep_edits = ""
	local wep_auto, wep_unlock = true, false
	local wep_weapon, wep_slot, wep_att = nil, nil, nil
	local wep_slot_dd, wep_att_dd
	local function wep_display(name)
		local list = items_list()
		local it = list and list:FindFirstChild(name)
		local props = it and it:FindFirstChild("ItemProperties")
		local disp = props and props:GetAttribute("Name")
		if type(disp) == "string" and disp ~= "" then return disp end
		return tostring(name)
	end
	local function wep_is_gun(name)
		local list = items_list()
		local it = list and list:FindFirstChild(name)
		local props = it and it:FindFirstChild("ItemProperties")
		if not props then return true end
		local t = props:GetAttribute("ItemType")
		if type(t) ~= "string" or t == "" then return true end
		return t == "RangedWeapon"
	end
	local function wep_gun_names()
		local models = items_models()
		local out = {}
		if models then
			for _, m in models:GetChildren() do
				if m:FindFirstChild("AttachmentPoints") and wep_is_gun(m.Name) then
					out[#out + 1] = m.Name
				end
			end
		end
		table.sort(out)
		return out
	end
	local function wep_slots(weapon)
		local models = items_models()
		local out = {}
		local seen = {}
		local m = models and models:FindFirstChild(weapon)
		local ap = m and m:FindFirstChild("AttachmentPoints")
		if ap then
			for _, s in ap:GetChildren() do
				if s.Name ~= "Magazine" and not seen[s.Name] then
					seen[s.Name] = true
					out[#out + 1] = s.Name
				end
			end
		end
		if wep_unlock then
			for _, s in {"Front", "Handle", "Stock", "Grip"} do
				if not seen[s] then
					seen[s] = true
					out[#out + 1] = s
				end
			end
		end
		table.sort(out)
		return out
	end
	local function wep_compat()
		local list = items_list()
		local map = {}
		if list then
			for _, it in list:GetChildren() do
				local props = it:FindFirstChild("ItemProperties")
				local cp = props and props:FindFirstChild("CompatibleParts")
				if cp then
					local ok, attrs = pcall(function() return cp:GetAttributes() end)
					if ok and type(attrs) == "table" then
						for att, slot in attrs do
							if type(slot) == "string" and slot ~= "" and list:FindFirstChild(att) then
								map[slot] = map[slot] or {}
								map[slot][att] = true
							end
						end
					end
				end
			end
		end
		return map
	end
	local wep_compat_cache = nil
	local function wep_options(weapon, slot)
		if not wep_compat_cache then wep_compat_cache = wep_compat() end
		local set = {}
		if wep_compat_cache[slot] then
			for att in wep_compat_cache[slot] do set[att] = true end
		end
		local def = attach_defaults[weapon] and attach_defaults[weapon][slot]
		if def then set[def] = true end
		local guess = items_list() and items_list():FindFirstChild(slot .. weapon)
		if guess then set[slot .. weapon] = true end
		local out = {}
		for att in set do out[#out + 1] = att end
		table.sort(out)
		return out
	end
	local function wep_owned(name)
		local out = {}
		local seen = {}
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
		local data = folder and folder:FindFirstChild(LocalPlayer.Name)
		if not data then return out end
		local function scan(root)
			if not root then return end
			for _, v in root:GetChildren() do
				if not seen[v] and v:FindFirstChild("Attachments") then
					if name == nil or v.Name == name then
						seen[v] = true
						out[#out + 1] = v
					end
				end
				local inner = v:FindFirstChild("Inventory")
				if inner then scan(inner) end
			end
		end
		scan(data:FindFirstChild("Inventory"))
		scan(data:FindFirstChild("Hotbar"))
		return out
	end
	local function wep_current(gun, slot)
		local atts = gun:FindFirstChild("Attachments")
		if not atts then return nil end
		for _, a in atts:GetChildren() do
			if a:GetAttribute("Slot") == slot then return a.Name end
		end
		return nil
	end
	local function wep_default(weapon, slot)
		local d = attach_defaults[weapon] and attach_defaults[weapon][slot]
		if d then return d end
		local guess = slot .. weapon
		if items_list() and items_list():FindFirstChild(guess) then return guess end
		return nil
	end
	local function wep_parse(str)
		local map = {}
		for chunk in tostring(str or ""):gmatch("[^;]+") do
			local w, s, a = chunk:match("^%s*([^/]+)/([^/]+)/([^/]+)%s*$")
			if w and s and a then
				map[w] = map[w] or {}
				map[w][s] = a
			end
		end
		return map
	end
	local function wep_serialize(map)
		local out = {}
		for w, slots in map do
			for s, a in slots do out[#out + 1] = w .. "/" .. s .. "/" .. a end
		end
		return table.concat(out, ";")
	end
	local function wep_stamp(gun, slot, att)
		local atts = gun:FindFirstChild("Attachments")
		if not atts then return end
		local cur = nil
		for _, a in atts:GetChildren() do
			if a:GetAttribute("Slot") == slot then cur = a break end
		end
		if not cur then
			cur = Instance.new("ObjectValue")
			cur.Parent = atts
		end
		pcall(function()
			cur.Name = att
			local list = items_list()
			cur.Value = list and list:FindFirstChild(att)
			cur:SetAttribute("Slot", slot)
			atts:SetAttribute(slot, att)
		end)
	end
	local function wep_apply_all()
		local map = wep_parse(wep_edits)
		if not next(map) then return 0 end
		local n = 0
		for _, gun in wep_owned(nil) do
			local slots = map[gun.Name]
			if slots then
				for slot, att in slots do
					if att == "-" then
						local atts = gun:FindFirstChild("Attachments")
						local cur = atts and (function()
							for _, a in atts:GetChildren() do
								if a:GetAttribute("Slot") == slot then return a end
							end
						end)()
						if cur then pcall(function() cur:Destroy() end) n += 1 end
					else
						wep_stamp(gun, slot, att)
						n += 1
					end
				end
			end
		end
		return n
	end
	local function wep_status()
		if not wep_weapon or not wep_slot then return "pick a weapon and slot" end
		local map = wep_parse(wep_edits)
		local edited = map[wep_weapon] and map[wep_weapon][wep_slot]
		if edited then return "edited: " .. edited end
		local gun = wep_owned(wep_weapon)[1]
		local fitted = gun and wep_current(gun, wep_slot)
		if fitted then return "fitted: " .. fitted end
		local def = wep_default(wep_weapon, wep_slot)
		if def then return "default: " .. def end
		return "empty"
	end
	local wep_refresh_slots, wep_refresh_atts
	local gun_grid = make_grid(guns_sec.holder)
	local att_grid = make_grid(mods_sec.holder)
	local gun_buttons, att_buttons = {}, {}
	wep_refresh_slots = function()
		local slots = wep_weapon and wep_slots(wep_weapon) or {}
		wep_slot = slots[1]
		if wep_slot_dd then
			wep_slot_dd.Refresh(slots)
			if wep_slot then wep_slot_dd.Set(wep_slot, true) end
		end
		wep_refresh_atts()
	end
	wep_refresh_atts = function()
		if not att_grid then return end
		for _, c in att_grid:GetChildren() do
			if c:IsA("ImageButton") then c:Destroy() end
		end
		table.clear(att_buttons)
		wep_att = "Empty"
		if not (wep_weapon and wep_slot) then return end
		local opts = wep_options(wep_weapon, wep_slot)
		local vals = {"Empty"}
		for _, o in opts do vals[#vals + 1] = o end
		for idx, name in vals do
			local b, stroke = grid_cell(att_grid, name == "Empty" and "" or item_icon(name), name, idx)
			att_buttons[name] = {b, stroke}
			b.MouseButton1Click:Connect(function()
				wep_att = name
				for n2, pair in att_buttons do
					pair[2].Color = (n2 == name) and Library.Theme.accent or Color3.fromRGB(70, 70, 70)
				end
			end)
		end
		local first = att_buttons["Empty"]
		if first then first[2].Color = Library.Theme.accent end
	end
	local function wep_select_gun(name)
		wep_weapon = name
		wep_compat_cache = nil
		for n2, pair in gun_buttons do
			pair[2].Color = (n2 == name) and Library.Theme.accent or Color3.fromRGB(70, 70, 70)
		end
		wep_refresh_slots()
	end
	do
		local guns = wep_gun_names()
		for idx, name in guns do
			local b, stroke = grid_cell(gun_grid, item_icon(name), name, idx)
			gun_buttons[name] = {b, stroke}
			b.MouseButton1Click:Connect(function()
				wep_select_gun(name)
			end)
		end
	end
	wep_slot_dd = mods_sec:Dropdown({Name = "Slot", Values = {}, Value = nil, Flag = "wep_slot", Multi = false, Callback = function(value)
		wep_slot = value
		wep_refresh_atts()
	end})
	mods_sec:Button({Name = "Apply attachment", Callback = function()
		if not wep_weapon or not wep_slot then
			Library.Notification("Pick a weapon and slot", 2.5)
			return
		end
		local map = wep_parse(wep_edits)
		map[wep_weapon] = map[wep_weapon] or {}
		if not wep_att or wep_att == "Empty" then
			map[wep_weapon][wep_slot] = "-"
		else
			map[wep_weapon][wep_slot] = wep_att
		end
		if not next(map[wep_weapon]) then map[wep_weapon] = nil end
		wep_edits = wep_serialize(map)
		Library.Flags["weapon_edits"] = wep_edits
		local n = wep_apply_all()
		Library.Notification("Edits: " .. wep_status() .. " (" .. n .. " stamped)", 3)
	end})
	mods_sec:Button({Name = "Clear slot", Callback = function()
		if not wep_weapon or not wep_slot then
			Library.Notification("Pick a weapon and slot", 2.5)
			return
		end
		local map = wep_parse(wep_edits)
		map[wep_weapon] = map[wep_weapon] or {}
		map[wep_weapon][wep_slot] = "-"
		if not next(map[wep_weapon]) then map[wep_weapon] = nil end
		wep_edits = wep_serialize(map)
		Library.Flags["weapon_edits"] = wep_edits
		local n = wep_apply_all()
		Library.Notification("Slot cleared (" .. n .. " removed)", 3)
	end})
	Library.Flags["weapon_edits"] = Library.Flags["weapon_edits"] or ""
	Library.ConfigFlags["weapon_edits"] = function(v)
		wep_edits = tostring(v or "")
		Library.Flags["weapon_edits"] = wep_edits
		local n = wep_apply_all()
		Library.Notification("Weapon edits loaded (" .. n .. " stamped)", 3)
	end
	local wep_auto_tick = 0
	cheat.utility.new_heartbeat(function()
		if wep_auto and wep_edits ~= "" and os.clock() - wep_auto_tick > 1 then
			wep_auto_tick = os.clock()
			wep_apply_all()
		end
	end)
end

do
	local Settings = ui.tabs.settings do
		local Main = ui.subtabs.settings_main do
			local Config = ui.sections.settings_config do
				local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })
				local LastFiles = Files
				local ConfigName;
				local ConfigList = Config:List({
					Values = Files,
					Value = Files[1] or "",
					Size = 135,
					Name = "",
					Flag = "settings_config_list",
					Search = true,
					Callback = function(v)
						if ConfigName and v then
							ConfigName.Set(v)
						end
					end
				})

				ConfigName = Config:Textbox({
					Name = "Name",
					Value = "",
					Flag = "settings_config_name"
				})

				Config:Button({
					Name = "Save",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_config_name"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ConfigFolder, ConfigName)

							if isfile(ConfigFilePath) then
								writefile(ConfigFilePath, Library:GetConfig())

								Library.Notification(
									string.format( "Successfully saved config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })

								ConfigList.Refresh(Files)

								ConfigList.Set(ConfigName)
							else
								writefile(ConfigFilePath, Library:GetConfig())

								Library.Notification(
									string.format( "Successfully created config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })

								ConfigList.Refresh(Files)

								ConfigList.Set(ConfigName)
							end
						else
							Library.Notification(
								string.format( "Invalid config name (%s).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
							)
						end
					end,
				})

				Config:Button({
					Name = "Load",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_config_list"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ConfigFolder, ConfigName)

							if isfile(ConfigFilePath) then
								Library.LoadConfig(readfile(ConfigFilePath))

								Library.Notification(
									string.format( "Successfully loaded config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)
							else
								Library.Notification(
									string.format( "Couldn't find config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)
							end
						end
					end,
				})

				Config:Button({
					Name = "Delete",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_config_list"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ConfigFolder, ConfigName)

							if isfile(ConfigFilePath) then
								delfile(ConfigFilePath)

								Library.Notification(
									string.format( "Successfully deleted config (%s.cfg).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })

								ConfigList.Refresh(Files)

								ConfigList.Set(Files[1] or "")
							end
						end
					end,
				})

	task.spawn(function()
		while task.wait(5) do
			if ui.window.Visible then
				local _, Files = Utility.GetFiles(ConfigFolder, { ".cfg" })

							if #Files ~= #LastFiles then
								LastFiles = Files

								ConfigList.Refresh(Files)

								ConfigList.Set(Files[1] or "")
							end
						end
					end
				end)
			end

			local Personalization = ui.sections.settings_personalization
			do
				local TweenTypes = {}
				for _,v in Enum.EasingStyle:GetEnumItems() do
					table.insert(TweenTypes, v.Name)
				end
				Personalization:Keybind({Name = "Window key", Ignore = true, Key = Enum.KeyCode.Delete, Flag = "menu_key", Callback = function()
					ui.window.Open()
				end})

				local Watermark = Library:Watermark({
					titlestart = "swim",
					titleend = "hub"
				})
				local WatermarkText;
				Personalization:Toggle({Name = "Watermark", Flag = "menu_watermark", Value = true, Callback = function(v)
					Watermark.SetVisible(v)
					if WatermarkText then
						WatermarkText.State(v)
					end
				end})
				WatermarkText = Personalization:Textbox({
					Name = "Watermark text",
					Value = "ping: {ping}ms | fps: {fps} | user: {user} | {date}",
					Flag = "menu_watermark_text",
					Callback = function(v)
						Watermark.SetText(v)
					end
				})
				Personalization:Toggle({Name = "Keybind list", Flag = "menu_keybind_list", Value = true, Callback = function(v)
					Library.KeybindsList.Status(v)
				end})
				Personalization:Dropdown({Name = "Keybind style", Values = {"Pressed", "All"}, Value = "All", Flag = "menu_keybind_style", Multi = false, Callback = function(v)
					Library.KeybindsList.View = v
					Library.KeybindsList.Refresh()
				end})
				Personalization:Slider({Name = "Animations", Min = 0, Max = 100, Value = 40, Flag = "menu_animation_speed", Callback = function(v)
					Library.TweenSpeed = v / 100
				end})
				Personalization:Dropdown({Name = "", Values = TweenTypes, Value = "Exponential", Flag = "menu_animation_type", Callback = function(v)
					Library.TweenStyle = Enum.EasingStyle[v]
				end})
			end
		end
		local Theme = ui.subtabs.settings_theme do
			local ThemeColorpickers = { }

			local Config = ui.sections.theme_config do
				local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })
				local LastFiles = Files
				local ThemeName;
				local ThemeList = Config:List({
					Values = Files,
					Value = Files[1] or "",
					Size = 135,
					Name = "",
					Flag = "settings_theme_list",
					Search = true,
					Callback = function(v)
						if ThemeName and v then
							ThemeName.Set(v)
						end
					end
				})
				ThemeName = Config:Textbox({
					Name = "Name",
					Value = "",
					Flag = "settings_theme_name"
				})

				Config:Button({
					Name = "Save",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_theme_name"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ThemeFolder, ConfigName)

							if isfile(ConfigFilePath) then
								writefile(ConfigFilePath, Library.GetTheme())

								Library.Notification(
									string.format( "Successfully saved theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })

								ThemeList.Refresh(Files)

								ThemeList.Set(ConfigName)
							else
								writefile(ConfigFilePath, Library.GetTheme())

								Library.Notification(
									string.format( "Successfully created theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })

								ThemeList.Refresh(Files)

								ThemeList.Set(ConfigName)
							end
						else
							Library.Notification(
								string.format( "Invalid theme name (%s).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
							)
						end
					end,
				})

				Config:Button({
					Name = "Load",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_theme_list"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ThemeFolder, ConfigName)

							if isfile(ConfigFilePath) then
								local Data = Library.GetThemeData(readfile(ConfigFilePath))

								for theme, v in Data do
									ThemeColorpickers[theme].Set({c = v, a = 0})
								end

								Library.Notification(
									string.format( "Successfully loaded theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)
							else
								Library.Notification(
									string.format( "Couldn't find theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)
							end
						end
					end,
				})

				Config:Button({
					Name = "Delete",
					Confirm = true,
					Callback = function()
						local ConfigName = Library.Flags["settings_theme_list"]

						if ConfigName and ConfigName ~= "" then
							local ConfigFilePath = string.format("%s%s.cfg", ThemeFolder, ConfigName)

							if isfile(ConfigFilePath) then
								delfile(ConfigFilePath)

								Library.Notification(
									string.format( "Successfully deleted theme (%s.theme).", Utility.RichText( ConfigName, Library.Theme.accent ) ), 5
								)

								local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })

								ThemeList.Refresh(Files)

								ThemeList.Set(Files[1] or "")
							end
						end
					end,
				})

	task.spawn(function()
		while task.wait(5) do
			if ui.window.Visible then
				local _, Files = Utility.GetFiles(ThemeFolder, { ".cfg" })

							if #Files ~= #LastFiles then
								LastFiles = Files

								ThemeList.Refresh(Files)

								ThemeList.Set(Files[1] or "")
							end
						end
					end
				end)
			end

			local Colors = ui.sections.theme_colors do
				for theme, color in (Library.Theme) do
					ThemeColorpickers[theme] = Colors:Colorpicker({Name = Utility.ToTitleCase(theme), Flag = "settings_" .. theme, Usealpha = true, Ignore = true, Value = color, Callback = function(v)
						Library.UpdateTheme(theme, v.c)
					end})
				end
			end
		end
	end
end
do
	local TweenService = game:GetService("TweenService")
	local GuiService = game:GetService("GuiService")

	local bullet_infos = cheat.bullet_infos









	local get_estimated_origin = project_delta.get_estimated_origin

	local __newindex; __newindex = hookmetamethod(game, "__newindex", newcclosure(LPH_NO_VIRTUALIZE(function(self, idx, val)
		if self == Camera and idx == "CFrame" then
			if thirdperson and thirdperson_key then
				val = val + (val.LookVector * -thirdperson_distance)
			end
			if aspect_ratio then
				val = val * _CFramenew(
					0, 0, 0,
					aspect_ratio_x, 0, 0,
					0, aspect_ratio_y, 0,
					0, 0, 1
				)
			end
		end
		return __newindex(self, idx, val)
	end)))

	local __index; __index = hookmetamethod(game, '__index', newcclosure(LPH_NO_VIRTUALIZE(function(self, key)
		if checkcaller() then return __index(self, key) end
		if key == 'CFrame' and (self == hrp or self == head) and desync_enabled and desync_enabled_key and old_cframe then
			if self == hrp then
				return old_cframe
			end
			if self == head then
				return old_cframe * _CFramenew(
					0,
					hrp.Size.Y / 2 + head.Size.Y / 2,
					0
				) or _CFramenew()
			end
		end
		if key == "ReducedMotionEnabled" and no_recoil and self == GuiService then
			return true
		end
		return __index(self, key)
	end)))

	local __namecall; __namecall = hookmetamethod(game, "__namecall", newcclosure(LPH_NO_VIRTUALIZE(function(self, ...)
		local args = {...}
		local method = getnamecallmethod()

		if method == "FireServer" and self.Name == "Trap" and Library.Flags["misc_remove_mines"] then
			return
		end

		if method == "Raycast" and cheat.ignore_water and self == workspace then
			local ray_args = {...}
			if ray_args[3] then
				ray_args[3].IgnoreWater = true
				return __namecall(self, unpack(ray_args))
			end
		end
		if method == "Raycast" and aimbot_mode == "Silent" then
			local hitpart = target_part
			if not (hitpart and debugtraceback():find("Bullet")) then
				return __namecall(self, ...)
			end




			local hitpos = hitpart.Position

			if silent_forcehit then
				return {
					Instance = hitpart,
					Position = hitpos,
					Distance = (hitpos - args[1]).Magnitude,
					Normal = _Vector3new(1, 0, 0),
					Material = hitpart.Material
				}
			end

			local origin = args[1]
			local direction = args[2]

			args[2] = (hitpos - origin)

			return __namecall(self, unpack(args))
		end
		if self == TweenService and method == "Create" and args[1] == Camera and (zoom and zoom_key or fov_changer) then
			args[3]["FieldOfView"] = nil
			return __namecall(self, unpack(args))
		end
		if method == "Play" and self.ClassName == "AnimationTrack" then
			local name = self.Name
			if name == "Equip" and instant_equip then
				__namecall(self, ...)
				self.TimePosition = self.Length
				return
			end
		end
		if method == "GetAttribute" then
			local attribute = args[1]
			if attribute == "AccuracyDeviation" and no_spread then
				return 0
			end
		end
		if method == "InvokeServer" then
			local remote_name = self.Name
			if remote_name == "Drowning" and cheat.anti_drown then
				return nil
			end
			if remote_name == "FireProjectile" and aimbot_mode == "Silent" then
				local r = table.create(3)
				r[1] = args[2]
				r[2] = args[3]
				r[3] = args[1]
				bullet_infos[args[2]] = r
				return __namecall(self, unpack(args))
			end
		end
		if method == "FireServer" then
			local remote_name = self.Name
			if remote_name == "UpdateCrouch" and cheat.fake_crouch then
				args[1] = true
				return __namecall(self, unpack(args))
			end
			if remote_name == "ProjectileInflict" then
				if debugtraceback():find("CharacterController") then
					return coroutine.yield()
				end
				if aimbot_mode == "Silent" then
					args[4] = bullet_infos[args[3]][2] + 5
				end
				if hit_sound then
					task.defer(function()
						local sound = hit_sound_instance:Clone()
						sound.Volume = hit_sound_volume
						sound.PlaybackSpeed = hit_sound_speed
						sound.Parent = SoundService
						sound.PlayOnRemove = true
						sound:Destroy()
					end)
				end
				if hit_logs then
					local parent_model = args[1]
					repeat parent_model = parent_model.Parent until parent_model == nil or parent_model.ClassName == "Model"
					if parent_model then
						notification_queue[#notification_queue + 1] = {
							text = `Hit {Utility.RichText(parent_model.Name, Library.Theme.accent)} in the {Utility.RichText(args[1].Name, Library.Theme.accent)}`,
							duration = hit_logs_duration
						}
					end
				end

				return __namecall(self, unpack(args))
			end
			if remote_name == "UpdateTilt" and antiaim and antiaim_pitch then
				args[1] = antiaim_pitch_value
				args[2] = 0
				args[3] = nil
				args[4] = nil
				return __namecall(self, unpack(args))
			end
			if remote_name == "Drowning" and cheat.anti_drown then
				return
			end
		end

		return __namecall(self, ...)
	end)))
end

cheat.EspLibrary.load()

if project_delta.fps_object then
	project_delta.fps_bindable:Fire()
end

task.spawn(function()




















	cheat.CrossScriptChat = {SetSendingEnabled=function(...)end}
end)

do
	local mine_folders = {
		"OutpostLandmines",
		"OutpostClaymores",
		"HeliCrashClaymores",
		"ShipWreckClaymores",
		"BridgeClaymores"
	}

	local function is_mine_name(name)
		name = string.lower(name)
		return string.find(name, "landmine", 1, true) ~= nil or string.find(name, "claymore", 1, true) ~= nil
	end

	local function destroy_in(root)
		for _, folder_name in mine_folders do
			local folder = root:FindFirstChild(folder_name)
			if folder then
				for _, mine in folder:GetChildren() do
					pcall(function() mine:Destroy() end)
				end
			end
		end
	end

	local function each_mine(fn)
		local roots = {
			workspace:FindFirstChild("AiZones"),
			workspace:FindFirstChild("NoCollision") and workspace.NoCollision:FindFirstChild("AiZones")
		}
		for _, root in roots do
			if root then
				for _, folder_name in mine_folders do
					local folder = root:FindFirstChild(folder_name)
					if folder then
						for _, mine in folder:GetChildren() do
							fn(mine)
						end
					end
				end
			end
		end
		for _, inst in workspace:GetDescendants() do
			if is_mine_name(inst.Name) and (inst:IsA("BasePart") or inst:IsA("Model")) then
				fn(inst.Parent:IsA("Model") and inst.Parent or inst)
			end
		end
	end

	local mine_manip, mine_mode = false, "Explode All"
	local miscsec = ui.sections.misc
	local mine_mode_dropdown = nil
	local mine_toggle = miscsec:Toggle({Name = "Mine manipulation", Value = false, Flag = "mine_manip_enabled", Callback = function(bool)
		mine_manip = bool
		cheat.feat.mine_manipulation = bool
		if mine_mode_dropdown then mine_mode_dropdown.State(bool) end
	end})
	mine_mode_dropdown = miscsec:Dropdown({Name = "Mine mode", Values = {"Explode All", "Deactivate All"}, Value = "Explode All", Flag = "mine_manip_mode", Multi = false, Callback = function(str)
		mine_mode = str
	end})
	mine_mode_dropdown.State(false)
	task.spawn(function()
		while task.wait(0.5) do
			if mine_manip then
				if mine_mode == "Explode All" and firetouchinterest then
					pcall(function()
						local char = LocalPlayer.Character
						local leg = char and (char:FindFirstChild("LeftLowerLeg") or char:FindFirstChild("HumanoidRootPart"))
						if not leg then return end
						each_mine(function(mine)
							local trigger = mine:FindFirstChild("Trigger")
							if trigger then
								pcall(firetouchinterest, leg, trigger, 0)
								pcall(firetouchinterest, leg, trigger, 1)
							end
						end)
					end)
				elseif mine_mode == "Deactivate All" then
					pcall(function()
						each_mine(function(mine)
							local trigger = mine:FindFirstChild("Trigger")
							if trigger then
								pcall(function() trigger:Destroy() end)
							end
						end)
					end)
					task.wait(5)
				else
					task.wait(1)
				end
			end
		end
	end)

	cheat.fake_crouch = false
	miscsec:Toggle({Name = "Fake crouch", Value = false, Flag = "misc_fake_crouch", Callback = function(bool)
		cheat.fake_crouch = bool
		if bool then
			pcall(function()
				local rems = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
				local uc = rems and rems:FindFirstChild("UpdateCrouch")
				if uc then
					uc:FireServer(true)
				end
			end)
		end
	end})
	local fake_map_owned = {}
	local function fake_map_inventory()
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
		local data = folder and folder:FindFirstChild(LocalPlayer.Name)
		return data and data:FindFirstChild("Inventory")
	end
	local function fake_map_apply()
		local inv = fake_map_inventory()
		if not inv then return end
		local list = game:GetService("ReplicatedStorage"):FindFirstChild("ItemsList")
		for _, entry in {{name = "DAGR", slot = "EquipmentGPS"}, {name = "EstonianBorderMap", slot = "EquipmentMap"}, {name = "Pathfinder", slot = "EquipmentCompass"}} do
			local has = inv:FindFirstChild(entry.name)
			if not has then
				local obj = Instance.new("ObjectValue")
				obj.Name = entry.name
				if list then obj.Value = list:FindFirstChild(entry.name) end
				obj:SetAttribute("Slot", entry.slot)
				obj.Parent = inv
				fake_map_owned[entry.name] = obj
			end
		end
	end
	local function fake_map_remove()
		for name, obj in fake_map_owned do
			if obj and obj.Parent then pcall(function() obj:Destroy() end) end
			fake_map_owned[name] = nil
		end
	end
	miscsec:Toggle({Name = "Fake map", Value = false, Flag = "fake_map", Callback = function(bool)
		if bool then
			pcall(fake_map_apply)
		else
			pcall(fake_map_remove)
		end
	end})
	local mod_enabled, mod_volume = false, 3
	local mod_tracked = {}
	local mod_group_id = 3765739
	local mod_group_roles = {
		["Tester"] = true,
		["Content Creator"] = true,
		["Test Coordinator"] = true,
		["New Devs"] = true,
		["Dev Team"] = true,
		["Moderator"] = true,
		["Head Moderator"] = true,
		["Admin"] = true,
		["Developer"] = true,
		["Lead developer"] = true
	}
	local mod_group_cache = {}
	local function mod_group_role(player)
		if player == LocalPlayer then return false end
		local cached = mod_group_cache[player]
		if cached ~= nil then return cached end
		mod_group_cache[player] = false
		task.spawn(function()
			local ok, role = pcall(function()
				return player:GetRoleInGroup(mod_group_id)
			end)
			if ok and role and mod_group_roles[role] then
				mod_group_cache[player] = true
			end
		end)
		return false
	end
	local function mod_play(asset)
		if asset == "" then return end
		local s = Instance.new("Sound")
		s.SoundId = asset
		s.Volume = mod_volume
		s.Parent = SoundService
		s.PlayOnRemove = true
		s:Destroy()
	end
	local function mod_is_mod(player)
		if player == LocalPlayer then return false end
		return mod_group_role(player)
	end
	local function mod_scan()
		for _, player in Players:GetPlayers() do
			if mod_is_mod(player) then
				if not mod_tracked[player] then
					mod_tracked[player] = true
					Library.Notification("moderator join " .. player.Name, 9999)
					mod_play(admin_join_asset)
				end
			elseif mod_tracked[player] then
				mod_tracked[player] = nil
				Library.Notification("moderator leave " .. player.Name, 9999)
				mod_play(admin_leave_asset)
			end
		end
	end
	local mod_volume_slider = nil
	local mod_toggle = miscsec:Toggle({Name = "Moderator detector", Value = false, Flag = "misc_moderator_detector", Callback = function(bool)
		mod_enabled = bool
		if mod_volume_slider then mod_volume_slider.State(bool) end
		if bool then
			mod_scan()
		else
			table.clear(mod_tracked)
		end
	end})
	mod_volume_slider = miscsec:Slider({Name = "Moderator volume", Min = 0.1, Max = 10, Float = 0.1, Value = 3, Flag = "misc_moderator_volume", Suffix = "%s", Callback = function(int)
		mod_volume = int
	end})
	mod_volume_slider.State(false)
	local cheater_detector = false
	miscsec:Toggle({Name = "Cheater detector", Value = false, Flag = "cheatwatch_enabled", Callback = function(bool)
		cheater_detector = bool
	end})
	Players.PlayerRemoving:Connect(function(player)
		mod_group_cache[player] = nil
		if mod_tracked[player] then
			mod_tracked[player] = nil
			if mod_enabled then
				Library.Notification("moderator leave " .. player.Name, 9999)
				mod_play(admin_leave_asset)
			end
		end
	end)
	task.spawn(function()
		while task.wait(2) do
			if mod_enabled then
				mod_scan()
			end
		end
	end)
	miscsec:Toggle({Name = "Report notifications", Value = false, Flag = "misc_report_notifications", Callback = function(bool)
		cheat.report_notifications = bool
	end})
	miscsec:Button({Name = "Show current Reports", Callback = function()
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
		local data = folder and folder:FindFirstChild(LocalPlayer.Name)
		local status = data and data:FindFirstChild("Status")
		local uac = status and status:FindFirstChild("UAC")
		local reports = uac and uac:FindFirstChild("Reports")
		local total = reports and reports:GetAttribute("1") or 0
		Library.Notification("You currently have " .. tostring(total) .. " report(s)", 4)
	end})
	cheat.report_notifications = false
	local report_last_total = nil
	local function report_total()
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
		local data = folder and folder:FindFirstChild(LocalPlayer.Name)
		local status = data and data:FindFirstChild("Status")
		local uac = status and status:FindFirstChild("UAC")
		local reps = uac and uac:FindFirstChild("Reports")
		if not reps then return 0 end
		local n = 0
		for _, v in reps:GetAttributes() do
			if typeof(v) == "number" then
				n += v
			end
		end
		return n
	end
	task.spawn(function()
		while task.wait(0.5) do
			if cheat.report_notifications then
				local total = report_total()
				if report_last_total == nil then
					report_last_total = total
				elseif total > report_last_total then
					Library.Notification("You were reported! (+" .. (total - report_last_total) .. " report(s), Total: " .. total .. ")", 7)
					report_last_total = total
				elseif total < report_last_total then
					report_last_total = total
				end
			end
		end
	end)
	local recent_folder = game:GetService("ReplicatedStorage"):FindFirstChild("ReportList")
	recent_folder = recent_folder and recent_folder:FindFirstChild("Recent")
	if recent_folder then
		recent_folder.ChildAdded:Connect(function(child)
			if cheat.report_notifications then
				local name = child.Name:match("(.+)_([^_]+)$")
				if name == LocalPlayer.Name then
					Library.Notification("Added to Recent Reports list!", 7)
				end
			end
		end)
	end
	miscsec:Button({Name = "Diag", Callback = function()
		local out = {}
		local itemslist = game:GetService("ReplicatedStorage"):FindFirstChild("ItemsList")
		if itemslist then
			local names = {}
			for _, item in itemslist:GetChildren() do
				names[#names + 1] = item.Name .. " (" .. item.ClassName .. ")"
				if #names >= 60 then
					break
				end
			end
			out[#out + 1] = "items=" .. table.concat(names, "|")
		else
			out[#out + 1] = "items=none"
		end
		local roots = {
			workspace:FindFirstChild("AiZones"),
			workspace:FindFirstChild("NoCollision") and workspace.NoCollision:FindFirstChild("AiZones")
		}
		for _, root in roots do
			if root then
				local found = {}
				for _, f in root:GetChildren() do
					found[#found + 1] = f.Name .. "x" .. #f:GetChildren()
					if #found >= 25 then
						break
					end
				end
				out[#out + 1] = "root=" .. root:GetFullName() .. " folders=" .. table.concat(found, "|")
			end
		end
		local rems = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
		out[#out + 1] = "trap=" .. tostring(rems and rems:FindFirstChild("Trap") ~= nil)
		local data = project_delta.local_game_data
		local inv = data and data:FindFirstChild("Inventory")
		if inv then
			local conts = {}
			for _, c in inv:GetChildren() do
				local inner = c:FindFirstChild("Inventory")
				local n = 0
				if inner then
					n = #inner:GetChildren()
				end
				conts[#conts + 1] = c.Name .. "x" .. n
			end
			out[#out + 1] = "containers=" .. table.concat(conts, "|")
		else
			out[#out + 1] = "containers=none"
		end
		for _, line in out do
			print("[diag] " .. line)
		end
		Library.Notification("diag printed", 3)
	end})
	local detector_tick = 0
	cheat.utility.new_heartbeat(function()
		if not cheater_detector or os.clock() - detector_tick < 5 then return end
		detector_tick = os.clock()
		local folder = game:GetService("ReplicatedStorage"):FindFirstChild("Players")
		for _, player in Players:GetPlayers() do
			if player ~= LocalPlayer then
				local data = folder and folder:FindFirstChild(player.Name)
				local journey = data and data:FindFirstChild("Status") and data.Status:FindFirstChild("Journey")
				local stats = journey and journey:FindFirstChild("Statistics")
				local kills = stats and (stats:GetAttribute("K_PVP") or stats:GetAttribute("Kills")) or 0
				local deaths = stats and (stats:GetAttribute("D_PVP") or stats:GetAttribute("Deaths")) or 0
				local kd = kills / math.max(1, deaths)
				if kd >= 15 then
					Library.Notification("Cheater detector: suspicious K/D " .. player.Name .. " (" .. ("%.1f"):format(kd) .. ")", 5)
				end
			end
		end
	end)
end
