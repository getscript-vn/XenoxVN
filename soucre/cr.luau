
loadstring(game:HttpGet("https://raw.githubusercontent.com/getscript-vn/XenoxVN/refs/heads/main/soucre/wo.lia"))()

wait(0.1)
for i,v in pairs(game:GetDescendants()) do
    if v.ClassName == 'TextButton' and v.Text:find('Unlock') then
        v.Parent.TextBox.Text = 'Wkl_17832'
      for i1,vc in pairs(getconnections(v.MouseButton1Click)) do
        pcall(function()
            vc.Function()
        end)
      end
    end
end
