surface.CreateFont("Montserrat-35",{
    font = "Montserrat Black",
    size = 35,
})
surface.CreateFont("Montserrat-30",{
    font = "Montserrat Black",
    size = 30,
})
local PANEL = {}

local test_test;

function PANEL:Init()

  self:MakePopup()
  self:SetSize(1000,500)
  self:Center()
  self:SetTitle("")
  self:ShowCloseButton(false)

  self.ReplayBut = vgui.Create("DButton", self)
  self.ReplayBut:SetText("")
  self.ReplayBut:SetSize(281,52)
  self.ReplayBut:SetPos(self:GetWide() / 2 + 100, 350)
  self.ReplayBut.Paint = function (s, w, h)
    surface.SetDrawColor( 68, 87, 101, 255 )
    surface.DrawRect(0, 0, 281, 52)
    if self.ReplayBut:IsHovered() then
      draw.SimpleText("Rejouer","Montserrat-30", w / 2, h / 2, Color(255, 175, 56), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
      draw.SimpleText("Rejouer","Montserrat-30", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
  end
  self.ReplayBut.DoClick = function()
    self:Close()
    RunConsoleCommand("prisel_exitafk")
  end

  self.BuyPremBut = vgui.Create("DButton", self)
  self.BuyPremBut:SetText("")
  self.BuyPremBut:SetSize(281,52)
  self.BuyPremBut:SetPos(self:GetWide() / 2 - 400, 350)
  self.BuyPremBut.Paint = function (s, w, h)
    surface.SetDrawColor( 68, 87, 101, 255 )
    surface.DrawRect(0, 0, 281, 52)
    local text = PriselAfkFarm.RankDouble[LocalPlayer():GetUserGroup()] and "Offrir le Élite" or "Acheter le Élite"
    if self.BuyPremBut:IsHovered() then
      draw.SimpleText(text,"Montserrat-30", w / 2, h / 2, Color(255, 175, 56), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    else
      draw.SimpleText(text,"Montserrat-30", w / 2, h / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
  end
  self.BuyPremBut.DoClick = function()
    gui.OpenURL("https://prisel.koredia.com/")
  end
end
function PANEL:Paint(w, h)
  draw.RoundedBox(15, 0, 0, w, h,Color(0,0,0))
  draw.RoundedBox(15, 0, 0, w, h,Color(20, 20, 20, 175))
  draw.RoundedBoxEx(15, 0, 0, w, 54, Color(255, 175, 56, 180),true,true,false,false)

  draw.RoundedBox(0, 0, 52, w, 2,Color(255,255,255))

  draw.RoundedBoxEx(15, 0, h - 54, w, 54, Color(255, 175, 56, 180),false,false,true,true)
  draw.RoundedBox(0, 0, h - 56, w, 2,Color(255,255,255))

  draw.SimpleText("Prisel.fr - AFK (Gagne des récompenses)","Montserrat-35", w / 2, 54 / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

  draw.RoundedBox(15, 20, 75, w / 2 - 50, h - 150,Color(255,255,255))
  draw.RoundedBox(15, 25, 75, w / 2 - 50, h - 150,Color(37,37,37))

  draw.RoundedBox(15, 520, 75, w / 2 - 50, h - 150,Color(255,255,255))
  draw.RoundedBox(15, 525, 75, w / 2 - 50, h - 150,Color(37,37,37))

  local moneyAmount = PriselAfkFarm.MoneyPerMin
  moneyAmount = PriselAfkFarm.RankDouble[LocalPlayer():GetUserGroup()] and moneyAmount * 2 or moneyAmount

  draw.SimpleText("Argent que vous générez :","Montserrat-30", 70,  110, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
  draw.SimpleText(moneyAmount .. "        par minute","Montserrat-30", w / 2 - 50,  150, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
  surface.SetDrawColor(255,255,255,255)
  surface.SetMaterial(Material("prisel/afkfarm/icon_money.png"))
  surface.DrawTexturedRect(w / 2 - 225, 130,49,41)

  local jetonAmountMax = PriselAfkFarm.JetonsPerHoursMax
  jetonAmountMax = PriselAfkFarm.RankDouble[LocalPlayer():GetUserGroup()] and jetonAmountMax * 2 or jetonAmountMax

  local jetonAmountMin = PriselAfkFarm.JetonsPerHoursMin
  jetonAmountMin = PriselAfkFarm.RankDouble[LocalPlayer():GetUserGroup()] and jetonAmountMin * 2 or jetonAmountMin

  draw.SimpleText("Jetons que vous générez:","Montserrat-30", 70,  200, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
  draw.SimpleText(jetonAmountMin .. " à " .. jetonAmountMax .. "        par heure","Montserrat-30", w / 2 - 50,  240, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
  surface.SetDrawColor(255,255,255,255)
  surface.SetMaterial(Material("prisel/afkfarm/icon_jeton.png"))
  surface.DrawTexturedRect(w / 2 - 212, 220,49,41)

  draw.RoundedBox(15, 40, 280, w / 2 - 100, 2,Color(255,255,255,100))

  local txt = PriselAfkFarm.RankDouble[LocalPlayer():GetUserGroup()] and "Gains doublés par le Élite" or "Gains non doublés par le Élite"
  local txtColor = PriselAfkFarm.RankDouble[LocalPlayer():GetUserGroup()] and Color(255, 175, 56) or Color(240,30,30)
  draw.SimpleText(txt,"Montserrat-35", w / 2 - 250, 310, txtColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

  draw.SimpleText("Gains que vous avez généré","Montserrat-35", w / 2 + 250, 110, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

  draw.SimpleText(LocalPlayer():GetNWFloat("afkFarmMoneyWon") .. " €","Montserrat-30", w / 2 + 250,  175, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  draw.SimpleText(LocalPlayer():GetNWFloat("afkFarmJetonsWon") .. " jetons","Montserrat-30", w / 2 + 250,  225, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

  draw.SimpleText("Temps afk :","Montserrat-30", w / 2 + 175,  280, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  local time = string.FormattedTime( CurTime() - LocalPlayer():GetNWInt("afkStartTime"))
  local timeTxt = string.format("%02i:%02i:%02i", time.h, time.m, time.s)
  draw.SimpleText(timeTxt,"Montserrat-30", w / 2 + 325,  280, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

  draw.RoundedBox(15, 540, 315, w / 2 - 100, 2,Color(255,255,255,100))

  draw.RoundedBox(15, 91, 341, 299, 70,Color(255,255,255))
  draw.RoundedBox(15, 94, 344, 293, 64,Color(68, 87, 101, 255))

  draw.RoundedBox(15, w / 2 + 91, 341, 299, 70,Color(255,255,255))
  draw.RoundedBox(15, w / 2 + 94, 344, 293, 64,Color(68, 87, 101, 255))

  draw.SimpleText("Les récompenses sont remises entre 23h et 6h.","Montserrat-35", w / 2, 470, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end
vgui.Register("PriselAfkFarm:Menu", PANEL, "DFrame")

net.Receive("PriselAfkFarm:OpenMenu",function()
  if IsValid(PriselAfkFarm.PriFrame) then PriselAfkFarm.PriFrame:Remove() end
  if IsValid(PriselAfkFarm.BlackBackground) then PriselAfkFarm.BlackBackground:Remove() end
  PriselAfkFarm.PriFrame = vgui.Create("PriselAfkFarm:Menu")
  PriselAfkFarm.BlackBackground = vgui.Create("DPanel")
  PriselAfkFarm.BlackBackground:SetSize(ScrW(), ScrH())
  PriselAfkFarm.BlackBackground.Paint = function(aself,w,h) draw.RoundedBox(0,0,0,w,h,Color(0,0,0)) end
  PriselAfkFarm.PriFrame.OnRemove = function() if IsValid(PriselAfkFarm.BlackBackground) then PriselAfkFarm.BlackBackground:Remove() end end
end)
