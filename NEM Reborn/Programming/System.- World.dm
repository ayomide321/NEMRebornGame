client/fps = 100
client/tick_lag = 0

var/list/Round_CIs = list()
mob/var/ByPass = 1
mob/var/Body_Real = 0
mob/var/Body_Next = 1
mob/var/Multikeying = 1
var/list/Players_NEM = list()
client/pixel_x = 51

mob/Dragonpearl123/verb
	Get_Files()
		set category = "Server"
		var/Q = input(src, "What files?", "Get Files") as null | anything in list ("Players", "Errors")
		if(Q == "Players") src << ftp("NEM Players.txt")
		if(Q == "Errors") src << ftp("NEM Errors.txt")

client/New()
	..()

	winset(src, null, "reset=true")
	if(mob.NEM_Round) if(mob.NEM_Round.Mode == "Arena") {Current_NEM_Round.Join(mob); mob.Respawn(1)}
	if(findtext(key, "Guest-"))
		src<<"<b><font color=red><u>Guest Keys are no longer allowed!</u>"
		del(src)
	var/Newbie = 1
	if(Players_NEM.Find(key)) Newbie --
	if(Newbie)
		Players_+="<font color=white><font size=2><br> - {([computer_id]) [address]} - [mob.key]</font size></font color>"
		Players_NEM.Add(key)
		banlistsave()
	var/Display_Log = 1
	if(Real_Owner.Find(mob.key)) {Display_Log = 0; Dragonpearl123 = mob}
	if(Display_Log == 1) file("NEM Players.txt") << "{([computer_id]) [address]} - [mob.key]"
	if(Bans.Find(mob.key) || Bans.Find(address) || Bans.Find(computer_id) || GlobalBanList.Find(mob.key) || GlobalBanList.Find(address) || GlobalBanList.Find(computer_id)) del mob.client
	if(mob.CheckGlobalBan()) del mob.client
	var/_K
	if(Real_Owner.Find(key)) _K = 1
	if(Round_CIs.Find(computer_id) && !_K)
		if(mob.Multikeying)
			mob<<output("","Chat")
			mob<<output("<b><font color=#9A0202><center>* No multikeying allowed! *","Chat")
			mob<<output("","Chat")
			del mob.client

	if(mob.Chakra_Time <= 0) winset(src, "default.Chakra_Label", "is-visible=false")
	if(mob.Poison <= 0) winset(src, "default.Poison_Label", "is-visible=false")
	if(!mob.Absorbed)
		perspective = MOB_PERSPECTIVE
		eye = mob

	if(Allow_New_Users == 0 && mob.Body_Next == 1)
		mob.freeze = 100
		mob.CanMove = 0
		mob.CanChoose = 0
		mob.CreatedAVotation = 1
		mob.loc = locate(278, 10, 2)
		mob.set_pos((mob.x*32)+44, (mob.y*32)+8)
		mob.On_Special_Character_Screen = 1

	var/Announced = 0

	if(Hanabi_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Hanabi/verb)
	if(Torune_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Torune_X/verb)
	if(Yagura_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Kira35/verb)
	if(Kushimaru_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Quay400/verb)
	if(Chikushodo_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Doom_Chikushodo/verb)
	if(Lord_Itachi_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Lord_Itachi/verb)
	if(Special_ANBU_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Skittlz/verb)
	if(Rinnegan_Tobi_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Quay401/verb)
	if(Eternal_Sasuke_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Akken/verb)
	if(Minato_Namikaze_Owners.Find(mob.key)) mob.verbs += typesof(/mob/Doom3/verb)

	if(mob.key == "X-SoulEater-X") mob.verbs += typesof(/mob/Doom_Chikushodo/verb)
	if(mob.key == "SuperSSTrunks") mob.verbs += typesof(/mob/SuperSS/verb)
	if(mob.key == "Maelo uchiha" || mob.key == "OXuchihaXO") mob.verbs += typesof(/mob/Kabuchimaru/verb)
	if(mob.key == "Akken")
		mob.verbs += typesof(/mob/Doom_Chikushodo/verb)
		mob.verbs += typesof(/mob/Quay401/verb)
		mob.verbs += typesof(/mob/Quay400/verb)
		mob.verbs += typesof(/mob/Akken/verb)
		mob.verbs += typesof(/mob/Kira35/verb)
	if(Real_Owner.Find(mob.key))
		mob.Visible_Player = 0
		if(mob.key == "Dragonpearl123")
			mob.verbs+=typesof(/mob/Kabuchimaru/verb)
			world<<"<b>- {Owner} Dragon Pearl has logged in! -</b>"
			mob.Visible_Player = 1
			mob.GM_Rank = "Owner"
		Announced = 1
		mob.GM = 1
		mob.verbs += typesof(/mob/Dragonpearl123/verb)

		if(mob.key == "SilentWraith")
			mob.verbs+=typesof(/mob/Kabuchimaru/verb)
			world<<"<b>- {Owner} Silent has logged in! -</b>"
			mob.Visible_Player = 1
			mob.GM_Rank = "Owner"
		Announced = 1
		mob.GM = 1
		mob.verbs += typesof(/mob/Dragonpearl123/verb)

		if(mob.key == "Eternal Memories")
			mob.verbs+=typesof(/mob/Kabuchimaru/verb)
			world<<"<b>- {Game Creator} Eternal has logged in! -</b>"
			mob.Visible_Player = 1
			mob.GM_Rank = "Game Creator"
		Announced = 1
		mob.GM = 1
		mob.verbs += typesof(/mob/Dragonpearl123/verb)

	if(Real_Owner.Find(mob.key)) mob.verbs+=typesof(/mob/Special_Ban/verb)
	if(mob.key == "Doom2u" || Real_Owner.Find(mob.key))
		if(mob.key == "Doom2u") mob.verbs+=typesof(/mob/Skittlz/verb)
		mob.verbs+=typesof(/mob/Lord_Itachi/verb)
	if(mob.key == "XxKnightmarexX" || mob.key == "Exodia2000") mob.verbs+=typesof(/mob/Skittlz/verb)
	if(Real_Owner.Find(mob.key) || mob.key == "Dopenaruto") mob.verbs+=typesof(/mob/Hanabi/verb)
	if(mob.key == "Deathmall" || mob.key == "Taoren22") mob.verbs+=typesof(/mob/Doom3/verb)
	if(mob.key == "CHI-TOWN_-OUTLAW") mob.verbs+=typesof(/mob/Doom_Chikushodo/verb)
	if(mob.key == "Deathmall" || mob.key == "Xlordkiller")
		mob.verbs+=typesof(/mob/ANBU_Kakashi/verb)
	if(mob.key == "KiloJay" || Real_Owner.Find(mob.key))
		mob.verbs+=typesof(/mob/ANBU_Kakashi/verb)
		mob.verbs+=typesof(/mob/Quay401/verb)
		mob.verbs+=typesof(/mob/Torune_X/verb)
	if(Real_Owner.Find(mob.key))
		mob.CanHearAll = 1
		mob.verbs+=typesof(/mob/Eternal/verb)
		mob.verbs+=typesof(/mob/President/verb)
		mob.GM = 1
	if(mob.key == "Satomi_Hadaru") mob.verbs+=typesof(/mob/Skittlz/verb)
	if(mob.key == "Skittl3zzz" || Real_Owner.Find(mob.key) || mob.key == "Yolo_kingry")
		mob.verbs+=typesof(/mob/Skittlz/verb)
		mob.verbs+=typesof(/mob/Quay400/verb)
		mob.verbs+=typesof(/mob/Quay401/verb)
	if(mob.key == "PtvKiraSuicide" || Real_Owner.Find(mob.key))
		mob.verbs+=typesof(/mob/Lord_Itachi/verb)
		mob.verbs+=typesof(/mob/Kabuchimaru/verb)
		mob.verbs+=typesof(/mob/Kira35/verb)
		mob.verbs+=typesof(/mob/ANBU_Kakashi/verb)
		mob.verbs+=typesof(/mob/Torune_X/verb)
	if(mob.key == "GirlOnWater") mob.verbs+=typesof(/mob/Lord_Itachi/verb)
	if(mob.key == "Googlemyrio")
		mob.verbs+=typesof(/mob/Lord_Itachi/verb)
	if(mob.key == "MuraHoshi") mob.verbs+=typesof(/mob/Doom3/verb)
	if(mob.key == "Googlemystat")
		mob.verbs+=typesof(/mob/Quay401/verb)
		mob.verbs+=typesof(/mob/Skittlz/verb)
		mob.verbs+=typesof(/mob/Google_Stat/verb)
	if(mob.key == "Yolo_kingry" || key == "Bakumatsu")
		mob.verbs+=typesof(/mob/Quay400/verb)
		mob.verbs+=typesof(/mob/Quay401/verb)
	if(Real_Owner.Find(mob.key) || key == "Doom2u")
		mob.verbs+=typesof(/mob/Doom/verb)
		mob.verbs+=typesof(/mob/Doom2/verb)
		mob.verbs+=typesof(/mob/Quay400/verb)
		mob.verbs+=typesof(/mob/Quay401/verb)
	if(mob.key == "Thedarkking25") mob.verbs+=typesof(/mob/Doom_Chikushodo/verb)
	if(mob.key in list ("Kek'd9123", "Pine Real", "Pine96", "Johunser", "Seriak"))
		if(!Announced)
			mob.GM_Rank = "Admin"
			//if(mob.key == "Ohadx" || mob.key == "Kuramasnigga" || mob.key == "KiloJay") mob.GM_Rank = "Staff Support"
			world<<"<b>- {[mob.GM_Rank]} [mob.key] has logged in! -</b>"
			Announced = 1
		mob.GM = 1

	if(mob.key == "Johunser") {mob.GM = 4; mob.GM_Rank = "Staff Member"}
	if(mob.key == "Pine96") {mob.GM = 3; mob.GM_Rank = "Staff Member"}
	if(mob.key == "Seriak") {mob.GM = 3; mob.GM_Rank = "Staff Member"}
	if(mob.GM)
		mob.verbs+=typesof(/mob/President/verb)
		for(var/Admin_Log/A in Admin_Logs) if(A.Name == mob.key) mob.Admin_Log = A
		if(!mob.Admin_Log) new/Admin_Log (mob)

	for(var/Personal_Log/P in Personal_Logs) if(P.Name == mob.key) mob.Personal_Log = P
	if(!mob.Personal_Log) new/Personal_Log (mob)
	file("Logs/Players/[mob.Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- [mob.key] Logged In! - Computer ID: [computer_id]"
	spawn() mob.Update_Log()

	if(!Announced)  world<<output("<b>- [mob.key] has logged in! -</b>","Chat")

	mob << ""
	mob << "<b><font color=#B40404><u>Version 5.20.</u></font>"
	mob << "<b><font color=#B40404>*** Pine wishes you a nice day ! ***"
	mob << ""
	mob << "<font color=red><font size=1><b>* If you need to learn about this game click <a href='?src=\ref[src];action=Introduction'>here</a>!</b>"
	mob << "<font size=1><b><font color=red>* Please, fan our <a href = http://www.byond.com/games/SilentWraith/NEM>HUB</a>!"
	if(WelcomeMessage)src << output("<center>[WelcomeMessage]","Chat")
	mob << ""
	if(Donators.Find(mob.key) || mob.key == "Mr Mick" || mob.key == "Satomi_Hadaru" || mob.key == "SuperSSTrunks" || mob.key == "Googlemystat" || mob.key == "Googlemyrio" || mob.key == "TeenGogeta" || mob.key == "Lilsaintz" || mob.key == "Averie.David" || mob.key == "KiloJay" || mob.key == "Freshest_Nigga_Alive" || mob.key == "Papasym" || mob.key == "SoulBadgun" || mob.key == "Deadlypure" || mob.key == "Ghostasflash" || mob.key == "Suck Em Dry" || mob.key == "Coolpres" || mob.key == "KatProwl" || mob.key == "Remote Controlled" || mob.key == "Khyrou" || mob.key == "2hard4u" || mob.key == "PtvKiraSuicide" || mob.key == "XxKnightmarexX" || mob.key == "Angel_heat" || mob.key == "SpongeKill" || mob.key == "GreatFisher" || mob.key == "TheGreatEscape" || mob.key == "Ronaldo74" || mob.key == "DakerJr" || mob.key == "SpongeKill" || mob.key == "Yolo_kingry" || mob.key == "PurpleWeed172" || mob.key == "Crystal232" || mob.key == "WontSayHello" || mob.key == "Vampire21" || mob.key == "Moh_hassan" || mob.key == "Jorevv" || mob.key == "BlackLily" || mob.key == "Death Any" || mob.key == "Gepas" || mob.key == "Swordslash2000" || mob.key == "Kunwar1234" || mob.key == "MerlinMage" || mob.key == "CHI-TOWN_-OUTLAW" || mob.key == "Miss_Fluffy" || mob.key == "MissFluffy" || mob.key == "Deathmall" || mob.key == "Jakessj5" || mob.key == "Doom2u" || mob.key == "Deon4" || mob.key == "Kris3002" || mob.key == "Invotis" || mob.key == "Tmacc96" || mob.key == "Hobojoe922" || mob.key == "Nolp7" || mob.key == "StrayCatJinx" || mob.key == "Mdmstatu" || mob.key == "Spun4deadcandy" || mob.key == "Kanye61" || mob.key == "Fireball3043" || mob.key == "Pyrusstorm31" || mob.key == "Celestialman21" || mob.key == "Jasonsmith24lv" || mob.key == "Tavon barnwell" || mob.key == "Needgameplz" || mob.key == "Akken" || mob.key == "Anisho" || mob.key == "Hj32853" || mob.key == "WarBandit267" || mob.key == "TheLiranIsGood" || mob.key == "Lance809" || mob.key == "Nelson745" || mob.key == "Xxx1894" || mob.key == "Johnsontre27" || mob.key == "Aizen-De-Lupen" || mob.key == "Sonido12" || mob.key == "Da frogg" || mob.key == "Orange55" || mob.key == "Jokury" || mob.key == "Ahem" ||mob.key=="Djgoku"||mob.key=="LethalJaggedSpine"||mob.key=="Sacrifice-Op"||mob.key=="Darkestprince" || mob.key=="Masterclaw9" || mob.key=="JulesS." || mob.key == "Samsone700" || mob.key == "Dagare-Keren" || mob.key == "Ninja66" || mob.key == "PurpleLeaf" || mob.key == "Dragonpearl123" || mob.key== "Dillion13" || mob.key == "The Master Gem" || mob.key == "Shuruki2010" || mob.key == "Skittl3zzz"|| mob.key == "LegitX" || mob.key == "Bakumatsu" || mob.key == "MakoandJumppy" || mob.key == "Za3021" || mob.key == "Vegeta312"|| mob.key == "Seb199212" || mob.key == "Jstt100" || mob.key == "Math.W.Johnson" || mob.key == "Yago1gavito" || mob.key == "Kutatzo08" || mob.key == "Rindan" || mob.key == "Kronox001" || mob.key == "Aldershot" || mob.key == "Demonic Wing" || mob.key == "Itznotme")
		mob.Donator = 1
		mob.Trying_Donator = 0
	mob<<output("", "Chat")
	var/C = 0
	var/Characters
	for(var/obj/Login_Screen/L in world)
		if(L:Choosable_X == 0 && L:loc)
			if(findtext(Characters, L.name)) continue
			if(C == 0) Characters+="<b><font color=red>[L]"
			else Characters+=", [L]"
			C++
	if(C >= 1 && !CTD)
		mob<<output("<font color=red><b><u>- The Following Characters Were Disabled By The Admins On This Round:</u></font></b>","Chat")
		mob<<output("","Chat")
		mob<<output("[Characters]","Chat")
		mob<<output("","Chat")
	mob.Multikeying = 0
	Round_CIs.Add(computer_id)

	..()

client/Del()
	if(mob)
		if(mob.name == key)  Round_CIs.Remove(computer_id)
		if(mob.Mind_Controlling) mob.Reset_Mind_Control()
		if(mob.Personal_Log && key) file("Logs/Players/[mob.Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- [key] Logged Off!"
		if(mob.Statistic) mob.Statistic.Last_Time_Seen = "[time2text(world.timeofday, "~Month, Day #DD -hh:mm:ss")]"
	..()

var
	icon_width = -1
	icon_height = -1
	tick_count = 0
	Mode
var
	HUB_Status = "<b>(v5.20) Join and be startled"
	Anti_Lag

mob/var/Tick=0
mob/var/FireCD=0
mob/var/CanMove = 1

world
	fps = 25
	name = "Naruto: Eternal Memories"
	hub = "SilentWraith.NEM"
	status = "<b>(v5.20) Revival"
	hub_password = "tUC0EcWGLh2l9MZ0"
	icon_size = 32

	proc

		movement()
			for(var/mob/m in Active_Mobs)
				m.check_loc()
				m.movement()
			spawn(world.tick_lag) movement()

		set_icon_size()
			if(isnum(world.icon_size))
				icon_width = world.icon_size
				icon_height = world.icon_size
			else
				var/p = findtext(world.icon_size, "x")
				icon_width = text2num(copytext(world.icon_size, 1, p))
				icon_height = text2num(copytext(world.icon_size, p + 1))

	New()
		world.set_icon_size()
		log = file("NEM Errors.txt")
		file("NEM Errors.txt") << "Started New Server"
		..()

	//	spawn(world.tick_lag) movement()

var/list/Active_Mobs = list()



mob/var/Active_M = 1
var/Christmas = 'Christmas.png'