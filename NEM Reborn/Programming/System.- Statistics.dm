var/list/Statistics = list()
mob/var/Statistic/Statistic

Score
	var
		Amount
		Name

	New(_Name, list/List)
		Name = _Name
		List.Add(src)

var/list/Wiped = list()

Statistic
	var
		Ninja
		Rank = "D Rank Missing-Nin"
		Ryo = 25
		Kills = 0
		KOs = 1
		KOds = 1
		Assists = 0
		Village_Damage_Done = 1
		Village_Damage_Received = 1
		Damage_Done = 1
		Damage_Received = 1
		Rounds_Played = 0
		Times_Booted = 0
		Times_Muted = 0
		Time_Played = 0
		Warning_Level = 0
		Ryo_Spent = 0
		Ryo_Given = 0
		Village_KOs = 1
		Village_KOds = 1
		Reputation = 1
		Obtained_Ryo
		Cloaks = 0
		Got_Village
		Last_Time_Seen
		Village
		Reboot_Poll
		Poll_Timer
		CTD_Timer
		Rogue
		Log
		tmp/Alliance/_Village_

		D_Missions
		C_Missions
		B_Missions
		A_Missions
		S_Missions

		list
			Ignored_People = list()
			Characters_Used = list()
			Characters_Enemies = list()
			Enemies = list()

	New(mob/Creator)
		..()
		spawn(10)
			if(!Total_Reputation) Total_Reputation = Reputation

		if(Creator)
			Ninja = Creator
			if(Ninja != "NPC") Statistics.Add(src)

		spawn()
			if(Ninja && !Obtained_Ryo)
				if(findtext(Ninja, "Guest-")) return
				spawn()
					var/Check[] = params2list(world.GetScores(Ninja, ""))
					if(!Check) return
					Ryo = text2num(Check["Ryo"])
					Rounds_Played = text2num(Check["Rounds Played"])
					Kills = text2num(Check["Ninjas Killed"])
					KOs = text2num(Check["Ninjas Ko'd"])
					KOds = text2num(Check["Times Ko'd"])
					Assists = text2num(Check["Times Assisted"])
					Obtained_Ryo = 1
	proc
		Rank_Update(To)
			if(To == "Akatsuki" && findtext(Rank, "Missing-Nin")) Rank = "Member"
			else if(To == "Missing-Nin")
				if(findtext(Rank, "Missing-Nin")) return
				if(Rank == "Academy Student") Rank = "D Rank Missing-Nin"
				else if(Rank == "Genin") Rank = "C Rank Missing-Nin"
				else if(Rank == "Chuunin") Rank = "B Rank Missing-Nin"
				else if(Rank == "Special Jounin") Rank = "B+ Rank Missing-Nin"
				else if(Rank == "Jounin" || Rank == "Member") Rank = "A Rank Missing-Nin"
				else Rank = "S Rank Missing-Nin"
			else
				if(!findtext(Rank, "Missing-Nin")) return
				if(Rank == "D Rank Missing-Nin") Rank = "Academy Student"
				else if(Rank == "C Rank Missing-Nin") Rank = "Genin"
				else if(Rank == "B Rank Missing-Nin") Rank = "Chuunin"
				else if(Rank == "B+ Rank Missing-Nin") Rank = "Special Jounin"
				else Rank = "Jounin"

		Time_Played()
			var/Time_Played_ = Time_Played
			var/Time_Played__ = Time_Played
			var/Minutes = 0
			var/Hours = 0
			var/Days = 0
			while(Time_Played__)
				if(Hours >= 24)
					Hours -= 24
					Days ++
				if(Minutes >= 60)
					Minutes -= 60
					Hours ++
				if(Time_Played_ >= 60)
					Time_Played_ -= 60
					Minutes ++
				if(Time_Played_ < 60)
					Time_Played__ = 0
			if(Days) return "[Days] day(s), [Hours] hour(s), [Minutes] minute(s), [Time_Played_] second(s)"
			if(!Days && Hours) return "[Hours] hour(s), [Minutes] minute(s), [Time_Played_] second(s)"
			if(!Days && !Hours && Minutes) return "[Minutes] minute(s), [Time_Played_] second(s)"
			if(!Days && !Hours && !Minutes && Time_Played_) return "[Time_Played_] second(s)"

		Show()
			..()
			usr << output(null, "Statistics.Statistics Left")
			usr << output(null, "Statistics.Statistics Right")
			var/Time = Time_Played()

			var/Score/F_Character
			var/list/Characters = list()

			for(var/C in Characters_Used)
				if(Characters.Find(C)) continue
				var/Score/Character = new/Score (C, Characters)
				for(var/R in Characters_Used) if(R == C) Character.Amount ++
				F_Character = Character
			for(var/Score/C in Characters) if(C.Amount >= F_Character.Amount) F_Character = C

			var/Score/F_Enemy
			var/list/_Characters_Enemies = list()

			for(var/C in Characters_Enemies)
				if(_Characters_Enemies.Find(C)) continue
				var/Score/Enemy = new/Score (C, _Characters_Enemies)
				for(var/R in Characters_Enemies) if(R == C) Enemy.Amount ++
				F_Enemy = Enemy
			for(var/Score/C in _Characters_Enemies) if(C.Amount >= F_Enemy.Amount) F_Enemy = C

			var/Score/Nemesis
			var/list/_Enemies = list()

			for(var/C in Enemies)
				if(_Enemies.Find(C)) continue
				var/Score/Enemy = new/Score (C, _Enemies)
				for(var/R in Enemies) if(R == C) Enemy.Amount ++
				Nemesis = Enemy
			for(var/Score/C in _Enemies) if(C.Amount >= Nemesis.Amount) Nemesis = C
			if(!Kills && !KOs) KOs = 1
			if(!KOds) KOds = 1
			var/Missions = "None"
			if(D_Missions) Missions = "[D_Missions] D Rank"
			if(C_Missions) {if(Missions != "None") Missions += " - [C_Missions] C Rank"; else Missions = "[C_Missions] C Rank"}
			if(B_Missions) {if(Missions != "None") Missions += " - [B_Missions] B Rank"; else Missions = "[B_Missions] B Rank"}
			if(A_Missions) {if(Missions != "None") Missions += " - [A_Missions] A Rank"; else Missions = "[A_Missions] A Rank"}
			if(S_Missions) {if(Missions != "None") Missions += " - [S_Missions] S Rank"; else Missions = "[S_Missions] S Rank"}


			var/Window = {"<html><body><font color=white><style = \"text/css\">body { background-color:black} </style></body></html><b>
<font color=#FFEB75><u><font size=3>* Rank: <font color=#FFF7C4>[Rank]</u><br><font size=2>
<font color=#FFEB75><u><font size=2>Reputation: <font color=#FFF7C4>[round(Reputation, 0.05)]</u><br><font size=2>
<br>
<font color=#39FF3C><u><span class='right'>* Round(s) Played: <font color=#77FF7A>[Rounds_Played]</u></span><br>
<font color=#74FF61>Ninja(s) Killed: <font color=#A8FF9C>[Kills]<br>
<font color=#74FF61>Ninja(s) Ko'd: <font color=#A8FF9C>[KOs]<br>
<font color=#74FF61>Time(s) Ko'd: <font color=#A8FF9C>[KOds]<br>
<font color=#74FF61>Time(s) Assisted: <font color=#A8FF9C>[Assists]<br>
<br>
<font color=#FF4747><u>Damage Done: <font color=#FF7C7C>[Damage_Done]<br>
<font color=#FF4747>Damage Received: <font color=#FF7C7C>[Damage_Received]</u><br>"}
			if(F_Character) Window += "<br><font color=#7A97FF><u>* Most Used Character: <font color=#A5B9FF>[F_Character.Name], [F_Character.Amount] time(s)</u><br>"
			if(F_Enemy) Window += "<font color=#8C86FF>Defeated The Most By: <font color=#B6B2FE>[F_Enemy.Name]<br>"
			if(Nemesis) Window += "<font color=#8676FF>Nemesis: <font color=#A296FF>[Nemesis.Name]<br>"
			Window += {"<br>
<font color=#77D2FF><u>* Warning Level: <font color=#A6E1FE>[Times_Booted]</u><br>
<font color=#89FCFF>Time(s) Booted: <font color=#B5FBFE>[Times_Booted]<br>
<font color=#89FCFF>Time(s) Muted: <font color=#B5FBFE>[Times_Muted]<br>
<br>
<font color=#FFEB75><u>* Current Ryo: <font color=#FFF7C4>[round(Ryo, 0.05)]</u><br>
<font color=#FFEB75>Ryo Spent: <font color=#FFF7C4>[Ryo_Spent]<br>
<font color=#FFEB75>Ryo Given: <font color=#FFF7C4>[Ryo_Given]<br>
<br>
<font color=#D7D7D7><u>Time Played: <font color=#FFFFFF>[Time]<br>
<font color=#D7D7D7>Last Time Seen Online: <font color=#FFFFFF>[Last_Time_Seen]</u><br><br>
<font size=3><u><font color=#7B0000>Missions:</u><br><font size=2><font color=#950000>[Missions]</u>
"}

			winset(usr, "Statistics.Statistics Character", "text=\"* [Ninja] *\"")
			usr << output(Window, "Statistics.Statistics Left")
			var/Window_Right = {"<html><body><font color=#A4A4A4><style = \"text/css\">body { background-color:#151200} </style></body></html><b><font size=2>[Log]"}
			usr << output(Window_Right, "Statistics.Statistics Right")

			usr.Center("Statistics", 3)

			del(_Characters_Enemies)
			del(Characters)
			del(_Enemies)


mob/var
	Ryo
	Statistic_CD