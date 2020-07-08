mob/var/Squad/Squad
mob/var/Squad_Cooldown
mob/var/KoTH_Area
mob/var/Just_Updated
mob/var/Zones/_Squad_Area
var/list/Zones = list()
var/A1 = new/Zones ("Waterfall Zone")
var/A2 = new/Zones ("Dried Lake Zone")
var/A3 = new/Zones ("Mountain Zone")
var/A4 = new/Zones ("Snake Tunnel Zone")
var/A5 = new/Zones ("Underground Temple Zone")
var/A6 = new/Zones ("Jungle Zone")
var/A7 = new/Zones ("Outskirts Zone")
var/A8 = new/Zones ("Sky Fortress Zone")
var/A9 = new/Zones ("Swamp Cave Zone")



var
	list/Squads = list()
	list/_Squad_Colors_ = list("R", "B", "G", "Y", "C", "P", "PU", "BO")
	list/_Colors_ = list("R", "B", "G", "Y", "C", "P", "PU", "BO")

obj/KoTH_Flag
	layer = 85
	dir = EAST
	icon = 'Graphics/Flags.dmi'
	var/Color_Assigned
	New()
		..()
		if(length(_Colors_) >= 1)
			Color_Assigned = pick(_Colors_)
			_Colors_.Remove(Color_Assigned)
		dir = pick(EAST, WEST)

Zones
	var
		list/_Ninjas_ = list()
		Squad/Captured
		Squad/Squad_In
		Squad/Capturing
		Stage
		Time
		name

	New(_Name)
		..()
		Zones.Add(src)
		name = _Name

	proc

		Check_Status(var/NEM_Round/G)
			..()

			loop
				if(!G) return

				if(Captured) Captured.Points += 0.1

				Squad_In = null
				var/_Extra_ = 0
				var/_Enemies_ = 0
				var/Can_Capture = 1
				for(var/mob/M in _Ninjas_)
					if(M.loc.name != name) {Leave(M); continue}
					if(M.Dragonned || M.dead || M.knocked) continue
					_Enemies_ ++
					/*if(Captured)
						Stage = 1
						if(M.Squad && M.Squad == Captured)
							Can_Capture = 0
							continue*/
					if(!Squad_In && M.Squad) Squad_In = M.Squad
					else if(Squad_In && M.Squad && M.Squad != Squad_In) Can_Capture = 0
					_Extra_ ++

				if(_Enemies_)
					if(Can_Capture && Squad_In)

						if(Captured)
							if(Squad_In == Captured)
								if(Time < 15) Time += _Extra_
								if(Time > 15) Time = 15
							else
								if(Time)
									Stage = 2
									Time -= _Extra_
									if(!Time || Time <= 0)
										G.Ninjas<<"<font color=[admin_color]><b><font size=3><u>* [name] has been reverted!</u>"
										Captured = null
										for(var/obj/KoTH_Flag/K) if(K.loc.name == name) K.icon_state = null

						else if(!Captured)
							Stage = 3
							if(Capturing == Squad_In)
								Time += _Extra_
								if(Time >= 30)
									Time = 15
									Captured = Squad_In
									for(var/obj/KoTH_Flag/K) if(K.loc.name == name) K.icon_state = Squad_In.Color
									G.Ninjas<<"<font color=[admin_color]><b><font size=3><u>* [name] has been captured by Squad [Squad_In.Name]!</u>"
							else
								if(!Capturing || Time <= 0)
									Capturing = Squad_In
									Time += _Extra_
								else Time -= _Extra_
				if(_Enemies_) spawn(10) goto loop
				else spawn(30) goto loop

		Join(mob/M)
			if(_Ninjas_.Find(M)) return
			_Ninjas_.Add(M)
			M._Squad_Area = src
			M<<"<b><font color=[admin_color]><u><font size=2>You've entered [src]!</u>"

		Leave(mob/M)
			_Ninjas_.Remove(M)
			M._Squad_Area = null
			M<<"<b><font color=[admin_color]><u><font size=2>You've left [src]!</u>"


turf/KoTH

	var/Zones/To_Check

	Waterfall_Zone
		New() {..(); To_Check = A1; name = To_Check.name}
	Dried_Lake_Zone
		New() {..(); To_Check = A2; name = To_Check.name}
	Mountain_Zone
		New() {..(); To_Check = A3; name = To_Check.name}
	Snake_Tunnel_Zone
		New() {..(); To_Check = A4; name = To_Check.name}
	Underground_Temple_Zone
		New() {..(); To_Check = A5; name = To_Check.name}
	Jungle_Zone
		New() {..(); To_Check = A6; name = To_Check.name}
	Outskirts_Zone
		New() {..(); To_Check = A7; name = To_Check.name}
	Sky_Fortress_Zone
		New() {..(); To_Check = A8; name = To_Check.name}
	Swamp_Cave_Zone
		New() {..(); To_Check = A9; name = To_Check.name}


	Entered(mob/M)
		if(ismob(M)) if(M.client && M.Squad && !M.Just_Updated)
			M.Just_Updated ++
			spawn(5) M.Just_Updated --
			To_Check.Join(M)
		..()

mob/Dragonpearl123/verb/Check (mob/M)
	src<<"<font color=red><u><b>Target = [M.Target]; Frozen = [M.freeze]; Moving = [M.Moving]"
	src<<"<font color=red><u><b>Round = [M.NEM_Round.Mode]"

mob/verb

	Join_Squad()
		set hidden = 1
		if(NEM_Round.Type != "King Of The Hill") return
		if(Squad) {Announced("<font color=#609BF2><b><u>* You're already in Squad [Squad.Name]!", 7); return}
		if(Squad_Cooldown > world.realtime) {Announced("<font color=#609BF2><b><u>* Please wait...", round(Squad_Cooldown -world.realtime)); return}

		var/list/_Squads_ = list()
		for(var/Squad/S in Squads) if(length(S.Members) < 4) _Squads_.Add(S.Name)
		var/Squad/_Squad = input(src, "Which Squad would you like to join?", "Join Squad") as null | anything in _Squads_

		if(Squad_Cooldown > world.realtime) {Announced("<font color=#609BF2><b><u>* Please wait...", round(Squad_Cooldown -world.realtime)); return}
		if(Squad) return

		Squad_Cooldown = world.realtime +100
		for(var/Squad/S in Squads) if(S.Name == _Squad)
			var/mob/Player = S.Leader
			var/Confirmation = input(Player, "[src] wants to join your Squad!\n\nAccept?", "[src]'s Request") in list("Yes", "No")
			if(NEM_Round.Type != "King Of The Hill" || Player.NEM_Round.Type != "King Of The Hill") return
			if(Squad) {Announced("<font color=#609BF2><b><u>* You're already in Squad [Squad.Name]!", 7); return}

			if(!Player.Squad || !S || S.Leader != Player) return
			if(length(Player.Squad.Members) >= 4) return
			if(Confirmation == "Yes") Player.Squad.Join(src)
			else Announced("<font color=#609BF2><b><u>* [Player.key] has rejected your request!", 7)

	Leave_Squad()
		set hidden = 1
		if(NEM_Round.Type != "King Of The Hill") return
		if(!Squad) return
		var/Confirmation = input(src, "Are you sure?\n\nLeaving Squad [Squad.Name]", "Leave Squad") in list("Yes", "No")
		if(NEM_Round.Type != "King Of The Hill" || Squad) return
		if(!Squad) return
		if(Confirmation == "Yes") Squad.Leave(src)

	Invite_Squad_Member()
		set hidden = 1
		if(NEM_Round.Type != "King Of The Hill") return
		if(!Squad || Squad.Leader != src) return
		if(Squad.Cooldown > world.realtime) {Announced("<font color=#609BF2><b><u>* Please wait...", round(Squad.Cooldown -world.realtime)); return}
		if(length(Squad.Members) >= 4) {Announced("<font color=#609BF2><b><u>* Your Squad is full!", 7); return}

		var/list/Ninjas = list()
		for(var/mob/Ninja in NEM_Round.Ninjas) if(Ninja.client && !Ninja.Squad) Ninjas.Add(Ninja)
		var/mob/Player = input("Who would you like to invite to your Squad?", "Invite Member") as null | anything in Ninjas
		if(!Player) return

		if(!Squad || Squad.Leader != src || Player.Squad) return
		if(length(Squad.Members) >= 4) {Announced("<font color=#609BF2><b><u>* Your Squad is full!", 7); return}
		if(Squad.Cooldown > world.realtime) {Announced("<font color=#609BF2><b><u>* Please wait...", round(Squad.Cooldown -world.realtime)); return}

		Squad.Cooldown = world.realtime +150
		var/Confirmation = input(Player, "Would you like to join Squad [Squad.Name]?", "[Squad.Name]'s Invitation") in list("Yes", "No")
		if(!Squad || Squad.Leader != src || Player.Squad || Player.NEM_Round.Type != "King Of The Hill" || NEM_Round.Type != "King Of The Hill") return
		if(length(Squad.Members) >= 4) {Announced("<font color=#609BF2><b><u>* Your Squad is full!", 7); return}
		if(Confirmation == "Yes")
			if(Player.Squad) {Player.Announced("<font color=#609BF2><b><u>* You're already in Squad [Squad.Name]!", 7); Announced("<font color=#609BF2><b><u>* [Player.key] has rejected your invitation!", 7); return}
			Squad.Join(Player)
		else Announced("<font color=#609BF2><b><u>* [Player.key] has rejected your invitation!", 7)

	Kick_Squad_Member()
		set hidden = 1
		if(NEM_Round.Type != "King Of The Hill") return
		if(!Squad || Squad.Leader != src) return
		var/list/Ninjas = list()
		for(var/mob/Ninja in Squad.Members) if(Ninja != src) Ninjas.Add(Ninja)
		var/mob/Player = input("Who would you like to kick off your Squad?", "Kick Member Member") as null | anything in Ninjas
		if(!Player) return
		var/Confirmation = input(src, "Are you sure?\n\nKicking [Player]", "Kick Member") in list("Yes", "No")
		if(!Squad || Squad.Leader != src || !Player.Squad || Player.Squad != Squad) return
		if(Confirmation == "Yes") Squad.Leave(Player)

	Form_Squad()
		set hidden = 1
		if(NEM_Round.Type != "King Of The Hill") return
		if(Squad) {Announced("<font color=#609BF2><b><u>* You're already in Squad [Squad.Name]!", 7); return}
		var/Name = input(src, "What will be your Squad's name?\n\nCharacters Limit: 18", "Create Squad") as text
		if(Squad) {Announced("<font color=#609BF2><b><u>* You're already in Squad [Squad.Name]!", 7); return}
		if(!Name || length(Name) <= 3 || length(Name) >= 18 || FilterText(Name, ADList)) {Announced("<font color=#609BF2><b><u>* Your Squad's name is not allowed!", 7); return}
		for(var/Squad/S in Squads) if(S.Name == Name) {Announced("<font color=#609BF2><b><u>* This name has been already picked!", 7); return}
		if(length(Squads) == 8) {Announced("<font color=#609BF2><b><u>* There are too many Squads!", 7); return}
		if(alert(src, "Are you sure?\n\nSquad's Name: [Name]", "Create Squad", "No", "Yes") == "Yes")
			if(NEM_Round.Type != "King Of The Hill" || Squad) return
			if(Squad) {Announced("<font color=#609BF2><b><u>* You're already in Squad [Squad.Name]!", 7); return}
			new/Squad (src, Name)

	Disband_Squad()
		set hidden = 1
		if(NEM_Round.Type != "King Of The Hill") return
		if(!Squad || Squad.Leader != src) return
		var/Confirmation = input(src, "Are you sure?\n\nDisbanding Squad [Squad.Name]", "Disband Squad") in list("Yes", "No")
		if(NEM_Round.Type != "King Of The Hill" || Squad) return
		if(!Squad || Squad.Leader != src) return
		if(Confirmation == "Yes") del(Squad)

Squad
	var
		Points
		Name
		Color
		mob/Leader
		list/Members = list()
		Cooldown

	New(mob/_Leader, _Name)
		..()
		_Leader.NEM_Round.Ninjas<<"<b><font color=[admin_color]><u>* [_Leader.key] has created Squad [_Name]!</u>"
		Color = pick(_Squad_Colors_)
		_Squad_Colors_.Remove(Color)
		Leader = _Leader
		Name = _Name
		Join(Leader)
		Squads.Add(src)

	Del(G)
		if(G)
			Leader.NEM_Round.Ninjas<<"<b><font color=[admin_color]><u>* [Leader.key] has disbanded Squad [Name]!</u>"
			for(var/mob/M in Members) Leave(M)

		for(var/Zones/K in Zones) if(K.Captured == src)
			K.Captured = null
			K.Squad_In = null
			K.Stage = 0
			K.Time = 0
			for(var/obj/KoTH_Flag/F) if(F.icon_state == Color) F.icon_state = null
		_Squad_Colors_.Add(Color)
		Squads.Remove(src)
		..()

	proc
		Join(mob/Member)
			Member.Village = "Squad [Name]"
			Members.Add(Member)
			Member.Squad = src
			Member.Update_Squad_Window()
			new/obj/Effects/Player_Icon (Member.loc, Member)
			if(Member != Leader) for(var/mob/M in Members) M.Announced("<font color=#609BF2><b><u>* [Member] has joined the Squad!", 7)

		Leave(mob/Member)
			if(Member != Leader) for(var/mob/M in Members) M.Announced("<font color=#609BF2><b><u>* [Member] has left the Squad!", 7)
			Member.Village = rand(1, 300000)
			Members.Remove(Member)
			Member.Squad = null
			Member.Update_Squad_Window()
			for(var/obj/Effects/Player_Icon/P in Member.Overlays) del(P)

			var/T
			for(var/mob/M in Members)
				T++
				for(var/obj/Effects/Player_Icon/P in M.Overlays) P.icon_state = "[T][Color]"

mob/proc/Update_Squad_Window()
	if(client)

		if(!Squad)
			winset(src, "Squads.Join Button","is-visible=true")
			winset(src, "Squads.Join Button","text='Join Squad'")
			winset(src, "Squads.Join Button","command=Join-Squad")
			winset(src, "Squads.Form Button","is-visible=true")
			winset(src, "Squads.Form Button","text='Form Squad'")
			winset(src, "Squads.Form Button","command=Form-Squad")
			winset(src, "Squads.Leave Button","text='Leave Squad'")
			winset(src, "Squads.Leave Button","command=Leave-Squad")

		else
			if(Squad.Leader == src)
				winset(src, "Squads.Form Button","text='Disband Squad'")
				winset(src, "Squads.Form Button","command=Disband-Squad")
				winset(src, "Squads.Leave Button","text='Kick Member'")
				winset(src, "Squads.Leave Button","command=Kick-Squad-Member")
				winset(src, "Squads.Join Button","text='Invite Member'")
				winset(src, "Squads.Join Button","command=Invite-Squad-Member")
			else
				winset(src,"Squads.Join Button","is-visible=false")
				winset(src, "Squads.Form Button","is-visible=false")