local StarterGui = game:GetService("StarterGui")
local function showNotify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "Thông báo",
            Text = text or "",
            Duration = duration or 3,
        })
    end)
end
local chairslist = {}
for i,v in pairs(game:GetService('Workspace'):GetDescendants()) do
    if v.ClassName == 'Seat' then
        table.insert(chairslist,v)
    end
end
local function GetSeatDist(part)
    for i,v in pairs(chairslist) do
        if (v.Position - part.Position).Magnitude < 10 then
            return v
        end
    end
end
local function GetMoneyDist(part)
   local moneypart = workspace:FindFirstChild('moneypart')

    for i,v in pairs(moneypart:GetChildren()) do
        if v:IsA('BasePart') and (v.Position - part.Position).Magnitude < 10  and v.Name == 'MoneyPart' then
            return v
        end
    end
end
local function GetWork()
   local moneypart = workspace:FindFirstChild('moneypart')
    for i,v in pairs(moneypart:GetChildren()) do
      if v:IsA('BasePart') and v.Name == 'MoneyPart' then
          return v
      end
   end
end
task.spawn(function()
    while true do
    pcall(function()
    while true do
        if game.Players.LocalPlayer.Character.Humanoid.Sit == false then
            local work = GetWork()
            if work then
                repeat wait()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = work.CFrame * CFrame.new(0,15,0)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = work.CFrame
                until game.Players.LocalPlayer.Character.Humanoid.Sit == true
                showNotify("System", "Ngồi Thành Công", 5)
                else
                showNotify("Thông Báo Lỗi", "Không Tìm Thấy Công Việc Trống.", 5)
            end
            else
            if not GetMoneyDist(game.Players.LocalPlayer.Character.Humanoid.Seat or game.Workspace:FindFirstChildOfClass('Part')) then
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
        end
        task.wait()
    end
    end)
    task.wait()
    end
end)

local GC = getconnections or get_signal_cons
	if GC then
		for i,v in pairs(GC(game.Players.LocalPlayer.Idled)) do
			if v["Disable"] then
				v["Disable"](v)
			elseif v["Disconnect"] then
				v["Disconnect"](v)
			end
		end
	else
		local VirtualUser = cloneref(game:GetService("VirtualUser"))
		game.Players.LocalPlayer.Idled:Connect(function()
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end

loadstring(game:HttpGet("https://raw.githubusercontent.com/getscript-vn/Api/refs/heads/main/Anti%20Lag"))()
