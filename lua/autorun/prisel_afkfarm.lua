if SERVER then
  AddCSLuaFile("afk_farm_config.lua")
  AddCSLuaFile("client/cl_afkfarm.lua")
  include("afk_farm_config.lua")
  include("server/sv_afkfarm.lua")
end
if CLIENT then
  include("afk_farm_config.lua")
  include("image_loader.lua")
  include("client/cl_afkfarm.lua")
end
