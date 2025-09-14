-- Table chứa game
local Games = {
    {
        Name = "Cộng đồng Việt Nam",
        PlaceId = 18192562963,
        ScriptUrl = "https://raw.githubusercontent.com/getscript-vn/XenoxVN/refs/heads/main/cdvnscript.lua",
        Icon = "rbxassetid://6031075930"
    },
        {
        Name = "Cộng đồng Việt Nam PVP",
        PlaceId = 181925629613,
        ScriptUrl = "https://raw.githubusercontent.com/getscript-vn/XenoxVN/refs/heads/main/cdvnpvp.lua",
        Icon = "rbxassetid://6031075930"
    },
            {
        Name = "Vũng Tàu City",
        PlaceId = 72565292869142,
        ScriptUrl = "https://raw.githubusercontent.com/getscript-vn/XenoxVN/refs/heads/main/vungtaucitypvp.lua",
        Icon = "rbxassetid://6031075930"
    },
    {
        Name = "Vietnam I Love",
        PlaceId = 83641551582603,
        ScriptUrl = "https://raw.githubusercontent.com/getscript-vn/XenoxVN/refs/heads/main/vietnamilovescript.lua",
        Icon = "rbxassetid://6031075929"
    }
}

local function TryAutoLoad()
    for _, g in ipairs(Games) do
        if game.PlaceId == g.PlaceId then
            loadstring(game:HttpGet(g.ScriptUrl))()
            return true
        end
    end
    return false
end

if not TryAutoLoad() then
    local TweenService = game:GetService("TweenService")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.IgnoreGuiInset = true

    -- Frame chính
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, -1, 0) -- bắt đầu ở trên
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)

    -- Loading Label
    local LoadingLabel = Instance.new("TextLabel")
    LoadingLabel.Size = UDim2.new(1, 0, 0, 50)
    LoadingLabel.Position = UDim2.new(0, 0, 0, 100)
    LoadingLabel.BackgroundTransparency = 1
    LoadingLabel.Text = "Loading"
    LoadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadingLabel.TextSize = 30
    LoadingLabel.Font = Enum.Font.GothamBold
    LoadingLabel.Parent = MainFrame

    -- Hiệu ứng Loading... (., .., ...)
    local loading = true
    task.spawn(function()
        local dots = 0
        while loading do
            dots = (dots % 3) + 1
            LoadingLabel.Text = "Loading" .. string.rep(".", dots)
            task.wait(0.5)
        end
    end)

    -- Tween xuống giữa
    local tween = TweenService:Create(
        MainFrame,
        TweenInfo.new(1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Position = UDim2.new(0.5, -200, 0.5, -150)}
    )
    tween:Play()

    task.wait(3)
    loading = false -- dừng loop
    LoadingLabel:Destroy()

    -- Tiêu đề
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = "Chọn Game"
    Title.TextColor3 = Color3.fromRGB(0, 170, 255)
    Title.TextSize = 28
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Container nút
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Size = UDim2.new(1, 0, 0.7, 0)
    ButtonFrame.Position = UDim2.new(0, 0, 0.25, 0)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Parent = ButtonFrame
    UIListLayout.FillDirection = Enum.FillDirection.Vertical
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 10)

    -- Sinh nút từ table
    for _, g in ipairs(Games) do
        local Btn = Instance.new("TextButton")
        Btn.Size = UDim2.new(0.8, 0, 0, 40)
        Btn.Text = g.Name
        Btn.TextSize = 20
        Btn.Font = Enum.Font.GothamBold
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        Btn.Parent = ButtonFrame
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)

        -- icon
        if g.Icon then
            local Img = Instance.new("ImageLabel")
            Img.Size = UDim2.new(0, 24, 0, 24)
            Img.Position = UDim2.new(0, -30, 0.5, -12)
            Img.BackgroundTransparency = 1
            Img.Image = g.Icon
            Img.Parent = Btn
        end

        Btn.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
            loadstring(game:HttpGet(g.ScriptUrl))()
        end)
    end
end
