//mob/proc/Damage(mob/Target_, var/Amount, var/Death, var/Knockback, mob/Direction, var/Meele, var/Special, var/AOE, var/Extra)

obj/proc/Check_Pixels()
	loop
		if(pixel_x > 32) {pixel_x -= 32; x++; goto loop}
		else if(pixel_x < -32) {pixel_x += 32; x--; goto loop}
		if(pixel_y > 32) {pixel_y -= 32; y++; goto loop}
		else if(pixel_y < -32) {pixel_y += 32; y--; goto loop}

obj
	Water_Eruption
		icon = 'Graphics/Skills/Water Eruption.dmi'
		layer = 155
		pixel_y = -8
		var/list/_Enemies_ = list()
		alpha = 175

		New(loc, mob/Executor, obj/Water_Eruption/O)
			..()
			if(!O)
				dir = Executor.dir
				loc = Executor.loc
				pixel_x = Executor.pixel_x
			else
				O.alpha -= 15
				_Enemies_ = O._Enemies_
				dir = O.dir
				loc = O.loc
				x = O.x
				y = O.y
				pixel_x = O.pixel_x

			if(dir == EAST)
				if(!O)
					pixel_x += 18
				pixel_x += 48
			else
				if(!O) pixel_x += 48
				pixel_x -= 48
			Check_Pixels()

			bound_width = 58
			bound_x = pixel_x
			bound_x -= 24
			if(dir == WEST) bound_x -= 4
			bound_y = -4
			var/T = 0
			var/G
			var/N = 1
			spawn(5) del(src)
			spawn(4)
				loop
					alpha -= 25
					spawn(0.50) goto loop

			bound_y -= 32
			bound_height = 75

			for(var/atom/A in obounds(src)) if(A.density || istype(A, /turf/Special_Floor))
				if(ismob(A) && A:Real && A:ByPass) continue
				G = 1
			if(!G) del(src)

			bound_y += 32

			spawn(0.790)
				bound_y = 0
				for(var/atom/A in obounds(src)) if(A.density)
					if(ismob(A) && A:Real && A:ByPass) continue
					if(istype(A, /turf/Special_Floor)) continue
					if(dir == EAST && istype(A, /turf/Wall_Stand)) continue
					N = 0
				if(N) new/obj/Water_Eruption (loc, Executor, src)
				bound_y = -4

			loop
				T++
				if(T > 4) return

				if(T == 1) {bound_height = 90; flick("Go", src)}
				else if(T == 2 || T == 3 || T == 4)
					bound_height = 90
					for(var/mob/M in obounds(src))
						if(_Enemies_.Find(M)) continue
						if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && !M.Dragonned)
							if(M.Village == Executor.Village && M != Executor)
								M.vel_y = 6
								_Enemies_(M, 1)
							else
								if(M.Dodging == 1)
									_Enemies_(M)
									M.Auto_Dodge (Executor)
									Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
								else if(Executor.dir == EAST && M.px >= Executor.px || Executor.dir == WEST && M.px <= Executor.px) {M.Damage(Executor, 35+rand(0, 15), 1, 0, src, 1); M.vel_y = 8; _Enemies_(M)}
				spawn(1) goto loop

		proc/_Enemies_(mob/M, var/G)
			_Enemies_.Add(M)
			var/T = 14.5
			if(G) T = 3.5
			spawn(T) _Enemies_.Remove(M)

	Earth_Rising
		icon = 'Graphics/Skills/Tsuchikage I.dmi'
		layer = 155
		pixel_y = -8
		var/list/_Enemies_ = list()

		New(loc, mob/Executor, obj/Wood_Column/O)
			..()
			if(!O)
				dir = Executor.dir
				loc = Executor.loc
				pixel_x = Executor.pixel_x
			else
				_Enemies_ = O._Enemies_
				dir = O.dir
				loc = O.loc
				x = O.x
				y = O.y
				pixel_x = O.pixel_x

			if(dir == EAST)
				if(!O)
					pixel_x -= 12
				pixel_x += 64
			else
				if(!O) pixel_x += 8
				pixel_x -= 64
			Check_Pixels()

			bound_width = 128
			bound_x = pixel_x
			bound_x -= 4
			if(dir == WEST) bound_x -= 46
			bound_y = -4
			var/T = 0
			var/G
			var/N = 1
			spawn(10) del(src)
			spawn(6)
				loop
					alpha -= 25
					spawn(0.50) goto loop

			bound_y -= 32
			bound_height = 33

			for(var/atom/A in obounds(src)) if(A.density || istype(A, /turf/Special_Floor))
				if(ismob(A) && A:Real && A:ByPass) continue
				G = 1
			if(!G) del(src)

			bound_y += 32

			spawn(1.50)
				bound_y = 0
				for(var/atom/A in obounds(src)) if(A.density)
					if(ismob(A) && A:Real && A:ByPass) continue
					if(istype(A, /turf/Special_Floor)) continue
					if(dir == EAST && istype(A, /turf/Wall_Stand)) continue
					N = 0
				if(N) new/obj/Earth_Rising (loc, Executor, src)
				bound_y = -4

			loop
				T++
				if(T > 4) return

				if(T == 1) {bound_height = 65; flick("Go", src)}
				else
					bound_height = 70
					for(var/mob/M in obounds(src))
						if(_Enemies_.Find(M)) continue
						if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && !M.Dragonned)
							if(M.Village == Executor.Village && M != Executor)
								M.vel_y = 6
								_Enemies_(M, 1)
							else
								if(M.Dodging == 1)
									_Enemies_(M)
									M.Auto_Dodge (Executor)
									Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
								else if(Executor.dir == EAST && M.px >= Executor.px || Executor.dir == WEST && M.px <= Executor.px) {M.Damage(Executor, 35+rand(0, 10), 1, 1, src, 1); _Enemies_(M)}
				spawn(1) goto loop

		proc/_Enemies_(mob/M, var/G)
			_Enemies_.Add(M)
			var/T = 14.5
			if(G) T = 3.5
			spawn(T) _Enemies_.Remove(M)


	Wood_Column
		icon = 'Graphics/Skills/Yamato I.dmi'
		layer = 155
		alpha = 255
		pixel_y = -4
		var/list/_Enemies_ = list()

		New(loc, mob/Executor, obj/Wood_Column/O)
			..()
			if(!O)
				dir = Executor.dir
				loc = Executor.loc
				pixel_x = Executor.pixel_x
			else
				_Enemies_ = O._Enemies_
				dir = O.dir
				loc = O.loc
				pixel_x = O.pixel_x

			if(dir == EAST)
				if(!O) pixel_x -= 20
				pixel_x += 80
			else
				if(!O) pixel_x += 40
				pixel_x -= 80
			Check_Pixels()

			bound_width = 80
			bound_height = 32
			bound_x = pixel_x
			bound_y = -4
			if(dir == WEST && !O)
				bound_width += 32
				bound_x -= 80
			var/T = 0
			var/R = 0
			var/G
			var/N = 1
			spawn(35) del(src)

			bound_y -= 32
			bound_height += 32

			for(var/atom/A in obounds(src)) if(A.density || istype(A, /turf/Special_Floor))
				if(ismob(A) && A:Real && A:ByPass) continue
				G = 1
			if(!G) del(src)

			bound_y += 32
			bound_height -= 32

			spawn(1.25)
				bound_y = 0
				for(var/atom/A in obounds(src)) if(A.density)
					if(ismob(A) && A:Real && A:ByPass) continue
					if(istype(A, /turf/Special_Floor)) continue
					if(dir == EAST && istype(A, /turf/Wall_Stand)) continue
					N = 0
				if(N) new/obj/Wood_Column (loc, Executor, src)
				bound_y = -4

			loop
				if(R) T--
				else T++

				if(T == 1) {bound_height = 22; R = 0; flick("Go", src)}
				else if(T == 2) bound_height = 56
				else if(T == 3) bound_height = 78
				else if(T == 4) {bound_height = 100; R = 1}
				if(T != 1) for(var/mob/M in obounds(src))
					if(_Enemies_.Find(M)) continue
					if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && !M.Dragonned)
						if(M.Village == Executor.Village && M != Executor)
							M.vel_y = 6
							_Enemies_(M, 1)
						else
							if(M.Dodging == 1)
								_Enemies_(M)
								M.Auto_Dodge (Executor)
								Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
							else if(Executor.dir == EAST && M.px >= Executor.px || Executor.dir == WEST && M.px <= Executor.px) {M.Damage(Executor, 15.5+rand(0, 5), 1, 1, src, 1); _Enemies_(M)}
				spawn(1.25) goto loop

		proc/_Enemies_(mob/M, var/G)
			_Enemies_.Add(M)
			var/T = 14.5
			if(G) T = 3.5
			spawn(T) _Enemies_.Remove(M)

	Explosive_Fist
		icon = 'Graphics/Skills/Gari II.dmi'
		layer = 155
		alpha = 200
		New(loc, mob/Executor)
			..()
			dir = Executor.dir
			loc = Executor.loc
			bound_width = 255
			bound_height = 	130
			pixel_x = Executor.step_x
			pixel_y = (Executor.step_y) -29
			if(dir == EAST) pixel_x += 85
			if(dir == WEST) pixel_x -= 237
			Check_Pixels()

			bound_x = pixel_x
			if(dir == EAST)
				bound_x -= 24
				bound_width += 18
			if(dir == WEST) {bound_x -= 45; bound_width += 40}
			bound_y = pixel_y
			flick("Go", src)
			spawn(3.5) del(src)

			for(var/mob/M in obounds(src))
				if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && M.Village != Executor.Village && !M.Dragonned)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					else if(Executor.dir == EAST && M.px >= Executor.px || Executor.dir == WEST && M.px <= Executor.px) M.Damage(Executor, 25+rand(0, 10), 1, 2, src, 1)
	Flaming_Fist
		icon = 'Graphics/Skills/Gari I.dmi'
		layer = 155
		alpha = 200
		New(loc, mob/Executor)
			..()
			dir = Executor.dir
			loc = Executor.loc
			bound_width = 310
			bound_height = 	105
			pixel_x = Executor.step_x
			pixel_y = (Executor.step_y) -55
			if(dir == EAST) pixel_x += 62
			if(dir == WEST) pixel_x -= 214
			Check_Pixels()

			bound_x = pixel_x
			if(dir == EAST) bound_width -= 6
			if(dir == WEST) {bound_x -= 60; bound_width += 60}
			bound_y = pixel_y
			var/A = new/obj/Flaming_Fist_Overlay (loc, src)
			spawn(3.75)
				del(A)
				del(src)

			for(var/mob/M in obounds(src))
				if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && M.Village != Executor.Village && !M.Dragonned)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					else if(Executor.dir == EAST && M.px >= Executor.px || Executor.dir == WEST && M.px <= Executor.px) M.Damage(Executor, 35+rand(0, 10), 1, 2, src, 1)

	Flaming_Fist_Overlay
		icon = 'Graphics/Skills/Gari I.dmi'
		layer = 156
		alpha = 200
		New(loc, obj/Obj)
			..()
			loc = Obj.loc
			dir = Obj.dir
			y = Obj.y
			x = Obj.x
			pixel_x = Obj.pixel_x
			pixel_y = Obj.pixel_y
			if(dir == EAST) pixel_x += 255
			else pixel_x -= 255
			Check_Pixels()
			flick("Go", Obj)
			flick("Go I", src)