mob/var/DodgeCD = 0
mob/var/Dodging = 0
mob/var/Dodge_Next = 0
mob/var/obj/Dodge_Text
mob/var/list/Overlays = list()
mob/var/On_Wall = 0
mob/var/obj/Effects/Wall_Standing/Wall_Freeze = null
mob/var/Overlay

mob/proc
	Overlays()
		if(Substitution)
			for(var/obj/Effects/O in Overlays) O.invisibility = 101
			return
		for(var/obj/Effects/O in Overlays)
			O.invisibility = 0
			O.alpha = alpha
			if(!O:Second_Creator && !O:__Direction) O.dir = dir
			if(O:__Direction) dir = O:__Direction
			O.loc = loc
			if(dir == EAST) O.pixel_x = O.R_Pixel_x
			else if(dir == WEST) O.pixel_x = O.L_Pixel_x
			O.step_x = px - x * icon_width
			O.step_y = py - y * icon_height
atom/proc
	Flick(Animation, atom/Atom, var/S)
		if(ismob(Atom))
			if(Atom:Susanoo) return
			if(Atom:Puppet && Animation != "atk") return
			if(Atom:knocked) return
			if(Atom:GoingSage) if(Animation == "hurt") return
			else if(Atom:Punch_Animation) if(!findtext(Animation, "punch") && !Atom:knockback && S) return
		flick(Animation, Atom)

obj/Edo_Object
	icon = 'Graphics/Skills/Edo Object.dmi'
	pixel_y = -10
	layer = 85
	New(loc, mob/E, mob/C)
		..()
		spawn(25) del(src)

		E.CanBeRevived = 0
		E.layer = 0
		var/Direction = C.dir
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (C.loc, C, 2, 96, Direction)
		var/list/Turfs = Bounds.Turfs()
		var/_T_
		for(var/turf/T in Turfs)
			if(C.dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (C.loc, C, 2, 96, Direction)
			E.set_pos(Bound.px, Bound.py)
			_T_ ++
		if(!_T_) E.set_pos(Bounds.px, Bounds.py)
		E.dir = Direction
		if(E.client)
			E.client.perspective = EYE_PERSPECTIVE
			E.client.eye = E
		new/obj/Effects/Edo_Object (E.loc, E)
		E.dead = 0
		E.knocked = 1
		spawn(10)
			E.knocked = 0
			E.Dragonned = 1
			E.MaxEnergy /= 1.35
			E.Def /= 1.25
			E.Str /= 1.25
			E.MaxHP = 75
			E.HP = E.MaxHP
			E.Cha = E.MaxCha
			E.Energy = E.MaxEnergy
			E.density = 1
			E.Run_Off()
			E.verbs-=typesof(/mob/Dead/verb)
			E.icon_state = "mob-standing"
			E.CanUseGates = 0
			E.CanGoKyuubi = 0
			E.Edo = new/obj/Effects/Edo_Aura (E.loc, E)
			E.Edo.icon *= "#190707"
			E.CanGoCS = 0
			E.layer = 101
			E.alpha = 100
			if(!E.Moving) E.Movement()
			spawn(1) E.alpha = 112
			spawn(2) E.alpha = 124
			spawn(3) E.alpha = 136
			spawn(4) E.alpha = 148
			spawn(5) E.alpha = 160
			spawn(6) E.alpha = 172
			spawn(7) E.alpha = 184
			spawn(8) E.alpha = 196
			spawn(9) E.alpha = 208
			spawn(10) E.alpha = 220
			spawn(11) E.alpha = 232
			spawn(12) E.alpha = 244
			spawn(13)
				E.layer = 100
				E.alpha = 255
				E.Dragonned = 0
				E.freeze = 0
				E.stop()

obj/Effects
	var
		__Direction
		Pixel_Y
		R_Pixel_x
		L_Pixel_x
		mob/Creator
		mob/Second_Creator

	New(loc, mob/Creator_, dir_, mob/_Creator)
		Creator = Creator_
		dir = Creator_.dir
		if(dir_)
			dir = dir_
			__Direction = dir
		if(_Creator) Second_Creator = _Creator
		loc = Creator_.loc
		step_x = Creator_.step_x
		step_y = Creator_.step_y
		pixel_y += Pixel_Y
		if(dir == EAST) pixel_x += R_Pixel_x
		if(dir == WEST) step_x += L_Pixel_x
		..()

	Smoke
		layer = 110
		icon = 'Graphics/Smoke II.dmi'
		New()
			..()
			Flick("Go", src)
			spawn(7) del(src)

	Player_Icon
		alpha = 200
		layer = 150
		icon = 'Graphics/Players.dmi'
		R_Pixel_x = 46
		L_Pixel_x = 42
		Pixel_Y = 60
		New()
			..()
			loc = null
			Creator.Overlay ++
			Creator.Overlays.Add(src)
			icon_state = "[length(Creator.Squad.Members)][Creator.Squad.Color]"

	Fuu_Special
		layer = 150
		icon = 'Graphics/Skills/Fuu Jutsu.dmi'
		R_Pixel_x = -68
		L_Pixel_x = 58
		New()
			..()
			if(!Creator) del(src)
			else
				Flick("Go", src)
				spawn(200) del(src)

	Yondaime_Special
		layer = 150
		icon = 'Graphics/Skills/Yondaime Special.dmi'
		Pixel_Y = -32
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(12.75) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()
	Mini_Shark
		layer = 150
		icon = 'Graphics/Skills/FShark.dmi'
		Pixel_Y = -4
		R_Pixel_x = 4
		L_Pixel_x = -4
		New()
			..()
			if(!Creator) del(src)
			else
				Flick("Go", src)
				spawn(8) del(src)

	Rock_Lee_Gates
		layer = 150
		icon = 'Graphics/Skills/Rock Lee Gates Transformation.dmi'
		Pixel_Y = -3
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.invisibility = 101
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(12.25) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()
	Explosive_Combo
		layer = 150
		icon = 'Graphics/Skills/Gari III.dmi'
		Pixel_Y = -1
		R_Pixel_x = 31
		L_Pixel_x = -111
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.invisibility = 101
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(10) del(src)
		Del()
			new/obj/Effects/Explosive_Combo_ (Creator.loc, Creator)
			Creator.Overlay --
			..()
	Explosive_Combo_
		layer = 150
		icon = 'Graphics/Skills/Gari III.dmi'
		Pixel_Y = -1
		L_Pixel_x = 31
		R_Pixel_x = -111
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go I", src)
				spawn(7) del(src)
		Del()
			Creator.Overlay --
			if(Creator.dir == EAST) Creator.dir = WEST
			else Creator.dir = EAST
			Creator.Dragonned = 0
			Creator.invisibility = 0
			Creator.freeze --
			Creator.stop()
			..()
	Flying_Swallow
		layer = 150
		icon = 'Graphics/Skills/Asuma I.dmi'
		Pixel_Y = -60
		L_Pixel_x = -10
		alpha = 175
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.invisibility = 101
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(6) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.Overlay --
			Creator.freeze --
			Creator.stop()
			..()

	Domed_Wall
		layer = 99
		icon = 'Graphics/Skills/Yamato II.dmi'
		icon_state = "Normal"
		Pixel_Y = -10
		L_Pixel_x = -20
		var/mob/_To_Drain
		var/Ending
		New()
			..()
			if(!Creator) del(src)
			else
				spawn()
					if(_To_Drain == Creator) _To_Drain<<"<b><font color=#CFA16C><u>You're currently protecting yourself, to stop press S.</u>"
					else
						_To_Drain<<"<b><font color=#CFA16C><u>You're currently protecting [Creator.name], to stop press S.</u>"
						Creator<<"<b><font color=#CFA16C><u>You're currently being protected by [Creator.name], to stop press S.</u>"
					Creator.On_Wood_Wall = src
					_To_Drain.W_Protecting = src
					_To_Drain.Regenerate_Chakra = 0
					_To_Drain.Wood_Wall = 0
					loc = null
					Creator.layer = 95
					Creator.Overlay ++
					Creator.freeze ++
					Creator.Dragonned = 1
					Creator.Overlays.Add(src)
					Flick("Go", src)

			spawn(21)

				loop
					if(Ending) return
					if(!_To_Drain || _To_Drain.name != "Yamato" && _To_Drain.name != "Hashirama Senju") Delete()
					else if(_To_Drain.Cha <= 0)
						if(_To_Drain == Creator) _To_Drain<<"<b><font color=#CFA16C><u>You have no chakra left! The Wood Domed Wall has vanished!</u>"
						else
							_To_Drain<<"<b><font color=#CFA16C><u>You have no chakra left! The Wood Domed Wall has vanished!</u>"
							Creator<<"<b><font color=#CFA16C><u>[_To_Drain.name] has no chakra left! The Wood Domed Wall has vanished!</u>"
						Delete()
					_To_Drain.Regenerate_Chakra = 0
					_To_Drain.Cha -= 3.25
					spawn(2.5) goto loop

		proc/Delete(var/G)
			if(Ending) return

			if(G)
				if(_To_Drain == Creator) _To_Drain<<"<b><font color=#CFA16C><u>The Wood Domed Wall has vanished!</u>"
				else
					if(_To_Drain) _To_Drain<<"<b><font color=#CFA16C><u>The Wood Domed Wall has vanished!</u>"
					if(Creator) Creator<<"<b><font color=#CFA16C><u>The Wood Domed Wall has vanished!</u>"

			if(Creator) Creator.On_Wood_Wall = null
			spawn() if(_To_Drain)
				for(var/obj/Jutsus/Wood_Doomed_Wall/W in _To_Drain) W.Delay(25)
				_To_Drain.W_Protecting = null
				_To_Drain.Regenerate_Chakra = 1

			Ending = 1
			flick("End", src)

			spawn(4)
				invisibility = 101

				if(Creator)
					Creator.Dragonned = 0
					Creator.Overlay --
					Creator.freeze --
					Creator.stop()
					Creator.layer = 100
				del(src)

	Ninken_IV
		layer = 105
		icon = 'Graphics/Skills/Dogs IV.dmi'
		L_Pixel_x = -10
		R_Pixel_x = -10
		Pixel_Y = -12
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.invisibility = 101
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(11) del(src)
		Del()
			Creator.invisibility = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Sai_II
		layer = 101
		icon = 'Graphics/Skills/Sai II.dmi'
		L_Pixel_x = -10
		R_Pixel_x = -10
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(4) del(src)
		Del()
			Flick("teleport", Creator)
			Creator.stop()
			Creator.Overlay --
			..()

	Sea_Dragon
		layer = 155
		icon = 'Graphics/Skills/Temari I.dmi'
		Pixel_Y = -8
		R_Pixel_x = -8
		L_Pixel_x = 6
		alpha = 200
		New()
			..()
			Flick("Go", src)
			spawn(8) del(src)

	Two_Rising_Dragons
		layer = 150
		icon = 'Graphics/Skills/Tenten Special.dmi'
		Pixel_Y = -8
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(26) del(src)
		Del()
			Flick("teleport", Creator)
			Creator.invisibility = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Kakashi_Raikiri
		layer = 150
		icon = 'Graphics/Skills/Kakashi Raikiri X.dmi'
		Pixel_Y = -11
		L_Pixel_x = -10
		R_Pixel_x = -10
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.invisibility = 101
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
		Del()
			Creator.invisibility = 0
			Creator.Overlay --
			..()

	Jyuuken_I
		layer = 150
		icon = 'Graphics/Skills/Hina 2.dmi'
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Second_Creator.Dragonned = 1
				Creator.Dragonned = 1
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(16) del(src)
		Del()
			Creator.Overlay --
			Creator.Overlays.Remove(src)
			new/obj/Effects/Jyuuken_II (Creator, Creator, null, Second_Creator)
			..()

	Devouring_Snakes
		layer = 115
		alpha = 200
		Pixel_Y = -6
		L_Pixel_x = -10
		R_Pixel_x = -10
		icon = 'Graphics/Skills/Kabuchimaru Special X.dmi'
		New()
			..()
			Flick("Go", src)
			spawn(7.2) del(src)
		Del()
			Creator.Overlay --
			..()

	Hanabi_Special_I
		layer = 125
		Pixel_Y = -66
		L_Pixel_x = -10
		R_Pixel_x = -30
		icon = 'Graphics/Skills/Hanabi Special.dmi'

		New()
			..()
			Creator.invisibility = 101
			Flick("Go", src)
			spawn(40.50)
				step_y += 54
				Creator.Substitution = 1
				if(Creator.dir == EAST)
					step_x += 45
					Creator.set_pos(Creator.px+31, Creator.py+54)
				else
					step_x -= 45
					Creator.set_pos(Creator.px-31, Creator.py+54)
			spawn(49) del(src)

		Del()
			Creator.Overlay --
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			..()

	Hanabi_Special_II
		layer = 125
		Pixel_Y = -2
		L_Pixel_x = -4
		R_Pixel_x = -18
		icon = 'Graphics/Skills/Hanabi Special X.dmi'

		New()
			..()
			Creator.invisibility = 101
			Flick("Go", src)
			spawn(12)
				step_y -= 20
				if(Creator.dir == EAST)
					step_x -= 30
					Creator.set_pos(Creator.px-30, Creator.py-20)
				else
					step_x += 30
					Creator.set_pos(Creator.px+30, Creator.py-20)
			spawn(34) del(src)

		Del()
			Creator.Overlay --
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			..()

	Hanabi_Special_III
		layer = 125
		Pixel_Y = -23
		L_Pixel_x = -45
		R_Pixel_x = -40
		icon = 'Graphics/Skills/Hanabi Special XX.dmi'

		New()
			..()
			Creator.invisibility = 101
			Flick("Go", src)
			spawn(10) del(src)

		Del()
			Creator.Overlay --
			Creator.invisibility = 0
			Creator.freeze --
			Creator.stop()
			..()

	Edo_Object
		layer = 85
		Pixel_Y = -10
		L_Pixel_x = -10
		R_Pixel_x = -10
		icon = 'Graphics/Skills/Edo Object.dmi'
		New()
			..()
			Flick("Go", src)
			spawn(30) del(src)
		Del()
			Creator.Overlay --
			..()

	RL_Hit
		layer = 155
		icon = 'Graphics/Skills/Rock Lee Gates Special VI.dmi'
		Pixel_Y = -35
		R_Pixel_x = -32
		L_Pixel_x = 32
		New()
			..()
			Flick("Go", src)
			spawn(4) del(src)

	RL_Special_I
		layer = 150
		icon = 'Graphics/Skills/Rock Lee Gates Special I.dmi'
		Pixel_Y = -3
		New()
			..()
			Flick("Go", src)
			spawn(23.75) del(src)

	RL_Special_II
		layer = 150
		icon = 'Graphics/Skills/Rock Lee Gates Special II.dmi'
		L_Pixel_x = 10
		Pixel_Y = -3
		New()
			..()
			Flick("Go", src)
			spawn(8) del(src)

	RL_Special_III
		layer = 150
		icon = 'Graphics/Skills/Rock Lee Gates Special III.dmi'
		Pixel_Y = -3
		New()
			..()
			Flick("Go", src)
			spawn(17) del(src)

	RL_Special_IV
		layer = 150
		icon = 'Graphics/Skills/Rock Lee Gates Special IV.dmi'
		Pixel_Y = -3
		New()
			..()
			flick("Go", src)
			loc = null
			Creator.Overlay ++
			Creator.Overlays.Add(src)
			spawn(6.25) del(src)

		Del()
			Creator.Overlay --
			..()

	RL_Special_V
		layer = 150
		icon = 'Graphics/Skills/Rock Lee Gates Special V.dmi'
		Pixel_Y = -25
		icon_state = ""
		New()
			..()
			loc = null
			Creator.Overlay ++
			Creator.Overlays.Add(src)
			loop
				alpha = rand(185, 255)
				spawn(0.75) goto loop

		Del()
			Creator.Overlay --
			..()

	RL_Special_VI
		layer = 150
		icon = 'Graphics/Skills/Rock Lee Gates Special IV.dmi'
		Pixel_Y = -3
		New()
			..()
			if(!Creator) del(src)
			else
				flick("Go", src)
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Creator.client.perspective = MOB_PERSPECTIVE
				Creator.client.eye = Creator
				spawn(6.25) del(src)
		Del()
			Creator.Overlay --
			Creator.invisibility = 0
			Creator.Substitution = 0
			Creator.Special_Eye = 0
			Creator.freeze --
			Creator.Dragonned = 0
			..()


	Jyuuken_II
		layer = 150
		icon = 'Graphics/Skills/Hina 3.dmi'
		New()
			..()
			if(!Creator) del(src)
			else
				Second_Creator.Substitution = 1
				Second_Creator.dir = Creator.dir
				Second_Creator.px = Creator.px
				Second_Creator.py = Creator.py
				Second_Creator.loc = Creator.loc
				loc = Second_Creator.loc
				Second_Creator.Dragonned = 1
				Creator.Dragonned = 1
				step_x = Second_Creator.step_x
				step_y = Second_Creator.step_y
				pixel_y = -5
				if(Second_Creator.dir == EAST) pixel_x -= 43
				if(Second_Creator.dir == WEST) pixel_x += 3
				Flick("Go", src)
				spawn(8) del(src)
		Del()
			Second_Creator.Substitution = 0
			Flick("teleport", Second_Creator)
			Creator.Overlay --
			Second_Creator.client.perspective = MOB_PERSPECTIVE
			Second_Creator.client.eye = Second_Creator
			Second_Creator.invisibility = 0
			Second_Creator.Dragonned = 0
			Second_Creator.freeze --
			Second_Creator.stop()
			..()

	Hinata_U
		layer = 149
		icon = 'Graphics//Skills/Hinata.dmi'
		Pixel_Y = -16
		L_Pixel_x = -38
		R_Pixel_x = -34
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(32) del(src)
		Del()
			Flick("teleport", Creator)
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Orochimaru_Mission
		layer = 149
		icon = 'Graphics/Skills/Orochimaru Mission.dmi'
		L_Pixel_x = -50
		R_Pixel_x = -10
		New()
			..()
			if(!Creator) del(src)
			else
				loc = Creator.loc
				Creator.Substitution = 1
				spawn() Mission_Show_(Creator, "<font color=#4B246E><b><font size=3><center>It seems that the experiment failed...", Creator.NEM_Round, 40)
				Creator.invisibility = 101
				Creator.Icon_State = null
				Flick("Start", src)
				Creator.pixel_x += 14
				Creator.pixel_y += 12
				spawn(210) del(src)
				spawn(50)
					spawn(70) {Creator.stop(); Creator.invisibility = 101; flick("Second", src)}
					spawn(75) {Creator.set_pos(Creator.px-107, Creator.py+18); flick("Go", Creator); Creator.Icon_State = "Dash"; Creator.running = 0; spawn(4.5) Creator.vel_x = -35; Creator.invisibility = 0; Creator.NEM_Round.Del("Victory")}
					spawn() while(Creator.vel_x < 0) {Creator.vel_x += Creator.decel; if(Creator.vel_x > 0) Creator.vel_x = 0; sleep(0.35)}
					spawn(13) Mission_Show_(Creator, "<font color=#4B246E><b><font size=3><center>Oh well, I have more important stuff to do ...\nSo pardon me, but I have to go now", Creator.NEM_Round, 55)
					spawn(8) Creator.pixel_y = 0
					Creator.stop()
					Creator.vel_y = 8
					Creator.vel_x = -12
					Creator.invisibility = 0
		Del()
			Flick("teleport", Creator)
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			..()

	Tobirama_Shield
		layer = 150
		icon = 'Graphics//Skills/Tobirama Shield.dmi'
		Pixel_Y = -5
		L_Pixel_x = -31
		R_Pixel_x = -31
		New()
			..()
			Creator.Overlays.Add(src)
			Creator.Overlay ++
			flick("Go", src)
			icon_state = "Wait"
		Del()
			Creator.Overlay --
			Creator.Overlays.Remove(src)
			flick("End", src)
			spawn(2) ..()

	Suigetsu_Water
		layer = 150
		icon = 'Graphics//Skills/Suigetsu Appear.dmi'
		Pixel_Y = -6
		L_Pixel_x = -10
		R_Pixel_x = -10
		New()
			..()
			flick("Go", src)
			spawn(4.75) del(src)

	Bijuu_Attack
		var/Time_To_Show
		layer = 105

		New()
			L_Pixel_x -= (11-18)
			R_Pixel_x -= (8-18)
			Pixel_Y += 1
			..()

			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				Creator.invisibility = 101
				spawn(Time_To_Show) del(src)

		Del()
			if(!Creator.Substitution) Creator.invisibility = 0
			Creator.Overlay --
			..()


		I
			icon = 'Graphics//Skills/Bijuu Attack I.dmi'
			Time_To_Show = 6.75
			L_Pixel_x = -53
			R_Pixel_x = 22
		II
			icon = 'Graphics//Skills/Bijuu Attack II.dmi'
			Time_To_Show = 5.75
			L_Pixel_x = -53
			R_Pixel_x = 22
		III
			icon = 'Graphics//Skills/Bijuu Attack III.dmi'
			Time_To_Show = 5.75
			L_Pixel_x = -34
			R_Pixel_x = 4
			Pixel_Y = -6
		IV
			icon = 'Graphics//Skills/Bijuu Attack IV.dmi'
			Time_To_Show = 6.75
			L_Pixel_x = -49
			R_Pixel_x = 19
		V
			layer = 95
			icon = 'Graphics//Skills/Bijuu Attack V.dmi'
			Time_To_Show = 9
			L_Pixel_x = -67
			R_Pixel_x = -13
			Pixel_Y = -1
			Del()
				Creator.freeze --
				if(Creator.dir == EAST) Creator.dir = WEST
				else Creator.dir = EAST
				..()
		VI
			icon = 'Graphics//Skills/Bijuu Attack Air.dmi'
			Time_To_Show = 6.45
			L_Pixel_x = -40
			R_Pixel_x = 0

	Suigetsu_Attack
		var/Time_To_Show
		layer = 105

		New()
			..()

			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				Creator.invisibility = 101
				spawn(Time_To_Show) del(src)

		Del()
			if(!Creator.Substitution) Creator.invisibility = 0
			Creator.Overlay --
			..()


		I
			icon = 'Graphics//Skills/Suigetsu Attack II.dmi'
			Time_To_Show = 5.30
			L_Pixel_x = -32
			R_Pixel_x = 6
		II
			icon = 'Graphics//Skills/Suigetsu Attack III.dmi'
			Time_To_Show = 4.85
			L_Pixel_x = -32
			R_Pixel_x = 6
		III
			icon = 'Graphics//Skills/Suigetsu Attack IV.dmi'
			Time_To_Show = 5.35
			L_Pixel_x = -32
			R_Pixel_x = 6
			Pixel_Y = -18
		IV
			icon = 'Graphics//Skills/Suigetsu Attack V.dmi'
			Time_To_Show = 5.35
			L_Pixel_x = -32
			R_Pixel_x = 6
		V
			icon = 'Graphics//Skills/Suigetsu Attack I.dmi'
			Time_To_Show = 4.5
			L_Pixel_x = -32
			R_Pixel_x = 6
		VI
			icon = 'Graphics//Skills/Suigetsu Attack VI.dmi'
			Time_To_Show = 4.6
			L_Pixel_x = -36
			R_Pixel_x = 6
	Water_Palm
		layer = 150
		icon = 'Graphics//Skills/Suigetsu Palm.dmi'
		Pixel_Y = -4
		R_Pixel_x = 16
		L_Pixel_x = -94
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.invisibility = 101
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(13) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Hinata_Air
		layer = 150
		icon = 'Graphics//Skills/Hinata 2.dmi'
		Pixel_Y = -34
		L_Pixel_x = -63
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(5.75) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Tenten
		layer = 150
		icon = 'Graphics//Skills/Tenten A.dmi'
		R_Pixel_x = -215
		L_Pixel_x = 85
		New()
			..()
			var/list/L = list()
			var/obj/C = new/obj/Effects/Tenten_B (Creator, Creator, dir, Second_Creator)
			L.Add(C)
			L.Add(src)
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				for(var/obj/Effects/O in L) Flick("Go", O)
				spawn(12.5) del(src)
		Del()
			for(var/obj/Jutsus/Scythe_Summoning/J in Second_Creator) J.Delay(20)
			Flick("teleport", Second_Creator)
			Second_Creator.client.perspective = MOB_PERSPECTIVE
			Second_Creator.client.eye = Second_Creator
			Second_Creator.invisibility = 0
			Second_Creator.Dragonned = 0
			Second_Creator.CanMove = 1
			Second_Creator.freeze --
			Second_Creator.stop()
			Second_Creator.Overlay --
			..()

	Tenten_B
		layer = 150
		R_Pixel_x = 40
		L_Pixel_x = -170
		icon = 'Graphics//Skills/Tenten B.dmi'
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlays.Add(src)
				spawn(12.5) del(src)

	Ninken_I
		layer = 150
		icon = 'Graphics/Skills/Dogs I.dmi'
		Pixel_Y = -4
		R_Pixel_x = 140
		L_Pixel_x = -200
		New()
			..()
			Flick("Go", src)
			spawn(9) del(src)

	Ninken_II
		layer = 151
		icon = 'Graphics/Skills/Dogs II.dmi'
		R_Pixel_x = -12
		L_Pixel_x = 6
		New()
			..()
			Flick("Go", src)
			spawn(21) del(src)

	Ninken_III
		layer = 151
		icon = 'Graphics/Skills/Dogs III.dmi'
		R_Pixel_x = -12
		L_Pixel_x = 6

		New()
			..()
			Flick("Go", src)
			spawn(75) del(src)

		Del()
			Flick("End", src)
			spawn(6) ..()

	Flame_Imprisonment
		layer = 150
		icon = 'Graphics/Skills/Tobi I.dmi'
		Pixel_Y = -4
		R_Pixel_x = -12
		L_Pixel_x = 12
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				var/_HP = Second_Creator.HP
				loop
					spawn(2.5)

						Second_Creator.icon_state = "mob-shooting"
						Second_Creator.Regenerate_Chakra = 0
						Creator.Regenerate_Chakra = 0
						Creator.Poison = 1
						Creator.Damage(Second_Creator, rand(2, 3), 1, 0, 0, 1)
						Second_Creator.Cha -= 4.5+rand(0, 1.5)
						if(Second_Creator.HP < _HP || Creator.knocked || Second_Creator.knocked || Second_Creator.Cha <= 4.5) del(src)
						else spawn(1.5) goto loop

		Del()
			for(var/obj/Jutsus/Flame_Imprisonment/F in Second_Creator) F.Delay(30)
			for(var/obj/Jutsus/Flame_Battle_Encampment/F in Second_Creator) F.Delay(15)
			for(var/obj/Jutsus/Fire_Dragon_Tobi/F in Second_Creator) F.Delay(2)
			for(var/obj/Jutsus/Huge_Fire_Sphere_Tobi/F in Second_Creator) F.Delay(2)
			for(var/obj/Jutsus/Giant_FireBall_Tobi/F in Second_Creator) F.Delay(2)
			Creator.Overlay --
			Creator.Dragonned = 0
			Second_Creator.Special_ = 0
			Second_Creator.Doming = 0
			Second_Creator.Regenerate_Chakra = 1
			Second_Creator.freeze --
			Second_Creator.stop()
			Creator.Regenerate_Chakra = 1
			Creator.freeze --
			Creator.Poison = 0
			Creator.stop()
			..()

	R_Hit
		layer = 150
		icon = 'Graphics/Skills/Hiruko S2.dmi'
		Pixel_Y = -4
		R_Pixel_x = 4
		L_Pixel_x = -4
		New()
			..()
			if(!Creator) del(src)
			else
				loc = Creator.loc
				Flick("Go", src)
				spawn(6.75) del(src)



	Shadow_Sewing
		icon = 'Graphics/Skills/Shikamaru S.dmi'
		layer = 200
		R_Pixel_x = -12
		L_Pixel_x = -6
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(6) del(src)
		Del()
			Creator.Overlay --
			..()

	Shadow_Neck
		icon = 'Graphics/Skills/Shikamaru S2.dmi'
		layer = 149
		R_Pixel_x = -12
		L_Pixel_x = -6
		Pixel_Y = -1
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(10) del(src)
		Del()
			Creator.Overlay --
			..()

	Choji_Pill
		layer = 150
		alpha = 150
		icon_state = "Kunai"
		icon = 'Graphics/Scrolls.dmi'
		L_Pixel_x = -18
		R_Pixel_x = -12
		New()
			..()
			if(!Creator) del(src)
			if(Creator.Choji_Pill == "Spinach")
				icon *= "#76FF84"
				Creator << "<b><font color=#76FF84><u><font size=3>Your body feels stronger...</u>"
				Creator.No_HP_Regen = 1
				spawn(200) Creator.No_HP_Regen = 0
			else if(Creator.Choji_Pill == "Curry") {icon *= "#F1F76D"; Creator << "<b><font color=#F1F76D><u><font size=3>Your body feels as if it was burning...</u>"}
			else if(Creator.Choji_Pill == "Chilli")
				icon *= "#D03939"
				Creator << "<b><font color=#D03939><u><font size=3>Your internal organs are ripping apart...</u>"
				Creator.Deaths = 4
				Creator.Transformed = 1
				Creator.Transform_Proc(600, "Chilli Pill", "#D03939")
				var/ONR = Creator.NEM_Round
				spawn(6000)
					if(!Creator.dead && Creator.NEM_Round && Creator.NEM_Round == ONR)
						Creator.HP = -100
						Creator.Death_Check ("Pill's Effects")
			loc = null
			Creator.Overlay ++
			Creator.Overlays.Add(src)

			if(Creator.Choji_Pill == "Curry")
				loop
					Creator.HP -= 0.75
					Creator.Death_Check("Pill's Effects")
					spawn(5) goto loop


		Del()
			Creator.Overlay --
			Creator.No_HP_Regen = 0
			Creator.Choji_Pill = null
			..()


	Aura_Red
		layer = 150
		alpha = 150
		icon_state = "Kunai"
		icon = 'Graphics/Scrolls.dmi'
		L_Pixel_x = -18
		R_Pixel_x = -12
		New()
			..()
			if(!Creator) del(src)
			else
				icon *= "#C90000"
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
		Del()
			Creator.Overlay --
			..()

	Pill_Aura
		layer = 150
		alpha = 150
		icon_state = "Kunai"
		icon = 'Graphics/Scrolls.dmi'
		L_Pixel_x = -8
		R_Pixel_x = -8
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
		Del()
			Creator.Overlay --
			..()

	Edo_Aura
		layer = 150
		alpha = 150
		icon_state = "Kunai"
		icon = 'Graphics/Scrolls.dmi'
		L_Pixel_x = -8
		R_Pixel_x = -8
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
		Del()
			Creator.Overlay --
			..()

	Drown
		layer = 200
		icon = 'Graphics/Drown.dmi'
		Pixel_Y = -4
		New()
			..()
			loc = Creator.loc
			Flick("Go", src)
			spawn(8.1) del(src)

	Strong_Hit
		layer = 155
		icon = 'Graphics/Strong Hit.dmi'
		Pixel_Y = 0
		R_Pixel_x = 0
		L_Pixel_x = 0
		alpha = 175
		New()
			..()
			if(!Creator) del(src)
			else
				loc = Creator.loc
				Flick("Go", src)
				spawn(4) del(src)

	Meele_Hit
		layer = 150
		icon = 'Graphics/Meele Hit.dmi'
		Pixel_Y = 6
		R_Pixel_x = 28
		L_Pixel_x = 34
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				var/P = rand(-4, 4)
				R_Pixel_x += P
				L_Pixel_x += P
				pixel_y += rand(-4, 16)
				Flick("Go", src)
				spawn(4) del(src)
		Del()
			Creator.Overlay --
			..()

	Wall_Standing
		var/Old_HP
		var/Active_W = 1
		layer = 101
		Pixel_Y = -16
		L_Pixel_x = 12
		R_Pixel_x = -32
		icon_state = "wall-standing"

		New()
			..()
			if(!Creator) del(src)
			if(z == 7 || z == 9 || z == 3 || z == 4 || z == 12 || z == 13 || z == 14 || z == 17 || Creator.NEM_Round && Creator.NEM_Round.Mode == "Weed Picking" || Creator.NEM_Round && Creator.NEM_Round.Mode == "Escort Gaara")
				L_Pixel_x += 14
				R_Pixel_x -= 16
			if(Creator.name == "Suigetsu") R_Pixel_x += 42
			if(Creator.Bijuu) R_Pixel_x += 68
			Creator.dir = __Direction
			Creator.Dodging = 0
			loc = null
			icon = Creator.icon
			Old_HP = Creator.HP
			Creator.stop()

			Creator.move_speed = Creator.speed_multiplier *10
			var/Percentage = 100*(Creator.HP/Creator.MaxHP)
			if(Percentage <= 70) Creator.move_speed /= 1.05
			if(Percentage <= 60) Creator.move_speed /= 1.05
			if(Percentage <= 50) Creator.move_speed /= 1.05
			if(Percentage <= 60) Creator.move_speed /= 1.05
			if(Percentage <= 70) Creator.move_speed /= 1.05
			if(Percentage <= 80) Creator.move_speed /= 1.05
			if(Percentage <= 90) Creator.move_speed /= 1.07
			Creator.move_speed *= Creator.Movement_Boost

			Creator.Wall_Freeze = src
			Creator.Wall_CD = 1
			spawn(0.45) Creator.Wall_CD = 0
			Creator.On_Wall = 20
			Creator.invisibility = 101
			Creator.fall_speed = 0
			Creator.Overlay ++
			Creator.Overlays.Add(src)
			Active()

		Del()
			Active_W = 0
			Creator.Wall_CD = 0
			Creator.Overlay --
			Creator.Overlays.Remove(src)
			Creator.invisibility = 0
			Creator.Wall_Freeze = null
			Creator.fall_speed = 25
			if(Creator.On_Wall > 15 && Creator.HP >= Old_HP) Creator.jump()
			if(Creator.On_Wall > 15 && Creator.HP < Old_HP) Creator.On_Wall = 0
			..()

		proc/Active()
			..()
			loop
				if(!Active_W) return

				if(Creator.On_Wall != 20 || Creator.HP < Old_HP) del(src)
				if(Creator.HP >= Old_HP)
					if(!Creator.S_K_A) Creator.Dodging = 0
					Old_HP = Creator.HP
					Creator.dir = __Direction
					Creator.invisibility = 101
					Creator.Wall_Freeze = src
					Creator.On_Wall = 20
					Creator.fall_speed = 0
					spawn(0.25) goto loop


	Kyuubi_Hand_Crush
		layer = 115
		icon = 'Graphics/Skills/Kyuubi_Hand_2.dmi'
		Pixel_Y = -2
		L_Pixel_x = -60
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(10) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Kyuubi_Claw
		layer = 115
		icon = 'Graphics/Skills/Kyuubi_Hand.dmi'
		Pixel_Y = -2
		L_Pixel_x = -60
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(10.5) del(src)
		Del()
			Creator.invisibility = 0
			Creator.layer = 100
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()


	Substitution_A
		icon = 'Graphics/Skills/SubstitutionAttack.dmi'
		layer = 151
		New()
			..()
			if(!Creator) del(src)
			else
				Flick("Go",src)
				spawn(10) del(src)

	Hit_S
		layer = 150
		icon = 'Graphics/Skills/Hit S.dmi'
		Pixel_Y = -39
		R_Pixel_x = -10
		L_Pixel_x = -10
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(5) del(src)
		Del()
			Creator.Overlay --
			..()

	Hit_R
		layer = 150
		icon = 'Graphics/Skills/Amaterasu.dmi'
		Pixel_Y = -39
		R_Pixel_x = -10
		L_Pixel_x = -10
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(5) del(src)
		Del()
			Creator.Overlay --
			..()

	Hit_SX
		layer = 150
		alpha = 200
		icon = 'Graphics/Skills/Gari IV.dmi'
		New()
			..()
			if(!Creator) del(src)
			else
				Flick("Go", src)
				spawn(5.1) del(src)
		Del()
			..()

	Fire_Tsunami
		layer = 150
		icon = 'Graphics/Skills/Madara F2.dmi'
		New()
			..()
			if(Creator.dir == EAST) pixel_x = -255
			if(Creator.dir == WEST) pixel_x = 255
			loc = null
			Creator.overlays += src
			Flick("Go", Creator)
			spawn(200) del(src)

	Tobi_Flame
		layer = 150
		icon = 'Graphics/Skills/Tobi F.dmi'
		Pixel_Y = -6
		R_Pixel_x = -6
		L_Pixel_x = 6
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(12) del(src)
		Del()
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Anko_Snake
		layer = 150
		icon = 'Graphics/Skills/Anko Snake.dmi'
		Pixel_Y = -16
		L_Pixel_x = -10
		alpha = 175
		New()
			..()
			if(!Creator) del(src)
			else
				loc = Creator.loc
				Flick("Go", src)
				spawn(7.25) del(src)
		Del() ..()

	Anko_Snake_I
		layer = 150
		icon = 'Graphics/Skills/Anko Snake I.dmi'
		L_Pixel_x = -10
		alpha = 175
		New()
			..()
			if(!Creator) del(src)
			else
				loc = Creator.loc
				Flick("Go", src)
				spawn(30) del(src)
		Del()
			flick("End", src)
			spawn(4.60) ..()

	Might_Gai
		layer = 150
		icon = 'Graphics/Skills/Might Gai.dmi'
		R_Pixel_x = 180
		L_Pixel_x = -120
		New()
			..()
			if(!Creator) del(src)
			else
				loc = Creator.loc
				Flick("Go F", src)
				icon_state = "Go"
				if(Creator.knocked) spawn(15) del(src)
				if(!Creator.knocked) spawn(22.5) del(src)
		Del()
			Flick("End", src)
			spawn(6.9) ..()

	Rock_Lee_Weights
		layer = 150
		icon = 'Graphics/Skills/Rock Lee Weights.dmi'
		Pixel_Y = -7
		New()
			..()
			if(!Creator) del(src)
			else
				step_x = Creator.step_x
				if(Creator.dir == WEST) step_x -= 28
				if(Creator.dir == EAST) step_x -= 33
				Flick("Go", src)
				spawn(21) del(src)
		Del()
			Creator.invisibility = 0
			Creator.freeze --
			Creator.Overlay --
			..()

	Madara_W
		layer = 150
		icon = 'Graphics/Skills/Madara W.dmi'
		R_Pixel_x = 35
		L_Pixel_x = -45
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(5) del(src)
		Del()
			Creator.invisibility = 0
			Creator.freeze --
			Creator.Dragonned = 0
			Creator.stop()
			Creator.Overlay --
			..()

	Madara_H
		layer = 150
		icon = 'Graphics/Skills/Madara A.dmi'
		Pixel_Y = -23
		R_Pixel_x = -35
		L_Pixel_x = -42
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(7) del(src)
		Del()
			Creator.Overlay --
			..()

	Fatal_Bite
		layer = 150
		icon = 'Graphics/Skills/Kabuchimaru Special XX.dmi'
		L_Pixel_x = -30
		R_Pixel_x = 0
		New()
			..()
			if(!Creator) del(src)
			else
				Creator.invisibility = 101
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(12.5) del(src)
		Del()
			Creator.Overlay --
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			..()

	Killer_Snakes
		layer = 150
		icon = 'Graphics/Skills/Kabuchimaru Special.dmi'
		L_Pixel_x = -165
		R_Pixel_x = 36
		Pixel_Y = -2
		New()
			..()
			if(!Creator) del(src)
			else
				Creator.invisibility = 101
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(8.8) del(src)
		Del()
			Creator.Overlay --
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			..()
	Madara_WW
		layer = 150
		icon = 'Graphics/Skills/Madara WW.dmi'
		L_Pixel_x = -120
		R_Pixel_x = -45
		Pixel_Y = -8
		New()
			..()
			if(!Creator) del(src)
			else
				new/obj/Effects/Madara_WW2 (Creator.loc, Creator)
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(14) del(src)
		Del()
			Creator.Overlay --
			..()

	Madara_WW2
		layer = 150
		icon = 'Graphics/Skills/Madara WW2.dmi'
		L_Pixel_x = 135
		R_Pixel_x = -290
		Pixel_Y = -8
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(14) del(src)
		Del()
			Creator.Overlay --
			..()

	Anko_Special
		layer = 150
		icon = 'Graphics/Skills/Anko Special.dmi'
		Pixel_Y = -7
		R_Pixel_x = -33
		L_Pixel_x = -86
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Creator.invisibility = 101
				Flick("Go", src)
				spawn(13) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Itachi_Image
		layer = 150
		icon = 'Graphics/Skills/Itachi Image.dmi'
		L_Pixel_x = -10
		New()
			..()
			loc = Creator.loc
			Flick("Go", src)
			spawn(4) del(src)

	Itachi_Dash
		layer = 150
		icon = 'Graphics/Skills/Itachi Dash.dmi'
		L_Pixel_x = -10
		New()
			..()
			loc = Creator.loc
			spawn(0.75) pixel_y = rand(-4, 4)
			Flick("Go", src)
			spawn(7.5) del(src)

	Anko_Summoning
		layer = 150
		icon = 'Graphics/Skills/Anko Summon.dmi'
		Pixel_Y = -12
		R_Pixel_x = -10
		L_Pixel_x = -10
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Creator.invisibility = 101
				Flick("Go", src)
				spawn(8.3) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Striking_Snakes
		layer = 150
		icon = 'Graphics/Skills/Anko Attack.dmi'
		R_Pixel_x = 24
		L_Pixel_x = -44
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Creator.invisibility = 101
				Flick("Go", src)
				spawn(19.05) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.stop()
			Creator.Overlay --
			..()

	Insect_Sphere
		layer = 150
		icon = 'Graphics/Skills/Shino Bug.dmi'
		Pixel_Y = -25
		R_Pixel_x = 47
		L_Pixel_x = -93
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Creator.invisibility = 101
				Flick("Go", src)
				spawn(6.25) del(src)
		Del()
			Creator.invisibility = 0
			Creator.freeze --
			Creator.Dragonned = 0
			Creator.stop()
			Creator.Overlay --
			..()

	Sand_Crush
		layer = 150
		icon = 'Graphics/Skills/Gaara.dmi'
		Pixel_Y = -2
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(12) del(src)
		Del()
			Creator.Overlay --
			..()

	Shukaku_Claw
		layer = 150
		icon = 'Graphics/Skills/Gaara Claw.dmi'
		R_Pixel_x = 24
		L_Pixel_x = -48
		New()
			..()
			if(!Creator) del(src)
			else
				Flick("Go", src)
				spawn(6) del(src)
		Del()
			..()

	Asuma_F
		layer = 150
		icon = 'Graphics/Skills/Asuma F.dmi'
		R_Pixel_x = -60
		Pixel_Y = -35
		L_Pixel_x = 5
		New()
			..()
			if(!Creator) del(src)
			else
				Flick("Go", src)
				spawn(19) del(src)

	Kakashi_Doton
		Pixel_Y = -12
		layer = 150
		icon = 'Graphics/Skills/Kakashi Raikiri.dmi'
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.invisibility = 101
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(7.5) del(src)
		Del()
			Creator.invisibility = 0
			Creator.Dragonned = 0
			Creator.freeze --
			Creator.Overlay --
			..()

	Wind_BT
		layer = 150
		icon = 'Graphics/Skills/Orochimaru Wind.dmi'
		New()
			..()
			if(!Creator) del(src)
			else
				loc = null
				Creator.Overlay ++
				Creator.Overlays.Add(src)
				Flick("Go", src)
				spawn(7.5) del(src)
		Del()
			Creator.Overlay --
			..()

	Suffocating_Paper
		layer = 150
		icon = 'Graphics/Skills/Konan Suffocating Papers.dmi'
		Pixel_Y = -4
		R_Pixel_x = -3
		L_Pixel_x = 3
		New()
			..()
			loc = null
			Creator.Overlay ++
			Creator.Overlays.Add(src)
			Flick("Go", src)
			spawn(16) del(src)
		Del()
			Creator.Overlay --
			..()

	Bug_Pillar
		layer = 150
		icon = 'Graphics/Skills/Bug Pillar.dmi'
		Pixel_Y = -3
		R_Pixel_x = 0
		L_Pixel_x = 0
		New()
			..()
			if(prob(90)) spawn(rand(2, 3.5)) new/obj/Effects/Bug_Pillar_ (Creator.loc, Creator)
			dir = pick(EAST, WEST)
			pixel_y += rand(-4, 6)
			pixel_x += rand(-46, 46)
			Flick("Go", src)
			spawn(6.25) del(src)

	Bug_Pillar_
		layer = 150
		icon = 'Graphics/Skills/Bug Pillar.dmi'
		Pixel_Y = -3
		R_Pixel_x = 0
		L_Pixel_x = 0
		New()
			..()
			Creator.Damaged_Again ++
			if(prob(85)) spawn(rand(2, 3.5)) new/obj/Effects/Bug_Pillar__ (Creator.loc, Creator)
			dir = pick(EAST, WEST)
			pixel_y += rand(-2, 14)
			pixel_x += rand(-46, 46)
			if(prob(95)) Flick("Go!", src)
			else Flick("Go", src)
			spawn(6.25) del(src)

	Bug_Pillar__
		layer = 150
		icon = 'Graphics/Skills/Bug Pillar.dmi'
		Pixel_Y = -3
		R_Pixel_x = 0
		L_Pixel_x = 0
		New()
			..()
			Creator.Damaged_Again ++
			if(prob(75)) spawn(rand(2, 3.5)) new/obj/Effects/Bug_Pillar___ (Creator.loc, Creator)
			dir = pick(EAST, WEST)
			pixel_y += rand(-2, 14)
			pixel_x += rand(-46, 46)
			if(prob(95)) Flick("Go!", src)
			else Flick("Go", src)
			spawn(6.25) del(src)

	Bug_Pillar___
		layer = 150
		icon = 'Graphics/Skills/Bug Pillar.dmi'
		Pixel_Y = -3
		R_Pixel_x = 0
		L_Pixel_x = 0
		New()
			..()
			Creator.Damaged_Again ++
			dir = pick(EAST, WEST)
			pixel_y += rand(-2, 14)
			pixel_x += rand(-46, 46)
			if(prob(95)) Flick("Go!", src)
			else Flick("Go", src)
			spawn(6.25) del(src)


	Fuuton_Poison
		layer = 150
		icon = 'Graphics/Skills/Torune Poison.dmi'
		Pixel_Y = -5
		R_Pixel_x = 77
		L_Pixel_x = -77
		New()
			..()
			loc = null
			Creator.Overlay ++
			Creator.Overlays.Add(src)
			Flick("Go", src)
			spawn(6) del(src)
		Del()
			Creator.Overlay --
			..()

	Bug_Barrage
		layer = 150
		icon = 'Graphics/Meele Hit.dmi'
		Pixel_Y = 0
		R_Pixel_x = 0
		L_Pixel_x = 0
		New()
			..()
			loc = null
			Creator.Overlay ++
			var/A = new/obj/Effects/Bug_Barrage_A (Creator.loc, Creator, dir)
			var/B = new/obj/Effects/Bug_Barrage_B (Creator.loc, Creator, dir)
			Creator.Overlays.Add(A)
			Creator.Overlays.Add(B)
			spawn(5)
				del(A)
				del(B)
				del(src)
		Del()
			Creator.Overlay --
			..()

	Bug_Barrage_A
		layer = 151
		icon = 'Graphics/Skills/Bug Barrage W.dmi'
		Pixel_Y = -6
		R_Pixel_x = -108
		L_Pixel_x = 0
		New()
			..()
			loc = null
			Flick("Go", src)

	Bug_Barrage_B
		layer = 151
		icon = 'Graphics/Skills/Bug Barrage E.dmi'
		Pixel_Y = -6
		R_Pixel_x = 108
		L_Pixel_x = -216
		New()
			..()
			loc = null
			Flick("Go", src)

mob/proc/Damage(mob/Target_, var/Amount, var/Death, var/Knockback, mob/Direction, var/Meele, var/Special, var/AOE, var/Extra, var/Shuriken)

	if(Levitating) Check_Levitating()
	if(Meele)
		if (Meele == 2) new/obj/Effects/RL_Hit (loc, src)
		else
			new/obj/Effects/Meele_Hit (loc, src)
			if(ismob(Target_)) if(!Shuriken && Target_.name == "{Venomous Insects} Torune" || Target_.name == "Orochimaru" || Target_.name == "Kabuchimaru") if(prob(25)) Poison_Proc((3), Target_.name)
	if(Special)
		if(Special == 1) new/obj/Effects/Hit_S (loc, src)
		else
			if(src.name == "Gari")
				new/obj/Effects/Hit_SX (loc, src)
			else
				new/obj/Effects/Hit_R (loc, src)


	if(ismob(Target_))
		if(Target_.Byakugan) if(prob(25)) Stop_Chakra(3)
	if(findtext(name, "{Clone}") || findtext(name, "{NPC}")) if(ismob(Target_)) if(Target_.client && Target != Target_)
		if(Target) Target.Enemies_Following.Remove(src)
		Target = Target_
		Target_.Enemies_Following.Add(src)
	if(!Meele && !Special)
		var/H = new/obj/Hit(src.loc)
		H:pixel_x = src.pixel_x
		H:pixel_y = src.pixel_y

	if(!Shuriken)
		if(!Extra)
			if(!Direction)
				if(Target_.dir == EAST) src.dir = WEST
				if(Target_.dir == WEST) src.dir = EAST

			if(Direction)
				if(Direction != src && Direction.dir == EAST) src.dir = WEST
				if(Direction != src && Direction.dir == WEST) src.dir = EAST
		else
			if(Target_.px >= px) dir = EAST
			else dir = WEST

	if(Knockback == "East") src.knockbackeastx()
	else if(Knockback == "West") src.knockbackwestx()

	if(!Direction)
		if(Knockback == 1)
			if(Target_.px < px) src.knockbackeast()
			if(Target_.px > px) src.knockbackwest()
		if(Knockback == 2)
			if(Target_.px < px) src.knockbackeastx()
			if(Target_.px > px) src.knockbackwestx()

	if(Direction)

		if(Knockback == 1)
			if(src.dir == EAST) src.knockbackwest()
			if(src.dir == WEST) src.knockbackeast()

		if(Knockback == 2)
			if(src.dir == EAST) src.knockbackwestx()
			if(src.dir == WEST) src.knockbackeastx()

	if(!Knockback && !Direction && !Shuriken)
		if(Meele) Flick("hurt", src, 1)
		if(!Meele) Flick("hurt", src)

	Interrupt = rand(1, 10000)
	Active_Attack = 0
	HP -= Amount

	if(NEM_Round == Current_NEM_Round) Statistic.Damage_Received += Amount
	if(ismob(Target_))
		if(Target_.NEM_Round == Current_NEM_Round && !Target_.Susanoo && !AOE && Amount > 0) Target_.Statistic.Damage_Done += Amount
		src.Assisting(Target_, Amount)
		src.Last_Person_Who_Attacked = Target_
	if(Death) src.Death_Check(Target_)

mob/var/Last_Person_Who_Attacked

mob/proc/Auto_Dodge(mob/M, Projectile, var/R)
	if(Reviving || Attacking && !client) return
	var/Direction = M.dir

	if(R)
		if(R == EAST) Direction = WEST
		else Direction = EAST

	if(Dashing || KakashiChidori || Rasengan || Chidori || DinamicEntry || Iron)
		Dodging = 0
		return

	if(Special_Crow)
		Dodging = 0
		if(Direction == WEST) dir = EAST
		if(Direction == EAST) dir = WEST
		Itachi_Crow()
		var/H = new/obj/Hit(src.loc)
		H:pixel_x = src.pixel_x
		H:pixel_y = src.pixel_y
		return

	Dodging = 0
	if(Dodge_Text) del(Dodge_Text)
	flick("mob-jumping", src)
	src<<output("<b><font color=#6EDEFF><u>You have successfully dodged [M]!</u></font>", "Chat")

	if(Projectile)
		Dodge_Next = 1
		spawn(15) Dodge_Next = 0

	if(Direction == WEST)
		dir = EAST
		vel_y = 10
		if(client) vel_x = -20
		else vel_x = -15

	if(Direction == EAST)
		dir = WEST
		vel_y = 10
		if(client) vel_x = 20
		else vel_x = 15

mob/proc/Dodge_Show()
	..()
	var/T = 1
	if(Dodge_Text) del(Dodge_Text)
	if(client) {var/obj/O = image(null, src); Dodge_Text = O; O.pixel_y += 64; O.pixel_x -= 190; O.alpha = 150; O.maptext = "<b><font color=#DDE2A9><center>Dodging"; O.maptext_width = 500; O.maptext_height = 160; O.layer = 1000; src<<O}

	loop
		if(Dodge_Text)
			if(T == 1) {Dodge_Text.alpha += 15; if(Dodge_Text.alpha > 190) T = 0}
			else {Dodge_Text.alpha -= 15; if(Dodge_Text.alpha < 135) T = 1}
			if(!Dodging) if(Dodge_Text) del(Dodge_Text)
		if(Dodging) spawn(1.25) goto loop

mob/proc/Set_Dodge()
	if(!S_K_A) if(Wall_Freeze || freeze || Special_Crow) return
	if(Dodging) return
	if(!client || Substitution)
		Dodging = 1
		DodgeCD = 1
		spawn(45) DodgeCD = 0
		spawn(20) if(Dodging == 1 && !Special_Crow) {if(Dodge_Text) del(Dodge_Text); Dodging = 0}
	else
		if(Can_Dodge_ == 1)

			if(Energy <10)
				src<<output("<b><font color=red><u>You need more energy!</u></font>", "Chat")
				return
			if(E_Part == "Dodge") Complete_Genin_Part()
			Energy -= 10
			Dodging = 1
			DodgeCD = 1
			if(client) Dodge_Show()
			spawn(30) DodgeCD = 0
			spawn(20) if(Dodging == 1 && !Special_Crow) {if(Dodge_Text) del(Dodge_Text); Dodging = 0}

		else
			if(Reviving==1||DodgeCD==1||Boulder>=1||BoulderX>=1||Gates||Chidori||DinamicEntry||Iron||Rasengan||knockback==1||Controlling>=1||knocked==1)return

			if(Energy <10)
				src<<output("<b><font color=red><u>You need more energy!</u></font>", "Chat")
				return
			if(E_Part == "Dodge") Complete_Genin_Part()
			Energy -= 10
			Dodging = 1
			DodgeCD = 1
			if(client) Dodge_Show()
			spawn(30) DodgeCD = 0
			spawn(20) if(Dodging == 1 && !Special_Crow) {if(Dodge_Text) del(Dodge_Text); Dodging = 0}

proc
	Update_Ranking()
		var/list/Reputation = list()
		var/Rank
		var/list/A_ = list()
		var/list/V_ = list()

		for(var/Alliance/V in Alliances) if(V.Type == "Village")
			A_.Add(V)
			var/_Score_ = 0
			var/Players_In = 0
			for(var/Statistic/S in V.Members) if(S.Reputation >= 10 && S.Time_Played >= 43200)
				Players_In ++
				_Score_ += S.Reputation
			if(Players_In) _Score_ /= Players_In
			Reputation.Add(_Score_)
			V.Score = _Score_

		Villages
			Rank ++
			var/Rank_Text
			if(Rank == 1) {Rank_Text = "1st"} if(Rank == 2) {Rank_Text = "2nd"} if(Rank == 3) {Rank_Text = "3rd"} if(Rank == 4) {Rank_Text = "4th"} if(Rank == 5) {Rank_Text = "5th"} if(Rank == 6) {Rank_Text = "6th"} if(Rank == 7) {Rank_Text = "7th"} if(Rank == 8) {Rank_Text = "8th"} if(Rank == 9) {Rank_Text = "9th"} if(Rank == 10) {Rank_Text = "10th"} if(Rank == 11) {Rank_Text = "11st"} if(Rank == 12) {Rank_Text = "12nd"} if(Rank == 13) {Rank_Text = "13rd"} if(Rank == 15) {Rank_Text = "15th"} if(Rank == 16) {Rank_Text = "16th"} if(Rank == 17) {Rank_Text = "17th"} if(Rank == 18) {Rank_Text = "18th"} if(Rank == 19) {Rank_Text = "19th"} if(Rank == 20) {Rank_Text = "20th"}
			if(length(Reputation))
				var/Alliance/Next = max(Reputation)
				for(var/Alliance/V in A_) if(V.Score == Next) V.Rank = Rank_Text
				Reputation.Remove(Next)
				goto Villages

		Reputation = list()
		Rank = null

		for(var/Alliance/V in Alliances) if(V.Type == "Organization")
			V_.Add(V)
			var/_Score_ = 0
			var/Players_In = 0
			for(var/Statistic/S in V.Members) if(S.Reputation >= 10 && S.Time_Played >= 43200)
				Players_In ++
				_Score_ += S.Reputation
			if(Players_In) _Score_ /= Players_In
			Reputation.Add(_Score_)
			V.Score = _Score_

		Organizations
			Rank ++
			var/Rank_Text
			if(Rank == 1) {Rank_Text = "1st"} if(Rank == 2) {Rank_Text = "2nd"} if(Rank == 3) {Rank_Text = "3rd"} if(Rank == 4) {Rank_Text = "4th"} if(Rank == 5) {Rank_Text = "5th"} if(Rank == 6) {Rank_Text = "6th"} if(Rank == 7) {Rank_Text = "7th"} if(Rank == 8) {Rank_Text = "8th"} if(Rank == 9) {Rank_Text = "9th"} if(Rank == 10) {Rank_Text = "10th"} if(Rank == 11) {Rank_Text = "11st"} if(Rank == 12) {Rank_Text = "12nd"} if(Rank == 13) {Rank_Text = "13rd"} if(Rank == 15) {Rank_Text = "15th"} if(Rank == 16) {Rank_Text = "16th"} if(Rank == 17) {Rank_Text = "17th"} if(Rank == 18) {Rank_Text = "18th"} if(Rank == 19) {Rank_Text = "19th"} if(Rank == 20) {Rank_Text = "20th"}
			if(length(Reputation))
				var/Alliance/Next = max(Reputation)
				for(var/Alliance/V in V_) if(V.Score == Next) V.Rank = Rank_Text
				Reputation.Remove(Next)
				goto Organizations

world
	New()
		..()
		banlistload()
		Time()
		Characters_Load()
		Update_Ranking()
		spawn() Check_Log()

	Reboot()
		Rebooting = 1
		for(var/mob/M)
			if(M.dead == 0 && M.name != M.key && M.client)
				M.Update_Scores()
				if(M.Mission_On) M.Missions_Cooldowns.Remove(M.Mission_On.Name)
		banlistsave()
		Characters_Save()
		..()

	Del()
		if(!Rebooting)
			Rebooting = 1
			for(var/mob/M)
				if(M.dead == 0 && M.name != M.key && M.client)
					M.Update_Scores()
					if(M.Mission_On) M.Missions_Cooldowns.Remove(M.Mission_On.Name)
			banlistsave()
			Characters_Save()
		..()

var/Rebooting
mob/var/HbR = 0
var/Special = 0
var/Auto_Balancer = 1
var/NextSpawn = 1
mob/var/obj/Effects/Domed_Wall/On_Wood_Wall
mob/var/obj/Effects/Domed_Wall/W_Protecting
var/SpecialX = 0
mob/var/freeze = 0
mob/var/No_HP_Regen
#define STEPPED_ON