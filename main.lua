io.stdout:setvbuf('no')

love.graphics.setDefaultFilter('nearest')

if arg[#arg] == "-debug" then
  require("mobdebug").start()
end

math.randomseed(love.timer.getTime())

-- Constantes
LARGEUR_ECRAN = 1024
HAUTEUR_ECRAN = 764

HAUTEUR_DEPART_MAP = 124

LARGEUR_EN_TILE = 16
HAUTEUR_EN_TILE = 10

DIMENSION_SPRITE = 64
VITESSE_LINK = 5

local interfaceManager = require("interfacemanager")
local interface

-- Création des listes
link = {}
liste_sprites = {}
liste_tile = {}
liste_map = {}
liste_maps = {}

-- Chargement des images
local n, m, l
for n=1, 2 do
  liste_tile[n] = love.graphics.newImage("images/tile_"..n..".png")
end

-- Chargement des maps
for n=1, 2 do
  liste_map[n] = {2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2}
end
for n=3, 4 do
  liste_map[n] = {2,2,1,1,1,1,1,1,1,1,1,1,1,1,2,2}
end
for n=5, 6 do
  liste_map[n] = {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
end
for n=7, 8 do
  liste_map[n] = {2,2,1,1,1,1,1,1,1,1,1,1,1,1,2,2}
end
for n=9, 10 do
  liste_map[n] = {2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2}
end


for n=1, 10 do
  local map_temp = {}
  for m=1, 16 do
    table.insert(map_temp, liste_map)
  end
  table.insert(liste_maps, map_temp)
end

function ConvertPixelTile(pType, pX, pY)
  local coord = {}
  
  if pType == 1 then
    coord.x = math.floor((pX + DIMENSION_SPRITE / 2) / DIMENSION_SPRITE) + 1
    coord.y = math.floor((pY + DIMENSION_SPRITE / 2 - HAUTEUR_DEPART_MAP) / DIMENSION_SPRITE) + 1
  else
    coord.x = (pX + 0.5) * DIMENSION_SPRITE  
    coord.y = (pY + 0.5) * DIMENSION_SPRITE + HAUTEUR_DEPART_MAP
  end
  
  return coord
end

function CreateSprite(pNomImage, pX, pY)
  local sprite = {}
  
  table.insert(liste_sprites, sprite)
  
  sprite.image = love.graphics.newImage("images/"..pNomImage..".png")
  sprite.x = pX
  sprite.y = pY
  
  return sprite
end

function love.load()
  love.window.setMode(LARGEUR_ECRAN, HAUTEUR_ECRAN)
  love.window.setTitle("JGC09-2016 Clone de Legend of Zelda")
  
  largeur = love.graphics.getWidth()
  hauteur = love.graphics.getHeight()
  
  interface = interfaceManager.Init()
  
  current_map = {}
  current_map.ligne = 9
  current_map.colonne = 10
  current_map.map = liste_maps[current_map.ligne][current_map.colonne]
  
  link = CreateSprite("link", LARGEUR_EN_TILE / 2 * DIMENSION_SPRITE, HAUTEUR_EN_TILE / 2 * DIMENSION_SPRITE + HAUTEUR_DEPART_MAP, 0, 1, 1, DIMENSION_SPRITE / 2, DIMENSION_SPRITE / 2)
end

function love.update(dt)
  local coord 

  if love.keyboard.isDown("up") then
    coord = ConvertPixelTile(1, link.x, link.y - 5)
      if current_map.map[coord.y][coord.x] < 2 then
        link.y = link.y - VITESSE_LINK
      end
    
    if link.y < HAUTEUR_DEPART_MAP then
      current_map.ligne = current_map.ligne - 1
      current_map.map = liste_maps[current_map.ligne][current_map.colonne]
      link.y = HAUTEUR_ECRAN - 10 - DIMENSION_SPRITE / 2 
    end
  end
  if love.keyboard.isDown("down") then
    coord = ConvertPixelTile(1, link.x, link.y + 5)
    if current_map.map[coord.y][coord.x] < 2 then
      link.y = link.y + VITESSE_LINK
    end
    
    if link.y > HAUTEUR_ECRAN - 10 - DIMENSION_SPRITE / 2 then
      current_map.ligne = current_map.ligne + 1
      current_map.map = liste_maps[current_map.ligne][current_map.colonne]
      link.y = HAUTEUR_DEPART_MAP
    end
  end
  
  if love.keyboard.isDown("left") then
    coord = ConvertPixelTile(1, link.x - 5, link.y)
    if current_map.map[coord.y][coord.x] < 2 then
      link.x = link.x - VITESSE_LINK
    end
    
    if link.x < 10 + DIMENSION_SPRITE / 2 then
      current_map.colonne = current_map.colonne - 1
      current_map.map = liste_maps[current_map.ligne][current_map.colonne]
      link.x = LARGEUR_ECRAN - 10 - DIMENSION_SPRITE / 2
    end
  end
  
  if love.keyboard.isDown("right") then
    coord = ConvertPixelTile(1, link.x + 5, link.y)
    if current_map.map[coord.y][coord.x] < 2 then
      link.x = link.x + VITESSE_LINK
    end
    
    if link.x > LARGEUR_ECRAN - 10 - DIMENSION_SPRITE / 2 then
      current_map.colonne = current_map.colonne + 1
      current_map.map = liste_maps[current_map.ligne][current_map.colonne]
      link.x = 10 + DIMENSION_SPRITE / 2
    end
  end
end

function love.draw()
  local n, m, x
  local y = HAUTEUR_DEPART_MAP
  local coord = {}
  
  interfaceManager.Draw()
  
  for n = 1, HAUTEUR_EN_TILE do
    x = 0
    for m = 1, LARGEUR_EN_TILE do
      local t = current_map.map[n][m]
      love.graphics.draw(liste_tile[t], x, y)
      x = x + DIMENSION_SPRITE
    end
    y = y + DIMENSION_SPRITE
  end
  
  for n=1, #liste_sprites do
    local s = liste_sprites[n]
    love.graphics.draw(s.image, s.x, s.y)
  end
  
  coord = ConvertPixelTile(1, link.x, link.y)
  love.graphics.print("x : "..link.x.." Coord.x : "..coord.x.." y : "..link.y.." Coord.y : "..coord.y.." Ligne : "
    ..current_map.ligne.." Colonne : "..current_map.colonne)
end

function love.keypressed(key)
  
end