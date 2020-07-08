mob/var/list/Enemies_Following = list()
mob/var/mob/Target = null
mob/var/Real_Person = 0

mob
	Dragonpearl123
		verb

			Create_NPC()
				set category = "NPCs"
				var/Type = input(src, "What NPC do you want to create?","Create NPC") as null | anything in list("Kakuzu", "Kakashi", "Sasuke", "Yondaime", "Suigetsu", "Itachi", "Tobi", "Kimimaro", "Kidoumaru", "Hiruzen Sarutobi", "Sasori", "Orochimaru", "Gaara", "Zabuza", "Tobirama Senju", "Konan", "Danzou", "Hidan", "(Butterfly) Choji", "Guren", "Ginkaku", "Kinkaku", "Ebisu", "{PS} Kakashi", "Mizukage", "Tsuchikage", "Special ANBU", "(Kyuubi) Naruto", "(Curse Seal) Jirobo", "Zaku", "Dosu", "Sai", "Asuma", "Madara", "{PS} Sasuke", "{PS} (Curse Seal) Sasuke")
				if(!Type) return
				var/N = new/mob/NPC/Custom (src.loc)
				N:NEM_Round = NEM_Round
				Current_Log.Add("*[key] created NPC [Type]!", 1)
				if(Type == "Kakuzu")
					src = N
					N:Village = "Akatsuki"
					N:name = "{NPC} Kakuzu"
					N:icon = 'Graphics/Characters/Kakuzu.dmi'
					N:Jutsus += new/obj/Jutsus/Flaming_Shuriken (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Kakuzu (N)
					N:Jutsus += new/obj/Jutsus/Fire_Coffin (N)
					N:Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Kakuzu (N)
					N:Jutsus += new/obj/Jutsus/Earth_Smash (N)
					N:Jutsus += new/obj/Jutsus/Raiton_Sphere_Kakuzu (N)

				if(Type == "Kakashi")
					N:Village = "Leaf"
					N:name = "{NPC} Kakashi"
					N:icon = 'Graphics/Characters/Kakashi.dmi'
					N:Jutsus += new/obj/Jutsus/Chidori_Kakashi (N)
					N:Jutsus += new/obj/Jutsus/Raikiri (N)
					N:Jutsus += new/obj/Jutsus/Water_Dragon_Kakashi (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Kakashi (N)
					N:Jutsus += new/obj/Jutsus/Dynamic_Entry_Kakashi (N)

				if(Type == "Sasuke")
					N:Village = "Akatsuki"
					N:name = "{NPC} Sasuke"
					N:icon = 'Graphics/Characters/Sasuke.dmi'
					N:Jutsus += new/obj/Jutsus/Chidori_Sasuke (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Sasuke (N)

				if(Type == "Yondaime")
					N:Village = "Leaf"
					N:name = "{NPC} Yondaime"
					N:icon = 'Graphics/Characters/Yondaime.dmi'
					N:Jutsus += new/obj/Jutsus/Rasengan_Yondaime (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_Yondaime (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Yondaime (N)


				if(Type == "Suigetsu")
					N:Village = "Akatsuki"
					N:name = "{NPC} Suigetsu"
					N:icon = 'Graphics/Characters/Suigetsu.dmi'
					N:Jutsus += new/obj/Jutsus/Water_Palm (N)
					N:Jutsus += new/obj/Jutsus/Water_Dragon_Akatsuki (N)
					N:Jutsus += new/obj/Jutsus/Five_Hungry_Sharks (N)

				if(Type == "Itachi")
					N:Village = "Akatsuki"
					N:name = "{NPC} Itachi"
					N:icon = 'Graphics/Characters/Itachi.dmi'
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_Itachi (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Itachi (N)
					N:Jutsus += new/obj/Jutsus/Crow_Genjutsu_Itachi (N)

				if(Type == "Tobi")
					N:Village = "Akatsuki"
					N:name = "{NPC} Tobi"
					N:icon = 'Graphics/Characters/Tobi.dmi'
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_Tobi (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Tobi (N)
					N:Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Tobi (N)

				if(Type == "Kimimaro")
					N:Village = "Akatsuki"
					N:name = "{NPC} Kimimaro"
					N:icon = 'Graphics/Characters/Kimimaro.dmi'
					N:Jutsus += new/obj/Jutsus/Bone_Bullets (N)
					N:Jutsus += new/obj/Jutsus/Teshi_Sendan (N)

				if(Type == "Kidoumaru")
					N:Village = "Akatsuki"
					N:name = "{NPC} Kidoumaru"
					N:icon = 'Graphics/Characters/Kidoumaru.dmi'
					N:Jutsus += new/obj/Jutsus/Spider_Sticky_Gold (N)
					N:Jutsus += new/obj/Jutsus/Spider_Sticking_Spit (N)

				if(Type == "Hiruzen Sarutobi")
					N:Village = "Leaf"
					N:name = "{NPC} Hiruzen Sarutobi"
					N:icon = 'Graphics/Characters/3rdHokage.dmi'
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Hiruzen (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_Hiruzen (N)
					N:Jutsus += new/obj/Jutsus/Earth_Dragon (N)
					N:Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone (N)
					N:Jutsus += new/obj/Jutsus/Adamantine_Trap (N)

				if(Type == "Sasori")
					N:Village = "Akatsuki"
					N:name = "{NPC} Sasori"
					N:icon = 'Graphics/Characters/Sasori.dmi'
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_Sasori (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Sasori (N)
					N:Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone_Sasori (N)
					N:Jutsus += new/obj/Jutsus/Summoning_Puppets (N)



				if(Type == "Orochimaru")
					N:Village = "Akatsuki"
					N:name = "{NPC} Orochimaru"
					N:icon = 'Graphics/Characters/Orochimaru.dmi'
					N:Jutsus += new/obj/Jutsus/Snake_Dash (N)
					N:Jutsus += new/obj/Jutsus/Snakes_Summoning (N)
					N:Jutsus += new/obj/Jutsus/Rashomon2 (N)

				if(Type == "Gaara")
					N:Village = "Leaf"
					N:name = "{NPC} Gaara"
					N:icon = 'Graphics/Characters/Gaara.dmi'
					N:Jutsus += new/obj/Jutsus/Sand_Shuriken (N)
					N:Jutsus += new/obj/Jutsus/Sand_Bullet (N)
					N:Jutsus += new/obj/Jutsus/Sand_Tsunami (N)

				if(Type == "Zabuza")
					N:Village = "Akatsuki"
					N:name = "{NPC} Zabuza"
					N:icon = 'Graphics/Characters/Zabuza.dmi'
					N:Jutsus += new/obj/Jutsus/Water_Bubble_Zabuza (N)
					N:Jutsus += new/obj/Jutsus/Water_Bullet_Zabuza (N)
					N:Jutsus += new/obj/Jutsus/Water_Dragon_Zabuza (N)
					N:Jutsus += new/obj/Jutsus/Water_Splash (N)
					N:Jutsus += new/obj/Jutsus/Ice_Spikes (N)
					N:Jutsus += new/obj/Jutsus/Immense_Tsunami_Zabuza (N)

				if(Type == "Tobirama Senju")
					N:Village = "Leaf"
					N:name = "{NPC} Tobirama Senju"
					N:icon = 'Graphics/Characters/Tobirama Senju.dmi'
					N:Jutsus += new/obj/Jutsus/Water_Bubble (N)
					N:Jutsus += new/obj/Jutsus/Water_Bullet (N)
					N:Jutsus += new/obj/Jutsus/Water_Dragon_Akatsuki (N)
					N:Jutsus += new/obj/Jutsus/Water_Dash (N)
					N:Jutsus += new/obj/Jutsus/Immense_Tsunami (N)

				if(Type == "Konan")
					N:Village = "Akatsuki"
					N:name = "{NPC} Konan"
					N:icon = 'Graphics/Characters/Konan.dmi'
					N:Jutsus += new/obj/Jutsus/Paper_Trap (N)
					N:Jutsus += new/obj/Jutsus/Paper_Throw (N)
					N:Jutsus += new/obj/Jutsus/Paper_Hurricane (N)
					N:Jutsus += new/obj/Jutsus/Paper_Tornado (N)
					N:Jutsus += new/obj/Jutsus/Dance_of_Wild_Papers (N)
					N:Jutsus += new/obj/Jutsus/Suffocating_Papers (N)

				if(Type == "Hidan")
					N:Village = "Akatsuki"
					N:name = "{NPC} Hidan"
					N:icon = 'Graphics/Characters/Hidan.dmi'
					N:Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (N)
					N:Jutsus += new/obj/Jutsus/Wrath_Of_Jashin (N)
					N:Jutsus += new/obj/Jutsus/Scythe_Strike (N)

				if(Type == "Danzou")
					N:Village = "Akatsuki"
					N:name = "{NPC} Danzou"
					N:icon = 'Graphics/Characters/Danzou.dmi'
					N:Jutsus += new/obj/Jutsus/Slash (N)
					N:Jutsus += new/obj/Jutsus/Wind_Blast (N)
					N:Jutsus += new/obj/Jutsus/Wind_Blade (N)
					N:Jutsus += new/obj/Jutsus/Wind_Storm_Danzou (N)
					N:Jutsus += new/obj/Jutsus/Wind_Wave (N)

				if(Type == "Guren")
					N:Village = "Akatsuki"
					N:name = "{NPC} Guren"
					N:icon = 'Graphics/Characters/Guren.dmi'
					N:Jutsus += new/obj/Jutsus/Crystal_Spikes (N)
					N:Jutsus += new/obj/Jutsus/Jaden_Blade (N)
					N:Jutsus += new/obj/Jutsus/Crystal_Shurikens (N)
					N:Jutsus += new/obj/Jutsus/Giant_Crystal_Shuriken (N)
					N:Jutsus += new/obj/Jutsus/Crystal_Explosive_Tree (N)
					N:Jutsus += new/obj/Jutsus/Crystal_Vortex (N)
					N:Jutsus += new/obj/Jutsus/Crystal_Wave (N)

				if(Type == "(Butterfly) Choji")
					N:Village = "Leaf"
					N:name = "{NPC} (Butterfly) Choji"
					N:icon = 'Graphics/Characters/ButterflyChoji.dmi'
					N:Jutsus += new/obj/Jutsus/Butterfly_Bullet_Bomb (N)

				if(Type == "Ginkaku")
					N:Village = "Akatsuki"
					N:name = "{NPC} Ginkaku"
					N:icon = 'Graphics/Characters/Ginkaku.dmi'
					N:Jutsus += new/obj/Jutsus/Kunai_Rush (N)

				if(Type == "Kinkaku")
					N:Village = "Akatsuki"
					N:name = "{NPC} Kinkaku"
					N:icon = 'Graphics/Characters/Kinkaku.dmi'
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_Kinkaku (N)
					N:Jutsus += new/obj/Jutsus/Fire_Dragon_Kinkaku (N)
					N:Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Kinkaku (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Kinkaku (N)
					N:Jutsus += new/obj/Jutsus/Five_Hungry_Sharks_Kinkaku (N)
					N:Jutsus += new/obj/Jutsus/Water_Dragon_Kinkaku (N)
					N:Jutsus += new/obj/Jutsus/Raiton_Sphere_Kinkaku (N)
					N:Jutsus += new/obj/Jutsus/Rock_Throw_Kinkaku (N)
					N:Jutsus += new/obj/Jutsus/Wind_Storm_Kinkaku (N)

				if(Type == "ANBU")
					N:Village = "Leaf"
					N:name = "{NPC} ANBU"
					N:icon = 'Graphics/Characters/ANBU.dmi'
					N:Jutsus += new/obj/Jutsus/Anbu_Combo (N)
					N:Jutsus += new/obj/Jutsus/Raiton_Sphere_Anbu (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_Anbu (N)
					N:Jutsus += new/obj/Jutsus/Giant_Fireball_Anbu (N)
					N:Jutsus += new/obj/Jutsus/Water_Dragon_Anbu (N)
					N:Jutsus += new/obj/Jutsus/Five_Hungry_Sharks_Anbu (N)
					N:Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone_Anbu (N)
					N:Jutsus += new/obj/Jutsus/Multiple_Exploding_Kunais_Throw_Anbu (N)

				if(Type == "(Lightning Armour) Raikage")
					N:Village = "Leaf"
					N:name = "{NPC} (Lightning Armour) Raikage"
					N:icon = 'Graphics/Characters/RaikageX.dmi'
					N:Jutsus += new/obj/Jutsus/Dash_Raikage (N)
					N:Jutsus += new/obj/Jutsus/Drop_Kick (N)
					N:Jutsus += new/obj/Jutsus/Liger_Bomb_Raikage (N)
					N:Jutsus += new/obj/Jutsus/Lariat_Raikage (N)
					N:Jutsus += new/obj/Jutsus/Elbow (N)

				if(Type == "Ebisu")
					N:Village = "Leaf"
					N:name = "{NPC} Ebisu"
					N:icon = 'Graphics/Characters/Ebisu.dmi'
					N:Jutsus += new/obj/Jutsus/Throw_Kunai_E1 (N)
					N:Jutsus += new/obj/Jutsus/Flaming_Shuriken_E1 (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_E1 (N)
					N:Jutsus += new/obj/Jutsus/Fire_Dragon_E1 (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_E1 (N)
					N:Jutsus += new/obj/Jutsus/Wind_Blast_E1 (N)
					N:Jutsus += new/obj/Jutsus/Wind_Blade_E1 (N)
					N:Jutsus += new/obj/Jutsus/Special_Combo_E1 (N)

				if(Type == "Mizukage")
					N:Village = "Leaf"
					N:name = "{NPC} Mizukage"
					N:icon = 'Graphics/Characters/Mei.dmi'
					N:Jutsus += new/obj/Jutsus/Lava_Shuriken (N)
					N:Jutsus += new/obj/Jutsus/Lava_Punches (N)
					N:Jutsus += new/obj/Jutsus/Lava_Cannon (N)
					N:Jutsus += new/obj/Jutsus/Lava_Whirl (N)
					N:Jutsus += new/obj/Jutsus/Lava_Punch (N)
					N:Jutsus += new/obj/Jutsus/Lava_Shoot (N)
					N:Jutsus += new/obj/Jutsus/Lava_Incineration (N)
					N:Jutsus += new/obj/Jutsus/Poison_Smoke (N)
					N:Jutsus += new/obj/Jutsus/Water_Revenge (N)

				if(Type == "Tsuchikage")
					N:Village = "Leaf"
					N:name = "{NPC} Tsuchikage"
					N:icon = 'Graphics/Characters/Tsuchikage.dmi'
					N:Jutsus += new/obj/Jutsus/Earth_Smash_Tsu (N)
					N:Jutsus += new/obj/Jutsus/Earth_Dragon_Tsu (N)
					N:Jutsus += new/obj/Jutsus/Rock_Smash (N)
					N:Jutsus += new/obj/Jutsus/Rock_Throw_Tsu (N)
					N:Jutsus += new/obj/Jutsus/Detachment_of_the_Primitive_World (N)
					N:Jutsus += new/obj/Jutsus/Flight (N)

				if(Type == "Special ANBU")
					N:Village = "Leaf"
					N:name = "{NPC} Special ANBU"
					N:icon = 'Graphics/Characters/ANBU Special.dmi'
					N:Jutsus += new/obj/Jutsus/Raiton_Sphere_AnbuS (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_AnbuS (N)
					N:Jutsus += new/obj/Jutsus/Giant_Fireball_AnbuS (N)
					N:Jutsus += new/obj/Jutsus/Water_Dragon_AnbuS (N)
					N:Jutsus += new/obj/Jutsus/Wind_Slash_AnbuS (N)
					N:Jutsus += new/obj/Jutsus/Earth_Wall_AnbuS (N)
					N:Jutsus += new/obj/Jutsus/Multiple_Exploding_Kunais_Throw_AnbuS (N)
					N:Jutsus += new/obj/Jutsus/Special_Combo_SA (N)

				if(Type == "(Kyuubi) Naruto")
					N:Village = "Leaf"
					N:name = "{NPC} (Kyuubi) Naruto"
					N:icon = 'Graphics/Characters/Naruto Kyuubi.dmi'
					N:Jutsus += new/obj/Jutsus/Kyuubi_Rasengan (N)
					N:Jutsus += new/obj/Jutsus/Kyuubi_Slash_Naruto (N)

				if(Type == "(Curse Seal) Jirobo")
					N:Village = "Akatsuki"
					N:name = "{NPC} (Curse Seal) Jirobo"
					N:icon = 'Graphics/Characters/JiroboCS.dmi'
					N:Jutsus += new/obj/Jutsus/Rock_Throw (N)
					N:Jutsus += new/obj/Jutsus/Brutal_Tackle (N)

				if(Type == "Zaku")
					N:Village = "Akatsuki"
					N:name = "{NPC} Zaku"
					N:icon = 'Graphics/Characters/Zaku.dmi'
					N:Jutsus += new/obj/Jutsus/Airwave (N)
					N:Jutsus += new/obj/Jutsus/Compressed_Airwave (N)
					N:Jutsus += new/obj/Jutsus/Explosive_Airwave (N)

				if(Type == "Dosu")
					N:Village = "Akatsuki"
					N:name = "{NPC} Dosu"
					N:icon = 'Graphics/Characters/Dosu.dmi'
					N:Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Dosu (N)
					N:Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone_Dosu (N)
					N:Jutsus += new/obj/Jutsus/Resonating_Echo_Drill (N)
					N:Jutsus += new/obj/Jutsus/Resonating_Shockwave (N)

				if(Type == "Sai")
					N:Village = "Leaf"
					N:name = "{NPC} Sai"
					N:icon = 'Graphics/Characters/Sai.dmi'
					N:Jutsus += new/obj/Jutsus/Ink_Lion (N)
					N:Jutsus += new/obj/Jutsus/Ink_Snake (N)
					N:Jutsus += new/obj/Jutsus/Ink_Dragon (N)
					N:Jutsus += new/obj/Jutsus/Ink_Bird (N)

				if(Type == "Asuma")
					N:Village = "Leaf"
					N:name = "{NPC} Asuma"
					N:icon = 'Graphics/Characters/Asuma.dmi'
					N:Jutsus += new/obj/Jutsus/Chakra_Blade_Punch (N)
					N:Jutsus += new/obj/Jutsus/Chakra_Blade_Throw (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_Asuma (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Asuma (N)

				if(Type == "{PS} Sasuke")
					N:Village = "Leaf"
					N:name = "{NPC} {PS} Sasuke"
					N:icon = 'Graphics/Characters/LilSasuke.dmi'
					N:Jutsus += new/obj/Jutsus/Chidori_PSasuke (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_PSasuke (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_PSasuke (N)

				if(Type == "Madara")
					N:Village = "Akatsuki"
					N:name = "{NPC} Madara"
					N:icon = 'Graphics/Characters/Madara.dmi'
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_Madara (N)
					N:Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Madara (N)
					N:Jutsus += new/obj/Jutsus/Fire_Dragon (N)
					N:Jutsus += new/obj/Jutsus/Amaterasu_Ball (N)

				if(Type == "{PS} Kakashi")
					N:Village = "Leaf"
					N:name = "{NPC} {PS} Kakashi"
					N:icon = 'Graphics/Characters/LilKakashi.dmi'
					N:Jutsus += new/obj/Jutsus/Chidori_PKakashi (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_PKakashi (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_PKakashi (N)
					N:Jutsus += new/obj/Jutsus/Raiton_Sphere_PKakashi (N)
					N:Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_PKakashi (N)

				if(Type == "{PS} (Curse Seal) Sasuke")
					N:Village = "Leaf"
					N:name = "{NPC} {PS} (Curse Seal) Sasuke"
					N:icon = 'Graphics/Characters/LilSasukeCS.dmi'
					N:Jutsus += new/obj/Jutsus/Chidori_CPSasuke (N)
					N:Jutsus += new/obj/Jutsus/Phoenix_Flower_CPSasuke (N)
					N:Jutsus += new/obj/Jutsus/Giant_FireBall_CPSasuke (N)




mob/Dragonpearl123/verb/Destroy_NPCs()
	set category = "NPCs"
	if(!key=="Dragonpearl123")
		src << output("<b><font color=red><center>This function was disabled to prevent the lag, we're sorry.","Chat")
		return
	Current_Log.Add("*[key] destroyed all NPCs!", 1)
	for(var/mob/NPC/N) del(N)
	Yamato = 0
	Yagura = 0
	Naruto = 0
	Kisame = 0
	Zetsu = 0

mob/var/_Special_NPC_ = 0

mob/NPC

	var
		Bumped
		Jumping = 0
		UnEffective = 0

	Genin_NPC
		icon = 'Graphics/Characters/Yondaime.dmi'
		name = "{Jounin} Yondaime"
		_Special_NPC_ = 1
		Real_Person = 1
		Check_Icon = 1
		running = 1
		Real = 1
		Deaths = 3
		Checked_X = 1
		var/Phoenix

		bump(atom/T, d)
			..()
			if(isturf(T))
				if(d == LEFT || d == RIGHT)
					if(d == RIGHT &&  px - Target.px > 0) return
					if(d == LEFT && px - Target.px < 0) return
					jump()
					spawn(3) if(!Double_Jump) double_jump()

		New()
			..()
			src.Jutsus += new/obj/Jutsus/Rasengan_Yondaime (src)
			Str = 12.5
			Def = 7
			MaxHP = 100000000000000000
			HP = MaxHP
			MaxCha = 10000000000000
			Cha = MaxCha
			MaxEnergy = 10000000000000
			Energy = MaxEnergy
			Recover()
			set_state()
			spawn() _Check_Target()

		proc/Phoenix()
			..()
			Phoenix = 1
			freeze = 100

			loop
				if(!Phoenix) return
				Flick("mob-shooting", src)
				var/mob/A = new/mob/Ultimate_Projectile/Phoenix_Flower(null, src)
				A.pixel_y = rand(-16,16)
				spawn(4) goto loop

		proc/_Check_Target()
			set background = 1

			..()
			loop
				if(Phoenix) return

				if(Target.Dragonned)
					running = 1
					switch(rand(1,2))
						if(1)
							vel_x = 10
							dir = EAST
						if(2)
							vel_x = -10
							dir = WEST
					spawn(5) goto loop
				else _AI()

		proc/_AI()
			set background = 1

			loop
				if(Phoenix) return
				running = 1

				if(prob(75))
					var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 240, 80)
					var/list/Projectile = Bounds.Projectile()
					for(var/mob/M in Projectile)
						if(abs(px - M.px) < 220)
							if(prob(35)) Substitution()
							else if(prob(15)) Set_Dodge()
						else
							jump()
							spawn() double_jump()

				if(prob(75))
					Bumped = 0
					if(Target.freeze) if(prob(7)) Set_Dodge()
					if(Target.Attacking == 1)
						if(prob(15)) Substitution()
						else if(prob(15)) Set_Dodge()
					if(!knocked && !knockback && !freeze && !Attacking && prob(3) && Target:py >= py && abs(px -Target.px) <= 128)
						for(var/obj/Jutsus/Rasengan_Yondaime/O in src.Jutsus) O.Click()

				if(!knockback)
					if(Target.py > py)
						if(!on_ground && !Double_Jump) double_jump()
						if(on_ground && Jumping == 0)
							vel_y = 12
							Jumping = 1
							spawn(10) Jumping = 0

					vel_x = (Target.px - px) /1.65
					if(vel_x > 0)
						dir = EAST
						if(vel_x > 23) vel_x = 23
						if(vel_x < 14) vel_x = 14

					else if(vel_x < 0)
						dir = WEST
						if(vel_x < -23) vel_x = -23
						if(vel_x > -14) vel_x = -14

					else
						vel_x = pick(-5, 5)
						if(vel_x > 0) dir = EAST
						if(vel_x < 0) dir = WEST

				if(!Target.Dragonned) spawn(5) goto loop
				else _Check_Target()


	Custom
		dir = EAST
		Real_Person = 1
		Check_Icon = 1
		running = 1
		Real = 1
		Deaths = 3
		Checked_X = 1
		New()
			..()
			Str = 12.5
			Def = 6.5
			MaxHP = 150
			HP = MaxHP
			MaxCha = 10000000000000
			Cha = MaxCha
			MaxEnergy = 10000000000000
			Energy = MaxEnergy
			Recover()
			set_state()
			spawn() Check_Target()

	Zetsu
		name = "{Clone} Zetsu"
		Village = "Akatsuki"
		icon = 'Graphics/Characters/Zetsu.dmi'
		dir = EAST
		Real_Person = 1
		Check_Icon = 1
		running = 1
		Real = 1
		Deaths = 3
		Checked_X = 1
		New()
			..()
			src.Jutsus += new/obj/Jutsus/Chakra_Sphere (src)
			Str = 11.5
			Def = 5.5
			MaxHP = 100
			HP = MaxHP
			MaxCha = 10000000000000
			Cha = MaxCha
			MaxEnergy = 10000000000000
			Energy = MaxEnergy
			Recover()
			set_state()
			spawn() Check_Target()


	Yamato
		name = "{Clone} Yamato"
		Village = "Leaf"
		icon = 'Graphics/Characters/Yamato.dmi'
		dir = EAST
		Real_Person = 1
		Check_Icon = 1
		running = 1
		Real = 1
		Deaths = 3
		Checked_X = 1
		New()
			..()
			Str = 11.5
			Def = 5.5
			MaxHP = 100
			HP = MaxHP
			MaxCha = 10000000000000
			Cha = MaxCha
			MaxEnergy = 10000000000000
			Energy = MaxEnergy
			Recover()
			set_state()
			spawn() Check_Target()


	Naruto
		name = "{Clone} Naruto"
		Village = "Leaf"
		icon  = 'Graphics/Characters/Naruto.dmi'
		dir = EAST
		Real_Person = 1
		Check_Icon = 1
		running = 1
		Real = 1
		Deaths = 3
		Checked_X = 1
		New()
			..()
			src.Jutsus += new/obj/Jutsus/Naruto_Rasengan (src)
			src.Jutsus += new/obj/Jutsus/Giant_Rasengan (src)
			Str = 11.5
			Def = 5.5
			MaxHP = 100
			HP = MaxHP
			MaxCha = 10000000000000
			Cha = MaxCha
			MaxEnergy = 10000000000000
			Energy = MaxEnergy
			Recover()
			set_state()
			spawn() Check_Target()

	Kisame
		name = "{Clone} Kisame"
		Village = "Akatsuki"
		icon = 'Graphics/Characters/Kisame.dmi'
		dir = EAST
		Real_Person = 1
		Check_Icon = 1
		running = 1
		Real = 1
		Deaths = 3
		Checked_X = 1
		New()
			..()
			src.Jutsus += new/obj/Jutsus/Five_Hungry_Sharks_Kisame (src)
			src.Jutsus += new/obj/Jutsus/Water_Dragon_Kisame (src)
			src.Jutsus += new/obj/Jutsus/Immense_Tsunami_Kisame (src)
			Str = 11.5
			Def = 5.5
			MaxHP = 100
			HP = MaxHP
			MaxCha = 10000000000000
			Cha = MaxCha
			MaxEnergy = 10000000000000
			Energy = MaxEnergy
			Recover()
			set_state()
			spawn() Check_Target()

	Kushimaru
		name = "{Clone} Kushimaru"
		Village = "Leaf"
		icon = 'Graphics/Characters/Kushimaru.dmi'
		dir = EAST
		Real_Person = 1
		Check_Icon = 1
		running = 1
		Real = 1
		Deaths = 3
		Checked_X = 1
		New()
			..()
			src.Kushimaru_Proc()
			src.Jutsus += new/obj/Jutsus/Water_Tsunami (src)
			src.Jutsus += new/obj/Jutsus/Needle_Throw_ (src)
			src.Jutsus += new/obj/Jutsus/Needle_Cutting_Bind (src)
			src.Jutsus += new/obj/Jutsus/Water_Dash_Kus (src)
			src.Jutsus += new/obj/Jutsus/Water_Dragon_Kus (src)
			src.Jutsus += new/obj/Jutsus/Water_Vortex_Kus (src)
			Str = 11.5
			Def = 5.5
			MaxHP = 100
			HP = MaxHP
			MaxCha = 10000000000000
			Cha = MaxCha
			MaxEnergy = 10000000000000
			Energy = MaxEnergy
			Recover()
			set_state()
			spawn() Check_Target()


	Akamaru
		icon = 'Graphics/Skills/Akamaru.dmi'
		name = "Akamaru"
		Real_Person = 1
		running = 1
		Real = 1
		Checked_X = 1
		New()
			..()
			Energy = 10000000000000
			Str = 12.50
			Def = 6.5
			MaxHP = rand(200, 250)
			HP = MaxHP
			Recover()
			set_state()
			spawn() Check_Target()

	Yagura
		name = "{Clone} Yagura"
		Village = "Leaf"
		icon = 'Graphics/Characters/Yagura.dmi'
		dir = EAST
		Real_Person = 1
		Check_Icon = 1
		running = 1
		Real = 1
		Deaths = 3
		Checked_X = 1
		New()
			..()
			src.Jutsus += new/obj/Jutsus/Throw_Kunai_Y (src)
			src.Jutsus += new/obj/Jutsus/Water_Shark_Y (src)
			src.Jutsus += new/obj/Jutsus/Water_Tsunami (src)
			src.Jutsus += new/obj/Jutsus/Sanbi_Grasp (src)
			Str = 11.5
			Def = 5.5
			MaxHP = 100
			HP = MaxHP
			MaxCha = 10000000000000
			Cha = MaxCha
			MaxEnergy = 10000000000000
			Energy = MaxEnergy
			Recover()
			set_state()
			spawn() Check_Target()



	bump(mob/M)
		..()
		if(!Bumped)
			if(ismob(M))
				if(Target)
					if(M == Target)
						UnEffective = 0
						Bumped = 1
						Attack()
						stop()
					if(M != Target && Target:py >= py)
						if(!on_ground && !Double_Jump) double_jump()
						if(on_ground) jump()
				if(!Target)
					if(!on_ground && !Double_Jump) double_jump()
					if(on_ground) jump()

	proc/Check_Target()
		set background = 1

		..()
		loop
			if(Target)
				AI()
				return

			if(dead)
				if(Target) Target.Enemies_Following.Remove(src)
				Target = null
				return
			if(!Target)
				var/C
				var/Difference = 1000000
				UnEffective = 0
				for(var/mob/M in hearers(30))
					if(M.name != M.key && M.client && !M.knocked && !M.dead && M.Village != Village && !C && !M.Substitution)
						var/Difference_ = abs(py - M.py) + abs(px - M.px)
						if(Difference_ < Difference)
							var/Enemies = 0
							for(var/mob/T in M.Enemies_Following) if(T.dead == 0 && T.Target == M) Enemies++
							if(Enemies < 3)
								Difference = Difference_
								Target = M
				if(Target)
					Target.Enemies_Following.Add(src)
					C++
					AI()
					return

				running = 1
				switch(rand(1,2))
					if(1)
						vel_x = 10
						dir = EAST
					if(2)
						vel_x = -10
						dir = WEST
				spawn(5) goto loop

	proc/AI()
		set background = 1

		loop
			if(dead) return

			var/A
			running = 1
			UnEffective ++

			if(prob(75))
				var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 240, 80)
				var/list/Projectile = Bounds.Projectile()
				for(var/mob/M in Projectile)
					if(abs(px - M.px) < 220)
						if(prob(35) && name != "Akamaru") Substitution()
						else if(prob(75)) Set_Dodge()
					else
						jump()
						spawn() double_jump()

			for(var/mob/M in hearers(30))

				if(!Target) break

				if(UnEffective > 50 || Target.dead || Target.Substitution == 1)
					A++
					Target = null
					Check_Target()
					break

				if(M == Target)
					A++
					Bumped = 0
					if(M.freeze) if(prob(25)) Set_Dodge()
					if(M.Attacking == 1)
						if(prob(15)) Substitution()
						else if(prob(35)) Set_Dodge()
					if(!knocked && !knockback && !freeze && !input_lock && !Attacking && !M.knocked)
						if(prob(5) && Target:py >= py)
							var/U
							for(var/obj/O in Jutsus)
								if(!U && prob(25))
									U++
									O.Click()

						if(Target.py > py)
							if(!on_ground && !Double_Jump) double_jump()
							if(on_ground && Jumping == 0)
								vel_y = 12
								Jumping = 1
								spawn(10) Jumping = 0

						if(Target.px > px)
							dir = EAST
							vel_x = 15

						if(Target.px < px)
							dir = WEST
							vel_x = -15

						if(Target.px == px)
							vel_x = pick(-15, 15)
							if(vel_x > 0) dir = EAST
							if(vel_x < 0) dir = WEST

					spawn(5) goto loop


			if(!A)
				Target = null
				Check_Target()

mob/var/AI = 0
mob/var/AttackedbyAkamaru = 0
var/Zetsu = 0
var/Kisame = 0
var/Yamato = 0
var/Yagura = 0
var/Kushimaru = 0
var/Naruto = 0