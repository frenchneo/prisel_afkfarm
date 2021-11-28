function PriselAfkFarm.ThinkMoney()
  for k,v in pairs(team.GetPlayers(TEAM_AFK)) do
    local moneyHeShouldWin = PriselAfkFarm.MoneyPerMin
    moneyHeShouldWin = PriselAfkFarm.RankDouble[v:GetUserGroup()] and moneyHeShouldWin * 2 or moneyHeShouldWin
    v:addMoney(moneyHeShouldWin)
    v:SetNWFloat("afkFarmMoneyWon",v:GetNWFloat("afkFarmMoneyWon") + moneyHeShouldWin)
  end
end
timer.Create("PriselAfkFarm:ThinkMoney", 60, 0, PriselAfkFarm.ThinkMoney)

function PriselAfkFarm.ThinkJetons()
  for k,v in pairs(team.GetPlayers(TEAM_AFK)) do
    local jetonsHeShouldWinMax = PriselAfkFarm.JetonsPerHoursMax
    jetonsHeShouldWinMax = PriselAfkFarm.RankDouble[v:GetUserGroup()] and jetonsHeShouldWinMax * 2 or jetonsHeShouldWinMax
    local jetonsHeShouldWinMin = PriselAfkFarm.JetonsPerHoursMin
    jetonsHeShouldWinMin = PriselAfkFarm.RankDouble[v:GetUserGroup()] and jetonsHeShouldWinMin * 2 or jetonsHeShouldWinMin
    local jetonsHeShouldWin = math.random(jetonsHeShouldWinMin,jetonsHeShouldWinMax)
    v:PS_GivePoints(jetonsHeShouldWin)
    v:SetNWInt("afkFarmJetonsWon",v:GetNWInt("afkFarmJetonsWon") + jetonsHeShouldWin)
  end
end
timer.Create("PriselAfkFarm:ThinkJetons", 60 * 60, 0, PriselAfkFarm.ThinkJetons)

hook.Add("PlayerChangedTeam", "PriselAfkFarm:TimeAfk", function( ply, oldTeam, newTeam)
  if oldTeam == TEAM_AFK and newTeam ~= TEAM_AFK then
    ply:SetNWInt("afkFarmJetonsWon",0)
    ply:SetNWInt("afkFarmMoneyWon",0)
    --ply:FAdmin_SetGlobal("FAdmin_godded", false)
    ply:GodDisable()
  end
  if newTeam ~= TEAM_AFK then return end
  if oldTeam == newTeam then return end
  ply:SetNWInt("afkStartTime",CurTime())
  net.Start("PriselAfkFarm:OpenMenu")
  net.Send(ply)
  --ply:FAdmin_SetGlobal("FAdmin_godded", true)
  ply:GodEnable()

end)
util.AddNetworkString("PriselAfkFarm:OpenMenu")
concommand.Add("prisel_exitafk",function(ply)
  ply:changeTeam(TEAM_CITIZEN, true)
  --ply:FAdmin_SetGlobal("FAdmin_godded", false)
  ply:GodDisable()
end)

function PriselAfkFarm.CheckAfkTeam()
  local time = tonumber(os.date("%H"))
  if time >= 21 or time <= 11 then return end
  for k,v in pairs(team.GetPlayers(TEAM_AFK)) do
    v:changeTeam(TEAM_CITIZEN, true)
    -- v:FAdmin_SetGlobal("FAdmin_godded", false)
    v:GodDisable()
  end
end
timer.Create("PriselAfkFarm:CheckAfkTeam",60,0,PriselAfkFarm.CheckAfkTeam)
