local provincias = { 'Arque', 'Mizque', 'Aniceto Arce', 'Tiraque', 'Punata' }
local platos = { 'Silpancho', 'Pique Macho', 'Milaneza', 'Falso Conejo', 'Picante de Pollo' }
-- desc_plato = {'', '', '', '', '', ''}
local desc_plato = 'Este es un texto de prueba'

local ANCHO_CELDA = 100 -- ancho de la celda
local ALTO_CELDA = 30 -- alto de la celda
local SCREEN_W, SCREEN_H = canvas:attrSize()
local offset = 5 -- separacion entre bloques
local estado_provincias = 1 -- posicion del array seleccionado
local estado_platos = 1 -- posicion de los platos seleccionados
local estado_descripcion = 1 -- estado de la descripcion
-- local EMPTY = 0
-- local SELECTED = 1
-- local estado = 0
-- local arrayProvincias = {}
-- local arrayPlatos = {}
-- -- move
-- local player_moved = false
-- local moves = 0
-- local targets = 0 
-- -- tableros de dibujo
-- local tableros = {}
-- local tableroProvincias = tableros[1]
-- local tableroPlatos = tableros[2]
-- local tableroConsejos = tableros[3]
-- local tablero_cambiado = false
counter = 0

function init()
  -- init provincias
  -- tableros[1] = {}
  -- for i=0,4 do
  --   tableros[1] = {}
  -- end
  draw()
  -- canvas:flush()
end

function dibujar_titulo()
  canvas:attrColor('red')
  canvas:attrFont('Tiresias', 15, 'bold')
  canvas:drawText(10, 0, 'se inicio la aplicacion ')
  canvas:attrColor('black')
  -- canvas:flush()
end

-- function dibujar_provincias( state )
--   canvas:attrColor('red')
--   canvas:attrFont('Tiresias', 15, 'bold')
--   canvas:drawText(10, 30, 'se inicio la aplicacion ')
--   canvas:attrColor('black')

-- end

-- function obtener_tamanio( arreglo )
--   for i=1,arreglo do
--     print(i)
--   end
-- end
function reset_vars()
  
end
-- Esta funcion dibujara todas las provincias
function dibujar_provincias()
  canvas: attrColor('red')
  canvas:attrFont('Tiresias', 15, 'bold')
  canvas:drawText(10, 0, #provincias)
  canvas:attrColor('black')
end

-- dibujar todo
function draw()
  canvas:clear()
  -- dibujar_titulo()
  dibujar_provincias()
  -- dibujar_seleccion(estado_provincias)
  canvas:flush()
  -- canvas:flush()
end
-- funcion para seleccionar una provincia
function seleccionar_provincia()
  -- canvas:clear()
  canvas:attrColor('red')
  canvas:attrFont('Tiresias', 15, 'bold')
  canvas:drawText(10, 30, 'se selecciono una provincia')
  canvas:attrColor('black')
end
-- funcion para seleccionar un plato
function seleccionar_plato()
  -- canvas:clear()
  canvas:attrColor('red')
  canvas:attrFont('Tiresias', 15, 'bold')
  canvas:drawText(10, 60, 'se selecciono un plato')
  canvas:attrColor('black')
end
-- funcion para seleccionar un plato
function volver_anterior()
  -- canvas:clear()
  canvas:attrColor('red')
  canvas:attrFont('Tiresias', 15, 'bold')
  canvas:drawText(10, 90, 'se volvio a un estado anterior')
  canvas:attrColor('black')
end
-- funcion para actualizar un plato
function actualizar_vista()
  canvas:flush()
end

-- function eventos de teclado
function onkeyPress( evt )
  -- canvas:clear()
  if evt.class == 'key' and evt.type == 'press' then
    if evt.key == 'RED' then
      seleccionar_provincia()
    elseif evt.key == 'GREEN' then
      seleccionar_plato()
    elseif evt.key == 'YELLOW' then
      volver_anterior()
    -- elseif evt.key == 'CURSOR_UP' then
    --   mover(1)
    -- elseif evt.key == 'CURSOR_DOWN' then
    --   mover(-1)
    end
    actualizar_vista()
  end
  return true
end

function handler( evt )
  counter = counter + 1
  canvas:clear()
  canvas:attrColor('red')
  canvas:attrFont('Tiresias', 15, 'bold')
    canvas:drawText(10, 0, evt.class or 'no existe clase')
    canvas:drawText(10, 15, evt.key or 'no existe key')
    canvas:drawText(10, 30, evt.type or 'no existe tipo')
    canvas:attrColor('black')
    canvas:flush()
end
-- init 
init()
-- registrar evento
event.register(onkeyPress)