atom/var/Special_Floor_Var

var
	list/Troll = list("OXuchihaXO", "24.102.241.94")
	list/Bans = list()
	list/Illegal_Characters = list()
	list/Illegal_Characters_X = list()
	list/Active_Rounds = list()
	Verified75 = 1
	Updated = 1
	Ninja_Alive
	Just_Finished
	Juggernaut_Goal = 30
	Boss_Mode_

mob/Dragonpearl123/verb/Destroy_Logs()
	if(alert(src, "Are you sure?", "Update Pills", "No", "Yes") == "Yes")
		if(alert(src, "Are you sure?", "Update Pills", "No", "Yes") == "Yes")
			if(alert(src, "Are you sure?", "Update Pills", "No", "Yes") == "Yes")
				if(alert(src, "Are you sure?", "Update Pills", "No", "Yes") == "Yes")
					if(alert(src, "Are you sure?", "Update Pills", "No", "Yes") == "Yes")
						for(var/Log/L in Logs) del(L)
						for(var/Admin_Log/A in Admin_Logs) del(A)
						for(var/Personal_Log/P in Personal_Logs) del(P)
						Current_Log = null
						Personal_Logs = list()
						Admin_Logs = list()
						Logs = list()

						var/Date = time2text(world.timeofday, "Month ~Day #DD")
						new/Log (Date)
						world.Reboot()


proc
	Check_Winner(NEM_Round/Round)
		if(Round.Type == "King Of The Hill" || Round.Type == "Tourney") return
		if(Round.Type == "Mission" || Round.Mode != "Normal" && Round.Mode != "Juggernaut Mode" && Round.Mode != "Challenge") return

		if(Round.Mode == "Juggernaut Mode")
			if(Juggernaut.Juggernaut_Points >= Juggernaut_Goal)
				Auto_Balancer = 1
				Juggernaut.NEM_Round.Shout("<b><font color=red><font size=3><u>Juggernaut [Juggernaut.key] - [Juggernaut.name] has managed to obtain [Juggernaut_Goal] points, good job!</u>")
				Juggernaut.Statistic.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Became The Juggernaut! *"
				Juggernaut.Ryo_Reward(25, 1)
				spawn(30)
					Auto_Balancer = 1
					world.Reboot()

		if(Round.Mode == "Challenge")
			var
				Losers
				NEM_Side/Loser
				NEM_Side/Winner

			for(var/NEM_Side/S in Round.Groups)
				if(!S.Ninjas) {Loser = S; Losers++}
				if(S.Ninjas) Winner = S

			if(!Losers) return
			if(Losers == 2) Round.Ninjas<<"<b><font size=2><font color=[admin_color]><u>Both ninjas have died, so nobody's won!</u>"
			world<<"<b><font color=[admin_color]><u>* Challenge.- [Winner.Name] has defeated [Loser.Name]!</u>"
			del(Round)
			return


		if(Round.Mode == "Normal" && !Just_Finished)
			var
				Losers
				NEM_Side/Loser

			for(var/NEM_Side/S in Round.Groups)
				if(!S.Ninjas) {Loser = S; Losers++}
				if(S.Ninjas) Winner = S

			if(!Losers) return
			if(Losers == 2) Round.Ninjas<<"<b><font size=2><font color=[admin_color]><u>Everybody's dead, so nobody's won!</u>"
			else if(Loser.Name == "Akatsuki")
				Round.Ninjas<<"<b><font size=2><font color=#00FF00><u>Allied Shinobi Forces have won, all the Akatsuki Members are dead!</u>"
			else if(Loser.Name == "Allied Shinobis Forces")
				Round.Ninjas<<"<b><font size=2><font color=#8904B1><u>Akatsuki has won, all the Alliance Shinobis are dead!</u>"

			for(var/mob/M in Round.Ninjas)
				M.icon_state = "mob-standing"
				M.freeze = 777
				M.stop()
			Just_Finished = 1
			spawn(75) Just_Finished = 0
			spawn(15) Reset_World(Round)

	banlistsave()
		if(!WorldSave) return
		var/savefile/F = new("Worldsaves/Bans.sav")
		if(!AllowedPoisonX) AllowedPoison = 0
		if(AllowedPoisonX) AllowedPoison = 1
		if(!AllowedAmaterasuX) AllowedAmaterasu = 0
		if(AllowedAmaterasuX) AllowedAmaterasu = 1
		F["CTD_Leaf_Ninjas"] << CTD_Leaf_Ninjas
		F["Lucky_Number"] << Lucky_Number
		F["CTD_Akatsuki_Ninjas"] << CTD_Akatsuki_Ninjas
		F["Capture_The_Flag_X"] << Capture_The_Flag_X
		F["Set_To_Load"] << Set_To_Load
		F["Donators_Keys"] << Donators_Keys
		F["Donators_IPs"] << Donators_IPs
		F["Donators_CIs"] << Donators_CIs
		F["_Reboot_Poll_"] << _Reboot_Poll_
		F["Been_Here"] << Been_Here
		F["_CTD_Timer_"] << _CTD_Timer_
		F["_Timer_"] << _Timer_
		F["Players_"] << Players_
		F["admin_color"] << admin_color
		F["Anti_Lag"] << Anti_Lag
		F["Clones"] << Clones
		F["HUB_Status"] << HUB_Status
		F["Auto_Balancer"] << Auto_Balancer
		F["WelcomeMessage"] << WelcomeMessage
		F["Current_Log"] << Current_Log
		F["Admin_Logs"] << Admin_Logs
		F["Personal_Logs"] << Personal_Logs
		F["Logs"] << Logs
		F["Players"] << Players
		F["Messages"] << Messages
		F["Rating"] << Rating
		F["PlayersWhoVoted"] << PlayersWhoVoted
		F["Tournament_On_Next_Round"] << Tournament_On_Next_Round
		F["Next_Prize"] << Next_Prize
		F["Updated"] << Updated
		F["Bans"] << Bans
		F["Players_NEM"] << Players_NEM
		F["Next_Mode"] << Next_Mode
		F["Reports"] << Reports
		F["Alliances"] << Alliances
		F["IDs"] << IDs
		F["Votations"] << Votations
		F["Donators"] << Donators
		F["NextSpawn"] << NextSpawn
		F["GlobalBanList"] << GlobalBanList
		F["RoundsRequired"] << RoundsRequired
		F["SpecialX"] << SpecialX
		F["AllowedPoison"] << AllowedPoison
		F["Ino_Allowed"] << Ino_Allowed
		F["AllowedAmaterasu"] << AllowedAmaterasu
		F["Statistics"] << Statistics
		F["CTD_Next"] << CTD_Next
		F["Auctions"] << Auctions
		F["MCKN"] << MCKN
		F["MCKNV"] << MCKNV
		F["Donators"] << Donators
		F["Hanabi_Owners"] << Hanabi_Owners
		F["Torune_Owners"] << Torune_Owners
		F["Yagura_Owners"] << Yagura_Owners
		F["Kushimaru_Owners"] << Kushimaru_Owners
		F["Chikushodo_Owners"] << Chikushodo_Owners
		F["Lord_Itachi_Owners"] << Lord_Itachi_Owners
		F["Special_ANBU_Owners"] << Special_ANBU_Owners
		F["Rinnegan_Tobi_Owners"] << Rinnegan_Tobi_Owners
		F["Eternal_Sasuke_Owners"] << Eternal_Sasuke_Owners
		F["Minato_Namikaze_Owners"] << Minato_Namikaze_Owners

	banlistload()
		if(fexists("Worldsaves/Bans.sav"))
			var/savefile/load = new("Worldsaves/Bans.sav")
			load["MCKN"] >> MCKN
			if(!MCKN) MCKN = "Nobody"
			load["MCKNV"] >> MCKNV
			if(!MCKNV) MCKNV = 0
			load["Donators"] >> Donators
			load["Hanabi_Owners"] >> Hanabi_Owners
			load["Torune_Owners"] >> Torune_Owners
			load["Yagura_Owners"] >> Yagura_Owners
			load["Kushimaru_Owners"] >> Kushimaru_Owners
			load["Chikushodo_Owners"] >> Chikushodo_Owners
			load["Lord_Itachi_Owners"] >> Lord_Itachi_Owners
			load["Special_ANBU_Owners"] >> Special_ANBU_Owners
			load["Rinnegan_Tobi_Owners"] >> Rinnegan_Tobi_Owners
			load["Eternal_Sasuke_Owners"] >> Eternal_Sasuke_Owners
			load["Minato_Namikaze_Owners"] >> Minato_Namikaze_Owners

			if(!Donators) Donators = list()
			if(!Hanabi_Owners && !Torune_Owners && !Yagura_Owners && !Kushimaru_Owners && !Chikushodo_Owners && !Lord_Itachi_Owners && !Special_ANBU_Owners && !Rinnegan_Tobi_Owners && !Eternal_Sasuke_Owners && !Minato_Namikaze_Owners)
				Hanabi_Owners = list()
				Torune_Owners = list()
				Yagura_Owners = list()
				Kushimaru_Owners = list()
				Chikushodo_Owners = list()
				Lord_Itachi_Owners = list()
				Special_ANBU_Owners = list()
				Rinnegan_Tobi_Owners = list()
				Eternal_Sasuke_Owners = list()
				Minato_Namikaze_Owners = list()

			load["CTD_Leaf_Ninjas"] >> CTD_Leaf_Ninjas
			load["CTD_Akatsuki_Ninjas"] >> CTD_Akatsuki_Ninjas
			load["CTD_Next"] >> CTD
			load["_Reboot_Poll_"] >> _Reboot_Poll_
			load["_CTD_Timer_"] >> _CTD_Timer_
			load["Auctions"] >> Auctions
			if(!Auctions) Auctions = list()
			load["_Timer_"] >> _Timer_
			CTD_Next = 0
			load["Capture_The_Flag_X"] >> Capture_The_Flag_X
			load["Lucky_Number"] >> Lucky_Number
			if(isnull(Lucky_Number)) Lucky_Number = new/Lucky_Number (1)
			if(Capture_The_Flag_X == 1)
				Capture_The_Flag_X = 0
				Capture_The_Flag = 1
				for(var/obj/Akatsuki_Flag_Spawn/A in world) new/mob/Akatsuki_Flag (A:loc)
				for(var/obj/Leaf_Flag_Spawn/L in world) new/mob/Leaf_Flag (L:loc)
			load["Donators_Keys"] >> Donators_Keys
			load["Updated"] >> Updated
			load["Players_NEM"] >> Players_NEM
			if(!Players_NEM) Players_NEM = list()
			load["Donators_IPs"] >> Donators_IPs
			load["IDs"] >> IDs
			load["Donators"] >> Donators
			load["Camera_Lag_X"] >> Camera_Lag_X
			load["Donators_CIs"] >> Donators_CIs
			load["NextSpawn"] >> NextSpawn
			NextSpawn ++
			if(NextSpawn >= 6 || NextSpawn <= 0) {NextSpawn = 1; Spawn = 1}
			else Spawn = NextSpawn
			Current_NEM_Round = new/NEM_Round ("Normal")

			load["Reports"] >> Reports
			load["Statistics"] >> Statistics
			if(!Reports) Reports = list()
			load["Alliances"] >> Alliances
			if(length(Alliances) < 4 || !Alliances)
				new/Alliance ("Hidden Leaf", "Village", null, "[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")]")
				new/Alliance ("Hidden Sand", "Village", null, "[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")]")
				new/Alliance ("Hidden Cloud", "Village", null, "[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")]")
				new/Alliance ("Hidden Mist", "Village", null, "[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")]")
			load["Players_"] >> Players_
			if(!Players) Players = list()
			load["Clones"] >> Clones
			load["Been_Here"] >> Been_Here
			load["GlobalBanList"] >> GlobalBanList
			load["Players"] >> Players
			if(!Players) Players = "<html><body><font color=white><style = \"text/css\">body { background-color:black} </style></body></html><b><u><font size=3>World Log</font size></u></font><br></b>"
			load["HUB_Status"] >> HUB_Status
			world.status = HUB_Status
			load["Auto_Balancer"] >> Auto_Balancer
			load["Votations"] >> Votations
			load["WelcomeMessage"] >> WelcomeMessage
			load["Current_Log"] >> Current_Log
			load["Logs"] >> Logs
			load["Personal_Logs"] >> Personal_Logs
			load["Admin_Logs"] >> Admin_Logs
			load["Messages"] >> Messages
			load["Ino_Allowed"] >> Ino_Allowed
			load["Bans"] >> Bans
			if(!Updated)
				Bans = list()
				Updated = 1
			load["Rating"] >> Rating
			load["PlayersWhoVoted"] >> PlayersWhoVoted
			load["RoundsRequired"] >> RoundsRequired
			load["Anti_Lag"] >> Anti_Lag
			load["admin_color"] >> admin_color
			if(!admin_color)
				admin_color = "94E0FA"
			if(AllowedPoison)
				load["AllowedPoison"] >> AllowedPoison
			if(AllowedAmaterasu)
				load["AllowedAmaterasu"] >> AllowedAmaterasu
			load["SpecialX"] >> SpecialX
			if(SpecialX==1)
				Special=1
				SpecialX=0
			load["Next_Prize"] >> Next_Prize
			load["Next_Mode"] >> Next_Mode
			Next_Mode = 0

	Characters_Load()
		if(fexists("Worldsaves/Characters.sav"))
			var/savefile/load = new("Worldsaves/Characters.sav")
			load["SoundMode"] >> SoundMode
			load["CanPlaySoundies"] >> CanPlaySoundies
			load["Illegal_Characters"] >> Illegal_Characters
			load["Illegal_Characters_X"] >> Illegal_Characters_X
			Characters_Check()

	Characters_Save()
		var/savefile/F = new("Worldsaves/Characters.sav")
		F["SoundMode"] << SoundMode
		F["IllegalMelody"] << IllegalMelody
		F["CanPlaySoundies"] << CanPlaySoundies
		F["Illegal_Characters"] << Illegal_Characters
		F["Illegal_Characters_X"] << Illegal_Characters_X

//mob/verb/Pwipe_Old_Saves()
//	for(var/Statistic/S in Statistics)
//		S.Village = null
//		if(S.Time_Played <= 6000) {Statistics.Remove(S); del(S)}
//	for(var/Alliance/A in Alliances) for(var/Statistic/S in Statistics) if(A.Members.Find(S))
//		world<<"[S.Ninja] [A.Name]"
//		S.Village = "[A.Name]"

mob/var/Rounds = 0
var/_CTD_Timer_
var/_TC_Timer_
var/_Reboot_Poll_
var/_Timer_
var/Camera_Lag_X = 0
var/Players_ = "<html><body><font color=white><style = \"text/css\">body { background-color:black} </style></body></html><b><u><font size=3>World Log</font size></u></font><br></b>"
mob/var/_Player = 0