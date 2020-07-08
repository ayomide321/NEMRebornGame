var/Healers_Leaf = 0
var/Healers_Akatsuki = 0
var/mob/Juggernaut
mob/var
	New_To_Us = 2
	Juggernaut_Points = 0
	Energy_Recover = 1
	Speed_Multiplier_X = 0
	Healer_Character = 0
	Can_Revive = 1
	knocked=0
	Dome=0
	Doming=0
	ultra_speed=0
	speed_multiplier=1
	OnWall = 0
	WallJump = 0
	CanUseAmat = 1
	KOs = 0
	KOd = 0
	WereDodging
	Chat = 1
	Body_Offline = 0
	HP_Regened = 0
	Cha_Regened = 0
	Energy_Regened = 0
	HP_Rewarded = 0
	Cha_Rewarded = 0
	Energy_Rewarded = 0


mob/proc/Eternal_Sasuke_Special()
	if(name == "Eternal Sasuke") spawn(5) Eternal_Sasuke_Special()
	if(!Shield_) overlays -= 'Graphics/Skills/Susanoo Shield.dmi'
	if(Shield_ == 1)
		Cha -= 2.75
		Str = 15.25
		Dragonned = 1
		Regenerate_Chakra = 0
		if(src.Cha <= 0)
			src<<output("<b><font color=#10C8FF><u>Susanoo's Shield has vanished!</u></font></b>","Chat")
			overlays -= 'Graphics/Skills/Susanoo Shield.dmi'
			Regenerate_Chakra = 1
			Str = 13.75
			Dragonned = 0
			Cha = 0
			Shield_ = 0

mob/proc/Rinnegan_Tobi_Special()
	if(name == "Rinnegan Tobi" || name == "Tobi") spawn(5) Rinnegan_Tobi_Special()
	else
		Substitution = 0
		Dragonned = 0
		Can_Attack_ = 1
		Regenerate_Chakra = 1
		density = 1
		alpha = 255
		Intangible = 0
		return

	if(Substitution == 2)
		alpha = 175
		src.Cha -= 2
		density = 0
		Intangible = 1
		Dragonned = 1
		Can_Attack_ = 0
		Regenerate_Chakra = 0
		if(knocked || Cha <= 0)
			alpha = 255
			src<<output("<b><font color=#10C8FF><u>Your body is no longer intangible!</u></font></b>","Chat")
			Can_Attack_ = 1
			Regenerate_Chakra = 1
			Dragonned = 0
			Substitution = 0
			src.Cha = 0
			if(!knocked) density = 1
			Intangible = 0


mob/var/Shield_ = 0
mob/var/Intangible_CD = 0
mob/var/Intangible = 0


mob/var/Attacked_ = 0

mob/proc/Attacked(var/T, var/G)
	if(!G || G && Attacked_ <= 15) Attacked_ += T/3

mob/proc/Recover()
	set background = 1
	src.Recovering = 1
	spawn(3) Recover()
	if(z == 8) if(Kamui == 0) src.Auto_Spawn()
	if(Kamui == 1)
		if(z != 8)
			src<<"<b><font color=red><font size=2><u>Don't cheat!"
			for(var/obj/Tobi/T in world)
				var/N = new/obj/Portal ()
				N:loc = T.loc
				src.loc = T.loc
				if(dir == EAST)
					N:dir = EAST
					src.knockbackeast()
				if(dir == WEST)
					N:dir = WEST
					src.knockbackwest()

	if(Cha < 0) Cha = 0
	if(Energy < 0) Energy = 0

	if(Using_Sand_Shield || !On_Wall && !GoingSage && on_ground && !Boulder && !BoulderX && !Gates && !Controlling && !Attacking && !Attacked && !knockback && !knocked && !freeze && !Dashing)

		if(!Attacked && !Attacking)
			var/HP_Rate = HP /18.5
			var/Cha_Rate = Cha /19
			var/Energy_Rate = Energy /14.5
			HP_Rate *= HP_Boost
			if(Explosing) Cha_Rate /= 4
			if(Using_Sand_Shield)
				HP_Rate /= 2.5
				Energy_Rate = 4.25
			if(Venomous_Clone)
				HP_Rate /= 2.25
				Cha_Rate /= 2.25
				Energy_Rate /= 2.25
			if(Edo)
				HP_Rate /= 2.5
				Cha_Rate /= 1.50
				Energy_Rate /= 1.50
			if(Byakugan || Sharingan || Rinnegan)
				HP_Rate /= 3.75
				Cha_Rate /= 4.25
				Energy_Rate /= 3
				if(HP_Rate < 1.35) HP_Rate = 1.35
				if(Cha_Rate < 1) Cha_Rate = 1
				if(Energy_Rate < 2) Energy_Rate = 2
			if(Kyuubi)
				HP_Rate /= 15
				Cha_Rate /= 10
				Energy_Rate /= 5
			if(name == "Hiruko")
				HP_Rate /= 3
				Energy_Rate /= 2
			if(Round_GoingOn == 1) HP_Rate /= 1.75
			if(Round_GoingOn == 1) Cha_Rate /= 1.75
			if(HP_Rate > 3) HP_Rate = 3
			if(Cha_Rate > 2.85) Cha_Rate = 2.85
			if(Energy_Rate > 3.75) Energy_Rate = 3.75
			if(HP_Rate < 1.45 *HP_Boost) HP_Rate = 1.45 *HP_Boost
			if(Cha_Rate < 1.05) Cha_Rate = 1.05
			if(Energy_Rate < 1.75) Energy_Rate = 1.75
			if(vel_x) {HP_Rate /= 1.65; Cha_Rate /= 1.65; Energy_Rate = 1.65}
			if(running == 1) {HP_Rate /= 1.75; Cha_Rate /= 1.75; Energy_Rate = 0}

			if(Boss == 1) HP_Rate = 0.5
			if(Active_Assist) Check_Assist(HP_Rate)
			if(Choji_Pill == "Curry" && running) HP_Rate = 0
			if(HP < MaxHP && Poison == 0 && !Amaterasu && !No_HP_Regen) src.HP+=HP_Rate
			if(Energy < MaxEnergy && Energy_Recover >= 1) src.Energy+=Energy_Rate
			if(Levitating == 0 && Cha < MaxCha && Regenerate_Chakra >= 1 && !Using_Sand_Shield) src.Cha+=Cha_Rate
			if(HP != MaxHP) src.HP_Regened += HP_Rate
			if(Cha != MaxCha && Regenerate_Chakra >= 1 && !Using_Sand_Shield) src.Cha_Regened += Cha_Rate
			if(Energy != MaxEnergy && Energy_Recover >= 1) src.Energy_Regened += Energy_Rate
			if(HP > MaxHP) HP = MaxHP
			if(Cha > MaxCha) Cha = MaxCha
			if(Energy > MaxEnergy) Energy = MaxEnergy

			if(density != 1 && !knocked) density = 1
mob/proc/Dodge()
		Flick("teleport",src)
		src.vel_y=10
		Flick("teleport",src)
mob/var/Rasenshuriken_Effect = 0
mob/proc/Rasenshuriken_Effect(var/Owner)
	..()
	Rasenshuriken_Effect = 1
	freeze ++
	new/obj/Rasenshuriken (src.loc, Owner)
mob/proc/Rasenshuriken_EffectX(var/Owner, var/Dir)
	..()
	src.Rasenshuriken_Effect = 1
	src.freeze ++
	new/obj/RasenshurikenX (src.loc, Owner, Dir)
var/WarningTo
var/Voter
var/VoteType
var/VoteReason
var/Votations=1
var/VotationGoingOn=0
var/admin_color="#94E0FA"
mob/var/Accept_Votes=1
mob/var/Abuser=0
mob/var/CreatedAVotation=0
var/HealRound = 1

obj/proc
	Kusanagi()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor<<"<b><font color=#A24E94><u>Press X to destroy the Kusanagi.</b></u></font>"
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Kusanagi!")
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 1
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/Kusanagi/Kusanagi (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Village = Executor.Village
		A:dir = Executor.dir
		A:Owner = Executor
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --
	KusanagiX()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor<<"<b><font color=#A24E94><u>Press X to destroy the Kusanagi.</b></u></font>"
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Kusanagi!")
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 1
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/KusanagiX/Kusanagi (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Owner = Executor
		A:Village = Executor.Village
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --
	Crow_Puppet_Summon()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 30) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor.freeze ++
		Flick("scroll", Executor)
		sleep(5)
		Executor.freeze --
		Executor.stop()
		Executor<<"<b><font color=#9A9A9A><u>Press X to destroy the Crow Puppet.</b></u></font>"
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Crow Puppet!")
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 1
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/CrowPuppet/CrowPuppet (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Owner = Executor
		A:Village = Executor.Village
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --
	Sasori_Puppet_Summon()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 30) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor.freeze ++
		Flick("scroll", Executor)
		sleep(5)
		Executor.freeze --
		Executor.stop()
		Executor<<"<b><font color=#9A9A9A><u>Press X to destroy the Sasori.</b></u></font>"
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Sasori!")
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 1
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/SasoriP/SasoriP (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Owner = Executor
		A:Village = Executor.Village
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --
	Salamander_Puppet_Summon()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 30) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor.freeze ++
		Flick("scroll", Executor)
		sleep(5)
		Executor.freeze --
		Executor.stop()
		Executor<<"<b><font color=#9A9A9A><u>Press X to destroy the Salamander Puppet.</b></u></font>"
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Salamander Puppet!")
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 1
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/Salamander/Salamander (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Owner = Executor
		A:Village = Executor.Village
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --

	Mind_Body_Switch_Technique()
		var/mob/Executor = usr
		src.Executed_Fully = 1
		if(Executor._CD) return
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 120)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(30)
			Target++
			Executor.Execute_Jutsu("Mind Body Switch Technique!")
			Flick("Seals", Executor)
			Executor.Executed_Fully = 1
			Executor.Dragonned = 1

			spawn(3.75)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

			M.freeze ++
			M.Dragonned = 1
			var/obj/C = new/obj/Effects/Fuu_Special (M.loc, M, M.dir)
			var/T = 0
			loop
				T++
				if(T > 17)
					if(C) Flick("End", C)
					spawn(10)
						M.freeze --
						M.Dragonned = 0
						M.stop()
						if(C) C.loc = M.loc
				else
					C.loc = M.loc
					M.icon_state = "mob-standing"
					M.Dragonned = 1
					M.stop()
					spawn(5) goto loop


		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Ninken()
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
				for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(5)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			var/Damage = 7
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(5)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Doton_Fist/K in Executor) K.Delay(7)
			for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(7)
			for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(7)
			for(var/obj/Jutsus/Raikiri/L in Executor.Jutsus) L.Delay(5)
			for(var/obj/Jutsus/Chidori_Kakashi/L in Executor.Jutsus) L.Delay(5)
			Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Ninja Hounds!")
			Flick("mob-shooting", Executor)

			spawn(7)
				new/obj/Effects/Ninken_I (Executor.loc, Executor)
				Executor.Dragonned = 1
				M.Dragonned = 1
				spawn(9.5)
					new/obj/Effects/Ninken_II (M.loc, M)
					M.Dragonned = 1
					spawn(1.25) M.Damage(Executor, Damage, 0, null, null, 1)
					spawn(4.25) M.Damage(Executor, Damage, 0, null, null, 1)
					spawn(7.25) M.Damage(Executor, Damage, 0, null, null, 1)
					spawn(12.25) M.Damage(Executor, Damage, 0, null, null, 1)
					spawn(15.25) M.Damage(Executor, Damage, 0, null, null, 1)
					spawn(18.25) M.Damage(Executor, Damage, 1, null, null, 1)
					spawn(30)
						Flick("teleport", Executor)
						Executor.Dragonned = 0
						Executor.CanMove = 1
						Executor.freeze --
						Executor.stop()
						M.Dragonned = 0
						M.CanMove = 1
						M.freeze --
						M.stop()

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()


	Water_Prison_()
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
				for(var/obj/Jutsus/Water_Palm_/J in Executor) J.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Water_Palm_/J in Executor) J.Delay(10)
			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_Suigetsu(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Executor.Execute_Jutsu("Water Release.- Prison!")
			Flick("Water Prison", Executor)
			sleep(2)
			Executor.layer = 201
			var/A = new/obj/Water_Prison (M.loc)
			A:pixel_x = M.pixel_x
			A:pixel_y = M.pixel_y
			M.Dodging = 0
			spawn(4.5)
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
			M.stop()
			spawn(5)
				M.invisibility = 101
				M.stop()
				M.HP -= 11.5
				new/obj/Hit(M.loc)
				Flick("hurt", M)
				spawn(3.5)
					M.stop()
					M.HP -= 11.5
					new/obj/Hit(M.loc)
					Flick("hurt", M)
					spawn(3.5)
						M.HP -= 11.5
						M.stop()
						new/obj/Hit(M.loc)
						Flick("hurt",M)
						M.Death_Check(Executor)
						spawn(19)
							Executor.layer = 100
							M.Dragonned = 0
							M.invisibility = 0
							M.CanMove = 1
							M.freeze --
							M.stop()

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()


	Water_Prison()
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
				for(var/obj/Jutsus/Summoning_Sharks/J in Executor) J.Delay(5)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Summoning_Sharks/J in Executor) J.Delay(10)
			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Executor.Execute_Jutsu("Water Release.- Prison!")
			if(Executor.name != "(UnCloaked) Kisame") Flick("mob-shooting", Executor)
			else Flick("mob-seals", Executor)
			sleep(3)
			Executor.layer = 201
			var/A = new/obj/Water_Prison (M.loc)
			A:pixel_x = M.pixel_x
			A:pixel_y = M.pixel_y
			M.Dodging = 0
			spawn(5)
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
			M.stop()
			spawn(5)
				M.invisibility = 101
				M.stop()
				M.HP -= 11.5
				new/obj/Hit(M.loc)
				Flick("hurt", M)
				spawn(3.5)
					M.stop()
					M.HP -= 11.5
					new/obj/Hit(M.loc)
					Flick("hurt", M)
					spawn(3.5)
						M.HP -= 11.5
						M.stop()
						new/obj/Hit(M.loc)
						Flick("hurt",M)
						M.Death_Check(Executor)
						spawn(19)
							Executor.layer = 100
							M.Dragonned = 0
							M.invisibility = 0
							M.CanMove = 1
							M.freeze --
							M.stop()

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Shukaku_Claw()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Sand_Crush/K in Executor) K.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Sand_Crush/K in Executor) K.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(20)
			for(var/obj/Jutsus/Sand_Crush/K in Executor) K.Delay(7)
			Flick("Crush", Executor)

			sleep(2)
			Executor.Execute_Jutsu("Shukaku Claw!")

			spawn(6)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

			new/obj/Effects/Shukaku_Claw (M.loc, M)
			var/Damage = 40+rand(0, 10)
			spawn(3.5)
				M.freeze --
				M.Dragonned = 0
				M.stop()
				M.Damage(Executor, Damage, 1, 2)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Striking_Shadow_Snakes()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				Executor.Activated = 0
				for(var/obj/Jutsus/Underground_Snake_Swamp/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Snake_Summoning/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Snake_Grasp/J in Executor) J.Delay(10)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				Executor.Activated = 0
				for(var/obj/Jutsus/Underground_Snake_Swamp/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Snake_Summoning/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Snake_Grasp/J in Executor) J.Delay(10)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			Executor.Activated = 0
			for(var/obj/Jutsus/Underground_Snake_Swamp/J in Executor) J.Delay(10)
			for(var/obj/Jutsus/Snake_Summoning/J in Executor) J.Delay(13)
			for(var/obj/Jutsus/Snake_Grasp/J in Executor) J.Delay(13)
			Flick("Crush", Executor)
			sleep(1.5)
			Executor.Execute_Jutsu("Striking Shadow Snakes!")

			new/obj/Effects/Striking_Snakes (Executor.loc, Executor)
			spawn(9.05)
				M.Poison_Proc(10, Executor.name)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Executor, 40, 1, 2)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()

	Sand_Crush()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Shukaku_Claw/K in Executor) K.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Shukaku_Claw/K in Executor) K.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Shukaku_Claw/K in Executor) K.Delay(7)
			Flick("Crush", Executor)

			sleep(1.5)
			Executor.Execute_Jutsu("Sand Release.- Crush!")

			spawn(12)
				M.freeze --
				M.Dragonned = 0
				M.stop()
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

			new/obj/Effects/Sand_Crush (M.loc, M)
			var/Damage = 12.5
			spawn(5) M.Damage(Executor, Damage, 1, 0)
			spawn(7) M.Damage(Executor, Damage, 1, 0)
			spawn(9) M.Damage(Executor, Damage, 1, 0)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Insect_Sphere()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 35) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Executor.invisibility = 0
			Executor.Execute_Jutsu("Insect Sphere!")

			spawn(6.25)
				M.freeze --
				M.Dragonned = 0
				M.stop()

			new/obj/Effects/Insect_Sphere (Executor.loc, Executor)
			spawn(4)
				var/Damage = 30+rand(0, 10)
				M.Damage(Executor, Damage, 1, 0)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Heat_Explosion()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(90)
		for(var/obj/Jutsus/Wood_Stab/W in Executor) W.Delay(7)
		for(var/obj/Jutsus/Wood_Dragon/W in Executor) W.Delay(7)
		Flick("mob-shooting", Executor)
		Executor.freeze ++
		Executor.stop()
		sleep(3)
		Executor.Execute_Jutsu("Heat Explosion!")
		new/obj/Effects/Madara_H (Executor.loc, Executor)
		var/_Target_
		spawn(7)
			for(var/obj/Jutsus/J in src) J.Delay(5)
			Executor.freeze --
			Executor.stop()
		sleep(2.5)
		for(var/mob/M in view(Executor, 7))
			if(M == src || !M.Real || M.Village == Executor.Village || M.Dragonned || M.knocked) continue
			_Target_ ++
			Executor.Executed_Fully = 1
			var/Damage = 50+rand(0, 20)
			M.Damage(Executor, Damage, 1, 2, 0, 1, 0, 1)
		if(_Target_) Executor.Damage_Up(50+rand(0, 20))

	Fatal_Bite()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 45) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Devouring_Snakes/W in Executor) W.Delay(5)
				for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(3)
				for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(3)
				for(var/obj/Jutsus/Killing_Snakes/W in Executor) W.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_KC(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Devouring_Snakes/W in Executor) W.Delay(5)
				for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(3)
				for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(3)
				for(var/obj/Jutsus/Killing_Snakes/W in Executor) W.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Devouring_Snakes/W in Executor) W.Delay(7)
			for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(5)
			for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(5)
			for(var/obj/Jutsus/Killing_Snakes/W in Executor) W.Delay(10)
			Executor.Execute_Jutsu("Fatal Bite!")
			new/obj/Effects/Fatal_Bite (Executor.loc, Executor)
			var/Damage = 30+rand(0, 15)
			spawn(7.5)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Executor, Damage, 1, 2, 0, 1)
				M.Poison_Proc(5, Executor.name)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Killing_Snakes()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 70) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Devouring_Snakes/W in Executor) W.Delay(5)
				for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(3)
				for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(3)
				for(var/obj/Jutsus/Fatal_Bite/W in Executor) W.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Devouring_Snakes/W in Executor) W.Delay(5)
				for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(3)
				for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(3)
				for(var/obj/Jutsus/Fatal_Bite/W in Executor) W.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(20)
			for(var/obj/Jutsus/Devouring_Snakes/W in Executor) W.Delay(7)
			for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in Executor) W.Delay(5)
			for(var/obj/Jutsus/Earthquake_K/W in Executor) W.Delay(5)
			for(var/obj/Jutsus/Fatal_Bite/W in Executor) W.Delay(10)
			Executor.Execute_Jutsu("Killing Snakes!")
			new/obj/Effects/Killer_Snakes (Executor.loc, Executor)
			var/Damage = 40+rand(0, 15)
			spawn(5.6) M.Damage(Executor, Damage /2.5, 0, 0, 0, 1)
			spawn(7.2)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Executor, Damage /1.55, 1, 2, 0, 1)
				M.Poison_Proc(7, Executor.name)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Wood_Dragon()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 120, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Wood_Stab/W in Executor) W.Delay(7)
				for(var/obj/Jutsus/Log_Summoning/P in Executor.Jutsus) spawn() P.Delay(5)
				for(var/obj/Jutsus/Mokuton_Daijurin_no_Jutsu/J in Executor) spawn() J.Delay(7)
				for(var/obj/Jutsus/Special_Attack/J in Executor) spawn() J.Delay(7)
				Executor.Activated = 0
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind__(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Wood_Stab/W in Executor) W.Delay(7)
				for(var/obj/Jutsus/Log_Summoning/P in Executor.Jutsus) spawn() P.Delay(5)
				for(var/obj/Jutsus/Mokuton_Daijurin_no_Jutsu/J in Executor) spawn() J.Delay(7)
				for(var/obj/Jutsus/Special_Attack/J in Executor) spawn() J.Delay(7)
				Executor.Activated = 0
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(20)
			for(var/obj/Jutsus/Log_Summoning/P in Executor.Jutsus) spawn() P.Delay(7)
			for(var/obj/Jutsus/Mokuton_Daijurin_no_Jutsu/J in Executor) spawn() J.Delay(10)
			for(var/obj/Jutsus/Special_Attack/J in Executor) spawn() J.Delay(10)
			Executor.Activated = 0
			for(var/obj/Jutsus/Wood_Stab/W in Executor) W.Delay(10)
			Flick("mob-shooting", Executor)

			sleep(3)
			Executor.Execute_Jutsu("Wood Release.- Dragon!")

			new/obj/Effects/Madara_WW (M.loc, M)
			var/Damage = 50+rand(0, 15)
			spawn(6.25) M.Damage(Executor, Damage, 1, 0, 0, 1)
			spawn(14)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				M.Dragonned = 0
				M.freeze --
				M.stop()

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Wood_Stab()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 100, 80)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Wood_Dragon/W in Executor) W.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Wood_Dragon/W in Executor) W.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Wood_Dragon/W in Executor) W.Delay(10)
			Flick("mob-shooting", Executor)

			sleep(3)
			Executor.invisibility = 101
			Executor.Execute_Jutsu("Wood Release.- Stab!")

			new/obj/Effects/Madara_W (Executor.loc, Executor)
			var/Damage = 30+rand(0, 10)
			spawn(0.75)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Executor, Damage, 1, 2, 0, 1)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Flame_Battle_Encampment()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 100, 80)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Flame_Imprisonment/F in Executor) F.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Flame_Imprisonment/F in Executor) F.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(20)
			for(var/obj/Jutsus/Flame_Imprisonment/F in Executor) F.Delay(10)
			Flick("katon", Executor)

			sleep(3)
			Executor.Execute_Jutsu("Flame Battle Encampment!")

			spawn(12)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

			new/obj/Effects/Tobi_Flame (M.loc, M)
			var/Damage = 10+rand(1, 3)
			spawn(3) M.Damage(Executor, Damage, 1, 0, 0, 1)
			spawn(5) M.Damage(Executor, Damage, 1, 0, 0, 1)
			spawn(7) M.Damage(Executor, Damage, 1, 0, 0, 1)
			spawn(9) M.Damage(Executor, Damage, 1, 0, 0, 1)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Kyuubi_Hand_Crush()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 120)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(15)
				for(var/obj/Jutsus/Kyuubi_Slash_Naruto/W in Executor) W.Delay(10)
				for(var/obj/Jutsus/Kyuubi_Rasengan/W in Executor) W.Delay(5)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(15)
				for(var/obj/Jutsus/Kyuubi_Slash_Naruto/W in Executor) W.Delay(10)
				for(var/obj/Jutsus/Kyuubi_Rasengan/W in Executor) W.Delay(5)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(20)
			for(var/obj/Jutsus/Kyuubi_Slash_Naruto/W in Executor) W.Delay(15)
			for(var/obj/Jutsus/Kyuubi_Rasengan/W in Executor) W.Delay(5)
			Executor.invisibility = 101
			new/obj/Effects/Kyuubi_Hand_Crush (Executor.loc, Executor)
			Flick("mob-shooting", Executor)
			Executor.Execute_Jutsu("Kyuubi Hand Crush!")
			var/Damage = 40+rand(0, 15)
			spawn(5)
				Executor.Dragonned = 1
				M.Dragonned = 1
			spawn(7.25)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.vel_y = 10
				M.Damage(Executor, Damage, 1, 2)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Kyuubi_Claw()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 120)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Kyuubi_Hand_Crush/W in Executor) W.Delay(7)
				for(var/obj/Jutsus/Kyuubi_Rasengan/W in Executor) W.Delay(5)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Kyuubi_Hand_Crush/W in Executor) W.Delay(7)
				for(var/obj/Jutsus/Kyuubi_Rasengan/W in Executor) W.Delay(5)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Kyuubi_Rasengan/W in Executor) W.Delay(5)
			for(var/obj/Jutsus/Kyuubi_Hand_Crush/W in Executor) W.Delay(10)
			Executor.invisibility = 101
			new/obj/Effects/Kyuubi_Claw (Executor.loc, Executor)
			Flick("mob-shooting", Executor)
			Executor.Execute_Jutsu("Kyuubi Claw!")
			var/Damage = 20+rand(0, 7)
			spawn(2)
				M.Dragonned = 1
				M.Damage(Executor, Damage, 1, 2)
			spawn(2.5)
				if(Executor.dir == EAST) M.px -= 2
				if(Executor.dir == WEST) M.px += 2
				M.step_x = M.px - M.x * icon_width
				var/T = 0
				loop
					if(T < 4.75)
						T += 0.25
						if(Executor.dir == EAST && abs(M.px - Executor.px) > 10) M.px -= 2
						if(Executor.dir == WEST && abs(M.px - Executor.px) > 10) M.px += 2
						M.step_x = M.px - M.x * icon_width
						spawn(0.25) goto loop
					else
						M.Dragonned = 0
						M.freeze --
						M.stop()
						M.Damage(Executor, Damage*1.25, 1, 2)
						return

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Ash_Pile_Burning()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/S in Executor) S.Delay(3)
				for(var/obj/Jutsus/Flying_Swallow/A in Executor) A.Delay(4)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/S in Executor) S.Delay(3)
				for(var/obj/Jutsus/Flying_Swallow/A in Executor) A.Delay(4)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(17)
			for(var/obj/Jutsus/S in Executor) S.Delay(7)
			for(var/obj/Jutsus/Flying_Swallow/A in Executor) A.Delay(6)
			Flick("Katon", Executor)
			Executor.icon_state = "Katon"
			Executor.Doming = 1

			sleep(3.5)
			Executor.Execute_Jutsu("Fire Release.- Ash Pile Burning!")
			new/obj/Effects/Asuma_F (M.loc, M)

			spawn(19)
				Executor.Doming = 0
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

			spawn(5.15) M.Damage(Executor, 15+rand(0, 5), 1, 0)
			spawn(8.65) M.Damage(Executor, 20, 1, 0)
			spawn(12.15)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Executor, 20+rand(0, 5), 1, 0)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Flying_Swallow()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 160, 120)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/S in Executor) S.Delay(3)
				for(var/obj/Jutsus/Ash_Pile_Burning/A in Executor) A.Delay(4)
				Executor.Activated = 0
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/S in Executor) S.Delay(3)
				for(var/obj/Jutsus/Ash_Pile_Burning/A in Executor) A.Delay(4)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(13)
			for(var/obj/Jutsus/S in Executor) S.Delay(7)
			for(var/obj/Jutsus/Ash_Pile_Burning/A in Executor) A.Delay(6)

			Executor.Execute_Jutsu("Flying Swallow!")
			Flick("Special Jutsu", Executor)

			spawn(3)
				M.input_lock = 1
				M.freeze --
				M.stop()
				M.vel_y = 8
				M.Damage(Executor, 20, 0, 2, 0, 1)
			//	M.vel_y = 18

			sleep(10.5)

			Executor.density = 0
			var/F = new/obj/Effects/Flying_Swallow (Executor.loc, Executor)
			spawn(3.75)
				M.Damage(Executor, 25+rand(0, 5), 1, 2, 0, 1)
				M.Dragonned = 0
				M.input_lock = 0
			while(F && M.loc)
				if(Executor.dir == EAST) Executor.set_pos(M.px, M.py)
				else Executor.set_pos(M.px, M.py)
				sleep(0.40)
			flick("teleport", Executor)
			Executor.set_pos(M.px, M.py)
			Executor.vel_x = M.vel_x
			Executor.vel_y = -6
			spawn(2.5) Executor.density = 0

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()

	Jyuuken_Fury()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 160, 120)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Jyuuken_Shinan/K in Executor) K.Delay(7)
				for(var/obj/Jutsus/Hakke_Juushou/K in Executor) K.Delay(5)
				Executor.Activated = 0
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.invisibility = 101
			Executor.Teleport_Behind_Close_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Jyuuken_Shinan/K in Executor) K.Delay(7)
				for(var/obj/Jutsus/Hakke_Juushou/K in Executor) K.Delay(5)
				Executor.Activated = 0
				Executor.invisibility = 0
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(20)
			for(var/obj/Jutsus/Jyuuken_Shinan/K in Executor) K.Delay(15)
			for(var/obj/Jutsus/Hakke_Juushou/K in Executor) K.Delay(10)
			Executor.Activated = 0
			new/obj/Effects/Hanabi_Special_I (Executor.loc, Executor)
			Executor.Execute_Jutsu("Jyuuken Fury!")
			var/Damage = 13+rand(0, 1.25)

			spawn(15) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(25) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(32) M.Damage(Executor, Damage, 0, 0, 0, 1)
			spawn(45)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				M.Damage(Executor, Damage*1.65, 1, 0, 0, 1)
				if(Executor.dir == EAST) M.knockbackeastx()
				else M.knockbackwestx()
				spawn(1.5) Executor.Substitution = 0
				return

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()

	Doton_Fist()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 100)
		var/list/Enemy = Bounds.Enemy()
		for(var/mob/M in Enemy)
			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(5)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_Close(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(5)
				for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(5)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Primary_Lotus_Kakashi/K in Executor) K.Delay(7)
			for(var/obj/Jutsus/One_Thousand/K in Executor) K.Delay(7)
			for(var/obj/Jutsus/Ninken/K in Executor) K.Delay(7)
			Executor.invisibility = 1
			new/obj/Effects/Kakashi_Doton (Executor.loc, Executor)
			Executor.Execute_Jutsu("Doton Fist!")

			spawn(1.5)
				var/Damage = 15+rand(0, 7.5)
				M.Damage(Executor, Damage, 0, 0, 0, 1)
				M.py += 2
				M.step_y = M.py - M.y * icon_height
				var/T = 0
				loop
					if(T < 3)
						T += 0.30
						M.py += 2
						M.step_y = M.py - M.y * icon_height
						spawn(0.30) goto loop
					else
						M.stop()
						M.vel_y = 15
						M.Damage(Executor, Damage*1.25, 1, 2, 0, 1)
						M.Dragonned = 0
						M.freeze --
						return

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Great_Breakthrough()
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
				for(var/obj/Jutsus/Snake_Bite/K in Executor) K.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind_(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Snake_Bite/K in Executor) K.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Snake_Bite/K in Executor) K.Delay(10)
			Flick("Fuuton", Executor)

			sleep(3.5)
			Executor.Execute_Jutsu("Wind Release.- Great Breakthrough!")

			spawn(6.9)
				M.freeze --
				M.Dragonned = 0
				M.stop()
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()

			new/obj/Effects/Wind_BT (M.loc, M)
			spawn(3.55)
				var/Damage = 25+rand(0,5)
				M.Damage(Executor, Damage, 1, 2)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

	Snake_Bite()
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
				for(var/obj/Jutsus/Wind_BT/K in Executor) K.Delay(7)
				Executor.freeze --
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Target++
			Executor.Executed_Fully = 1
			Executor.Teleport_Behind(M, Executor)
			M.Can_Dodge_ = 1
			M.freeze ++
			M.Dragonned = 1
			Executor.Dragonned = 1
			sleep(rand(3.75, 4.5))
			M.Can_Dodge_ = 0

			if(M.Dodging == 1)
				Delay(10)
				for(var/obj/Jutsus/Wind_BT/K in Executor) K.Delay(7)
				Executor.Dragonned = 0
				Executor.freeze --
				M.freeze --
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			Delay(15)
			for(var/obj/Jutsus/Wind_BT/K in Executor) K.Delay(7)
			Executor.pixel_y = -1
			if(Executor.dir == EAST) Executor.pixel_x = 43
			if(Executor.dir == WEST) Executor.pixel_x = -59
			Flick("snake", Executor)

			spawn(6)
				Flick("teleport", Executor)
				M.freeze --
				M.Dragonned = 0
				M.stop()
				Executor.Dragonned = 0
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()

			sleep(3)
			var/Damage = 20+rand(0,5)
			M.Poison_Proc(10, Executor.name)
			M.Damage(Executor, Damage, 1, 2)

		spawn()
			if(!Target)
				Flick("teleport", Executor)
				Executor.pixel_x = 0
				Executor.pixel_y = 0
				Executor.freeze --
				Executor.stop()



mob/proc/Tobi_ProcEAST()
	var/T=0
	var/OldSpeed = src.move_speed
	var/Lives = Deaths
	loop
		dir = WEST
		vel_y += 0.25
		if(rand(1,2)) Quake_Effect(1)
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Rinnegan Tobi")
			src.vel_x = 25
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Rinnegan Tobi")
			src.vel_x = 25
			spawn(1)goto loop
		if(src.HbR==0 || T >= 25 || Deaths != Lives)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.Run_Off()
			return
mob/proc/Tobi_ProcWEST()
	var/T=0
	var/OldSpeed = src.move_speed
	var/Lives = Deaths
	loop
		dir = EAST
		vel_y += 0.25
		if(rand(1,2)) Quake_Effect(1)
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Rinnegan Tobi")
			src.vel_x = -20
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Rinnegan Tobi")
			src.vel_x = -20
			spawn(1)goto loop
		if(src.HbR==0 || T >= 25 || Deaths != Lives)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.Run_Off()
			return



mob/proc/Pein_ProcEAST_X(mob/Attacker)
	var/T=0
	var/OldSpeed = src.move_speed
	var/Lives = Deaths
	loop
		dir = WEST
		vel_y ++
		fall_speed=1
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.knockback = 1
			src.vel_x = 20
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = 20
			spawn(1)goto loop
		if(src.HbR==0 || T >= 50 || Deaths != Lives)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.fall_speed = 25
			src.Run_Off()
			return
mob/proc/Pein_ProcWEST_X(mob/Attacker)
	var/T=0
	var/OldSpeed = src.move_speed
	var/Lives = Deaths
	loop
		fall_speed=1
		dir = EAST
		vel_y ++
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = -20
			spawn(1) goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = -20
			spawn(1) goto loop
		if(src.HbR==0 || T >= 50 || Deaths != Lives)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.fall_speed = 25
			src.Run_Off()
			return



mob/proc/Pein_ProcEASTX(mob/Attacker)
	var/T=0
	var/OldSpeed = src.move_speed
	var/Lives = Deaths
	flick("mob-knockback", src)
	loop
		dir = WEST
		vel_y ++
		fall_speed=1
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = 20
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = 20
			spawn(1)goto loop
		if(src.HbR==0 || T >= 50 || Deaths != Lives)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.fall_speed = 25
			src.Run_Off()
			return
mob/proc/Pein_ProcWESTX(mob/Attacker)
	var/T=0
	var/OldSpeed = src.move_speed
	var/Lives = Deaths
	flick("mob-knockback", src)
	loop
		fall_speed=1
		dir = EAST
		vel_y ++
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = -20
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = -20
			spawn(1)goto loop
		if(src.HbR==0 || T >= 50 || Deaths != Lives)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.fall_speed = 25
			src.Run_Off()
			return



mob/proc/Pein_ProcEAST(mob/Attacker)
	var/T=0
	var/OldSpeed = src.move_speed
	var/Lives = Deaths
	flick("mob-knockback", src)
	loop
		dir = WEST
		vel_y ++
		fall_speed=1
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = 20
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = 20
			spawn(1)goto loop
		if(src.HbR==0 || T >= 100 || Deaths != Lives)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.fall_speed = 25
			src.Run_Off()
			return
mob/var/Special_HBR

mob/proc/Pein_ProcWEST(mob/Attacker)
	var/T=0
	var/OldSpeed = src.move_speed
	var/Lives = Deaths
	flick("mob-knockback", src)
	loop
		fall_speed=1
		dir = EAST
		vel_y ++
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = -20
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check(Attacker)
			src.vel_x = -20
			spawn(1)goto loop
		if(src.HbR==0 || T >= 100 || Deaths != Lives)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.fall_speed = 25
			src.Run_Off()
			return
mob/proc/Bomber_ProcEAST()
	var/T=0
	var/OldSpeed = src.move_speed
	loop
		dir = WEST
		src.Special_HBR = 1
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.overlays+='Graphics/Skills/Bomber.dmi'
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Water Bomb's Effects")
			src.vel_x = 30
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Water Bomb's Effects")
			src.vel_x = 30
			spawn(1)goto loop
		if(src.HbR==0 || T >= 35)
			src.Special_HBR = 0
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.overlays-='Graphics/Skills/Bomber.dmi'
			src.Run_Off()
			return
mob/proc/Bomber_ProcWEST()
	var/T=0
	var/OldSpeed = src.move_speed
	loop
		dir = EAST
		src.Special_HBR = 1
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HbR=2
			src.move_speed= 0
			src.overlays+='Graphics/Skills/Bomber.dmi'
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Water Bomb's Effects")
			src.vel_x = -30
			spawn(1)goto loop
		if(src.HbR==2&&T>=1)
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Water Bomb's Effects")
			src.vel_x = -30
			spawn(1)goto loop
		if(src.HbR==0 || T >= 35)
			src.Special_HBR = 0
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.overlays-='Graphics/Skills/Bomber.dmi'
			src.Run_Off()
			return
mob/proc/HbR_ProcEAST()
	var/T=0
	var/OldSpeed = src.move_speed
	loop
		dir = WEST
		if(src.HbR==0&&T==0)
			Dragonned = 1
			if(on_ground) new/obj/DotonEASTXX (src.loc)
			T++
			src.HbR=1
			src.move_speed= 0
			src.overlays+='Graphics/Skills/RasenshurikenExpandE.dmi'
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Rasengan's Effects")
			src.vel_x = 25
			spawn(1)goto loop
		if(src.HbR==1&&T>=1)
			if(on_ground) new/obj/DotonEASTXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Rasengan's Effects")
			src.vel_x = 25
			spawn(1)goto loop
		if(src.HbR==0 || T >= 25)
			Dragonned = 0
			if(on_ground) new/obj/DotonEASTXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.overlays-='Graphics/Skills/RasenshurikenExpandE.dmi'
			src.Run_Off()
			return

mob/proc/HbR_ProcWEST()
	var/T=0
	var/OldSpeed = src.move_speed
	loop
		dir = EAST
		if(src.HbR==0&&T==0)
			if(on_ground) new/obj/DotonWESTXX (src.loc)
			Dragonned = 1
			T++
			src.HbR=1
			src.move_speed= 0
			src.overlays+='Graphics/Skills/RasenshurikenExpandW.dmi'
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Rasengan's Effects")
			src.vel_x = -25
			spawn(1)goto loop
		if(src.HbR==1&&T>=1)
			if(on_ground) new/obj/DotonWESTXX (src.loc)
			T++
			src.HP-=0.1
			src.knockback = 1
			src.Death_Check("Rasengan's Effects")
			src.vel_x = -25
			spawn(1)goto loop
		if(src.HbR==0 || T >= 25)
			Dragonned = 0
			if(on_ground) new/obj/DotonWESTXX (src.loc)
			T=0
			src.move_speed= OldSpeed
			knockback = 0
			vel_x = 0
			HbR = 0
			src.stop()
			src.overlays-='Graphics/Skills/RasenshurikenExpandW.dmi'
			src.Run_Off()
			return



mob/proc/Transform_Proc(var/T, var/Transform, var/Color)
	if(!client) return
	Transformed = 1
	loop
		if(T > 0 && Transformed)
			if(T > 1) Announced("<b><font color=[Color]><u>* [Transform] will last for [T] seconds.</u>", 0, 1)
			else Announced("<b><font color=[Color]><u>* [Transform] will last for [T] second.</u>", 0, 1)

			spawn(10)
				T--
				goto loop

mob/proc/Poison_Proc(var/P, var/Poisoner)
	if(NEM_Round.Type == "King Of The Hill" || NEM_Round.Type == "Tourney") return
	if(name == "Orochimaru" || name == "Kabuchimaru" || name == "Torune" || name == "{Venomous Insects} Torune" || !client || AllowedPoison == 0 || NEM_Round.Mode == "Challenge" || Immune_To_Poison) return
	Poison += P
	if(Poison > 15) Poison = 15
	if(client) winset(src,"default.Poison_Label", "text='Poison Effect will last for [Poison] seconds'")
	if(Poison_On) return
	src<<"<font color=#8904B1><b>You've been poisoned by [Poisoner]!"
	overlays += 'Graphics/Skills/Poison.dmi'
	Poison_On = 1
	loop
		if(Poison > 0)
			if(client)
				winset(src, "default.Poison_Label", "is-visible=true")
				if(Poison > 1) winset(src,"default.Poison_Label", "text='Poison Effect will last for [Poison] seconds'")
				else winset(src,"default.Poison_Label", "text='Poison Effect will last for [Poison] second'")
			HP -= 0.5+rand(0.25,0.5)
			Death_Check("Poison's Effects")
			new/obj/Effects/Meele_Hit (src.loc, src)
			spawn(10)
				Poison--
				goto loop
		else
			Poison = 0
			Poison_On = 0
			overlays -='Graphics/Skills/Poison.dmi'
			if(client) winset(src, "default.Poison_Label", "is-visible=false")

mob/proc/Stop_Chakra(var/P, var/Enemy)
	if(!client || NEM_Round.Mode == "Challenge") return
	Chakra_Time += P
	if(Chakra_Time > 10 && Enemy != "Pein") Chakra_Time = 10
	if(client) winset(src,"default.Chakra_Label", "text='You are unable to regenerate chakra for [Chakra_Time] seconds'")
	if(Chakra_On) return
	Chakra_On = 1
	loop
		if(Chakra_Time > 0)
			if(client)
				winset(src, "default.Chakra_Label", "is-visible=true")
				if(Chakra_Time > 1) winset(src,"default.Chakra_Label", "text='You are unable to regenerate chakra for [Chakra_Time] seconds'")
				else winset(src,"default.Chakra_Label", "text='You are unable to regenerate chakra for [Chakra_Time] second'")
			Regenerate_Chakra = 0
			spawn(10)
				Chakra_Time--
				goto loop
		else
			Regenerate_Chakra = 1
			Chakra_On = 0
			if(client) winset(src, "default.Chakra_Label", "is-visible=false")

mob/var/Transformed = 0
mob/var/Poison_On = 0
mob/var/Chakra_On = 0
mob/var/Chakra_Time = 0
mob/proc/Amaterasu_XX()
	if(NEM_Round.Type == "King Of The Hill") return
	if(AllowedAmaterasu == 0 || name == "Lord Itachi" || name == "(Rinnegan) Sasuke" || Immune_To_Amaterasu)
		Amaterasu = 0
		return
	var/T=0
	var/Times = 20
	src.Amaterasu = 10
	loop
		if(Immune==1&&Amaterasu==10)
			Amaterasu=0
			src.overlays-='Graphics/Skills/amatflame.dmi'
			T=0
			return
		if(src.Amaterasu==10&&T==0)
			T++
			src.overlays+='Graphics/Skills/amatflame.dmi'
			src.HP-=0.75+rand(0.25,1.50)
			src.Death_Check("Amaterasu's Effects")
			spawn(15)goto loop
		if(src.Amaterasu==10&&T>=1)
			T++
			src.HP-=0.75+rand(0.25,1.50)
			src.Death_Check("Amaterasu's Effects")
			spawn(15)goto loop
		if(T>=Times&&Amaterasu==10)
			Amaterasu=0
			src.overlays-='Graphics/Skills/amatflame.dmi'
			src<<output("<br><b><font color=red><u>You're now immune to Amaterasu Flames!</u></font><br>","Chat")
			Immune=1
			T=0
			return
		if(src.Amaterasu==0)
			T=0
			src.overlays-='Graphics/Skills/amatflame.dmi'
			return
mob/proc/Amaterasu_Proc()
	if(NEM_Round.Type == "King Of The Hill") return
	if(AllowedAmaterasu == 0 || name == "Lord Itachi" || Immune_To_Amaterasu)
		Amaterasu = 0
		return
	var/T=0
	var/Times=rand(25,50)
	loop
		if(Immune == 1 && Amaterasu == 1 || knocked)
			Amaterasu=0
			src.overlays-='Graphics/Skills/amatflame.dmi'
			T=0
			return
		if(src.Amaterasu==1&&T==0)
			T++
			src.overlays+='Graphics/Skills/amatflame.dmi'
			src.HP-=0.75+rand(0.25,1.50)
			src.Death_Check("Amaterasu's Effects")
			spawn(15)goto loop
		if(src.Amaterasu==1&&T>=1)
			T++
			src.HP-=0.75+rand(0.25,1.50)
			src.Death_Check("Amaterasu's Effects")
			spawn(15)goto loop
		if(T>=Times&&Amaterasu==1)
			Amaterasu=0
			src.overlays-='Graphics/Skills/amatflame.dmi'
			src<<output("<br><b><font color=red><u>You're now immune to Amaterasu Flames!</u></font><br>","Chat")
			Immune=1
			T=0
			return
		if(src.Amaterasu==0)
			T=0
			src.overlays-='Graphics/Skills/amatflame.dmi'
			return

mob/Dragonpearl123/verb

	Full()
		set category = "Server"
		HP = MaxHP
		Cha = MaxCha
		Energy = MaxEnergy

	Chuunin_I()
		set category = "Modes"
		loc = locate(17, 91, 6)

	Game_Name()
		var/T = input("What name?", "Game Name") as text
		if(T) world.name = T

mob/Eternal/verb
	Chuunin_Map()
		set category = "Modes"
		Current_Log.Add("*[key] teleported himself to Chuunin Exam Stage!", 1)
		for(var/obj/Chuunin_Player_Right_Spawn_1/L) Teleport_(L)

mob/var/Text_Color = "#969696"

mob/var/Deaths=0
mob/proc
	SaveScores()
		if(WorldSave==0) return
		var/savefile/F=new("Saves/[key].sav")
		if(Kunais_L)
			Kunais += Kunais_L
			Kunais_L = 0
			if(Kunai_Jutsu) del(Kunai_Jutsu)
		if(Shurikens_L)
			Shurikens += Shurikens_L
			Shurikens_L = 0
			if(Shuriken_Jutsu) del(Shuriken_Jutsu)
		if(Scroll_Kunais_L)
			Scroll_Kunais += Scroll_Kunais_L
			Scroll_Kunais_L = 0
			if(Scroll_Kunai_Jutsu) del(Scroll_Kunai_Jutsu)
		F["Wall_Jump"] << src.Wall_Jump
		F["Missions_Cooldowns"] << src.Missions_Cooldowns
		F["Shurikens"] << src.Shurikens
		F["Kunais"] << src.Kunais
		F["Scroll_Kunais"] << src.Scroll_Kunais
		F["Wall_Key"] << src.Wall_Key
		F["Text_Color"] << src.Text_Color
		F["Ryo_Gained_On_Tourney_"] << src.Ryo_Gained_On_Tourney_
		F["Ryo_Reward_Boost"] << src.Ryo_Reward_Boost
		F["Ryo_Wasted_On_Tourney_"] << src.Ryo_Wasted_On_Tourney_
		F["Mute_Time"] << Mute_Time
		F["Saved_Day"] << src.Saved_Day
		F["Thanked_Times"] << src.Thanked_Times
		F["Ryo_Multiplied"] << src.Ryo_Multiplied
		F["Thanked"] << src.Thanked
		F["New_"] << src.New_
		F["Achievements"] << src.Achievements
		F["Ignoring"] << src.Ignoring
		F["Sound"] << src.Sound
		F["Rounds"] << src.Rounds
		F["Trial"] << src.Trial
		F["_Player"] << src._Player
		F["Jutsus_Saved"] << src.Jutsus_Saved
		F["Donator"] << src.Donator
		F["Try_Donator"] << src.Try_Donator
		F["Trying_Donator"] << src.Trying_Donator
		F["Abuser"] << src.Abuser
		F["Accept_Votes"] << src.Accept_Votes
		F["Voted"] << src.Voted
		F["SeeEffects"] << src.SeeEffects
		F["Mute"] << src.Mute
		F["New_To_Us"] << src.New_To_Us
		F["Ignored_Challengers"] << src.Ignored_Challengers
	LoadScores()
		if(fexists("Saves/[key].sav"))//if an existing save file exists in the folder located in the game folder
			var/savefile/F=new("Saves/[key].sav") // it creates a new save file
			F["Rounds"] >> src.Rounds
			F["Shurikens"] >> src.Shurikens
			if(!Shurikens) Shurikens = 0
			F["Kunais"] >> src.Kunais
			if(!Kunais) Kunais = 0
			F["Scroll_Kunais"] >> src.Scroll_Kunais
			if(!Scroll_Kunais) Scroll_Kunais = 0
			F["SeeEffects"] >> src.SeeEffects
			if(!SeeEffects) see_invisible = 10
			F["Jutsus_Saved"] >> src.Jutsus_Saved
			F["New_To_Us"] >> src.New_To_Us
			if(New_To_Us < 6)
				for(var/Jutsus_Set/S in Jutsus_Saved) if(S.name == "(Puppet Body) Sasori" || S.name == "Sasori" || S.name == "Asuma" || S.name == "Yamato" || S.name == "Hashirama Senju") del(S)
				New_To_Us = 6
			if(New_To_Us < 7)
				for(var/Jutsus_Set/S in Jutsus_Saved) if(S.name == "Tsuchikage" || 	S.name == "Sai") del(S)
				New_To_Us = 7
			if(New_To_Us < 8)
				for(var/Jutsus_Set/S in Jutsus_Saved) if(S.name == "Hidan" || S.name == "Shino" || S.name == "Temari") del(S)
				New_To_Us = 8
			if(New_To_Us < 9)
				for(var/Jutsus_Set/S in Jutsus_Saved) if(S.name == "Tobirama Senju") del(S)
				New_To_Us = 9
			F["Saved_Day"] >> src.Saved_Day
			if(!Jutsus_Saved) Jutsus_Saved = list()
			F["Wall_Key"] >> src.Wall_Key
			F["Missions_Cooldowns"] >> src.Missions_Cooldowns
			if(!Missions_Cooldowns) Missions_Cooldowns = list()
			F["Wall_Jump"] >> src.Wall_Jump
			F["Text_Color"] >> src.Text_Color
			if(!Text_Color) Text_Color = "#969696"
			F["Mute_Time"] >> src.Mute_Time
			F["Ryo_Reward_Boost"] >> src.Ryo_Reward_Boost
			F["Ignored_Challengers"] >> src.Ignored_Challengers
			if(!Ignored_Challengers) Ignored_Challengers = list()
			F["Ryo_Gained_On_Tourney_"] >> src.Ryo_Gained_On_Tourney_
			F["Ryo_Wasted_On_Tourney_"] >> src.Ryo_Wasted_On_Tourney_
			F["_Player"] >> src._Player
			F["Ryo_Multiplied"] >> src.Ryo_Multiplied
			F["Thanked_Times"] >> src.Thanked_Times
			F["Thanked"] >> src.Thanked
			F["New_"] >> src.New_
			if(!Thanked_Times) Thanked_Times = 0
			if(!Thanked) Thanked = 0
			F["Sound"] >> src.Sound
			F["Achievements"] >> src.Achievements
			F["Ignoring"] >> src.Ignoring
			if(!Ignoring) Ignoring = list()
			F["Trial"] >> src.Trial
			if(Trial == 1) Donator = 1
			F["Try_Donator"] >> src.Try_Donator
			F["Donator"] >> src.Donator
			F["Trying_Donator"] >> src.Trying_Donator
			F["Mute"] >> src.Mute
			F["Abuser"] >> src.Abuser
			F["Accept_Votes"] >> src.Accept_Votes
			F["Voted"] >> src.Voted
mob/var/immortal=0
mob/var/CanGoKyuubi=1
mob/var/CanGoCS=1
mob/var/CanBeRevived=1
mob/var/mob/Kabuto
mob
	proc
		Edo_Stun()
			..()
			var/_Round_ = Round
			spawn(300)
				if(Round != _Round_ || Kabuchimaru && Kabuchimaru.dead) return
				HP = MaxHP
				Cha = MaxCha
				Energy = MaxEnergy
				Run_Off()
				Dragonned = 0
				knocked = 0
				dead = 0
				density = 1
				freeze = 0
				stop()
				holding_left = null
				holding_right = null
				src<<"<b><font color=#505050><u>Your body is ready to fight again.</u>"
		Death_Check(mob/Killer, Special)
			if(name == key) return
			if(NEM_Round.Mode == "Arena") return
			if(NEM_Round && NEM_Round.Type != "King Of The Hill" && name == "Naruto" && !freeze && Deaths >= 3 && NEM_Round.Mode == "Normal" && GoingSage == 0  && NEM_Side && NEM_Side.Ninjas <= NEM_Side.Enemy.Ninjas && CanGoKyuubi == 1 && !CTD)
				Kyuubi()
				return
			if(NEM_Round && NEM_Round.Type != "King Of The Hill" && name == "Sasuke" && !freeze && Deaths >= 3 && NEM_Round.Mode == "Normal" && CanUseSusanoo == 0 && CanGoCS == 1 && NEM_Side && NEM_Side.Ninjas <= NEM_Side.Enemy.Ninjas && !CTD && !GoingSusanoo)
				Sasuke_Curse_Seal()
				return
			if(immortal==1)
				HP=MaxHP
				return
			if(HP <= 0 && knocked == 0 && dead == 0 &&name != key)
				if(Edo)
					Dragonned = 1
					knocked = 1
					dead = 1
					freeze = 100
					density = 0
					src<<"<b><font color=#505050><u>Your body has been highly damaged, it'll be fully recovered in 30 seconds.</u>"
					Edo_Stun()
					return
				if(Mind_Controlling)
					Reset_Mind_Control()
					return
				if(src.Controlling_Shadow == 1) for(var/obj/Shadow/S in world) del(S)
				if(src.name == "(Kyuubi) Naruto" || src.name == "(Curse Seal) Sasuke" || Gates == 1) src.ultra_speed=0
				if(Controlling >=1 ) del(Controlling_Object)
				if(Amaterasu>=1)
					src<<output("<b><font color=#8904B1>Amaterasu's Effect has disappeard.","Chat")
					src.Amaterasu=0
				if(src.Levitating) src.Check_Levitating()
				if(NEM_Round.Type == "King Of The Hill") spawn() Respawn_()

				var/Assisting
				var/Highest_Assist_Damage
				var/mob/Real_Killer
				var/list/Already_Checked = list()

				for(var/Assist/S in Assisted_By)
					if(S.Enemy)
						var/_Damage_
						var/_Enemy_ = S.Enemy
						Already_Checked.Add(S.Enemy)
						for(var/Assist/F in Assisted_By) if(F.Enemy && F.Enemy == _Enemy_) {_Damage_ += F.Damage; del(F)}
						if(_Damage_ >= Highest_Assist_Damage) {Highest_Assist_Damage = _Damage_; Real_Killer = _Enemy_}

				Already_Checked.Remove(Real_Killer)
				for(var/mob/S in Already_Checked)
					if(!Assisting) Assisting = "[S.name]"
					else Assisting += " & [S.name]"
					S.Statistic.Assists ++
					S._Assists ++

				if(Real_Killer) Killer = Real_Killer

				if(Boss_Mode)
					spawn() Respawn_()
					if(ismob(Killer))
						Killer.Juggernaut_Points ++
						if(Juggernaut == src) Killer.Juggernaut_Points += 2
						if(Killer.Juggernaut_Points >= Juggernaut.Juggernaut_Points)
							for(var/obj/Effects/Aura_Red/A) del(A)
							Juggernaut = Killer
							new/obj/Effects/Aura_Red (Juggernaut.loc, Juggernaut)
				if(Boulder >= 1 || BoulderX >= 1)
					Flick("boulder", src)
					BoulderX = 0
					Boulder = 0
				if(src.icon == 'Graphics/Skills/WolfFang.dmi')
					src.icon = 'Graphics/Characters/Kiba.dmi'
					src.Real=1
					src.Checked_X=1
					src.Dragonned=0

				if(Changed_Village == 1)
					overlays -= 'Graphics/Skills/Genjutsu.dmi'
					Changed_Village = 0
					Village = "Leaf"
					NEM_Side = Leaf
					if(client)
						NEM_Side.Enemy.Ninjas --
						NEM_Side.Ninjas ++
						if(!Mission_On) Check_Winner(NEM_Round)

				Flick("Knocked", src)

				if(Sharingan || Byakugan || Rinnegan)
					Byakugan_Off(src)
					Sharingan_Off(src)
					Rinnegan_Off(src)

				if(Choji_Pill)
					if(Choji_Pill == "Spinach")
						Str /= 1.30
						Def /= 1.15
						MaxCha /= 1.30
						Jutsus += new/obj/Jutsus/Curry_Pill (src)

					else if(Choji_Pill == "Curry")
						Str /= 1.40
						Def /= 1.30
						MaxCha /= 1.40
						MaxHP /= 1.25
						speed_multiplier /= 1.30
						Jutsus += new/obj/Jutsus/Chilli_Pill (src)

					else if(Choji_Pill == "Chilli")
						Str /= 1.85
						Def /= 1.50
						MaxHP /= 1.50
						MaxCha /= 1.50
						speed_multiplier /= 1.50

					Choji_Pill = null
					for(var/obj/Effects/Choji_Pill/C in Overlays) del(C)

				src.knocked = 1
				src.Bijuu = 0
				src.Illusion_ = 0
				src.Counting_ = 0
				src.Poison = 0
				src.Chakra_Time = 0
				src.CanMove = 1
				src.Venomous_Clone = 0
				src.Deflection = 0
				src.Dragonned = 0
				src.CanBeRevived=1
				src.vel_y -= 200
				src.Regenerate_Chakra = 1
				src.Activated = 0
				src.Explosing = 0
				src.Run_Off()
				src.freeze = 100
				src.Special_ = 0
				src.Transformed = 0
				src.knockback = 0
				src.Boulder = 0
				src.BoulderX = 0
				src.Real = 1
				src.Checked_X = 1
				src.Dome = 0
				src.Dodging = 0
				src.GoingSusanoo=0
				src.RealDeaths+=1
				src.Deaths+=1
				if(Deaths > 3) if(client && Question_Time && NEM_Round == Current_NEM_Round) spawn() Question(Question_Time, 1)
				HP=0
				Cha=0
				Energy=0
				Levitating=0
				density=0
				icon_state="Knocked"

				if(name=="Hiruko")
					speed_multiplier = 1.35
					icon = 'Graphics/Characters/Sasori.dmi'
					name= "Sasori"
					Str=10
					Def=5
					MaxHP=100
					HP=100
					Check_Jutsu()
				if(Kyuubi==1)
					Str=10
					Def=5
					MaxHP=110
					MaxCha=100
					MaxEnergy=100
					if(icon  == 'Graphics/Characters/Naruto Kyuubi.dmi')
						name = "Naruto"
						icon = 'Graphics/Characters/Naruto.dmi'
					if(icon == 'Graphics/Characters/Curse Seal Sasuke.dmi')
						name = "Sasuke"
						icon = 'Graphics/Characters/Sasuke.dmi'
					src.Str=12
					src.Def=6.5
					speed_multiplier=1.60
					Kyuubi=0
					Check_Jutsu()
				if(Sage==1)
					Sage=0
					Str=10
					Def=5
					MaxHP=100
					MaxCha=100
					MaxEnergy=100
					if(name == "Sage Naruto")
						name = "Naruto"
						icon = 'Graphics/Characters/Naruto.dmi'
					if(name == "Sage Jiraiya")
						name = "Jiraiya"
						icon = 'Graphics/Characters/Jiraiya.dmi'
					if(name == "(Curse Seal) Kimimaro")
						name = "Kimimaro"
						icon = 'Graphics/Characters/Kimimaro.dmi'
					if(name == "{PS} (Curse Seal) Sasuke")
						name= "{PS} Sasuke"
						icon = 'Graphics/Characters/LilSasuke.dmi'
					if(name == "(Curse Seal) Kidoumaru")
						name = "Kidoumaru"
						icon = 'Graphics/Characters/Kidoumaru.dmi'
					if(name == "(Curse Seal) Jirobo")
						name = "Jirobo"
						icon = 'Graphics/Characters/Jirobo.dmi'
					if(name == "(Curse Seal) Tayuya")
						name = "Tayuya"
						icon = 'Graphics/Characters/Tayuya.dmi'
					if(name == "(Curse Seal) Juugo")
						name = "Juugo"
						icon = 'Graphics/Characters/Juugo.dmi'
					if(name == "(Curse Seal) Sakon")
						name = "Sakon"
						icon = 'Graphics/Characters/Sakon.dmi'
					if(name == "(Three Tails) Killer Bee")
						name = "Killer Bee"
						icon = 'Graphics/Characters/Killer Bee.dmi'
						MaxHP = 120
						MaxCha = 125
						MaxEnergy = 150
					speed_multiplier = 1.45
					src.Str=12
					src.Check_Jutsu()
					src.Def=6
					if(name == "{Venomous Insects} Torune")
						ultra_speed = 2
						Str = 13.15
						MaxHP = 120
						MaxCha = 120
						MaxEnergy = 200
						Def = 8
						icon = 'Torune.dmi'
						name = "Torune"
						speed_multiplier = 2
						src.Check_Jutsu()
						src.Run_Off()
						src.stop()
						for(var/mob/Torune/T in world) T.Always_Freeze()
					if(src.name == "Naruto")
						MaxHP = 115
						MaxCha = 100
						MaxEnergy = 185
						Str = 12
						Def = 6.5
						speed_multiplier = 1.60
					if(src.name == "{PS} Sasuke")
						MaxHP = 120
						MaxCha = 125
						MaxEnergy = 150
						Str = 12.5
						Def = 7
						speed_multiplier = 1.55
					if(src.name == "(Puppet Body) Sasori")
						src.name = "Sasori"
						src.MaxHP = 110
						src.HP = 110
						src.MaxEnergy = 115
						src.Energy = 115
						src.MaxCha=100
						src.Cha=100
						src.Str=12.5
						src.Def=6
						src.speed_multiplier=1.20
						src.ultra_speed = 0
						src.icon = 'Graphics/Characters/Sasori.dmi'
					if(src.name == "(Sanbi) Yagura")
						src.ultra_speed = 2
						src.speed_multiplier = 1.95
						src.MaxCha = 125
						src.Cha = 125
						src.MaxHP = 125
						src.HP = 125
						src.Def = 8.25
						src.Str = 13.25
						src.MaxEnergy = 225
						src.Energy = 225
						src.name= "Yagura"
						src.icon = 'Graphics/Characters/Yagura.dmi'
					if(src.name == "(Lightning Armour) Raikage")
						src.name = "Raikage"
						src.pixel_y = 0
						src.MaxHP = 125
						src.MaxCha = 130
						src.MaxEnergy = 200
						src.Str = 13.5
						src.Def = 7.5
						src.icon = 'Graphics/Characters/Raikage.dmi'
						src.speed_multiplier = 1.90
					if(src.name=="Sakon")
						src.Def=6.5
						src.Str=12.5
					if(name == "Tayuya")
						src.speed_multiplier = 1.45
						src.Def = 7.25
						src.Str = 12
						src.MaxHP = 105
						src.MaxCha = 125
						src.MaxEnergy = 130
						src.HP = 105
						src.MaxCha = 125
						src.Energy = 130
					if(name == "(Youthful) Rock Lee")
						new/obj/Effects/Might_Gai (src.loc, src)
						world<<output("<font size=2><font color=#52D017><u>- Might Gai ordered Rock Lee to put his weights back on! -</u></font>","Chat")
						name = "Rock Lee"
						MaxHP = 115
						MaxEnergy = 175
						Str = 14.5
						Def = 7.25
						speed_multiplier = 1.60
						ultra_speed = 0
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
					if(name == "(Butterfly) Choji")
						name = "Choji"
						MaxHP = 115
						MaxCha = 100
						MaxEnergy = 100
						Str = 11.5
						Def = 6.5
						speed_multiplier = 1.35
						icon = 'Graphics/Characters/Choji.dmi'
					Check_Jutsu()
				if(Susanoo==1)
					ultra_speed = 0
					Susanoo = 0
					Dragonned = 0
					Str = 10
					src.pwidth = 32
					Def = 5
					layer = 100
					MaxHP = 100
					MaxCha = 100
					MaxEnergy = 100
					if(icon == 'Graphics/Skills/Susanoo2.dmi')
						name = "Sasuke"
						icon = 'Graphics/Characters/Sasuke.dmi'
					if(icon =='Graphics/Skills/Susanoo.dmi')
						name = "Itachi"
						icon = 'Graphics/Characters/Itachi.dmi'
					Check_Jutsu()
				if(name=="(Opened Gates) Rock Lee")
					icon = 'Graphics/Characters/RockLee.dmi'
					speed_multiplier = 1.65
					name = "Rock Lee"
					ultra_speed = 0
					Str = 14.5
					Def = 7.25
					MaxEnergy = 175
					MaxCha = 100
					MaxHP = 115
					Check_Jutsu()
				if(Gates == 1)
					Real=1
					src.Checked_X=1
					Gates=0
					Dragonned=0
					MaxCha=100
					MaxEnergy=100
					if(name=="(Opened Gates) Might Gai")
						icon = 'Graphics/Characters/MightGai.dmi'
						speed_multiplier = 1.65
						name="Might Gai"
					speed_multiplier = 1.55
					fall_speed = 25
					Check_Jutsu()
				if(GoingSage)
					src.GoingSage = 0
					src.speed_multiplier = Speed_Multiplier_X
					src.Check_Icon = 1
					src.Attacking = 0


				if(!client && Body_Offline == 0)
					if(Clone_Creator)
						for(var/obj/Jutsus/Akamaru_Summon/J in Clone_Creator.Jutsus) J.Delay(45)
						for(var/obj/Jutsus/Water_Clone/J in Clone_Creator.Jutsus) J.Delay(45)
						for(var/obj/Jutsus/Clone_Jutsu_Kisame/J in Clone_Creator.Jutsus) J.Delay(45)
						for(var/obj/Jutsus/Clone_Jutsu_Naruto/J in Clone_Creator.Jutsus) J.Delay(45)
						for(var/obj/Jutsus/Clone_Jutsu_Yamato/J in Clone_Creator.Jutsus) J.Delay(45)
						for(var/obj/Jutsus/Water_Clone_Kus/J in Clone_Creator.Jutsus) J.Delay(45)
						for(var/obj/Jutsus/Clone_Jutsu/J in Clone_Creator.Jutsus) J.Delay(45)
					if(Real_C == 0) del(src)
					if(Killer)
						if(Ino_NPC)
							dead = 1
							knocked = 1
							Murderer = Killer
							Creator_M.Reset_Mind_Control()
							return
						if(Special) NEM_Round.Shout("<u><b><font color=#CC0000>[src.name] has drowned due to the lack of chakra and energy!</u></font>")
						if(!Special)
							if(Assisting) {Killer = Real_Killer; NEM_Round.Shout("<b><font color=#CC0000><u>[src.name] has been killed by [Killer], assisted by [Assisting]!</u>")}
							else NEM_Round.Shout("<u><b><font color=#CC0000>[src.name] has been killed by [Killer]!</u>")

						if(ismob(Killer))
							if(Killer.client)
								if(Killer.NEM_Round == Current_NEM_Round) Killer.Statistic.Kills++
								Statistic.Characters_Enemies.Add(Killer.name)
								Statistic.Enemies.Add(Killer.key)
								Killer.Update_Scores()
								Killer.Kills++
								Killer.Attacked = 0
							if(!Killer.client)
								if(name == "{Clone} Yagura")
									Flick("Explosion", src)
									sleep(6)
								if(findtext(src.name, "{NPC}") && Target)
									var/Text
									if(Target) Target.Enemies_Following.Remove(src)
									if(Village == "Akatsuki") Text = pick("I've been stopped by a Leaf Shinobi... dd- I hate you, [Target:name].", "I disgraced myself, aaarg!", "You may have defeated me-... but the Akatsuki will destroy you!")
									if(Village == "Leaf") Text = pick("Ggg... I've been wounded too badly-", "I surrender-... but Allied Forces will avenge me!", "It's over-... there's no hope.", "The Hokage will disgrace me for this...")
									view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: [Text]"
								for(var/mob/M)
									if(M.name == "[Killer]")
										if(M.key)
											Statistic.Enemies.Add(M.key)
											Statistic.Characters_Enemies.Add(M.name)
											if(M.NEM_Round == Current_NEM_Round) M.Statistic.Kills++
											M.Update_Scores()
											M.Kills++
											M.Attacked = 0
					if(!Killer)
						NEM_Round.Shout("<u><b><font color=#CC0000>[src.name] has been killed by ???!</u>")
						if(name == "{Clone} Yagura")
							Flick("Explosion", src)
							sleep(6)
					if(istype(src, /mob/Torune))
						for(var/obj/Jutsus/Venomous_Insect_Clone/J in _Owner_) J.Delay(35)
						Flick("Seals", _Owner_)
						Flick("Seals", src)
						_Owner_._CD = 0
						_Owner_.Venomous_Clone = 0
						_Owner_.freeze ++
						_Owner_.Substitution = 0
						_Owner_.invisibility = 0
						_Owner_.speed_multiplier = 0
						_Owner_.move_speed = 0
						_Owner_.Dragonned = 0
						_Owner_.density = 1
						_Owner_.Can_Attack_ = 1
						spawn(3.75) _Owner_.freeze --
					if(istype(src, /mob/Kakashi))
						for(var/obj/Jutsus/Kakashi_Clone/J in _Owner_) J.Delay(45)
						Flick("mob-shooting", _Owner_)
						Flick("mob-shooting", src)
						_Owner_._CD = 0
						_Owner_.Venomous_Clone = 0
						_Owner_.freeze ++
						_Owner_.Substitution = 0
						_Owner_.invisibility = 0
						_Owner_.Dragonned = 0
						_Owner_.density = 1
						_Owner_.Can_Attack_ = 1
						spawn(3.75)
							_Owner_.freeze --
							_Owner_.stop()
					if(!Ino_NPC)
						if(Puppet == 1) del(src)
						if(Target) Target:Enemies_Following.Remove(src)
						src.Checked_X = 0
						src.freeze = 100
						src.dead = 1
						if(!Mission_NPC) src.Always_Freeze()
						return
				if(Deaths > 3)
					if(Healer_Character == 1)
						if(Village == "Leaf") Healers_Leaf --
						if(Village == "Akatsuki") Healers_Akatsuki --
						if(Can_Revive == 1 && name == "Pein") src<<"<b><font color=red><u>You can no longer use Path Of Resurrection."
						if(Can_Revive == 1 && name == "Tsunade") src<<"<b><font color=red><u>You can no longer Revive nor Mass Heal."
						if(Can_Revive == 1 && name != "Tsunade") src<<"<b><font color=red><u>You can no longer Revive."
						Revived_T = 5
						Can_Revive = 0

					Go_Dead()
					src.dead = 1
					src.GoingSage = 0
					src.HP = 0
					src.Cha = 0
					src.Energy = 0
					src.dead=1
					src.freeze = 100
					src.knocked=1
					src.Poison=0
					src.Amaterasu=0
					if(name=="Hiruko")
						speed_multiplier = 1.35
						icon = 'Graphics/Characters/Sasori.dmi'
						name= "Sasori"
						Check_Jutsu()
						Str=10
						Def=5
						MaxHP=100
						HP=100
					if(Kyuubi==1)
						Str=10
						Def=5
						MaxHP=100
						MaxCha=100
						MaxEnergy=100
						if(icon == 'Graphics/Characters/Naruto Kyuubi.dmi')
							name = "Naruto"
							icon= 'Graphics/Characters/Naruto.dmi'
						if(icon == 'Graphics/Characters/Curse Seal Sasuke.dmi')
							name = "Sasuke"
							icon= 'Graphics/Characters/Sasuke.dmi'
						src.Str=11
						src.Def=5.5
						Kyuubi=0
						Check_Jutsu()
					if(Sage==1)
						Sage=0
						Str=10
						Def=5
						MaxHP=100
						MaxCha=100
						MaxEnergy=100
						if(name == "Sage Naruto")
							name = "Naruto"
							icon = 'Graphics/Characters/Naruto.dmi'
						if(name == "Sage Jiraiya")
							name = "Jiraiya"
							icon = 'Graphics/Characters/Jiraiya.dmi'
						if(name == "(Curse Seal) Kimimaro")
							name = "Kimimaro"
							icon = 'Graphics/Characters/Kimimaro.dmi'
						if(name == "{PS} (Curse Seal) Sasuke")
							name= "{PS} Sasuke"
							icon = 'Graphics/Characters/LilSasuke.dmi'
						if(name == "(Curse Seal) Kidoumaru")
							name = "Kidoumaru"
							icon = 'Graphics/Characters/Kidoumaru.dmi'
						if(name == "(Curse Seal) Jirobo")
							name = "Jirobo"
							icon = 'Graphics/Characters/Jirobo.dmi'
						if(name == "(Curse Seal) Tayuya")
							name = "Tayuya"
							icon = 'Graphics/Characters/Tayuya.dmi'
						if(name == "(Curse Seal) Juugo")
							name = "Juugo"
							icon = 'Graphics/Characters/Juugo.dmi'
						if(name == "(Curse Seal) Sakon")
							name = "Sakon"
							icon = 'Graphics/Characters/Sakon.dmi'
						if(name == "(Three Tails) Killer Bee")
							name = "Killer Bee"
							icon = 'Graphics/Characters/Killer Bee.dmi'
						if(name == "(Butterfly) Choji")
							name = "Choji"
							icon = 'Graphics/Characters/Choji.dmi'
						speed_multiplier = 1.25
						src.Str=12
						src.Def=6
						if(src.name == "(Puppet Body) Sasori")
							src.name = "Sasori"
							src.MaxHP = 110
							src.HP = 110
							src.MaxEnergy = 115
							src.Energy = 115
							src.MaxCha=100
							src.Cha=100
							src.Str=12.5
							src.Def=6
							src.speed_multiplier=1.20
							src.ultra_speed = 0
							src.icon = 'Graphics/Characters/Sasori.dmi'
						if(src.name == "(Sanbi) Yagura")
							src.ultra_speed = 2
							src.speed_multiplier = 1.95
							src.MaxCha = 125
							src.Cha = 125
							src.MaxHP = 125
							src.HP = 125
							src.Def = 8.25
							src.Str = 13.25
							src.MaxEnergy = 225
							src.Energy = 225
							src.name= "Yagura"
							src.icon = 'Graphics/Characters/Yagura.dmi'
						if(src.name == "(Lightning Armour) Raikage")
							src.name = "Raikage"
							src.pixel_y = 0
							src.MaxHP = 125
							src.MaxCha = 130
							src.MaxEnergy = 200
							src.Str = 13.5
							src.Def = 7.5
							src.icon = 'Graphics/Characters/Raikage.dmi'
							src.speed_multiplier = 1.90
						if(src.name=="Sakon")
							src.Def=6.5
							src.Str=12.5
						if(name == "{Venomous Insects} Torune")
							ultra_speed = 2
							MaxHP = 120
							MaxCha = 120
							Str = 13.15
							MaxEnergy = 200
							icon = 'Torune.dmi'
							Def = 8
							name = "Torune"
							ultra_speed = 0
							src.Check_Jutsu()
							src.Run_Off()
							src.stop()
							for(var/mob/Torune/T in world) T.Always_Freeze()
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
						Check_Jutsu()
					if(Susanoo==1)
						Susanoo=0
						Dragonned=0
						Str=10
						src.pwidth = 32
						layer = 100
						Def=5
						MaxHP=100
						MaxCha=100
						MaxEnergy=100
						if(icon == 'Graphics/Skills/Susanoo2.dmi')
							name = "Sasuke"
							icon = 'Graphics/Characters/Sasuke.dmi'
						if(icon == 'Graphics/Skills/Susanoo.dmi')
							name = "Itachi"
							icon = 'Graphics/Characters/Itachi.dmi'
						Check_Jutsu()
					if(name == "(Opened Gates) Rock Lee")
						icon = 'Graphics/Characters/RockLee.dmi'
						speed_multiplier = 1.65
						ultra_speed = 0
						name = "Rock Lee"
						Str = 14.5
						Def = 7.25
						MaxEnergy = 175
						MaxCha = 100
						MaxHP = 115
						Check_Jutsu()
					if(Gates==1)
						Real=1
						src.Checked_X=1
						Gates=0
						Dragonned=0
						MaxCha=100
						MaxEnergy=100
						if(name == "(Opened Gates) Might Gai")
							icon = 'Graphics/Characters/MightGai.dmi'
							speed_multiplier = 1.65
							name = "Might Gai"
						move_speed=10
						fall_speed=25
						running=0
						Check_Jutsu()

				if(Gentle_Fist) Gentle_Fist_Off(src)
				if(Deaths<=3)
					KOd++
					if(NEM_Round == Current_NEM_Round) Statistic.KOds++
					if(Killer)
						if(Assisting)  NEM_Round.Shout("<b><font color=#FF8000>[src.name] has been knocked out by [Killer], assisted by [Assisting]!")
						else NEM_Round.Shout("<b><font color=#FF8000>[src.name] has been knocked out by [Killer]!")

						if(ismob(Killer))
							if(Killer.client)
								Killer.KOs++
								if(Killer.NEM_Round == Current_NEM_Round) Killer.Statistic.KOs++
								Statistic.Characters_Enemies.Add(Killer.name)
								Statistic.Enemies.Add(Killer.key)
								Killer.Update_Scores()
							if(!Killer.client)
								for(var/mob/M)
									if(M.name == "[Killer]")
										M.KOs++
										if(M.key)
											if(M.NEM_Round == Current_NEM_Round) M.Statistic.KOs++
											Statistic.Characters_Enemies.Add(M.name)
											Statistic.Enemies.Add(M.key)
											M.Update_Scores()
					if(!Killer) NEM_Round.Shout("<b><font color=#FF8000>[src.name] has been knocked out by ???!")
					spawn(50)
						src.Assisted_By = list()
						src.Run_Off()
						src.dead = 0
						src.knocked=0
						src.HP=MaxHP
						src.Energy = src.MaxEnergy
						src.freeze = 0
						src.stop()
						src.density=1
						src.Dragonned=0
						src.Cha=MaxCha
						src.running=0
						src.icon_state="mob"
						src.set_state()
						src.alpha = 150
						src.Dragonned = 1
						src.Substitution = 2
						src.No_Attack = 1
						spawn(30)
							src.alpha = 255
							src.Dragonned = 0
							src.Substitution = 0
							src.No_Attack = 0
						if(name == "Kisame" && Deaths >= 2 && NEM_Round.Mode != "Challenge" && NEM_Round.Type != "King Of The Hill" && !CTD && NEM_Round.Type != "Tourney" && !Boss_Mode) Drop_Cloak()
						if(name == "Madara" && Deaths >= 2 && NEM_Round.Mode != "Challenge" && NEM_Round.Type != "King Of The Hill" && !CTD && NEM_Round.Type != "Tourney" && !Boss_Mode) Drop_Shirt()
						if(Capture_The_Flag == 0 && Deaths >= 3 && src.name == "Sasori" && Revived_T == 0 && NEM_Round.Type != "Tourney" && !Mind_Controlling)
							world<<output("<b><font color=#A60000><u><font size=2>Sasori has activated Puppet Body Mode!","Chat")
							var/A=new/obj/GroundSmash(src.loc)
							if(src.dir==WEST) A:pixel_x-=15
							if(src.dir==EAST) A:pixel_x-=10
							icon = 'Graphics/Characters/SasoriX.dmi'
							Check_Jutsu()
							Revived_T ++
							Str = 13.5
							Def = 7.5
							MaxHP = 150
							HP = 150
							MaxCha = 115
							Cha = 115
							MaxEnergy = 200
							Energy = 200
							ultra_speed = 1
							Sage = 1
							name = "(Puppet Body) Sasori"
							Check_Jutsu()

				if(Deaths > 3)
					if(name == "Kabuchimaru") for(var/mob/M in world) if(M.Edo)
						M<<"<b><font color=#505050><u>Kabuchimaru died, you're free again...</u>"
						M.Respawn(1)
					dead = 1
					GoingSage = 0
					HP = 0
					Cha = 0
					Energy = 0
					dead=1
					freeze = 100
					knocked=1
					Poison=0
					Amaterasu=0
					KOd++
					if(NEM_Round == Current_NEM_Round) Statistic.KOds++
					Update_Scores()
					if(NEM_Side) NEM_Side.Ninjas --

					if(Killer)
						if(Special) NEM_Round.Shout("<u><b><font color=#CC0000>[src.name] has drowned due to the lack of chakra and energy!</u></font>")
						if(!Special)
							if(Assisting)  NEM_Round.Shout("<b><font color=#CC0000><u>[src.name] has been killed by [Killer], assisted by [Assisting]!</u>")
							else NEM_Round.Shout("<u><b><font color=#CC0000>[src.name] has been killed by [Killer]!</u>")

						if(ismob(Killer))
							if(client)
								client.perspective = EYE_PERSPECTIVE
								client.eye = Killer

							if(Killer.client)
								Statistic.Characters_Enemies.Add(Killer.name)
								Statistic.Enemies.Add(Killer.key)
								Killer.Kills++
								if(Killer.NEM_Round == Current_NEM_Round) Killer.Statistic.Kills++
								Killer.Update_Scores()

							if(!Killer.client)
								for(var/mob/M)
									if(M.name == "[Killer]")
										Statistic.Characters_Enemies.Add(M.name)
										M.Kills++
										if(M.key)
											Statistic.Enemies.Add(M.key)
											if(M.NEM_Round == Current_NEM_Round) M.Statistic.Kills++
											M.Update_Scores()

					verbs+=typesof(/mob/Dead/verb)

					if(!Killer)
						NEM_Round.Shout("<u><b><font color=#CC0000>[src.name] has been killed by ???!</u>")
						src.dead = 1

					if(NEM_Round.Type == "Tourney")
						var/mob/L = null
						for(var/mob/C)
							var/Check__ = 0
							if(Fighters.Find(C) && !C.dead)
								Check__ = 1
								L = src
							if(C.client && Check__ == 0)
								if(C.client.perspective == MOB_PERSPECTIVE && C.client.eye == src)
									C.client.perspective = EYE_PERSPECTIVE
									C.client.eye = L

					if(name=="Ginkaku")
						for(var/mob/M)
							if(M.Absorbed==1)
								M.loc = loc
								M.x += rand(-3,3)
								M.check_loc()
								M.freeze = 100
								M.Absorbed = 0
								M<<output("<b><font size=2><center><font color=#7C0101>* Ginkaku has died, your soul is now free and you can be revived again *","Chat")
								M.CanBeRevived = 1
								M.layer = 100
								M.Checked_X = 1
								M.Teleport_(src)
								if(!M.Moving) M.Movement()
								M.Go_Dead()
					if(!Sound)
						var/sound/S = sound('Death.ogg', 0, 0, 0, 85)
						src << sound(null)
						src << S

					if(!Mission_On) Check_Winner(NEM_Round)

mob/var/Try_Donator = 0

mob/Dragonpearl123/verb
	Kill(mob/M in world)
		set category = "Server"
		M.Deaths = 4
		M.HP = 0
		M.Death_Check()

var/Version = "Special Version"

atom
	proc
		inside4(qx,qy,qw,qh)
			if(qx <= px - qw) return 0
			if(qx >= px + pwidth) return 0
			if(qy <= py - qh) return 0
			if(qy >= py + pheight) return 0
			return 1
		inside()
			if(!args || args.len == 0) return obounds(src)

			else if(args.len == 1)
				var/atom/a = args[1]
				if(!istype(a)) return 0
				return a.inside4(px, py, pwidth, pheight)

	proc
		left(w) return obounds(src, -w, 0, -pwidth + w, 0)
		right(w) return obounds(src, pwidth, 0, -pwidth + w, 0)
		top(h) return obounds(src, 0, pheight, 0, -pheight + h)
		bottom(h) return obounds(src, 0, -h, 0, -pheight + h)

mob
	proc

		knockback(atom/a, magnitude = 0.5)
			if(knockback == 1 || freeze)return
			var/T=0
			loop
			if(vel_y==0)return
			if(T!=2)
				T++
				vel_y+=magnitude
				vel_x-=3
				spawn(25)goto loop
		knock()
			src.knockback=1
			src.vel_x+=30
			src.vel_y+=10
			spawn(10)
				if(on_ground==1)
					src.knockback=0
					src.stop()
			spawn(25)
				src.knockback=0


		knockbackeastx(atom/a, magnitude = 3)
			if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || Real_C == 0 && !_Special_Puppet_ || KakashiChidori || Rasengan || Chidori || DinamicEntry || Iron) return
			flick("mob-knockback", src)
			var/T = 0
			dir = WEST
			knockback = 1
			Attacking = 0
			vel_y+=13
			vel_x=20
			New_Knockback = rand(1, 99999999)
			var/KN = New_Knockback
			spawn()
				loop
					if(KN != New_Knockback || !knockback) return
					fall_speed = 5
					dir=WEST
					if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || freeze || T >= 30)
						fall_speed = 25
						knockback = 0
						src.stop()
						return
					if(T!=50)
						T++
						Attacking = 0
						knockback = 1
						vel_x = 20
						spawn(1.5*world.tick_lag)goto loop

		knockbackwestx(atom/a, magnitude = 3)
			if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || Real_C == 0 && !_Special_Puppet_ || KakashiChidori || Rasengan || Chidori || DinamicEntry || Iron) return
			flick("mob-knockback", src)
			Attacking = 0
			dir = EAST
			knockback = 1
			var/T=0
			vel_y+=13
			vel_x=-20
			New_Knockback = rand(1, 99999999)
			var/KN = New_Knockback
			spawn()
				loop
					if(KN != New_Knockback || !knockback) return
					fall_speed = 5
					dir=EAST
					if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || freeze || T >= 30)
						fall_speed = 25
						knockback = 0
						src.stop()
						return
					if(T!=50)
						T++
						Attacking = 0
						knockback = 1
						vel_x = -20
						spawn(1.5*world.tick_lag)goto loop


		knockbackeastt(atom/a, magnitude = 3)
			if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || Real_C == 0 && !_Special_Puppet_ || KakashiChidori || Rasengan || Chidori || DinamicEntry || Iron) return
			if(freeze)return
			flick("mob-knockback", src)
			Attacking = 0
			var/T=0
			dir = WEST
			knockback = 1
			vel_y+=12
			vel_x=20
			New_Knockback = rand(1, 99999999)
			var/KN = New_Knockback
			spawn()
				loop
					if(KN != New_Knockback || !knockback) return
					fall_speed = 5
					dir=WEST
					if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || freeze || T >= 15)
						fall_speed = 25
						knockback = 0
						src.stop()
						return
					if(T!=15)
						T++
						Attacking = 0
						knockback = 1
						vel_x = 20
						spawn(1.5*world.tick_lag)goto loop

		knockbackwestt(atom/a, magnitude = 3)
			if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || Real_C == 0 && !_Special_Puppet_ || KakashiChidori || Rasengan || Chidori || DinamicEntry || Iron) return
			if(freeze) return
			flick("mob-knockback", src)
			Attacking = 0
			dir = EAST
			knockback = 1
			var/T=0
			vel_y+=12
			vel_x=-20
			New_Knockback = rand(1, 99999999)
			var/KN = New_Knockback
			spawn()
				loop
					if(KN != New_Knockback || !knockback) return
					dir=EAST
					fall_speed = 5
					if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || freeze || T >= 15)
						fall_speed = 25
						knockback = 0
						src.stop()
						return
					if(T!=15)
						T++
						knockback = 1
						Attacking = 0
						vel_x = -20
						spawn(1.5*world.tick_lag)goto loop


		knockbackeast()
			if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || Real_C == 0 && !_Special_Puppet_ || KakashiChidori || Rasengan || Chidori || DinamicEntry || Iron) return
			flick("mob-knockback", src)
			Attacking = 0
			var/T=0
			dir = WEST
			knockback = 1
			vel_y+=10
			vel_x=20
			New_Knockback = rand(1, 99999999)
			var/KN = New_Knockback
			spawn()
				loop
					if(KN != New_Knockback || !knockback) return
					dir=WEST
					fall_speed = 5
					if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || freeze || T >= 30)
						fall_speed = 25
						knockback = 0
						src.stop()
						return
					if(T!=30)
						T++
						Attacking = 0
						knockback = 1
						vel_x = 20
						spawn(1.5*world.tick_lag)goto loop

		knockbackwest(atom/a, magnitude = 3)
			if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || Real_C == 0 && !_Special_Puppet_ || KakashiChidori || Rasengan || Chidori || DinamicEntry || Iron) return
			flick("mob-knockback", src)
			Attacking = 0
			dir = EAST
			knockback = 1
			var/T=0
			vel_y+=10
			vel_x=-20
			New_Knockback = rand(1, 99999999)
			var/KN = New_Knockback
			spawn()
				loop
					if(KN != New_Knockback || !knockback) return
					dir=EAST
					fall_speed = 5
					if(Gates == 1 || Boulder >= 1 || BoulderX >= 1 || freeze || T >= 30)
						fall_speed = 25
						knockback = 0
						src.stop()
						return
					if(T!=30)
						T++
						knockback = 1
						Attacking = 0
						vel_x = -20
						spawn(1.5*world.tick_lag)goto loop
var/Messages
mob/var/DelayC = 0

mob
	proc
		Run_Off()
			running = 0
			if(Flag == 0)
				move_speed = speed_multiplier* 8.5
				if(ultra_speed == 0.5) move_speed = 0.85
				if(Gates==1) move_speed = 30
				if(Boulder>=1) move_speed = 50
				if(BoulderX>=1) move_speed = 75
			if(!speed_multiplier) move_speed = 0
			if(Flag == 1) move_speed = 10
			if(Poison) move_speed -= 1.5

			var/Percentage = 100*(HP/MaxHP)
			if(Percentage <= 70) move_speed /= 1.05
			if(Percentage <= 60) move_speed /= 1.05
			if(Percentage <= 50) move_speed /= 1.05
			if(Percentage <= 60) move_speed /= 1.05
			if(Percentage <= 70) move_speed /= 1.05
			if(Percentage <= 80) move_speed /= 1.05
			if(Percentage <= 90) move_speed /= 1.075
			move_speed *= Movement_Boost
mob
	verb
		Contact_Dragonpearl()
			if(DelayC)
				src<<"<b><font color=red><u>Wait, don't use this command too fast!"
				return
			var/T=input("Please, type below your message.", "Contact Pearl") as text
			var/Person = src.key
			if(!T) return
			if(length(T) >= 300)
				src<<"<b><font color=red><u>Your message is too long!</u></font>"
			DelayC = 1
			spawn(30) DelayC = 0
			Messages += "<br><font color=white><font size=2><b>[time2text(world.realtime)]</b> - ([src.key]) - [html_encode(T)]"
			var/C = 0
			for(var/mob/M)
				if(M.key == "Dragonpearl123")
					M<<"<b><font color=#5CB3FF>[T] ~by [Person].<b> <a href='?src=\ref[src];action=Reply;User=[Person]'><i>Reply</i></a></b></font>"
					C++
			if(C == 0) src<<"<b><font color=#8EFCF9><font size=2><i>Dragon Pearl is currently offline, he will read your message right after getting online!</i></b>"
			if(C >= 1)
				src<<"<b><font color=#8EFCF9><font size=2><i>Dragon Pearl is currently online, he will shortly read your message!</i></b>"
mob

	pwidth = 32
	pheight = 48

	base_state = "mob"

	var
		Ryo_Multiplied = 0
		C=0
		Characters
		dead=0
		Background/my_background

	Logout()
		if(Chatroom) Chatroom.Leave(src)
		src.Body_Offline = 1
		src.SaveScores()
		Update_Scores()
		src << sound(null)

		var/Announced = 0
		if(Multikeying) Announced = 1

		if(!Announced)
			if(key == "SilentWraith")
				del(Admin_Log)
				Announced = 1

			if(key == "Dragonpearl123")
				world<<"<b>- {Owner} Dragon Pearl has logged off! -</b>"
				Announced = 1

			if(GM && !Announced)
				world<<"<b>- {[GM_Rank]} [key] has logged off! -</b>"
				Announced = 1

			if(!Announced)  world<<output("<b>- [key] has logged off! -</b>","Chat")

		if(name == "Minato Namikaze")
			for(var/mob/Absorbing_Barrier/A in world) del(A)
			for(var/mob/Space_Time_Barrier/S in world) del(S)

		if(Fighters.Find(src) && !dead)
			Village = rand(1, 300000000)
			Deaths = 4
			HP = -10
			Death_Check()
			Tourney_List.Remove(src)
			Fighters.Remove(src)
			Checked_X = 0
			loc = null
			world<<"<b><font color=#FFD203><center><font size=3>One of the fighters has disconnected, restarting round!"
			for(var/mob/M in world)
				if(M.Bet)
					M.Ryo_Reward(M.Bet)
					M.Bet = 0
			Red_Team_Bets = list()
			Blue_Team_Bets = list()
			Red_Team = null
			Blue_Team = null
			Tournament_Restart()

		if(Squad) if(Squad.Leader == src)
			var/O
			if(length(Squad) == 1) del(Squad)
			else for(var/mob/M in Squad.Members) if(M != src) for(var/obj/Effects/Player_Icon/I in M.Overlays) I.icon_state = "[O][Squad.Color]"


		if(Boss == 1)
			world<<output("<b><font size=3><font color=[admin_color]>The Boss logged off, rebooting!","Chat")
			for(var/mob/M)
				if(M.Guardian == 1 && M.dead == 0)
					M.HP = -10
					M.Deaths = 50
					M.Death_Check ("Boss")
			Auto_Balancer = 1
			fdel("Scoreboard.sav")
			for(var/mob/M)
				if(M.client)
					M.SaveScores()
					Ranking(M)
			for(var/mob/M) RankingDisplay(M)
			Check_Winner_Score()
			sleep(30)
			Auto_Balancer = 1
			world.Reboot()

		if(Flag == 1)
			if(Village == "Leaf")
				//new/mob/Akatsuki_Flag (src.loc)
				//world<<"<b><font size=2><font color=#00FF00><u>[src.name] has dropped Akatsuki's Flag!</u></center></font>"
				for(var/obj/Akatsuki_Flag_Spawn/A in world) new/mob/Akatsuki_Flag (A:loc)
				world<<"<b><font size=2><font color=#8904B1><u>Akatsuki's Flag has been respawned!</u></center></font>"
			if(Village == "Akatsuki")
				//new/mob/Leaf_Flag (src.loc)
				//world<<"<b><font size=2><font color=#8904B1><u>[src.name] has dropped Leaf's Flag!</u></center></font>"
				for(var/obj/Leaf_Flag_Spawn/A in world) new/mob/Leaf_Flag (A:loc)
				world<<"<b><font size=2><font color=#00FF00><u>Leaf's Flag has been respawned!</u></font>"
		if(Controlling_Shadow == 1) for(var/obj/Shadow/S in world) del(S)
		if(name != key && NEM_Round) Check_Winner(NEM_Round)
		if(name == key) del(src)
		if(Rebooting) del(src)
		if(NEM_Round && NEM_Round.Mode == "Arena") {Dragonned = 1000; freeze = 1000; spawn(75) {if(client) {freeze = 0; Dragonned = 0}; else del(src)}}
		if(Mission_On)
			Mission_On.Leave(src)
			if(NEM_Round.Type == "Mission")
				if(!NEM_Round.Cut_Scene) spawn(75) {var/mob/T; for(var/mob/M in NEM_Round.Ninjas) if(M.client && !M.dead && M != src) T = M; for(var/mob/Mission_NPC/M in NEM_Round.Ninjas) if(M.Target == src) {if(T) M.Target = T; M.Active_AI = 0}}; del(src)
				if(NEM_Round.Cut_Scene) del(src)
		..()

mob/var/Time = 0
mob/var/Confirmed = 0
mob/proc/Is_Fan()
	if(!ckey)
		return 0
	var/http[]=world.Export("http://www.byond.com/games/SilentWraith/NEM?command=view_fans")
	if(!http)
		return 0
	var/fanData=html_encode(file2text(http["CONTENT"]))
	if(findtext(fanData,"/[ckey]&"))
		return 1
	else
		return 0

var/list/NonFans = list()
mob/var/Absorbed = 0
mob/var/Kamui = 0
var/list/Donators_Keys = list()
var/list/Donators_IPs = list()
var/list/Donators_CIs = list()
mob/var/Recovering = 0
mob/var/Mute_Time = 0
mob/proc/Count_Time()
	loop
		if(!client) return
		spawn(10)

			if(NEM_Round && NEM_Round.Mode == "Arena")
				if(!Boulder && !BoulderX && !Controlling && !Attacking && !Attacked && !knockback && !knocked && !freeze && Regenerate_Chakra >= 1)
					HP = MaxHP
					Cha = MaxCha
					Energy = MaxEnergy

			if(Challenge_Cooldown) Challenge_Cooldown --
			if(Mute_Time > 0) Mute_Time --
			if(Mute_Time == 0 && Mute)
				world<<"<b><u><font color=[admin_color]>[key] has been automatically unmuted!</u>"
				Mute = 0

			Statistic.Time_Played++
			if(Thanked)
				Thanked ++
				if(Thanked >= 300)
					Thanked = 0
					src<<"<b><font color=red><u><center>You can now use * Thank You *!</center></font></u>"

			goto loop

mob/var/Sound = 0
mob/var/On_Special_Character_Screen = 0
mob/var/Ryo_Reward_Boost = 1
mob/var/_Name = "None"
mob/var/Avatar = 'Graphics/Faces/Question.dmi'

obj/Screen
	Time
		screen_loc = "1,1"
		mouse_opacity = 0
		New()
			icon = Screen_Icon
			..()
			spawn() layer = 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000


mob/proc/Mist()
	..()
	for(var/obj/Screen/Time/T in client.screen) del(T)
	var/T = new/obj/Screen/Time
	client.screen += T
	spawn(150) for(var/obj/Screen/Time/V in client.screen) del(V)

var/Screen_Icon = 'Graphics/MistXX.dmi'
mob/var/Saved_Day

mob/verb/Donate()
	var/Window = {"<STYLE>BODY {scrollbar-DarkShadow-Color:#000000;scrollbar-Shadow-Color:#262626;scrollbar-base-color:#484848;scrollbar-arrow-color:#686868;background: black; color: white}</STYLE>
	<html>
	<body>
	<b><font size=5><center><font color=#840000>* <u>Packages</u> *</font></font size></center>
	<br>
	<br><font color=#930000><font size=2><u>By donating you extend the time this server is hosted!</u>
	<br>* The Packages last forever!
	<br>* You can gift a package, but you can not give yours to another person.
	<br>* Hanabi, Special ANBU, Minato Namikaze, Rinnegan Tobi & Eternal Sasuke can only go to 1 side.
	<br>* You can share your customs with whoever you want for 1 round.
	<br><i>The game doesn't automatically recognize your purchases, so please use Advise to tell the Owner if you bought a package, after that he'll give you the custom(s) you bought.</i>
	<br><center>
	<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target="_top">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="PVJPSR4MGR8J4">
<table>
<tr><td><input type="hidden" name="on0" value="Packages">Packages</td></tr><tr><td><select name="os0">
	<option value="Ranked Characters">Ranked Characters $5.00 USD</option>
	<option value="Hanabi & Special Anbu">Hanabi & Special Anbu $10.00 USD</option>
	<option value="Yagura(50%off)">Yagura(50%off) $5.00 USD</option>
	<option value="Chikushodo(Sale)">Chikushodo(Sale) $8.00 USD</option>
	<option value="Kushimaru(Sale)">Kushimaru(Sale) $8.00 USD</option>
	<option value="Rinnegan Tobi">Rinnegan Tobi $10.00 USD</option>
	<option value="Eternal Sasuke(Clearance)">Eternal Sasuke(Clearance) $3.00 USD</option>
	<option value="Minato Namikaze(Sale)">Minato Namikaze(Sale) $5.00 USD</option>
	<option value="Torune">Torune $20.00 USD</option>
	<option value="Lord Itachi(Sale)">Lord Itachi(Sale) $15.00 USD</option>
</select> </td></tr>
</table>
<input type="hidden" name="currency_code" value="USD">
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>"}
	usr << browse(Window,"window=Updates;size=525x400")




mob
	Login()
		..()
		client.view = "32x15"
		Avatar = Question
		winset(src, "default.Avatar","image=\ref[Avatar]")
		src.Count_Time()
		src.Body_Real = 1
		src.Body_Offline = 0
		src.Real_Person = 1
		if(!Recovering)
			Check_Icon = 1
			Substitution = 1
			Recover()
			if(!On_Special_Character_Screen)
				loc = locate(20, 56, 2)
				set_pos((x*32)+44, (y*32)+8)
			check_loc()
		Real = 1
		Checked_X = 1
		if(name != key)
			if(client)
				winset(src, "default.Avatar","image=\ref[Avatar]")
				winset(src, "default.Avatar_Name","text-color=[Text_Color]")
				winset(src, "default.Avatar_Name","text=[_Name]")
			if(Mind_Controlled)
				Target.client.perspective = EYE_PERSPECTIVE
				Target.client.eye = Mind_Controlled
			Dragonned = 0
			freeze = 0
			Real = 1
			Checked_X=1
			knockback = 0
			Attacked = 0
			Attacking = 0

	//	if(NEM_Round && NEM_Round.Type == "King Of The Hill")
	//		winset(src, "default.Arena", "text=Squads")
	//		winset(src, "default.Arena", "command=Squads")
	//	else
		winset(src, "default.Avatar_Name","text-color=#969696")
		winset(src, "default.Avatar_Name","text=None")

		if(name != key)
			if(NEM_Round.Type == "Tourney" && Lost_Tourney) if(alert(src, "Would you like to leave Tournament?", "Leave Tourney", "No", "Yes") == "Yes") if(NEM_Round.Type == "Tourney")
				Respawn()
				Current_NEM_Round.Join(src)
			if(NEM_Round == Current_NEM_Round && dead && Question_Time) Question(Question_Time, 1)

		else
			if(Question_Time) Question(Question_Time)
			verbs+=typesof(/mob/Dead/verb)
			Active_M = 0
			Moving = 0
			src.LoadScores()

			spawn()

				if(!Statistic.Got_Village && !Statistic._Village_)
					Statistic.Got_Village = 1
					var/list/_A_ = list()
					var/Alliance/Lowest
					for(var/Alliance/A in Alliances) if(A.Type == "Village") _A_.Add(A)
					for(var/Alliance/A in _A_) if(!Lowest || length(A.Members) < length(Lowest.Members)) Lowest = A
					Statistic.Village = Lowest.Name
					Statistic._Village_ = Lowest
					Statistic.Rogue = 0
					Lowest._Members.Add(src)
					Lowest.Members.Add(Statistic)
					Lowest.Organize()
					if(Lowest.Type == "Organization") Statistic.Rank_Update("Akatsuki")
					else Statistic.Rank_Update("Normal")

				if(client.IsByondMember())

					src<<"<b><font color=[admin_color]><u><center><font size=2>Thank you for supporting BYOND!</u></center>"
					if(Statistic.Rank == "Academy Student")
						src<<"<b><font color=[admin_color]><center>You're now a Genin!</center>"
						Statistic.Rank = "Genin"

					var/Day = time2text(world.realtime,"DD")
					if(Saved_Day != Day)
						Saved_Day = Day
						Ryo_Reward(30)

			src.freeze = 1
			if(Allow_New_Users == 0 && src.Body_Next == 1)
				src.freeze = 1
				src.CanMove = 0
				src.CanChoose = 0
				src.CreatedAVotation = 1
				src.loc = locate(278, 10, 2)
				src.set_pos((x*32)+44, (y*32)+8)
				src.On_Special_Character_Screen = 1
				src.verbs+=typesof(/mob/Dead/verb)

		if(!Sound)
			var/sound/S = sound('Naruto Eternal Memories Song.ogg', 1, 0, 0, 85)
			src << S

		pwidth = 32
		pheight = 48
		src.Body_Next = 0




mob/var/Fan = 0
var/Players = 0
var/list/Been_Here = list()
mob
	base_state = "mob"
	var/Times_Checked = 0
mob
	proc
		Always_Freeze()
			..()
			loc = locate(1, 1, 1)
			vel_x = 0
			vel_y = 0
			Moving = null
			Checked_X = 0
			Substitution = 1
			freeze = 666
			Times_Checked = 0
			Times_Checked ++
			if(Times_Checked >= 20) del(src)
			if(Times_Checked < 20)
				spawn(30) Always_Freeze()

		Chakra_Rod()
			..()
			var/Times = 0
			freeze ++

			loop
				if(Times >= 5)
					Doming = 0
					CanMove = 1
					Can_Substitution = 1
					if(!knocked) freeze --
					return
				icon_state = "hurt"
				Doming = 1
				Times++
				Can_Substitution = 0
				spawn(3.85) goto loop

		Go_Freeze()
			..()
			var/Times = 0
			freeze ++
			loop
				if(Times >= 5)
					Doming = 0
					CanMove = 1
					Can_Substitution = 1
					if(!knocked) freeze --
					return
				Doming = 1
				icon_state = "hurt"
				Times++
				Can_Substitution = 0
				spawn(4) goto loop

		Go_Dead()
			..()
			var/_CNR = Current_NEM_Round
			spawn(10)
				loop
					if(!dead || Current_NEM_Round != _CNR) return
					if(!vel_y)
						Moving = 0
						stop()
					else spawn(10) goto loop

mob/var/Can_Substitution = 1
mob/var/_Assists = 0
mob/var/SeeEffects
mob/var/New_Knockback

var/list
	Donators = list("TeenGogeta", "Cb12")
	Hanabi_Owners = list("KiloJay", "Maelo uchiha", "Chibi Sonic")
	Torune_Owners = list("TeenGogeta")
	Yagura_Owners = list()
	Kushimaru_Owners = list("Xioshen")
	Chikushodo_Owners = list("Cb12")
	Lord_Itachi_Owners = list("OXuchihaXO", "CrimsonxPhoenix")
	Special_ANBU_Owners = list("KiloJay", "Maelo uchiha", "Cb12", "Chibi Sonic")
	Rinnegan_Tobi_Owners = list("Cb12", "Xlordkiller")
	Eternal_Sasuke_Owners = list("KiloJay", "Cb12")
	Minato_Namikaze_Owners = list("Xlordkiller")

mob/Dragonpearl123/verb/Pwipe_Packages()
	set category = "Server"
	if(alert(src, "Are you sure?", "Pwipe Packages", "No", "Yes") == "Yes")
		if(alert(src, "Are you sure?", "Pwipe Packages", "Yes", "No") == "Yes")
			if(alert(src, "Are you sure?", "Pwipe Packages", "No", "Yes") == "Yes")
				Donators = list("TeenGogeta", "Cb12")
				Hanabi_Owners = list("KiloJay", "Maelo uchiha", "Chibi Sonic")
				Torune_Owners = list("TeenGogeta")
				Yagura_Owners = list()
				Kushimaru_Owners = list("Xioshen")
				Chikushodo_Owners = list("Cb12")
				Lord_Itachi_Owners = list("OXuchihaXO", "CrimsonxPhoenix")
				Special_ANBU_Owners = list("KiloJay", "Maelo uchiha", "Cb12", "Chibi Sonic")
				Rinnegan_Tobi_Owners = list("Cb12", "Xlordkiller")
				Eternal_Sasuke_Owners = list("KiloJay", "Cb12")
				Minato_Namikaze_Owners = list("Xlordkiller")

mob/Dragonpearl123/verb/Grant_Package()
	set category = "Server"
	var/T = input("What BYOND Key", "Grant Package") as text
	if(!T) return
	var/P = input("What Package?\n\nBYOND Key: [T]", "Grant Package") as null | anything in list("Ranked Characters", "Hanabi", "Torune", "Yagura", "Kushimaru", "Chikushodo", "Lord Itachi", "Special ANBU", "Rinnegan Tobi", "Eternal Sasuke", "Minato Namikaze")
	if(!P) return
	var/C = input("Are you sure?\n\nGranting [P] to [T]", "Grant Package") in list("No", "Yes")
	if(C == "No") return
	else if(P == "Ranked Characters") Donators.Add(T)
	else if(P == "Hanabi") Hanabi_Owners.Add(T)
	else if(P == "Torune") Torune_Owners.Add(T)
	else if(P == "Yagura") Yagura_Owners.Add(T)
	else if(P == "Kushimaru") Kushimaru_Owners.Add(T)
	else if(P == "Chikushodo") Chikushodo_Owners.Add(T)
	else if(P == "Lord Itachi") Lord_Itachi_Owners.Add(T)
	else if(P == "Special ANBU") Special_ANBU_Owners.Add(T)
	else if(P == "Rinnegan Tobi") Rinnegan_Tobi_Owners.Add(T)
	else if(P == "Eternal Sasuke") Eternal_Sasuke_Owners.Add(T)
	else if(P == "Minato Namikaze") Minato_Namikaze_Owners.Add(T)
	src<<"<b><font color=[admin_color]><u>You've added [P] Package to [T]!</u>"
	for(var/mob/M in world) if(M.key == T) M<<"<b><font color=[admin_color]><u><font size=3>You've been given [P] Package</u>!<br>Please relog to unlock it :3"

mob/Dragonpearl123/verb/Packages()
	set category = "Server"
	if(length(Donators)) src<<"<b><font color=[admin_color]><u>Ranked Characters</u>"
	for(var/S in Donators) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Hanabi_Owners)) src<<"<b><font color=[admin_color]><u>Hanabi</u>"
	for(var/S in Hanabi_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Torune_Owners)) src<<"<b><font color=[admin_color]><u>Torune</u>"
	for(var/S in Torune_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Yagura_Owners)) src<<"<b><font color=[admin_color]><u>Yagura</u>"
	for(var/S in Yagura_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Kushimaru_Owners)) src<<"<b><font color=[admin_color]><u>Kushimaru</u>"
	for(var/S in Kushimaru_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Chikushodo_Owners)) src<<"<b><font color=[admin_color]><u>Chikushodo</u>"
	for(var/S in Chikushodo_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Lord_Itachi_Owners)) src<<"<b><font color=[admin_color]><u>Lord Itachi</u>"
	for(var/S in Lord_Itachi_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Special_ANBU_Owners)) src<<"<b><font color=[admin_color]><u>Special ANBU</u>"
	for(var/S in Special_ANBU_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Rinnegan_Tobi_Owners)) src<<"<b><font color=[admin_color]><u>Rinnegan Tobi</u>"
	for(var/S in Rinnegan_Tobi_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Eternal_Sasuke_Owners)) src<<"<b><font color=[admin_color]><u>Eternal Sasuke</u>"
	for(var/S in Eternal_Sasuke_Owners) src<<"<b><font color=[admin_color]>- [S]"
	if(length(Minato_Namikaze_Owners)) src<<"<b><font color=[admin_color]><u>Minato Namikaze</u>"
	for(var/S in Minato_Namikaze_Owners) src<<"<b><font color=[admin_color]>- [S]"