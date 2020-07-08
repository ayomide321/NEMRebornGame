mob/var/FFF = 1
mob/var/Active_AI = 1

mob/Death_Check(Killer)
	..()
	if(Mission_On && dead && FFF)
		var {D; A}
		FFF = 0
		if(Mission_On.Limit > 1)
			var/mob/T
			for(var/mob/M in NEM_Round.Ninjas) if(M.client && !M.dead) T = M
			for(var/mob/Mission_NPC/M in NEM_Round.Ninjas) if(M.Target == src) {if(T) M.Target = T; else M.Active_AI = 0}

			var/V
			if(NEM_Round.Stage == 4) V = 0.25
			else if(NEM_Round.Stage == 5) V = 0.50
			if(V) {Ryo_Reward(round(Mission_On.Ryo_Reward*V), 0.5); Rep_Reward(round(Mission_On.Rep_Reward*V), 0.5)}

			if(T)
				var/MTD
				if(NEM_Round.Mode == "Orochimaru's Wrath") MTD = "<font color=#C38DC6><font size=4><b><center>* [NEM_Round.Mode] *<br><font size=3>"
				NEM_Round.Ninjas.Remove(src)
				Current_NEM_Round.Join(src)
				spawn() {if(Mission_On) Mission_On.Ninjas.Remove(src); Mission_On = null}
				Resize()
				Mission_Show("[MTD]Mission Failed!")
				Respawn()
				return

		for(var/mob/M in NEM_Round.Ninjas) if(M.Village == Village && M.client) {A ++; if(M.dead) D ++}
		if(D == A) NEM_Round.Del("Lost")

mob/Mission/Follow
	Active_M = 1
	Mission_NPC = 1
	Real_Person = 1
	var/NEM_Round/NR
	var/mob/Creator
	var/To_Follow
	var/Updated
	alpha = 25

	Del()
		var/list/Existing_Enemies = list()
		var/list/All_Enemies = list()
		while(alpha > 0) {alpha -= 10; sleep(0.25)}
		if(NR)
			for(var/mob/M in NR.Ninjas) {if(M.client) {All_Enemies.Add(M); Existing_Enemies.Add(M); M.input_lock = 0; M.stop(); M.client.screen = null; spawn() M.Mission_Show("<font color=#C38DC6><font size=4><b><center>* [M.Mission_On.Name] *<br><font size=3>Defeat Orochimaru & Kabuto!"); M.Dragonned = 0; M.Substitution = 0; M.freeze = 0; M.client.eye = M; M.client.perspective = MOB_PERSPECTIVE}}
			for(var/mob/Mission_NPC/M in NR.Ninjas) {M.Icon_State = null; if(length(Existing_Enemies) > 0) {var/X = pick(Existing_Enemies); M.Target = X; Existing_Enemies.Remove(X)} else M.Target = pick(All_Enemies); M.Active_AI = 1; M.Special_AI()}
		..()
	New(L, V, N, NEM_Round/_N) {..(); Substitution = 1; _N.Ninjas.Add(src); spawn(100) Substitution = 0; spawn(600) del(src); spawn(65) vel_x *= 1.35; spawn(75) vel_x *= 1.35; spawn(85) vel_x *= 1.25; loc = L; To_Follow = N; NR = _N; for(var/mob/M in NR.Ninjas) if(M.client) {M.client.eye = src; M.client.perspective = EYE_PERSPECTIVE}; spawn(25) vel_x = V}
	proc/Update() {spawn() while(alpha < 255) {alpha += 5; sleep(0.175)}; Updated = 1; icon = 'Kusanagi Mission.dmi'; layer = 500; var/matrix/M = matrix(); M.Turn(135); transform = M; spawn(15) vel_x = -40}
	bump(atom/A)
		if(ismob(A) && !Updated)
			if(A:name == To_Follow) {spawn(20) {spawn() Mission_Show_(A, "<font color=#4B246E><b><font size=3><center>It seems you're finally conscious\nI hope you are ready for the experiment", NR, 65); vel_x = 0; spawn(60) new/mob/Mission_NPC/Kabuto_I (locate(294, 163, 18), NR); spawn(65) A:dir = EAST; spawn(100) Mission_Show_(A, "<font color=#4B246E><b><font size=3><center>Good, but before we start the experiment\nlet's see what they can really do", NR, 40); spawn(150) {A:dir = WEST; A:Icon_State = "puppeteer"; flick("puppeteer", A); Update()}}}
		if(ismob(A) && Updated) {A:Substitution = 1; spawn(2.5) A:Substitution = 0; flick("Attack", src); del(A:Extra_Image); new/obj/Effects/Meele_Hit (A:loc, A); A:HP /= 2; flick("hurt", A); Substitution = 1; spawn(0.30) Substitution = 0; return}
		else if(isturf(A)) {vel_x = 0; del(src)}
		..()

mob/Mission_NPC
	Active_M = 0
	Mission_NPC = 1

	Death_Check()
		..()
		if(dead && FFF)
			var {D; A}
			FFF = 0
			for(var/mob/Mission_NPC/M in NEM_Round.Ninjas) if(M.Village == Village) {A ++; if(M.dead) D ++}
			if(D == A)
				if(NEM_Round.Mode == "Orochimaru's Wrath")
					if(NEM_Round.Stage == 2) {NEM_Round.Stage = 3; NEM_Round.I_Cut_Scene ("Second Part", NEM_Round)}
					else if(NEM_Round.Stage == 3) {NEM_Round.Stage = 4; NEM_Round.I_Cut_Scene("Third Part", NEM_Round)}
					else if(NEM_Round.Stage == 4) {NEM_Round.Stage = 5; NEM_Round.I_Cut_Scene("Fourth Part", NEM_Round)}
					else if(NEM_Round.Stage == 5) {NEM_Round.Stage = 6; NEM_Round.I_Cut_Scene("Fifth Part", NEM_Round)}

				else if(NEM_Round.Mode == "Escort Gaara")
					NEM_Round.Stage ++
					for(var/mob/M in NEM_Round.Ninjas) if(M.client) if(M.client) spawn() M.Mission_Show("<font color=#E9CD68><font size=4><b><center>* [M.Mission_On.Name] *<br><font size=3>Wave [NEM_Round.Stage-1]/3 Completed!")
					for(var/turf/T in NEM_Round.Temporal_Turfs) T.density = 0
					for(var/obj/O in NEM_Round.Objects) del(O)
					if(NEM_Round.Stage == 2)
						if(NEM_Round._Spawn == 1) {NEM_Round.Objects.Add(new/obj/Blue_Rashomon (locate(165, 46, 18))); var/T = 52; while(T >= 46) {var/turf/G = locate(165, T, 18); NEM_Round.Temporal_Turfs.Add(G); G.density = 1; T --}}
						else if(NEM_Round._Spawn == 2) {NEM_Round.Objects.Add(new/obj/Blue_Rashomon (locate(392, 46, 18))); var/T = 52; while(T >= 46) {var/turf/G = locate(392, T, 18); NEM_Round.Temporal_Turfs.Add(G); G.density = 1; T --}}
						else if(NEM_Round._Spawn == 3) {NEM_Round.Objects.Add(new/obj/Blue_Rashomon (locate(165, 46, 19))); var/T = 52; while(T >= 46) {var/turf/G = locate(165, T, 19); NEM_Round.Temporal_Turfs.Add(G); G.density = 1; T --}}
					if(NEM_Round.Stage <= 3) NEM_Round.Bijuu_Dama = 1

				else NEM_Round.Del("Victory")

	var {Enemy_Jumped; Bumped; UnEffective; Jumping; Move_Speed; Chances_Dodge; Chances_Substitution; Stage = 1; Normal_Move_Speed = 17.5}
	bump(atom/M, d) {if(!Bumped && ismob(M)) {Bumped = 1; if(d == 16) {vel_y  = 0; return}; if(Iron || Chidori) {if(ismob(M) && M:Village == Village) {var/V = vel_x; spawn() vel_x = V; M:SubstitutionCD = 0; M:Substitution()} ..()}; else if(ismob(M) && M:Village != Village) {vel_x = 0; UnEffective = 0; Bumped = 1; if(prob(65)) {if(name == "Hinata" && on_ground) if(prob(15.5) && length(Jutsus)) {var/obj/Jutsus/J = pick(Jutsus); J.Delay = 0; J.Click()}; if(name == "Kimimaro" && on_ground || name == "Sasuke" && on_ground || name == "Kabuto" && on_ground || name == "Orochimaru" && on_ground) if(prob(13.5) && length(Ignored_Challengers)) {var/obj/Jutsus/J = pick(Ignored_Challengers); J.Delay = 0; J.Click()}; if(name == "Zabuza" && on_ground) if(prob(7.5) && length(Ignored_Challengers)) {var/obj/Jutsus/J = pick(Ignored_Challengers); J.Delay = 0; spawn() Bumped = 0; J.Click()}; if(name == "Sakon" && on_ground) if(prob(10.5) && length(Ignored_Challengers)) {var/obj/Jutsus/J = pick(Ignored_Challengers); J.Delay = 0; spawn() Bumped = 0; J.Click()}; if(name == "Neji" && on_ground) if(prob(15.5) &&  length(Jutsus)) {var/obj/Jutsus/J = pick(Jutsus); J.Delay = 0; J.Click(); spawn(30) J.Click()}; Attack()}; else if(prob(15)) {keys[controls.up] = 1; Attack()}; else {if(dir == EAST) keys[controls.right] = 1; else keys[controls.left] = 1; Attack()}; stop()}; else if(ismob(M)) if(!on_ground) {if(M.dir == dir) {if(SubstitutionCD && !Double_Jump) double_jump(); else if(SubstitutionCD && Double_Jump) {keys[controls.down] = 1; Attack()}}}; else jump()} else if(!Bumped && d != 32 && isturf(M)) {Bumped = 1; if(d == dir) {vel_x = 0; vel_y = 0}}}


	Akamaru {name = "Dog"; icon = 'Akamaru.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 12.5; Def = 7; MaxHP = 800; HP = 800; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 17.5; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 10; Shurikens_L = 10000}

	Akamaru
		Damage(mob/Target_)
			..()
			Target_.WD --
			if(Target_.WD > 1) spawn() Target_.Mission_Show("<font color=#B1EEAC><font size=4><b><center>* [Target_.Mission_On.Name] *<br><font size=3>Hit Akamaru [Target_.WD] Times!")
			else if(Target_.WD == 1) spawn() Target_.Mission_Show("<font color=#B1EEAC><font size=4><b><center>* [Target_.Mission_On.Name] *<br><font size=3>Hit Akamaru [Target_.WD] Times!")
			else if(Target_.WD == 0) NEM_Round.Del("Victory")

		bump(M, d)
			if(d == 32) return
			if(ismob(M) && on_ground) vel_y = 12
			else if(isturf(M)) vel_y = 0
			Bumped ++
			if(Bumped > 8)
				Bumped = 0
				if(dir == EAST) {dir = WEST; vel_x = -18}
				else {dir = EAST; vel_x = 18}
			return

		New(loc, G)
			..()
			Target = G
			set_state()
			Attack_CD = 0
			spawn() dir = EAST

			loop
				knockback = 0

				if(dir == EAST)
					vel_x = 18
					var/turf/G1 = locate(x+9, y, z)
					var/turf/G2 = locate(x+5, y, z)
					var/turf/G3 = locate(x+7, y, z)
					if(!G1.Special_Floor_Var && G1.density || !G2.Special_Floor_Var && G2.density || !G3.Special_Floor_Var && G3.density) vel_y = 13
					if(on_ground && abs(Target.py -py) < 240 && Target.px -px > 0 && Target.px -px < 280 && vel_y <= 0) vel_y = 12
				else
					vel_x = -18
					var/turf/G1 = locate(x-9, y, z)
					var/turf/G2 = locate(x-5, y, z)
					var/turf/G3 = locate(x-7, y, z)
					if(!G1.Special_Floor_Var && G1.density || !G2.Special_Floor_Var && G2.density || !G3.Special_Floor_Var && G3.density) vel_y = 13
					if(on_ground && abs(Target.py -py) < 240 && Target.px -px < 0 && Target.px -px > -280 && vel_y <= 0) vel_y = 12

				spawn(3) goto loop

	Sasuke {name = "{PS} Sasuke"; icon = 'LilSasuke.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 12.5; Def = 7; MaxHP = 800; HP = 800; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 17.5; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 10; Shurikens_L = 10000}

	Sasuke
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Great_FireBall_Shower (src)
			Shuriken_Jutsu = new/obj/Shuriken_Jutsu (src, "[Shurikens_L]/[Shurikens] Makibishi Spikes (G)")
			Kunai_Jutsu = new/obj/Chain_Kunais_Jutsu (src, "[Kunais_L]/[Kunais] Chain Kunais (T)")
			Shuriken_Type = rand(1, 4)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(150) Extra_I()
			spawn(450) Extra_II()


		proc/Invencibility()
			..()
			Normal_Move_Speed = Move_Speed
			Chances_Dodge += 5
			Chances_Substitution += 2.5
			Edo = new/obj/Effects/Edo_Aura (loc, src)
			Edo.icon *= "#B63DBF"
			var/T = 10
			loop {if(T) {Dragonned = 1; T--; spawn(10) goto loop}; else {Dragonned = 0; del(Edo)}}

		Damage()
			..()

			if(HP <= 600 && Stage == 1) {Sharingan = 1; overlays += new/obj/Sharingan; Str = 14.5; Def = 8; Move_Speed = Normal_Move_Speed *1.2; Stage = 2; Invencibility()}
			else if(HP <= 400 && Stage == 2) {overlays -= /obj/Sharingan; name = "{PS} (Curse Seal) Sasuke"; icon = 'Graphics/Characters/LilSasukeCS.dmi'; Str = 17; Def = 9; Move_Speed = 21; Stage = 3; Invencibility()}
			else if(HP <= 200 && Stage == 3) {overlays += new/obj/Sharingan; Str = 20; Def = 10; Move_Speed = 24; Stage = 4; Invencibility()}

		proc/Extra_I()
			..()
			loop
				var/C
				if(Target.knocked || freeze || Attacking || knockback || Target.Dragonned) {C = 1; spawn(30) goto loop}
				else {spawn(rand(600, 750)) goto loop; Dodging = 1}
				if(!C && on_ground) Kunai_Jutsu.Scroll_Kunai(src)
				else {!C && Shuriken_Jutsu.Makibishi_Shuriken(src); spawn(2.5) Shuriken_Jutsu.Makibishi_Shuriken(src); spawn(5) Shuriken_Jutsu.Makibishi_Shuriken(src); spawn(7.5) Shuriken_Jutsu.Makibishi_Shuriken(src); spawn(10) Shuriken_Jutsu.Makibishi_Shuriken(src)}

		proc/Extra_II()
			..()
			loop
				var/C
				if(on_ground && !freeze && !Attacking && !knockback && !Target.Dragonned && !Target.knocked) {spawn(rand(600, 750)) goto loop; Dodging = 1; C = 1; for(var/obj/Jutsus/S in Jutsus) {S.Delay = 0; S.Click()}}
				if(!C) spawn(30) goto loop

	Zaku {name = "Zaku"; icon = 'Zaku.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 12.5; Def = 8.25; MaxHP = 110; HP = 110; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 21; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Zaku
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Airwave (src)
			Jutsus += new/obj/Jutsus/Compressed_Airwave (src)
	//		Jutsus += new/obj/Jutsus/Compressed_Airwave (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 250)) goto loop}

	Kin {name = "Kin"; icon = 'Kin.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 13.5; Def = 7.85; MaxHP = 125; HP = 125; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 19.5; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Kin
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Dosu (src)
			Jutsus += new/obj/Jutsus/Sound_Spiral (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}

	Dosu {name = "Dosu"; icon = 'Dosu.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 12.5; Def = 8; MaxHP = 105; HP = 105; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 18; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Dosu
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Dosu (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(Iron || Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}

	Hanabi {name = "Hanabi"; icon = 'Hanabi.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 14; Def = 7.75; MaxHP = 150; HP = 150; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 18; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Hanabi
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Haku (src)
			overlays += new/obj/Byakugan
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}

	Haku {name = "Haku"; icon = 'Haku.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 14; Def = 7.65; MaxHP = 185; HP = 195; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 19; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Haku
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Water_Dragon_Haku (src)
			Jutsus += new/obj/Jutsus/Demon_Mirrors (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); if(istype(S, /obj/Jutsus/Demon_Mirrors)) {spawn(750) Jutsus += new/obj/Jutsus/Demon_Mirrors (src); del(S)}; S.Delay = 0; S.Click(); spawn(rand(200, 350)) goto loop}

	Zabuza {name = "Zabuza"; icon = 'Zabuza.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 15; Def = 8; MaxHP = 200; HP = 200; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 21; Scroll_Kunais_L = 100000; Chances_Dodge = 27.5; Chances_Substitution = 17.5; Shurikens_L = 10000}

	Zabuza
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Water_Bubble_Zabuza (src)
			Jutsus += new/obj/Jutsus/Water_Bubble_Zabuza (src)
			Jutsus += new/obj/Jutsus/Water_Bubble_Zabuza (src)
			Jutsus += new/obj/Jutsus/Immense_Tsunami_Zabuza (src)
			Jutsus += new/obj/Jutsus/Kirigakure_Jutsu (src)
			Jutsus += new/obj/Jutsus/Kirigakure_Jutsu (src)
			Ignored_Challengers += new/obj/Jutsus/Water_Splash (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(175, 300)) goto loop}

	Hinata {name = "Hinata"; icon = 'Graphics/Characters/Hinata.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 15; Def = 8; MaxHP = 150; HP = 150; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 20; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Hinata
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Eight_Trigrams_Air_Palm_ (src)
			overlays += new/obj/Byakugan
			Target = T
			set_state()
			spawn() Special_AI()

	Neji {name = "Neji"; icon = 'Neji.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 16; Def = 8.5; MaxHP = 150; HP = 150; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 21; Scroll_Kunais_L = 100000; Chances_Dodge = 27.5; Chances_Substitution = 15; Shurikens_L = 10000}

	Neji
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Rotation (src)
			overlays += new/obj/Byakugan
			Target = T
			set_state()
			spawn() Special_AI()

	Jirobo {name = "Jirobo"; icon = 'Jirobo.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 14.75; Def = 8.5; MaxHP = 85; HP = 85; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 21; Scroll_Kunais_L = 100000; Chances_Dodge = 22.5; Chances_Substitution = 12.5; Shurikens_L = 10000}

	Jirobo
		New(loc, T)
			..()
			Target = T
			set_state()
			spawn() Special_AI()

	Kidoumaru {name = "Kidoumaru"; icon = 'Kidoumaru.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 14; Def = 8.5; MaxHP = 75; HP = 75; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 22; Scroll_Kunais_L = 100000; Chances_Dodge = 22.5; Chances_Substitution = 12.5; Shurikens_L = 10000}

	Kidoumaru
		New(loc, T)
			..()
			Target = T
			set_state()
			spawn() Special_AI()

	Tayuya {name = "Tayuya"; icon = 'Tayuya.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 14; Def = 8.25; MaxHP = 70; HP = 70; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 21; Scroll_Kunais_L = 100000; Chances_Dodge = 22.5; Chances_Substitution = 12.5; Shurikens_L = 10000}

	Tayuya
		New(loc, T)
			..()
			Target = T
			set_state()
			spawn() Special_AI()

	Sakon {name = "Sakon"; icon = 'Sakon.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 15; Def = 8.35; MaxHP = 75; HP = 75; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 21; Scroll_Kunais_L = 100000; Chances_Dodge = 22.5; Chances_Substitution = 12.5; Shurikens_L = 10000}

	Sakon
		New(loc, T)
			..()
			Target = T
			set_state()
			spawn() Special_AI()

	Kimimaro {name = "Kimimaro"; icon = 'Kimimaro.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 15.50; Def = 8.50; MaxHP = 130; HP = 130; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 21; Scroll_Kunais_L = 100000; Chances_Dodge = 22.5; Chances_Substitution = 12.5; Shurikens_L = 10000}

	Kimimaro
		New(loc, T)
			..()
			Target = T
			set_state()
			spawn() Special_AI()


	Jirobo_I {name = "Jirobo"; icon = 'Jirobo.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 16; Def = 8; MaxHP = 250; HP = 250; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 19.5; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Jirobo_I
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Rock_Throw (src)
			Jutsus += new/obj/Jutsus/Brutal_Tackle (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(!Active_AI) spawn(75) goto loop
				else if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}


	Tayuya_I {name = "Tayuya"; icon = 'Tayuya.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 13.5; Def = 7; MaxHP = 200; HP = 200; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 19.5; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Tayuya_I
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Revolt_Demon (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(!Active_AI) spawn(75) goto loop
				else if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}

	Sakon_I {name = "Sakon"; icon = 'Sakon.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 15; Def = 7.5; MaxHP = 240; HP = 240; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 19.5; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Sakon_I
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw (src)
			Ignored_Challengers += new/obj/Jutsus/Bullet_Punch (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(!Active_AI) spawn(75) goto loop
				else if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}


	Kidoumaru_I {name = "Kidoumaru"; icon = 'Kidoumaru.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 15; Def = 7.5; MaxHP = 240; HP = 240; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 19.5; Scroll_Kunais_L = 100000; Chances_Dodge = 25; Chances_Substitution = 15; Shurikens_L = 10000}

	Kidoumaru_I
		New(loc, T)
			..()
			Jutsus += new/obj/Jutsus/Spider_Sticky_Gold (src)
			Jutsus += new/obj/Jutsus/Spider_Sticking_Spit (src)
			Target = T
			set_state()
			spawn() Special_AI()
			spawn(rand(50, 150)) loop
				if(!Active_AI) spawn(75) goto loop
				else if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}

	Kimimaro_I {name = "Kimimaro"; icon = 'Kimimaro.dmi'; dir = WEST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 18.75; Def = 9.75; MaxHP = 550; HP = 550; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 21.5; Scroll_Kunais_L = 100000; Chances_Dodge = 27.5; Chances_Substitution = 20; Shurikens_L = 10000}

	Kimimaro_I
		New(loc, NEM_Round/N)
			..()
			Ignored_Challengers += new/obj/Jutsus/Teshi_Sendan (src)
			Jutsus += new/obj/Jutsus/Bone_Bullets (src)
			N.Join(src)
			dir = WEST
			set_state()
			spawn(rand(50, 150)) loop
				if(!Active_AI) spawn(75) goto loop
				else if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}

	Sasuke_I {name = "Sasuke"; icon = 'Sasuke.dmi'; dir = WEST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 19.5; Def = 10; MaxHP = 600; HP = 600; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 22.5; Scroll_Kunais_L = 100000; Chances_Dodge = 30.5; Chances_Substitution = 20; Shurikens_L = 10000}

	Sasuke_I
		bump(atom/A)
			if(Chidori == "NPC" && ismob(A)) {new/obj/Effects/Meele_Hit (A:loc, A); if(A:client) {A:client.perspective = MOB_PERSPECTIVE; A:client.eye = A}; flick("hurt", A); A:HP = 0; A:Cha = 0; A:Energy = 0; A:knocked = 1; Substitution = 1; spawn(0.40) Substitution = 0; return}
			..()

		New(loc, NEM_Round/N)
			..()
			Jutsus += new/obj/Jutsus/Chidori_Sasuke (src)
			Jutsus += new/obj/Jutsus/Giant_FireBall_Sasuke (src)
			Ignored_Challengers += new/obj/Jutsus/Chidori_Stream (src)
			N.Join(src)
			dir = WEST
			set_state()
			spawn(rand(50, 150)) loop
				if(!Active_AI) spawn(75) goto loop
				else if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}

	Orochimaru_I {name = "Orochimaru"; icon = 'Orochimaru.dmi'; dir = WEST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 19.35; Def = 9.75; MaxHP = 800; HP = 800; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 22.5; Scroll_Kunais_L = 100000; Chances_Dodge = 30.5; Chances_Substitution = 20; Shurikens_L = 10000}

	Orochimaru_I

		New(loc, NEM_Round/N)
			..()
			Jutsus += new/obj/Jutsus/Snakes_Summoning (src)
			Ignored_Challengers += new/obj/Jutsus/Snake_Bite (src)
			Ignored_Challengers += new/obj/Jutsus/Wind_BT (src)
			N.Ninjas.Add(src)
			NEM_Round = N
			Active_AI = 0
			Movement()
			dir = WEST
			set_state()
			spawn(rand(250, 400)) loop
				if(!Active_AI) spawn(75) goto loop
				else if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(200, 400)) goto loop}

	Kabuto_I {name = "Kabuto"; icon = 'Kabuto.dmi'; dir = WEST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 19; Def = 9.50; MaxHP = 725; HP = 725; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; Move_Speed = 22.5; Scroll_Kunais_L = 100000; Chances_Dodge = 30.5; Chances_Substitution = 20; Shurikens_L = 10000}

	Kabuto_I

		New(loc, NEM_Round/N)
			..()
			Jutsus += new/obj/Jutsus/Dead_Soul_Summoning (src)
			Jutsus += new/obj/Jutsus/Chakra_Scalpel (src)
			Ignored_Challengers += new/obj/Jutsus/Tornedo (src)
			spawn() Mission_Show_(src, "<font color=#BABABA><b><font size=3><center>Everything is prepared, Orochimaru-sama", N, 45)
			flick("teleport", src)
			N.Ninjas.Add(src)
			NEM_Round = N
			Active_AI = 0
			Movement()
			dir = WEST
			set_state()
			spawn(rand(100, 200)) loop
				if(!Active_AI) spawn(75) goto loop
				else if(Target.knocked || Target.Dragonned || freeze || Attacking || knockback || Target.px > px && dir == WEST || Target.px < px && dir == EAST) spawn(30) goto loop
				else {var/obj/Jutsus/S = pick(Jutsus); S.Delay = 0; S.Click(); spawn(rand(100, 200)) goto loop}

	proc/Special_AI()
		set background = 1
		var/Current_Jump

		loop
			clear_input()
			running = 1
			UnEffective ++

			if(!Active_AI) return
			if(dead)  {if(vel_x > 0) {vel_x -= 0.5; if(vel_x < 0) vel_x = 0}; else if(vel_x < 0) {vel_x += 0.5; if(vel_x > 0) vel_x = 0}}
			if(dead && !vel_x) return

			if(freeze < 0) freeze = 0

			Bumped = 0

			if(Target.knocked) vel_x = 0
			if(!knocked && !knockback && !freeze && !input_lock && !Attacking && !Target.knocked && !Target.Substitution && !Iron && !Chidori && !Rasengan && !Iron)

				if(Target.freeze) if(prob(Chances_Dodge/1.5)) Set_Dodge()

				if(Target.Active_Attack)
					if(prob(Chances_Substitution*1.75) && !Dragonned) Substitution()
					else if(prob(Chances_Dodge*1.75)) Set_Dodge()

				if(Target.Attacking == 1)
					if(prob(Chances_Substitution/1.5) && !Dragonned) Substitution()
					else if(prob(Chances_Dodge/1.5)) Set_Dodge()

				var/V
				if(prob(Chances_Dodge) && !DodgeCD) V = "Dodge"
				else if(prob(Chances_Substitution) && !SubstitutionCD) V = "Substitution"

				if(V)
					var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 240, 80)
					var/list/Projectile = Bounds.Projectile()
					for(var/mob/M in Projectile)
						if(abs(px - M.px) < 220)
							if(V == "Substitution" && !Dragonned) Substitution()
							else Set_Dodge()
						else
							jump()
							spawn() double_jump()

				if(!Active_Attack)

					if(!on_ground && !Double_Jump && Target.py > py && vel_y < 0) double_jump()

					else if(Target.py > py && on_ground && Target.on_ground) {vel_y = 12; Jumping = 1; spawn(10) Jumping = 0}

					else if(Target.py > py && Enemy_Jumped != Current_Jump)
						if(Target.vel_y > 0 && prob(75) || Target.vel_y < 0 && prob(25))
							Enemy_Jumped ++
							Current_Jump = Enemy_Jumped
							if(on_ground && Jumping == 0)
								vel_y = 12
								Jumping = 1
								spawn(10) Jumping = 0

					else if(Target.py < py)
						if(dir == EAST && Target.px -px > 4 && Target.px -px < 54) {keys[controls.down] = 1; Attack(); Move_Speed /= 2; spawn(7.5) Move_Speed = Normal_Move_Speed}
						else if(dir == WEST && Target.px -px < -4 && Target.px -px > -54) {keys[controls.down] = 1; Attack(); Move_Speed /= 2; spawn(7.5) Move_Speed = Normal_Move_Speed}

					if(on_ground && prob(3)) jump()
					if(Target.on_ground) {Current_Jump = Enemy_Jumped -1}

					if(Target.px > px)
						dir = EAST
						vel_x = min(Move_Speed, Target.px-px)

					else if(Target.px < px)
						dir = WEST
						vel_x = min(-Move_Speed, px -Target.px)

					if(name == "Dosu" && prob(1.5) && Target.on_ground && on_ground)
						var/obj/Jutsus/J = new/obj/Jutsus/Resonating_Echo_Drill (src)
						J.Click()
						spawn(100) del(J)

					else if(abs(Target.px -px) < 48 && !on_ground && py - Target.py > 8) {keys[controls.down] = 1; Attack(); Move_Speed /= 2; spawn(7.5) Move_Speed = Normal_Move_Speed}

					else if(Target.px == px)
						if(dir == WEST) {dir = EAST; vel_x = 7}
						else {dir = WEST; vel_x = -7}


			spawn(3) goto loop


mob/Mission_NPC_
	Mission_NPC = 1

	Gaara {var/Jumping; name = "Gaara"; icon = 'Graphics/Characters/Gaara.dmi'; dir = EAST; Real_Person = 1; Check_Icon = 1; running = 1; Real = 1; Deaths = 3; Checked_X = 1; Str = 15; Def = 8.75; MaxHP = 450; HP = 450; MaxCha = 10000000000000; Cha = 100000000000000000000; MaxEnergy = 10000000000000; Energy = 10000000000000; var/Move_Speed = 18; Scroll_Kunais_L = 100000; Shurikens_L = 10000}

	Gaara
		bump(M, d) {..(); if(ismob(M) && M:Village != Village && on_ground) if(d == EAST || d == WEST) jump()}

		New(loc, T)
			..()
			Target = T
			Village = Target.Village
			set_state()
			spawn() {Gaara_AI()}

		Death_Check()
			..()
			if(dead && FFF) {FFF = 0; NEM_Round.Del("Lost")}

		proc/Gaara_AI()
			set background = 1

			loop

				if(freeze < 0) freeze = 0
				if(Attacked)
					if(prob(5) && !Dragonned) Substitution()
					else if(prob(15)) Set_Dodge()

				if(Target.knocked) vel_x = 0
				else if(!knocked && !knockback && !freeze && !Target.knocked && !Target.Substitution)
					if(Target.py > py && NEM_Round.Bijuu_Dama) {if(!Levitating) {icon = 'Graphics/Skills/Gaara Flying.dmi'; Levitating = 1; fall_speed = 10}; vel_y = 10}

					else if(Target.py > py && on_ground && Target.on_ground) {vel_y = 12; Jumping = 1; spawn(10) Jumping = 0}

					else if(Target.py > py)

						if(Target.vel_y > 0 || Target.vel_y < 0 && prob(25))
							if(!on_ground && !Double_Jump && Target.py > py && Target.vel_y > vel_y*1.75) double_jump()
							else if(on_ground && Jumping == 0)
								vel_y = 12
								Jumping = 1
								spawn(10) Jumping = 0

					if(Levitating && Target.py -py < 0) {icon = 'Graphics/Characters/Gaara.dmi'; Levitating = 0; fall_speed = 20}

					if(Target.px > px)
						dir = EAST
						vel_x = 0
						if(abs(Target.px -px) > 300)
							running = 1
							vel_x = min(Move_Speed, Target.px-px)
						else if(abs(Target.px - px) > 112)
							running = 0
							vel_x = min(Move_Speed/1.55, Target.px-px)

					if(Target.px < px)
						dir = WEST
						vel_x = 0
						if(abs(Target.px -px) > 300)
							running = 1
							vel_x = min(-Move_Speed, px -Target.px)
						else if(abs(Target.px - px) > 112)
							running = 0
							vel_x = min(-Move_Speed/1.55, px -Target.px)

				spawn(3) goto loop