var/list/Alliances = list()
var/Nothing = 'Graphics/Nothing.dmi'
mob/var/Alliance
	Alliance
	Alliance_R
	_Genin_Exam_On_

area/Black
	icon = 'Graphics/Ultra Black.dmi'
	layer = 100000000

Alliance
	var
		Statistic/Leader
		Name
		Type
		Victories = 0
		Loss = 0
		Tax = 5
		Ryo = 3000
		Logo
		In_War
		Storyline
		Created_On
		Required_Reputation = 10
		Required_Ryo = 150
		Announcement
		Score
		tmp/Rank
		tmp/list/Genins = list()
		tmp/Genin_Exam_Current
		tmp/Promote_Delay
		tmp/Invite_Delay
		tmp/Taxes_Delay
		tmp/Exam_Delay
		tmp/R_Ryo_Delay
		tmp/R_Reputation_Delay
		Today_Pill
		Current_Pill
		tmp/list/_Members = list()
		Pills_In_List = list()
		list/Members = list()

	New(_Name, _Type, mob/_Leader, Date)
		..()
		Genins = list()
		spawn() for(var/Statistic/S in Members) if(S.Last_Time_Seen == "Now") S.Last_Time_Seen = "[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")]"
		if(_Name) Name = _Name
		if(_Type) Type = _Type
		if(Date)
			Created_On = Date
			if(_Leader) Storyline += "<font color=#3681E3><u>[Created_On] - <font color=#4A8BE1>Formed by [_Leader.key]!</u><br>"
			else Storyline += "<font color=#3681E3><u>[Created_On] - <font color=#4A8BE1>Formed!</u><br>"
		if(_Name)
			Update_Village()
			if(_Leader) {Members.Add(_Leader.Statistic); _Members.Add(_Leader); Leader = _Leader.Statistic; _Leader.Statistic.Village = Name; _Leader.Statistic._Village_ = src; _Leader.Alliance_R = src; _Leader.Current_Village(); Show(_Leader)}
			Alliances.Add(src)
		else
			if(!Required_Reputation) Required_Reputation = 10
			if(!Required_Ryo) Required_Ryo = 150

		spawn(5) if(!Announcement) Announcement = "<center><font size=5><font color=#4B7FCC><u>[src.Name]</u></center><br><font size=3><center>None</center>"

	proc
		Update_Village()
			var/list/Pills_ = list()
			var/list/Pills = list("Height", "Blood", "Delay", "Energy", "Stealth", "Immunity")
			for(var/P in Pills) if(P == Current_Pill) Pills.Remove(P)

			loop
				for(var/P in Pills)
					if(length(Pills_) == 2 || Pills_.Find(P)) continue
					if(prob(100/length(Pills))) Pills_.Add(P)
				if(length(Pills_) < 2) goto loop

			Pills_In_List = Pills_
			Current_Pill = null
			Today_Pill = null

		Delay(Var, Value)

			if(Var == "Exam")
				Exam_Delay = Value
				loop
					spawn(10)
						Exam_Delay --
						if(Exam_Delay) goto loop

			if(Var == "Invite")
				Invite_Delay = Value
				loop
					spawn(10)
						Invite_Delay --
						if(Invite_Delay) goto loop

			else if(Var == "Taxes")
				Taxes_Delay = Value
				loop
					spawn(10)
						Taxes_Delay --
						if(Taxes_Delay) goto loop

			else if(Var == "Required Reputation")
				R_Reputation_Delay = Value
				loop
					spawn(10)
						R_Reputation_Delay --
						if(R_Reputation_Delay) goto loop

			else if(Var == "Required Ryo")
				R_Ryo_Delay = Value
				loop
					spawn(10)
						R_Ryo_Delay --
						if(R_Ryo_Delay) goto loop

		Organize()
			var/list/Players = Members
			Members = list()
			for(var/Statistic/S in Players) if(Leader) if(S.Ninja == Leader.Ninja) {Members.Add(S); Players.Remove(S)}
			for(var/Statistic/S in Players) if(S.Rank != "ANBU" && S.Rank != "Jounin" && S.Rank != "Chuunin" && S.Rank != "Genin" && S.Rank != "Academy Student" && S.Rank != "Special Jounin") {Members.Add(S); Players.Remove(S)}
			for(var/Statistic/S in Players) if(S.Rank == "ANBU") {Members.Add(S); Players.Remove(S)}
			for(var/Statistic/S in Players) if(S.Rank == "Jounin") {Members.Add(S); Players.Remove(S)}
			for(var/Statistic/S in Players) if(S.Rank == "Special Jounin") {Members.Add(S); Players.Remove(S)}
			for(var/Statistic/S in Players) if(S.Rank == "Chuunin") {Members.Add(S); Players.Remove(S)}
			for(var/Statistic/S in Players) if(S.Rank == "Genin") {Members.Add(S); Players.Remove(S)}
			for(var/Statistic/S in Players) if(S.Rank == "Academy Student") {Members.Add(S); Players.Remove(S)}

		Show(mob/Player)
			Update(Player)
			Player.Center("Village", 4)
			Player.Alliance_R = src

		Update(mob/Player)
			if(Logo) winset(Player, "Village.Village Logo", "image=\ref[Logo]")
			else winset(Player, "Village.Village Logo", "image=\ref[Nothing]")
			winset(Player, "Village.Ranking", "text='[Rank]'")
			winset(Player, "Village.Village Text", "text='[Type]'")
			winset(Player, "Village.Village Name", "text='* [Name] *'")
			var/Window = "<html><body><font color=#2F81FE><style = \"text/css\">body { background-color:#1A1E2E} </style><b><font size=3><u>"
			if(Leader) Window += "[Leader.Rank]: <font color=#438EFE>[Leader.Ninja]</u>"
			Window += "<font size=2><br><font color=#5799FC><i>Ryo: <font color=#6CA5FA>[Ryo]<br><font color=#5799FC>Taxes: <font color=#6CA5FA>[Tax]%<br><br></u>"
			if(!Player.Statistic._Village_) Window += "<a href='?src=\ref[src];action=Join Village I'>Join</a>"
			if(Player.Statistic._Village_ == src) Window += "<a href='?src=\ref[src];action=Donate Ryo'>Donate Ryo</a>"
			if(Real_Owner.Find(Player.key)) Window += " <a href='?src=\ref[src];action=Change Leader;User=\ref[src]&&Village=\ref[src]'>Owner</a> <a href='?src=\ref[src];action=Disband;User=\ref[src]&&Village=\ref[src]'>Disband</a> <a href='?src=\ref[src];action=Logo'>Logo</a></a> <a href='?src=\ref[src];action=Special Village Command;User=\ref[src]&&Village=\ref[src]'>Special</a> "
			if(Player.Statistic == Leader) Window += " <a href='?src=\ref[src];action=Village Settings'>Settings</a> <a href='?src=\ref[src];action=Taxes'>Taxes</a> <a href='?src=\ref[src];action=Invite To Village'>Invite</a> <a href='?src=\ref[src];action=Kick From Village'>Kick</a> <a href='?src=\ref[src];action=Promote'>Promote</a>"
			if(Player.Statistic._Village_ == src && Player.Statistic != Leader) Window += " <a href='?src=\ref[src];action=Leave Village'>Leave</a>"
			Player << output(null, "Village.Village Browse")
			Player << output(Window, "Village.Village Browse")


mob/proc

	Promote()
		if(Statistic._Village_.Leader != Statistic) return
		if(Statistic._Village_.Promote_Delay)
			Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.Promote_Delay)
			return
		Statistic._Village_.Update(src)
		var/Window = "<html><body><font color=#3774D1><style = \"text/css\">body { scrollbar-DarkShadow-Color:#002350;scrollbar-Shadow-Color:#3061A1;scrollbar-base-color:#0F3669;scrollbar-arrow-color:#376FBA;background-color:#232A3F} </style><b><font size=4><u>* Promote Ninja *</u><font size=2><br><br>"
		for(var/Statistic/S in Statistic._Village_.Members)
			var/Color
			if(S == Statistic || S.Rank == "Academy Student" || S.Rank == "Genin" || S.Rank == "Chuunin" || S.Rank == "Special Jounin") continue
			if(S.Rank == "Jounin") Color = "#4989DD"
			else if(S.Rank == "ANBU" || S.Rank == "Member") Color = "#5591DF"
			else Color = "#639AE2"
			Window += "<font color=[Color]>- [S.Rank], <a href='?src=\ref[S];action=Promote User;User=\ref[S]'>[S.Ninja]</a><br>"
		src << output(null, "Village.Notes Browse")
		src << output(Window, "Village.Notes Browse")

	Village_Settings(var/S)
		if(!Statistic._Village_ || Statistic._Village_.Leader != Statistic) return

		if(!S)
			var/Window = "<html><body><font color=#FFF7C4><style = \"text/css\">body { scrollbar-DarkShadow-Color:#002350;scrollbar-Shadow-Color:#3061A1;scrollbar-base-color:#0F3669;scrollbar-arrow-color:#376FBA;background-color:#232A3F} </style><b>"
			Window += "<font color=#5779D0><font size=3><u>* Settings *</u><br><br>"
			Window += "<font color=#6A87D1><font size=2>- Required Reputation: [Alliance_R.Required_Reputation] <a href='?src=\ref[src];action=Village Settings Reputation'>~Edit</a><br>"
			Window += "<font color=#6A87D1><font size=2>- Ryo To Pay: [Alliance_R.Required_Ryo] <a href='?src=\ref[src];action=Village Settings Ryo'>~Edit</a>"
			src << output(null, "Village.Notes Browse")
			src << output(Window, "Village.Notes Browse")

		else if(S == "Reputation")
			if(!Statistic._Village_ || Statistic._Village_.Leader != Statistic) return
			if(Statistic._Village_.R_Reputation_Delay) {Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.R_Reputation_Delay); return}
			var/R = input(src, "Set the required reputation to join the village", "Required Reputation") as num
			if(!R) return
			if(R > 1000) {Announced("<font color=#609BF2><b><u>* Required Reputation can't go above 1000!", 7); return}
			if(R < 5) {Announced("<font color=#609BF2><b><u>* Required Reputation can't go below 5!", 7); return}
			R = round(R, 0.1)
			if(alert(src, "Are you sure? You're setting the required reputation to [R]", "* Confirmation*", "No", "Yes") == "Yes")
				if(!Statistic._Village_ || Statistic._Village_.Leader != Statistic) return
				if(Statistic._Village_.R_Reputation_Delay) {Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.R_Reputation_Delay); return}
				Announced("<font color=#609BF2><b><u>* You've successfully set the required reputation to [R]!", 7)
				Statistic._Village_.Required_Reputation = R
				Statistic._Village_.Delay("Required Reputation", 300)
				Village_Settings()

		else if(S == "Ryo")
			if(!Statistic._Village_ || Statistic._Village_.Leader != Statistic) return
			if(Statistic._Village_.R_Ryo_Delay) {Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.R_Ryo_Delay); return}
			var/R = input(src, "Set the ryo to pay to join the village", "Ryo To Pay") as num
			if(!R) return
			if(R > 15000) {Announced("<font color=#609BF2><b><u>* Required Ryo can't go above 15000!", 7); return}
			if(R < 50) {Announced("<font color=#609BF2><b><u>* Required Ryo can't be below 50!", 7); return}
			R = round(R, 0.05)
			if(alert(src, "Are you sure? You're setting the required ryo to [R]", "* Confirmation*", "No", "Yes") == "Yes")
				if(!Statistic._Village_ || Statistic._Village_.Leader != Statistic) return
				if(Statistic._Village_.R_Ryo_Delay) {Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.R_Ryo_Delay); return}
				Announced("<font color=#609BF2><b><u>* You've successfully set the required ryo to [R]!", 7)
				Statistic._Village_.Required_Ryo = R
				Statistic._Village_.Delay("Required Ryo", 300)
				Village_Settings()


	Join_Village(var/V)
		if(Statistic._Village_) return

		if(!V)
			var/Window = "<html><body><font color=#FFF7C4><style = \"text/css\">body { scrollbar-DarkShadow-Color:#002350;scrollbar-Shadow-Color:#3061A1;scrollbar-base-color:#0F3669;scrollbar-arrow-color:#376FBA;background-color:#232A3F} </style><b>"
			Window += "<font color=#5779D0><font size=3><u>* Join [Alliance_R.Type] [Alliance_R.Name] *</u><br><br>"
			Window += "<font color=#6A87D1><font size=2>- Required Reputation: [Alliance_R.Required_Reputation]<br>"
			Window += "<font color=#6A87D1><font size=2>- Ryo To Pay: [Alliance_R.Required_Ryo]<br><br>"
			Window += "<font color=#8A9ED0><font size=2><a href='?src=\ref[src];action=Join Village II'>Confirm</a>"
			src << output(null, "Village.Notes Browse")
			src << output(Window, "Village.Notes Browse")
		else
			if(Statistic.Ryo < Alliance_R.Required_Ryo)
				Announced("<font color=#609BF2><b><u>* You don't have enough ryo! Obtain [Alliance_R.Required_Ryo-Statistic.Ryo]", 5)
				return
			if(Statistic.Reputation < Alliance_R.Required_Reputation)
				Announced("<font color=#609BF2><b><u>* You don't have enough reputation! Obtain [Alliance_R.Required_Reputation-Statistic.Reputation]", 5)
				return
			Statistic.Ryo -= Alliance_R.Required_Ryo
			Statistic._Village_ = Alliance_R
			Statistic._Village_.Ryo += Statistic._Village_.Required_Ryo
			Announced("")
			Announcement_Time = -7
			Statistic.Rogue = 0
			if(Statistic._Village_.Type == "Organization") Statistic.Rank_Update("Akatsuki")
			else Statistic.Rank_Update("Normal")
			Statistic._Village_._Members.Add (src)
			Statistic._Village_.Members.Add (Statistic)
			Statistic._Village_.Storyline += "<font color=#3681E3>[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")] - <font color=#4A8BE1>[key] joined [Statistic._Village_.Type] [Statistic._Village_.Name]!<br>"
			Statistic._Village_.Organize()
			for(var/mob/M in Statistic._Village_._Members) M.Announced("<font color=#609BF2><b><u>* [key] has joined [Statistic._Village_.Type] [Statistic._Village_.Name]!", 10)

	Pills_Guide()
		var/Window = "<html><body><font color=#FFF7C4><style = \"text/css\">body { scrollbar-DarkShadow-Color:#002350;scrollbar-Shadow-Color:#3061A1;scrollbar-base-color:#0F3669;scrollbar-arrow-color:#376FBA;background-color:#232A3F} </style><b>"
		Window += "<font color=#5779D0><font size=3><u>* To consume a pill press P!</u><br>"
		Window += "<font color=#6A87D1><font size=2>- Lv.1 = 0~25 Reputation.<br>"
		Window += "<font color=#6A87D1><font size=2>- Lv.2 = 25~50 Reputation.<br>"
		Window += "<font color=#6A87D1><font size=2>- Lv.3 = >50 Reputation.<br>"
		Window += "<font color=#7891D1><font size=2><u>- Formula to calculate reputation</u><br><i>((Damage Done /Damage Received * KOs & Kills /Times KO'd + Deaths) *5) /Villagers or Members.</i><br>"
		Window += "<font color=#8A9ED0><font size=2><u>* Once a player leaves or gets kicked, his stats get erased!</u><br><br>"
		Window += "<font color=#AAF7FE><font size=2><i><u>* The Affiliation with highest reputation gets 1 extra pill.</u></i><br>"
		Window += "<font color=#7CF3FF><font size=2>� Kage or Leaders - 3 pills.<br>"
		Window += "<font color=#7CF3FF><font size=2>� Special Rank - 2 pills and 50% chance to get 1 more.<br>"
		Window += "<font color=#7CF3FF><font size=2>� Anbu - 2 pills and 25% chance to get 1 more.<br>"
		Window += "<font color=#7CF3FF><font size=2>� Jounin - 2 pills.<br>"
		Window += "<font color=#7CF3FF><font size=2>� Chuunin - 1 pill.<br>"
		Window += "<font color=#7CF3FF><font size=2>� Genin - 50% chance to get 1 pill.<br><br>"
		Window += "<font color=#AAF7FE><font size=2><u>- You can only change the pill once a day, and you can't have the same pill for the next day.</u><br><br><br>"
		Window += "<font color=#AC0000><font size=3><u>* Blood Pill *</u><br>"
		Window += "<font color=#C20000><font size=2>Lv. 1 ~+25% HP Regeneration, lasts 15 seconds.<br>"
		Window += "<font color=#C20000><font size=2>Lv. 2 ~+35% HP Regeneration, lasts 20 seconds.<br>"
		Window += "<font color=#C20000><font size=2>Lv. 3 ~+45% HP Regeneration, lasts 25 seconds.<br><br>"
		Window += "<font color=#C18700><font size=3><u>* Energy Pill *</u><br>"
		Window += "<font color=#E6A100><font size=2>Lv. 1 ~+15% Movement Speed & +15 Stamina, lasts 10 seconds.<br>"
		Window += "<font color=#E6A100><font size=2>Lv. 2 ~+25% Movement Speed & +25 Stamina, lasts 15 seconds.<br>"
		Window += "<font color=#E6A100><font size=2>Lv. 3 ~+35% Movement Speed & +25 Stamina, lasts 20 seconds.<br><br>"
		Window += "<font color=#3493D3><font size=3><u>* Height Pill *</u><br>"
		Window += "<font color=#3CB1FF><font size=2>Lv. 1 ~+1 Extra Jump, lasts 30 seconds.<br>"
		Window += "<font color=#3CB1FF><font size=2>Lv. 2 ~+1 Extra Jump, lasts 40 seconds.<br>"
		Window += "<font color=#3CB1FF><font size=2>Lv. 3 ~+1 Extra Jump, lasts 50 seconds.<br><br>"
		Window += "<font color=#C2C2C2><font size=3><u>* Stealth Pill *</u><br>"
		Window += "<font color=#FFFFFF><font size=2>Lv. 1 ~Substitution lasts +0.5 second(s) & -15% delay, lasts 45 seconds.<br>"
		Window += "<font color=#FFFFFF><font size=2>Lv. 2 ~Substitution lasts +1.0 second(s) & -20% delay, lasts 60 seconds.<br>"
		Window += "<font color=#FFFFFF><font size=2>Lv. 3 ~Substitution lasts +1.5 second(s) & -25% delay, lasts 75 seconds.<br><br>"
		Window += "<font color=#9326CE><font size=3><u>* Immunity Pill *</u><br>"
		Window += "<font color=#B52AFF><font size=2>Lv. 1 ~Immune to Amaterasu & Immune to Poison, lasts 20 seconds.<br>"
		Window += "<font color=#B52AFF><font size=2>Lv. 2 ~Immune to Amaterasu & Immune to Poison, lasts 25 seconds.<br>"
		Window += "<font color=#B52AFF><font size=2>Lv. 3 ~Immune to Amaterasu & Immune to Poison, lasts 30 seconds.<br><br>"
		Window += "<font color=#5FDC35><font size=3><u>* Delay Pill *</u><br>"
		Window += "<font color=#6AF53B><font size=2>Lv. 1 ~-25% Cooldown on Jutsus, lasts 20 seconds.<br>"
		Window += "<font color=#6AF53B><font size=2>Lv. 2 ~-25% Cooldown on Jutsus, lasts 40 seconds.<br>"
		Window += "<font color=#6AF53B><font size=2>Lv. 3 ~-25% Cooldown on Jutsus, lasts 60 seconds.<br><br>"
	//	Window += "<font color=#DAD600><font size=3><u>* Golden Pill *</u><br>"
	//	Window += "<font color=#EEEA00><font size=2>Lv. 1 ~+50% Ryo Rewards, lasts forever.<br>"
	//	Window += "<font color=#EEEA00><font size=2>Lv. 2 ~+100% Ryo Rewards, lasts forever.<br>"
	//	Window += "<font color=#EEEA00><font size=2>Lv. 3 ~+150% Ryo Rewards, lasts forever.<br><br>"

		src << output(null, "Village.Notes Browse")
		src << output(Window, "Village.Notes Browse")

	Select_Pill()
		if(Statistic._Village_.Leader != Statistic) return
		if(Statistic._Village_.Today_Pill)
			src<<"<b><font color=red><u>You have already selected a pill today!</u>"
			return
		var/Type = input(src, "What pill would you like to select?","Select Pill") as null | anything in Statistic._Village_.Pills_In_List
		if(!Type) return
		else if(alert(src, "Are you sure? You can only do this once per day!", "Selecting [Type] Pill", "No", "Yes") == "Yes")
			if(Statistic._Village_.Today_Pill)
				src<<"<b><font color=red><u>You have already selected a pill today!</u>"
				return
			Statistic._Village_.Current_Pill = Type
			Statistic._Village_.Today_Pill = 1
			for(var/mob/M in Statistic._Village_._Members) M.Announced("<font color=#609BF2><b><u>* [Type] Pill has been selected as our daily pill!", 15)

	Promote_Ninja(Statistic/Player, Rank_, Prize_)
		if(Statistic._Village_.Leader != Statistic) return
		if(Statistic._Village_.Promote_Delay)
			Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.Promote_Delay)
			return
		if(Statistic._Village_.Ryo < text2num(Prize_))
			Announced("<font color=#609BF2><b><u>* [Statistic._Village_.Type] [Statistic._Village_.Name] needs [text2num(Prize_)-Statistic._Village_.Ryo] Ryo!", 5)
			return
		for(var/mob/M in Statistic._Village_._Members) M.Announced("<font color=#609BF2><b><u>* [Player.Ninja] has been promoted to [Rank_]!", 7)
		Player.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * [Player.Ninja] has been promoted to [Rank_]! *"
		Statistic._Village_.Storyline += "<font color=#3681E3>[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")] - <font color=#4A8BE1>[Player.Ninja] was promoted to [Rank_]!<br>"
		Statistic._Village_.Delay("Promote", 90)
		Player.Rank = Rank_
		Statistic._Village_.Organize()
		Statistic._Village_.Update(src)
		Statistic._Village_.Ryo -= text2num(Prize_)
		Statistic._Village_.Update(src)
		winset(src, "Village.Village Notes", "text='- Members -'")
		Current_Village()

	Taxes()
		if(Statistic._Village_.Leader != Statistic) return
		if(Statistic._Village_.Taxes_Delay)
			Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.Taxes_Delay)
			return
		var/Previous_Taxes = Statistic._Village_.Tax
		var/Tax = input(src, "What taxes do you want to set to your village?", "Taxes") as num
		Tax = round(Tax, 1)
		if(Tax == Previous_Taxes) Announced("<font color=#609BF2><b><u>* These are the previous taxes!", 5)
		else if(Tax > 15) Announced("<font color=#609BF2><b><u>* Taxes Limit is 15%!", 5)
		else if(Tax < 1 && key != "Dragonpearl123") Announced("<font color=#609BF2><b><u>* Taxes Minium is 1%!", 5)
		else if(alert(src, "Are you sure?", "Setting Taxes To [Tax]%", "No", "Yes") == "Yes")
			if(Statistic._Village_.Taxes_Delay) Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.Taxes_Delay)
			else
				if(Tax > Previous_Taxes) Statistic._Village_.Storyline += "<font color=#3681E3>[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")] - <font color=#4A8BE1>Taxes were increased from [Previous_Taxes]% to [Tax]%!<br>"
				if(Tax < Previous_Taxes) Statistic._Village_.Storyline += "<font color=#3681E3>[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")] - <font color=#4A8BE1>Taxes were decreased from [Previous_Taxes]% to [Tax]%!<br>"
				Statistic._Village_.Delay("Taxes", 300)
				Statistic._Village_.Tax = Tax
				Statistic._Village_.Update(src)
				for(var/mob/M in Statistic._Village_._Members) M.Announced("<font color=#609BF2><b><u>* Taxes have been set to [Tax]%!", 7)


	Kick_From_Village()
		if(Statistic._Village_.Leader != Statistic) return
		if(Statistic._Village_.Ryo < 300)
			Announced("<font color=#609BF2><b><u>* [Statistic._Village_.Type] [Statistic._Village_.Name] needs [300-Statistic._Village_.Ryo] Ryo!", 5)
			return
		Statistic._Village_.Update(src)
		var/Window = "<html><body><font color=#3774D1><style = \"text/css\">body { scrollbar-DarkShadow-Color:#002350;scrollbar-Shadow-Color:#3061A1;scrollbar-base-color:#0F3669;scrollbar-arrow-color:#376FBA;background-color:#232A3F} </style><b><font size=4><u>* Kick Ninja *</u><font size=2><br><i>* [Statistic._Village_.Type] [Statistic._Village_.Name] will lose 300 Ryo if a ninja gets kicked.</i><br><br>"
		for(var/Statistic/S in Statistic._Village_.Members)
			if(S.Rank == "Academy Student") continue
			var/Color
			if(S == Statistic) continue
			else if(S.Rank == "Academy Student") Color = "#2467C0"
			else if(S.Rank == "Genin") Color = "#3073CB"
			if(S.Rank == "Chuunin") Color = "#3B7ED4"
			else if(S.Rank == "Jounin" || S.Rank == "Special Jounin") Color = "#4989DD"
			else if(S.Rank == "ANBU" || S.Rank == "Member") Color = "#5591DF"
			else Color = "#639AE2"
			Window += "<font color=[Color]>- [S.Rank], <a href='?src=\ref[S];action=Kick From Village User;User=\ref[S]&&Village=\ref[Statistic._Village_]'>[S.Ninja]</a><br>"
		src << output(null, "Village.Notes Browse")
		src << output(Window, "Village.Notes Browse")

	Invite_Village()
		if(Statistic._Village_.Leader != Statistic) return
		if(Statistic._Village_.Invite_Delay)
			Announced("<font color=#609BF2><b><u>* Please, wait...", Statistic._Village_.Invite_Delay)
			return
		if(Statistic._Village_.Ryo < 150)
			Announced("<font color=#609BF2><b><u>* [Statistic._Village_.Type] [Statistic._Village_.Name] needs [150-Statistic._Village_.Ryo] Ryo!", 5)
			return
		Statistic._Village_.Update(src)
		var/Window = "<html><body><font color=#3774D1><style = \"text/css\">body { scrollbar-DarkShadow-Color:#002350;scrollbar-Shadow-Color:#3061A1;scrollbar-base-color:#0F3669;scrollbar-arrow-color:#376FBA;background-color:#232A3F} </style><b><font size=4><u>* Invite Ninja *</u><font size=2><br><i>* [Statistic._Village_.Type] [Statistic._Village_.Name] will lose 150 Ryo if a ninja joins.</i><br><br>"
		var/Color
		for(var/mob/S in world) if(S.client && !S.Statistic._Village_ && S.Statistic.Rank == "S Rank Missing-Nin") {Color = "#5591DF"; Window += "<font color=[Color]>- [S.Statistic.Rank], <a href='?src=\ref[S];action=Invite To Village User;User=\ref[S]&&Village=\ref[Statistic._Village_]'>[S.Statistic.Ninja]</a><br>"}
		for(var/mob/S in world) if(S.client && !S.Statistic._Village_ && S.Statistic.Rank == "A Rank Missing-Nin") {Color = "#4989DD"; Window += "<font color=[Color]>- [S.Statistic.Rank], <a href='?src=\ref[S];action=Invite To Village User;User=\ref[S]&&Village=\ref[Statistic._Village_]'>[S.Statistic.Ninja]</a><br>"}
		for(var/mob/S in world) if(S.client && !S.Statistic._Village_ && S.Statistic.Rank == "B Rank Missing-Nin" || S.client && !S.Statistic._Village_ && S.Statistic.Rank == "B+ Rank Missing-Nin") {Color = "#3073CB"; Window += "<font color=[Color]>- [S.Statistic.Rank], <a href='?src=\ref[S];action=Invite To Village User;User=\ref[S]&&Village=\ref[Statistic._Village_]'>[S.Statistic.Ninja]</a><br>"}
		for(var/mob/S in world) if(S.client && !S.Statistic._Village_ && S.Statistic.Rank == "C Rank Missing-Nin") {Color = "#3B7ED4"; Window += "<font color=[Color]>- [S.Statistic.Rank], <a href='?src=\ref[S];action=Invite To Village User;User=\ref[S]&&Village=\ref[Statistic._Village_]'>[S.Statistic.Ninja]</a><br>"}
		for(var/mob/S in world) if(S.client && !S.Statistic._Village_ && S.Statistic.Rank == "D Rank Missing-Nin") {Color = "#2467C0"; Window += "<font color=[Color]>- [S.Statistic.Rank], <a href='?src=\ref[S];action=Invite To Village User;User=\ref[S]&&Village=\ref[Statistic._Village_]'>[S.Statistic.Ninja]</a><br>"}
		src << output(null, "Village.Notes Browse")
		src << output(Window, "Village.Notes Browse")

	Invite_Village_Player(mob/M, Alliance/Village_)
		if(Village_.Leader != Statistic) return
		M.Announced("<font color=#609BF2><b><u>* You've been invited to [Village_.Type] [Village_.Name]!</u> <a href='?src=\ref[M];action=Accept Village Invitation;Village=\ref[Village_]'>Accept</a> or <a href='?src=\ref[M];action=Reject Village Invitation;Village=\ref[Village_]'>Reject</a>", 15)

	Edit_Logo()
		var/F = input(src, "Please, select the new logo.", "Logo") as null | icon
		var/icon/I = new(F)
		I.Scale(100, 100)
		Alliance_R.Logo = fcopy_rsc(I)
		Alliance_R.Update(src)

	Donate_Ryo()
		if(!Statistic._Village_) return
		var/Donation = input(src, "How much ryo would you like to donate?", "Donate Ryo") as num
		Donation = round(Donation, 0.05)
		if(Donation <= 0) return
		if(Statistic.Ryo < Donation)
			src<<"<b><font color=#40D3E9><i>You don't have enough ryo!</b></i></font>"
			return
		if(alert(src, "Are you sure?", "Donate [Donation] Ryo", "No", "Yes") == "Yes")
			if(Statistic.Ryo < Donation)
				src<<"<b><font color=#40D3E9><i>You don't have enough ryo!</b></i></font>"
				return
			Announced("<font color=#609BF2><b><u>* You've successfully donated [Donation] Ryo!", 7)
			Statistic.Ryo -= Donation
			Statistic._Village_.Ryo += Donation
			Statistic._Village_.Update(src)

	Current_Village()
		var/_Page = winget(src, "Village.Village Notes", "text")
		Alliance_R.Update(src)
		var/Window = "<html><body><font color=#FFF7C4><style = \"text/css\">body { scrollbar-DarkShadow-Color:#002350;scrollbar-Shadow-Color:#3061A1;scrollbar-base-color:#0F3669;scrollbar-arrow-color:#376FBA;background-color:#232A3F} </style><b>"

		if(_Page == "- Announcements -")
			if(Alliance_R.Leader && Alliance_R.Leader.Ninja == Statistic.Ninja) Window += "<br><br><font size=3><a href='?src=\ref[src];action=Edit Announcements'>Edit</a>"
			Window += "[Alliance_R.Announcement]"

		else if(_Page == "- Storyline -")
			Window += "<font size=2>[Alliance_R.Storyline]"
			if(key == "Dragonpearl123") Window += "<br><br><font size=3><a href='?src=\ref[src];action=Edit Storyline'>Edit</a>"

		else if(_Page == "- Members -")
			var/Active
			var/UnActive
			for(var/Statistic/S in Alliance_R.Members)
				var/Color
				if(S.Rank == "Academy Student") Color = "#2467C0"
				else if(S.Rank == "Genin") Color = "#3073CB"
				else if(S.Rank == "Chuunin") Color = "#3B7ED4"
				else if(S.Rank == "Special Jounin" || S.Rank == "Jounin") Color = "#4989DD"
				else if(S.Rank == "ANBU" || S.Rank == "Member") Color = "#5591DF"
				else if(S != Alliance_R.Leader) Color = "#639AE2"
				else Color = "#70A2E4"
				if(S.Last_Time_Seen == "Now") Active += "<font color=[Color]>{[round(S.Reputation, 0.05)]}- [S.Rank], [S.Ninja]<br>"
				else UnActive += "<font color=[Color]>{[round(S.Reputation, 0.05)]}- [S.Rank], [S.Ninja]<br>"
			if(Active) Window += "<font color=#5089DF><font size=4><u>* Active *</u><font size=2><br><br>[Active]<br>"
			if(UnActive) Window += "<font color=#4C80D0><font size=4><u>* UnActive *</u><font size=2><br><br>[UnActive]"

		else if(_Page == "- Statistics -")
			var/Population
			var/Reputation
			for(var/Statistic/S in Alliance_R.Members) {Population ++; Reputation += S.Reputation}
			Window += "<font size=3><font color=#4B7FCC><u>* Population: <font color=#5B88CB>[Population]</u><font size=2><br><br>"
			if(Alliance_R.Current_Pill) Window += "<font color=#4367C2>- Currently Using: <font color=#5472C1>[Alliance_R.Current_Pill] Pill<br>"
			else Window += "<font color=#4367C2>- Currently Using: <font color=#5472C1>None<br>"
			Window += "<font color=#4367C2>- Reputation: <font color=#5472C1>[round(Alliance_R.Score, 0.1)]<br>"
			if(Alliance_R.Leader == Statistic) Window += "<br><font color=#4367C2><font size=3><a href='?src=\ref[src];action=Select Pill'>Select Pill</a>"
			Window += "<br><font color=#4367C2><font size=3><a href='?src=\ref[src];action=Pills Guide'>Pills Guide</a>"

		src << output(null, "Village.Notes Browse")
		src << output(Window, "Village.Notes Browse")

Statistic/proc
	Calculate_Reputation(var/T)
		var/To_Return
		if(T == "Village") To_Return = ((Village_Damage_Done/Village_Damage_Received) * (Village_KOs/Village_KOds)) * 5
		if(T == "User") To_Return = ((Damage_Done/Damage_Received) * ((KOs+Kills) /KOds)) * 5
		if(To_Return >= 40) To_Return = 40
		return round(To_Return, 0.1)

mob/verb
	Next_Village()
		set hidden = 1
		var/_Page = winget(src, "Village.Village Notes", "text")
		if(_Page == "- Announcements -") winset(src, "Village.Village Notes", "text='- Storyline -'")
		else if(_Page == "- Storyline -") winset(src, "Village.Village Notes", "text='- Members -'")
		else if(_Page == "- Members -") winset(src, "Village.Village Notes", "text='- Statistics -'")
		else if(_Page == "- Statistics -") winset(src, "Village.Village Notes", "text='- Announcements -'")
		Current_Village()

	Previous_Village()
		set hidden = 1
		var/_Page = winget(src, "Village.Village Notes", "text")
		if(_Page == "- Announcements -") winset(src, "Village.Village Notes", "text='- Statistics -'")
		else if(_Page == "- Storyline -") winset(src, "Village.Village Notes", "text='- Announcements -'")
		else if(_Page == "- Members -") winset(src, "Village.Village Notes", "text='- Storyline -'")
		else if(_Page == "- Statistics -") winset(src, "Village.Village Notes", "text='- Members -'")
		Current_Village()

mob/Dragonpearl123/verb
	Create_Alliance()
		var/Name = input("Please, type below the Alliance's name.", "Create Alliance") as text
		if(!Name) return
		var/Type = input(src, "What kind of Alliance?","Create Alliance") in list("Village", "Organization")
		if(!Type) return
		var/list/Players = list()
		for(var/mob/M) if(M.client) Players.Add(M)
		var/mob/Leader = input("Please, select the Alliance's Leader.", "Create Alliance") as null | anything in Players
		if(!Leader) return
		var/Rank = input("Please, type below [Leader.key]'s New Rank.", "Create Alliance") as text
		if(!Rank || !Leader) return
		Leader.Statistic.Rank = Rank
		new/Alliance (Name, Type, Leader, "[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")]")