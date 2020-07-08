mob/proc
	Announced (Announcement, Time, Priority)

		if(Priority && Announcement_Time > 0) return

		if(!Time)
			if(AFK) if(!findtext(Announcement, "* AFK Check.-")) return
			src << output(null, "default.Announcements")
			src << output("<b><font size=2><center>[Announcement]", "Announcements")

		else
			if(Announce_M == Announcement) return
			Announcement_Time = Time
			Announce_M = Announcement

			if(!AFK)
				src << output(null, "default.Announcements")
				src << output("<b><font size=2><center>[Announcement]</u> ([Announcement_Time])", "Announcements")

			var/Previous_Announce_M = Announce_M

			loop
				spawn(10)
					if(Announce_M != Previous_Announce_M) return
					Announcement_Time --

					if(Announcement_Time > 0) goto loop
					else if(Announcement_Time == 0)
						Announced("")
						spawn(10) if(Announce_M == Announcement) Announce_M = null


mob/verb

	Change_Chat()
		set hidden = 1
		var/_Page = winget(src, "default.button4", "text")
		if(_Page == "Global") _Page = "Village"
		else if(_Page == "Side") _Page = "Global"
		else if(_Page == "Village")
			if(!dead && name != key) _Page = "Side"
			else _Page = "Global"
		Update_Chat(_Page)

	Update_Chat(_Page as text)
		set hidden = 1
		if(!client) return
		if(isnum(Village)) {winset(src, "default.button4", "text=Global"); winset(src, "default.input1", "command=Global-Say")}
		else if(_Page == "Global") {winset(src, "default.button4", "text=Global"); winset(src, "default.input1", "command=Global-Say")}
		else if(_Page == "Village") {winset(src, "default.button4", "text=Village"); winset(src, "default.input1", "command=Village-Say")}
		else if(_Page == "Side") {winset(src, "default.button4", "text=Side"); winset(src, "default.input1", "command=Side-Say")}

mob/var
	Announcement_Time
	Announce_M






var
	list
		ADList = list("\n","games.byond","http://games.byond.com","www.byond.com/games","byond://","BYOND.world","byond: //", "NarutoNinjaWarsBrasil", "Naruto NinjaWarsBrasil", "Naruto Ninja WarsBrasil", "Naruto Ninja Wars Brasil", "NARUTONINJAWWARSBRASIL")
		ADList_ = list("games.byond","http://games.byond.com","www.byond.com/games","byond://","BYOND.world","byond: //")
mob
	var
		tmp
			LastMessage = null//Defines the last message they said
			MsgSpam = 0//The message spam, builds up when they repeat themselves
			Spam = 0//The spam, which defines how many times they've said something within a given period of time
		Mute = 0//Defines mute, so they cannot talk, REPLACE This with your mute var in your game
	proc
		CheckSpam()//Checks Spam, make sure that they are stopped in their trac
			src.Spam ++
			spawn(50)
			src.Spam -= 1

		FilterText(T as text, var/list/L)//You need to filter the text, such as the "ADList" above, so they cannot spam and ruin everyones good time :P
			for(var/O in L)//Basic for() call
				if(findtext(T,O))//Finds the message in a filter, if it is found, it will return a 1
					return 1//^|^

mob
	Dead/verb
		Observe()
			set name = "Observe"
			var/list/choose = list()
			var/Myself = "Myself"
			choose += Myself
			for(var/mob/M) if(M.client && M.name != M.key && !M.dead && M != src && M.NEM_Round && M.NEM_Round.Type != "Colosseum") choose.Add("[M.key] ~ [M.name]")
			var/mob/M = input("Which character do you want to observe?", "Observe") as null|anything in choose
			if(!M) return
			if(M == "Myself")
				if(client.eye != src) Announced("")
				client.perspective = MOB_PERSPECTIVE
				client.eye = src
			else
				Selecting = null
				if(Character_Image) del(Character_Image)
				if(Character_Image_I) del(Character_Image_I)
				if(Character_Image_II) del(Character_Image_II)
				if(Character_Image_III) del(Character_Image_III)
				var/F = findtext(M, "~")
				var/K = copytext(M, 1, F-1)
				for(var/client/C) if(C.key == K && C.mob.NEM_Round && C.mob.NEM_Round.Type != "Colosseum" && C.mob.dead == 0) {client.perspective = EYE_PERSPECTIVE; client.eye = C.mob}

	President/verb
		Observe()
			set name = "Observe"
			var/list/choose = list()
			var/Myself = "Myself"
			choose += Myself
			for(var/mob/M) if(M.client && M.name != M.key && !M.dead && M != src) choose.Add("[M.key] ~ [M.name]")
			var/mob/M = input("Which character do you want to observe?", "Observe") as null|anything in choose
			if(!M) return
			if(M == "Myself")
				if(client.eye != src) Announced("")
				client.perspective = MOB_PERSPECTIVE
				client.eye = src
			else
				Selecting = null
				if(Character_Image) del(Character_Image)
				if(Character_Image_I) del(Character_Image_I)
				if(Character_Image_II) del(Character_Image_II)
				if(Character_Image_III) del(Character_Image_III)
				var/F = findtext(M, "~")
				var/K = copytext(M, 1, F-1)
				for(var/client/C) if(C.mob && C.mob.dead == 0 && C.key == K) {client.perspective = EYE_PERSPECTIVE; client.eye = C.mob}

var/PlayersWhoVoted=0
var/Rating=0
mob/var/Voted=-1
mob/var/Voting=0
var/WelcomeMessage
mob/Dragonpearl123/verb/Welcome_Message(t as text)
	set category = "Server"
	WelcomeMessage=t

mob/verb/Introduction() Center("Introduction", 5)
mob/verb/Guide() Center("Guide", 6)
mob/verb/Rules() Center("Rules", 7)
mob/var/Who_Delay = 0

mob/verb/Who()
	if(Who_Delay == 1) return
	Who_Delay = 1
	spawn(100) Who_Delay = 0
	var/P = 0
	src<<"<b>___________________________________________________"
	src<<""

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 0 && M.Village == "Leaf" && M.Visible_Player == 1)
			src<<"<b><font color=#00FF49>{Alive} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 1 && M.Village == "Leaf" && M.Visible_Player == 1)
			src<<"<b><font color=#4EFF81>{Deceased} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 0 && M.Village == "Akatsuki" && M.Visible_Player == 1)
			src<<"<b><font color=#6A0888>{Alive} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 1 && M.Village == "Akatsuki" && M.Visible_Player == 1)
			src<<"<b><font color=#8904B1>{Deceased} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 0 && M.Village == "Red" && M.Visible_Player == 1)
			src<<"<b><font color=#FF4040>{Alive} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 1 && M.Village == "Red" && M.Visible_Player == 1)
			src<<"<b><font color=#FF4040>{Deceased} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 0 && M.Village == "Blue" && M.Visible_Player == 1)
			src<<"<b><font color=#53CCFF>{Alive} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 1 && M.Village == "Blue" && M.Visible_Player == 1)
			src<<"<b><font color=#53CCFF>{Deceased} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 0 && M.Village != "Blue" && M.Village != "Leaf" && M.Village != "Akatsuki" && M.Village != "Red" && M.Visible_Player == 1)
			src<<"<b><font color=#FFE600>{Alive} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name != M.key && M.client && M.dead == 1 &&M.Village != "Blue" && M.Village != "Leaf" && M.Village != "Akatsuki" && M.Village != "Red" && M.Visible_Player == 1)
			src<<"<b><font color=#FFEF58>{Deceased} [M.Real_Character_Name] - [M.key]"
			P++

	for(var/mob/M)
		if(M.name == M.key && M.client && M.Visible_Player == 1)
			src<<"<b><font color=gray>{Not Playing} [M.key]"
			P++

	for(var/mob/M)
		if(M.client && M.Visible_Player == 2)
			P++

			if(!M.Statistic.Wasted_Cloak)
				if(M.name != M.key) src<<"<b><font color=#A80000>{[M.Statistic.Reputation_Rank]} [M.key]- [M.name]"
				else src<<"<b><font color=#A80000>{[M.Statistic.Reputation_Rank]} [M.key]"
			else
				if(M.name != M.key) src<<"<b><font color=#A80000>{[M.Statistic.Reputation_Rank]} [M.name]"
				else src<<"<b><font color=#A80000>{[M.Statistic.Reputation_Rank]} ???"

	var/GMs_Online
	for(var/mob/M) if(M.GM) GMs_Online ++
	if(GMs_Online)
		src<<""
		src<<"<b><font color=[admin_color]><u><a href='?src=\ref[src];action=Admin Help'>* Do you need Admin Help? *</a></u>"
	else
		src<<""
		src<<"<b><font color=[admin_color]><u>* Unfortunately, there are no Staff Members online. *</u>"

	src<<""
	src<<"<b><font size=2><u>People Online: [P]</u></font>"
	src<<"<b>___________________________________________________"


mob
	verb
		Admin_Help() // Verb to talk/Asking you to type a message to the world
			if(src.GM == 1)//If they're muted they shouldn't be able to talk
				src<<output("<b><font color=red><u>Only normal players are allowed to use this command.</u></font></b>", "Chat")
				return
			if(src.Mute)//If they're muted they shouldn't be able to talk
				src<<output("<b><font color=red><u>You're muted, so you can't use this command.</u></font></b>", "Chat")
				return
			var/T=input("Please, type below your message.", "Admin Help") as null as text
			if(!T) return
			Current_Log.Add("[key] Admin Helps: [T]")
			var/P = 0
			var/Person = key
			for(var/mob/M)
				if(M.GM == 1)
					M<<output("<u><font color=[admin_color]><b>[src.key] - Admin Helps</u> [html_encode(copytext(T,1,750))] <br><a href='?src=\ref[src];action=Reply Admin Help;User=[Person]'><i>* Reply</i></a></b></font>", "Chat")
					P++
			if(P > 1) src<<output("<font size=2><b><font color=[admin_color]><i>You've successfully sent your message to [P] Admins.</i>", "Chat")
			if(P == 1) src<<output("<font size=2><b><font color=[admin_color]><i>You've successfully sent your message to [P] Admin.</i>", "Chat")
			if(P == 0) src<<output("<font size=2><b><font color=[admin_color]><i>We apologize, there are no Admins online now.</i>", "Chat")

mob
	verb

		Village_Say(t as text)
			if(!t || !Statistic._Village_) return
			if(NEM_Round.Type == "Colosseum") {Global_Say(t); return}
			if(Mute) {src<<"<b><font color=red>You're muted, you can't talk.</b>"; return}
			if(!OOC_Chat) {src<<"<b><font color=red>We're sorry, but the Chat is disabled!"; return}
			if(src.Spam > 5)
				Mute = 1
				Mute_Time = 15*60
				Statistic.Times_Muted ++
				world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 15 minutes!</u></font>","Chat")
				file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 15 minutes!"
				return
			if(src.Spam > 5) src<<output("<font color=[admin_color]><b><u>Stop spamming, or you'll be muted!</u>","Chat")
			if(FilterText(t,ADList)) return

			if(t == LastMessage)
				Repetitive ++
				spawn(30) Repetitive --
				if(Repetitive > 1)
					Mute = 1
					Mute_Time = 3*60
					Statistic.Times_Muted ++
					world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 3 minutes!</u></font>","Chat")
					file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 3 minutes!"
					return
				else src<<"<b><font color=[admin_color]><u>Do not repeat the message you wrote before!</u>"

			LastMessage = t
			var/Old_Message = LastMessage
			spawn(100) if(LastMessage == Old_Message) LastMessage = null

			Current_Log.Add("[key] Village Says: [t]")
			t = "<font color=#3874BF><b>-[Statistic.Rank], [key]- Village Says:</b><font color=#5484BE> [html_encode(copytext(t,1,500))]"
			for(var/mob/M in Statistic._Village_._Members) if(M.client)
				if(!GM) if(M.Ignoring.Find(key) || M.Ignoring.Find("*[client.computer_id]")) continue
				M<<output("[t]","Chat")
			if(ismob(Dragonpearl123) && Dragonpearl123.Statistic._Village_ != Statistic._Village_) Dragonpearl123 << t
			CheckSpam()

		Side_Say(t as text)
			if(!t) return
			if(NEM_Round.Type == "Colosseum") {Global_Say(t); return}
			if(Mute) {src<<"<b><font color=red>You're muted, you can't talk.</b>"; return}
			if(!OOC_Chat) {src<<output("<b><font color=red>We're sorry, but the Chat is disabled!","Chat"); return}
			if(!Village || dead || NEM_Round.Mode == "Challenge" || isnum(Village))
				Global_Say(t)
				return
			if(src.Spam > 5)
				Mute = 1
				Mute_Time = 15*60
				Statistic.Times_Muted ++
				world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 15 minutes!</u></font>","Chat")
				file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 15 minutes!"
				return
			if(src.Spam > 5) src<<output("<font color=[admin_color]><b><u>Stop spamming, or you'll be muted!</u>","Chat")
			if(FilterText(t,ADList)) return

			if(t == LastMessage)
				Repetitive ++
				spawn(30) Repetitive --
				if(Repetitive > 1)
					Mute = 1
					Mute_Time = 3*60
					Statistic.Times_Muted ++
					world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 3 minutes!</u></font>","Chat")
					file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 3 minutes!"
					return
				else src<<"<b><font color=[admin_color]><u>Do not repeat the message you wrote before!</u>"

			LastMessage = t
			var/Old_Message = LastMessage
			spawn(100) if(LastMessage == Old_Message) LastMessage = null

			Current_Log.Add("[key] Side Says: [t]")
			if(name!=key&&Village=="Leaf")t = "<font color=#00FF49><b>-[Statistic.Rank], [name]- Side Says:<font color=#4EFF81></b> [html_encode(copytext(t,1,500))]"//This is here because, well, we want the t var to be saved with the 500 letters and html encoded
			if(name!=key&&Village=="Akatsuki")t = "<font color=#6A0888><b>-[Statistic.Rank], [name]- Side Says:<font color=#8904B1></b> [html_encode(copytext(t,1,500))]"//This is here because, well, we want the t var to be saved with the 500 letters and html encoded
			if(name!=key&&Village=="Blue")t = "<font color=#53CCFF><b>-[Statistic.Rank], [name]- Side Says:</b> [html_encode(copytext(t,1,500))]"//This is here because, well, we want the t var to be saved with the 500 letters and html encoded
			if(name!=key&&Village=="Red")t = "<font color=#FF4040><b>-[Statistic.Rank], [name]- Side Says:</b> [html_encode(copytext(t,1,500))]"//This is here because, well, we want the t var to be saved with the 500 letters and html encoded
			if(name!=key&&Village=="Good")t = "<font color=#FF4040><b>-[Statistic.Rank], [name]- Side Says:</b> [html_encode(copytext(t,1,500))]"//This is here because, well, we want the t var to be saved with the 500 letters and html encoded
			if(NEM_Round.Type == "King Of The Hill") t = "<font color=#F06D6D><b>-[Statistic.Rank], [name]- Side Says:</b> [html_encode(copytext(t,1,500))]"
			for(var/mob/M)
				if(M.client && M.Village == Village)
					if(!GM) if(M.Ignoring.Find(key) || M.Ignoring.Find("*[client.computer_id]")) continue
					M<<output("[t]","Chat")
			if(ismob(Dragonpearl123) && Dragonpearl123.Village != src.Village) Dragonpearl123<<output("[t]", "Chat")
			CheckSpam()

		Global_Say(T as text)
			if(!T) return
			if(Functions(T) || T == "/server") return
			if(findtext(T, "/", 1, 2)) {src<<""; src<<"<b><font color=#7A000A><u><font size=2><br>Functions.</u><br><font size=1><font color=#A2000E>- Menu <font color=#B2000F>/menu<br><font color=#A2000E>- Arena <font color=#B2000F>/arena<br><font color=#A2000E>- Ignore <font color=#B2000F>/ignore<br><font color=#A2000E>- UnIgnore <font color=#B2000F>/unignore<br><font color=#A2000E>- Ignoring <font color=#B2000F>/ignoring"; if(GM) src<<""; if(GM) src<<"<font color=#A2000E><b>- Server <font color=#B2000F>/server<br><font color=#A2000E>- AFK Check <font color=#B2000F>/afk-check"; src<<""; return}

			if(Mute)
				src<<"<b><font color=red>You're muted, you can't talk.</b>"
				return
			if(src.Spam > 5)
				Mute = 1
				Mute_Time = 15*60
				Statistic.Times_Muted ++
				world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 15 minutes!</u></font>","Chat")
				file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 15 minutes!"
				return
			if(Spam > 4) src<<output("<font color=red><b>Stop spamming, or you'll be muted!","Chat")
			if(FilterText(T,ADList)) return
			Current_Log.Add("[key] Global Says: [T]")


			if(T == LastMessage)
				Repetitive ++
				spawn(30) Repetitive --
				if(Repetitive > 1)
					Mute = 1
					Mute_Time = 3*60
					Statistic.Times_Muted ++
					if(!GM) world<<output("<font color=[admin_color]><b><u>[key] has been automatically muted for 3 minutes!</u></font>","Chat")
					file("Logs/Players/[Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[key] has been automatically muted for 3 minutes!"
					return
				else src<<"<b><font color=[admin_color]><u>Do not repeat the message you wrote before!</u>"

			LastMessage = T
			var/Old_Message = LastMessage
			spawn(100) if(LastMessage == Old_Message) LastMessage = null
			if(!Statistic.Reputation_Rank) Statistic.Reputation_Rank()

			if(isnum(Village) || !Village && name != key || Village == "Good")
				if(NEM_Round.Type == "Colosseum")
					if(!Statistic.Cloaks)
						if(name != key) T= "<font color=#FEE176><b>{[Statistic.Reputation_Rank]} [key]- [name]: <font color=#FDECAD>[html_encode(copytext(T,1,500))]"
						else T= "<font color=#8C7C40><b>{[Statistic.Reputation_Rank]} [key]: <font color=#8A8265>[html_encode(copytext(T,1,500))]"
					else
						if(name != key) T= "<font color=#FEE176><b>{[Statistic.Reputation_Rank]} [name]: <font color=#FDECAD>[html_encode(copytext(T,1,500))]"
						else T= "<font color=#8C7C40><b>{[Statistic.Reputation_Rank]} ???: <font color=#8A8265>[html_encode(copytext(T,1,500))]"
				else
					if(!dead) T= "<font color=#FEE176><b>{[Statistic.Rank], None} [key]- [name]: <font color=#FDECAD>[html_encode(copytext(T,1,500))]"
					if(dead) T= "<font color=#8C7C40><b>{[Statistic.Rank], None} [key]- [name]: <font color=#8A8265>[html_encode(copytext(T,1,500))]"
			else
				if(NEM_Round.Type == "Colosseum")
					if(!Statistic.Cloaks)
						if(name != key) T= "<font color=#FEE176><b>{[Statistic.Reputation_Rank]} [key]- [name]: <font color=#FDECAD>[html_encode(copytext(T,1,500))]"
						else T= "<font color=#8C7C40><b>{[Statistic.Reputation_Rank]} [key]: <font color=#8A8265>[html_encode(copytext(T,1,500))]"
					else
						if(name != key) T= "<font color=#FEE176><b>{[Statistic.Reputation_Rank]} [name]: <font color=#FDECAD>[html_encode(copytext(T,1,500))]"
						else T= "<font color=#8C7C40><b>{[Statistic.Reputation_Rank]} ???: <font color=#8A8265>[html_encode(copytext(T,1,500))]"
				else
					if(name != key && !dead && Statistic._Village_) T= "<font color=#FEE176><b>{[Statistic._Village_.Name] - [Statistic.Rank], [Village]} [key]- [name]: <font color=#FDECAD>[html_encode(copytext(T,1,500))]"
					else if(name != key && dead && Statistic._Village_) T= "<font color=#8C7C40><b>{[Statistic._Village_.Name] - [Statistic.Rank], [Village]} [key]- [name]: <font color=#8A8265>[html_encode(copytext(T,1,500))]"
					else if(name == key && Statistic._Village_) T= "<font color=#8C7C40><b>{[Statistic._Village_.Name] - [Statistic.Rank], None} [key]: <font color=#8A8265>[html_encode(copytext(T,1,500))]"
					else if(name != key && !dead) T= "<font color=#FEE176><b>{[Statistic.Rank], [Village]} [key]- [name]: <font color=#FDECAD>[html_encode(copytext(T,1,500))]"
					else if(name != key && dead) T= "<font color=#8C7C40><b>{[Statistic.Rank], [Village]} [key]- [name]: <font color=#8A8265>[html_encode(copytext(T,1,500))]"
					else if(name == key) T= "<font color=#8C7C40><b>{[Statistic.Rank], None} [key]: <font color=#8A8265>[html_encode(copytext(T,1,500))]"

			for(var/mob/P)
				if(P.client && P.Ignoring.Find(key) || P.Ignoring.Find("*[client.computer_id]")) continue
				P<<"[T]"
			CheckSpam()

mob/proc
	Functions(T)
		if(T == "/functions" || T == "/Functions" || T == "/help") {src<<""; src<<"<b><font color=#7A000A><u><font size=2><br>Functions.</u><br><font size=1><font color=#A2000E>- Menu <font color=#B2000F>/menu<br><font color=#A2000E>- Arena <font color=#B2000F>/arena<br><font color=#A2000E>- Ignore <font color=#B2000F>/ignore<br><font color=#A2000E>- UnIgnore <font color=#B2000F>/unignore<br><font color=#A2000E>- Ignoring <font color=#B2000F>/ignoring"; if(GM) src<<""; if(GM) src<<"<font color=#A2000E><b>- Server <font color=#B2000F>/server<br><font color=#A2000E>- AFK Check <font color=#B2000F>/afk-check"; src<<""; return 1}
		else if(T == "/menu" || T == "/Menu") {Menu(); return 1}
		else if(T == "/arena" || T == "/Arena") {Arena(); return 1}
		else if(T == "/server" || T == "/Server") {if(GM) Server()}
		else if(T == "/afk-check" || T == "/Afk-check") {if(GM) AFK_Check(); return 1}
		else if(findtext(T, "/ignore", 1, 8))
			var/To_Ignore = copytext(T, 9)
			if(To_Ignore == "Dragonpearl123" || To_Ignore == "SilentWraith" || To_Ignore == key) return 1
			if(To_Ignore)  Ignore(To_Ignore, 1)
			return 1
		else if(findtext(T, "/unignore", 1, 10))
			var/To_Ignore = copytext(T, 11)
			if(To_Ignore == "Dragonpearl123" || To_Ignore == "SilentWraith" || To_Ignore == key) return 1
			if(To_Ignore) Ignore(To_Ignore)
			return 1
		else if(findtext(T, "/ignoring", 1, 10))
			var/_I = "None"
			for(var/S in Ignoring) {if(findtext(S, "*", 1)) continue; else {if(_I == "None") _I = S; else _I += ", [S]"}}
			src<<"<b><font color=#7A000A><u><font size=2><br>Ignoring:</u> <font size=1><font color=#A2000E>[_I]"
			return 1

	Ignore(T, C)
		if(C)
			if(Ignoring.Find(T)) {src<<"<b><font color=#B2000F><u>You are already ignoring [T]!</u>"; return}
			for(var/Personal_Log/S in Personal_Logs) if(S.Name == T) {Ignoring.Add(T); for(var/CI in S.CIs) {if(CI == client.computer_id) continue; Ignoring.Remove("*[CI]"); Ignoring.Add("*[CI]")}; src<<"<b><font color=#B2000F><u>You will no longer receive [T]'s messages!</u>"; return; break}
			src<<"<b><font color=#B2000F><u>This person does not exist in the Database!</u>"
		else
			if(!Ignoring.Find(T)) {src<<"<b><font color=#B2000F><u>You are not ignoring [T]!</u>"; return}
			var/_F
			for(var/S in Ignoring)
				if(_F) {if(findtext(S, "*", 1)) Ignoring.Remove(S); else {return}}
				else if(S == T) {Ignoring.Remove(S); src<<"<b><font color=#B2000F><u>You will now receive [T]'s messages!</u>"; _F = 1}


mob
	Dragonpearl123
		verb/Troll(mob/M in world)
			var/Text = input("What text?", "Troll") as text
			var/T
			if(isnum(M.Village) || !M.Village && M.name != M.key)
				if(!M.dead) T= "<font color=#FEE176><b>{[M.Statistic.Rank], None} [M.key]- [M.name]: <font color=#FDECAD>[Text]"
				if(M.dead) T= "<font color=#8C7C40><b>{[M.Statistic.Rank], None} [M.key]- [M.name]: <font color=#8A8265>[Text]"
			else
				if(M.name != M.key && !M.dead && M.Statistic._Village_) T= "<font color=#FEE176><b>{[M.Statistic._Village_.Name] - [M.Statistic.Rank], [M.Village]} [M.key]- [M.name]: <font color=#FDECAD>[Text]"
				else if(M.name != M.key && M.dead && M.Statistic._Village_) T= "<font color=#8C7C40><b>{[M.Statistic._Village_.Name] - [M.Statistic.Rank], [M.Village]} [M.key]- [M.name]: <font color=#8A8265>[Text]"
				else if(M.name == M.key && M.Statistic._Village_) T= "<font color=#8C7C40><b>{[M.Statistic._Village_.Name] - [M.Statistic.Rank], None} [M.key]: <font color=#8A8265>[Text]"
				else if(M.name != M.key && !M.dead) T= "<font color=#FEE176><b>{[M.Statistic.Rank], [M.Village]} [M.key]- [M.name]: <font color=#FDECAD>[Text]"
				else if(M.name != M.key && M.dead) T= "<font color=#8C7C40><b>{[M.Statistic.Rank], [M.Village]} [M.key]- [M.name]: <font color=#8A8265>[Text]"
				else if(M.name == M.key) T= "<font color=#8C7C40><b>{[M.Statistic.Rank], None} [M.key]: <font color=#8A8265>[Text]"
			if(Text) world<<"[T]"

mob/var/Repetitive
mob/var/GM_Rank