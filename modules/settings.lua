--quick change settings

local m ={}


m.debug = false

m.title = "Water Drop"

m.assetsDir = "assets/"


m.highScore = system.getPreference( "app", "highScore", "number" )
if(m.highScore == nil)then
  m.highScore = 0
end
return m
