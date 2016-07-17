
counter = 0
function handler( evt )
  counter = counter + 1
  canvas:clear()
  canvas:attrColor('red')
  canvas:attrFont('Tiresias', 15, 'bold')
    canvas:drawText(0, 0, 'Cantidad de eventos:'..counter)
    canvas:attrColor('black')
    canvas:flush()
end
event.register(handler)