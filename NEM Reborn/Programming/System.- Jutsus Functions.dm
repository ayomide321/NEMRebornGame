obj/proc
	Wind_Wave()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(20)
		Flick("Doton", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(3)
		Executor.Execute_Jutsu("Wind Release.- Wave!")
		new/obj/Doton_Effect (Executor.loc, Executor, Executor.dir, 50)
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()
	Water_Vortex()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(20)
		if(Executor.name != "Kushimaru") Flick("punch4", Executor)
		if(Executor.name == "Kushimaru") Flick("punch1", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(3)
		Executor.Execute_Jutsu("Water Release.- Vortex!")
		new/obj/Water_Effect (Executor.loc, Executor, Executor.dir, 50)
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()

	Akamaru_Transformation()
		var/mob/Executor = usr
		On_Ground = 1
		if(Executor.Can_Execute(src, 0) == 0) return
		Executor.freeze ++
		Executor.stop()
		Flick("jutsu", Executor)
		sleep(3)
		var/Target = 0
		for(var/mob/NPC/Akamaru/A in hearers(15))
			if(!A.knocked && A.icon == 'Graphics/Characters/Kiba.dmi')
				Target = 1
				Executor.freeze --
				if(Executor.Can_Execute(src, 50) == 0) return
				Delay(5)
				Executor.Execute_Jutsu("Beast Transformation!")
				var/B = new/obj/BigSmoke (Executor.loc)
				B:pixel_x = Executor.pixel_x
				B:pixel_y = Executor.pixel_y
				A.icon = 'Graphics/Skills/Akamaru.dmi'
				A.Check_Icon = 1
				A.Str = 13.25
				A.Def = 7

			else if(!A.knocked && A.icon == 'Graphics/Skills/Akamaru.dmi')
				Target = 1
				Executor.freeze --
				if(Executor.Can_Execute(src, 50) == 0) return
				Delay(5)
				Executor.Execute_Jutsu("Beast Transformation!")
				var/B = new/obj/BigSmoke (Executor.loc)
				B:pixel_x = Executor.pixel_x
				B:pixel_y = Executor.pixel_y
				A.icon = 'Graphics/Characters/Kiba.dmi'
				A.Check_Icon = 1
				A.Str=12.50
				A.Def=6.50
		spawn(5)
			if(!Target)
				Delay(3)
				Executor.freeze --
				Executor.stop()
	Wolf_Fang_Over_Fang()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		src.On_Ground = 1
		src.Capture_The_Flag = 1
		src.Tournament_GoingOn = 1
		if(Executor.freeze || Executor.dead || Executor.Attacking || Executor.Boulder || Executor.BoulderX) return
		for(var/mob/NPC/Akamaru/A in hearers(15))
			if(A.icon == 'Graphics/Characters/Kiba.dmi')
				Executor<<output("<b><font color=red>Akamaru must be on his normal form!","Chat")
				return
			if(A.freeze)
				Executor<<output("<b><font color=red>Akamaru must be able to move!","Chat")
				return
			if(A.dead == 1)
				Executor<<output("<b><font color=red>Akamaru must be alive!","Chat")
				return
			if(A.knocked == 0)
				if(Executor.Can_Execute(src, 100) == 0) return
				Delay(90)
				Akamaru = 0
				var/B = new/obj/BigSmoke (Executor.loc)
				B:pixel_x = Executor.pixel_x
				B:pixel_y = Executor.pixel_y
				Executor.Execute_Jutsu("Wolf Fang Over Fang!")
				Executor.BoulderX = 1
				Executor.move_speed = 75
				Executor.Dragonned = 1
				Executor.freeze ++
				Executor.Real = 0
				Flick("jutsu", Executor)
				sleep(5)
				Executor.freeze --
				del(A)
				Executor.icon = 'Graphics/Skills/WolfFang.dmi'
				Flick("boulder", Executor)
				if(Executor.dir == EAST) Executor.vel_x = 50
				if(Executor.dir == WEST) Executor.vel_x = -50
				spawn(300)
					if(Executor.BoulderX)
						Flick("fang", Executor)
						Executor.move_speed = 12
						Executor.Dragonned = 0
						Executor.BoulderX = 0
						Executor.Real = 1
						sleep(5)
						Executor.icon = 'Graphics/Characters/Kiba.dmi'





	Akamaru_Summon()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Tournament_GoingOn = 1
		if(!Executor.loc) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 0) == 0) return
		Flick("jutsu", Executor)
		Executor.freeze ++
		sleep(1.5)
		Executor.freeze --
		Executor.stop()
		if(Executor.freeze == 0 && Executor.Dragonned == 0 && Executor.knocked == 0 && !Executor.knockback)
			for(var/mob/NPC/Akamaru/A) if(!A.dead && A.Clone_Creator == Executor)
				Delay(3)
				if(!Executor.loc) return
				Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Akamaru!")
				for(var/mob/D)
					if(D.AttackedbyAkamaru == 1) D.AttackedbyAkamaru = 0
				switch(rand(1,2))
					if(1)
						A:loc = Executor.loc
						A:dir = EAST
						A:x += 2
					if(2)
						A:loc = Executor.loc
						A:dir = WEST
						A:x -= 2
				return

		if(Executor.Can_Execute(src, 25) == 0) return
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Akamaru!")
		if(!Executor.loc) return
		var/B = new/mob/NPC/Akamaru(Executor.loc)
		B:Clone_Creator = Executor
		B:MaxHP = Executor.MaxHP/1.25
		B:HP = B:MaxHP
		B:Str = Executor.Str/1.1
		B:Def = Executor.Def/1.1
		B:Village = Executor.Village
		B:Deaths = 3
		switch(rand(1,2))
			if(1)
				B:dir = EAST
				B:x += 2
			if(2)
				B:dir =WEST
				B:x -= 2
		return
	Rashomon()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(60)
		Flick("rash", Executor)
		Executor.Attacking ++
		sleep(2.5)
		Executor.Execute_Jutsu("Rashomon!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/A = new/mob/Rashomon(Executor.loc)
		A:Village = Executor.Village
		A:Creator = Executor.name
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x+=3
		if(Executor.dir == WEST) A:x-=5
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()
	Rashomon2()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(60)
		Flick("heal2", Executor)
		Executor.Attacking ++
		sleep(2.5)
		Executor.Execute_Jutsu("Rashomon!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/A = new/mob/Rashomon2(Executor.loc)
		A:Village = Executor.Village
		A:Creator = Executor.name
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x+=3
		if(Executor.dir == WEST) A:x-=5
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()


	Flame_Imprisonment()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Special_ == 96) for(var/obj/Effects/Flame_Imprisonment/F in world) del(F)

		else
			src.Executed_Fully = 1
			if(Executor.Can_Execute(src, 20) == 0) return
			Executor.freeze ++
			Executor.stop()
			var/Target = 0
			var/obj/Bounds/Bounds = new/obj/Bounds (Executor.loc, Executor, 140, 100)
			var/list/Enemy = Bounds.Enemy()
			for(var/mob/M in Enemy)
				if(M.Dodging == 1)
					Delay(15)
					Executor.freeze --
					for(var/obj/Jutsus/Flame_Battle_Encampment/F in Executor) F.Delay(10)
					for(var/obj/Jutsus/Fire_Dragon_Tobi/F in Executor) F.Delay(2)
					for(var/obj/Jutsus/Huge_Fire_Sphere_Tobi/F in Executor) F.Delay(2)
					for(var/obj/Jutsus/Giant_FireBall_Tobi/F in Executor) F.Delay(2)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return

				Target ++
				Executor.Executed_Fully = 1
				Executor.Dragonned = 1
				M.Can_Dodge_ = 1
				M.Dragonned = 1
				M.freeze ++
				Executor.Teleport_Behind_(M, Executor)
				sleep(rand(3.75, 4.5))
				M.Can_Dodge_ = 0
				if(M.Dodging)
					Delay(15)
					for(var/obj/Jutsus/Flame_Battle_Encampment/F in Executor) F.Delay(10)
					for(var/obj/Jutsus/Fire_Dragon_Tobi/F in Executor) F.Delay(2)
					for(var/obj/Jutsus/Huge_Fire_Sphere_Tobi/F in Executor) F.Delay(2)
					for(var/obj/Jutsus/Giant_FireBall_Tobi/F in Executor) F.Delay(2)
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
					M.freeze --
					M.Dragonned = 0
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					return
				Executor.Dragonned = 0
				Flick("mob-shooting", Executor)
				Executor.icon_state = "mob-shooting"
				spawn(2.5)
				Executor<<"<b><font color=#9F000F><u>Press X to stop using this jutsu.</b></u></font>"
				Executor.Special_ = 96
				Executor.Doming = 1
				Executor.Execute_Jutsu("Flame Imprisonment!")
				var/obj/F = new/obj/Effects/Flame_Imprisonment(M.loc, M, null, Executor)
				F.layer = (M.layer) +10

			spawn() if(!Target)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()


	Advent_Of_Bugs()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(45)
		Executor.pixel_y -= 2
		Flick("Special IX", Executor)
		icon_state = "Special IX"
		Executor.Attacking ++
		Executor.Dragonned = 1
		Executor.stop()
		spawn(2.5)
		Executor.Doming = 1
		Executor.Execute_Jutsu("Advent Of Bugs!")
		var/A = new/mob/Advent_Of_Bugs(Executor.loc)
		A:step_x = Executor.step_x
		A:bound_x = Executor.bound_x
		A:bound_x = Executor.step_x
		A:Village = Executor.Village
		A:_Creator = Executor
		A:dir = Executor.dir
		if(Executor.dir == WEST)
			A:x -= 5
			A:pixel_x += 8
			A:bound_x -= 22
		if(Executor.dir == EAST)
			A:pixel_x += 64
			A:bound_x += 24
		A:set_pos(A)
		sleep(8.75)
		Executor.pixel_y += 2
		Executor.stop()
		Executor.Doming = 0
		Executor.Dragonned = 0
		Executor.Attacking --

	Earth_Dome()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Doming == 1)
			Executor.Doming = 0
			if(!Executor.knocked) Executor.icon_state = "mob-standing"
			for(var/mob/Earth_Dome/E in world) del(E)
		else
			if(Executor.Can_Execute(src, 25) == 0) return
			Delay(30)
			Flick("Dome", Executor)
			Executor.icon_state = "Dome"
			Executor.freeze ++
			Executor.Dragonned = 1
			sleep(1.5)
			Executor.Doming = 1
			Executor.Execute_Jutsu("Earth Dome!")
			var/A = new/mob/Earth_Dome(Executor.loc)
			A:Village = Executor.Village
			A:_Creator = Executor
			if(Executor.dir == EAST) A:x+=2
			if(Executor.dir == WEST)
				A:x -= 5
				A:pixel_x = -32
			sleep(5)
			Executor.Dragonned = 0
			loop
				Executor.icon_state = "Dome"
				if(Executor.Cha <= 0 || Executor.Attacked || !Executor.Doming || Executor.knocked)
					if(Executor.Cha < 5 && Executor.Doming == 1) Executor<<"<b><font color=#6EDEFF><u>You don't have enough chakra!</u></font>"
					Executor.Doming = 0
					Executor.icon_state = "mob-standing"
					Executor.stop()
					del(A)
				else
					Executor.Cha -= 5
					if(A)
						for(var/mob/M in A:Caught)
							new/obj/Hit (M.loc)
							M.HP -= 2.5
							M.Cha -= 2.5
							Flick("hurt", M)
							M.Death_Check(Executor)
					spawn(5)
						goto loop


	Flame_Tornado()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Tournament_GoingOn = 1
		src.Capture_The_Flag = 1
		if(CTD) return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Boss_Mode_ || Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(Tornado)
			Executor<<"<font color=red><b>This jutsu has been already used on this round!"
			return
		var/Clients
		for(var/mob/M in world) if(M.client) Clients ++
		if(Clients >= 25)
			Executor<<"<font color=red><b>This jutsu can't be executed when there are more than 25 players online!"
			return
		if(Executor.Can_Execute(src, Executor.MaxCha) == 0) return
		Tornado = 1
		Executor.freeze ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(4)
		Executor.NEM_Round.Shout("<font color=#990012><u><font size=3><b>The earth trembles as the Fire Tornadoes have been summoned to destroy everything!</u>")
		new/obj/Tobi_FT/Main (Executor.loc, Executor)

		spawn(3.5)
			Executor.Stop_Chakra(15, "Fire Tornado")
			Executor.freeze --
			Executor.stop()
			del(src)


	Space_Time_Barrier()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round && Executor.NEM_Round.Mode == "Arena") return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.pixel_y -= 12
		Flick("Sealing", Executor)
		Executor.Attacking ++
		Executor.stop()
		var/Barriers = 0

		for(var/mob/Space_Time_Barrier/P in world)
			Barriers ++
			P:New_B --

		if(Barriers > 1) for(var/mob/Space_Time_Barrier/S in world) if(S:New_B < 0) del(S)
		sleep(7.5)
		Executor.Execute_Jutsu("Sealing Formation: Space-Time Barrier!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/mob/A = new/mob/Space_Time_Barrier (Executor.loc)
		A:New_B = 1
		if(Executor.dir == EAST) A.dir = WEST
		if(Executor.dir == WEST) A.dir = EAST
		A.Village = Executor.Village
		A:Creator = Executor
		if(Executor.dir == EAST) A:x += 2
		if(Executor.dir == WEST) A:x -= 2
		spawn(3.5)
			Flick("teleport", Executor)
			Executor.pixel_y += 12
			Executor.Attacking --
			Executor.stop()
			var/M

			for(var/mob/Space_Time_Barrier/S in view(3)) if(S != A)
				if(!M) Executor << "<b><font color=red><u>Don't try to cheat! Your other barrier was too close...</u>"
				M ++
				del(A)

			for(var/mob/Absorbing_Barrier/S in view(3))
				if(!M) Executor << "<b><font color=red><u>Don't try to cheat! Your other barrier was too close...</u>"
				M ++
				del(A)

	Absorbing_Barrier()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round && Executor.NEM_Round.Mode == "Arena") return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(180)
		Executor.pixel_y -= 12
		Flick("Sealing", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(7.5)
		Executor.Execute_Jutsu("Sealing Formation: Genesis Rebirth!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/mob/A = new/mob/Absorbing_Barrier (Executor.loc)
		A.dir = Executor.dir
		A.Village = Executor.Village
		A:Creator = Executor
		if(Executor.dir == EAST) A:x += 2
		if(Executor.dir == WEST) A:x -= 2
		spawn(3.5)
			Flick("teleport", Executor)
			Executor.pixel_y += 12
			Executor.Attacking --
			Executor.stop()

	InkDragon()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(50)
		Executor.freeze ++
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Flick("mob-shooting", Executor)
		var/A=new/mob/InkDragon (Executor.loc, Executor.dir)
		A:Village = Executor.Village
		if(Executor.dir == EAST) A:x+=2
		if(Executor.dir == WEST) A:x-=2
		A:Owner = Executor
		A:pixel_x = Executor.pixel_x
		A:pixel_y = Executor.pixel_y
		spawn(10) Executor.freeze --
	Wood_Pillar()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(45)
		Flick("mob-shooting", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(2.5)
		Executor.Execute_Jutsu("Wood Pillar!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/A=new/mob/Wood_Pillar(Executor.loc)
		A:Village = Executor.Village
		A:Creator = Executor.name
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x+=2
		if(Executor.dir == WEST) A:x-=2
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()
	Earth_Walls()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 100) == 0) return
		Delay(45)
		Executor.Attacking ++
		Executor.stop()
		if(Executor.name != "Kakkou") Flick("mob-shooting", Executor)
		if(Executor.name == "Kakkou") Flick("Summon", Executor)
		sleep(3)
		Executor.Execute_Jutsu("Earth Release.- Walls!")

		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y

		var/A = new/mob/Earth_Wall(Executor.loc)
		A:Village = Executor.Village
		A:Creator = Executor.name
		A:x += 3
		A:dir = EAST
		var/D = new/mob/Earth_Wall(Executor.loc)
		D:Village = Executor.Village
		D:Creator = Executor.name
		D:x -= 3
		D:dir = WEST

		spawn(7.5)
			Executor.Attacking --
			Executor.stop()
	Earth_Wall_()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Flick("mob-shooting", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Earth Release.- Wall!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/A = new/mob/Earth_Wall(Executor.loc)
		A:Village = Executor.Village
		A:Creator = Executor.name
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x += 3
		if(Executor.dir == WEST) A:x -= 3
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()
	Earth_Wall()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(30)
		Executor.Attacking ++
		Executor.stop()
		Executor.pixel_y -= 7
		Flick("Summon", Executor)
		sleep(2.5)
		Executor.Execute_Jutsu("Earth Release.- Wall!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/A = new/mob/Earth_Wall(Executor.loc)
		A:Village = Executor.Village
		A:Creator = Executor.name
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x += 3
		if(Executor.dir == WEST) A:x -= 3
		spawn(3.5)
			Executor.pixel_y = 0
			Executor.Attacking --
			Executor.stop()
	Wind_Storm_T()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(45)
		Flick("Storm", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(5)
		var/A = new/mob/Wind_Storm_All/Storm(Executor.loc, Executor)
		Executor.Execute_Jutsu("Wind Release.- Storm!")
		if(Executor.dir == EAST) A:x+=1
		if(Executor.dir == WEST) A:x-=1
		Flick("1", A)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()
	Wind_Storm_Kinkaku()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(45)
		Flick("mob-shooting", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(5)
		var/A = new/mob/Wind_Storm_All/Storm(Executor.loc, Executor)
		Executor.Execute_Jutsu("Wind Release.- Storm!")
		if(Executor.dir == EAST) A:x+=1
		if(Executor.dir == WEST) A:x-=1
		Flick("1", A)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()
	Wind_StormD()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(45)
		Flick("Storm", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(5)
		var/A = new/mob/Wind_Storm_All/Storm(Executor.loc, Executor)
		Executor.Execute_Jutsu("Wind Release.- Storm!")
		if(Executor.dir == EAST) A:x+=1
		if(Executor.dir == WEST) A:x-=1
		Flick("1", A)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()
	Wind_Storm()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, 65) == 0) return
		Delay(45)
		Flick("rage2", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(5)
		var/A = new/mob/Wind_Storm_All/Storm(Executor.loc, Executor)
		Executor.Execute_Jutsu("Wind Release.- Storm!")
		if(Executor.dir == EAST) A:x+=1
		if(Executor.dir == WEST) A:x-=1
		Flick("1", A)
		spawn(3.5)
			Executor.Attacking --
			Executor.stop()
	Kamui_AK()
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.Can_Execute(src, Executor.MaxCha/2) == 0) return
		Delay(60)
		if(!Executor.on_ground) Flick("airpunch", Executor)
		else Flick("mob-shooting", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(2.5)
		new/mob/Portal (Executor.loc, Executor)
		Executor.Execute_Jutsu("Kamui!")
		spawn(1.5)
			Executor.Attacking --
			Executor.stop()
	Paper_Tornado()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 90) == 0) return
		Delay(60)
		Flick("WindEnd", Executor)
		Executor.Attacking ++
		Executor.stop()
		spawn()
			if(Executor.dir == EAST) Executor.pixel_x = -30
			if(Executor.dir == WEST) Executor.pixel_x = -18
			Executor.pixel_y = -9
		sleep(16)
		Executor.Execute_Jutsu("Paper Tornado!")
		var/A = new/mob/Wind_Supreme_Storm/Storm(Executor.loc, Executor)
		Flick("Go", A)
		if(Executor.dir == EAST) A:x += 2
		if(Executor.dir == WEST) A:x -= 2
		spawn()
			Executor.pixel_x = 0
			Executor.pixel_y = 0
			Flick("teleport", Executor)
			Executor.Attacking --
			Executor.stop()
	Paper_Hurricane()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 30) == 0) return
		Delay(5)
		Flick("rage2",Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(5)
		new/mob/Ultimate_Projectile/Paper_Hurricane(null, Executor)
		Executor.Execute_Jutsu("Paper Hurricane!")
		spawn(2.5)
			Executor.Attacking --
			Executor.stop()
	Amaterasu()
		if(Boss_Mode_) return
		if(Delay) return
		var/mob/Executor = usr
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		src.On_Ground = 1
		src.Tournament_GoingOn = 1
		if(CTD) return
		if(Executor.NEM_Round.Mode == "Challenge") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(Executor.NEM_Round.Type == "Mission") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		if(Executor.NEM_Round.Mode == "Arena") return
		if(Executor.Mind_Controlling)
			Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
			return
		if(AllowedAmaterasu == 0)
			Executor<<output("<b><font color=red>Amaterasu was disabled for this round, we're sorry.","Chat")
			return
		if(Executor.CanUseAmaterasu >= 1)
			Executor<<output("<b><font color=red>You can't use Amaterasu anymore!</b>","Chat")
			return
		var/Real_Name = Executor.name
		if(Executor.client)
			if(alert(Executor, "Are you sure? You won't be able to use Amaterasu again, and you'll be on your last life.", "Deadly Skill", "No", "Yes") == "Yes")
				if(Real_Name != Executor.name)return
				if(Executor.CanUseAmaterasu >= 1)
					Executor<<output("<b>You can't use Amaterasu anymore!</b>","Chat")
					return
				if(Executor.Can_Execute(src, 100) == 0) return
				Executor.CanUseAmaterasu ++
				Executor.Attacking ++
				Executor.Deaths = 3
				Executor.stop()
				Flick("katon", Executor)
				sleep(2.5)
				Executor.Execute_Jutsu("Amaterasu!")
				var/B = new/obj/BigSmoke (Executor.loc)
				B:pixel_x = Executor.pixel_x
				B:pixel_y = Executor.pixel_y
				new/mob/Ultimate_Projectile/Amaterasu(null, Executor)
				spawn(25)
					Executor.icon_state = "mob-standing"
					Executor.Attacking --
					Executor.stop()
					del(src)

	Poison_Smoke_Bomb()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(!AllowedPoison)
			Executor<<"<b><font color=red>Poison is not allowed on this round, we're sorry."
			return
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(15)
		Flick("seals", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(1.5)
		Executor.Execute_Jutsu("Poison Smoke Bomb!")
		var/A = new/obj/Poison_Smoke(Executor.loc)
		A:Village = Executor.Village
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x+=2
		if(Executor.dir == WEST) A:x-=2
		spawn(7.5)
			Executor.Attacking --
			Executor.stop()
	Kunai_Grenade()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 85) == 0) return
		Delay(30)
		Flick("Grenade", Executor)
		Executor.Attacking ++
		Executor.stop()
		sleep(8.5)
		Executor.Execute_Jutsu("Kunai Grenade!")
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		var/A=new /mob/ProjectileR/Kunai_Grenade(Executor, Executor.dir)
		if(Executor.dir == EAST) A:x+=1
		if(Executor.dir == WEST) A:x-=1
		A:owner = Executor
		A:Owner = Executor
		A:dir = Executor.dir
		spawn(10)
			Executor.Attacking --
			Executor.stop()
	Adamantine_Trap()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(45)
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		Flick("trap", Executor)
		sleep(5)
		for(var/mob/M in hearers(15))
			if(M.Village != Executor.Village && !M.knocked && M.Real && !M.Boulder && !M.BoulderX && !M.Gates && !M.Dragonned)
				if(M.Dodging)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				Target ++
				if(Target == 1) Executor.Executed_Fully = 1
				Executor.Execute_Jutsu("Adamantine Trap!")
				M.Dodging = 0
				M.Chakra_Rod()
				var/A=new/obj/Trap (M.loc)
				A:pixel_x = M.pixel_x
				A:pixel_y = M.pixel_y
				spawn(19.25) del(A)
		spawn(5)
			Executor.freeze --
			Executor.stop()

	Fire_Coffin()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(35)
		Flick("summon", Executor)
		Executor.freeze ++
		Executor.stop()
		var/Target = 0
		sleep(5)
		Flick("summon", Executor)
		spawn(3) Executor.Execute_Jutsu("Fire Coffin!")
		for(var/mob/M in hearers(15))
			if(M.Village != Executor.Village && !M.knocked && M.Real && !M.Boulder && !M.BoulderX && !M.Gates && !M.Dragonned)
				if(M.Dodging)
					M.Auto_Dodge (Executor)
					Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					continue
				Target ++
				if(Target == 1)
					Executor.Executed_Fully = 1
					Executor.Damage_Up(10+rand(5, 20))
				var/A=new/obj/Fire_Coffin (M.loc)
				A:pixel_x = M.pixel_x
				A:pixel_y = M.pixel_y
				M.Dodging = 0
				M.Go_Freeze()
				M.Damage(Executor, 10+rand(5, 20), 1, 0, 0, 0, 0, 1)
				spawn(18.5) del(A)
		spawn(5)
			Executor.freeze --
			Executor.stop()

	Explosive_Kunais()
		var/mob/Executor = usr
		src.On_Ground = 1
		src.Executed_Fully = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		var/list/choose=list()
		for(var/mob/D in hearers(15))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to use this jutsu on?", "Explosive Kunais") as null|anything in choose
		if(!M || M == "Cancel" || M == cancel)
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging)
				Delay(20)
				Executor.Cha -= 25
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			if(!M.Dodging)
				if(Executor.Can_Execute(src, 90) == 0) return
				Delay(45)
				M.icon_state = "mob-standing"
				M.Dragonned = 1
				M.freeze ++
				M.stop()
				Executor.Dragonned = 1
				Executor.freeze ++
				Executor.stop()
				Executor.Execute_Jutsu("I will finish you! Take this!")
				Flick("mob-shooting", Executor)
				sleep(3)
				var/A=new/obj/Dropped_Kunai2(M.loc)
				A:Owner = Executor
				A:pixel_y = M.pixel_y
				A:dir = WEST
				A:x += 1
				var/B=new/obj/Dropped_Kunai2(M.loc)
				B:Owner = Executor
				B:pixel_x -= 16
				B:pixel_y = M.pixel_y
				B:dir = WEST
				B:x += 2
				var/C=new/obj/Dropped_Kunai2(M.loc)
				C:Owner = Executor
				C:pixel_y = M.pixel_y
				C:dir = WEST
				C:x += 2
				var/D=new/obj/Dropped_Kunai2(M.loc)
				D:Owner = Executor
				D:pixel_y = M.pixel_y
				D:dir = EAST
				D:x -= 1
				var/E=new/obj/Dropped_Kunai2(M.loc)
				E:Owner = Executor
				E:pixel_y = M.pixel_y
				E:pixel_x += 16
				E:dir = EAST
				E:x -= 2
				var/F=new/obj/Dropped_Kunai2(M.loc)
				F:Owner = Executor
				F:pixel_y = M.pixel_y
				F:dir = EAST
				F:x -= 2
				sleep(10)
				Executor.Execute_Jutsu("Now EXPLODE!")
				sleep(2.5)
				del(A); del(B); del(C); del(D); del(E); del(F)
				new/obj/Hit(M.loc)
				var/Damage = rand(35,50)
				M.Damage(Executor, Damage, 1, 0)
				spawn(10)
					Executor.Dragonned = 0
					Executor.freeze --
					Executor.stop()
					M.Dragonned = 0
					M.freeze --
					M.stop()

	Earth_Fall()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 65)
			Executor.Cooldown_Display (65)
			return
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		var/list/choose=list()
		for(var/mob/D in hearers(15))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to use this jutsu on?", "Rock Lodging Destruction") as null|anything in choose
		if(!M || M == "Cancel" || M == cancel)
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(20)
				Executor.Cha -= 25
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(Executor.Can_Execute(src, 65) == 0) return
			Delay(45)
			Flick("Summon", Executor)
			Executor.icon_state = "Summon"
			Executor.Dragonned = 1
			Executor.freeze ++
			Executor.loc = M.loc
			M.icon_state = "mob-standing"
			M.Dragonned = 1
			M.freeze ++
			M.stop()
			if(Executor.dir == EAST) Executor.x -= 2
			if(Executor.dir == WEST) Executor.x += 2
			Executor.Execute_Jutsu("Rock Lodging Destruction!")
			var/Drain = 45+rand(0,10)
			M.Dragonned = 1
			var/O = new/obj/Rock_Log (M.loc)
			O:pixel_x = M.pixel_x
			O:pixel_y = M.pixel_y
			spawn(7) del(O)
			spawn(3)
				M.Damage(Executor, Drain, 1, 0)
				spawn(2)
					var/A=new/obj/GroundSmash(M.loc)
					if(M.dir==WEST) A:pixel_x-=15
					if(M.dir==EAST) A:pixel_x-=10
			spawn(10)
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.stop()
			spawn(15)
				Flick("teleport", Executor)
				Executor.icon_state = "mob-standing"
				Executor.Dragonned = 0
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()

	Hijutsu_Sensatsu_Suisho()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 65)
			Executor.Cooldown_Display (65)
			return
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		var/list/choose=list()
		for(var/mob/D in hearers(15))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to use this jutsu on?", "Hijutsu: Sensatsu Suisho") as null|anything in choose
		if(!M || M == "Cancel" || M == cancel)
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(20)
				Executor.Cha -= 25
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(Executor.Can_Execute(src, 65) == 0) return
			Delay(45)
			Executor.freeze ++
			Executor.loc = M.loc
			Executor.stop()
			M.icon_state="mob-standing"
			M.Dragonned = 1
			M.freeze ++
			M.stop()
			Flick("teleport", Executor)
			if(Executor.dir == EAST) Executor.x --
			if(Executor.dir == WEST) Executor.x ++
			Executor.Execute_Jutsu("Hijutsu: Sensatsu Suisho!")
			var/Drain = 50
			var/O = new/obj/Haku_Attack (M.loc)
			O:pixel_x = M.pixel_x
			O:pixel_y = M.pixel_y
			spawn(7.5)
				Executor.CanMove = 1
				Executor.freeze --
				Executor.stop()
			spawn(6) M.Damage(Executor, Drain, 1, 0)
			spawn(12)
				del(O)
				M.Dragonned = 0
				M.CanMove = 1
				M.freeze --
				M.stop()

	Red_Secret_Technique()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 65)
			Executor.Cooldown_Display (65)
			return
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		var/list/choose=list()
		for(var/mob/D in hearers(15))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to use this jutsu on?", "Red Secret Technique") as null|anything in choose
		if(!M || M == "Cancel" || M == cancel)
			Executor.PeinCD = 0
			return
		if(M.Dragonned || Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(20)
				Executor.Cha -= 25
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(Executor.Can_Execute(src, 65) == 0) return
			Delay(45)
			Executor.freeze ++
			Executor.stop()
			M.icon_state = "mob-standing"
			M.freeze ++
			M.stop()
			M.Dragonned = 1
			var/A = new/obj/RedSecret(M.loc)
			A:dir = pick(EAST, WEST)
			var/Picken_Dir = A:dir
			if(A:dir == EAST) A:x --
			if(A:dir == WEST) A:x ++
			Executor.Execute_Jutsu("Red Secret Technique!")
			Flick("scroll", Executor)
			sleep(9.5)
			Flick("hurt", M)
			var/HPDrained=45
			M.HP -= HPDrained
			new/obj/Hit(M.loc)
			if(M.Levitating) M.Check_Levitating()
			M.Death_Check(Executor)
			spawn(7.5)
				M.Dragonned = 0
				M.freeze --
				M.stop()
				if(Picken_Dir == EAST) M.knockbackeast()
				if(Picken_Dir == WEST) M.knockbackwest()
			spawn(10.5)
				Executor.freeze --
				Executor.stop()

	Man_Eating_Sharks()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 65)
			Executor.Cooldown_Display (65)
			return
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		var/list/choose=list()
		for(var/mob/D in hearers(15))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to use this jutsu on?", "Water Release.- Man Eating Sharks") as null|anything in choose
		if(!M || M == "Cancel" || M == cancel)
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(20)
				Executor.Cha -= 25
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return
			if(M.Dodging == 0)
				if(Executor.Can_Execute(src, 65) == 0) return
				Delay(45)
				Executor.freeze ++
				M.icon_state="mob-standing"
				M.freeze ++
				M.stop()
				M.Dragonned = 1
				var/A=new/obj/Sharks_(M.loc)
				A:pixel_y = M.pixel_y
				A:pixel_x = M.pixel_x
				A:pixel_x -= 45
				A:pixel_y -= 36
				Executor.Execute_Jutsu("Water Release.- Man Eating Sharks!")
				if(M.dir == EAST) A:dir = WEST
				if(M.dir == WEST) A:dir = EAST
				Flick("mob-shooting", Executor)
				sleep(11.5)
				var/HPDrained=45
				M.Damage(Executor, HPDrained, 1, 0)
				spawn(7)
					Executor.freeze --
					Executor.stop()
					M.Dragonned = 0
					M.freeze --
					M.stop()

	Lava_Punch()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 60)
			Executor.Cooldown_Display (60)
			return
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		var/list/choose=list()
		for(var/mob/D in hearers(15))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to use this jutsu on?", "Lava Punch") as null|anything in choose
		if(!M || M == "Cancel" || M == cancel)
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(20)
				Executor.Cha -= 25
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

		if(M.Dodging == 0)
			if(Executor.Can_Execute(src, 60) == 0) return
			Delay(40)
			M.Dragonned = 1
			M.freeze ++
			var/A = new/obj/Lava_Punch(M.loc)
			A:dir = pick(EAST, WEST)
			A:pixel_x = M.pixel_x
			if(A:dir == EAST) A:pixel_x -= 64
			if(A:dir == WEST) A:pixel_x += 32
			Executor.Execute_Jutsu("Lava Punch!")
			Flick("mob-shooting", Executor)
			sleep(9.5)
			var/HPDrained=42.5
			M.Damage(Executor, HPDrained, 1, 0)
			spawn(3.5)
				M.icon_state = "mob-standing"
				M.Dragonned = 0
				M.freeze --
				M.stop()

	Snake_Grasp()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 45)
			Executor.Cooldown_Display (45)
			return
		var/list/choose = list()
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		for(var/mob/D in hearers(15)) if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/mob/M = input("Who do you want to use this jutsu on?", "Snake Grasp") as null|anything in choose
		if(!M || M == "Cancel")
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(17)
				Executor.Activated = 0
				for(var/obj/Jutsus/Underground_Snake_Swamp/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Striking_Shadow_Snakes/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Snake_Summoning/J in Executor) J.Delay(10)
				Executor.Cha -= 15
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			if(M.Dodging == 0)
				if(Executor.Can_Execute(src, 45) == 0) return
				Delay(35)
				Executor.Activated = 0
				for(var/obj/Jutsus/Underground_Snake_Swamp/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Striking_Shadow_Snakes/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Snake_Summoning/J in Executor) J.Delay(15)
				Executor.freeze ++
				Executor.Dragonned = 1
				new/obj/Effects/Anko_Summoning (Executor.loc, Executor)
				M.icon_state = "mob-standing"
				M.Substitution = 1
				M.Dragonned = 1
				M.freeze ++
				M.stop()
				var/Direction = M.dir
				spawn(7.50)
					new/obj/Effects/Anko_Snake_I (M.loc, M)
					Executor.Execute_Jutsu("Snake Grasp!")
					spawn(1.15)
						if(M.dir == EAST) M.step_x += 10
						else M.step_x -= 10
						M.step_y += 16
						M.dir = Direction
					spawn(2.30)
						if(M.dir == EAST) M.step_x -= 6
						else M.step_x += 6
						M.step_y += 64
						M.dir = Direction
					spawn(3.45)
						M.invisibility = 101
						M.Poison_Proc(5, Executor.name)
						M.Damage(Executor, 25+rand(1, 15), 0, 0)
						M.dir = Direction
					spawn(31.15)
						M.invisibility = 0
						if(M.dir == EAST) M.step_x += 6
						else M.step_x -= 6
						M.step_y -= 64
						M.dir = Direction
					spawn(32.30)
						if(M.dir == EAST) M.step_x -= 10
						else M.step_x += 10
						M.step_y -= 16
						M.dir = Direction
					spawn(34.60)
						M.Death_Check (Executor)
						M.dir = Direction
						M.Substitution = 0
						M.Dragonned = 0
						M.freeze --
						M.stop()

	Snake_Summoning()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 45)
			Executor.Cooldown_Display (45)
			return
		var/list/choose = list()
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		for(var/mob/D in hearers(15)) if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/mob/M = input("Who do you want to use this jutsu on?", "Snake Summoning") as null|anything in choose
		if(!M || M == "Cancel")
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(17)
				Executor.Activated = 0
				for(var/obj/Jutsus/Underground_Snake_Swamp/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Striking_Shadow_Snakes/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Snake_Grasp/J in Executor) J.Delay(13)
				Executor.Cha -= 15
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			if(M.Dodging == 0)
				if(Executor.Can_Execute(src, 45) == 0) return
				Delay(35)
				Executor.Activated = 0
				for(var/obj/Jutsus/Underground_Snake_Swamp/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Striking_Shadow_Snakes/J in Executor) J.Delay(10)
				for(var/obj/Jutsus/Snake_Grasp/J in Executor) J.Delay(15)
				Executor.freeze ++
				Executor.Dragonned = 1
				new/obj/Effects/Anko_Summoning (Executor.loc, Executor)
				M.icon_state = "mob-standing"
				M.Dragonned = 1
				M.freeze ++
				M.stop()
				spawn(7.50)
					new/obj/Effects/Anko_Snake (M.loc, M)
					var/Direction = M.dir
					Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Snake!")
					spawn(4)
						M.Damage(Executor, 35+rand(1, 5), 1, 0)
						spawn(0.5)
							M.Dragonned = 0
							M.freeze --
							M.stop()
							M.Poison_Proc(7, Executor.name)
							if(Direction == EAST) M.knockbackwest()
							if(Direction == WEST) M.knockbackeast()

	Enma_Summon()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 55)
			Executor.Cooldown_Display (55)
			return
		var/list/choose = list()
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		for(var/mob/D in hearers(15))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/mob/M=input("Who do you want to use this jutsu on?", "Enma Summon") as null|anything in choose
		if(!M || M == "Cancel")
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(20)
				Executor.Cha -= 25
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			if(M.Dodging == 0)
				if(Executor.Can_Execute(src, 55) == 0) return
				Delay(40)
				Executor.freeze ++
				M.icon_state = "mob-standing"
				M.freeze ++
				M.stop()
				M.Dragonned = 1
				var/A=new/obj/Monkey(M.loc)
				A:dir = pick(WEST, EAST)
				if(A:dir == EAST) A:x -= 1
				if(A:dir == WEST) A:x += 1
				var/Picken_Dir = A:dir
				Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Monkey King: ENMA!")
				Flick("summon",Executor)
				spawn(15)
					var/HPDrained=40
					M.Damage(Executor, HPDrained, 1, 0)
					spawn(3.5)
						M.Dragonned = 0
						M.freeze --
						M.stop()
						if(Picken_Dir == EAST) M.knockbackeast()
						if(Picken_Dir == WEST) M.knockbackwest()
					spawn(10)
						Executor.freeze --
						Executor.stop()


	Amaterasu_AOE()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.PeinCD || Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 80)
			Executor.Cooldown_Display (80)
			return
		var/list/choose = list()
		Executor.PeinCD = 1
		spawn(25) Executor.PeinCD = 0
		for(var/mob/D in hearers(15))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Gates && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/mob/M=input("Who do you want to use this jutsu on?", "Amaterasu") as null|anything in choose
		if(!M || M == "Cancel")
			Executor.PeinCD = 0
			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || M.Gates || Executor.knocked || Delay || Executor.freeze || !Executor.Real)
			Executor.PeinCD = 0
			return
		else
			Executor.PeinCD = 0
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}

			if(M.Dodging == 1)
				Delay(20)
				for(var/obj/Jutsus/Tsukuyomi_/J in Executor) J.Delay(7)
				for(var/obj/Jutsus/Amaterasu_Wildfire/J in Executor) J.Delay(7)
				Executor.Cha -= 30
				M.Dragonned = 0
				M.Auto_Dodge (Executor)
				Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
				return

			if(M.Dodging == 0)
				if(Executor.Can_Execute(src, 80) == 0) return
				Delay(40)
				for(var/obj/Jutsus/Tsukuyomi_/J in Executor) J.Delay(20)
				for(var/obj/Jutsus/Amaterasu_Wildfire/J in Executor) J.Delay(13)
				flick("Hand-Seals", Executor)
				Executor.Dragonned = 1
				Executor.freeze ++
				Executor.stop()
				M.icon_state = "mob-standing"
				M.Dragonned = 1
				M.freeze ++
				M.stop()
				sleep(6)
				Executor.Dragonned = 0
				Executor.freeze --
				Executor.stop()
				new/obj/Itachi_Amaterasu (M.loc, M, Executor)
				Executor.Execute_Jutsu("Amaterasu!")
				spawn(3.5)
					M.Damage(Executor, 20, 1, 0)
					M.Dragonned = 0
					M.freeze --
					M.stop()


	Toad_Summon()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 60) == 0) return
		Delay(20)
		Executor.freeze ++
		Executor.stop()
		Flick("summon", Executor)
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		sleep(5)
		Flick("toad", Executor)
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Toad!")
		var/T=0
		loop
			T++
			if(T > 6)
				Flick("teleport", Executor)
				Executor.freeze --
				Executor.stop()
				return

			Flick("toad", Executor)
			var/A = new/mob/Ultimate_Projectile/Phoenix_Flower(null, Executor)
			A:pixel_y = -2
			spawn(3.4) goto loop

	Frogs_Song()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Can_Execute(src, 50) == 0) return
		Delay(15)
		Executor.freeze ++
		Executor.stop()
		Executor.Execute_Jutsu("Frogs Song!")
		Flick("Frogs Song", Executor)
		spawn(6) new/mob/Ultimate_Projectile/Hossenka(null, Executor)
		spawn(11) new/mob/Ultimate_Projectile/Hossenka(null, Executor)
		spawn(16) new/mob/Ultimate_Projectile/Hossenka(null, Executor)
		spawn(21) new/mob/Ultimate_Projectile/Hossenka(null, Executor)
		spawn(25) Executor.freeze --
	Shisui_Genjutsu()
		var/mob/Executor = usr
		src.On_Ground = 1
		var/Real_Name = Executor.name
		if(Executor.knockback || Executor.freeze || Executor.Controlling || Executor.Attacking || Executor.knocked || Delay || !Executor.on_ground) return
		if(Executor.Cha < 20)return
		var/list/choose=list()
		for(var/mob/D in hearers(20))
			if(D.Real_C == 1 && D.Village != Executor.Village && !D.knocked && !D.Dragonned && D.Real && !D.Boulder && !D.BoulderX) choose.Add(D)
		var/cancel="Cancel"
		choose+=cancel
		var/mob/M=input("Who do you want to use this technique on?", "Judgement Chain") as null|anything in choose
		if(!M || M == "Cancel" || M == cancel)

			return
		if(Executor.name != Real_Name || !Executor.on_ground || M.Village == Executor.Village || M.knocked || M.Real_C == 0 || !M.Real || M.Boulder || M.BoulderX || Executor.knocked || Delay || Executor.freeze || !Executor.Real)

			return
		else

			if(abs(M.x - Executor.x) > 20 || abs(M.y - Executor.y) > 20) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
			if(Executor.Can_Execute(src, 20) == 0) return
			else
				Delay(60)
				flick("Kotoamatsukami",Executor)
				//new/obj/Effects/ShisuiGenjutsu (M.loc, M)
				M.Chain_Restriction="Melee Restriction"
				M.Damage(Executor, 25, 1)
				M.overlays += /obj/ShisuiMS
				M<<"<font color=purple><font size=2>You have been placed under Shisui's Genjutsu, Attack and you will hurt yourself as well"
				M.RestrictionFX=1
				spawn(100)
					M.Chain_Restriction=null
					M.RestrictionFX=0
					M.overlays -=/obj/ShisuiMS
					M<<"<font color=purple><font size=2>It Has worn off"

mob/proc
	Bug_Levitation()
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		for(var/obj/Jutsus/Bug_Levitation/J in src)
			J.Tournament_GoingOn = 1
			J.Capture_The_Flag = 1
			J.Boss_Mode = 1
			J.Dash = 1
			if(Levitating)
				src.Levitating = 0
				src.fall_speed = 25
				spawn() J.Delay(30)
				return
			if(J.Delay || NEM_Round.Mode != "Normal") return
			if(src.Can_Execute(J, 10) == 0) return
			src<<"<b><font color=#6EDEFF><u>Press Space to Fly.</b></u></font>"
			src.Levitating = 1
			src.fall_speed = 10
			src.stop()
	Flight()
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		for(var/obj/Jutsus/Flight/J in src)
			J.Tournament_GoingOn = 1
			J.Capture_The_Flag = 1
			J.Boss_Mode = 1
			J.Dash = 1
			if(Levitating)
				src.Levitating = 0
				src.fall_speed = 25
				spawn() J.Delay(30)
				return
			if(J.Delay || NEM_Round.Mode != "Normal") return
			if(src.Can_Execute(J, 10) == 0) return
			src<<"<b><font color=#6EDEFF><u>Press Space to Fly.</b></u></font>"
			src.Levitating = 6
			src.fall_speed = 10
			src.stop()
	Clay_Bird()
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		for(var/obj/Jutsus/Clay_Bird/J in src)
			J.Tournament_GoingOn = 1
			J.Capture_The_Flag = 1
			J.Boss_Mode = 1
			J.Dash = 1
			if(Levitating)
				spawn() J.Delay(30)
				Flick("teleport", src)
				src.Levitating = 0
				src.fall_speed = 25
				src.icon = 'Graphics/Characters/Deidara.dmi'
				return
			if(J.Delay || NEM_Round.Mode != "Normal") return
			if(src.Can_Execute(J, 10) == 0) return
			src.Execute_Jutsu("Clay Bird!")
			src.icon = 'Graphics/Characters/claybird.dmi'
			src<<"<b><font color=#6EDEFF><u>Press Space to Fly.</b></u></font>"
			src.Levitating = 2
			src.fall_speed = 10
			src.stop()
	Floating_Sand_Sphere()
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		for(var/obj/Jutsus/Floating_Sand_Sphere/J in src)
			J.Tournament_GoingOn = 1
			J.Capture_The_Flag = 1
			J.Boss_Mode = 1
			J.Dash = 1
			if(Levitating)
				spawn() J.Delay(30)
				Flick("teleport", src)
				src.Levitating = 0
				src.fall_speed = 25
				src.icon = 'Graphics/Characters/Gaara.dmi'
				return
			if(J.Delay || NEM_Round.Mode != "Normal") return
			if(src.Can_Execute(J, 10) == 0) return
			src.Execute_Jutsu("Floating Sand Sphere!")
			src.icon = 'Graphics/Skills/Gaara Flying.dmi'
			src<<"<b><font color=#6EDEFF><u>Press Space to Fly.</b></u></font>"
			src.Levitating = 7
			src.fall_speed = 10
			src.stop()
	Ink_Bird()
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		for(var/obj/Jutsus/Ink_Bird/J in src)
			J.Tournament_GoingOn = 1
			J.Capture_The_Flag = 1
			J.Boss_Mode = 1
			J.Dash = 1
			if(Levitating)
				spawn() J.Delay(30)
				Flick("teleport", src)
				src.Levitating = 0
				src.fall_speed = 25
				src.icon = 'Graphics/Characters/Sai.dmi'
				return
			if(J.Delay || NEM_Round.Mode != "Normal") return
			if(src.Can_Execute(J, 10) == 0) return
			src.Execute_Jutsu("Ink Bird!")
			src.icon = 'Graphics/Characters/InkBird.dmi'
			src<<"<b><font color=#6EDEFF><u>Press Space to Fly.</b></u></font>"
			src.Levitating = 3
			src.fall_speed = 10
			src.stop()
	Bird()
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		for(var/obj/Jutsus/Summon_Bird/J in src)
			J.Tournament_GoingOn = 1
			J.Capture_The_Flag = 1
			J.Boss_Mode = 1
			J.Dash = 1
			if(Levitating)
				spawn() J.Delay(30)
				Flick("teleport", src)
				src.Levitating = 0
				src.fall_speed = 25
				src.icon = 'Graphics/Characters/Animal Path.dmi'
				return
			if(J.Delay || NEM_Round.Mode != "Normal") return
			if(src.Can_Execute(J, 10) == 0) return
			src.Execute_Jutsu("Kuchiyose No Jutsu.- Bird!")
			src.icon = 'Graphics/Skills/Bird.dmi'
			src<<"<b><font color=#6EDEFF><u>Press Space to Fly.</b></u></font>"
			src.Levitating = 4
			src.fall_speed = 10
			src.stop()
	Bird_ANBU()
		if(CTD) return
		if(NEM_Round.Mode == "Challenge") {src<<"<b><font color=red><u>This jutsu isn't allowed on challenges.</u>"; return}
		if(NEM_Round.Type == "Mission") {src<<"<b><font color=red><u>This jutsu isn't allowed on missions.</u>"; return}
		for(var/obj/Jutsus/Bird_AnbuS/J in src)
			J.Tournament_GoingOn = 1
			J.Capture_The_Flag = 1
			J.Boss_Mode = 1
			J.Dash = 1
			if(Levitating)
				spawn() J.Delay(30)
				Flick("teleport", src)
				src.Levitating = 0
				src.fall_speed = 25
				src.icon = 'Graphics/Characters/Anbu Special.dmi'
				return
			if(J.Delay || NEM_Round.Mode != "Normal") return
			if(src.Can_Execute(J, 10) == 0) return
			src.Execute_Jutsu("Kuchiyose No Jutsu.- Bird!")
			src.icon = 'Graphics/Skills/BirdX.dmi'
			src<<"<b><font color=#6EDEFF><u>Press Space to Fly.</b></u></font>"
			src.Levitating = 5
			src.fall_speed = 10
			src.stop()
	Check_Levitating()
		if(Levitating == 1) Bug_Levitation()
		if(Levitating == 2) Clay_Bird()
		if(Levitating == 3) Ink_Bird()
		if(Levitating == 4) Bird()
		if(Levitating == 5) Bird_ANBU()
		if(Levitating == 6) Flight()
		if(Levitating == 7) Floating_Sand_Sphere()


mob/Portal
	icon = 'Graphics/Skills/Portal.dmi'
	freeze = 1000
	Real = 0
	layer = 150
	alpha = 200
	Dragonned = 1
	Substitution = 1
	density = 0
	HP = 100000000

	New(loc, mob/_Creator_)
		..()
		Village = _Creator_.Village
		dir = _Creator_.dir
		loc = _Creator_.loc
		px = _Creator_.px
		py = _Creator_.py
		step_x = _Creator_.step_x
		step_y = _Creator_.step_y
		var/list/Projectiles = list()
		var/T

		loop
			if(!_Creator_ || T == 13) {del(src); return}
			for(var/mob/M in view(15))

				if(istype(M, /mob/Ultimate_Projectile))
					if(istype(M, /mob/Ultimate_Projectile/NL_Mind_Transfer)) continue
					if(istype(M, /mob/Ultimate_Projectile/L_Mind_Transfer)) continue
					if(istype(M, /mob/Ultimate_Projectile/Hiraishin_Kunai)) continue
					if(Projectiles.Find(M)) continue
					Projectiles.Add(M)
					M:Projectile_Owner = Owner
					M:Allies = Village
					if(M.dir == EAST)
						M.vel_x = -M.vel_x
						if(M.vel_x > 0) M.vel_x = -M.vel_x
						M.dir = WEST
					else
						M.vel_x = abs(M.vel_x)
						M.dir = EAST

				else if(M != src && M.Village != _Creator_.Village && !M.Dragonned && M.Real && !M.knocked)
					if(M.px > px) {M.vel_x = -10; M.dir = EAST}
					else {M.vel_x = 10; M.dir = WEST}
					if(M.py < py) M.vel_y = 7

			for(var/mob/M in view(5)) if(M != src && M.Village != _Creator_.Village && !M.Dragonned && M.Real && !M.knocked)
				if(!M.Dodging) M.Damage (_Creator_, rand(8.5, 10), 1, 0, src, 1)
				else M.Auto_Dodge(src)

			T++
			spawn(5) goto loop