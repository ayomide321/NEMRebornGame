mob/var/Thanked_Times = 0
mob/var/Thanked = 0
mob/var/Defense = 0
mob/var/Guess_Whats = 0

//AFTER U DROWN ON A ROUND IT BUGS THE MISSION AND STUFF

client/Topic(href,href_list[])
	switch(href_list["action"])

		if("Join Mission")
			var/Mission/M = locate(href_list["Mission"])
			var/F
			for(var/Mission/X in Active_Missions) if(X.Name == M && length(X.Ninjas) < X.Limit) {X.Join(mob); F = 1; break}
			if(!F) src<<"<b><font color=red><u>This mission is not currently available!</u>"

		if("Boot Chatroom")
			var/mob/Kick = locate(href_list["To Kick"])
			if(!Kick || Kick.Chatroom != mob.Chatroom || !mob.Chatroom || mob != mob.Chatroom.Leader) return
			else Kick.Chatroom.Leave(Kick, 1)

		if("Join Chatroom")
			var/Chatroom/Chatroom = locate(href_list["Chatroom"])
			if(!Chatroom) {src<<"<b><font color=red><u>This chatroom no longer exists!</u>"; return}
			if(mob.Chatroom) {src<<"<b><font color=red><u>You're already in a chatroom!</u>"; return}
			if(Chatroom.Members.Find(mob)) mob.Center("Chatroom")
			else
				if(!Chatroom.Password) {Chatroom.Join(mob); mob.Chatrooms()}
				else mob.Chatroom_Password_(Chatroom)

		if("Check Village")
			var/Alliance/A = locate(href_list["Village"])
			winset(mob, "Village.Village Notes", "text='- Announcements -'")
			mob.Alliance_R = A
			mob.Alliance_R.Update(mob)
			mob.Alliance_R.Show(mob)
			mob.Current_Village()

		if("Rank Promotion")

			var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Rank Promotion *</center></u><font size=4><br>"}
			var/Rank
			var/R
			var/A
			if(mob.Statistic.Rank == "Academy Student") {Rank = "Genin"; R = "* Complete E Rank Mission."}
			else if(mob.Statistic.Rank == "Genin") {Rank = "Chuunin"; R = "* 15 Reputation<br>- 10 D Rank Missions<br>- 5 C Rank Missions"}
			else if(mob.Statistic.Rank == "Chuunin") {Rank = "Special Jounin"; R = "* 45 Reputation<br>- 20 D Rank Missions<br>- 10 C Rank Missions<br>- 5 B Rank Missions<br>- 3 A Rank Missions"}
			else if(mob.Statistic.Rank == "Special Jounin") {Rank = "Jounin"; R = "* 85 Reputation<br>- 30 D Rank Missions<br>- 15 C Rank Missions<br>- 10 B Rank Missions<br>- 5 A Rank Missions<br>- 3 S Rank Missions"}
			Window += "<br><u><font size=3>[Rank]</u><font size=2><br>[R]"
			if(mob.Statistic.Rank == "Genin" && mob.Statistic.D_Missions >= 10 && mob.Statistic.C_Missions >= 5 && mob.Statistic.Reputation >= 15) A = 1
			if(mob.Statistic.Rank == "Chuunin" && mob.Statistic.D_Missions >= 20 && mob.Statistic.C_Missions >= 10 && mob.Statistic.B_Missions >= 5 && mob.Statistic.A_Missions >= 3 && mob.Statistic.Reputation >= 45) A = 1
			if(mob.Statistic.Rank == "Special Jounin" && mob.Statistic.D_Missions >= 30 && mob.Statistic.C_Missions >= 15 && mob.Statistic.B_Missions >= 10 && mob.Statistic.A_Missions >= 5 && mob.Statistic.S_Missions >= 3 && mob.Statistic.Reputation >= 85) A = 1
			if(A) Window += "<br><br><font size=3><a href='?src=\ref[src];action=Get Promotion'>Get Promotion</a>"
			src << output(null, "Menu.Browse")
			src << output(Window, "Menu.Browse")

		if("Statistic Search")
			if(mob.Statistic_CD) {var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Statistics *</center></u><font size=4><br>"}; Window += "<br><u><font size=3>Type below the name.</u><br><br><br><a href='?src=\ref[usr];action=Statistic Search'>Search</a><br><br><u>* Wait a moment..."; src << output(null, "Menu.Browse"); src << output(Window, "Menu.Browse"); return}

			var/Key = winget(src, "Menu.Statistic", "text")
			if(!Key || Key == "NPC") return
			mob.Statistic_CD = 1
			spawn(15) mob.Statistic_CD = 0
			for(var/Statistic/S in Statistics) if(S.Ninja == Key) {S.Show(mob); return}

			var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Statistics *</center></u><font size=4><br>"}
			Window += "<br><u><font size=3>Type below the name.</u><br><br><br><a href='?src=\ref[usr];action=Statistic Search'>Search</a><br><br><u>* [Key] doesn't exist in the Database!"
			src << output(null, "Menu.Browse")
			src << output(Window, "Menu.Browse")

		if("Chatroom Password")
			var/Chatroom/C = locate(href_list["Chatroom"])
			if(!C) src<<"<b><font color=red><u>This chatroom no longer exists!</u>"
			var/Key = winget(src, "Menu.Statistic", "text")
			if(!Key) return
			if(Key == C.Password)
				C.Join(mob)
				mob.Chatrooms()
			else
				var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Chatroom Password *</center></u><font size=4><br>"}
				Window += {"<br><u><font size=3>What is the password?</u><br><br><br><a href='?src=\ref[src];action=Chatroom Password;Chatroom=\ref[C]'>Join</a><br><br><u>* Incorrect Password!</u>"}
				src << output(null, "Menu.Browse")
				src << output(Window, "Menu.Browse")

		if("Get Promotion")
			var/R = mob.Statistic.Rank
			if(mob.Statistic.Rank == "Genin" && mob.Statistic.D_Missions >= 10 && mob.Statistic.C_Missions >= 5 && mob.Statistic.Reputation >= 15) {mob.Statistic.Reputation -= 15; mob.Statistic.Rank = "Chuunin"}
			else if(mob.Statistic.Rank == "Chuunin" && mob.Statistic.D_Missions >= 20 && mob.Statistic.C_Missions >= 10 && mob.Statistic.B_Missions >= 5 && mob.Statistic.A_Missions >= 3 && mob.Statistic.Reputation >= 45) {mob.Statistic.Reputation -= 45; mob.Statistic.Rank = "Special Jounin"}
			else if(mob.Statistic.Rank == "Special Jounin" && mob.Statistic.D_Missions >= 30 && mob.Statistic.C_Missions >= 15 && mob.Statistic.B_Missions >= 10 && mob.Statistic.A_Missions >= 5 && mob.Statistic.S_Missions >= 3 && mob.Statistic.Reputation >= 85) {mob.Statistic.Reputation -= 85; mob.Statistic.Rank = "Jounin"}
			if(R != mob.Statistic.Rank) {mob<<"<b><font color=[admin_color]><u><font size=3>You've been promoted to [mob.Statistic.Rank]!</u>"; mob.Statistic.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Promoted To [mob.Statistic.Rank]! *"; mob.Missions()}

		if("Create Chatroom")
			var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Create Chatroom *</center></u><font size=4><br>"}
			Window += {"<br><u><font size=3>Type below the name.</u><br><br><br><a href='?src=\ref[usr];action=Create Chatroom Finish'>Create</a>"}
			src << output(null, "Menu.Browse")
			src << output(Window, "Menu.Browse")
			winshow(src, "Menu.Return", 1)
			winshow(src, "Menu.Statistic", 1)

		if("Create Chatroom Finish")
			var/Key = winget(src, "Menu.Statistic", "text")
			var/G
			for(var/Chatroom/C in Active_Chatrooms) if(C.Name == Key) G = 1
			if(!Key || Key == " " || Key == "  " || G || length(Key) < 3 || length(Key) > 26) {var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Create Chatroom *</center></u><font size=4><br>"}; Window += "<br><u><font size=3>Type below the name.</u><br><br><br><a href='?src=\ref[usr];action=Create Chatroom Finish'>Create</a><br><br><u>* This name is not allowed!"; src << output(null, "Menu.Browse"); src << output(Window, "Menu.Browse"); return}
			new/Chatroom (Key, mob)
			mob.Chatrooms()

		if("Change Chatroom Password")
			if(!mob.Chatroom || mob.Chatroom.Leader != mob) return
			var/Key = winget(src, "Menu.Statistic", "text")
			if(!Key || length(Key) > 18) {var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Chatroom Password *</center></u><font size=4><br>"}; Window += "<br><u><font size=3>Type below the password.</u><br><br><br><a href='?src=\ref[usr];action=Change Chatroom Password'>Set</a><br><br><u>* The password is too long!"; src << output(null, "Menu.Browse"); src << output(Window, "Menu.Browse"); return}
			mob.Chatrooms()
			mob.Chatroom.Password = Key
			mob<<output("<font color=#BABABA><b><u><font size=2>The password is now [Key]!</u>", "Chatroom.Output")

		if("Chatrooms") mob.Chatrooms()
		if("My Statistics") mob.Statistic.Show(mob)
		if("Donate Ryo") mob.Donate_Ryo()
		if("Missions Refresh") mob.Missions()
		if("Join Village I") mob.Join_Village()
		if("Join Village II") mob.Join_Village(1)
		if("Village Settings") mob.Village_Settings()
		if("Village Settings Reputation") mob.Village_Settings("Reputation")
		if("Village Settings Ryo") mob.Village_Settings("Ryo")
		if("Logo") mob.Edit_Logo()
		if("Taxes") mob.Taxes()
		if("Invite To Village") mob.Invite_Village()
		if("Kick From Village") mob.Kick_From_Village()
		if("Promote") mob.Promote()
		if("Select Pill") mob.Select_Pill()
		if("Pills Guide") mob.Pills_Guide()
		if("Buy Lucky Number") Lucky_Number.Check(mob, 1)
		if("Auction") mob.Black_Market_Auction()
		if("Black Market") mob.Black_Market()
		if("No Buy Lucky Number") Lucky_Number.Check(mob)
		if("Check Who Plays") Lucky_Number.Who_Plays(mob)
		if("Previous Winners") Lucky_Number.Previous_Winners(mob)

		if("Edit Storyline")
			if(mob.key != "Dragonpearl123") return
			var/T = input(mob, "Type below the storyline","Edit Storyline", mob.Alliance_R.Storyline) as message
			if(!T) return
			if(alert(mob, "Are you sure?", "Edit Storyline", "No", "Yes") == "Yes") if(alert(mob, "Are you sure?", "Edit Storyline", "No", "Yes", "No") == "Yes") if(alert(mob, "Are you sure?", "Edit Storyline", "No", "Yes", "No") == "Yes")
				mob.Alliance_R.Storyline = T
				mob.Current_Village()

		if("Edit Announcements")
			if(!mob.Statistic._Village_ || mob.Statistic._Village_.Leader.Ninja != key) return
			var/Q = input(src, "What would you like to do?", "Edit Announcements") in list ("Edit", "Reset")
			if(!mob.Statistic._Village_ || mob.Statistic._Village_.Leader.Ninja != key) return
			if(Q == "Edit")
				if(!mob.Statistic._Village_ || mob.Statistic._Village_.Leader.Ninja != key) return
				var/T = input(mob, "Please, type below the announcements.\n\n* Remember to use HTML Tags! (such as <b>, <u>, <i>, <br>, etc...)","Edit Announcements", mob.Statistic._Village_.Announcement) as message
				if(!mob.Statistic._Village_ || mob.Statistic._Village_.Leader.Ninja != key) return
				if(!T) return
				if(length(T) >= 15000) mob.Announced("<font color=#609BF2><b><u>* It can't exceed 15000 characters!", 7)
				else if(mob.FilterText(T,ADList_)) mob.Announced("<font color=#609BF2><b><u>* You entered an illegal word!", 7)

				else
					mob.Statistic._Village_.Announcement = T
					mob.Current_Village()
					for(var/mob/M in world) if(M.client && mob.Statistic._Village_.Members.Find(M.Statistic)) M.Announced("<font color=#609BF2><b><u>* [mob.Statistic._Village_.Name]'s Announcements were updated!", 7)

			if(Q == "Reset")
				if(alert(mob, "Reset Announcements?", "Reset Announcements", "No", "Yes") == "Yes") if(alert(mob, "Are you sure?\n\nThis will reset the Announcements!", "Reset Announcements", "No", "Yes", "No") == "Yes")
					if(!mob.Statistic._Village_ || mob.Statistic._Village_.Leader.Ninja != key) return
					mob.Statistic._Village_.Announcement = "<center><font size=5><font color=#4B7FCC><u>[mob.Statistic._Village_.Name]</u></center><br><font size=3><center>None</center>"
					mob.Current_Village()
					mob.Announced("<font color=#609BF2><b><u>* You have successfully resetted the Announcements!", 7)

		if("Kick From Village User No")
			mob.Announced("")
			mob.Announcement_Time = -7

		if("Buy Shuriken")
			if(mob.Statistic.Shuriken_Perk) {mob<<"<b><font color=red><u>You already have this perk!</u>"; return}
			if(mob.Statistic.Reputation < 30) {mob<<"<b><font color=red><u>You require [30-mob.Statistic.Reputation] more reputation to buy this!</u>"; return}
			if(alert(mob, "This perk requires 30 reputation, are you sure?", "Buy Makibishi Spike Perk", "Yes", "No") == "Yes") if(alert(mob, "Really?\n\nBuying Makibishi Spike Perk for 25 reputation", "Buy Makibishi Spike Perk", "No", "Yes") == "Yes")
				if(mob.Statistic.Shuriken_Perk) {mob<<"<b><font color=red><u>You already have this perk!</u>"; return}
				if(mob.Statistic.Reputation < 30) {mob<<"<b><font color=red><u>You require [30-mob.Statistic.Reputation] more reputation to buy this!</u>"; return}
				mob.Statistic.Reputation -= 25
				mob.Statistic.Shuriken_Perk = 1
				mob<<"<b><font color=red><u>You can now buy Makibishi Spikes!</u>"
		if("Buy Kunai Scroll")
			if(mob.Statistic.Scroll_Perk) {mob<<"<b><font color=red><u>You already have this perk!</u>"; return}
			if(mob.Statistic.Reputation < 30) {mob<<"<b><font color=red><u>You require [30-mob.Statistic.Reputation] more reputation to buy this!</u>"; return}
			if(alert(mob, "This perk requires 30 reputation, are you sure?", "Buy Kunai Scroll Perk", "Yes", "No") == "Yes") if(alert(mob, "Really?\n\nBuying Kunai Scroll Perk for 25 reputation", "Buy Kunai Scroll Perk", "No", "Yes") == "Yes")
				if(mob.Statistic.Scroll_Perk) {mob<<"<b><font color=red><u>You already have this perk!</u>"; return}
				if(mob.Statistic.Reputation < 30) {mob<<"<b><font color=red><u>You require [30-mob.Statistic.Reputation] more reputation to buy this!</u>"; return}
				mob.Statistic.Reputation -= 25
				mob.Statistic.Scroll_Perk = 1
				mob<<"<b><font color=red><u>You can now buy Kunai Scrolls!</u>"

		if("Kick From Village User Yes")
			var/Statistic/User = locate(href_list["User"])
			if(mob.Statistic._Village_.Members.Find(User))
				if(mob.Statistic._Village_.Ryo < 300) mob.Announced("<font color=#609BF2><b><u>* [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name] needs [300-mob.Statistic._Village_.Ryo] Ryo!", 5)
				for(var/mob/M in mob.Statistic._Village_._Members) M.Announced("<font color=#609BF2><b><u>* [User.Ninja] has been kicked off [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name]!", 7)
				mob.Statistic._Village_.Ryo -= 300
				mob.Statistic._Village_.Members.Remove(User)
				mob.Statistic._Village_._Members.Remove(User)
				mob.Statistic._Village_.Storyline += "<font color=#3681E3>[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")] - <font color=#4A8BE1>[User.Ninja] was kicked off [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name]!<br>"
				for(var/Statistic/S in Statistics) if(S.Ninja == User.Ninja) {S.Rank_Update("Missing-Nin"); S._Village_ = null; S.Village = null; S.Rogue = 1}

		if("Yes Buy Lucky Number")
			var/_Price_ = text2num(href_list["Price"])
			Lucky_Number.Buy_Ticket(mob, mob.Statistic, _Price_)


		if("Leave Village")
			if(!mob.Statistic._Village_) return
			if(mob.Statistic.Ryo < 75) mob.Announced("<font color=#609BF2><b><u>* You need [75-mob.Statistic.Ryo] Ryo to leave [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name]!", 5)
			else mob.Announced("<font color=#609BF2><b><u>* Pay 75 Ryo to leave [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name]?</u> <a href='?src=\ref[src];action=Leave Village Yes'>Yes</a> or <a href='?src=\ref[src];action=Kick From Village User No;User=\ref[src]'>No</a>", 10)

		if("Leave Village Yes")
			if(!mob.Statistic._Village_) return
			if(mob.Statistic.Ryo < 75) mob.Announced("<font color=#609BF2><b><u>* You need [75-mob.Statistic.Ryo] Ryo to leave [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name]!", 5)
			else
				if(mob.Statistic.Rank != "Academy Student" && mob.Statistic.Rank != "Genin" && mob.Statistic.Rank != "Chuunin") mob.Statistic._Village_.Storyline += "<font color=#3681E3>[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")] - <font color=#4A8BE1>[mob.Statistic.Ninja] left [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name]!<br>"
				mob.Statistic.Rank_Update("Missing-Nin")
				for(var/mob/M in mob.Statistic._Village_._Members) M.Announced("<font color=#609BF2><b><u>* [mob.Statistic.Ninja] left [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name]!", 7)
				mob.Statistic._Village_.Ryo += 75
				mob.Statistic.Ryo -= 75
				mob.Statistic._Village_._Members.Remove(mob)
				mob.Statistic._Village_.Members.Remove(mob.Statistic)
				mob.Statistic._Village_ = null
				mob.Statistic.Village = null
				mob.Statistic.Rogue = 1

		if("Bid Now")
			var/mob/User = locate(href_list["User"])
			var/Auction/Auction = locate(href_list["Auction"])
			if(!Auction) {User<<"<b><font color=red><u>This auction no longer exists!</u>"; return}
			else Auction.Buy(mob)

		if("Promote User")
			var/Statistic/User = locate(href_list["User"])
			if(!mob.Statistic._Village_.Members.Find(User)) return

			var
				Prize_
				Promotion

			if(User.Rank != "Academy Student" && User.Rank != "Genin" && User.Rank != "Chuunin" && User.Rank != "Special Jounin")
				Promotion = input(mob, "Please, type below the rank.","Special Rank") as text
				mob.Announced("<font color=#609BF2><b><u>Admin Ranks are illegal!", 5)
				if(Promotion == mob.Statistic._Village_.Leader.Rank)
					mob.Announced("<font color=#609BF2><b><u>You can't share your rank!", 5)
					return
				if(Promotion == "Genin" || Promotion == "Chuunin" || Promotion == "Academy Student" || Promotion == "Special Jounin")
					mob.Announced("<font color=#609BF2><b><u>Illegal Rank!", 5)
					return
				if(findtext(Promotion, "kage") || findtext(Promotion, "Kage"))
					mob.Announced("<font color=#609BF2><b><u>Illegal Rank!", 5)
					return
				if(length(Promotion) > 18)
					mob.Announced("<font color=#609BF2><b><u>Too long! Limit: 18 characters.", 5)
					return
				if(length(Promotion) < 3)
					mob.Announced("<font color=#609BF2><b><u>Too short! Minium: 3 characters.", 5)
					return
				Prize_ = 1500

			mob.Announced("<font color=#609BF2><b><u>* Promote [User.Ninja] to [Promotion] for [Prize_] Ryo?</u> <a href='?src=\ref[src];action=Promote Ninja;User=\ref[User]&&Rank=[Promotion]&&Prize_=[Prize_]'>Yes</a> or <a href='?src=\ref[src];action=Kick From Village User No;User=\ref[User]'>No</a>", 10)
			winset(mob, "Village.Village Notes", "text='- Members -'")
			mob.Current_Village()

		if("Promote Ninja")
			var/Statistic/Ninja = locate(href_list["User"])
			var/Rank_ = href_list["Rank"]
			var/Cost_ = href_list["Prize_"]
			mob.Promote_Ninja(Ninja, Rank_, Cost_)

		if("Kick From Village User")
			var/Statistic/User = locate(href_list["User"])
			if(!User.Village || !mob.Statistic._Village_.Members.Find(User)) return
			if(mob.Statistic._Village_.Ryo < 300) mob.Announced("<font color=#609BF2><b><u>* [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name] needs [300-mob.Statistic._Village_.Ryo] Ryo!", 7)
			mob.Announced("<font color=#609BF2><b><u>* Are you sure you want to kick [User.Ninja]?</u> <a href='?src=\ref[src];action=Kick From Village User Yes;User=\ref[User]'>Yes</a> or <a href='?src=\ref[src];action=Kick From Village User No;User=\ref[User]'>No</a>", 10)
			mob.Current_Village()

		if("Change Leader")
			var/Alliance/Village = locate(href_list["Village"])
			var/Person = input(mob, "Who'll be the New Village Leader?", "* Change Village Leader *") as text
			if(!Person) return
			for(var/Statistic/S in Statistics) if(S.Ninja == Person)
				if(Village.Leader) {S.Rank = Village.Leader.Rank; Village.Leader.Rank = "ANBU"; Village.Leader = S}
				Village.Leader = S
				Village.Storyline += "<u><font color=#3681E3>[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")] - <font color=#4A8BE1>[S.Ninja] is now the [Village.Type] Leader!</u><br>"
				for(var/mob/M in Village._Members) M.Announced("<font color=#609BF2><b><u>* [S.Ninja] is now the [Village.Type] Leader!", 7)
				return


		if("Special Village Command")
			var/Alliance/Village = locate(href_list["Village"])
			var/Q= input(src, "What would you like to do?", "Special") in list ("Delete Member")
			if(Q == "Delete Member")
				var/list/Players = list()
				for(var/Statistic/M in Village.Members) Players.Add(M.Ninja)
				var/S = input("Who would you like to delete off [Village.Type] [Village.Name]?", "Selection") as null | anything in Players
				if(alert(src, "Are you sure?", "Confirmation", "No", "Yes") == "Yes")
					for(var/Statistic/D in Village.Members) if(D.Ninja == S)
						if(D.Village == Village) D.Village = null
						Village.Members.Remove(D)
						Village.Organize()
						D.Rank_Update("Missing-Nin")

		if("Disband")
			var/Alliance/Village = locate(href_list["Village"])
			if(alert(src, "Are you sure?", "Disband [Village.Type] [Village.Name]", "No", "Yes") == "Yes")
				if(alert(src, "Are you sure?", "Disband [Village.Type] [Village.Name]", "Yes", "No") == "Yes")
					for(var/Statistic/S in Village.Members)
						S.Rank_Update("Missing-Nin")
						S.Village = null
						S._Village_ = null
					Alliances.Remove(Village)
					del(Village)

		if("Invite To Village User")
			var/mob/User = locate(href_list["User"])
			var/Alliance/Village = locate(href_list["Village"])
			if(mob.Statistic._Village_.Invite_Delay) mob.Announced("<font color=#609BF2><b><u>* Please, wait...", mob.Statistic._Village_.Invite_Delay)
			else if(mob.Statistic._Village_.Ryo < 150) mob.Announced("<font color=#609BF2><b><u>* [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name] needs [150-mob.Statistic._Village_.Ryo] Ryo!", 5)
			else if(User.Statistic._Village_) mob.Announced("<font color=#609BF2><b><u>* This player is already in [User.Statistic._Village_.Type] [User.Statistic._Village_.Name]!", 5)
			else if(!User.client) mob.Announced("<font color=#609BF2><b><u>* This player is currently offline!", 5)

			else
				mob.Announced("<font color=#609BF2><b><u>* You've successfully invited [User.key] to your Village!", 7)
				mob.Statistic._Village_.Delay("Invite", 15)
				mob.Invite_Village_Player(User, Village)
				mob.Current_Village()

		if("Accept Village Invitation")
			var/Alliance/Village = locate(href_list["Village"])
			if(mob.Statistic._Village_)
				mob.Announced("<font color=#609BF2><b><u>* You are already in [mob.Statistic._Village_.Type] [mob.Statistic._Village_.Name]!", 5)
				return
			if(Village.Ryo < 150)
				mob.Announced("<font color=#609BF2><b><u>* [Village.Type] [Village.Name] needs [150-Village.Ryo] Ryo!", 5)
				for(var/mob/M in world) if(M.Statistic == Village.Leader) M.Announced("<font color=#609BF2><b><u>* [Village.Type] [Village.Name] needs [150-Village.Ryo] Ryo!", 5)
				return
			mob.Statistic._Village_ = Village
			mob.Statistic.Village = Village.Name
			mob.Announced("")
			mob.Announcement_Time = -7
			mob.Statistic.Rogue = 0
			if(mob.Statistic._Village_.Type == "Organization") mob.Statistic.Rank_Update("Akatsuki")
			else mob.Statistic.Rank_Update("Normal")
			Village.Ryo -= 150
			Village._Members.Add(mob)
			Village.Members.Add(mob.Statistic)
			Village.Storyline += "<font color=#3681E3>[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")] - <font color=#4A8BE1>[key] joined [Village.Type] [Village.Name]!<br>"
			Village.Organize()
			for(var/mob/M in Village._Members) M.Announced("<font color=#609BF2><b><u>* [key] has joined [Village.Type] [Village.Name]!", 10)
			winset(src, "Village.Village Notes", "text='- Storyline -'")
			mob.Current_Village()

		if("Reject Village Invitation")
			var/Alliance/Village = locate(href_list["Village"])
			mob.Announced("")
			mob.Announcement_Time = -7
			for(var/mob/M in world) if(M.client && Village.Leader == M.Statistic) M.Announced("<font color=#609BF2><b><u>* [key] has rejected your invitation!", 7)

		if("Vote Poll")
			var/Option = locate(href_list["Option"])
			var/Poll/Poll = locate(href_list["Poll"])
			if(Poll.Voted.Find(key)) return
			Poll.Voted_Options.Add(Option)
			Poll.Voted.Add(key)
			mob<<"<b><font color=#B00000><u>You've successfully voted [Option]</u>"
			for(var/mob/C) if(C.CanHearAll==1) C<<output("<b><font color=#D73D3D>* [key] Poll Voted: [Option]","Chat")
		if("Contact") mob.Contact_Dragonpearl()
		if("Un_AFK") mob.Un_AFK()
		if("Introduction") mob.Introduction()
		if("Admin Help") mob.Admin_Help()
		if("Investigate")
			var/Personal_Log/M = locate(href_list["Log"])
			for(var/I in M.CIs) for(var/Personal_Log/P in Personal_Logs) if(P.Name != M.Name && P.CIs.Find(I)) src<<"<u><b><font color=[admin_color]>[P.Name] and [M.Name] share the same Computer ID {[I]}!</u>"
			for(var/I in M.IPs) for(var/Personal_Log/P in Personal_Logs) if(P.Name != M.Name && P.IPs.Find(I)) src<<"<u><b><font color=[admin_color]>[P.Name] and [M.Name] share the same IP {[I]}!</u>"

		if("Thank You")
			if(mob.Thanked)
				var/Time = 300 - mob.Thanked
				if(Time != 1) src<<"<b><font color=red><u><center>You will be able to use * Thank You * in [Time] seconds!</center></font></u>"
				if(Time == 1) src<<"<b><font color=red><u><center>You will be able to use * Thank You * in [Time] second!</center></font></u>"
				return
			var/M = href_list["User"]
			var/Checked = 0
			for(var/mob/P)
				if(P.key == M)
					Current_Log.Add("[mob.key] gave [M] a Thank You Point!")
					Checked = 1
					mob.Thanked = 1
					P.Thanked_Times ++
					P.Ryo_Reward(10)
					if(!P.Thanked_Times) P.Thanked_Times = 1
			if(!Checked) src<<"<b><font color=[admin_color]><font size=2><i><u>[M] is currently offline, so we couldn't than him his help! :(</i></u></font>"
			if(Checked) world<<"<b><font color=[admin_color]><font size=2><i><u>[M] has received a Thank You Point for helping [mob.key]!</b><i></u></font>"

		if("Reply Admin Help")
			var/M = href_list["User"]
			var/T = input(src, "Please, type below your message.","Reply [M]") as text
			if(!T) return
			var/Checked = 0
			for(var/mob/P)
				if(P.key == M)
					Checked = 1
					var/Admin = mob.key
					if(!P.Thanked) P<<output("<u><font color=[admin_color]><b>[src.key] - Replied</u> [html_encode(copytext(T,1,750))] <br><a href='?src=\ref[src];action=Admin Help'><i>* Ask More!</a> <a href='?src=\ref[src];action=Thank You;User=[Admin]'><i>* Thank You!</i></a></b></font>", "Chat")
					if(P.Thanked) P<<output("<u><font color=[admin_color]><b>[src.key] - Replied</u> [html_encode(copytext(T,1,750))] <br><a href='?src=\ref[src];action=Admin Help'><i>* Ask More!</a></i></b></font>", "Chat")
					for(var/mob/C in world) if(C.GM_Rank || Real_Owner.Find(C.key)) C<<"<u><font color=[admin_color]><b>[src.key] - Admin Helped [M]</u> [html_encode(copytext(T,1,750))]"
			if(Checked) src<<"<b><font color=[admin_color]><font size=2><i>You've successfully sent your message to [M].</i>"
			if(!Checked) src<<"<b><font color=[admin_color]><font size=2><i>You've failed to send your message to [M].</i>"
		if("Reply")
			var/M = href_list["User"]
			var/T = input(src, "Please, type below your message.","Reply [M]") as text
			if(!T) return
			var/Checked = 0
			for(var/mob/P)
				if(P.key == M)
					Checked = 1
					P<<"<b><font color=#5CB3FF>[T] ~by Dragon Pearl. <i><a href='?src=\ref[src];action=Contact'>Reply</a></i></b></font>"
			if(Checked) src<<"<b><font color=#8EFCF9><font size=2><i>You've successfully sent your message to [M].</i>"
			if(!Checked) src<<"<b><font color=#8EFCF9><font size=2><i>You've failed to send your message to [M].</i>"


var/Password = "asdqw45e16"
var/Remote_Server = 0
var/Topic_CD = 0

world/Topic(T as text, Address, Master, Key) return