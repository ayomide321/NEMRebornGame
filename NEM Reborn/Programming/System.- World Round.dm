mob/var/Controlling_Object = null

var
	CTD
	CTD_Next
	Round_ = 0
	Allow_New_Users = 1

proc
	Characters_Check()
		for(var/obj/Locked_X/L in world) del(L)
		for(var/obj/Login_Screen/L in world)
			if(!L.Last_Time_Used_By_) L.Last_Time_Used_By = null
			L.Last_Time_Used_By_ = null
			L.Choosable = 1
			L.Choosable_X = 1

		if(CTD)
			var/_CTD_Leaf_Ninjas
			var/_CTD_Akatsuki_Ninjas
			var/_Akatsuki_Ninjas
			var/_Leaf_Ninjas
			var/Spotted
			loop
				var/obj/Locked_ = new/obj/Locked_X ()
				if(Spotted == 1) Locked_.loc = locate(22, 60, 2)
				else if(Spotted == 2) Locked_.loc = locate(26, 60, 2)
				else if(Spotted == 3) Locked_.loc = locate(30, 60, 2)
				else if(Spotted == 4) Locked_.loc = locate(22, 57, 2)
				else if(Spotted == 5) Locked_.loc = locate(26, 57, 2)
				else if(Spotted == 6) Locked_.loc = locate(30, 57, 2)
				else if(Spotted == 7) Locked_.loc = locate(22, 54, 2)
				else if(Spotted == 8) Locked_.loc = locate(26, 54, 2)
				else if(Spotted == 9) Locked_.loc = locate(30, 54, 2)
				Spotted ++
				if(Spotted <= 9) goto loop

			for(var/obj/Login_Screen/F in world)
				if(F in CTD_Leaf_Ninjas) {_CTD_Leaf_Ninjas ++; continue}
				if(F in CTD_Akatsuki_Ninjas) {_CTD_Akatsuki_Ninjas ++; continue}
				F.loc = locate(1, 1, 1); new/obj/Locked_X (F:loc); F:Choosable = 0; F:Choosable_X = 0

			for(var/obj/Login_Screen/F in CTD_Leaf_Ninjas)
				F.Donator = 0
				F.Choosable_Forever = 1
				F.Choosable = 1
				F.Choosable_X = 1

				if(F)
					F.Side = "Leaf"
					_Leaf_Ninjas ++
					if(_CTD_Leaf_Ninjas == 1) F.loc = locate(22, 57, 2)
					else if(_CTD_Leaf_Ninjas == 2)
						if(_Leaf_Ninjas == 1) F.loc = locate(22, 60, 2)
						else if(_Leaf_Ninjas == 2) F.loc = locate(26, 60, 2)
					else if(_CTD_Leaf_Ninjas == 3)
						if(_Leaf_Ninjas == 1) F.loc = locate(22, 60, 2)
						else if(_Leaf_Ninjas == 2) F.loc = locate(26, 60, 2)
						else if(_Leaf_Ninjas == 3) F.loc = locate(30, 60, 2)
					else if(_CTD_Leaf_Ninjas == 4)
						if(_Leaf_Ninjas == 1) F.loc = locate(22, 60, 2)
						else if(_Leaf_Ninjas == 2) F.loc = locate(26, 60, 2)
						else if(_Leaf_Ninjas == 3) F.loc = locate(30, 60, 2)
						else if(_Leaf_Ninjas == 4) F.loc = locate(22, 57, 2)
					for(var/obj/Locked_X/L in F.loc) del(L)


			for(var/obj/Login_Screen/F in CTD_Akatsuki_Ninjas)
				F.Donator = 0
				F.Choosable_Forever = 1
				F.Choosable = 1
				F.Choosable_X = 1

				if(F)
					F.Side = "Akatsuki"
					_Akatsuki_Ninjas ++
					if(_CTD_Akatsuki_Ninjas == 1) F.loc = locate(30, 57, 2)
					else if(_CTD_Akatsuki_Ninjas == 2)
						if(_Akatsuki_Ninjas == 1) F.loc = locate(26, 54, 2)
						else if(_Akatsuki_Ninjas == 2) F.loc = locate(30, 54, 2)
					else if(_CTD_Akatsuki_Ninjas == 3)
						if(_Akatsuki_Ninjas == 1) F.loc = locate(22, 54, 2)
						else if(_Akatsuki_Ninjas == 2) F.loc = locate(26, 54, 2)
						else if(_Akatsuki_Ninjas == 3) F.loc = locate(30, 54, 2)
					else if(_CTD_Akatsuki_Ninjas == 4)
						if(_Akatsuki_Ninjas == 1) F.loc = locate(30, 57, 2)
						else if(_Akatsuki_Ninjas == 2) F.loc = locate(22, 54, 2)
						else if(_Akatsuki_Ninjas == 3) F.loc = locate(26, 54, 2)
						else if(_Akatsuki_Ninjas == 4) F.loc = locate(30, 54, 2)
					for(var/obj/Locked_X/L in F.loc) del(L)


		if(HealRound == 0)
			for(var/obj/Login_Screen/Pein_Face/F in world) {new/obj/Locked_X (F:loc); F:Choosable = 0; F:Choosable_X = 0}
			for(var/obj/Login_Screen/Tsunade_Face/F in world) {new/obj/Locked_X (F:loc); F:Choosable = 0; F:Choosable_X = 0}
			for(var/obj/Login_Screen/Kabuto_Face/F in world) {new/obj/Locked_X (F:loc); F:Choosable = 0; F:Choosable_X = 0}
			for(var/obj/Login_Screen/Rin_Face/F in world) {new/obj/Locked_X (F:loc); F:Choosable = 0; F:Choosable_X = 0}
			for(var/obj/Login_Screen/Karin_Face/F in world) {new/obj/Locked_X (F:loc); F:Choosable = 0; F:Choosable_X = 0}
			for(var/obj/Login_Screen/Sakura_Face/F in world) {new/obj/Locked_X (F:loc); F:Choosable = 0; F:Choosable_X = 0}
			HealRound = 1

		for(var/obj/Login_Screen/L in world) if(Illegal_Characters.Find(L) && L:loc) for(var/obj/Login_Screen/R in world) if(L.name == R.name && R.loc) {R.Choosable_X = 0; L.Choosable = 0; new/obj/Locked_X (R.loc)}
		Illegal_Characters = list()
		for(var/obj/Login_Screen/L in world) if(Illegal_Characters_X.Find(L)) for(var/obj/Login_Screen/R in world) if(L.name == R.name && R.loc) {R.Choosable_X = 0; L.Choosable = 0; new/obj/Locked_X (R.loc); L.Choosable_X = 0}

		var
			Leaf
			Akatsuki

		for(var/NEM_Side/G in Current_NEM_Round.Groups)
			if(G.Name == "Allied Shinobis Forces") Leaf = G
			else Akatsuki = G

		for(var/obj/Login_Screen/L in world)
			if(L.Side == "Leaf") L.NEM_Side = Leaf
			else L.NEM_Side = Akatsuki

	Time()
		var/Default = Round_

		loop
			if(Round_ != Default) return
			spawn(10)
				Time_Left --
				if(Time_Left > 0) goto loop
				else
					var/C
					for(var/mob/M in Current_NEM_Round.Ninjas) if(M.client && M.name != M.key) C ++
					if(!C)
						Current_NEM_Round.Ninjas<<"<b><font size=2><font color=[admin_color]><u>Everybody's dead, so nobody's won!</u>"
						for(var/mob/M in Current_NEM_Round.Ninjas)
							M.icon_state = "mob-standing"
							M.freeze = 777
							M.stop()
						Just_Finished = 1
						spawn(75) Just_Finished = 0
						spawn(15) Reset_World(Current_NEM_Round)

					else
						Lock_Round()
						Check_Winner(Current_NEM_Round)

					return

	Lock_Round()
		Allow_New_Users = 0
		Round_ ++

		for(var/obj/Effect/E in world) del(E)

		for(var/mob/M)
			if(M.client && M.name == M.key && M.NEM_Round == Current_NEM_Round && M.NEM_Round.Mode != "Arena")
				M.loc = locate(278, 10, 2)
				M.set_pos((M.x*32)+44, (M.y*32)+8)
				M.On_Special_Character_Screen = 1
				M.CreatedAVotation = 1
				M.CanChoose = 0
				M.freeze = 1000

	Reset_World(NEM_Round/_NEM_Round)
		for(var/mob/M in _NEM_Round) del(M)

		if(Next_Mode == "Chuunin Exam" || Next_Mode == "Reboot Now" || CTD || CTD_Next)
			Update_Ranking()
			banlistsave()
			Score_Time(_NEM_Round)
			world.Reboot()

		if(_NEM_Round.Mode == "Normal")
			for(var/obj/Chain/O in world) del(O)
			for(var/obj/Chain_Kunai/O in world) del(O)
			Update_Ranking()
			Score_Time(_NEM_Round)
			for(var/obj/Tobi_FT/T in world) del(T)
			Round_ ++
			Tornado = 0
			Time_Left = 600
			Time()
			Allow_New_Users = 1
			fdel("Scoreboard.sav")
			for(var/mob/NPC/S) if(!S._Special_NPC_) del(S)
			for(var/obj/Dropped_Kunai/D in world) del(D)
			var/_Players_
			for(var/mob/M in world) if(M.client) _Players_ ++
			if(_Players_ >= 15) if(Spawn == 4) Spawn = 5

			Naruto = 0
			Yamato = 0
			Yagura = 0
			Zetsu = 0
			Kisame = 0
			Kunai = 0
			Akamaru = 0
			Illusion_Ready = 0
			Kabuchimaru = null


		if(!Next_Round)
			Current_NEM_Round = new/NEM_Round ("Normal")
			spawn() banlistsave()
			Characters_Check()

			for(var/mob/M in _NEM_Round.Ninjas)
				if(!M.client && !M._Special_NPC_) del(M)
				else spawn()
					if(Question_Time) {M.Respawn(); M.Question(Question_Time)}
					else {M.Respawn(0); Current_NEM_Round.Join(M)}

		if(_NEM_Round == Current_NEM_Round && Next_Round)
			Start_New_Round()

		_NEM_Round.Del("Normal Restart")

var/Question = 'Graphics/Faces/Question.dmi'
var/mob/Kabuchimaru
mob/var/list/Scrolls = list()

mob
	proc
		Respawn(var/G)
			if(!client) del(src)
			else
				if(Effect__) del(Effect__)
				for(var/obj/Effects/Tobirama_Shield/T in Overlays) del(T)
				Leaving_Arena = 0
				for(var/obj/Effects/Player_Icon/I in Overlays) del(I)
				for(var/obj/Effects/Choji_Pill/C in Overlays) del(C)
				for(var/obj/Screen/Time/T in client.screen) del(T)
				Squad = null
				FFF = 0
				E_Part = null
				client.view = "32x15"
				client.perspective = MOB_PERSPECTIVE
				if(Extra_Image) del(Extra_Image)
				client.eye = src
				Avatar = 'Graphics/Faces/Question.dmi'
				winshow(src, "Squads", 0)
				winset(src, "default.Avatar","image=\ref[Avatar]")
				winset(src, "default.Avatar","image=\ref[Avatar]")
				winset(src, "default.Avatar_Name","text-color=#969696")
				winset(src, "default.Avatar_Name","text=None")
				for(var/obj/J in src.Jutsus)
					Jutsus -= J
					del(J)

				if(On_Wood_Wall) On_Wood_Wall.Delete()
				if(W_Protecting) W_Protecting.Delete()
				if(Active_Assist) del(Active_Assist)
				for(var/Assist/A in Assisted_By) del(A)
				Avatar = Question
				Last_Person_Who_Attacked = null
				Substitution = 1
				if(Kunais_L) Kunais += Kunais_L
				if(Scroll_Kunais_L) Scroll_Kunais += Scroll_Kunais_L
				if(Shurikens_L) Shurikens += Shurikens_L
				if(Edo) del(Edo)
				No_HP_Regen = 0
				Icon_State = null
				Choji_Pill = null
				Shuriken_Damage = 0
				Shuriken_Cooldown = 0
				if(Scrolls) for(var/obj/Scroll/S in Scrolls) del(S)
				if(Character_Image_) del(Character_Image_)
				Scrolls = list()
				Shurikens_L = 0
				Kunais_L = 0
				if(Character_Image) del(Character_Image)
				if(Character_Image_I) del(Character_Image_I)
				if(Character_Image_II) del(Character_Image_II)
				if(Character_Image_III) del(Character_Image_III)
				Selecting = null
				Scroll_Kunais_L = 0
				S_K_A = 0
				if(Kamui) for(var/mob/M in world) M.RT.Remove(src)
				Kamui = 0
				Kunai_Jutsu = null
				Scroll_Kunai_Jutsu = null
				Chakra_Drain_Active = 0
				del(Pill)
				Wood_Wall = 0
				Pills = 3
				Icon_State = null
				Puppets_Chasing = list()
				Special_Eye = 0
				HP_Boost = 1
				Ryo_Boost = 1
				Explosing = 0
				Dashing_CD = null
				Overlay = 0
				Itachi_Special_Illusion = 0
				Flamed = 0
				Bijuu = 0
				Can_Grab = 1
				Chained = 0
				Movement_Boost = 1
				Sharking = 0
				Get_On_Wall = 1
				input_lock = 0
				Jump_Boost = 0
				No_Attack = 0
				Immune_To_Amaterasu = 0
				Immune_To_Poison = 0
				Delay_Boost = 0
				Substitution_Delay_Boost = 1
				Substitution_Duration_Boost = 0
				stop()
				verbs+=typesof(/mob/Dead/verb)
				Venomous_Clone = 0
				KakashiChidori = 0
				Rasengan = 0
				Chidori = 0
				DinamicEntry = 0
				Iron = 0
				Wall_CD = 0
				if(!G) Multikeying = 0
				Selecting_Jutsu = null
				Selected_Jutsu = null
				if(!Sound)
					var/sound/S = sound('Naruto Eternal Memories Song.ogg', 1, 0, 0, 85)
					src << sound(null)
					src << S
				Remembered_Spot = null
				Winded = 0
				alpha = 255
				On_Wall = 0
				Executing_Special_Jutsu = 0
				Holding_X = 0
				Wall_Freeze = null
				Ant = null
				_Assists = 0
				On_Shadow = 0
				Doton = 0
				Using_Sand_Shield = 0
				Punch_Animation = 0
				SaveScores()
				Special_Crow = 0
				Energy_Recover = 1
				Mind_Controlled = null
				Mind_Controlling = null
				Dashing = null
				Change_Direction = 1
				Update_Scores()
				Illusion_ = 0
				if(Controlling_Shadow == 1) for(var/obj/Shadow/S in world) del(S)
				Deflection = 0
				_Delay = 0
				Attacked_ = 0
				Lethal = 1
				Poison_On = 0
				Chakra_On = 0
				if(Byakugan) Byakugan_Off(src)
				if(Rinnegan) Rinnegan_Off(src)
				if(Sharingan) Sharingan_Off(src)
				if(Gentle_Fist) Gentle_Fist_Off(src)
				if(Amat_Sword) Amat_Sword_Fist_Off(src)
				Transformed = 0
				invisibility = 0
				_Tornado = 0
				Chakra_Time = 0
				Can_Dodge_ = 0
				Gentle_Fist = 0
				Amat_Sword = 0
				_CD = 0
				New_ = 1
				Used_Tornado = 0
				Regenerate_Chakra = 1
				overlays -= /obj/Sharingan
				for(var/obj/Sharingan/S in overlays) del(S)
				overlays -= /obj/Byakugan
				for(var/obj/Byakugan/S in overlays) del(S)
				overlays -= /obj/Rinnegan
				for(var/obj/Rinnegan/S in overlays) del(S)
				Update_Scores()
				HP_Regened = 0
				Cha_Regened = 0
				Energy_Regened = 0
				HP_Rewarded --
				Cha_Rewarded --
				Energy_Rewarded --
				On_Special_Character_Screen = 0
				Can_Substitution = 1
				Executed_Fully = 0
				BoulderX = 0
				overlays -= 'Graphics/Skills/Genjutsu.dmi'
				Boulder = 0
				UsingKirin = 0
				Activated = 0
				Deaths = 0
				pixel_x = 0
				TsunamiCD = 0
				Controlling_Object = null
				InkCD = 0
				Village = null
				CanUseGates = 1
				Dragonned = 0
				CanUseTsu = 0
				Gates = 0
				Counting = 0
				Changed_Village = 0
				GoingSusanoo = 0
				icon = null
				Susanoo = 0
				GoingSage = 0
				Sage = 0
				layer = 100
				Remembered_Location = null
				pwidth = 32
				C = 0
				Characters = null
				Def = 5
				Str = 10
				MaxHP = 100
				MaxCha = 100
				MaxEnergy = 100
				HP = 100
				Cha = 100
				FireCD=0
				Energy = 100
				icon = null
				Levitating = 0
				Controlling = 0
				Attacking = 0
				dead = 0
				knocked = 0
				DoujutsuCD = 0
				Gentle_Fist = 0
				_CD_ = 0
				Byakugan = 0
				Sharingan = 0
				Rinnegan = 0
				knocked = 0
				Immune = 0
				Poison_Immunity = 0
				Kills = 0
				KOs = 0
				KOd = 0
				Poison = 0
				Amaterasu = 0
				CanChoose = 1
				CanGoCS = 1
				CanGoKyuubi = 1
				Kyuubi = 0
				PeinCD = 0
				RasenganCD = 0
				WoodCD = 0
				Doming = 0
				CanUseAmaterasu = 0
				Old_Village = null
				CanUseSusanoo = 0
				CanBeRevived = 1
				DRasenganCD = 0
				CanMove = 1
				CreatedAVotation = 0
				Chain_Restriction=null
				RestrictionFX=null
				Crow = 0
				HP = MaxHP
				Cha = MaxCha
				immortal = 0
				overlays-='Graphics/Skills/immortal.dmi'
				Energy = MaxEnergy
				Iron = 0
				Revived_T = 0
				Can_Revive = 1
				Healer_Character = 0
				freeze = 100
				name = key
				ultra_speed = 0
				speed_multiplier = 1
				FireCD = 0
				CloneCD = 0
				knockback = 0
				Attacking = 0
				Attacked = 0
				Real = 1
				Counting_ = 0
				Checked_X = 1
				Run_Off()
				Tsunami_CD = 0
				Reviving = 0
				speed_multiplier = 1.35
				fall_speed = 25
				move_speed = 13.5
				ChidoriCD = 0
				Intangible_CD = 0
				Intangible = 0
				Shield_ = 0
				FirePunchCD = 0
				RasenganCD = 0
				Kamui = 0
				RT = list()
				Absorbed = 0
				density = 1
				Special_ = 0
				HP = MaxHP
				Cha = MaxCha
				Energy = MaxEnergy
				stop()
				Substitution = 1
				pixel_y = 0
				pwidth = 32
				pheight = 48
				Moving = 0
				if(!G)
					for(var/obj/Login_Screen/L in world)
						if(L:Choosable_X == 0 && L:loc)
							if(findtext(Characters, L.name)) continue
							if(C == 0)Characters+="<b><font color=red>[L]"
							else Characters+=", [L]"
							src.C++
				if(src.C >= 1 && !CTD)
					src<<output("","Chat")
					src<<output("<font color=red><b><u>- The Following Characters Were Disabled By Admins On This Round:</b></u></font>","Chat")
					src<<output("","Chat")
					src<<output("[src.Characters]","Chat")
					src<<output("","Chat")
				client.images = null
				Page = 1
				loc = locate(3, 3, 1)
				set_pos((x*32)+44, (y*32)+8)
				loc = locate(20,56,2)

				if(G)
					freeze = 100
					CanMove = 0
					CreatedAVotation = 1
					loc = locate(278, 10, 2)
					On_Special_Character_Screen = 1

				set_pos((x*32)+44, (y*32)+8)

mob/var/Reviving = 0
mob/var/obj/Character_Image_
mob/var/Changed_Village = 0
mob/var/_Delay = 0
mob/var/Bijuu = 0
mob/var/_CD_ = 0
mob/var/Get_On_Wall = 1
mob/var/Used_Tornado = 0
mob/var/Using_Sand_Shield = 0
mob/var/Can_Grab = 1
mob/var/No_Attack
mob/var/Choji_Pill