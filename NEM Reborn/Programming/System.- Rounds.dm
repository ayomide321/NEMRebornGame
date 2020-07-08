mob/var/tmp/NEM_Round/NEM_Round
mob/var/tmp/NEM_Side/NEM_Side
var/tmp/NEM_Side/Leaf
var/tmp/NEM_Side/Akatsuki
var/list/_Active_Missions_ = list()

var/New_Mode
var/Question_Number
var/Question_Time
mob/var/Question_Alert

proc

	Start_New_Round()
		New_Mode = Next_Round
		Next_Round = null

		for(var/NEM_Round/R in Active_Rounds) if(Arena != R) del(R)
		for(var/mob/M in world) M.Respawn()
		Current_NEM_Round = new/NEM_Round ("Normal")

		Ask_Question()
		Characters_Check()
		//if(New_Mode == "Colosseum" || New_Mode == "Tourney") spawn() AFK_Check_Process()
		spawn()
			if(New_Mode == "King Of The Hill") {Question_Time = 1500; new/NEM_Round ("Normal", "King Of The Hill")}
			if(New_Mode == "Tourney") {Question_Time = 10; new/NEM_Round ("Normal", "Tourney")}

	Ask_Question()
		Question_Time = 45
		Question_Number = rand(1, 999999)
		var/QN = Question_Number
		for(var/client/M) spawn() M.mob.Question(QN)

		loop
			Question_Time --
			if(Question_Time) spawn(10) goto loop

			else
				Question_Number = 0
				for(var/client/C)
					winshow(C, "Round Alert", 0)
					if(C.mob.Question_Alert == 1)
						if(C.mob.key != C.mob.name && !C.mob.dead) continue
						Current_NEM_Round.Join(C.mob)
						C.mob.Respawn()
						C.mob.Question_Alert = 0

mob/proc
	Question(QN, G)
		if(!G)
			CanChoose = 0
			Question_Alert = 1
			On_Special_Character_Screen = 1
			Current_NEM_Round.Join(src)
			loc = locate(278, 10, 2)
			set_pos((x*32)+44, (y*32)+8)

		Center("Round Alert")

	Center(control_id, var/G)
		var/loc_id = "default"
		var/size = winget(src, loc_id, "pos")
		var/F = findtext(size, ",")
		var/x = text2num(copytext(size,1,F))
		var/y = text2num(copytext(size,F+1, 100))
		if(G == 3) winset(src, control_id, "pos=[x+5],[y+5]") // Statistics
		else if(G == 4) winset(src, control_id, "pos=[x+216],[y+50]") // Villages
		else if(G == 5)
			if(control_id != "Introduction") winset(src, control_id, "pos=[x+10],[y+386]") //Logs
			else winset(src, control_id, "pos=[x+288],[y+55]") //Introduction
		else if(G == 6) winset(src, control_id, "pos=[x+216],[y+55]") // Guide
		else if(G == 7) winset(src, control_id, "pos=[x+188],[y+55]") // Rules
		else if(G == 8) winset(src, control_id, "pos=[x+251],[y+33]") //Player Logs

		if(control_id == "Report") winset(src, control_id, "pos=[x+92],[y+55]")
		else if(control_id == "Poll") winset(src, control_id, "pos=[x+311],[y+55]")
		else if(control_id == "Lucky Number") winset(src, control_id, "pos=[x+228],[y+55]")
		else if(control_id == "Menu") winset(src, control_id, "pos=[x+5],[y+5]")
		else if(control_id == "Shop") winset(src, control_id, "pos=[x+170],[y+226]")
		else if(control_id == "Round Alert") winset(src, control_id, "pos=[x+231],[y+55]")
		else if(control_id == "Squads") winset(src, control_id, "pos=[x+341],[y+55]")
		else if(control_id == "Create_Poll") winset(src, control_id, "pos=[x+441],[y+55]")
		else if(control_id == "Chatroom") winset(src, control_id, "pos=[x+5],[y+138]")
		winshow(src, control_id, 1)
		winset(src, "Round Alert.Special_Round", "text='[New_Mode]'")
		if(New_Mode == "Tourney") winset(src, "Round Alert.Special_Round", "command=Question-Tourney")
		else winset(src, "Round Alert.Special_Round", "command=Question-KoTH")

mob/verb
	Question_Decide(S as text)
		set hidden = 1
		if(NEM_Round == Arena) {src<<"<b><font color=red><u>First you have to leave Arena.</u>"; return}
		if(NEM_Round.Mode == "Challenge" || NEM_Round.Type == "King Of The Hill") return
		Question_Alert = 1
		if(!Question_Time || Question_Alert <= 1 && name != key && !dead) return

		if(S == "Main")
			if(NEM_Round == Current_NEM_Round && loc != locate(278, 10, 2)|| NEM_Round.Type == "Tourney" && !Lost_Tourney)
				winshow(src, "Round Alert", 0)
				return
			Question_Alert = 0
			Current_NEM_Round.Join(src)
			Respawn()
		else if(S == NEM_Round.Type) return
		else if(S == "a897d4q9we1fasd") Question_Alert = 2
		else if(S == "qweqwsadasdassa") for(var/NEM_Round/N in Active_Rounds) if(N.Type == "Tourney") {Question_Alert = 0; N.Join(src); Respawn()}
		else if(S == "asdweqewesadaszx") for(var/NEM_Round/N in Active_Rounds) if(N.Type == "King Of The Hill") {Question_Alert = 0; N.Join(src); Respawn()}
		winshow(src, "Round Alert", 0)

	Question_Tourney() {set hidden = 1; Question_Decide("qweqwsadasdassa")}
	Question_KoTH() {set hidden = 1; Question_Decide("asdweqewesadaszx")}

NEM_Round
	var
		Mode
		Type
		Time = 20
		Started
		Stage
		_Spawn
		Cut_Scene
		list/DNJ = list()
		list/Spawns = list()
		list/Objects = list()
		list/Temporal_Turfs = list()
		list/Permanent_Objects = list()
		list/Permanent_Turfs = list()
		list/Groups = list()
		list/Ninjas = list()
		list/Ninjas_ = list()
		list/Scrolls = list()
		list/Images = list()
		list/Picked_Characters = list()
		list/Shurikens = list()
		list/Puppets = list()
		Bijuu_Dama

	New(_Mode, _Type)
		..()
		Type = _Type

		if(Type == "Mission")
			_Active_Missions_.Add(src)
			Mode = _Mode
			Time = 600
			Count_Time()
			for(var/obj/Login_Screen/C in world) if(C.Donator || C.S_Ranked) Picked_Characters.Add(C)
			for(var/obj/Login_Screen/C in world) if(C.name in list("Yondaime", "Jirobo", "Choji", "Neji", "Kakkou", "Sai", "Pein", "Deidara", "Tobi", "Shikamaru")) Picked_Characters.Add(C)

			if(Mode == "Genin Exam")
				Picked_Characters = list()
				for(var/obj/Login_Screen/C in world) if(C.name != "Naruto") Picked_Characters.Add(C)

			else if(Mode == "Escort Gaara")
				for(var/obj/Login_Screen/C in world) if(C.name == "Gaara") Picked_Characters.Add(C)
				Stage = 1
				var/NEM_Side/Good = new/NEM_Side ("Good")
				var/NEM_Side/Evil = new/NEM_Side ("Evil")
				_Spawn = 1
				for(var/obj/Mission_Spawn/M in locate(51, 19, 18)) _Spawn = 2
				if(_Spawn == 2) for(var/obj/Mission_Spawn/M in locate(278, 19, 18)) _Spawn = 3

				if(_Spawn == 1)
					if(src) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(51, 19, 18))); Spawns.Add("Gaara", "Jirobo", "Kidoumaru", "Tayuya", "Sakon", "Kimimaro"); Spawns["Gaara"] = locate(42, 21, 18); Spawns["Jirobo"] = locate(39, 30, 18); Spawns["Kidoumaru"] =  locate(62, 38, 18); Spawns["Tayuya"] =  locate(112, 55, 18); Spawns["Sakon"] =  locate(152, 58, 18); Spawns["Kimimaro"] =  locate(123, 89, 18)}
					if(src) {Objects.Add(new/obj/Red_Rashomon (locate(76, 13, 18))); var/T = 18; while(T >= 13) {var/turf/G = locate(76, T, 18); Temporal_Turfs.Add(G); G.density = 1; T --}}
				else if(_Spawn == 2)
					if(src) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(278, 19, 18))); Spawns.Add("Gaara", "Jirobo", "Kidoumaru", "Tayuya", "Sakon", "Kimimaro"); Spawns["Gaara"] = locate(269, 21, 18); Spawns["Jirobo"] = locate(266, 30, 18); Spawns["Kidoumaru"] =  locate(289, 38, 18); Spawns["Tayuya"] =  locate(339, 55, 18); Spawns["Sakon"] =  locate(379, 58, 18); Spawns["Kimimaro"] =  locate(350, 89, 18)}
					if(src) {Objects.Add(new/obj/Red_Rashomon (locate(303, 13, 18))); var/T = 18; while(T >= 13) {var/turf/G = locate(303, T, 18); Temporal_Turfs.Add(G); G.density = 1; T --}}
				else if(_Spawn == 3)
					if(src) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(51, 19, 19))); Spawns.Add("Gaara", "Jirobo", "Kidoumaru", "Tayuya", "Sakon", "Kimimaro"); Spawns["Gaara"] = locate(42, 21, 19); Spawns["Jirobo"] = locate(39, 30, 19); Spawns["Kidoumaru"] =  locate(62, 38, 19); Spawns["Tayuya"] =  locate(112, 55, 19); Spawns["Sakon"] =  locate(152, 58, 19); Spawns["Kimimaro"] =  locate(123, 89, 19)}
					if(src) {Objects.Add(new/obj/Red_Rashomon (locate(76, 13, 19))); var/T = 18; while(T >= 13) {var/turf/G = locate(76, T, 19); Temporal_Turfs.Add(G); G.density = 1; T --}}

				Groups.Add(Good)
				Groups.Add(Evil)

			else if(Mode == "Capture The Missing Dog")
				for(var/obj/Login_Screen/C in world) if(C.Given_Speed > 1.60) Picked_Characters.Add(C)
				Stage = 1
				var/NEM_Side/Good = new/NEM_Side ("Good")
				var/NEM_Side/Evil = new/NEM_Side ("Evil")
				_Spawn = 1
				for(var/obj/Mission_Spawn/M in locate(93, 29, 16)) _Spawn = 2
				if(_Spawn == 2) for(var/obj/Mission_Spawn/M in locate(102, 29, 9)) _Spawn = 3

				if(_Spawn == 1) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(93, 29, 16))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(103, 26, 16)))}
				else if(_Spawn == 2) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(102, 29, 9))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(112, 26, 9)))}
				else if(_Spawn == 3) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(93, 165, 19))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(103, 162, 19)))}

				Groups.Add(Good)
				Groups.Add(Evil)

			else if(Mode == "Orochimaru's Wrath")
				Stage = 1
				Time = 30
				var/list/Allowed = list()
				for(var/obj/Login_Screen/C in world) if(C.name in list("Naruto", "Sai", "Sakura", "Tenten", "Neji", "Rock Lee", "Kankuro", "Gaara", "Temari", "Shino", "Hinata", "Shikamaru", "Ino", "Kakashi", "Yamato", "Might Gai", "Asuma", "Ebisu")) Allowed.Add(C)
				for(var/obj/Login_Screen/C in world) if(!Allowed.Find(C) && !Picked_Characters.Find(C)) Picked_Characters.Add(C)
				Stage = 1
				if(src) {Spawns.Add(locate(241, 10, 3), locate(243, 10, 3), locate(245, 10, 3), locate(247, 10, 3))}

			if(Mode == "Weed Picking")
				var/NEM_Side/Good = new/NEM_Side ("Good")
				var/NEM_Side/Weeds = new/NEM_Side ("Weeds")
				var/Spawn = 1
				for(var/obj/Mission_Spawn/M in locate(157, 118, 1)) Spawn = 2
				if(Spawn == 2) for(var/obj/Mission_Spawn/M in locate(319, 107, 1)) Spawn = 3

				var/list/C = list()
				var/list/L = list()
				if(Spawn == 1) L = list(locate(234, 123, 1), locate(235, 123, 1), locate(236, 123, 1), locate(237, 123, 1), locate(171, 123, 1), locate(172, 123, 1), locate(173, 123, 1), locate(261, 120, 1), locate(262, 120, 1), locate(263, 120, 1), locate(247, 145, 1), locate(248, 145, 1), locate(249, 145, 1), locate(157, 107, 1), locate(169, 107, 1), locate(183, 107, 1), locate(228, 107, 1), locate(243, 107, 1), locate(247, 107, 1), locate(250, 107, 1), locate(253, 107, 1), locate(256, 107, 1))
				else if(Spawn == 2) L = list(locate(396, 112, 1), locate(397, 112, 1), locate(398, 112, 1), locate(399, 112, 1), locate(319, 96, 1), locate(331, 96, 1), locate(345, 96, 1), locate(390, 96, 1), locate(405, 96, 1), locate(409, 96, 1), locate(412, 96, 1), locate(415, 96, 1), locate(417, 96, 1), locate(419, 96, 1), locate(333, 112, 1), locate(334, 112, 1), locate(335, 112, 1), locate(396, 112, 1), locate(397, 112, 1), locate(398, 112, 1), locate(423, 109, 1), locate(424, 109, 1), locate(425, 109, 1))
				else if(Spawn == 3) L = list(locate(393, 20, 1), locate(394, 20, 1), locate(395, 20, 1), locate(396, 20, 1), locate(316, 4, 1), locate(328, 4, 1), locate(342, 4, 1), locate(387, 4, 1), locate(402, 4, 1), locate(406, 4, 1), locate(408, 4, 1), locate(411, 4, 1), locate(413, 4, 1), locate(416, 4, 1), locate(330, 20, 1), locate(331, 20, 1), locate(332, 20, 1), locate(393, 20, 1), locate(394, 20, 1), locate(395, 20, 1), locate(420, 17, 1), locate(421, 17, 1), locate(422, 17, 1), locate(423, 17, 1))

				if(Spawn == 1) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(157, 118, 1))); var/T = rand(13, 17); while(T) {var/P = pick(L); C.Add(P); L.Remove(P); T --}}
				else if(Spawn == 2) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(319, 107, 1))); var/T = rand(13, 17); while(T) {var/P = pick(L); C.Add(P); L.Remove(P); T --}}
				else if(Spawn == 3) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(316, 15, 1))); var/T = rand(13, 17); while(T) {var/P = pick(L); C.Add(P); L.Remove(P); T --}}
				for(var/G in C) {var/obj/W = new/obj/Weed (); W.loc = G; Weeds.Spawns.Add(W)}

				Groups.Add(Good)
				Groups.Add(Weeds)

			else if(Mode == "Mist Ambush")
				var/NEM_Side/Good = new/NEM_Side ("Good")
				var/NEM_Side/Evil = new/NEM_Side ("Evil")
				var/Spawn = 1
				for(var/obj/Mission_Spawn/M in locate(23, 15, 13)) Spawn = 2
				if(Spawn == 2) for(var/obj/Mission_Spawn/M in locate(185, 15, 13)) Spawn = 3

				if(Spawn == 1) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(23, 15, 13))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(90, 15, 13)))}
				else if(Spawn == 2) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(185, 15, 13))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(252, 15, 13)))}
				else if(Spawn == 3) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(362, 15, 13))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(429, 15, 13)))}
				Groups.Add(Good)
				Groups.Add(Evil)

			else if(Mode == "Curse Revolution")
				var/NEM_Side/Good = new/NEM_Side ("Good")
				var/NEM_Side/Evil = new/NEM_Side ("Evil")
				var/Spawn = 1
				for(var/obj/Mission_Spawn/M in locate(285, 17, 7)) Spawn = 2
				if(Spawn == 2) for(var/obj/Mission_Spawn/M in locate(285, 78, 7)) Spawn = 3

				if(Spawn == 1) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(285, 17, 7))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(345, 19, 7)))}
				else if(Spawn == 2) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(285, 78, 7))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(345, 80, 7)))}
				else if(Spawn == 3) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(138, 105, 7))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(199, 108, 7)))}
				Groups.Add(Good)
				Groups.Add(Evil)

			else if(Mode == "Revenge of the Sound Ninjas")
				var/NEM_Side/Good = new/NEM_Side ("Good")
				var/NEM_Side/Evil = new/NEM_Side ("Evil")
				var/Spawn = 1
				for(var/obj/Mission_Spawn/M in locate(261, 155, 17)) Spawn = 2
				if(Spawn == 2) for(var/obj/Mission_Spawn/M in locate(262, 107, 17)) Spawn = 3

				if(Spawn == 1) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(261, 155, 17))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(356, 155, 17)))}
				else if(Spawn == 2) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(262, 107, 17))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(357, 107, 17)))}
				else if(Spawn == 3) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(262, 61, 17))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(357, 61, 17)))}
				Groups.Add(Good)
				Groups.Add(Evil)

			else if(Mode == "Retrieve Byakugan")
				var/NEM_Side/Good = new/NEM_Side ("Good")
				var/NEM_Side/Evil = new/NEM_Side ("Evil")
				var/Spawn = 1
				for(var/obj/Mission_Spawn/M in locate(30, 184, 17)) Spawn = 2
				if(Spawn == 2) for(var/obj/Mission_Spawn/M in locate(30, 125, 17)) Spawn = 3

				if(Spawn == 1) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(30, 184, 17))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(142, 184, 17)))}
				else if(Spawn == 2) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(30, 125, 17))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(142, 125, 17)))}
				else if(Spawn == 3) {Good.Spawns.Add(new/obj/Mission_Spawn (locate(260, 19, 17))); Evil.Spawns.Add(new/obj/Mission_Spawn (locate(372, 19, 17)))}
				Groups.Add(Good)
				Groups.Add(Evil)

		if(Type == "Tourney")
			Time = 90
			Groups.Add(new/NEM_Side ("Random"))
			for(var/obj/Login_Screen/L in world) if(L.Donator || L.name in list("Kiba", "Hashirama Senju", "Choji", "Tayuya", "Jirobo")) Picked_Characters.Add(L)
			Tournament_GoingOn = 1
			Round_GoingOn = 0
			Next_Round = null
			Tournament_Start()
			Count_Time()
			for(var/NEM_Round/N in Active_Rounds) if(N.Mode == "Normal" && N != src) if(Spawn == 3)
				NextSpawn ++
				Spawn ++
				Groups = list()

				var/NEM_Side/_Leaf = new/NEM_Side ("Allied Shinobis Forces")
				var/NEM_Side/_Akatsuki = new/NEM_Side ("Akatsuki")
				for(var/obj/Leaf_Spawn/S in world) if(Spawn == 1 && S.z == 1 || Spawn == 2 && S.z == 4 || Spawn == 3 && S.z == 7 || Spawn == 4 && S.z == 9 || Spawn == 5 && S.z == 13) {Leaf = _Leaf; _Leaf.Spawns.Add(S)}
				for(var/obj/Akatsuki_Spawn/S in world) if(Spawn == 1 && S.z == 1 || Spawn == 2 && S.z == 4 || Spawn == 3 && S.z == 7 || Spawn == 4 && S.z == 9 || Spawn == 5 && S.z == 13) {Akatsuki = _Akatsuki; _Akatsuki.Spawns.Add(S)}
				N.Groups.Add(_Akatsuki)
				N.Groups.Add(_Leaf)
				_Leaf.Enemy = _Akatsuki
				_Akatsuki.Enemy = _Leaf


		if(Type == "King Of The Hill")
			Time = 1500
			for(var/Zones/Z) Z.Check_Status(src)
			Groups.Add(new/NEM_Side ("Random"))
			for(var/obj/Login_Screen/Pein_Face/L in world) Picked_Characters.Add(L)
			Next_Round = null
			Count_Time()

		if(_Mode == "Challenge")

			var/NEM_Side/West = new/NEM_Side ("West", "West")
			var/NEM_Side/East = new/NEM_Side ("East", "East")
			for(var/obj/Login_Screen/L in world) if(L.Donator || L.Healer) Picked_Characters.Add(L)
			for(var/obj/Challenge/S in world) if(!S.Occupied && S.Direction == EAST && !West.Ready) {S.Occupied = 1; West.Ready = 1; West.Spawns.Add(S)}
			for(var/obj/Challenge/S in world) if(!S.Occupied && S.Direction == WEST && !East.Ready) {S.Occupied = 1; East.Ready = 1; East.Spawns.Add(S)}
			Count_Time()

			West.Enemy = East
			East.Enemy = West
			Groups.Add(West)
			Groups.Add(East)

		else if(_Mode == "Arena")
			var/NEM_Side/Arena = new/NEM_Side ("Arena")
			spawn() for(var/obj/Leaf_Spawn/S in world) if(S.z == 2) Arena.Spawns.Add(S)
			Groups.Add(Arena)

		else if(_Mode == "Normal")

			if(!Type)
				if(!NextSpawn) Spawn = 1
				NextSpawn ++
				if(NextSpawn >= 6) {NextSpawn = 1; Spawn = 1}
				else Spawn = NextSpawn


				var/NEM_Side/_Leaf = new/NEM_Side ("Allied Shinobis Forces")
				var/NEM_Side/_Akatsuki = new/NEM_Side ("Akatsuki")
				for(var/obj/Leaf_Spawn/S in world) if(Spawn == 1 && S.z == 1 || Spawn == 2 && S.z == 4 || Spawn == 3 && S.z == 7 || Spawn == 4 && S.z == 9 || Spawn == 5 && S.z == 13) {Leaf = _Leaf; _Leaf.Spawns.Add(S)}
				for(var/obj/Akatsuki_Spawn/S in world) if(Spawn == 1 && S.z == 1 || Spawn == 2 && S.z == 4 || Spawn == 3 && S.z == 7 || Spawn == 4 && S.z == 9 || Spawn == 5 && S.z == 13) {Akatsuki = _Akatsuki; _Akatsuki.Spawns.Add(S)}
				Groups.Add(_Akatsuki)
				Groups.Add(_Leaf)
				_Leaf.Enemy = _Akatsuki
				_Akatsuki.Enemy = _Leaf

		Mode = _Mode
		Active_Rounds.Add(src)

	Del(var/G)
		_Active_Missions_.Remove(src)
		if(src == Current_NEM_Round) if(G == "Victory" || G == "Lost") return
		if(Scrolls) for(var/S in Scrolls) del(S)
		if(Shurikens) for(var/S in Shurikens) del(S)
		for(var/mob/S in Scrolls) S.Del(1)

		Active_Rounds.Remove(src)

		if(Mode == "Challenge")
			for(var/NEM_Side/N in Groups) for(var/obj/Challenge/C in N.Spawns) C.Occupied = null

			for(var/mob/M in Ninjas) if(M.Real)
				Current_NEM_Round.Join(M)
				M.Visible_Player = 1
				M.Respawn()

		if(Type == "King Of The Hill")
			Score_Time(src)
			New_Mode = null
			var/Points_
			var/Squad/Squad_Winning

			for(var/Squad/S in Squads) if(S.Points > Points_)
				Points_ = S.Points
				Squad_Winning = S

			for(var/mob/M in Ninjas) if(M.Real)
				if(M.Squad)
					if(M.Squad == Squad_Winning) {M.Rep_Reward(5); M.Ryo_Reward((M.Squad.Points/length(M.Squad.Members))*2)}
					else M.Ryo_Reward(M.Squad.Points/length(M.Squad.Members))
				Current_NEM_Round.Join(M)
				M.Respawn()

			world<<"<b><font color=[admin_color]><font size=4><center><u>* King of the Hill has concluded!</u></center>"
			if(Squad_Winning) world<<"<br><br><font color=[admin_color]><font size=3><b>* The Winner Is Squad [Squad_Winning.Name]!</font>"

			for(var/Squad/S in Squads) S.Del(1)


		if(Type == "Tourney")
			Score_Time(src)
			New_Mode = null
			Tournament_GoingOn = 0
			for(var/mob/M in Ninjas) if(M.Real)
				Current_NEM_Round.Join(M)
				M.Respawn()

		if(Type == "Mission")
			if(Started == 3) return
			else {for(var/turf/T in Temporal_Turfs) T.density = 0; for(var/turf/T in Permanent_Turfs) T.density = 0; for(var/obj/O in Objects) del(O)}

			if(G)
				Started = 3
				Time = 0
				var/MTD
				if(Mode == "Weed Picking") MTD = "<font color=#9AFA85><font size=4><b><center>* [Mode] *<br><font size=3>"
				else if(Mode == "Genin Exam") MTD = "<font color=#DFC24A><font size=4><b><center>* [Mode] *<br><font size=3>"
				else if(Mode == "Capture The Missing Dog") MTD = "<font color=#B1EEAC><font size=4><b><center>* [Mode] *<br><font size=3>"
				else if(Mode == "Mist Ambush")  MTD = "<font color=#5D78FF><font size=4><b><center>* [Mode] *<br><font size=3>"
				else if(Mode == "Escort Gaara")  {MTD = "<font color=#E9CD68><font size=4><b><center>* [Mode] *<br><font size=3>"}
				else if(Mode == "Retrieve Byakugan") MTD = "<font color=#E0F5F5><font size=4><b><center>* [Mode] *<br><font size=3>"
				else if(Mode == "Orochimaru's Wrath") MTD = "<font color=#C38DC6><font size=4><b><center>* [Mode] *<br><font size=3>"
				else if(Mode == "Curse Revolution") MTD = "<font color=#89089C><font size=4><b><center>* [Mode] *<br><font size=3>"
				else if(Mode == "Revenge of the Sound Ninjas") MTD = "<font color=#D1D1CF><font size=4><b><center>* [Mode] *<br><font size=3>"
				if(G == "Lost") {for(var/mob/M in Ninjas) if(M.Village == "Good") spawn() M.Mission_Show("[MTD]Mission Failed!"); Ninjas<<output("", "Menu.MissionOutput"); Ninjas<<output("<font color=#B6B6B6><b><font size=3><center><u>Mission Failed!</u></center>", "Menu.MissionOutput"); Ninjas<<output("", "Menu.MissionOutput"); sleep(35)}
				else
					for(var/mob/M in Ninjas) if(M.Village == "Good" && M.client) {spawn() M.Movement(); if(M.Mission_On.Rank == "D") M.Statistic.D_Missions += 1; else if(M.Mission_On.Rank == "C") M.Statistic.C_Missions += 1; else if(M.Mission_On.Rank == "B") M.Statistic.B_Missions += 1; else if(M.Mission_On.Rank == "A") M.Statistic.A_Missions += 1; else if(M.Mission_On.Rank == "S") M.Statistic.S_Missions += 1; else if(M.Mission_On.Rank == "E") {M.Statistic.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Promoted To Genin! *"; M<<"<b><font color=[admin_color]><u><font size=3>You are now a Genin!</u>"; M.Statistic.Rank = "Genin"}; M.Ryo_Reward(M.Mission_On.Ryo_Reward); M.Rep_Reward(M.Mission_On.Rep_Reward); spawn() M.Mission_Show("[MTD]Success, well done!")}
					spawn() {Ninjas<<output("", "Menu.MissionOutput"); Ninjas<<output("<font color=#B6B6B6><b><font size=3><center><u>Mission Success!</u></center>", "Menu.MissionOutput"); Ninjas<<output("", "Menu.MissionOutput")}
					sleep(35)
			var/Mission/Mission
			for(var/NEM_Side/N in Groups) for(var/obj/S in N.Spawns) del(S)
			for(var/mob/M in Ninjas) {if(M.client) {M.Resize(); M.stop(); Mission = M.Mission_On; M.Mission_On = null; M.Respawn(); Current_NEM_Round.Join(M)}; else del(M)}
			if(Mission) del(Mission)
		..()

	proc
		Count_Time()
			..()
			loop
				spawn(10)
					if(Started == 3) return
					Time--

					if(!Time)

						if(Type == "Mission")
							if(Mode == "Orochimaru's Wrath")
								if(Stage == 1)
									var/MI
									for(var/mob/M in Ninjas) if(M.key == M.name) {MI = M.Mission_On; M.Mission_On = null; M.Resize(); Current_NEM_Round.Join(M); M.Respawn()}
									spawn() {if(length(Ninjas) > 0) {Time = 1500; spawn() Count_Time(); I_Cut_Scene ("Tsunade", src); Stage = 2}; else {if(MI) del(MI); del(src)}}
								else del(src)
								return

							if(Started == 3) return
							else del(src)
						if(Type == "Tourney") {Tournament_Verification(src); return}

						else if(Mode == "Challenge")
							if(Started)
								for(var/mob/M in Ninjas)
									spawn()
										M.Respawn()
										if(Type != "Colosseum") M<<"<b><font color=[admin_color]><u>* Challenge.- This battle has lasted too long, restarting!</u>"
								del(src)
							else
								var/A
								for(var/NEM_Side/G in Groups) if(G.Ninjas) A++
								if(A != 2)

									for(var/mob/M in Ninjas)
										M.Respawn()
										M<<"<b><font color=[admin_color]><u>* Challenge.- Someone forgot to pick a character!</u>"

									spawn() del(src)
								else
									for(var/mob/M in Ninjas)
										M<<"<b><font color=[admin_color]><u>* Challenge.- It's Time To Fight! Good luck!</u>"
										M.freeze = 0
									Started = 1
									Time = 1500
									goto loop

						else del(src)

					else goto loop

		Join(mob/Ninja)
			..()
			if(Ninja.NEM_Round && Ninja.NEM_Round == Current_NEM_Round && Ninja.dead && Ninja.key != Ninja.name) Ninja.NEM_Round.DNJ.Add(Ninja.key)

			if(Type == "Mission")
				if(Ninja.name == Ninja.key) {Ninja.NEM_Round.Ninjas_.Remove(Ninja.key)}
				if(!Ninja.client)
					spawn() {Ninja.freeze = 0; Ninja.Movement()}
					if(Ninja.name) {Ninjas.Add(Ninja); Ninja.NEM_Round = src; Spawn(Ninja)}
			if(Ninja.Mission_NPC) return

			if(Type == "Tourney") Ninja.Auto_Spawn()
//			if(Type == "King Of The Hill")

				//spawn() if(Type == "King Of The Hill")
					//if(Ninja.client)
					//	winset(Ninja, "default.Arena", "text=Squads")
					//	winset(Ninja, "default.Arena", "command=Squads")

			if(Mode == "Genin Exam" || Mode == "Challenge" || Type == "Tourney") Ninja.NEM_Side = null
			if(Ninjas_.Find(Ninja.key) || DNJ.Find(Ninja.key))
				Ninja.verbs+=typesof(/mob/Dead/verb)
				Ninja.loc = locate(278, 10, 2)
				Ninja.set_pos((Ninja.x*32)+44, (Ninja.y*32)+8)
				Ninja.On_Special_Character_Screen = 1
				Ninja.CreatedAVotation = 1
				Ninja.CanChoose = 0
				Ninja.freeze = 777
			if(Ninja.NEM_Round)
				Ninja.NEM_Round.Ninjas.Remove(Ninja)
				Ninja.NEM_Side = null
			if(Ninja.client && Current_NEM_Round == src && Time_Left <= 0)
				Ninja.freeze = 999
				Ninja.CanMove = 0
				Ninja.CanChoose = 0
				Ninja.CreatedAVotation = 1
				Ninja.loc = locate(278, 10, 2)
				Ninja.set_pos((Ninja.x*32)+44, (Ninja.y*32)+8)
				Ninja.On_Special_Character_Screen = 1
				Ninja.verbs+=typesof(/mob/Dead/verb)
			Ninja.NEM_Round = src
			Ninjas.Add(Ninja)
			spawn() for(var/obj/S in Ninja.NEM_Round.Picked_Characters)
				var/image/L = image('Locked.dmi', S, null, 100000001)
				L.pixel_x += 1
				L.pixel_y -= 1
				Ninja << L

		Spawn(mob/Ninja)
			if(Ninja.Effect__) del(Ninja.Effect__)
			if(Ninja.NEM_Round.Type == "Mission")
				if(Ninja.client)
					for(var/NEM_Side/N in Groups) if(N.Name == "Good")  {Ninja.Teleport_(pick(N.Spawns)); Ninja.dir = EAST; Ninja.Village = "Good"}
					if(Mode == "Curse Revolution") {Ninja.Village = "Good"; spawn() Ninja.Mission_Show("<font color=#89089C><font size=4><b><center>* [Ninja.Mission_On.Name] *<br><font size=3>Defeat PS Sasuke!"); var/mob/S = new/mob/Mission_NPC/Sasuke (locate(1, 1, 1), Ninja); Join(S)}
					else if(Mode == "Capture The Missing Dog") {Ninja.Village = "Good"; spawn() Ninja.Mission_Show("<font color=#B1EEAC><font size=4><b><center>* [Ninja.Mission_On.Name] *<br><font size=3>Hit Akamaru 5 Times!"); spawn() Ninja.WD = 5; Ninja.MaxCha = 1; Ninja.Cha = 0; Ninja.Regenerate_Chakra = 0; var/mob/S = new/mob/Mission_NPC/Akamaru (locate(1, 1, 1), Ninja); Join(S)}
					else if(Mode == "Genin Exam") {Ninja.Village = "Good"; Ninja.E_List = list("Use A Jutsu", "Downward Meele", "Upward Meele", "Dodge", "Use Substitution", "Sprint", "Double Jump"); Ninja.Complete_Genin_Part(1); Ninja.dir = EAST; Ninja.loc = locate(371, 34, 4); Ninja.E_Part = pick(Ninja.E_List); spawn() Ninja.Mission_Show("<font color=#DFC24A><font size=4><b><center>* [Ninja.Mission_On.Name] *<br><font size=3>[Ninja.E_Part]!")}
					else if(Mode == "Orochimaru's Wrath") {Ninja.Village = "Good"; Ninja.client.eye = locate(0, 0, 0); Ninja.freeze = 10000; var/L = pick(Spawns); Ninja.dir = WEST; Ninja.loc = L; Spawns.Remove(L)}
					else if(Mode == "Mist Ambush") {Ninja.Village = "Good"; spawn() Ninja.Mission_Show("<font color=#5D78FF><font size=4><b><center>* [Ninja.Mission_On.Name] *<br><font size=3>Defeat Zabuza & Haku!"); var/mob/S = new/mob/Mission_NPC/Zabuza (locate(1, 1, 1), Ninja); var/mob/H = new/mob/Mission_NPC/Haku (locate(1, 1, 1), Ninja); Join(S); Join(H)}
					else if(Mode == "Escort Gaara") {Ninja.Village = "Good"; spawn() Ninja.Mission_Show("<font color=#E9CD68><font size=4><b><center>* [Ninja.Mission_On.Name] *<br><font size=3>Protect Gaara!"); Ninja.Escort_Gaara(); var/mob/Gaara = new/mob/Mission_NPC_/Gaara (Spawns["Gaara"], Ninja); Join(Gaara); spawn(50) {var/mob/S = new/mob/Mission_NPC/Jirobo (Spawns["Jirobo"], Gaara); var/mob/H = new/mob/Mission_NPC/Kidoumaru (Spawns["Kidoumaru"], Gaara); Join(S); Join(H)}}
					else if(Mode == "Weed Picking") {for(var/NEM_Side/N in Groups) if(N.Name == "Weeds") Ninja.WTD = length(N.Spawns); Ninja.WD = 0; Ninja.Village = "Good"; spawn() Ninja.Mission_Show("<font color=#9AFA85><font size=4><b><center>* [Ninja.Mission_On.Name] *<br><font size=3>[Ninja.WD] out of [Ninja.WTD]")}
					else if(Mode == "Retrieve Byakugan") {Ninja.Village = "Good"; spawn() Ninja.Mission_Show("<font color=#E0F5F5><font size=4><b><center>* [Ninja.Mission_On.Name] *<br><font size=3>Defeat Neji, Hinata & Hanabi!"); var/mob/S = new/mob/Mission_NPC/Neji (locate(1, 1, 1), Ninja); var/mob/H = new/mob/Mission_NPC/Hinata (locate(1, 1, 1), Ninja); var/mob/N = new/mob/Mission_NPC/Hanabi (locate(1, 1, 1), Ninja); Join(S); Join(H); Join(N)}
					else if(Mode == "Revenge of the Sound Ninjas") {Ninja.Village = "Good"; spawn() Ninja.Mission_Show("<font color=#D1D1CF><font size=4><b><center>* [Ninja.Mission_On.Name] *<br><font size=3>Defeat Dosu, Kin & Zaku!"); var/mob/S = new/mob/Mission_NPC/Dosu (locate(1, 1, 1), Ninja); var/mob/H = new/mob/Mission_NPC/Kin (locate(1, 1, 1), Ninja); var/mob/N = new/mob/Mission_NPC/Zaku (locate(1, 1, 1), Ninja); Join(S); Join(H); Join(N)}

				else if(Ninja.name != "Gaara") for(var/NEM_Side/N in Groups) if(N.Name == "Evil") {if(length(N.Spawns)) Ninja.Teleport_(pick(N.Spawns)); Ninja.dir = WEST; Ninja.Village = "Evil"}
				return

			if(Ninja.NEM_Round.Mode == "Challenge")
				Ninja.Village = rand(1, 1000000)
				Ninja.NEM_Round.Ninjas.Remove(Ninja)
				Ninja.NEM_Round.Ninjas.Add(Ninja)
				for(var/NEM_Side/S in Ninja.NEM_Round.Groups) if(!Ninja.NEM_Side && S.Ready == 1)
					Ninja.NEM_Side = S
					S.Ready = Ninja
					S.Name = Ninja.name
				for(var/obj/Challenge/C in Ninja.NEM_Side.Spawns)
					if(C.Direction == EAST) Ninja.dir = EAST
					else Ninja.dir = WEST
					Ninja.Teleport_(C)
				for(var/obj/Challenge/C in Ninja.NEM_Side.Spawns)
					if(C.Direction == EAST) Ninja.dir = EAST
					else Ninja.dir = WEST
					Ninja.Teleport_(C)

			else
				if(Ninja.NEM_Round.Mode == "Arena")
					Ninja.Village = rand(1, 1000000)
					Ninja.dir = pick(EAST, WEST)
					for(var/NEM_Side/S in Ninja.NEM_Round.Groups) Ninja.NEM_Side = S

				if(Ninja.NEM_Side) for(var/S in Ninja.NEM_Side.Spawns)
					Ninja.Teleport_(S)
					spawn()
						if(Ninja.Village == "Leaf") Ninja.dir = EAST
						if(Ninja.Village == "Akatsuki") Ninja.dir = WEST
					Ninja.NEM_Side.Spawns.Remove(S)
					Ninja.NEM_Side.Spawns.Add(S)

				else if(Time_Left <= 0 && src == Current_NEM_Round && Type != "Mission")
					Ninja.freeze = 555
					Ninja.CanMove = 0
					Ninja.CanChoose = 0
					Ninja.CreatedAVotation = 1
					Ninja.loc = locate(278, 10, 2)
					Ninja.set_pos((Ninja.x*32)+44, (Ninja.y*32)+8)
					Ninja.On_Special_Character_Screen = 1
					Ninja.verbs+=typesof(/mob/Dead/verb)

		Shout(Text) Ninjas<<Text


var/_Announced_V = 0

NEM_Side
	var
		Name
		Ninjas = 0
		Healers = 0
		NEM_Side/Enemy
		list/Spawns = list()
		Direction
		Ready
		Type

	New(_Name, _Type)
		..()
		Name = _Name
		if(_Type) Type = _Type

proc

	Score_Time(NEM_Round/NEM_Round)
		fdel("Scoreboard.sav")
		for(var/mob/M in NEM_Round.Ninjas)
			if(M.client)
				M.SaveScores()
				Ranking(M)
		for(var/mob/M in NEM_Round.Ninjas) RankingDisplay(M)
		Check_Winner_Score()

obj/Challenge_Colosseum {var {Occupied; Direction}}
obj/Challenge {var {Occupied; Direction}}
obj/Genin_Exam_Spawn {var{Occupied}}
obj/Leaf_Spawn
obj/Akatsuki_Spawn
mob/var/Genin_Spawn_Area
mob/var/Leaving_Arena
mob/var/Challenge_Cooldown
var/NEM_Round/Arena = new/NEM_Round ("Arena")

mob/verb/Squads()
	set hidden = 1
	if(NEM_Round.Type != "King Of The Hill") return
	Center("Squads")

mob/verb/Arena()
	if(Leaving_Arena || Mission_On) return

	if(NEM_Round.Mode == "Arena")
		if(Controlling_Object) del(Controlling_Object)
		Leaving_Arena = 1
		loop
			if(Dragonned || freeze && name != key) {spawn(10) goto loop}
			else
				Respawn()
				Leaving_Arena = 0
				Current_NEM_Round.Join(src)
	else

		if(NEM_Round != Current_NEM_Round || Question_Alert) return
		if(Current_NEM_Round == "Normal" && !CTD)
			src<<"<b><font color=red><u>You can only join the Arena during normal rounds!</u>"
			return

		if(name != key && !dead)
			src<<"<b><font color=red><u>You can't join the Arena now, you have to be dead!</u>"
			return

		if(name == key || dead)
			client.images = null
			Respawn(0)
			CanChoose = 1
			Arena.Join(src)
			src<<"<b><font color=red><u>Now you have to choose the character you want to use!</u>"

mob/verb/Challenge()
	if(NEM_Round != Current_NEM_Round || Question_Alert) return
	var/A = input(src, "What do you want to do?", "* Challenge *") in list("Challenge", "Ignore", "UnIgnore")
	if(A == "Ignore")
		var/list/Players = list()
		for(var/mob/M) if(M.client && M != src) {if(Ignored_Challengers.Find(M)) continue; Players.Add(M)}
		var/mob/Player = input("Who do you want to ignore?", "* Challenge.- Ignore *") as null | anything in Players
		if(!Player) return
		if(alert(src, "Are you sure?", "* Challenge.- Ignore [Player.key] *", "No", "Yes") == "Yes")
			Ignored_Challengers.Remove(Player)
			Ignored_Challengers.Add(Player)
			src<<"<b><font color=red><u>You will no longer receive [Player.key]'s Challenge Petitions.</u>"

	else if(A == "UnIgnore")
		var/list/Players = list()
		for(var/mob/M in Ignored_Challengers) if(M.client) Players.Add(M)
		var/mob/Player = input("Who do you want to unignore?", "* Challenge.- UnIgnore *") as null | anything in Players
		if(!Player) return
		if(alert(src, "Are you sure?", "* Challenge.- UnIgnore [Player.key] *", "No", "Yes") == "Yes")
			Ignored_Challengers.Remove(Player)
			src<<"<b><font color=red><u>You will now receive [Player.key]'s Challenge Petitions.</u>"

	else if(A == "Challenge")
		if(NEM_Round != Current_NEM_Round) return
		if(Challenge_Cooldown) {Announced("<font color=#609BF2><b><u>* Please, wait...", Challenge_Cooldown); return}

		var/C
		for(var/NEM_Round/N in Active_Rounds) if(N.Mode == "Challenge") C++
		if(C >= 5) {Announced("<font color=#609BF2><b><u>* There are too many challenges going on already.", 5); return}
		var/list/Players = list()
		for(var/mob/M) if(M.client && M.key == M.name && M != src || M.client && M.dead && M != src) {if(M.Ignored_Challengers.Find(src) || M.NEM_Round.Mode == "Challenge" || M.NEM_Round != Current_NEM_Round) continue; Players.Add(M)}
		var/mob/Player = input("Who do you want to challenge?", "* Challenge *") as null | anything in Players
		if(!Player) return
		if(Player.Ignored_Challengers.Find(src)) return
		if(Challenge_Cooldown) {Announced("<font color=#609BF2><b><u>* Please, wait...", Challenge_Cooldown); return}
		Challenge_Cooldown = 7
		var/Q = input(Player, "[key] wants to have a challenge with you!", "* Challenge Petition *") in list("Accept", "Reject")
		if(Q == "Reject") src<<"<b><font color=red><u>[Player.key] has rejected your challenge petition!</u>"
		else
			if(Player.NEM_Round != Current_NEM_Round || NEM_Round != Current_NEM_Round || Player.Question_Alert || Question_Alert) return
			if(Player.name != Player.key && !Player.dead) {Player<<"<b><font color=red><u>To accept the challenge you must be dead!</u>"; src<<"<b><font color=red><u>[Player.key] has to be dead to fight you!"; return}
			if(name != key && !dead) {src<<"<b><font color=red><u>To accept the challenge you must be dead!</u>"; Player<<"<b><font color=red><u>[key] has to be dead to fight you!"; return}
			world<<"<b><font color=[admin_color]><u>* Challenge.- [key] will shortly fight [Player.key]!</u>"
			C = 0
			for(var/NEM_Round/N in Active_Rounds) if(N.Mode == "Challenge") C++
			if(C >= 5) {Announced("<font color=#609BF2><b><u>* There are too many challenges going on already.", 5); return}
			var/NEM_Round/Challenge_ = new/NEM_Round ("Challenge")
			Respawn()
			Player.Respawn()
			Challenge_.Join(src)
			Challenge_.Join(Player)

mob/var/list/Ignored_Challengers = list()

mob/Dragonpearl123/verb/Rounds()
	for(var/NEM_Round/N in Active_Rounds)
		src<<N.Mode
		if(N.Type) src<<N.Type
		for(var/mob/M in N.Ninjas) src<<M