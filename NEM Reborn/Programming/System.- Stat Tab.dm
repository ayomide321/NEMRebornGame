obj/BigSmoke
	icon = 'Graphics/bigsmoke.dmi'
	layer = 105
	New()
		Flick("smoke",src)
		spawn(5)del(src)



mob/var/Special_Eye
mob/var/Moving

mob/New()
	..()
	spawn() if(Active_M) Movement()

mob/proc/Movement()
	Moving = rand(1, 10000)
	var/R = Moving

	loop
		if(Moving != R) return
		check_loc()
		movement()
		spawn(world.tick_lag) if(loc) goto loop

mob

	Stat()

		..()

		if(Overlay < 0) Overlay = 0
		if(Attacking < 0) Attacking = 0
		if(freeze < 0) freeze = 0
		if(freeze && !S_K_A) Dodging = 0
		if(Special_Crow) Dodging = 1
		var/Observing_

		if(!AFK)
			if(_Squad_Area)
				if(_Squad_Area.Stage == 1 && _Squad_Area.Captured) Announced("<font color=#609BF2><b><u>* [_Squad_Area.name] belongs to Squad [_Squad_Area.Captured.Name] - [_Squad_Area.Time]/15</u>")
				else if(_Squad_Area.Stage == 2 && _Squad_Area.Squad_In) Announced("<font color=#609BF2><b><u>* [_Squad_Area.name] is being reverted - [_Squad_Area.Time]</u>")
				else if(_Squad_Area.Stage == 3 && _Squad_Area.Squad_In) Announced("<font color=#609BF2><b><u>* [_Squad_Area.name] is being captured by Squad [_Squad_Area.Squad_In.Name] - [_Squad_Area.Time]/30</u>")

			else if(Announcement_Time > 0) Announced("[Announce_M]</u> ([Announcement_Time])")

			else if(!Transformed)
				if(Question_Alert == 1)
					if(Question_Time > 1) Announced("<center><b><font color=#C80000><u>* Choose a round to join, [Question_Time] seconds left! *</u>")
					else Announced("<center><b><font color=#C80000><u>* Choose a round to join, [Question_Time] second left! *</u>")

				else if(Question_Alert == 2)
					if(Question_Time > 1) Announced("<center><b><font color=#C80000><u>* [New_Mode] will begin in [Question_Time] seconds! *</u>")
					else Announced("<center><b><font color=#C80000><u>* [New_Mode] will begin in [Question_Time] second! *</u>")

				else if(NEM_Round && NEM_Round.Type == "Mission")
					if(NEM_Round.Stage == 1 && NEM_Round.Mode == "Orochimaru's Wrath") Announced("<center><b><font color=#C80000><u>* Mission: [NEM_Round.Mode] will start in [NEM_Round.Time]! *</u>")
					else Announced("<center><b><font color=#C80000><u>* Mission: [NEM_Round.Mode] will end in [NEM_Round.Time]! *</u>")

				else if(!Special_Eye && client.eye != src && !Controlling_Object && ismob(client.eye))
					if(!client.eye || client.eye:dead || client.eye:key == client.eye:name)
						client.eye = src
						client.perspective = MOB_PERSPECTIVE

				else if(NEM_Round && NEM_Round.Mode == "Challenge")
					if(NEM_Round.Time > 0 && NEM_Round.Started) Announced("<b><font color=#FD3838><u><center>* Fighting [NEM_Side.Enemy.Name]! Time Left: [NEM_Round.Time] *</u>")
					else if(NEM_Round.Time > 1) Announced("<b><font color=#FD3838><u><center>* The Challenge will start in [NEM_Round.Time] seconds! *</u>")
					else if(NEM_Round.Time == 1) Announced("<b><font color=#FD3838><u><center>* The Challenge will start in [NEM_Round.Time] second! *</u>")

				else if(NEM_Round && NEM_Round.Type == "Tourney")
					if(Announced_Text) Announced(Announced_Text)
					if(NEM_Round.Time > 1 && !NEM_Round.Started) Announced("<center><b><font color=#FFD203><u>* The Tournament will start in [NEM_Round.Time] seconds *</u>")
					else if(NEM_Round.Time == 1 && !NEM_Round.Started) Announced("<center><b><font color=#FFD203><u>* The Tournament will start in [NEM_Round.Time] second *</u>")
					else if(!NEM_Round.Time && name == key) Announced("<center><b><font color=#FFD203>* The Tournament has already started, you can not join now *")
					if(!Announced_Text && Round_GoingOn && NEM_Round.Time > 1) Announced("<b><font color=#FFD203>Tournament.- The Round #[Round] will begin in [NEM_Round.Time] seconds!")
					else if(!Announced_Text && Round_GoingOn && NEM_Round.Time == 1) Announced("<b><font color=#FFD203>Tournament.- The Round #[Round] will begin in [NEM_Round.Time] second!")

				else if(name == key && !Question_Alert)
					if(NEM_Round && NEM_Round.Type == "King Of The Hill") Announced("<center><b><font color=#A60000><u>* King of the Hill Event! *</u>")
					else if(Time_Left > 1) Announced("<center><b><font color=#A60000><u>* [Time_Left] seconds remaining to choose a character *</u>")
					else if(Time_Left == 1) Announced("<center><b><font color=#A60000><u>* [Time_Left] second remaining to choose a character *</u>")
					else if(On_Special_Character_Screen) Announced("<font color=#A60000><u><b>* Round Locked.- You must wait until the next round to choose a character.</u>")

				else if(name != key) Announced("<center><b><font color=#A60000><u>* Now Playing As [name] *</u>")


		if(name != key && !Mind_Controlling && !Mind_Controlled && !Observing_)
			winset(src, "default.HPBar","value=\"[round(100*src.HP/src.MaxHP)]%\"")
			winset(src, "default.ChaBar","value=\"[round(100*src.Cha/src.MaxCha)]%\"")
			winset(src, "default.EnergyBar","value=\"[round(100*src.Energy/src.MaxEnergy)]%\"")

		statpanel("World")
		if(Mute)
			stat("You'll be automatically unmuted in [Mute_Time] seconds")
			stat("")

		if(NEM_Round == Arena)
			stat("<b><u>* Arena *")

		if(NEM_Round && NEM_Round.Type == "King Of The Hill")
			stat("")
			stat("* King of the Hill *")
			stat("Time Left: [NEM_Round.Time]")
			stat("")
			for(var/Squad/S in Squads) stat("~Squad [S.Name]- [round(S.Points, 0.25)]")
		if(Capture_The_Flag == 1)
			stat("")
			stat("* Capture The Flag Event *")
			stat("")
			stat("Captured Flags: [Leaf_Flags]/[Flags_Required] ~Allied Shinobi Forces")
			stat("Captured Flags: [Akatsuki_Flags]/[Flags_Required] ~Akatsuki")
		if(Attacked_ > 0) Attacked_ --
		if(Attacked_ < 0) Attacked_ = 0
		Attacked = Attacked_

		if(CTD)
			stat("")
			stat("Current Mode: Custom Team Deathmatch")
			stat("")
			stat("")
			stat("[Leaf.Name]- [Leaf.Ninjas] Shinobis")
			stat("[Akatsuki.Name]- [Akatsuki.Ninjas] Members")

		if(Boss_Mode)
			stat("")
			stat("Current Mode: Juggernaut")
			stat("")
			stat("")
			stat("* Juggernaut: [Juggernaut.name] - [Juggernaut.Juggernaut_Points]/[Juggernaut_Goal] Points")
			stat("")
			stat("")
			if(Juggernaut_Points == 0) stat("- You have no points")
			if(Juggernaut_Points == 1) stat("- You have [Juggernaut_Points] Point")
			if(Juggernaut_Points > 1) stat("- You have [Juggernaut_Points] Points")
			stat("")
			stat("")

		if(NEM_Round && NEM_Round.Type == "Tourney")
			stat("")
			stat("Current Mode: Tournament")
			stat("Tournament's Prize: [Prize]")
			stat("")
			stat("Round #[Round]")
			if(Bet)
				if(Red_Team_Bets.Find(src))
					if(Round_Type == "1vs1") stat("- You have bet [Bet] ryo for [Red_Team_]")
					else stat("- You have bet [Bet] ryo for Red Team")
				if(Blue_Team_Bets.Find(src))
					if(Round_Type == "1vs1") stat("- You have bet [Bet] ryo for [Blue_Team_]")
					else stat("- You have bet [Bet] ryo for  Blue Team")
			stat("")
			stat("")
			if(Lost_Tourney == 0) stat("* You are in the Tournament *")
			if(Lost_Tourney == 1) stat("* You are not in the Tournament *")

		if(NEM_Round == Current_NEM_Round && !CTD)
			stat("<u><b>Current Mode: Allied Shinobi Forces Vs Akatsuki")
			stat("")
			stat("")
			stat("[Leaf.Name]- [Leaf.Ninjas] Shinobis")
			stat("[Akatsuki.Name]- [Akatsuki.Ninjas] Members")
		if(Healer_Character == 1 && name != "Pein")
			stat("")
			var/Check = 5 - Revived_T
			if(Check >= 2) stat("You have [Check] revives left")
			if(Check == 1) stat("You have [Check] revive left")
			if(Check <= 0) stat("You can no longer revive")

		stat("")
		stat("")
		stat("<u><b>Active Missions: [length(_Active_Missions_)]")
		stat(Menu_)

		if(name != key)
			statpanel("Jutsus")
			var/N = 3-Deaths
			if(N < 0) N = 0
			stat("* Lives: [N] *")
			if(Kunais) stat(Kunai_Jutsu)
			if(Scroll_Kunais) stat(Scroll_Kunai_Jutsu)
			if(Shurikens) stat(Shuriken_Jutsu)
			stat("")
			stat(Jutsus)

mob/var/Shurikens = 0
mob/var/Shurikens_L = 0
mob/var/Kunais = 0
mob/var/Kunais_L = 0
mob/var/Scroll_Kunais = 0
mob/var/Scroll_Kunais_L = 0