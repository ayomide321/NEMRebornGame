obj/proc/Chain_Kunai()
	var/mob/Executor = usr
	if(Executor.Bijuu) return
	if(!Executor.Kunais_L || Executor.Susanoo) return
	if(Executor.Can_Execute(src, 0) == 0) return
	Executor.Kunais_L --
	Real_Name = "[Executor.Kunais_L]/[Executor.Kunais] Chain Kunais (T)"
	Delay(10)
	if(Executor.name == "Suigetsu") Flick("throw", Executor)
	else
		if(Executor.on_ground) Flick("punch[rand(1,5)]", Executor)
		else Flick("airpunch", Executor)
	Executor.freeze ++
	spawn(2.5)
		new/obj/Chain_Kunai (Executor.loc, Executor)
		Executor.freeze --
		Executor.stop()

obj/proc/Makibishi_Shuriken()
	var/mob/Executor = usr
	if(Executor.Bijuu || Executor.Shuriken_Cooldown) return
	if(Executor.Shurikens_L <= 0|| Executor.Susanoo) return
	if(Executor.Can_Execute(src, 0) == 0) return
	if(length(Executor.Existing_Shurikens) >= 5) {Executor<<"<b><font color=red><u>You can only use up to 5 Makibishi Spikes at the same time!</u>"; return}

	Executor.Shurikens_L --
	name = "[Executor.Shurikens_L]/[Executor.Shurikens] Makibishi Spikes (G)"
	if(Executor.client)
		Executor.Shuriken_Cooldown = 1
		for(var/obj/Jutsus/J in Executor)
			if(J.Delay == 1) J.Delay = 2
			else if(!J.Delay) J.Delay(2)
		spawn(3.3) Executor.Shuriken_Cooldown = 0
	if(Executor.name == "Suigetsu") Flick("throw", Executor)
	else
		if(Executor.on_ground) Flick("punch[rand(1,5)]", Executor)
		else Flick("airpunch", Executor)
	spawn(0.5) new/mob/Makibishi_Shuriken (Executor.loc, Executor)

mob/var/Shuriken_Cooldown

obj

	Chain
		icon = 'Kunais Special I.dmi'
		icon_state = "Chain"
		layer = 300
		pixel_y = 24
		New(loc, obj/Chain_Kunai/_Creator_)
			..()
			_Creator_.Chain.Add(src)
			pixel_x = _Creator_.pixel_x
			step_x = _Creator_.step_x
			step_y = _Creator_.step_y
			loc = _Creator_.loc
			dir = _Creator_.dir
			spawn(20)
				if(!_Creator_) del(src)
				if(_Creator_.Found_Enemy) return
				if(dir == EAST)
					if(pixel_x == 16) _Creator_.Spot_To_Go = "[x+1], 0"
					else _Creator_.Spot_To_Go = "[x], [pixel_x]"
				else
					if(pixel_x == -16) _Creator_.Spot_To_Go = "[x-1], 0"
					else _Creator_.Spot_To_Go = "[x], [pixel_x]"
				del(src)

	Chain_Kunai
		icon = 'Kunais Special I.dmi'
		layer = 300
		pixel_y = 24
		pheight = 22
		pwidth = 52
		var/Spot_To_Go
		var/mob/_Owner_
		var/Found_Enemy
		var/First_Time
		var/list/Chain = list()

		New(loc, mob/_Creator_)
			..()
			bound_y = 10
			_Owner_ = _Creator_
			step_x = _Owner_.step_x
			step_y = _Owner_.step_y
			dir = _Owner_.dir
			if(dir == EAST) x++
			Spot_To_Go = "[x], 0"
			spawn(0.30) Start()

		proc
			Start()
				..()
				loop
					if(Found_Enemy) return

					new/obj/Chain (loc, src)
					if(dir == EAST)
						if(pixel_x == 16)
							x ++
							pixel_x = 0
						else pixel_x += 16
					else
						if(pixel_x == -16)
							x --
							pixel_x = 0
						else pixel_x -= 16
					Around()

					spawn(0.30) goto loop



			Around()
				..()
				var/T
				for(var/atom/A in obounds(src))
					if(!A.density || istype(A, /turf/Wall_Stand)) continue
					if(ismob(A))
						if(!A:Real || A:Dragonned || A:Village == _Owner_.Village || A:Dodge_Next || A:Chained || T) continue
						if(A:Dodging == 1) A:Auto_Dodge(src, 1)
						else
							T++
							A:Damage(_Owner_, 15, 1, null, src)
							Return_Enemy (A)
					else
						if(dir == EAST) First_Time ++
						if(First_Time != 1) del(src)

			Return_Enemy(mob/A)
				..()
				icon_state = "Chained"
				A.step_x = 0+pixel_x
				A.Chained = 1
				A.freeze ++
				A.stop()
				if(dir == EAST) step_x = 16
				else step_x = 46
				Found_Enemy = 1
				var/_Freeze_ = A.freeze

				loop
					if(A.dead || A.knocked)
						A.Chained = 0
						A.freeze --
						A.stop()
						for(var/C in Chain) del(C)
						del(src)
						return

					else if(A.freeze <= _Freeze_)

						if(dir == EAST)
							if(pixel_x == -16)
								x --
								pixel_x = 0
							else pixel_x -= 16
							A.set_pos(A.px-16, A.py)
							for(var/obj/Chain/C in loc) if(Chain.Find(C) && C.pixel_x == pixel_x+16) del(C)
						else
							if(pixel_x == 16)
								x ++
								pixel_x = 0
							else pixel_x += 16
							A.set_pos(A.px+16, A.py)
							for(var/obj/Chain/C in loc) if(Chain.Find(C) && C.pixel_x == pixel_x || Chain.Find(C) && C.pixel_x == pixel_x-16) del(C)


						if(Spot_To_Go == "[x], [pixel_x]")
							A.Chained = 0
							A.freeze --
							A.stop()
							for(var/C in Chain) del(C)
							del(src)
							return

					spawn(0.4) goto loop

mob/var/Chained