var/tmp/NEM_Round/Current_NEM_Round
mob/var/Deflection = 0
mob/var/SpamCD = 0

mob/proc
	Projectile(var/mob/O,var/mob/M,var/G, var/L, var/E, var/S)
		if(!M.Real || !O.Real || !O || !M) return

		var/Damage = G
		if(Damage < 0)
			Damage = 0
			Dodge()
		switch(rand(1,10))
			if(10)
				if(M.Levitating) M.Check_Levitating()
				M.Dodge()
				M.stop()
			else
				var/KnockBack = 0
				if(Damage >= 25) KnockBack++
				if(Damage >= 40) KnockBack++
				M.Damage(O, Damage, 1, KnockBack, src)
				if(Is_Special() != 8) del(src)

mob/proc/Is_Special()
	if(istype(src, /mob/Ultimate_Projectile/Ink_Snake)) return 1
	if(istype(src, /mob/Ultimate_Projectile/Bind)) return 1.5
	if(istype(src, /mob/Ultimate_Projectile/Spider)) return 2
	if(istype(src, /mob/Ultimate_Projectile/Amaterasu_Ball)) return 3
	if(istype(src, /mob/Ultimate_Projectile/Rasenshuriken)) return 4
	if(istype(src, /mob/Ultimate_Projectile/Ink)) return 5
	if(istype(src, /mob/Ultimate_Projectile/RasenshurikenXX)) return 3
	if(istype(src, /mob/Ultimate_Projectile/RasenshurikenX)) return 6
	if(istype(src, /mob/Ultimate_Projectile/Senbon_Shower)) return 7
	if(istype(src, /mob/Ultimate_Projectile/Needle_)) return 7
	if(istype(src, /mob/Ultimate_Projectile/Cube)) return 8
	if(istype(src, /mob/Ultimate_Projectile/Sound_Spiral)) return 9
	if(istype(src, /mob/Ultimate_Projectile/Chakra_Rod)) return 10
	if(istype(src, /mob/Ultimate_Projectile/Hiraishin_Kunai)) return 11
	if(istype(src, /mob/Ultimate_Projectile/Amaterasu)) return 12
	if(istype(src, /mob/Ultimate_Projectile/AshuraBall)) return 11
	if(istype(src, /mob/Ultimate_Projectile/Rocket_Punch)) return 13
	if(istype(src, /mob/Ultimate_Projectile/NL_Mind_Transfer)) return 14
	if(istype(src, /mob/Ultimate_Projectile/L_Mind_Transfer)) return 15
	if(istype(src, /mob/Ultimate_Projectile/Explosive_Poisonous_Flowers)) return 16
	if(istype(src, /mob/Ultimate_Projectile/Poisonous_Flower) || istype(src, /mob/Ultimate_Projectile/Giant_Poisonous_Flower)) return 17
	if(istype(src, /mob/Ultimate_Projectile/Poisonous_Flower) || istype(src, /mob/Ultimate_Projectile/Laser_Outburst)) return 18
	if(istype(src, /mob/Ultimate_Projectile/Poisonous_Flower) || istype(src, /mob/Ultimate_Projectile/Black_Panther)) return 19
	else return 0



mob
	Ultimate_Projectile
		Real = 0
		Checked_X = 0
		density = 0
		Active_M = 0
		layer = 100
		Projectile = 1

		var
			list/Not_Dense = list()
			mob/Projectile_Owner
			Type
			Can_Teleport = 0
			PX
			Just_Created = 0
			Length = 500
			Allies
			Damage
			Delay
			S = 0
			T = 0

		New(_loc, mob/_Projectile_Owner, var/D, var/L)
			..()
			if(_Projectile_Owner)
				PX = _Projectile_Owner.px
				Substitution = 1
				density = 0
				src.dir = _Projectile_Owner.dir
				if(_Projectile_Owner.Village) src.Allies = _Projectile_Owner.Village
				src.Projectile_Owner = _Projectile_Owner
				if(!src.loc)
					if(D) dir = D
					Teleport_(_Projectile_Owner)
					if(L) Teleport_(L)
					if(dir == EAST) vel_x += 7
					if(dir == WEST) vel_x -= 7
					if(dir == NORTH) vel_y += 7
					if(dir == SOUTH) vel_y -= 7
					if(Delay >= 2) vel_x *= 2
					if(Delay >= 3) vel_x *= 1.35
					if(Delay >= 4) vel_x *= 1.35
					if(Delay >= 5) vel_x *= 1.35
					vel_x = round(vel_x)
					Just_Created = 1
					spawn(10)
						Just_Created = 0
						Substitution = 1
						density = 0
			if(!_Projectile_Owner) del(src)
			spawn(world.tick_lag * Length) del(src)

		movement()
			if(!loc) return
			set_flags()
			for(var/mob/a in obounds(src))

				if(Just_Created)
					if(dir == EAST && a.px < PX) continue
					if(dir == WEST && a.px > PX) continue
				if(a:Dodge_Next == 1) continue
				if(istype(a, /mob/Space_Time_Barrier) && Teleporting_Barrier == a) continue
				if(a:Village == Allies) continue
				else if(a.density) Check_Damage(a)

			pixel_move(vel_x)

			spawn(world.tick_lag)
				check_loc()
				movement()

		proc/Check_Damage(mob/M)
			if(M)
				if(ismob(M) && M.ByPass == 0) del(src)
				if(isturf(M) && M.density == 1 && !istype(M, /turf/Special_Floor)) del(src)
				if(ismob(M) && M.Deflection && M.Village != Allies)
					if(!istype(M, /mob/Ultimate_Projectile/NL_Mind_Transfer) && !istype(M, /mob/Ultimate_Projectile/L_Mind_Transfer) && !istype(M, /mob/Ultimate_Projectile/Hiraishin_Kunai) && !istype(M, /mob/Ultimate_Projectile/Senbon_Shower))
						if(vel_x < 0) {vel_x = abs(vel_x); dir = EAST}
						else {vel_x = -vel_x; dir = WEST}
						Projectile_Owner = M
						Allies = M.Village
						return

				if(istype(M, /mob/Absorbing_Barrier))
					M:Creator:Cha += Damage/1.25
					if(M:Creator:Cha >= M:Creator:MaxCha) M:Creator:Cha = M:Creator:MaxCha
					del(src)
				if(istype(M, /mob/Space_Time_Barrier) && Teleporting_Barrier != M)
					var/Current_Barrier = M:New_B
					for(var/mob/Space_Time_Barrier/S in world) if(S:New_B != Current_Barrier) Teleport_Barrier(S)
					return
				if(istype(M, /mob/Rashomon2) || istype(M, /mob/Rashomon) || istype(M, /mob/Wood_Pillar) || istype(M, /mob/Tree) || istype(M, /mob/Earth_Wall))
					del(src)
				if(M.Dragonned == 1 && !M.Substitution)
					if(M != Projectile_Owner) del(src)
				if(M.Dodging == 1 && M.Village != Allies && M.Dragonned == 0)
					M.Auto_Dodge(src, 1)
					return
				if(M.Dragonned == 0 && M.knocked == 0 && M.dead == 0 && M.Real == 1 && M.Village != Allies)
					if(Is_Special() == 0)
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M.Def/3))), src)
					else if(Is_Special() == 1)
						var/S = new/obj/InkSnakeEffect(M.loc, M.dir)
						S:Caught.Add(M)
						if(icon == 'Graphics/Skills/OroSnake.dmi') S:icon = 'Graphics/Skills/OroSnakeEffect.dmi'
						S:Village = Allies
						M.Run_Off()
						M.stop()
						del(src)
					else if(Is_Special() == 1.5)
						var/S = new/obj/BindEffect(M.loc)
						S:Caught.Add(M)
						S:dir = dir
						S:Village = Allies
						M.Run_Off()
						M.stop()
						del(src)
					else if(Is_Special() == 2)
						var/S = new/obj/SpiderEffect(M.loc)
						S:Caught.Add(M)
						S:Village = Allies
						M.Run_Off()
						M.stop()
						del(src)
					else if(Is_Special() == 3)
						M.Amaterasu_XX()
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M:Def/2.5))), src)
						if(src) del(src)
					else if(Is_Special() == 4)
						M.Rasenshuriken_Effect(Projectile_Owner)
						if(src) del(src)
					else if(Is_Special() == 5)
						M.Blind_Effect_2()
						if(src) del(src)
					else if(Is_Special() == 6)
						M.Rasenshuriken_EffectX(Projectile_Owner, dir)
						if(src) del(src)
					else if(Is_Special() == 7)
					//	if(ismob(Projectile_Owner))
					//		Projectile_Owner.Precise_Aim_Usages++
					//		Projectile_Owner:Check_Special_Medals("Precise Aim")
						if(Projectile_Owner)
							if(!Projectile_Owner:knocked && Projectile_Owner:CanMove)
								Projectile_Owner:loc = src.loc
								Projectile_Owner:vel_y = 12
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M:Def/3))), src)
						if(src) del(src)
					else if(Is_Special() == 8)
						if(ismob(Projectile_Owner))
							Projectile(Projectile_Owner, M, round(round(Damage)-(round(M:Def/2.5))), src)
						M.Auto_Spawn()
						M<<"<b><font color=red><u>A huge force has sent you to spawn!"
						if(src) del(src)
					else if(Is_Special() == 9)
						M:Quake_Effect_X(rand(15, 20))
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M.Def/3))), src)
						if(src) del(src)
					else if(Is_Special() == 10)
						M:Chakra_Rod()
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M.Def/3))), src)
						if(src) del(src)
					else if(Is_Special() == 11)
						if(ismob(Projectile_Owner) && Can_Teleport)
							Projectile_Owner:Minato_Teleport(M, src)
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M.Def/3))), src)
						if(src) del(src)
					else if(Is_Special() == 12)
						if(M.Amaterasu == 0)
							M.Amaterasu=1
							M.Amaterasu_Proc()
						if(src) del(src)
					else if(Is_Special() == 13)
						new/obj/Effects/R_Hit (M.loc, M)
						M.Poison_Proc(7, name)
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M.Def/3))), src)
						if(src) del(src)
					else if(Is_Special() == 14)
						Projectile_Owner:Mind_Control(M, 0)
						del(src)
					else if(Is_Special() == 15)
						Projectile_Owner:Mind_Control(M, 1)
						del(src)
					else if(Is_Special() == 16)
						new/obj/Effects/Substitution_A (M.loc, M)
						M.Poison_Proc(3, name)
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M.Def/3))), src)
						if(src) del(src)
					else if(Is_Special() == 17)
						M.Poison_Proc(5, name)
						Projectile(Projectile_Owner, M, round(round(Damage)-(round(M.Def/3))), src)
						if(src) del(src)
					else if(Is_Special() == 18)
						new/obj/Raiton_Effect_Special (M, Projectile_Owner, dir, step_y, y)
						if(src) del(src)
					else if(Is_Special() == 19)
						new/obj/Panther_Effect_Special (M, Projectile_Owner, dir)
						Projectile(Projectile_Owner, M, round(round(30)-(round(M.Def/3))), src)
						if(src) del(src)

		bump(atom/A) Check_Damage(A)

		Chakra_Sphere
			icon = 'Graphics/Skills/Zetsu Skill.dmi'
			Type = "Normal"
			Delay = 3
			Damage = 50
			pwidth = 80
			pheight = 50
			New()
				..()
				Flick("Go", src)

		Rasenshuriken
			icon = 'Graphics/Skills/Rasenshuriken.dmi'
			Type = "Normal"
			Delay = 6
			Damage = 100
			pixel_y = 12
			pwidth = 80
			pheight = 50
			New()
				..()
				Flick("Go", src)

		RasenshurikenX
			icon = 'Graphics/Skills/RasenshurikenE.dmi'
			Type = "Normal"
			Delay = 6
			Damage = 100
			pixel_y = 12
			pwidth = 80
			pheight = 45
			New()
				..()
				Flick("Go", src)

		RasenshurikenXX
			icon = 'Graphics/Skills/Poton.dmi'
			Type = "Normal"
			Delay = 6
			Damage = 45
			blend_mode = BLEND_ADD
			pixel_y = 12
			pwidth = 80
			pheight = 45
			New()
				..()
				Flick("Go", src)
		Phoenix_Flower
			name = "Phoenix Flower"
			icon = 'Graphics/Skills/Fireball.dmi'
			Type = "Fire"
			Delay = 3
			Damage = 13
			pheight = 50
		Chakra_Rod
			name = "Chakra Rod"
			icon = 'Graphics/Skills/Chakra Rod.dmi'
			Type = "Normal"
			Delay = 3
			Damage = 13
			pheight = 50
		Rocket_Punch
			name = "Rocket Punch"
			icon = 'Graphics/Skills/Hiruko S.dmi'
			Type = "Normal"
			Delay = 3
			Damage = 30
			pheight = 50
		Juuha
			name = "Juuha Shou"
			icon = 'Graphics/Skills/Juuha.dmi'
			Type = "Wind"
			Delay = 3
			Damage = 35
			pheight = 75
			pixel_y = 12
		Crystal_Giant_Shuriken
			name = "Crystal Giant Hexagonal Shuriken"
			icon = 'Graphics/Characters/Guren.dmi'
			icon_state = "Crystal"
			Type = "Ice"
			Delay = 4
			Damage = 60
			pheight = 50
		Crystal_Vortex
			name = "Crystal Vortex"
			icon = 'Graphics/Skills/Crystal2.dmi'
			Type = "Ice"
			Delay = 4
			Damage = 80
			pheight = 50
			New()
				Flick("Go", src)
				..()
		Hexagonal_Shurikens
			name = "Crystal Hexagonal Shurikens"
			icon = 'Graphics/Characters/Guren.dmi'
			icon_state = "Shuriken"
			Type = "Ice"
			Delay = 4
			Damage = 27.5
			pheight = 50
		Amaterasu
			icon = 'Graphics/Skills/Amaterasu.dmi'
			pixel_y = 16
			pheight = 70
			Delay = 3
		Paper_Hurricane
			name = "Paper Hurricane"
			icon = 'Graphics/Skills/Wind.dmi'
			Type = "Wind"
			Delay = 4
			Damage = 25
			pheight = 75
		Explosive_Poisonous_Flowers
			icon = 'Graphics/Skills/Flowers Explosive.dmi'
			Type = "Wind"
			Delay = 3
			Damage = 55
			pheight = 64
			pixel_y = -6
		Poisonous_Flower
			icon = 'Graphics/Skills/Flower.dmi'
			Type = "Wind"
			Delay = 3
			Damage = 17.5
			pheight = 64
			pixel_y = -6
		Wave_Of_Inspiration
			icon = 'Graphics/Skills/Darui Raiton X.dmi'
			Type = "Thunder"
			alpha = 200
			Delay = 3
			Damage = 30
			pheight = 48
			pixel_y = 20
			New()
				..()
				freeze ++
				if(dir == EAST) set_pos(px +48, py)
				if(dir == WEST) set_pos(px -48, py)
				vel_x = 0
				Flick("Go", src)
				spawn(3.75)
					freeze --
					if(dir == EAST) vel_x = 19
					if(dir == WEST) vel_x = -19
		Black_Panther
			icon = 'Graphics/Skills/Darui Special.dmi'
			Type = "Thunder"
			alpha = 190
			Delay = 3
			pheight = 75
			pwidth = 150
			New()
				..()
				if(dir == WEST) set_pos(px -64, py)
				if(dir == EAST) set_pos(px -12, py)
			Del()
				freeze = 100
				vel_x = 0
				Flick("End", src)
				spawn(3) ..()
		Laser_Outburst
			icon = 'Graphics/Skills/Darui Raiton XX.dmi'
			Type = "Thunder"
			Delay = 3
			pheight = 90
			pixel_y = 8
			New()
				..()
				freeze ++
				if(dir == EAST) set_pos(px +40, py)
				if(dir == WEST) set_pos(px -40, py)
				vel_x = 0
				Flick("Go", src)
				spawn(1.5)
					freeze --
					if(dir == EAST) vel_x = 21
					if(dir == WEST) vel_x = -21
		Giant_Poisonous_Flower
			icon = 'Graphics/Skills/Flowers Big.dmi'
			Type = "Wind"
			Delay = 3
			Damage = 37.5
			pheight = 64
			pixel_y = -6
		NL_Mind_Transfer
			name = "Ino's Mind Control"
			icon = 'Graphics/Skills/Mind Transfer NL.dmi'
			Type = "Wind"
			Delay = 4
			Damage = 0
			pheight = 64
			pixel_y = -6
		L_Mind_Transfer
			name = "Ino's Mind Control"
			icon = 'Graphics/Skills/Mind Transfer L.dmi'
			Type = "Wind"
			Delay = 4
			Damage = 0
			pheight = 64
			pixel_y = -6
		Jaden_Blade
			name = "Crystal Jaden Blade"
			icon = 'Graphics/Characters/Guren.dmi'
			icon_state = "BladeProjectile"
			Type = "Ice"
			Delay = 4
			Damage = 45
			pheight = 50
			pixel_y = 6
		Ink
			icon = 'Graphics/Skills/Ink.dmi'
			Type = "Normal"
			pixel_y = 10
			Delay = 4
			Damage = 30
			pwidth = 110
			pheight = 60

		Kunai
			icon = 'Graphics/Skills/Kunai.dmi'
			Type = "Normal"
			Delay = 3
			pheight = 50
			pixel_y = 16
			Damage = 7.5

		Bug
			icon = 'Graphics/Skills/Bug Projectile.dmi'
			Type = "Normal"
			Delay = 4
			pheight = 50
			pwidth = 75
			pixel_y = 8
			Damage = 27.5

		Ferocious_Wind
			icon = 'Graphics/Skills/Temari II.dmi'
			Type = "Normal"
			alpha = 200
			Delay = 4
			pheight = 48
			pwidth = 130
			pixel_y = 16
			Damage = 27.5

		Kunai
			icon = 'Graphics/Skills/Kunai.dmi'
			Type = "Normal"
			Delay = 3
			pheight = 50
			pixel_y = 16
			Damage = 7.5
			Del()
				var/E = new/obj/Explosion (src.loc)
				E:pixel_y = pixel_y
				E:x += 1
				..()

		Itachi_Flame
			icon = 'Graphics/Skills/Itachi Flame.dmi'
			Type = "Normal"
			Delay = 3
			pixel_y = -4
			Length = 100000
			New()
				..()
				spawn(26)
					vel_x = 0
					spawn(10) del(src)
				/*	loop
						T++
						for(var/mob/M in obounds(src))
							world<<"[T], [M.name]"
							del(src)
						spawn(1) goto loop*/

		Crow_Itachi
			icon = 'Graphics/Skills/Itachi Genjutsu Crows.dmi'
			Type = "Normal"
			Delay = 2
			pixel_y = 6
			New()
				..()
				spawn(12)
					vel_x = 0
					flick("Go", src)
					spawn(9) del(src)


		Hiraishin_Kunai
			icon = 'Graphics/Skills/Hiraishin Kunai.dmi'
			Type = "Normal"
			Can_Teleport = 1
			Delay = 4
			pheight = 50
			pixel_y = 16
			Damage = 9

		Senbon_
			icon = 'Graphics/Skills/Senbon.dmi'
			name = "Senbon"
			Type = "Normal"
			Delay = 3
			pheight = 50
			pixel_y = 20
			Damage = 20

		Chidori_Senbon
			icon = 'Graphics/Skills/CSenbon.dmi'
			name = "Chidori Senbon"
			Type = "Normal"
			Delay = 3
			pheight = 50
			pixel_y = 6
			Damage = 30

		KunaiX
			icon = 'Graphics/Skills/KunaiX.dmi'
			Type = "Normal"
			name = "Kunai"
			Delay = 3
			pheight = 50
			pixel_y = 16
			Damage = 10
			Del()
				..()

		Bug_Storm
			icon = 'Graphics/Skills/BugWave.dmi'
			Type = "Sand"
			Damage = 22.5
			Delay = 2
			pixel_y = 16
			pheight = 70


		Ink_Lion
			icon = 'Graphics/Skills/InkLion.dmi'
			Type = "Normal"
			Delay = 2
			Damage = 30
			pixel_y = 16
			pheight = 70
			Del()
				var/A=new/obj/InkSplash(src.loc)
				A:pixel_y-=20
				..()

		Ink_Eagle
			icon = 'Graphics/Skills/Ink Bird.dmi'
			Type = "Normal"
			Delay = 3
			Damage = 27.5
			pheight = 90
			pwidth = 75
			Del()
				var/A=new/obj/InkSplash(src.loc)
				A:pixel_y-=20
				..()

		Ink_Snake
			name = "Snake"
			icon = 'Graphics/Skills/InkSnake.dmi'
			Type = "Normal"
			Delay = 2
			pixel_y = 16

		Bind
			icon = 'Graphics/Skills/Bind.dmi'
			Type = "Normal"
			Delay = 2
			pixel_y = 26

		Spider_Shuriken
			icon = 'Graphics/Skills/SpiderShuriken.dmi'
			Type = "Normal"
			Delay = 3
			pixel_y = 16
			Damage = 15

		Spider_Arrow
			icon = 'Graphics/Skills/ArrowX.dmi'
			Type = "Normal"
			Delay = 3
			pixel_y = 16
			Damage = 8.5

		Spider
			icon = 'Graphics/Skills/Spider.dmi'
			Delay = 4
			pixel_y = 6

		Rock
			icon = 'Graphics/Characters/JiroboCS.dmi'
			icon_state = "Rock"
			Damage = 40
			Delay = 2
			pheight = 75
			Type = "Rock"

		Bone_Bullet
			icon = 'Graphics/Skills/Bone Bullet.dmi'
			Type = "Normal"
			Damage = 20
			Delay = 3
			pheight = 30
			pixel_y = 16

		Blast
			icon = 'Graphics/Skills/Blast.dmi'
			Type = "Wind"
			Damage = 38
			Delay = 3
			pheight = 60

		Blade
			icon = 'Graphics/Skills/Vacuum Blade.dmi'
			Type = "Wind"
			Damage = 50
			Delay = 3
			pheight = 90

		Fire_Shuriken
			icon = 'Graphics/Skills/FlamingShuriken.dmi'
			Type = "Fire"
			Damage = 20
			Delay = 3
			pheight = 50
			pixel_y = 10

		Fire_Shuriken_
			name = "Fire Shuriken"
			icon = 'Graphics/Skills/FlamingShuriken.dmi'
			Type = "Fire"
			Damage = 12.5
			Delay = 3
			pheight = 50
			pixel_y = 10

		Lava_Shuriken
			icon = 'Graphics/Skills/FlamingShuriken.dmi'
			Type = "Fire"
			Damage = 20
			Delay = 3
			pheight = 50
			pixel_y = 10

		FireBall
			icon = 'Graphics/Skills/Katon.dmi'
			name="FireBall"
			Type = "Fire"
			Damage = 45
			Delay = 2
			pheight = 140
			pixel_x = -16

		FireBall_S
			icon = 'Graphics/Skills/Sharingan - Fire Ball.dmi'
			name="Uchiha Style - FireBall"
			Type = "Fire"
			Damage = 50
			Delay = 2
			pheight = 140
			pixel_x = -16

		Raiton_Sphere
			icon = 'Graphics/Skills/RaitonSphere.dmi'
			Type = "Thunder"
			Damage = 30
			Delay = 3
			pheight = 50
			pixel_y = 16

		Fire_Sphere
			icon = 'Graphics/Skills/FireSphere.dmi'
			Type = "Fire"
			Damage = 47.5
			Delay = 2
			pheight = 80
			pixel_x = -25

		Hossenka
			icon = 'Graphics/Skills/Hossenka.dmi'
			Type = "Fire"
			Damage = 8
			Delay = 3
			pixel_y = 12

		Chakra_Blade
			icon = 'Graphics/Skills/ChakraBlade.dmi'
			Type = "Normal"
			Damage = 42.5
			Delay = 4
			pixel_y = 16
			pheight = 70

		Clay_Dove
			icon = 'Graphics/Claydove.dmi'
			Type = "Normal"
			Damage = 25
			Delay = 3
			pheight = 50
			pixel_y= 16

		Deidara_Spider
			icon = 'Graphics/Skills/Clayspider.dmi'
			Type = "Normal"
			Damage = 25
			Delay = 3
			pheight = 50
			pixel_y= 16

		Sand_Shuriken
			icon = 'Graphics/Skills/SandShuriken.dmi'
			Type = "Sand"
			Damage = 13
			Delay = 3
			pheight = 50
			pixel_y = 16

		Sand_Bullet
			icon = 'Graphics/Skills/SandBullet.dmi'
			Type = "Sand"
			Damage = 30
			Delay = 3
			pixel_y = 16
			pheight = 100

		Sand_Wave
			icon = 'Graphics/Skills/SandWave.dmi'
			Type = "Sand"
			Damage = 40
			Delay = 2
			pheight = 70

		BlackSand
			icon = 'Graphics/Skills/BlackSand.dmi'
			Type = "Rock"
			Damage = 40
			Delay = 2
			pheight = 100

		Earth_Dragon
			icon = 'Graphics/Skills/EarthDragon.dmi'
			Type = "Sand"
			icon_state = "0"
			Damage = 45
			Delay = 3
			pheight = 100
			pixel_x = -16

		Cube
			icon = 'Graphics/Skills/Cube.dmi'
			Type = "Sand"
			name = "???"
			Damage = 87.5
			Delay = 4
			pheight = 190

		Shuriken
			icon = 'Graphics/Skills/3rdShuriken.dmi'
			Type = "Normal"
			Damage = 10
			Delay = 3
			pheight = 50
			pixel_y = 16

		Five_Hungry_Sharks
			icon = 'Graphics/Skills/Shark.dmi'
			name = "Shark"
			Type = "Water"
			Damage = 17.5
			Delay = 3
			pheight = 70
			pixel_x = -16
			Del()
				var/obj/S = new/obj/Splash(src.loc)
				S.dir = dir
				..()

		Fire_Dragon
			icon = 'Graphics/Skills/FireDragon.dmi'
			Type = "Fire"
			Damage = 45
			Delay = 3
			pheight = 100
			pixel_x = -16

		Lava_Incineration
			icon = 'Graphics/Skills/FireIncineration.dmi'
			Type = "Fire"
			Damage = 75
			Delay = 3
			pheight = 210
			pwidth = 135
			New()
				..()
				if(dir == EAST) pixel_x -= 94
				Flick("Go", src)

		Lava_Cannon
			icon = 'Graphics/Skills/FireCannon.dmi'
			Type = "Fire"
			Damage = 40
			Delay = 3
			pheight = 90
			pixel_x = -8
			pixel_y = 16

		Paper_X
			icon = 'Graphics/Skills/PaperX.dmi'
			Type = "Wind"
			Damage = 15
			Delay = 3
			pheight = 32
			pixel_y = 28

		Water_Dragon
			icon = 'Graphics/Skills/WaterDragon.dmi'
			Type = "Water"
			Damage = 47.5
			Delay = 3
			pheight = 100
			pixel_x = -16
			Del()
				new/obj/Splash(src.loc)
				..()

		Suigetsu_Sword
			name = "Suigetsu's Sword"
			icon = 'Graphics/Skills/Suigetsu Sword.dmi'
			Type = "Water"
			Damage = 47.5
			Delay = 3
			pheight = 80
			pwidth = 50

		Senbon_Shower
			icon = 'Graphics/Skills/Shower.dmi'
			Type = "Water"
			Damage = 45
			Delay = 3
			pheight = 80
			pixel_y = 12
			New()
				Flick("Go", src)
				..()

		Paper
			icon = 'Graphics/Skills/PaperX.dmi'
			Type = "Wind"
			Damage = 15
			Delay = 3
			pheight = 32
			pixel_y = 28



		Needle_
			name = "Kushimaru's Needle"
			icon = 'Graphics/Skills/NeedleThrow.dmi'
			Type = "Water"
			Damage = 45
			Delay = 3
			pheight = 70
			pixel_y = 24

		Sound_Spiral
			icon = 'Graphics/Skills/Sound.dmi'
			Type = "Water"
			Damage = 25
			Delay = 3
			pheight = 70
			pixel_y = 10
			New()
				Flick("Go", src)
				..()

		Water_Wave
			icon = 'Graphics/Skills/Wave.dmi'
			Type = "Water"
			Damage = 40
			Delay = 2
			pheight = 70
			Del()
				new/obj/Splash(src.loc)
				..()
		Bullet
			icon = 'Graphics/Skills/WaterAttack.dmi'
			Type = "Water"
			Delay = 3
			Damage = 35
			pheight = 60
			Del()
				new/obj/Splash(src.loc)
				..()

		Bubble
			icon = 'Graphics/Skills/Bubble.dmi'
			Type = "Water"
			Delay = 3
			Damage = 25
			pheight = 60
			pixel_y = 10
			Del()
				new/obj/Splash(src.loc)
				..()
		RealWave
			icon = 'Graphics/Skills/RealWave.dmi'
			Type = "Water"
			name = "Water Wave"
			Damage = 40
			Delay = 2
			pheight = 150
			pheight = 150
			Del()
				new/obj/RealSplash(src.loc)
				..()

		Fire_Tsunami
			icon = 'Graphics/Skills/Madara F.dmi'
			Type = "Fire"
			name = "Fire Tsunami"
			Damage = 40
			Delay = 3
			pheight = 64
			pwidth = 85
			pixel_x = -100
			pixel_y = -10
			New()
				..()
				spawn()
					new/obj/Effects/Fire_Tsunami (loc, src)


		Wind_Scythe
			icon = 'Graphics/Skills/WindScythe.dmi'
			Type = "Wind"
			Damage = 60
			Delay = 3
			pheight = 220
			pixel_y = 16

		Whirlwind
			icon = 'Graphics/Skills/Whirlwind.dmi'
			Type = "Wind"
			Damage = 15
			Delay = 4
			pheight = 50
			pixel_y = -4
			alpha = 200

		Airwave
			icon = 'Graphics/Skills/Wind 2.dmi'
			Type = "Wind"
			Damage = 27
			Delay = 3
			pheight = 40
			pixel_y = 18

		Compressed_Airwave
			icon = 'Graphics/Skills/Wind 1.dmi'
			Type = "Wind"
			Damage = 40
			Delay = 3
			pheight = 55
			pixel_y = 12

		Wind_Tornado
			icon = 'Graphics/Skills/WindTornado.dmi'
			Type = "Wind"
			Damage = 32.5
			Delay = 3
			pheight = 65
			pixel_y = 5

		Wind_Cutter
			icon = 'Graphics/Skills/KonanRage.dmi'
			Type = "Wind"
			Damage = 50
			Delay = 5
			pheight = 75
			pixel_y = 16

		UKunai
			icon = 'Graphics/Skills/Kunai.dmi'
			Type = "Normal"
			name = "Kunai"
			Damage = 15
			Delay = 3
			pheight = 50
			pixel_y = 16


		UShuriken
			icon = 'Graphics/Skills/Shuriken.dmi'
			Type = "Normal"
			name = "Shuriken"
			Damage = 15
			Delay = 3
			pheight = 50
			pixel_y = 16

		Kunai
			icon = 'Graphics/Skills/Kunai.dmi'
			Type = "Normal"
			Damage = 22.5
			Delay = 3
			pheight = 50
			pixel_y = 16
			Del()
				var/E = new/obj/Explosion (src.loc)
				E:pixel_y = pixel_y
				E:x += 1
				..()

		AshuraBall
			name = "Ashura Ball"
			icon = 'Graphics/Skills/Ashura Ball.dmi'
			Type = "Normal"
			Delay = 3
			Damage = 15
			pheight = 10
			pwidth=27

		Susanoo_Arrow
			icon = 'Graphics/Skills/SusanooArrow.dmi'
			Damage = 75
			Delay = 4
			Type = "Ice"
			pheight = 100
			pixel_y = 16

		Amaterasu_Ball
			icon = 'Graphics/Skills/AmaterasuBall.dmi'
			Damage = 25
			Delay = 3
			Type = "Ice"
			pheight = 125

		Amaterasu_Ball_S
			icon = 'Graphics/Skills/Sharingan Eraser Amaterasu.dmi'
			Damage = 30
			Delay = 3
			Type = "Ice"
			pheight = 125

mob/var/KunaiCD = 0

obj/proc
	Explosive_Kunai_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		if(Executor.name == "Torune") Flick("punch1", Executor)
		else if(Executor.name == "Ebisu" || Executor.name == "Karin" || Executor.name == "Omoi" || Executor.name == "Anko" || Executor.name == "Hanabi" || Executor.name == "(UnCloaked) Kisame") Flick("throw", Executor)
		else if(Executor.name == "{PS} Kakashi") Flick("punch2", Executor)
		else Flick("seals", Executor)
		sleep(2.5)
		new/mob/Ultimate_Projectile/Kunai (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()
	Hiraishin_Kunai()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("throw", Executor)
		sleep(1.75)
		new/mob/Ultimate_Projectile/Hiraishin_Kunai (null, Executor)
		spawn(1)
			Executor.Attacking --
			Executor.stop()
	Senbon_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 20) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("throw", Executor)
		new/mob/Ultimate_Projectile/Senbon_ (null, Executor)
		spawn(5)
			Executor.Attacking --
			Executor.stop()
	Chidori_Senbon()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("Senbon", Executor)
		sleep(6)
		Executor.Execute_Jutsu("Chidori Senbon!")
		new/mob/Ultimate_Projectile/Chidori_Senbon (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()
	Throw_Kunai()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("Throw", Executor)
		new/mob/Ultimate_Projectile/KunaiX (null, Executor)
		spawn(5)
			Executor.Attacking --
			Executor.stop()

	InkLion()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		for(var/obj/Jutsus/Ink_Eagle/L in src) if(L.Delay < 2) L.Delay(2)
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Ink_Lion (null, Executor)
		Executor.Execute_Jutsu("Ink Lion!")
		spawn(5)
			Executor.Attacking --
			Executor.stop()

	Ink_Eagle()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 22.5) == 0) return
		Delay(3)
		for(var/obj/Jutsus/Ink_Lion/L in src)  if(L.Delay < 2) L.Delay(2)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Ink_Eagle (null, Executor)
		Executor.Execute_Jutsu("Ink Eagle!")
		spawn(5)
			Executor.Attacking --
			Executor.stop()


	Needle_Cutting_Bind()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(15)
		Executor.Attacking ++
		Executor.stop()
		Flick("Bind", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Needle Cutting Bind!")
		new/mob/Ultimate_Projectile/Bind (null, Executor)
		spawn(5)
			Executor.Attacking --
			Executor.stop()
	InkSnake()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(7)
		for(var/obj/Jutsus/Ink_Dragon/I in Executor) if(I.Delay <= 10) I.Delay(10)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Ink_Snake (null, Executor)
		Executor.Execute_Jutsu("Ink Snake!")
		spawn(5)
			Executor.Attacking --
			Executor.stop()

	Rock_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(5)
		Executor.Attacking ++
		Executor.stop()
		if(name != "Kinkaku" && name != "Tsuchikage") Flick("punch2", Executor)
		if(name == "Kinkaku") Flick("mob-shooting", Executor)
		if(name == "Tsuchikage") Flick("throw", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Rock Throw!")
		new/mob/Ultimate_Projectile/Rock (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Spider_Sticky_Gold()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("Shuriken", Executor)
		sleep(3.5)
		new/mob/Ultimate_Projectile/Spider_Shuriken (null, Executor)
		spawn(5)
			Executor.Attacking --
			Executor.stop()

	Spider_Sticking_Spit()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(12)
		Executor.Attacking ++
		Executor.stop()
		Flick("Spider", Executor)
		sleep(6)
		Executor.Execute_Jutsu("Spider Sticking Spit!")
		new/mob/Ultimate_Projectile/Spider (null, Executor)
		spawn(0.5)
			Executor.Attacking --
			Executor.stop()

	Spider_Sticking_Spit_K()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(10)
		Executor.Attacking ++
		Executor.stop()
		Flick("Kidoumaru", Executor)
		sleep(6)
		Executor.Execute_Jutsu("Spider Sticking Spit!")
		new/mob/Ultimate_Projectile/Spider (null, Executor)
		spawn(4)
			Executor.Attacking --
			Executor.stop()

	Bone_Bullets()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(5)
		Executor.Attacking ++
		Executor.stop()
		Flick("Bullet", Executor)
		spawn(14.5)
			if(!Executor.client) spawn(10) {Executor.Attacking = 0}
			Executor.Attacking --
			Executor.stop()
		sleep(4.75)
		Executor.Execute_Jutsu("Bone Bullets!")
		new/mob/Ultimate_Projectile/Bone_Bullet (null, Executor)
		sleep(2.5)
		new/mob/Ultimate_Projectile/Bone_Bullet (null, Executor)
		sleep(2.5)
		new/mob/Ultimate_Projectile/Bone_Bullet (null, Executor)
		sleep(2.5)
		new/mob/Ultimate_Projectile/Bone_Bullet (null, Executor)


	Rain_of_Arrows()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Executor.Execute_Jutsu("Rain Of Arrows!")
		var/T=0
		loop
			if(T!=10)
				T++
				Flick("Arrow", Executor)
				var/A = new/mob/Ultimate_Projectile/Spider_Arrow(null, Executor)
				var/B = new/mob/Ultimate_Projectile/Spider_Arrow(null, Executor)
				if(Executor.dir == EAST)
					B:x+=1
					B:y+=rand(0,5)
					B:pixel_y=rand(-8,8)
					B:dir=EAST
					A:x+=1
					A:y+=rand(0,5)
					A:pixel_y=rand(-8,8)
					A:dir=EAST
				if(Executor.dir == WEST)
					B:x-=1
					B:y+=rand(0,5)
					B:pixel_y=rand(-8,8)
					B:dir=WEST
					A:x-=1
					A:y+=rand(0,5)
					A:pixel_y=rand(-8,8)
					A:dir=WEST
				spawn(3) goto loop

			else
				Executor.Attacking --
				Executor.stop()


	Snakes_Summoning()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Executor.Execute_Jutsu("Snakes Summoning!")
		var/T=0
		loop
			if(T!=5)
				T++
				Flick("mob-shooting", Executor)
				var/A = new/mob/Ultimate_Projectile/Ink_Snake(null, Executor)
				var/B = new/mob/Ultimate_Projectile/Ink_Snake(null, Executor)
				var/C = new/mob/Ultimate_Projectile/Ink_Snake(null, Executor)
				var/D = new/mob/Ultimate_Projectile/Ink_Snake(null, Executor)
				A:icon = 'Graphics/Skills/Orosnake.dmi'
				B:icon = 'Graphics/Skills/Orosnake.dmi'
				C:icon = 'Graphics/Skills/Orosnake.dmi'
				D:icon = 'Graphics/Skills/Orosnake.dmi'
				if(Executor.dir==EAST)
					B:x+=1
					switch(rand(1,3))
						if(1) B:y+=rand(0,6)
						if(2) B:y+=rand(0,6)
					B:pixel_y=rand(-8,8)
					B:dir=EAST
					A:x+=1
					A:y+=rand(0,5)
					A:pixel_y=rand(-8,8)
					A:dir=EAST
					C:x+=1
					C:y+=rand(0,5)
					C:pixel_y=rand(-8,8)
					C:dir=EAST
					D:x+=1
					D:y+=rand(0,5)
					D:pixel_y=rand(-8,8)
					D:dir=EAST
				if(Executor.dir==WEST)
					B:x-=1
					switch(rand(1,3))
						if(1) B:y+=rand(0,5)
						if(2) B:y+=rand(0,5)
					B:pixel_y=rand(-8,8)
					B:dir=WEST
					A:x-=1
					A:y+=rand(0,5)
					A:pixel_y=rand(-8,8)
					A:dir=WEST
					C:x-=1
					C:y+=rand(0,5)
					C:pixel_y=rand(-8,8)
					C:dir=WEST
					D:x-=1
					D:y+=rand(0,5)
					D:pixel_y=rand(-8,8)
					D:dir=WEST
				spawn(2) goto loop
			else
				Executor.Attacking --
				Executor.stop()

	Wind_Blast()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		if(Executor.name != "Ebisu") Flick("Blast", Executor)
		if(Executor.name == "Ebisu") Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Wind Release.- Blast!")
		var/A=new/mob/Ultimate_Projectile/Blast(null, Executor)
		A:pixel_y += 25
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()

	Wind_Blade()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(5)
		Executor.Attacking ++
		Executor.stop()
		sleep(3)
		Executor.Execute_Jutsu("Wind Release.- Blade!")
		if(Executor.name != "Ebisu" && Executor.name != "Special ANBU") Flick("Blade", Executor)
		if(Executor.name == "Ebisu") Flick("mob-shooting", Executor)
		if(Executor.name == "Special ANBU") Flick("throw", Executor)
		new/mob/Ultimate_Projectile/Blade (null, Executor)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()

	Flaming_Shuriken()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("throw", Executor)
		sleep(1.5)
		new/mob/Ultimate_Projectile/Fire_Shuriken (null, Executor)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()

	Lava_Shuriken()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("throw", Executor)
		sleep(1.5)
		new/mob/Ultimate_Projectile/Fire_Shuriken (null, Executor)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()

	Spit_Ink()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("Throw", Executor)
		sleep(2.5)
		new/mob/Ultimate_Projectile/Ink (null, Executor)
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()

	Explosive_Poisonous_Flowers()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(15)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Explosive Poisonous Flowers!")
		new/mob/Ultimate_Projectile/Explosive_Poisonous_Flowers (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Poisonous_Flowers()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(3)
		for(var/obj/Jutsus/Explosive_Poisonous_Flowers/J in Executor) J.Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Poisonous Flowers!")
		new/mob/Ultimate_Projectile/Poisonous_Flower (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Giant_Poisonous_Flower()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(7)
		for(var/obj/Jutsus/Explosive_Poisonous_Flowers/J in Executor) J.Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Giant Poisonous Flower!")
		new/mob/Ultimate_Projectile/Giant_Poisonous_Flower (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Summon_Giant_FireBall()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 55) == 0) return
		Delay(13, Executor)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(3.75)
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Giant FireBall!")
		new/mob/Ultimate_Projectile/FireBall (null, Executor)
		spawn(1.5)
			Executor.Attacking --
			Executor.stop()

	Shisui_Fireball()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 55) == 0) return
		Delay(13, Executor)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		if(Executor.name == "Lord Madara") Flick("Kanton", Executor)
		sleep(3.75)
		Executor.Execute_Jutsu("Uchiha Syle.- Giant FireBall!")
		new/mob/Ultimate_Projectile/FireBall_S (null, Executor)
		spawn(1.5)
			Executor.Attacking --
			Executor.stop()

	Black_Panther()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(7, Executor)
		Executor.Attacking ++
		Executor.stop()
		Flick("Attack II", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Lightning Release.- Black Panther!")
		new/mob/Ultimate_Projectile/Black_Panther (null, Executor)
		spawn(2.75)
			Executor.Attacking --
			Executor.stop()

	Wave_Of_Inspiration()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(2, Executor)
		Executor.Attacking ++
		Executor.stop()
		Flick("Attack II", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Lightning Release.- Wave Of Inspiration!")
		new/mob/Ultimate_Projectile/Wave_Of_Inspiration (null, Executor)
		spawn(2.75)
			Executor.Attacking --
			Executor.stop()

	Laser_Outburst()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(7, Executor)
		Executor.Attacking ++
		Executor.stop()
		Flick("Attack II", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Lightning Release.- Laser Outburst!")
		new/mob/Ultimate_Projectile/Laser_Outburst (null, Executor)
		spawn(2.75)
			Executor.Attacking --
			Executor.stop()

	Giant_FireBall()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(15, Executor)
		for(var/obj/Jutsus/Ash_Pile_Burning/J in Executor) J.Delay(7)
		for(var/obj/Jutsus/Flying_Swallow/J in Executor) J.Delay(5)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Fire Release.- Giant FireBall!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/FireBall (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	NL_Mind_Transfer()
		var/mob/Executor = usr
		if(CTD) return
		if(Ino_Allowed) {Executor<<"<b><font color=red><u>This jutsu has been disabled, sorry!</u>"; return}
		if(Executor.NEM_Round.Mode != Current_NEM_Round) {Executor<<"<b><font color=red><u>This jutsu isn't allowed on this mode!</u>"; return}
		if(Executor.Kamui) {Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu on this dimension."; return}
		if(Boss_Mode_) return
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(15)
		for(var/obj/Jutsus/L_Mind_Transfer/J in Executor) J.Delay(15)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Mind Transfer!")
		new/mob/Ultimate_Projectile/NL_Mind_Transfer (null, Executor)
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()
	L_Mind_Transfer()
		var/mob/Executor = usr
		if(CTD) return
		if(Ino_Allowed) {Executor<<"<b><font color=red><u>This jutsu has been disabled, sorry!</u>"; return}
		if(Executor.NEM_Round.Mode != Current_NEM_Round) {Executor<<"<b><font color=red><u>This jutsu isn't allowed on this mode!</u>"; return}
		if(Executor.Kamui) {Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu on this dimension."; return}
		if(Boss_Mode_) return
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(15)
		for(var/obj/Jutsus/NL_Mind_Transfer/J in Executor) J.Delay(15)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Mind Transfer!")
		new/mob/Ultimate_Projectile/L_Mind_Transfer (null, Executor)
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()
	Rocket_Punch()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("Shoot", Executor)
		sleep(8)
		Executor.Execute_Jutsu("Rocket Punch!")
		new/mob/Ultimate_Projectile/Rocket_Punch (null, Executor)
		spawn(12.50)
			Executor.Attacking --
			Executor.stop()
	Edo_Tensei()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Mode == "Arena" || Delay) return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.knocked || Executor.Attacking) return
		if(Executor.NEM_Round != Current_NEM_Round) return
		if(Executor.Cha < 100)
			Executor.Cooldown_Display (100)
			return
		var/_Edos_ = 0
		for(var/mob/M in world) if(M.Edo) _Edos_ ++
		if(_Edos_ >= 2)
			Executor<<"<font color=red><b>This jutsu can't be executed when there are more than 2 Edos!"
			return
		var/list/choose=list()
		for(var/mob/M in Executor.NEM_Round.Ninjas) if(M != Executor && M.dead && M.client && M.key != M.name && !M.Edo) choose.Add(M)
		var/mob/M=input("Who would you like to use this jutsu on?", "Edo Tensei") as null|anything in choose
		if(Executor.knockback == 1 || Executor.freeze || Executor.Attacking == 1 || Executor.knocked == 1) return
		if(!M) return
		if(M.name == M.key || Executor.name != "Kabuchimaru" || !M.client || !M.dead || M.NEM_Round != Executor.NEM_Round) return
		_Edos_ = 0
		for(var/mob/F in world) if(F.Edo) _Edos_ ++
		if(_Edos_ >= 2)
			Executor<<"<font color=red><b>This jutsu can't be executed when there are more than 2 Edos!"
			return
		if(Executor.NEM_Round != Current_NEM_Round) return
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(600)
		M.Village = Executor.Village
		M.NEM_Side = Executor.NEM_Side
		Executor.freeze ++
		Flick("Edo", Executor)
		sleep(5.5)
		Executor.NEM_Round.Shout("<font color=#505050><b><center><font size=3>Let the war begin... Edo Tensei!")
		new/obj/Edo_Object (Executor.loc, M, Executor)
		spawn(9.5)
			Executor.freeze --
			Executor.stop()

	Summon_Ally()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.knocked || Executor.Attacking) return
		if(Executor.Levitating) return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Executor.Cha < 25)
			Executor.Cooldown_Display (25)
			return
		var/list/choose=list()
		for(var/mob/M in Executor.NEM_Round.Ninjas) if(M != Executor && M.Village == Executor.Village && M.client) choose.Add(M)
		var/mob/M=input("Who would you like to summon?", "Summon Ally") as null|anything in choose
		if(!M) return
		if(Executor.knockback == 1 || Executor.freeze || Executor.Attacking == 1 || Executor.knocked == 1)return
		if(!M) return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(30)
		Executor.freeze ++
		Executor.pixel_y -= 10
		Flick("Summon", Executor)
		sleep(3)
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Ally: [M.name]!")
		M.loc = Executor.loc
		M.check_loc()
		spawn(2)
			Executor.pixel_y = 0
			Executor.freeze --
			Executor.stop()

	Flying_Thunder_God()
		var/mob/Executor = usr
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.knocked || Executor.Attacking) return
		if(Executor.Levitating) return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Executor.Cha < 20)
			Executor.Cooldown_Display (20)
			return
		var/list/choose=list()
		for(var/mob/M in Executor.NEM_Round.Ninjas) if(M != Executor && M.Village == Executor.Village && M.Real && M.client && !M.Absorbed) choose.Add(M)
		var/mob/M=input("Who would you like to teleport to?", "Flying Thunder God") as null|anything in choose
		if(!M) return
		if(M.Absorbed) return
		if(Executor.knockback == 1 || Executor.freeze || Executor.Attacking == 1 || Executor.knocked == 1) return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Executor.Can_Execute(src, 20) == 0) return
		if(Executor.name == "Yondaime") Delay(90)
		else Delay(30)
		Executor.freeze ++
		Flick("Minato Teleport", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Flying Thunder God!")
		Executor.Teleport_(M)
		spawn(2)
			Executor.freeze --
			Executor.stop()

	Yondaime()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.knocked || Executor.Attacking) return
		if(Executor.Cha < 50)
			Executor.Cooldown_Display (60)
			return
		var/list/choose=list()
		for(var/mob/M in hearers(15)) if(M != Executor && M.Village != Executor.Village && M.Real && M.Dragonned == 0 && M.knocked == 0) choose.Add(M)
		var/mob/M=input("Who would you like to use this jutsu on?", "Hiraishin Ni No Dan") as null|anything in choose
		if(!M) return
		if(Executor.knockback == 1 || Executor.freeze || Executor.Attacking == 1 || Executor.knocked == 1 || M.knocked == 1|| M.Dragonned == 1) return
		if(!M) return
		if(Executor.Can_Execute(src, 60) == 0) return
		if(M.Dodging == 1)
			Delay(10)
			M.Auto_Dodge (Executor)
			Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
			return
		Delay(20)
		for(var/obj/Jutsus/Rasengan_Yondaime/K in Executor) K.Delay(5)
		Executor.Execute_Jutsu("Hiraishin Ni No Dan!")
		Executor.density = 0
		Executor.Teleport_Behind_Close_Y (M, Executor)
		Executor.invisibility = 101
		Executor.Dragonned = 1
		Executor.freeze ++
		M.Dragonned = 1
		M.freeze ++
		M.stop()
		new/obj/Effects/Yondaime_Special (Executor.loc, Executor)
		spawn(2.15)
			M.input_lock = 1
			M.freeze --
			M.stop()
			M.Damage(Executor, 10+rand(0, 5), 0, null, null, 1)
			M.vel_y = 6
		spawn(7.25)
			Executor.density = 1
			M.input_lock = 0
			M.Dragonned = 0
			M.Damage(Executor, 30+rand(0, 15), 1, 2, null, 1)
	Absorb()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.knocked || Executor.Attacking) return
		if(Executor.Levitating) return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Executor.Cha < 35)
			Executor.Cooldown_Display (35)
			return
		var/list/choose=list()
		for(var/mob/M in hearers(15)) if(M != Executor && M.Village != Executor.Village && M.Real && M.Dragonned == 0 && M.knocked == 0) choose.Add(M)
		var/mob/M=input("Who would you like to use this jutsu on?", "Summon Preta Path: Absorb") as null|anything in choose
		if(!M) return
		if(Executor.knockback == 1 || Executor.freeze || Executor.Attacking == 1 || Executor.knocked == 1 || M.knocked == 1|| M.Dragonned == 1) return
		if(!M) return
		if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
		if(Executor.Can_Execute(src, 35) == 0) return
		if(M.Dodging == 1)
			Delay(10)
			M.Auto_Dodge (Executor)
			Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
			return
		Delay(45)
		M.CanMove = 0
		M.freeze ++
		spawn()
			Executor.CanMove = 0
			Executor.freeze ++
			Executor.stop()
			M.CanMove = 0
			Executor.pixel_y -= 10
			Flick("Summon", Executor)
			spawn(5)
				Executor.pixel_y = 0
				Executor.CanMove = 1
				Executor.freeze --
			sleep(3)
			Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Preta Path: Absorb!")
			M.CanMove = 0
			var/Pein = new/obj/Preta (M.loc)
			Flick("Go", Pein)
			Pein:pixel_x = M.pixel_x
			if(M.dir == EAST)
				Pein:pixel_x += 55
				Pein:dir = WEST
			if(M.dir == WEST)
				Pein:pixel_x -= 10
				Pein:dir = EAST
			var/Times = 0
			spawn(5)
				loop
					if(Times <= 5)
						Flick("hurt", M)
						M.Dragonned = 1
						M.icon_state = "hurt"
						Times ++
						new/obj/Hit (M.loc)
						var/Formula = rand(4, 5.5)
						M.Cha -= Formula
						Executor.Cha += Formula
						spawn(4.5) goto loop
					else
						if(M.Cha < 0) M.Cha = 0
						M.Dragonned = 0
						M.CanMove = 1
						if(!M.knocked)
							Flick("hurt", M)
							M.freeze --
						if(Pein) del(Pein)

	Chakra_Rod()
		var/mob/Executor = usr
		if(Executor.Levitating) return
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(10)
		Executor.Attacking ++
		Executor.stop()
		Flick("Special", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Chakra Rod!")
		new/mob/Ultimate_Projectile/Chakra_Rod (null, Executor)
		spawn(1.5)
			Executor.Attacking --
			Executor.stop()

	Wind_Cutter()
		var/mob/Executor = usr
		if(Executor.Levitating) return
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(15)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(3.5)
		Executor.Execute_Jutsu("Wind Release.- Cutter!")
		new/mob/Ultimate_Projectile/Wind_Cutter (null, Executor)
		spawn(1.5)
			Executor.Attacking --
			Executor.stop()

	Beast_Tearing_Palm()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Wind Release.- Beast Tearing Palm!")
		new/mob/Ultimate_Projectile/Juuha (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Giant_Hexagonal_Shuriken()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(15)
		Executor.Attacking ++
		Executor.stop()
		if(Executor.dir == EAST) Executor.pixel_x = -14
		if(Executor.dir == WEST) Executor.pixel_x = -6
		Flick("CrystalThrow", Executor)
		sleep(8)
		spawn() Executor.pixel_x = 0
		Flick("teleport", Executor)
		Executor.Execute_Jutsu("Crystal Release.- Giant Hexagonal Shuriken!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Crystal_Giant_Shuriken (null, Executor)
		spawn(2)
			Executor.Attacking --
			Executor.stop()
	Crystal_Vortex()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 125) == 0) return
		Delay(25)
		Executor.Attacking ++
		Executor.stop()
		if(Executor.dir == EAST) Executor.pixel_x = -14
		if(Executor.dir == WEST) Executor.pixel_x = -6
		Flick("CrystalThrow2", Executor)
		sleep(7)
		spawn() Executor.pixel_x = 0
		Flick("teleport", Executor)
		Executor.Execute_Jutsu("Crystal Release.- Vortex!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Crystal_Vortex (null, Executor)
		spawn(2)
			Executor.Attacking --
			Executor.stop()

	Crystal_Shurikens()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(2)
		Executor.Attacking ++
		Executor.stop()
		Flick("CrystalShuriken", Executor)
		new/mob/Ultimate_Projectile/Hexagonal_Shurikens (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Jaden_Blade()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(5)
		Executor.Attacking ++
		Executor.stop()
		Flick("Blade", Executor)
		sleep(4)
		Executor.Execute_Jutsu("Jaden Blade!")
		new/mob/Ultimate_Projectile/Jaden_Blade (null, Executor)
		spawn(1)
			Executor.Attacking --
			Executor.stop()

	Huge_Fire_Sphere()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 55) == 0) return
		Delay(10)
		for(var/obj/Jutsus/Flame_Battle_Encampment/S in Executor.Jutsus) S.Delay(2)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.50)
		Executor.Execute_Jutsu("Fire Release.- Huge Fire Sphere!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Fire_Sphere (null, Executor)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()

	Raiton_Sphere()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Raiton Sphere!")
		new/mob/Ultimate_Projectile/Raiton_Sphere (null, Executor)
		spawn(5)
			Executor.Attacking --
			Executor.stop()

	Phoenix_Flower_Anko()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Fire Release.- Phoenix Flower!")
		flick("Seals", Executor)
		spawn(1.5)
			var/B = new/obj/BigSmoke (Executor.loc)
			B:pixel_x = Executor.pixel_x
			B:pixel_y = Executor.pixel_y

		spawn(6.45)
			var/T = 0
			loop
				if(T != 5)
					T++
					var/A = new/mob/Ultimate_Projectile/Phoenix_Flower(null, Executor)
					A:pixel_y = rand(-16,16)
					spawn(2.50) goto loop
				else
					Executor.freeze --
					Executor.stop()

	Phoenix_Flower()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(15)
		for(var/obj/Jutsus/Ash_Pile_Burning/J in Executor) J.Delay(7)
		for(var/obj/Jutsus/Flying_Swallow/J in Executor) J.Delay(5)
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Fire Release.- Phoenix Flower!")
		sleep(1)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/T = 0
		loop
			if(T != 5)
				T++
				Flick("mob-shooting", Executor)
				var/A=new/mob/Ultimate_Projectile/Phoenix_Flower(null, Executor)
				A:pixel_y = rand(-16,16)
				spawn(2.75) goto loop
			else
				Executor.freeze --
				Executor.stop()

	Ashura_Balls()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(10)
		Executor.Attacking ++
		Executor.stop()
		flick("throw", Executor)
		sleep(3)
		var/A=new/mob/Ultimate_Projectile/AshuraBall(null,Executor,null,"Straight",null)
		var/B=new/mob/Ultimate_Projectile/AshuraBall(null,Executor,null,"Straight",null)
		var/C=new/mob/Ultimate_Projectile/AshuraBall(null,Executor,null,"Straight",null)
		var/D=new/mob/Ultimate_Projectile/AshuraBall(null,Executor,null,"Straight",null)
		if(Executor.dir==EAST)
		 A:x+=3
		 B:x+=1
		 C:y+=1
		 D:y+=1
		 D:x+=3
		if(Executor.dir==WEST)
		 A:x-=3
		 B:x-=1
		 C:y+=1
		 D:y+=1
		 D:x-=3
		spawn(3)
			Executor.Attacking --
			Executor.stop()
	Chakra_Blade_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(3)
		for(var/obj/Jutsus/Ash_Pile_Burning/J in Executor) J.Delay(3)
		for(var/obj/Jutsus/Flying_Swallow/J in Executor) J.Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("throw", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Chakra Blade Throw!")
		new/mob/Ultimate_Projectile/Chakra_Blade (null, Executor)
		spawn(4.5)
			Executor.Attacking --
			Executor.stop()

	Clay_Dove()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 20) == 0) return
		Delay(2)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Art is a Bang!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Clay_Dove (null, Executor)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()

	Clay_Spider()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 20) == 0) return
		Delay(2)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Art is a Bang!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		new/mob/Ultimate_Projectile/Deidara_Spider (null, Executor)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()

	Sand_Shuriken()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 7.5) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(1.5)
		new/mob/Ultimate_Projectile/Sand_Shuriken (null, Executor)
		spawn(4)
			Executor.Attacking --
			Executor.stop()

	Sand_Bullet()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Sand Bullet!")
		new/mob/Ultimate_Projectile/Sand_Bullet (null, Executor)
		spawn(4)
			Executor.Attacking --
			Executor.stop()

	Uprising()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 70) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		spawn(5.25) {Executor.Attacking --; Executor.stop()}
		sleep(3.75)
		Executor.Execute_Jutsu("Wood Release.- Uprising!")
		new/obj/Wood_Column (Executor.loc, Executor)

	Water_Uprising()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(20)
		Executor.Attacking ++
		Executor.stop()
		Flick("rage1", Executor)
		spawn(4) {Executor.Attacking --; Executor.stop()}
		sleep(2)
		Executor.Execute_Jutsu("Water Release.- Uprising!")
		new/obj/Water_Eruption (Executor.loc, Executor)

	Uprising_()
		src.On_Ground = 1
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(20)
		Executor.Attacking ++
		Executor.stop()
		Flick("seals", Executor)
		spawn(3.75) {Executor.Attacking --; Executor.stop()}
		sleep(2.75)
		Executor.Execute_Jutsu("Earth Release.- Great Mud River!")
		new/obj/Earth_Rising (Executor.loc, Executor)

	Earth_Dragon()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(3.5)
		Executor.Execute_Jutsu("Earth Release.- Dragon!")
		new/mob/Ultimate_Projectile/Earth_Dragon (null, Executor)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		spawn(5)
			Executor.Attacking --
			Executor.stop()

	Detachment_of_the_Primitive_World()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(60)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(6.5)
		Executor.Execute_Jutsu("Detachment Of The Primitive World!")
		new/mob/Ultimate_Projectile/Cube (null, Executor)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		spawn(5)
			Executor.Attacking --
			Executor.stop()

	Shuriken_Shadow_Clone()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Shuriken Shadow Clone!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/T=0
		loop
			if(T!=10)
				T++
				Executor.Doming = 1
				Executor.icon_state = "throw"
				var/A = new/mob/Ultimate_Projectile/Shuriken(null, Executor)
				A:pixel_y = rand(-12,24)
				spawn(1.5) goto loop
			else
				spawn(1.5)
					Executor.Doming = 0
					Executor.freeze --
					Executor.stop()

	Five_Hungry_Sharks()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(17)
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(3)
		Executor.Execute_Jutsu("Water Release.- Five Hungry Sharks!")
		var/T=0
		loop
			if(T < 5)
				T++
				Flick("mob-shooting", Executor)
				new/mob/Ultimate_Projectile/Five_Hungry_Sharks (null, Executor)
				spawn(2.15) goto loop
			else
				spawn(2.5)
					Executor.freeze --
					Executor.stop()

	Senshokuko()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(17)
		Executor.Sharking = 1
		Executor.stop()
		Flick("mob-seals", Executor)
		sleep(3.75)
		Flick("Shark", Executor)
		Executor.Execute_Jutsu("Water Release.- Senshokuko!")
		var/T = 0
		loop
			if(Executor.knocked || T >= 10)
				Executor.Sharking = 0
				Executor.stop()
			else
				if(Executor.dir == EAST) Executor.vel_x = -22
				if(Executor.dir == WEST) Executor.vel_x = 22
				T++
				new/mob/Ultimate_Projectile/Five_Hungry_Sharks (null, Executor)
				spawn(1.90) goto loop



	Explosive_Fist()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(15)
		Executor.Attacking ++
		Executor.stop()
		Flick("Gari I", Executor)
		for(var/obj/Jutsus/Explosive_Combo/F in Executor) F.Delay(10)
		for(var/obj/Jutsus/Flaming_Fist/F in Executor) F.Delay(20)
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()
		sleep(2.95)
		Executor.Execute_Jutsu("Explosive Fist!")
		new/obj/Explosive_Fist (Executor.loc, Executor)

	Flaming_Fist()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 55) == 0) return
		Delay(20)
		Executor.Attacking ++
		Executor.stop()
		for(var/obj/Jutsus/Explosive_Combo/F in Executor) F.Delay(10)
		for(var/obj/Jutsus/Explosive_Fist/F in Executor) F.Delay(15)
		Flick("punch1", Executor)
		sleep(2.25)
		Executor.Execute_Jutsu("Flaming Fist!")
		new/obj/Flaming_Fist (Executor.loc, Executor)
		spawn(1.75)
			Executor.Attacking --
			Executor.stop()

	Water_Dragon()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		if(Executor.name != "(UnCloaked) Kisame") Flick("mob-shooting", Executor)
		else Flick("mob-seals", Executor)
		sleep(2)
		Executor.Execute_Jutsu("Water Release.- Dragon!")
		new/mob/Ultimate_Projectile/Water_Dragon (null, Executor)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		spawn(1.75)
			Executor.Attacking --
			Executor.stop()

	Summoning_Puppets()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Tournament_GoingOn = 1
		src.Capture_The_Flag = 1
		if(CTD) return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.NEM_Round.Type == "Tourney") return
		if(Executor.Can_Execute(src, 60) == 0) return
		var/F = 0
		for(var/mob/New_Puppets/I in world) if(I.Executor == Executor && !I.Deleted && !I.dead) F++
		if(F) {Executor<<"<b><font color=red><u>You already have [F] Puppet(s) active!</u>"; Executor.Cha += 85; return}
		Delay(75)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shootingx", Executor)

		var/T
		var/P
		if(name == "Sasori") {T = 1.5; P = 5}
		else {T = 2.5; P = 5}

		spawn(P)
			Flick("teleport", Executor)
			Executor.Attacking --
			Executor.stop()

		sleep(T)
		Executor.Execute_Jutsu("Kugutsu no Jutsu!")
		var/P1 = 0
		for(var/mob/M1) if(M1.client && M1.dead == 0 && M1.Village != Executor.Village && M1.name != M1.key && M1.NEM_Round == Executor.NEM_Round) P1++

		spawn()
			var/mob/I = new/mob/New_Puppets/Puppet_I (Executor.loc, Executor)
			var/B = new/obj/BigSmoke (I.loc)
			B:pixel_x = I.pixel_x
			B:pixel_y = I.pixel_y

		if(P1 >= 2) spawn(2.5)
			var/mob/I = new/mob/New_Puppets/Puppet_II (Executor.loc, Executor)
			var/B = new/obj/BigSmoke (I.loc)
			B:pixel_x = I.pixel_x
			B:pixel_y = I.pixel_y

		if(P1 >= 3) spawn(5)
			var/mob/I = new/mob/New_Puppets/Puppet_III (Executor.loc, Executor)
			var/B = new/obj/BigSmoke (I.loc)
			B:pixel_x = I.pixel_x
			B:pixel_y = I.pixel_y

	Summon_Puppet()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 15) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shootingx", Executor)

		var/T
		var/P
		var/F
		if(name == "Sasori") {T = 1.5; P = 3.5}
		else {T = 2.5; P = 3.5}

		spawn(P)
			Flick("teleport", Executor)
			Executor.Attacking --
			Executor.stop()

		sleep(T)

		spawn()
			for(var/mob/New_Puppets/I in world) if(I.Executor == Executor && !I.Deleted && !F && !I.dead)
				F = 2
				I.loc = Executor.loc
				I.dir = Executor.dir
				if(I.Target_) {I.Target_.Puppets_Chasing.Remove(I); I.Target_ = null}
				I.set_pos(Executor.px, Executor.py)
				var/B = new/obj/BigSmoke (I.loc)
				B:pixel_x = I.pixel_x
				B:pixel_y = I.pixel_y
			if(!F)
				Executor<<"<b><font color=red><b><u>You don't have any puppet!</u>"
				Executor.Cha += 15

	Sword_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("Throw", Executor)
		sleep(1.25)
		new/mob/Ultimate_Projectile/Suigetsu_Sword (null, Executor)
		spawn(6.25)
			Executor.Attacking --
			Executor.stop()

	Sound_Spiral_K()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("Tayuya", Executor)
		sleep(7)
		Executor.Execute_Jutsu("Sound Spiral!")
		new/mob/Ultimate_Projectile/Sound_Spiral (null, Executor)
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()

	Sound_Spiral()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Sound Spiral!")
		new/mob/Ultimate_Projectile/Sound_Spiral (null, Executor)
		spawn(2)
			Executor.Attacking --
			Executor.stop()

	Senbon_Shower()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(15)
		Executor.Attacking ++
		Executor.stop()
		Flick("Combo3", Executor)
		sleep(5.75)
		new/mob/Ultimate_Projectile/Senbon_Shower (null, Executor)
		Executor.Execute_Jutsu("Shower Throw!")
		spawn(1.25)
			Executor.Attacking --
			Executor.stop()

	Needle_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(7)
		Executor.Attacking ++
		Executor.stop()
		Flick("Throw", Executor)
		sleep(3)
		Executor.Execute_Jutsu("Needle Throw!")
		new/mob/Ultimate_Projectile/Needle_ (null, Executor)
		spawn(2)
			Executor.Attacking --
			Executor.stop()
	Susanoo_Shield()
		var/mob/Executor = usr
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(Executor.Shield_ == 1)
			Executor<<output("<b><font color=#10C8FF><u>Susanoo's Shield has vanished!</u></font></b>","Chat")
			Executor.Dragonned = 0
			Executor.Str = 13.75
			Executor.Shield_ = 0
			Executor.Regenerate_Chakra = 1
			Executor.overlays -= 'Graphics/Skills/Susanoo Shield.dmi'
			if(!Executor.knocked) Executor.density = 1
			Executor.Intangible_CD = 1
			spawn(50) Executor.Intangible_CD = 0
			Delay(5)

		if(!Executor.Shield_ && Executor.Intangible_CD == 0)
			if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.knocked || Executor.Attacking) return
			if(Executor.Cha < 10)
				Executor.Cooldown_Display (10)
				return
			Executor.Activated = 0
			Executor.Str = 15.25
			Executor.Cha -= 15
			Executor.Execute_Jutsu("Susanoo Shield!")
			Executor.density = 0
			Executor.Dragonned = 1
			Executor.Shield_ = 1
			Executor.Regenerate_Chakra = 0
			Executor.overlays += 'Graphics/Skills/Susanoo Shield.dmi'
	Phase()
		var/mob/Executor = usr
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Tournament_GoingOn == 1)
			src<<"<b><font color=red><u>This jutsu is not allowed during Tournament.</u>"
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(invisibility == 101) return
		if(Capture_The_Flag == 1)
			Executor<<"<b><font color=red><u>You aren't allowed to use this jutsu during Capture The Flag Event.</u></font>"
			return
		if(Boss_Mode == 1)
			Executor<<output("<b><font color=red><u>This jutsu is illegal in Juggernaut Mode!</u></font>", "Chat")
			return
		if(Executor.Intangible == 1)
			Executor<<output("<b><font color=#10C8FF><u>Your body is no longer intangible!</u></font></b>","Chat")
			Executor.Can_Attack_ = 1
			Executor.Dragonned = 0
			Executor.Substitution = 0
			Executor.alpha = 255
			Executor.Intangible = 0
			Executor.Regenerate_Chakra = 1
			if(!Executor.knocked) Executor.density = 1
			Executor.Intangible_CD = 1
			spawn(90) Executor.Intangible_CD = 0
			Delay(13)

		if(!Executor.Intangible && Executor.Intangible_CD == 0 && !Executor.Substitution)
			if(Executor.On_Wall || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.knocked || Executor.Attacking) return
			if(Executor.Cha < 10)
				Executor.Cooldown_Display (10)
				return
			Executor.Cha -= 10
			Executor<<output("<b><font color=#10C8FF><u>Your body is now intangible!</u></font></b>","Chat")
			Executor.Substitution = 2
			Executor.Dragonned = 1
			Executor.density = 0
			Executor.Dragonned = 1
			Executor.Can_Attack_ = 0
			Executor.Intangible = 1
			Executor.alpha = 175
			Executor.Regenerate_Chakra = 0
	Fire_Dragon()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(7)
		for(var/obj/Jutsus/Raikiri_AK/S in Executor.Jutsus) S.Delay(1)
		for(var/obj/Jutsus/Flame_Battle_Encampment/S in Executor.Jutsus) S.Delay(2)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.50)
		Executor.Execute_Jutsu("Fire Release.- Dragon!")
		new/mob/Ultimate_Projectile/Fire_Dragon (null, Executor)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		spawn(3.25)
			Executor.Attacking --
			Executor.stop()
	Lava_Incineration()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(45)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Lava Incineration!")
		new/mob/Ultimate_Projectile/Lava_Incineration (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Lava_Cannon()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 40) == 0) return
		Delay(5)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Lava Cannon!")
		new/mob/Ultimate_Projectile/Lava_Cannon (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Paper_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 12.5) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("throw", Executor)
		sleep(3.5)
		var/A = new/mob/Ultimate_Projectile/Paper (null, Executor)
		A:dir = Executor.dir
		spawn(1.5)
			Executor.Attacking --
			Executor.stop()

	Dance_of_wild_Papers()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(90)
		Executor.freeze ++
		Executor.Doming = 1
		Executor.stop()
		var/Q = 0
		Executor.Execute_Jutsu("Dance Of Wild Papers!")
		loop
			if(Q <20)
				Executor.icon_state = "throw"
				Q++
				var/D = pick(EAST, WEST)
				var/obj/L = new/mob/Ultimate_Projectile/Paper_X (null, Executor, D)
				L.y += rand(0,4)
				spawn(1) goto loop
			else
				Executor.Doming = 0
				Executor.freeze --
				Executor.stop()

	Amaterasu_Ball()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(20)
		Executor.Attacking ++
		Executor.stop()
		Flick("punch1", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Amaterasu Ball!")
		new/mob/Ultimate_Projectile/Amaterasu_Ball (null, Executor)
		spawn(4.5)
			Executor.Attacking --
			Executor.stop()

	Amaterasu_Ball_S()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(20)
		Executor.Attacking ++
		Executor.stop()
		Flick("punch1", Executor)
		sleep(1.5)
		Executor.Execute_Jutsu("Shisui Style - Amaterasu Ball!")
		new/mob/Ultimate_Projectile/Amaterasu_Ball_S (null, Executor)
		spawn(4.5)
			Executor.Attacking --
			Executor.stop()

	Water_Bubble()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 20) == 0) return
		Delay(2)
		Executor.Attacking ++
		Executor.stop()
		Flick("throw", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Water Release.- Bubble!")
		new/mob/Ultimate_Projectile/Bubble (null, Executor)
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()

	Water_Bullet()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("rage1", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Water Release.- Bullet!")
		new/mob/Ultimate_Projectile/Bullet (null, Executor)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()

	Whirlwind()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 12.5) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("fan", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Wind Release.- Whirlwind!")
		new/mob/Ultimate_Projectile/Whirlwind (null, Executor)
		spawn(2)
			Executor.Attacking --
			Executor.stop()

	Wind_Tornado()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 35) == 0) return
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("fan", Executor)
		sleep(4)
		Executor.Execute_Jutsu("Wind Release.- Tornado!")
		new/mob/Ultimate_Projectile/Wind_Tornado (null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Airwave()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 20) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Wind Release.- Airwave!")
		new/mob/Ultimate_Projectile/Airwave (null, Executor)
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()

	Compressed_Airwave()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(3)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Wind Release.- Compressed Airwave!")
		new/mob/Ultimate_Projectile/Compressed_Airwave (null, Executor)
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()

	Wind_Scythe()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(5)
		Executor.Attacking ++
		Executor.stop()
		Flick("fan", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Wind Release.- Scythe!")
		new/mob/Ultimate_Projectile/Wind_Scythe (null, Executor)
		spawn(2)
			Executor.Attacking --
			Executor.stop()

	Random_Weapon_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 7) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("throw3", Executor)
		sleep(1.75)
		switch(rand(1,2))
			if(1) new/mob/Ultimate_Projectile/UKunai (null, Executor)
			if(2) new/mob/Ultimate_Projectile/UShuriken (null, Executor)
		spawn(3.25)
			Executor.Attacking --
			Executor.stop()

	Great_Fireball_Shower()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 135) == 0) return
		Delay(60)
		Executor.Attacking ++
		Executor.stop()
		var/T = 3
		if(Executor.name == "Madara") Executor.Execute_Jutsu("Great FireBall Shower!")
		else {Executor.Execute_Jutsu("It's over!"); Executor.freeze ++; Executor.Attacking --; T = 5; Executor.vel_y = 0}
		loop
			if(T != 0)
				if(Executor.name == "Madara") Flick("Throw", Executor)
				else {Flick("mob-shooting", Executor); Executor.vel_y = 0}
				spawn(2.5)
					var/B = new/obj/BigSmoke (Executor.loc)
					B:pixel_x = Executor.pixel_x
					B:pixel_y = Executor.pixel_y
					T--
					var/A = new/mob/Ultimate_Projectile/FireBall (null, Executor)
					A:pixel_y = rand(-16, 16)
					if(Executor.name == "Madara") spawn(8.5) goto loop
					else spawn(4) goto loop
			else
				spawn(1.5)
					if(Executor.name != "Madara") {Executor.freeze --; Executor.stop()}
					else {Executor.Attacking --; Executor.stop()}

	Massive_Flaming_Shurikens()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(25)
		Executor.Attacking ++
		Executor.stop()
		Executor.Execute_Jutsu("Massive Flaming Shurikens!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/T = 0
		loop
			if(T != 12)
				T++
				if(T == 1 || T == 3 || T == 5 || T == 7 || T == 9 || T == 11) Flick("Throw", Executor)
				var/A = new/mob/Ultimate_Projectile/Fire_Shuriken_(null, Executor)
				A:pixel_y = rand(-26, 26)
				spawn(1.75) goto loop
			else
				spawn(1.5)
					Executor.Attacking --
					Executor.stop()

	Multiple_Exploding_Kunai_Throw()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(15)
		Executor.Attacking ++
		Executor.stop()
		Executor.Execute_Jutsu("Multiple Exploding Kunais!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/T=0
		loop
			if(T != 6)
				T++
				if(Executor.name != "ANBU" && Executor.name != "Special ANBU") Flick("scroll", Executor)
				if(Executor.name == "ANBU" || Executor.name == "Special ANBU") Flick("throw", Executor)
				var/A=new /mob/Ultimate_Projectile/Kunai(null, Executor)
				A:pixel_y = rand(-8, 8)
				spawn(1.5) goto loop
			else
				spawn(1.5)
					Executor.Attacking --
					Executor.stop()

	Twin_Rising_Dragons()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(45)
		Executor.freeze ++
		Executor.stop()
		Executor.invisibility = 101
		new/obj/Effects/Two_Rising_Dragons (Executor.loc, Executor)
		spawn(3) Executor.Execute_Jutsu("Two Rising Dragons!")
		spawn(11)
			var/A = new/mob/Ultimate_Projectile/Kunai(null, Executor)
			A:pixel_y = rand(-8, 8)
			A:pheight = 32
			spawn(rand(1, 1.75))
				var/C = new/mob/Ultimate_Projectile/UKunai (null, Executor)
				C:y += 1
				C:pixel_y = rand(-8, 8)
				C:pheight = 32
			spawn(rand(1, 1.75))
				var/D = new/mob/Ultimate_Projectile/UShuriken (null, Executor)
				D:y += 2
				D:pixel_y = rand(-8, 8)
				D:pheight = 32
			spawn(rand(1, 1.75))
				switch(rand(1, 2))
					if(1)
						var/F = new/mob/Ultimate_Projectile/UKunai (null, Executor)
						F:y += 3
						F:pixel_y = rand(-8, 8)
						F:pheight = 32
					if(2)
						var/F = new/mob/Ultimate_Projectile/UShuriken (null, Executor)
						F:y += 3
						F:pixel_y = rand(-8, 8)
						F:pheight = 32
			spawn(rand(1, 1.75))
				var/E = new/mob/Ultimate_Projectile/Kunai(null, Executor)
				E:y += 4
				E:pixel_y = rand(-8, 8)
				E:pheight = 32

		spawn(14)
			var/A = new/mob/Ultimate_Projectile/Kunai(null, Executor)
			A:pixel_y = rand(-8, 8)
			A:pheight = 32
			spawn(rand(1, 1.75))
				var/C = new/mob/Ultimate_Projectile/UKunai (null, Executor)
				C:y += 1
				C:pixel_y = rand(-8, 8)
				C:pheight = 32
			spawn(rand(1, 1.75))
				var/D = new/mob/Ultimate_Projectile/UShuriken (null, Executor)
				D:y += 2
				D:pixel_y = rand(-8, 8)
				D:pheight = 32
			spawn(rand(1, 1.75))
				switch(rand(1, 2))
					if(1)
						var/F = new/mob/Ultimate_Projectile/UKunai (null, Executor)
						F:y += 3
						F:pixel_y = rand(-8, 8)
						F:pheight = 32
					if(2)
						var/F = new/mob/Ultimate_Projectile/UShuriken (null, Executor)
						F:y += 3
						F:pixel_y = rand(-8, 8)
						F:pheight = 32
			spawn(rand(1, 1.75))
				var/E = new/mob/Ultimate_Projectile/Kunai(null, Executor)
				E:y += 4
				E:pixel_y = rand(-8, 8)
				E:pheight = 32


		spawn(17)
			var/A = new/mob/Ultimate_Projectile/Kunai(null, Executor)
			A:pixel_y = rand(-8, 8)
			A:pheight = 32
			spawn(rand(1, 1.75))
				var/C = new/mob/Ultimate_Projectile/UKunai (null, Executor)
				C:y += 1
				C:pixel_y = rand(-8, 8)
				C:pheight = 32
			spawn(rand(1, 1.75))
				var/D = new/mob/Ultimate_Projectile/UShuriken (null, Executor)
				D:y += 2
				D:pixel_y = rand(-8, 8)
				D:pheight = 32
			spawn(rand(1, 1.75))
				switch(rand(1, 2))
					if(1)
						var/F = new/mob/Ultimate_Projectile/UKunai (null, Executor)
						F:y += 3
						F:pixel_y = rand(-8, 8)
						F:pheight = 32
					if(2)
						var/F = new/mob/Ultimate_Projectile/UShuriken (null, Executor)
						F:y += 3
						F:pixel_y = rand(-8, 8)
						F:pheight = 32
			spawn(rand(1, 1.75))
				var/E = new/mob/Ultimate_Projectile/Kunai(null, Executor)
				E:y += 4
				E:pixel_y = rand(-8, 8)
				E:pheight = 32

			Executor.freeze --
	Throw_Arrow()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(5)
		Executor.Attacking ++
		Executor.stop()
		Flick("Bow", Executor)
		sleep(1.75)
		Executor.Execute_Jutsu("RAAAAAAH!")
		new/mob/Ultimate_Projectile/Susanoo_Arrow(null, Executor)
		spawn(4.25)
			Executor.Attacking --
			Executor.stop()


	Fire_Tsunami()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Great Fire Annihilation!")
		new/mob/Ultimate_Projectile/Fire_Tsunami(null, Executor)
		var/B = new/mob/Ultimate_Projectile/Fire_Tsunami(null, Executor)
		B:y += 2
		var/C = new/mob/Ultimate_Projectile/Fire_Tsunami(null, Executor)
		C:y += 4
		var/D = new/mob/Ultimate_Projectile/Fire_Tsunami(null, Executor)
		D:y += 6
		var/E = new/mob/Ultimate_Projectile/Fire_Tsunami(null, Executor)
		E:y += 8
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()

	Immense_Tsunami()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(25)
		Executor.Attacking ++
		Executor.stop()
		Flick("Barrier", Executor)
		sleep(5)
		Flick("Barrier", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Water Release.- Tsunami!")
		new/mob/Ultimate_Projectile/RealWave(null, Executor)
		var/B = new/mob/Ultimate_Projectile/RealWave(null, Executor)
		B:y += 1
		var/C = new/mob/Ultimate_Projectile/RealWave(null, Executor)
		C:y += 3
		var/D = new/mob/Ultimate_Projectile/RealWave(null, Executor)
		D:y += 5
		var/E = new/mob/Ultimate_Projectile/RealWave(null, Executor)
		E:y += 7
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()


	Sand_Tsunami()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(25)
		Executor.Attacking ++
		Executor.stop()
		Flick("Barrier", Executor)
		sleep(5)
		Flick("Barrier", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Sand Release.- Tsunami!")
		new/mob/Ultimate_Projectile/Sand_Wave(null, Executor)
		var/B = new/mob/Ultimate_Projectile/Sand_Wave(null, Executor)
		B:y += 1
		var/C = new/mob/Ultimate_Projectile/Sand_Wave(null, Executor)
		C:y += 3
		var/D = new/mob/Ultimate_Projectile/Sand_Wave(null, Executor)
		D:y += 5
		var/E = new/mob/Ultimate_Projectile/Sand_Wave(null, Executor)
		E:y += 7
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()




	Ferocious_Wind()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 27.5) == 0) return
		Delay(1)
		Executor.Attacking ++
		Executor.stop()
		Flick("Storm", Executor)
		sleep(5)
		Executor.Execute_Jutsu("Wind Style.- Ferocious Wind!")
		new/mob/Ultimate_Projectile/Ferocious_Wind(null, Executor)
		spawn(2)
			Executor.Attacking --
			Executor.stop()


	Bug_Bullet()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 25) == 0) return
		Delay(2)
		Executor.Attacking ++
		Executor.stop()
		Executor.Execute_Jutsu("Bug Bullet!")
		Flick("mob-shooting", Executor)
		sleep(1.5)
		new/mob/Ultimate_Projectile/Bug(null, Executor)
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Bug_Storm()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 45) == 0) return
		Delay(5)
		Executor.Attacking ++
		Executor.stop()
		Executor.Execute_Jutsu("Bug Storm!")
		Flick("mob-shooting", Executor)
		sleep(1.5)
		new/mob/Ultimate_Projectile/Bug_Storm(null, Executor)
		var/B = new /mob/Ultimate_Projectile/Bug_Storm(null, Executor)
		B:y += 1
		var/C = new /mob/Ultimate_Projectile/Bug_Storm(null, Executor)
		C:y += 2
		var/D = new /mob/Ultimate_Projectile/Bug_Storm(null, Executor)
		D:y += 3
		spawn(3)
			Executor.Attacking --
			Executor.stop()

	Throw_RasenshurikenXX()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Flick("Rasenshuriken", Executor)
		sleep(2)
		new/mob/Ultimate_Projectile/RasenshurikenXX(null,Executor,null,"Straight",null)
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()

	Throw_Rasenshuriken()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Flick("Rasenshuriken", Executor)
		sleep(13)
		var/A = new/mob/Ultimate_Projectile/Rasenshuriken (null, Executor)
		A:Village = Executor.Village
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()
			if(Executor.E_Part == "Use A Jutsu") Executor.Complete_Genin_Part()


	Throw_Rasenshuriken_X()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 135) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Flick("Rasenshuriken Charge", Executor)
		sleep(15)
		Flick("Rasenshuriken Throw", Executor)
		sleep(6)
		var/A = new/mob/Ultimate_Projectile/RasenshurikenX (null, Executor)
		A:Village = Executor.Village
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()

mob/var/Tsunami_CD = 0
mob/var/mob/Mind_Controlled = null
mob/var/mob/Mind_Controlling = null
mob/var/Mind_Controlling_
mob/var/mob/Creator_M = null
mob/var/mob/Fake_Ino = null
mob/var/Murderer = null
mob/var/Real_Character_Name

mob/Ino
mob/var/Ino_NPC = 0

mob/proc
	Mind_Control(mob/Target, var/_Lethal)
		if(Mind_Controlling || !Target.client || knocked || dead || Target.knocked || Target.dead || Target.Edo || Target.Susanoo || !Target.Real) return
		Old_Village = Village
		if(Target.Controlling_Object) del(Target.Controlling_Object)
		for(var/mob/M)
			if(M.Village == Old_Village) M<<"<b><font color=#FCDFFF><font size=2><u>[name] is now controlling [Target]'s body!</u></font>"
		if(!_Lethal)
			Lethal = null
			src<<"<b><font color=#FCDFFF>You are now controlling this body, you can't attack anybody, however your allies can attack you while being in this body.<br><br>* If you die this body's health will be reduced to 25%, so make sure your allies are close to him!<br>* Your real body's health bar is at the top of the screen.<br>* Press Q to stop using this jutsu."
			Village = Target.Village
			overlays += new/obj/NL_Mind_Control ()
		if(_Lethal)
			Lethal = 1
			src<<"<b><font color=#FCDFFF>You are now controlling this body, you can attack the Enemy team, however everyone else can attack you too while being in this body.<br><br>* If you die this body's health will be reduced to 25%, so make sure your allies are close to him!<br>* Your real body's health bar is at the top of the screen.<br>* Press Q to stop using this jutsu."
			Village = rand(1, 1000000000000000)
			overlays += new/obj/L_Mind_Control ()
		Time__ = rand(1, 1000)
		var/Old_Time = Time__
		spawn(1800)
			if(Old_Time == Time__ && Mind_Controlling)
				src<<"<b><font color=#FCDFFF>You've had enough fun with [Target.name]."
				Reset_Mind_Control()
				return
		if(Target.Sharingan) Target.Sharingan_Off(Target)
		if(Target.Byakugan) Target.Byakugan_Off(Target)
		if(Target.Rinnegan) Target.Rinnegan_Off(Target)
		if(Target.Gentle_Fist) Target.Gentle_Fist_Off(Target)
		if(Target.Amat_Sword) Amat_Sword_Fist_Off(Target)
		Target.Mind_Controlled = src
		freeze = 0
		Mind_Controlling = Target
		var/mob/I = new/mob/Ino (src.loc)
		Fake_Ino = I
		Special_ = 61
		Attacking = 0
		I.Ino_NPC = 1
		I.icon_state = "Control"
		I.dir = dir
		I.Village = Old_Village
		I.Creator_M = src
		I.stop()
		I.Substitution = 1
		I.layer = layer
		I.icon = icon
		I.px = px
		I.py = py
		I.Teleport_(src)
		I.Substitution = 0
		I.HP = HP
		I.MaxHP = MaxHP
		I.MaxCha = MaxCha
		I.MaxEnergy = MaxEnergy
		I.speed_multiplier = speed_multiplier
		I.ultra_speed = ultra_speed
		I.Attacking = 0
		Fake_Ino.Attacking = 0
		Fake_Ino.Def = Def
		Fake_Ino.Str = Str
		I.Recover()
		Real_Character_Name = Target.name
		dir = Target.dir
		Target.density = 0
		Target.Substitution = 1
		Target.invisibility = 101
		Target.Invisibility()
		Substitution = 1
		Teleport_(Target)
		Substitution = 0
		icon = Target.icon
		Flick("teleport", src)
		MaxHP = Target.MaxHP
		HP = Target.HP
		MaxCha = Target.MaxCha
		Cha = Target.Cha
		MaxEnergy = Target.MaxEnergy
		Energy = Target.Energy
		Str = Target.Str
		Def = Target.Def
		speed_multiplier = Target.speed_multiplier
		ultra_speed = Target.ultra_speed
		Run_Off()
		Target.Dragonned = 1
		Target.CanMove = 0
		Target.freeze ++
		if(Target.client)
			Target.client.perspective = EYE_PERSPECTIVE
			Target.client.eye = src
		for(var/obj/J in Jutsus) del(J)
		Jutsus = Target.Jutsus

	Reset_Mind_Control()
		if(Mind_Controlling_) return
		Mind_Controlling_ = 1
		Special_ = 0
		loop
			if(freeze && !knocked || Dragonned && !knocked || !CanMove && !knocked) spawn(0.25) goto loop
			else
				flick("teleport", src)
				flick("teleport", Mind_Controlling)
				src<<"<b><font color=#FCDFFF>You're no longer controlling [Mind_Controlling.name]."
				Mind_Controlling.Mind_Controlled = null
				Real_Character_Name = name
				Lethal = 0
				overlays -= /obj/NL_Mind_Control
				overlays -= /obj/L_Mind_Control
				Fake_Ino.Substitution = 1
				Village = Old_Village
				if(Controlling_Object) del(Controlling_Object)
				Mind_Controlling.icon = icon
				icon = 'Ino.dmi'
				Run_Off()
				Activated = 0
				Special_Crow = 0
				Crow = 0
				Attacking = 0
				Mind_Controlling.Attacking = 0
				Mind_Controlling.Dragonned = 0
				Mind_Controlling.density = 1
				Fake_Ino.invisibility = 101
				Mind_Controlling.CanMove = 1
				Mind_Controlling.freeze = 0
				Mind_Controlling.Substitution = 0
				Mind_Controlling.dir = dir
				Mind_Controlling.HP = HP
				Mind_Controlling.Cha = Cha
				Mind_Controlling.Energy = Energy
				Mind_Controlling.Str = Str
				Mind_Controlling.Def = Def
				Mind_Controlling.speed_multiplier = speed_multiplier
				Mind_Controlling.ultra_speed = ultra_speed
				Mind_Controlling.Run_Off()
				speed_multiplier = Fake_Ino.speed_multiplier
				ultra_speed = Fake_Ino.ultra_speed
				dir = Fake_Ino.dir
				Def = Fake_Ino.Def
				Str = Fake_Ino.Str
				MaxHP = Fake_Ino.MaxHP
				MaxCha = Fake_Ino.MaxCha
				MaxEnergy = Fake_Ino.MaxEnergy
				Mind_Controlling.invisibility = 0
				//var/SRC_Loc = loc
				//Mind_Controlling.loc = SRC_Loc
				Mind_Controlling.Teleport_(src)
				if(Mind_Controlling.client)
					Mind_Controlling.client.perspective = MOB_PERSPECTIVE
					Mind_Controlling.client.eye = Mind_Controlling
				Mind_Controlling.Substitution = 0
				spawn() Teleport_(Fake_Ino)
				var/_HP = MaxHP *0.25
				if(HP <= 0)
					HP = 15
					Mind_Controlling.HP = _HP
				if(Fake_Ino.knocked) HP = 15
				Jutsus = list()
				Check_Jutsu()
				Mind_Controlling = null
				spawn()
					for(var/obj/Jutsus/NL_Mind_Transfer/S in Jutsus) S.Delay(45)
					for(var/obj/Jutsus/L_Mind_Transfer/S in Jutsus) S.Delay(45)
					Mind_Controlling_ = 0
					Fake_Ino.Always_Freeze()
					Fake_Ino = null

	Teleport_(atom/To_Go, var/G)
		loc = To_Go.loc
		set_pos(To_Go.px, To_Go.py, To_Go.z)
		if(ismob(To_Go))
			step_x = To_Go:step_x
			step_y = To_Go:step_y
		stop()

mob/var/Projectile

mob/New()
	..()
	if(!Active_M) spawn()
		check_loc()
		movement()

	Real_Character_Name = name
	if(!NEM_Round && !Mission_NPC)
		if(!Projectile) Current_NEM_Round.Join(src)
		else if(Current_NEM_Round) Current_NEM_Round.Ninjas.Add(src)

	spawn()
		if(client)
			for(var/Statistic/S in Statistics) if(S.Ninja == key)
				Statistic = S
				var/_C
				S.Last_Time_Seen = "Now"

				for(var/Alliance/A in Alliances)  for(var/Statistic/D in A.Members) if(D.Ninja == S.Ninja)
					if(A.Leader) if(A.Leader.Ninja == Statistic.Ninja) A.Leader = Statistic
					for(var/Statistic/F in A.Members) if(F.Ninja == Statistic.Ninja) A.Members.Remove(F)
					Statistic._Village_ = A
					Statistic.Got_Village = 1
					A._Members.Remove(src)
					A._Members.Add(src)
					A.Members.Add(Statistic)
					A.Organize()
					_C ++

				if(!_C)
					Statistic._Village_ = null
					Statistic.Village = null
					Statistic.Rank_Update("Missing-Nin")
			if(!Statistic)
				var/Statistic/S = new/Statistic (key)
				S.Last_Time_Seen = "Now"
				Statistic = S

		else
			Statistic = NPC_Statistic

var/tmp/Statistic/NPC_Statistic = new/Statistic ("NPC")

mob/proc/Invisibility()
	..()
	loop
		if(Mind_Controlled)
			invisibility = 101
			Dragonned = 1
			Substitution = 1
			freeze = 1
		spawn(3) goto loop

mob/var/Time__
mob/var/Lethal = 1
mob/var/Mission_NPC


mob
	Special_Effect/Crescent_Moon
		Real = 0
		Checked_X = 0
		Active_M = 0
		density = 0
		pheight = 16
		ByPass = 1
		Substitution = 1
		layer = 100

		var
			Length = 300
			Delay

		New(_loc, mob/_Projectile_Owner, var/D, var/L)
			..()
			if(_Projectile_Owner)
				src.dir = _Projectile_Owner.dir
				loc = _Projectile_Owner.loc
				set_pos(_Projectile_Owner.px, _Projectile_Owner.py+6)
				if(dir == EAST) vel_x += 32
				if(dir == WEST) vel_x -= 32

		bump(atom/a) vel_x = 0

		movement()
			if(!vel_x || !loc) return
			set_flags()
			pixel_move(vel_x)
			spawn(world.tick_lag)
				check_loc()
				movement()

//mob/Dragonpearl123/verb/S()
//	var/matrix/M = matrix()
//	M.Turn(rand(0, 359))
//	animate(src, transform = M, time = 10)