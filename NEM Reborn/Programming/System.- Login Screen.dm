mob/var/Statistics_CD = 0
mob/var/Wood_Wall = 0
mob/var/obj/Character_Image
mob/var/obj/Character_Image_I
mob/var/obj/Character_Image_II
mob/var/obj/Character_Image_III

mob/proc/Check_Time_Played(var/mob/M)
	var/Seconds_ = M.Statistic.Time_Played
	var/Seconds__ = M.Statistic.Time_Played
	var/Minutes = 0
	var/Hours = 0
	var/Days = 0
	while(Seconds__)
		if(Hours >= 24)
			Hours -= 24
			Days ++
		if(Minutes >= 60)
			Minutes -= 60
			Hours ++
		if(Seconds_ >= 60)
			Seconds_ -= 60
			Minutes ++
		if(Seconds_ < 60)
			Seconds__ = 0
	if(Days) src<<"<b><u><font color=[admin_color]>Time Played: [Days] day(s), [Hours] hour(s), [Minutes] minute(s), [Seconds_] second(s).</u></font>"
	if(!Days && Hours) src<<"<b><u><font color=[admin_color]>Time Played: [Hours] hour(s), [Minutes] minute(s), [Seconds_] second(s).</u></font>"
	if(!Days && !Hours && Minutes) src<<"<b><u><font color=[admin_color]>Time Played: [Minutes] minute(s), [Seconds_] second(s).</u></font>"
	if(!Days && !Hours && !Minutes && Seconds_) src<<"<b><u><font color=[admin_color]>Time Played: [Seconds_] second(s).</u></font>"


mob/var/list/Ignoring = list()
mob/var/AFK = 0
mob/var/Asking=0

mob/Click()
	if(usr.dead || usr.key == usr.name)
		if(dead || name == key || usr.client.eye == src) return
		usr.client.perspective = EYE_PERSPECTIVE
		usr.client.eye = src

	if(src.knocked==0&&src.Dragonned==0&&src.Real==1&&Akamaru==1&&usr.name=="Kiba"&&Village!=usr.Village&&usr.Asking==0)
		Asking=1
		var/mob/A = input(usr, "Do you want to attack [src.name] with Akamaru?","[src.name]") in list("Yes","No")
		if(A=="Yes")
			usr.Asking=0
			for(var/mob/M)
				if(istype(M,/mob/NPC/Akamaru))
					spawn(30)
						M:Target=src
		if(A=="No")
			usr.Asking=0
	if(src.knocked==0&&src.Dragonned==0&&src.Real==1&&Yagura==1&&usr.name=="Yagura"&&Village!=usr.Village&&usr.Asking==0)
		Asking=1
		var/mob/A = input(usr, "Do you want to attack [src.name] with your clone?","[src.name]") in list("Yes","No")
		if(A=="Yes")
			usr.Asking=0
			for(var/mob/M)
				if(istype(M,/mob/NPC/Yagura))
					spawn(30)
						M:Target=src
		if(A=="No")
			usr.Asking=0
	if(src.knocked==0&&src.Dragonned==0&&src.Real==1&&Kushimaru==1&&usr.name=="Kushimaru"&&Village!=usr.Village&&usr.Asking==0)
		Asking=1
		var/mob/A = input(usr, "Do you want to attack [src.name] with your clone?","[src.name]") in list("Yes","No")
		if(A=="Yes")
			usr.Asking=0
			for(var/mob/M)
				if(istype(M,/mob/NPC/Kushimaru))
					spawn(30)
						M:Target=src
		if(A=="No")
			usr.Asking=0
	if(src.knocked==0&&src.Dragonned==0&&src.Real==1&&Naruto==1&&usr.name=="Naruto"&&Village!=usr.Village&&usr.Asking==0)
		Asking=1
		var/mob/A = input(usr, "Do you want to attack [src.name] with your clone?","[src.name]") in list("Yes","No")
		if(A=="Yes")
			usr.Asking=0
			for(var/mob/M)
				if(istype(M,/mob/NPC/Naruto))
					spawn(30)
						M:Target=src
		if(A=="No")
			usr.Asking=0
	if(src.knocked==0&&src.Dragonned==0&&src.Real==1&&Zetsu==1&&usr.name=="Zetsu"&&Village!=usr.Village&&usr.Asking==0)
		Asking=1
		var/mob/A = input(usr, "Do you want to attack [src.name] with your clone?","[src.name]") in list("Yes","No")
		if(A=="Yes")
			usr.Asking=0
			for(var/mob/M)
				if(istype(M,/mob/NPC/Zetsu))
					spawn(30)
						M:Target=src
		if(A=="No")
			usr.Asking=0
	if(src.knocked==0&&src.Dragonned==0&&src.Real==1&&Yamato==1&&usr.name=="Yamato"&&Village!=usr.Village&&usr.Asking==0)
		Asking=1
		var/mob/A = input(usr, "Do you want to attack [src.name] with your clone?","[src.name]") in list("Yes","No")
		if(A=="Yes")
			usr.Asking=0
			for(var/mob/M)
				if(istype(M,/mob/NPC/Yamato))
					spawn(30)
						M:Target=src
		if(A=="No")
			usr.Asking=0
	if(src.knocked==0&&src.Dragonned==0&&src.Real==1&&Kisame==1&&usr.name=="Kisame"&&Village!=usr.Village&&usr.Asking==0)
		Asking=1
		var/mob/A = input(usr, "Do you want to attack [src.name] with your clone?","[src.name]") in list("Yes","No")
		if(A=="Yes")
			usr.Asking=0
			for(var/mob/M)
				if(istype(M,/mob/NPC/Kisame))
					spawn(30)
						M:Target=src
		if(A=="No")
			usr.Asking=0

mob/var/CanChoose=1
mob/var/CanChooseKonan=0
mob/var/Village
mob/var/Jutsus[] = list()
mob/var/Old_Dir = null
mob/var/Effect

obj
	Login_Screen
		var
			Last_Time_Used_By
			Last_Time_Used_By_
			NEM_Side/NEM_Side
			S_Side
			Side
			Healer
			Donator
			Choosable = 1
			Choosable_X = 1
			S_Ranked
			Given_HP
			Given_Chakra
			Given_Icon
			Given_Energy
			Given_Str
			Given_Def
			Given_Speed
			Ultra_Speed = 0
			Choosable_Forever = 0

		mouse_opacity = 2
		layer = 10000002
		pixel_y = 1
		pixel_x = 15

		MouseEntered()
			if(usr.Effect__) del(usr.Effect__)
			var/mob/Ninja = usr
			if(!Choosable_X) return
			if(!Choosable) return
			if(Ninja.NEM_Round && Ninja.NEM_Round.Picked_Characters.Find(src)) return
			if(!Ninja.CanChoose) return
			if(Ninja.Character_Image_) del(Ninja.Character_Image_)
			var/Effect_ = new/obj/Effect/Character (locate(x, y, z))
			usr.Effect__ = Effect_
			if(Ninja.Effect) del(Ninja.Effect)
			Effect_:Selecting = src
			var/obj/Image = image('Graphics/Screen/Glow.dmi', Effect_, Side, 100000000)
			Ninja.Effect = Image
			Image.pixel_x = 15
			Image.pixel_y = 1
			Ninja << Image

		proc/Choose(mob/Ninja, _Side, Price, Tax, mob/Person, var/C)
			if(Ninja.NEM_Round && Ninja.NEM_Round.Picked_Characters.Find(src)) return
			if(!Ninja.CanChoose) return
			if(!Choosable_X) return
			if(!Choosable) return

			if(!C)
				if(!Ninja.Character_Image_I) {Ninja.Character_Image_I = image('Character.png', locate(Ninja.x-14, Ninja.y+1, Ninja.z), null, 100000000000000000000000); Ninja << Ninja.Character_Image_I}
				if(!Ninja.Character_Image) {Ninja.Character_Image = image(Given_Icon, locate(Ninja.x-15, Ninja.y+4, Ninja.z), "mob-standing", 10000000000000000000000); Ninja << Ninja.Character_Image}
				if(!Ninja.Character_Image_II) {Ninja.Character_Image_II = image(null, locate(Ninja.x-11, Ninja.y+1, Ninja.z), null, 1000000000000000000000000); Ninja << Ninja.Character_Image_II}
				if(!Ninja.Character_Image_III) {Ninja.Character_Image_III = image(null, locate(Ninja.x-7, Ninja.y+1, Ninja.z), null, 1000000000000000000000000); Ninja << Ninja.Character_Image_III}
				Ninja:Selecting = src
				Ninja.Character_Image_I.pixel_y = -24
				Ninja.Character_Image_III.pixel_y = -20
				Ninja.Character_Image_III.maptext_width = 505
				Ninja.Character_Image_III.maptext_height = 700
				Ninja.Character_Image_III.maptext = "<b><font size=3><font color=white>          Enter to Choose"
				Ninja.Character_Image_II.maptext_width = 505
				Ninja.Character_Image_II.maptext_height = 700
				Ninja.Character_Image_II.maptext = "<b><font size=5><font color=white><u>[name]</u><br><font size=3><br>Health: [Given_HP]<br>Chakra: [Given_Chakra]<br>Energy: [Given_Energy]<br><br>Strength: [Given_Str]<br>Defense: [Given_Def]<br>Speed: [Given_Speed]"
				Ninja.Character_Image.icon = Given_Icon
				Ninja.Character_Image.pixel_x = 18
				Ninja.Character_Image.dir = EAST
				return

			if(!Ninja.NEM_Round) return

			if(Ninja.NEM_Round == Current_NEM_Round && Time_Left <= 0)
				Ninja<<"<b><font color=red><u>This round is currently locked, sorry!"
				Ninja.freeze = 1
				Ninja.CanMove = 0
				Ninja.CanChoose = 0
				Ninja.CreatedAVotation = 1
				Ninja.loc = locate(278, 10, 2)
				Ninja.set_pos((Ninja.x*32)+44, (Ninja.y*32)+8)
				Ninja.On_Special_Character_Screen = 1
				src.verbs+=typesof(/mob/Dead/verb)
				return

			if(Ninja.NEM_Round.Type == "Colosseum" && S_Ranked || Ninja.NEM_Round.Type == "Tourney" && S_Ranked || S_Ranked  && Ninja.NEM_Round.Type == "Mission" || Ninja.NEM_Round.Type == "King Of The Hill" && S_Ranked) return
			if(S_Ranked && Current_NEM_Round.Mode != "Normal" || S_Ranked && Ninja.NEM_Round.Type == "King Of The Hill") {Ninja<<"<b><font color=red><u><center>[name] isn't usable during this mode!</u>"; return}
			if(_Side)
				if(_Side == "Leaf") NEM_Side = Leaf
				if(_Side == "Akatsuki") NEM_Side = Akatsuki
				Side = _Side
			if(!Ninja.CanChoose) {Ninja<<"<b><font color=red><u><center>You aren't allowed to use a character now!</u></center>"; return}
			if(!Choosable || Ninja.NEM_Round.Picked_Characters.Find(src)) {Ninja<<"<b><font color=red><u><center>This character has been already chosen!</u></center>"; return}
			if(Donator && !Ninja.Donator) {Ninja<<"<b><font color=red><u><center>You aren't allowed to use this character!</u></center>"; return}
			if(Donator && Ninja.NEM_Round.Type == "Tourney") {Ninja<<"<b><font color=red><u><center>You aren't allowed to use this character during Tournament!</u></center>"; return}
			if(Ninja.NEM_Round.Mode == "Normal" && Ninja.NEM_Round.Type != "King Of The Hill" && Ninja.NEM_Round.Type != "Mission") if(NEM_Side.Ninjas > NEM_Side.Enemy.Ninjas) {Ninja<<"<b><font color=red><center><u>[NEM_Side.Name] has more ninjas than [NEM_Side.Enemy.Name]!</center></u>"; return}
			if(S_Ranked)
				if(Price)
					if(Ninja.Statistic.Ryo < Price) {Ninja<<"<font color=red><b><u>You don't have enough ryo!</u>"; winshow(Ninja, "Shop", 0)}
					else {Ninja.Statistic.Ryo -= Price; Ninja.Statistic.Ryo_Spent += Price; if(Tax) Ninja.Statistic._Village_.Ryo += Tax; winshow(Ninja, "Shop", 0)}
				else
					if(!Person) return
					if(Last_Time_Used_By == Person)
						if(Person == Ninja) Ninja<<"<font color=red><b><u>You used this character the previous round, so you're unable to select it now!</u>"
						else Ninja<<"<font color=red><b><u>[Person.key] used this character the previous round, so you're unable to select it now!</u>"
						return
					if(name == "Kabuchimaru") Kabuchimaru = Ninja
					Last_Time_Used_By = Person
					Last_Time_Used_By_ = Person
				Ninja.client.perspective = MOB_PERSPECTIVE
				Ninja.client.eye = Ninja

			if(Healer && Ninja.NEM_Round == Current_NEM_Round && !CTD && Ninja.NEM_Round.Type != "Mission")
				if(NEM_Side.Healers > NEM_Side.Enemy.Healers) {Ninja<<"<b><font color=red><center><u>[NEM_Side.Name] has more healers than [NEM_Side.Enemy.Name]!</center></u>"; return}
				Ninja.Healer_Character = 1
				Ninja.Deaths = 2

			Ninja.Selecting = null
			if(Ninja.Character_Image) del(Ninja.Character_Image)
			if(Ninja.Character_Image_I) del(Ninja.Character_Image_I)
			if(Ninja.Character_Image_II) del(Ninja.Character_Image_II)
			if(Ninja.Character_Image_III) del(Ninja.Character_Image_III)

			Ninja.NEM_Side = NEM_Side
			if(Ninja.NEM_Round.Mode == "Challenge" || Ninja.NEM_Round.Type) Ninja.NEM_Side = null
			Ninja.Village = Side
			Ninja.Auto_Spawn()
			Ninja.check_loc()

			if(Ninja.NEM_Round.Mode != "Genin Exam" && Ninja.NEM_Round.Mode != "Arena" && Ninja.NEM_Round.Mode != "Challenge" && !CTD)
				Ninja.NEM_Round.Picked_Characters.Add(src)
				var/image/L = image('Locked.dmi', src, null, 100000001)
				Ninja.NEM_Round.Ninjas << L
				Ninja.NEM_Round.Images.Add(L)

			if(Donator)
				if(Ninja.Trying_Donator) Ninja.Donator = 0

			if(Ninja.NEM_Side)
				if(Ninja.Healer_Character) Ninja.NEM_Side.Healers ++
				Ninja.NEM_Side.Ninjas ++
			if(!Ninja.Moving) Ninja.Movement()
			winset(Ninja, "default.Avatar","image=\ref[icon]")
			var/_Name = name
			if(_Name == "Hashirama Senju") _Name = "Hashirama"
			if(_Name == "Tobirama Senju") _Name = "Tobirama"
			if(_Name == "Hiruzen Sarutobi") _Name = "Hiruzen"
			winset(Ninja, "default.Avatar_Name","text-color=[Ninja.Text_Color]")
			winset(Ninja, "default.Avatar_Name","text='[_Name]'")
			if(Ninja.NEM_Round.Mode != "Arena") Ninja.NEM_Round.Ninjas_.Add(Ninja.key)
			if(Ninja.NEM_Round.Mode != "Tourney") Ninja.verbs-=typesof(/mob/Dead/verb)
			if(Ninja.Effect__) del(Ninja.Effect__)
			Ninja._Name = _Name
			Ninja.Avatar = icon
			Ninja.client.view = "32x15"
			Ninja.name = name
			Ninja.Substitution = 0
			Ninja.FFF = 1
			Ninja.Check_Jutsu()
			Ninja.CanChoose = 0
			Ninja.Real_Character_Name = name
			Ninja.speed_multiplier = Given_Speed
			Ninja.MaxHP = Given_HP
			Ninja.HP = Given_HP
			Ninja.MaxCha = Given_Chakra
			Ninja.Cha = Given_Chakra
			Ninja.MaxEnergy = Given_Energy
			Ninja.Energy = Given_Energy
			Ninja.Str = Given_Str
			Ninja.Def = Given_Def
			Ninja.ultra_speed = Ultra_Speed
			Ninja.icon = Given_Icon
			Ninja.freeze = 0
			if(Ninja.Character_Image_) del(Ninja.Character_Image_)
			if(Ninja.NEM_Round.Type == "King Of The Hill")
				if(Ninja.Squad) Ninja.Village = "Squad [Ninja.Squad.Name]"
				else Ninja.Village = rand(1, 30000)
				Ninja.Deaths = 4
			if(Ninja.NEM_Round == Current_NEM_Round || Ninja.NEM_Round.Type == "King Of The Hill")

				if(Ninja.Kunais >= 5)
					Ninja.Kunais_L = 5
					Ninja.Kunais -= 5
				else
					Ninja.Kunais_L = Ninja.Kunais
					Ninja.Kunais = 0

				if(Ninja.Shurikens >= 25)
					Ninja.Shurikens_L = 25
					Ninja.Shurikens -= 25
				else
					Ninja.Shurikens_L = Ninja.Shurikens
					Ninja.Shurikens = 0

				Ninja.Shuriken_Type = rand(1, 4)

				if(Ninja.Scroll_Kunais >= 7)
					Ninja.Scroll_Kunais_L = 7
					Ninja.Scroll_Kunais -= 7
				else
					Ninja.Scroll_Kunais_L = Ninja.Kunais
					Ninja.Scroll_Kunais = 0

				if(Ninja.Statistic._Village_) if(Ninja.Statistic._Village_.Current_Pill)
					var/Amount
					if(Ninja.Statistic.Rank == "Genin") if(prob(50)) Amount = 1
					else if(Ninja.Statistic.Rank == "Chuunin") Amount = 1
					else if(Ninja.Statistic.Rank == "Jounin" || Ninja.Statistic.Rank == "Special Jounin") Amount = 2
					else if(Ninja.Statistic.Rank != "Academy Student")
						Amount = 2
						if(prob(25)) Amount += 1
					else if(Ninja.Statistic != Ninja.Statistic._Village_.Leader)
						Amount = 2
						if(prob(50)) Amount += 1
					else if(Ninja.Statistic == Ninja.Statistic._Village_.Leader) Amount = 3
					if(Ninja.Statistic._Village_.Rank == "1st") Amount += 1
					new/obj/Pill (Ninja, Ninja.Statistic._Village_.Current_Pill, Amount)
			if(Ninja.name == "Eternal Sasuke" || Ninja.name == "Rinnegan Tobi" || Ninja.name == "Special ANBU" || Ninja.name == "Minato Namikaze") Ninja.Avatar(Ninja.name)
			if(Ninja.name == "Eternal Sasuke") Ninja.Eternal_Sasuke_Special()
			if(Ninja.name == "Kushimaru") Ninja.Kushimaru_Proc()
			if(Ninja.name == "Tobi" || Ninja.name == "Rinnegan Tobi") Ninja.Rinnegan_Tobi_Special()
			if(Ninja.NEM_Round == Current_NEM_Round)
				Ninja.Statistic.Rounds_Played ++
				Ninja.Statistic.Characters_Used.Add(name)
			if(Ninja.NEM_Round.Mode == "Challenge") Ninja.freeze = 100
			if(Ninja.NEM_Round.Type == "Mission")
				Ninja.Missions_Cooldowns.Add(Ninja.Mission_On.Name)
				var/Time
				if(Ninja) {if(Ninja.Mission_On.Rank == "E") Time = world.realtime+9000; else if(Ninja.Mission_On.Rank == "D") Time = world.realtime+9000; else if(Ninja.Mission_On.Rank == "C") Time = world.realtime+18000; else if(Ninja.Mission_On.Rank == "B") Time = world.realtime+27000; else if(Ninja.Mission_On.Rank == "A") Time = world.realtime+36000; else if(Ninja.Mission_On.Rank == "S") Time = world.realtime+54000}
				Ninja.Missions_Cooldowns[Ninja.Mission_On.Name] = Time
				Ninja.NEM_Round.Spawn(Ninja)


		Naruto_Face
			name = "Naruto"
			icon = 'Graphics/Faces/NarutoFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Naruto.dmi'
			Given_HP = 115
			Given_Chakra = 100
			Given_Energy = 185
			Given_Str = 12
			Given_Def = 6.5
			Given_Speed = 1.60

		Ino_Face
			name = "Ino"
			icon = 'Graphics/Faces/InoFaceAlivX.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Ino.dmi'
			Given_HP = 115
			Given_Chakra = 110
			Given_Energy = 125
			Given_Str = 11.5
			Given_Def = 6
			Given_Speed = 1.50

		Madara_Face
			name = "Madara"
			icon = 'Graphics/Faces/MadaraFaceAlive.dmi'

			Donator = 1
			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Madara.dmi'
			Given_HP = 150
			Given_Chakra = 140
			Given_Energy = 175
			Given_Str = 14.5
			Given_Def = 9.25
			Given_Speed = 1.75

		Kakkou_Face
			name = "Kakkou"
			icon = 'Graphics/Faces/KakkouFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kakkou.dmi'
			Given_HP = 115
			Given_Chakra = 115
			Given_Energy = 115
			Given_Str = 13.25
			Given_Def = 7.5
			Given_Speed = 1.55

		Kabuto_Face
			name = "Kabuto"
			icon = 'Graphics/Faces/KabutoFaceAlive.dmi'

			Donator = 1
			Healer = 1
			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kabuto.dmi'
			Given_HP = 160
			Given_Chakra = 135
			Given_Energy = 175
			Given_Str = 12.5
			Given_Def = 8
			Given_Speed = 1.40

		Zetsu_Face
			name = "Zetsu"
			icon = 'Graphics/Faces/ZetsuFaceAlive.dmi'

			Donator = 1
			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Zetsu.dmi'
			Given_HP = 140
			Given_Chakra = 150
			Given_Energy = 225
			Given_Str = 14.25
			Given_Def = 9
			Given_Speed = 1.60

		Pre_Shippuden_Kakashi_Face
			name = "{PS} Kakashi"
			icon = 'Graphics/Faces/LilKakashiFaceAlive.dmi'

			Donator = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/LilKakashi.dmi'
			Given_HP = 120
			Given_Chakra = 125
			Given_Energy = 150
			Given_Str = 12.5
			Given_Def = 7
			Given_Speed = 1.60

		Pre_Shippuden_Sasuke_Face
			name = "{PS} Sasuke"
			icon = 'Graphics/Faces/LilSasukeFaceAlive.dmi'

			Donator = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/LilSasuke.dmi'
			Given_HP = 120
			Given_Chakra = 125
			Given_Energy = 150
			Given_Str = 12.5
			Given_Def = 7
			Given_Speed = 1.55

		Killer_Bee_Face
			name = "Killer Bee"
			icon = 'Graphics/Faces/Killer_BeeFaceAlive.dmi'

			Donator = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Killer Bee.dmi'
			Given_HP = 120
			Given_Chakra = 125
			Given_Energy = 150
			Given_Str = 12.5
			Given_Def = 7
			Given_Speed = 1.55

		Obito_Face
			name = "Obito"
			icon = 'Graphics/Faces/ObitoFaceAlive.dmi'

			Donator = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Obito.dmi'
			Given_HP = 120
			Given_Chakra = 125
			Given_Energy = 150
			Given_Str = 12.5
			Given_Def = 7
			Given_Speed = 1.55

		Ebisu_Face
			name = "Ebisu"
			icon = 'Graphics/Faces/EbisuFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Ebisu.dmi'
			Given_HP = 115
			Given_Chakra = 115
			Given_Energy = 125
			Given_Str = 11.5
			Given_Def = 6.5
			Given_Speed = 1.45

		Anko_Face
			name = "Anko"
			icon = 'Graphics/Faces/AnkoFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Anko.dmi'
			Given_HP = 120
			Given_Chakra = 125
			Given_Energy = 125
			Given_Str = 11.75
			Given_Def = 6.5
			Given_Speed = 1.375

		Omoi_Face
			name = "Omoi"
			icon = 'Graphics/Faces/OmoiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Omoi.dmi'
			Given_HP = 120
			Given_Chakra = 130
			Given_Energy = 140
			Given_Str = 12.75
			Given_Def = 6.5
			Given_Speed = 1.475

		Mifune_Face
			name = "Mifune"
			icon = 'Graphics/Faces/MifuneFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Mifune.dmi'
			Given_HP = 140
			Given_Chakra = 130
			Given_Energy = 200
			Given_Str = 14
			Given_Def = 8
			Given_Speed = 2.2

		Darui_Face
			name = "Darui"
			icon = 'Graphics/Faces/DaruiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Darui.dmi'
			Given_HP = 120
			Given_Chakra = 130
			Given_Energy = 150
			Given_Str = 12.75
			Given_Def = 6.75
			Given_Speed = 1.525

		Yondaime_Face
			name = "Yondaime"
			icon = 'Graphics/Faces/YondaimeFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Yondaime.dmi'
			Given_HP = 150
			Given_Chakra = 100
			Given_Energy = 175
			Given_Str = 12.5
			Given_Def = 7.5
			Given_Speed = 2.15
			Ultra_Speed = 2

		Rin_Face
			name = "Rin"
			icon = 'Graphics/Faces/RinFaceAlive.dmi'

			Donator = 1
			Healer = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Rin.dmi'
			Given_HP = 165
			Given_Chakra = 115
			Given_Energy = 150
			Given_Str = 12
			Given_Def = 6.5
			Given_Speed = 1.50

		Sakura_Face
			name = "Sakura"
			icon = 'Graphics/Faces/SakuraFaceAlive.dmi'

			Healer = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Sakura.dmi'
			Given_HP = 175
			Given_Chakra = 100
			Given_Energy = 100
			Given_Str = 12.5
			Given_Def = 6.5
			Given_Speed = 1.385

		Sai_Face
			name = "Sai"
			icon = 'Graphics/Faces/SaiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Sai.dmi'
			Given_HP = 115
			Given_Chakra = 120
			Given_Energy = 175
			Given_Str = 12
			Given_Def = 7.5
			Given_Speed = 1.40

		MightGai_Face
			name = "Might Gai"
			icon = 'Graphics/Faces/MightGaiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/MightGai.dmi'
			Given_HP = 120
			Given_Chakra = 125
			Given_Energy = 175
			Given_Str = 14.5
			Given_Def = 7.5
			Given_Speed = 1.65

		Kakashi_Face
			name = "Kakashi"
			icon = 'Graphics/Faces/KakashiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Kakashi.dmi'
			Given_HP = 100
			Given_Chakra = 100
			Given_Energy = 150
			Given_Str = 13.5
			Given_Def = 6.5
			Given_Speed = 1.45

		Temari_Face
			name = "Temari"
			icon = 'Graphics/Faces/TemariFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Temari.dmi'
			Given_HP = 120
			Given_Chakra = 140
			Given_Energy = 150
			Given_Str = 12.75
			Given_Def = 7
			Given_Speed = 1.525

		Zaku_Face
			name = "Zaku"
			icon = 'Graphics/Faces/ZakuFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Zaku.dmi'
			Given_HP = 125
			Given_Chakra = 135
			Given_Energy = 125
			Given_Str = 13
			Given_Def = 7
			Given_Speed = 1.40

		Kin_Face
			name = "Kin"
			icon = 'Graphics/Faces/KinFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kin.dmi'
			Given_HP = 120
			Given_Chakra = 125
			Given_Energy = 115
			Given_Str = 11.75
			Given_Def = 6.25
			Given_Speed = 1.40

		Dosu_Face
			name = "Dosu"
			icon = 'Graphics/Faces/DosuFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Dosu.dmi'
			Given_HP = 115
			Given_Chakra = 105
			Given_Energy = 115
			Given_Str = 13.5
			Given_Def = 7.5
			Given_Speed = 1.375

		Kiba_Face
			name = "Kiba"
			icon = 'Graphics/Faces/KibaFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Kiba.dmi'
			Given_HP = 115
			Given_Chakra = 100
			Given_Energy = 175
			Given_Str = 12.5
			Given_Def = 7
			Given_Speed = 1.55

		Tenten_Face
			name = "Tenten"
			icon = 'Graphics/Faces/TentenFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Tenten.dmi'
			Given_HP = 120
			Given_Chakra = 100
			Given_Energy = 115
			Given_Str = 11
			Given_Def = 6.5
			Given_Speed = 1.55

		Hanabi_Face
			name = "Hanabi"
			icon = 'Graphics/Faces/HanabiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Hanabi.dmi'
			Given_HP = 132.5
			Given_Chakra = 140
			Given_Energy = 150
			Given_Str = 12.25
			Given_Def = 7
			Given_Speed = 1.675
			Ultra_Speed = 1
			S_Ranked = 1

		Neji_Face
			name = "Neji"
			icon = 'Graphics/Faces/NejiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Neji.dmi'
			Given_HP = 110
			Given_Chakra = 150
			Given_Energy = 125
			Given_Str = 12
			Given_Def = 7
			Given_Speed = 1.45

		Shikamaru_Face
			name = "Shikamaru"
			icon = 'Graphics/Faces/ShikamaruFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Shikamaru.dmi'
			Given_HP = 115
			Given_Chakra = 150
			Given_Energy = 115
			Given_Str = 11.5
			Given_Def = 6.5
			Given_Speed = 1.40

		Kankuro_Face
			name = "Kankuro"
			icon = 'Graphics/Faces/KankuroFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Kankuro.dmi'
			Given_HP = 100
			Given_Chakra = 100
			Given_Energy = 115
			Given_Str = 11.5
			Given_Def = 6.5
			Given_Speed = 1.375

		Hashirama_SenjuFace
			name = "Hashirama Senju"
			icon = 'Graphics/Faces/Hashirama_SenjuFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Hashirama Senju.dmi'
			Given_HP = 135
			Given_Chakra = 150
			Given_Energy = 175
			Given_Str = 14
			Given_Def = 8
			Given_Speed = 1.55

		Tobirama_SenjuFace
			name = "Tobirama Senju"
			icon = 'Graphics/Faces/Tobirama_SenjuFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Tobirama Senju.dmi'
			Given_HP = 125
			Given_Chakra = 125
			Given_Energy = 175
			Given_Str = 13.75
			Given_Def = 7.75
			Given_Speed = 1.50

		ZabuzaFace
			name = "Zabuza"
			icon = 'Graphics/Faces/ZabuzaFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Zabuza.dmi'
			Given_HP = 115
			Given_Chakra = 120
			Given_Energy = 150
			Given_Str = 13.75
			Given_Def = 7.75
			Given_Speed = 1.50

		Choji_Face
			name = "Choji"
			icon = 'Graphics/Faces/ChojiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Choji.dmi'
			Given_HP = 115
			Given_Chakra = 100
			Given_Energy = 100
			Given_Str = 11.5
			Given_Def = 6.5
			Given_Speed = 1.375

		Gaara_Face
			name = "Gaara"
			icon = 'Graphics/Faces/GaaraFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Gaara.dmi'
			Given_HP = 135
			Given_Chakra = 150
			Given_Energy = 150
			Given_Str = 10.5
			Given_Def = 8
			Given_Speed = 1.375

		Chiyo_Face
			name = "Granny Chiyo"
			icon = 'Graphics/Faces/ChiyoFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Chiyo.dmi'
			Given_HP = 150
			Given_Chakra = 130
			Given_Energy = 150
			Given_Str = 10.5
			Given_Def = 6
			Given_Speed = 1.375


		Hinata_Face
			name = "Hinata"
			icon = 'Graphics/Faces/HinataFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Hinata.dmi'
			Given_HP = 110
			Given_Chakra = 150
			Given_Energy = 125
			Given_Str = 12
			Given_Def = 7
			Given_Speed = 1.45

		Yamato_Face
			name = "Yamato"
			icon = 'Graphics/Faces/YamatoFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Yamato.dmi'
			Given_HP = 125
			Given_Chakra = 150
			Given_Energy = 125
			Given_Str = 11.5
			Given_Def = 7.5
			Given_Speed = 1.40

		Mizukage_Face
			name = "Mizukage"
			icon = 'Graphics/Faces/MeiFaceAlive.dmi'

			Donator = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Mei.dmi'
			Given_HP = 120
			Given_Chakra = 140
			Given_Energy = 175
			Given_Str = 13.5
			Given_Def = 7.5
			Given_Speed = 1.90
			Ultra_Speed = 2

		Tsuchikage_Face
			name = "Tsuchikage"
			icon = 'Graphics/Faces/TsuchikageFaceAlive.dmi'

			Donator = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Tsuchikage.dmi'
			Given_HP = 115
			Given_Chakra = 140
			Given_Energy = 175
			Given_Str = 13.5
			Given_Def = 7.5
			Given_Speed = 1.90
			Ultra_Speed = 1

		Raikage_Face
			name = "Raikage"
			icon = 'Graphics/Faces/RaikageFaceAlive.dmi'

			Donator = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Raikage.dmi'
			Given_HP = 125
			Given_Chakra = 130
			Given_Energy = 185
			Given_Str = 13.5
			Given_Def = 7.5
			Given_Speed = 1.90
			Ultra_Speed = 1

		Ginkaku_Face
			name = "Ginkaku"
			icon = 'Graphics/Faces/GinkakuFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Ginkaku.dmi'
			Given_HP = 115
			Given_Chakra = 135
			Given_Energy = 175
			Given_Str = 13.75
			Given_Def = 7.75
			Given_Speed = 1.70

		Kinkaku_Face
			name = "Kinkaku"
			icon = 'Graphics/Faces/KinkakuFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kinkaku.dmi'
			Given_HP = 100
			Given_Chakra = 150
			Given_Energy = 175
			Given_Str = 12.5
			Given_Def = 6.5
			Given_Speed = 1.65

		Deidara_Face
			name = "Deidara"
			icon = 'Graphics/Faces/DeidaraFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Deidara.dmi'
			Given_HP = 115
			Given_Chakra = 135
			Given_Energy = 115
			Given_Str = 11.75
			Given_Def = 5.75
			Given_Speed = 1.50

		Guren_Face
			name = "Guren"
			icon = 'Graphics/Faces/GurenFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Guren.dmi'
			Given_HP = 120
			Given_Chakra = 155
			Given_Energy = 120
			Given_Str = 12.5
			Given_Def = 6.5
			Given_Speed = 1.45

		Pein_Face
			name = "Pein"
			icon = 'Graphics/Faces/PeinFaceAlive.dmi'

			Healer = 1
			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Pein.dmi'
			Given_HP = 140
			Given_Chakra = 100
			Given_Energy = 150
			Given_Str = 10
			Given_Def = 6.5
			Given_Speed = 1.50



		Hidan_Face
			name = "Hidan"
			icon = 'Graphics/Faces/HidanFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Hidan.dmi'
			Given_HP = 122.5
			Given_Chakra = 100
			Given_Energy = 130
			Given_Str = 13.75
			Given_Def = 7
			Given_Speed = 1.45

		Kisame_Face
			name = "Kisame"
			icon = 'Graphics/Faces/KisameFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kisame.dmi'
			Given_HP = 120
			Given_Chakra = 100
			Given_Energy = 175
			Given_Str = 13
			Given_Def = 7.5
			Given_Speed = 1.45

		Tobi_Face
			name = "Tobi"
			icon = 'Graphics/Faces/TobiFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Tobi.dmi'
			Given_HP = 115
			Given_Chakra = 125
			Given_Energy = 175
			Given_Str = 12.5
			Given_Def = 6.5
			Given_Speed = 1.55

		Kakuzu_Face
			name = "Kakuzu"
			icon = 'Graphics/Faces/KakuzuFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kakuzu.dmi'
			Given_HP = 115
			Given_Chakra = 125
			Given_Energy = 150
			Given_Str = 13.5
			Given_Def = 8
			Given_Speed = 1.45

		Sasori_Face
			name = "Sasori"
			icon = 'Graphics/Faces/SasoriFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Sasori.dmi'
			Given_HP = 100
			Given_Chakra = 100
			Given_Energy = 115
			Given_Str = 12.5
			Given_Def = 6.5
			Given_Speed = 1.35

		Konan_Face
			name = "Konan"
			icon = 'Graphics/Faces/KonanFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Konan.dmi'
			Given_HP = 115
			Given_Chakra = 125
			Given_Energy = 115
			Given_Str = 12.5
			Given_Def = 6
			Given_Speed = 1.40

		Itachi_Face
			name = "Itachi"
			icon = 'Graphics/Faces/ItachiFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Itachi.dmi'
			Given_HP = 115
			Given_Chakra = 115
			Given_Energy = 175
			Given_Str = 13.5
			Given_Def = 7.5
			Given_Speed = 1.55

		Juugo_Face
			name = "Juugo"
			icon = 'Graphics/Faces/JuugoFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Juugo.dmi'
			Given_HP = 115
			Given_Chakra = 100
			Given_Energy = 130
			Given_Str = 12.5
			Given_Def = 6.5
			Given_Speed = 1.45

		Suigetsu_Face
			name = "Suigetsu"
			icon = 'Graphics/Faces/SuigetsuFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Suigetsu New.dmi'
			Given_HP = 125
			Given_Chakra = 150
			Given_Energy = 135
			Given_Str = 12.75
			Given_Def = 6.75
			Given_Speed = 1.40

		Old_Suigetsu_Face
			name = "Suigetsu"
			icon = 'Graphics/Faces/SuigetsuFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Suigetsu.dmi'
			Given_HP = 125
			Given_Chakra = 150
			Given_Energy = 135
			Given_Str = 12.75
			Given_Def = 6.75
			Given_Speed = 1.40

		Kidoumaru_Face
			name = "Kidoumaru"
			icon = 'Graphics/Faces/KidoumaruFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kidoumaru.dmi'
			Given_HP = 110
			Given_Chakra = 100
			Given_Energy = 110
			Given_Str = 13
			Given_Def = 6.5
			Given_Speed = 1.45

		Orochimaru_Face
			name = "Orochimaru"
			icon = 'Graphics/Faces/OrochimaruFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Orochimaru.dmi'
			Given_HP = 125
			Given_Chakra = 150
			Given_Energy = 150
			Given_Str = 13.5
			Given_Def = 7.5
			Given_Speed = 1.50

		Jirobo_Face
			name = "Jirobo"
			icon = 'Graphics/Faces/JiroboFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Jirobo.dmi'
			Given_HP = 115
			Given_Chakra = 105
			Given_Energy = 110
			Given_Str = 12.5
			Given_Def = 7.15
			Given_Speed = 1.40

		Tayuya_Face
			name = "Tayuya"
			icon = 'Graphics/Faces/TayuyaFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Tayuya.dmi'
			Given_HP = 95
			Given_Chakra = 125
			Given_Energy = 100
			Given_Str = 11.5
			Given_Def = 6.5
			Given_Speed = 1.35

		Sakon_Face
			name = "Sakon"
			icon = 'Graphics/Faces/SakonFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Sakon.dmi'
			Given_HP = 105
			Given_Chakra = 100
			Given_Energy = 115
			Given_Str = 12.5
			Given_Def = 6.5
			Given_Speed = 1.45

		Kimimaro_Face
			name = "Kimimaro"
			icon = 'Graphics/Faces/KimimaroFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kimimaro.dmi'
			Given_HP = 115
			Given_Chakra = 100
			Given_Energy = 130
			Given_Str = 12.75
			Given_Def = 6.75
			Given_Speed = 1.45

		Danzou_Face
			name = "Danzou"
			icon = 'Graphics/Faces/DanzouFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Danzou.dmi'
			Given_HP = 115
			Given_Chakra = 100
			Given_Energy = 115
			Given_Str = 13
			Given_Def = 7
			Given_Speed = 1.475

		Karin_Face
			name = "Karin"
			icon = 'Graphics/Faces/KarinFaceAlive.dmi'

			Healer = 1
			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Karin.dmi'
			Given_HP = 170
			Given_Chakra = 110
			Given_Energy = 135
			Given_Str = 10.5
			Given_Def = 5.5
			Given_Speed = 1.375

		Hiruzen_Sarutobi_Face
			name = "Hiruzen Sarutobi"
			icon = 'Graphics/Faces/3rdHokageFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/3rdHokage.dmi'
			Given_HP = 125
			Given_Chakra = 125
			Given_Energy = 175
			Given_Str = 13.75
			Given_Def = 7.25
			Given_Speed = 1.50

		Asuma_Face
			name = "Asuma"
			icon = 'Graphics/Faces/AsumaFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Asuma.dmi'
			Given_HP = 110
			Given_Chakra = 100
			Given_Energy = 115
			Given_Str = 11
			Given_Def = 6
			Given_Speed = 1.40

		Jiraiya_Face
			name = "Jiraiya"
			icon = 'Graphics/Faces/JiraiyaFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Jiraiya.dmi'
			Given_HP = 125
			Given_Chakra = 150
			Given_Energy = 150
			Given_Str = 15
			Given_Def = 7.5
			Given_Speed = 1.50

		Tsunade_Face
			name = "Tsunade"
			icon = 'Graphics/Faces/TsunadeFaceAlive.dmi'

			Healer = 1
			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Tsunade.dmi'
			Given_HP = 170
			Given_Chakra = 150
			Given_Energy = 125
			Given_Str = 17.5
			Given_Def = 8
			Given_Speed = 1.50

		Shino_Face
			name = "Shino"
			icon = 'Graphics/Faces/ShinoFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Shino.dmi'
			Given_HP = 115
			Given_Chakra = 130
			Given_Energy = 125
			Given_Str = 12.5
			Given_Def = 6.5
			Given_Speed = 1.40

		Aoi_Face
			name = "Aoi"
			icon = 'Graphics/Faces/AoiFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Aoi.dmi'
			Given_HP = 100
			Given_Chakra = 125
			Given_Energy = 150
			Given_Str = 14
			Given_Def = 7
			Given_Speed = 1.50

		Sora_Face
			name = "Sora"
			icon = 'Graphics/Faces/SoraFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Sora.dmi'
			Given_HP = 115
			Given_Chakra = 125
			Given_Energy = 175
			Given_Str = 13.75
			Given_Def = 7
			Given_Speed = 1.475

		Nagato_Face
			name = "Nagato"
			icon = 'Graphics/Faces/NagatoFace.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Nagato.dmi'
			Given_HP = 120
			Given_Chakra = 130
			Given_Energy = 200
			Given_Str = 12
			Given_Def = 8
			Given_Speed = 2

		Sasuke_Face
			name = "Sasuke"
			icon = 'Graphics/Faces/SasukeFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Sasuke.dmi'
			Given_HP = 100
			Given_Chakra = 100
			Given_Energy = 150
			Given_Str = 13.5
			Given_Def = 7.5
			Given_Speed = 1.50

		Shisui_Face
			name = "Shisui"
			icon = 'Graphics/Faces/ShisuiFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Shisui.dmi'
			Given_HP = 110
			Given_Chakra = 130
			Given_Energy = 110
			Given_Str = 11.275
			Given_Def = 8
			Given_Speed = 1.50



		RockLee_Face
			name = "Rock Lee"
			icon = 'Graphics/Faces/RockLeeFaceAlive.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/RockLee.dmi'
			Given_HP = 115
			Given_Chakra = 100
			Given_Energy = 175
			Given_Str = 14.5
			Given_Def = 7.25
			Given_Speed = 1.65

		Gari_Face
			name = "Gari"
			icon = 'Graphics/Faces/GariFace.dmi'

			Side = "Akatsuki"
			Donator = 1
			Given_Icon = 'Graphics/Characters/Gari.dmi'
			Given_HP = 125
			Given_Chakra = 115
			Given_Energy = 135
			Given_Str = 13
			Given_Def = 7.5
			Given_Speed = 1.55
			Ultra_Speed = 2

		Haku_Face
			name = "Haku"
			icon = 'Graphics/Faces/HakuFaceAlive.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Haku.dmi'
			Given_HP = 125
			Given_Chakra = 115
			Given_Energy = 125
			Given_Str = 12.5
			Given_Def = 7.5
			Given_Speed = 1.45

		Rinnegan_Tobi_Face
			name = "Rinnegan Tobi"
			icon = 'Graphics/Faces/Rinnegan Tobi Face.dmi'

			Side = "Akatsuki"
			S_Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/RT.dmi'
			Given_HP = 120
			Given_Chakra = 140
			Given_Energy = 225
			Given_Str = 13.5
			Given_Def = 8
			Given_Speed = 2
			Ultra_Speed = 2
			S_Ranked = 1

		Eternal_Sasuke_Face
			name = "Eternal Sasuke"
			icon = 'Graphics/Faces/Eternal Sasuke Face.dmi'

			Side = "Akatsuki"
			S_Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/EMSasuke.dmi'
			Given_HP = 120
			Given_Chakra = 135
			Given_Energy = 225
			Given_Str = 13.75
			Given_Def = 8
			Given_Speed = 2.00
			Ultra_Speed = 2
			S_Ranked = 1

		Eternal_Sasuke_Face
			name = "(Rinnegan) Sasuke"
			icon = 'Graphics/Faces/Eternal Sasuke Face.dmi'

			Side = "Akatsuki"
			S_Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/RSasuke.dmi'
			Given_HP = 110
			Given_Chakra = 120
			Given_Energy = 175
			Given_Str = 12.52
			Given_Def = 7.65
			Given_Speed = 2.00
			Ultra_Speed = 2
			S_Ranked = 1

		ANaruto_Face
			name = "(Ashura) Naruto"
			icon = 'Graphics/Faces/ANarutoFaceAlive.dmi'

			Side = "Leaf"
			S_Side = "Leaf"
			Given_Icon = 'Graphics/Characters/ANaruto.dmi'
			Given_HP = 140
			Given_Chakra = 200
			Given_Energy = 225
			Given_Str = 12.52
			Given_Def = 7.65
			Given_Speed = 2.00
			Ultra_Speed = 2
			S_Ranked = 1

		Chikushodo_Face
			name = "Chikushodo"
			icon = 'Graphics/Faces/Chikushodo Face.dmi'

			Side = "Akatsuki"
			S_Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Animal Path.dmi'
			Given_HP = 130
			Given_Chakra = 125
			Given_Energy = 225
			Given_Str = 14
			Given_Def = 8.5
			Given_Speed = 2
			Ultra_Speed = 2
			S_Ranked = 1

		Kushimaru_Face
			name = "Kushimaru"
			icon = 'Graphics/Faces/Kushimaru Face.dmi'

			Side = "Akatsuki"
			S_Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Kushimaru.dmi'
			Given_HP = 130
			Given_Chakra = 125
			Given_Energy = 225
			Given_Str = 13.5
			Given_Def = 8.5
			Given_Speed = 1.95
			Ultra_Speed = 2
			S_Ranked = 1

		Yagura_Face
			name = "Yagura"
			icon = 'Graphics/Faces/Yagura Face.dmi'

			Side = "Leaf"
			S_Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Yagura.dmi'
			Given_HP = 125
			Given_Chakra = 125
			Given_Energy = 225
			Given_Str = 13.25
			Given_Def = 8.25
			Given_Speed = 1.95
			Ultra_Speed = 2
			S_Ranked = 1

		Minato_Namikaze_Face
			name = "Minato Namikaze"
			icon = 'Graphics/Faces/Minato Namikaze Face.dmi'

			Side = "Leaf"
			S_Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Minato.dmi'
			Given_HP = 135
			Given_Chakra = 125
			Given_Energy = 225
			Given_Str = 14.25
			Given_Def = 8.50
			Given_Speed = 2.20
			Ultra_Speed = 2
			S_Ranked = 1

		Torune_Face
			name = "Torune"
			icon = 'Graphics/Faces/Torune Face.dmi'

			Side = "Leaf"
			S_Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Torune.dmi'
			Given_HP = 120
			Given_Chakra = 120
			Given_Energy = 200
			Given_Str = 13.15
			Given_Def = 8
			Given_Speed = 2
			Ultra_Speed = 2
			S_Ranked = 1

		Lord_Itachi_Face
			name = "Lord Itachi"
			icon = 'Graphics/Faces/RareItachiFaceAliveXX.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Rare Itachi.dmi'
			Given_HP = 140
			Given_Chakra = 150
			Given_Energy = 175
			Given_Str = 14.30
			Given_Def = 8.85
			Given_Speed = 2.10
			Ultra_Speed = 2
			S_Ranked = 1

		ANBU_Kakashi_Face
			name = "ANBU Kakashi"
			icon = 'Graphics/Faces/ANBUKakashiFace.dmi'

			Side = "Leaf"
			Given_Icon = 'Graphics/Characters/Kakashi ANBU.dmi'
			Given_HP = 140
			Given_Chakra = 150
			Given_Energy = 175
			Given_Str = 14.15
			Given_Def = 8.75
			Given_Speed = 2.00
			Ultra_Speed = 2
			S_Ranked = 1

		Kabuchimaru_Face
			name = "Kabuchimaru"
			icon = 'Graphics/Faces/SageKabutoFaceAliveX.dmi'

			Side = "Akatsuki"
			Given_Icon = 'Graphics/Characters/Sage Kabuto.dmi'
			Given_HP = 155
			Given_Chakra = 150
			Given_Energy = 200
			Given_Str = 14
			Given_Def = 9.00
			Given_Speed = 2.10
			Ultra_Speed = 2
			S_Ranked = 1

		Special_ANBU_Face
			name = "Special ANBU"
			icon = 'Graphics/Faces/ANBU Face.dmi'

			Side = "Leaf"
			S_Side = "Leaf"
			Given_Icon = 'Graphics/Characters/ANBU Special.dmi'
			Given_HP = 125
			Given_Chakra = 140
			Given_Energy = 225
			Given_Str = 14
			Given_Def = 8.25
			Given_Speed = 2.05
			Ultra_Speed = 2
			S_Ranked = 1



	Locked
		layer = 1000
		pixel_y = 16
		icon = 'Graphics/Skills/Locked.dmi'
		icon_state = "2"
		pixel_y = 1
		pixel_x = 15
		layer = 100000001
		New()
			..()
			for(var/obj/Locked/L in src) if(L != src) del(L)
			for(var/obj/Locked_X/L in src) if(L != src) del(L)
	Locked_X
		layer = 1000
		pixel_y = 1
		pixel_x = 15
		icon = 'Graphics/Skills/Locked.dmi'
		icon_state = "1"
		layer = 100000001
		New()
			..()
			for(var/obj/Locked/L in src) if(L != src) del(L)
			for(var/obj/Locked_X/L in src) if(L != src) del(L)
	Arrow
		layer = 100

		ToDefault
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(235,36,3)
				usr.check_loc()
		ToZaku
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(175,8,2)
				usr.check_loc()

		ToJuugo
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(120,15,2)
				usr.check_loc()

		ToSpecial
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				if(usr.Donator == 0)
					//usr<<output("<b><font color=red>This section is donator-only!", "Chat")
					return
				if(usr.Donator == 1)
					usr.loc=locate(31,41,6)
					usr.check_loc()
		ToPSSasuke
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				if(usr.Donator == 0)
					//usr<<output("<b><font color=red>This section is donator-only!", "Chat")
					return
				if(usr.Donator == 1)
					usr.loc=locate(194,58,6)
					usr.check_loc()
		ToKakuzu
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(166,30,3)
				usr.check_loc()
		ToHokage
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(16,1,3)
				usr.check_loc()
		ToItachi
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(241,35,6)
				usr.check_loc()
		ToObito
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				if(usr.Donator == 0)
					//usr<<output("<b><font color=red>This section is donator-only!", "Chat")
					return
				if(usr.Donator == 1)
					usr.loc=locate(119,53,6)
					usr.check_loc()
		ToKillerBee
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				if(usr.Donator == 0)
					//usr<<output("<b><font color=red>This section is donator-only!", "Chat")
					return
				if(usr.Donator == 1)
					usr.loc=locate(96,10,6)
					usr.check_loc()
		ToTemari
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(282,36,2)
				usr.check_loc()
		ToDanzou
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(238,34,5)
				usr.check_loc()
		ToTsunade
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(240,37,2)
				usr.check_loc()
		ToAkat
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(235,16,3)
				usr.check_loc()
		ToKinkaku
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(124,63,3)
				usr.check_loc()
		ToHaku
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(83,64,2)
				usr.check_loc()
		ToAoi
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(210,64,2)
				usr.check_loc()
		ToSound
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(16,36,3)
				usr.check_loc()
		ToSound2
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(277,10,6)
				usr.check_loc()
		ToTenten
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(282,9,5)
				usr.check_loc()
		ToChoji
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(83,29,3)
				usr.check_loc()
		ToKiba
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(137,63,5)
				usr.check_loc()
		ToKakasi
			icon_state="2"
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(282,24,3)
				usr.check_loc()

		To3rd
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(203,11,6)
				usr.check_loc()
		Yamato
			icon_state=""
			Click()
				if(usr.CanChoose<=0)return
				usr.loc=locate(83,29,3)
				usr.check_loc()