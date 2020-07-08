var/Next_Mode
mob/var/Kills = 0
mob/var/TsunamiCD = 0
mob/var/RealDeaths = 0
mob/var/obj/Edo
mob/var/FirePunchCD = 0
mob/var/DRasenganCD = 0
mob/var/Remembered_Spot
mob/var/Flamed
mob/var/Remembered_Location
mob/var/Executing_Special_Jutsu = 0
mob/var/list/RT = list()
var/IllegalMelody = 0
var/Doton = 0
var/Water = 0
var/Kunai = 0
mob/var/tmp/UsingKirin = 0
mob/var/Owner
mob/var/mob/_Owner_
mob/var/Revived_T = 0
mob/var/DCD = 0
mob/var/OldX
mob/var/OldY
mob/var/Iron=0
mob/var/Activated=0
mob/var/Poison=0
mob/var/Amaterasu=0
mob/var/CanUseAmaterasu=0
mob/var/CanUseSusanoo=0
mob/var/CanUseTsu=0
mob/var/OldLoc=0
mob/var/Crow=0

mob/proc/Flamed()
	Flamed = 1
	spawn(2.5) Flamed = 0

var
	Pein = 'Shinra N.png'
	Pein_ = 'Shinra N2.png'
	Pein__ = 'Shinra N3.png'

obj
	Bounds_Ranged

		var/mob/Creator

		New(loc, mob/Creator_, var/Width, var/Height)
			..()
			Creator = Creator_
			dir = Creator.dir
			bound_width = Width
			bound_height = Height
			if(dir == EAST) bound_x =  32
			else if(dir == WEST) bound_x =  -Width
			spawn(100) del(src)

		proc/Enemy()
			var/list/Enemies = list()
			for(var/mob/M in bounds(src, 0))
				if(M.knocked || M.Real_C == 0 || M == Creator || !M.Real || M.Village == Creator.Village || M.Dragonned) continue
				if(dir == EAST && M.px > px) Enemies.Add(M)
				if(dir == WEST && M.px < px) Enemies.Add(M)

			return Enemies

	Bounds

		var/mob/Creator

		New(loc, mob/Creator_, var/Width, var/Height)
			..()
			Creator = Creator_
			dir = Creator.dir
			bound_width = Width
			bound_height = Height
			if(dir == EAST) bound_x =  32
			else if(dir == WEST) bound_x =  -Width
			spawn(30) del(src)

		proc/Enemy()
			var/list/Enemies = list()
			for(var/mob/M in bounds(src, 0))
				if(!M.ByPass)
					if(dir == EAST && M.px > px) Enemies.Add(M)
					if(dir == WEST && M.px < px) Enemies.Add(M)
					continue

				if(M.knocked || M.Real_C == 0 || M == Creator || !M.Real || M.Village == Creator.Village || M.Dragonned) continue
				if(dir == EAST && M.px > px) Enemies.Add(M)
				if(dir == WEST && M.px < px) Enemies.Add(M)

			var/PX
			if(dir == EAST) PX = 1000000
			if(dir == WEST) PX = -1000000

			for(var/mob/M in Enemies)
				if(dir == EAST)
					if(M.px > PX) Enemies.Remove(M)
					else
						PX = M.px
						for(var/mob/L in Enemies) if(L.px >= PX && L != M) Enemies.Remove(L)
				if(dir == WEST)
					if(M.px < PX) Enemies.Remove(M)
					else
						PX = M.px
						for(var/mob/L in Enemies) if(L.px <= PX && L != M) Enemies.Remove(L)

			for(var/mob/M in Enemies) if(!M.ByPass) return null
			return Enemies

		proc/Projectile()
			var/list/Enemies = list()
			for(var/mob/M in bounds(src, 0))
				if(M.client || M == Creator) continue
				else if(istype(M, /mob/Ultimate_Projectile)) if(M:Allies == Creator.Village) continue
				else if(M.Village == Creator.Village) continue
				if(dir == EAST && M.px > px) Enemies.Add(M)
				if(dir == WEST && M.px < px) Enemies.Add(M)

			var/PX
			if(dir == EAST) PX = 1000000
			if(dir == WEST) PX = -1000000

			for(var/mob/M in Enemies)
				if(dir == EAST)
					if(M.px > PX) Enemies.Remove(M)
					else
						PX = M.px
						for(var/mob/L in Enemies) if(L.px >= PX && L != M) Enemies.Remove(L)
				if(dir == WEST)
					if(M.px < PX) Enemies.Remove(M)
					else
						PX = M.px
						for(var/mob/L in Enemies) if(L.px <= PX && L != M) Enemies.Remove(L)

			return Enemies




	Bounds_Turf

		New(loc, mob/Creator, var/Width, var/Height, Direction)
			dir = Direction
			bound_width = Creator.pwidth
			bound_height = Creator.pheight
			px = Creator.px
			py = Creator.py
			bound_x = Creator.step_x
			if(dir == EAST) {bound_x += Height; px += Height}
			else {bound_x -= Height; px -= Height}
			spawn(30) del(src)

		proc/Turfs()
			var/list/Turfs = list()
			for(var/turf/M in obounds(src))
				if(dir == EAST && !istype(M, /turf/Special_Floor) && M.density) Turfs.Add(M)
				if(dir == WEST && !istype(M, /turf/Special_Floor) && M.density) Turfs.Add(M)
			return Turfs

mob/proc

	Teleport_Behind_NSS(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 32, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 32, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			new/obj/Effects/Smoke (loc, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)

	Teleport_Behind_Gari(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 84, dir)
		var/list/Turfs = Bounds.Turfs()
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 84, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			if(Enemy.px <= px) {Enemy.dir = WEST; dir = EAST}
			else {Enemy.dir = EAST; dir = WEST}
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		if(Enemy.px <= px) {Enemy.dir = WEST; dir = EAST}
		else {Enemy.dir = EAST; dir = WEST}

	Teleport_Behind(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 32, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 32, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			new/obj/Effects/Smoke (loc, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)
		new/obj/Effects/Smoke (loc, src)

	Teleport_Behind_KC(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 52, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 52, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			new/obj/Effects/Smoke (loc, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)
		new/obj/Effects/Smoke (loc, src)

	Teleport_Behind_Suigetsu(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds
		if(dir == WEST) Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 94, dir)
		else Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 46, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST)
				Direction = WEST
				var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 94, Direction)
				layer = 101
				set_pos(Bound.px, Bound.py)
				Face_Me(Enemy, src)
				new/obj/Effects/Smoke (loc, src)
				return
			else
				var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 46, Direction)
				layer = 101
				set_pos(Bound.px, Bound.py)
				Face_Me(Enemy, src)
				new/obj/Effects/Smoke (loc, src)
				return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)
		new/obj/Effects/Smoke (loc, src)

	Teleport_Behind_RL(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds
		if(dir == WEST) Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 94, dir)
		else Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 94, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST)
				Direction = WEST
				var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 94, Direction)
				layer = 101
				set_pos(Bound.px, Bound.py)
				Face_Me(Enemy, src)
				return
			else
				var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 94, Direction)
				layer = 101
				set_pos(Bound.px, Bound.py)
				Face_Me(Enemy, src)
				return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)

	Teleport_Behind_RL_(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds
		if(dir == WEST) Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 28, dir)
		else Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 28, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST)
				Direction = WEST
				var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 28, Direction)
				layer = 101
				set_pos(Bound.px, Bound.py)
				Face_Me(Enemy, src)
				return
			else
				var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 28, Direction)
				layer = 101
				set_pos(Bound.px, Bound.py)
				Face_Me(Enemy, src)
				return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)

	Teleport_Behind_Close(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 24, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 24, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			new/obj/Effects/Smoke (loc, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)
		new/obj/Effects/Smoke (loc, src)

	Teleport_Behind_Close_Y(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 28, dir)
		var/list/Turfs = Bounds.Turfs()
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 28, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)

	Teleport_Behind_Close_(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 16, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 16, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			new/obj/Effects/Smoke (loc, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)
		new/obj/Effects/Smoke (loc, src)

	Teleport_Behind_NS(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 32, dir)
		var/list/Turfs = Bounds.Turfs()
		if(name != "Konan") Flick("teleport", src)
		else Flick("Appear", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 32, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)

	Teleport_Behind_(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 64, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 64, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			new/obj/Effects/Smoke (loc, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)
		new/obj/Effects/Smoke (loc, src)

	Teleport_Behind__(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 160, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 160, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			new/obj/Effects/Smoke (loc, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)
		new/obj/Effects/Smoke (loc, src)

	Teleport_Behind_C(mob/Enemy, src)
		var/obj/Bounds_Turf/Bounds = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 130, dir)
		var/list/Turfs = Bounds.Turfs()
		Flick("teleport", src)
		Enemy.stop()
		for(var/turf/T in Turfs)
			var/Direction = EAST
			if(dir == EAST) Direction = WEST
			var/obj/Bounds_Turf/Bound = new/obj/Bounds_Turf (Enemy.loc, Enemy, 2, 130, Direction)
			layer = 101
			set_pos(Bound.px, Bound.py)
			Face_Me(Enemy, src)
			new/obj/Effects/Smoke (loc, src)
			return
		layer = 101
		set_pos(Bounds.px, Bounds.py)
		Face_Me(Enemy, src)
		new/obj/Effects/Smoke (loc, src)

	Face_Me(mob/Enemy, mob/Aggresor)
		if(Enemy.px < Aggresor.px)
			Enemy.dir = EAST
			Aggresor.dir = WEST
		if(Enemy.px > Aggresor.px)
			Enemy.dir = WEST
			Aggresor.dir = EAST



obj

	SakuraCherry
	//	icon = 'Naruto.dmi'
	//	icon_state = "mob-standing"
		bound_width=50 //This line and the next sets the bounded box for mobcheck.
		bound_height=35 //The bounded box determines what part of the atom is dense.
	SakuraCherryXX
	//	icon = 'Naruto.dmi'
	//	icon_state = "mob-standing"
		bound_width=350 //This line and the next sets the bounded box for mobcheck.
		bound_height=35 //The bounded box determines what part of the atom is dense.
	GroundSmash
		icon = 'Graphics/Skills/biggroundsmash.dmi'
		layer = 55
		pixel_x= -50
		pixel_y= -4
		New()
			..()
			Flick("Explosion",src)
			spawn(100)del(src)
	GroundSmashX
		icon = 'Graphics/Skills/biggroundsmash.dmi'
		layer = 55
		pixel_y= -4
		pixel_x= -50
		icon_state = "Explosion"
		New()
			..()
			Flick("Explosion",src)
			spawn(450)del(src)
	Shinra
		icon = 'Graphics/Skills/Sinra.dmi'
		layer = 1000
		New()
			..()
			Flick("Explode",src)
			spawn(7.8)del(src)
	Smoke
		icon = 'Graphics/Skills/Substitution.dmi'
		layer = 55
		New()
			..()
			Flick("Smoke",src)
			spawn(100) del(src)
	Rain_Bomb
		icon = 'Graphics/Skills/WaterFall.dmi'
		layer = 55
		pixel_x= -50
		New()
			..()
			Flick("1",src)
			spawn(5)del(src)
	Wood_Lock
		icon = 'Graphics/Skills/woodlock.dmi'
		layer = 150
		New()
			..()
			Flick("1",src)
			spawn(25) del(src)
	Water_Effect
		icon = 'Graphics/Skills/Water.dmi'
		layer = 125
		alpha = 150
		pixel_x = 125
		pixel_y = -10
		New(loc, mob/Owner, _dir, Amount, obj/_Special, list/Attacked)
			..()
			dir = _dir
			if(!Attacked) Attacked = list()
			step_x = Owner.step_x

			if(Amount != 50)
				pixel_x = _Special.pixel_x
				x = _Special.x
				if(dir == EAST)	x += 4
				else x -= 4
			else
				if(dir == WEST) pixel_x -= 295
				else pixel_x -= 100

			spawn(0.5)
				bound_width = 200
				bound_height = 90
				bound_x = pixel_x
				for(var/mob/M in obounds(src))
					if(M.Real == 1 && M.Gates == 0 && M.Boulder == 0 && M.knocked == 0 && M.Dragonned == 0 && M.Real == 1 && M.Village != Owner.Village)
						if(Attacked.Find(M)) continue
						Attacked.Add(M)
						var/Damage = 35+rand(0,5)
						if(dir == EAST) M.Damage(Owner, Damage, 1, "East")
						else M.Damage(Owner, Damage, 1, "West")
			Flick("Go", src)
			spawn(3)
				Amount --
				for(var/turf/T in obounds(src)) if(T.density) Amount = 0
				if(Amount > 0) new/obj/Water_Effect (loc, Owner, dir, Amount, src, Attacked)
			spawn(10) del(src)
	Doton_Effect
		icon = 'Graphics/Skills/Doton.dmi'
		layer = 125
		alpha = 150
		pixel_x = 125
		New(loc, mob/Owner, _dir, Amount, obj/_Special, list/Attacked)
			..()
			dir = _dir
			if(!Attacked) Attacked = list()
			step_x = Owner.step_x

			if(Amount != 50)
				pixel_x = _Special.pixel_x
				x = _Special.x
				if(dir == EAST)	x += 3
				else x -= 3
			else
				if(dir == WEST) pixel_x -= 335
				else pixel_x -= 64

			spawn(0.5)
				bound_width = 240
				bound_height = 85
				bound_x = pixel_x
				for(var/mob/M in obounds(src))
					if(M.Real == 1 && M.Gates == 0 && M.Boulder == 0 && M.knocked == 0 && M.Dragonned == 0 && M.Real == 1 && M.Village != Owner.Village)
						if(Attacked.Find(M)) continue
						Attacked.Add(M)
						var/Damage = 35+rand(0,5)
						if(dir == EAST) M.Damage(Owner, Damage, 1, "East")
						else M.Damage(Owner, Damage, 1, "West")
			if(Amount == 50) Flick("First", src)
			else Flick("Second" ,src)
			spawn(1.5)
				Amount --
				for(var/turf/T in obounds(src)) if(T.density) Amount = 0
				if(Amount > 0) new/obj/Doton_Effect (loc, Owner, dir, Amount, src, Attacked)
			spawn(3) del(src)
	DotonEASTXX
		icon = 'Graphics/Skills/Doton.dmi'
		dir = EAST
		layer = 105
		New()
			..()
			Flick("Boom2",src)
			spawn(10)del(src)
	DotonEASTXXX
		icon = 'Graphics/Skills/DotonX.dmi'
		dir = EAST
		layer = 105
		New()
			..()
			Flick("Boom2",src)
			spawn(10)del(src)
	DotonWESTXXX
		icon = 'Graphics/Skills/DotonX.dmi'
		dir = WEST
		layer = 105
		var/T = 0
		New()
			..()
			Flick("Boom2",src)
			spawn(10)del(src)
	DotonWESTXX
		icon = 'Graphics/Skills/Doton.dmi'
		dir = WEST
		layer = 105
		var/T = 0
		New()
			..()
			Flick("Boom2",src)
			spawn(10)del(src)
	Sharingan
		icon = 'Graphics/Skills/Doujutsus.dmi'
		layer = 130
		pixel_y = 32
		alpha = 175
		icon_state = "sharingan"

	Mangekyou_Sharingan
		icon = 'Graphics/Skills/Doujutsus.dmi'
		layer = 130
		pixel_y = 32
		alpha = 175
		icon_state = "Mangekyou"

	Mangekyou_Sharingan_K
		icon = 'Graphics/Skills/Doujutsus.dmi'
		layer = 130
		pixel_y = 32
		alpha = 175
		icon_state = "MangekyouK"

	ShisuiMS
		icon = 'Graphics/Skills/Doujutsus.dmi'
		layer = 130
		pixel_y = 32
		alpha = 175
		icon_state = "Shisui"


	Byakugan
		icon = 'Graphics/Skills/Doujutsus.dmi'
		layer = 130
		pixel_y = 32
		alpha = 175
		icon_state = "byakugan"

	Rinnegan
		icon = 'Graphics/Skills/Doujutsus.dmi'
		layer = 130
		pixel_y = 52
		alpha = 175
		icon_state = "Rinnegan"

	Gentle_Fist
		icon = 'Graphics/Skills/Gentle Fist.dmi'
		layer = 130
		pixel_y = -1

	Amat_Sword
		icon = 'Graphics/Skills/Amaterasu.dmi'
		layer = 130
		pixel_y = -1

	MoltenHand
		icon = 'Graphics/Skills/Great_Slash.dmi'
		layer = 100
		New()
			..()
			spawn(7)del(src)

	L_Mind_Control
		icon = 'Mind Transfer L.dmi'
		layer = 155
		pixel_y = 25

	NL_Mind_Control
		icon = 'Mind Transfer NL.dmi'
		layer = 155
		pixel_y = 25

	Red
		icon = 'Graphics/Red.dmi'
		layer = 100
		pixel_y = 26

	Blue
		icon = 'Graphics/Blue.dmi'
		layer = 100
		pixel_y = 26

	Anbu_1
		icon = 'Graphics/Skills/ANBU 1.dmi'
		layer = 150
		New()
			..()
			Flick("Go",src)
			spawn(12.25) del(src)

	Anbu_2
		icon = 'Graphics/Skills/ANBU 3.dmi'
		layer = 150
		New()
			..()
			Flick("Go",src)
			spawn(12.25) del(src)

	Anbu_3
		icon = 'Graphics/Skills/ANBU 2.dmi'
		layer = 150
		New()
			..()
			Flick("Go",src)
			spawn(11) del(src)

	Anbu_4
		icon = 'Graphics/Skills/ANBU 4.dmi'
		layer = 150
		New()
			..()
			Flick("Go",src)
			spawn(12.25) del(src)

	Anbu_5
		icon = 'Graphics/Skills/ANBU 5.dmi'
		layer = 150
		New()
			..()
			Flick("Go",src)
			spawn(10) del(src)

	Path_1
		icon = 'Graphics/Characters/Pein.dmi'
		layer = 101
		New()
			..()
			Flick("Path1",src)
			spawn(8)del(src)

	Chibaku_Pein
		icon = 'Graphics/Skills/Pein Chibaku.dmi'
		layer = 150
		New()
			..()
			Flick("Go", src)
			spawn(15) del(src)

	Shinra_Pein
		icon = 'Graphics/Skills/Pein Shinra.dmi'
		layer = 150
		New()
			..()
			Flick("Go", src)
			spawn(70) del(src)


	Preta
		icon = 'Graphics/Skills/Ningendo.dmi'
		layer = 150
		New()
			..()
			Flick("Go", src)
			spawn(90) del(src)


	Absorb_Soul
		icon = 'Graphics/Skills/Pein Absorb Soul.dmi'
		layer = 1000000000000000000000000000
		New()
			..()
			Flick("Go", src)
			spawn(15) del(src)



	Chibaku
		icon = 'Graphics/Skills/Pein Chibaku 2.dmi'
		layer = 50
		New()
			..()
			Flick("Go", src)
			spawn(17) del(src)

	Portal
		icon = 'Graphics/Characters/RT.dmi'
		layer = 1000
		icon_state = "null"
		New()
			..()
			Flick("Appear",src)
			spawn(7) del(src)

	Release
		icon = 'Graphics/Skills/Release.dmi'
		layer = 150
		New()
			Flick("Go", src)
			spawn(7.5) del(src)
			..()

	Hand
		icon = 'Graphics/Skills/Hand.dmi'
		layer = 115
		New()
			..()
			Flick("Go",src)
			spawn(100)
				if(src) del(src)

	Ice_Spike
		icon = 'Graphics/Skills/Ice Spike Explossive.dmi'
		layer = 115
		New()
			..()
			Flick("Go",src)
			spawn(8) if(src) del(src)


	Mirrors
		icon = 'Graphics/Characters/HakuAttack3.dmi'
		layer = 90
		New()
			..()
			Flick("Go", src)
			spawn(600) if(src) del(src)
	Haku_Attack
		icon = 'Graphics/Characters/HakuAttack2.dmi'
		layer = 110
		New()
			..()
			Flick("Go", src)
			spawn(250) if(src) del(src)


	Rock_Log
		icon = 'Graphics/Skills/EarthFall.dmi'
		icon_state = "null"
		layer = 300
		New()
			..()
			Flick("Go", src)
			spawn(250) if(src) del(src)
	Trunk
		icon = 'Graphics/Skills/Mokuton3.dmi'
		layer = 110
		New()
			..()
			Flick("Go",src)
			spawn(15) del(src)
	Dead_Soul
		icon = 'Graphics/Skills/DeadSoul.dmi'
		layer = 110
		New()
			..()
			Flick("Go",src)
			spawn(15) del(src)
	Flaming_Dragon
		icon = 'Graphics/Skills/Flaming Dragon.dmi'
		layer = 200
		layer=200
		var/T = 0
		var/Village
		var/Owner
		New()
			..()
			icon_state = "Go"
			loop
				if(T!=6)
					T++
					for(var/mob/M in view(src, 3))
						if(M.Village!=src.Village&&M.name != "Obito" && M.knocked==0&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0)
							var/Damage = 7.5+rand(0, 4.5)
							M.Damage(Owner, Damage, 1, 0)
							M.Attacked(15)
					spawn(2.5) goto loop
				else
					del(src)
		Del()
			Flick("End", src)
			spawn(3)
				..()
	RasenshurikenX
		icon = 'Graphics/Skills/RasenshurikenX.dmi'
		icon_state = ""
		layer = 300
		bound_width = 325
		bound_height = 120
		layer = 200
		var/T = 0
		var/Village
		var/Owner
		New(loc, mob/_Owner, Direction)
			..()
			dir = Direction
			Owner = _Owner
			Village = _Owner.Village
			var/icon/I = new(src.icon)
			I.Scale(300, 120)
			src.icon = I
			src.pixel_x -= 80

			loop
				spawn(30) del(src)
				if(T!=6)
					T++
					for(var/mob/M in bounds(src, 0))
						if(M.Village != Village && M.Real == 1 && M.knocked == 0 && M.Dragonned == 0 && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0)
							var/Damage = 5+rand(5,15)
							M.Damage(Owner, Damage, 1, 0)
							M.Attacked(15)
					spawn(5) goto loop
				else
					del(src)
		Del()
			spawn(10) ..()
			for(var/mob/M)
				if(M.Rasenshuriken_Effect == 1)
					M.freeze --
					M.Rasenshuriken_Effect = 0
	Rasenshuriken
		icon = 'Graphics/Skills/Rasenshuriken.dmi'
		icon_state = ""
		layer = 300
		bound_width=400 //This line and the next sets the bounded box for mobcheck.
		bound_height=120
		layer = 200
		var/T = 0
		var/Village
		var/Owner
		New(loc, mob/_Owner)
			..()
			Owner = _Owner
			Village = _Owner.Village
			var/icon/I= new(src.icon)
			I.Scale(400,120)
			src.icon = I
			src.pixel_x -= 140

			loop
				spawn(30) del(src)
				if(T!=6)
					T++
					for(var/mob/M in bounds(src, 0))
						if(M.Village != Village && M.Real == 1 && M.knocked == 0 && M.Dragonned == 0 && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0)
							var/Damage = 5+rand(5,15)
							M.Damage(Owner, Damage, 1, 0)
							M.Attacked(15)
					spawn(5) goto loop
				else
					del(src)
		Del()
			spawn(10) ..()
			for(var/mob/M)
				if(M.Rasenshuriken_Effect == 1)
					M.freeze --
					M.Rasenshuriken_Effect = 0
			Flick("End",src)

	Kyuubi_Hand
		icon = 'Graphics/Skills/Kyuubi_Hand.dmi'
		layer = 105
		New()
			..()
			src.pixel_x += 55
			Flick("End",src)
			spawn(15)del(src)

	Raikage
		icon = 'Graphics/Characters/Killer Bee.dmi'
		layer = 105
		New()
			..()
			Flick("Raikage",src)
			spawn(15) del(src)
	Revolt_Demon
		icon = 'Graphics/Skills/Revolt Demon.dmi'
		layer = 105
		New()
			..()
			Flick("Go",src)
			spawn(15) del(src)
	Spike
		icon = 'Graphics/Skills/Spike.dmi'
		pixel_y = -6
		New(mob/M)
			..()
			layer = (M.layer) +10
			loc = M.loc
			step_x = M.step_x
			if(M.dir == EAST) pixel_x -= 16
			if(M.dir == WEST) pixel_x += 8
			Flick("Go", src)
			spawn(5) del(src)
	Trap
		icon = 'Graphics/Trap.dmi'
		layer = 105
		New()
			..()
			Flick("1",src)
	Water_Prison
		icon = 'Graphics/Skills/Water Prison.dmi'
		layer = 200
		New()
			..()
			Flick("Start",src)
			spawn(29.5) del(src)
		Del()
			icon_state = "null"
			Flick("End", src)
			spawn(7) ..()


	Rock_Splash
		icon = 'Graphics/Skills/EarthSplash.dmi'
		layer = 200
		bound_width=115
		bound_height=80
		var/Village
		New()
			Flick("Go",src)
			spawn()for(var/mob/M in bounds(src,0))
				if(M.Village!=Village&&M.name != "Tsuchikage"&&M.Real==1&&M.knocked==0&&M.Dragonned==0&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0)
					M.HP -= 23
					new/obj/Hit (M.loc)
					M.Death_Check("Tsuchikage")
			spawn(15)del(src)


	Water_Splash
		icon = 'Graphics/Skills/Water Explosion.dmi'
		layer = 200
		bound_width=115
		bound_height=80
		var/Village
		New()
			Flick("Go",src)
			spawn()for(var/mob/M in bounds(src,0))
				if(M.Village!=Village&&M.name != "Zabuza"&&M.Real==1&&M.knocked==0&&M.Dragonned==0&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0)
					M.HP -= 23
					new/obj/Hit (M.loc)
					M.Death_Check("Zabuza")
			spawn(15) del(src)


	Crystal_Splash
		icon = 'Graphics/Skills/Crystal Explosion.dmi'
		layer = 200
		bound_width=100
		bound_height=80
		var/Village
		New()
			Flick("Go",src)
			spawn()for(var/mob/M in bounds(src,0))
				if(M.Village!=Village&&M.name != "Guren"&&M.Real==1&&M.knocked==0&&M.Dragonned==0&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0)
					M.HP -= 23
					new/obj/Hit (M.loc)
					M.Death_Check("Guren")
			spawn(15)del(src)


	Wind_Splash
		icon = 'Graphics/Skills/Wind 3.dmi'
		layer = 200
		bound_width=100
		bound_height=80
		var/Village
		New()
			Flick("Go",src)
			spawn()for(var/mob/M in bounds(src,0))
				if(M.Village!=Village&&M.name != "Zaku"&&M.Real==1&&M.knocked==0&&M.Dragonned==0&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0)
					M.HP -= 23
					new/obj/Hit (M.loc)
					M.Death_Check("Zaku")
			spawn(15)del(src)


	Special_Spike
		icon = 'Graphics/Skills/Needles.dmi'
		layer = 200
		pixel_y = -4
		var/Village
		var/mob/Creator_
		New(loc, Owner)
			..()
			Creator_ = Owner
			bound_width=65
			bound_height=35
			Flick("Go", src)
			spawn() for(var/mob/M in bounds(src,0))
				if(M.Village!=Village&&M.name != "Juugo"&&M.Real==1&&M.knocked==0&&M.Dragonned==0&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0)
					M.HP -= 25
					new/obj/Hit (M.loc)
					M.Death_Check(Creator_)
			spawn(15)del(src)
	Monkey
		icon = 'Graphics/Characters/3rdHokage.dmi'
		icon_state = "Enma"
		layer = 150
		New()
			..()
			Flick("Enma",src)
			spawn(20)del(src)

	Itachi_Amaterasu
		icon = 'Graphics/Skills/Itachi Amaterasu X.dmi'
		alpha = 175
		layer = 155
		var/Village

		New(loc, mob/Enemy, mob/Creator)
			..()
			Village = Creator.Village
			step_x = Enemy.step_x
			step_y = Enemy.step_y
			dir = Enemy.dir
			px = Enemy.px
			py = Enemy.py
			pixel_x = -65
			pixel_y = -35
			bound_x = -54
			bound_y = -6
			bound_width = 202
			bound_height = 170
			spawn()
				Flick("Go", src)
				spawn(150) del(src)
				loop
					for(var/mob/M in obounds(src, 0))
						if(M.Village != Village && M.knocked == 0 && M.Real == 1 && M.Dragonned == 0 && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0)
							M.Damage(Creator, 4, 1, 0)
							if(!M.Amaterasu) M.Amaterasu_XX()
					spawn(4) goto loop

		Del()
			flick("End", src)
			spawn(3) ..()
	Poison_Smoke_
		icon = 'Graphics/Skills/Acid.dmi'
		layer = 150
		New()
			..()
			Flick("Go",src)
			spawn(5)del(src)
	Lava_Punch
		icon = 'Graphics/Skills/Lava Punch.dmi'
		layer = 150
		New()
			..()
			Flick("Go",src)
			spawn(15) del(src)
	Sharks_
		icon = 'Graphics/Skills/SharkEat.dmi'
		icon_state = "Enma"
		layer = 150
		New()
			..()
			Flick("Go",src)
			spawn(19)del(src)
	RedSecret
		icon = 'Graphics/Skills/PuppetAttack.dmi'
		layer = 105
		New()
			..()
			Flick("Go",src)
			spawn(20)del(src)
	Fire_Coffin
		icon = 'Graphics/Skills/FireCoffin.dmi'
		layer = 1000
		alpha = 200
		New()
			..()
			Flick("1",src)
			spawn(35)del(src)

	Itachi_Illusion
		icon = 'Graphics/Itachi Illusion.dmi'
		layer = 150

	Itachi_AOE_Illusion_X
		icon = 'Graphics/Skills/Itachi Genjutsu I.dmi'
		layer = 150

	Itachi_AOE_Illusion
		icon = 'Graphics/Skills/Itachi Genjutsu.dmi'
		layer = 150

	Itachi_Crow
		icon = 'Graphics/Skills/Itachi Genjutsu Crows I.dmi'
		layer = 150

	Path_2
		icon = 'Graphics/Characters/Pein.dmi'
		layer = 105
		New()
			..()
			Flick("Path2",src)
			spawn(8)del(src)
	Rock
		icon = 'Graphics/Skills/RockThrow.dmi'
		layer = 150
		New()
			..()
			spawn(12)del(src)
	Paper
		icon = 'Graphics/Skills/Paper.dmi'
		layer = 300
		New()
			Flick("Go", src)
			spawn(24) del(src)
	Path_4
		icon = 'Graphics/Characters/Pein.dmi'
		layer = 105
		New()
			..()
			Flick("Path4",src)
			spawn(17)del(src)
	Path_5
		icon = 'Graphics/Characters/Pein.dmi'
		layer = 105
		New()
			..()
			Flick("Path5",src)
			spawn(10)del(src)
	Susanoo_Arm
		icon = 'Graphics/Skills/Sussanoo Arm.dmi'
		layer = 110
		alpha = 150

		New()
			..()
			Flick("Go",src)
			spawn(25) del(src)

		Del()
			Flick("End", src)
			spawn(4) ..()

	Dropped_Kunai
		icon = 'Graphics/Skills/DroppedKunai.dmi'
		layer = 100
		New()
			..()
			Flick("Fall",src)

	Dropped_Kunai2
		icon = 'Graphics/Skills/DroppedKunai2.dmi'
		layer = 500
		pixel_x = 32
		var/Owner
		New()
			..()
			Flick("Explode!",src)
		Del()
			var/A=new/obj/Explosion (src.loc)
			A:pixel_x=src.pixel_x
			A:pixel_y=src.pixel_y
			for(var/mob/M in src.loc)
				if(M.Real==1&&M.knocked==0&&M.Dragonned==0)
					var/Damage = rand(1,5)
					M.Damage(Owner, Damage, 1, 0)
			..()
	Warrior
		icon = 'Graphics/Skills/Warriors.dmi'
		layer = 105
		var/R
		New()
			..()
			R=rand(1,3)
			Flick("[R]",src)
			spawn(10)del(src)
	Poison_Smoke
		icon = 'Graphics/Skills/PoisonSmoke.dmi'
		layer = 55
	//	pixel_x= -50
		var/T = 0
		var/Village
		New()
			..()
			flick("Go", src)
			spawn()
				for(var/mob/M in view(2))
					if(M.Village!=Village)
						if(M.dead==0&&M.knocked==0&&M.Dragonned==0&&AllowedPoison==1&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0&&M.Real==1&&M.Poison_Immunity==0)
							M.Poison_Proc(15, "Karin")
			spawn(8) del(src)
	Sand_Spike
		icon = 'Graphics/Skills/SandSpikes.dmi'
		layer=75
		New()
			..()
			spawn(15)del(src)
	Hell
		layer = 500
		icon = 'Graphics/Hell.dmi'
	X_Akatsuki_Second_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	Leaf_Fourth_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	Leaf_Fifth_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100

	X_Akatsuki_First_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	X_Akatsuki_Second_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	X_Akatsuki_Third_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	X_Akatsuki_Fourth_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	X_Akatsuki_Fifth_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	Akatsuki_Third_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	Akatsuki_Fourth_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	Akatsuki_Fifth_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100

	X_Akatsuki_First_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100

	X_Akatsuki_Second_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100

	X_Leaf_First_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100

	X_Leaf_Second_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100

	X_Leaf_Third_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100

	X_Leaf_Fourth_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100

	X_Leaf_Fifth_Spawn
		icon = 'Graphics/Wall.dmi'
		invisibility = 100
	TourneySpawn
	RightSide
	WestSide
	Huge_Fire
		icon = 'Graphics/Skills/Huge_Fire.dmi'
		layer = 155
		alpha = 155
		pixel_x= -50
		var/T=0
		var/Village
		var/Owner
		New()
			..()
			spawn()
				var/N= new/obj/Huge_Fire2(src.loc)
				N:Village = Village
				N:Owner = Owner
				loop
					if(T!=15)
						T++
						for(var/mob/M in src.loc)
							if(M.Village!=Village&&M.name != "Pein"&&M.knocked==0&&M.Real==1&&M.Dragonned==0&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0)
								var/Damage = 5
								M.Damage(Owner, Damage, 1, 0)
								M.Attacked(15)
						spawn(10)goto loop
					else
						del(src)
	Amaterasu_Wildfire
		icon = 'Graphics/Skills/Itachi Amaterasu.dmi'
		layer = 155
		pixel_x = -4
		pixel_y = -8
		alpha = 150
		var/Village
		var/Owner
		Del()
			flick("End", src)
			spawn(4) ..()
		New()
			..()
			bound_width = 114
			bound_height = 120
			flick("Start", src)
			spawn(125) del(src)
			spawn()
				loop
					var/_Target_
					for(var/mob/M in obounds(src, 0))
						if(!M.Flamed && M.Village != Village && M.knocked == 0 && M.Real == 1 && M.Dragonned == 0 && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0)
							_Target_ ++
							M.Damage(Owner, 5+rand(0,3), 1, 0, 0, 0, 0, 1)
							M.Attacked(5)
							M.Flamed()
					if(_Target_) Owner:Damage_Up(5+rand(0, 3))
					spawn(4) goto loop
	Huge_Fire2
		icon = 'Graphics/Skills/Huge_Fire.dmi'
		layer = 60
		var/T=0
		var/Village
		var/Owner
		New()
			..()
			spawn()
				src.x-=2
				loop
					if(T!=25)
						T++
						for(var/mob/M in src.loc)
							if(M.Village!=Village&&M.name != "Pein"&&M.knocked==0&&M.Real==1&&M.Dragonned==0&&M.Gates==0&&M.Boulder==0&&M.BoulderX==0)
								var/Damage = 5
								M.Damage(Owner, Damage, 1, 0)
								M.Attacked(10)
						spawn(5)goto loop
					else
						del(src)
	Kirin
		icon = 'Graphics/Skills/kirin.dmi'
		layer = 115
		pixel_x = -50
		New()
			..()
			spawn(150)del(src)
	Supreme_Kirin
		icon = 'Graphics/Skills/Kirin Supreme.dmi'
		layer = 115
		pixel_x = -120
		pixel_y = -30
		New()
			..()
			Flick("Go", src)
			spawn(5.5) del(src)
mob/var/Rasengan=0
mob/var/DinamicEntry=0
mob/var/KakashiChidori=0
mob/var/Chidori=0
mob/var/ChakraBlade=0
mob/var/ChakraBladeCD=0
mob/var/RasenganCD=0
mob/var/ClayBirdCD=0
mob/var/Boulder=0
mob/var/BoulderX=0
mob/var/BoulderCD=0
mob/var/ExpandCD=0
mob/var/PeinCD=0
mob/var/RasenshurikenCD=0
mob/var/ChidoriCD=0
mob/var/InkCD=0
mob/var/CO
mob/var/COM
mob/proc
	Minato_Teleport(var/Enemy, var/Projectile)
		Projectile:Can_Teleport = 0
		loc = Enemy:loc
		set_pos(Enemy:px, Enemy:py +64)
		layer = 101
		dir = Enemy:dir
		Flick("Minato Teleport", src)

	Teleport_Barrier(mob/Barrier)
		src:Allies = Barrier.Village
		src:Projectile_Owner = Barrier:Creator
		dir = Barrier.dir
		if(dir == EAST)
			vel_x = abs(vel_x)
			set_pos(Barrier.px + Barrier.step_x+(pwidth*2.5), Barrier.py)
		else if(dir == WEST)
			vel_x = -vel_x
			set_pos(Barrier.px + Barrier.step_x-pwidth, Barrier.py)
		Teleporting_Barrier = Barrier

	Execute_Jutsu(var/M, var/C)
		view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: [M]"

	Cooldown_Display (var/C)
		..()
		winset(src, "default.Chakra_Needed", "is-visible=true")
		winset(src, "default.Chakra_Needed","value=\"[round(100*C/MaxCha)]%\"")

		if(!COM)
			src<<"<b><font color=#6EDEFF><u>You don't have enough chakra!</u>"
			COM ++
			spawn(15) COM --

		CO ++
		var/_CO = CO
		var/T = 0

		loop
			if(CO != _CO) return
			T++
			if(T == 1) winset(src, "default.Chakra_Needed", "bar-color=\"#1FB9FF\"")
			else if(T == 2) winset(src, "default.Chakra_Needed", "bar-color=\"#42C4FF\"")
			else if(T == 3) winset(src, "default.Chakra_Needed", "bar-color=\"#75D3FF\"")
			else if(T == 4) winset(src, "default.Chakra_Needed", "bar-color=\"#9AE0FF\"")
			else if(T == 5) winset(src, "default.Chakra_Needed", "bar-color=\"#BBE9FE\"")

			spawn(1)
				if(T != 5) goto loop
				else winset(src, "default.Chakra_Needed", "is-visible=false")

	Can_Execute(var/obj/J, var/C)
		if(Explosing || No_Attack || GoingSage || Wall_Freeze || Mind_Controlling && !Lethal || J.Delay || Gentle_Fist || Executing_Special_Jutsu || Venomous_Clone) return 0
		if(J.Dash && Flag)
			src<<"<b><font color=red><u>You can't use this jutsu while carrying the Flag.</u>"
			return 0
		if(J.Tournament_GoingOn && NEM_Round.Type == "Tourney")
			src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return 0
		if(J.Boss_Mode && Boss_Mode)
			src<<"<b><font color=red><u>This jutsu is illegal during Juggernaut Mode!</u>"
			return 0
		if(J.Capture_The_Flag && Capture_The_Flag)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u>"
			return 0
		if(J.Special_Heal && Can_Revive == 0)
			src<<"<b><font color=red><u>You died before, you use this jutsu anymore.</u>"
			return 0
		if(J.On_Ground && !on_ground) return 0
		if(!J.Hit_Execute)
			if(Levitating || Shield_ || Gates || Intangible || Boulder || BoulderX || knockback || freeze || Controlling >= 1 || Attacking || knocked) return 0
		if(J.Hit_Execute)
			if(Levitating || Shield_ || Gates || Intangible || Boulder || BoulderX || knockback || Controlling >= 1 || knocked) return 0
		if(Cha < C)
			if(client) Cooldown_Display (C)
			return 0
		else
			if(Substitution == 1)
				if(Substitution_Image) del(Substitution_Image)
				density = 1
				Dragonned = 0
				Substitution = 0
				Can_Attack_ = 1
				invisibility = 0
			if(!J.Executed_Fully) Cha -= C
			else
				var/Result = C/4
				Cha -= Result
				spawn() Drain_Rest(C-Result)
mob/proc
	Drain_Rest(var/C)
		..()
		var/Checks = 0
		while(C)
			if(Executed_Fully)
				Executed_Fully = 0
				Cha -= C
				C = null
			if(Checks > 5) return
			Checks++
			sleep(5)
obj/var
	Dash = 0
	Delay = 0
	Cooldown = 0
	On_Ground = 0
	Boss_Mode = 0
	Hit_Execute = 0
	Special_Heal = 0
	Executed_Fully = 0
	Capture_The_Flag = 0
	Tournament_GoingOn = 0

mob/Dragonpearl123/verb/Cooldown()
	set hidden = 1
	Missions_Cooldowns = list()
	for(var/obj/Jutsus/J in src) if(J.Delay) J.Delay = 1
	if(Kunai_Jutsu.Delay) Kunai_Jutsu.Delay = 1
	if(Scroll_Kunai_Jutsu.Delay) Scroll_Kunai_Jutsu.Delay = 1
	SubstitutionCD = 0

obj/proc
	Delay(var/T, mob/Executor)
		if(Executor) T = round(T)
		if(src:Jutsu_Executor) if(src:Jutsu_Executor:Delay_Boost) T = round(T *0.75, 1)
		if(T == Delay) return
		if(Delay)
			Delay += T
			return
		Delay = T
		Delay++
		spawn()
			while(Delay)
				var/Real_Name_ = Real_Name
				Delay--
				Cooldown = 1
				if(!Delay)
					name = Real_Name_
					return
				else
					if(Delay == 1) name = "[Real_Name_] - Cooldown: [Delay] second"
					if(Delay > 1) name = "[Real_Name_] - Cooldown: [Delay] seconds"
					sleep(10)

	Sword_Rush()
		src.Dash = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(10)
		for(var/obj/Jutsus/Crescent_Moon/J in Executor) spawn() J.Delay(7)
		for(var/obj/Jutsus/Dual_Slash/J in Executor) spawn() J.Delay(7)
		Executor.Rasengan = 894651657
		Executor.Execute_Jutsu("Sword Rush!")
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(15)
			Executor.Rasengan = 0
			Flick("teleport", Executor)
		loop
			if(Executor.Rasengan)
				Flick("Charge", Executor)
				spawn(6.25) goto loop

	Rasengan_Yondaime_()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		Flick("Rasengan", Executor.)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		sleep(5.15)
		Executor.Rasengan = "Yondaime"
		Executor.Execute_Jutsu("Rasengan!")
		Flick("Rasengan II",Executor)
		if(Executor.dir == EAST && Executor.Rasengan) Executor.vel_x = 50
		if(Executor.dir == WEST && Executor.Rasengan) Executor.vel_x = -50
		spawn(15)
			Executor.Rasengan = 0
			Flick("teleport", Executor)

	Rasengan()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		for(var/obj/Jutsus/Naruto_Uzumaki_Barrage/J in Executor) spawn() J.Delay(5)
		for(var/obj/Jutsus/Giant_Rasengan/J in Executor) spawn() J.Delay(3)
		for(var/obj/Jutsus/Rasenshuriken/J in Executor) spawn() J.Delay(3)
		Executor.Rasengan=1
		Flick("giant",Executor.)
		Executor.Execute_Jutsu("Rasengan!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Flick("rasengan3",Executor)
		if(Executor.dir==EAST && Executor.Rasengan) Executor.vel_x = 25
		if(Executor.dir==WEST && Executor.Rasengan) Executor.vel_x = -25
		spawn(10)
			Executor.Rasengan = 0
			Flick("teleport", Executor)
			if(Executor.E_Part == "Use A Jutsu") Executor.Complete_Genin_Part()
	Rasengan_Ashura()
		src.Dash = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(10)
		Executor.Rasengan=1
		Flick("rasengan", Executor.)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		if(Executor.dir==EAST && Executor.Rasengan) Executor.vel_x = 65
		if(Executor.dir==WEST && Executor.Rasengan) Executor.vel_x = -65
		spawn(20)
			Executor.Rasengan = 0
			Flick("teleport", Executor)
	Heal()
		src.Tournament_GoingOn = 1
		src.Boss_Mode = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Next_Mode == "Reboot Now") return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(5)
		Executor.freeze ++
		Flick("Heal", Executor)
		spawn(10)
			Executor.freeze --
			Executor.stop()
		for(var/mob/M in view(7))
			if(M.Village == Executor.Village && !M.Gates && !M.Kyuubi && !M.Susanoo && M.Real && !M.knocked)
				if(M != Executor && Executor.name != "Rin" && Executor.name != "Kabuto") M.overlays+='Graphics/Skills/Heal.dmi'
				if(M != Executor && Executor.name == "Rin" || Executor.name == "Kabuto" && M != Executor) M.overlays+='Graphics/Skills/Heal2.dmi'
				var/Buff = 10+rand(5, 15)
				M.Check_Assist(Buff)
				M.HP += Buff
				spawn(10)
					if(Executor.name != "Rin" && Executor.name != "Kabuto") M.overlays-='Graphics/Skills/Heal.dmi'
					if(Executor.name == "Rin" || Executor.name == "Kabuto") M.overlays-='Graphics/Skills/Heal2.dmi'


	Mass_Heal()
		src.Tournament_GoingOn = 1
		src.Capture_The_Flag = 1
		src.Special_Heal = 1
		src.Boss_Mode = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Next_Mode == "Reboot Now") return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(15)
		Executor.freeze ++
		spawn(20)
			Executor.freeze --
			Executor.stop()
		Flick("Heal", Executor)
		for(var/mob/M in Executor.NEM_Round.Ninjas)
			if(M.Village == Executor.Village && !M.Gates && !M.Kyuubi && !M.Susanoo && M.Real && !M.knocked)
				if(M != Executor) M.overlays+='Graphics/Skills/Heal.dmi'
				var/Buff = 5+rand(5, 15)
				M.Check_Assist(Buff)
				M.HP += Buff
				spawn(10) M.overlays-='Graphics/Skills/Heal.dmi'
	Lethal_Scratch()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(20)
		Flick("Special",Executor)
		sleep(5)
		Executor.Execute_Jutsu("Lethal Scratch!")
		Executor.Rasengan = 4978216
		if(Executor.dir == EAST) Executor.vel_x = 65
		if(Executor.dir == WEST) Executor.vel_x = -65
		spawn(25)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
	Lava_Whirl()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(25)
		for(var/obj/Jutsus/Lava_Punches/K in Executor) K.Delay(5)
		Executor.freeze ++
		if(Executor.dir == WEST) Executor.pixel_x -= 40
		spawn() Flick("Dash", Executor)
		sleep(6)
		Executor.Execute_Jutsu("Lava Whirl!")
		Executor.Rasengan = 79874
		Executor.freeze --
		if(Executor.dir==EAST) Executor.vel_x=65
		if(Executor.dir==WEST) Executor.vel_x=-65
		spawn(25)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
				Executor.pixel_x = 0
	Brutal_Impact()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 125) == 0) return
		Delay(10)
		Flick("Best", Executor)
		sleep(5)
		Executor.Rasengan = 81365164
		Executor.Execute_Jutsu("Brutal Impact!")
		if(Executor.dir==EAST) Executor.vel_x = 65
		if(Executor.dir==WEST) Executor.vel_x = -65
		spawn(20)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
	Minato_Rasengan()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(10)
		Flick("rasengan", Executor)
		sleep(7.5)
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Flick("rasengan2", Executor)
		Executor.Execute_Jutsu("Rasengan!")
		Executor.Rasengan = "Minato"
		if(Executor.dir == EAST) Executor.vel_x = 60
		if(Executor.dir == WEST) Executor.vel_x = -60
		spawn(20)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan = 0
	Jiraiya_Rasengan_S()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(10)
		for(var/obj/Jutsus/Toad_Flame_Bullet/S in src) S.Delay(5)
		Executor.Execute_Jutsu("Rasengan!")
		Executor.Rasengan = 8
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(20)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
		loop
			if(Executor.Rasengan)
				Flick("rasengan", Executor)
				spawn(3.75) goto loop
	Jiraiya_Rasengan()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(10)
		Flick("rasengan", Executor)
		sleep(4)
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Flick("rasengan2", Executor)
		sleep(1.5)
		Flick("rasengan3", Executor)
		Executor.Execute_Jutsu("Rasengan!")
		Executor.Rasengan = 8
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(15)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
	Water_Bomb()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(25)
		Flick("First", Executor)
		sleep(6)
		Executor.Execute_Jutsu("Water Release.- Bomb!")
		Executor.Rasengan = 89794161
		if(Executor.dir == EAST) Executor.vel_x = 75
		if(Executor.dir == WEST) Executor.vel_x = -75
		spawn(40)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
	Beast_Tearing_Gale_Palm()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 55) == 0) return
		Delay(15)
		for(var/obj/Jutsus/Beast_Tearing_Gale_Scratch/J in Executor) J.Delay(10)
		Flick("First", Executor)
		sleep(4)
		Executor.Activated = 0
		Executor.Execute_Jutsu("Beast Tearing Gale Palm!")
		Executor.Rasengan = 69
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
	Lariat()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(30)
		Flick("Lariat", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Lariat!")
		Executor.Rasengan = 88491
		if(Executor.dir == EAST) Executor.vel_x = 60
		if(Executor.dir == WEST) Executor.vel_x = -60
		spawn(20)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
	Lariat_Raikage()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 55) == 0) return
		Delay(20)
		Flick("Lariat", Executor)
		Executor.Execute_Jutsu("Lariat!")
		Executor.Rasengan = 79841321
		if(Executor.dir == EAST) Executor.vel_x = 60
		if(Executor.dir == WEST) Executor.vel_x = -60
		spawn(20)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan = 0
		loop
			spawn(6.75) if(Executor.Rasengan)
				Flick("Lariat", Executor)
				goto loop
	Water_Dash()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Levitating) return
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(10)
		Flick("Dash", Executor)
		Executor.Rasengan=10
		Executor.Execute_Jutsu("Water Release.- Dash!")
		if(Executor.dir == EAST) Executor.vel_x = 65
		if(Executor.dir == WEST) Executor.vel_x = -65
		spawn(30)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
	Snake_Dash()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(20)
		Flick("slither", Executor)
		Executor.Execute_Jutsu("Snake Dash!")
		Executor.Rasengan=1987461513621
		if(Executor.dir == EAST) Executor.vel_x = 65
		if(Executor.dir == WEST) Executor.vel_x = -65
		spawn(30)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan=0
	Boulder()
		src.Capture_The_Flag = 1
		src.Tournament_GoingOn = 1
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(75)
		Executor.Boulder = 1
		Executor.Dragonned = 1
		Executor.move_speed = 50
		Flick("boulder", Executor)
		sleep(5)
		Flick("boulder2", Executor)
		Executor.Execute_Jutsu("Boulder!")
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(300)
			if(Executor.Boulder)
				Executor.Dragonned = 0
				Executor.Boulder = 0
				Executor.move_speed = 10
				Flick("teleport", Executor)
	Seven_Swords_Dance()
		src.Capture_The_Flag = 1
		src.Tournament_GoingOn = 1
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(75)
		Executor.Execute_Jutsu("Seven Swords Dance!")
		Executor.Boulder = 1
		Executor.Dragonned = 1
		Executor.move_speed = 50
		Flick("boulder2", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(300)
			if(Executor.Boulder)
				Executor.Dragonned = 0
				Executor.Boulder = 0
				Executor.move_speed = 10
				Flick("teleport", Executor)
	Fang_Over_Fang()
		src.Capture_The_Flag = 1
		src.Tournament_GoingOn = 1
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(60)
		Executor.Execute_Jutsu("Fang Over Fang!")
		Executor.Boulder = 1
		Executor.Dragonned = 1
		Executor.move_speed = 50
		Flick("boulder", Executor)
		sleep(5)
		Flick("boulder2", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(300)
			if(Executor.Boulder)
				Executor.Dragonned = 0
				Executor.Boulder = 0
				Executor.move_speed = 10
				Flick("teleport", Executor)
	Slash()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(10)
		Executor.freeze ++
		Flick("Unleash", Executor)
		sleep(10)
		Executor.freeze --
		Executor.Rasengan = 666
		Executor.Execute_Jutsu("Graaaaah!")
		Flick("MAttack", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(25)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan = 0
	Double_Rasengan()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(15)
		Flick("Double Rasengan Charge", Executor)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		sleep(11)
		Executor.Execute_Jutsu("Double Rasengan!")
		Executor.Rasengan = 22220
		Flick("Double Rasengan Step", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan = 0
	KRasengan()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(10)
		for(var/obj/Jutsus/J in src) if(J != src) J.Delay(7)
		Flick("rasengan", Executor)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Flick("rasengan2", Executor)
		sleep(5)
		Flick("rasengan3", Executor)
		Executor.Rasengan = 107
		Executor.Execute_Jutsu("Rasengan!")
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(15)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan = 0
	Brutal_Tackle()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10)
		Executor.Execute_Jutsu("DIE!!!")
		Flick("Tackle", Executor)
		Executor.Iron = 2
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.Iron)
				Flick("teleport", Executor)
				Executor.Iron = 0
	Iron_Ball()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(7)
		Executor.Execute_Jutsu("Graah!")
		Executor.Iron=1
		Flick("giant", Executor)
		Flick("Iron", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 25
		if(Executor.dir == WEST) Executor.vel_x = -25
		spawn(10)
			if(Executor.Iron)
				Flick("teleport", Executor)
				Executor.Iron = 0
	Resonating_Echo_Drill()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 70) == 0) return
		Delay(15)
		Flick("first", Executor)
		Executor.Iron = 98791651
		Executor.freeze ++
		sleep(3)
		Executor.freeze --
		Executor.Execute_Jutsu("Resonating Echo Drill!")
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(15)
			if(Executor.Iron)
				Flick("teleport", Executor)
				Executor.Iron = 0
	Lightning_Stab()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(15)
		Executor.Chidori = 10007
		Flick("Lightning Stab", Executor)
		sleep(6)
		Executor.Execute_Jutsu("Lightning Stab!")
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Flick("Lightning Stab2", Executor)
		if(Executor.dir==EAST) Executor.vel_x = 55
		if(Executor.dir==WEST) Executor.vel_x = -50
		spawn(15)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Chakra_Scalpel()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(15)
		for(var/obj/Jutsus/Dead_Soul_Summoning/K in Executor) K.Delay(5)
		for(var/obj/Jutsus/Special_AttackX/K in Executor) K.Delay(5)
		for(var/obj/Jutsus/Tornedo/K in Executor) K.Delay(5)
		Flick("Mystic", Executor)
		sleep(10)
		Executor.Activated = 0
		Executor.Chidori = 289846135
		Executor.Execute_Jutsu("Chakra Scalpel!")
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Chidori_Rinne()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		Flick("Chidori", Executor)
		Flick("Chidori2", Executor)
		sleep(3)
		Executor.Chidori = 1
		Executor.Execute_Jutsu("Chidori!")
		Flick("ChidoriHit", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(15)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Rinnegan_Slash()
		var/mob/Executor = usr
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 30) == 0) return
		var/T=0
		Delay(3)
		flick("teleport", Executor)
		sleep(2)
		for(var/mob/M in range("26x5"))
			if(T)return
			if(Executor.dir == EAST && M.px < Executor.px) continue
			else if(Executor.dir == WEST && M.px > Executor.px) continue
			if(M.Boulder >= 1|| M.BoulderX >= 1 ||M.knocked == 1 || M.Real == 0 || M.Village == Executor.Village || M.Dragonned == 1) continue
			if(M.Dodging == 1)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your Technique!"
				return
			T++
			Delay(10)
			Executor.Executed_Fully=1
			if(Executor.dir==EAST)Executor.loc=locate(M.x+2,M.y,M.z)
			else Executor.loc=locate(M.x-1,M.y,M.z)
			flick("RinneAttack",Executor)
			M.Damage(Executor, 15+rand(5,15), 1)
		spawn()
			if(T==0)
				Executor.freeze = 0
				Executor.Dragonned = 0
				Executor.stop()
				return
	Chidori()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		Flick("chidori", Executor)
		Flick("chidori2", Executor)
		sleep(3)
		Executor.Chidori = 1
		Executor.Execute_Jutsu("Chidori!")
		Flick("chidori3", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(15)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0

	Poisonous_Chakra_Scalpel()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10)
		Flick("Chusa", Executor)
		sleep(10.25)
		Executor.Rasengan = "Kabuchimaru"
		Executor.Execute_Jutsu("Poisonous Chakra Scalpel!")
		Flick("Chusa Go", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(15)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan = 0
	Chidori_EMS()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(15)
		Executor.freeze ++
		Flick("Chidori", Executor)
		sleep(9)
		Executor.freeze --
		Executor.Chidori = "Chidori"
		Executor.Execute_Jutsu("Chidori!")
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(15)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Chidori_Stab()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(30)
		Executor.freeze ++
		Flick("Chidori Stab", Executor)
		sleep(6)
		Executor.freeze --
		Executor.Chidori = "Stab"
		Executor.Execute_Jutsu("Chidori Stab!")
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(25)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	LariatX()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 110) == 0) return
		Delay(30)
		Flick("Lariat", Executor)
		sleep(3)
		Executor.Chidori = 596846163
		Executor.Execute_Jutsu("Lariat!")
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Dash()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(15)
		Flick("Raiton Buretto2", Executor)
		sleep(8)
		Executor.Chidori = 89461324749
		Executor.Execute_Jutsu("Dash!")
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(15)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Butterfly_Bullet_Bomb()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(15)
		Flick("Go", Executor)
		sleep(11)
		Executor.Chidori = 892713
		Executor.Execute_Jutsu("Butterfly Bullet Bomb!")
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Rage()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(15)
		for(var/obj/Jutsus/Ultra_Punch/K in Executor) K.Delay(5)
		for(var/obj/Jutsus/Piston_Fist/K in Executor) K.Delay(5)
		Flick("Rage", Executor)
		sleep(6)
		Executor.Chidori = 6875610655
		Executor.Execute_Jutsu("Rage!")
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Chakra_Impulsion()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(15)
		Flick("Rage", Executor)
		sleep(6)
		Executor.Chidori = 6875610655
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		Executor.Execute_Jutsu("Chakra Impulsion!")
		spawn(20)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Pre_Chidori()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		Executor.Activated = 0
		Executor.Executing_Special_Jutsu = 1
		for(var/obj/Jutsus/Leaf_Hurricane_PSasuke/K in Executor) K.Delay(5)
		for(var/obj/Jutsus/Phoenix_Flower_PSasuke/K in Executor) K.Delay(5)
		for(var/obj/Jutsus/Lion_Barrage/K in Executor) K.Delay(5)
		Flick("chidori", Executor)
		sleep(6)
		Flick("chidori2", Executor)
		sleep(8)
		Executor.Executing_Special_Jutsu = 0
		Executor.Attacking = 0
		Executor.Chidori = 1996
		Flick("chidori3", Executor)
		Executor.Execute_Jutsu("Chidori!")
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(20)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	CChidori()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(7)
		Flick("chidori", Executor)
		Flick("chidori2", Executor)
		sleep(3)
		Executor.Chidori = 108
		Executor.Execute_Jutsu("Chidori!")
		Flick("chidori3", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(20)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Giant_Rasengan()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(15)
		for(var/obj/Jutsus/Naruto_Uzumaki_Barrage/J in Executor) spawn() J.Delay(5)
		for(var/obj/Jutsus/Naruto_Rasengan/J in Executor) spawn() J.Delay(3)
		for(var/obj/Jutsus/Rasenshuriken/J in Executor) spawn() J.Delay(3)
		Flick("rasengan", Executor)
		sleep(5)
		Executor.Rasengan = 5
		Executor.Execute_Jutsu("Giant Rasengan!")
		Flick("giant", Executor)
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Flick("giant2", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(15)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan = 0
				if(Executor.E_Part == "Use A Jutsu") Executor.Complete_Genin_Part()
	Raikiri_()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(17, Executor)
		var/K = new/obj/Effects/Kakashi_Raikiri (Executor.loc, Executor)
		sleep(10.9)
		del(K)
		Executor.Execute_Jutsu("Raikiri!")
		Executor.Chidori = "AK"
		Flick("Raikiri", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.Chidori)
				Flick("teleport", Executor)
				Executor.Chidori = 0
	Raikiri()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 80) == 0) return
		Delay(30, Executor)
		for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(3)
		Flick("raikiri1", Executor)
		sleep(2.5)
		Flick("raikiri2", Executor)
		sleep(5)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Execute_Jutsu("Raikiri!")
		Executor.KakashiChidori = 1
		Flick("raikiri3", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(20)
			if(Executor.KakashiChidori)
				Flick("teleport", Executor)
				Executor.KakashiChidori = 0
	Kakashi_Chidori()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10, Executor)
		for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(3)
		Executor.freeze ++
		Flick("raikiri1", Executor)
		sleep(2.5)
		Flick("chidori2", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Chidori!")
		Executor.KakashiChidori = 5
		Executor.freeze --
		Flick("chidori3", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 50
		if(Executor.dir == WEST) Executor.vel_x = -50
		spawn(20)
			if(Executor.KakashiChidori)
				Flick("teleport", Executor)
				Executor.KakashiChidori = 0
	Dynamic_Entry()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(7, Executor)
		for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Primary_Lotus_Might_Gai/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Leaf_Hurricane_Might_Gai/K in Executor) K.Delay(3)
		Executor.DinamicEntry = 1
		Flick("dinamic", Executor)
		Executor.Execute_Jutsu("Dynamic Entry!")
		if(Executor.dir == EAST) Executor.vel_x = 45
		if(Executor.dir == WEST) Executor.vel_x = -45
		spawn(15)
			if(Executor.DinamicEntry)
				Flick("teleport", Executor)
				Executor.DinamicEntry = 0
	Slap_Of_Youth()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		for(var/obj/Jutsus/Primary_Lotus_Might_Gai/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Leaf_Hurricane_Might_Gai/K in Executor) K.Delay(3)
		Delay(7)
		Flick("youth", Executor)
		sleep(8)
		Executor.Execute_Jutsu("Slap Of Youth!")
		Executor.DinamicEntry = 5
		Flick("youth2", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 40
		if(Executor.dir == WEST) Executor.vel_x = -40
		spawn(15)
			if(Executor.DinamicEntry)
				Flick("teleport", Executor)
				Executor.DinamicEntry = 0
	Rasenshuriken()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(30)
		for(var/obj/Jutsus/Naruto_Uzumaki_Barrage/J in Executor) spawn() J.Delay(7)
		for(var/obj/Jutsus/Naruto_Rasengan/J in Executor) spawn() J.Delay(5)
		for(var/obj/Jutsus/Giant_Rasengan/J in Executor) spawn() J.Delay(5)
		Flick("rasen2", Executor)
		sleep(15)
		Executor.Rasengan = 2
		Executor.Execute_Jutsu("Wind Release.- Rasenshuriken!")
		Flick("rasen2", Executor)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Flick("rasen4", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 55
		if(Executor.dir == WEST) Executor.vel_x = -55
		spawn(15)
			if(Executor.Rasengan)
				Flick("teleport", Executor)
				Executor.Rasengan = 0
				if(Executor.E_Part == "Use A Jutsu") Executor.Complete_Genin_Part()
	Chakra_Blade_Punch()
		src.Dash = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		for(var/obj/Jutsus/Ash_Pile_Burning/J in Executor) J.Delay(3)
		for(var/obj/Jutsus/Flying_Swallow/J in Executor) J.Delay(3)
		Delay(10)
		Executor.ChakraBlade = 1
		Flick("blade2", Executor)
		if(Executor.dir == EAST) Executor.vel_x = 20
		if(Executor.dir == WEST) Executor.vel_x = -20
		spawn(15)
			if(Executor.ChakraBlade)
				Flick("teleport", Executor)
				Executor.ChakraBlade = 0
	Suffocating_Paper()
		src.On_Ground = 1
		var/mob/Executor = usr
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		var/Target = 0
		Executor.freeze ++
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Paper_Trap/J in Executor) J.Delay(7)
				Executor.Activated = 0
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Target++
			Executor.Executed_Fully = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Paper_Trap/J in Executor) J.Delay(7)
				Executor.Activated = 0
				M.freeze --
				M.Dragonned = 0
				Executor.Dragonned = 0
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Paper_Trap/J in Executor) J.Delay(10)
			Executor.Activated = 0
			M.CanMove = 0
			Flick("Special", Executor)
			sleep(3)
			Executor.Execute_Jutsu("Suffocating Papers!")
			new/obj/Effects/Suffocating_Paper (M.loc, M)
			spawn(5) M.Damage(Executor, 13.5, 1, 0, 0, 1)
			spawn(8) M.Damage(Executor, 7.5, 1, 0, 0, 1)
			spawn(11) M.Damage(Executor, 7.5, 1, 0, 0, 1)
			spawn(14) M.Damage(Executor, 7.5, 1, 0, 0, 1)
			spawn(16)
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)

	Naruto_Uzumaki_Barrage()
		src.On_Ground = 1
		var/mob/Executor = usr
		src.Executed_Fully = 1
		if(Executor.E_Part == "Use A Jutsu") {spawn() Executor.Complete_Genin_Part(); return}
		if(Executor.Can_Execute(src, 25) == 0) return
		var/Target = 0
		Executor.freeze ++
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			Executor.Executed_Fully = 1
			for(var/obj/Jutsus/Naruto_Rasengan/J in Executor) spawn() J.Delay(3)
			for(var/obj/Jutsus/Giant_Rasengan/J in Executor) spawn() J.Delay(3)
			for(var/obj/Jutsus/Rasenshuriken/J in Executor) spawn() J.Delay(3)
			Target++
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 0
			Executor.Teleport_Behind(M, Executor)
			M.Can_Dodge_ = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				M.freeze --
				M.Dragonned = 0
				Executor.Dragonned = 0
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("uzamaki", Executor)
			spawn(5)
				M.freeze --
				M.Dragonned = 0
				M.vel_y = 10
				M.Damage(Executor, 35, 1, 0, 0, 1)
				spawn(2.5)
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
					Flick("teleport", Executor)
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)

mob/proc
	Transform()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(WoodCD == 1||dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boulder>=1||BoulderX>=1||Guardian || Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		src.freeze ++
		src.stop()
		src.WoodCD = 1
		spawn(1200) WoodCD = 0
		icon_state="Throw"
		NEM_Round.Shout("<font size=2><font color=#800517><u>- Killer Bee has transformed into Three Tails! -</u>")
		var/A=new/obj/GroundSmash(src.loc)
		if(src.dir==WEST)
			A:pixel_x-=15
		if(src.dir==EAST)
			A:pixel_x-=10
		Sage=1
		GoingSage=0
		Str=16.5
		MaxHP=150
		MaxCha=150
		Def=8
		ultra_speed = 1
		freeze--
		src.icon = 'Graphics/Characters/Killer Bee2.dmi'
		name = "(Three Tails) Killer Bee"
		src.Check_Jutsu()
		src.Run_Off()
		src.stop()
	Poison_Transformation()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(CanUseSusanoo > 2)
			src<<output("<b><font color=red>You can only use Poison Transformation twice per round!","Chat")
			return
		if(dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Guardian || Boss || Tournament_GoingOn) return
		if(!on_ground) return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		GoingSage = 1
		Flick("Special III", src)
		spawn(11)
			src.speed_multiplier = 0
			src.move_speed = 0
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#A23BEC><u>- Torune's body has been coated with nano-sized, venomous insects! -</u>")
				Sage=1
				GoingSage=0
				Str=15
				Transformed = 1
				MaxHP=175
				Counting = rand(1,500)
				var/Current_Counting = Counting
				MaxCha=175
				Cha=175
				ultra_speed = 1
				Def=8.25
				name = "{Venomous Insects} Torune"
				src.icon = 'Graphics/Characters/Torune Poison.dmi'
				Transform_Proc(600, "Venomous Insects", "#A23BEC")
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				src.dir = Facing
				spawn(6000)
					if(Sage == 1 && Counting == Current_Counting)
						src.speed_multiplier = Speed_Multiplier_X
						Transformed = 0
						Attacking=0
						NEM_Round.Shout("<font size=2><font color=#A23BEC><u>- Torune's body is no longer covered in nano-sized, venomous insects! -</u>")
						Sage = 0
						src.icon = 'Graphics/Characters/Torune.dmi'
						name = "Torune"
						ultra_speed = 2
						MaxHP = 120
						MaxCha = 120
						Str = 13.15
						Def = 8
						MaxEnergy = 200
						ultra_speed = 0
						src.Check_Jutsu()
						src.Run_Off()
						src.stop()
	Drop_Weights()
		if(Gates) return
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only drop your weights twice per round!","Chat")
			return
		if(dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1) return
		if(Guardian || Boss || Tournament_GoingOn) return
		if(!on_ground) return
		if(alert(src, "Are you sure? You can only use this jutsu once.", "Drop Weights", "No", "Yes") == "Yes")
			if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
			if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
			if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
			if(Capture_The_Flag == 1)
				src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
				return
			if(CanUseSusanoo>=1)
				src<<output("<b><font color=red>You can only drop your weights once per round!","Chat")
				return
			if(dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1) return
			if(Guardian || Boss || Tournament_GoingOn) return
			if(!on_ground) return
			var/Facing = dir
			Speed_Multiplier_X = speed_multiplier
			src.Dodging = 0
			src.speed_multiplier = 0
			src.move_speed = 0
			src.Check_Icon = 0
			src.stop()
			GoingSage = 1
			invisibility = 101
			new/obj/Effects/Rock_Lee_Weights (src.loc, src)
			new/obj/Effects/Might_Gai (src.loc, src)
			spawn(16) if(GoingSage) NEM_Round.Shout("<font size=2><font color=#52D017><u>- Rock Lee has dropped his weights! -</u>")
			spawn(21)
				for(var/mob/M in view(src, 3)) if(M.Dragonned == 0 && !M.knocked && M.Real && M != src) M.Damage(src, rand(5, 10), 1, 1, 0, 1)
				src.speed_multiplier = 2.15
				src.Check_Icon = 1
				src.Attacking = 0
				if(GoingSage)
					CanUseSusanoo ++
					Sage = 1
					GoingSage = 0
					Str = 17
					Transformed = 1
					MaxHP = 130
					if(HP >= 115) HP = MaxHP
					Cha = MaxCha
					MaxEnergy = 250
					Energy = 250
					Def = 8
					name = "(Youthful) Rock Lee"
					src.Run_Off()
					src.stop()
					src.dir = Facing
					for(var/obj/Jutsus/Drop_Weights/D in src) del(D)
	Kyuubi_Mode()
		for(var/obj/Jutsus/Kyuubi_Mode_K/G in src) if(G.Delay) return
		for(var/obj/Jutsus/Kyuubi_Mode_G/G in src) if(G.Delay) return
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(CanUseSusanoo > 1)
			src<<output("<b><font color=red>You can only use Kyuubi Mode twice per round!","Chat")
			return
		if(dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Guardian || Boss || Tournament_GoingOn) return
		if(!on_ground) return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		GoingSage = 1
		spawn()
			src.speed_multiplier = Speed_Multiplier_X *1.30
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#AC3400><u>- [name] has transformed into Kyuubi! -</u>")
				var/A=new/obj/GroundSmash(src.loc)
				if(dir == WEST) A:pixel_x -= 15
				if(dir == EAST) A:pixel_x -= 10
				Sage = 1
				Bijuu = 1
				GoingSage = 0
				Str = 14.25
				Transformed = 1
				MaxHP = 150
				Counting = rand(1,500)
				var/Current_Counting = Counting
				MaxCha = 175
				MaxEnergy = 215
				Def = 7.85
				Activated = 0
				name = "(Kyuubi) [name]"
				src.icon = 'Graphics/Characters/Bijuu.dmi'
				Transform_Proc(420, "Kyuubi Mode", "#AC3400")
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				src.dir = Facing
				spawn(3000)
					if(Sage == 1 && Counting == Current_Counting)
						if(freeze)
							loop
								sleep(30)
								if(Sage == 1 && freeze) goto loop
						Transformed = 0
						NEM_Round.Shout("<font size=2><font color=#AC3400><u>- [name] has reverted into his normal form! -</u>")
						Sage = 0
						Bijuu = 0
						if(name == "(Kyuubi) Ginkaku")
							icon = 'Graphics/Characters/Ginkaku.dmi'
							name = "Ginkaku"
							pwidth = 32
							pixel_x = 0
							MaxHP = 115
							MaxCha = 135
							MaxEnergy = 175
							Str = 13.75
							Def = 7.75
							speed_multiplier = 1.70
							ultra_speed = 0
						if(name == "(Kyuubi) Kinkaku")
							icon = 'Graphics/Characters/Kinkaku.dmi'
							name = "Kinkaku"
							pwidth = 32
							pixel_x = 0
							MaxHP = 100
							MaxCha = 150
							MaxEnergy = 175
							Str = 12.5
							Def = 6.5
							speed_multiplier = 1.65
							ultra_speed = 0
						Run_Off()
						Check_Jutsu()
	Sage_Mode()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(CanUseSusanoo>3)
			src<<output("<b><font color=red>You can only use Sage Mode three times per round!","Chat")
			return
		if(dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Guardian || Boss || Tournament_GoingOn) return
		if(!on_ground) return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=yellow><b><u>You begin focusing natural energy...</u></font>"
		GoingSage = 1
		icon_state = "mob-shooting"
		spawn(rand(175,200))
			src.speed_multiplier = Speed_Multiplier_X *1.30
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#FE9A2E><u>- Naruto has transformed into Sage Mode! -</u>")
				var/A=new/obj/GroundSmash(src.loc)
				if(src.dir==WEST)
					A:pixel_x-=15
				if(src.dir==EAST)
					A:pixel_x-=10
				Sage=1
				GoingSage=0
				Str=15
				Transformed = 1
				MaxHP=150
				HP=150
				Counting = rand(1,500)
				var/Current_Counting = Counting
				MaxCha=150
				Cha=150
				Def=7.5
				name = "Sage Naruto"
				src.icon = 'Graphics/Characters/Sage.dmi'
				Transform_Proc(300, "Sage Mode", "#FE9A2E")
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				src.dir = Facing
				spawn(3000)
					if(Sage == 1 && Counting == Current_Counting)
						if(freeze)
							loop
								sleep(30)
								if(Sage == 1 && freeze) goto loop
						Transformed = 0
						NEM_Round.Shout("<font size=2><font color=#FE9A2E><u>- Naruto's Sage Mode has run out! -</u>")
						Sage = 0
						src.icon = 'Graphics/Characters/Naruto.dmi'
						MaxHP=115
						MaxCha=100
						Attacking=0
						MaxEnergy=150
						name = "Naruto"
						Str=12
						Def=6.5
						src.speed_multiplier = 1.60
						src.Check_Jutsu()
						src.Run_Off()
						src.stop()



	PS_SCurse_Seal()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Guardian || dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only activate Curse Seal twice per round!","Chat")
			return
		var/Facing = dir
		if(Sharingan) Sharingan_Off(src)
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=#800517><b>...Hatred..."
		GoingSage=1
		Flick("CS Transform", src)
		spawn(12.75)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#8904B1><u>- {PS} Sasuke has activated Curse Seal! -</u>")
				Activated=0
				Sage=1
				GoingSage=0
				Str=14
				move_speed=10
				MaxHP=125
				MaxCha=150
				ultra_speed = 1
				Def=7
				name = "{PS} (Curse Seal) Sasuke"
				src.icon = 'Graphics/Characters/LilSasukeCS.dmi'
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				src.dir = Facing



	Transform_Y()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boulder||BoulderX||Guardian || dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only transform twice per round!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		GoingSage=1
		if(dir == WEST) pixel_x -= 16
		spawn() Flick("Transformation", src)
		spawn(12.5)
			var/A=new/obj/GroundSmash(src.loc)
			if(src.dir==WEST) A:pixel_x-=15
			if(src.dir==EAST) A:pixel_x-=10
		spawn(15)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#FF8900><u>- Yagura has Released Sanbi! -</u></font>")
				Counting = rand(1,500)
				var/Current_Counting = Counting
				Sage=1
				GoingSage=0
				Activated=0
				Str=15
				MaxHP=180
				ultra_speed = 2
				MaxCha=145
				Cha=145
				MaxEnergy=300
				Energy=300
				speed_multiplier = 2.10
				Def=9
				Activated = 0
				name = "(Sanbi) Yagura"
				Check_Jutsu()
				Run_Off()
				stop()
				Transformed = 1
				src.dir = Facing
				spawn()
					src.pixel_x = 0
					src.icon = 'Graphics/Characters/YaguraX.dmi'

				Transform_Proc(420, "Sanbi Chakra", "#FF8900")
				spawn(4200)
					if(Sage == 1 && Counting == Current_Counting)
						Transformed = 0
						Attacking=0
						ultra_speed = 0
						NEM_Round.Shout("<font size=2><font color=#FF8900><u>- Yagura's Sanbi Chakra has vanished! -</u></font>")
						Sage = 0
						src.icon = 'Graphics/Characters/Yagura.dmi'
						name = "Yagura"
						Activated = 0
						src.ultra_speed = 2
						speed_multiplier = 1.95
						src.MaxCha = 125
						src.Cha = 125
						src.MaxHP = 125
						src.HP = 125
						src.Def = 8.25
						src.Str = 13.25
						src.MaxEnergy = 225
						src.Energy = 225
						src.Check_Jutsu()
						src.Run_Off()
						src.stop()



	Lightning_Release_Armour()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boulder||BoulderX||Guardian || dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only activate Lightning Release Armour twice per round!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		GoingSage=1
		spawn()
			pixel_y = -3
			Flick("Transform", src)
		spawn(7)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#3DE2FF><u>- The Raikage has Released Lightning Armour! -</u>")
				var/A=new/obj/GroundSmash(src.loc)
				if(src.dir==WEST)
					A:pixel_x-=15
				if(src.dir==EAST)
					A:pixel_x-=10
				Counting = rand(1,500)
				var/Current_Counting = Counting
				Sage=1
				GoingSage=0
				Str=14.5
				MaxHP=175
				ultra_speed = 2
				MaxCha=130
				Activated=0
				MaxEnergy=250
				Def=8.5
				Activated = 0
				name = "(Lightning Armour) Raikage"
				src.icon = 'Graphics/Characters/RaikageX.dmi'
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				src.dir = Facing
				Transformed = 1
				Transform_Proc(420, "Lightning Armour", "#3DE2FF")
				spawn(4200)
					if(Sage == 1 && Counting == Current_Counting)
						if(freeze)
							loop
								sleep(30)
								if(Sage == 1 && freeze) goto loop
						Transformed = 0
						Attacking=0
						ultra_speed = 0
						NEM_Round.Shout("<font size=2><font color=#3DE2FF><u>- The Raikage's Lightning Armour has vanished! -</u>")
						Sage = 0
						src.icon = 'Graphics/Characters/Raikage.dmi'
						pixel_y = 0
						MaxHP=100
						MaxCha=130
						MaxEnergy=200
						name = "Raikage"
						Activated = 0
						Str=13.5
						Def=7.5
						Check_Jutsu()
						src.Run_Off()
						src.stop()
	Butterfly_Mode()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Choji_Pill) {src<<"<b><font color=red><u>You can't transform while being under [Choji_Pill]'s effects!</u>"; return}
		if(Boulder||BoulderX||Guardian || dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=3)
			src<<output("<b><font color=red>You can only activate Butterfly Mode three times per round!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=#FE5FD4><b><u><font size=3>Get ready!</u>"
		GoingSage=1
		icon_state="jutsu"
		spawn(200)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#FC4DCE><u>- Choji has activated Butterfly Mode! -</u>")
				var/A=new/obj/GroundSmash(src.loc)
				if(src.dir==WEST) A:pixel_x-=15
				if(src.dir==EAST) A:pixel_x-=10
				Counting = rand(1,500)
				var/Current_Counting = Counting
				Sage=1
				GoingSage=0
				Str=14.5
				MaxHP=145
				Activated=0
				ultra_speed = 1
				HP=145
				MaxCha=150
				speed_multiplier=1.55
				Cha=150
				MaxEnergy=250
				Energy=250
				Def=8.5
				name = "(Butterfly) Choji"
				src.icon = 'Graphics/Characters/ButterflyChoji.dmi'
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				src.dir = Facing

				Transform_Proc(300, "Butterfly Mode", "#FC4DCE")
				spawn(3000)
					if(Sage == 1 && Counting == Current_Counting)
						Transformed = 0
						Attacking=0
						NEM_Round.Shout("<font size=2><font color=#FC4DCE><u>- Choji's Butterfly Mode has run out! -</u>")
						Sage = 0
						src.icon = 'Graphics/Characters/Choji.dmi'
						MaxHP=100
						MaxCha=100
						MaxEnergy=100
						name = "Choji"
						Str=12
						Def=6
						ultra_speed = 0
						src.Check_Jutsu()
						src.Run_Off()
						src.stop()
	Curse_SealK()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission" && client) {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Guardian || dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only activate Curse Seal twice per round!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=#800517><b>...Hatred..."
		GoingSage=1
		Flick("CS Transform", src)
		spawn(10.40)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#8904B1><u>- Kidoumaru has activated Curse Seal! -</u>")
				Sage=1
				ultra_speed = 1
				GoingSage=0
				Str += 3
				MaxHP += 35
				MaxCha += 45
				Def += 2.25
				move_speed=10
				src.icon = 'Graphics/Characters/KidoumaruCS.dmi'
				name = "(Curse Seal) Kidoumaru"
				src.Check_Jutsu()
				if(!Mission_NPC) Run_Off()
				src.stop()
				src.dir = Facing
	Curse_SealJ()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission" && client) {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Guardian || Boulder>=1||dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only activate Curse Seal twice per round!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=#800517><b>...Hatred..."
		GoingSage=1
		Flick("CS Transform", src)
		spawn(8.15)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#8904B1><u>- Jirobo has activated Curse Seal! -</u>")
				Sage=1
				GoingSage=0
				move_speed=10
				ultra_speed = 1
				Str += 3
				MaxHP += 35
				MaxCha += 45
				Def += 2.25
				name = "(Curse Seal) Jirobo"
				src.icon = 'Graphics/Characters/JiroboCS.dmi'
				src.Check_Jutsu()
				if(!Mission_NPC) Run_Off()
				src.stop()
				src.dir = Facing
	Curse_SealT()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission" && client) {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Guardian || Boulder>=1||dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only activate Curse Seal twice per round!","Chat")
			return
		if(PeinCD==1)
			src<<output("<b><font color=red>Wait sometime, we don't want you to abuse!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=#800517><b>...Hatred..."
		GoingSage=1
		Flick("CS Transform", src)
		spawn(11.65)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#8904B1><u>- Tayuya has activated Curse Seal! -</u>")
				Sage=1
				GoingSage=0
				Str += 3
				MaxHP += 35
				MaxCha += 45
				Def += 2.25
				move_speed=10
				ultra_speed = 1
				src.icon = 'Graphics/Characters/TayuyaCS.dmi'
				name = "(Curse Seal) Tayuya"
				src.Check_Jutsu()
				if(!Mission_NPC) Run_Off()
				src.stop()
				src.dir = Facing
	Curse_SealS()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission" && client) {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Guardian || Boulder>=1||dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(Boss || Tournament_GoingOn) return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only activate Curse Seal twice per round!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=#800517><b>...Hatred..."
		GoingSage=1
		Flick("CS Transform", src)
		spawn(11.45)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#8904B1><u>- Sakon has activated Curse Seal! -</u>")
				Sage=1
				GoingSage=0
				Str += 3
				MaxHP += 35
				MaxCha += 45
				Def += 2.25
				move_speed=10
				ultra_speed = 1
				src.icon = 'Graphics/Characters/SakonCS.dmi'
				name = "(Curse Seal) Sakon"
				src.Check_Jutsu()
				if(!Mission_NPC) Run_Off()
				src.stop()
				src.dir = Facing
	Curse_Seal_Juugo()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode || Chidori) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Guardian || dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only activate Curse Seal twice per round!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=#800517><b>...Hatred..."
		GoingSage=1
		icon_state="mob-shooting"
		spawn(rand(75, 100))
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#8904B1><u>- Juugo has activated Curse Seal! -</u>")
				var/A=new/obj/GroundSmash(src.loc)
				if(src.dir==WEST)
					A:pixel_x-=15
				if(src.dir==EAST)
					A:pixel_x-=10
				Sage=1
				GoingSage=0
				Str=15
				move_speed=10
				ultra_speed = 1
				MaxHP=125
				HP=125
				MaxCha=150
				Cha=150
				Def=7.5
				name = "(Curse Seal) Juugo"
				src.icon = 'Graphics/Characters/JuugoCS.dmi'
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				src.dir = Facing
	Curse_Seal()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Guardian || dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		if(CanUseSusanoo>=2)
			src<<output("<b><font color=red>You can only activate Curse Seal twice per round!","Chat")
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=#800517><b>...Hatred..."
		GoingSage=1
		Flick("CS Transform", src)
		spawn(12.75)
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo+=1
				NEM_Round.Shout("<font size=2><font color=#8904B1><u>- Kimimaro has activated Curse Seal! -</u>")
				Sage=1
				GoingSage=0
				Str=15
				move_speed=10
				MaxHP=125
				MaxCha=150
				Def=7.5
				ultra_speed = 1
				name = "(Curse Seal) Kimimaro"
				src.icon = 'Graphics/Characters/KimimaroCS.dmi'
				src.Check_Jutsu()
				if(!Mission_NPC) Run_Off()
				src.stop()
				src.dir = Facing
	Jiraiya_Sage_Mode()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(CanUseSusanoo>3)
			src<<output("<b><font color=red>You can only use Sage Mode three times per round!","Chat")
			return
		if(Guardian || dead==1||Sage==1||GoingSage==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(Boss || Tournament_GoingOn) return
		if(!on_ground)
			return
		var/Facing = dir
		Speed_Multiplier_X = speed_multiplier
		src.Dodging = 0
		src.speed_multiplier = 0
		src.move_speed = 0
		src.Check_Icon = 0
		src.stop()
		src<<"<font color=yellow><b><u>You begin focusing natural energy...</u></font>"
		GoingSage=1
		icon_state="mob-sage"
		spawn(rand(175, 200))
			src.speed_multiplier = Speed_Multiplier_X
			src.Check_Icon = 1
			src.Attacking = 0
			if(GoingSage==1)
				CanUseSusanoo += 1
				NEM_Round.Shout("<font size=2><font color=#FE9A2E><u>- Jiraiya has transformed into Sage Mode! -</u>")
				var/A=new/obj/GroundSmash(src.loc)
				if(src.dir==WEST)
					A:pixel_x-=15
				if(src.dir==EAST)
					A:pixel_x-=10
				Sage=1
				GoingSage=0
				Str=15
				move_speed=10
				MaxHP=150
				HP=150
				MaxCha=165
				Counting = rand(1,500)
				var/Current_Counting = Counting
				Cha=150
				ultra_speed = 1
				Def=7.5
				src.icon = 'Graphics/Characters/Sage Jiraiya.dmi'
				name = "Sage Jiraiya"
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				src.dir = Facing
				Transformed = 1
				Transform_Proc(300, "Sage Mode", "#FE9A2E")
				spawn(3000)
					if(Sage == 1 && Counting == Current_Counting)
						if(freeze)
							loop
								sleep(30)
								if(Sage == 1 && freeze) goto loop
						Transformed = 0
						Attacking=0
						NEM_Round.Shout("<font size=2><font color=#FE9A2E><u>- Jiraiya's Sage Mode has run out! -</u>")
						Sage = 0
						src.icon = 'Graphics/Characters/Jiraiya.dmi'
						Str=15
						Def=7.5
						MaxHP=125
						MaxCha=150
						MaxEnergy=150
						name = "Jiraiya"
						ultra_speed = 0
						src.Check_Jutsu()
						src.Run_Off()
						src.stop()
	Drop_Cloak()
		Flick("mob-shooting", src)
		freeze ++
		Dragonned = 1
		spawn(7.5)
			NEM_Round.Shout("<font size=2><font color=#2ECCFA><u>- Kisame has dropped his cloak! -</u>")
			src.icon = 'Graphics/Characters/Kisame Uncloak.dmi'
			Flick("mob-seals", src)
			CanUseGates = 0
			speed_multiplier *= 1.15
			Str = 13.25
			Def = 7.25
			MaxEnergy = 150
			MaxCha = 125
			MaxHP = 140
			HP = MaxHP
			Cha = MaxCha
			Energy = MaxEnergy
			name = "(UnCloaked) Kisame"
			src.Check_Jutsu()
			src.Run_Off()
			spawn(4)
				Dragonned = 0
				freeze --
				stop()
	Drop_Shirt()
		Flick("mob-shooting", src)
		freeze ++
		Dragonned = 1
		spawn(7.5)
			NEM_Round.Shout("<font size=2><font color=#2ECCFA><u>- Madara has removed his shirt! -</u>")
			src.icon = 'Graphics/Characters/Lord Madara.dmi'
			Flick("mob-shooting", src)
			CanUseGates = 0
			speed_multiplier *= 1.15
			Str = 13.25
			Def = 7.25
			MaxEnergy = 150
			MaxCha = 150
			MaxHP = 140
			HP = MaxHP
			Cha = MaxCha
			Energy = MaxEnergy
			name = "Lord Madara"
			src.Check_Jutsu()
			src.Run_Off()
			spawn(4)
				Dragonned = 0
				freeze --
				stop()
	Gates()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Arena") return
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(CanUseGates == 0)
			src<<output("<b><font color=red>You can't open gates anymore!","Chat")
			return
		if(!on_ground) return
		if(Boss == 1) return
		if(Guardian == 1) return
		if(Tournament_GoingOn == 1)
			src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return
		var/Real_Name = name
		if(client)
			if(alert(src, "Are you sure? This'll reset your lives to zero.", "Deadly Skill", "No", "Yes") == "Yes")
				if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
				if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
				if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
				if(Boss==1|| dead==1||Gates==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1||Real_Name != name)return
				if(CanUseGates == 0)
					src<<output("<b><font color=red>You can't open gates anymore!","Chat")
					return
				if(!on_ground) return

				new/obj/Effects/Rock_Lee_Gates (loc, src)
				freeze ++
				Dragonned = 1
				spawn(5)
					NEM_Round.Shout("<font size=2><font color=green><u>- Rock Lee has Opened Gates! -</u>")
					Deaths = 3
					src.icon = 'Graphics/Characters/Rock Lee Gates.dmi'
					CanUseGates = 0
					speed_multiplier *= 1.30
					ultra_speed = 2
					Str = 15.25
					Def = 8
					MaxEnergy = 200
					MaxCha = 125
					MaxHP = 175
					HP = MaxHP
					Cha = MaxCha
					Energy = MaxEnergy
					name= "(Opened Gates) Rock Lee"
					src.Check_Jutsu()
					src.Run_Off()
	MightGates()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Arena") return
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Tournament_GoingOn == 1)
			src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return
		if(Gates) return
		if(Guardian == 1) return
		if(Boss == 1) return
		var/Real_Name = name
		if(client)
			if(alert(src, "Are you sure? You won't be able to return into your normal form, and this'll kill you.", "Deadly Skill", "No", "Yes") == "Yes")
				if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
				if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
				if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
				if(Boss==1||dead==1||Gates==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1||Real_Name != name)return
				if(CanUseGates==0)
					src<<output("<b><font color=red>You can't open gates anymore!","Chat")
					return
				if(!on_ground)
					return

				Flick("gates",src)
				NEM_Round.Shout("<font size=2><font color=green><u>- Might Gai has Opened Gates! -</u>")
				Deaths=3
				src.icon = 'Graphics/Characters/Gates2.dmi'
				CanUseGates=0
				Dragonned = 1
				Gates=1
				MaxHP*=1.75
				HP=MaxHP
				speed_multiplier = 20
				name= "(Opened Gates) Might Gai"
				MaxEnergy=1000000000000
				Energy=1000000000000
				Transformed = 1
				Transform_Proc(180, "Gates", "green")
				spawn(1800)
					if(src.Gates==1)
						Transformed = 0
						src.HP=0
						src.Dragonned = 1
						src.Death_Check("Gates' Effects")
	Hiruko_Summon()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Arena") return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Tournament_GoingOn == 1)
			src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return
		if(Guardian || Boss) return
		var/Real_Name = name
		if(client)
			if(alert(src, "Are you sure? You won't be able to return into your normal form, and you'll be on your last life after summoning Hiruko.", "Deadly Skill", "No", "Yes") == "Yes")
				if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
				if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
				if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
				if(name == "Hiruko") return
				if(dead==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1||Real_Name != name)return
				if(CanUseGates==0) return
				if(!on_ground) return
				if(Controlling>=1)
					for(var/mob/Puppet/M)
						del(M)
						return
					for(var/mob/PuppetX/M)
						del(M)
						CanUseGates=0
						sleep(10)
						if(Controlling>=1)
							CanUseGates = 1
							src<<output("<b><font color=red>Stop controlling the Puppet first!","Chat")
							return

				NEM_Round.Shout("<font size=2><font color=#800517><u>- Sasori has summoned Hiruko! -</u>")
				Deaths = 3
				src.icon = 'Graphics/Characters/Hiruko.dmi'
				MaxHP = 225
				HP = 225
				Str = 15
				Def = 8
				speed_multiplier = 1.15
				name = "Hiruko"
				MaxEnergy = 200
				Energy = 200
				MaxCha = 100
				Cha = 100
				src.Check_Jutsu()
				src.Run_Off()
				src.stop()
				if(Controlling>=1)
					for(var/mob/Puppet/M)
						del(M)
						return
					for(var/mob/PuppetX/M)
						del(M)

	Susanoo()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Arena") return
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		for(var/obj/Jutsus/Susanoo_Sasuke/S in src) if(S.Delay) return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(src.immortal == 1) return
		if(Boss_Mode == 1)
			src<<output("<b><font color=red>You can't use this jutsu on Juggernaut Mode!","Chat")
			return
		if(Tournament_GoingOn == 1)
			src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return
		var/Real_Name = name
		if(Boss) return
		var/Round = Spawn
		if(client)
			if(alert(src, "Are you sure? You won't be able to return into your normal form, and this'll kill you after some minutes.", "Deadly Skill", "No", "Yes") == "Yes")
				if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
				if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
				if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
				if(dead==1||Susanoo==1||GoingSusanoo==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1||Real_Name != name)return
				for(var/obj/Jutsus/Susanoo_Itachi/S in src) if(S.Delay) return
				if(!on_ground)
					return
				if(CanUseSusanoo>=1)
					src<<output("<b>You can't use Susanoo anymore!</b>","Chat")
					return
				if(Sharingan==1)
					src<<"<b><font color=red>Deactivate Sharingan first!</b>"
					return
				var/Facing = dir
				Speed_Multiplier_X = speed_multiplier
				src.Dodging = 0
				src.speed_multiplier = 0
				src.move_speed = 0
				src.Check_Icon = 0
				src.layer = 149
				src.stop()
				src<<"<font color=#8A0886><b>You start feeling stronger..."
				GoingSusanoo = 1
				GoingSage = 1
				icon_state="mob-shooting"
				spawn(300)
					src.speed_multiplier = Speed_Multiplier_X
					src.Check_Icon = 1
					src.Attacking = 0
					if(GoingSage == 1 && GoingSusanoo == 1 && name != "(Curse Seal) Sasuke")
						src.CanUseSusanoo+=1
						NEM_Round.Shout("<font size=2><font color=#8A0886><u>- Sasuke has transformed into Susanoo! -</u>")
						Susanoo = 1
						name = "Susanoo"
						src.Crow = 0
						GoingSusanoo = 0
						GoingSage = 0
						Str = 300
						Sharingan = 0
						move_speed = 0.85
						MaxHP = 100000
						pwidth = 174
						layer = 105
						ultra_speed = 0.5
						HP = 100000
						MaxCha = 250
						Dragonned = 1
						Cha = 250
						Def = 100000
						src.icon = 'Graphics/Skills/Susanoo2.dmi'
						src.Check_Jutsu()
						src.Run_Off()
						src.stop()
						src.dir = Facing
						var/Time_ = rand(150, 250)
						Transformed = 1
						Transform_Proc(Time_, "Susanoo", "#8A0886")
						spawn(Time_*10)
							if(Round != Spawn || name != "Susanoo") return
							Deaths=3
							Transformed = 0
							Dragonned = 0
							if(!dead && !knocked) src.HP=-1
							if(!dead && !knocked) src<<"<font color=#8A0886><b>You've died by Susanoo's effects..."
							if(!dead && !knocked) src.Susanoo=0
							if(!dead && !knocked) src.Str=10
							if(!dead && !knocked) src.Dragonned=0
							if(!dead && !knocked) src.Def=5
							if(!dead && !knocked) src.pwidth = 32
							if(!dead && !knocked) src.MaxHP=100
							if(!dead && !knocked) src.MaxCha=100
							if(!dead && !knocked) src.MaxEnergy=100
							layer = 100
							src.name = "Sasuke"
							src.ultra_speed = 0
							src.icon = 'Graphics/Characters/Sasuke.dmi'
							src.Check_Jutsu()
							src.Run_Off()
							src.stop()
							if(!dead && !knocked) src.Death_Check("Susanoo's Effects")
	Itachi_Susanoo()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Arena") return
		if(CTD) return
		for(var/obj/Jutsus/Susanoo_Itachi/S in src) if(S.Delay) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(src.immortal == 1) return
		if(Boss_Mode == 1)
			src<<output("<b><font color=red>You can't use this jutsu on Juggernaut Mode!","Chat")
			return
		if(Tournament_GoingOn == 1)
			src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return
		var/Real_Name = name
		if(Boss || Tournament_GoingOn) return
		var/Round = Spawn
		if(client)
			if(alert(src, "Are you sure? You won't be able to return into your normal form, and this'll kill you after some minutes.", "Deadly Skill", "No", "Yes") == "Yes")
				if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
				if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
				if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
				if(dead==1||Susanoo==1||GoingSusanoo==1||knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1||Real_Name != name)return
				for(var/obj/Jutsus/Susanoo_Itachi/S in src) if(S.Delay) return
				if(!on_ground)
					return
				if(Sharingan==1)
					src<<"<b><font color=red>Deactivate Sharingan first!</b>"
					return
				if(CanUseSusanoo>=1)
					src<<output("<b>You can't use Susanoo anymore!</b>","Chat")
					return
				var/Facing = dir
				Speed_Multiplier_X = speed_multiplier
				src.Dodging = 0
				src.speed_multiplier = 0
				src.move_speed = 0
				src.Check_Icon = 0
				src.stop()
				src<<"<font color=#8A0886><b>You start feeling stronger..."
				GoingSusanoo = 1
				GoingSage = 1
				icon_state="mob-shooting"
				spawn(300)
					src.speed_multiplier = Speed_Multiplier_X
					src.Check_Icon = 1
					src.Attacking = 0
					if(GoingSusanoo==1)
						src.CanUseSusanoo+=1
						NEM_Round.Shout("<font size=2><font color=#8A0886><u>- Itachi has transformed into Susanoo! -</u>")
						Susanoo = 1
						GoingSusanoo = 0
						GoingSage = 0
						Str = 300
						move_speed = 0.85
						pwidth = 174
						MaxHP = 100000
						ultra_speed = 0.5
						Sharingan = 0
						HP = 100000
						MaxCha = 250
						Dragonned = 1
						Cha = 250
						layer = 149
						Def = 100000
						name = "Itachi Susanoo"
						src.icon = 'Graphics/Skills/Susanoo.dmi'
						src.Check_Jutsu()
						src.Run_Off()
						src.stop()
						src.dir = Facing
						var/Time_ = rand(250,350)
						Transform_Proc(Time_, "Susanoo", "#8A0886")
						spawn(Time_*10)
							if(Round != Spawn || name != "Itachi Susanoo") return
							Transformed = 0
							Deaths=3
							Dragonned = 0
							if(Round != Spawn) return
							if(!dead && !knocked)
								Deaths=3
								src.HP=-1
								Dragonned = 0
								src<<"<font color=#8A0886><b>You've died by Susanoo's effects..."
								src.Susanoo=0
								src.Str=10
								src.Dragonned=0
								src.Def=5
								src.pwidth = 32
								src.MaxHP=100
								src.MaxCha=100
								src.MaxEnergy=100
								src.freeze=1
							layer = 100
							src.name = "Itachi"
							ultra_speed = 0
							src.icon = 'Graphics/Characters/Itachi.dmi'
							src.Check_Jutsu()
							src.Run_Off()
							src.stop()
							if(!dead && !knocked) src.Death_Check("Susanoo's Effects")

	Control_Kamui()
		if(src.NEM_Round.Mode == "Arena") return
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			src<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		var/mob/A
		if(Kamui == 1) A= input(src, "What would you like to do?", "Control Kamui") in list ("Leave Dimension")
		if(Kamui == 0) A= input(src, "What would you like to do?", "Control Kamui") in list ("Nullify Kamui", "Teleport To Dimension")
		if(A == "Nullify Kamui")
			if(Kamui == 1 || knockback == 1 || freeze || Controlling >= 1 || Attacking == 1 || knocked == 1) return
			var/list/choose=list()
			for(var/mob/M in RT) if(M != src) choose.Add(M)
			var/mob/M=input("Who would you like to free?", "Nullify Kamui") as null|anything in choose
			if(knockback == 1 || freeze || Controlling >= 1 || Attacking == 1 || knocked == 1)return
			if(!M || M.Kamui == 0)
				return
			if(src.Cha < 25)
				Cooldown_Display (25)
				return
			Cha -= 25
			M<<"<b><font color=#710093><u><font size=2>* [src.name] has teleported you back! *</u></font>"
			src<<"<b><font color=#710093><u><font size=2>* You have freed [M.name]! *</u></font>"
			NEM_Round.Shout("<b><font color=#710093><u>[src.name] has nullified [M.name]'s Kamui!</u>")
			if(M == src)
				stop()
				freeze ++
				spawn(5) freeze --
			RT.Remove(M)
			M.loc = src.loc
			M.vel_y += 10
			if(dir == WEST) M.knockbackwest()
			if(dir == EAST) M.knockbackeast()
			M.Kamui = 0
			M.CanBeRevived=1
		if(A == "Teleport To Dimension" || A == "Leave Dimension")
			if(knockback == 1 || freeze || Controlling >= 1 || Attacking == 1 || knocked == 1)return
			Flick("Teleport", src)
			src.Dragonned = 1
			src.freeze ++
			var/P = new/obj/Portal (src.loc)
			P:dir = src.dir
			spawn(3.30)
				src.Dragonned = 0
				src.freeze --
				src.stop()
				if(Kamui == 1)
					RT.Remove(src)
					var/N = new/obj/Portal (Remembered_Location)
					N:dir = src.dir
					src.Kamui = 0
					src.loc = Remembered_Location
					return
				if(Kamui == 0)
					if(src.Cha < 25)
						Cooldown_Display (25)
						return
					RT.Add(src)
					src.Kamui = 1
					src.Remembered_Location = src.loc
					for(var/obj/Tobi/T in world)
						var/N = new/obj/Portal (T.loc)
						src.loc = T.loc
						if(dir == EAST)
							N:dir = WEST
							src.x--
						if(dir == WEST)
							N:dir = EAST
							src.x++

	Release_Soul()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			src<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(src.Cha < 25)
			Cooldown_Display (25)
			return
		var/list/choose=list()
		for(var/mob/M)
			if(M.Absorbed == 1) choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Which soul do you want to release?", "Release Soul") as null|anything in choose
		if(M=="Cancel"||M==cancel||!M)
			PeinCD=0
			return
		if(src.Cha < 25)
			Cooldown_Display (25)
			return
		if(M.Absorbed == 0) return
		PeinCD = 0
		Cha -= 25
		M<<output("<b><font color=#7C0101><u><font size=2><center>* Your soul has been released, you can now be revived *</center></u></font>","Chat")
		NEM_Round.Shout("<b><font color=#7C0101><u>[M.name]'s Soul has been released by [src.name]!</u>")
		M.loc = loc
		M.x += rand(-3,3)
		M.check_loc()
		M.freeze = 100
		M.Absorbed = 0
		M.CanBeRevived = 1
		M.layer = 100
		M.Checked_X = 1
		M.Teleport_(src)
		if(!M.Moving) M.Movement()
		M.Go_Dead()
		if(M.client)
			M.client.perspective = MOB_PERSPECTIVE
			M.client.eye = M



	Absorb_Soul()
		if(NEM_Round.Type == "King Of The Hill") {src<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Mind_Controlling)
			src<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Capture_The_Flag == 1)
			src<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			src<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		var/T = 0
		for(var/mob/M)
			if(M.Absorbed) T++
		if(T >= 5)
			src<<"<b><font color=red><u>You can not have more than 5 souls in Benihisago, release one!</u></font>"
			return
		if(src.Cha < 50)
			Cooldown_Display (50)
			return
		if(knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(!on_ground) return
		src.freeze ++
		src.stop()
		var/Old_HP = HP
		vel_y=0
		vel_x=0
		src.Cha-=50
		Flick("Absorb",src)
		spawn(15)
			Flick("teleport", src)
			src.freeze --
			src.stop()
		for(var/mob/M in src.loc)
			if(M.dead==1&&M.Village!=src.Village)
				spawn(10)
					if(HP < Old_HP)
						src<<output("<br><b><font color=red>You've been interrupted while attempting to absorb [M.name]'s Soul!<br>","Chat")
						src.stop()
						vel_y=0
						vel_x=0
						return
					if(M.dead==0) return
					M<<output("<b><font color=#7C0101><u><font size=2><center>* Your soul has been absorbed, in order to get free Ginkaku must die *</u></center></font>","Chat")
					M.layer = 0
					M.Absorbed = 1
					M.Checked_X = 0
					M.CanBeRevived = 0
					M.loc = locate(0,0,0)
					if(M.client)
						M.client:perspective = EYE_PERSPECTIVE
						M.client:eye = src
					NEM_Round.Shout("<b><font color=#7C0101><u>[M.name]'s Soul has been absorbed by [src.name]!</u>")
obj/proc
	Destroy_Soul()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Delay || Executor.Levitating || Executor.knocked || Executor.freeze || Executor.Attacking || Executor.Controlling) return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(Executor.Cha < 100)
			Executor.Cooldown_Display (100)
			return
		if(!Executor.on_ground) return
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.stop()
		spawn(5)
			Executor.CanMove = 1
			Executor.freeze --
			Executor.pixel_y = 0
		Executor.pixel_y = -10
		Flick("Summon", Executor)
		var/obj/K = new/obj/SakuraCherry
		K.dir = Executor.dir
		K.loc = Executor.loc
		K.step_x = Executor.step_x
		K.step_y = Executor.step_y
		step(K,Executor.dir,16)
		spawn(3) del(K)
		for(var/mob/M in bounds(K,0))
			if(M == Executor || !M.dead || !M.Real || M.Village == Executor.Village || M.Dragonned) continue
			if(M.CanBeRevived && M.dead && M.Village != Executor.Village)
				spawn(3)
					if(!M.dead)
						Executor.pixel_y = 0
						Flick("teleport", Executor)
						return
					if(Delay || Executor.Levitating || Executor.knocked || Executor.Attacking || Executor.Controlling) return
					if(Executor.Cha < 100)
						Executor.Cooldown_Display (100)
						return
					Delay(300)
					Executor.Cha -= 100
					Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Ningendo Path: Soul Removal!")
					Executor.NEM_Round.Shout("<b><font color=#4E387E><u><font size=2>Chikushodo: This is the power of a God!</u>")
					var/Pein = new/obj/Absorb_Soul (M.loc)
					spawn(2.5)
						Flick("hurt", M)
						M.icon_state = "hurt"
						spawn(1.5) M.layer = 0
					if(Executor.dir == EAST)
						Pein:dir = WEST
						Pein:x += 1
					if(Executor.dir == WEST)
						Pein:dir = EAST
						Pein:x -= 1
					sleep(8)
					Executor.NEM_Round.Shout("<u><b><font color=#CC0000>[M.name]'s Soul has been ripped asunder!</u>")
					M.Respawn(1)
					M.CanChoose = 0
					if(M.client)
						M.client:perspective = EYE_PERSPECTIVE
						M.client:eye = Executor
					return
	Revive()
		if(Boss_Mode_  || Next_Mode == "Reboot Now") return
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		src.Capture_The_Flag = 1
		src.Boss_Mode = 1
		if(CTD) return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.Can_Revive == 0)
			Executor<<"<b><font color=red><u>You died before, you can't revive anymore.</u></font>"
			return
		if(Executor.Revived_T >= 5)
			Executor<<"<b><font color=red><u>You've already revived 5 ninjas, you can't use this jutsu anymore!</u></font>"
			return
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.freeze ++
		var/Old_HP = Executor.HP
		Executor.Reviving = 1
		Executor.stop()
		Flick("heal2", Executor)
		spawn(20)
			Executor.Reviving = 0
			Executor.freeze --
			Executor.stop()
		var/Revived_ = 0
		for(var/mob/M in Executor.loc)
			if(M.client && M.CanBeRevived && M.dead && M.Village == Executor.Village)
				spawn(10)
					if(Executor.Revived_T >= 5) continue
					if(Executor.HP < Old_HP)
						Executor<<output("<br><b><font color=red>You've been interrupted while attempting to revive [M.name]!<br>","Chat")
						Executor.stop()
						return
					if(!M.dead) return
					if(M.Village == Executor.Village && !Revived_)
						Delay(30)
						Revived_++
						Executor.Revived_T++
						var/Check = 5 - Executor.Revived_T
						if(Check >= 2) Executor<<"<b><font color=red><u>You have [Check] revives left</u></font>"
						if(Check == 1) Executor<<"<b><font color=red><u>You have [Check] revive left</u></font>"
						if(Check == 0) Executor<<"<b><font color=red><u>You can no longer revive</u></font>"
						M.knocked = 0
						M.Energy = M.MaxEnergy
						M.Cha = M.MaxCha
						M.HP = M.MaxHP
						M.freeze = 0
						M.stop()
						M.knocked = 0
						M.density = 1
						M.dead = 0
						M.CanUseGates = 0
						M.CanGoKyuubi = 0
						M.CanGoCS = 0
						M.client:perspective = EYE_PERSPECTIVE//this sets the client perspective to the usr eye, making the eye not go black if out of range.
						M.client:eye = M// it will set your eye to who you look at
						M.verbs-=typesof(/mob/Dead/verb)
						M.icon_state="mob-standing"
						M.set_state()
						M.stop()
						M.Run_Off()
						if(!M.Moving) M.Movement()
						if(M.Healer_Character == 1)
							if(M.Village == "Leaf") Healers_Leaf ++
							if(M.Village == "Akatsuki") Healers_Akatsuki ++
						Executor.NEM_Round.Shout("<b><font color=#4BFF4B><u>[M.name] has been revived by [Executor.name]!</u>")
						M.NEM_Side.Ninjas ++


	Tsukuyomi_()
		var/list/_Enemies = list()
		var/Enemies
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 125) == 0) return
		for(var/obj/Jutsus/Amaterasu_Wildfire/J in Executor) J.Delay(15)
		for(var/obj/Jutsus/Amaterasu_AOE/J in Executor) J.Delay(20)
		var/_Done_ = 0
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Hand-Seals", Executor)
		sleep(6)

		Executor.Dragonned = 0
		Executor.freeze --
		Executor.stop()

		if(!Executor.knocked)
			Executor.Execute_Jutsu("Tsukuyomi no Mikoto!")
			for(var/mob/M in view(15))
				if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && M.Village != Executor.Village && !M.Dragonned && M.client)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					else
						_Done_ ++
						if(_Done_ == 1) Delay(90)
						Executor.Executed_Fully = 1
						Enemies ++
						_Enemies.Add(M)

			if(!_Done_) Delay(30)

			if(Enemies)
				Itachi_Illusion(Executor)
				for(var/mob/M in _Enemies) spawn() M.Itachi_Illusion_Self()


	Sawarbi_No_Mai_K()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(15)
		for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(5)
		Flick("Kimimaro", Executor)
		Executor.freeze ++
		Executor.stop()
		var/_Target_
		spawn(11)
			Executor.freeze --
			Executor.stop()

		sleep(6)
		if(!Executor.knocked)
			Executor.Execute_Jutsu("Sawarbi No Mai!")
			for(var/mob/M in view(15))
				if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && M.Village != Executor.Village && !M.Dragonned)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					else
						_Target_ ++
						M.freeze ++
						new/obj/Spike (M)
						spawn(1.75)
							M.freeze --
							var/Damage = 20+rand(5, 20)
							M.vel_y = 10
							M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 1, 1)
			if(_Target_) Executor.Damage_Up(20+rand(5, 20))


	Summon_Sharks()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(17)
		for(var/obj/Jutsus/Water_Prison_Kisame/J in Executor) J.Delay(7)
		Executor.freeze ++
		Executor.stop()
		Flick("mob-seals", Executor)
		var/_Target_
		spawn(0.5)
			Executor.freeze --
			Executor.stop()
		sleep(3.5)
		if(!Executor.knocked)
			Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Sharks!")
			for(var/mob/M in view(13))
				if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && M.Village != Executor.Village && !M.Dragonned)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					else
						_Target_ ++
						M.freeze ++
						if(Executor.px <= M.px) M.dir = WEST
						else M.dir = EAST
						new/obj/Effects/Mini_Shark (M.loc, M)
						spawn(3)
							M.freeze --
							var/Damage = 30+rand(5, 15)
							M.vel_y = 5
							M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 1, 1)
			if(_Target_) Executor.Damage_Up(30+rand(5, 15))


	Sawarbi_No_Mai()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(17)
		for(var/obj/Jutsus/Tessenka/J in Executor) J.Delay(7)
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		new/obj/Special_Effect/Sawarbi (Executor)
		var/_Target_
		sleep(7.3)
		if(!Executor.knocked)
			Executor.Execute_Jutsu("Sawarbi No Mai!")
			for(var/mob/M in view(13))
				if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && M != Executor && !M.knocked && M.Village != Executor.Village && !M.Dragonned)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					else
						_Target_ ++
						M.freeze ++
						new/obj/Spike (M)
						spawn(1.75)
							M.freeze --
							var/Damage = 30+rand(5, 35)
							M.vel_y = 10
							M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 1, 1)
			if(_Target_) Executor.Damage_Up(30+rand(5, 35))

	Kirigakure_Jutsu()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(30)
		Executor.freeze ++
		Executor.stop()
		spawn(8)
			Executor.freeze --
			Executor.stop()

		Flick("rage1", Executor)

		spawn(4.5)
			Executor.Execute_Jutsu("Kirigakure No Jutsu!")
			for(var/mob/M in view(15))
				if(M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Dragonned)
					M<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Mist()

	Earth_Eruption()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		for(var/obj/Jutsus/Chakra_Rush/P in Executor.Jutsus) P.Delay(5)
		Delay(10)
		Executor.freeze ++
		Executor.stop()
		spawn(7.5)
			Executor.freeze --
			Executor.stop()

		if(Executor.name == "Karin")
			Flick("Smash", Executor)

			Executor.Execute_Jutsu("Earth Eruption!")
			spawn(1.5)
				var/A=new/obj/GroundSmash(Executor.loc)
				if(Executor.dir == WEST) A:pixel_x -= 25
				for(var/mob/M in view(5))
					if(M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Dragonned)
						if(M.Dodging == 0)
							var/Damage = 25+rand(0,10)
							M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 0, 1)
							M.Quake_Effect(10)
							M.vel_y = 10
							if(M.px > Executor.px) M.knockbackeast()
							if(M.px < Executor.px) M.knockbackwest()
							if(M.px == Executor.px)
								if(Executor.dir == EAST) M.knockbackeast()
								if(Executor.dir == WEST) M.knockbackwest()
						if(M.Dodging == 1)
							M.Auto_Dodge (Executor)
							Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"

	Hakke_Juushou()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10)
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Hakke Juushou!")
		new/obj/Effects/Hanabi_Special_III (Executor.loc, Executor)

		spawn(5)
			for(var/mob/M in view(7))
				if(M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Dragonned)
					if(M.Dodging == 0)
						var/Damage = 25+rand(0, 10)
						M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 0, 1)
						M.Quake_Effect(10)
						M.vel_y = 10
						if(M.px > Executor.px) M.knockbackeast()
						if(M.px < Executor.px) M.knockbackwest()
						if(M.px == Executor.px)
							if(Executor.dir == EAST) M.knockbackeast()
							if(Executor.dir == WEST) M.knockbackwest()
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"

	Cherry_Blossom_Groundsmash()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10)
		for(var/obj/Jutsus/Sakura_Inner_Rage/P in Executor.Jutsus) P.Delay(7)
		for(var/obj/Jutsus/Cherry_Blossom_Impact_Sakura/P in Executor.Jutsus) P.Delay(7)
		for(var/obj/Jutsus/Cherry_Blossom_Impact_Tsunade/P in Executor.Jutsus) P.Delay(7)
		Executor.freeze ++
		Executor.stop()
		spawn(20)
			Executor.freeze --
			Executor.stop()

		if(Executor.name == "Sakura")
			Flick("smash", Executor)

			Executor.Execute_Jutsu("Cherry Blossom Groundsmash!")
			spawn(3)
				var/A=new/obj/GroundSmash(Executor.loc)
				if(Executor.dir==WEST) A:pixel_x -= 25
				for(var/mob/M in view(5))
					if(M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Dragonned)
						if(M.Dodging == 0)
							var/Damage = 25+rand(0,10)
							M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 0, 1)
							M.Quake_Effect(10)
							M.vel_y = 10
							if(M.px > Executor.px) M.knockbackeast()
							if(M.px < Executor.px) M.knockbackwest()
							if(M.px == Executor.px)
								if(Executor.dir == EAST) M.knockbackeast()
								if(Executor.dir == WEST) M.knockbackwest()
						if(M.Dodging == 1)
							M.Auto_Dodge (Executor)
							Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
		if(Executor.name == "Tsunade")
			Flick("Smash", Executor)
			Executor.Execute_Jutsu("Cherry Blossom Groundsmash!")
			spawn(7.5)
				var/A=new/obj/GroundSmash(Executor.loc)
				if(Executor.dir==WEST) A:pixel_x -= 25
				for(var/mob/M in view(5))
					if(M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Dragonned)
						if(M.Dodging == 0)
							var/Damage = 25+rand(5, 10)
							M.Damage(Executor, Damage, 1, 0)
							M.Quake_Effect(10)
							M.vel_y = 10
							if(M.px > Executor.px) M.knockbackeast()
							if(M.px < Executor.px) M.knockbackwest()
							if(M.px == Executor.px)
								if(Executor.dir == EAST) M.knockbackeast()
								if(Executor.dir == WEST) M.knockbackwest()
						if(M.Dodging == 1)
							M.Auto_Dodge (Executor)
							Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
	Sharingan_CD()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, Executor.MaxCha/2) == 0) return
		var/_FE_
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		spawn(1)
			Executor.freeze --
			Executor.stop()
		for(var/mob/M in view(15))
			if(M.Dodging == 0)

				if(M != Executor)
					_FE_ ++
					new/obj/Effects/Meele_Hit (M.loc, M)
					Executor.Executed_Fully = 1

				if(_FE_ == 1) Delay(30)
				for(var/obj/Jutsus/J in M) J.Delay(7)
			if(M.Dodging == 1)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
		spawn() if(!_FE_) Delay(15)

	Earth_Smash()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10)
		Executor.freeze ++
		Executor.stop()
		if(Executor.name != "Tsuchikage") Flick("earth", Executor)
		if(Executor.name == "Tsuchikage") Flick("mob-shooting",  Executor)
		sleep(7.5)
		var/A=new/obj/GroundSmash(Executor.loc)
		if(Executor.dir==WEST) A:pixel_x -= 15
		if(Executor.dir==EAST) A:pixel_x -= 10
		spawn(2.5)
			Flick("teleport", Executor)
			Executor.freeze --
			Executor.stop()
		Executor.Execute_Jutsu("Earth Smash!")
		for(var/mob/M in view(5))
			if(M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Dragonned)
				if(M.Dodging == 0)
					var/Damage = 25+rand(0,10)
					M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 0, 1)
					M.vel_y=5+rand(1,5)
					if(M.px > Executor.px) M.knockbackeast()
					if(M.px < Executor.px) M.knockbackwest()
					if(M.px == Executor.px)
						if(Executor.dir == EAST) M.knockbackeast()
						if(Executor.dir == WEST) M.knockbackwest()
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
	Expand()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 38) == 0) return
		Delay(7)
		Executor.freeze ++
		Executor.stop()
		Flick("expand", Executor)
		var/A=new/obj/GroundSmash(Executor.loc)
		if(Executor.dir == WEST) A:pixel_x-=25
		spawn(10)
			Flick("teleport", Executor)
			Executor.freeze --
			Executor.stop()
		for(var/mob/M in view(5))
			if(M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Dragonned)
				if(M.Dodging == 0)
					var/Damage = 35+rand(0,5)
					M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 0, 1)
					if(M.px > Executor.px) M.knockbackeast()
					if(M.px < Executor.px) M.knockbackwest()
					if(M.px == Executor.px)
						if(Executor.dir == EAST) M.knockbackeast()
						if(Executor.dir == WEST) M.knockbackwest()
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
	Hair_Needles()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(10)
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("mane", Executor)
		Executor.Execute_Jutsu("Hair Needles!")
		for(var/mob/M in view(2))
			if(M.Village != Executor.Village && !M.Dragonned && !M.dead && !M.knocked && M.Real)
				if(M.Dodging == 0)
					var/Damage = 15+rand(10,25)
					M.Damage(Executor, Damage, 1, 0)
					if(M.px > Executor.px) M.knockbackeast()
					if(M.px < Executor.px) M.knockbackwest()
					if(M.px == Executor.px)
						if(Executor.dir == EAST) M.knockbackeast()
						if(Executor.dir == WEST) M.knockbackwest()
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
		spawn(25)
			Flick("mane2", Executor)
			spawn(6.5)
				Executor.stop()
				Executor.freeze --
				Executor.Dragonned = 0

	Amaterasu_Wildfire()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(30)
		for(var/obj/Jutsus/Tsukuyomi_/J in Executor) J.Delay(13)
		for(var/obj/Jutsus/Amaterasu_AOE/J in Executor) J.Delay(13)
		Executor.freeze ++
		Executor.stop()
		Flick("Hand-Seals", Executor)
		sleep(6)
		Executor.freeze --
		Executor.Execute_Jutsu("Amaterasu Wildfire!")
		var/A=new/obj/Amaterasu_Wildfire(Executor.loc)
		A:x += 3
		A:dir = EAST
		A:Village = Executor.Village
		A:Owner = Executor
		var/A1=new/obj/Amaterasu_Wildfire(Executor.loc)
		A1:x -= 3
		A1:Village = Executor.Village
		A1:Owner = Executor
		A1:dir = WEST
		var/A2=new/obj/Amaterasu_Wildfire(Executor.loc)
		A2:Village = Executor.Village
		A2:Owner = Executor
		A2:dir = Executor.dir
		var/A3=new/obj/Amaterasu_Wildfire(Executor.loc)
		A3:x+=7
		A3:dir = EAST
		A3:Village = Executor.Village
		A3:Owner = Executor
		var/A4=new/obj/Amaterasu_Wildfire(Executor.loc)
		A4:x-=7
		A4:dir = WEST
		A4:Village = Executor.Village
		A4:Owner = Executor

	Inferno()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 100) == 0) return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		Delay(30)
		Executor.freeze ++
		Executor.stop()
		Flick("Rain", Executor)
		sleep(10)
		Executor.freeze --
		Executor.Execute_Jutsu("Inferno!")
		var/A=new/obj/Huge_Fire(Executor.loc)
		A:x+=3
		A:Village = Executor.Village
		A:Owner = Executor
		var/A1=new/obj/Huge_Fire(Executor.loc)
		A1:x-=3
		A1:Village = Executor.Village
		A1:Owner = Executor
		var/A2=new/obj/Huge_Fire(Executor.loc)
		A2:Village = Executor.Village
		A2:Owner = Executor
		var/A3=new/obj/Huge_Fire(Executor.loc)
		A3:x+=7
		A3:Village = Executor.Village
		A3:Owner = Executor
		var/A4=new/obj/Huge_Fire(Executor.loc)
		A4:x-=7
		A4:Village = Executor.Village
		A4:Owner = Executor

	Ice_Shield()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		src.On_Ground = 1
		if(Executor.Using_Sand_Shield)
			for(var/obj/Effects/Tobirama_Shield/T in Executor.Overlays) del(T)
			Executor.Using_Sand_Shield = 0
			Executor.Special_ = 0
			sleep(2)
			Executor<<output("<b><font color=#3EFFFA><u>You have stopped using Ice Shield.</u>","Chat")
			Executor.Icon_State = null
			Executor.Dragonned = 0
			Executor.freeze --
			Executor.stop()

		if(Executor.Can_Execute(src, 10) == 0) return
		Delay(15)
		new/obj/Effects/Tobirama_Shield (Executor.loc, Executor)
		Executor.stop()
		Executor.Icon_State = "Shield"
		Flick("Shield", Executor)
		Executor.Using_Sand_Shield = 1
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.Execute_Jutsu("Ice Release.- Shield!")
		Executor.Special_ = 2
		Executor<<"<b><font color=#3EFFFA><u>To stop using Ice Shield press X."

		loop
			if(!Executor.Using_Sand_Shield) return

			Executor.Cha -= 2.95
			if(Executor.Cha <= 0)
				for(var/obj/Effects/Tobirama_Shield/T in Executor.Overlays) del(T)
				Executor<<output("<b><font color=#3EFFFA><u>You have stopped using Ice Shield due to your low chakra!</u>","Chat")
				Executor.Using_Sand_Shield = 0
				Executor.Special_ = 0
				Executor.Icon_State = null
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			else spawn(3.5) goto loop

	Sand_Shield()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		src.On_Ground = 1
		if(Executor.Using_Sand_Shield)
			Executor<<output("<b><font color=#F2E187><u>You have stopped using Sand Shield.</u>","Chat")
			Executor.Using_Sand_Shield = 0
			Executor.Special_ = 0
			Executor.Icon_State = null
			flick("shield2", Executor)
			sleep(6.5)
			Executor.Dragonned = 0
			Executor.freeze --
			Executor.stop()

		if(Executor.Can_Execute(src, 10) == 0) return
		Delay(15)
		Executor.stop()
		Executor.Icon_State = "shield"
		Flick("shield", Executor)
		Executor.Using_Sand_Shield = 1
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.Execute_Jutsu("Sand Release.- Shield!")
		Executor.Special_ = 2
		Executor<<"<b><font color=#F2E187><u>To stop using Sand Shield press X."

		loop
			if(!Executor.Using_Sand_Shield) return

			Executor.Cha -= 2.95
			if(Executor.Cha <= 0)
				Executor<<output("<b><font color=#F2E187><u>You have stopped using Sand Shield due to your low chakra!</u>","Chat")
				Executor.Using_Sand_Shield = 0
				Executor.Special_ = 0
				Executor.Icon_State = null
				Flick("shield2", Executor)
				sleep(5.5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			else spawn(3.5) goto loop

	Sand_Spikes()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 55) == 0) return
		Delay(5)
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Sand Release.- Spikes!")
		var/A=new/obj/Sand_Spike(Executor.loc)
		var/B=new/obj/Sand_Spike(Executor.loc)
		if(Executor.dir == EAST)
			A:x+=2
			B:x+=4
			for(var/mob/M in view(A,2))
				if(M != Executor && M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real)
					if(M.Dodging)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue
					Executor.Executed_Fully = 1
					var/Damage = 15+rand(10,30)
					M.Damage(Executor, Damage, 1, 0)
					M.vel_y=5
			for(var/mob/M in view(B,2))
				if(M != Executor && M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real)
					if(M.Dodging || M.Dodge_Next)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue
					Executor.Executed_Fully = 1
					var/Damage = 15+rand(10,30)
					M.Damage(Executor, Damage, 1, 0)
					M.vel_y=5
		if(Executor.dir == WEST)
			A:x-=2
			B:x-=4
			for(var/mob/M in view(A,2))
				if(M != Executor && M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real)
					if(M.Dodging)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue
					Executor.Executed_Fully = 1
					var/Damage = 15+rand(10,30)
					M.Damage(Executor, Damage, 1, 0)
					M.vel_y=5
			for(var/mob/M in view(B,2))
				if(M != Executor && M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real)
					if(M.Dodging || M.Dodge_Next)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue
					Executor.Executed_Fully = 1
					var/Damage = 15+rand(10,30)
					M.Damage(Executor, Damage, 1, 0)
					M.vel_y=5
		spawn(7.5)
			Flick("teleport", Executor)
			Executor.freeze --
			Executor.stop()
	Rain_Bomb()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(20)
		Executor.freeze ++
		Executor.stop()
		Flick("Rain", Executor)
		sleep(7.5)
		spawn(2.5) Executor.freeze --
		for(var/mob/M in view(10))
			if(M.Village != Executor.Village && !M.Dragonned && M.Real && !M.knocked)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				Executor.Executed_Fully = 1
				M.freeze ++
				var/A=new/obj/Rain_Bomb(M.loc)
				switch(rand(1,2))
					if(2)
						A:dir=WEST
						A:x+=2
					if(1)
						A:dir=EAST
						A:x-=2
				spawn(5)
					var/Damage = 25+rand(1,15)
					M.Damage(Executor, Damage, 1, 0)
				spawn(10) M.freeze --
mob
	proc
		Quake_Effect(duration)
			if(!src.client) return
			if(Controlling_Object) del(Controlling_Object)
			spawn(1)
				loop
					if(name == key && client)
						src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
						src.client:eye = src// it will set your eye to who you look at
						return
					if(!client)
						spawn(100)
							if(client)
								src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
								src.client:eye = src// it will set your eye to who you look at
					else
						if(duration >= 1)
							duration--
							src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
							src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
							src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
							spawn(3) goto loop
						else
							src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
							src.client:eye = src// it will set your eye to who you look at

		Quake_Effect_X(duration)
			if(!src.client) return
			if(Controlling_Object) del(Controlling_Object)
			duration*=1.5
			src<<"<font color=#10C8FF><font size=2>You inner ear has been damaged by a Sound Wave!"
			spawn(1)
				loop
					if(name == key && client)
						src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
						src.client:eye = src// it will set your eye to who you look at
						return
					if(!client)
						spawn(100)
							if(client)
								src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
								src.client:eye = src// it will set your eye to who you look at
					if(duration >= 1)
						duration--
						src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
						src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
						src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
						src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
						src.client.eye = get_step(src,pick(NORTH,SOUTH,EAST,WEST))
						spawn(3) goto loop
					else
						src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
						src.client:eye = src// it will set your eye to who you look at

mob/var/Counting_ = 0
mob/proc
	Stop_Amaterasu_Flames()
		if(NEM_Round.Mode == "Arena" || NEM_Round.Mode == "Challenge" || NEM_Round.Mode == "Mission") return
		if(knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(!on_ground) return
		if(src.Cha < 30)
			Cooldown_Display (30)
			return
		stop()
		src.Cha-=30
		Flick("mob-shooting",src)
		sleep(10)
		for(var/mob/M)
			if(M.dead==0&&M.Amaterasu>=1)
				M.Amaterasu=0
				M<<output("<b><font color=red>The Amaterasu Flames have vanished.","Chat")

obj/proc

	Path_Of_Resurrection()
		var/mob/Executor = usr
		var/Real_Name = Executor.name
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		if(CTD) return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Next_Mode == "Reboot Now") return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Delay || !Executor.on_ground || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(Executor.NEM_Round.Type == "Tourney" == 1)
			Executor<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return
		if(Executor.Cha < 100)
			Executor.Cooldown_Display (100)
			return
		if(Executor.Can_Revive == 0)
			Executor<<"<b><font color=red><u>You died before, you can't revive anymore.</u></font>"
			return
		if(Executor.CanUseAmaterasu >= 1)
			Executor<<output("<b><font color=red>You can only use Path of Resurrection 1 time per round.</b>","Chat")
			return
		var/P1 = 0
		for(var/mob/M1)
			if(M1.client && M1.CanBeRevived == 1 && M1.dead == 1 && M1.Village == Executor.Village && M1.name != "Pein") P1++
		if(!P1)
			Executor<<"<b><font color=red><u>Unable to use this jutsu.- Nobody in your village is dead!</u></font>"
			return
		if(Executor.client)
			if(alert(Executor, "Are you sure? This'll revive all the dead ninjas in your village, but you'll die!", "Deadly Skill", "No", "Yes") == "Yes")
				if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
				if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
				if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
				if(Executor.name != Real_Name) return
				if(Executor.Can_Revive == 0)
					Executor<<"<b><font color=red><u>You died before, you can't revive anymore.</u></font>"
					return
				if(Executor.CanUseAmaterasu >= 1)
					Executor<<output("<b><font color=red>You can only use Path of Resurrection 1 time per round.</b>","Chat")
					return
				if(Boss_Mode == 1)
					Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
					return
				var/P2 = 0
				for(var/mob/M2)
					if(M2.client && M2.CanBeRevived == 1 && M2.dead == 1 && M2.Village == Executor.Village && M2.name != "Pein") P2++
				if(!P2)
					Executor<<"<b><font color=red><u>Unable to use this jutsu.- Nobody in your village is dead!</u></font>"
					return
				if(Executor.Can_Execute(src, 100) == 0) return
				var/TriesX = 0
				var/list/Revived_List = list()
				loop
					for(var/mob/M in Executor.NEM_Round.Ninjas)
						if(M.client && M.CanBeRevived == 1 && M.dead == 1 && M.Village == Executor.Village && M.name != "Pein")
							if(Revived_List.Find(M)) continue
							Revived_List.Add(M)
							if(TriesX == 0)
								Executor.CanUseAmaterasu = 1
								Executor.freeze ++
								Executor.stop()
								Executor.Dragonned = 1
								Executor.NEM_Round.Shout("<b><u><font color=red>Pein sacrificed himself to revive the Akatsukis!</u>")
							TriesX ++
							var/A = new/obj/Path_4(M.loc)
							switch(rand(1,2))
								if(1)
									A:x+=1
									A:dir = WEST
								if(2)
									A:x-=1
									A:dir = EAST
							sleep(30)
							if(!M.dead)
								M.overlays -= 'Graphics/Skills/Heal.dmi'
								continue
							M.Energy = M.MaxEnergy
							M.Cha = M.MaxCha
							M.HP = M.MaxHP
							M.CanUseGates = 0
							M.knocked = 0
							M.density = 1
							M.freeze = 0
							M.dead = 0
							M.stop()
							M.Run_Off()
							M.set_state()
							M.client:perspective = EYE_PERSPECTIVE//this sets the client perspective to the usr eye, making the eye not go black if out of range.
							M.client:eye = M// it ll set your eye to who you look at
							M.verbs-=typesof(/mob/Dead/verb)
							if(!M.Moving) M.Movement()
							if(M.Healer_Character == 1)
								if(M.Village == "Leaf") Healers_Leaf ++
								if(M.Village == "Akatsuki") Healers_Akatsuki ++
							Executor.NEM_Round.Shout("<b><font color=#AC0404><u>[M.name] has been revived by Pein!</u>")
							if(A) del(A)
							M.NEM_Side.Ninjas ++
							goto loop
				Executor.Dragonned = 0
				Executor.Deaths = 4
				Executor.HP = -100
				Executor.Death_Check()


	Sacrifice()
		var/mob/Executor = usr
		var/Real_Name = Executor.name
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		if(CTD) return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Next_Mode == "Reboot Now") return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Delay || !Executor.on_ground || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(Executor.NEM_Round.Type == "Tourney")
			Executor<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return
		if(Executor.Cha < 100)
			Executor.Cooldown_Display (100)
			return
		if(Executor.Can_Revive == 0)
			Executor<<"<b><font color=red><u>You died before, you can't revive anymore.</u></font>"
			return
		if(Executor.CanUseAmaterasu >= 1)
			Executor<<output("<b><font color=red>You can only use Sacrifice 1 time per round.</b>","Chat")
			return
		var/P1 = 0
		for(var/mob/M1) if(M1.client && M1.CanBeRevived == 1 && M1.dead == 1 && M1.Village == Executor.Village && M1.name != "Tsunade") P1++
		if(!P1)
			Executor<<"<b><font color=red><u>Unable to use this jutsu.- Nobody in your village is dead!</u></font>"
			return
		if(Executor.client)
			if(alert(Executor, "Are you sure? This'll revive all the dead ninjas in your village, but you'll die!", "Deadly Skill", "No", "Yes") == "Yes")
				if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
				if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
				if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
				if(Executor.name != Real_Name) return
				if(Executor.Can_Revive == 0)
					Executor<<"<b><font color=red><u>You died before, you can't revive anymore.</u></font>"
					return
				if(Executor.CanUseAmaterasu >= 1)
					Executor<<output("<b><font color=red>You can only use Sacrifice 1 time per round.</b>","Chat")
					return
				if(Boss_Mode == 1)
					Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
					return
				var/P2 = 0
				for(var/mob/M2)
					if(M2.client && M2.CanBeRevived == 1 && M2.dead == 1 && M2.Village == Executor.Village && M2.name != "Tsunade") P2++
				if(!P2)
					Executor<<"<b><font color=red><u>Unable to use this jutsu.- Nobody in your village is dead!</u></font>"
					return
				if(Executor.Can_Execute(src, 100) == 0) return
				var/TriesX = 0
				var/list/Revived_List = list()
				loop
					for(var/mob/M in Executor.NEM_Round.Ninjas)
						if(M.client && M.CanBeRevived == 1 && M.dead == 1 && M.Village == Executor.Village && M.name != "Tsunade")
							if(Revived_List.Find(M)) continue
							Revived_List.Add(M)
							if(TriesX == 0)
								Executor.Dragonned = 1
								Executor.CanUseAmaterasu = 1
								Executor.freeze ++
								Executor.stop()
								Executor.NEM_Round.Shout("<b><u><font color=red>Tsunade sacrificed herself to revive the Alliance Shinobis!</u>")
							TriesX ++
							M.overlays += 'Graphics/Skills/Heal.dmi'
							sleep(30)
							if(!M.dead)
								M.overlays -= 'Graphics/Skills/Heal.dmi'
								continue
							M.Energy = M.MaxEnergy
							M.Cha = M.MaxCha
							M.HP = M.MaxHP
							M.CanUseGates = 0
							M.knocked = 0
							M.density = 1
							M.freeze = 0
							M.dead = 0
							M.stop()
							M.Run_Off()
							M.set_state()
							if(M.client)M.client:perspective = EYE_PERSPECTIVE//this sets the client perspective to the usr eye, making the eye not go black if out of range.
							if(M.client)M.client:eye = M// it ll set your eye to who you look at
							M.verbs-=typesof(/mob/Dead/verb)
							if(!M.Moving) M.Movement()
							if(M.Healer_Character == 1)
								if(M.Village == "Leaf") Healers_Leaf ++
								if(M.Village == "Akatsuki") Healers_Akatsuki ++
							Executor.NEM_Round.Shout("<b><font color=#4BFF4B><u>[M.name] has been revived by Tsunade!</u>")
							M.overlays-='Graphics/Skills/Heal.dmi'
							M.NEM_Side.Ninjas ++
							goto loop
				Executor.Deaths = 4
				Executor.HP = -10
				Executor.Dragonned = 0
				Executor.Death_Check()
	Shinra_Tensei()
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		if(CTD) return
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.NEM_Round.Type == "Tourney")
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Tournament.</u>"
			return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(Executor.Can_Execute(src, 125) == 0) return
		Delay(300)
		spawn(60)
			Executor.CanMove = 1
			Executor.freeze --
			Executor.stop()
			if(!Executor.knocked) Executor.icon_state = "mob-standing"
		var/Counting__ = rand(1,99999)
		Executor.Counting_= Counting__
		Executor.Doming = 1
		Executor.Attacked = 1
		spawn(450) Executor.Attacked = 0
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.stop()
		Flick("mob-shooting", Executor)
		Executor.icon_state = "mob-shooting"
		var/_Target_
		sleep(10)
		if(Executor.Counting_ == Counting__)
			view(Executor, 40)<<"<center><img src='Shinra N2.png'>"
			sleep(15)
			if(Executor.Counting_ == Counting__)
				view(Executor, 40)<<"<center><img src='Shinra N.png'>"
				sleep(5)
				if(Executor.Counting_ == Counting__)
					var/S = new/obj/Shinra (Executor.loc)
					S:pixel_x = Executor.pixel_x
					S:pixel_y = Executor.pixel_y
					S:pixel_x -= 15
					S:pixel_y -= 54
					var/A=new/obj/GroundSmashX(Executor.loc)
					if(Executor.dir == WEST) A:pixel_x-=15
					if(Executor.dir == EAST) A:pixel_x-=10
					view(Executor, 40)<<"<center><img src='Shinra N3.png'>"
					Executor.Dragonned = 1
					Executor.Doming = 0
					Executor.Stop_Chakra(30, "Pein")
					spawn(30) Executor.Dragonned = 0
					for(var/mob/M in view(40))
						if(M.Susanoo) continue
						if(M.Real == 0 && !M.Gates)
							if(istype(M, /mob/Ultimate_Projectile/))
								M:Projectile_Owner = Executor
								M:Allies = rand(1,30000000)
								if(M.px > Executor.px)
									M.vel_x = 10
									M.dir = EAST
								if(M.px < Executor.px)
									M.vel_x = -10
									M.dir = WEST
								if(M.px == Executor.px)
									switch(rand(1,2))
										if(1)
											M.vel_x = 10
											M.dir = EAST
										if(2)
											M.vel_x = -10
											M.dir = WEST
							else
								if(M.px > Executor.px) M.Pein_ProcEAST(Executor)
								if(M.px < Executor.px) M.Pein_ProcWEST(Executor)
								if(M.px == Executor.px)
									switch(rand(1,2))
										if(1) M.Pein_ProcEAST(Executor)
										if(2) M.Pein_ProcWEST(Executor)

						if(M.Real == 1 && !M.Gates)
							if(M.name != Executor.name && M.dead == 0 && M.knocked == 0)
								if(M.px > Executor.px) M.Pein_ProcEAST(Executor)
								if(M.px < Executor.px) M.Pein_ProcWEST(Executor)
								if(M.px == Executor.px)
									switch(rand(1,2))
										if(1) M.Pein_ProcEAST(Executor)
										if(2) M.Pein_ProcWEST(Executor)
								_Target_ ++
								M.HP -= 65
								M.vel_y = 20
								if(M.Levitating) M.Check_Levitating()
								if(M.client) M.Quake_Effect(40)
								M.Death_Check(Executor)
					if(_Target_) Executor.Damage_Up(65)
	Shinra_Tensei_C()
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.NEM_Round.Type == "Tourney")
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Tournament.</u>"
			return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(Executor.Can_Execute(src, 80) == 0) return
		Delay(150)
		spawn(50)
			Executor.pixel_y = 0
			Executor.CanMove = 1
			Executor.stop()
			if(!Executor.knocked)
				Executor.freeze --
				Executor.icon_state = "mob-standing"
		Executor.Dragonned = 1
		Executor.Attacked = 1
		spawn(150) Executor.Attacked = 0
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.stop()
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Deva Path: Shinra Tensei!")
		Executor.pixel_y -= 10
		Flick("Summon", Executor)
		Executor.icon_state = "Summon"
		var/_Target_
		spawn(3)
			if(Executor)
				var/Pein = new/obj/Shinra_Pein (Executor.loc)
				Pein:dir = Executor.dir
				Pein:pixel_x = Executor.pixel_x
				if(Executor.dir == EAST) Pein:x += 2
				if(Executor.dir == WEST) Pein:x -= 2
				spawn(3)
					spawn(30)
						if(Pein) del(Pein)
					Executor.Dragonned = 0
					var/S = new/obj/Shinra (Pein:loc)
					S:pixel_x = Pein:pixel_x
					S:pixel_y = Pein:pixel_y
					S:pixel_x -= 15
					S:pixel_y -= 54
					var/A=new/obj/GroundSmashX(Pein:loc)
					if(Executor.dir == WEST) A:pixel_x-=15
					if(Executor.dir == EAST) A:pixel_x-=10
					Executor.Stop_Chakra(15)
					for(var/mob/M in view(40))
						if(M.Susanoo) continue
						if(M.Real == 0 && !M.Gates)
							if(istype(M, /mob/Ultimate_Projectile/))
								M:Projectile_Owner = Executor
								M:Allies = rand(1,30000000)
								if(M.px > Executor.px)
									M.vel_x = 10
									M.dir = EAST
								if(M.px < Executor.px)
									M.vel_x = -10
									M.dir = WEST
								if(M.px == Executor.px)
									switch(rand(1,2))
										if(1)
											M.vel_x = 10
											M.dir = EAST
										if(2)
											M.vel_x = -10
											M.dir = WEST
							else
								if(M.px > Executor.px) M.Pein_ProcEASTX(Executor)
								if(M.px < Executor.px) M.Pein_ProcWESTX(Executor)
								if(M.px == Executor.px)
									switch(rand(1,2))
										if(1) M.Pein_ProcEASTX(Executor)
										if(2) M.Pein_ProcWESTX(Executor)

						if(M.Real == 1 && !M.Gates)
							if(M.name!=Executor.name&&M.dead==0&&M.knocked==0)
								if(M.px > Executor.px) M.Pein_ProcEASTX(Executor)
								if(M.px < Executor.px) M.Pein_ProcWESTX(Executor)
								if(M.px == Executor.px)
									switch(rand(1,2))
										if(1) M.Pein_ProcEASTX(Executor)
										if(2) M.Pein_ProcWESTX(Executor)
								var/Damage = 35+rand(0,5)
								_Target_ ++
								M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 1)
								M.vel_y=20
								if(M.client) M.Quake_Effect(20)
					if(_Target_) Executor.Damage_Up(35+rand(0, 5))
	Clone_Jutsu_Yamato()
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		src.Boss_Mode = 1
		var/mob/Executor = usr
		if(CTD) return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(!Clones || Executor.Boss == 1 || Executor.Guardian == 1 ||  Executor.NEM_Round.Mode == "Arena")
			Executor<<output("<b><font color=red><u>This jutsu is currently disabled for you.", "Chat")
			return
		for(var/mob/NPC/Yamato/Z) if(!Z.dead && Z.Clone_Creator == Executor)
			Delay(3)
			Flick("mob-shooting", Executor)
			Z.loc = Executor.loc
			Z.check_loc()
			Z.vel_y = 12
			Z.dir = Executor.dir
			return
		if(Executor.Can_Execute(src, 100) == 0) return
		Executor.freeze ++
		Flick("mob-shooting", Executor)
		sleep(3)
		Yamato = 1
		var/C=new/mob/NPC/Yamato(Executor.loc)
		C:Clone_Creator = Executor
		C:NEM_Round= Executor.NEM_Round
		C:NEM_Side = Executor.NEM_Side
		C:MaxHP = Executor.MaxHP/1.25
		C:HP = C:MaxHP
		C:Str = Executor.Str/1.1
		C:Def = Executor.Def/1.1
		C:Village = Executor.Village
		C:freeze ++
		Flick("mob-shooting", C)
		if(Executor.dir == EAST)
			C:loc = locate(Executor.x-2, Executor.y, Executor.z)
			C:dir = WEST
		if(Executor.dir == WEST)
			C:loc = locate(Executor.x+2, Executor.y, Executor.z)
			C:dir = EAST
		sleep(6)
		if(C) C:freeze --
		spawn(5)
			Executor.freeze --
			Executor.stop()
	Push_BackP()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(10)
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("punch4", Executor)
		spawn(10)
			Executor.Dragonned = 0
			Executor.pixel_y = 0
			Executor.freeze --
			Executor.stop()
		Executor.Execute_Jutsu("Chakra Shockwave Splash!")
		for(var/mob/M in view(4))
			if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Boulder && !M.BoulderX)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					var/Damage = rand(40,25)
					M.Damage(Executor, Damage, 1, 2, 0, 1)
					M.Quake_Effect(10)
					M.vel_y += 4
					if(M.px > Executor.px) M.knockbackeast()
					if(M.px < Executor.px) M.knockbackwest()
					if(M.px == Executor.px)
						if(Executor.dir == EAST) M.knockbackwest()
						if(Executor.dir == WEST) M.knockbackeast()
	Shinra_TenseiP()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(13)
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("throw", Executor)
		if(Executor.name == "Lord Madara") Flick("Shinra", Executor)
		spawn(10)
			Executor.Dragonned = 0
			Executor.pixel_y = 0
			Executor.freeze --
			Executor.stop()
		Executor.Execute_Jutsu("Almighty Push!")
		for(var/mob/M in view(4))
			if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Boulder && !M.BoulderX)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					var/Damage = rand(40,25)
					M.Damage(Executor, Damage, 1, 2, 0, 1)
					M.Quake_Effect(10)
					M.vel_y += 4
					if(M.px > Executor.px) M.knockbackeast()
					if(M.px < Executor.px) M.knockbackwest()
					if(M.px == Executor.px)
						if(Executor.dir == EAST) M.knockbackwest()
						if(Executor.dir == WEST) M.knockbackeast()
	Water_Clone_X()
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		src.Boss_Mode = 1
		if(CTD) return
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(!Clones || Executor.Boss == 1 || Executor.Guardian == 1 ||  Executor.NEM_Round.Mode == "Arena")
			Executor<<output("<b><font color=red><u>This jutsu is currently disabled for you.", "Chat")
			return
		for(var/mob/NPC/Kushimaru/Z) if(!Z.dead && Z.Clone_Creator == Executor)
			Delay(3)
			Flick("mob-shooting", Executor)
			Z.loc = Executor.loc
			Z.check_loc()
			Z.vel_y = 12
			Z.dir = Executor.dir
			return
		if(Executor.Can_Execute(src, 100) == 0) return
		Flick("mob-shooting", Executor)
		Executor.freeze ++
		sleep(3)
		Kushimaru = 1
		var/C=new/mob/NPC/Kushimaru(Executor.loc)
		C:Clone_Creator = Executor
		C:NEM_Round= Executor.NEM_Round
		C:NEM_Side = Executor.NEM_Side
		C:MaxHP = Executor.MaxHP/1.25
		C:HP = C:MaxHP
		C:Str = Executor.Str/1.1
		C:Def = Executor.Def/1.1
		C:Village = Executor.Village
		C:freeze ++
		Flick("mob-shooting", C)
		if(Executor.dir == EAST)
			C:loc = locate(Executor.x-2, Executor.y, Executor.z)
			C:dir = WEST
		if(Executor.dir == WEST)
			C:loc = locate(Executor.x+2, Executor.y, Executor.z)
			C:dir = EAST
		sleep(6)
		if(C) C:freeze --
		spawn(5)
			Executor.freeze --
			Executor.stop()
	Water_Clone()
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		src.Boss_Mode = 1
		if(CTD) return
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(!Clones || Executor.Boss == 1 || Executor.Guardian == 1 ||  Executor.NEM_Round.Mode == "Arena")
			Executor<<output("<b><font color=red><u>This jutsu is currently disabled for you.", "Chat")
			return
		for(var/mob/NPC/Yagura/Z) if(!Z.dead && Z.Clone_Creator == Executor)
			Delay(3)
			Flick("mob-shooting", Executor)
			Z.loc = Executor.loc
			Z.check_loc()
			Z.vel_y = 12
			Z.dir = Executor.dir
			return
		if(Executor.Can_Execute(src, 100) == 0) return
		Executor.freeze ++
		Flick("mob-shooting", Executor)
		sleep(3)
		Kushimaru = 1
		var/C=new/mob/NPC/Yagura(Executor.loc)
		C:NEM_Round= Executor.NEM_Round
		C:NEM_Side = Executor.NEM_Side
		C:Clone_Creator = Executor
		C:MaxHP = Executor.MaxHP/1.25
		C:HP = C:MaxHP
		C:Str = Executor.Str/1.1
		C:Def = Executor.Def/1.1
		C:Village = Executor.Village
		C:freeze ++
		Flick("mob-shooting", C)
		if(Executor.dir == EAST)
			C:loc = locate(Executor.x-2, Executor.y, Executor.z)
			C:dir = WEST
		if(Executor.dir == WEST)
			C:loc = locate(Executor.x+2, Executor.y, Executor.z)
			C:dir = EAST
		sleep(6)
		if(C) C:freeze --
		spawn(5)
			Executor.freeze --
			Executor.stop()
	Clone_Jutsu_Kisame()
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		src.Boss_Mode = 1
		if(CTD) return
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(!Clones || Executor.Boss == 1 || Executor.Guardian == 1 ||  Executor.NEM_Round.Mode == "Arena")
			Executor<<output("<b><font color=red><u>This jutsu is currently disabled for you.", "Chat")
			return
		for(var/mob/NPC/Kisame/Z) if(!Z.dead && Z.Clone_Creator == Executor)
			Delay(3)
			Flick("mob-shooting", Executor)
			Z.loc = Executor.loc
			Z.check_loc()
			Z.vel_y = 12
			Z.dir = Executor.dir
			return
		if(Executor.Can_Execute(src, 100) == 0) return
		Executor.freeze ++
		Flick("mob-shooting", Executor)
		sleep(3)
		Kushimaru = 1
		var/C=new/mob/NPC/Kisame(Executor.loc)
		C:Clone_Creator = Executor
		C:NEM_Round= Executor.NEM_Round
		C:NEM_Side = Executor.NEM_Side
		C:MaxHP = Executor.MaxHP/1.25
		C:HP = C:MaxHP
		C:Str = Executor.Str/1.1
		C:Def = Executor.Def/1.1
		C:Village = Executor.Village
		C:freeze ++
		Flick("mob-shooting", C)
		if(Executor.dir == EAST)
			C:loc = locate(Executor.x-2, Executor.y, Executor.z)
			C:dir = WEST
		if(Executor.dir == WEST)
			C:loc = locate(Executor.x+2, Executor.y, Executor.z)
			C:dir = EAST
		sleep(6)
		if(C) C:freeze --
		spawn(5)
			Executor.freeze --
			Executor.stop()

	Kakashi_Clone()
		src.Tournament_GoingOn = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(CTD) return
		if(Executor.Boss || Executor.Guardian || Capture_The_Flag) {Executor<<output("<b><font color=red><u>This jutsu is currently disabled for you.", "Chat"); return}
		if(Executor.Kamui) {Executor<<"<b><font color=red><u>This jutsu isn't allowed on Kamui!</u>"; return}

		for(var/mob/Kakashi/T in world)
			if(!T.dead)
				Delay(45)
				Flick("mob-shooting", Executor)
				Flick("mob-shooting", T)
				Executor.freeze ++
				Executor.invisibility = 0
				Executor.Substitution = 0
				Executor.Dragonned = 0
				Executor.Venomous_Clone = 0
				Executor._CD = 0
				Executor.Can_Attack_ = 1
				Executor.density = 1
				sleep(3.75)
				Executor.freeze --
				Executor.stop()
				T.Checked_X = 0
				T.loc = null
				T.freeze = 1
				T.dead = 1
				T.Always_Freeze()
				return

		if(Executor.Substitution) return
		if(Executor.Can_Execute(src, 70) == 0) return
		Executor.Substitution = 1
		Executor.Can_Attack_ = 0
		Executor.Venomous_Clone = 1
		Executor.Dragonned = 1
		Executor.density = 0
		Executor._CD = 1
		Executor.invisibility = 101
		var/mob/T = new/mob/Kakashi(Executor.loc)
		T:NEM_Round= Executor.NEM_Round
		T:NEM_Side = Executor.NEM_Side
		T._Owner_ = Executor
		T.stop()
		T.HP = Executor.MaxHP
		T.HP /= 1.25
		T.Str = Executor.Str
		T.Def = Executor.Def
		T.Village = Executor.Village
		T.icon = Executor.icon
		T.name = Executor.name
		T.dir = Executor.dir
		T.step_x = Executor.step_x
		T.step_y = Executor.step_y
		T.set_pos(Executor.px, Executor.py)
		T.Substitution()
		spawn(12.5) T.vel_x = 0

	Venomous_Insect_Clone()
		src.Tournament_GoingOn = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(CTD) return
		if(Executor.Boss || Executor.Guardian || Capture_The_Flag)
			Executor<<output("<b><font color=red><u>This jutsu is currently disabled for you.", "Chat")
			return

		for(var/mob/Torune/T in world)
			if(!T.dead)
				Delay(15)
				Flick("Seals", Executor)
				Flick("Seals", T)
				Executor.freeze ++
				Executor.invisibility = 0
				Executor.speed_multiplier = 0
				Executor.move_speed = 0
				Executor.Substitution = 0
				Executor.Dragonned = 0
				Executor.Venomous_Clone = 0
				Executor._CD = 0
				Executor.Can_Attack_ = 1
				Executor.density = 1
				sleep(3.75)
				Executor.freeze --
				T.Checked_X = 0
				T.loc = null
				T.freeze = 1
				T.dead = 1
				T.Always_Freeze()
				return

		if(Executor.Substitution) return
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.Substitution = 1
		Executor.Can_Attack_ = 0
		Executor.Venomous_Clone = 1
		Executor.Dragonned = 1
		Executor.density = 0
		Executor._CD = 1
		Executor.speed_multiplier = 2
		Executor.move_speed = 20
		Executor.invisibility = 101
		var/mob/T = new/mob/Torune(Executor.loc)
		T:NEM_Round= Executor.NEM_Round
		T:NEM_Side = Executor.NEM_Side
		T._Owner_ = Executor
		T.stop()
		T.HP = Executor.MaxHP
		T.Str = Executor.Str
		T.Def = Executor.Def
		T.Village = Executor.Village
		T.icon = Executor.icon
		T.name = Executor.name
		T.dir = Executor.dir
		T.step_x = Executor.step_x
		T.step_y = Executor.step_y
		T.set_pos(Executor.px, Executor.py)
		T.Substitution()
		spawn(12.5) T.vel_x = 0

	Clone_Jutsu_Naruto()
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		src.Boss_Mode = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(!Clones || Executor.Boss == 1 || Executor.Guardian == 1 ||  Executor.NEM_Round.Mode == "Arena")
			Executor<<output("<b><font color=red><u>This jutsu is currently disabled for you.", "Chat")
			return
		for(var/mob/NPC/Naruto/Z) if(!Z.dead && Z.Clone_Creator == Executor)
			Delay(3)
			Flick("mob-shooting", Executor)
			Z.loc = Executor.loc
			Z.check_loc()
			Z.vel_y = 12
			Z.dir = Executor.dir
			return
		if(Executor.Can_Execute(src, 100) == 0) return
		Executor.freeze ++
		Flick("mob-shooting", Executor)
		sleep(3)
		Kushimaru = 1
		var/C=new/mob/NPC/Naruto(Executor.loc)
		C:Clone_Creator = Executor
		C:NEM_Round= Executor.NEM_Round
		C:NEM_Side = Executor.NEM_Side
		C:MaxHP = Executor.MaxHP/1.25
		C:HP = C:MaxHP
		C:Str = Executor.Str/1.1
		C:Def = Executor.Def/1.1
		C:Village = Executor.Village
		C:freeze ++
		Flick("mob-shooting", C)
		if(Executor.dir == EAST)
			C:loc = locate(Executor.x-2, Executor.y, Executor.z)
			C:dir = WEST
		if(Executor.dir == WEST)
			C:loc = locate(Executor.x+2, Executor.y, Executor.z)
			C:dir = EAST
		sleep(6)
		if(C) C:freeze --
		spawn(5)
			Executor.freeze --
			Executor.stop()
	Clone_Jutsu()
		src.Tournament_GoingOn = 1
		src.On_Ground = 1
		src.Boss_Mode = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(!Clones || Executor.Boss == 1 || Executor.Guardian == 1 ||  Executor.NEM_Round.Mode == "Arena")
			Executor<<output("<b><font color=red><u>This jutsu is currently disabled for you.", "Chat")
			return
		for(var/mob/NPC/Zetsu/Z) if(!Z.dead && Z.Clone_Creator == Executor)
			Delay(3)
			Flick("mob-shooting", Executor)
			Z.loc = Executor.loc
			Z.check_loc()
			Z.vel_y = 12
			Z.dir = Executor.dir
			return
		if(Executor.Can_Execute(src, 125) == 0) return
		Executor.freeze ++
		Flick("mob-shooting", Executor)
		sleep(3)
		Kushimaru = 1
		var/C=new/mob/NPC/Zetsu(Executor.loc)
		C:Clone_Creator = Executor
		C:NEM_Round= Executor.NEM_Round
		C:NEM_Side = Executor.NEM_Side
		C:MaxHP = Executor.MaxHP
		C:HP = C:MaxHP
		C:Str = Executor.Str
		C:Def = Executor.Def
		C:Village = Executor.Village
		C:freeze ++
		Flick("mob-shooting", C)
		if(Executor.dir == EAST)
			C:loc = locate(Executor.x-2, Executor.y, Executor.z)
			C:dir = WEST
		if(Executor.dir == WEST)
			C:loc = locate(Executor.x+2, Executor.y, Executor.z)
			C:dir = EAST
		sleep(6)
		if(C) C:freeze --
		spawn(5)
			Executor.freeze --
			Executor.stop()
	Amaterasu_Control()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Boss_Mode_) return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(!AllowedAmaterasu)
			Executor<<"<b><font color=red><u><center>Amaterasu isn't currently allowed!</u></center></font>"
			return
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 50)
			Executor.Cooldown_Display (50)
			return
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		var/list/choose=list()
		for(var/mob/D in view(15))
			if(!D.Amaterasu && !D.Immune && D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to use this jutsu on?", "Amaterasu Control") as null|anything in choose
		if(!M || M == "Cancel" || M == cancel)
			Executor.PeinCD = 0
			return
		if(M.Amaterasu || M.Immune || M.Amaterasu || Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(30)
				Executor.Cha -= 25
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(Executor.Can_Execute(src, 50) == 0) return
			Delay(90)
			Flick("Amaterasu Control", Executor)
			Executor.icon_state = "Amaterasu Control"
			Executor.freeze ++
			Executor.stop()
			sleep(7.5)
			Executor.Execute_Jutsu("Amaterasu Control!")
			M.Amaterasu_XX()
			sleep(1.5)
			Executor.freeze --
			Executor.stop()
	Chakra_Sphere()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(7)
		Flick("mob-shooting", Executor)
		Executor.Attacking ++
		sleep(1.5)
		Executor.Execute_Jutsu("Chakra Sphere!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Chakra_Sphere (null, Executor)
		Executor.stop()
		spawn(5)
			Executor.Attacking --
			Executor.stop()
	Blind()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(15)
		Executor.freeze ++
		Flick("Blind",src)
		spawn(10) Executor.freeze --
		spawn(7)
			for(var/mob/M in view(20))
				if(M.Real_C == 1 && M.client && M != Executor && !M.knocked && M.Village != Executor.Village)
					M.Blind_Effect()

mob/var/mob/Clone_Creator

mob/proc
	Remember_Spot()
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(NEM_Round.Type == "Tourney")
			src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
			return
		if(Kamui == 1)
			src<<"<b><font color=red><u>You can't use this jutsu on Kamui's Dimension!</u></font>"
			return
		if(!on_ground) return
		if(knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		if(src.Cha < 10)
			Cooldown_Display (10)
			return
		src.Cha-=10
		src<<output("<b><font color=red><u>You've successfully remembered your current spot.</u></font>", "Chat")
		Remembered_Location = src.loc
	Remember_Spot_Anko()
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Kamui == 1) {src<<"<b><font color=red><u>You can't use this jutsu on Kamui's Dimension!</u></font>"; return}
		if(!on_ground) return
		if(knockback==1||freeze||Controlling>=1||Attacking==1||knocked==1)return
		src<<output("<b><font color=red><u>You've successfully remembered your current spot.</u>", "Chat")
		Remembered_Spot = src.loc
	Teleport_Back()
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(NEM_Round.Type == "Tourney") {src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"; return}
		if(Kamui == 1) {src<<"<b><font color=red><u>You can't use this jutsu on Kamui's Dimension!</u></font>"; return}
		if(Flag == 1) {src<<"<b><font color=red><u>You aren't allowed to use this jutsu while carrying the Flag.</u></font>"; return}
		if(knockback || freeze || Controlling>=1 || Attacking  || knocked || !on_ground)return
		if(!Remembered_Location)
			src<<output("<b><font color=red>You haven't remembered any spot!", "Chat")
			return
		if(src.Cha < 100)
			Cooldown_Display (100)
			return
		src.Cha -= 100
		src.freeze ++
		src.Dragonned=1
		Flick("Hide", src)
		spawn(8)
			if(src) Flick("Appear", src)
			if(src) src.loc = src.Remembered_Location
			if(src) spawn(8)
				if(src)
					src.freeze --
					src.Dragonned = 0


mob/proc
	Blind_Effect()
		src<<output("<b><font color=red><u>You've been blinded by Zetsu!</u></font>", "Chat")
		if(Controlling_Object) del(Controlling_Object)
		src.client.eye  = locate(0,0,0)
		spawn(rand(15,30))
			if(src) src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
			if(src) src.client:eye = src
	Feather_Effect()
		src.overlays+='Graphics/Skills/Genjutsu2.dmi'
		src.freeze ++
		src<<output("<b><font color=red><u>You've been blinded by Kabuto!</u></font>", "Chat")
		if(Controlling_Object) del(Controlling_Object)
		src.client.eye  = locate(0,0,0)
		spawn(rand(35,45))
			if(src)
				src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
				src.client:eye = src
				src.freeze --
				src.overlays-='Graphics/Skills/Genjutsu2.dmi'
	Feather_Effect_X()
		src.overlays+='Graphics/Skills/Genjutsu2.dmi'
		src.freeze ++
		src<<output("<b><font color=red><u>You've been blinded by Kabutomaru!</u></font>", "Chat")
		if(Controlling_Object) del(Controlling_Object)
		src.client.eye  = locate(0,0,0)
		spawn(rand(35,45))
			if(src)
				src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
				src.client:eye = src
				src.freeze --
				src.overlays-='Graphics/Skills/Genjutsu2.dmi'
	Blind_Effect_2()
		src<<output("<b><font color=red><u>You've been blinded by (Three Tails) Killer Bee!</u></font>", "Chat")
		if(Controlling_Object) del(Controlling_Object)
		src.client.eye  = locate(0,0,0)
		spawn(rand(20,30))
			if(src) src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
			if(src) src.client:eye = src
mob/proc
	Tsukuyomi_Effect()
		src.overlays+='Graphics/Skills/Genjutsu.dmi'

		if(Controlling_Object) del(Controlling_Object)
		src<<output("<b><font color=#A90606><u>You've been caught in Itachi's Tsukuyomi!", "Chat")
		src.Dragonned = 1
		src.freeze ++
		if(client)
			client.eye = locate(29,14,2)
			client.perspective = EYE_PERSPECTIVE
		var/D = new/obj/Image()
		D:icon = src.icon
		D:icon_state = "mob-standing"
		D:loc = locate(29,14,2)
		var/I = new/obj/Image()
		I:icon = 'Graphics/Characters/Itachi.dmi'
		switch(rand(1,2))
			if(1)
				I:loc = locate(28,14,2)
				I:dir = EAST
				D:dir = WEST
			if(2)
				I:loc = locate(30,14,2)
				I:dir = WEST
				D:dir = EAST
		I:icon_state = "Tsukuyomi"
		sleep(9)
		Flick("Tsukuyomi_1", I)
		sleep(1)
		src.Dragonned = 1
		src.HP -= 9
		var/H1 = new/obj/TsuHit_1 (D:loc)
		new/obj/Hit (src.loc)
		Flick("hurt", D)
		view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: Ww-w-what?!"
		H1:dir = I:dir
		sleep(3)
		Flick("Tsukuyomi_2", I)
		sleep(9)
		src.Dragonned = 1
		src.HP -= 9
		var/H2 = new/obj/TsuHit_2 (D:loc)
		new/obj/Hit (src.loc)
		Flick("hurt", D)
		H2:dir = I:dir
		sleep(9)
		Flick("Tsukuyomi_1", I)
		sleep(1)
		src.Dragonned = 1
		src.HP -= 9
		var/H3 = new/obj/TsuHit_1 (D:loc)
		new/obj/Hit (src.loc)
		Flick("hurt", D)
		view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: D-d-d-....!"
		H3:dir = I:dir
		sleep(9)
		Flick("Tsukuyomi_2", I)
		sleep(1)
		src.Dragonned = 1
		src.HP -= 9
		var/H4 = new/obj/TsuHit_2 (D:loc)
		new/obj/Hit (src.loc)
		Flick("hurt", D)
		view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: Aaaw!"
		H4:dir = I:dir
		sleep(1)
		src.Dragonned = 1
		src.HP -= 9
		var/H5 = new/obj/TsuHit_1 (D:loc)
		new/obj/Hit (src.loc)
		Flick("hurt", D)
		view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: Ouch!"
		H5:dir = I:dir
		sleep(9)
		Flick("Tsukuyomi_2", I)
		sleep(1)
		src.Dragonned = 1
		src.HP -= 15
		var/H6 = new/obj/TsuHit_2 (D:loc)
		new/obj/Hit (src.loc)
		Flick("hurt", D)
		view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: Ungh!"
		H6:dir = I:dir
		sleep(9)
		I:icon = null
		view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: AAAARGHHH!"
		sleep(5)
		D:icon_state = "Knocked"
		sleep(5)
		view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: Aaa--.... Am I dead?"
		sleep(1)
		src.Dragonned = 1
		src.HP -= 9
		sleep(40)
		src<<output("<b><font color=#A90606><u>Tsukuyomi's effects are no longer in your body!<u>", "Chat")
		sleep(10)
		if(I) del(I)
		if(D) del(D)
		src.Death_Check("Itachi")
		src.Dragonned = 0
		src.freeze --
		if(client)
			src.client:perspective = MOB_PERSPECTIVE//this sets the client perspective to the usr, making the eye black when out of range(dont really know why you would want that on at all really).
			src.client:eye = src
		src.stop()
		src.overlays-='Graphics/Skills/Genjutsu.dmi'
mob/var/Blinded=0
mob/var/Old_Village = null
obj/proc
	Crystal_Spikes()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(30)
		Executor.freeze ++
		Executor.stop()
		Flick("Protect", Executor)
		Executor.Execute_Jutsu("Crystal Release.- Spikes!")
		var/A1 = new/mob/Crystal_Spike (Executor.loc)
		A1:Village = Executor.Village
		A1:Creator = Executor.name
		A1:x += 2
		A1:dir = EAST
		var/A2 = new/mob/Crystal_Spike (Executor.loc)
		A2:Village = Executor.Village
		A2:Creator = Executor.name
		A2:x -= 2
		A2:dir = WEST
		var/A3 = new/mob/Crystal_Spike (Executor.loc)
		A3:Village = Executor.Village
		A3:x += 4
		A3:Creator = Executor.name
		A3:dir = EAST
		var/A4 = new/mob/Crystal_Spike (Executor.loc)
		A4:Village = Executor.Village
		A4:x -= 4
		A4:Creator = Executor.name
		A4:dir = WEST
		var/A5 = new/mob/Crystal_Spike (Executor.loc)
		A5:Village = Executor.Village
		A5:x += 6
		A5:Creator = Executor.name
		A5:dir = EAST
		var/A6 = new/mob/Crystal_Spike (Executor.loc)
		A6:Village = Executor.Village
		A6:x -= 6
		A6:Creator = Executor.name
		A6:dir = WEST
		var/A7 = new/mob/Crystal_Spike (Executor.loc)
		A7:Village = Executor.Village
		A7:x += 8
		A7:dir = EAST
		A7:Creator = Executor.name
		var/A8 = new/mob/Crystal_Spike (Executor.loc)
		A8:Village = Executor.Village
		A8:x -= 8
		A8:Creator = Executor.name
		A8:dir = WEST
		spawn(10)
			Executor.freeze --
			Executor.stop()
	Rock_Spikes()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(30)
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		Executor.Execute_Jutsu("Rock Spikes!")
		var/A1 = new/mob/Rock_Spike (Executor.loc)
		A1:Village = Executor.Village
		A1:Creator = Executor.name
		A1:x += 2
		A1:dir = EAST
		var/A2 = new/mob/Rock_Spike (Executor.loc)
		A2:Village = Executor.Village
		A2:Creator = Executor.name
		A2:x -= 2
		A2:dir = WEST
		var/A3 = new/mob/Rock_Spike (Executor.loc)
		A3:Village = Executor.Village
		A3:Creator = Executor.name
		A3:x += 5
		A3:dir = EAST
		var/A4 = new/mob/Rock_Spike (Executor.loc)
		A4:Village = Executor.Village
		A4:Creator = Executor.name
		A4:x -= 5
		A4:dir = WEST
		var/A5 = new/mob/Rock_Spike (Executor.loc)
		A5:Village = Executor.Village
		A5:Creator = Executor.name
		A5:x += 8
		A5:dir = EAST
		var/A6 = new/mob/Rock_Spike (Executor.loc)
		A6:Village = Executor.Village
		A6:Creator = Executor.name
		A6:x -= 8
		A6:dir = WEST
		var/A7 = new/mob/Rock_Spike (Executor.loc)
		A7:Village = Executor.Village
		A7:Creator = Executor.name
		A7:x += 11
		A7:dir = EAST
		var/A8 = new/mob/Rock_Spike (Executor.loc)
		A8:Village = Executor.Village
		A8:Creator = Executor.name
		A8:dir = WEST
		A8:x -= 11
		spawn(10)
			Executor.freeze --
			Executor.stop()
	Ice_Spikes()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(30)
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		Executor.Execute_Jutsu("Ice Spikes!")
		var/A1 = new/mob/Ice_Spike (Executor.loc)
		A1:Village = Executor.Village
		A1:Creator = Executor.name
		A1:dir = EAST
		A1:x += 2
		var/A2 = new/mob/Ice_Spike (Executor.loc)
		A2:Village = Executor.Village
		A2:Creator = Executor.name
		A2:x -= 2
		A2:dir = WEST
		var/A3 = new/mob/Ice_Spike (Executor.loc)
		A3:Village = Executor.Village
		A3:Creator = Executor.name
		A3:x += 4
		A3:dir = EAST
		var/A4 = new/mob/Ice_Spike (Executor.loc)
		A4:Village = Executor.Village
		A4:Creator = Executor.name
		A4:x -= 4
		A4:dir = WEST
		var/A5 = new/mob/Ice_Spike (Executor.loc)
		A5:Village = Executor.Village
		A5:Creator = Executor.name
		A5:x += 6
		A5:dir = EAST
		var/A6 = new/mob/Ice_Spike (Executor.loc)
		A6:Village = Executor.Village
		A6:Creator = Executor.name
		A6:x -= 6
		A6:dir = WEST
		var/A7 = new/mob/Ice_Spike (Executor.loc)
		A7:Village = Executor.Village
		A7:Creator = Executor.name
		A7:x += 8
		A7:dir = EAST
		var/A8 = new/mob/Ice_Spike (Executor.loc)
		A8:Village = Executor.Village
		A8:Creator = Executor.name
		A8:x -= 8
		A8:dir = WEST
		spawn(10)
			Executor.freeze --
			Executor.stop()
	Earth_Spikes()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(30)
		Executor.freeze ++
		Executor.stop()
		Flick("Throw", Executor)
		spawn(5)
			Executor.freeze --
			Executor.stop()
		sleep(2)
		Executor.Execute_Jutsu("Earth Spikes!")
		if(Executor.dir == EAST)
			var/A1 = new/obj/Special_Spike (Executor.loc, Executor)
			A1:x += 1
			A1:Village = Executor.Village
			sleep(1)
			var/A2 = new/obj/Special_Spike (Executor.loc, Executor)
			A2:x += 3
			A2:Village = Executor.Village
			sleep(1)
			var/A3 = new/obj/Special_Spike (Executor.loc, Executor)
			A3:x += 5
			A3:Village = Executor.Village
			sleep(1)
			var/A4 = new/obj/Special_Spike (Executor.loc, Executor)
			A4:x += 7
			A4:Village = Executor.Village
			sleep(1)
			var/A5 = new/obj/Special_Spike (Executor.loc, Executor)
			A5:x += 9
			A5:Village = Executor.Village
			sleep(1)
			var/A6 = new/obj/Special_Spike (Executor.loc, Executor)
			A6:x += 11
			A6:Village = Executor.Village
			sleep(1)
			var/A7 = new/obj/Special_Spike (Executor.loc, Executor)
			A7:x += 13
			A7:Village = Executor.Village
			var/A8 = new/obj/Special_Spike (Executor.loc, Executor)
			A8:x += 15
			A8:Village = Executor.Village
			var/A9 = new/obj/Special_Spike (Executor.loc, Executor)
			A9:x += 17
			A9:Village = Executor.Village
		if(Executor.dir == WEST)
			var/A1 = new/obj/Special_Spike (Executor.loc, Executor)
			A1:x -= 1
			A1:Village = Executor.Village
			sleep(1)
			var/A2 = new/obj/Special_Spike (Executor.loc, Executor)
			A2:x -= 3
			A2:Village = Executor.Village
			sleep(1)
			var/A3 = new/obj/Special_Spike (Executor.loc, Executor)
			A3:x -= 5
			A3:Village = Executor.Village
			sleep(1)
			var/A4 = new/obj/Special_Spike (Executor.loc, Executor)
			A4:x -= 7
			A4:Village = Executor.Village
			sleep(1)
			var/A5 = new/obj/Special_Spike (Executor.loc, Executor)
			A5:x -= 9
			A5:Village = Executor.Village
			sleep(1)
			var/A6 = new/obj/Special_Spike (Executor.loc, Executor)
			A6:x -= 11
			A6:Village = Executor.Village
			sleep(1)
			var/A7 = new/obj/Special_Spike (Executor.loc, Executor)
			A7:x -= 13
			A7:Village = Executor.Village
			var/A8 = new/obj/Special_Spike (Executor.loc, Executor)
			A8:x -= 15
			A8:Village = Executor.Village
			var/A9 = new/obj/Special_Spike (Executor.loc, Executor)
			A9:x -= 17
			A9:Village = Executor.Village
	Explosive_Airwave()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.stop()
		Flick("Explosion", Executor)
		sleep(7)
		Executor.Execute_Jutsu("Wind Release.- Explosive Airwave!")
		var/A1 = new/obj/Wind_Splash (Executor.loc)
		A1:x += 2
		A1:Village = Executor.Village
		var/A2 = new/obj/Wind_Splash (Executor.loc)
		A2:x -= 1
		A2:Village = Executor.Village
		sleep(2.5)
		var/A3 = new/obj/Wind_Splash (Executor.loc)
		A3:x += 4
		A3:Village = Executor.Village
		var/A4 = new/obj/Wind_Splash (Executor.loc)
		A4:x -= 3
		A4:Village = Executor.Village
		sleep(2.5)
		var/A5 = new/obj/Wind_Splash (Executor.loc)
		A5:x += 6
		A5:Village = Executor.Village
		var/A6 = new/obj/Wind_Splash (Executor.loc)
		A6:x -= 5
		A6:Village = Executor.Village
		sleep(2.5)
		var/A7 = new/obj/Wind_Splash (Executor.loc)
		A7:x += 8
		A7:Village = Executor.Village
		var/A8 = new/obj/Wind_Splash (Executor.loc)
		A8:x -= 7
		A8:Village = Executor.Village
		sleep(2.5)
		var/A9 = new/obj/Wind_Splash (Executor.loc)
		A9:x += 10
		A9:Village = Executor.Village
		var/A10 = new/obj/Wind_Splash (Executor.loc)
		A10:x -= 9
		A10:Village = Executor.Village
		spawn(5)
			Executor.freeze --
			Executor.stop()
	Crystal_Wave()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.stop()
		Flick("punch4", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Crystal Release.- Wave!")
		var/A1 = new/obj/Crystal_Splash (Executor.loc)
		A1:x += 1
		A1:Village = Executor.Village
		var/A2 = new/obj/Crystal_Splash (Executor.loc)
		A2:x -= 1
		A2:Village = Executor.Village
		sleep(2.5)
		var/A3 = new/obj/Crystal_Splash (Executor.loc)
		A3:x += 3
		A3:Village = Executor.Village
		var/A4 = new/obj/Crystal_Splash (Executor.loc)
		A4:x -= 3
		A4:Village = Executor.Village
		sleep(2.5)
		var/A5 = new/obj/Crystal_Splash (Executor.loc)
		A5:x += 5
		A5:Village = Executor.Village
		var/A6 = new/obj/Crystal_Splash (Executor.loc)
		A6:x -= 5
		A6:Village = Executor.Village
		sleep(2.5)
		var/A7 = new/obj/Crystal_Splash (Executor.loc)
		A7:x += 7
		A7:Village = Executor.Village
		var/A8 = new/obj/Crystal_Splash (Executor.loc)
		A8:x -= 7
		A8:Village = Executor.Village
		sleep(2.5)
		var/A9 = new/obj/Crystal_Splash (Executor.loc)
		A9:x += 9
		A9:Village = Executor.Village
		var/A10 = new/obj/Crystal_Splash (Executor.loc)
		A10:x -= 9
		A10:Village = Executor.Village
		spawn(15)
			Executor.freeze --
			Executor.stop()
	Rock_Smash()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(7)
		Executor.Execute_Jutsu("Rock Smash!")
		var/A1 = new/obj/Rock_Splash (Executor.loc)
		A1:x += 1
		A1:Village = Executor.Village
		var/A2 = new/obj/Rock_Splash (Executor.loc)
		A2:x -= 1
		A2:Village = Executor.Village
		sleep(2.5)
		var/A3 = new/obj/Rock_Splash (Executor.loc)
		A3:x += 3
		A3:Village = Executor.Village
		var/A4 = new/obj/Rock_Splash (Executor.loc)
		A4:x -= 3
		A4:Village = Executor.Village
		sleep(2.5)
		var/A5 = new/obj/Rock_Splash (Executor.loc)
		A5:x += 5
		A5:Village = Executor.Village
		var/A6 = new/obj/Rock_Splash (Executor.loc)
		A6:x -= 5
		A6:Village = Executor.Village
		sleep(2.5)
		var/A7 = new/obj/Rock_Splash (Executor.loc)
		A7:x += 7
		A7:Village = Executor.Village
		var/A8 = new/obj/Rock_Splash (Executor.loc)
		A8:x -= 7
		A8:Village = Executor.Village
		sleep(2.5)
		var/A9 = new/obj/Rock_Splash (Executor.loc)
		A9:x += 9
		A9:Village = Executor.Village
		var/A10 = new/obj/Rock_Splash (Executor.loc)
		A10:x -= 9
		A10:Village = Executor.Village
		spawn(10)
			Executor.freeze --
			Executor.stop()
	Water_Splash()
		src.On_Ground = 1
		var/mob/Executor = loc
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		spawn(6)
			Executor.freeze --
			Executor.stop()
		Executor.Execute_Jutsu("Water Splash!")
		var/A1 = new/obj/Water_Splash (Executor.loc)
		A1:x += 1
		A1:Village = Executor.Village
		var/A2 = new/obj/Water_Splash (Executor.loc)
		A2:x -= 1
		A2:Village = Executor.Village
		sleep(2.5)
		if(!Executor.loc) return
		var/A3 = new/obj/Water_Splash (Executor.loc)
		A3:x += 3
		A3:Village = Executor.Village
		var/A4 = new/obj/Water_Splash (Executor.loc)
		A4:x -= 3
		A4:Village = Executor.Village
		sleep(2.5)
		if(!Executor.loc) return
		var/A5 = new/obj/Water_Splash (Executor.loc)
		A5:x += 5
		A5:Village = Executor.Village
		var/A6 = new/obj/Water_Splash (Executor.loc)
		A6:x -= 5
		A6:Village = Executor.Village
		sleep(2.5)
		if(!Executor.loc) return
		var/A7 = new/obj/Water_Splash (Executor.loc)
		A7:x += 7
		A7:Village = Executor.Village
		var/A8 = new/obj/Water_Splash (Executor.loc)
		A8:x -= 7
		A8:Village = Executor.Village
		sleep(2.5)
		if(!Executor.loc) return
		var/A9 = new/obj/Water_Splash (Executor.loc)
		A9:x += 9
		A9:Village = Executor.Village
		var/A10 = new/obj/Water_Splash (Executor.loc)
		A10:x -= 9
		A10:Village = Executor.Village


obj/proc
	Underground_Snake_Swamp()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == "Snake Swamp")
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Underground Snake Swamp! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Underground Snake Swamp! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = "Snake Swamp"

	Underground_Snake_Swamp_X(mob/M)
		var/mob/Executor = usr
		src.Hit_Execute = 1
		if(!M) return
		if(!Executor.Remembered_Spot)
			Executor<<"<b><font color=red><u>You have to remember a spot first!</u>"
			return
		if(Executor.Can_Execute(src, 60) == 0) return

		for(var/obj/Jutsus/Underground_Snake_Swamp/J in Executor) spawn() J.Delay(15)
		for(var/obj/Jutsus/Striking_Shadow_Snakes/J in Executor) spawn() J.Delay(10)
		for(var/obj/Jutsus/Snake_Summoning/J in Executor) spawn() J.Delay(13)
		for(var/obj/Jutsus/Snake_Grasp/J in Executor) spawn() J.Delay(13)
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		M.Dragonned = 1
		M.freeze ++
		M.stop()
		spawn()
			if(Executor.dir == EAST) Executor.step_x += 12
			else Executor.step_x -= 12
			new/obj/Effects/Anko_Special (Executor.loc, Executor)
			Executor.Execute_Jutsu("Underground Snake Swamp!")
			spawn(8.75)
				M.Damage(Executor, 40+rand(0,5), 1, 0)
				M.Poison_Proc(7, Executor.name)
			spawn(13)
				M.loc = Executor.Remembered_Spot
				Executor.loc = Executor.Remembered_Spot
				Executor.Substitution_Action()
				M.Dragonned = 0
				M.freeze --
				M.stop()

	Susanoo_Crushing_Grip()
		var/mob/Executor = usr
		if(Delay || Executor.Shield_) return
		if(Executor.Activated == 697)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Susanoo's Crushing Grip! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Susanoo's Crushing Grip! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 697

	Susanoo_Crushing_Grip_X(mob/M)
		var/mob/Executor = usr
		src.Hit_Execute = 1
		if(!M) return
		if(Executor.Can_Execute(src, 90) == 0) return
		for(var/obj/Jutsus/Susanoo_Crushing_Grip/J in Executor) spawn() J.Delay(25)
		for(var/obj/Jutsus/Chidori_Senbon/J in Executor) spawn() J.Delay(5)
		for(var/obj/Jutsus/Fire_Dragon_EMS/J in Executor) spawn() J.Delay(5)
		for(var/obj/Jutsus/Chidori_EMS/J in Executor) spawn() J.Delay(5)
		for(var/obj/Jutsus/Chidori_Stab/J in Executor) spawn() J.Delay(5)

		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.CanMove = 0
		Executor.freeze ++
		M.CanMove = 0
		M.freeze ++
		spawn()
			Executor.Doming = 1
			Executor.icon_state = "Amaterasu Hand"
			sleep(5)
			var/obj/A = new/obj/Susanoo_Arm (M.loc)
			Executor.CanMove = 0
			Executor.stop()
			M.CanMove = 0
			A.step_x = M.step_x
			A:dir = Executor.dir
			if(Executor.dir == EAST) A.pixel_x = -40
			if(Executor.dir == WEST) A.pixel_x = 4
			spawn(6.5)
				Executor.Execute_Jutsu("Susanoo's Crushing Grip!")
				new/obj/Hit (M.loc)
				Flick("hurt", M)
				M.icon_state = "hurt"
				M.HP -= 45
				spawn(16.5) Executor.Execute_Jutsu("Susanoo's Crushing Release!")
				spawn(17.5)
					Executor.Doming = 0
					Executor.Dragonned = 0
					Executor.CanMove = 1
					Executor.freeze --
					Executor.stop()
					M.CanMove = 1
					M.freeze --
					M.Blinded = 0
	Chibaku_Tensei()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Can_Execute(src, 90) == 0) return
		if(Executor.Activated == 1970)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Summon Deva Path: Chibaku Tensei! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Summon Deva Path: Chibaku Tensei! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 1970

	Chibaku_Tensei_X(mob/M)
		var/mob/Executor = usr
		src.Hit_Execute = 1
		if(!M) return
		if(Executor.Can_Execute(src, 100) == 0) return
		for(var/obj/Jutsus/Chibaku_Tensei/J in Executor) spawn() J.Delay(60)
		Executor.Activated = 0
		Executor.Dragonned = 1
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		spawn()
			Executor.layer = M.layer +1
			Executor.CanMove = 0
			Executor.stop()
			M.CanMove = 0
			Executor.pixel_y -= 10
			Flick("Summon X", Executor)
			spawn(13) Executor.pixel_y = 0
			sleep(3)
			Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Deva Path: Chibaku Tensei!")
			spawn(5.25)
				var/Pein = new/obj/Chibaku_Pein (M.loc)
				if(Executor.dir == EAST)
					Pein:x += 2
					Pein:dir = WEST
				if(Executor.dir == WEST)
					Pein:x -= 2
					Pein:dir = EAST
				Executor.CanMove = 0
				M.CanMove = 0

				spawn(5)
					M.y += 5
					var/Chibaku = new/obj/Chibaku (M.loc)
					Chibaku:pixel_x = M.pixel_x
					if(Executor.dir == EAST) Chibaku:pixel_x -= 50
					if(Executor.dir == WEST) Chibaku:pixel_x -= 40
					Chibaku:pixel_y -= 60
					Chibaku:dir = Executor.dir
					spawn(3)
						var/Layer = M.layer
						M.layer = 0
						Executor.CanMove = 0
						M.CanMove = 0
						Flick("hurt", M)
						new/obj/Hit (M.loc)
						M.HP -= rand(9, 11.5)
						spawn(2.5)
							new/obj/Hit (M.loc)
							M.HP -= rand(9, 11.5)
						spawn(5)
							new/obj/Hit (M.loc)
							M.HP -= rand(9, 11.5)
						spawn(7.5)
							new/obj/Hit (M.loc)
							M.HP -= rand(9, 11.5)
						spawn(10)
							new/obj/Hit (M.loc)
							M.HP -= rand(9, 11.5)
						spawn(12.5)
							new/obj/Hit (M.loc)
							M.HP -= rand(9, 11.5)
						spawn(15)
							M.layer = Layer
							Executor.Dragonned = 0
							Executor.CanMove = 1
							Executor.freeze --
							M.Dragonned = 0
							M.CanMove = 1
							M.freeze --
							new/obj/Hit (M.loc)
							M.HP -= rand(9, 11.5)
							if(Executor.dir == EAST) M.knockbackeastx()
							if(Executor.dir == WEST) M.knockbackwestx()
							if(Chibaku) del(Chibaku)
							M.Death_Check(Executor)
	Scythe_Summoning()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 9742)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Scythe Summoning! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Scythe Summoning! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 9742

	Scythe_Summoning_(mob/M)
		var/mob/Executor = usr
		src.Hit_Execute = 1
		if(!M) return
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.layer = M.layer +1
		Executor.client.perspective = EYE_PERSPECTIVE
		Executor.client.eye = M
		Executor.Activated = 0
		Executor.Dragonned = 1
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		Executor.invisibility = 101
		new/obj/Effects/Tenten (M.loc, M, Executor.dir, Executor)
		Executor.Execute_Jutsu("Scythe Summoning!")
		spawn(10)
			M.Dragonned = 0
			M.CanMove = 1
			M.freeze --
			M.stop()
			M.Damage(Executor, 40, 1, 2, 0, 1)
	Special_Combo_SA()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 1971)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated ANBU Team.- Ultimate Combo! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated ANBU Team.- Ultimate Combo! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 1971

	Special_Combo_SA_X(mob/M)
		var/mob/Executor = usr
		src.Hit_Execute = 1
		if(!M) return
		if(Executor.Can_Execute(src, 90) == 0) return
		var/Real_Loc = Executor.loc
		var/Damage = 9
		Executor.layer = M.layer +1
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = M
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.Checked_X = 0
		M.Comboed = 1
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		if(Executor.dir == WEST) Executor.pixel_x -= 20
		Executor.pixel_y -= 12
		Executor.freeze ++
		Flick("Special", Executor)
		if(Executor.dir == EAST) Executor.x -= 2
		if(Executor.dir == WEST) Executor.x += 2
		spawn(9)
			Executor.Execute_Jutsu("ANBU Team.- Ultimate Combo!")
			var/A1 = new/obj/Anbu_1 (M.loc)
			A1:pixel_x = M.pixel_x
			A1:pixel_y = M.pixel_y
			A1:dir = Executor.dir
			if(Executor.dir == EAST) A1:x --
			if(Executor.dir == WEST) A1:x ++
			M.CanMove = 0
			Executor.CanMove = 0
			spawn(5)
				M.CanMove = 1
				M.freeze --
				new/obj/Hit (M.loc)
				Flick("hurt", M)
				M.HP -= Damage
				if(Executor.dir == EAST) M.knockbackeast()
				if(Executor.dir == WEST) M.knockbackwest()
			spawn(9)
				M.CanMove = 0
				M.freeze ++
				var/A2 = new/obj/Anbu_2 (M.loc)
				A2:pixel_x = M.pixel_x
				A2:pixel_y = M.pixel_y
				A2:dir = Executor.dir
				A2:y --
				if(Executor.dir == EAST) A2:x ++
				if(Executor.dir == EAST) A2:x --
			spawn(14.5)
				M.CanMove = 1
				M.freeze --
				new/obj/Hit (M.loc)
				Flick("hurt", M)
				M.HP -= Damage
				M.vel_y = 15
			spawn(21.25)
				M.CanMove = 0
				M.freeze ++
				var/A3 = new/obj/Anbu_3 (M.loc)
				A3:pixel_x = M.pixel_x
				A3:pixel_y = M.pixel_y
				A3:y ++
				A3:dir = Executor.dir
				if(Executor.dir == EAST) A3:x ++
				if(Executor.dir == WEST) A3:x --
			spawn(26.25)
				M.CanMove = 1
				M.freeze --
				new/obj/Hit (M.loc)
				Flick("hurt", M)
				M.HP -= Damage
				if(Executor.dir == EAST) M.knockbackwest()
				if(Executor.dir == WEST) M.knockbackeast()
			spawn(32.25)
				M.CanMove = 0
				M.freeze ++
				var/A4 = new/obj/Anbu_4 (M.loc)
				A4:pixel_x = M.pixel_x
				A4:pixel_y = M.pixel_y
				if(Executor.dir == EAST)
					A4:dir = WEST
					A4:x --
				if(Executor.dir == WEST)
					A4:dir = EAST
					A4:x ++
			spawn(37.75)
				M.CanMove = 1
				M.freeze --
				new/obj/Hit (M.loc)
				Flick("hurt", M)
				M.HP -= Damage
				if(Executor.dir == EAST) M.knockbackeast()
				if(Executor.dir == WEST) M.knockbackwest()
			spawn(45.5)
				M.CanMove = 0
				M.freeze ++
				Executor.loc = M.loc
				Executor.Substitution = 1
				Executor.density = 0
				var/Check = 0
				if(Executor.dir == EAST && !Check)
					Check = 1
					Executor.x ++
					Executor.dir = WEST
				if(Executor.dir == WEST && !Check)
					Check = 1
					Executor.x --
					Executor.dir = EAST
				Flick("Special 2", Executor)
			spawn(49.5)
				M.CanMove = 1
				M.freeze --
				new/obj/Hit (M.loc)
				Flick("hurt", M)
				M.HP -= Damage
				if(Executor.dir == EAST) M.knockbackeast()
				if(Executor.dir == WEST) M.knockbackwest()
			spawn(52.5)
				Executor.pixel_x = 0
				M.CanMove = 0
				M.freeze ++
				var/A5 = new/obj/Anbu_5 (M.loc)
				A5:pixel_x = M.pixel_x
				A5:pixel_y = M.pixel_y
				A5:dir = Executor.dir
				if(Executor.dir == EAST) A5:x ++
				if(Executor.dir == WEST) A5:x --
				spawn(5)
					M.CanMove = 1
					M.freeze --
					new/obj/Hit (M.loc)
					Flick("hurt", M)
					M.HP -= Damage
					if(A5:dir == EAST) M.knockbackwest()
					if(A5:dir == WEST) M.knockbackeast()
			spawn(60.5)
				for(var/obj/Jutsus/Special_Combo_SA/J in Executor) spawn() J.Delay(45)
				Executor.Substitution = 0
				Executor.density = 1
				Executor.client:perspective = MOB_PERSPECTIVE
				Executor.client:eye = Executor
				var/Check = 0
				if(Executor.dir == EAST && !Check)
					Check = 1
					Executor.dir = WEST
				if(Executor.dir == WEST && !Check)
					Check = 1
					Executor.dir = EAST
				Executor.Checked_X = 0
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.loc = Real_Loc
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				M.Dragonned = 0
				M.Comboed = 0
				M.Death_Check(Executor)

	Special_Combo_E1()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 1969)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Special Combo! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Special Combo! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 1969

	Special_Combo_E1_X(mob/M)
		var/mob/Executor = usr
		src.Hit_Execute = 1
		if(!M) return
		if(Executor.Can_Execute(src, 75) == 0) return
		for(var/obj/Jutsus/Special_Combo_E1/J in Executor) spawn() J.Delay(30)
		var/Speed_Multiplier = M.speed_multiplier
		var/Move_Speed = M.move_speed
		var/Real_Loc = Executor.loc
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = M
		M.move_speed = 0
		M.speed_multiplier = 0
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.pixel_y -= 5
		Executor.Checked_X = 0
		M.fall_speed = 0
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		if(Executor.dir == EAST) Executor.x --
		if(Executor.dir == WEST) Executor.x ++
		spawn(37.75) if(M) M.fall_speed = 20
		spawn()
			Executor.layer = M.layer +1
			M.move_speed = 0
			M.speed_multiplier = 0
			Executor.CanMove = 0
			Executor.freeze ++
			Executor.stop()
			Flick("GO", Executor)
			sleep(7)
			Executor.Execute_Jutsu("Special Combo!")
			Executor.Substitution = 1
			Executor.density = 0
			spawn(5.25)
				if(Executor.dir == EAST) M.dir = WEST
				if(Executor.dir == WEST) M.dir = EAST
				M.Dragonned = 1
				M.CanMove = 1
				M.freeze --
				M.move_speed = 0
				M.speed_multiplier = 0
				Flick("hurt", M)
				M.fall_speed = 0
				new/obj/Hit (M.loc)
				Executor.Dragonned = 1
				Executor.CanMove = 0
				M.HP -= rand(15,17.5)
				M.vel_y = 15
				spawn(1.75)
					Executor.loc = M.loc
					if(Executor.dir == EAST) Executor.x ++
					if(Executor.dir == WEST) Executor.x --

				spawn(6.25)
					if(Executor.dir == EAST) M.dir = WEST
					if(Executor.dir == WEST) M.dir = EAST
					M.Dragonned = 1
					M.move_speed = Move_Speed
					M.speed_multiplier = Speed_Multiplier
					Flick("hurt", M)
					M.fall_speed = 0
					new/obj/Hit (M.loc)
					Executor.Dragonned = 1
					Executor.CanMove = 0
					M.HP -= rand(12.5,15)
					if(Executor.dir == EAST) M.vel_x -= 10
					if(Executor.dir == WEST) M.vel_x += 10
					spawn(5.75)
						Executor.loc = M.loc
						Executor.y ++
						if(Executor.dir == EAST) Executor.x --
						if(Executor.dir == WEST) Executor.x ++
						spawn(3.25)
							if(Executor.dir == EAST) M.dir = WEST
							if(Executor.dir == WEST) M.dir = EAST
							M.Dragonned = 1
							M.move_speed = Move_Speed
							M.speed_multiplier = Speed_Multiplier
							Flick("hurt", M)
							M.fall_speed = 0
							spawn(10.25)
								M.fall_speed = 0
								M.Death_Check(Executor)
							new/obj/Hit (M.loc)
							Executor.Dragonned = 1
							Executor.CanMove = 0
							M.HP -= rand(12.5,15)
							if(Executor.dir == EAST) M.knockbackeast()
							if(Executor.dir == WEST) M.knockbackwest()
							spawn(1.75)
								Executor.pixel_y = 0
								Executor.Checked_X = 1
								Executor.loc = Real_Loc
								Executor.layer = 100
								Executor.client:perspective = MOB_PERSPECTIVE
								Executor.client:eye = Executor
								Executor.Substitution = 0
								Executor.density = 1
							spawn(9.75)
								Executor.Dragonned = 0
								Executor.CanMove = 1
								Executor.freeze --
								M.Dragonned = 0
	Lava_Shoot()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 85)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Lava Shoot! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Lava Shoot! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 85

	Lava_Shoot_X(mob/M)
		var/mob/Executor = usr
		src.Hit_Execute = 1
		if(!M) return
		if(Executor.Can_Execute(src, 90) == 0) return
		for(var/obj/Jutsus/Lava_Shoot/J in Executor) spawn() J.Delay(20)
		Executor.Activated = 0
		Executor.Dragonned = 1
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		Executor.y = M.y
		Executor.y += 2
		Executor.pixel_y = M.pixel_y
		Executor.pixel_y -= 26
		if(Executor.dir==EAST) Executor.x = M.x-3
		if(Executor.dir==WEST)
			Executor.x = M.x+2
			Executor.pixel_x -= 18
		spawn()
			if(Executor && M)
				Executor.CanMove = 0
				Executor.freeze ++
				Executor.stop()
				Flick("Dragon", Executor)
				M.CanMove = 0
				spawn(6.5)
					if(Executor && M)

						if(M)
							M.CanMove = 0
							Executor.Execute_Jutsu("Lava Shoot!")
							spawn(2)
								Flick("hurt", M)
								M.HP -= 45
								new/obj/Hit (M.loc)
								spawn(1.5)
									Executor.pixel_y = 0
									Executor.pixel_x = 0
									Executor.Dragonned = 0
									Executor.CanMove = 1
									Executor.freeze --
									M.CanMove = 1
									M.freeze --
									M.Dragonned = 0
									if(Executor.dir == EAST) M.knockbackeast()
									if(Executor.dir == WEST) M.knockbackwest()

	Flaming_Dragon()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 6)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Flaming Dragon! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Flaming Dragon! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 6

	Flaming_Dragon_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 100) == 0) return
		if(Executor.Sharingan == 0)
			Executor<<output("<b><font color=red><u>You must activate Sharingan!</u></center></font></b>","Chat")
			return
		for(var/obj/Jutsus/Flaming_Dragon/J in Executor) spawn() J.Delay(20)
		for(var/obj/Jutsus/Obito_Combo/J in Executor) spawn() J.Delay(7)
		Executor.Activated = 0
		Executor.Dragonned = 1
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		Executor.y = M.y
		if(Executor.dir==EAST) Executor.x = M.x-3
		if(Executor.dir==WEST) Executor.x = M.x+3
		Executor.vel_y = 15
		spawn(5)
			if(Executor && M)
				Executor.CanMove = 0
				Executor.freeze ++
				Executor.stop()
				M.CanMove = 0
				Flick("Dragon", Executor)
				spawn(5)
					if(Executor && M)
						if(M)
							M.CanMove = 0
							Executor.Execute_Jutsu("Flaming Dragon!")
							var/D = new/obj/Flaming_Dragon ()
							D:Owner = Executor
							D:Village = Executor.Village
							D:dir = Executor.dir
							D:loc = M.loc
							spawn(8)
								M.CanMove = 1
								M.freeze --
								M.Dragonned = 0
								spawn(7)
									Executor.Dragonned = 0
									Executor.CanMove = 1
									Executor.freeze --


	Black_Ant()
		var/mob/Executor = usr
		src.Tournament_GoingOn = 1
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Ant) return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.WoodCD) return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay) return
		if(Executor.Cha < 35)
			Executor.Cooldown_Display (35)
			return
		Executor.WoodCD = 1
		var/list/choose = list()
		for(var/mob/M in view(15))
			if(M.Real && M.Real_C == 1 && M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village && !M.Boss) choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		spawn(300) Executor.WoodCD = 0
		var/mob/M = input(Executor,"Who to use this jutsu on?", "Kuchiyose No Jutsu.- Black Ant") as null|anything in choose
		if(!M || M == "Cancel" || Executor.knocked || Executor.freeze || Executor.Dragonned || Delay)
			Executor.WoodCD = 0
			return
		if(M.Gates || M.Boulder || M.BoulderX || M.knocked || M.Real_C == 0 || M.Dragonned || M.Substitution || M.Village == Executor.Village || M.Boss)
			Executor.WoodCD = 0
			return
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Ant) return
		if(Executor.Can_Execute(src, 25) == 0) return
		Executor.WoodCD = 0
		Flick("scroll", Executor)
		M.freeze ++
		M.Dragonned = 1
		Executor.freeze ++
		spawn(7) Executor.freeze --
		spawn(6.5)
			M.Black_Ant(Executor)
			Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Black Ant!")


	Tsukuyomi()
		var/mob/Executor = usr
		src.Tournament_GoingOn = 1
		if(CTD || Executor.NEM_Round.Mode == "Arena") return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.WoodCD) return
		if(Executor.CanUseTsu >= 3)
			Executor<<output("<b><font color=red><u>Tsukuyomi can only be used three times per round!</u></center></font>", "Chat")
			return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay) return
		if(Executor.Cha < 100)
			Executor.Cooldown_Display (100)
			return
		Executor.WoodCD = 1
		var/list/choose=list()
		for(var/mob/M in view(15))
			if(M.Real && M.Real_C == 1 && M.client && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village && !M.Boss) choose.Add(M)
		spawn(300) Executor.WoodCD = 0
		var/mob/M=input(Executor,"Who to use Tsukuyomi on?", "Tsukuyomi") as null|anything in choose
		if(!M || Executor.knocked || Executor.freeze || Executor.Dragonned || Delay)
			Executor.WoodCD = 0
			return
		if(M.Gates || M.Boulder || M.BoulderX || M.knocked || M.Real_C == 0 || M.Dragonned || M.Village == Executor.Village || M.Boss)
			Executor.WoodCD = 0
			return
		Executor.WoodCD = 0
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(60)
		Executor.CanUseTsu ++
		Flick("tsukuyomi2", Executor)
		Executor.freeze ++
		spawn(5) Executor.freeze --
		Executor.Execute_Jutsu("Tsukuyomi!")
		M.Tsukuyomi_Effect()



	Absolute_Control()
		var/mob/Executor = usr
		src.Tournament_GoingOn = 1
		src.Capture_The_Flag = 1
		if(Boss_Mode) return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay) return
		if(Executor.Cha < 135)
			Executor.Cooldown_Display (135)
			return
		if(Executor.WoodCD) return
		if(Executor.CanUseTsu >= 1)
			Executor<<output("<b><font color=red><u>Sharingan Techique: Absolute Control can only be used once per round!</u></center></font>", "Chat")
			return
		Executor.WoodCD = 1
		var/list/choose=list()
		for(var/mob/M in view(15))
			if(M.Real && M.Real_C == 1 && M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village == "Leaf" && !M.Boss && !M.Edo) choose.Add(M)
		spawn(30) Executor.WoodCD = 0
		var/mob/M = input(Executor,"Who to use Sharingan Techique: Absolute Control on?", "Sharingan Techique: Absolute Control") as null|anything in choose
		if(!M || !M.client || Executor.knocked || Executor.freeze || Executor.Dragonned || Delay)
			Executor.WoodCD = 0
			return
		if(M.Gates || M.Boulder || M.BoulderX || M.knocked || M.Real_C == 0 || M.Dragonned || M.Village == Executor.Village || M.Boss || M.Edo)
			Executor.WoodCD = 0
			return
		Executor.WoodCD = 0
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		var/P1 = 0
		for(var/mob/M1) if(M1.NEM_Round && M1.NEM_Round == M.NEM_Round && M1.Village == M1.Village && M1.client && !M1.dead) P1++
		if(P1 == 1) {Executor<<"<b><font color=red><u>This jutsu can only be used when there's more than 1 enemy ninja alive!</u>"; return}
		if(Executor.Can_Execute(src, 135) == 0) return
		Delay(300)
		Executor.CanUseTsu ++
		Flick("tsukuyomi2", Executor)
		Executor.freeze ++
		spawn(5) Executor.freeze --
		Executor.Execute_Jutsu("Sharingan Techique: Absolute Control!")
		Executor.NEM_Round.Shout("<font color=#A816BF><b><center><font size=3>With this power... I  shall take revenge on the Leaf!!!")
		for(var/mob/Ultimate_Projectile/U) if(U.Projectile_Owner == M) U.Allies = "Akatsuki"
		M.Changed_Village = 1
		M.NEM_Side.Ninjas --
		Executor.NEM_Side.Ninjas ++
		spawn() Check_Winner(Executor.NEM_Round)
		M.Village = "Akatsuki"
		M.NEM_Side = Executor.NEM_Side
		M.overlays+='Graphics/Skills/Genjutsu.dmi'

	Ninken_II()
		var/mob/Executor = usr
		if(Executor.WoodCD) return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay) return
		if(Executor.Cha < 65)
			Executor.Cooldown_Display (65)
			return
		Executor.WoodCD = 1
		var/list/choose=list()
		for(var/mob/M in view(15))
			if(M.Real && M.Real_C == 1 && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village && !M.Boss) choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		spawn(300) Executor.WoodCD = 0
		var/mob/M=input(Executor,"Who to use this jutsu on?", "Ninja Hounds") as null|anything in choose
		if(!M || M == "Cancel" || Executor.knocked || Executor.freeze || Executor.Dragonned || Delay)
			Executor.WoodCD = 0
			return
		if(M.Gates || M.Boulder || M.BoulderX || M.knocked || M.Real_C == 0 || M.Dragonned || M.Village == Executor.Village || M.Boss)
			Executor.WoodCD = 0
			return
		Executor.WoodCD = 0
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Can_Execute(src, 65) == 0) return
		Executor.freeze ++
		new/obj/Effects/Ninken_IV (Executor.loc, Executor)
		sleep(9.50)

		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Ninja Hounds!")
		if(M.Dodging)
			Delay(15)
			M.Auto_Dodge (Executor)
			Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
		else
			Delay(30)
			M.freeze ++
			var/N = new/obj/Effects/Ninken_III (M.loc, M)
			spawn(1.50) M.Damage(Executor, 5, 1, 0, 0, 1)
			spawn(16.75) del(N)
			spawn(rand(23, 28))
				M.freeze --
				M.stop()

	Kamui_()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.WoodCD) return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay) return
		if(Executor.Cha < 25)
			Executor.Cooldown_Display (25)
			return
		Executor.WoodCD = 1
		var/list/choose=list()
		if(Executor.Kamui) choose.Add("~Return~ [Executor.name]")
		else for(var/mob/M in Executor.RT) choose.Add("~Return~ [M]")
		for(var/mob/M in view(15)) if(M.Real && M.Real_C == 1 && !M.Gates && !M.Boulder && !M.BoulderX && !M.Dragonned && M.Village == Executor.Village && !M.Boss && !M.Kamui) choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		spawn(300) Executor.WoodCD = 0
		var/mob/M=input(Executor,"Who to use this jutsu on?", "Kamui Dimension") as null|anything in choose
		if(!M || M == "Cancel" || Executor.knocked || Executor.freeze || Executor.Dragonned || Delay)
			Executor.WoodCD = 0
			return
		if(ismob(M)) if(M.Gates || M.Boulder || M.BoulderX || M.knocked || M.Real_C == 0 || M.Dragonned || M.Boss)
			Executor.WoodCD = 0
			return
		Executor.WoodCD = 0
		if(ismob(M)) if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(7)
		Executor.freeze ++
		Flick("mob-shooting", Executor)

		spawn(3.50)
			Executor.freeze --
			Executor.stop()

		sleep(2.50)
		Executor.Execute_Jutsu("Kamui Dimension!")

		if(findtext(M, "~Return~"))
			M = copytext(M, 10)
			for(var/mob/F in world) if(F.Kamui && F.name == M)
				if(F == Executor)
					Executor.Kamui = 0
					var/P = new/obj/Portal (Executor.loc)
					P:dir = Executor.dir
					Executor.RT.Remove(Executor)
					Executor.loc = Executor.Remembered_Location
					Flick("teleport", Executor)
				else
					var/P = new/obj/Portal (F.loc)
					P:dir = F.dir
					F.Kamui = 0
					F.density = 0
					F.loc = Executor.loc
					F.set_pos (Executor.px, Executor.py)
					Executor.RT.Remove(F)
					spawn(5) F.density = 1
					spawn(1)
						F.vel_y = 5
						if(F.dir == WEST) F.knockbackwest()
						if(F.dir == EAST) F.knockbackeast()
						Executor.NEM_Round.Shout("<b><font color=#710093><u>[Executor.name] has nullified [F.name]'s Kamui!</u>")

		else
			if(M == Executor)
				if(M.Kamui) return
				Executor.Remembered_Location = Executor.loc
			var/P = new/obj/Portal (M.loc)
			P:dir = Executor.dir
			M.freeze ++
			M.Dragonned = 1

			sleep(3)

			Executor.RT.Add(M)
			M.CanBeRevived = 0
			M.Dragonned = 0
			M.Kamui = 1
			M.freeze --
			M.stop()
			for(var/obj/Tobi/T in world)
				var/N = new/obj/Portal ()
				N:loc = T.loc
				M.loc = T.loc
				if(dir == EAST)
					N:dir = EAST
					M:knockbackeast()
				if(dir == WEST)
					N:dir = WEST
					M.knockbackwest()

	Devouring_Snakes()
		var/mob/Executor = usr
		if(Executor.WoodCD) return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay) return
		if(Executor.Cha < 45)
			Executor.Cooldown_Display (45)
			return
		Executor.WoodCD = 1
		var/list/choose=list()
		for(var/mob/M in view(15))
			if(M.Real && M.Real_C == 1 && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village && !M.Boss) choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		spawn(300) Executor.WoodCD = 0
		var/mob/M=input(Executor,"Who to use this jutsu on?", "Devouring Snakes") as null|anything in choose
		if(!M || M == "Cancel" || Executor.knocked || Executor.freeze || Executor.Dragonned || Delay)
			Executor.WoodCD = 0
			return
		if(M.Gates || M.Boulder || M.BoulderX || M.knocked || M.Real_C == 0 || M.Dragonned || M.Village == Executor.Village || M.Boss)
			Executor.WoodCD = 0
			return
		Executor.WoodCD = 0
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Can_Execute(src, 45) == 0) return
		Executor.freeze ++
		Flick("Seals", Executor)
		sleep(2.50)
		Executor.freeze --
		Executor.stop()

		Executor.Execute_Jutsu("Devouring Snakes!")
		if(M.Dodging)
			Delay(15)
			for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(5)
			for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(5)
			M.Auto_Dodge (Executor)
			Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
		else
			Delay(25)
			for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(7)
			for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(7)
			M.freeze ++
			M.Dragonned = 1
			new/obj/Effects/Devouring_Snakes (M.loc, M)
			spawn(2.75)
				M.Damage(Executor, rand(30, 40), 1, 0, 0, 1)
				M.Poison_Proc (5, Executor.name)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.vel_y = 12

	Feather_Illusion()
		var/mob/Executor = usr
		if(Executor.WoodCD) return
		if(Executor.CanUseTsu>10)
			Executor<<output("<b><font color=red><u>Feather Illusion can only be used ten times per round!</u></center></font>", "Chat")
			return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay) return
		if(Executor.Cha < 100)
			Executor.Cooldown_Display (100)
			return
		Executor.WoodCD = 1
		var/list/choose=list()
		for(var/mob/M in view(15))
			if(M.Real && M.Real_C == 1 && M.client && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village && !M.Boss) choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		spawn(300) Executor.WoodCD = 0
		var/mob/M=input(Executor,"Who to use Feather Illusion on?", "Feather Illusion") as null|anything in choose
		if(!M || M == "Cancel" || Executor.knocked || Executor.freeze || Executor.Dragonned || Delay)
			Executor.WoodCD = 0
			return
		if(M.Gates || M.Boulder || M.BoulderX || M.knocked || M.Real_C == 0 || M.Dragonned || M.Village == Executor.Village || M.Boss)
			Executor.WoodCD = 0
			return
		Executor.WoodCD = 0
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(60)
		Executor.CanUseTsu ++
		Flick("mob-shooting", Executor)
		Executor.freeze ++
		spawn(5) Executor.freeze --
		Executor.Execute_Jutsu("Feather Illusion!")
		if(Executor.name != "Kabutomaru") M.Feather_Effect(Executor)
		if(Executor.name == "Kabutomaru") M.Feather_Effect_X(Executor)




	Sharingan_Genjutsu()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 696)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Sharingan Genjutsu! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.Intangible || Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Sharingan Genjutsu! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 696



	Sharingan_Genjutsu_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		if(!M) return
		for(var/obj/Jutsus/Sharingan_Genjutsu/J in Executor) spawn() J.Delay(15)
		var/Ended = 0
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.layer = 150
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		M.CanMove = 0
		M.freeze ++
		M.stop()
		M.CanMove = 0
		spawn(2.5)
			if(!Ended)
				Executor.Dragonned = 1
				Executor.CanMove = 0
				Executor.stop()
				if(M)
					M.HP -= 35
					new/obj/Hit (M.loc)
					M.Dragonned = 0
					M.CanMove = 0
					M.stop()
				spawn(10)
					Executor.pixel_y = 0
					Executor.pixel_x = 0
					Flick("teleport", Executor)
					Executor.icon_state = "mob-standing"
					Executor.Dragonned = 0
					Executor.CanMove = 1
					Executor.freeze --
					Executor.stop()
					if(M)
						M.pixel_y = 0
						M.icon_state = "mob-standing"
						M.CanMove = 1
						M.freeze --
						M.stop()
						M.Death_Check(Executor)
		Flick("teleport", Executor)
		spawn(1)
			if(M)
				M.CanMove = 0
				Executor.CanMove = 0
				Executor.loc = M.loc
				Executor.pixel_x = M.pixel_x
				Executor.pixel_y = M.pixel_y
				if(Executor.dir == EAST)
					Executor.x --
					Executor.pixel_x += 20
					M.dir = WEST
				if(Executor.dir == WEST)
					Executor.pixel_x -=24
					Executor.x ++
					M.dir = EAST
		spawn(2)
			Executor.icon_state = "Sharingan Genjutsu"
			Flick("Sharingan Genjutsu", Executor)
			if(M)
				M.icon_state = "hurt"
				M.pixel_y = 24
				Executor.Execute_Jutsu("Sharingan Genjutsu!")
				M.CanMove = 0




	Chakra_Implosion()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 777)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Chakra Implosion! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Chakra Implosion! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 777



	Chakra_Implosion_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 55) == 0) return
		for(var/obj/Jutsus/Chakra_Implosion/J in Executor) spawn() J.Delay(15)
		Executor.Activated = 0
		Executor.Dragonned=1
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		M.Dragonned=1
		M.CanMove = 0
		M.freeze ++
		M.stop()
		spawn(5)
			Executor.Dragonned = 0
			Executor.CanMove = 1
			Executor.freeze --
			Executor.stop()
			if(M)
				M.HP -= 40
				new/obj/Hit (M.loc)
				M.Dragonned=0
				M.CanMove = 1
				M.freeze --
				M.stop()
				M.Death_Check(Executor)
				if(Executor.dir == EAST) M.knockbackeast()
				if(Executor.dir == WEST) M.knockbackeast()
		Flick("Release", Executor)
		var/R = new/obj/Release (Executor.loc)
		R:layer = Executor.layer+30
		R:pixel_x = Executor.pixel_x
		R:pixel_y = Executor.pixel_y
		spawn(3.5)
			if(M)
				Executor.Execute_Jutsu("Chakra Implosion!")
				M.CanMove = 0




	Sanbi_Hand()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 888)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Sanbi's Grasp! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Sanbi's Grasp! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 888


	Sanbi_Hand_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 80) == 0) return
		for(var/obj/Jutsus/Sanbi_Grasp/J in Executor) spawn() J.Delay(30)
		var/Last_Location = loc
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		M.CanMove = 0
		M.freeze ++
		M.stop()
		spawn(60)
			if(Last_Location)
				Flick("teleport", Executor)
				Executor.stop()
				Executor.loc = Last_Location
				Executor.check_loc()
			Executor.Dragonned = 0
			Executor.CanMove = 1
			Executor.freeze --
			Flick("teleport", Executor)
			if(M)
				M.icon_state = "mob-standing"
				M.CanMove = 1
				M.freeze --
				M.Death_Check(Executor)
		spawn(6)
			if(M)
				Executor.Execute_Jutsu("Bijuu Technique.- Sanbi's Grasp!")
				Executor.CanMove = 0
				M.CanMove = 0
				Flick("Hand", Executor)
				Executor.loc = M.loc
				if(Executor.dir == EAST) Executor.x -= 7
				if(Executor.dir == WEST) Executor.x += 4
				var/H = new/obj/Hand (Executor.loc)
				H:dir = Executor.dir
				H:pixel_y += 8
				if(Executor.dir == EAST) H:pixel_x += 194
				if(Executor.dir == WEST) H:pixel_x -= 113
				spawn(11)
					M.icon_state = "hurt"
					new/obj/Hit (M.loc)
					M.HP -= 30
				spawn(49)
					if(H) del(H)


	Claws()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 35)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Claws Strike! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Claws Strike! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 35

	Claws_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 75) == 0) return
		for(var/obj/Jutsus/Claws/J in Executor) spawn() J.Delay(20)
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		M.stop()
		spawn(5.5)
			spawn(2)
				Flick("teleport", Executor)
				Executor.layer = 100
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
			if(M)
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.stop()
				if(Executor.dir == EAST) M.knockbackeast()
				if(Executor.dir == WEST) M.knockbackwest()
				M.Death_Check(Executor)
		if(Executor.dir == EAST) Executor.pixel_x += 10
		if(Executor.dir == WEST) Executor.pixel_x -= 90
		spawn()
			Flick("Claws", Executor)
			if(M)
				Executor.Execute_Jutsu("Claws Strike!")
				Executor.layer = 125
				spawn(5.5)
					Flick("hurt", M)
					new/obj/Hit (M.loc)
					M.HP -= 55+rand(0,5)
					spawn(2)
						Executor.layer = 100
						Executor.Dragonned = 0
						Flick("teleport", Executor)
						Executor.layer = 100
						Executor.stop()
						if(M)
							M.Dragonned = 0
							M.Death_Check(Executor)
							M.stop()


	Beast_Tearing_Gale_Scratch()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 69)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Beast Tearing Gale Scratch! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Beast Tearing Gale Scratch! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 69

	Beast_Tearing_Gale_Scratch_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 50) == 0) return
		for(var/obj/Jutsus/Beast_Tearing_Gale_Scratch/J in Executor) spawn() J.Delay(20)
		for(var/obj/Jutsus/Beast_Tearing_Gale_Palm/J in Executor) spawn() J.Delay(10)
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		M.stop()
		spawn(9.5)
			spawn(2)
				Flick("teleport", Executor)
				Executor.layer = 100
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
			if(M)
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.stop()
				M.Death_Check(Executor)
				spawn()
					if(Executor.dir == EAST) M.knockbackeast()
					if(Executor.dir == WEST) M.knockbackwest()
		if(Executor.dir == EAST) Executor.pixel_x += 40
		if(Executor.dir == WEST) Executor.pixel_x -= 100
		spawn()
			Flick("Chakra", Executor)
			if(M)
				Executor.Execute_Jutsu("Beast Tearing Gale Scratch!")
				Executor.layer = 125
				spawn(8.50)
					Flick("hurt", M)
					new/obj/Hit (M.loc)
					M.HP -= 45+rand(1, 10)
				spawn(9.5)
					spawn(2)
						Flick("teleport", Executor)
						Executor.layer = 100
						Executor.Dragonned = 0
						Executor.layer = 100
						Executor.stop()
					if(M)
						M.Dragonned = 0
						M.Death_Check(Executor)
						M.stop()

	Water_Stream()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 31)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Water Stream! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Water Stream! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 31

	Water_Stream_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 65) == 0) return
		for(var/obj/Jutsus/Water_Stream/J in Executor) spawn() J.Delay(20)
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		M.stop()
		spawn(4)
			spawn(6)
				Flick("teleport", Executor)
				Executor.layer = 100
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
			if(M)
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.stop()
				if(Executor.dir == EAST) M.knockbackeast()
				if(Executor.dir == WEST) M.knockbackwest()
				M.Death_Check(Executor)
		if(Executor.dir == EAST) Executor.pixel_x += 24
		if(Executor.dir == WEST) Executor.pixel_x -= 105
		spawn()
			Flick("Water", Executor)
			if(M)
				Executor.Execute_Jutsu("Water Stream!")
				Executor.layer = 125
				Executor.CanMove = 0
				M.CanMove = 0
				spawn(4.00)
					Flick("hurt", M)
					new/obj/Hit (M.loc)
					M.HP -= 40
				spawn(8)
					spawn(2)
						Flick("teleport", Executor)
						Executor.layer = 100
						Executor.Dragonned = 0
						Executor.layer = 100
						Executor.stop()
					if(M)
						M.Dragonned = 0
						M.Death_Check(Executor)
						M.stop()
	Fire_Stream()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 30)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Fire Stream! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Fire Stream! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 30

	Fire_Stream_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 60) == 0) return
		for(var/obj/Jutsus/Fire_Stream/J in Executor) spawn() J.Delay(20)
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		M.stop()
		spawn(11.5)
			Flick("teleport", Executor)
			Executor.layer = 100
			Executor.pixel_x = 0
			Executor.pixel_y = 0
			Executor.Dragonned = 0
			Executor.CanMove = 1
			Executor.freeze --
			Executor.stop()
			M.Dragonned = 0
			M.CanMove = 1
			M.freeze --
			M.stop()
		if(Executor.dir == EAST) Executor.pixel_x += 24
		if(Executor.dir == WEST) Executor.pixel_x -= 105
		spawn()
			Flick("Fire", Executor)
			if(M)
				Executor.Execute_Jutsu("Fire Stream!")
				Executor.layer = 125
				M.Dragonned = 1
				spawn(3.75)
					Flick("hurt", M)
					new/obj/Hit (M.loc)
					M.HP -= 10
				spawn(6.50)
					Flick("hurt", M)
					new/obj/Hit (M.loc)
					M.HP -= 10
				spawn(10)
					Flick("hurt", M)
					new/obj/Hit (M.loc)
					M.HP -= 15
				spawn(11.5)
					Flick("teleport", Executor)
					Executor.layer = 100
					Executor.Dragonned = 0
					Executor.CanMove = 1
					Executor.layer = 100
					Executor.stop()
					if(M)
						M.Dragonned = 0
						M.CanMove = 1
						M.Dragonned = 0
						M.Death_Check(Executor)
						M.stop()



	Special_AttackX()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 7)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Special Attack! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Special Attack! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 7

	Special_AttackX_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 55) == 0) return
		for(var/obj/Jutsus/Special_AttackX/J in Executor) spawn() J.Delay(15)
		for(var/obj/Jutsus/Dead_Soul_Summoning/K in Executor) K.Delay(5)
		for(var/obj/Jutsus/Chakra_Scalpel/K in Executor) K.Delay(5)
		for(var/obj/Jutsus/Tornedo/K in Executor) K.Delay(5)
		Executor.Activated = 0
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.Dragonned=1
		Executor.layer=175
		Executor.stop()
		M.stop()
		M.CanMove = 0
		M.freeze ++
		M.Dragonned=1
		M.stop()
		spawn(15)
			Executor.CanMove = 1
			Executor.Dragonned = 0
			Executor.freeze --
			Executor.layer = 100
			Executor.stop()
		Flick("Special Attack", Executor)
		spawn(6)
			if(M)
				Executor.loc = M.loc
				M.CanMove = 1
				M.freeze --
				M.vel_y = 25
				new/obj/Hit (M.loc)
				M.HP -= rand(30,45)
				M.Dragonned = 0
				Executor.Dragonned = 1
				M.Death_Check(Executor)

	Special_Attack()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 4)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Special Attack! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Special Attack! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 4
	Special_Attack_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 65) == 0) return
		for(var/obj/Jutsus/Log_Summoning/P in Executor.Jutsus) if(!P.Delay) P.Delay(7)
		for(var/obj/Jutsus/Mokuton_Daijurin_no_Jutsu/J in Executor) spawn() J.Delay(7)
		for(var/obj/Jutsus/Wood_Dragon/J in Executor) spawn() J.Delay(10)
		for(var/obj/Jutsus/Special_Attack/J in Executor) spawn() J.Delay(30)
		var/Old_Loc = Executor.loc
		Executor.Activated = 0
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.stop()
		Executor.loc=M.loc
		M.CanMove=0
		M.stop()
		M.freeze ++
		M.Dragonned=1
		M.vel_x=0
		M.vel_y=0
		spawn(30)
			Executor.CanMove = 1
			Executor.freeze --
		if(Executor.dir == EAST) Executor.x = M.x-1
		if(Executor.dir == WEST) Executor.x = M.x+1
		Flick("Special Attack", Executor)
		spawn(5)
			if(M)
				new/obj/Hit (M.loc)
				M.HP -= rand(10,15)
				M.Dragonned = 1
				Executor.Dragonned = 1
				spawn(6)
					new/obj/Hit (M.loc)
					M.HP -= rand(10,20)
					M.Dragonned = 1
					Executor.Dragonned = 1
				spawn(10) Executor.y += 1
				spawn(12)
					Flick("airpunch",Executor)
					new/obj/Hit (M.loc)
					M.HP -= rand(15,25)
					M.Dragonned = 1
					Executor.Dragonned = 1
					M.Death_Check(Executor)
				spawn(15)
					if(Executor)
						Executor.CanMove = 1
						Executor.Dragonned = 0
						Executor.loc = Old_Loc
						Executor.layer = 100
						Executor.stop()
						Flick("teleport", Executor)
						Executor.loc= Old_Loc
					if(M)
						M.freeze --
						M.Dragonned=0
						M.stop()
					if(Executor)
						if(Executor.dir == EAST) M.knockbackeastx()
						if(Executor.dir == WEST) M.knockbackwestx()

	Rasengan_Barrage()
		var/mob/Executor = usr
		if(Delay || Executor.ChidoriCD) return
		Executor.ChidoriCD = 1
		var/list/choose = list()
		for(var/mob/M in view(15))
			if(M.Real && M != Executor && !M.dead && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village) choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who to use Rasengan Barrage on?", "Rasengan Barrage") as null|anything in choose
		if(!M || M == "Cancel")
			Executor.ChidoriCD = 0
			return
		if(Delay || Executor.knocked || Executor.name != "Minato Namikaze" || M.dead || M.knocked || M.Real_C == 0 || M.Gates || M.Boulder || M.BoulderX || M.Dragonned || !M.Real || Executor.knocked || Executor.freeze)
			Executor.ChidoriCD = 0
			return
		Executor.ChidoriCD = 0
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(60)
		Executor.freeze ++
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.pixel_y = -18
		Executor.loc = M.loc
		Executor.y = M.y+1
		Executor.stop()
		M.freeze ++
		M.stop()
		Flick("barrage", Executor)
		var/Target
		var/_Target_
		spawn(7)
			if(!Target)
				Executor.Dragonned = 0
				Executor.pixel_y = 0
				Executor.freeze --
		spawn(6.75)
			if(M.Dodging == 0)
				Target ++
				new/obj/Ground_Explosion_X (M.loc)
				var/Damage = 25
				M.Damage(Executor, Damage, 1, 0)
				spawn(3)
					if(Executor)
						Executor.layer = 100
						Executor.pixel_y = 0
						Executor.Dragonned = 0
						Executor.freeze --
						Flick("Minato Teleport", Executor)
						Executor.stop()
						Executor.vel_y = 10
						if(Executor.dir == EAST) Executor.vel_x = 15
						if(Executor.dir == WEST) Executor.vel_x = -15
					if(M)
						M.freeze --
						M.Dragonned = 0
					for(var/mob/D in view(10))
						if(D.Real_C == 1 && D.Village != Executor.Village && D.name != Executor.name && D.Real && !D.knocked && !D.Gates && !D.Boulder && !D.BoulderX && !D.Dragonned)
							_Target_ ++
							new/obj/Hit(D.loc)
							var/DamagX = 20+rand(10, 25)
							D.Damage(Executor, DamagX, 1, 0, 0, 0, 0, 1)
							D.vel_y = 20
							if(D.client) D.Quake_Effect(20)
					if(_Target_) Executor.Damage_Up(20+rand(10, 25))
			if(M.Dodging == 1)
				Target ++
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.Dragonned = 0
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.layer = 100
				M.Dragonned = 0
				M.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

	Rasengan_Quake()
		var/mob/Executor = usr
		if(Executor.ChidoriCD || Delay) return
		Executor.ChidoriCD = 1
		var/list/choose = list()
		for(var/mob/M in view(20))
			if(M.Real && M != Executor && !M.dead && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village) choose.Add(M)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who to use Rasengan Quake on?", "Rasengan Quake") as null|anything in choose
		if(!M || M == "Cancel")
			Executor.ChidoriCD = 0
			return
		if(Delay || Executor.knocked || !Executor.Sage || M.dead || M.knocked || M.Real_C == 0 || M.Gates || M.Boulder || M.BoulderX || M.Dragonned || !M.Real || Executor.knocked || Executor.freeze)
			Executor.ChidoriCD = 0
			return
		Executor.ChidoriCD = 0
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(60)
		Executor.freeze ++
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.pixel_y = -18
		Executor.loc = M.loc
		Executor.y = M.y+1
		Executor.stop()
		M.freeze ++
		M.stop()
		Flick("Rasengan Quake", Executor)
		var/Target
		var/_Target_
		spawn(7)
			if(!Target)
				Executor.Dragonned = 0
				Executor.pixel_y = 0
				Executor.freeze = 0
		spawn(4)
			if(M.Dodging == 0)
				Target ++
				new/obj/Ground_Explosion_X (M.loc)
				var/Damage = 25
				M.Damage(Executor, Damage, 1, 0)
				spawn(3)
					if(Executor)
						Executor.layer = 100
						Executor.pixel_y = 0
						Executor.Dragonned = 0
						Executor.freeze --
						Flick("teleport", Executor)
						Executor.stop()
						Executor.vel_y = 10
						if(Executor.dir == EAST) Executor.vel_x = 15
						if(Executor.dir == WEST) Executor.vel_x = -15
					if(M)
						M.freeze --
						M.Dragonned = 0
					for(var/mob/D in view(10))
						if(D.Real_C == 1 && D.Village != Executor.Village && D.name != Executor.name && D.Real && !D.knocked && !D.Gates && !D.Boulder && !D.BoulderX && !D.Dragonned)
							_Target_ ++
							new/obj/Hit(D.loc)
							var/DamagX = 20+rand(10, 25)
							D.Damage(Executor, DamagX, 1, 0, 0, 0, 0, 1)
							D.vel_y = 20
							if(D.client) D.Quake_Effect(20)
					if(_Target_) Executor.Damage_Up(20+rand(10, 25))
			if(M.Dodging == 1)
				Target ++
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.Dragonned = 0
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.layer = 100
				M.Dragonned = 0
				M.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return


	Elbow()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 15)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Elbow! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Elbow! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 15

	Elbow_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 125) == 0) return
		for(var/obj/Jutsus/Elbow/J in Executor) spawn() J.Delay(90)
		for(var/obj/Jutsus/Endless_Kicks/L in src) L.Delay(7)
		Executor.Activated = 0
		spawn()
			Executor.loc = M.loc
			Executor.y += 1
			if(Executor.dir == WEST)
				Executor.x += 1
				Executor.pixel_x += 10
			if(Executor.dir == EAST)
				Executor.x -= 1
				Executor.pixel_x -= 10
		var/Old_Loc = Executor.loc
		Executor.Cha -= 125
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.stop()
		M.freeze ++
		M.Dragonned = 1
		M.CanMove = 0
		M.stop()
		Flick("Raiton Buretto", Executor)
		if(M)
			spawn(0.5)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(1)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(1.5)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(2)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(2.5)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(3)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(3.5)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(4)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(4.5)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(5)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(5.5)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(6)
				if(Executor.dir == WEST) Executor.pixel_x -=1
				if(Executor.dir == EAST) Executor.pixel_x +=1
				Executor.pixel_y -= 1
			spawn(6.5)
				Executor.Execute_Jutsu("Elbow!")
				var/Damage = 16.5
				M.Damage(Executor, Damage, 0, 0)
			spawn(10)
				var/Damage = 16.5
				M.Damage(Executor, Damage, 0, 0)
			spawn(13.5)
				var/Damage = 16.5
				M.Damage(Executor, Damage, 0, 0)
			spawn(17)
				var/Damage = 16.5
				M.Damage(Executor, Damage, 0, 0)
			spawn(20.5)
				var/Damage = 16.5
				M.Damage(Executor, Damage, 1, 0)
				M.CanMove = 1
				M.freeze --
				M.Dragonned = 0
				Flick("teleport", Executor)
				spawn()
					Executor.pixel_y = 0
					Executor.pixel_x = 0
					Executor.CanMove = 1
					Executor.freeze --
					Executor.Dragonned = 0
					Executor.loc = Old_Loc
					Executor.stop()



	Raikage_Hit()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 9)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Liger Bomb! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Liger Bomb! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 9

	Raikage_Hit_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 80) == 0) return
		for(var/obj/Jutsus/Elbow/J in Executor) spawn() J.Delay(20)
		for(var/obj/Jutsus/Endless_Kicks/L in src) L.Delay(7)
		Executor.Activated = 0
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.stop()
		M.freeze ++
		M.Dragonned = 1
		M.CanMove = 0
		M.stop()
		Flick("Second", Executor)
		if(M)
			spawn(4)
				var/Damage = rand(20,25)
				M.Damage(Executor, Damage, 0, 0)
				Executor.fall_speed = 0
				Executor.CanMove = 0
				M.CanMove = 1
				M.freeze --
				M.fall_speed = 0
				M.vel_y = 50
			spawn(6)
				Executor.CanMove = 0
				Executor.loc = M.loc
				Executor.pixel_y += 32
				M.vel_y = 0
				M.CanMove = 0
				M.freeze ++
			spawn(11)
				spawn(11.5)
					Executor.pixel_y = 0
					Executor.fall_speed = 25
					Executor.layer = 0
					Executor.Substitution = 1
					Executor.CanMove = 1
					Executor.freeze --
					Executor.Dragonned = 0
					var/A=new/obj/Smoke(Executor.loc)
					A:pixel_x = Executor.pixel_x
					A:pixel_y = Executor.pixel_y
					if(Executor.dir == EAST) Executor.vel_x-=rand(20,25)
					if(Executor.dir == WEST) Executor.vel_x+=rand(20,25)
					spawn(10)
						Executor.Substitution = 0
						Executor.layer = 100
				var/DamagX = rand(20,30)
				M.Damage(Executor, DamagX, 1, 0)
				Executor.Execute_Jutsu("Liger Bomb!")
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.fall_speed = 25
				M.vel_y -= 10

	Rockfall()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 16)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Rockfall! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Rockfall! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 16

	Rockfall_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 55) == 0) return
		for(var/obj/Jutsus/Rockfall/J in Executor) spawn() J.Delay(15)
		Executor.Activated = 0
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.Dragonned = 1
		Executor.stop()
		M.freeze ++
		M.Dragonned = 1
		M.stop()
		Flick("mob-shooting", Executor)
		spawn(15)
			Executor.CanMove = 1
			Executor.freeze --
			Executor.Dragonned = 0
			Executor.layer = 100
			Executor.stop()
			Flick("teleport", Executor)


		spawn(8)
			if(M)
				Executor.Execute_Jutsu("Rockfall!")
				var/A = new/obj/Rock (M.loc)
				A:dir = Executor.dir
				A:pixel_y = 16
				A:pixel_x = 30
				spawn(1) A:pixel_y -= 1
				spawn(2) A:pixel_y -= 1
				spawn(3) A:pixel_y -= 1
				spawn(4) A:pixel_y -= 1
				spawn(5) A:pixel_y -= 1
				spawn(6) A:pixel_y -= 1
				spawn(7) A:pixel_y -= 1
				spawn(8)
					A:pixel_y -= 1
					var/D=new/obj/GroundSmash (M.loc)
					if(Executor.dir == WEST) D:pixel_x -= 15
					if(Executor.dir == EAST) D:pixel_x -= 10
					var/Damage = rand(35,40)
					M.Damage(Executor, Damage, 1, 0)
					spawn(5)
						M.freeze --
						M.Dragonned = 0
						if(Executor && Executor.dir == EAST) M.knockbackeastx()
						if(Executor && Executor.dir == WEST) M.knockbackwestx()


	Drop_Kick()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 14)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Drop Kick! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Drop Kick! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 14

	Drop_Kick_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 65) == 0) return
		for(var/obj/Jutsus/Drop_Kick/J in Executor) spawn() J.Delay(15)
		Executor.Activated = 0
		var/Old_Loc = Executor.loc
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.loc = M.loc
		Executor.stop()
		Executor.y = M.y+1
		M.freeze ++
		M.CanMove=0
		M.stop()
		if(Executor.dir == EAST) Executor.x = M.x-1
		if(Executor.dir == WEST) Executor.x = M.x+1
		Flick("First", Executor)
		spawn(8)
			if(Executor)
				Executor.CanMove = 1
				Executor.freeze --
				Executor.Dragonned = 0
				Executor.loc = Old_Loc
				Executor.layer = 100
				Executor.stop()
				Flick("teleport", Executor)
				Executor.loc= Old_Loc


		spawn(4)
			if(M)
				Executor.Execute_Jutsu("Drop Kick!")
				var/A=new/obj/GroundSmash(M.loc)
				if(Executor.dir == WEST) A:pixel_x-=15
				if(Executor.dir == EAST) A:pixel_x-=10
				Executor.pixel_y -=1
				var/Damage = rand(20,35)
				M.Damage(Executor, Damage, 1, 2)
				M.CanMove = 1
				M.freeze --

	Guillotine_Drop()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 10)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Guillotine Drop! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Guillotine Drop! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 10


	Guillotine_Drop_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 50) == 0) return
		for(var/obj/Jutsus/Guillotine_Drop/J in Executor) spawn() J.Delay(15)
		Executor.Activated = 0
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.stop()
		M.freeze ++
		M.Dragonned = 1
		M.CanMove = 0
		M.stop()
		Executor.loc = M.loc
		Executor.pixel_y += 20
		Flick("First", Executor)
		if(M)
			spawn(1) Executor.pixel_y -=1
			spawn(2) Executor.pixel_y -=1
			spawn(3) Executor.pixel_y -=1
			spawn(4)
				Executor.Execute_Jutsu("Guillotine Drop!")
				var/A=new/obj/GroundSmash(M.loc)
				if(Executor.dir == WEST) A:pixel_x -= 15
				if(Executor.dir == EAST) A:pixel_x -= 10
				Executor.pixel_y -=1
				var/Damage = rand(25,45)
				M.Damage(Executor, Damage, 1, 0)
			spawn(5) Executor.pixel_y -=1
			spawn(6) Executor.pixel_y -=1
			spawn(7)
				Executor.layer = 0
				Executor.Substitution = 1
				var/A=new/obj/Smoke(Executor.loc)
				A:pixel_x = Executor.pixel_x
				A:pixel_y = Executor.pixel_y
				Executor.CanMove = 1
				Executor.freeze --
				Executor.Dragonned = 0
				Executor.pixel_y = 0
				if(Executor.dir == EAST) Executor.vel_x-=rand(20,25)
				if(Executor.dir == WEST) Executor.vel_x+=rand(20,25)
				M.CanMove = 1
				M.freeze --
				M.Dragonned = 0
				spawn(10)
					Executor.Substitution = 0
					Executor.layer = 100


	Obito_Combo()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 5)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Special Combo! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Special Combo! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 5

	Obito_Combo_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 65) == 0) return
		for(var/obj/Jutsus/Obito_Combo/J in Executor) spawn() J.Delay(10)
		for(var/obj/Jutsus/Flaming_Dragon/J in Executor) spawn() J.Delay(7)
		Executor.Activated = 0
		var/Old_Loc = Executor.loc
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.loc = M.loc
		Executor.y = M.y+1
		Executor.stop()
		M.freeze ++
		M.CanMove = 0
		M.stop()
		if(Executor.dir == EAST) Executor.x = M.x-1
		if(Executor.dir == WEST) Executor.x = M.x+1
		Flick("Rendan", Executor)
		spawn(8)
			if(Executor)
				Executor.CanMove = 1
				Executor.freeze --
				Executor.Dragonned = 0
				Executor.loc = Old_Loc
				Executor.layer = 100
				Executor.stop()
				Executor.loc= Old_Loc
				Flick("teleport", Executor)


		spawn(4)
			if(M)
				var/Damage = rand(30,50)
				M.Damage(Executor, Damage, 1, 2)
				M.CanMove = 1
				M.freeze --


	Demonic_Mirrors()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 22 && Executor.client)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Demonic Mirrors! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Demonic Ice Crystal Mirrors! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 22

	Demonic_Mirrors_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 75) == 0) return
		for(var/obj/Jutsus/Demon_Mirrors/J in Executor) spawn() J.Delay(30)
		Executor.Activated = 0
		Executor.layer = null
		Executor.freeze ++
		Executor.stop()
		M.freeze ++
		M.stop()
		if(M)
			var/Drain = 4.5
			Executor.Execute_Jutsu("Demonic Ice Crystal Mirrors!")
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.overlays += 'Graphics/Characters/HakuAttack.dmi'
			var/O = new/obj/Mirrors (M.loc)
			O:pixel_x = M.pixel_x -36
			O:pixel_y = M.pixel_y
			spawn(5) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(10) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(15) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(20) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(25) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(30) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(35) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(40) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(45) M.Damage(Executor, Drain, 0, 0, 0, 1)
			spawn(50)
				for(var/obj/Jutsus/J in Executor) if(J != src) spawn() J.Delay(3)
				M.Damage(Executor, Drain, 1, 1, 0, 1)
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()
				M.overlays -= 'Graphics/Characters/HakuAttack.dmi'
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.stop()
				del(O)


	Sensatsu_Suisho()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 21)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Hijutsu: Sensatsu Suisho! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Hijutsu: Sensatsu Suisho! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 21

	Sensatsu_Suisho_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 65) == 0) return
		for(var/obj/Jutsus/Hijutsu/J in Executor) spawn() J.Delay(20)
		Executor.Activated = 0
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		M.CanMove = 0
		M.freeze ++
		M.stop()
		Flick("mob-shooting", Executor)
		if(M)
			Executor.Execute_Jutsu("Hijutsu: Sensatsu Suisho!")
			var/Drain = 50
			M.Dragonned = 1
			var/O = new/obj/Haku_Attack (M.loc)
			O:pixel_x = M.pixel_x
			O:pixel_y = M.pixel_y
			spawn(3)
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
			spawn(6)
				M.Damage(Executor, Drain, 1, 0)
			spawn(12)
				del(O)
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.stop()

	Absorb_Chakra()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 20)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Chakra Absorb! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Chakra Absorb! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 20

	Absorb_Chakra_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 0) == 0) return
		for(var/obj/Jutsus/Absorb_Chakra_K/J in Executor) spawn() J.Delay(30)
		Executor.Activated = 0
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.stop()
		M.CanMove = 0
		M.freeze ++
		M.stop()
		Flick("mystic2", Executor)

		if(M)
			spawn(2)
				Executor.Execute_Jutsu("Chakra Absorb!")
				var/Drain = rand(30,50)
				M.Cha-=Drain
				Executor.Cha+=Drain
				if(M.Cha <0) M.Cha = 0
				if(Executor.Cha >Executor.MaxCha) Executor.Cha = Executor.MaxCha
				Flick("hurt", M)
				new/obj/Hit(M.loc)
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
			spawn(5)
				M.CanMove = 1
				M.freeze --
				M.stop()


	Paper_Trap()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 13)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Paper Trap! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Paper Trap! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 13

	Paper_Trap_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 65) == 0) return
		for(var/obj/Jutsus/Paper_Trap/J in Executor) spawn() J.Delay(15)
		for(var/obj/Jutsus/Suffocating_Papers/J in Executor) spawn() J.Delay(10)
		Executor.Activated = 0
		Executor.loc = M.loc
		if(Executor.dir == EAST) Executor.x -= 2
		if(Executor.dir == WEST) Executor.x += 2
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.Dragonned = 1
		Executor.layer = 125
		Executor.stop()
		M.Dragonned = 1
		M.freeze ++
		M.CanMove = 0
		M.stop()
		Flick("paper", Executor)
		spawn(12)
			if(Executor)
				Executor.CanMove = 1
				Executor.freeze --
				Executor.Dragonned = 0
				Executor.layer = 100
				Executor.stop()
				Flick("teleport", Executor)

		if(M)
			var/P = new/obj/Paper (M.loc)
			P:dir = M.dir
			P:pixel_x = M:pixel_x
			P:pixel_y = M:pixel_y
			var/Damage = rand(10,15)
			spawn(8)
				Executor.Execute_Jutsu("Paper Trap!")
				M.Damage(Executor, Damage, 0, 0)
			spawn(11)
				M.Damage(Executor, Damage, 0, 0)
			spawn(14)
				var/DamagX = rand(10,15)
				M.Damage(Executor, DamagX, 1, 0)
			spawn(23)
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.stop()



	Earthquake_K()
		var/mob/Executor = usr
		var/_Target_
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10)
		for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(5)
		Executor.freeze ++
		Executor.stop()
		spawn(10.5)
			Executor.freeze --
			Executor.stop()

		Flick("Jirobo", Executor)

		spawn(6)
			Executor.Execute_Jutsu("Earthquake!")
			var/A=new/obj/GroundSmash(Executor.loc)
			if(Executor.dir == WEST) A:pixel_x -= 25
			for(var/mob/M in view(20))
				if(M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Dragonned)
					if(M.Dodging == 0)
						var/Damage = 25+rand(0, 10)
						_Target_ ++
						M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 1)
						M.Quake_Effect(15)
						M.vel_y = 5
						if(M.px > Executor.px) M.knockbackeast()
						if(M.px < Executor.px) M.knockbackwest()
						if(M.px == Executor.px)
							if(Executor.dir == EAST) M.knockbackeast()
							if(Executor.dir == WEST) M.knockbackwest()
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
		if(_Target_) Executor.Damage_Up(30)

	Earthquake()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(13)
		Executor.stop()
		Executor.freeze ++
		spawn(12.5)
			Executor.freeze --
			Executor.stop()
		Flick("Earthquake", Executor)
		var/_Target_
		sleep(10)
		for(var/mob/M in view(20))
			M<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[Executor.name]</b>: Earthquake!"
			if(M.Village != Executor.Village && M.client && M.dead == 0 && M.knocked == 0 && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Dragonned == 0)
				if(M.Dodging == 0)
					_Target_ ++
					new/obj/Hit(M.loc)
					if(M.Levitating) M.Check_Levitating()
					var/Damage = 35
					M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 1)
					M.vel_y = 15
					M.Quake_Effect(25)

				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
		if(_Target_) Executor.Damage_Up(30)

	Resonating_Shockwave()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 55) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.stop()
		if(Executor.name != "Kin") Flick("punch5", Executor)
		if(Executor.name == "Kin") Flick("punch4", Executor)
		var/_Target_
		sleep(3)
		for(var/mob/M in view(20))
			M<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[Executor.name]</b>: Resonating Shockwave!"
			if(M.Village != Executor.Village && M.client && M.dead == 0 && M.knocked == 0 && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Dragonned == 0)

				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				else
					var/Damage = 40
					Executor.Executed_Fully = 1
					_Target_ ++
					M.Damage(Executor, Damage, 1, 0, 0, 0, 0, 1)
					M.Quake_Effect_X(30)
		spawn(2)
			Executor.freeze --
			Executor.stop()
			Flick("teleport", Executor)
		if(_Target_) Executor.Damage_Up(40)

	Wood_Binding()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(25)
		Executor.stop()
		Executor.freeze ++
		Flick("mob-shooting",Executor)
		sleep(5)
		Executor.freeze--
		Executor.stop()
		for(var/mob/M in view(10))
			if(M.Village != Executor.Village && M.Real && M.dead == 0 && M.knocked == 0 && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Dragonned == 0)
				if(M.Dodging)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				M.freeze ++
				M.Dodging = 0
				new/obj/Wood_Lock(M.loc)
				M.stop()
				if(M.Levitating) M.Check_Levitating()
				spawn(19)
					M.freeze --
					M.stop()

	Jyuuken_Shinan()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 7319745)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Jyuuken Shinan! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Jyuuken Shinan! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 7319745

	Jyuuken_Shinan_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 60) == 0) return
		for(var/obj/Jutsus/Jyuuken_Shinan/J in Executor) spawn() J.Delay(20)
		for(var/obj/Jutsus/Jyuuken_Fury/J in Executor) spawn() J.Delay(15)
		for(var/obj/Jutsus/Hakke_Juushou/J in Executor) spawn() J.Delay(10)
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.loc = M.loc
		Executor.freeze ++
		Executor.stop()
		M.icon_state = "mob-standing"
		M.Dragonned = 1
		M.freeze ++
		M.stop()
		flick("teleport", Executor)
		step_x = M.step_x
		step_y = M.step_y
		if(Executor.dir == EAST) Executor.set_pos (M.px -2, M.py+20)
		else Executor.set_pos (M.px +2, M.py+20)
		sleep(1.5)

		new/obj/Effects/Hanabi_Special_II (Executor.loc, Executor)
		Executor.Dragonned = 1
		if(M)
			var/Damage = rand(7, 7.75)
			Executor.Execute_Jutsu("Jyuuken Shinan!")
			spawn(6.25) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(14.25) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(17.00) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(20.25) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(22.25) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(28.00) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(32.25)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.vel_y = 15
				M.Damage(Executor, Damage*2, 1, 0, 0, 1)
	Lion_Barrage()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 3)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Lion Barrage! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Lion Barrage! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 3

	Lion_Barrage_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 90) == 0) return
		for(var/obj/Jutsus/Lion_Barrage/J in Executor) spawn() J.Delay(15)
		for(var/obj/Jutsus/Leaf_Hurricane_PSasuke/K in Executor) K.Delay(5)
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.Executing_Special_Jutsu = 1
		Executor.fall_speed = 0
		Executor.layer = 125
		Executor.loc = M.loc
		Executor.stop()
		Flick("teleport", Executor)
		M.stop()
		M.icon_state = "mob-standing"
		M.fall_speed = 0
		switch(rand(1,2))
			if(1)
				Executor.x+=2
				Executor.dir=WEST
			if(2)
				Executor.x-=2
				Executor.dir=EAST
		Flick("leaf", Executor)
		if(M)
			var/Damage = rand(15,20)
			M.Damage(Executor, Damage, 0, 0)
			M.vel_y = 10
			Executor.Execute_Jutsu("Lion Barrage!")
			sleep(3)
			if(!Executor) M.fall_speed=25
			if(!M)
				Executor.Executing_Special_Jutsu = 0
				Executor.Dragonned=0
				Executor.layer=100
				Executor.fall_speed=25
				Executor.stop()
			Executor.y = M.y+1
			if(Executor.dir == EAST) Executor.x = M.x-2
			if(Executor.dir == WEST) Executor.x = M.x+2
			Flick("lion1", Executor)
			M.vel_y = 5
			sleep(3)
			if(!Executor) M.fall_speed = 25
			if(!M)
				Executor.Executing_Special_Jutsu = 0
				Executor.Dragonned = 0
				Executor.layer = 100
				Executor.fall_speed = 25
				Executor.stop()
			Flick("lion2", Executor)
			M.Damage(Executor, Damage, 0, 0)
			M.vel_y = 8
			sleep(8)
			if(!Executor) M.fall_speed = 25
			if(!M)
				Executor.Executing_Special_Jutsu = 0
				Executor.Dragonned = 0
				Executor.layer = 100
				Executor.fall_speed = 25
				Executor.stop()
			Executor.loc = M.loc
			if(Executor.dir == EAST) Executor.x-=2
			if(Executor.dir == WEST) Executor.x+=2
			Flick("airpunch", Executor)
			M.Damage(Executor, Damage, 1, 0)
			Executor.Dragonned = 0
			M.vel_y-=10
			spawn(5)
				if(M)
					M.fall_speed = 25
					M.vel_y = 0
			spawn(5)
				if(Executor)
					Executor.fall_speed = 25
					spawn(5) Executor.Executing_Special_Jutsu = 0

			spawn(100)
				if(M && M.knocked==0) M.CanMove=1
				if(M)
					M.fall_speed=25
					M.vel_y=0
					M.stop()
				if(Executor)
					Executor.Executing_Special_Jutsu = 0
					Executor.fall_speed=25
					Executor.Dragonned=0
					Executor.layer=100
					Executor.stop()





	Kunai_Rush()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 11)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Kunai Rush! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Kunai Rush! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 11


	Kunai_Rush_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 90) == 0) return
		for(var/obj/Jutsus/Kunai_Rush/J in Executor) spawn() J.Delay(45)
		Executor.Activated = 0
		Executor.Dragonned=1
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.layer = 125
		Executor.loc = M.loc
		Executor.stop()
		Flick("teleport", Executor)
		M.stop()
		M.icon_state = "mob-standing"
		M.Dragonned = 1
		M.CanMove = 0
		M.freeze ++
		if(Executor.dir == EAST) Executor.x -= 2
		if(Executor.dir == WEST) Executor.x += 2
		spawn() Executor.pixel_y = -23
		Flick("Special", Executor)
		if(M)
			spawn(8)
				var/Damage = 8.5
				M.Damage(Executor, Damage, 0, 0)
				Executor.Execute_Jutsu("Kunai Rush!")
			spawn(10)
				var/Damage = 8.5
				M.Damage(Executor, Damage, 0, 0)
			spawn(12)
				var/Damage = 8.5
				M.Damage(Executor, Damage, 0, 0)
			spawn(14)
				var/Damage = 8.5
				M.Damage(Executor, Damage, 0, 0)
			spawn(16)
				var/Damage = 8.5
				M.Damage(Executor, Damage, 0, 0)
			spawn(18)
				var/DamagX = 15
				M.Damage(Executor, DamagX, 1, 2)
				Executor.pixel_y = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.fall_speed = 25
				Executor.Dragonned = 0
				Executor.layer = 100
				M.CanMove = 1
				M.freeze --
				M.Dragonned = 0


	Ice_Spike_Explosion()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 23)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Ice Spike Explosion! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Ice Spike Explosion! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 23


	Ice_Spike_Explosion_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 80) == 0) return
		for(var/obj/Jutsus/Ice_Spike/J in Executor) spawn() J.Delay(20)
		Executor.Activated = 0
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.Dragonned = 1
		Executor.stop()
		M.stop()
		M.icon_state = "mob-standing"
		M.CanMove = 0
		M.freeze ++
		M.Dragonned = 1
		Flick("mob-shooting", Executor)
		spawn(10)
			M.Dragonned = 0
			M.CanMove = 1
			M.freeze --
		if(M)
			var/I = new/obj/Ice_Spike (M.loc)
			I:pixel_x += 30
			I:dir = Executor.dir
			spawn(4)
				var/Damage = 55
				M.Damage(Executor, Damage, 1, 0)
				M.Dragonned = 0
				Executor.Execute_Jutsu("Ice Spike Explosion!")
				spawn(4)
					M.Dragonned = 0
					M.CanMove = 1
					Executor.freeze --
					Executor.Dragonned = 0


	Crystal_Explosive_Tree()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 12)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Crystal Release.- Explosive Tree! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Crystal Release.- Explosive Tree! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 12


	Crystal_Explosive_Tree_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 75) == 0) return
		for(var/obj/Jutsus/Crystal_Explosive_Tree/J in Executor) spawn() J.Delay(20)
		Executor.Activated = 0
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.Dragonned = 1
		Executor.stop()
		M.stop()
		M.icon_state = "mob-standing"
		M.CanMove = 0
		M.freeze ++
		M.Dragonned = 1
		Flick("Protect", Executor)
		var/T = new/obj/Crystal_Tree (M.loc)
		if(Executor.dir == WEST) T:pixel_x -= 6
		if(Executor.dir == EAST) T:pixel_x += 4
		spawn(6)
			Executor.Execute_Jutsu("Crystal Release.- Explosive Tree!")
			M.Dragonned = 0
			M.CanMove = 1
			M.freeze --
			M.stop()
			var/Damage = 40+rand(5,10)
			M.Damage(Executor, Damage, 1, 2)
			spawn(4)
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()

	Anbu_Combo()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 8)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Special Combo! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Special Combo! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 8
	Anbu_Combo_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 80) == 0) return
		for(var/obj/Jutsus/Anbu_Combo/J in Executor) spawn() J.Delay(20)
		Executor.Activated = 0
		Executor.Dragonned=1
		Executor.freeze ++
		Executor.CanMove = 0
		Executor.fall_speed = 0
		Executor.pixel_x = M.pixel_x
		Executor.layer = 125
		Executor.stop()
		Executor.loc = M.loc
		Executor.y += 1
		Flick("teleport", Executor)
		M.icon_state="mob-standing"
		M.CanMove = 0
		M.freeze ++
		M.Dragonned = 1
		M.stop()
		if(Executor.dir == EAST) Executor.x+=2
		if(Executor.dir == WEST) Executor.x-=2
		Flick("Start", Executor)
		if(M)
			spawn(3)
				var/Damage = rand(10,15)
				M.Damage(Executor, Damage, 0, 0)
				Executor.Execute_Jutsu("Special Combo!")
			spawn(5)
				Executor.loc = M.loc
				Executor.y += 1
				if(Executor.dir == EAST) Executor.x-=2
				if(Executor.dir == WEST) Executor.x+=2
			spawn(7)
				var/DamagX = rand(15,20)
				M.Damage(Executor, DamagX, 0, 0)
			spawn(9)
				Executor.loc = M.loc
				Executor.y += 1
				if(Executor.dir == EAST) Executor.x+=2
				if(Executor.dir == WEST) Executor.x-=2
			spawn(11)
				var/DamagF = rand(20,25)
				M.Damage(Executor, DamagF, 0, 0)
			spawn(13)
				M.Damage(Executor, 0, 1, 2)
				Executor.CanMove = 1
				Executor.layer = 100
				Executor.freeze --
				Executor.fall_speed = 25
				Executor.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.Dragonned = 0
	Wrath_Of_Jashin()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 1)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Wrath Of Jashin! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Wrath Of Jashin! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 1
	Wrath_Of_Jashin_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 75) == 0) return
		for(var/obj/Jutsus/Wrath_Of_Jashin/J in Executor) spawn() J.Delay(15)
		for(var/obj/Jutsus/Scythe_Strike/J in Executor) spawn() J.Delay(10)
		var/R = Executor.loc
		Executor.Activated = 0
		Executor.Dragonned = 1
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.layer = 105
		Executor.loc = M.loc
		Executor.pixel_x = M.pixel_x
		Flick("teleport", Executor)
		M.icon_state = "mob-standing"
		M.CanMove = 0
		M.freeze ++
		M.Dragonned = 1
		M.stop()
		spawn(40)
			Executor.CanMove = 1
			M.CanMove = 1
		switch(rand(1,2))
			if(1)
				Executor.x+=2
				Executor.dir=WEST
			if(2)
				Executor.x-=2
				Executor.dir=EAST
		spawn(10)
			if(M)
				Flick("rage4", Executor)
				spawn(25)
					M.freeze --
					M.Dragonned = 0
					Executor.CanMove = 1
					Executor.Dragonned=0
					Executor.loc = R
					Executor.freeze --
					Executor.layer = 100
					Executor.vel_x = 0
					Executor.stop()
					M.CanMove = 1
					M.stop()
				spawn(15)
					Executor.Execute_Jutsu("Wrath Of Jashin!")
					var/Damage = 60
					M.Damage(Executor, Damage, 1, 0)

	Scythe_Strike()
		var/mob/Executor = usr
		if(Delay) return
		if(Executor.Activated == 2)
			Executor.Activated = 0
			Executor<<""
			Executor<<"<b><font color=#AB0505><center><font size=3><u>* Deactivated Scythe Strike! *</u></center><br>"
			Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
			Executor<<""
			Executor<<""
			return
		if(Executor.knockback || Executor.freeze || Executor.Attacking || Executor.knocked) return
		Executor<<""
		Executor<<"<b><font color=#AB0505><center><font size=3><u>* Activated Scythe Strike! *</u></center><br>"
		Executor<<"<b><font color=#C00B0B><center>To execute the jutsu you have to hit an enemy."
		Executor<<""
		Executor.Activated = 2

	Scythe_Strike_X(mob/M)
		src.Hit_Execute = 1
		var/mob/Executor = usr
		if(!M) return
		if(Executor.Can_Execute(src, 75) == 0) return
		for(var/obj/Jutsus/Scythe_Strike/J in Executor) spawn() J.Delay(15)
		for(var/obj/Jutsus/Wrath_Of_Jashin/J in Executor) spawn() J.Delay(10)
		Executor.Activated = 0
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.Dragonned = 1
		M.icon_state="mob-standing"
		M.CanMove = 0
		M.freeze ++
		M.Dragonned = 1
		M.stop()
		Flick("rage2", Executor)
		spawn(5)
			Executor.layer=0
			spawn(3.5)
				M.overlays+='Graphics/Skills/HidanAttack.dmi'
				Executor.Execute_Jutsu("Scythe Strike!")
				spawn(3)
					var/DamagX = 20
					M.Damage(Executor, DamagX, 0, 0)
					M.CanMove = 0
					spawn(10)
						M.Damage(Executor, DamagX, 0, 0)
						M.CanMove=0
						spawn(10)
							M.Dragonned = 0
							M.stop()
							M.CanMove = 1
							M.freeze --
							Executor.CanMove = 1
							Executor.Dragonned=0
							Executor.freeze --
							Executor.layer=100
							Executor.stop()
							Flick("hurt",M)
							M.overlays-='Graphics/Skills/HidanAttack.dmi'
							var/Damage = rand(20,40)
							M.Damage(Executor, Damage, 1, 0)



	Revolt_Demon()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(15)
		for(var/obj/Jutsus/Illusionary_Warriors_Melody/W in Executor) W.Delay(7)
		Executor.stop()
		Executor.freeze ++
		spawn(2.25) {Executor.stop(); Executor.freeze --}
		Flick("Flute", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Revolt Of The Demon Realm!")
		var/_Target_
		for(var/mob/M in view(20))
			if(M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				else
					_Target_ ++
					M.icon_state = "mob-standing"
					M.freeze ++
					M.stop()
					Executor.stop()
					var/A = new/obj/Revolt_Demon(M.loc)
					A:dir = pick(EAST, WEST)
					var/HPDrained = 20+rand(0, 15)
					spawn(4)
						M.freeze --
						M.stop()
						M.Damage(Executor, HPDrained, 1, 0, 0, 0, 0, 1)
		if(_Target_) Executor.Damage_Up(25+rand(0, 15))


	Raikage_Summoning()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(20)
		for(var/obj/Jutsus/Lariat/L in Executor) L.Delay(7)
		Executor.stop()
		var/T = 0
		Flick("Throw", Executor)
		sleep(1.5)
		for(var/mob/M in view(20))
			if(T == 1) return
			if(M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				else
					T++
					Executor.Executed_Fully = 1
					M.icon_state = "mob-standing"
					M.freeze ++
					M.stop()
					Executor.stop()
					var/A=new/obj/Raikage()
					A:dir = pick(EAST, WEST)
					if(A:dir == EAST) A:loc = locate(M.x-1, M.y, M.z)
					if(A:dir == WEST) A:loc = locate(M.x+1, M.y, M.z)
					Executor.Execute_Jutsu("Raikage Summoning!")
					var/HPDrained = 40+rand(10, 20)
					if(M.Levitating) M.Check_Levitating()
					spawn(4)
						M.freeze --
						M.stop()
						M.Damage(Executor, HPDrained, 1, 2)


	Dead_Soul_Summoning()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(15)
		Executor.Activated = 0
		for(var/obj/Jutsus/Chakra_Scalpel/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Special_AttackX/K in Executor) K.Delay(3)
		for(var/obj/Jutsus/Tornedo/K in Executor) K.Delay(3)
		Executor.stop()
		var/T = 0
		Flick("mob-shooting", Executor)
		sleep(1.5)
		for(var/mob/M in view(20))
			if(T == 1) return
			if(M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				else
					T++
					Executor.Executed_Fully = 1
					M.icon_state = "mob-standing"
					M.freeze ++
					M.stop()
					Executor.stop()
					var/A=new/obj/Dead_Soul()
					A:dir = pick(EAST, WEST)
					if(A:dir == EAST) A:loc = locate(M.x-1, M.y, M.z)
					if(A:dir == WEST) A:loc = locate(M.x+1, M.y, M.z)
					Executor.Execute_Jutsu("Dead Soul Summoning!")
					var/HPDrained = 25+rand(5,15)
					if(M.Levitating) M.Check_Levitating()
					spawn(5)
						M.freeze --
						M.stop()
						M.Damage(Executor, HPDrained, 1, 2)


	Log_Summoning()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 45) == 0) return
		for(var/obj/Jutsus/Special_Attack/P in Executor.Jutsus) if(!P.Delay) P.Delay(7)
		Executor.Activated = 0
		Delay(15)
		Executor.stop()
		var/T = 0
		Flick("mob-shooting", Executor)
		sleep(1.5)
		for(var/mob/M in view(20))
			if(T == 1) return
			if(M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"

				else
					T++
					Executor.Executed_Fully = 1
					M.icon_state = "mob-standing"
					M.freeze ++
					M.stop()
					Executor.stop()
					var/A=new/obj/Trunk(M.loc)
					A:dir = pick(EAST, WEST)
					if(A:dir == EAST) A:pixel_x = -48
					if(A:dir == WEST) A:pixel_x = 48
					Executor.Execute_Jutsu("Log Summoning!")
					var/HPDrained = 15+rand(5,25)
					if(M.Levitating) M.Check_Levitating()
					spawn(6.5)
						M.freeze --
						M.stop()
						M.Damage(Executor, HPDrained, 1)


	Insect_Apocalypse()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 120) == 0) return
		Executor.Cha += 120
		Executor.freeze ++
		Executor.stop()
		var/PX = Executor.px
		var/PY = Executor.py
		Flick("Special X", Executor)
		sleep(11.5)
		Executor.freeze --
		if(Executor.Can_Execute(src, 120) == 0) return
		Delay(60)
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Insect Apocalypse!")
		if(Executor.knocked || Executor.px != PX || Executor.py != PY)
			Executor.freeze --
			Executor.stop()
			return
		new/obj/Torune/Main (Executor.loc, Executor)
		spawn(8.5)
			if(!Executor.knocked) Executor.freeze --
			Executor.stop()


	Absorption_Path()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.freeze ++
		for(var/obj/Jutsus/Offensive_Path/J in Executor) J.Delay(10)
		for(var/obj/Jutsus/Defensive_Path/J in Executor) J.Delay(10)
		for(var/obj/Jutsus/Absorption_Path/J in Executor) J.Delay(10)
		Executor.stop()
		var/T = 0
		Flick("Rain", Executor)
		sleep(5)
		Executor.freeze --
		for(var/mob/M in view(20))
			if(T == 1) return
			if(M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				else
					T++
					Executor.Executed_Fully = 1
					M.icon_state = "mob-standing"
					M.freeze ++
					M.stop()
					Executor.stop()
					var/A=new/obj/Path_1(M.loc)
					A:dir = pick(EAST, WEST)
					if(A:dir == EAST) A:loc = locate(M.x-1, M.y, M.z)
					if(A:dir == WEST) A:loc = locate(M.x+1, M.y, M.z)
					Executor.Execute_Jutsu("Absorption Path!")
					var/HPDrained = 20+rand(5,15)
					var/ChaDrained = 20+rand(5,15)
					if(M.Levitating) M.Check_Levitating()
					spawn(5)
						if(M)
							Executor.Cha += ChaDrained/2
							Executor.HP += HPDrained/2
							M.Damage(Executor, HPDrained, 1)
							M.Cha -= ChaDrained
							if(M.Cha < 0) M.Cha = 0
					spawn(15)
						if(M)
							M.freeze --
							M.stop()


	Defensive_Path()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.freeze ++
		for(var/obj/Jutsus/Offensive_Path/J in Executor) spawn() J.Delay(10)
		for(var/obj/Jutsus/Defensive_Path/J in Executor) spawn() J.Delay(10)
		for(var/obj/Jutsus/Absorption_Path/J in Executor) spawn() J.Delay(10)
		Executor.stop()
		var/T = 0
		Flick("Rain", Executor)
		sleep(1.5)
		Executor.freeze --
		for(var/mob/M in view(20))
			if(T == 1) return
			if(M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				else
					T++
					Executor.Executed_Fully = 1
					M.icon_state = "mob-standing"
					M.freeze ++
					M.stop()
					Executor.stop()
					var/A=new/obj/Path_2()
					A:dir = pick(EAST, WEST)
					if(A:dir == EAST) A:loc = locate(M.x-1, M.y, M.z)
					if(A:dir == WEST) A:loc = locate(M.x+1, M.y, M.z)
					Executor.Execute_Jutsu("Defensive Path!")
					var/HPDrained = 15+rand(10, 15)
					if(M.Levitating) M.Check_Levitating()
					spawn(5)
						if(M)
							M.Damage(Executor, HPDrained, 1)
					spawn(20)
						if(M)
							if(!M.knocked) M.freeze --
							M.stop()


	Offensive_Path()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.freeze ++
		for(var/obj/Jutsus/Offensive_Path/J in Executor) spawn() J.Delay(10)
		for(var/obj/Jutsus/Defensive_Path/J in Executor) spawn() J.Delay(10)
		for(var/obj/Jutsus/Absorption_Path/J in Executor) spawn() J.Delay(10)
		Executor.stop()
		var/T = 0
		Flick("Rain", Executor)
		sleep(1.5)
		Executor.freeze --
		for(var/mob/M in view(20))
			if(T == 1) return
			if(M.Real && M != Executor && !M.Gates && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"

				else
					T++
					Executor.Executed_Fully = 1
					M.icon_state = "mob-standing"
					M.freeze ++
					M.stop()
					Executor.stop()
					var/A=new/obj/Path_5()
					A:dir = pick(EAST, WEST)
					if(A:dir == EAST) A:loc = locate(M.x-1, M.y, M.z)
					if(A:dir == WEST) A:loc = locate(M.x+1, M.y, M.z)
					Executor.Execute_Jutsu("Offensive Path!")
					var/HPDrained = 30+rand(10, 15)
					if(M.Levitating) M.Check_Levitating()
					spawn(5) M.Damage(Executor, HPDrained, 1)
					spawn(10)
						if(!M.knocked) M.freeze --
						M.stop()
	Supreme_Kirin()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 135) == 0) return
		Delay(180)
		Executor.UsingKirin = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Kirin", Executor)
		spawn(15)
			if(Executor.GoingSusanoo == 0) Executor.freeze --
			Executor.stop()
			spawn(150) Executor.UsingKirin=0
		sleep(11)
		if(Executor.knocked || !Executor.UsingKirin) return

		Executor.Execute_Jutsu("Kirin!")
		var/_Target_
		for(var/mob/M in view(15))
			if(!M.knocked && M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Boulder && !M.BoulderX && !M.Gates && !M.Dragonned)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					_Target_ ++
					Executor.Executed_Fully = 1
					var/K = new/obj/Supreme_Kirin (M.loc)
					if(M.px > Executor) K:dir = EAST
					if(M.px < Executor.px) K:dir = WEST
					spawn(2.5)
						var/A=new/obj/GroundSmash(M.loc)
						if(M.dir == WEST) A:pixel_x-=15
						if(M.dir == EAST) A:pixel_x-=10
						M.Damage(Executor, 50+rand(5, 15), 1, 2, 0, 0, 0, 1)
		if(_Target_) Executor.Damage_Up(50+rand(5, 15))
	Kirin()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(30)
		Executor.UsingKirin = 1
		Executor.freeze ++
		Executor.stop()
		Flick("kirin", Executor)
		spawn(20)
			if(Executor.GoingSusanoo == 0) Executor.freeze --
			Executor.stop()
			spawn(150) Executor.UsingKirin=0
		sleep(10)
		if(Executor.knocked || !Executor.UsingKirin) return
		Flick("kirin2", Executor)
		var/A=new/obj/Kirin(Executor.loc)
		A:pixel_x-=25
		var/C=new/obj/Kirin(Executor.loc)
		C:x-=3
		var/B=new/obj/Kirin(Executor.loc)
		B:x+=2
		var/D=new/obj/Kirin(Executor.loc)
		D:x+=5
		var/E=new/obj/Kirin(Executor.loc)
		E:x-=5
		var/D1=new/obj/Kirin(Executor.loc)
		D1:x+=8
		var/E1=new/obj/Kirin(Executor.loc)
		E1:x-=8
		Executor.Execute_Jutsu("Kirin!")
		var/_Target_
		for(var/mob/M in view(10))
			if(!M.knocked && M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Boulder && !M.BoulderX && !M.Gates && !M.Dragonned)
				if(M.Dodging == 1)
					M.Dragonned = 0
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					var/Damage = rand(40,55)
					_Target_ ++
					M.Damage(Executor, Damage, 1, 2, 0, 0, 0, 1)
		if(_Target_) Executor.Damage_Up(rand(40, 50))
	Chidori_Stream()
		var/mob/Executor = loc
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(5)
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Chidori Stream!")
		Flick("stream", Executor)
		spawn(10)
			Executor.freeze --
			Executor.stop()
		for(var/mob/M in view(Executor, 3))
			if(!M.knocked && M.Real && M != Executor && !M.dead && M.Village != Executor.Village && !M.Boulder && !M.BoulderX && !M.Gates && !M.Dragonned)
				if(M.Dodging == 1)
					M.Dragonned = 0
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					var/Damage = rand(20,35)
					M.Damage(Executor, Damage, 1, 0)
	Poison_Smoke()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Tournament_GoingOn = 1
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(15)
		if(AllowedPoison == 0) return
		Executor.freeze ++
		Executor.Dragonned = 1
		Executor.stop()
		Flick("Acid", Executor)
		var/S = new/obj/Poison_Smoke_ (Executor.loc)
		S:pixel_x = Executor.pixel_x
		if(Executor.dir == EAST) S:pixel_x -= 60
		if(Executor.dir == WEST) S:pixel_x -= 50
		sleep(0.75)
		Executor.Execute_Jutsu("Poison Smoke!")
		for(var/mob/M in view(2))
			if(M.Village!= Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX && M.Poison_Immunity == 0)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					M.Poison_Proc(10, Executor.name)
		sleep(3.5)
		Executor.icon_state = "mob-standing"
		Executor.Dragonned=0
		Executor.freeze --
		Executor.stop()
	Omni_Strike()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Omni Strike", Executor)
		Executor.Execute_Jutsu("Omni Strike!")
		spawn(6.75)
			Executor.freeze --
			Executor.Dragonned = 0
			Executor.stop()

		spawn(1.75)
			var/T
			var/list/Attacked_Omni = list()

			loop
				T++
				for(var/mob/M in view(2))
					if(Attacked_Omni.Find(M)) continue
					if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
						if(M.Dodging == 1)
							Attacked_Omni.Add(M)
							M.Auto_Dodge (Executor)
							Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						else if(M.Dodging == 0)
							Attacked_Omni.Add(M)
							M.Damage(Executor, 15+rand(5, 15), 1, 2, 0, 1)
				spawn(0.5) if(T < 7) goto loop
	Double_Chakra_Scalpel()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		Executor.Deflection = 1
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Chakra OP", Executor)
		Executor.Execute_Jutsu("Double Chakra Scalpel!")
		spawn(14.5)
			Executor.freeze --
			Executor.Deflection = 0
			Executor.Dragonned = 0
			Executor.stop()
		spawn(3.65)
			var/T = 0
			loop
				T++
				for(var/mob/M in view(2))
					if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
						if(M.Dodging == 1)
							M.Auto_Dodge (Executor)
							Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						else if(M.Dodging == 0) M.Damage(Executor, 15+rand(5, 10), 1, 2, 0, 1)
				spawn(3.75) if(T == 1) goto loop
	Bullet_Punch()
		var/mob/Executor = loc
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		Executor.Deflection = 1
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Bullet Punch", Executor)
		Executor.Execute_Jutsu("Bullet Punch!")
		spawn(15.3)
			Executor.freeze --
			Executor.Deflection = 0
			Executor.Dragonned = 0
			Executor.stop()
		spawn(2)
			var/T = 0
			loop
				T++
				for(var/mob/M in view(Executor, 2))
					if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
						if(M.Dodging == 1)
							M.Auto_Dodge (Executor)
							Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						else if(M.Dodging == 0) M.Damage(Executor, 15+rand(5, 10), 1, 2, 0, 1)
				spawn(3.25) if(T == 1) goto loop
	Teleport_to_Kunai()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Dash = 1
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.NEM_Round.Type == "Tourney") {Executor<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"; return}
		if(Executor.Kamui == 1) {Executor<<"<b><font color=red><u>You can't use this jutsu on Kamui's Dimension!</u></font>"; return}
		if(Kunai==0) {Executor<<output("<b><font color=red>You haven't dropped any kunai yet!","Chat"); return}
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(30)
		for(var/obj/Dropped_Kunai/K in world)
			Kunai = 0
			K:icon = null
			Executor.loc = K:loc
			Flick("teleport", Executor)
			Executor.freeze ++
			Executor.stop()
			del(K)
			sleep(5)
			Executor.freeze --
			Executor.stop()
	Destroy_Kunai()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Dash = 1
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.NEM_Round.Type == "Tourney") {Executor<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"; return}
		if(Kunai==0) {Executor<<output("<b><font color=red><u>You haven't dropped any kunai yet!</u>","Chat"); return}
		if(Executor.Can_Execute(src, 5) == 0) return
		Delay(3)
		for(var/obj/Dropped_Kunai/K in world)
			new/obj/Explosion (K.loc)
			for(var/mob/M in view(K, 2))
				if(!M.Dragonned && M.Real && !M.knocked)
					var/Damage = rand(5,15)
					M.Damage(Executor, Damage, 1, 0)
			K:icon = null
			Kunai = 0
			Flick("punch4", Executor)
			Executor.freeze ++
			Executor.stop()
			Executor<<output("<b><font color=red><u>The kunai has been successfully destroyed!</u>","Chat")
			Executor.freeze --
			Executor.stop()
			del(K)

	Drop_Kunai()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.NEM_Round.Type == "Tourney") {Executor<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"; return}
		if(Executor.Kamui == 1) {Executor<<"<b><font color=red><u>You can't use this jutsu on Kamui's Dimension!</u></font>"; return}
		for(var/obj/Dropped_Kunai/K in world)
			if(K)
				Executor<<output("<b><font color=red><u>You already have a kunai dropped somewhere!</u></font>","Chat")
				return
		if(Executor.Can_Execute(src, 10) == 0) return
		Delay(15)
		Kunai=1
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		var/A=new/obj/Dropped_Kunai (Executor.loc)
		if(Executor.dir == EAST)
			A:x += 2
			A:dir = EAST
		if(Executor.dir == WEST)
			A:dir = WEST
		sleep(2.5)
		Executor.freeze --
		Executor.stop()


	Illusionary_Warriors_Melody()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Mind_Controlling) {Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."; return}
		if(Executor.NEM_Round.Type == "Tourney") {Executor<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"; return}

		if(Executor.Illusion_ == 1) Executor.Illusion_ = 0
		if(Executor.Can_Execute(src, 15) == 0) return
		var/First_Time = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Flute", Executor)
		sleep(5)
		Flick("Flute2", Executor)
		Executor.Special_ = 3
		Executor.Execute_Jutsu("Demonic Flute.- Illusionary Warriors Manipulating Melody!")
		Executor<<"<b><font color=#10C8FF><u>To stop using Illusionary Warriors Melody press X."
		Executor.Illusion_ = 1
		var/list/Attacked_Mobs = list()
		var/_Target_

		if(src)
			var/P = 0
			for(var/mob/M in Executor.NEM_Round.Ninjas)
				if(M.name != M.key && M.Real == 1 && !M.knocked && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Dragonned == 0 && M.Village != Executor.Village && M.name != M.key)
					if(Attacked_Mobs.Find(M)) continue
					P++
					if(!First_Time)

						if(Executor.Illusion_ == 0)
							Delay(30)
							for(var/obj/Jutsus/Revolt_Demon/R in Executor) R.Delay(7)
							Executor.Special_ = 0
							Executor.freeze --
							Executor.stop()
							if(!Executor.knocked) Flick("teleport", Executor)
							return

						Executor.Cha -= 10

						if(Executor.Cha <= 0)
							Delay(30)
							for(var/obj/Jutsus/Revolt_Demon/R in Executor) R.Delay(7)
							Executor<<output("<b><font color=red><u>You don't have enough chakra to continue using this Genjutsu!</u></b>","Chat")
							Executor.Illusion_ = 0
							Executor.Special_ = 0
							Executor.freeze --
							Executor.stop()
							if(!Executor.knocked) Flick("teleport", Executor)
							return

					Attacked_Mobs.Add(M)
					First_Time = 0
					Flick("Flute3", Executor)
					M.Special_Tayuya_Jutsu()
					M.Dragonned = 1
					M.CanMove = 0
					M.freeze ++
					M.Can_Dodge_ = 1
					M.stop()
					M.icon_state = "mob-standing"

					var/A = new/obj/Warrior(M.loc)
					if(M.dir == EAST)
						A:dir = WEST
						A:x++
					if(M.dir == WEST)
						A:dir = EAST
						A:x--


					sleep(5.15)
					M.Can_Dodge_ = 0

					var/Check_ = 0

					if(M.name == M.key || M.Real == 0 || M.knocked || M.Gates == 1 || M.Boulder != 0 || M.BoulderX != 0 || M.Dragonned == 1 && M.Village == Executor.Village)
						Check_ = 1
						Executor.Cha += 10
						Executor << "<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>You couldn't execute this jutsu on [M.name], so you recovered some chakra."

					if(!Check_)

						if(M.Dodging == 1)
							M.Auto_Dodge (Executor)
							Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"

						else
							M.Damage(Executor, 10+rand(3, 10), 1, 0, 0, 0, 0, 1)
							_Target_ ++
							if(_Target_ == 1) Executor.Damage_Up(10+rand(3, 10))

					sleep(3.5)

			if(!P)
				Delay(20)
				for(var/obj/Jutsus/Revolt_Demon/R in Executor) R.Delay(7)
				Executor.Special_ = 0
				Executor.freeze --
				Executor.stop()
				if(!Executor.knocked) Flick("teleport", Executor)

			else
				Executor.Special_ = 0
				Executor.freeze --
				Executor.stop()
				if(!Executor.knocked) Flick("teleport", Executor)
				Delay(30)
				for(var/obj/Jutsus/Revolt_Demon/R in Executor) R.Delay(7)

	Choji_Pill()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/_Pill_ = name
		var/Accepted
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode) return
		if(Executor.Mind_Controlling) {Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."; return}
		if(Executor.dead || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Executor.Choji_Pill || Executor.GoingSage || Executor.Boulder) return

		if(findtext(_Pill_ , "Spinach Pill")) if(alert(Executor, "Side Effects:\n\n- Damages 50 HP\n- Disables HP Regeneration and Jutsus for 20 seconds", "* Warning *", "Eat", "Cancel") == "Eat")
			if(Executor.dead || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Executor.Choji_Pill || Executor.GoingSage || Executor.Boulder) return
			if(Executor.HP <= 50) {Executor<<"<b><font color=red><u>You don't have enough health!</u>"; return}
			Accepted = 1
			for(var/obj/Jutsus/J in Executor) J.Delay(20)
			Executor.HP -= 50
			Executor.Str *= 1.30
			Executor.Def *= 1.15
			Executor.Cha *= 1.30
			Executor.MaxCha *= 1.30
			Executor.Choji_Pill = "Spinach"

		else if(findtext(_Pill_, "Curry Pill")) if(alert(Executor, "Side Effects:\n\n- Damage over time\n- Disables HP Regeneration while running", "* Warning *", "Eat", "Cancel") == "Eat")
			if(Executor.dead || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Executor.Choji_Pill || Executor.GoingSage || Executor.Boulder) return
			Accepted = 1
			Executor.Str *= 1.40
			Executor.Def *= 1.30
			Executor.HP *= 1.25
			Executor.MaxHP *= 1.25
			Executor.Cha *= 1.40
			Executor.MaxCha *= 1.40
			Executor.speed_multiplier *= 1.30
			Executor.Choji_Pill = "Curry"

		else if(alert(Executor, "Side Effects:\n\n- Death after 10 minutes", "* Warning *", "Eat", "Cancel") == "Eat")
			if(Executor.dead || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Executor.Choji_Pill || Executor.GoingSage || Executor.Boulder) return
			Accepted = 1
			Executor.HP *= 1.50
			Executor.Str *= 1.85
			Executor.Def *= 1.50
			Executor.Cha *= 1.50
			Executor.MaxHP *= 1.50
			Executor.MaxCha *= 1.40
			Executor.speed_multiplier *= 1.50
			Executor.Choji_Pill = "Chilli"

		if(!Accepted) return
		new/obj/Effects/Choji_Pill (Executor.loc, Executor)
		del(src)


	Rising_Bug_Pillars()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor._CD) return
		if(Executor.InkCD == 1 && Executor.Attacked)
			Executor<<output("<b><font color=#10C8FF><u>You have stopped using Rising Bug Pillars.</u></font>","Chat")
			Delay(20)
			Flick("End", Executor)
			Executor.Doming = 0
			Executor.Special_ = 0
			Executor.Attacked = 0
			Executor.CanMove = 1
			Executor.InkCD = 0
			spawn(4.75)
				Executor.freeze --
				Executor.stop()
			return
		if(Executor.Can_Execute(src, 30) == 0) return
		Executor.Special_ = 7
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.InkCD = 1
		Executor.stop()
		var/PX = Executor.px
		var/PY = Executor.py
		Executor.Doming = 1
		Executor.icon_state = "Special VII"
		Flick("Special VI", Executor)
		icon_state = "Special VII"
		sleep(7.5)
		Executor.Execute_Jutsu("Rising Bug Pillars!")
		var/Times = 0
		Executor<<"<b><font color=#10C8FF><u>To stop using Rising Bug Pillars press X."
		loop
			var/_Target_
			if(Executor.InkCD == 0) return
			icon_state = "Special VII"
			Executor.Attacked = 1
			Times++
			for(var/mob/M in view(13))
				if(M.Village != Executor.Village && M.Real && !M.Dragonned && !M.knocked && !M.Gates && !M.Boulder && !M.BoulderX)
					if(M.py - Executor.py >= 200 && !M.on_ground) continue
					if(M.Dodging == 0)
						_Target_ ++
						var/Damage = 1.95+rand(0, 2.6)
						if(M.on_ground) M.freeze ++
						M.Can_Dodge_ = 1
						M.Poison_Proc(3, Executor.name)
						new/obj/Effects/Bug_Pillar (M.loc, M)
						spawn(2.5)
							M.freeze --
							M.Can_Dodge_ = 0
							if(M.Dodging == 1)
								M.Auto_Dodge (Executor)
								Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
							else
								var/Old_Damaged = M.Damaged_Again
								spawn(rand(4.5, 5.5))
									if(M.Damaged_Again != Old_Damaged && M.Village != Executor.Village && M.Real && !M.Dragonned && !M.knocked && !M.Gates && !M.Boulder && !M.BoulderX)
										if(M.Dodging == 1)
											M.Auto_Dodge (Executor)
											Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
											continue
										M.Damage(Executor, Damage/2, 1, 0, 0, 1, 0, 1)
										M.vel_y = rand(5, 7)
										Old_Damaged = M.Damaged_Again
									spawn(rand(4.5, 5.5))
										if(M.Damaged_Again != Old_Damaged && M.Village != Executor.Village && M.Real && !M.Dragonned && !M.knocked && !M.Gates && !M.Boulder && !M.BoulderX)
											if(M.Dodging == 1)
												M.Auto_Dodge (Executor)
												Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
												continue
											M.Damage(Executor, Damage/2.10, 1, 0, 0, 1, 0, 1)
											M.vel_y = rand(3, 5)
											Old_Damaged = M.Damaged_Again
										spawn(rand(4.5, 5.5))
											if(M.Dodging == 1)
												M.Auto_Dodge (Executor)
												Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
												continue
											if(M.Damaged_Again != Old_Damaged && M.Village != Executor.Village && M.Real && !M.Dragonned && !M.knocked && !M.Gates && !M.Boulder && !M.BoulderX)
												M.Damage(Executor, Damage/2.20, 1, 0, 0, 1, 0, 1)
												M.vel_y = rand(1, 3)
								M.Damage(Executor, Damage, 1, 0, 0, 1, 0, 1)
								M.vel_y = rand(9, 13)

					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"

			if(_Target_) Executor.Damage_Up(rand(2.5, 7.5))

			if(Times > 0)
				Executor.Cha -= 4.5
				if(Executor.freeze > 1 || Executor.Cha <= 0 || Executor.knocked || Executor.px != PX || Executor.py != PY)
					Delay(30)
					if(Executor.Cha <= 0) Executor<<output("<b><font color=#10C8FF><u>You have stopped using Rising Bug Pillars due to your low chakra!</u></font></b>","Chat")
					Executor.icon_state = "mob-standing"
					Executor.Special_ = 0
					Flick("End", Executor)
					Executor.Doming = 0
					Executor.Attacked = 0
					Executor.CanMove = 1
					Executor.freeze --
					Executor.InkCD = 0
					spawn(4.75)
						Executor.stop()
						return
			spawn(rand(7.5, 9)) goto loop

	Rotation()
		var/mob/Executor = loc
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		src.On_Ground = 1

		if(Executor.Special_ == 2)
			Executor<<output("<b><font color=#00F3FF><u>You have stopped using Rotation.</u>","Chat")
			Flick("rotation3", Executor)
			Executor.Icon_State = null
			Executor.Dragonned = 0
			Executor.Deflection = 0
			Executor.Special_ = 0
			Executor.Attacked = 0
			Executor.freeze --
			Executor.stop()
			Executor.icon_state = "mob-standing"
			Delay(15)
			return

		if(Executor.Can_Execute(src, 20) == 0) return
		Executor.Dragonned = 1
		Executor.Special_ = 2
		Executor.freeze ++
		Executor.stop()
		Executor.Icon_State = "rotation2"
		Flick("rotation", Executor)
		sleep(3.5)
		Executor.Execute_Jutsu("Eight Triagrams.- Rotation!")
		var/Times = 0
		var/list/Enemies_Rotation = list()

		Executor<<"<b><font color=#00F3FF><u>You stop using Rotation press X.</u>"

		loop
			if(Executor.Special_ == 0) return
			Executor.Attacked = 1
			Executor.Deflection = 1
			Times++
			for(var/mob/M in view(Executor, 3))
				if(M.Village != Executor.Village && M.Real && !M.Dragonned && !M.knocked && !M.Gates && !M.Boulder && !M.BoulderX)
					if(Enemies_Rotation.Find(M))
						Enemies_Rotation.Remove(M)
						continue

					Enemies_Rotation.Add(M)

					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue

					if(M.Dodging == 0)
						var/Damage = 15+rand(0, 5)
						M.Damage(Executor, Damage, 1, 2, 0, 1)

			if(Times > 0 || Executor.knocked)
				Executor.Cha -= 6
				if(Executor.Cha <= 0)
					Delay(15)
					Executor<<output("<b><font color=#00F3FF><u>You have stopped using Rotation due to your low chakra!</u>","Chat")
					Executor.Special_ = 0
					Flick("rotation3", Executor)
					Executor.Icon_State = null
					Executor.Deflection = 0
					Executor.Dragonned = 0
					Executor.Attacked = 0
					Executor.freeze --
					Executor.stop()
					return
			spawn(5) goto loop

	Spinning_Slash()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		src.On_Ground = 1
		if(Executor.InkCD == 1 && Executor.Attacked && Executor.Dragonned == 1)
			Executor<<output("<b><font color=#10C8FF><u>You have stopped using Spinning Slash.</u>","Chat")
			Flick("End", Executor)
			Executor.InkCD = 2
			Executor.Dragonned = 0
			Executor.Deflection = 0
			Executor.Special_ = 0
			Executor.icon_state = "mob-standing"
			Executor.Attacked = 0
			Executor.CanMove = 1
			Executor.freeze --
			Executor.stop()
			Delay(15)
			return
		if(Executor.Can_Execute(src, 20) == 0) return
		Executor.Dragonned = 1
		Executor.Special_ = 2
		Executor.freeze ++
		Executor.InkCD = 1
		Executor.stop()
		Executor.icon_state = "Go"
		Flick("Go", Executor)
		sleep(3)
		Executor.Execute_Jutsu("Spinning Slash!")
		var/Times = 0
		var/list/Enemies_SS = list()

		Executor<<"<b><font color=#10C8FF><u>To stop using Spinning Slash press X.</u>"

		loop
			if(Executor.InkCD == 2) return
			Executor.Attacked = 1
			Executor.Deflection = 1
			Times++
			for(var/mob/M in view(2))
				if(M.Village != Executor.Village && M.Real && !M.Dragonned && !M.knocked && !M.Gates && !M.Boulder && !M.BoulderX)
					if(Enemies_SS.Find(M))
						Enemies_SS.Remove(M)
						continue

					Enemies_SS.Add(M)

					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue

					if(M.Dodging == 0)
						var/Damage = 15 +rand(0, 5)
						M.Damage(Executor, Damage, 1, 2, 0, 1)
			if(Times > 0 || Executor.knocked)
				if(Executor.InkCD == 2) return
				Executor.Cha -= 5.5
				if(Executor.Cha <= 0)
					Delay(15)
					Executor<<output("<b><font color=#10C8FF><u>You have stopped using Spinning Slash due to your low chakra!</u>","Chat")
					Executor.Special_ = 0
					Flick("End", Executor)
					Executor.Deflection = 0
					Executor.Dragonned = 0
					Executor.InkCD = 2
					Executor.Attacked = 0
					Executor.freeze --
					Executor.stop()
					return
			spawn(5) goto loop
	Water_Revenge()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.Dragonned = 1
		Executor.pixel_y -= 10
		Executor.stop()
		if(Executor.dir == EAST) Executor.pixel_x -= 52
		if(Executor.dir == WEST) Executor.pixel_x -= 48
		spawn() Flick("Release", Executor)
		sleep(4)
		spawn(6.5)
			Executor.Dragonned = 0
			Executor.pixel_x = 0
			Executor.pixel_y = 0
			Executor.freeze --
			Executor.stop()
			spawn() if(!Executor.knocked) Executor.icon_state = "mob-standing"
		Executor.Execute_Jutsu("Water Revenge!")
		for(var/mob/M in view(2))
			if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					M.Damage(Executor, rand(20, 30), 1, 2, 0, 1)
	Spinning_Blade()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10)
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		if(Executor.dir == WEST) Executor.pixel_x -= 3
		if(Executor.dir == EAST) Executor.pixel_x -= 1
		Flick("Special1", Executor)
		Executor.Execute_Jutsu("Spinning Blade!")
		spawn(7.5)
			Flick("teleport", Executor)
			Executor.Dragonned = 0
			Executor.freeze --
			Executor.stop()
		for(var/mob/M in view(2))
			if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					var/Damage = rand(25,35)
					M.Damage(Executor, Damage, 1, 0, 0, 1)
	Wind_Shield()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Levitating) return
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(10)
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Executor.pixel_y -= 22
		Flick("Shield", Executor)
		if(Executor.name == "Danzou")
			if(Executor.dir == WEST) Executor.pixel_x -= 3
			if(Executor.dir == EAST) Executor.pixel_x -= 1
		spawn(7.5)
			Flick("teleport", Executor)
			Executor.Dragonned = 0
			Executor.pixel_y = 0
			if(Executor.name == "Danzou") Executor.pixel_x = 0
			Executor.freeze --
			Executor.stop()
		Executor.Execute_Jutsu("Wind Release.- Shield!")
		for(var/mob/M in view(2))
			if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				if(M.Dodging == 0)
					var/Damage = rand(25,35)
					M.Damage(Executor, Damage, 1, 0, 0, 1)
	Spin_Kick()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Levitating) return
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(10)
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Spin", Executor)
		var/list/Enemies_Attacked = list()
		spawn(15)
			Flick("teleport", Executor)
			Executor.Dragonned = 0
			Executor.freeze --
			Executor.stop()
		Executor.Execute_Jutsu("Taijutsu.- Spin Kick!")
		spawn(3.75)
			for(var/mob/M in view(2))
				if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
					Enemies_Attacked.Add(M)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue
					if(M.Dodging == 0)
						var/Damage = rand(25, 35)
						M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn(7)
			for(var/mob/M in view(2))
				if(Enemies_Attacked.Find(M)) continue
				if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue
					if(M.Dodging == 0)
						var/Damage = rand(25, 35)
						M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn(10)
			for(var/mob/M in view(2))
				if(M.Village != Executor.Village && !M.Dragonned && !M.knocked && M.Real && !M.Gates && !M.Boulder && !M.BoulderX)
					if(M.Dodging == 1)
						M.Auto_Dodge (Executor)
						Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
						continue
					if(M.Dodging == 0)
						var/Damage = rand(25, 35)
						M.Damage(Executor, Damage, 1, 2, 0, 1)

	Teshi_Sendan()
		var/mob/Executor = loc
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 70) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Teshi Sendan!")
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(15)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(20)
			Target = 1
			Executor.Executed_Fully = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Executor.Dragonned = 1
			Flick("Teshi", Executor)
			sleep(3)
			var/Damage = 10
			M.Damage(Executor, Damage, 0, 0, 0, 1)
			sleep(2.5)
			var/DamagX = 3+rand(2,3)
			Flick("Teshi", Executor)
			M.Damage(Executor, DamagX, 0, 0, 0, 1)
			sleep(2.5)
			Flick("Teshi", Executor)
			M.Damage(Executor, DamagX, 0, 0, 0, 1)
			sleep(2.5)
			Flick("Teshi", Executor)
			M.Damage(Executor, DamagX, 0, 0, 0, 1)
			sleep(2.5)
			Flick("Teshi", Executor)
			M.Damage(Executor, DamagX, 0, 0, 0, 1)
			sleep(2.5)
			Flick("Teshi", Executor)
			M.Damage(Executor, DamagX, 0, 0, 0, 1)
			sleep(2.5)
			Flick("Teshi",Executor)
			M.Damage(Executor, DamagX, 0, 0, 0, 1)
			sleep(2.5)
			Flick("Teshi", Executor)
			M.Damage(Executor, DamagX, 0, 0, 0, 1)
			sleep(2.5)
			Flick("hurt", M)
			M.Damage(Executor, DamagX, 1, 2, 0, 1)
			M.freeze --
			M.Dragonned=0
			Executor.Dragonned = 0
			Executor.freeze --
			Executor.stop()
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)
				Executor.stop()


	Poison_Jab()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		Executor.Dragonned = 1
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 135, 115)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Bug_Barrage/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Fuuton_Poison/J in Executor) J.Delay(5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			M.freeze ++
			M.stop()
			M.Can_Dodge_ = 1
			M.Dragonned = 1
			Target = 1
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Bug_Barrage/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Fuuton_Poison/J in Executor) J.Delay(5)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Bug_Barrage/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Fuuton_Poison/J in Executor) J.Delay(7)
			Executor.Execute_Jutsu("Poison Jab!")
			Flick("Special II", Executor)
			sleep(10.5)
			var/T = 0
			loop
				if(T >= 6)
					spawn(2.5)
						Executor.Dragonned = 0
						Executor.freeze --
						Executor.stop()
					M.freeze --
					M.Dragonned = 0
					if(Executor.dir == EAST) M.knockbackeast()
					if(Executor.dir == WEST) M.knockbackwest()
					return
				T++
				M.Poison_Proc(rand(2, 3), Executor.name)
				M.stop()
				var/Damage = 7
				M.Damage(Executor, Damage, 1, 0, 0, 1)
				spawn(1.9) goto loop
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()


	Chakra_Rush()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 20) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		Executor.Dragonned = 1
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Earth_Eruption/P in Executor.Jutsus) P.Delay(5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			for(var/obj/Jutsus/Earth_Eruption/P in Executor.Jutsus) P.Delay(7)
			M.freeze ++
			M.stop()
			M.Can_Dodge_ = 1
			M.Dragonned = 1
			Target = 1
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			Executor.Execute_Jutsu("Chakra Rush!")
			Flick("Rage", Executor)
			sleep(3)
			var/T = 1
			loop
				if(T >= 6)
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
					Flick("teleport", Executor)
					M.freeze --
					M.Dragonned = 0
					if(Executor.dir == EAST) M.knockbackeast()
					if(Executor.dir == WEST) M.knockbackwest()
					return
				if(T == 2 || T == 4) Flick("Rage", Executor)
				M.stop()
				M.Stop_Chakra(1)
				M.Dragonned = 1
				var/Damage = 7
				M.Damage(Executor, Damage, 1, 0, 0, 1)
				if(Executor.dir == EAST) M.dir = WEST
				if(Executor.dir == WEST) M.dir = EAST
				T++
				spawn(3) goto loop
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()


	Golden_Kunai_Slash()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 65) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		Executor.Dragonned = 1
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			M.freeze ++
			M.stop()
			M.Can_Dodge_ = 1
			M.Dragonned = 1
			Target = 1
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(7)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			Executor.Execute_Jutsu("Golden Kunai Slash!")
			Executor.layer = M.layer
			Executor.layer += 5
			Flick("Golden Kunai", Executor)
			sleep(4.15)
			var/T = 0
			loop
				if(T == 2)
					sleep(7.65)
					Executor.layer = 100
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
					Flick("teleport", Executor)
					return

				else
					M.stop()
					M.Dragonned = 1
					var/Damage = 25
					if(T == 1)
						M.freeze --
						M.Dragonned = 0
						Damage += rand(5, 10)
						if(Executor.dir == EAST) M.knockbackeast()
						if(Executor.dir == WEST) M.knockbackwest()
					M.Damage(Executor, Damage, 1, 0, 0, 1)
					if(Executor.dir == EAST) M.dir = WEST
					if(Executor.dir == WEST) M.dir = EAST
					T++
					spawn(1.45) goto loop
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()


	Spider_Bind()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		Executor.Dragonned = 1
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			M.stop()
			M.freeze ++
			M.Can_Dodge_ = 1
			M.Dragonned = 1
			Target = 1
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1

			var/Old_Loc = Executor.loc
			Executor.Substitution = 1
			Executor.loc = M.loc
			Executor.step_x = M.step_x
			Executor.step_y = M.step_y
			Executor.pixel_y = 14
			new/obj/Effects/Smoke (loc, src)

			sleep(rand(3.75, 4.5))
			Executor.step_x = M.step_x
			Executor.step_y = M.step_y
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(5)
				Executor.Dragonned = 0
				Executor.Substitution = 0
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Executor.loc = Old_Loc
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Executor.Execute_Jutsu("Spider Bind!")
			Flick("Net Start", Executor)
			M.Dragonned = 0
			Executor.alpha = 125
			Executor.layer = (M.layer) +5
			sleep(6.6)
			var/T = 0
			loop
				if(T >= 4)
					Delay(15)
					Executor.alpha = 255
					Executor.pixel_y = 0
					Executor.loc = Old_Loc
					Flick("Net End", Executor)
					spawn(6.6)
						Executor.Substitution = 0
						Executor.Dragonned = 0
						Executor.layer = 100
						Executor.freeze --
						Executor.stop()
						M.freeze --
						return
				else
					Executor.step_x = M.step_x
					Executor.step_y = M.step_y
					T++
					Flick("Net", Executor)
					M.dir = Executor.dir
					M.stop()
					spawn(6.6) goto loop
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()


	Lightning_Spark()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		var/Target = 0
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Attack I", Executor)
		var/Damage = 35+rand(0, 5)
		sleep(1.65)
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 180, 160)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)

			if(Target) continue
			if(M.Dodging == 1)
				Delay(5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(10)
			Target ++
			Executor.Execute_Jutsu("Lightning Release.- Spark!")
			Executor.Executed_Fully = 1
			M.Dragonned = 1
			M.freeze ++
			M.stop()
			new/obj/Effects_Raiton/Darui_Raiton (M, Executor)

			spawn(2.8)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			spawn(4.15)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Executor, Damage, 1, 2, 0, 1)

		spawn()
			if(Target == 0)
				Delay(1)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()


	Crescent_Moon()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		var/Target = 0
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		Flick("Slash I", Executor)
		var/Damage = 15
		var/Dodged
		sleep(1)
		var/obj/Bounds/Bounds = new/obj/Bounds_Ranged (Executor.loc, Executor, 220, 200)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Dodged ++
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				continue
			Target ++
			Executor.Executed_Fully = 1
			M.Dragonned = 1
			M.freeze ++
			M.stop()
			M.Damage(Executor, Damage, 0, 0, 0, 1, 0, 1)
			spawn(4.25)
				M.Dragonned = 0
				M.freeze --
				M.stop()

		spawn()
			if(Target)
				Delay(17)
				Executor.Damage_Up(37.5)
				for(var/obj/Jutsus/Sword_Rush/J in Executor) spawn() J.Delay(5)
				for(var/obj/Jutsus/Dual_Slash/J in Executor) spawn() J.Delay(7)
				Executor.layer ++
				Executor.Execute_Jutsu("Crescent Moon Beheading!")
				var/mob/C = new/mob/Special_Effect/Crescent_Moon(null, Executor)

				spawn(4.25)
					var/list/Enemy_ = Bounds.Enemy()
					for(var/mob/M in Enemy_)
						if(M.Dodging == 1)
							M.Auto_Dodge (Executor)
							Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
							continue

						M.stop()
						M.vel_y += 10
						M.Damage(Executor, Damage*1.50, 1, 0, 0, 1, 0, 1)
						if(Executor.dir == EAST) M.knockbackwestx()
						if(Executor.dir == WEST) M.knockbackeastx()

				spawn(3.5)
					Flick("Slash II", Executor)
					Executor.pixel_y -= 4
					Executor.loc = C.loc
					Executor.px = C.px
					Executor.py = C.py
					Executor.step_x = C.step_x
					Executor.step_y = C.step_y
					del(C)
					spawn(6.5)
						Executor.layer --
						Executor.Dragonned = 0
						Executor.pixel_y = 0
						Executor.freeze --
						Executor.stop()

		spawn()
			if(Target == 0)
				if(!Dodged) Delay(1)
				else Delay(7)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()


	Endless_Kicks()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 30) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		Executor.Dragonned = 1
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			M.freeze ++
			M.stop()
			M.Can_Dodge_ = 1
			M.Dragonned = 1
			Target = 1
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			Executor.Execute_Jutsu("Endless Kicks!")
			var/obj/R = new/obj/Animation/Raikage_Kick (Executor)
			sleep(5)
			var/T = 0
			loop
				if(T >= 6)
					del(R)
					Flick("teleport", Executor)
					M.freeze --
					M.Dragonned = 0
					if(Executor.dir == EAST) M.knockbackeast()
					if(Executor.dir == WEST) M.knockbackwest()
					return
				T++
				M.stop()
				M.Dragonned = 1
				Flick("Attack", R)
				var/Damage = 7.5
				M.Damage(Executor, Damage, 1, 0, 0, 1)
				if(Executor.dir == EAST) M.dir = WEST
				if(Executor.dir == WEST) M.dir = EAST
				spawn(5) goto loop
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()


	Toad_Flame_Bullet()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 45) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		Executor.Dragonned = 1
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Rasengan_Sage_Jiraiya/J in Executor) J.Delay(3)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			M.freeze ++
			M.stop()
			M.Can_Dodge_ = 1
			M.Dragonned = 1
			Target = 1
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_C(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Rasengan_Sage_Jiraiya/J in Executor) J.Delay(3)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Rasengan_Sage_Jiraiya/J in Executor) J.Delay(5)
			Executor.Execute_Jutsu("Fire Release.- Toad Flame Bullet!")
			new/obj/Special_Effect/Jiraiya_Katon (Executor)
			sleep(8.5)
			var/T = 0
			loop
				T++
				M.stop()
				M.Dragonned = 1
				var/Damage = 15
				M.Damage(Executor, Damage, 1, 0, 0, 1)
				if(Executor.dir == EAST) M.dir = WEST
				if(Executor.dir == WEST) M.dir = EAST
				if(T >= 3)
					M.Dragonned = 0
					M.freeze --
					M.stop()
					if(Executor.dir == EAST) M.knockbackeast()
					if(Executor.dir == WEST) M.knockbackwest()
				else spawn(3) goto loop
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()


	Sakura_Inner_Rage()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 20) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		Executor.Dragonned = 1
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Cherry_Blossom_Impact_Sakura/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Cherry_Blossom_Groundsmash/J in Executor) J.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			M.freeze ++
			M.stop()
			M.Can_Dodge_ = 1
			M.Dragonned = 1
			Target = 1
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Cherry_Blossom_Impact_Sakura/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Cherry_Blossom_Groundsmash/J in Executor) J.Delay(7)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Cherry_Blossom_Impact_Sakura/J in Executor) J.Delay(10)
			for(var/obj/Jutsus/Cherry_Blossom_Groundsmash/J in Executor) J.Delay(10)
			Executor.Execute_Jutsu("Inner Rage!")
			Flick("inner", Executor)
			sleep(3)
			var/T=0
			loop
				if(T>=6)
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
					Flick("teleport", Executor)
					M.freeze --
					M.Dragonned = 0
					if(Executor.dir == EAST) M.knockbackeast()
					if(Executor.dir == WEST) M.knockbackwest()
					return
				T++
				M.stop()
				M.Dragonned = 1
				Flick("inner", Executor)
				var/Damage = 5
				M.Damage(Executor, Damage, 1, 0, 0, 1)
				if(Executor.dir == EAST) M.dir = WEST
				if(Executor.dir == WEST) M.dir = EAST
				spawn(3) goto loop
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

	Sea_Dragon()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		var/Target = 0
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(7)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(10)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Target = 1
			Executor.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			Executor.Teleport_Behind_KC(M, Executor)
			Executor.Executed_Fully = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(7)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(10)
				M.freeze --
				M.Dragonned = 0
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(15)
			Executor.Execute_Jutsu("Wind Release.- Sea Dragon!")
			Flick("Storm", Executor)

			sleep(7)
			new/obj/Effects/Sea_Dragon (M.loc, M)
			spawn(3) {Executor.freeze --; Executor.stop(); Executor.Dragonned = 0}

			spawn(1.75)
				M.input_lock = 1
				M.freeze --
				M.stop()
				M.vel_y = 14
				M.Damage(Executor, 20, 0, 0, 0, 1)

			spawn(4.50)
				M.Damage(Executor, 35, 1, 0, 0, 1)
				M.input_lock = 0
				M.Dragonned = 0
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

	Palms()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 135) == 0) return
		var/Target = 0
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(15)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Air_Palm/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Rotation/J in Executor) J.Delay(3)
				for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(10)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Target = 1
			Executor.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			Executor.Teleport_Behind(M, Executor)
			Executor.Executed_Fully = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(15)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Rotation/J in Executor) J.Delay(3)
				for(var/obj/Jutsus/Air_Palm/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(10)
				M.freeze --
				M.Dragonned = 0
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(30)
			for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(15)
			for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(15)
			for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(15)
			for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(15)
			for(var/obj/Jutsus/Air_Palm/J in Executor) J.Delay(15)
			for(var/obj/Jutsus/Rotation/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Palms/J in Executor) J.Delay(15)
			Executor.Execute_Jutsu("Eight Triagrams.- Sixty Four Palms!")
			Flick("palms", Executor)
			if(name == "Neji") sleep(5)
			var/Damage = 10
			M.Damage(Executor, Damage, 0, 0, 0, 1)
			sleep(5)
			if(Executor.name != "Hinata") Flick("palms", Executor)
			M.Damage(Executor, Damage, 0, 0, 0, 1)
			sleep(5)
			Flick("palms", Executor)
			M.Damage(Executor, Damage, 0, 0, 0, 1)
			sleep(5)
			if(Executor.name != "Hinata") Flick("palms", Executor)
			M.Damage(Executor, Damage, 0, 0, 0, 1)
			sleep(5)
			Flick("palms", Executor)
			M.Damage(Executor, 20, 1, 2, 0, 1)
			M.freeze --
			M.Dragonned=0
			spawn(5)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

	Dual_Slash_Mifune()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(7)
				for(var/obj/Jutsus/Crescent_Moon/J in Executor) spawn() J.Delay(5)
				for(var/obj/Jutsus/Sword_Rush/J in Executor) spawn() J.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(13)
			for(var/obj/Jutsus/Crescent_Moon/J in Executor) spawn() J.Delay(7)
			for(var/obj/Jutsus/Sword_Rush/J in Executor) spawn() J.Delay(7)
			Target = 1
			Executor.Executed_Fully = 1
			M.Dragonned = 1
			M.freeze ++
			M.stop()

			Executor.Dragonned = 1
			M.Can_Dodge_ = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("Charge End", Executor)
			Executor.Execute_Jutsu("Quick Slash!")
			var/Damage = 15
			spawn(3)
				M.Damage(Executor, Damage, 0, 0, 0, 1)
				M.Attacking = 1
				M.freeze --
				M.stop()
				M.vel_y = 20
			spawn(6.80)
				Flick("punch5", Executor)
				M.freeze ++
				Executor.step_x = M.step_x
				Executor.step_y = M.step_y
				if(Executor.dir == EAST) Executor.px = (M.px) -48
				if(Executor.dir == WEST) Executor.px = (M.px) +48
				Executor.set_pos(Executor.px, M.py)
				spawn(2)
					M.stop()
					M.freeze --
					M.Attacking = 0
					M.Dragonned = 0
					M.Damage(Executor, Damage, 1*1.25, 0, 0, 1)
					if(Executor.dir == EAST) M.knockbackeastx()
					if(Executor.dir == WEST) M.knockbackwestx()
				spawn(6.5)
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()

	Dual_Slash()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(7)
				for(var/obj/Jutsus/Crescent_Moon/J in Executor) spawn() J.Delay(5)
				for(var/obj/Jutsus/Sword_Rush/J in Executor) spawn() J.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(13)
			for(var/obj/Jutsus/Crescent_Moon/J in Executor) spawn() J.Delay(7)
			for(var/obj/Jutsus/Sword_Rush/J in Executor) spawn() J.Delay(7)
			Target = 1
			Executor.Executed_Fully = 1
			M.Dragonned = 1
			M.freeze ++
			M.stop()

			Executor.Dragonned = 1
			M.Can_Dodge_ = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("Combo I", Executor)
			Executor.Execute_Jutsu("Dual Slash!")
			var/Damage = 15
			spawn(3)
				M.Damage(Executor, Damage, 0, 0, 0, 1)
				M.Attacking = 1
				M.freeze --
				M.stop()
				M.vel_y = 20
			spawn(6.80)
				Flick("Combo II", Executor)
				M.freeze ++
				Executor.step_x = M.step_x
				Executor.step_y = M.step_y
				if(Executor.dir == EAST) Executor.px = (M.px) -48
				if(Executor.dir == WEST) Executor.px = (M.px) +48
				Executor.set_pos(Executor.px, M.py)
				spawn(2)
					M.stop()
					M.freeze --
					M.Attacking = 0
					M.Dragonned = 0
					M.Damage(Executor, Damage, 1*1.25, 0, 0, 1)
					if(Executor.dir == EAST) M.knockbackeastx()
					if(Executor.dir == WEST) M.knockbackwestx()
				spawn(6.5)
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Great_Whirlwind()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(7)
				for(var/obj/Jutsus/Leaf_Hurricane_/J in Executor) J.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(25)
			for(var/obj/Jutsus/Leaf_Hurricane_/J in Executor) J.Delay(13)
			Target = 1
			M.Dragonned = 1
			M.No_Attack = 1
			Executor.Executed_Fully = 1
			Executor.Dragonned = 1
			Executor.Teleport_Behind_RL(M, Executor)
			sleep(rand(3.75, 4.5))

			Executor.invisibility = 101
			new/obj/Effects/RL_Special_I (Executor.loc, Executor)
			sleep(23.75)
			new/obj/Effects/RL_Special_II (Executor.loc, Executor)
			sleep(2.25)
			Executor.Special_Eye = 1
			Executor.Teleport_Behind_RL_(M, Executor)
			Executor.Execute_Jutsu("Wind Release.- Great Whirlwind!")
			new/obj/Effects/RL_Special_III (Executor.loc, Executor)
			sleep(3)
			M.Damage(Executor, 17+rand(0,5), 0, 0, null, 1)
			Executor.density = 0
			M.vel_y = 20
			sleep(13)
			Executor.Teleport_Behind_RL(M, Executor)
			var/_PX_ = Executor.px -M.px
			var/_PY_ = Executor.py -M.py
			var/IV = new/obj/Effects/RL_Special_IV (Executor.loc, Executor)
			var/L = 0
			while(L < 10)
				Executor.set_pos (M.px+_PX_, M.py+_PY_)
				L++
				sleep(0.625)
			var/R = 0
			var/T = 1
			var/Ended
			Executor.client.perspective = EYE_PERSPECTIVE
			Executor.client.eye = M
			del(IV)
			var/V = new/obj/Effects/RL_Special_V (Executor.loc, Executor)
			Executor.dir = EAST
			loop
				if(R == 0 || R == 2 || R == 4) T++
				else T--
				if(T == 1)
					Executor.set_pos (M.px-72, M.py)
					Executor.dir = EAST
					if(R) R++
					if(R == 6)
						del(V)
						Ended = 1

				else if(T == 2) Executor.set_pos (M.px-54, M.py)
				else if(T == 3) Executor.set_pos (M.px-36, M.py)
				else if(T == 4)
					Executor.set_pos (M.px-18, M.py)
					if(Executor.dir == EAST)
						M.dir = WEST
						M.Damage(Executor, 5+rand(0, 1), 0, 0, null, 2)
						M.knockbackeast()
				else if(T == 5) Executor.set_pos (M.px, M.py)
				else if(T == 6)
					Executor.set_pos (M.px+18, M.py)
					if(Executor.dir == WEST)
						M.dir = EAST
						M.Damage(Executor, 4.75+rand(0, 1), 0, 0, null, 2)
						M.knockbackwest()
				else if(T == 7) Executor.set_pos (M.px+36, M.py)
				else if(T == 8) Executor.set_pos (M.px+54, M.py)
				else if(T == 9)
					R++
					Executor.dir = WEST
					Executor.set_pos (M.px+72, M.py)

				if(Ended)
					M.No_Attack = 0
					M.Dragonned = 0
					M.Death_Check (Executor)
					Executor.dir = WEST
					new/obj/Effects/RL_Special_VI (Executor.loc, Executor)
				else spawn(0.95) goto loop
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Water_Palm_()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(7)
				for(var/obj/Jutsus/Water_Prison_/J in Executor) J.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(13)
			for(var/obj/Jutsus/Water_Prison_/J in Executor) J.Delay(7)
			Target = 1
			M.freeze ++
			M.stop()
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			Executor.Teleport_Behind_Suigetsu(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			new/obj/Effects/Water_Palm (Executor.loc, Executor)
			Executor.Execute_Jutsu("Water Release.- Palm!")
			sleep(6.5)
			Executor.Executed_Fully = 1
			var/Damage = 25
			M.freeze --
			M.Dragonned = 0
			M.Damage(Executor, Damage, 1, 2, 0, 1)
			if(Executor.dir == EAST) M.knockbackeastx()
			if(Executor.dir == WEST) M.knockbackwestx()
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Explosive_Combo()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 37.5) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(7)
				for(var/obj/Jutsus/Explosive_Fist/F in Executor) F.Delay(7)
				for(var/obj/Jutsus/Flaming_Fist/F in Executor) F.Delay(7)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(13)
			for(var/obj/Jutsus/Explosive_Fist/F in Executor) F.Delay(13)
			for(var/obj/Jutsus/Flaming_Fist/F in Executor) F.Delay(13)
			Target = 1
			M.freeze ++
			M.stop()
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			Executor.Teleport_Behind_KC(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				M.stop()
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Executor.Executed_Fully = 1
			new/obj/Effects/Explosive_Combo (Executor.loc, Executor)
			Executor.Execute_Jutsu("Explosive Combo!")
			M.input_lock = 1

			spawn(3.25)
				M.freeze --
				M.stop()
				M.Damage(Executor, 15, 0, 2, 0, 1)

			spawn(10)
				M.freeze ++
				M.stop()
				Executor.Teleport_Behind_Gari (M, Executor)

			spawn(15.50)
				M.input_lock = 0
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Executor, 20 +rand(0, 7.5), 1, 0, 0, 1)
				if(M.px <= Executor.px) M.knockbackwest()
				else M.knockbackeast()

		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Water_Palm()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(7)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(13)
			Target = 1
			M.freeze ++
			M.stop()
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				M.stop()
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("palm", Executor)
			Executor.Execute_Jutsu("Water Release.- Palm!")
			sleep(3)
			spawn(6.5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			Executor.Executed_Fully = 1
			var/Damage = 25
			M.freeze --
			M.Dragonned = 0
			M.Damage(Executor, Damage, 1, 2, 0, 1)
			if(Executor.dir == EAST) M.knockbackeastx()
			if(Executor.dir == WEST) M.knockbackwestx()
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Jyuuken()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Target = 1
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(5)
				Executor.Dragonned = 0
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Palms/J in Executor) J.Delay(7)
			Flick("mob-shooting", Executor)
			sleep(3.5)
			Executor.Execute_Jutsu("Jyuuken!")
			Executor.invisibility = 101
			new/obj/Effects/Jyuuken_I (M.loc, M, null, Executor)
			var/Damage = 10
			spawn(4.75) M.Damage(Executor, Damage, 1, 0, 0, 1)
			spawn(9.60) M.Damage(Executor, Damage, 1, 0, 0, 1)
			spawn(19.75)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.vel_y = 10
				M.Damage(Executor, rand(0, 5) +Damage*2, 1, 0, 0, 1)

		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Protection_Palms()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 120) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(15)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(13)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(13)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(13)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(13)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(13)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Target = 1
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(15)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(13)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(13)
				for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(13)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(13)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(13)
				Executor.Dragonned = 0
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(45)
			for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(13)
			for(var/obj/Jutsus/Eight_Trigrams_Air_Palm/J in Executor) J.Delay(13)
			for(var/obj/Jutsus/Eight_Trigrams_Air_Palm_/J in Executor) J.Delay(13)
			for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(13)
			for(var/obj/Jutsus/Palms/J in Executor) J.Delay(13)
			Flick("mob-shooting", Executor)
			sleep(3)
			Executor.invisibility = 101
			new/obj/Effects/Hinata_U (Executor.loc, Executor)
			Executor.Execute_Jutsu("Eight Trigrams.- Protection Of The Sixty Four Palms!")
			var/Damage = 4.8
			var/Move_Speed = M.move_speed
			var/Speed_Multiplier = M.speed_multiplier
			spawn(27.50)
				M.move_speed = Move_Speed
				M.speed_multiplier = Speed_Multiplier
				M.freeze --
				M.Dragonned = 0
				M.stop()
				M.vel_y = 10
				M.Damage(Executor, Damage*1.5, 1, 2, 0, 1)
			spawn(0.5)
				Executor.Dragonned = 1
				M.Dragonned = 1
				M.Damage(Executor, Damage*1.5, 0, 0, 0, 1)
				M.pixel_y ++
				spawn(0.5)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(1)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(1.5)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(2)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(2.5)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(3)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(3.5)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(4)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(4.5)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
			spawn(5)
				Executor.Dragonned = 1
				M.vel_y = 6
				M.speed_multiplier = 0
				spawn(0.5)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(1)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(1.5)
					M.py += 3
				spawn(2)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
				spawn(2.5)
					M.py += 3
					if(Executor.dir == EAST) M.px -= 1
					if(Executor.dir == WEST) M.px += 1
					M.step_x = M.px - M.x * icon_width
					M.step_y = M.py - M.y * icon_height
			spawn(9.5)
				var/T

				loop
					if(T < 9)
						T++
						M.Dragonned = 1
						M.Damage(Executor, Damage, 0, 0, 0, 1)
					spawn(2.25) goto loop


		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Air_Palm_()
		var/mob/Executor = loc
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Target = 1
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(5)
				Executor.Dragonned = 0
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Palms/J in Executor) J.Delay(7)
			Flick("mob-shooting", Executor)
			sleep(3)
			Executor.invisibility = 101
			new/obj/Effects/Hinata_Air (Executor.loc, Executor)
			Executor.Execute_Jutsu("Eight Triagrams.- Air Palm!")
			var/Damage = 25
			spawn(2.5)
				M.freeze --
				M.Dragonned = 0
				M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Air_Palm()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Target = 1
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(15)
				for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Palms/J in Executor) J.Delay(5)
				Executor.Dragonned = 0
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Protection_Palms/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Jyuuken/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Palms/J in Executor) J.Delay(7)
			Flick("air", Executor)
			sleep(3)
			Executor.Execute_Jutsu("Eight Triagrams.- Air Palm!")
			spawn(6.5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			var/Damage = 25
			spawn(1.5)
				M.freeze --
				M.Dragonned = 0
				M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Tessenka()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Sawarbi_No_Mai/J in Executor) J.Delay(7)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Sawarbi_No_Mai/J in Executor) J.Delay(7)
			Target = 1
			Executor.Dragonned = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("Tessenka", Executor)
			sleep(8.5)
			Executor.Execute_Jutsu("Tessenka!")
			spawn(4.25)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			var/Damage = 25+rand(5,10)
			M.freeze --
			M.Dragonned = 0
			M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Palm_Wood_Pillar()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 30) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				Executor.pixel_x = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			Target = 1
			Executor.Dragonned = 1
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				M.Dragonned = 0
				Executor.Dragonned = 0
				M.freeze --
				Executor.pixel_x = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(Executor.dir == EAST) Executor.pixel_x = -2
			if(Executor.dir == WEST) Executor.pixel_x = -114
			Flick("Palm", Executor)
			sleep(3)
			Executor.Execute_Jutsu("Palm Wood Pillar!")
			spawn(6.5)
				Executor.Dragonned = 0
				Executor.pixel_x = 0
				spawn() Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
			var/Damage = 35
			M.freeze --
			M.Dragonned = 0
			M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Executor.pixel_x = 0
				spawn() Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
	Mokuton_Daijurin_no_Jutsu()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 30) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Wood_Dragon/J in Executor) spawn() J.Delay(5)
				for(var/obj/Jutsus/Special_Attack/J in Executor) spawn() J.Delay(5)
				Executor.Activated = 0
				Executor.pixel_x = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(M.Dodging == 0)
				Delay(15)
				for(var/obj/Jutsus/Wood_Dragon/J in Executor) spawn() J.Delay(10)
				for(var/obj/Jutsus/Special_Attack/J in Executor) spawn() J.Delay(7)
				Executor.Activated = 0
				Executor.Dragonned = 1
				Target = 1
				M.freeze ++
				M.stop()
				M.Dragonned = 1
				Executor.Teleport_Behind(M, Executor)
				Executor.Executed_Fully = 1
				M.Can_Dodge_ = 1
				sleep(rand(3.75, 4.5))
				M.Can_Dodge_ = 0
				if(M.Dodging == 1)
					Executor.Dragonned = 0
					M.freeze --
					M.Dragonned = 0
					Executor.pixel_x = 0
					Executor.freeze --
					Executor.stop()
					Flick("teleport", Executor)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return
				if(Executor.dir == EAST) Executor.pixel_x = 34
				if(Executor.dir == WEST) Executor.pixel_x = -96
				Flick("Mokuton", Executor)
				Executor.Activated = 0
				sleep(3)
				Executor.Execute_Jutsu("Mokuton Daijurin No Jutsu!")
				spawn(6.5)
					Executor.Dragonned = 0
					Executor.pixel_x = 0
					spawn() Flick("teleport", Executor)
					Executor.freeze --
					Executor.stop()
				var/Damage = 35
				M.Dragonned = 0
				M.freeze --
				M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Executor.pixel_x = 0
				spawn() Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()

	Tornedo()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		Executor.Activated = 0
		Executor.Execute_Jutsu("Tornedo!")
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				for(var/obj/Jutsus/Chakra_Scalpel/K in Executor) K.Delay(3)
				for(var/obj/Jutsus/Special_AttackX/K in Executor) K.Delay(3)
				for(var/obj/Jutsus/Dead_Soul_Summoning/K in Executor) K.Delay(3)
				Delay(15)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(20)
			for(var/obj/Jutsus/Chakra_Scalpel/K in Executor) K.Delay(5)
			for(var/obj/Jutsus/Special_AttackX/K in Executor) K.Delay(5)
			for(var/obj/Jutsus/Dead_Soul_Summoning/K in Executor) K.Delay(5)
			Target++
			Executor.Dragonned = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("Tornedo", Executor)
			spawn(13)
				Executor.Dragonned = 0
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
			sleep(4)
			var/Damage = 45
			M.Dragonned = 0
			M.freeze --
			M.Damage(Executor, Damage, 1, 2, 0, 1)

		spawn()
			if(!Target)
				Executor.freeze --
				Flick("teleport", Executor)
				Executor.stop()

	Fuuton_Poison()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 30) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Bug_Barrage/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Poison_Jab/J in Executor) J.Delay(7)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Target = 1
			Executor.Teleport_Behind_(M, Executor)
			Executor.Executed_Fully = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			Executor.Dragonned = 1
			M.Can_Dodge_ = 1
			sleep(rand(3.5, 4))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Bug_Barrage/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Poison_Jab/J in Executor) J.Delay(7)
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Bug_Barrage/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Poison_Jab/J in Executor) J.Delay(7)
			Flick("Poison", Executor)
			sleep(4)
			Executor.Execute_Jutsu("Fuuton: Poisonous Breeze!")
			new/obj/Effects/Fuuton_Poison (Executor.loc, Executor)
			spawn(1.5)
				if(!M.knocked && AllowedPoison && !M.Poison_Immunity)
					M.Poison_Proc(10, Executor.name)
					M.Damage(Executor, 5, 1, 0, 0, 0)
			spawn(6)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				M.freeze --
				M.Dragonned = 0
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)
				Executor.stop()

	Bug_Barrage()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 30) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Fuuton_Poison/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Poison_Jab/J in Executor) J.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Fuuton_Poison/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Poison_Jab/J in Executor) J.Delay(7)
			Target = 1
			Executor.Teleport_Behind(M, Executor)
			Executor.Executed_Fully = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			Executor.Dragonned = 1
			M.Can_Dodge_ = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Fuuton_Poison/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Poison_Jab/J in Executor) J.Delay(5)
				M.Dragonned = 0
				M.freeze --
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Fuuton_Poison/J in Executor) J.Delay(7)
			for(var/obj/Jutsus/Poison_Jab/J in Executor) J.Delay(7)
			Flick("Special I", Executor)
			sleep(7)
			Executor.Execute_Jutsu("Bug Barrage!")
			new/obj/Effects/Bug_Barrage (M.loc, M, Executor.dir)
			var/Damage = 7.5
			var/T = 5
			loop
				T--
				if(T == 0)
					M.Damage(Executor, Damage, 1, 2, 0, 1)
					Executor.Dragonned = 0
					Executor.freeze --
					M.Poison_Proc(7, Executor.name)
					Executor.stop()
					M.freeze --
					M.Dragonned = 0
				else
					M.Damage(Executor, Damage, 0, 0, 0, 1)
					spawn(1.25) goto loop
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)
				Executor.stop()


	Ultra_Punch()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Piston_Fist/L in Executor.Jutsus) spawn() L.Delay(3)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Rage/L in Executor.Jutsus) spawn() L.Delay(5)
			for(var/obj/Jutsus/Piston_Fist/L in Executor.Jutsus) spawn() L.Delay(7)
			Target = 1
			Executor.Teleport_Behind(M, Executor)
			Executor.Executed_Fully = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			Executor.Dragonned = 1
			M.Can_Dodge_ = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.Dragonned = 0
				M.freeze --
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("Ultra Punch", Executor)
			sleep(2)
			Executor.Execute_Jutsu("Ultra Punch!")
			spawn(6.5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			var/Damage = 30
			M.freeze --
			M.Dragonned = 0
			M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)
				Executor.stop()

	Piston_Fist()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Piston_Fist/L in Executor.Jutsus) spawn() L.Delay(3)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			for(var/obj/Jutsus/Ultra_Punch/L in Executor.Jutsus) spawn L.Delay(7)
			for(var/obj/Jutsus/Rage/L in Executor.Jutsus) spawn() L.Delay(5)
			Delay(15)
			Target = 1
			M.freeze ++
			M.stop()
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			M.Can_Dodge_ = 1
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Executor.Dragonned = 0
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("Piston", Executor)
			sleep(5)
			Executor.Execute_Jutsu("Piston Fist!")
			spawn(6.5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			M.freeze --
			M.Dragonned = 0
			var/Damage = 45+rand(0,5)
			M.Damage(Executor, Damage, 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)
				Executor.stop()




	Healing_Palm()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Healing Palm!")
		var/Target = 0
		Flick("HealPalm", Executor)
		sleep(4.5)
		var/obj/K = new/obj/SakuraCherry
		K.dir = Executor.dir
		K.loc = Executor.loc
		K.step_x = Executor.step_x
		K.step_y = Executor.step_y
		step(K,Executor.dir,16)
		spawn(3) del(K)
		for(var/mob/M in bounds(K,0))
			if(M == Executor || M.knocked || M.Real_C == 0 || !M.Real || M.Village != Executor.Village || M.Dragonned) continue
			Delay(10)
			Target = 1
			spawn(7.5)
				Executor.freeze --
				Executor.stop()
			Executor.Executed_Fully = 1
			M.overlays += 'Graphics/Skills/Heal2.dmi'
			spawn(10) M.overlays -= 'Graphics/Skills/Heal2.dmi'
			M.HP += 20+rand(15, 25)
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()

	Magma_Hand()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(20)
		Executor.stop()
		var/T = 0
		flick("mob-shooting", Executor)
		sleep(2)
		for(var/mob/M in view(13))
			if(T == 2) return
			if(M.Real && M != Executor && !M.Boulder && !M.BoulderX && !M.knocked && !M.Dragonned && M.Village != Executor.Village)
				if(M.Dodging == 1)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your Jutsu!"
				else
					T++
					Executor.Executed_Fully = 1
					M.icon_state = "mob-standing"
					M.freeze=1
					M.stop()
					var/A = new/obj/MoltenHand(M.loc)
					A:y--
					if(M.Levitating) M.Check_Levitating()
					spawn(5)
						if(M)
							M.Damage(Executor, 20, 1)
					spawn(8)
						if(M)
							if(!M.knocked) M.freeze --
							M.stop()

	One_Thousand()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			Target = 1
			Executor.layer = 101
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_Close(M, Executor)
			sleep(5)
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(5)
				Executor.layer = 100
				Executor.Dragonned = 0
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(7)
			for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(7)
			for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(7)
			Flick("Sennen", Executor)
			Executor.Execute_Jutsu("One Thousand Years Of Pain!")
			sleep(8)
			spawn(4.25)
				Executor.layer = 100
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			M.freeze --
			M.Dragonned = 0
			M.vel_y = 15
			M.Damage(Executor, rand(35, 42.5), 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)
				Executor.stop()


	Cherry_Blossom_Impact()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Sakura_Inner_Rage/J in Executor) J.Delay(5)
				for(var/obj/Jutsus/Cherry_Blossom_Groundsmash/P in Executor.Jutsus) P.Delay(5)
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			for(var/obj/Jutsus/Cherry_Blossom_Impact_Sakura/P in Executor.Jutsus) P.Delay(10)
			for(var/obj/Jutsus/Cherry_Blossom_Groundsmash/P in Executor.Jutsus) P.Delay(3)
			M.Dragonned = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			Target = 1
			Executor.Dragonned = 1
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Sakura_Inner_Rage/J in Executor) J.Delay(5)
				Executor.Dragonned = 0
				M.freeze --
				M.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(10)
			for(var/obj/Jutsus/Sakura_Inner_Rage/J in Executor) J.Delay(5)
			if(Executor.name == "Sakura") Flick("Cherry", Executor)
			if(Executor.name == "Tsunade") Flick("punch4", Executor)
			sleep(4.5)
			Executor.Execute_Jutsu("Cherry Blossom Impact!")
			spawn(8.5)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
			M.freeze --
			M.Dragonned = 0
			M.Damage(Executor, rand(25, 35), 1, 2, 0, 1)
		spawn()
			if(Target == 0)
				Executor.freeze --
				Flick("teleport", Executor)
				Executor.stop()

	Aoi_Combo()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Special Combo!")
		var/Target = 0
		if(Executor.dir == EAST) Executor.pixel_x -= 20
		if(Executor.dir == WEST) Executor.pixel_x += 20
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(15)
				for(var/obj/Jutsus/Sword_Slash/L in Executor.Jutsus) L.Delay(5)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			if(M.Dodging == 0)
				Delay(20)
				for(var/obj/Jutsus/Sword_Slash/L in Executor.Jutsus) L.Delay(15)
				Target ++
				Executor.Dragonned = 1
				M.Dragonned = 1
				M.freeze ++
				M.stop()
				Executor.Executed_Fully = 1
				Executor.Teleport_Behind(M, Executor)
				M.Can_Dodge_ = 1
				sleep(rand(3.75, 4.5))
				M.Can_Dodge_ = 0
				if(M.Dodging == 1)
					M.freeze --
					M.Dragonned = 0
					Executor.Dragonned = 0
					Executor.pixel_x = 0
					Executor.pixel_y = 0
					Executor.freeze --
					Executor.stop()
					Flick("teleport", Executor)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return
				Executor.icon_state = "Combo"
				Flick("Combo", Executor)
				sleep(3)
				var/Old_Loc_ = loc
				if(M.Levitating) M.Check_Levitating()
				spawn(2)
					var/Damage = 10+rand(0,5)
					M.Damage(Executor, Damage, 0, 0, 0, 1)

				spawn(10.75)
					if(Executor.dir == EAST) Executor.x += 2
					if(Executor.dir == WEST) Executor.x -= 2

				spawn(15.5)
					var/DamagX = 15+rand(0,10)
					M.Damage(Executor, DamagX, 0, 0, 0, 1)

				spawn(19.75)
					if(Executor.dir == EAST) Executor.x -= 2
					if(Executor.dir == WEST) Executor.x += 2
					Executor.pixel_y += 30

				spawn(24.5)
					var/DamagF = 20+rand(0,10)
					M.Damage(Executor, DamagF, 0, 0, 0, 1)

				spawn(26)
					Executor.pixel_x = 0
					Executor.pixel_y = 0
					Flick("teleport", Executor)
					Executor.loc = Old_Loc_
					Executor.check_loc()
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
					if(M)
						M.Damage(Executor, 0, 1, 2, 0, 1)
						M.freeze --
						M.Dragonned = 0

		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Kamui()
		var/mob/Executor = usr
		src.Capture_The_Flag = 1
		src.Executed_Fully = 1
		src.On_Ground = 1
		src.Boss_Mode = 1
		src.Tournament_GoingOn = 1
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.Can_Execute(src, 10) == 0) return
		Executor.Dragonned = 1
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/Ended = 0
		Executor.icon_state = "Teleport"
		Flick("Teleport", Executor)
		sleep(5)
		var/obj/K = new/obj/SakuraCherry
		K.dir = Executor.dir
		K.loc = Executor.loc
		K.step_x = Executor.step_x
		K.step_y = Executor.step_y
		step(K,Executor.dir,16)
		spawn(3) del(K)
		for(var/mob/M in bounds(K,0))
			if(M == Executor || !M.Real || M.Dragonned) continue
			if(M.Dodging == 0)
				spawn(6.5)
					if(!Ended)
						Delay(10)
						Executor.icon_state = "mob-standing"
						Executor.Dragonned = 0
						Executor.CanMove = 1
						Executor.freeze --
						Executor.stop()
				Delay(10)
				Target ++
				Executor.Executed_Fully = 1
				M.CanMove = 0
				M.freeze ++
				if(Target == 1) Executor.Execute_Jutsu("Kamui!")
				if(M.Levitating) M.Check_Levitating()
				var/P = new/obj/Portal (M.loc)
				P:dir = Executor.dir
				spawn(3.30)
					Executor.icon_state = "mob-standing"
					Executor.Dragonned = 0
					Executor.CanMove = 1
					Executor.freeze --
					Executor.stop()
					Ended = 1
					if(M)
						Executor.RT.Add(M)
						M.CanBeRevived = 0
						M.Kamui = 1
						for(var/obj/Tobi/T in world)
							var/N = new/obj/Portal ()
							N:loc = T.loc
							M.loc = T.loc
							if(dir == EAST)
								N:dir = EAST
								M:knockbackeast()
							if(dir == WEST)
								N:dir = WEST
								M.knockbackwest()
						M.CanMove = 1
						M.freeze --

			if(M.Dodging == 1 && Target == 0)
				Delay(10)
				Ended = 1
				Executor.icon_state = "mob-standing"
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"

		spawn()
			if(Target == 0)
				Ended = 1
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()

	Doton_Punch()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Executor.Dragonned = 1
		Executor.freeze ++
		Executor.layer = 125
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Rinnegan_Sword/K in Executor) K.Delay(3)
				for(var/obj/Jutsus/Bansho_Tenin/K in Executor) K.Delay(3)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(M.Dodging == 0)
				Delay(20)
				for(var/obj/Jutsus/Rinnegan_Sword/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Bansho_Tenin/K in Executor) K.Delay(5)
				Executor.Dragonned = 1
				Target ++
				M.Can_Dodge_ = 1
				M.freeze ++
				M.stop()
				M.Dragonned = 1
				Executor.Executed_Fully = 1
				Executor.Teleport_Behind(M, Executor)
				sleep(rand(3.75, 4.5))
				M.Can_Dodge_ = 0
				if(M.Dodging == 1)
					M.Dragonned = 0
					M.freeze --
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					Flick("teleport", Executor)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return
				Flick("Doton Punch", Executor)
				if(Executor.name == "Lord Madara") Flick("mob-shooting", Executor)
				sleep(10.5)
				if(Target == 1)	Executor.Execute_Jutsu("Doton Punch!")
				if(Executor.name == "Lord Madara"&& Target == 1)Executor.Execute_Jutsu("Heavenly Strike!")
				var/Damage = 45
				M.Damage(Executor, Damage, 1, 0, 0, 1)
				spawn(2.5)
					Executor.icon_state = "mob-standing"
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					if(M)
						M.Dragonned = 0
						M.freeze --
						M.Death_Check(Executor)
						if(Executor.dir == EAST) M.Tobi_ProcEAST()
						if(Executor.dir == WEST) M.Tobi_ProcWEST()

		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()

	Bansho_Tenin()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 70) == 0) return
		Delay(30)
		for(var/obj/Jutsus/Rinnegan_Sword/K in Executor) K.Delay(5)
		for(var/obj/Jutsus/Doton_Punch/K in Executor) K.Delay(5)
		var/Target = 0
		var/Ended = 0
		Executor.icon_state = "Banshou"
		Flick("Banshou", Executor)
		Executor.CanMove = 0
		Executor.freeze ++
		Executor.layer = 125
		Executor.stop()
		for(var/mob/M in ohearers(Executor,12))
			if(M == Executor || M.knocked || M.Real_C == 0 || !M.Real || M.Village == Executor.Village || M.Dragonned || Executor.dir == EAST && M.x < Executor.x || Executor.dir == WEST && M.x > Executor.x || Executor.dir == WEST && M.x == Executor.x && M.pixel_x > Executor.pixel_x || Executor.dir == EAST && M.x == Executor.x && M.pixel_x < Executor.pixel_x) continue
			if(M.Dodging == 0)
				spawn(25)
					if(!Ended)
						Executor.layer = 100
						Executor.icon_state = "mob-standing"
						Flick("teleport", Executor)
						Executor.Dragonned = 0
						Executor.freeze --
						Executor.stop()
				Executor.Executed_Fully = 1
				M.CanMove = 0
				M.freeze ++
				M.Dragonned = 1
				M.stop()
				Executor.Dragonned = 1
				Flick("hurt", M)
				M.loc = Executor.loc
				if(Executor.dir == EAST)
					M.dir = WEST
					M.x += rand(3,5)
				if(Executor.dir == WEST)
					M.dir = EAST
					M.x -= rand(3,5)
				M.pixel_x = rand(-64, 64)
				Target ++
				if(Target == 1) Executor.Execute_Jutsu("Bansho Tenin!")
				if(M.Levitating) M.Check_Levitating()
				spawn(3.5)
					var/Damage = 15
					M.Damage(Executor, Damage, 0, 0, 0, 1, 0, 1)
					M.icon_state = "hurt"
				spawn(7.5)
					M.pixel_y += 35
					spawn(1.5) M.pixel_y += 35
					spawn(3)
						M.pixel_y += 35
						var/Damage = 15
						M.Damage(Executor, Damage, 0, 0, 0, 1, 0, 1)

				spawn(15)
					M.pixel_y -= 53
					if(Executor.dir == EAST) M.x++
					if(Executor.dir == WEST) M.x--
					spawn(1.5)
						M.pixel_y -= 52
						if(Executor.dir == EAST) M.x++
						if(Executor.dir == WEST) M.x--
						M.HP-=15
						var/Damage = 15
						M.Damage(Executor, Damage, 0, 0, 0, 1, 0, 1)
				spawn(21.25)
					Ended = 1
					Executor.icon_state = "mob-standing"
					Executor.Dragonned = 0
					Executor.CanMove = 1
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					if(M)
						M.Damage(Executor, 0, 1, 2, 0, 1, 0, 1)
						M.pixel_x = 0
						M.pixel_y = 0
						M.Dragonned = 0
						M.CanMove = 1
						M.freeze --


			if(M.Dodging == 1)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"

		spawn(5)
			if(Target == 0)
				Ended = 1
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()
				Flick("teleport", Executor)
			else Executor.Damage_Up(45)

	Rinnegan_Sword()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 45) == 0) return
		var/Target = 0
		Executor.stop()
		Executor.freeze ++
		Executor.layer = 125
		Executor.icon_state = "Rinnengan Sword"
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Bansho_Tenin/K in Executor) K.Delay(3)
				for(var/obj/Jutsus/Doton_Punch/K in Executor) K.Delay(3)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(M.Dodging == 0)
				Delay(15)
				for(var/obj/Jutsus/Bansho_Tenin/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Doton_Punch/K in Executor) K.Delay(5)
				M.Can_Dodge_ = 1
				Executor.Dragonned = 1
				Target ++
				M.Dragonned = 1
				M.freeze ++
				M.stop()
				Executor.Executed_Fully = 1
				Executor.Teleport_Behind(M, Executor)
				sleep(4.5)
				M.Can_Dodge_ = 0
				if(M.Dodging == 1)
					M.Dragonned = 0
					M.freeze --
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					Flick("teleport", Executor)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return
				Flick("Rinnengan Sword", Executor)
				if(Target == 1) Executor.Execute_Jutsu("Rinnegan Sword!")
				if(M.Levitating) M.Check_Levitating()
				spawn(3.5)
					var/Damage = 35
					M.Damage(Executor, Damage, 0, 0, 0, 1)
				spawn(5)
					Executor.icon_state = "mob-standing"
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					M.Dragonned = 0
					M.freeze --
					M.Attacked(100)
					M.Damage(Executor, 0, 1, 0)

		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()

	Lava_Punches()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.layer = 125
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Lava_Whirl/K in Executor) K.Delay(3)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			if(M.Dodging == 0)
				Delay(15)
				for(var/obj/Jutsus/Lava_Whirl/K in Executor) K.Delay(5)
				Executor.Executed_Fully = 1
				M.freeze ++
				M.stop()
				M.Dragonned = 1
				M.Can_Dodge_ = 1
				Executor.Dragonned = 1
				Target ++
				Executor.Teleport_Behind(M, Executor)
				sleep(rand(3.75, 4.5))
				M.Can_Dodge_ = 0
				if(M.Dodging == 1)
					M.freeze --
					M.Dragonned = 0
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					Flick("teleport", Executor)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return
				Flick("FireFight", Executor)
				sleep(3)
				if(Target == 1) Executor.Execute_Jutsu("Lava Punches!")
				if(M.Levitating) M.Check_Levitating()

				spawn(2.5)
					var/Damage = 10
					M.Damage(Executor, Damage, 0, 0, 0, 1)

				spawn(4.75)
					var/DamagX = 10+rand(0,2.5)
					M.Damage(Executor, DamagX, 0, 0, 0, 1)

				spawn(7.5)
					spawn(2)
						Executor.icon_state = "mob-standing"
						Executor.Dragonned = 0
						Executor.pixel_x = 0
						Executor.freeze --
						Executor.layer = 100
						Executor.stop()
					if(M)
						M.Dragonned = 0
						var/DamagF = 18.5
						M.freeze --
						M.Damage(Executor, DamagF, 1, 2, 0, 1)

		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()

	Sword_Slash()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 55) == 0) return
		var/Target = 0
		Executor.freeze ++
		Executor.layer = 125
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Aoi_Combo/L in Executor.Jutsus) L.Delay(7)
				Executor.Dragonned = 0
				Executor.pixel_x = 0
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(M.Dodging == 0)
				Delay(15)
				M.Can_Dodge_ = 1
				for(var/obj/Jutsus/Aoi_Combo/L in Executor.Jutsus) L.Delay(15)
				Executor.Executed_Fully = 1
				M.Dragonned = 1
				M.stop()
				M.freeze ++
				Executor.Dragonned = 1
				Target ++
				Executor.Teleport_Behind(M, Executor)
				sleep(rand(3.75, 4.5))
				M.Can_Dodge_ = 0
				if(M.Dodging == 1)
					M.Dragonned = 0
					M.freeze --
					Executor.Dragonned = 0
					Executor.pixel_x = 0
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					Flick("teleport", Executor)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return
				if(Executor.dir == EAST) Executor.pixel_x += 38
				if(Executor.dir == WEST) Executor.pixel_x -= 38
				Flick("Combo2", Executor)
				sleep(3)
				if(Target == 1)Executor.Execute_Jutsu("Sword of the Thunder God!")
				if(M.Levitating) M.Check_Levitating()
				spawn(3.5)
					var/Damage = 10
					M.Damage(Executor, Damage, 0, 0, 0, 1)
				spawn(8)
					var/DamagF = 12.5
					M.Damage(Executor, DamagF, 0, 0, 0, 1)
				spawn(9.5)
					M.pixel_y+=40
				spawn(11)
					var/DamagX = 17.5
					M.Damage(Executor, DamagX, 0, 0, 0, 1)
				spawn(17)
					Executor.Dragonned = 0
					Executor.pixel_x = 0
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					Flick("teleport", Executor)
					if(M)
						M.Dragonned = 0
						M.pixel_y = 0
						var/DamagD = 15
						M.freeze --
						M.Damage(Executor, DamagD, 1, 2, 0, 1)

		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.freeze --
				Executor.layer = 100
				Executor.stop()

	Leaf_Hurricane_()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		var/Target = 0
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Great_Whirlwind/K in Executor) K.Delay(5)
				Flick("teleport", Executor)
				Executor.stop()
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Great_Whirlwind/P in Executor.Jutsus) P.Delay(7)
			Target = 1
			M.Can_Dodge_ = 1
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			Executor.freeze ++
			Executor.Executed_Fully = 1
			Executor.Dragonned = 1
			Executor.Teleport_Behind_RL_(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				M.freeze --
				M.Dragonned = 0
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Flick("Lotus I", Executor)
			sleep(4.5)
			M.freeze --
			M.stop()
			var/Previous_Layer = Executor.layer
			Executor.layer = (M.layer)+1
			Executor.Execute_Jutsu("Leaf Hurricane!")
			Executor.Substitution = 1
			M.Damage(Executor, 15, 0, 0, 0, 1)
			M.vel_y = 20
			M.Double_Jump = 1
			sleep(9)
			flick("Lotus II", Executor)
			spawn(6.75)
				M.Damage(Executor, 15+rand(0, 5), 1, 0, 0, 1)
				M.vel_y += 7
			var/T = 0
			while(T < 20)
				if(T < 17)
					if(Executor.dir == EAST) Executor.set_pos (M.px-18, M.py-18)
					if(Executor.dir == WEST) Executor.set_pos (M.px+18, M.py-18)
				else if(T == 17)
					Executor.layer = Previous_Layer
					Executor.Substitution = 0
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()

				T++
				sleep(0.3375)
			M.Dragonned = 0

		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.fall_speed = 25
				Executor.stop()

	SpecialAttack_As()
		var/mob/Executor = usr//LOOK HERE NICK
		var/T=0
		src.Executed_Fully=1
		if(Executor.Can_Execute(src, 35) == 0) return
		flick("teleport", Executor)
		for(var/mob/M in range("14x4"))
			if(T==1)return
			if(Executor.dir == EAST && M.px < Executor.px) continue
			else if(Executor.dir == WEST && M.px > Executor.px) continue
			if(M.Boulder >= 1|| M.BoulderX >= 1 || M == Executor || M.knocked == 1 || M.Real == 0 || M.Village == Executor.Village || M.Dragonned == 1) continue
			if(M.Dodging == 1)
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your Technique!"
			else
				T++
				Delay(13)
				Executor.Substitution = 1
				Executor.Executed_Fully=1
				Executor.Dragonned = 1
				M.InkCD=1
				M.freeze++
				flick("Uppercut", Executor)
				spawn(2)
					M.Dragonned = 1
					Executor.loc = M.loc
					M.CanMove = 1
					M.freeze --
					M.vel_y = 25
					M.Damage(Executor, 13, 0)
					M.Substitution=1
					spawn(3)
						Executor.loc = locate(M.x,M.y+2,M.z)
						flick("UpperUnder", Executor)
						spawn(1)
							M.Damage(Executor, 13, 1,2)
							M.vel_y=-65
							M.Substitution=0
							Executor.Substitution=0
							Executor.Dragonned = 0
							M.Dragonned = 0
							spawn(5)
								M.InkCD=0
								break
		spawn(2)
			if(T==0)
				Delay(2)
				return
	Leaf_Hurricane()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 25) == 0) return
		var/Target = 0
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Primary_Lotus_Might_Gai/J  in Executor) J.Delay(7)
				for(var/obj/Jutsus/Primary_Lotus_Rock_Lee/J  in Executor) J.Delay(7)
				for(var/obj/Jutsus/Leaf_Hurricane_PSasuke/K in Executor) K.Delay(3)
				for(var/obj/Jutsus/Lion_Barrage/K in Executor) K.Delay(3)
				Executor.fall_speed = 25
				Executor.Activated = 0
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				M.fall_speed = 25
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			for(var/obj/Jutsus/Primary_Lotus_Might_Gai/P in Executor.Jutsus) if(!P.Delay) P.Delay(7)
			for(var/obj/Jutsus/Primary_Lotus_Rock_Lee/P in Executor.Jutsus) if(!P.Delay) P.Delay(7)
			for(var/obj/Jutsus/Leaf_Hurricane_PSasuke/K in Executor) K.Delay(3)
			for(var/obj/Jutsus/Phoenix_Flower_PSasuke/K in Executor) K.Delay(3)
			for(var/obj/Jutsus/Lion_Barrage/K in Executor) K.Delay(3)
			Executor.Activated = 0
			M.Can_Dodge_ = 1
			Target = 1
			M.fall_speed = 0
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			Executor.freeze ++
			Executor.Executed_Fully = 1
			Executor.Dragonned = 1
			Executor.Teleport_Behind(M, Executor)
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Primary_Lotus_Might_Gai/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Primary_Lotus_Rock_Lee/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Leaf_Hurricane_PSasuke/K in Executor) K.Delay(3)
				for(var/obj/Jutsus/Lion_Barrage/K in Executor) K.Delay(3)
				Executor.Activated = 0
				M.fall_speed = 25
				M.freeze --
				M.Dragonned = 0
				Executor.Dragonned = 0
				Executor.fall_speed = 25
				Executor.freeze --
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				M.fall_speed = 25
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			Delay(15)
			for(var/obj/Jutsus/Primary_Lotus_Might_Gai/J in Executor) J.Delay(10)
			for(var/obj/Jutsus/Primary_Lotus_Rock_Lee/J in Executor) J.Delay(10)
			for(var/obj/Jutsus/Leaf_Hurricane_PSasuke/K in Executor) K.Delay(3)
			for(var/obj/Jutsus/Phoenix_Flower_PSasuke/K in Executor) K.Delay(3)
			for(var/obj/Jutsus/Lion_Barrage/K in Executor) K.Delay(3)
			Executor.Activated = 0
			Flick("leaf", Executor)
			sleep(3)
			spawn(10) Executor.fall_speed = 25
			M.freeze --
			Executor.freeze --
			Executor.Execute_Jutsu("Leaf Hurricane!")
			M.Damage(Executor, 15, 0, 0, 0, 1)
			M.vel_y = 15
			Executor.fall_speed = 0
			spawn(5)
				Flick("leaf2", Executor)
				Flick("hurt", M)
				Executor.loc=locate(M.x+1,M.y+1,M.z)
				spawn(5)
					if(Executor.dir == WEST) Executor.loc=locate(M.x-1,M.y+1,M.z)
					if(Executor.dir == EAST) Executor.loc=locate(M.x+1,M.y+1,M.z)
					Flick("leaf3",Executor)
					var/Damage = 20
					M.Damage(Executor, Damage, 1, 0, 0, 1)
					M.vel_y = 5
					spawn(10)
						Executor.Dragonned = 0
						Executor.fall_speed = 25
						Executor.stop()
						M.fall_speed = 25
						M.Dragonned = 0
						M.stop()
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.fall_speed = 25
				Executor.stop()
	Primary_Lotus()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 30) == 0) return
		var/Target = 0
		Executor.stop()
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Primary_Lotus_Might_Gai/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Leaf_Hurricane_Rock_Lee/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(7)
				for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(7)
				for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(7)
				Executor.layer = 100
				Executor.stop()
				Flick("teleport", Executor)
				M.Auto_Dodge (Executor)
				M.fall_speed = 25
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(M.Dodging == 0)
				for(var/obj/Jutsus/Leaf_Hurricane_Might_Gai/L in Executor.Jutsus) if(!L.Delay) L.Delay(7)
				for(var/obj/Jutsus/Leaf_Hurricane_Rock_Lee/L in Executor.Jutsus) if(!L.Delay) L.Delay(7)
				M.freeze ++
				M.stop()
				Executor.freeze ++
				Executor.Dragonned = 1
				Executor.Executed_Fully = 1
				M.Dragonned = 1
				M.Can_Dodge_ = 1
				Target = 1
				Executor.Teleport_Behind(M, Executor)
				sleep(rand(3.75, 4.5))
				M.Can_Dodge_ = 0
				if(M.Dodging == 1)
					Delay(10)
					for(var/obj/Jutsus/Primary_Lotus_Might_Gai/J in Executor) J.Delay(7)
					for(var/obj/Jutsus/Leaf_Hurricane_Rock_Lee/J in Executor) J.Delay(7)
					for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(7)
					for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(7)
					for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(7)
					M.Dragonned = 0
					M.freeze --
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.layer = 100
					Executor.stop()
					Flick("teleport", Executor)
					M.Auto_Dodge (Executor)
					M.fall_speed = 25
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return
				Delay(15)
				for(var/obj/Jutsus/Primary_Lotus_Might_Gai/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Leaf_Hurricane_Rock_Lee/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(10)
				for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(10)
				for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(10)
				for(var/obj/Jutsus/Raikiri/L in Executor.Jutsus) L.Delay(5)
				for(var/obj/Jutsus/Chidori_Kakashi/L in Executor.Jutsus) L.Delay(5)
				Flick("lotus2", Executor)
				Executor.Execute_Jutsu("Primary Lotus!")
				sleep(3)
				Executor.freeze --
				var/Damage = 15
				if(M.client)
					M.client.perspective = EYE_PERSPECTIVE
					M.Special_Eye = 1
					M.client.eye = Executor
				M.density = 1
				M.Damage(Executor, Damage, 0, 0, 0, 1)
				var/M_Speed_Multiplier = M.speed_multiplier
				var/Speed_Multiplier = Executor.speed_multiplier
				M.move_speed = 0
				M.speed_multiplier = 0
				M.freeze --
				M.Change_Direction = 0
				Executor.Substitution = 1
				Executor.Change_Direction = 0
				Executor.move_speed = 0
				Executor.speed_multiplier = 0
				spawn(2.5)
					new/obj/Effects/Meele_Hit (M.loc, M)
					M.vel_y = 25
					spawn(5)
						Executor.Teleport_(M)
						spawn(2)
							M.vel_y = 10
							Executor.vel_y = 10
							Flick("lotus4", Executor)
							spawn(2)
								Executor.vel_y = 10
								M.vel_y = 10
								Flick("lotus4", Executor)
							spawn(4)
								Executor.vel_y = 10
								M.vel_y = 10
								Flick("lotus4", Executor)
							spawn(6)
								Executor.freeze ++
								Executor.stop()
								M.freeze ++
								M.stop()
								Flick("lotus1", Executor)
								M.Substitution = 1
								M.invisibility = 101
								spawn(3.25)
									Executor.Attacking = 0
									Executor.Change_Direction = 1
									Executor.Substitution = 0
									Executor.speed_multiplier = Speed_Multiplier
									Executor.Run_Off()
									Executor.vel_y = -15
									Flick("lotus5", Executor)
									Executor.freeze --
							spawn(17.5)
								Executor.Dragonned = 0
								M.Dragonned = 0
							spawn(8)
								Flick("lotus5", Executor)
								spawn(6) Flick("lotus5", Executor)
								spawn(12)
									Flick("teleport", Executor)
									M.Change_Direction = 1
									M.speed_multiplier = M_Speed_Multiplier
									M.Run_Off()
									M.Attacking = 0
									M.invisibility = 0
									M.Substitution = 0
									M.Teleport_(Executor)
									spawn() M.Substitution = 0
									var/DamagF = 20+rand(0,5)
									M.Damage(Executor, DamagF, 1, 2, 0, 1)
									M.vel_y = 10
									M.freeze --
									M.invisibility = 0
									M.Dragonned = 0
									if(M.client)
										M.client.perspective = MOB_PERSPECTIVE
										M.client.eye = M
										M.Special_Eye = 0
									Executor.Attacking = 0
									Executor.Dragonned = 0
									Executor.stop()
		spawn()
			if(Target == 0)
				Flick("teleport", Executor)
				Executor.Attacking = 0
				Executor.stop()
mob/var/Executed_Fully = 0
mob/var/Can_Dodge_ = 0
mob/var/OldIcon
mob/var/Counting=0
mob/var/CanUseGates=1
mob/var/GoingSage=0
mob/var/Sage=0
mob/var/Kyuubi=0
mob/var/GoingSusanoo=0
mob/var/Susanoo=0
mob/var/Substitution=0
mob/var/SubstitutionCD=0
mob/proc/Substitution()
	if(name == "{Venomous Insects} Torune" && _CD || name == "ANBU Kakashi" && _CD) return
	if(No_Attack || Rasengan || Chidori || KakashiChidori || Dashing || DinamicEntry || Iron || Wall_Freeze || !Can_Substitution ||Levitating || Substitution || SubstitutionCD == 1 || knockback == 1 || freeze || Susanoo == 1 || dead == 1 || knocked == 1 || Gates == 1 || Boulder >= 1 || BoulderX >= 1 || Dragonned == 1) return
	if(Cha <= 10 || Energy <= 10) return
	if(E_Part == "Use Substitution") Complete_Genin_Part()
	Cha -= 10
	Energy -= 10
	Substitution_Action()

mob/proc/Substitution_Action(var/G)
	for(var/obj/Effects/Suigetsu_Attack/S in Overlays) del(S)
	var/obj/Image = image(icon, src, icon_state, 150)
	Substitution_Image = Image
	Image.alpha = 100
	src << Image
	invisibility = 101
	Substitution = 1
	density = 0
	SubstitutionCD = 1
	Dragonned = 1
	Can_Attack_ = 0
	if(!G)
		var/A=new/obj/Smoke(src.loc)
		A:pixel_x = src.pixel_x
		A:pixel_y = src.pixel_y
	if(dir == EAST) vel_x-=rand(20,25)
	if(dir == WEST) vel_x+=rand(20,25)
	spawn(15 +(Substitution_Duration_Boost *10))
		if(Substitution)
			invisibility = 0
			density = 1
			Dragonned = 0
			Can_Attack_ = 1
			Substitution = 0
	if(!G) spawn(150 /Substitution_Delay_Boost) SubstitutionCD = 0
	else spawn(50) SubstitutionCD = 0

mob/proc/Kyuubi()
	Kyuubi = 1
	CanGoKyuubi = 0
	NEM_Round.Shout("<font size=2><font color=#FE9A2E><u>- Naruto has transformed into Kyuubi! -</u>")
	icon = 'Graphics/Characters/Naruto Kyuubi.dmi'
	name = "(Kyuubi) Naruto"
	MaxEnergy = 1000
	Energy = 1000
	MaxCha = rand(1000,1500)
	Cha = MaxCha
	ultra_speed = 1
	speed_multiplier = 2.05
	MaxHP = 200
	HP = MaxHP
	Str = 16.5
	Def = 9
	Check_Jutsu()
	var/A = new/obj/GroundSmash(src.loc)
	if(src.dir==WEST) A:pixel_x-=15
	if(src.dir==EAST) A:pixel_x-=10

mob/proc/Sasuke_Curse_Seal()
	if(Sharingan) Sharingan_Off(src)
	Kyuubi = 1
	CanGoCS = 0
	NEM_Round.Shout("<font size=2><font color=#8904B1><u>- Sasuke has activated Curse Seal! -</u>")
	icon = 'Graphics/Characters/Curse Seal Sasuke.dmi'
	name = "(Curse Seal) Sasuke"
	MaxEnergy = 1000
	Energy = 1000
	MaxCha = rand(750,1000)
	Cha = MaxCha
	ultra_speed = 1
	speed_multiplier = 1.95
	MaxHP = 200
	HP = MaxHP
	Str = 16.5
	Def = 9
	Check_Jutsu()
	var/A=new/obj/GroundSmash(src.loc)
	if(src.dir==WEST) A:pixel_x-=15
	if(src.dir==EAST) A:pixel_x-=10

mob/var/Go_Through

mob/proc/Go_Through(var/N)
	Go_Through = N

	loop
		var/_V_
		for(var/mob/M in inside()) if(M.name == Go_Through) _V_ = 1
		if(_V_) spawn(2.5) goto loop
		else Go_Through = null

mob
	Rashomon
		icon = 'Graphics/Skills/Rashomon.dmi'
		layer = 105
		density = 1
		pheight = 210
		pwidth = 150
		pixel_y=5
		Active_M = 0
		pixel_x=30
		Real=0
		Checked_X = 0
		freeze=1
		Village
		ByPass = 0
		var/Creator
		New()
			..()
			spawn() for(var/mob/M in inside())
				if(M.Real && M.knocked == 0  && !M.freeze && !M.Puppet && M.Boulder == 0 && M.BoulderX == 0 && M.Gates == 0)
					if(dir == EAST) M.dir = WEST
					else M.dir = EAST
					M.Go_Through (name)
					M.Substitution_Action()
					M.vel_y = 15
			spawn(250) del(src)
mob
	Rashomon2
		icon = 'Graphics/Skills/Rashomon2.dmi'
		layer = 105
		density = 1
		pheight = 170
		pwidth = 100
		Real=0
		Checked_X = 0
		ByPass = 0
		Active_M = 0
		freeze=1
		Village
		var/Creator
		New()
			..()
			spawn() for(var/mob/M in inside())
				if(M.Real && M.knocked == 0  && !M.freeze && !M.Puppet && M.Boulder == 0 && M.BoulderX == 0 && M.Gates == 0)
					if(dir == EAST) M.dir = WEST
					else M.dir = EAST
					M.Go_Through (name)
					M.Substitution_Action()
					M.vel_y = 12
			spawn(250)del(src)

obj
	Crystal_Tree
		icon = 'Graphics/Skills/CrystalTree.dmi'
		name = "Crystal Tree"
		density = 1
		pixel_x = -12
		layer = 1000
		New()
			..()
			Flick("Go", src)
			spawn(7) del(src)
mob
	Space_Time_Barrier
		icon = 'Graphics/Skills/SpaceTimeBarrier.dmi'
		layer = 205
		density = 1
		pheight = 135
		pwidth = 48
		pixel_x = 26
		ByPass = 1
		Real = 0
		Checked_X = 0
		freeze = 1
		Active_M = 0
		var/New_B = 0
		var/Creator
		New()
			..()
			Flick("Go", src)
		Del()
			Flick("Disappear", src)
			spawn(7.5) ..()

	Absorbing_Barrier
		icon = 'Graphics/Skills/SpaceTimeBarrier Chakra.dmi'
		layer = 205
		density = 1
		pheight = 135
		pwidth = 48
		pixel_x = 26
		ByPass = 1
		Real = 0
		Checked_X = 0
		Active_M = 0
		freeze = 1
		var/Creator
		New()
			..()
			Flick("Go", src)
			spawn(900) del(src)
		Del()
			Flick("Disappear", src)
			spawn(7.5) ..()

	Wood_Pillar
		icon = 'Graphics/Skills/Wood Pillar.dmi'
		layer = 205
		density = 1
		pheight = 210
		pwidth = 100
		ByPass = 0
		pixel_x=30
		Real=0
		Checked_X = 0
		Active_M = 0
		freeze=1
		var/Creator
		New()
			..()
			spawn() for(var/mob/M in inside())
				if(M.Real && M.knocked == 0  && !M.freeze && !M.Puppet && M.Boulder == 0 && M.BoulderX == 0 && M.Gates == 0)
					if(dir == EAST) M.dir = WEST
					else M.dir = EAST
					M.Go_Through (name)
					M.Substitution_Action()
					M.vel_y = 12
			spawn(100)del(src)

	Earth_Wall
		icon = 'Graphics/Skills/RockWall.dmi'
		layer = 205
		density = 1
		pheight = 150
		pwidth = 90
		pixel_x=30
		ByPass = 0
		pixel_y=-4
		Active_M = 0
		Real=0
		Checked_X = 0
		freeze=1
		var/Creator
		New()
			..()
			spawn() for(var/mob/M in inside())
				if(M.Real && M.knocked == 0  && !M.freeze && !M.Puppet && M.Boulder == 0 && M.BoulderX == 0 && M.Gates == 0)
					if(dir == EAST) M.dir = WEST
					else M.dir = EAST
					M.Go_Through (name)
					M.Substitution_Action()
					M.vel_y = 12
			spawn(150) del(src)
mob
	Advent_Of_Bugs
		icon = 'Graphics/Skills/Advent Bugs.dmi'
		layer = 250
		pixel_y = -6
		Active_M = 0
		freeze = 1
		density = 0
		Real = 0
		var/L = 1
		Checked_X = 0
		var/mob/_Creator
		var/list/Caught = list()
		New()
			..()
			bound_width = 170
			bound_height = 100
			Flick("Go", src)
			spawn(100)
				L = 0
				del(src)
			spawn(8.75)
				icon_state = "Continue"
				loop
					if(!L) return
					for(var/mob/M in bounds(src, 0))
						if(M.Real  && !M.Dragonned && !M.knocked && M.Village != Village && !M.Susanoo && !M.Boulder && !M.BoulderX && !M.Gates)
							var/C
							if(Caught.Find(M)) C = 1
							if(!C)
								M.freeze ++
								Caught.Add(M)
							M.Dragonned = 1
					for(var/mob/M in Caught)
						new/obj/Hit (M.loc)
						M.Poison_Proc(rand(1, 3), "Advent of Bugs")
						M.CanMove = 0
						M.HP -= 1.5
						M.Cha -= 2.5
						_Creator.Cha += rand(0.5, 1)
						if(_Creator.Cha > _Creator.MaxCha) _Creator.Cha = _Creator.MaxCha
						M.Death_Check(_Creator)
						Flick("hurt", M)
					spawn(3) goto loop

		Del()
			Flick("End", src)
			spawn(3.75) ..()
			for(var/mob/M in Caught)
				M.Dragonned = 0
				M.freeze --
				Caught.Remove(M)
	Earth_Dome
		icon = 'Graphics/Skills/Earth Dome.dmi'
		layer = 250
		//pheight = 115
		//pwidth = 150
		pixel_y= -20
		freeze=1
		Real=0
		Active_M = 0
		var/Deleting
		Checked_X = 0
		var/mob/_Creator
		var/list/Caught = list()
		New()
			..()
			spawn(300) del(src)
			Flick("Go", src)
			spawn(4)
				loop
					if(Deleting) return
					for(var/mob/M in hearers(src, 3))
						if(_Creator.dir == EAST && M.px < _Creator.px) continue
						if(_Creator.dir == WEST && M.px > _Creator.px) continue
						if(Caught.Find(M)) continue
						if(M.Real  && !M.Dragonned && !M.knocked && M.Village != Village)
							Caught.Add(M)
							M.freeze ++
							M.Dragonned = 1
					spawn(5)
						goto loop

		Del()
			Deleting = 1
			for(var/mob/M in Caught)
				M.CanMove = 1
				M.Dragonned = 0
				M.freeze --
				Caught.Remove(M)
			_Creator.freeze --
			Flick("End", src)
			spawn(3) ..()
mob
	Ice_Spike
		Real_Person = 1
		icon = 'Graphics/Skills/Ice Spike.dmi'
		name = "Ice Spike"
		layer = 55
		density = 1
		pheight = 90
		pwidth = 50
		bound_width=50
		bound_height=90
		pixel_y=5
		ByPass = 0
		pixel_x=30
		Real=0
		Checked_X = 0
		layer = 200
		density = 1
		var/T=0
		var/Creator

		New()
			..()
			spawn() for(var/mob/M in inside())
				if(M.Real && M.knocked == 0  && !M.freeze && !M.Puppet && M.Boulder == 0 && M.BoulderX == 0 && M.Gates == 0)
					if(dir == EAST) M.dir = WEST
					else M.dir = EAST
					M.Go_Through (name)
					M.Substitution_Action()
					M.vel_y = 12
			Flick("Go", src)
			spawn(50)
				Flick("End", src)
				spawn(3) del(src)
	Rock_Spike
		Real_Person = 1
		icon = 'Graphics/Skills/RockSpike.dmi'
		name = "Rock Spike"
		layer = 55
		density = 1
		pheight = 95
		pwidth = 45
		bound_width=45
		bound_height=90
		ByPass = 0
		pixel_x=32
		Real=0
		Checked_X = 0
		layer = 200
		density = 1
		var/T=0
		var/Creator

		New()
			..()
			spawn() for(var/mob/M in inside())
				if(M.Real && M.knocked == 0  && !M.freeze && !M.Puppet && M.Boulder == 0 && M.BoulderX == 0 && M.Gates == 0)
					if(dir == EAST) M.dir = WEST
					else M.dir = EAST
					M.Go_Through (name)
					M.Substitution_Action()
					M.vel_y = 12
			spawn(60) del(src)

	Crystal_Spike
		Real_Person = 1
		icon = 'Graphics/Skills/Crystal.dmi'
		name = "Crystal Spike"
		layer = 55
		density = 1
		pheight = 90
		pwidth = 50
		bound_width=50
		ByPass = 0
		bound_height=90
		Real=0
		Checked_X = 0
		layer = 200
		density = 1
		var/T=0
		var/Creator

		New()
			..()
			spawn() for(var/mob/M in inside())
				if(M.Real && M.knocked == 0  && !M.freeze && !M.Puppet && M.Boulder == 0 && M.BoulderX == 0 && M.Gates == 0)
					if(dir == EAST) M.dir = WEST
					else M.dir = EAST
					M.Go_Through (name)
					M.Substitution_Action()
					M.vel_y = 12
			Flick("Go", src)
			spawn(50)
				Flick("Redo", src)
				spawn(5) del(src)
	Tree
		Real_Person = 1
		icon = 'Graphics/Skills/Mokuton.dmi'
		name = "Tree"
		layer = 55
		density = 1
		pheight = 130
		pwidth = 50
		bound_width=50
		ByPass = 0
		bound_height=150
		pixel_y=5
		pixel_x=30
		Real=0
		Checked_X = 0
		layer = 200
		density = 1
		var/T=0
		New()
			..()
			spawn() for(var/mob/M in inside())
				if(M.Real && M.knocked == 0  && !M.freeze && !M.Puppet && M.Boulder == 0 && M.BoulderX == 0 && M.Gates == 0)
					if(dir == EAST) M.dir = WEST
					else M.dir = EAST
					M.Go_Through (name)
					M.Substitution_Action()
					M.vel_y = 12
			Flick("Go", src)
			spawn(100)
				Flick("End", src)
				spawn(1.85) del(src)
mob/InkDragon
	Real_Person = 1
	icon = 'Graphics/Skills/InkDragon.dmi'
	density = 1
	layer =	 105
	pwidth = 70
	Real = 0
	ByPass = 0
	Checked_X = 0
	var/list/Caught=list()
	pheight = 100
	var/T = 0
	New(loc, _dir)
		..()
		dir = _dir
		flick("Go", src)
		spawn(120) del(src)
		spawn()
			loop
				var/_Target_
				T+=1
				if(T>=16) del(src)
				for(var/mob/M in Caught)
					if(M.Dragonned==1)
						_Target_ ++
						M.Dragonned = 1
						var/Damage = 4.25+rand(0.1,0.75)
						M.Damage(Owner, Damage, 1, 0, 0, 0, 0, 1)
						M.Attacked = 1
						M.loc=locate(src.x,src.y+2,src.z)
				for(var/mob/M in hearers(2))
					if(Caught.Find(M)) continue
					if(!istype(M,/mob/InkDragon)&&M.Real==1&&M.Dragonned==0&&M.Village!=Village&&M.Gates==0&&M.BoulderX==0&&M.Boulder==0&&M.knocked==0)
						_Target_ ++
						M.OldX = M.x
						M.OldY = M.y
						M.Dragonned = 1
						M.Attacked = 1
						M.freeze ++
						Caught.Add(M)
				if(_Target_) Owner:Damage_Up(4.25+rand(0.1, 0.75))
				spawn(7.5) goto loop
	Del()
		for(var/mob/M in Caught)
			M.Dragonned = 0
			M.Attacked = 0
			M.freeze --
			M.stop()
			Caught.Remove(M)
		Flick("Down", src)
		spawn(10) ..()

/*mob/Dragonpearl123/verb/Fix()
	if(alert(src, "Are you sure?", "Confirmation", "No", "Yes") == "Yes")
		if(alert(src, "Are you sure?", "Confirmation", "Yes", "No") == "Yes")
			if(alert(src, "Are you sure?", "Confirmation", "No", "Yes") == "Yes")
				for(var/Statistic/S in Statistics)
					S.Village_Damage_Received = 1
					S.Village_Damage_Done = 1
					S.Damage_Received = 1
					S.Damage_Done = 1
					S.Village_KOs = 1
					S.Village_KOds = 1
					S.KOs = 1
					S.KOds = 1
					S.Kills = 0
					S.Rounds_Played = 1
					S.Characters_Used = list()
					S.Characters_Enemies = list()
					S.Enemies = list()
					S.Assists = 0*/

mob/proc/Damage_Up(var/A)
	if(NEM_Round != Current_NEM_Round || A <= 0) return
	Statistic.Damage_Done += A

mob/var/Dragonned=0
obj/H_H


mob/var/Regenerate_Chakra = 1

mob/proc/Chakra_Drain()
	if(Chakra_Drain_Active) return
	Chakra_Drain_Active = 1

	loop
		if(name != "ANBU Kakashi" && name != "Rinnegan Tobi")
			Chakra_Drain_Active = 0
			return
		if(Substitution != 2) Regenerate_Chakra = 1
		spawn(5) goto loop
		var/C = 0
		for(var/mob/M in RT) C++
		if(C)
			Regenerate_Chakra = 0
			if(Kamui) C *= 1.5
			if(!Kamui) C *= 0.75
			if(name == "ANBU Kakashi") C *= 1.75
			src.Cha -= C
			if(Cha <= 0 || knocked == 1)
				if(Kamui == 1)
					Kamui = 0
					loc = Remembered_Location
					RT.Remove(src)
					Flick("teleport", src)
				spawn() for(var/mob/M in RT)
					M.Kamui = 0
					M.density = 0
					M.loc = loc
					M.set_pos (px, py)
					RT.Remove(M)
					spawn(5) M.density = 1
					spawn(1)
						M.vel_y = 5
						if(M.dir == WEST) M.knockbackwest()
						if(M.dir == EAST) M.knockbackeast()
						NEM_Round.Shout("<b><font color=#710093><u>[src.name] has nullified [M.name]'s Kamui!</u>")
				src<<"<b><font color=#710093><u>Kamui's effects have disappeard as your chakra vanished!</u>"

mob/var
	Ant
	Illusion_ = 0
	Damaged_Again = 0
	Chakra_Drain_Active = 0

mob/Torune Fall_Special = 0
mob/Kakashi Fall_Special = 0

mob/proc
	Special_Tayuya_Jutsu()
		..()
		spawn(5.10)
			Dragonned = 0
			CanMove = 1
			freeze --
			stop()

	Black_Ant(mob/Kankuro)
		..()

		stop()
		Kankuro.Regenerate_Chakra = 0
		new/obj/Black_Ant (loc, src, Kankuro)
		Kankuro << "<font color=#BB9F7C><b><u>You are now using Black Ant on [src], to unsummon it press Q.</u></font>"
		src << "<font color=#BB9F7C><b><u>You have been trapped in [Kankuro]'s Black Ant untill he runs out of chakra or releases you.</u></font>"

obj
	Special_Effect
		var
			mob/Creator
			Special
			Time
			EAST_
			WEST_
			Y

		New(mob/_Creator, var/G)
			..()
			Creator = _Creator
			if(!G) Creator.invisibility = 101
			else Special = 1
			layer = (Creator.layer) +10
			loc = Creator.loc
			step_x = Creator.step_x
			step_y = Creator.step_y
			dir = Creator.dir
			pixel_y += Y
			if(dir == EAST) pixel_x += EAST_
			if(dir == WEST) pixel_x += WEST_
			Flick("Go", src)
			spawn(Time) del(src)

		Sai
			icon = 'Graphics/Skills/Sai I.dmi'
			Time = 8
			EAST_ = -10
			WEST_ = -10

		Shisui
			icon = 'Graphics/Characters/Shisui.dmi'
			icon_state = "teleport"
			Time = 8
			EAST_ = -10
			WEST_ = -10

		Shino
			icon = 'Graphics/Skills/Shino II.dmi'
			Time = 6.25
			EAST_ = -11
			WEST_ = -9
			Y = -2

		Sawarbi
			icon = 'Graphics/Skills/Sawarbi.dmi'
			Time = 15.4
			EAST_ = -43
			WEST_ = -37
			Y = -5

		Jiraiya_Katon
			icon = 'Graphics/Skills/Jiraiya Katon.dmi'
			Time = 19
			EAST_ = 21
			WEST_ = -122
			Y = 2

		Itachi
			icon = 'Graphics/Skills/Itachi Crow.dmi'
			Time = 7
			EAST_ = -45
			WEST_ = -35
			Y = -12

		Konan
			icon = 'Graphics/Skills/Konan Special.dmi'
			Time = 4

		Del()
			if(!Special)
				Creator.invisibility = 0
				Creator.Dragonned = 0
				Creator.freeze --
				Creator.stop()
			..()

	Effects_Raiton
		New(mob/M, mob/Creator)
			..()
			layer = (M.layer) +10
			loc = M.loc
			step_x = M.step_x
			step_y = M.step_y
			dir = Creator.dir
			pixel_y -= 16
			if(dir == EAST)
				M.dir = WEST
				pixel_x -= 32
			if(dir == WEST)
				M.dir = EAST
				pixel_x -= 16
			Flick("Go", src)
			spawn(8) del(src)

		Darui_Raiton icon = 'Graphics/Skills/DaruiRaiton.dmi'

	Panther_Effect_Special
		icon = 'Graphics/Skills/Darui Special X.dmi'
		alpha = 175
		pixel_x = -12
		New(mob/M, mob/Creator, var/D)
			..()
			M.Dragonned = 1
			M.freeze ++
			spawn(3)
				layer = (M.layer) +10
				loc = M.loc
				step_x = M.step_x
				step_y = M.step_y
				if(D == "EAST") M.dir = WEST
				if(D == "WEST") M.dir = EAST
				dir = M.dir
				Flick("Go", src)
				spawn(5.5)
					M.Dragonned = 0
					M.freeze --
					M.stop()
					M.Damage(Creator, 20, 1)
				spawn(9) del(src)

	Raiton_Effect_Special
		icon = 'Graphics/Skills/Darui Raiton XXX.dmi'
		alpha = 175
		New(mob/M, mob/Creator, var/D, var/SY, var/Y)
			..()
			M.freeze ++
			M.Dragonned = 1
			layer = (M.layer) +10
			loc = M.loc
			y = Y
			dir = D
			step_x = M.step_x
			step_y = SY
			pixel_y = 7
			if(dir == EAST) M.dir = WEST
			if(dir == WEST) M.dir = EAST
			Flick("End", src)
			spawn(2.5)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Creator, 55, 1, 2)
			spawn(7) del(src)


	Black_Ant
		icon = 'Graphics/Skills/OP Kankuro Bind.dmi'
		alpha = 125
		var/Deleted
		var/mob/Enemy
		var/mob/_Creator

		New(loc, mob/_Enemy, mob/Kankuro)
			..()
			Enemy = _Enemy
			dir = Enemy.dir
			step_x = Enemy.step_x
			layer = (Enemy.layer) +5
			if(dir == EAST) pixel_x += 10
			if(dir == WEST) pixel_x -= 10
			step_y = Enemy.step_y
			_Creator = Kankuro
			Kankuro.Ant = src
			Flick("Appear", src)
			spawn(22.05)
				Enemy.invisibility = 101
				alpha = 255
				Check()

		proc
			Check()
				..()
				var/Round_ = Round
				var/Damage = 1

				loop
					if(Deleted) return

					if(_Creator.Cha <= 0 || _Creator.knocked || _Creator.dead || Round_ != Round)
						_Creator << "<font color=#BB9F7C><b><u>You have ran out of chakra, [Enemy] has been released!</u></font>"
						del(src)
					else
						_Creator.Cha -= 2
						_Creator.Regenerate_Chakra = 0
						Enemy.Dragonned = 1
						Enemy.Damage(_Creator, Damage, 0, 0, 0, 1, 0)
						spawn(5) goto loop

		Del()

			Flick("Disappear", src)
			Deleted = 1
			alpha = 175
			spawn(5.15) ..()

			if(_Creator)
				for(var/obj/Jutsus/Black_Ant/B in _Creator.Jutsus) spawn() B.Delay(30)
				_Creator << "<font color=#BB9F7C><b><u>The Black Ant has been unsummoned!</u></font>"
				_Creator.Ant = null
				_Creator.Regenerate_Chakra = 1

			if(Enemy)
				Enemy << "<font color=#BB9F7C><b><u>The Black Ant has been unsummoned!</u></font>"
				spawn() Enemy.invisibility = 0
				Enemy.Damage(_Creator, 0.5, 1, 0, 0, 1, 0)
				Enemy.Dragonned = 0
				Enemy.freeze --
				Enemy.stop()

obj
	Animation
		var/mob/Creator

		New(mob/_Creator)
			..()
			Creator = _Creator
			Creator.invisibility = 101
			layer = (Creator.layer) +10
			loc = Creator.loc
			dir = Creator.dir
			step_x = Creator.step_x
			step_y = Creator.step_y
			pixel_y -= 16
			if(dir == EAST) pixel_x = 16
			if(dir == WEST) pixel_x = -39
			Flick("Go", src)

		Del()
			Flick("End", src)
			spawn(3.5)
				Creator.Dragonned = 0
				Creator.invisibility = 0
				Creator.freeze --
				Creator.stop()
				..()

		Raikage_Kick icon = 'Graphics/Skills/Raikage Special.dmi'

mob/var/Venomous_Clone = 0