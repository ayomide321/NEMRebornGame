NEM_Round/proc/I_Cut_Scene (var/S, NEM_Round/N)
	var/obj/T = new/obj/Screen/Time
	T.icon = 'Cut Scene.dmi'
	T.layer = 10000000000
	T.alpha = 185
	N.Cut_Scene = 1
	for(var/mob/M in N.Ninjas) if(M.Controlling_Object) del(M.Controlling_Object)

	if(S == "Tsunade")
		T.icon = 'Cut Scene.dmi'
		T.layer = 10000000000
		T.alpha = 185
		var/Tsunade
		for(var/obj/Tsunade/B in world) Tsunade = B
		spawn() Mission_Show_(Tsunade, "<font color=#94E993><b><center><font size=3>We have spotted the Sound 4!", N, 40)
		spawn(40) Mission_Show_(Tsunade, "<font color=#94E993><b><center><font size=3>Your mission is to defeat them all and return here!", N, 60)
		spawn(100) Mission_Show_(Tsunade, "<font color=#94E993><b><center><font size=3>But beware, this mission is rank S!", N, 40)
		spawn(140) {spawn(2.5) flick("Tsunade Start", Tsunade); Mission_Show_(Tsunade, "<font color=#94E993><b><font size=3><center>Go!", N, 20)}
		spawn(157.5)
			N.Cut_Scene = 0
			del(T)
			var/list {Existing_Enemies = list(); All_Enemies = list()}
			N.Spawns = list(locate(25, 68, 17), locate(45, 80, 17), locate(54, 72, 17), locate(33, 73, 17))
			for(var/mob/M in N.Ninjas) {if(M.client) {M.client.perspective = MOB_PERSPECTIVE; M.client.eye = M}; All_Enemies.Add(M); Existing_Enemies.Add(M); M.dir = EAST; flick("teleport", M); var/G = pick(N.Spawns); M.loc = G; N.Spawns.Remove(G); M.freeze = 0; M.stop(); spawn() M.Mission_Show("<font color=#C38DC6><font size=4><b><center>* [M.Mission_On.Name] *<br><font size=3>Defeat Sound 4 Members!")}
			N.Spawns = list(locate(157, 80, 17), locate(155, 73, 17), locate(144, 68, 17), locate(168, 68, 17))
			if(N) {var/mob/Mission_NPC/NPC = new/mob/Mission_NPC/Tayuya_I; N.Join(NPC); NPC = new/mob/Mission_NPC/Jirobo_I; N.Join(NPC); NPC = new/mob/Mission_NPC/Sakon_I; N.Join(NPC); NPC = new/mob/Mission_NPC/Kidoumaru_I; N.Join(NPC); for(var/mob/M in N.Ninjas) if(M.Mission_NPC) {var/P = pick(N.Spawns); M.loc = P; N.Spawns.Remove(P); if(length(Existing_Enemies) > 0) {var/X = pick(Existing_Enemies); M.Target = X; Existing_Enemies.Remove(X)} else M.Target = pick(All_Enemies)}}

		for(var/mob/M in N.Ninjas) if(M.client)
			M.client.screen += T
			M.client.perspective = EYE_PERSPECTIVE
			M.client.eye = locate(238, 10, 3)
	//		client.perspective = MOB_PERSPECTIVE
	//		client.eye = src

	else if(S == "Second Part")
		T.icon = 'Black Screen.dmi'
		T.layer = 10000000000
		T.alpha = 0
		var/obj/Z = new/obj/Screen/Time
		Z.icon = 'Cut Scene.dmi'
		Z.layer = 1000000000
		Z.alpha = 185
		var/Ready
		var/mob {Kidoumaru; Tayuya; Jirobo; Sakon}
		spawn() {while(T.alpha < 255) {T.alpha += 5; sleep(0.5)}; sleep(13); for(var/mob/M in N.Ninjas) if(M.client) {M.input_lock = 1; M.stop(); M.client.screen += Z; M.client.perspective = EYE_PERSPECTIVE; M.client.eye = locate(162, 78, 17)}; while(T.alpha > 0) {T.alpha -= 5; sleep(0.7)}; for(var/mob/M in N.Ninjas) if(M.Mission_NPC) {M.dir = WEST; M.Active_AI = 0; M.dead = 0; M.knocked = 0; M.Checked_X = 1; M.layer = 0; M.Dragonned = 1; M.freeze = 1000; if(M.name == "Sakon") Sakon = M; else if(M.name == "Tayuya") Tayuya = M; else if(M.name == "Jirobo") Jirobo = M; else if(M.name == "Kidoumaru") Kidoumaru = M}; Ready = 1; goto Start}
		for(var/mob/M in N.Ninjas) if(M.client) {M.client.screen += T}
		spawn(25)
			N.Spawns = list(locate(24, 66, 17), locate(26, 66, 17), locate(28, 66, 17), locate(30, 66, 17))
			for(var/mob/M in N.Ninjas) if(M.client) {M.dir = EAST; M.stop(); var/G = pick(N.Spawns); M.loc = G; N.Spawns.Remove(G); M.dir = EAST}

		Start
			if(!Ready) return
			if(Sakon) {Sakon.loc = locate(158, 78, 17); Sakon.layer = 100; flick("teleport", Sakon); Mission_Show_(Sakon, "<font color=#ACB5F2><b><font size=3><center>This is boring, let's just get it over with, you can't win...", N, 45)}
			spawn(20) if(Kidoumaru) {Kidoumaru.loc = locate(160, 78, 17); Kidoumaru.layer = 100; flick("teleport", Kidoumaru); Mission_Show_(Kidoumaru, "<font color=#767676><b><font size=3><center>No, we will kill them slow, that's how I like my games!", N, 50)}
			spawn(67) if(Tayuya) {Tayuya.loc = locate(162, 78, 17); Tayuya.layer = 100; flick("teleport", Tayuya); Mission_Show_(Tayuya, "<font color=#E375A6><b><font size=3><center>Shut the hell up you two!", N, 30)}
			spawn(100) if(Jirobo) {Jirobo.loc = locate(164, 78, 17); Jirobo.layer = 100; flick("teleport", Jirobo); Mission_Show_(Jirobo, "<font color=#DCAE5E><b><font size=3><center>Don't be that rude, Tayuya ..", N, 35)}
			spawn(140) for(var/mob/Mission_NPC/M in N.Ninjas) {var/turf/T1 = locate(M.x, M.y-1, M.z); var/turf/T2 = locate(M.x-1, M.y-1, M.z); N.Temporal_Turfs.Add(new/turf/wall (T1), new/turf/wall (T2))}
			spawn(150) if(N) {for(var/mob/Mission_NPC/M in N.Ninjas) {M.Checked_X = 1; M.density = 1; M.freeze = 0; M.stop()}; Sakon.Curse_SealS(); Tayuya.Curse_SealT(); Jirobo.Curse_SealJ(); Kidoumaru.Curse_SealK()}
			spawn(175)
				N.Cut_Scene = 0
				spawn(10) for(var/turf/T3 in N.Temporal_Turfs) {new/turf/Special_Floor (T3); N.Temporal_Turfs.Remove(T3)}
				var/list {Existing_Enemies = list(); All_Enemies = list()}
				del(Z)
				T.alpha = 255
				spawn() {while(T.alpha > 0) {T.alpha -= 7; sleep(0.35)}; del(T)}
				for(var/mob/M in N.Ninjas) if(M.client) {M.input_lock = 0; spawn() M.Mission_Show("<font color=#C38DC6><font size=4><b><center>* [M.Mission_On.Name] *<br><font size=3>Kill Sound 4 Members!"); M.client.perspective = MOB_PERSPECTIVE; M.client.eye = M; M.HP = M.MaxHP; M.Cha = M.MaxCha; M.Energy = M.MaxEnergy; Existing_Enemies.Add(M); All_Enemies.Add(M)}
				for(var/mob/M in N.Ninjas) if(M.Mission_NPC) {M.stop(); M.Movement(); M.Energy = M.MaxEnergy; spawn() M.running = 1; M.Attacking = 0; M.Attacked = 0; M.HP = M.MaxHP; M.running = 1; M.Dragonned = 0; if(length(Existing_Enemies) > 0) {var/X = pick(Existing_Enemies); M.Target = X; Existing_Enemies.Remove(X)} else M.Target = pick(All_Enemies); M.FFF = 1; M.freeze = 0; M.Active_AI = 1; M:Special_AI()}

	else if(S == "Third Part")
		T.icon = 'Black Screen.dmi'
		T.layer = 10000000000
		T.alpha = 0
		var/obj/Z = new/obj/Screen/Time
		Z.icon = 'Cut Scene.dmi'
		Z.layer = 1000000000
		Z.alpha = 185
		for(var/mob/M in N.Ninjas) if(M.client) {M.Dragonned = 1; M.stop(); M.input_lock = 1; M.keys["east"] = 0}
		spawn() {while(T.alpha < 255) {T.alpha += 5; sleep(0.5)}; sleep(20); for(var/mob/M in N.Ninjas) if(M.client) {M.client.screen += Z}; while(T.alpha > 0) {T.alpha -= 5; sleep(0.7)}}
		for(var/mob/M in N.Ninjas) if(M.client) {M.client.screen += T}
		spawn(40)
			N.Spawns = list(locate(187, 13, 17), locate(183, 13, 17), locate(179, 13, 17), locate(175, 13, 17))
			for(var/mob/M in N.Ninjas) {if(M.client) {M.Dragonned = 0; M.input_lock = 0; M.freeze = 0; M.key_down("west"); var/G = pick(N.Spawns); M.loc = G; N.Spawns.Remove(G); M.dir = WEST; M.input_lock = 1; M.freeze = 0; M.stop(); M.HP = M.MaxHP; M.Cha = M.MaxCha; M.Energy = M.MaxEnergy; M.running = 1; M.vel_x = -16}; else del(M)}
			spawn(70)
				var/mob/_PX_
				for(var/mob/M in N.Ninjas) if(M.client) if(!_PX_ || M.px < _PX_.px) _PX_ = M
				spawn() Mission_Show_(_PX_, "<font color=#7FFF7B><b><font size=3><center>Wait!", N, 25)
				sleep(10)
				var/V = 32
				spawn()
					while(V) {V --; for(var/mob/M in N.Ninjas) M.vel_x += 0.5; sleep(0.35)}
					spawn(5)
						spawn() Mission_Show_(_PX_, "<font color=#7FFF7B><b><font size=3><center>What's this feeling?", N, 25)
						spawn(25) for(var/mob/M in N.Ninjas)
							if(M) {var/obj/Spike = new/obj/Spike (M); Spike.pixel_x -= 12; spawn(1.75) {M.HP -= 25; var/H = new/obj/Hit(M.loc); H:pixel_x = M.pixel_x; H:pixel_y = M.pixel_y; flick("hurt", M); M.freeze = 0; M.stop(); M.vel_y = 18}}
							spawn(12.5) {var/K = new/obj/Supreme_Kirin (M.loc); if(M.dir == EAST) K:dir = WEST; else K:dir = EAST; spawn(0.5) {M.HP = 0; M.Energy = 0; M.Cha = 0; var/H = new/obj/Hit(M.loc); H:pixel_x = M.pixel_x; H:pixel_y = M.pixel_y; flick("hurt", M); if(M.dir == EAST) M.knockbackwest(); else M.knockbackeast(); M.knocked = 1}}
			spawn(170)
				var/list/B = list()
				for(var/mob/M in N.Ninjas) if(M.client) B.Add(M)
				spawn() Mission_Show_(pick(B), "<font color=#8AED86><b><font size=3><center>This shadow is...", N, 25)
				sleep(25)
				N.Cut_Scene = 0
				for(var/mob/M in N.Ninjas) {M.client.screen -= T; M.client.screen += T}
				while(T.alpha < 255) {T.alpha += 5; sleep(0.5)}
				del(Z)
				var/list {Existing_Enemies = list(); All_Enemies = list()}
				N.Spawns = list(locate(35, 157, 18), locate(38, 157, 18), locate(41, 157, 18), locate(44, 157, 18))
				for(var/mob/M in N.Ninjas) {M.HP = M.MaxHP; M.Cha = M.MaxCha; M.Energy = M.MaxEnergy; M.knocked = 0; var/Y = pick(N.Spawns); M.dir = EAST; All_Enemies.Add(M); Existing_Enemies.Add(M); M.loc = Y; N.Spawns.Remove(Y); M.dead = 0}
				while(T.alpha > 0) {T.alpha -= 5; sleep(0.5)}
				for(var/mob/M in N.Ninjas) {M.running = 0; M.input_lock = 0; spawn() M.Mission_Show("<font color=#C38DC6><font size=4><b><center>* [M.Mission_On.Name] *<br><font size=3>Defeat Sasuke & Kimimaro!")}
				new/mob/Mission_NPC/Sasuke_I (locate(122, 157, 18), N)
				new/mob/Mission_NPC/Kimimaro_I (locate(125, 157, 18), N)
				for(var/mob/Mission_NPC/M in N.Ninjas) {if(length(Existing_Enemies) > 0) {var/X = pick(Existing_Enemies); M.Target = X; Existing_Enemies.Remove(X)} else M.Target = pick(All_Enemies); M.Special_AI()}



	else if(S == "Fourth Part")
		var/obj/X = new/obj/Screen/Time
		X.icon = 'Sharingan Eyes.jpg'
		X.layer = 100000000000
		X.alpha = 50
		var/obj/Y = new/obj/Screen/Time
		Y.icon = 'Black Screen.dmi'
		Y.layer = 1000000000000
		Y.alpha = 0
		var/obj/Z = new/obj/Screen/Time
		Z.icon = 'Cut Scene.dmi'
		Z.layer = 1000000000
		Z.alpha = 185

		N.Spawns = list(locate(62, 157, 18), locate(65, 157, 18), locate(68, 157, 18), locate(71, 157, 18))
		for(var/mob/M in N.Ninjas) if(M.client) {M.input_lock = 1; M.stop()}
		sleep(30)
		for(var/mob/M in N.Ninjas) if(M.client) {var/G = pick(N.Spawns); M.loc = G; N.Spawns.Remove(G); M.Dragonned = 1; M.client.eye = locate(0, 0, 0); M.client.perspective = EYE_PERSPECTIVE;; M.client.screen += Z; M.client.screen += X; M.client.screen += Y}
		while(X.alpha < 255) {X.alpha += 7; sleep(0.75)}
		sleep(10.5)
		for(var/mob/M in N.Ninjas) if(M.client) M.dir = EAST
		while(Y.alpha < 255) {Y.alpha += 5; sleep(0.5)}
		del(X)
		spawn() for(var/mob/Mission_NPC/Kimimaro_I/M in N.Ninjas) M.alpha = 0
		spawn() for(var/mob/Mission_NPC/Sasuke_I/M in N.Ninjas) {spawn(10) Mission_Show_(M, "<font color=#592157><b><font size=3><center>Hmph, bunch of weaklings, this isn't worth my time...", N, 35); spawn(45) flick("Chidori NPC", M); spawn(50) {flick("chidori3", M); M.Chidori = "NPC"; M.vel_x = -86; M.running = 0}; for(var/mob/F in N.Ninjas) if(F.client) {F.client.perspective = EYE_PERSPECTIVE; F.client.eye = M}; M.Dragonned = 1; M.dir = WEST; M.Active_AI = 0; M.loc = locate(122, 157, 18); M.overlays += new/obj/Sharingan; M.dead = 0; M.knocked = 0; M.freeze = 0; M.Dragonned = 1; M.HP = M.MaxHP; M.Energy = M.MaxEnergy; M.Cha = M.MaxCha; M.Checked_X = 1}
		sleep(13.5)
		while(Y.alpha > 0) {Y.alpha -= 5; sleep(0.5)}
		spawn(70)
			while(Y.alpha < 255) {Y.alpha += 4; sleep(0.80)}
			sleep(15)
			N.Cut_Scene = 0
			for(var/mob/M in N.Ninjas) if(!M.client) del(M)
			new/mob/Mission_NPC/Orochimaru_I (locate(291, 163, 18), N)
			N.Spawns = list(locate(189, 163, 18), locate(192, 163, 18), locate(195, 163, 18), locate(198, 163, 18))
			new/mob/Mission/Follow (locate(184, 163, 18), 8, "Orochimaru", N)
			spawn(1.5) for(var/mob/M in N.Ninjas) if(M.client) {M.Dragonned = 0; var/P = pick(N.Spawns); M.loc = P; N.Spawns.Remove(P); M.Poison = 1; spawn(250) M.Poison = 0; M.HP = M.MaxHP; M.Energy = M.MaxEnergy; M.Cha = M.MaxCha; M.dir = EAST; var/obj/O = image('Graphics/Skills/OroSnakeEffect.dmi', M, null, 250, M.dir); M.Extra_Image = O; M.freeze = 1000; M.density = 1; M.Substitution = 0; M.dead = 0; M.knocked = 0; N.Ninjas << O}
			while(Y.alpha > 0) {Y.alpha -= 4; sleep(0.775)}
			del(Y)



	else if(S == "Fifth Part")
		var/obj/Y = new/obj/Screen/Time
		Y.icon = 'Black Screen.dmi'
		Y.layer = 1000000000000
		Y.alpha = 0
		var/obj/Z = new/obj/Screen/Time
		Z.icon = 'Cut Scene.dmi'
		Z.layer = 1000000000
		Z.alpha = 185
		var/mob/Orochimaru
		for(var/mob/M in N.Ninjas) {if(M.client) M.client.screen += Y; M.stop(); M.input_lock = 1; M.freeze = 0}
		while(Y.alpha < 255) {Y.alpha += 5; sleep(0.5)}
		sleep(10)
		for(var/mob/Mission_NPC/Orochimaru_I/M in N.Ninjas) {Orochimaru = M; M.dir = WEST; M.Active_AI = 0; M.Icon_State = "Knocked 2"; M.knocked = 0; M.dead = 0; M.Checked_X = 1; M.loc = locate(283, 163, 18)}
		N.Spawns = list(locate(287, 163, 18), locate(289, 163, 18), locate(291, 163, 18), locate(293, 163, 18))
		for(var/mob/M in N.Ninjas) if(M.client) {var/P = pick(N.Spawns); M.dir = EAST; M.loc = P; N.Spawns.Remove(P); M.client.screen += Z; M.client.perspective = EYE_PERSPECTIVE; M.client.eye = Orochimaru}
		while(Y.alpha > 0) {Y.alpha -= 5; sleep(0.5)}
		if(Orochimaru) spawn() new/obj/Effects/Orochimaru_Mission (Orochimaru.loc, Orochimaru)
		spawn(125) while(Y.alpha < 255) {Y.alpha += 5; sleep(0.40)}
		spawn(5) for(var/mob/M in N.Ninjas) if(M.client) M.dir = WEST

mob/var/Extra_Image