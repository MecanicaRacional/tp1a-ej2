--hecho por diego
--v 1.0.0
--19/03/2017

function _init()
c = 8*2
w = 3.14
--radio
r = c/w
--lapsos
t = -0.1
timer = 0
--ecuaciones parametricas de la
--trayectoria
init_x = 64
init_y = 64 - r
coords = {init_x,init_y}
coords_viejas = {coords}
--senos y cosenos con radianes
cos1 = cos function cos(angle) return cos1(angle/(3.1415*2)) end
sin1 = sin function sin(angle) return sin1(-angle/(3.1415*2)) end
coords_hilo = {init_x,init_y}
--ajustes
debug = 1 --1 on, -1 off
velocidad_rapida = 0.1
velocidad_lenta = 0.01
--paso delta t
delta_t = velocidad_lenta
--intro
intro_timer = 0
intro = 0
intro_espera = 120
cls()
end


function evaluar()
 x = init_x + (c * ((-1/w) * sin(w*t) + t * cos(w*t)))
 y = init_y - (c * ((1/w) * cos(w*t) + t * sin(w*t)))
 return({x,y})
end


function posicion_hilo()
 cox = 64 + r * sin(-w*t)
 coy = 64 - r * cos(w*t)
 return({cox,coy})
end


function cambiar_ajustes()
 if btnp(5) then
  sfx(0)
  if delta_t == velocidad_rapida then
   delta_t = velocidad_lenta
  else
   delta_t = velocidad_rapida
  end
 end
 if btnp(4) then
  sfx(0)
  debug = debug * -1
 end
end


function _update()
 timer += 1
 --tiempo de introduccion
 if intro == 0 then
  intro_timer += 1
  if intro_timer > intro_espera then
   intro = 1
  end
 else
		if timer % 5 == 0 then
	 	t += delta_t
	 	timer = 0
	 	add(coords_viejas,coords)
	 	coords = evaluar()
	 	coords_hilo = posicion_hilo()
		end
		--reinicio automatico
		if t > 10 then
		 t=-0.1
		 coords = {init_x,init_y}
		 coords_viejas = {}
		 timer = 0
		end
		cambiar_ajustes()
	end
end


function draw_intro()
 cls(6)
 map(0,0,16,16)
 print("facultad de ingenieria",20,60,1)
 print("mecanica racional",30,70,1)
 print("2017",55,90,1)
 print("creado por diego lanciotti",10,110,1)
end


function _draw()
	cls()
	--intro
	if intro == 0 then
	 draw_intro()
	else
	
	 --circulo
		circ(64,64,r,8)
		
		--ejes x,y
		line(64,64,94,64,9)
		line(64,64,64,94,9)
  circ(94,64,1,9)
		circ(64,94,1,9)
		print("x",98,62,9)
		print("y",63,98,9)
		
		--trayectoria
		for i=1,len(coords_viejas)-1 do
		 circfill(coords[1],coords[2],1,12)
		 line(coords_viejas[i][1],coords_viejas[i][2],coords_viejas[i+1][1],coords_viejas[i+1][2],7)
		 if i == len(coords_viejas)-1 then
		  line(coords_viejas[i+1][1],coords_viejas[i+1][2],coords[1],coords[2],7)
		 end
		end 
		
		--hilo
		line(coords_hilo[1],coords_hilo[2],coords[1],coords[2],4)
		
		--debug
		if debug == 1 then
		 --evita dibujar sobre datos
		 rectfill(0,0,18,16,0)
		 print("x: ",0,0,6)
		 print("y: ",0,10,6)
		 print("tiempo: ",40,0,6)
		 print(coords[1],10,0,6)
		 print(coords[2],10,10,6)
		 print(t,70,0,6)
		end
		
		--instrucciones
		if t < 2 then
	 	print("presionar z - muestra datos",0,112,6)
	 	print("presionar x - cambia delta_t",0,120,6)
		end
	end
end

--return table length
function len(t)
  local count = 0
  for _ in pairs(t) do count = count + 1 end
  return count
end