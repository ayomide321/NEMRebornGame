mob/var/Immune=0
mob/var/Poison_Immunity=0
mob/var/Attack_CD=0
mob/var/Active_Attack
mob/var/Special_Width
mob/var/Special_Height
mob/var/list/Attacked_List = list()
mob/var/Interrupt
var/AllowedPoison=1
var/AllowedPoisonX=1
var/AllowedAmaterasu=1
var/AllowedAmaterasuX=1
var/Akamaru=0


obj
	mobcheck
		bound_width=24
		bound_height=20
	mobcheckX
		bound_width=34
		bound_height=40
	mobcheckS
		bound_width=24
		bound_height=15000
	mobcheckXS
		bound_width=34
		bound_height=15000

mob/var/Attacking=0
mob/var/HP=100
mob/var/MaxHP=100
mob/var/Cha=100
mob/var/MaxCha=100
mob/var/Energy=100
mob/var/MaxEnergy=100
mob/var/Str=10
mob/var/Def=5
mob/var/combo=0
mob/var/Chain_Restriction=null
mob/var/RestrictionFX=null
mob/var/Attacked=0
mob/var/FightingOnTourney=1
var/Ton=0
var/First=0
var/Second=0
var/TourneyRound=0
var/RightSide=1
var/WestSide=1
mob/var/Explosing
mob/var/CanAttackKazekage=1
mob/var/tmp/Can_Attack_On_Air = 1
mob/var/Can_Attack_ = 1

mob/proc/Special_Attack(mob/M)
	if(Attacked_List.Find(M)) return
	if(!knocked && !Dragonned && !freeze && !M.Dragonned && M.Real && !M.knocked && M.Village != Village)
		if(M.Dodging == 1) {Attacked_List.Add(M); M.Auto_Dodge(src, 1); return}
		var/damage=src.Str-M.Def
		damage += rand(5, 8.5)
		if(damage <= 0) damage = 1
		M.Damage(src, damage /1.75, 1, 0, 0, 1, 0, 0, 1)
		if(dir == EAST) M.knockbackeast()
		else M.knockbackwest()
		Attacked_List.Add(M)

mob/proc
	Attack()
		if(Wall_Freeze || No_Attack || Mind_Controlling && !Lethal || GoingSage || KakashiChidori || Rasengan || Chidori || DinamicEntry || Iron || Attacking || knockback || Venomous_Clone) return
		if(Substitution == 1)
			if(Substitution_Image) del(Substitution_Image)
			density = 1
			Dragonned = 0
			Substitution = 0
			Can_Attack_ = 1
			invisibility = 0
		if(!Can_Attack_) return
		if(RestrictionFX==1)
			src.HP -= 10
		if(Explosing)
			if(Cha < C)
				if(client) Cooldown_Display (C)
				src<<"<b><font color=#F39441><u>You're no longer using Explosive Meele!</u>"
				Explosing = 0
				for(var/obj/Jutsus/Explosive_Meele/M in Jutsus) M.Delay(10)
			else
				Can_Attack_ = 0
				freeze ++
				if(on_ground) Flick("seals", src)
				else Flick("airpunch", src)
				spawn(15) Can_Attack_ = 1
				spawn(4) {freeze --; stop()}
				sleep(1.75)
				if(!loc) return
				var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 350, 220)
				var/list/Enemy = Bounds.Enemy()
				for(var/mob/M in Enemy)
					if(M.Dodging == 1)
						M.Auto_Dodge (src)
						src<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge you!"
					else
						Cha -= 12.5
						var/Damage=src.Str-M.Def
						Damage += rand(5, 10.5)
						M.Damage(src, Damage, 1, 1, 0, 0, 3)
						if(Cha < 0)
							Cha = 0
							Explosing = 0
							src<<"<b><font color=#F39441><u>You're no longer using Explosive Meele!</u>"
							for(var/obj/Jutsus/Explosive_Meele/E in Jutsus) E.Delay(10)
						return
				return
		if(Amat_Sword)
			if(Cha < C)
				if(client) Cooldown_Display (C)
				src<<"<b><font color=#F39441><u>You're no longer using Amaterasu Sword</u>"
				Amat_Sword = 0
				for(var/obj/Jutsus/Amat_Sword/M in Jutsus) M.Delay(15)
			else
				Can_Attack_ = 0
				freeze ++
				if(on_ground) Flick("seals", src)
				else Flick("airpunch", src)
				spawn(15) Can_Attack_ = 1
				spawn(4) {freeze --; stop()}
				sleep(1)
				if(!loc) return
				var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 350, 220)
				var/list/Enemy = Bounds.Enemy()
				for(var/mob/M in Enemy)
					if(M.Dodging == 1)
						M.Auto_Dodge (src)
						src<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge you!"
					else
						Cha -= 12.5
						var/Damage=src.Str-M.Def
						Damage += rand(5, 10.5)
						M.Damage(src, Damage, 1, 1, 0, 0, 3)
						if(Cha < 0)
							Cha = 0
							Amat_Sword = 0
							src<<"<b><font color=#F39441><u>You're no longer using Amaterasu Sword!</u>"
							for(var/obj/Jutsus/Amat_Sword/E in Jutsus) E.Delay(10)
						return
				return

		if(name == "{Venomous Insects} Torune")
			var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 200, 160)
			var/list/Enemy = Bounds.Enemy()
			for(var/mob/M in Enemy)
				if(M.Dodging == 1)
					Can_Attack_ = 0
					spawn(12.5) Can_Attack_ = 1
					M.Auto_Dodge (src)
					src<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge you!"
				else
					client.perspective = EYE_PERSPECTIVE
					client.eye = M
					Checked_X = 0
					loc = M.loc
					px = M.px
					py = M.py
					freeze ++
					Dragonned = 1
					M.Dragonned = 1
					Substitution = 1
					M.freeze ++
					Flick("Special V", src)
					spawn(1)
						M.stop()
						Dragonned = 1
						M.Dragonned = 1
						layer = 101
						if(dir == EAST)
							M.dir = WEST
							pixel_x = M.step_x -42
						if(dir == WEST)
							M.dir = EAST
							pixel_x = M.step_x +42
						pixel_y = M.step_y
						loc = M.loc
					spawn(4.5)
						Dragonned = 1
						M.Dragonned = 1
						M.freeze --
						M.Damage(src, 5, 0, 0, 0, 1)
						if(dir == EAST) M.knockbackeastx()
						if(dir == WEST) M.knockbackwestx()
						M.Poison_Proc(3, name)
					spawn(17)
						if(dir == EAST) dir = WEST
						else if(dir == WEST) dir = EAST
						Dragonned = 1
						M.stop()
						M.Dragonned = 1
						M.freeze ++
						if(dir == EAST)
							M.dir = WEST
							pixel_x = M.step_x -74
						if(dir == WEST)
							M.dir = EAST
							pixel_x = M.step_x +74
						pixel_y = M.step_y -8
						loc = M.loc
					spawn(19.5)
						M.Dragonned = 0
						M.freeze --
						M.Poison_Proc(3, name)
						M.Damage(src, 7.5, 1, 0, 0, 1)
						if(dir == EAST) M.knockbackeastx()
						if(dir == WEST) M.knockbackwestx()
					spawn(22)
						Flick("teleport", src)
						pixel_y = 0
						pixel_x = 0
						client.perspective = MOB_PERSPECTIVE
						client.eye = src
						Substitution = 0
						Dragonned = 0
						Checked_X = 1
						freeze --
						Can_Attack_ = 0
						spawn(17.5) Can_Attack_ = 1
		else

			if(name == "Deidara" && CanAttackKazekage)
				for(var/mob/Ultimate_Projectile/BlackSand/B) del(B)
				CanAttackKazekage = 0
				spawn(50)  CanAttackKazekage = 1
				for(var/mob/M) if(M.name=="Clay Centipede" && !M.Deleted) M.Del_Puppet()

			if(name == "Sasori" && Controlling == 2 && CanAttackKazekage)
				for(var/mob/Ultimate_Projectile/BlackSand/B) del(B)
				CanAttackKazekage = 0
				for(var/mob/M) if(M.name == "Kazekage Puppet" && !M.Deleted)
					var/A = new/mob/Ultimate_Projectile/BlackSand(null, M)
					Flick("atk", M)
					A:Allies = Village
					A:Projectile_Owner = src
					if(M.dir == EAST) A:x+=1
					if(M.dir == WEST) A:x-=1
					A:dir=dir
					spawn(30) CanAttackKazekage=1
					return
			if(Levitating>=1||Boulder>=1||BoulderX>=1||Gates==1||knockback==1||freeze||Controlling>=1||Attacking||knocked==1)return
			if(!on_ground)
				if(!Can_Attack_On_Air) return
				if(name != "Suigetsu" && !Bijuu) Flick("airpunch", src)
				else
					if(Bijuu) Bijuu_Punch("airpunch")
					else Suigetsu_Punch("airpunch")
				Can_Attack_On_Air = 0
				Get_On_Wall = 0
				spawn(15) Get_On_Wall = 1
				Can_Attack_ = 0
				spawn(20) Can_Attack_On_Air = 1
				spawn(5) spawn(4.5) Can_Attack_ = 1
				stop()
				if(keys[controls.down] && Real && !Susanoo)
					if(Energy < 7) src<<output("<b><font color=red><u>You need more energy!</u></font>", "Chat")
					else
						if(E_Part == "Downward Meele") Complete_Genin_Part()
						if(name == "Sasuke") Flick("punch4", src)
						Interrupt = rand(1, 10000)
						Dodging = 0
						var/_I_ = Interrupt
						freeze ++
						vel_x = 0

						spawn(1.5)
							vel_x = 0
							Energy -= 7
							freeze --
							if(_I_ != Interrupt) return
							Attacked_List = list()
							Active_Attack = 1
							vel_y = -17.5
							if(dir == EAST) Special_Width = 27
							else Special_Width = -27
							spawn(6.5) Active_Attack = 0
						return


				Attacking_(8)
				if(Gentle_Fist)
					var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 180, 140)
					Bounds.y--
					var/list/Enemy = Bounds.Enemy()
					for(var/mob/M in Enemy)
						if(M.Dodging == 1)
							M.Auto_Dodge (src)
							src<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge you!"
						else
							var/Damage=src.Str-M.Def
							Damage += rand(5, 8.5)
							M.Damage(src, Damage, 1, 1, 0, 0, 1)
							return
					return

				if(!Gentle_Fist)
					if(Susanoo)
						var/obj/K = new/obj/mobcheckXS ()
						K.dir = dir
						K.loc = loc
						K.step_x = step_x
						K.step_y = step_y
						if(dir == EAST) K:x += 6
						if(dir == WEST) step(K, dir, 16)
						spawn(3) del(K)
						for(var/mob/M in bounds(K,0))
							if(M == src || !M.Real || M.Village == src.Village || FightingOnTourney == 0|| M.Dragonned || M.knocked) continue
							if(M.Dodging == 1)
								M.Auto_Dodge(src)
								continue
							if(M.Crow)
								M.Crow(src)
								return
							var/damage=src.Str-M.Def
							damage += rand(5, 8.5)
							M.Damage(src, damage, 1, 1, 0, 1)
							if(Byakugan == 1 || name == "Kisame" || name == "(UnCloaked) Kisame")
								if(combo >= 2)
									var/Chakra_Drained = combo*1.25
									if(M.Cha < Chakra_Drained) Chakra_Drained = M.Cha
									if(Chakra_Drained <= 0) Chakra_Drained = 0.15
									M.Cha -= Chakra_Drained
									src.Cha += Chakra_Drained
									if(src.Cha >= src.MaxCha) src.Cha = src.MaxCha
							M.Attacked(30, 1)
							if(name == "Dosu")
								switch(rand(1,4))
									if(4) M.Quake_Effect_X(3)
							if(name == "Sasori" || name == "(Puppet Body) Sasori" || name == "Torune" || name == "Hiruko")
								if(M.knocked || !AllowedPoison || M.Poison_Immunity) continue
								if(prob(25))
									M.Poison_Proc(3, name)

						return
					var/obj/K = new/obj/mobcheckX  ()
					if(name == "Suigetsu" || Bijuu) K.bound_width += 48
					K.dir = dir
					K.loc = loc
					K.step_x = step_x
					K.step_y = step_y
					if(Bijuu && dir == EAST) step(K,dir,22)
					if(Bijuu && dir == WEST) step(K,dir,22)
					step(K,dir,24)
					spawn(3) del(K)
					if(!loc) return
					for(var/mob/M in bounds(K,0))
						if(M == src || !M.Real || M.Village == Village || !FightingOnTourney|| M.Dragonned || M.knocked) continue
						if(M.Dodging == 0)
							if(M.Crow)
								M.Crow(src)
								return
							var/damage=src.Str-M.Def
							damage += rand(5, 8.5)
							M.Damage(src, damage, 1, 1, 0, 1)
							if(Byakugan || name == "Kisame" || name == "(UnCloaked) Kisame")
								if(combo >= 2)
									var/Chakra_Drained = combo*1.25
									if(M.Cha < Chakra_Drained) Chakra_Drained = M.Cha
									if(Chakra_Drained <= 0) Chakra_Drained = 0.15
									M.Cha-=Chakra_Drained
									Cha+=Chakra_Drained
									if(src.Cha >= src.MaxCha) src.Cha = src.MaxCha
							M.Attacked(30, 1)
							if(!M.knocked)
								if(Activated && M.Real_C)
									M.Dodging = 0
									var/H = new/obj/H_H (src)
									if(Activated == 1 && !knocked) H:Wrath_Of_Jashin_X(M)
									if(Activated == 2 && !knocked) H:Scythe_Strike_X(M)
									if(Activated == 3 && !knocked) H:Lion_Barrage_X(M)
									if(Activated == 7319745 && !knocked) H:Jyuuken_Shinan_X(M)
									if(Activated == 4 && !knocked) H:Special_Attack_X(M)
									if(Activated == 5 && !knocked) H:Obito_Combo_X(M)
									if(Activated == 6 && !knocked) H:Flaming_Dragon_X(M)
									if(Activated == 7 && !knocked) H:Special_AttackX_X(M)
									if(Activated == 8 && !knocked) H:Anbu_Combo_X(M)
									if(Activated == 9 && !knocked) H:Raikage_Hit_X(M)
									if(Activated == 10 && !knocked) H:Guillotine_Drop_X(M)
									if(Activated == 11 && !knocked) H:Kunai_Rush_X(M)
									if(Activated == 12 && !knocked) H:Crystal_Explosive_Tree_X(M)
									if(Activated == 13 && !knocked) H:Paper_Trap_X(M)
									if(Activated == 14 && !knocked) H:Drop_Kick_X(M)
									if(Activated == 15 && !knocked) H:Elbow_X(M)
									if(Activated == 16 && !knocked) H:Rockfall_X(M)
									if(Activated == 20 && !knocked) H:Absorb_Chakra_X(M)
									if(Activated == 21 && !knocked) H:Sensatsu_Suisho_X(M)
									if(Activated == 22 && !knocked) H:Demonic_Mirrors_X(M)
									if(Activated == 23 && !knocked) H:Ice_Spike_Explosion_X(M)
									if(Activated == 30 && !knocked) H:Fire_Stream_X(M)
									if(Activated == 31 && !knocked) H:Water_Stream_X(M)
									if(Activated == 696 && !knocked) H:Sharingan_Genjutsu_X(M)
									if(Activated == 777 && !knocked) H:Chakra_Implosion_X(M)
									if(Activated == 888 && !knocked) H:Sanbi_Hand_X(M)
									if(Activated == 35 && !knocked) H:Claws_X(M)
									if(Activated == 69 && !knocked) H:Beast_Tearing_Gale_Scratch_X(M)
									if(Activated == 85 && !knocked) H:Lava_Shoot_X(M)
									if(Activated == 697 && !knocked) H:Susanoo_Crushing_Grip_X(M)
									if(Activated == "Snake Swamp" && !knocked) H:Underground_Snake_Swamp_X(M)
									if(Activated == 1969 && !knocked) H:Special_Combo_E1_X(M)
									if(Activated == 9742 && !knocked) H:Scythe_Summoning_(M)
									if(Activated == 1970 && !knocked) H:Chibaku_Tensei_X(M)
									if(Activated == 1971 && !knocked) H:Special_Combo_SA_X(M)

								if(name == "Dosu")
									switch(rand(1,4))
										if(4) M.Quake_Effect_X(3)
								if(name == "Sasori" || name == "(Puppet Body) Sasori" || name == "Hiruko" || name == "Torune")
									if(M.knocked || !AllowedPoison || M.Poison_Immunity) continue
									if(prob(25))
										M.Poison_Proc(3, name)
						if(M.Dodging == 1)
							M.Auto_Dodge(src)
							continue
					return
			if(combo == 5) combo = 0
			combo++
			var/B_P
			var/TW = 1.5
			if(keys[controls.up])
				if(E_Part == "Upward Meele") Complete_Genin_Part()
				if(name != "Suigetsu" && !Bijuu) Flick("punch5", src)
				else
					if(Bijuu)
						if(Can_Grab) {freeze ++; Bijuu_Punch("grab"); B_P = 1; TW = 0}
						else Bijuu_Punch("punch2")
					else Suigetsu_Punch("punch5")
				combo = 0
			else
				if(name != "Suigetsu" && !Bijuu) Flick("punch[combo]", src)
				else
					if(Bijuu) Bijuu_Punch("punch[combo]")
					else Suigetsu_Punch("punch[combo]")
			Punch_Animation = 1
			spawn(2.75) Punch_Animation = 0
			Can_Attack_ = 0
			stop()
			if(ultra_speed != 2 && name != "Neji" && name != "Hinata" && !Gentle_Fist)
				Attacking_(5)
				spawn(5.75) Can_Attack_ = 1
			if(ultra_speed == 2 && !Gentle_Fist || name == "Neji" && !Gentle_Fist || name == "Hinata")
				Attacking_(4)
				spawn(4.75) Can_Attack_ = 1
			if(Gentle_Fist)
				Attacking_(4)
				spawn(12.15) Can_Attack_ = 1
			spawn(TW)
				if(!loc) return
				if(Gentle_Fist)
					var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 180, 140)
					var/list/Enemy = Bounds.Enemy()
					for(var/mob/M in Enemy)
						if(M.Dodging == 1)
							M.Auto_Dodge (src)
							src<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge you!"
						else
							var/Damage=src.Str-M.Def
							Damage += rand(5, 8.5)
							M.Damage(src, Damage, 1, 1, 0, 0, 1)
							return
				if(!Gentle_Fist)
					if(Susanoo)
						var/obj/K=new/obj/mobcheckS  ()
						if(name == "Suigetsu" || Bijuu) K.bound_width += 48
						K.dir =  dir
						K.loc = loc
						K.step_x = step_x
						K.step_y = step_y
						if(dir == EAST)K:x+=6
						if(dir == WEST) step(K,dir,16)
						spawn(3) del(K)
						for(var/mob/M in bounds(K,0))
							if(M == src || M.knocked || !M.Real || M.Village == src.Village || !FightingOnTourney || M.Dragonned || M.knocked) continue
							if(M.Dodging)
								M.Auto_Dodge(src)
								continue
							if(M.Crow)
								M.Crow(src)
								return
							var/damage=src.Str-M.Def
							damage += rand(5, 8.5)
							if(damage <= 0) damage = 1
							M.Damage(src, damage, 1, 0, 0, 1)
							if(Byakugan || name == "Kisame" || name == "(UnCloaked) Kisame")
								if(combo >= 2)
									var/Chakra_Drained = combo*1.25
									if(M.Cha < Chakra_Drained) Chakra_Drained = M.Cha
									if(Chakra_Drained <= 0) Chakra_Drained = 0.15
									M.Cha-=Chakra_Drained
									Cha+=Chakra_Drained
									if(Cha >= src.MaxCha) Cha = src.MaxCha
							if(M.Levitating) M.Check_Levitating()
							M.Attacked(30, 1)
							if(src.dir==EAST) M.dir=WEST
							if(src.dir==WEST) M.dir=EAST
							if(name == "Dosu")
								switch(rand(1,4))
									if(4) M.Quake_Effect_X(3)
							if(name == "Sasori" || name == "(Puppet Body) Sasori" || name == "Hiruko" || name == "Torune")
								if(M.knocked || !AllowedPoison || M.Poison_Immunity) continue
								if(prob(25)) M.Poison_Proc(3, name)
					var/obj/K = new/obj/mobcheck ()
					if(name == "Suigetsu" || Bijuu) K.bound_width += 48
					K.dir = dir
					K.loc = loc
					K.step_x = step_x
					K.step_y = step_y
					if(Bijuu && dir == EAST) step(K,dir,22)
					if(Bijuu && dir == WEST) step(K,dir,22)
					step(K,dir,24)
					spawn(3) del(K)
					for(var/mob/M in bounds(K,0))
						if(M == src || M.knocked || !M.Real || M.Village == Village || !FightingOnTourney || M.Dragonned|| M.knocked) continue
						if(!M.Dodging)
							if(M.Crow)
								M.Crow(src)
								return
							var/damage=src.Str-M.Def
							damage += rand(5, 8.5)
							if(damage <= 0) damage = 1
							if(Byakugan || name == "Kisame" || name == "(UnCloaked) Kisame")
								if(combo >= 2)
									var/Chakra_Drained = combo*1.25
									if(M.Cha < Chakra_Drained) Chakra_Drained = M.Cha
									if(Chakra_Drained <= 0) Chakra_Drained = 0.15
									M.Cha-=Chakra_Drained
									Cha+=Chakra_Drained
									if(Cha >= src.MaxCha) Cha = src.MaxCha
							M.Attacked(30, 1)
							if(!B_P)
								M.Damage(src, damage, 1, 0, 0, 1)
								if(!Attack_CD)
									if(keys[controls.up])
										if(!M.freeze && !GoingSage && M.on_ground) M.Fight()
										M.freeze ++
										spawn(1)
											M.freeze --
											M.vel_y = 15
											M.HP -= damage/2
											Attack_CD = 1
											spawn(100) Attack_CD = 0
									if(keys[controls.right] && dir == EAST && M.on_ground)
										if(!M.freeze && !GoingSage) M.Fight()
										new/obj/Effects/Strong_Hit (M.loc, M)
										M.freeze ++
										spawn(1.5)
											M.freeze --
											M.knockbackeastt()
											M.HP -= damage/1.75
											Attack_CD = 1
											spawn(100) Attack_CD = 0
									if(keys[controls.left] && dir == WEST && M.on_ground)
										if(!M.freeze && !GoingSage) M.Fight()
										new/obj/Effects/Strong_Hit (M.loc, M)
										M.freeze ++
										spawn(1.5)
											M.freeze --
											M.knockbackwestt()
											M.HP -= damage/1.75
											Attack_CD = 1
											spawn(100) Attack_CD = 0

								if(!M.knocked)
									if(Activated && M.Real_C)
										var/H = new/obj/H_H (src)
										M.Dodging = 0
										if(Activated == 1 && !knocked) H:Wrath_Of_Jashin_X(M)
										if(Activated == 2 && !knocked) H:Scythe_Strike_X(M)
										if(Activated == 3 && !knocked) H:Lion_Barrage_X(M)
										if(Activated == 7319745 && !knocked) H:Jyuuken_Shinan_X(M)
										if(Activated == 4 && !knocked) H:Special_Attack_X(M)
										if(Activated == 5 && !knocked) H:Obito_Combo_X(M)
										if(Activated == 6 && !knocked) H:Flaming_Dragon_X(M)
										if(Activated == 7 && !knocked) H:Special_AttackX_X(M)
										if(Activated == 8 && !knocked) H:Anbu_Combo_X(M)
										if(Activated == 9 && !knocked) H:Raikage_Hit_X(M)
										if(Activated == 10 && !knocked) H:Guillotine_Drop_X(M)
										if(Activated == 11 && !knocked) H:Kunai_Rush_X(M)
										if(Activated == 12 && !knocked) H:Crystal_Explosive_Tree_X(M)
										if(Activated == 13 && !knocked) H:Paper_Trap_X(M)
										if(Activated == 14 && !knocked) H:Drop_Kick_X(M)
										if(Activated == 15 && !knocked) H:Elbow_X(M)
										if(Activated == 16 && !knocked) H:Rockfall_X(M)
										if(Activated == 20 && !knocked) H:Absorb_Chakra_X(M)
										if(Activated == 21 && !knocked) H:Sensatsu_Suisho_X(M)
										if(Activated == 22 && !knocked) H:Demonic_Mirrors_X(M)
										if(Activated == 23 && !knocked) H:Ice_Spike_Explosion_X(M)
										if(Activated == 30 && !knocked) H:Fire_Stream_X(M)
										if(Activated == 31 && !knocked) H:Water_Stream_X(M)
										if(Activated == 696 && !knocked) H:Sharingan_Genjutsu_X(M)
										if(Activated == 777 && !knocked) H:Chakra_Implosion_X(M)
										if(Activated == 888 && !knocked) H:Sanbi_Hand_X(M)
										if(Activated == 35 && !knocked) H:Claws_X(M)
										if(Activated == 69 && !knocked) H:Beast_Tearing_Gale_Scratch_X(M)
										if(Activated == 85 && !knocked) H:Lava_Shoot_X(M)
										if(Activated == 697 && !knocked) H:Susanoo_Crushing_Grip_X(M)
										if(Activated == "Snake Swamp" && !knocked) H:Underground_Snake_Swamp_X(M)
										if(Activated == 1969 && !knocked) H:Special_Combo_E1_X(M)
										if(Activated == 9742 && !knocked) H:Scythe_Summoning_(M)
										if(Activated == 1970 && !knocked) H:Chibaku_Tensei_X(M)
										if(Activated == 1971 && !knocked) H:Special_Combo_SA_X(M)

									if(name == "Dosu")
										switch(rand(1,4))
											if(4) M.Quake_Effect_X(3)
									if(name == "Sasori" || name == "(Puppet Body) Sasori" || name == "Hiruko" || name == "Torune")
										if(M.knocked || !AllowedPoison || M.Poison_Immunity) continue
										if(prob(25)) M.Poison_Proc(3, name)
							else
								Can_Grab = 0
								spawn(55) Can_Grab = 1
								M.density = 0
								M.Dragonned = 1
								M.freeze ++
								Dragonned = 1
								spawn(9) Dragonned = 0
								M.alpha = 175
								M.Damage(src, damage, 0, 0, 0, 1)
								if(dir == EAST)
									M.set_pos (px +116, py +56)
									spawn(1.5) M.set_pos (px +108, py +66)
									spawn(3)
										M.dir = EAST
										M.set_pos (px +64, py +58)
									spawn(4.5) M.set_pos (px -12, py +2)
									spawn(6.75)
										M.alpha = 255
										M.set_pos (px -12, py +4)
										M.density = 1
										M.Dragonned = 0
										M.freeze --
										M.stop()
										M.Damage(src, damage/1.75, 1, 2, 0, 1, 0, 0, 1)
								else
									M.set_pos (px -72, py +56)
									spawn(1.5) M.set_pos (px -60, py +66)
									spawn(3)
										M.dir = WEST
										M.set_pos (px -10, py +54)
									spawn(4.5) M.set_pos (px +78, py +2)
									spawn(6.75)
										M.alpha = 255
										M.set_pos (px +78, py +4)
										M.density = 1
										M.Dragonned = 0
										M.freeze --
										M.stop()
										M.Damage(src, damage*1.25, 1, 2, 0, 1, 0, 0, 1)


						if(M.Dodging)
							M.Auto_Dodge(src)
							continue

mob/proc/Suigetsu_Punch (var/P)
	for(var/obj/Effects/Suigetsu_Attack/S in Overlays) del(S)
	if(P == "punch1") new/obj/Effects/Suigetsu_Attack/I (loc, src)
	else if(P == "punch2") new/obj/Effects/Suigetsu_Attack/II (loc, src)
	else if(P == "punch3") new/obj/Effects/Suigetsu_Attack/III (loc, src)
	else if(P == "punch4") new/obj/Effects/Suigetsu_Attack/IV (loc, src)
	else if(P == "punch5") new/obj/Effects/Suigetsu_Attack/V (loc, src)
	else if(P == "airpunch") new/obj/Effects/Suigetsu_Attack/VI (loc, src)

mob/proc/Bijuu_Punch (var/P)
	for(var/obj/Effects/Bijuu_Attack/S in Overlays) del(S)
	if(P == "punch1") new/obj/Effects/Bijuu_Attack/I (loc, src)
	else if(P == "punch2") new/obj/Effects/Bijuu_Attack/II (loc, src)
	else if(P == "punch3") new/obj/Effects/Bijuu_Attack/III (loc, src)
	else if(P == "punch4") new/obj/Effects/Bijuu_Attack/IV (loc, src)
	else if(P == "punch5") new/obj/Effects/Bijuu_Attack/II (loc, src)
	else if(P == "grab") new/obj/Effects/Bijuu_Attack/V (loc, src)
	else if(P == "airpunch") new/obj/Effects/Bijuu_Attack/VI (loc, src)

mob/proc/Fight()
	..()
	var/T = 3
	loop
		if(!T) Can_Attack_ = 1
		else
			T--
			Can_Attack_ = 0
			spawn(2) goto loop

mob/proc/Crow(mob/Enemy)
	if(name == "Itachi")
		for(var/obj/Jutsus/Crow_Genjutsu_Itachi/J in Jutsus) spawn() J.Delay(5)
		new/obj/Special_Effect/Itachi (src, 1)
		Crow = 0
		invisibility = 101
		Dragonned = 1
		density = 0
		freeze ++
		spawn(3)
			Teleport_Behind_NS (Enemy, src)
			invisibility = 0
			Dragonned = 0
			density = 1
			freeze --
			stop()
	else if(name == "Konan")
		for(var/obj/Jutsus/Paper_Clone/J in Jutsus) spawn() J.Delay(5)
		new/obj/Special_Effect/Konan (src, 1)
		Crow = 0
		invisibility = 101
		Dragonned = 1
		density = 0
		freeze ++
		spawn(4)
			Teleport_Behind_NS (Enemy, src)
			invisibility = 0
			density = 1
			spawn(4) Dragonned = 0
			spawn(3.5)
				freeze --
				stop()
	else if(name == "Shisui")
		for(var/obj/Jutsus/Body_Flicker/J in Jutsus) spawn() J.Delay(5)
		new/obj/Special_Effect/Shisui (src, 1)
		Crow = 0
		invisibility = 101
		Dragonned = 1
		density = 0
		freeze ++
		spawn(4)
			Teleport_Behind_NS (Enemy, src)
			invisibility = 0
			density = 1
			spawn(4) Dragonned = 0
			spawn(3.5)
				freeze --
				stop()
	else if(name == "Sai")
		for(var/obj/Jutsus/Ink_Clone/J in Jutsus) spawn() J.Delay(5)
		for(var/obj/Jutsus/Ink_Snake/J in Jutsus) spawn() J.Delay(3)
		new/obj/Special_Effect/Sai (src, 1)
		Crow = 0
		invisibility = 101
		Dragonned = 1
		density = 0
		freeze ++
		spawn(5.5)
			Teleport_Behind_NS (Enemy, src)
			invisibility = 0
			density = 1
			new/obj/Effects/Sai_II (loc, src)
			spawn(3)
				Dragonned = 0
				freeze --
				stop()
	else if(name == "Shino")
		for(var/obj/Jutsus/Bug_Clone/J in Jutsus) spawn() J.Delay(5)
		new/obj/Special_Effect/Shino (src, 1)
		Crow = 0
		invisibility = 101
		Dragonned = 1
		density = 0
		freeze ++
		spawn(4.25)
			Teleport_Behind_NS (Enemy, src)
			invisibility = 0
			density = 1
			spawn(1.75)
				Dragonned = 0
				freeze --
				stop()
	else
		for(var/obj/Jutsus/Suika/J in Jutsus) spawn() J.Delay(15)
		flick("Water", src)
		Crow = 0
		Dragonned = 1
		density = 0
		freeze ++
		spawn(4.70)
			invisibility = 101
			Teleport_Behind_Suigetsu (Enemy, src)
			if(Enemy.Dodging == 1)
				Enemy.Auto_Dodge (src)
				src<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[Enemy.name] managed to dodge your jutsu!"
			else
				new/obj/Effects/Suigetsu_Water (Enemy.loc, Enemy)
				spawn(0.75) Enemy.Damage(src, 10+rand(0, 5), 1, 1)
			spawn(2.5)
				flick("Return", src)
				invisibility = 0
				spawn(5.6)
					density = 1
					Dragonned = 0
					freeze --
					stop()


mob/proc/Attacking_(var/T)
	Attacking = 1
	spawn(T)
		Attacking = 0
		stop()

mob/var/Punch_Animation = 0