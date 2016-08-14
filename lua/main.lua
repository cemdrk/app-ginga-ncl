require 'tcp'

local provincias = { "Arani","Arque","Ayopaya","Bolivar","Carrasco","Capinota", "Campero","Cercado","Chapare","Esteban Arce","German Jordan","Mizque", "Punata","Quillacollo","Tapacari","Tiraque", "Tips"}
-- local platos = { 'Silpancho', 'Pique Macho', 'Milaneza', 'Falso Conejo', 'Picante de Pollo' }
-- desc_plato = {'', '', '', '', '', ''}
local desc_plato = 'Este es un texto de prueba'

local ANCHO_CELDA = 100 -- ancho de la celda
local ALTO_CELDA = 30 -- alto de la celda
local SCREEN_W, SCREEN_H = canvas:attrSize()
local offset = 5 -- separacion entre bloques
local estado_provincias = 1 -- posicion del array seleccionado
local estado_platos = 1 -- posicion de los platos seleccionados
local estado_descripcion = 1 -- estado de la descripcion
local estado_menu = 1 -- bandera del menu para el movimiento de las teclas
local estado_detalles = 1 -- estado para controlar los estados del plato
local HOST = 'localhost' -- Host a conectarse
local url = '/bolivianfood/list.php' -- Pagina solicitada
local result = '' -- resultado html de la busqueda
local question = '' -- 
local platos = {} -- nombre del plato
local ingrediente = {} -- ingrediente del plato
local descripcion = {} -- descripcion del plato
local preparacion = {} -- preparacion del plato
-- local i = 1
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
  draw()
end

function dibujar_titulo()
  canvas:attrColor('red')
  canvas:attrFont('Tiresias', 15, 'bold')
  canvas:drawText(10, 0, 'se inicio la aplicacion ')
  canvas:attrColor('black')
  -- canvas:flush()
end

-- function dibujar_provincias( state )
-- Esta funcion dibujara todas las provincias
function dibujar_provincias()
  cont = 0.1 * SCREEN_H
  for i=1,#provincias do
    if estado_provincias == i then
      canvas:attrColor(72,112,156,255)
      canvas:drawRect('fill', 0, cont, 0.25 * SCREEN_W, 0.04 * SCREEN_H)
      canvas: attrColor('white')
      canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
      canvas:drawText(5,cont,provincias[i])
    else
      canvas:attrColor(73,143,143,255)
      canvas:drawRect('fill', 0, cont, 0.25 * SCREEN_W, 0.04 * SCREEN_H)
      canvas: attrColor('white')
      canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
      canvas:drawText(5,cont,provincias[i])
    end 
    cont=cont + (0.05 * SCREEN_H)
    canvas:attrColor('black')
  end
  
end

-- dibujar todo
function draw()
  canvas:clear()
  dibujar_titulo()
  dibujar_provincias()
  seleccionar_provincia()
  seleccionar_plato()
  canvas:flush()
  -- canvas:flush()
end
-- funcion para seleccionar una provincia
function seleccionar_provincia()
  getTCP()
  if estado_menu == 2 or estado_menu == 3 then
    cont = 0.1 * SCREEN_H
    for i=1,#platos do
      local plato_seleccionado = platos[i]
      if estado_platos == i then
        canvas:attrColor(72,112,156,255)
        canvas:drawRect('fill', 0.30 * SCREEN_W , cont, 0.25 * SCREEN_W, 0.04 * SCREEN_H)
        canvas: attrColor('white')
        canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
        canvas:drawText(0.33 * SCREEN_W,cont,platos[i])
      else
        canvas:attrColor(73,143,143,255)
        canvas:drawRect('fill', 0.30 * SCREEN_W, cont, 0.25 * SCREEN_W, 0.04 * SCREEN_H)
        canvas: attrColor('white')
        canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
        canvas:drawText(0.33 * SCREEN_W,cont,platos[i])
      end
      cont = cont + (0.05 * SCREEN_H)
      canvas:attrColor('black')
    end
  end
end
-- funcion para seleccionar un plato
function seleccionar_plato()
  cont = 0.1 * SCREEN_H
  if estado_menu == 2 then
    canvas:attrColor(76, 142, 166, 255)
    canvas:drawRect('fill', 0.60 * SCREEN_W , cont, 0.39 * SCREEN_W, 0.8 * SCREEN_H)
    canvas: attrColor('white')
    canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
    canvas:drawText(0.63 * SCREEN_W,cont,platos[estado_platos])
    
    if estado_detalles == 1 then
      canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
      canvas:drawText(0.63 * SCREEN_W,0.15 * SCREEN_H,'Ingredientes: ')
      canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
      canvas:drawText(0.63 * SCREEN_W,0.2 * SCREEN_H,ingrediente[estado_platos])
    elseif estado_detalles == 2 then
      canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
      canvas:drawText(0.63 * SCREEN_W,0.15 * SCREEN_H ,'Preparacion: ')
      canvas:attrFont('Tiresias', 0.025 * SCREEN_H, 'bold')
      canvas:drawText(0.63 * SCREEN_W,0.2 * SCREEN_H , preparacion[estado_platos])
    end
    canvas:attrColor('black')
  end
end

function cambiar_detalle()
  if estado_detalles == 2 then
    estado_detalles = 1
  else
    estado_detalles = estado_detalles + 1
  end
end
-- funcion para seleccionar un plato

function mover( value )
  if value == -1 then
    if estado_menu == 1 then
      estado_provincias = estado_provincias - 1
    elseif estado_menu == 2 then
      estado_platos = estado_platos - 1
    elseif estado_menu == 3 then
      estado_descripcion = estado_descripcion - 1
    end
  else
    if estado_menu == 1 then
      estado_provincias = estado_provincias + 1
    elseif estado_menu == 2 then
      estado_platos = estado_platos + 1
    elseif estado_menu == 3 then
      estado_descripcion = estado_descripcion + 1
    end
  end
  draw()
end
-- function eventos de teclado
function onkeyPress( evt )
  -- canvas:clear()
  if evt.class == 'key' and evt.type == 'press' then
    if evt.key == 'RED' then
      estado_menu = 2
      seleccionar_provincia()
      seleccionar_plato()
    elseif evt.key == 'GREEN' then
      estado_menu = 1
      -- volver_anterior()
    elseif evt.key == 'YELLOW' then
      -- estado_detalles = 1
      cambiar_detalle()
    elseif evt.key == 'CURSOR_UP' then
      mover(-1)
    elseif evt.key == 'CURSOR_DOWN' then
      mover(1)
    end
    draw()
  end
  return true
end

function getTCP()
  tcp.execute(
    function ()
      local size = 0;
      tcp.connect(HOST, 80)
      tcp.send('GET '..url..'\n')
      result = tcp.receive()
      if result then
        _,_,size = string.find(result, '<tam>(.*)</tam>')
        -- size = toNumber(size)
        for i=1,size do
          _,_,platos[i] = string.find(result, '<plato'..i..'>(.*)</plato'..i..'>')
          _,_,descripcion[i] = string.find(result, '<description'..i..'>(.*)</description'..i..'>')
          _,_,ingrediente[i] = string.find(result, '<ingredientes'..i..'>(.*)</ingredientes'..i..'>')
          _,_,preparacion[i] = string.find(result, '<preparacion'..i..'>(.*)</preparacion'..i..'>')
        end
        -- _,_,question = string.find(result, '<plato'..i..'>(.*)</plato'..i..'>')
        -- i = i+1
      else
        _,_,question = 'error'.. evt.error
      end
      -- tcp.disconnect()de
    end
  )
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