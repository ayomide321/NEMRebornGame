turf/Mark
	icon = 'Black S.dmi'
	layer = 1000

mob
	proc
		Suigetsu_Proc()
			..()
			loop
				if(name != "Suigetsu") return
				src.pixel_x = 16
				spawn(100) goto loop
		Bijuu_Proc()
			..()
			loop
				if(name == "(Kyuubi) Ginkaku" || name == "(Kyuubi) Kinkaku")
					src.pixel_x = 18
					spawn(100) goto loop

		Check_Jutsu()
			..()
			spawn()
				Avatar(name)
				src.Selecting_Jutsu = null
				src.Selected_Jutsu = null
				src.Real_Character_Name = name
				src.Old_Name = src.name
				for(var/obj/J in src.Jutsus)
					src.Jutsus -= J
					del(J)

				for(var/obj/Chain_Kunais_Jutsu/SS in src) del(SS)
				for(var/obj/Shuriken_Jutsu/SS in src) del(SS)
				for(var/obj/Scroll_Kunais_Jutsu/SS in src) del(SS)
				for(var/obj/Shadow_Sewing/SS in src) del(SS)
				for(var/obj/Shadow_Neck/SS in src) del(SS)
				if(Shurikens_L) Shuriken_Jutsu = new/obj/Shuriken_Jutsu (src, "[Shurikens_L]/[Shurikens] Makibishi Spikes (G)")
				if(Kunais_L) Kunai_Jutsu = new/obj/Chain_Kunais_Jutsu (src, "[Kunais_L]/[Kunais] Chain Kunais (T)")
				if(Scroll_Kunais_L) Scroll_Kunai_Jutsu = new/obj/Scroll_Kunais_Jutsu (src, "[Scroll_Kunais_L]/[Scroll_Kunais] Kunai Scrolls (Y)")

				if(Mission_On && Mission_On.Name == "Weed Picking") return

				if(src.name == "Naruto")
					src.Jutsus += new/obj/Jutsus/Naruto_Uzumaki_Barrage (src)
					src.Jutsus += new/obj/Jutsus/Naruto_Rasengan (src)
					src.Jutsus += new/obj/Jutsus/Giant_Rasengan (src)
					src.Jutsus += new/obj/Jutsus/Rasenshuriken (src)
					src.Jutsus += new/obj/Jutsus/Throw_Rasenshuriken (src)
					src.Jutsus += new/obj/Jutsus/Sage_Mode (src)
					src.Jutsus += new/obj/Jutsus/Clone_Jutsu_Naruto (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Raikage")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (src)
					src.Jutsus += new/obj/Jutsus/Liger_Bomb (src)
					src.Jutsus += new/obj/Jutsus/Guillotine_Drop (src)
					src.Jutsus += new/obj/Jutsus/Endless_Kicks (src)
					src.Jutsus += new/obj/Jutsus/Lariat_Raikage_X (src)
					src.Jutsus += new/obj/Jutsus/Transform_Raikage (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Anko")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Anko (src)
					src.Jutsus += new/obj/Jutsus/Striking_Shadow_Snakes (src)
					src.Jutsus += new/obj/Jutsus/Snake_Summoning (src)
					src.Jutsus += new/obj/Jutsus/Snake_Grasp (src)
					src.Jutsus += new/obj/Jutsus/Remember_Spot_Anko (src)
					src.Jutsus += new/obj/Jutsus/Underground_Snake_Swamp (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Ebisu")
					src.Jutsus += new/obj/Jutsus/Throw_Kunai_E1 (src)
					src.Jutsus += new/obj/Jutsus/Flaming_Shuriken_E1 (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_E1 (src)
					src.Jutsus += new/obj/Jutsus/Fire_Dragon_E1 (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_E1 (src)
					src.Jutsus += new/obj/Jutsus/Wind_Blast_E1 (src)
					src.Jutsus += new/obj/Jutsus/Wind_Blade_E1 (src)
					src.Jutsus += new/obj/Jutsus/Special_Combo_E1 (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Mizukage")
					src.Jutsus += new/obj/Jutsus/Lava_Shuriken (src)
					src.Jutsus += new/obj/Jutsus/Lava_Punches (src)
					src.Jutsus += new/obj/Jutsus/Lava_Cannon (src)
					src.Jutsus += new/obj/Jutsus/Lava_Whirl (src)
					src.Jutsus += new/obj/Jutsus/Lava_Punch (src)
					src.Jutsus += new/obj/Jutsus/Lava_Shoot (src)
					src.Jutsus += new/obj/Jutsus/Lava_Incineration (src)
					src.Jutsus += new/obj/Jutsus/Poison_Smoke (src)
					src.Jutsus += new/obj/Jutsus/Water_Revenge (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Tsuchikage")
					src.Jutsus += new/obj/Jutsus/Earth_Smash_Tsu (src)
					src.Jutsus += new/obj/Jutsus/Earth_Dragon_Tsu (src)
					src.Jutsus += new/obj/Jutsus/Earth_Uprising (src)
					src.Jutsus += new/obj/Jutsus/Rock_Walls (src)
					src.Jutsus += new/obj/Jutsus/Rock_Smash (src)
					src.Jutsus += new/obj/Jutsus/Rock_Throw_Tsu (src)
					src.Jutsus += new/obj/Jutsus/Rockfall (src)
					src.Jutsus += new/obj/Jutsus/Flight (src)
					src.Jutsus += new/obj/Jutsus/Detachment_of_the_Primitive_World (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Eternal Sasuke")
					src.Jutsus += new/obj/Jutsus/Chidori_Senbon (src)
					src.Jutsus += new/obj/Jutsus/Fire_Dragon_EMS (src)
					src.Jutsus += new/obj/Jutsus/Chidori_EMS (src)
					src.Jutsus += new/obj/Jutsus/Chidori_Stab(src)
					src.Jutsus += new/obj/Jutsus/Susanoo_Shield(src)
					src.Jutsus += new/obj/Jutsus/Supreme_Kirin(src)
					src.Jutsus += new/obj/Jutsus/Amaterasu_Control(src)
					src.Jutsus += new/obj/Jutsus/Susanoo_Crushing_Grip(src)
					src.Jutsus += new/obj/Jutsus/Absolute_Control(src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Rinnegan) Sasuke")
					src.Jutsus += new/obj/Jutsus/Rinnegan (src)
					src.Jutsus += new/obj/Jutsus/Amat_Sword (src)
					src.Jutsus += new/obj/Jutsus/Chidori_Rinne (src)
					src.Jutsus += new/obj/Jutsus/Rinnegan_Slash (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_E1 (src)
					src.Jutsus += new/obj/Jutsus/Amaterasu_AOE_RS (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return
				if(src.name == "Lord Madara")
					src.Jutsus += new/obj/Jutsus/Rinnegan (src)
					src.Jutsus += new/obj/Jutsus/Shisui_FireBall (src)
					src.Jutsus += new/obj/Jutsus/Doton_PunchM (src)
					src.Jutsus += new/obj/Jutsus/Tele_Slash (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Lightning Armour) Raikage")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (src)
					src.Jutsus += new/obj/Jutsus/Dash_Raikage (src)
					src.Jutsus += new/obj/Jutsus/Drop_Kick (src)
					src.Jutsus += new/obj/Jutsus/Liger_Bomb_Raikage (src)
					src.Jutsus += new/obj/Jutsus/Lariat_Raikage (src)
					src.Jutsus += new/obj/Jutsus/Elbow (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "ANBU")
					src.Jutsus += new/obj/Jutsus/Anbu_Combo (src)
					src.Jutsus += new/obj/Jutsus/Raiton_Sphere_Anbu (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Anbu (src)
					src.Jutsus += new/obj/Jutsus/Giant_Fireball_Anbu (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Anbu (src)
					src.Jutsus += new/obj/Jutsus/Five_Hungry_Sharks_Anbu (src)
					src.Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone_Anbu (src)
					src.Jutsus += new/obj/Jutsus/Multiple_Exploding_Kunais_Throw_Anbu (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Special ANBU")
					src.Jutsus += new/obj/Jutsus/Raiton_Sphere_AnbuS (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_AnbuS (src)
					src.Jutsus += new/obj/Jutsus/Giant_Fireball_AnbuS (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_AnbuS (src)
					src.Jutsus += new/obj/Jutsus/Wind_Slash_AnbuS (src)
					src.Jutsus += new/obj/Jutsus/Earth_Wall_AnbuS (src)
					src.Jutsus += new/obj/Jutsus/Spin_Kick (src)
					src.Jutsus += new/obj/Jutsus/Multiple_Exploding_Kunais_Throw_AnbuS (src)
					src.Jutsus += new/obj/Jutsus/Special_Combo_SA (src)
					src.Jutsus += new/obj/Jutsus/Bird_AnbuS (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kinkaku")
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Fire_Dragon_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Five_Hungry_Sharks_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Raiton_Sphere_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Rock_Throw_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Wind_Storm_Kinkaku (src)
					src.Jutsus += new/obj/Jutsus/Kyuubi_Mode_K (src)
					for(var/obj/Jutsus/Kyuubi_Mode_K/G in src) G.Delay(45)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Ginkaku")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Ginkaku (src)
					src.Jutsus += new/obj/Jutsus/Kunai_Rush (src)
					src.Jutsus += new/obj/Jutsus/Absorb_Soul (src)
					src.Jutsus += new/obj/Jutsus/Release_Soul (src)
					src.Jutsus += new/obj/Jutsus/Kyuubi_Mode_G (src)
					for(var/obj/Jutsus/Kyuubi_Mode_G/G in src) G.Delay(45)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Kyuubi) Ginkaku")
					pwidth = 52+46
					Bijuu_Proc()
					src.Jutsus += new/obj/Jutsus/Bijuu_Dama (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Kyuubi) Kinkaku")
					pwidth = 52+46
					Bijuu_Proc()
					src.Jutsus += new/obj/Jutsus/Bijuu_Dama (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Guren")
					src.Jutsus += new/obj/Jutsus/Crystal_Spikes (src)
					src.Jutsus += new/obj/Jutsus/Jaden_Blade (src)
					src.Jutsus += new/obj/Jutsus/Crystal_Shurikens (src)
					src.Jutsus += new/obj/Jutsus/Giant_Crystal_Shuriken (src)
					src.Jutsus += new/obj/Jutsus/Crystal_Explosive_Tree (src)
					src.Jutsus += new/obj/Jutsus/Crystal_Vortex (src)
					src.Jutsus += new/obj/Jutsus/Crystal_Wave (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Kyuubi) Naruto")
					src.Jutsus += new/obj/Jutsus/Kyuubi_Rasengan (src)
					src.Jutsus += new/obj/Jutsus/Kyuubi_Slash_Naruto (src)
					src.Jutsus += new/obj/Jutsus/Kyuubi_Hand_Crush (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Choji")
					src.Jutsus += new/obj/Jutsus/Expand (src)
					src.Jutsus += new/obj/Jutsus/Boulder (src)
					src.Jutsus += new/obj/Jutsus/Butterfly_Mode (src)
					src.Jutsus += new/obj/Jutsus/Spinach_Pill (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Butterfly) Choji")
					src.Jutsus += new/obj/Jutsus/Butterfly_Bullet_Bomb (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return


				if(src.name == "Kiba")
					src.Jutsus += new/obj/Jutsus/Akamaru_Summon (src)
					src.Jutsus += new/obj/Jutsus/Akamaru_Transformation (src)
					src.Jutsus += new/obj/Jutsus/Fang_Over_Fang (src)
					src.Jutsus += new/obj/Jutsus/Wolf_Fang_Over_Fang (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Hidan")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (src)
					src.Jutsus += new/obj/Jutsus/Wrath_Of_Jashin (src)
					src.Jutsus += new/obj/Jutsus/Scythe_Strike (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Danzou")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Slash (src)
					src.Jutsus += new/obj/Jutsus/Wind_Shield (src)
					src.Jutsus += new/obj/Jutsus/Wind_Blast (src)
					src.Jutsus += new/obj/Jutsus/Wind_Blade (src)
					src.Jutsus += new/obj/Jutsus/Wind_Storm_Danzou (src)
					src.Jutsus += new/obj/Jutsus/Wind_Wave (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Haku")
					src.Jutsus += new/obj/Jutsus/Senbon_Throw (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Haku (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Haku (src)
					src.Jutsus += new/obj/Jutsus/Ice_Spike (src)
					src.Jutsus += new/obj/Jutsus/Hijutsu (src)
					src.Jutsus += new/obj/Jutsus/Demon_Mirrors (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Curse Seal) Sakon")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw (src)
					src.Jutsus += new/obj/Jutsus/Bullet_Punch (src)
					src.Jutsus += new/obj/Jutsus/Rashomon (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Sakon")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw (src)
					src.Jutsus += new/obj/Jutsus/Bullet_Punch (src)
					src.Jutsus += new/obj/Jutsus/Curse_Seal_Sakon (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Curse Seal) Tayuya")
					src.Jutsus += new/obj/Jutsus/Illusionary_Warriors_Melody (src)
					src.Jutsus += new/obj/Jutsus/Revolt_Demon (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Tayuya")
					src.Jutsus += new/obj/Jutsus/Illusionary_Warriors_Melody (src)
					src.Jutsus += new/obj/Jutsus/Revolt_Demon (src)
					src.Jutsus += new/obj/Jutsus/Curse_Seal_Tayuya (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Curse Seal) Jirobo")
					src.Jutsus += new/obj/Jutsus/Rock_Throw (src)
					src.Jutsus += new/obj/Jutsus/Brutal_Tackle (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Jirobo")
					src.Jutsus += new/obj/Jutsus/Earthquake (src)
					src.Jutsus += new/obj/Jutsus/Boulder (src)
					src.Jutsus += new/obj/Jutsus/Earth_Dome (src)
					src.Jutsus += new/obj/Jutsus/Curse_Seal_Jirobo (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Konan")
					src.Jutsus += new/obj/Jutsus/Paper_Trap (src)
					src.Jutsus += new/obj/Jutsus/Paper_Throw (src)
					src.Jutsus += new/obj/Jutsus/Paper_Hurricane (src)
					src.Jutsus += new/obj/Jutsus/Paper_Tornado (src)
					src.Jutsus += new/obj/Jutsus/Dance_of_Wild_Papers (src)
					src.Jutsus += new/obj/Jutsus/Suffocating_Papers (src)
					src.Jutsus += new/obj/Jutsus/Paper_Clone (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Tobirama Senju")
					src.Jutsus += new/obj/Jutsus/Water_Bubble (src)
					src.Jutsus += new/obj/Jutsus/Water_Bullet (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Akatsuki (src)
					src.Jutsus += new/obj/Jutsus/Water_Dash (src)
					src.Jutsus += new/obj/Jutsus/Water_Uprising (src)
					src.Jutsus += new/obj/Jutsus/Immense_Tsunami (src)
					src.Jutsus += new/obj/Jutsus/Ice_Shield (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Suigetsu")
					src.pwidth = 74
					src.Suigetsu_Proc()
					src.Jutsus += new/obj/Jutsus/Water_Palm_ (src)
					src.Jutsus += new/obj/Jutsus/Sword_Throw (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Akatsuki_X (src)
					src.Jutsus += new/obj/Jutsus/Five_Hungry_Sharks (src)
					src.Jutsus += new/obj/Jutsus/Water_Prison_ (src)
					src.Jutsus += new/obj/Jutsus/Suika (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Darui")
					src.Jutsus += new/obj/Jutsus/Darui (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Itachi (src)
					src.Jutsus += new/obj/Jutsus/Wave_Of_Inspiration (src)
					src.Jutsus += new/obj/Jutsus/Laser_Outburst (src)
					src.Jutsus += new/obj/Jutsus/Black_Panther (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Omoi")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw (src)
					src.Jutsus += new/obj/Jutsus/Raiton_Sphere_Omoi (src)
					src.Jutsus += new/obj/Jutsus/Sword_Rush (src)
					src.Jutsus += new/obj/Jutsus/Dual_Slash (src)
					src.Jutsus += new/obj/Jutsus/Crescent_Moon (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Mifune")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw (src)
					src.Jutsus += new/obj/Jutsus/Sword_Rush_Mifune (src)
					src.Jutsus += new/obj/Jutsus/Dual_Slash (src)
					src.Jutsus += new/obj/Jutsus/Molten_Hand (src)
					src.Jutsus += new/obj/Jutsus/Push_Back (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return


				if(src.name == "Zabuza")
					src.Jutsus += new/obj/Jutsus/Water_Bubble_Zabuza (src)
					src.Jutsus += new/obj/Jutsus/Water_Bullet_Zabuza (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Zabuza (src)
					src.Jutsus += new/obj/Jutsus/Water_Splash (src)
					src.Jutsus += new/obj/Jutsus/Water_Prison (src)
					src.Jutsus += new/obj/Jutsus/Ice_Spikes (src)
					src.Jutsus += new/obj/Jutsus/Immense_Tsunami_Zabuza (src)
					src.Jutsus += new/obj/Jutsus/Kirigakure_Jutsu (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Karin")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Karin (src)
					src.Jutsus += new/obj/Jutsus/Chakra_Rush (src)
					src.Jutsus += new/obj/Jutsus/Earth_Eruption (src)
					src.Jutsus += new/obj/Jutsus/Summon_GiantFireball (src)
					src.Jutsus += new/obj/Jutsus/Poison_Smoke_Bomb (src)
					src.Jutsus += new/obj/Jutsus/Heal_Karin (src)
					src.Jutsus += new/obj/Jutsus/Revive_Karin (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Rin")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (src)
					src.Jutsus += new/obj/Jutsus/Healing_Palm (src)
					src.Jutsus += new/obj/Jutsus/Heal_Rin (src)
					src.Jutsus += new/obj/Jutsus/Revive_Rin (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Gari")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Meele (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Combo (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Fist (src)
					src.Jutsus += new/obj/Jutsus/Flaming_Fist (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Gaara")
					src.Jutsus += new/obj/Jutsus/Sand_Manipulation (src)
					src.Jutsus += new/obj/Jutsus/Sand_Crush (src)
					src.Jutsus += new/obj/Jutsus/Sand_Shield (src)
					src.Jutsus += new/obj/Jutsus/Sand_Shuriken (src)
					src.Jutsus += new/obj/Jutsus/Sand_Bullet (src)
					src.Jutsus += new/obj/Jutsus/Sand_Spikes (src)
					src.Jutsus += new/obj/Jutsus/Sand_Tsunami (src)
					src.Jutsus += new/obj/Jutsus/Shukaku_Claw (src)
					src.Jutsus += new/obj/Jutsus/Floating_Sand_Sphere (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Tsunade")
					src.Jutsus += new/obj/Jutsus/Sacrifice (src)
					for(var/obj/Jutsus/Sacrifice/P in src.Jutsus) P:Delay(90)
					src.Jutsus += new/obj/Jutsus/Cherry_Blossom_Impact_Tsunade (src)
					src.Jutsus += new/obj/Jutsus/Cherry_Blossom_Groundsmash (src)
					src.Jutsus += new/obj/Jutsus/Heal_Tsunade (src)
					src.Jutsus += new/obj/Jutsus/Revive_Tsunade (src)
					src.Jutsus += new/obj/Jutsus/Mass_Heal (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Orochimaru")
					src.Jutsus += new/obj/Jutsus/Snake_Bite (src)
					src.Jutsus += new/obj/Jutsus/Kusanagi (src)
					src.Jutsus += new/obj/Jutsus/Snake_Dash (src)
					src.Jutsus += new/obj/Jutsus/Snakes_Summoning (src)
					src.Jutsus += new/obj/Jutsus/Wind_BT (src)
					src.Jutsus += new/obj/Jutsus/Rashomon2 (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kankuro")
					src.Jutsus += new/obj/Jutsus/Basic_Puppet_Summon_Kankuro (src)
					src.Jutsus += new/obj/Jutsus/Salamander_Puppet_Summon (src)
					src.Jutsus += new/obj/Jutsus/Crow_Puppet_Summon (src)
					src.Jutsus += new/obj/Jutsus/Black_Ant (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Aoi")
					src.Jutsus += new/obj/Jutsus/Senbon_Throw (src)
					src.Jutsus += new/obj/Jutsus/Senbon_Shower (src)
					src.Jutsus += new/obj/Jutsus/Aoi_Combo (src)
					src.Jutsus += new/obj/Jutsus/Sword_Slash (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Sasori")
					src.Jutsus += new/obj/Jutsus/Basic_Puppet_Summon_Sasori (src)
					src.Jutsus += new/obj/Jutsus/Kazekage_Puppet_Summon (src)
					src.Jutsus += new/obj/Jutsus/Hiruko_Summon (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Sasori (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Sasori (src)
					src.Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone_Sasori (src)
					src.Jutsus += new/obj/Jutsus/Summoning_Puppets (src)
					src.Jutsus += new/obj/Jutsus/Summon_Puppet (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Granny Chiyo")
					src.Jutsus += new/obj/Jutsus/Basic_Puppet_Summon_Sasori (src)
					src.Jutsus += new/obj/Jutsus/Summoning_Puppets_Chiyo (src)
					src.Jutsus += new/obj/Jutsus/Summon_Puppet_Chiyo (src)
					src.Jutsus += new/obj/Jutsus/Heal_Chiyo (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Sasori (src)
					src.Jutsus += new/obj/Jutsus/Sasori_Puppet_Summon (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Hiruko")
					src.Jutsus += new/obj/Jutsus/Rocket_Punch (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Puppet Body) Sasori")
					src.Jutsus += new/obj/Jutsus/Fire_Stream (src)
					src.Jutsus += new/obj/Jutsus/Water_Stream (src)
					src.Jutsus += new/obj/Jutsus/Red_Secret_Technique (src)
					src.Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone_Sasori_X (src)
					src.Jutsus += new/obj/Jutsus/Summoning_Puppets_ (src)
					src.Jutsus += new/obj/Jutsus/Summon_Puppet_ (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Minato Namikaze")
					src.Jutsus += new/obj/Jutsus/Hiraishin_Kunai (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Minato (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Minato (src)
					src.Jutsus += new/obj/Jutsus/Rasengan_Minato (src)
					src.Jutsus += new/obj/Jutsus/Rasengan_Barrage (src)
					src.Jutsus += new/obj/Jutsus/Space_Time_Barrier (src)
					src.Jutsus += new/obj/Jutsus/Sealing_Formation_Genesis_Rebirth (src)
					src.Jutsus += new/obj/Jutsus/Flying_Thunder_God_ (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Hiruzen Sarutobi")
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Hiruzen (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Hiruzen (src)
					src.Jutsus += new/obj/Jutsus/Earth_Dragon (src)
					src.Jutsus += new/obj/Jutsus/Earth_Wall_Hiruzen (src)
					src.Jutsus += new/obj/Jutsus/Enma_Summon (src)
					src.Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone (src)
					src.Jutsus += new/obj/Jutsus/Adamantine_Trap (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kidoumaru")
					src.Jutsus += new/obj/Jutsus/Spider_Sticky_Gold (src)
					src.Jutsus += new/obj/Jutsus/Spider_Sticking_Spit (src)
					src.Jutsus += new/obj/Jutsus/Spider_Bind (src)
					src.Jutsus += new/obj/Jutsus/Curse_Seal_Kidoumaru (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Curse Seal) Kidoumaru")
					src.Jutsus += new/obj/Jutsus/Spider_Sticky_Gold (src)
					src.Jutsus += new/obj/Jutsus/Golden_Kunai_Slash (src)
					src.Jutsus += new/obj/Jutsus/Rain_Of_Arrows (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kimimaro")
					src.Jutsus += new/obj/Jutsus/Bone_Bullets (src)
					src.Jutsus += new/obj/Jutsus/Teshi_Sendan (src)
					src.Jutsus += new/obj/Jutsus/Curse_Seal_Kimimaro (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Curse Seal) Kimimaro")
					src.Jutsus += new/obj/Jutsus/Tessenka (src)
					src.Jutsus += new/obj/Jutsus/Sawarbi_No_Mai (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Tobi")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Fire_Dragon_Tobi (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Tobi (src)
					src.Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Tobi (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Tobi (src)
					src.Jutsus += new/obj/Jutsus/Flame_Battle_Encampment (src)
					src.Jutsus += new/obj/Jutsus/Flame_Imprisonment (src)
					src.Jutsus += new/obj/Jutsus/Flame_Tornado (src)
					for(var/obj/Jutsus/Flame_Tornado/F  in src) F:Delay(300)
					src.Jutsus += new/obj/Jutsus/Phase_Tobi (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kakuzu")
					src.Jutsus += new/obj/Jutsus/Flaming_Shuriken (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Kakuzu (src)
					src.Jutsus += new/obj/Jutsus/Fire_Coffin (src)
					src.Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Kakuzu (src)
					src.Jutsus += new/obj/Jutsus/Earth_Smash (src)
					src.Jutsus += new/obj/Jutsus/Raiton_Sphere_Kakuzu (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Itachi")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Itachi (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Itachi (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Itachi (src)
					src.Jutsus += new/obj/Jutsus/Crow_Genjutsu_Itachi (src)
					src.Jutsus += new/obj/Jutsus/Massive_Flaming_Shurikens (src)
					src.Jutsus += new/obj/Jutsus/Susanoo_Itachi (src)
					for(var/obj/Jutsus/Susanoo_Itachi/S in src.Jutsus) S:Delay(180)
					src.Jutsus += new/obj/Jutsus/Amaterasu_Itachi (src)
					for(var/obj/Jutsus/Amaterasu_Itachi/S in src.Jutsus) S:Delay(180)
					src.Jutsus += new/obj/Jutsus/Stop_Amaterasu_Flames_Itachi (src)
					src.Jutsus += new/obj/Jutsus/Tsukuyomi (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "ANBU Kakashi")
					src.Jutsus += new/obj/Jutsus/Mangekyou_Sharingan (src)
					src.Jutsus += new/obj/Jutsus/Ninken_II (src)
					src.Jutsus += new/obj/Jutsus/Raikiri_AK (src)
					src.Jutsus += new/obj/Jutsus/Fire_Dragon_E1 (src)
					src.Jutsus += new/obj/Jutsus/Kamui_AK (src)
					src.Jutsus += new/obj/Jutsus/Kamui_Dimension (src)
					src.Jutsus += new/obj/Jutsus/Kakashi_Clone (src)
					src.Jutsus += new/obj/Jutsus/Sharingan_CD (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Lord Itachi")
					src.Jutsus += new/obj/Jutsus/Mangekyou_Sharingan (src)
					src.Jutsus += new/obj/Jutsus/Fire_Dragon_RI (src)
					src.Jutsus += new/obj/Jutsus/Crow_Genjutsu_ (src)
					src.Jutsus += new/obj/Jutsus/Omni_Strike (src)
					src.Jutsus += new/obj/Jutsus/Amaterasu_AOE (src)
					src.Jutsus += new/obj/Jutsus/Amaterasu_Wildfire (src)
					src.Jutsus += new/obj/Jutsus/Tsukuyomi_ (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kabuchimaru")
					src.Jutsus += new/obj/Jutsus/Spider_Sticking_Spit_K (src)
					src.Jutsus += new/obj/Jutsus/Sound_Spiral_K (src)
					src.Jutsus += new/obj/Jutsus/Earthquake_K (src)
					src.Jutsus += new/obj/Jutsus/Sawarbi_No_Mai_K (src)
					src.Jutsus += new/obj/Jutsus/Fatal_Bite (src)
					src.Jutsus += new/obj/Jutsus/Killing_Snakes (src)
					src.Jutsus += new/obj/Jutsus/Devouring_Snakes (src)
					src.Jutsus += new/obj/Jutsus/Poisonous_Chakra_Scalpel (src)
					src.Jutsus += new/obj/Jutsus/Edo_Tensei (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Hanabi")
					src.Jutsus += new/obj/Jutsus/Byakugan (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Haku (src)
					src.Jutsus += new/obj/Jutsus/Hakke_Juushou (src)
					src.Jutsus += new/obj/Jutsus/Jyuuken_Shinan (src)
					src.Jutsus += new/obj/Jutsus/Jyuuken_Fury (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Suigetsu")
					src.Jutsus += new/obj/Jutsus/Water_Palm (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Akatsuki (src)
					src.Jutsus += new/obj/Jutsus/Five_Hungry_Sharks (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Ino")
					src.Jutsus += new/obj/Jutsus/Heal_Ino (src)
					src.Jutsus += new/obj/Jutsus/Poisonous_Flowers (src)
					src.Jutsus += new/obj/Jutsus/Giant_Poisonous_Flower (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Poisonous_Flowers (src)
					src.Jutsus += new/obj/Jutsus/NL_Mind_Transfer (src)
					src.Jutsus += new/obj/Jutsus/L_Mind_Transfer (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Sakura")
					src.Jutsus += new/obj/Jutsus/Sakura_Inner_Rage (src)
					src.Jutsus += new/obj/Jutsus/Cherry_Blossom_Impact_Sakura (src)
					src.Jutsus += new/obj/Jutsus/Cherry_Blossom_Groundsmash (src)
					src.Jutsus += new/obj/Jutsus/Heal_Sakura (src)
					src.Jutsus += new/obj/Jutsus/Revive_Sakura (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Yondaime")
					src.Jutsus += new/obj/Jutsus/Rasengan_Yondaime (src)
					src.Jutsus += new/obj/Jutsus/Hiraishin_Kunai_Yondaime (src)
					src.Jutsus += new/obj/Jutsus/Hiraishin_Ni_no_Dan (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Yondaime (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Yondaime (src)
					src.Jutsus += new/obj/Jutsus/Drop_Kunai (src)
					src.Jutsus += new/obj/Jutsus/Destroy_Kunai (src)
					src.Jutsus += new/obj/Jutsus/Teleport_To_Kunai (src)
					src.Jutsus += new/obj/Jutsus/Flying_Thunder_God_Yondaime (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Pein")
					src.Jutsus += new/obj/Jutsus/Absorption_Path (src)
					src.Jutsus += new/obj/Jutsus/Defensive_Path (src)
					src.Jutsus += new/obj/Jutsus/Offensive_Path (src)
					src.Jutsus += new/obj/Jutsus/Rain_Bomb (src)
					src.Jutsus += new/obj/Jutsus/Inferno (src)
					src.Jutsus += new/obj/Jutsus/Shinra_Tensei (src)
					for(var/obj/Jutsus/Shinra_Tensei/S in src.Jutsus) S:Delay(300)
					src.Jutsus += new/obj/Jutsus/Path_Of_Resurrection (src)
					for(var/obj/Jutsus/Path_Of_Resurrection/P in src.Jutsus) P:Delay(90)
					src.Jutsus += new/obj/Jutsus/Rinnegan_P (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Susanoo")
					src.Jutsus += new/obj/Jutsus/Throw_Arrow (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Sasuke")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Chidori_Sasuke (src)
					src.Jutsus += new/obj/Jutsus/Chidori_Stream (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Sasuke (src)
					src.Jutsus += new/obj/Jutsus/Kirin (src)
					src.Jutsus += new/obj/Jutsus/Susanoo_Sasuke (src)
					for(var/obj/Jutsus/Susanoo_Sasuke/S in src.Jutsus) S:Delay(180)
					src.Jutsus += new/obj/Jutsus/Amaterasu_Sasuke (src)
					for(var/obj/Jutsus/Amaterasu_Sasuke/S in src.Jutsus) S:Delay(180)
					src.Jutsus += new/obj/Jutsus/Stop_Amaterasu_Flames_Sasuke (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Shisui")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Shisui_FireBall (src)
					src.Jutsus += new/obj/Jutsus/Amaterasu_Ball_S (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Sasuke (src)
					src.Jutsus += new/obj/Jutsus/Shisui_Genjutsu (src)
					src.Jutsus += new/obj/Jutsus/Body_Flicker (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Curse Seal) Sasuke")
					src.Jutsus += new/obj/Jutsus/Chidori_CSasuke (src)
					src.Jutsus += new/obj/Jutsus/Chidori_Stream_2 (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_CSasuke (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Sage Naruto")
					src.Jutsus += new/obj/Jutsus/Sage_Rasengan (src)
					src.Jutsus += new/obj/Jutsus/Double_Rasengan (src)
					src.Jutsus += new/obj/Jutsus/Rasengan_Quake (src)
					src.Jutsus += new/obj/Jutsus/Throw_RasenshurikenX (src)
					src.Jutsus += new/obj/Jutsus/Frogs_Song (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Hinata")
					src.Jutsus += new/obj/Jutsus/Byakugan (src)
					src.Jutsus += new/obj/Jutsus/Eight_Trigrams_Air_Palm_ (src)
					src.Jutsus += new/obj/Jutsus/Eight_Trigrams_Sixty_Four_Palms (src)
					src.Jutsus += new/obj/Jutsus/Protection_Palms (src)
					src.Jutsus += new/obj/Jutsus/Jyuuken (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kakashi")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Chidori_Kakashi (src)
					src.Jutsus += new/obj/Jutsus/Raikiri (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Kakashi (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Kakashi (src)
					src.Jutsus += new/obj/Jutsus/Dynamic_Entry_Kakashi (src)
					src.Jutsus += new/obj/Jutsus/Primary_Lotus_Kakashi (src)
					src.Jutsus += new/obj/Jutsus/Doton_Fist (src)
					src.Jutsus += new/obj/Jutsus/One_Thousand (src)
					src.Jutsus += new/obj/Jutsus/Ninken (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Tenten")
					src.Jutsus += new/obj/Jutsus/Random_Weapon_Throw (src)
					src.Jutsus += new/obj/Jutsus/Iron_Ball (src)
					src.Jutsus += new/obj/Jutsus/Kunai_Grenade (src)
					src.Jutsus += new/obj/Jutsus/Scythe_Summoning (src)
					src.Jutsus += new/obj/Jutsus/Multiple_Exploding_Kunais_Throw (src)
					src.Jutsus += new/obj/Jutsus/Two_Rising_Dragons (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Temari")
					src.Jutsus += new/obj/Jutsus/Whirlwind (src)
					src.Jutsus += new/obj/Jutsus/Ferocious_Wind (src)
					src.Jutsus += new/obj/Jutsus/Wind_Tornado (src)
					src.Jutsus += new/obj/Jutsus/Wind_Scythe (src)
					src.Jutsus += new/obj/Jutsus/Wind_Storm_Temari (src)
					src.Jutsus += new/obj/Jutsus/Wind_Sea_Dragon (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Zaku")
					src.Jutsus += new/obj/Jutsus/Airwave (src)
					src.Jutsus += new/obj/Jutsus/Compressed_Airwave (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Airwave (src)
					src.Jutsus += new/obj/Jutsus/Wind_Wave_Zaku (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return


				if(src.name == "(Sanbi) Yagura")
					src.Jutsus += new/obj/Jutsus/Water_Bomb (src)
					src.Jutsus += new/obj/Jutsus/Claws (src)
					src.Jutsus += new/obj/Jutsus/Chakra_Implosion (src)
					src.Jutsus += new/obj/Jutsus/Water_Vortex (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return


				if(src.name == "Rinnegan Tobi")
					src.Jutsus += new/obj/Jutsus/Throw_Kunai_Y (src)
					src.Jutsus += new/obj/Jutsus/Fire_Dragon_T (src)
					src.Jutsus += new/obj/Jutsus/Phase (src)
					src.Jutsus += new/obj/Jutsus/Kamui (src)
					src.Jutsus += new/obj/Jutsus/Control_Kamui (src)
					src.Jutsus += new/obj/Jutsus/Rinnegan_Sword (src)
					src.Jutsus += new/obj/Jutsus/Sharingan_Genjutsu (src)
					src.Jutsus += new/obj/Jutsus/Doton_Punch (src)
					src.Jutsus += new/obj/Jutsus/Bansho_Tenin (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Yagura")
					src.Jutsus += new/obj/Jutsus/Throw_Kunai_Y (src)
					src.Jutsus += new/obj/Jutsus/Water_Clone (src)
					src.Jutsus += new/obj/Jutsus/Water_Shark_Y (src)
					src.Jutsus += new/obj/Jutsus/Water_Tsunami (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Y (src)
					src.Jutsus += new/obj/Jutsus/Sanbi_Grasp (src)
					src.Jutsus += new/obj/Jutsus/Transform_Y (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kakkou")
					src.Jutsus += new/obj/Jutsus/Throw_Kunai_Y (src)
					src.Jutsus += new/obj/Jutsus/Earth_Walls_K (src)
					src.Jutsus += new/obj/Jutsus/Earth_Dragon_K (src)
					src.Jutsus += new/obj/Jutsus/Lethal_Scratch (src)
					src.Jutsus += new/obj/Jutsus/Spinning_Slash (src)
					src.Jutsus += new/obj/Jutsus/Earth_Fall (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Sora")
					src.Jutsus += new/obj/Jutsus/Throw_Kunai_Y (src)
					src.Jutsus += new/obj/Jutsus/Beast_Tearing_Palm (src)
					src.Jutsus += new/obj/Jutsus/Beast_Tearing_Gale_Palm (src)
					src.Jutsus += new/obj/Jutsus/Beast_Tearing_Gale_Scratch (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Dosu")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Dosu (src)
					src.Jutsus += new/obj/Jutsus/Shuriken_Shadow_Clone_Dosu (src)
					src.Jutsus += new/obj/Jutsus/Resonating_Echo_Drill (src)
					src.Jutsus += new/obj/Jutsus/Resonating_Shockwave (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kin")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Dosu (src)
					src.Jutsus += new/obj/Jutsus/Senbon_Throw_K (src)
					src.Jutsus += new/obj/Jutsus/Sound_Spiral (src)
					src.Jutsus += new/obj/Jutsus/Resonating_Shockwave (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Might Gai")
					src.Jutsus += new/obj/Jutsus/Dynamic_Entry_Might_Gai (src)
					src.Jutsus += new/obj/Jutsus/Slap_Of_Youth_Might_Gai (src)
					src.Jutsus += new/obj/Jutsus/Primary_Lotus_Might_Gai (src)
					src.Jutsus += new/obj/Jutsus/Leaf_Hurricane_Might_Gai (src)
					src.Jutsus += new/obj/Jutsus/Open_Gates_Might_Gai (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Rock Lee" || src.name == "(Youthful) Rock Lee")
					src.Jutsus += new/obj/Jutsus/Primary_Lotus_Rock_Lee (src)
					src.Jutsus += new/obj/Jutsus/Leaf_Hurricane_Rock_Lee (src)
					src.Jutsus += new/obj/Jutsus/Open_Gates_Rock_Lee (src)
					src.Jutsus += new/obj/Jutsus/Drop_Weights (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return
				if(src.name == "(Opened Gates) Rock Lee")
					src.Jutsus += new/obj/Jutsus/Leaf_Hurricane_ (src)
					src.Jutsus += new/obj/Jutsus/Great_Whirlwind (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()

				if(src.name == "Deidara")
					src.Jutsus += new/obj/Jutsus/Clay_Dove (src)
					src.Jutsus += new/obj/Jutsus/Clay_Spider (src)
					src.Jutsus += new/obj/Jutsus/Clay_Totem (src)
					src.Jutsus += new/obj/Jutsus/Clay_Centipede (src)
					src.Jutsus += new/obj/Jutsus/Clay_Bird (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Chikushodo")
					src.Jutsus += new/obj/Jutsus/Throw_Chakra_Rod (src)
					src.Jutsus += new/obj/Jutsus/Water_Dash_C (src)
					src.Jutsus += new/obj/Jutsus/Wind_Shield (src)
					src.Jutsus += new/obj/Jutsus/Wind_Cutter (src)
					src.Jutsus += new/obj/Jutsus/Absorb (src)
					src.Jutsus += new/obj/Jutsus/Destroy_Soul (src)
					src.Jutsus += new/obj/Jutsus/Shinra_Tensei_C (src)
					src.Jutsus += new/obj/Jutsus/Chibaku_Tensei (src)
					src.Jutsus += new/obj/Jutsus/Summon_Ally (src)
					src.Jutsus += new/obj/Jutsus/Summon_Bird (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Nagato")
					src.Jutsus += new/obj/Jutsus/Rinnegan (src)
					src.Jutsus += new/obj/Jutsus/Throw_Chakra_Rod_N (src)
					src.Jutsus += new/obj/Jutsus/Absorb_N (src)
					src.Jutsus += new/obj/Jutsus/Tele_Slash (src)
					src.Jutsus += new/obj/Jutsus/Chibaku_Tensei_N (src)
					src.Jutsus += new/obj/Jutsus/Shinra_Tensei_N (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Sai")
					src.Jutsus += new/obj/Jutsus/Ink_Lion (src)
					src.Jutsus += new/obj/Jutsus/Ink_Eagle (src)
					src.Jutsus += new/obj/Jutsus/Ink_Snake (src)
					src.Jutsus += new/obj/Jutsus/Ink_Dragon (src)
					src.Jutsus += new/obj/Jutsus/Ink_Clone (src)
					src.Jutsus += new/obj/Jutsus/Ink_Bird (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Shino")
					src.Jutsus += new/obj/Jutsus/Aggressive_Bug_Swarm (src)
					src.Jutsus += new/obj/Jutsus/Insect_Sphere (src)
					src.Jutsus += new/obj/Jutsus/Bug_Levitation (src)
					src.Jutsus += new/obj/Jutsus/Bug_Bullet (src)
					src.Jutsus += new/obj/Jutsus/Bug_Storm (src)
					src.Jutsus += new/obj/Jutsus/Bug_Clone (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Jiraiya")
					src.Jutsus += new/obj/Jutsus/Rasengan_Jiraiya (src)
					src.Jutsus += new/obj/Jutsus/Hair_Needles (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Jiraiya (src)
					src.Jutsus += new/obj/Jutsus/Toad_Summon (src)
					src.Jutsus += new/obj/Jutsus/Sage_Mode_Jiraiya (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Sage Jiraiya")
					src.Jutsus += new/obj/Jutsus/Rasengan_Sage_Jiraiya (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Sage_Jiraiya (src)
					src.Jutsus += new/obj/Jutsus/Toad_Flame_Bullet (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kushimaru")
					src.Jutsus += new/obj/Jutsus/Needle_Throw_ (src)
					src.Jutsus += new/obj/Jutsus/Needle_Cutting_Bind (src)
					src.Jutsus += new/obj/Jutsus/Water_Dash_Kus (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Kus (src)
					src.Jutsus += new/obj/Jutsus/Water_Vortex_Kus (src)
					src.Jutsus += new/obj/Jutsus/Water_Tsunami_Kus (src)
					src.Jutsus += new/obj/Jutsus/Man_Eating_Sharks (src)
					src.Jutsus += new/obj/Jutsus/Water_Clone_Kus (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kisame")
					src.Jutsus += new/obj/Jutsus/Five_Hungry_Sharks_Kisame (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Kisame (src)
					src.Jutsus += new/obj/Jutsus/Immense_Tsunami_Kisame (src)
					src.Jutsus += new/obj/Jutsus/Clone_Jutsu_Kisame (src)
					src.Jutsus += new/obj/Jutsus/Water_Prison_ (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return
				if(src.name == "(UnCloaked) Kisame")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (src)
					src.Jutsus += new/obj/Jutsus/Senshokuko (src)
					src.Jutsus += new/obj/Jutsus/Water_Dragon_Kisame_ (src)
					src.Jutsus += new/obj/Jutsus/Water_Prison_Kisame (src)
					src.Jutsus += new/obj/Jutsus/Summoning_Sharks (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Asuma")
					src.Jutsus += new/obj/Jutsus/Chakra_Blade_Punch (src)
					src.Jutsus += new/obj/Jutsus/Chakra_Blade_Throw (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Asuma (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Asuma (src)
					src.Jutsus += new/obj/Jutsus/Flying_Swallow (src)
					src.Jutsus += new/obj/Jutsus/Ash_Pile_Burning (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Ashura) Naruto")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Rin (src)
					src.Jutsus += new/obj/Jutsus/Rasengan_Ashura (src)
					src.Jutsus += new/obj/Jutsus/SpecialAttack_AS(src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Asuma (src)
					src.Jutsus += new/obj/Jutsus/Ashura_Ball (src)
					src.Jutsus += new/obj/Jutsus/Throw_RasenshurikenXX (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "{PS} Sasuke")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Chidori_PSasuke (src)
					src.Jutsus += new/obj/Jutsus/Leaf_Hurricane_PSasuke (src)
					src.Jutsus += new/obj/Jutsus/Lion_Barrage (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_PSasuke (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_PSasuke (src)
					src.Jutsus += new/obj/Jutsus/Curse_Seal_PSasuke (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Madara")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Fire_Dragon (src)
					src.Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Madara (src)
					src.Jutsus += new/obj/Jutsus/Wood_Stab (src)
					src.Jutsus += new/obj/Jutsus/Wood_Dragon (src)
					src.Jutsus += new/obj/Jutsus/Amaterasu_Ball (src)
					src.Jutsus += new/obj/Jutsus/Heat_Explosion (src)
					src.Jutsus += new/obj/Jutsus/Great_FireBall_Shower (src)
					src.Jutsus += new/obj/Jutsus/Great_Fire_Annihilation (src)
					src.Jutsus += new/obj/Jutsus/Fire_Tornadoes_Madara (src)
					for(var/obj/Jutsus/Fire_Tornadoes_Madara/S in src) S:Delay(300)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Torune")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw (src)
					src.Jutsus += new/obj/Jutsus/Bug_Barrage (src)
					src.Jutsus += new/obj/Jutsus/Poison_Jab (src)
					src.Jutsus += new/obj/Jutsus/Fuuton_Poison (src)
					src.Jutsus += new/obj/Jutsus/Rising_Bug_Pillars (src)
					src.Jutsus += new/obj/Jutsus/Advent_Of_Bugs (src)
					src.Jutsus += new/obj/Jutsus/Insect_Apocalypse (src)
					src.Jutsus += new/obj/Jutsus/Poison_Transformation (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "{Venomous Insects} Torune")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw (src)
					src.Jutsus += new/obj/Jutsus/Mind_Body_Switch_Technique (src)
					src.Jutsus += new/obj/Jutsus/Venomous_Insect_Clone (src)
					src.Jutsus += new/obj/Jutsus/Rising_Bug_Pillars_ (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "{PS} Kakashi")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Chidori_PKakashi (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_PKakashi (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_PKakashi (src)
					src.Jutsus += new/obj/Jutsus/Raiton_Sphere_PKakashi (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_PKakashi (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "{PS} (Curse Seal) Sasuke")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Chidori_CPSasuke (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_CPSasuke (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_CPSasuke (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Shikamaru")
					src.Jutsus += new/obj/Jutsus/Explosive_Kunai_Throw_Shikamaru (src)
					src.Jutsus += new/obj/Jutsus/Explosive_Kunais (src)
					src.Jutsus += new/obj/Jutsus/Shadow_Summoning (src)
					new/obj/Shadow_Sewing (src)
					new/obj/Shadow_Neck (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Neji")
					src.Jutsus += new/obj/Jutsus/Byakugan (src)
					src.Jutsus += new/obj/Jutsus/Air_Palm (src)
					src.Jutsus += new/obj/Jutsus/Rotation (src)
					src.Jutsus += new/obj/Jutsus/Palms (src)
					src.Jutsus += new/obj/Jutsus/Gentle_Fist (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Zetsu")
					src.Jutsus += new/obj/Jutsus/Blind (src)
					src.Jutsus += new/obj/Jutsus/Clone_Jutsu (src)
					src.Jutsus += new/obj/Jutsus/Chakra_Sphere (src)
					src.Jutsus += new/obj/Jutsus/Remember_Spot (src)
					src.Jutsus += new/obj/Jutsus/Teleport_Back (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Yamato")
					src.Jutsus += new/obj/Jutsus/Palm_Wood_Pillar (src)
					src.Jutsus += new/obj/Jutsus/Wood_Binding (src)
					src.Jutsus += new/obj/Jutsus/Wood_Pillar (src)
					src.Jutsus += new/obj/Jutsus/Wood_Doomed_Wall (src)
					src.Jutsus += new/obj/Jutsus/Uprising (src)
					src.Jutsus += new/obj/Jutsus/Clone_Jutsu_Yamato (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Obito")
					src.Jutsus += new/obj/Jutsus/Sharingan_1 (src)
					src.Jutsus += new/obj/Jutsus/Flaming_Shuriken_Obito (src)
					src.Jutsus += new/obj/Jutsus/Phoenix_Flower_Obito (src)
					src.Jutsus += new/obj/Jutsus/Giant_FireBall_Obito (src)
					src.Jutsus += new/obj/Jutsus/Huge_Fire_Sphere_Obito (src)
					src.Jutsus += new/obj/Jutsus/Flaming_Dragon (src)
					src.Jutsus += new/obj/Jutsus/Obito_Combo (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Killer Bee")
					src.Jutsus += new/obj/Jutsus/Throw_Kunai (src)
					src.Jutsus += new/obj/Jutsus/Raikage_Summoning (src)
					src.Jutsus += new/obj/Jutsus/Lightning_Stab (src)
					src.Jutsus += new/obj/Jutsus/Seven_Swords_Dance (src)
					src.Jutsus += new/obj/Jutsus/Spinning_Blade (src)
					src.Jutsus += new/obj/Jutsus/Lariat (src)
					src.Jutsus += new/obj/Jutsus/Transform (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Three Tails) Killer Bee")
					src.Jutsus += new/obj/Jutsus/Spit_Ink (src)
					src.Jutsus += new/obj/Jutsus/Lightning_Stab_3 (src)
					src.Jutsus += new/obj/Jutsus/Lariat_3 (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Juugo")
					src.Jutsus += new/obj/Jutsus/Ultra_Punch (src)
					src.Jutsus += new/obj/Jutsus/Piston_Fist (src)
					src.Jutsus += new/obj/Jutsus/Earth_Spikes (src)
					src.Jutsus += new/obj/Jutsus/Rage (src)
					src.Jutsus += new/obj/Jutsus/Curse_Seal_Juugo (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "(Curse Seal) Juugo")
					src.Jutsus += new/obj/Jutsus/Chakra_Impulsion (src)
					src.Jutsus += new/obj/Jutsus/Brutal_Impact (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Hashirama Senju")
					src.Jutsus += new/obj/Jutsus/Wood_Pillar_S (src)
					src.Jutsus += new/obj/Jutsus/Mokuton_Daijurin_no_Jutsu (src)
					src.Jutsus += new/obj/Jutsus/Log_Summoning (src)
					src.Jutsus += new/obj/Jutsus/Wood_Doomed_Wall (src)
					src.Jutsus += new/obj/Jutsus/Wood_Dragon (src)
					src.Jutsus += new/obj/Jutsus/Special_Attack (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return

				if(src.name == "Kabuto")
					src.Jutsus += new/obj/Jutsus/Dead_Soul_Summoning (src)
					src.Jutsus += new/obj/Jutsus/Feather_Illusion (src)
					src.Jutsus += new/obj/Jutsus/Chakra_Scalpel (src)
					src.Jutsus += new/obj/Jutsus/Tornedo (src)
					src.Jutsus += new/obj/Jutsus/Double_Chakra_Scalpel (src)
					src.Jutsus += new/obj/Jutsus/Heal_K (src)
					src.Jutsus += new/obj/Jutsus/Revive_K (src)
					src.Jutsus += new/obj/Jutsus/Special_AttackX (src)
					for(var/obj/Jutsus/J in src) J.Real_Name = J.name
					Jutsus_Organization()
					return
