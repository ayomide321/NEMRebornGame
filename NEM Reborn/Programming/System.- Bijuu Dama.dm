mob/Dragonpearl123/verb/Bijuu_Dama_()
	set name = "Bijuu Dama"
	new/obj/Bijuu_Dama_Start (loc, src)
	flick("punch[rand(1, 5)]", src)

obj/proc
	Bijuu_Dama()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Bijuu_Dama)
			src<<"<b><font color=red><u>There can only be one Bijuu Dama at the same time!</u>"
			return
		if(Executor.Can_Execute(src, 150) == 0) return
		Delay(90)
		Executor.NEM_Round.Bijuu_Dama = 1
		Executor.Attacking ++
		Executor.stop()
		Flick("Dama", Executor)
		new/obj/Bijuu_Dama_Start (Executor.loc, Executor)
		Executor.Execute_Jutsu("Bijuu Dama!")

obj/Bijuu_Dama_Start
	layer = 200
	alpha = 200
	icon = 'Graphics/Skills/Bijuu Dama.dmi'

	New(loc, mob/_Executor)
		..()
		pixel_x += _Executor.step_x
		pixel_y += _Executor.step_y
		dir = _Executor.dir
		if(dir == EAST)
			pixel_x += 102
		if(dir == WEST)
			pixel_x -= 96
		flick("Go", src)
		spawn(9)
			if(_Executor)
				new/obj/Bijuu_Dama (loc, _Executor, "First", null, src)
				_Executor.Attacking --
				_Executor.stop()
			del(src)


obj/Bijuu_Dama
	alpha = 200
	layer = 200
	icon = 'Graphics/Skills/Bijuu Tail.dmi'
	var/list/Dama = list()
	var/obj/Bijuu_Dama/After
	var/obj/Bijuu_Dama/Before
	var/NEM_Round/Stated_Round
	var/mob/Executor
	var/New_One
	var/Village
	var/Stop

	New(loc, mob/_Executor, var/State, var/obj/Bijuu_Dama/Tail, var/obj/Bijuu_Dama)
		..()
		Executor = _Executor
		Stated_Round = Executor.NEM_Round
		icon_state = State

		if(!Tail)
			New_One = 1
			loc = Bijuu_Dama.loc
			dir = Bijuu_Dama.dir
			pixel_x += Bijuu_Dama.pixel_x
			pixel_y += Bijuu_Dama.pixel_y
			if(dir == EAST)
				x ++
				pixel_x -= 12
			else if(dir == WEST) {x += 2; pixel_x += 16}
		else
			if(Tail.icon_state != "First") Tail.icon_state = "Tail"
			Dama = Tail.Dama
			Tail.After = src
			loc = Tail.loc
			dir = Tail.dir
			Before = Tail
			pixel_y = Tail.pixel_y
			if(dir == EAST)
				pixel_x = Tail.pixel_x +38
				if(Tail.New_One) pixel_x += 2
			else if(dir == WEST)
				pixel_x = Tail.pixel_x -38
				if(!Tail.New_One)
					Tail.pixel_x += 2

		Check()
		Village = Executor.Village
		spawn() Start()

	proc/Check()
		loop
			if(pixel_x >= 32) {pixel_x -= 32; x++; goto loop}
			else if(pixel_x <= -32) {pixel_x += 32; x--; goto loop}

	proc/Start()
		..()
		bound_height = 60
		bound_width = 38
		bound_x = pixel_x
		bound_y = 10 +pixel_y
		var/T = 0

		spawn(0.75)
			if(dir == EAST)

				for(var/atom/A in obounds(src))
					if(ismob(A) || Stop) continue
					if(A.density && !istype(A, /turf/Special_Floor))
						if(istype(A, /turf/Wall_Stand)) continue
						icon_state = "End"
						Stop = 1
						if(Stated_Round) Stated_Round.Bijuu_Dama = 0

			if(dir == WEST)

				for(var/atom/A in obounds(src, -56))
					if(ismob(A) || Stop) continue
					if(A.density && !istype(A, /turf/Special_Floor))
						icon_state = "End"
						Stop = 1
						if(Stated_Round) Stated_Round.Bijuu_Dama = 0

			if(!Stop)
				if(New_One) new/obj/Bijuu_Dama (loc, Executor, "Tail", src)
				else new/obj/Bijuu_Dama (loc, Executor, "End", src)

		loop
			if(icon_state == "First" || Stop && !Before)
				T++
				if(T > 4)
					if(After && !After.Stop)
						After.icon_state = "First"
						if(After.dir == EAST) After.pixel_x -= 2
					del(src)
					return

			for(var/atom/A in obounds(src))

				if(ismob(A))
					var/mob/M = A

					if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && M.Village != Village && !M.Dragonned)
						if(M.Dodging == 1)
							M.Auto_Dodge (src)
							Dama(M, 10)
						else if(Dama.Find(M) || M.Dodge_Next) M.vel_y = 6
						else
							M.Damage(Executor, 30+rand(0, 25), 1, 2, src, 1)
							Dama(M, 99999999)

			spawn(0.45) goto loop

	proc/Dama(mob/Enemy, var/Duration)
		Dama.Add(Enemy)
		if(Duration < 99999) spawn(Duration) Dama.Remove(Enemy)