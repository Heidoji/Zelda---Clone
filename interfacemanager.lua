local interfaceManager = {}

-- CONSTANTES
local PREMIER_COEUR_X = 710
local PREMIER_COEUR_Y = 80
local DIMENSION_SPRITE = 32

-- Initialisation des listes
interfaceManager.imgCoeur = {}

interfaceManager.Init = function()
  interfaceManager.diamant = 0
  interfaceManager.clef = 0
  interfaceManager.bombe = 0
  interfaceManager.case_x = 9
  interfaceManager.case_y = 10
  interfaceManager.vie = {3, 3, 4}
  interfaceManager.A = nil
  interfaceManager.B = nil
  
  interfaceManager.imgInterface = love.graphics.newImage("images/interface.png")

  interfaceManager.imgCoeur[1] = love.graphics.newImage("images/Coeur_plein.png")
  interfaceManager.imgCoeur[2] = love.graphics.newImage("images/Coeur_moitié.png")
  interfaceManager.imgCoeur[3] = love.graphics.newImage("images/Coeur_vide.png")
end

interfaceManager.Draw = function(pCase_x, pCase_y)
  interfaceManager.case_x = pCase_x
  interfaceManager.case_y = pCase_y
  local x = PREMIER_COEUR_X
  local y = PREMIER_COEUR_Y
  local i = 0
  local n, m
  
  love.graphics.draw(interfaceManager.imgInterface, 1, 1)
  
  for n = 1, #interfaceManager.vie do
    for m = 1, interfaceManager.vie[n] do
    print(i)
      if i >= 9 then
        y = PREMIER_COEUR_Y - DIMENSION_SPRITE - 2
        x = PREMIER_COEUR_X
      end
      
      love.graphics.draw(interfaceManager.imgCoeur[n], x, y)
      x = x + DIMENSION_SPRITE + 2
      i = i + 1
      
    end
  end
  
  
end

return interfaceManager