mob/verb
	Close_Menu()
		set hidden = 1
		if(Mission_On && Mission_On.Time_To_Start > 0) {Mission_On.Leave(src); Resize(); Missions()}

	Menu()
		set name = "Player Menu"
		if(Mission_On)
			if(Mission_On.Time_To_Start > 0) {Mission_On.Leave(src); Resize()}
			else {winshow(src, "Menu.MissionBackground", 1); winshow(src, "Menu.MissionOutput", 1); winshow(src, "Menu.MissionInput", 1); winshow(src, "Menu.Participants", 1); winshow(src, "Menu.Abandon", 1); winshow(src, "Menu.Begin", 1); winshow(src, "Menu.Browse", 0); winshow(src, "Menu.Return", 0); winshow(src, "Menu", 1); return}
		if(winget(src, "Menu", "is-visible") == "false") Center("Menu")
		winshow(src, "Menu.Statistic", 0)
		winshow(src, "Menu.MissionBackground", 0)
		winshow(src, "Menu.MissionOutput", 0)
		winshow(src, "Menu.MissionInput", 0)
		winshow(src, "Menu.Participants", 0)
		winshow(src, "Menu.Abandon", 0)
		winshow(src, "Menu.Begin", 0)
		winshow(src, "Menu.Return", 0)
		winshow(src, "Menu.Image", 0)
		winshow(src, "Menu.Browse", 0)
		winshow(src, "Menu.ExtraBackground", 0)
		return 1

	Villages()
		set hidden = 1
		if(Menu() == 0) return
		var/Window = {"<html><body><font color=white><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Villages *</center></u><font size=4><br>"}
		for(var/Alliance/A in Alliances) if(A.Type == "Village") Window += "<br><a href='?src=\ref[src];action=Check Village;Village=\ref[A]'>[A.Name]</a>"
		winset(src, "Menu.Image", "image=\ref[Menu_Villages]")
		src << output(null, "Menu.Browse")
		src << output(Window, "Menu.Browse")
		winshow(src, "Menu.Return", 1)
		winshow(src, "Menu.Image", 1)
		winshow(src, "Menu.Browse", 1)
		winshow(src, "Menu.ExtraBackground", 1)

	Organizations()
		set hidden = 1
		if(Menu() == 0) return
		var/Window = {"<html><body><font color=white><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Organizations *</center></u><font size=4><br>"}
		for(var/Alliance/A in Alliances) if(A.Type == "Organization") Window += "<br><a href='?src=\ref[src];action=Check Village;Village=\ref[A]'>[A.Name]</a>"
		winset(src, "Menu.Image", "image=\ref[Menu_Organizations]")
		src << output(null, "Menu.Browse")
		src << output(Window, "Menu.Browse")
		winshow(src, "Menu.Return", 1)
		winshow(src, "Menu.Image", 1)
		winshow(src, "Menu.Browse", 1)
		winshow(src, "Menu.ExtraBackground", 1)

	Missions()
		set hidden = 1
		if(!Statistic._Village_)
			src<<"<b><font color=red><u>You need a Village!</u>"
			return
		if(Menu() == 0) return

		var/GG
		if(Statistic.Rank != "Academy Student" && Statistic.Rank != "Genin" && Statistic.Rank != "Chuunin" && Statistic.Rank != "Special Jounin") GG = 1

		var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Missions *</center></u><font size=4><br>"}

		if(Statistic.Rank == "Academy Student")
			Window += "<br><u><font size=3>E Rank Mission</u><font size=2>"
			for(var/Mission/A in Active_Missions) if(A.Rank == "E") {if(length(A.Ninjas) == A.Limit || findtext(Window, A.Name)) continue; var/Time_To_Wait; for(var/C in Missions_Cooldowns) if(findtext(C, A.Name)) {if(Missions_Cooldowns[C] < world.realtime) Missions_Cooldowns.Remove(C); else Time_To_Wait = round((Missions_Cooldowns[C] -world.realtime) /600, 1)}; if(!Time_To_Wait) Window += {"<br><div style="float:right"><a href='?src=\ref[src];action=Join Mission;Mission=\ref[A.Name]'>[length(A.Ninjas)]/[A.Limit] ~Join</a></div style>[A.Name]"}; else if(Time_To_Wait > 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minutes<font color=#7E0F0F></div style>[A.Name]"}; else if(Time_To_Wait == 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minute<font color=#7E0F0F></div style>[A.Name]<br>"}}
			Window += "<br>"

		if(Statistic.Rank == "Genin" || Statistic.Rank == "Chuunin" || Statistic.Rank == "Special Jounin" || Statistic.Rank == "Jounin" || GG)
			Window += "<br><u><font size=3>D Rank Missions</u><font size=2>"
			for(var/Mission/A in Active_Missions) if(A.Rank == "D") {if(length(A.Ninjas) == A.Limit || findtext(Window, A.Name)) continue; var/Time_To_Wait; for(var/C in Missions_Cooldowns) if(findtext(C, A.Name)) {if(Missions_Cooldowns[C] < world.realtime) Missions_Cooldowns.Remove(C); else Time_To_Wait = round((Missions_Cooldowns[C] -world.realtime) /600, 1)}; if(!Time_To_Wait) Window += {"<br><div style="float:right"><a href='?src=\ref[src];action=Join Mission;Mission=\ref[A.Name]'>[length(A.Ninjas)]/[A.Limit] ~Join</a></div style>[A.Name]"}; else if(Time_To_Wait > 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minutes<font color=#7E0F0F></div style>[A.Name]"}; else if(Time_To_Wait == 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minute<font color=#7E0F0F></div style>[A.Name]"}}
			Window += "<br><br><u><font size=3>C Rank Missions</u><font size=2>"
			for(var/Mission/A in Active_Missions) if(A.Rank == "C") {if(length(A.Ninjas) == A.Limit || findtext(Window, A.Name)) continue; var/Time_To_Wait; for(var/C in Missions_Cooldowns) if(findtext(C, A.Name)) {if(Missions_Cooldowns[C] < world.realtime) Missions_Cooldowns.Remove(C); else Time_To_Wait = round((Missions_Cooldowns[C] -world.realtime) /600, 1)}; if(!Time_To_Wait) Window += {"<br><div style="float:right"><a href='?src=\ref[src];action=Join Mission;Mission=\ref[A.Name]'>[length(A.Ninjas)]/[A.Limit] ~Join</a></div style>[A.Name]"}; else if(Time_To_Wait > 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minutes<font color=#7E0F0F></div style>[A.Name]"}; else if(Time_To_Wait == 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minute<font color=#7E0F0F></div style>[A.Name]"}}

		if(Statistic.Rank == "Chuunin" || Statistic.Rank == "Special Jounin" || Statistic.Rank == "Jounin" || GG)
			Window += "<br><br><u><font size=3>B Rank Missions</u><font size=2>"
			for(var/Mission/A in Active_Missions) if(A.Rank == "B") {if(length(A.Ninjas) == A.Limit || findtext(Window, A.Name)) continue; var/Time_To_Wait; for(var/C in Missions_Cooldowns) if(findtext(C, A.Name)) {if(Missions_Cooldowns[C] < world.realtime) Missions_Cooldowns.Remove(C); else Time_To_Wait = round((Missions_Cooldowns[C] -world.realtime) /600, 1)}; if(!Time_To_Wait) Window += {"<br><div style="float:right"><a href='?src=\ref[src];action=Join Mission;Mission=\ref[A.Name]'>[length(A.Ninjas)]/[A.Limit] ~Join</a></div style>[A.Name]"}; else if(Time_To_Wait > 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minutes<font color=#7E0F0F></div style>[A.Name]"}; else if(Time_To_Wait == 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minute<font color=#7E0F0F></div style>[A.Name]"}}
			Window += "<br><br><u><font size=3>A Rank Missions</u><font size=2>"
			for(var/Mission/A in Active_Missions) if(A.Rank == "A") {if(length(A.Ninjas) == A.Limit || findtext(Window, A.Name)) continue; var/Time_To_Wait; for(var/C in Missions_Cooldowns) if(findtext(C, A.Name)) {if(Missions_Cooldowns[C] < world.realtime) Missions_Cooldowns.Remove(C); else Time_To_Wait = round((Missions_Cooldowns[C] -world.realtime) /600, 1)}; if(!Time_To_Wait) Window += {"<br><div style="float:right"><a href='?src=\ref[src];action=Join Mission;Mission=\ref[A.Name]'>[length(A.Ninjas)]/[A.Limit] ~Join</a></div style>[A.Name]"}; else if(Time_To_Wait > 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minutes<font color=#7E0F0F></div style>[A.Name]"}; else if(Time_To_Wait == 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minute<font color=#7E0F0F></div style>[A.Name]"}}

		var/S
		if(Statistic.Rank == "Special Jounin" || Statistic.Rank == "Jounin" || GG)
			Window += "<br><br><u><font size=3>S Rank Missions</u><font size=2>"
			for(var/Mission/A in Active_Missions) if(A.Rank == "S") {if(length(A.Ninjas) == A.Limit || findtext(Window, A.Name)) continue; S = 1; var/Time_To_Wait; for(var/C in Missions_Cooldowns) if(findtext(C, A.Name)) {if(Missions_Cooldowns[C] < world.realtime) Missions_Cooldowns.Remove(C); else Time_To_Wait = round((Missions_Cooldowns[C] -world.realtime) /600, 1)}; if(!Time_To_Wait) Window += {"<br><div style="float:right"><a href='?src=\ref[src];action=Join Mission;Mission=\ref[A.Name]'>[length(A.Ninjas)]/[A.Limit] ~Join</a></div style>[A.Name]"}; else if(Time_To_Wait > 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minutes<font color=#7E0F0F></div style>[A.Name]"}; else if(Time_To_Wait == 1) Window += {"<br><div style="float:right"><font color=#690D0D>[round(Time_To_Wait)] minute<font color=#7E0F0F></div style>[A.Name]"}}
			if(!S) Window += "<br><font color=#7E0F0F>None Available"

		Window += {"<br><br><font size=3><a href='?src=\ref[usr];action=Missions Refresh'>Refresh</a>"}
		Window += {"<br><font size=3><a href='?src=\ref[usr];action=Rank Promotion'>Rank Promotion</a>"}
		winset(src, "Menu.Image", "image=\ref[Menu_Missions]")
		src << output(null, "Menu.Browse")
		src << output(Window, "Menu.Browse")
		winshow(src, "Menu.Return", 1)
		winshow(src, "Menu.Image", 1)
		winshow(src, "Menu.Browse", 1)
		winshow(src, "Menu.ExtraBackground", 1)

	Chatrooms()
		set hidden = 1
		if(Menu() == 0) return
		var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Chatrooms *</center></u><font size=3><br>"}
		for(var/Chatroom/C in Active_Chatrooms) Window += {"<br><div style="float:right"><a href='?src=\ref[src];action=Join Chatroom;Chatroom=\ref[C]'>[length(C.Members)] Members ~Join</a></div style>[html_encode(C.Name)]"}
		Window += {"<br><br><font size=3>"}
		if(!Chatroom) Window += {"<div style="float:right"><a href='?src=\ref[src];action=Create Chatroom'>Create</a></div style>"}
		Window += "<a href='?src=\ref[usr];action=Chatrooms'>Refresh</a>"
		winset(src, "Menu.Image", "image=\ref[Menu_Missions]")
		src << output(null, "Menu.Browse")
		src << output(Window, "Menu.Browse")
		winshow(src, "Menu.Return", 1)
		winshow(src, "Menu.Image", 1)
		winshow(src, "Menu.Browse", 1)
		winshow(src, "Menu.ExtraBackground", 1)

	Statistics()
		set hidden = 1
		if(Menu() == 0) return
		var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Statistics *</center></u><font size=4><br>"}
		Window += {"<br><u><font size=3>Type below the name.</u><br><br><br><div id="main"><div style="float:right"><a href='?src=\ref[src];action=My Statistics'>My Statistics</a></div><a href='?src=\ref[usr];action=Statistic Search'>Search</a>"}
		src << output(null, "Menu.Browse")
		src << output(Window, "Menu.Browse")
		winshow(src, "Menu.Return", 1)
		winshow(src, "Menu.Statistic", 1)
		winshow(src, "Menu.Image", 1)
		winshow(src, "Menu.Browse", 1)
		winshow(src, "Menu.ExtraBackground", 1)

	Black_Market()
		set hidden = 1
		if(Menu() == 0) return

		var/Window = {"<html><body><font color=white><style = \"text/css\">body { scrollbar-DarkShadow-Color:#854040;scrollbar-Shadow-Color:#6F3636;scrollbar-base-color:#572B2B;scrollbar-arrow-color:#411F1F;background-color:#150000} #main p{text-align:right}</style></body></html><b><font size=6><u><font color=#7C0000><center>* Black Market *</u></center><br><font size=2>"}
		for(var/Auction/A in Auctions)
			var/_Time_Remaining_= (A.Time - world.realtime) /600
			var/T_Hours = round(_Time_Remaining_ /60)
			_Time_Remaining_ -= T_Hours *60
			if(T_Hours == -1) {T_Hours = 0; _Time_Remaining_ = 1}
			Window += "<br><font color=#A30101><font size=3><u>- [A.Creator.Ninja] is auctioning [A.Reputation] reputation.</u>"
			if(A.Bid_Creator) Window += {"<font color=#A30101><font size=2><div id="main"><div style="float:right">[T_Hours] Hour(s) & [round(_Time_Remaining_)] Minute(s) ~[A.Highest_Bid] ryo bid by [A.Bid_Creator.Ninja]</div><br>"}
			else Window += {"<font color=#A30101><font size=2><div id="main"><div style="float:right">~ [T_Hours] Hour(s) & [round(_Time_Remaining_)] Minute(s) ~[A.Highest_Bid] ryo bid</div><br>"}
			Window += {"<div id="main"><div style="float:right"><a href='?src=\ref[usr]User=\ref[usr]&&Auction=\ref[A];action=Bid Now'>Bid Now</a></div><br>"}
		Window += {"<br><br><font size=3><div id="main"><div style="float:right"><a href='?src=\ref[usr];action=Black Market'>Refresh</a></div><font color=#A30101><u><a href='?src=\ref[usr];action=Auction'>Start Auction</a></u>"}
		winset(src, "Menu.Image", "image=\ref[Menu_Organizations]")
		src << output(null, "Menu.Browse")
		usr << output(Window, "Menu.Browse")
		winshow(src, "Menu.Return", 1)
		winshow(src, "Menu.Image", 1)
		winshow(src, "Menu.Browse", 1)
		winshow(src, "Menu.ExtraBackground", 1)

	Black_Market_Auction()
		set hidden = 1
		var/Reputation = input(usr, "How much reputation?", "Start Auction") as num
		if(Reputation < 10) {usr<<"<b><font color=red><u>You must auction at least 10 reputation!</u>"; return}
		Reputation = round(Reputation, 0.05)
		if(usr.Statistic.Reputation -Reputation < 0) {usr<<"<b><font color=red><u>Your reputation can't go below 0!</u>"; return}
		if(alert(usr, "Are you sure?\n\n[Reputation] Reputation will be auctioned for [Reputation*10] Ryo!", "Start Auction", "Yes", "No") == "Yes") if(alert(usr, "Really?\n\n[Reputation] Reputation will be auctioned for [Reputation*10] Ryo!", "Start Auction", "No", "Yes") == "Yes")
			if(usr.Statistic.Reputation -Reputation < 0) {usr<<"<b><font color=red><u>Your reputation can't go below 0!</u>"; return}
			usr.Statistic.Reputation -= Reputation
			new/Auction (usr.Statistic, Reputation)
			Black_Market()
			world<<"<b><font color=#A80000><font size=3><u>Auctions~ [usr.key] is auctioning [Reputation] reputation!</u>"

mob/proc
	Resize(var/G)
		if(!client) return

		if(!G)
			winset(src, "Menu", "size=900x536")
			winset(src, "Menu.MissionOutput", "pos=520x32")
			winset(src, "Menu.Participants", "pos=672x0")
			winset(src, "Menu.Begin", "pos=520x0")
			winset(src, "Menu.MissionInput", "pos=520x506")
			winset(src, "Menu.MissionBackground", "pos=520x0")
			winset(src, "Menu.Abandon", "pos=752x506")
		else
			winset(src, "Menu", "size=380x536")
			winset(src, "Menu.MissionOutput", "pos=0x32")
			winset(src, "Menu.Participants", "pos=152x0")
			winset(src, "Menu.Begin", "pos=0x0")
			winset(src, "Menu.MissionInput", "pos=0x506")
			winset(src, "Menu.MissionBackground", "pos=0x0")
			winset(src, "Menu.Abandon", "pos=232x506")

var {Menu_Organizations = 'Organizations Menu.jpg'; Menu_Villages = 'Villages Menu.jpg'; Menu_Missions = 'Missions Menu.jpg'}