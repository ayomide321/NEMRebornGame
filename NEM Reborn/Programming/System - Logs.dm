var
	list/Logs = list()
	list/Admin_Logs = list()
	list/Personal_Logs = list()
	Log/Current_Log

mob/var
	tmp/Log/C_Log
	tmp/Admin_Log/Admin_Log
	tmp/Personal_Log/Personal_Log

proc/Check_Log()
	loop
		world.tick_lag = 0.40 +(world.cpu/2000)
		var/Date = time2text(world.timeofday, "Month ~Day #DD")
		if(!Current_Log || Current_Log.Name != Date)
			for(var/Alliance/A in Alliances) A.Update_Village()
			new/Log (Date)
		spawn(300) goto loop

Personal_Log
	var
		Name
		list/IPs = list()
		list/CIs = list()

	New(mob/Creator)
		..()
		if(Creator)
			Creator.Personal_Log = src
			Personal_Logs.Add(src)
			Name = Creator.key

	proc

		Show()
			usr.C_Log = src

			var/_IPs
			for(var/N in IPs)
				if(!_IPs) _IPs = N
				else _IPs += ", [N]"

			var/_CIs
			for(var/N in CIs)
				if(!_CIs) _CIs = N
				else _CIs += ", [N]"

			var/Text = file2text("Logs/Players/[Name].txt")
			var/Window = {"<html><body><font color=white><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=2>*Computer ID(s): [_CIs]<br>*IP(s): [_IPs]<br><a href='?src=\ref[src];action=Investigate;Log=\ref[src]'>Investigate!</a><br>[Text]"}
			winset(usr, "Player_Log.World_Log_Name", "text=\"[Name]\"")
			usr << output(null, "Player_Log.Log_Browse")
			usr << output(Window, "Player_Log.Log_Browse")
			usr.Center("Player_Log", 8)

Admin_Log
	var
		Name

	New(mob/Creator)
		..()
		if(Creator)
			Admin_Logs.Add(src)
			Creator.Admin_Log = src
			Name = Creator.key
		spawn() if(!Name)
			Admin_Logs.Remove(src)
			del(src)

	proc

		Show()
			usr.C_Log = src
			var/Text = file2text("Logs/Admins/[Name].txt")
			var/Window = {"<html><body><font color=white><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=2>[Text]"}
			winset(usr, "Admin_Log.World_Log_Name", "text=\"[Name]\"")
			usr << output(null, "Admin_Log.Log_Browse")
			usr << output(Window, "Admin_Log.Log_Browse")
			usr.Center("Admin_Log", 8)

Log
	var
		Name

	New(_Name)
		..()
		if(_Name) Name = _Name
		Current_Log = src
		Logs.Add(src)

	proc
		Add(T, G)
			file("Logs/Global/[Name].txt") << "<br><font color=#FFFAC0>/[time2text(world.timeofday, "hh:mm:ss")]/<font color=white> [html_encode(T)]"
			if(G) file("Logs/Admins/[usr.Admin_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- [html_encode(T)]"
			else file("Logs/Players/[usr.Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- [html_encode(T)]"

		Show()
			usr.C_Log = src
			var/Text = file2text("Logs/Global/[Name].txt")
			var/Window = {"<html><body><font color=white><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=2>[Text]"}
			winset(usr, "World_Log.World_Log_Name", "text=\"[Name]\"")
			usr << output(null, "World_Log.Log_Browse")
			usr << output(Window, "World_Log.Log_Browse")
			usr.Center("World_Log", 8)

mob/verb
	Admin_Log()
		set hidden = 1
		for(var/Admin_Log/A in Admin_Logs)
			A.Show(src)
			return

	Logs()
		Center("Logs", 5)

	General_Log()
		set hidden = 1
		if(!GM)
			src<<"<b><font color=red>You have no access to General Log!"
			return
		else Current_Log.Show(src)

	Player_Log()
		set hidden = 1
		if(!GM)
			src<<"<b><font color=red>You have no access to Player Log!"
			return
		else
			var/Player = input("Type below the player's key", "Player Log") as text
			if(!Player) return
			for(var/Personal_Log/L in Personal_Logs) if(L.Name == Player)
				L.Show(src)
				return
			src<<"<b><font color=red><u>[Player]'s Log doesn't exist in the Database!"

	Next_Log_Admin()
		set hidden = 1

		for(var/Admin_Log/L in Admin_Logs)
			if(!C_Log)
				L.Show(src)
				return
			if(L == C_Log) C_Log = null
		if(!C_Log) for(var/Admin_Log/L in Admin_Logs) if(!C_Log) L.Show(src)


	Previous_Log_Admin()
		set hidden = 1
		var/Admin_Log/P_Log

		for(var/Admin_Log/L in Admin_Logs)
			if(L == C_Log)
				if(P_Log) P_Log.Show(src)
				else
					for(var/Admin_Log/Last in Admin_Logs) P_Log = Last
					P_Log.Show(src)
				return

			else P_Log = L

mob/Dragonpearl123/verb
	Update_Pills()
		set category = "Server"
		if(alert(src, "Are you sure?", "Update Pills", "No", "Yes") == "Yes")
			for(var/Alliance/A in Alliances) A.Update_Village()
	Delete_Errors()
		set category = "Server"
		if(alert(src, "Are you sure?", "Delete Errors", "No", "Yes") == "Yes") {fdel("NEM Errors.txt")}

mob/President/verb
	Justify()
		set category = "Server"
		var/J = input("You're about to leave a note on your Admin Log.\nRemember you can't undo this!", "Justify Admin Action") as text
		if(!J) return
		if(alert(src, "Are you sure?\n\n\"[J]\"", "Justify Admin Action", "No", "Yes") == "Yes")
			file("Logs/Admins/[Admin_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] justified: [J]"
			Current_Log.Add("*[key] justified something on his Admin Log.")
	Next_Log()
		set hidden = 1

		for(var/Log/L in Logs)
			if(!C_Log)
				L.Show(src)
				return
			if(L == C_Log) C_Log = null
		if(!C_Log) for(var/Log/L in Logs) if(!C_Log) L.Show(src)


	Previous_Log()
		set hidden = 1
		var/Log/P_Log

		for(var/Log/L in Logs)
			if(L == C_Log)
				if(P_Log) P_Log.Show(src)
				else
					for(var/Log/Last in Logs) P_Log = Last
					P_Log.Show(src)
				return

			else P_Log = L

mob/proc/Update_Log()
	var/CI
	var/IP
	if(Personal_Log.CIs.Find(client.computer_id)) CI ++
	if(Personal_Log.IPs.Find(client.address)) IP ++
	if(!CI) Personal_Log.CIs.Add(client.computer_id)
	if(!IP) Personal_Log.IPs.Add(client.address)