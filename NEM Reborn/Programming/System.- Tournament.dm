mob/var/Lost_Tourney = 1
var/Round
var/Round_Type
var/Round_GoingOn
var/Round_Deaths_Limit = 100
var/list/Tourney_List = list()
var/list/Fighters = list()
var/Time_to_Start = 0
var/Time_Left = 600
var/Tournament_On_Next_Round = 0
var/Tournament_GoingOn = 0
var/Next_Prize
var/Prize
var/West_Side = 0
var/East_Side = 0
var/Winner
var/Loser
var/Next_Round
mob/var/Fighting_On_Tourney = 0
mob/var/On_Tourney = 0

mob/proc/Join_Tourney()
	if(Tournament_GoingOn == 1)
		Moving = 0
		overlays -= new/obj/Red
		overlays -= new/obj/Blue
		if(Fighters.Find(src))
			if(!Moving) Movement()
			Check_AFK()
			if(Round_Type == "1vs1" && Village == "Red")
				overlays += new/obj/Red
				for(var/obj/Tourney_Spawn_West/E in world)
					if(client)
						client:perspective = MOB_PERSPECTIVE
						client:eye = src
					loc = E.loc
					Checked_X = 1
					dir = EAST
					CanMove = 1
					freeze = 0
					return
			if(Round_Type == "1vs1" && Village == "Blue")
				overlays += new/obj/Blue
				for(var/obj/Tourney_Spawn_East/E in world)
					if(client)
						client:perspective = MOB_PERSPECTIVE
						client:eye = src
					loc = E.loc
					Checked_X = 1
					dir = WEST
					CanMove = 1
					freeze = 0
					return
			if(Round_Type == "2vs2" && Village == "Red")
				overlays += new/obj/Red
				for(var/obj/X_Leaf_Third_Spawn/E in world)
					if(client)
						client:perspective = MOB_PERSPECTIVE
						client:eye = src
					loc = E.loc
					Checked_X = 1
					dir = EAST
					CanMove = 1
					freeze = 0
					return
			if(Round_Type == "2vs2" && Village == "Blue")
				overlays += new/obj/Blue
				for(var/obj/X_Akatsuki_Third_Spawn/E in world)
					if(client)
						client:perspective = MOB_PERSPECTIVE
						client:eye = src
					loc = E.loc
					Checked_X = 1
					dir = WEST
					CanMove = 1
					freeze = 0
					return
			if(Round_Type == "3vs3" && Village == "Red")
				overlays += new/obj/Red
				for(var/obj/X_Leaf_Third_Spawn/E in world)
					if(client)
						client:perspective = MOB_PERSPECTIVE
						client:eye = src
					loc = E.loc
					Checked_X = 1
					dir = EAST
					CanMove = 1
					freeze = 0
					return
			if(Round_Type == "3vs3" && Village == "Blue")
				overlays += new/obj/Blue
				for(var/obj/X_Akatsuki_Third_Spawn/E in world)
					if(client)
						client:perspective = MOB_PERSPECTIVE
						client:eye = src
					loc = E.loc
					Checked_X = 1
					dir = WEST
					CanMove = 1
					freeze = 0
					return

		for(var/mob/M in Fighters) if(M == src) return

		Village = rand(1,30000000000)
		if(client) client.eye  = locate(0,0,0)

		if(!On_Tourney)
			Lost_Tourney = 0
			MaxHP = 115
			HP = 115
			MaxCha = 135
			Cha = 135
			MaxEnergy = 150
			Energy = 150
			Tourney_List.Add(src)
			On_Tourney = 1
			src<<output("","Chat")
			src<<output("<b><font color=#FFD203><font size=2><u><center>You've joined the Tournament!</u></center></font>","Chat")
			src<<output("","Chat")

		Tournament_Player(src)
		CanMove = 0
		Checked_X = 0
		loc = null

mob/Supreme
	verb
		Start_Tournament()
			set category = "Modes"
			if(New_Mode) {src<<"<b><font color=red><u>You can't host a special round until [New_Mode] ends!</u>"; return}
			var/T=input("What'll be the prize?", "Tournament's Prize") as text
			if(!T) return
			if(alert(usr, "Confirmation", "Start Tournament", "Yes", "No") == "Yes")
				if(New_Mode) {src<<"<b><font color=red><u>You can't host a special round until [New_Mode] ends!</u>"; return}
				Next_Prize = T
				Current_Log.Add("*[key] is hosting a Tourney on next round!", 1)
				if(key == "Dragonpearl123")
					world<<output("","Chat")
					world<<output("<b><font color=[admin_color]><font size=3><u><center>Dragon Pearl will host a Tourney the next round!</u></center>","Chat")
					world<<output("","Chat")
					world<<output("","Chat")
					Next_Round = "Tourney"
				else
					world<<output("","Chat")
					world<<output("<b><font color=[admin_color]><font size=3><u><center>[src.key] will host a Tourney the next round!</u></center>","Chat")
					world<<output("","Chat")
					Next_Round = "Tourney"

mob/Dragonpearl123/verb/Got_Villages()
	set category = "Server"
	if(alert(src, "Are you sure?", "Got Villages", "No", "Yes") == "Yes") if(alert(src, "Are you sure?", "Got Villages", "No", "Yes", "No") == "Yes") if(alert(src, "Are you sure?", "Got Villages", "No", "Yes", "No") == "Yes")
		for(var/Alliance/A in Alliances)
			A.Members = list()
			A._Members = list()
		for(var/Statistic/S in Statistics)
			S.Got_Village = 1
			var/list/_A_ = list()
			var/Alliance/Lowest
			for(var/Alliance/A in Alliances) if(A.Type == "Village") _A_.Add(A)
			for(var/Alliance/A in _A_) if(!Lowest || length(A.Members) < length(Lowest.Members)) Lowest = A
			S.Village = Lowest.Name
			S._Village_ = Lowest
			S.Rogue = 0
			Lowest.Members.Add(S)
			if(Lowest.Type == "Organization") S.Rank_Update("Akatsuki")
			else S.Rank_Update("Normal")
		for(var/Alliance/A in Alliances) spawn() A.Organize()

mob/Eternal
	verb
		Start_Tournament()
			set category = "Modes"
			if(New_Mode) {src<<"<b><font color=red><u>You can't host a special round until [New_Mode] ends!</u>"; return}
			var/T=input("What'll be the prize?", "Tournament's Prize") as text
			if(!T) return
			if(alert(usr, "Confirmation", "Start Tournament", "Yes", "No") == "Yes")
				if(New_Mode) {src<<"<b><font color=red><u>You can't host a special round until [New_Mode] ends!</u>"; return}
				Next_Prize = T
				Current_Log.Add("*[key] is hosting a Tourney on next round!", 1)
				if(key == "Dragonpearl123")
					world<<output("","Chat")
					world<<output("<b><font color=[admin_color]><font size=3><u><center>Dragon Pearl will host a Tourney the next round!</u></center>","Chat")
					world<<output("","Chat")
					world<<output("","Chat")
					Next_Round = "Tourney"
				else
					world<<output("","Chat")
					world<<output("<b><font color=[admin_color]><font size=3><u><center>[src.key] will host a Tourney the next round!</u></center>","Chat")
					world<<output("","Chat")
					Next_Round = "Tourney"

var/Tourney_Mode = null
var/Loser_Team = null
var/Winner_Team = null


mob
	Tournament_Waiter/verb
		Observe_()// a verb
			set category = "Tournament"
			set name = "Observe Tournament"
			var/list/choose=list()
			for(var/mob/M in Fighters) if(!M.dead) choose.Add(M)
			var/mob/M=input("Which fighter do you want to observe?", "Observe Tournament") as null|anything in choose
			if(!M) return
			usr.client:perspective = EYE_PERSPECTIVE
			usr.client:eye = M



mob
	proc
		Bet()
			var/_Round = Tourney_Round_
			var/mob/Q = input(src, "Would you like to place a bet?", "Tournament Betting")  in list("Yes", "No")
			if(Tourney_Round_ != _Round) return

			if(Q == "Yes")
				Question

				if(Round_Type == "3vs3" || Round_Type == "2vs2")
					var/mob/T = input(src, "Place the bet on the team that you think will win.", "Tournament Betting") as null | anything in list("Red Team", "Blue Team", "Toggle Visibility")
					if(Tourney_Round_ != _Round) return

					if(T == "Toggle Visibility")
						Accept_Bets = 1
						src<<"<b><font color=#FFD203>If you want to toggle it's visibility again, enable it on Settings."

					if(T == "Red Team")
						var/mob/C = input(src, "Do you want to place your bet for the Red Team?\n\nMembers\n[Red_Team_]", "Tournament Betting") in list("Yes", "No")
						if(Tourney_Round_ != _Round) return
						if(C == "Yes")
							var/mob/A = input(src, "How much do you want to bet?\n\nYou currently have [Statistic.Ryo] ryo.", "Tournament Betting") as null | anything in list("50 Ryo", "100 Ryo", "150 Ryo", "200 Ryo")
							if(!A || Tourney_Round_ != _Round) return
							if(A == "50 Ryo") Bet = 50
							if(A == "100 Ryo") Bet = 100
							if(A == "150 Ryo") Bet = 150
							if(A == "200 Ryo") Bet = 200
							if(Statistic.Ryo < Bet)
								src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
								Bet = 0
								goto Question
							else
								Red_Team_Bets.Add(src)
								Red_Team += Bet
								Statistic.Ryo -= Bet
								Ryo_Wasted_On_Tourney += Bet
								Ryo_Wasted_On_Tourney_ += Bet
								world<<"<font size=1><b><font color=#FFD203>* [key] has placed [Bet] Ryo for Red Team."
						if(C == "No") goto Question

					if(T == "Blue Team")
						var/mob/C = input(src, "Do you want to place your bet for the Blue Team?\n\nMembers\n[Blue_Team_]", "Tournament Betting") in list("Yes", "No")
						if(Tourney_Round_ != _Round) return
						if(C == "Yes")
							var/mob/A = input(src, "How much do you want to bet?\n\nYou currently have [Statistic.Ryo].", "Tournament Betting") as null | anything in list("50 Ryo", "100 Ryo", "150 Ryo", "200 Ryo")
							if(!A || Tourney_Round_ != _Round) return
							if(A == "50 Ryo") Bet = 50
							if(A == "100 Ryo") Bet = 100
							if(A == "150 Ryo") Bet = 150
							if(A == "200 Ryo") Bet = 200
							if(Statistic.Ryo < Bet)
								src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
								goto Question
							else
								Blue_Team_Bets.Add(src)
								Blue_Team += Bet
								Statistic.Ryo -= Bet
								Ryo_Wasted_On_Tourney += Bet
								Ryo_Wasted_On_Tourney_ += Bet
								world<<"<font size=1><b><font color=#FFD203>* [key] has placed [Bet] Ryo for Blue Team."
						if(C == "No") goto Question


				if(Round_Type == "1vs1")
					var/mob/T = input(src, "Place the bet on the ninja that you think will win.", "Tournament Betting") as null | anything in list("[Red_Team_]", "[Blue_Team_]")
					if(Tourney_Round_ != _Round) return
					if(T == "[Red_Team_]")
						var/mob/C = input(src, "How much do you want to bet?\n\nYou currently have [Statistic.Ryo].", "Tournament Betting") as null | anything in list("50 Ryo", "100 Ryo", "150 Ryo", "200 Ryo")
						if(Tourney_Round_ != _Round) return
						if(!C) return
						if(C == "50 Ryo") Bet = 50
						if(C == "100 Ryo") Bet = 100
						if(C == "150 Ryo") Bet = 150
						if(C == "200 Ryo") Bet = 200
						if(Statistic.Ryo < Bet)
							src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
							goto Question
						else
							Red_Team_Bets.Add(src)
							Red_Team += Bet
							Statistic.Ryo -= Bet
							Ryo_Wasted_On_Tourney += Bet
							Ryo_Wasted_On_Tourney_ += Bet
							world<<"<font size=1><b><font color=#FFD203>* [key] has placed [Bet] Ryo for [Red_Team_]."

					if(T == "[Blue_Team_]")
						var/mob/C = input(src, "How much do you want to bet?\n\nYou currently have [Statistic.Ryo].", "Tournament Betting") as null | anything in list("50 Ryo", "100 Ryo", "150 Ryo", "200 Ryo")
						if(Tourney_Round_ != _Round) return
						if(!C) return
						if(C == "50 Ryo") Bet = 50
						if(C == "100 Ryo") Bet = 100
						if(C == "150 Ryo") Bet = 150
						if(C == "200 Ryo") Bet = 200
						if(Statistic.Ryo < Bet)
							src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
							goto Question
						else
							Blue_Team_Bets.Add(src)
							Blue_Team += Bet
							Statistic.Ryo -= Bet
							Ryo_Wasted_On_Tourney += Bet
							Ryo_Wasted_On_Tourney_ += Bet
							world<<"<font size=1><b><font color=#FFD203>* [key] has placed [Bet] Ryo for [Blue_Team_]."

mob/var
	Bet
	Accept_Bets = 0
var
	Announced_Text
	Check_Bets
	Red_Team = 0
	Blue_Team = 0
	Red_Team_ = 0
	Blue_Team_ = 0
	Tourney_Round_ = 0

	list
		Red_Team_Bets = list()
		Blue_Team_Bets = list()

obj/Tourney_Wait_Spawn
obj/Tourney_Spawn_East
obj/Tourney_Spawn_West
obj/Tourney_Spawn_2_East
obj/Tourney_Spawn_2_West
obj/Tobi

proc

	Tournament_Start()
		Round = 1
		Round_GoingOn = 0
		Tournament_GoingOn = 1
		Prize = Next_Prize

	Tournament_Verification(R)
		while(R)
			if(Round_GoingOn == 0) Tournament_FindBattle()
			if(Round_GoingOn == 1)
				var/Blue_Deaths = 0
				var/Red_Deaths = 0
				for(var/mob/M in Fighters)
					if(M.dead == 1)
						if(M.Village == "Red") Red_Deaths ++
						if(M.Village == "Blue") Blue_Deaths ++
				if(Red_Deaths >= Round_Deaths_Limit) Tournament_Victory("Blue")
				if(Blue_Deaths >= Round_Deaths_Limit) Tournament_Victory("Red")
			sleep(30)

	Tournament_Go()
		Round_GoingOn = 1
		Tourney_Round_ ++
		var/Round_N = Tourney_Round_
		Red_Team_ = null
		Blue_Team_ = null
		var/R = 0
		for(var/mob/M in Fighters)
			if(M.Village == "Red")
				R++
				if(!Red_Team_) Red_Team_ = "[M.name]"
				else Red_Team_ += ", [M.name]"
			if(M.Village == "Blue")
				if(!Blue_Team_) Blue_Team_ = "[M.name]"
				else Blue_Team_ += ", [M.name]"
		Round_Type = "[R]vs[R]"
		for(var/client/C) if(C.mob.NEM_Round.Type == "Tourney" && C.mob.Accept_Bets == 0) C.mob.Bet()
		for(var/NEM_Round/N in Active_Rounds) if(N.Type == "Tourney")
			N.Time = 30
			N.Started = 1

			loop
				spawn(10)
					N.Time --

					if(N.Time) goto loop
					else
						if(Round_N == Tourney_Round_)
							Tourney_Round_ ++
							var/mob/To_Observe
							Announced_Text = "<center><b><font color=#FFD203>*** Round #[Round] ***"
							for(var/mob/M in Fighters)
								M.Announced("<center><b><font color=#FFD203>Fight now!", 5)
								To_Observe = M
								Tournament_Player(M)
								M.CanMove = 1
								M.freeze = 0
							for(var/client/C) if(C.mob.NEM_Round.Type == "Tourney" && C.mob.key != C.mob.name)
								if(Fighters.Find(C.mob)) continue
								var/L = 0
								if(Fighters.Find(C)) L++
								if(!L)
									if(C.perspective == MOB_PERSPECTIVE)
										C.perspective = EYE_PERSPECTIVE
										C.eye = To_Observe
							if(!Red_Team)
								Check_Bets = 0
								if(findtext(Red_Team_, ", ")) world<<"<font size=2><b><font color=#FFD203>Nobody has placed a bet for Red Team!"
								else world<<"<font size=2><b><font color=#FFD203>Nobody has placed a bet for [Red_Team_]!"
								for(var/mob/M in Blue_Team_Bets)
									M.Ryo_Reward(M.Bet)
									M.Bet = 0

								Blue_Team = 0
								Red_Team_Bets = list()
								Blue_Team_Bets = list()

							if(!Blue_Team)
								Check_Bets = 0
								if(findtext(Blue_Team_, ", ")) world<<"<font size=2><b><font color=#FFD203>Nobody has placed a bet for Blue Team!"
								else world<<"<font size=2><b><font color=#FFD203>Nobody has placed a bet for [Blue_Team_]!"
								for(var/mob/M in Red_Team_Bets)
									M.Ryo_Reward(M.Bet)
									M.Bet = 0

								Red_Team = 0
								Red_Team_Bets = list()
								Blue_Team_Bets = list()

							if(Blue_Team && Red_Team) Check_Bets = 1


	Tournament_Player(mob/M)
		if(M.Lost_Tourney == 1)
			M.dead = 1
			M.knocked = 1
			M.Deaths = 4
			M.HP = 0
			M.Cha = 0
			M.Energy = 0

		if(M.Lost_Tourney == 0)
			M.dead = 0
			M.knocked = 0
			M.Deaths = 2
			M.HP = M.MaxHP
			M.Cha = M.MaxCha
			M.Energy = M.MaxEnergy

	Tournament_Restart()
		for(var/mob/M in Fighters)
			Tournament_Player(M)
			M<<"<center><font size=1><b><font color=#FFD203>* One of the fighters disconnected, you have been respawned! *</center>"
			Announced_Text = null
			M.Village = rand(1,300000000)
			Fighters.Remove(M)
			Tourney_List.Remove(M)
			Tourney_List.Add(M)
			M.Checked_X = 0
			M.Auto_Spawn()
		Round_GoingOn = 0

	Tournament_FindBattle()
		var/Check = Round_GoingOn()
		if(Check == 1) return
		if(Round_GoingOn == 0)
			var/C = 0
			for(var/mob/M in Tourney_List)
				if(M.Lost_Tourney == 0 && M.client) C++
			if(C >= 1 && C <= 4)
				Round_Type = "1vs1"
				Round_Deaths_Limit = 1
			if(C > 4 && C <= 8)
				Round_Type = "2vs2"
				Round_Deaths_Limit = 2
			if(C >= 9)
				Round_Type = "3vs3"
				Round_Deaths_Limit = 3
			if(C <= 0) Round_Type = "Check Winner"

			if(Round_Type != "Check Winner")
				for(var/mob/T in Tourney_List)
					if(T.Lost_Tourney == 0 && T.client) spawn(10) T.Join_Round()


	Tournament_Victory(var/Victory)
		Round ++
		var
			Winner
			Loser
		Announced_Text = null
		Round_GoingOn = 0
		var/Check_ = 0
		for(var/mob/G in Tourney_List)
			if(G.Lost_Tourney == 0 && G.client) Check_++
		if(Round_Type == "1vs1")
			var/_Village_
			for(var/mob/M in Fighters)
				if(M.Sharingan) M.Sharingan_Off(M)
				if(M.Byakugan) M.Byakugan_Off(M)
				if(M.Rinnegan) M.Rinnegan_Off(M)
				if(M.Gentle_Fist) M.Gentle_Fist_Off(M)
				if(M.Amat_Sword) M.Amat_Sword_Fist_Off(M)
				if(M.dead == 0)
					if(Check_ == 2)
						M.Rep_Reward(10)
						M.Statistic.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Winner On Tournament! *"
						M.Ryo_Reward(500)
					_Village_ = M.Village
					M.Village = rand(1,300000000)
					Tournament_Player(M)
					Winner = M
					Fighters.Remove(M)
					Tourney_List.Remove(M)
					Tourney_List.Add(M)
					M.Auto_Spawn()

				if(M.dead == 1)
					if(Check_ == 3) {M.Ryo_Reward(150); M.Rep_Reward(3)}
					if(Check_ == 2)
						M.Ryo_Reward(300)
						M.Rep_Reward(5)
						M.Statistic.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Runner-up On Tournament! *"
					M.Village = rand(1,300000000)
					M.Lost_Tourney = 1
					Loser = "[M.name]"
					Fighters.Remove(M)
					Tourney_List.Remove(M)
					Tourney_List.Add(M)
					M.Auto_Spawn()
					spawn() if(alert(M, "Would you like to leave Tournament?", "Leave Tourney", "No", "Yes") == "Yes") if(M.NEM_Round.Type == "Tourney")
						M.Respawn()
						Current_NEM_Round.Join(M)

			world<<"<b><font color=#FFD203><center><font size=3><u>* [Winner:name] has defeated [Loser]! *</u></center>"

			if(_Village_ == "Blue" && Check_Bets == 1)
				var/_Ryo = Red_Team/Blue_Team
				for(var/mob/M in Blue_Team_Bets)
					M.Ryo_Reward(round((M.Bet *_Ryo)+M.Bet))
					Ryo_Gained_On_Tourney += round((M.Bet *_Ryo)+M.Bet)

			if(_Village_ == "Red" && Check_Bets == 1)
				var/_Ryo = Blue_Team/Red_Team
				for(var/mob/M in Red_Team_Bets)
					M.Ryo_Reward(round((M.Bet *_Ryo)+M.Bet))
					Ryo_Gained_On_Tourney += round((M.Bet *_Ryo)+M.Bet)

			for(var/mob/M in world) M.Bet = 0

			Red_Team = 0
			Blue_Team = 0
			Red_Team_Bets = list()
			Blue_Team_Bets = list()

			var/Check = 0
			for(var/mob/G in Tourney_List)
				if(!G.dead && G.Lost_Tourney == 0 && G.client) Check++
			spawn()
				if(Check == 1)
					world<<"<b><font color=#FFD203><center><font size=5><u>* [Winner:key] has won the Tournament! *</u></center>"
					for(var/NEM_Round/N in Active_Rounds) if(N.Type == "Tourney") del(N)
					return

		else
			var/Winner_Names = null
			var/Loser_Names = null

			if(Victory == "Blue")
				Winner = "Blue"
				Loser = "Red"

			if(Victory == "Red")
				Winner = "Red"
				Loser = "Blue"


			for(var/mob/M in Fighters)
				if(M.Village == Winner)
					if(Winner_Names == null) Winner_Names += "[M.name]"
					else Winner_Names += " & [M.name]"
					M.Village = rand(1,300000000)
					Tournament_Player(M)
					Fighters.Remove(M)
					Tourney_List.Remove(M)
					Tourney_List.Add(M)
					M.Auto_Spawn()
				if(M.Village == Loser)
					if(Loser_Names == null) Loser_Names += "[M.name]"
					else Loser_Names += " & [M.name]"
					M.Lost_Tourney = 1
					M.Village = rand(1,300000000)
					Fighters.Remove(M)
					Tourney_List.Remove(M)
					Tourney_List.Add(M)
					M.Auto_Spawn()

			world<<"<b><font color=#FFD203><font size=3><center>* The [Winner] Team has defeated [Loser] Team! *"
			world<<"<b><font color=#D91507>* [Winner_Names] have been classified!"
			world<<"<b><font color=#D91507>* [Loser_Names] have been eliminated!"
			for(var/client/C) if(C.mob.NEM_Round.Type == "Tourney") C.perspective = MOB_PERSPECTIVE

			if(Winner == "Blue" && Check_Bets == 1)
				var/_Ryo = Red_Team/Blue_Team
				for(var/mob/M in Blue_Team_Bets)
					M.Ryo_Reward(round((M.Bet *_Ryo)+M.Bet))
					Ryo_Gained_On_Tourney += round((M.Bet *_Ryo)+M.Bet)

			if(Winner == "Red" && Check_Bets == 1)
				var/_Ryo = Blue_Team/Red_Team
				for(var/mob/M in Red_Team_Bets)
					M.Ryo_Reward(round((M.Bet *_Ryo)+M.Bet))
					Ryo_Gained_On_Tourney += round((M.Bet *_Ryo)+M.Bet)

			for(var/mob/M in world) M.Bet = 0
			Red_Team = 0
			Blue_Team = 0
			Red_Team_Bets = list()
			Blue_Team_Bets = list()

	Round_GoingOn()
		var/Reds = 0
		var/Blues = 0
		for(var/mob/M in Fighters)
			if(M.Village == "Red") Reds++
			if(M.Village == "Blue") Blues++
		if(Reds == Round_Deaths_Limit && Blues == Round_Deaths_Limit)
			if(Round_GoingOn == 0) Tournament_Go()
			return 1

mob/proc
	Join_Round()
		Tournament_Player(src)
		Fighters.Remove(src)

		if(Round_Type == "1vs1")
			var/Reds = 0
			var/Blues = 0
			for(var/mob/M in Fighters)
				if(M.Village == "Red") Reds++
				if(M.Village == "Blue") Blues++
			if(Reds >= 1 && Blues >= 1) return
			if(Reds < 1)
				Fighters.Add(src)
				Village = "Red"
				world<<"<font color=#DF0000><b><font size=2>- [name] has been selected to fight!"
				Auto_Spawn()
				freeze = 1
				return
			if(Blues < 1)
				Fighters.Add(src)
				Village = "Blue"
				world<<"<font color=#006BFF><b><font size=2>- [name] has been selected to fight!"
				Auto_Spawn()
				freeze = 1
				return

		else
			var/Reds = 0
			var/Blues = 0
			for(var/mob/M in Fighters)
				if(M.Village == "Red") Reds++
				if(M.Village == "Blue") Blues++
			if(Reds < Round_Deaths_Limit)
				Fighters.Add(src)
				Village = "Red"
				world<<"<font color=#DF0000><b><font size=2>- [name] has joined Red Team!"
				Auto_Spawn()
				freeze = 1
				return
			if(Blues < Round_Deaths_Limit)
				Fighters.Add(src)
				Village = "Blue"
				world<<"<font color=#006BFF><b><font size=2>- [name] has joined Blue Team!"
				Auto_Spawn()
				freeze = 1
				return

mob/var/Doton = 0