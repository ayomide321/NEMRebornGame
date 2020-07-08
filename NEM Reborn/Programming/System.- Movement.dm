mob/var/Puppet
mob/var/Teleporting_Barrier = 0

client
	pixel_x = 15
	pixel_y = 120


obj
	Image
		layer = 100
	Tsukuyomi
		layer = 90
		icon = 'Graphics/Skills/Tsukuyomi.dmi'
		New()
			var/icon/I= new(src.icon)
			I.Scale(200,140)
			src.icon = I
mob/var/trace = 0
mob/var/CanHearAll = 0



atom
	var
		px = -1
		py = -1
		_px = 0
		_py = 0
		pwidth = -1
		pheight = -1
		pleft = 0
		pright = 0
		scaffold = 0
		flags = 0
		flags_right = 0
		flags_left = 0
		flags_bottom = 0
		flags_top = 0
		Special_PY = 0

	New()
		..()

		if(icon_width == -1) world.set_icon_size()
		if(pwidth == -1) pwidth = icon_width
		if(pheight == -1) pheight = icon_height
		if(pleft == 0 && pright == 0)
			pleft = pheight
			pright = pheight

		if(x && y)
			px = icon_width * x
			py = icon_height * y
		if(istype(src, /turf/Special_Floor))
			py += Special_PY
			pheight = 32 -Special_PY
			if(pheight <= 0)
				spawn()
					var
						Loc
						Layer
						Icon
						Icon_State
						Pixel_Y
						Pixel_X
						list/Overlays = list()
					for(var/turf/L in view(src, 1)) if(L.y < y && L.x == x)
						Icon = L.icon
						Icon_State = L.icon_state
						Pixel_Y = L.pixel_y
						Pixel_X = L.pixel_x
						Layer = L.layer
						Loc = L

					var/turf/Special_Floor/T = new/turf/Special_Floor (Loc)
					for(var/Turfs in Overlays) T.overlays += Turfs
					T.Special_PY = Special_PY -32
					T.icon = Icon
					T.icon_state = Icon_State
					T.pixel_y = Pixel_Y
					T.pixel_x = Pixel_X
					T.layer = Layer
					del(src)

	proc
		height(qx,qy,qw,qh)
			if(pright > pleft)
				. = min(icon_height, qx + qw - px)
				. = py + pleft + (.) * (pright - pleft) / pwidth
				. = min(., py + pright)
			else
				. = max(0, qx - px)
				if(. > px + pwidth) return -100
				. = py + pleft + (.) * (pright - pleft) / pwidth
				. = min(., py + pleft)

			. = round(.)


atom/movable
	step_size = 1
	New()
		..()
		bound_width = pwidth
		bound_height = pheight
turf
	Special_Floor
		Special_Floor_Var = 1
		pleft = 32
		pright = 32
		Special_PY = 31
		layer = 50

obj/Wall {density = 1}

mob
	animate_movement = 0

	var
		vel_x = 0
		vel_y = 0

	proc
		can_bump(atom/a)

			if(isturf(a))
				if(Real_Person)
					if(istype(a, /turf/Wall_Stand) && !Wall_Jump && !Substitution)
						if(Get_On_Wall && !Attacking && !GoingSage && a.y == y && Boulder == 0 && !Intangible && BoulderX == 0 && !On_Wall && client && Cha >= 5 && !knockback && !knocked && !Levitating && a.y >= y && !on_ground && !KakashiChidori && !Susanoo && !Gates && !Chidori && !Rasengan && !Iron && !DinamicEntry)
							var/Direction
							if(a.px < px) Direction = "West"
							else Direction = "East"
							if(Direction == "East" && keys[controls.right] || Direction == "West" && keys[controls.left]) {Double_Jump = 0; new/obj/Effects/Wall_Standing (loc, src, Direction)}
							return 1
					if(istype(a, /turf/Special_Floor))
						if(Fall_Special) return 0
						else if(a:py >= py || Fall_Special) return 0
						else if(a:py < py && vel_y <= 0)
							if(Target)
								if(Target:py -py < 10 && Target:py - py > -16) return 1
								else return 0
							else return 1
					else return a.density
				else return a.density

			else if(ismob(a))
				if(a:knocked || knocked || Active_Attack && a:ByPass || a:Active_Attack) return 0
				if(a:ByPass == 0)
					if(Go_Through != a:name) return 1
					else if(Substitution) return 0
				if(istype(src, /mob/Ultimate_Projectile/))
					if(src:Just_Created)
						if(dir == EAST && a:px < src:PX) return 0
						if(dir == WEST && a:px > src:PX) return 0
					if(a:Dodge_Next == 1) return 0
					if(istype(a, /mob/Space_Time_Barrier) && Teleporting_Barrier == a) return 0
					if(a:Village == src:Allies) return 0
					if(a:density) src:Check_Damage(a)
				if(a:On_Wall == 20 && src.On_Wall != 20 && src.On_Wall > 0) return 0
				if(a:_Special_Puppet_ && !_Special_Puppet_ && a:alpha == 255 && a:Village == Village)
					a:Substitution = 1
					a:alpha = 175
					spawn(8) {a:Substitution = 0; a:alpha = 255}
				if(Puppet) if(!src:CanAttack_ || a:Village == Village) return 0
				if(a:Puppet) if(a:Village == Village) return 0
				if(!Substitution && !a:Substitution) return a.density

			else if(isobj(a))
				if(istype(a, /obj/Scroll) && !a:Active && a:Allies != Village && Real && !Dragonned && !knocked && !Susanoo && !Boulder && !BoulderX && !Gates) {a:Activate(a, src); return 0}
				if(istype(a, /obj/Makibishi_Shuriken) && !Shuriken_Damage && Real && !Dragonned && !knocked && !Susanoo && !Boulder && !BoulderX && !Gates && a:Allies != Village)
					a:Hurt(src)
					Shuriken_Damage = 1
					spawn(4.50) Shuriken_Damage = 0
					return 0
			return 0


		pixel_move(dpx, dpy)
			bound_width = pwidth
			bound_height = pheight
			var/ipx = round(abs(dpx)) * ((dpx < 0) ? -1 : 1)
			var/ipy = round(abs(dpy)) * ((dpy < 0) ? -1 : 1)

			_px += (dpx - ipx)
			_py += (dpy - ipy)
			dpx = ipx
			dpy = ipy

			while(_px > 0.5)
				_px -= 1
				dpx += 1
			while(_px < -0.5)
				_px += 1
				dpx -= 1

			while(_py > 0.5)
				_py -= 1
				dpy += 1
			while(_py < -0.5)
				_py += 1
				dpy -= 1

			move_x = dpx
			move_y = dpy

			var/bumped = 0
			if(on_left && move_x < 0)
				move_x = 0
				dpx = 0
				bumped |= LEFT
			else if(on_right && move_x > 0)
				move_x = 0
				dpx = 0
				bumped |= RIGHT

			if(on_ground && move_y < 0)
				move_y = 0
				dpy = 0
				bumped |= DOWN

			if(Active_Attack)
				for(var/mob/a in obounds(src, move_x+Special_Width, move_y+Special_Height, abs(move_x), abs(move_y)))
					if(move_x == 0 && move_y == 0) break
					Special_Attack(a)
				if(on_ground) Active_Attack = 0

			for(var/atom/a in obounds(src, move_x, move_y, abs(move_x), abs(move_y)))
				if(move_x == 0 && move_y == 0) break
				if(!can_bump(a)) continue
				block_collision(a)

			set_pos(px + move_x, py + move_y)

			if(dpx > 0 && move_x < dpx) bumped |= RIGHT
			else if(dpx < 0 && move_x > dpx) bumped |= LEFT
			if(dpy > 0 && move_y < dpy) bumped |= UP
			else if(dpy < 0 && move_y > dpy) bumped |= DOWN

			if(bumped & RIGHT) for(var/atom/a in right(1)) if(can_bump(a)) bump(a, RIGHT)
			else if(bumped & LEFT) for(var/atom/a in left(1)) if(can_bump(a)) bump(a, LEFT)
			if(bumped & UP) for(var/atom/a in top(1)) if(can_bump(a)) bump(a, UP)
			else if(bumped & DOWN) for(var/atom/a in bottom(1)) if(can_bump(a)) bump(a, DOWN)

			return bumped ? 0 : 1

		set_pos(nx, ny, map_z = -1)

			if(istype(nx, /atom))
				var/atom/a = nx

				if(istype(a, /turf))
					loc = a
				else
					loc = a.loc

				return set_pos(a.px + (a.pwidth - pwidth) / 2, a.py + (a.pheight - pheight) / 2, a.z)

			if(map_z == -1) map_z = z

			var/moved = (nx != px || ny != py || map_z != z)

			px = round(nx)
			py = round(ny)

			var/tx = round((px + pwidth / 2) / icon_width)
			var/ty = round((py + pheight / 2) / icon_height)

			if(moved)
				var/turf/old_loc = loc
				var/turf/new_loc = locate(tx, ty, map_z)
				if(new_loc.y <= 2) Auto_Spawn()

				if(new_loc != old_loc)
					var/area/old_area = old_loc:loc
					Move(new_loc, dir)
					if(new_loc)
						new_loc.Entered(src)

					loc = new_loc

					if(new_loc)
						var/area/new_area = new_loc.loc

						if(old_area != new_area)
							if(old_area) old_area.Exited(src)
							if(new_area) new_area.Entered(src)

					if(!loc) Auto_Spawn()
				step_x = px - x * icon_width
				step_y = py - y * icon_height


			last_x = x
			last_y = y
			last_z = z


mob/var/Special_Crow
mob/var/Dashing
mob/var/Dashing_CD

mob/proc
	Itachi_Dash()
		var/Previous_HP = HP
		loop
			if(!Dashing) return
			if(HP < Previous_HP)
				Itachi_Dash_Off()
				return

			new/obj/Effects/Itachi_Dash (loc, src)
			if(dir == EAST) vel_x = 35
			else vel_x = -35
			spawn(0.75) goto loop

	Itachi_Dash_()
		if(Dashing) Itachi_Dash_Off()
		if(Dashing_CD || knockback || !on_ground || freeze || Attacking || knocked || Substitution) return

		else

			if(Cha < 15)
				Cooldown_Display (15)
				return

			Flick("Hand-Seals", src)
			Cha -= 15
			freeze ++
			var/Freeze = freeze
			var/Old_HP = HP
			sleep(6)

			if(knocked || Freeze != freeze || knockback || HP < Old_HP)
				freeze --
				return

			freeze --
			invisibility = 101
			Rasengan = "Itachi Dash"
			Dashing = 1
			Itachi_Dash()

	Itachi_Dash_Off()
		invisibility = 0
		Dashing = null
		Rasengan = null
		Dashing_CD = 1
		spawn(50) Dashing_CD = 0

	Itachi_Crow()
		Special_Crow = 0
		for(var/obj/Jutsus/Crow_Genjutsu_/C in Jutsus) spawn() C.Delay(10)
		if(loc) new/mob/Itachi_Crow (loc, src)
		Substitution_Action (1)

mob/var/Itachi_Special_Illusion
var/Illusion_Ready
var/Rare_Itachi
obj/Image_Illusion

proc/Itachi_Illusion(mob/C)
	Rare_Itachi = C
	for(var/obj/Itachi_AOE_Illusion/A in world) flick("Go", A)
	spawn(7)
		var/mob/I = new/mob/Ultimate_Projectile/Crow_Itachi (null, C)
		I.dir = EAST
		I.vel_x = abs(I.vel_x)
		I.loc = locate(155, 133, 2)
	loop
		if(Illusion_Ready == 1)
			Illusion_Ready = 2
			for(var/obj/Itachi_AOE_Illusion_X/A in world) flick("Go", A)

		if(Illusion_Ready == 3)
			var/mob/F = new/mob/Ultimate_Projectile/Itachi_Flame (null, C)
			F.dir = EAST
			F.vel_x = abs(F.vel_x)
			F.loc = locate(275, 169, 2)
			for(var/mob/M in world) if(M.Itachi_Special_Illusion) M.client.eye = F
			Illusion_Ready = 0
			if(C) C.Damage_Up(55+rand(1, 10))
			return

		spawn(0.5) goto loop


mob/proc/Itachi_Illusion_Self()
	var/Previous_HP = HP
	var/Previous_Chakra = Cha
	var/Previous_Energy = Energy
	No_Icon = 1
	Transformed = 1
	Itachi_Special_Illusion = 1
	client.perspective = EYE_PERSPECTIVE
	var/obj/Image = new/obj/Image_Illusion ()
	var/image/_Image = image(icon, Image, icon_state, 100)
	Image.loc = locate(168, 133, 2)
	Image.step_x = 0
	Image.step_y = 0
	_Image.icon_state = "mob-standing"
	_Image.alpha = 255
	_Image.dir = EAST
	src << _Image

	client.eye = Image
	icon_state = "mob-standing"
	Dragonned = 100
	freeze = 100
	stop()

	overlays += 'Graphics/Skills/Genjutsu I.dmi'
	spawn(21.5) flick("hurt", _Image)
	spawn(23)
		_Image.layer = 0
		_Image.icon_state = "Knocked"
		HP = 0
		Cha = 0
		Energy = 0
	spawn(37)
		Transformed = null
		Image.loc = locate(314, 169, 2)
		_Image.layer = 100

		var/T
		spawn(5)

			loop
				T++
				if(!Transformed) client.eye = locate(Image.x-T, Image.y, Image.z)
				if(T != 39) spawn(0.795) goto loop
				if(T == 20)
					if(!Illusion_Ready) Illusion_Ready = 1
					spawn(7.65)
						Transformed = 1
						if(Illusion_Ready == 2) Illusion_Ready = 3
						spawn(27.5)
							overlays -= 'Graphics/Skills/Genjutsu I.dmi'
							HP = Previous_HP
							Cha = Previous_Chakra
							Energy = Previous_Energy
							Damage(Rare_Itachi, 55+rand(1, 10), 1, 0, null, null, null, 1)
							No_Icon = null
							Transformed = null
							client.perspective = MOB_PERSPECTIVE
							client.eye = src
							Dragonned = 0
							freeze = 0
							Itachi_Special_Illusion = null
							del(_Image)
							del(Image)


mob
	Itachi_Crow
		icon = 'Graphics/Skills/Itachi Crow X.dmi'
		HP = 10000000000000
		dead = 1
		knocked = 1
		Dragonned = 1
		No_Icon = 1
		layer = 150
		density = 1

		New(L, mob/Creator)
			..()
			speed_multiplier = Creator.speed_multiplier
			ultra_speed = Creator.ultra_speed
			move_speed = Creator.move_speed
			if(Creator.loc) loc = Creator.loc
			dir = Creator.dir
			step_x = Creator.step_x
			step_y = Creator.step_y
			Old_PX = Creator.px
			Old_PY = Creator.py
			spawn() flick("Go", src)
			if(dir == EAST) knockbackwest()
			else knockbackeast()
			spawn(7.65) del(src)

			loop
				..()
				Checks_Loc ++
				if(Checks_Loc >= 3)
					if(name != "[key]" && Checked_X == 1 && Absorbed == 0)
						var/F = 0
						for(var/turf/W in obounds(src))
							if(!can_bump(W))
								if(W.Is_Water) Water_Drain()
								continue

							if(F == 0)
								F = 1
								Checks_Loc = 0
								stop()
								check_loc()
								if(Old_PX && Old_PY) set_pos(Old_PX, Old_PY)
								else Auto_Spawn()
								stop()
								check_loc()

						if(F == 0) {Old_PX = px; Old_PY = py}
				spawn(0.25) goto loop