mob/var/Chatroom/Chatroom
var/list/Active_Chatrooms = list()

Chatroom
	var {mob/Leader; Name; Password; list/Members = list()}

	New(N, mob/C)
		Name = N
		Join(C)
		Active_Chatrooms.Add(src)
		Leader = C
		winshow(C, "Chatroom.Password", 1)

	proc/Join(mob/M)
		M<<output(null, "Chatroom.Output")
		M.Center("Chatroom")
		M.Chatroom = src
		Members.Remove(M)
		Members.Add(M)
		Rank(M)
		Members << output("<font color=#BABABA><b><u>[M.key] has joined!</u>", "Chatroom.Output")

	proc/Leave(mob/M, var/X)
		Members << output("<font color=#BABABA><b><u>[M.key] has left!</u>", "Chatroom.Output")
		M.Chatroom = null
		Members.Remove(M)
		if(length(Members) == 0) {Active_Chatrooms.Remove(src); del(src)}
		else if(length(Members) == 1 && !X) for(var/mob/G in Members) {Rank(G, "Leader"); break; return}
		if(M.client) winshow(M, "Chatroom", 0)

	proc/Rank(mob/M, var/G)
		if(G) {Leader = M; winshow(M, "Chatroom.Password", 1); Members << output("<font color=#BABABA><b><u>[M.key] is now the Master!</u>", "Chatroom.Output")}
		else winshow(M, "Chatroom.Password", 0)


mob
	proc
		Chatroom_Password_(Chatroom/C)
			set hidden = 1
			if(Menu() == 0 || !C) return
			var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Chatroom Password *</center></u><font size=4><br>"}
			Window += {"<br><u><font size=3>What is the password?</u><br><br><br><a href='?src=\ref[src];action=Chatroom Password;Chatroom=\ref[C]'>Join</a>"}
			src << output(null, "Menu.Browse")
			src << output(Window, "Menu.Browse")
			winset(src, "Menu.Image", "image=\ref[Menu_Missions]")
			winset(src, "Menu.Statistic", "text=")
			winshow(src, "Menu.Statistic", 1)
			winshow(src, "Menu.Return", 1)
			winshow(src, "Menu.Image", 1)
			winshow(src, "Menu.Browse", 1)
			winshow(src, "Menu.ExtraBackground", 1)

	verb
		Chatroom_Close()
			set hidden = 1
			winshow(src, "Chatroom", 0)
			if(!Chatroom) return
			Chatroom.Leave(src)

		Chatroom_Who()
			set hidden = 1
			if(!Chatroom) return
			src<<output("<br>", "Chatroom.Output")
			src<<output("<font size=2><b><font color=#9E9E9E><u>* Who *</u>", "Chatroom.Output")
			for(var/mob/M in Chatroom.Members)
				if(Chatroom.Leader == src && M != src) src<<output("<font size=1><b><font color=#BABABA><a href='?src=\ref[src];action=Boot Chatroom;To Kick=\ref[M]'>Boot</a> - [M.key]", "Chatroom.Output")
				else src<<output("<font size=1><b><font color=#BABABA>[M.key]", "Chatroom.Output")
			src<<output("<br>", "Chatroom.Output")

		Chatroom_Password()
			set hidden = 1
			if(Menu() == 0 || !Chatroom || Chatroom.Leader != src) return
			var/Window = {"<html><body><style = \"text/css\">body { background-color:black} </style></body></html><b><font size=6><u><center><font color=#7E0F0F>* Chatroom Password *</center></u><font size=4><br>"}
			Window += {"<br><u><font size=3>Type below the password.</u><br><br><br><a href='?src=\ref[usr];action=Change Chatroom Password'>Set</a>"}
			src << output(null, "Menu.Browse")
			src << output(Window, "Menu.Browse")
			winset(src, "Menu.Image", "image=\ref[Menu_Missions]")
			winset(src, "Menu.Statistic", "text=")
			winshow(src, "Menu.Statistic", 1)
			winshow(src, "Menu.Return", 1)
			winshow(src, "Menu.Image", 1)
			winshow(src, "Menu.Browse", 1)
			winshow(src, "Menu.ExtraBackground", 1)

		Chatroom_Say(T as text)
			set hidden = 1
			if(!T || T == " " || T == "  " || T == "   ") return
			if(Mute) {src<<output("<font size=1><b><font color=#BABABA><u>You're muted, you can't talk.</u></b>", "Chatroom.Output"); return}
			if(Spam > 5) {Mute = 1; Mute_Time = 15*60; Statistic.Times_Muted ++; Chatroom.Members<<output("<font size=1><font color=#BABABA><b><u>[key] has been automatically muted for 15 minutes!</u>", "Chatroom.Output"); world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 15 minutes!</u></font>","Chat"); file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 15 minutes!"; return}
			if(Spam > 4) src<<output("<font size=1><font color=#BABABA><b><u>Stop spamming, or you'll be muted!</u>", "Chatroom.Output")
			if(FilterText(T,ADList)) return
			Current_Log.Add("[key] Chatroom Says: [T]")


			if(T == LastMessage)
				Repetitive ++
				spawn(30) Repetitive --
				if(Repetitive > 1) {Mute = 1; Mute_Time = 3*60; Statistic.Times_Muted ++; Chatroom.Members<<output("<font size=1><font color=#BABABA><b><u>[key] has been automatically muted for 3 minutes!</u></font>", "Chatroom.Output"); world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 3 minutes!</u></font>", "Chat"); file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 3 minutes!"; return}
				else src<<output("<font size=1><b><font color=#BABABA><u>Do not repeat the message you wrote before!</u>", "Chatroom.Output")

			LastMessage = T
			var/Old_Message = LastMessage
			spawn(100) if(LastMessage == Old_Message) LastMessage = null
			Chatroom.Members<<output("<font size=1><b><font color=#9E9E9E><font size=1><u>[key]:</u><font color=#BABABA> [html_encode(copytext(T,1,500))]", "Chatroom.Output")
			CheckSpam()
			if(ismob(Dragonpearl123)) Dragonpearl123<<"<b><font color=#9E9E9E><u>[key] Chatroom Says:</u><font color=#BABABA> [html_encode(copytext(T,1,500))]"