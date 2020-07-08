#define DEBUG
var/mob/Dragonpearl123

var
	SoundMode = 0
	SoundModeX = 0
	CanPlaySoundies = 1
	Font = list('njnaruto.ttf')
	Time_Chuunin
	Time_Genin
	list/CTD_Leaf_Ninjas = list()
	list/CTD_Akatsuki_Ninjas = list()

mob/Dragonpearl123/verb

	Reset_Cooldown()
		set category = "Server"
		var/list/Players = list()
		for(var/mob/M) if(M.Real)
			if(M.client) {Players.Add("[M.key] ~ [M.name]"); Players["[M.key] ~ [M.name]"] = M}
			else {Players.Add("NPC ~ [M.name]"); Players["NPC ~ [M.name]"] = M}

		var/mob/M = input("Who?", "Reset Cooldown") as null|anything in Players
		if(!M) return
		M = Players["[M]"]

		if(!M) return
		M.Missions_Cooldowns = list()

mob/President/verb

	Teleport()
		set category = "Server"
		var/list/Players = list()
		for(var/mob/M) if(M.Real)
			if(M.client) {Players.Add("[M.key] ~ [M.name]"); Players["[M.key] ~ [M.name]"] = M}
			else {Players.Add("NPC ~ [M.name]"); Players["NPC ~ [M.name]"] = M}

		var/mob/M = input("Who do you want to teleport to?", "Teleport") as null|anything in Players
		if(!M) return
		M = Players["[M]"]

		if(!M) return
		loc = M.loc
		Current_Log.Add("*[key] Teleported To [M]!", 1)

	Summon()
		set category = "Server"
		var/list/Players = list()
		for(var/mob/M) if(M.Real)
			if(M.client) {Players.Add("[M.key] ~ [M.name]"); Players["[M.key] ~ [M.name]"] = M}
			else {Players.Add("NPC ~ [M.name]"); Players["NPC ~ [M.name]"] = M}

		var/mob/M = input("Who do you want to summon?", "Summon") as null|anything in Players
		if(!M) return
		M = Players["[M]"]

		if(!M) return
		M.loc = loc
		Current_Log.Add("*[key] Summoned [M]!", 1)

	Create_Poll()
		set category = "Server"
		winset(src,"Poll.P_Option_1","text=''")
		winset(src,"Poll.P_Option_2","text=''")
		winset(src,"Poll.P_Option_3","text=''")
		winset(src,"Poll.P_Option_4","text=''")
		winset(src,"Poll.P_Option_5","text=''")
		winset(src,"Poll.P_Option_6","text=''")
		winset(src,"Poll.P_Option_7","text=''")
		winset(src,"Poll.P_Option_Question","text=''")
		Center("Poll")

	Create_Poll_Confirm()
		set hidden = 1

		var
			Question = winget(src, "Poll.P_Option_Question", "text")
			Option_1 = winget(src, "Poll.P_Option_1", "text")
			Option_2 = winget(src, "Poll.P_Option_2", "text")
			Option_3 = winget(src, "Poll.P_Option_3", "text")
			Option_4 = winget(src, "Poll.P_Option_4", "text")
			Option_5 = winget(src, "Poll.P_Option_5", "text")
			Option_6 = winget(src, "Poll.P_Option_6", "text")
			Option_7 = winget(src, "Poll.P_Option_7", "text")

		if(!Question || !Option_1 || !Option_2) return
		winshow(src, "Poll", 0)
		Current_Log.Add("*[key] created a Poll!", 1)
		new/Poll (Question, Option_1, Option_2, Option_3, Option_4, Option_5, Option_6, Option_7, Statistic)


mob/var/Poll_Selecting
mob/var/Poll_Selecting_S

mob/verb
	Poll()
		Poll_Selecting_S = null
		Poll_Selecting = null
		winset(src, "Create_Poll.Reboot", "text=\"Reboot\"")
		winset(src, "Create_Poll.Next Stage", "text=\"Next Stage\"")
		winset(src, "Create_Poll.Next Mode", "text=\"Next Mode\"")
		winset(src, "Create_Poll.Toggle Clones", "text=\"Toggle Clones\"")
		winset(src, "Create_Poll.Reboot", "background-color=\"#000000\"")
		winset(src, "Create_Poll.Next Stage", "background-color=\"#000000\"")
		winset(src, "Create_Poll.Next Mode", "background-color=\"#000000\"")
		winset(src, "Create_Poll.Toggle Clones", "background-color=\"#000000\"")
		Center("Create_Poll")

	Poll_C()
		set hidden = 1
		if(!Poll_Selecting) return

		if(Poll_Selecting == "Reboot")
			var/_V_ = Statistic.Reboot_Poll -world.realtime
			if(_V_ < 300 || !Statistic.Reboot_Poll) Statistic.Reboot_Poll = null
			else
				_V_ /= 600
				src<<"<font color=[admin_color]><b><u>You must wait [round(_V_)] minute(s) before doing this."
				return
			winshow(src, "Create_Poll", 0)
			new/Poll ("Would you like to reboot?", "Yes", "No", null, null, null, null, null, Statistic)

		else if(Poll_Selecting == "Next Stage")
			Poll_Selecting_S = 1
			winset(src, "Create_Poll.Reboot", "text=\"Leaf Village\"")
			winset(src, "Create_Poll.Next Stage", "text=\"Jungle\"")
			winset(src, "Create_Poll.Next Mode", "text=\"Underground\"")
			winset(src, "Create_Poll.Toggle Clones", "text=\"Sand Village\"")

			winset(src, "Create_Poll.Reboot", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Stage", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Mode", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Toggle Clones", "background-color=\"#000000\"")

		else if(Poll_Selecting == "Next Mode")
			Poll_Selecting_S = 2
			winset(src, "Create_Poll.Reboot", "text=\"Custom Deathmatch\"")
			winset(src, "Create_Poll.Next Stage", "text=\"Capture The Flag\"")
			winset(src, "Create_Poll.Next Mode", "text=\"Tournament\"")
			winset(src, "Create_Poll.Toggle Clones", "text=\"Juggernaut\"")

			winset(src, "Create_Poll.Reboot", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Stage", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Mode", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Toggle Clones", "background-color=\"#000000\"")

		else if(findtext(Poll_Selecting, "Would you like to play on"))
			winshow(src, "Create_Poll", 0)
			new/Poll (Poll_Selecting, "Yes", "No", null, null, null, null, null, Statistic)

		else if(Poll_Selecting == "Custom Team Deathmatch")
			var/_V_ = Statistic.CTD_Timer -world.realtime
			if(_V_ < 300 || !Statistic.CTD_Timer) Statistic.CTD_Timer = null
			else
				_V_ /= 600
				src<<"<font color=[admin_color]><b><u>You must wait [round(_V_)] minute(s) before doing this."
				return
			Custom_Team_Deathmatch_Normal()

		else if(Poll_Selecting in list ("Capture The Flag", "Tournament", "Juggernaut"))
			src<<"<b><font color=[admin_color]>This section will be available later, sorry! :3"

		else if(Poll_Selecting == "Toggle Clones")
			if(!Clones) new/Poll ("Would you like to enable clones?", "Yes", "No")
			else new/Poll ("Would you like to disable clones?", "Yes", "No", null, null, null, null, null, Statistic)


	Poll_S (S as text)
		set hidden = 1
		if(S != "Reboot" && S != "Next Stage" && S != "Next Mode" && S != "Toggle Clones") return

		if(!Poll_Selecting_S)
			winset(src, "Create_Poll.Reboot", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Stage", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Mode", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Toggle Clones", "background-color=\"#000000\"")
			winset(src, "Create_Poll.[S]", "background-color=\"#3B4389\"")
			Poll_Selecting = S
			if(Poll_Selecting == "Next Stage" || Poll_Selecting == "Next Mode") Poll_C()

		else if(Poll_Selecting_S == 1)
			winset(src, "Create_Poll.Reboot", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Stage", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Mode", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Toggle Clones", "background-color=\"#000000\"")
			winset(src, "Create_Poll.[S]", "background-color=\"#3B4389\"")
			if(S == "Reboot") Poll_Selecting = "Would you like to play on Leaf Village Stage next?"
			else if(S == "Next Stage") Poll_Selecting = "Would you like to play on Jungle Stage next?"
			else if(S == "Next Mode") Poll_Selecting = "Would you like to play on Underground Stage next?"
			else if(S == "Toggle Clones") Poll_Selecting = "Would you like to play on Sand Village Stage next?"

		else if(Poll_Selecting_S == 2)
			winset(src, "Create_Poll.Reboot", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Stage", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Next Mode", "background-color=\"#000000\"")
			winset(src, "Create_Poll.Toggle Clones", "background-color=\"#000000\"")
			winset(src, "Create_Poll.[S]", "background-color=\"#3B4389\"")
			if(S == "Reboot") Poll_Selecting = "Custom Team Deathmatch"
			else if(S == "Next Stage") Poll_Selecting = "Capture The Flag"
			else if(S == "Next Mode") Poll_Selecting = "Tournament"
			else if(S == "Toggle Clones") Poll_Selecting = "Juggernaut"

obj
	Tobi_FT
		layer = 50000000000000000
		var/Advanced
		var/Advanced_
		var/Type
		var/Type_
		var/list/Range = list()
		var/list/Projectiles = list()

		Del()
			icon_state = null
			if(Type_ == 1) Flick("End", src)
			if(Type_ == 2) Flick("End 2", src)
			spawn(5) ..()

		Main
			New(loc, mob/_Creator)
				..()
				dir = _Creator.dir
				pixel_x = _Creator.step_x
				pixel_y = _Creator.step_y

				Range.Add(new/obj/Tobi_FT/Tornado (loc, 3, src))
				Range.Add(new/obj/Tobi_FT/Tornado (loc, 10, src))
				Range.Add(new/obj/Tobi_FT/Tornado (loc, 16, src))
				Range.Add(new/obj/Tobi_FT/Tornado (loc, -3, src))
				Range.Add(new/obj/Tobi_FT/Tornado (loc, -10, src))
				Range.Add(new/obj/Tobi_FT/Tornado (loc, -16, src))

				spawn(2.5)
					for(var/obj/Tobi_FT/F in Range)
						if(F.Type_ == 1)
							Flick("Go", F)
							F.icon_state = "Flame"
						else
							Flick("Go 2", F)
							F.icon_state = "Flame 2"

					loop
						if(Advanced >= 1250)
							Advanced_ ++
							if(Advanced_ == 2)
								for(var/obj/Tobi_FT/T in Range) del(T)
								del(src)
							Advanced = -1
						for(var/obj/Tobi_FT/T in Range)
							if(T.x <= 5) continue
							if(T.x >= 400) continue
							if(Advanced == -1)
								if(T.dir == WEST) T.dir = EAST
								else T.dir = WEST
							if(T.dir == WEST)
								if(T.bound_x <= -156)
									T.x -= 5
									T.bound_x = -6
									T.pixel_x = 0
								T.bound_x -= 4
								T.pixel_x -= 4
							else
								T.bound_x += 4
								if(T.bound_x >= 156)
									T.x += 5
									T.bound_x = -6
									T.pixel_x = 0
								else
									T.pixel_x += 4

							for(var/mob/M in bounds(T, 0))
								if(istype(M, /mob/ProjectileR/Kunai_Grenade))
									if(Projectiles.Find(M)) continue
									Projectiles.Add(M)
									if(T.dir == WEST)
										M.vel_x = -M.vel_x
										if(M.vel_x > 0) M.vel_x = -M.vel_x
										M.dir = WEST
									else
										M.vel_x = abs(M.vel_x)
										M.dir = EAST

								else if(istype(M, /mob/Ultimate_Projectile))
									if(istype(M, /mob/Ultimate_Projectile/NL_Mind_Transfer)) continue
									if(istype(M, /mob/Ultimate_Projectile/L_Mind_Transfer)) continue
									if(istype(M, /mob/Ultimate_Projectile/Hiraishin_Kunai)) continue
									if(istype(M, /mob/Ultimate_Projectile/Senbon_Shower)) continue
									if(M:Projectile_Owner && M:Projectile_Owner.Mission_On) continue
									if(Projectiles.Find(M)) continue
									Projectiles.Add(M)
									M:Projectile_Owner = _Creator
									M:Allies = rand(1,3000)
									if(T.dir == WEST)
										M.vel_x = -M.vel_x
										if(M.vel_x > 0) M.vel_x = -M.vel_x
										M.dir = WEST
									else
										M.vel_x = abs(M.vel_x)
										M.dir = EAST

								else
									if(!M.Real || M.name == "Madara" || M.name == "Tobi"|| M.Dragonned || M.knocked || M.Gates || M.Controlling || M.Boulder || M._Tornado || M.Mission_On) continue
									if(M.Dodging)
										M.Auto_Dodge (T)
										continue
									M._Tornado = 1
									spawn(1.5) M._Tornado = 0
									M.Damage(_Creator, 2.5, 1, 0, T, 1)
									M.vel_y = 6
									if(M.vel_x >= M.move_speed/2) M.vel_x /= 4.5
									if(T.dir == EAST) M.vel_x += 6
									if(T.dir == WEST) M.vel_x -= 6
						Advanced++
						spawn(1.15) goto loop


		Tornado
			icon = 'Graphics/Skills/Tobi FT.dmi'
			name = "Fire Tornado"
			Type_ = 1
			New(loc, _x, obj/Tobi_FT/_Creator)
				..()
				bound_x = -12
				bound_width = 43
				bound_height = 230
				loc = _Creator.loc
				if(_x > 0) dir = EAST
				if(_x < 0) dir = WEST
				x += _x
				Type = _x
				pixel_y = _Creator.pixel_y
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -7, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -14, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -21, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -28, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -35, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -42, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -49, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -56, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -63, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, -70, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 7, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 14, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 21, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 28, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 35, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 42, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 49, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 56, src, 1))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 63, src, 2))
				_Creator.Range.Add(new/obj/Tobi_FT/Tornado_ (null, 70, src, 1))


		Tornado_
			name = "Fire Tornado"
			icon = 'Graphics/Skills/Tobi FT.dmi'
			New(loc, _y, obj/Tobi_FT/_Creator, var/C)
				..()
				Type_ = C
				bound_x = -12
				bound_width = 43
				bound_height = 230
				x = _Creator.x
				y = _Creator.y
				z = _Creator.z
				dir = _Creator.dir
				Type = _Creator.Type
				pixel_y = _Creator.pixel_y
				y += _y

mob/var/_Tornado = 0
var/Tornado = 0

obj
	Torune
		layer = 110
		icon_state = "Go"
		var/mob/_Creator

		New()
			..()
			pixel_y -= 12
			spawn(9) del(src)

		Main
			New(loc, Creator)
				..()
				y += 8
				var
					list/Enemies = list()
					list/Range = list()
					PY
				_Creator = Creator
				PY = _Creator.py
				Range.Add(new/obj/Torune/S (src.loc))
				Range.Add(new/obj/Torune/W (src.loc))
				Range.Add(new/obj/Torune/E (src.loc))
				Range.Add(new/obj/Torune/SE (src.loc))
				Range.Add(new/obj/Torune/NE (src.loc))
				Range.Add(new/obj/Torune/N (src.loc))
				Range.Add(new/obj/Torune/SW (src.loc))
				Range.Add(new/obj/Torune/NW (src.loc))
				Range.Add(new/obj/Torune/M (src.loc))
				for(var/obj/Torune/R1 in Range)
					R1.pixel_x += _Creator.step_x
					R1.bound_x += _Creator.step_x
				for(var/obj/Torune/R2 in Range) Flick("Go", R2)
				spawn(2)
					for(var/obj/Torune/T in Range)
						for(var/mob/M in bounds(T, 0))
							if(abs(PY - M.py) >= 155) continue
							if(!M.Real || M.Village == _Creator.Village || M.Dragonned || M.knocked || M.Gates || M.Controlling || M.Boulder) continue
							if(Enemies.Find(M)) continue
							Enemies.Add(M)
							M.Poison_Proc(5, _Creator)
							M.Damage(_Creator, rand(40, 60)/2.5, 1, 0, 0, 1)
				spawn(4)
					Enemies = list()
					for(var/obj/Torune/T in Range)
						for(var/mob/M in bounds(T, 0))
							if(!M.Real || M.Village == _Creator.Village || M.Dragonned || M.knocked || M.Gates || M.Controlling || M.Boulder) continue
							if(Enemies.Find(M)) continue
							Enemies.Add(M)
							M.Poison_Proc(5, _Creator)
							M.Damage(_Creator, rand(40, 70)/2, 1, 0, 0, 1)
				spawn(7.5)
					Enemies = list()
					for(var/obj/Torune/T in Range)
						for(var/mob/M in bounds(T, 0))
							if(abs(PY - M.py) >= 155) continue
							if(!M.Real || M.Village == _Creator.Village || M.Dragonned || M.knocked || M.Gates || M.Controlling || M.Boulder) continue
							if(Enemies.Find(M)) continue
							Enemies.Add(M)
							M.Poison_Proc(5, _Creator)
							M.Damage(_Creator, rand(40, 70)/2.5, 0, 1, 0, 1)


		E
			icon = 'Graphics/Skills/Torune_TE.dmi'
			pixel_x = 255
			New()
				..()
				bound_x = 255
				bound_y = 255
				bound_width = 85
				bound_height = 255
		W
			icon = 'Graphics/Skills/Torune_W.dmi'
			pixel_x = -255
			New()
				..()
				bound_x = -255
				bound_width = 255
				bound_height = 255
		SW
			icon = 'Graphics/Skills/Torune_SW.dmi'
			pixel_x = -255
			pixel_y = -255
			New()
				..()
				bound_x = -255
				bound_y = -255
				bound_width = 255
				bound_height = 255
		SE
			icon = 'Graphics/Skills/Torune_SE.dmi'
			pixel_x = 255
			pixel_y = -255
			New()
				..()
				bound_x = 255
				bound_y = -255
				bound_width = 70
				bound_height = 255
		M
			icon = 'Graphics/Skills/Torune_M.dmi'
			New()
				..()
				bound_width = 255
				bound_height = 255
		N
			icon = 'Graphics/Skills/Torune_TT.dmi'
			pixel_y = 255
			New()
				..()
				bound_y = 255
				bound_width = 255
				bound_height = 80
		S
			icon = 'Graphics/Skills/Torune_S.dmi'
			pixel_y = -255
			New()
				..()
				bound_y = -255
				bound_width = 255
				bound_height = 255
		NW
			icon = 'Graphics/Skills/Torune_T.dmi'
			pixel_y = 255
			pixel_x = -255
			New()
				..()
				bound_y = 255
				bound_x = -185
				bound_width = 185
				bound_height = 25
		NE
			icon = 'Graphics/Skills/Torune_I.dmi'
			pixel_y = 255
			pixel_x = 255
			New()
				..()
				bound_y = 255
				bound_x = 255
				bound_width = 20
				bound_height = 20



mob/Dragonpearl123/verb
	Ghost_Mode()
		if(!Substitution)
			alpha = 150
			Dragonned = 1
			MaxHP = 1000000
			HP = MaxHP
			MaxCha = 1000000
			Cha = MaxCha
			MaxEnergy = 1000000
			Energy = MaxEnergy
			Substitution = 1
			ultra_speed = 2
		else
			alpha = 255
			Dragonned = 0
			MaxHP = 1000000
			HP = MaxHP
			MaxCha = 1000000
			Cha = MaxCha
			MaxEnergy = 1000000
			Energy = MaxEnergy
			Substitution = 0
			ultra_speed = 0

mob/Dragonpearl123
	verb
		Relink()
			set category = "Server"
			var/T=input("Please, type below the full link.","Relinking") as text
			if(!T) return
			if(alert(src, "Are you sure?", "[T]", "No", "Yes") == "Yes")
				for(var/mob/M)
					if(M.client) M<<link("[T]")
		ReviveX(mob/M in world)
			set category = "Server"
			set name = "Revive"
			if(!M.dead) return
			if(M.NEM_Round.Type == "Tourney")
				M.Lost_Tourney = 0
				Tourney_List.Remove(M)
				Tourney_List.Add(M)
			if(M.Kyuubi==1)
				M.Str=10
				M.Def=5
				M.MaxHP=100
				M.MaxCha=100
				M.MaxEnergy=100
				M.Str=11
				M.Def=5.5
				M.Kyuubi=0
			M.CanGoKyuubi=0
			M.CanGoCS=0
			M.dead=0
			M.client:perspective = EYE_PERSPECTIVE
			M.client:eye = M
			M.verbs-=typesof(/mob/Dead/verb)
			M.knocked=0
			M.HP=M.MaxHP
			M.Energy=M.MaxEnergy
			M.freeze=0
			M.stop()
			M.density=1
			M.Cha=M.MaxCha
			M.knocked=0
			M.running=0
			M.icon_state="mob"
			M.set_state()
			M.Run_Off()
			M.stop()
			if(!M.Moving) M.Movement()
			if(M.Healer_Character == 1)
				if(M.Village == "Leaf") Healers_Leaf ++
				if(M.Village == "Akatsuki") Healers_Akatsuki ++
			NEM_Round.Shout("<font color=#4BFF4B><b><u>[M.name] has been revived!</u>")
			M.NEM_Side.Ninjas ++

mob/Eternal/verb
	Toggle_Ino()
		set category = "Server"

		if(Ino_Allowed)
			Ino_Allowed = 0
			src<<"<b><font color=red><u>Ino's Mind Transfer has been enabled!</u>"
		else
			Ino_Allowed = 1

			src<<"<b><font color=red><u>Ino's Mind Transfer has been disabled!</u>"
	Show_Image(f as file)
		world<< f
		world<< ""

mob/Dragonpearl123/verb

	Show_Image(f as file)
		world<< f
		world<< ""

var/Ino_Allowed

mob
	verb
		Server()
			set hidden = 1
			if(!GM) return

			var/mob/Q = input(src, "What would you like to do?", "Server") as null | anything in list("Fix World", "Reboot", "AFK Check", "Toggle Settings", "Privileges", "Boot", "Ban", "UnBan", "HUB Status", "Admin Messages")

			if(Q == "AFK Check") AFK_Check()

			if(Q == "Admin Messages")
				if(key != "Dragonpearl123")
					src<<"<b><font color=[admin_color]><u>You are not allowed to use this command.</u>"
					return
				var/Color = input("Select the color.", "Admin Messages") as color
				admin_color = Color
				for(var/client/C) if(C.mob.GM) C<<output("<b><u><font color=[admin_color]>[key] has changed Admin Messages' Color.</u></font>", "Chat")

			if(Q == "Reboot")
				if(alert(src, "Are you sure?\nReboot", "Confirmation", "Yes", "No") == "Yes")
					world<<output("<font color=[admin_color]><font size=3><b><center>Rebooting!","Chat")
					Current_Log.Add("*[key] rebooted the world!",1 )
					fdel("Scoreboard.sav")
					for(var/mob/M)
						if(M.client)
							M.SaveScores()
							Ranking(M)
					for(var/mob/M) RankingDisplay(M)
					Check_Winner_Score()
					Auto_Balancer = 1
					world.Reboot()
					for(var/NEM_Round/R in Active_Rounds) del(R)

			if(Q == "Fix World")
				if(alert(src, "Are you sure?\nFix World", "Fix World", "Yes", "No") == "Yes")
					Current_Log.Add("*[key] fixed the world!", 1)
					for(var/mob/Players)
						if(Players.client)
							Players.Real = 1
							Players.Checked_X = 1
							Players.knockback = 0
							Players.freeze = 0
							Players.Dragonned = 0
							Players.Attacked = 0
							Players.Attacking = 0

			if(Q == "Toggle Settings")
				var/mob/Toggle = input(src, "What would you like to do?", "Toggle Settings") as null | anything in list("Toggle Clones")

				if(Toggle == "Toggle Clones")
					if(!Clones)
						if(alert(src, "Are you sure?\nEnable Clones", "Toggle Clones", "Yes", "No") == "Yes")
							Current_Log.Add("*[key] enabled clones!", 1)
							Clones = 1
							world<<output("<b><font color=[admin_color]><u>Clones have been enabled by [src.key]!</u></font>", "Chat")
					else
						if(alert(src, "Are you sure?\nDisable Clones", "Toggle Clones", "Yes", "No") == "Yes")
							Current_Log.Add("*[key] disabled clones!", 1)
							Clones = 0
							world<<output("<b><font color=[admin_color]><u>Clones have been disabled by [src.key]!</u></font>", "Chat")


			if(Q == "Privileges")
				if(key != "Dragonpearl123")
					src<<"<b><font color=[admin_color]><u>You are not allowed to use this command.</u>"
					return

				var/mob/Privilege = input(src, "What would you like to do?", "Privileges") as null | anything in list("Mute", "UnMute")

				if(Privilege == "Mute")
					var/list/Players = list()
					for(var/mob/M) if(M.client && M != src && M.key != M.name && !M.GM) Players.Add("[M.key] ~ [M.name]")
					for(var/mob/M) if(M.client && M != src && M.key == M.name && !M.GM) Players.Add("[M.key] ~ Login Screen")
					var/mob/Player = input("Who do you want to mute?", "Mute") as null|anything in Players
					if(!Player) return
					else
						var/F = findtext(Player, "~")
						var/K = copytext(Player, 1, F-1)
						for(var/client/C) if(C.key == K)
							var/Minutes = input("How many minutes?", "Mute [Player]") as num
							if(!Minutes || Minutes < 1) return
							if(Minutes > 60) {src<<"<b><font color=red><u>You can't mute for more than 60 minutes!</u>"; return}
							Minutes = round(Minutes)
							var/R = input("Type below the reason.", "Mute [Player]") as text
							if(!R) return
							if(alert(src, "Are you sure?\nMute [Player] for [Minutes] minute(s)", "Mute", "Yes", "No") == "Yes")
								Current_Log.Add("*[key] muted [C.key] for [Minutes] minute(s)! *Reason: [R]", 1)
								C.mob.Statistic.Times_Muted ++
								file("Logs/Players/[C.mob.Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[C.key] was muted for [Minutes] minute(s) by [key]!<br><u>Reason: [R]</u>"
								C.mob.Mute = 1
								C.mob.Mute_Time = Minutes*60
								if(Minutes == 1) world<<output("<font color=[admin_color]><b><u>[C.key] has been muted by [key] for [Minutes] minute!</u><br>Reason: [R]</font>","Chat")
								else world<<output("<font color=[admin_color]><b><u>[C.key] has been muted by [key] for [Minutes] minutes!</u><br>Reason: [R]</font>","Chat")

				if(Privilege == "UnMute")
					var/list/Players = list()
					for(var/mob/M) if(M.client && M.Mute) Players.Add(M)
					var/mob/To_Be_UnMuted = input("Which person do you want to unmute?", "UnMute") as null | anything in Players
					if(!To_Be_UnMuted) return
					if(alert(src, "Are you sure?\nUnMute [To_Be_UnMuted]", "UnMute", "Yes", "No") == "Yes")
						Current_Log.Add("*[key] unmuted [To_Be_UnMuted.key]!", 1)
						file("Logs/Players/[To_Be_UnMuted.Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[To_Be_UnMuted.key] was unmuted by [key]!"
						To_Be_UnMuted.Mute_Time = 0
						To_Be_UnMuted.Mute = 0
						world<<output("<font color=[admin_color]><b><u>[To_Be_UnMuted.key] has been unmuted by [key]!</u></font>","Chat")

			if(Q == "Boot")
				Boot()


			if(Q == "HUB Status")
				if(key != "Dragonpearl123")
					src<<"<b><font color=[admin_color]><u>You are not allowed to use this command.</u>"
					return
				var/Status = input("Please, type below the new status","HUB Status") as text
				if(!Status) return
				HUB_Status = "<b>(v5.15) - [Status]"
				world.status = HUB_Status

			if(Q == "Ban")
				if(key != "Dragonpearl123")
					src<<"<b><font color=[admin_color]><u>You are not allowed to use this command.</u>"
					return
				var/To_Be_Banned = input("Who do you want to ban?", "Ban") as text
				if(!To_Be_Banned || To_Be_Banned == key) return
				if(Real_Owner.Find(To_Be_Banned))
					world<<"<b><font color=[admin_color]><u>* [key] has tried to ban DragonPearl!</u>"
					world<<"<b><font color=[admin_color]>[key] has been automatically banned!"
					Bans.Add(key)
					Bans.Add(client.computer_id)
					Bans.Add(client.address)
					del client
					return
				if(alert(src, "Are you sure?\nBan: [To_Be_Banned]", "Confirmation", "Yes", "No") == "Yes")
					Bans.Add(To_Be_Banned)
					Current_Log.Add("*[key] banned [To_Be_Banned]!", 1)
					for(var/Personal_Log/P in Personal_Logs) if(P.Name == To_Be_Banned) file("Logs/Players/[P.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[P.Name] was banned by [key]!"
					for(var/mob/Players) if(Players.GM) Players<<"<b><u><font color=[admin_color]>[To_Be_Banned] has been banned by [key]!</u></b>"
					for(var/mob/G)
						if(G.key == To_Be_Banned)
							Bans.Add(G.client.computer_id)
							Bans.Add(G.client.address)
							del G.client

			if(Q == "UnBan")
				if(key != "Dragonpearl123")
					src<<"<b><font color=[admin_color]><u>You are not allowed to use this command.</u>"
					return
				var/list/Banned_People = list()
				for(var/B in Bans) Banned_People.Add(B)
				var/To_Be_UnBanned = input("Who do you want to unban?","UnBan") as null | anything in Banned_People
				if(!To_Be_UnBanned) return
				if(alert(src, "Are you sure?\nUnBan: [To_Be_UnBanned]", "Confirmation", "Yes", "No") == "Yes")
					Current_Log.Add("*[key] unbanned [To_Be_UnBanned]!", 1)
					for(var/Personal_Log/P in Personal_Logs) if(P.Name == To_Be_UnBanned) file("Logs/Players/[P.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[P.Name] was unbanned by [key]!"
					Bans.Remove(To_Be_UnBanned)
					for(var/mob/Players) if(Players.GM) Players<<"<b><u><font color=[admin_color]>[To_Be_UnBanned] has been unbanned by [key]!</u></b>"

		AFK_Check()
			set hidden = 1
			if(!GM) return

			if(AFK_CD)
				src<<"<b><font color=red><u>Wait! There was an AFK Check not too long ago!"
				return
			if(alert(src, "Are you sure?\nAFK Check", "Confirmation", "Yes", "No") == "Yes")
				if(AFK_CD == 1)
					src<<"<b><font color=red><u>Wait! There was an AFK Check not too long ago!"
					return
				Current_Log.Add("*[key] has done an AFK Check!", 1)
				AFK_Check_Process()

		Boot()
			set hidden = 1
			if(!GM) return
			var/list/Players = list()
			for(var/mob/M) if(M.client && M != src && M.key != M.name && !M.GM) Players.Add("[M.key] ~ [M.name]")
			for(var/mob/M) if(M.client && M != src && M.key == M.name && !M.GM) Players.Add("[M.key] ~ Login Screen")
			var/mob/Player = input("Who do you want to boot?", "Boot") as null|anything in Players
			if(!Player) return
			else
				var/F = findtext(Player, "~")
				var/K = copytext(Player, 1, F-1)
				for(var/client/C) if(C.key == K)
					if(alert(src, "Are you sure?\nBoot [Player]", "Boot", "Yes", "No") == "Yes")
						world<<output("<font color=[admin_color]><b><u>[C.key] has been booted by [key]!</u>","Chat")
						C.mob.Statistic.Times_Booted ++
						file("Logs/Players/[C.mob.Personal_Log.Name].txt") << "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- *[C.key] was booted by [key]!"
						Current_Log.Add("*[key] booted [C.key]!", 1)
						if(C.mob.NEM_Round.Type != "Tourney")
							C.mob.HP = -10
							C.mob.Deaths = 4
							C.mob.Death_Check()
						del C


mob/Dragonpearl123/verb
	World_Announce(t as text)
		if(!t) return
		world<<output("[t]","Chat")

	Update(F as file)
		set category = "Server"
		fcopy(F, "[F]")
		if(alert(src, "Would you like to Reboot?", "Reboot", "No", "Yes") == "Yes")
			world<<output("<u><b><font color=[admin_color]>This server has been updated by [src.key]!","Chat")
			Auto_Balancer = 1
			for(var/mob/M)
				if(M.client) M.SaveScores()
			world.Reboot()

mob/President
	verb
		Admin_Chat(t as text)
			if(!t) return
			Current_Log.Add("*[key] Admin Chat: [t]")
			for(var/mob/M)
				if(M.GM) M<<output("<font size=2><font color=white>{[GM_Rank]- Admin Chat}</font color><font color=[admin_color]></b> [key]:</font color><font color=white> [html_encode(copytext(t,1,1500))]","Chat")

		Announcement(t as text)
			set category = "Server"
			if(!t) return
			Current_Log.Add("*[key] Announces: [t]")
			if(key == "SilentWraith")  world<<output("<u><font color=[admin_color]><font size=2><b>{Owner} Silent</font color><font color=white><b></u> [html_encode(copytext(t,1,500))]</b>","Chat")
			if(key == "Dragonpearl123")  world<<output("<u><font color=[admin_color]><font size=2><b>{Owner} Dragon Pearl</font color><font color=white><b></u> [html_encode(copytext(t,1,500))]</b>","Chat")
			else
				for(var/mob/M in world) if(M.client)
					if(!GM) if(M.Ignoring.Find(key) || M.Ignoring.Find("*[client.computer_id]")) continue
					else M<<output("<u><font color=[admin_color]><font size=2><b>{[GM_Rank]} [key]</font color><font color=white><b></u> [html_encode(copytext(t,1,500))]</b>","Chat")

var/list/Real_Owner = list("Dragonpearl123", "SilentWraith")

mob/var
	Updated_Bans
	Visible_Player = 1

mob
	Special_Ban/verb
		Global_Bans()
			if(Updated_Bans) return
			Updated_Bans = 1
			spawn(300) Updated_Bans = 0
			var/http[]=world.Export("http://global-bans-eternal.freeiz.com/Bans.html")
			if(!http) return
			var/FullText=file2text(http["CONTENT"])
			GlobalBanList=list()
			var/CurPos=1
			var/BanReason
			while(findtext(FullText,"\n",CurPos,0))
				var/NextPos=findtext(FullText,"\n",CurPos,0)
				var/ThisBanLine=copytext(FullText,CurPos,NextPos)
				if(copytext(ThisBanLine,1,3)=="//")	BanReason=copytext(ThisBanLine,3)
				GlobalBanList+=ThisBanLine
				GlobalBanList[ThisBanLine]=BanReason
				CurPos=NextPos+1
			src<<"<u>[ServerTag]</u></font> <u><font color=white>Global Ban List has been successfully updated.</u></font>"
			for(var/mob/M)	if(M.client) if(M.CheckGlobalBan())	del M.client

	Dragonpearl123/verb
		Visibility()
			if(!Visible_Player)
				src<<"<b><font color=[admin_color]><u>You're now visible to the world.</u></font>"
				Visible_Player = 1
			else
				src<<"<b><font color=[admin_color]><u>You're no longer visible to the world.</u></font>"
				Visible_Player = 0


var/list/GlobalBanList=list()
var/list/Banned_Worlds_List=list()
var/list/GlobalConfirmedPlayersList=list()
var/ServerTag="<b><font color=red>Server Info:</font>"

mob/Dragonpearl123/verb

	Bans()
		set category = "Server"
		for(var/S in Bans) src<<S

	Reputation_Reward()
		var/P = input(src,"Who do you want to reward with reputation?", "Give Reputation") as text
		if(P)
			for(var/mob/M)
				if(M.key == P)
					var/N = input(src, "How many reputation?", "Give Reputation") as num
					M.Statistic.Reputation += N
					M<<"<b><font color=#40D3E9><i>You've been rewarded with [N] Reputation!</b></i></font>"

	Custom_Rank(mob/M in world)
		var/T = input(src,"What Rank?", "Custom Rank") as text
		if(!T || !M) return
		var/V = input(src, "Are you sure?","[M] - Rank: [T]") in list("Yes", "No")
		if(V == "Yes")
			M.Statistic.Rank = T
			Current_Log.Add("*[key] promoted [M.key] to [T]!", 1)
			M.Statistic.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Promoted To [T]! *"
			world<<"<u><b><font size=1><font color=[admin_color]>Dragon Pearl has promoted [M.key] to [T]!</u></font>"

	Ryo_Panel()
		set category = "Server"
		var/mob/Q = input(src, "What do you want to do?","Ryo Panel") as null | anything in list("Give Ryo {Individual}","Give Ryo {Global}")
		if(Q == "Give Ryo {Individual}")
			var/P = input(src,"Who do you want to reward with ryo?", "Give Ryo {Individual}") as text
			if(P)
				for(var/mob/M)
					if(M.key == P)
						var/N = input(src, "How many ryo?", "Give Ryo {Individual}") as num
						M.Statistic.Ryo += N
						M<<"<b><font color=#40D3E9><i>You've been rewarded with [N] Ryo!</b></i></font>"
		if(Q == "Give Ryo {Global}")
			var/N = input(src,"How many ryo?", "Give Ryo {Global}") as num
			for(var/mob/M in world)
				M.Statistic.Ryo += N
				M<<"<b><font color=#40D3E9><i>You've been rewarded with [N] Ryo!</b></i></font>"

proc/Check_Banned_Worlds()
	if(world.internet_address in Banned_Worlds_List)
		return 1
	var/list/PlayerOctets=Split(world.internet_address,".")
	for(var/x in Banned_Worlds_List)
		if(findtext(x,"*",1,0))
			var/list/OctetList=Split(x,".")
			if(OctetList.len>=2 && PlayerOctets.len>=2)
				if(PlayerOctets[1]==OctetList[1] && PlayerOctets[2]==OctetList[2])
					return 4
	return 0
mob/proc/CheckGlobalBan()
	if(!client)return
	if(client.address in GlobalBanList) return 1
	if(key in GlobalBanList) return 2
	if(client.computer_id in GlobalBanList) return 3
	var/list/PlayerOctets=Split(src.client.address,".")
	for(var/x in GlobalBanList)
		if(findtext(x,"*",1,0))
			var/list/OctetList=Split(x,".")
			if(OctetList.len>=2 && PlayerOctets.len>=2)
				if(PlayerOctets[1]==OctetList[1] && PlayerOctets[2]==OctetList[2])
					src<<"This IP Range is Globaly Banned.";return 4
	return 0

var/Set_To_Load = 1
proc/LoadGlobalBans(var/RepeatLoad=1)
	if(Set_To_Load)
		var/http[]=world.Export("http://global-bans-eternal.freeiz.com/Bans.html")
		if(!http)
			if(RepeatLoad)	spawn(600)	LoadGlobalBans()
			return
		var/FullText=file2text(http["CONTENT"])
		GlobalBanList=list()
		var/CurPos=1
		var/BanReason
		while(findtext(FullText,"\n",CurPos,0))
			var/NextPos=findtext(FullText,"\n",CurPos,0)
			var/ThisBanLine=copytext(FullText,CurPos,NextPos)
			if(copytext(ThisBanLine,1,3)=="//")	BanReason=copytext(ThisBanLine,3)
			GlobalBanList+=ThisBanLine
			GlobalBanList[ThisBanLine]=BanReason
			CurPos=NextPos+1
		//if(RepeatLoad)	spawn(36000)	LoadGlobalBans()
		world<<"<u>[ServerTag]</u></font> <u><font color=white>Global Ban List has been successfully loaded.</u></font>"
		for(var/mob/M)	if(M.client)
			if(M.CheckGlobalBan())	del M.client

proc/UpdateGlobalBans(var/RepeatLoad=1)
	var/http[]=world.Export("http://global-bans-eternal.freeiz.com/Bans.html")
	if(!http)
		if(RepeatLoad)	spawn(3600)	LoadGlobalBans()
		return
	var/FullText=file2text(http["CONTENT"])
	GlobalBanList=list()
	var/CurPos=1
	var/BanReason
	while(findtext(FullText,"\n",CurPos,0))
		var/NextPos=findtext(FullText,"\n",CurPos,0)
		var/ThisBanLine=copytext(FullText,CurPos,NextPos)
		if(copytext(ThisBanLine,1,3)=="//")	BanReason=copytext(ThisBanLine,3)
		GlobalBanList+=ThisBanLine
		GlobalBanList[ThisBanLine]=BanReason
		CurPos=NextPos+1
	if(RepeatLoad)	spawn(36000) LoadGlobalBans()
	world<<"<u>[ServerTag]</u></font> <u><font color=white>Global Ban List has been successfully updated.</u></font>"
	for(var/mob/M)	if(M.client)
		if(M.CheckGlobalBan())	del M.client

proc/Split(var/text2split,var/SplitBy)
	var/CurPos=1
	var/list/SplitList=list()
	while(findtext(text2split,SplitBy,CurPos,0))
		var/NextPos=findtext(text2split,SplitBy,CurPos,0)
		SplitList+=copytext(text2split,CurPos,NextPos)
		CurPos=NextPos+1
	if(CurPos<=length(text2split))	SplitList+=copytext(text2split,CurPos,0)
	return SplitList


mob/var/GM = 0
mob/var/Donator = 0
var/list/Gays = list("Yolo_kingry", "Johnsontre27")
var/list/GMs = list()
mob/President/verb/Custom_Team_Deathmatch()
	set category = "Modes"
	src<<"<b><font color=red><u>This function is temporarily disabled, sorry!</u>"
	return

	var/_CTD_Ninjas_In_Leaf
	var/_CTD_Ninjas_In_Akatsuki
	var/list/_CTD_Leaf_Ninjas_List = list()
	var/list/_CTD_Akatsuki_Ninjas_List = list()
	var/list/Characters = list()
	for(var/obj/Login_Screen/C) if(C.loc && !C.S_Ranked) Characters.Add(C)

	var/_Leaf_ = input("How many characters will be available in Leaf?", "Leaf Characters") in list("One", "Two", "Three", "Four")
	if(_Leaf_ == "One") _CTD_Ninjas_In_Leaf = 1
	else if(_Leaf_ == "Two") _CTD_Ninjas_In_Leaf = 2
	else if(_Leaf_ == "Three") _CTD_Ninjas_In_Leaf = 3
	else if(_Leaf_ == "Four") _CTD_Ninjas_In_Leaf = 4
	var/Count
	Leaf_Ninjas
		var/obj/Login_Screen/L = input("Pick a character for Leaf.","Leaf Character - #[1+(Count)]") in Characters
		_CTD_Leaf_Ninjas_List.Add(L)
		for(var/obj/Login_Screen/R in Characters) if(R.name == L.name) Characters.Remove(R)
		Count ++
		if(Count != _CTD_Ninjas_In_Leaf) goto Leaf_Ninjas
	src<<"<b><font color=[admin_color]><u>The Following Characters Will Fight In Leaf:</u>"
	for(var/obj/Login_Screen/L in _CTD_Leaf_Ninjas_List) src<<"<b><font color=[admin_color]>- [L.name]"

	var/_Akatsuki_ = input("How many characters will be available in Akatsuki?", "Akatsuki Characters") in list("One", "Two", "Three", "Four")
	if(_Akatsuki_ == "One") _CTD_Ninjas_In_Akatsuki = 1
	else if(_Akatsuki_ == "Two") _CTD_Ninjas_In_Akatsuki = 2
	else if(_Akatsuki_ == "Three") _CTD_Ninjas_In_Akatsuki = 3
	else if(_Akatsuki_ == "Four") _CTD_Ninjas_In_Akatsuki = 4
	var/_Count
	Akatsuki_Ninjas
		var/obj/Login_Screen/L = input("Pick a character for Akatsuki.","Akatsuki Character - #[1+(_Count)]") in Characters
		_CTD_Akatsuki_Ninjas_List.Add(L)
		Characters.Remove(L)
		_Count ++
		if(_Count != _CTD_Ninjas_In_Akatsuki) goto Akatsuki_Ninjas
	src<<"<b><font color=[admin_color]><u>\nThe Following Characters Will Fight In Akatsuki:</u>"
	for(var/obj/Login_Screen/L in _CTD_Akatsuki_Ninjas_List) src<<"<b><font color=[admin_color]>- [L.name]"

	if(alert(src, "Are you sure?", "Custom Team Deathmatch", "No", "Yes") == "Yes")
		Next_Mode = "CTD"
		CTD_Leaf_Ninjas = _CTD_Leaf_Ninjas_List
		CTD_Akatsuki_Ninjas = _CTD_Akatsuki_Ninjas_List
		CTD_Next = 1
		world<<"\n<b><font color=[admin_color]><u><center><font size=3>* A Custom Team Deathmatch will be hosted on next round! *</u>"
		var/L_Text
		var/A_Text
		for(var/obj/Login_Screen/L in CTD_Leaf_Ninjas)
			if(!L_Text) L_Text += L.name
			else L_Text += " & [L.name]"
		for(var/obj/Login_Screen/L in CTD_Akatsuki_Ninjas)
			if(!A_Text) A_Text += L.name
			else A_Text += " & [L.name]"
		world<<"<b><font size=2><center><font color=#4EFF81>[L_Text] <font color=#A92323>Vs<font color=#8904B1> [A_Text]\n</center>"
mob/proc/Custom_Team_Deathmatch_Normal()
	src<<"<b><font color=red><u>This function is temporarily disabled, sorry!</u>"
	return
	var/_CTD_Ninjas_In_Leaf
	var/_CTD_Ninjas_In_Akatsuki
	var/list/_CTD_Leaf_Ninjas_List = list()
	var/list/_CTD_Akatsuki_Ninjas_List = list()
	var/list/Characters = list()
	for(var/obj/Login_Screen/C) if(C.loc && !C.S_Ranked) Characters.Add(C)

	var/_Leaf_ = input("How many characters will be available in Leaf?", "Leaf Characters") in list("One", "Two", "Three", "Four")
	if(_Leaf_ == "One") _CTD_Ninjas_In_Leaf = 1
	else if(_Leaf_ == "Two") _CTD_Ninjas_In_Leaf = 2
	else if(_Leaf_ == "Three") _CTD_Ninjas_In_Leaf = 3
	else if(_Leaf_ == "Four") _CTD_Ninjas_In_Leaf = 4
	var/Count
	Leaf_Ninjas
		var/obj/Login_Screen/L = input("Pick a character for Leaf.","Leaf Character - #[1+(Count)]") in Characters
		_CTD_Leaf_Ninjas_List.Add(L)
		for(var/obj/Login_Screen/R in Characters) if(R.name == L.name) Characters.Remove(R)
		Count ++
		if(Count != _CTD_Ninjas_In_Leaf) goto Leaf_Ninjas
	src<<"<b><font color=[admin_color]><u>The Following Characters Will Fight In Leaf:</u>"
	for(var/obj/Login_Screen/L in _CTD_Leaf_Ninjas_List) src<<"<b><font color=[admin_color]>- [L.name]"

	var/_Akatsuki_ = input("How many characters will be available in Akatsuki?", "Akatsuki Characters") in list("One", "Two", "Three", "Four")
	if(_Akatsuki_ == "One") _CTD_Ninjas_In_Akatsuki = 1
	else if(_Akatsuki_ == "Two") _CTD_Ninjas_In_Akatsuki = 2
	else if(_Akatsuki_ == "Three") _CTD_Ninjas_In_Akatsuki = 3
	else if(_Akatsuki_ == "Four") _CTD_Ninjas_In_Akatsuki = 4
	var/_Count
	Akatsuki_Ninjas
		var/obj/Login_Screen/L = input("Pick a character for Akatsuki.","Akatsuki Character - #[1+(_Count)]") in Characters
		_CTD_Akatsuki_Ninjas_List.Add(L)
		Characters.Remove(L)
		_Count ++
		if(_Count != _CTD_Ninjas_In_Akatsuki) goto Akatsuki_Ninjas
	src<<"<b><font color=[admin_color]><u>\nThe Following Characters Will Fight In Akatsuki:</u>"
	for(var/obj/Login_Screen/L in _CTD_Akatsuki_Ninjas_List) src<<"<b><font color=[admin_color]>- [L.name]"

	if(alert(src, "Are you sure?", "Custom Team Deathmatch", "No", "Yes") == "Yes")
		CTD_Leaf_Ninjas = _CTD_Leaf_Ninjas_List
		CTD_Akatsuki_Ninjas = _CTD_Akatsuki_Ninjas_List
		var/L_Text
		var/A_Text
		for(var/obj/Login_Screen/L in CTD_Leaf_Ninjas)
			if(!L_Text) L_Text += L.name
			else L_Text += " & [L.name]"
		for(var/obj/Login_Screen/L in CTD_Akatsuki_Ninjas)
			if(!A_Text) A_Text += L.name
			else A_Text += " & [L.name]"
		winshow(src, "Create_Poll", 0)
		new/Poll ("Would you like to have a Custom Team Deathmatch next?\n<font color=#4EFF81>[L_Text] <font color=#A92323>Vs<font color=#8904B1> [A_Text]", "Yes", "No", null, null, null, null, null, Statistic, _CTD_Leaf_Ninjas_List, _CTD_Akatsuki_Ninjas_List)
mob/President/verb/Characters()
	set category = "Server"
	if(Mission_On) return
	var/list/Characters = list()
	for(var/obj/Login_Screen/C) if(C.loc)
		if(Real_Owner.Find(key) && C.S_Ranked) Characters.Add(C)
		if(!C.S_Ranked) Characters.Add(C)
	switch(input("What do you want to do?","Characters") as null | anything in list("Change Character", "Enable Character", "Disable Character", "Enable Character (Next Round)", "Disable Character (Next Round)", "Enable Character (Permanent)", "Disable Character (Permanent)"))
		if("Change Character")
			var/obj/Login_Screen/L = input("What do you want to be?","Change Character") as null|anything in Characters
			if(!L || Mission_On) return
			if(L.name == name) return
			if(NEM_Round == Current_NEM_Round)
				if(NEM_Side) NEM_Side.Ninjas --
				NEM_Side = L.NEM_Side
				NEM_Side.Ninjas ++
			name = L.name
			if(!Moving) Movement()
			CanChoose = 0

			winset(src, "default.Avatar","image=\ref[L.icon]")
			_Name = L.name
			if(_Name == "Hashirama Senju") _Name = "Hashirama"
			if(_Name == "Tobirama Senju") _Name = "Tobirama"
			if(_Name == "Hiruzen Sarutobi") _Name = "Hiruzen"
			winset(src, "default.Avatar_Name","text-color=[Text_Color]")
			winset(src, "default.Avatar_Name","text='[_Name]'")
			Avatar = L.icon
			Village = L.Side
			Real_Character_Name = L.name
			speed_multiplier = L.Given_Speed
			MaxHP = L.Given_HP
			MaxCha = L.Given_Chakra
			MaxEnergy = L.Given_Energy
			HP = MaxHP
			Cha = MaxCha
			Energy = MaxEnergy
			Str = L.Given_Str
			Def = L.Given_Def
			ultra_speed = L.Ultra_Speed
			icon = L.Given_Icon
			Current_Log.Add("*[key] changed his character to [name]!", 1)
			Statistic.Characters_Used.Add(name)
			Check_Jutsu()
		if("Enable Character")
			var/mob/M=input("Which character do you want to enable?", "Enable Character") as null|anything in Characters
			if(!M||M=="Cancel")return
			for(var/obj/Login_Screen/L in world)
				if(L == M)
					var/Choosable = 1
					for(var/obj/Locked/U in L.loc) Choosable = 0
					for(var/obj/Locked_X/C in L.loc) Choosable = 0
					if(Choosable)
						src<<"<b><font color=red><u>[M] is already enabled!"
						return
					else
						Current_Log.Add("*[key] has enabled [M]!", 1)
						L.Choosable = 1
						L.Choosable_X = 1
						world<<output("<font color=[admin_color]><b><u>[M] has been enabled for this round by [src.key]!</u></font>","Chat")
						for(var/obj/Locked/U in L.loc) del(U)
						for(var/obj/Locked_X/C in L.loc) del(C)
		if("Disable Character")
			var/mob/M=input("Which character do you want to disable?", "Disable Character") as null|anything in Characters
			if(!M||M=="Cancel")return
			for(var/obj/Login_Screen/L in world)
				if(L == M)
					if(L.Choosable == 0)
						src<<"<b><font color=red><u>[M] is already disabled!"
						return
					if(L.Choosable == 1)
						Current_Log.Add("*[key] has disabled [M]!", 1)
						L.Choosable = 0
						L.Choosable_X = 0
						world<<output("<font color=[admin_color]><b><u>[M] has been disabled for this round by [src.key]!</u></font>","Chat")
						new/obj/Locked_X (L.loc)


		if("Enable Character (Next Round)")
			var/mob/M=input("Which character do you want to enable for next round?", "Enable Character (Next Round)") as null|anything in Characters
			if(!M||M=="Cancel")return
			var/In = 0
			for(var/C in Illegal_Characters)
				if(C == M)
					Current_Log.Add("*[key] has enabled [M] for next round!", 1)
					world<<output("<font color=[admin_color]><b><u>[M] has been enabled for next round by [src.key]!</u></font>","Chat")
					In = 1
					Illegal_Characters.Remove(C)
			if(In == 0)
				src<<"<b><font color=red><u>[M] is already enabled for next round!"
				return

		if("Disable Character (Next Round)")
			var/mob/M=input("Which character do you want to disable for next round?", "Disable Character (Next Round)") as null|anything in Characters
			if(!M||M=="Cancel")return
			for(var/C in Illegal_Characters)
				if(C == M)
					src<<"<b><font color=red><u>[M] is already disabled for next round!"
					return
			Illegal_Characters.Add(M)
			Current_Log.Add("*[key] has disabled [M] for next round!", 1)
			world<<output("<font color=[admin_color]><b><u>[M] has been disabled for next round by [src.key]!</u></font>","Chat")


		if("Enable Character (Permanent)")

			var/list/Disabled=list()
			for(var/C in Illegal_Characters_X)
				Disabled.Add(C)
			var/Cancel1="Cancel"
			Disabled+=Cancel1

			var/mob/M=input("Which character do you want to enable for permanent?", "Enable Character (Permanent)") as null|anything in Disabled
			if(!M||M=="Cancel")return

			var/In = 0
			for(var/C in Illegal_Characters_X)
				if(C == M)
					world<<output("<font color=[admin_color]><b><u>[M] has been permanently enabled by [src.key]!</u></font>","Chat")
					In = 1
					Illegal_Characters_X.Remove(C)
					Current_Log.Add("*[key] has permanently enabled [M]!", 1)
			if(In == 0)
				src<<"<b><font color=red><u>[M] is already permanently enabled!"
				return

		if("Disable Character (Permanent)")

			var/list/Enabled=list()
			for(var/obj/Login_Screen/C)
				if(Illegal_Characters_X.Find(C) || C.Choosable_X == 0 || name == "Kabutomaru") continue
				Enabled.Add(C)
			var/Cancel2="Cancel"
			Enabled+=Cancel2
			var/mob/M=input("Which character do you want to disable for permanent?", "Disable Character (Permanent)") as null|anything in Enabled

			if(!M||M=="Cancel")return
			for(var/C in Illegal_Characters_X)
				if(C == M)
					src<<"<b><font color=red><u>[M] is already permanently disabled!"
					return
			Illegal_Characters_X.Add(M)
			world<<output("<font color=[admin_color]><b><u>[M] has been permanently disabled by [src.key]!</u></font>","Chat")
			Current_Log.Add("*[key] has permanently disabled [M]!", 1)
