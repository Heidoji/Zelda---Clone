local interfaceManager = {}

-- CONSTANTES
local PREMIER_COEUR_X = 710
local PREMIER_COEUR_Y = 80
local DIMENSION_SPRITE = 32

local DIMENSION_RECT_MAP_X = 14
local DIMENSION_RECT_MAP_Y = 10

local PREMIER_ITEM_X = 363 + 16
local PREMIER_ITEM_Y = 8

-- Initialisation des listes
interfaceManager.imgCoeur = {}
interfaceManager.imgChiffre = {}

function Nombre_Item_Inventaire(pNombre)
  local nombre = {}
  local chiffre, n
  
  for n = 1, 3 do
    if pNombre == 0 then
      chiffre = 0
    else
      chiffre = pNombre % 10
      pNombre = math.floor(pNombre / 10)
    end
    table.insert(nombre, chiffre)
  end
  
  return nombre
end

interfaceManager.Init = function()
  interfaceManager.item = {0, 0, 0}     -- Diamand, Clef, Bombe
  interfaceManager.case = {9, 10}             -- Ligne, Colonne
  interfaceManager.vie = {3, 1, 2}            -- Plein, moitie, vide
  interfaceManager.A = nil
  interfaceManager.B = nil
  
  interfaceManager.imgInterface = love.graphics.newImage("images/interface/interface.png")

  interfaceManager.imgCoeur[1] = love.graphics.newImage("images/interface/Coeur_plein.png")
  interfaceManager.imgCoeur[2] = love.graphics.newImage("images/interface/Coeur_moitie.png")
  interfaceManager.imgCoeur[3] = love.graphics.newImage("images/interface/Coeur_vide.png")
  
  interfaceManager.imgChiffre[0] = love.graphics.newImage("images/interface/Chiffre_0.png")
  interfaceManager.imgChiffre[1] = love.graphics.newImage("images/interface/Chiffre_1.png")
  interfaceManager.imgChiffre[4] = love.graphics.newImage("images/interface/Chiffre_4.png")
end

interfaceManager.Draw = function()
  local x_coeur = PREMIER_COEUR_X
  local y_coeur = PREMIER_COEUR_Y
  
  local n, m
  
  local x_item = PREMIER_ITEM_X
  local y_item = PREMIER_ITEM_Y
  local i = 0
  
  love.graphics.draw(interfaceManager.imgInterface, 1, 1)
  
  love.graphics.setColor(181, 230, 29)
  love.graphics.rectangle('fill', (interfaceManager.case[2] - 1) * (DIMENSION_RECT_MAP_X + 1) + 8, (interfaceManager.case[1] - 1) * (DIMENSION_RECT_MAP_Y + 1) + 8, DIMENSION_RECT_MAP_X, DIMENSION_RECT_MAP_Y)
  love.graphics.setColor(255, 255, 255)
  
  for n = 1, #interfaceManager.item do
    nombre = Nombre_Item_Inventaire(interfaceManager.item[n])
    for m = #nombre, 1, -1 do
      love.graphics.draw(interfaceManager.imgChiffre[nombre[m]], x_item, y_item)
      x_item = x_item + DIMENSION_SPRITE - 5
    end
    y_item = y_item + DIMENSION_SPRITE + 8
    x_item = PREMIER_ITEM_X
  end
  
  for n = 1, #interfaceManager.vie do
    for m = 1, interfaceManager.vie[n] do
      if i >= 9 then
        y_coeur = PREMIER_COEUR_Y - DIMENSION_SPRITE - 2
        x_coeur = PREMIER_COEUR_X
      end
      
      love.graphics.draw(interfaceManager.imgCoeur[n], x_coeur, y_coeur)
      x_coeur = x_coeur + DIMENSION_SPRITE + 2
      i = i + 1
      
    end
  end
end

return interfaceManager