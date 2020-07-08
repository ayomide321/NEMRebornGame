mob/var/Old_Name
var/Menu_ = new/obj/Menu()

obj
	Menu
		name = "<b>* Menu *"
		Click() usr.Menu()

	Chain_Kunais_Jutsu
		var/Jutsu_Executor
		Click() src.Chain_Kunai()
		New(var/J, var/N)
			..()
			Jutsu_Executor = J
			Real_Name = N
			name = N

	Shuriken_Jutsu
		var/Jutsu_Executor
		Click() src.Makibishi_Shuriken()
		New(var/J, var/N)
			..()
			Jutsu_Executor = J
			Real_Name = N
			name = N

	Scroll_Kunais_Jutsu
		var/Jutsu_Executor
		Click() src.Scroll_Kunai()
		New(var/J, var/N)
			..()
			Jutsu_Executor = J
			Real_Name = N
			name = N

	Shadow_Sewing
		Click() src.Shadow_Sewing()
		var/Jutsu_Executor
		New(var/J)
			..()
			Jutsu_Executor = J

	Shadow_Neck
		Click() src.Shadow_Neck()
		var/Jutsu_Executor
		New(var/J)
			..()
			Jutsu_Executor = J

	Jutsus
		var/Jutsu_Executor
		New(var/J)
			..()
			Jutsu_Executor = J

		Senbon_Throw
			name = "Senbon Throw (1)"
			Click()
				src.Senbon_Throw()
		Senbon_Shower
			name = "Shower Throw (2)"
			Click()
				src.Senbon_Shower()
		Aoi_Combo
			name = "Special Combo (3)"
			Click()
				src.Aoi_Combo()
		Sword_Slash
			name = "Sword of the Thunder God (4)"
			Click()
				src.Sword_Slash()

		Two_Rising_Dragons
			name = "Two Rising Dragons (6)"
			Click()
				src.Twin_Rising_Dragons()

		Scythe_Summoning
			name = "Scythe Summoning (4)"
			Click()
				src.Scythe_Summoning()

		Explosive_Kunai_Throw_Haku
			name = "Explosive Kunai Throw (2)"
			Click()
				src.Explosive_Kunai_Throw()
		Hiraishin_Kunai
			name = "Hiraishin Kunai (1)"
			Click()
				src.Hiraishin_Kunai()
		Hiraishin_Kunai_Yondaime
			name = "Hiraishin Kunai (2)"
			Click()
				src.Hiraishin_Kunai()
		Hiraishin_Ni_no_Dan
			name = "Hiraishin Ni No Dan (3)"
			Click()
				src.Yondaime()
		Water_Dragon_Haku
			name = "Water Dragon (3)"
			Click()
				src.Water_Dragon()
		Ice_Spike
			name = "Ice Spike Explosion (4)"
			Click()
				src.Ice_Spike_Explosion()
		Hijutsu
			name = "Hijutsu: Sensatsu Suisho (5)"
			Click()
				src.Sensatsu_Suisho()
		Demon_Mirrors
			name = "Demonic Ice Crystal Mirrors (6)"
			Click()
				src.Demonic_Mirrors()
		Crystal_Spikes
			name = "Crystal Release: Spikes (1)"
			Click()
				src.Crystal_Spikes()
		Jaden_Blade
			name = "Crystal Release: Jaden Blade (2)"
			Click()
				src.Jaden_Blade()
		Crystal_Shurikens
			name = "Crystal Release: Hexagonal Shurikens (3)"
			Click()
				src.Crystal_Shurikens()
		Giant_Crystal_Shuriken
			name = "Crystal Release: Giant Hexagonal Shuriken (4)"
			Click()
				src.Giant_Hexagonal_Shuriken()
		Crystal_Explosive_Tree
			name = "Crystal Release: Explosive Tree (5)"
			Click()
				src.Crystal_Explosive_Tree()
		Crystal_Vortex
			name = "Crystal Release: Vortex (6)"
			Click()
				src.Crystal_Vortex()
		Crystal_Wave
			name = "Crystal Release: Wave (7)"
			Click()
				src.Crystal_Wave()
		Explosive_Kunai_Throw_Ginkaku
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()
		Kunai_Rush
			name = "Kunai Rush (2)"
			Click()
				src.Kunai_Rush()
		Absorb_Soul
			name = "Absorb Soul (3)"
			Click()
				usr.Absorb_Soul()
		Release_Soul
			name = "Release Soul (4)"
			Click()
				usr.Release_Soul()
		Needle_Throw_
			name = "Needle Throw (1)"
			Click()
				src.Needle_Throw()
		Needle_Cutting_Bind
			name = "Needle Cutting Bind (2)"
			Click()
				src.Needle_Cutting_Bind()
		Ice_Shield
			name = "Ice Shield (7)"
			Click()
				src.Ice_Shield()
		Water_Dash_C
			name = "Water Release.- Dash (2)"
			Click()
				src.Water_Dash()
		Water_Dash_Kus
			name = "Water Release.- Dash (3)"
			Click()
				src.Water_Dash()
		Water_Dragon_Kus
			name = "Water Release.- Dragon (4)"
			Click()
				src.Water_Dragon()
		Water_Vortex_Kus
			name = "Water Release.- Vortex (5)"
			Click()
				src.Water_Vortex()
		Water_Tsunami_Kus
			name = "Water Release.- Tsunami (6)"
			Click()
				src.Immense_Tsunami()
		Man_Eating_Sharks
			name = "Water Release.- Man Eating Sharks (7)"
			Click()
				src.Man_Eating_Sharks()
		Water_Clone_Kus
			name = "Water Release.- Clone (8)"
			Click()
				src.Water_Clone_X()
		Phoenix_Flower_Minato
			name = "Phoenix Flower (2)"
			Click()
				src.Phoenix_Flower()
		Phoenix_Flower_Kinkaku
			name = "Phoenix Flower (1)"
			Click()
				src.Phoenix_Flower()
		Phoenix_Flower_Anko
			name = "Phoenix Flower (2)"
			Click()
				src.Phoenix_Flower_Anko()
		Striking_Shadow_Snakes
			name = "Striking Shadow Snakes (3)"
			Click()
				src.Striking_Shadow_Snakes()
		Snake_Summoning
			name = "Snake Summoning (4)"
			Click()
				src.Snake_Summoning()
		Snake_Grasp
			name = "Snake Grasp (5)"
			Click()
				src.Snake_Grasp()
		Remember_Spot_Anko
			name = "Remember Spot (6)"
			Click()
				usr.Remember_Spot_Anko()
		Underground_Snake_Swamp
			name = "Underground Snake Swamp (7)"
			Click()
				src.Underground_Snake_Swamp()
		Phoenix_Flower_E1
			name = "Phoenix Flower (3)"
			Click()
				src.Phoenix_Flower()
		Fire_Dragon_Kinkaku
			name = "Fire Dragon (2)"
			Click()
				src.Fire_Dragon()
		Raikiri_AK
			name = "Raikiri (3)"
			Click()
				src.Raikiri_()
		Kamui_Dimension
			name = "Kamui Dimension (6)"
			Click()
				src.Kamui_()
		Kakashi_Clone
			name = "Clone Substitution (7)"
			Click()
				src.Kakashi_Clone()
		Sharingan_CD
			name = "Sharingan Genjutsu (8)"
			Click()
				src.Sharingan_CD()
		Fire_Dragon_E1
			name = "Fire Dragon (4)"
			Click()
				src.Fire_Dragon()
		Kamui_AK
			name = "Kamui (5)"
			Click()
				src.Kamui_AK()
		Huge_Fire_Sphere_Kinkaku
			name = "Huge Fire Sphere (3)"
			Click()
				src.Huge_Fire_Sphere()
		Giant_FireBall_Minato
			name = "Giant FireBall (3)"
			Click()
				src.Giant_FireBall()
		Giant_FireBall_Kinkaku
			name = "Giant FireBall (4)"
			Click()
				src.Giant_FireBall()
		Giant_FireBall_E1
			name = "Giant FireBall (5)"
			Click()
				src.Giant_FireBall()
		Five_Hungry_Sharks_Kinkaku
			name = "Five Hungry Sharks (5)"
			Click()
				src.Five_Hungry_Sharks()
		Water_Dragon_Kinkaku
			name = "Water Dragon (6)"
			Click()
				src.Water_Dragon()
		Raiton_Sphere_Kinkaku
			name = "Raiton Sphere (7)"
			Click()
				src.Raiton_Sphere()
		Darui
			name = "Lightning Spark (1)"
			Click()
				src.Lightning_Spark()
		Wave_Of_Inspiration
			name = "Wave Of Inspiration (3)"
			Click()
				src.Wave_Of_Inspiration()
		Laser_Outburst
			name = "Laser Outburst (4)"
			Click()
				src.Laser_Outburst()
		Black_Panther
			name = "Black Panther (5)"
			Click()
				src.Black_Panther()
		Raiton_Sphere_Omoi
			name = "Raiton Sphere (2)"
			Click()
				src.Raiton_Sphere()
		Rock_Throw_Kinkaku
			name = "Rock Throw (8)"
			Click()
				src.Rock_Throw()
		Wind_Storm_Kinkaku
			name = "Wind Storm (9)"
			Click()
				src.Wind_Storm_Kinkaku()
		Kyuubi_Mode_K
			name = "Kyuubi Mode (0)"
			Click()
				usr.Kyuubi_Mode()
		Kyuubi_Mode_G
			name = "Kyuubi Mode (5)"
			Click()
				usr.Kyuubi_Mode()
		Anbu_Combo
			name = "Special Combo (1)"
			Click()
				src.Anbu_Combo()
		Frogs_Song
			name = "Frogs Song (5)"
			Click()
				src.Frogs_Song()
		Throw_RasenshurikenX
			name = "Throw Rasenshuriken (4)"
			Click()
				src.Throw_Rasenshuriken_X()
		Double_Rasengan
			name = "Double Rasengan (2)"
			Click()
				src.Double_Rasengan()
		Rasengan_Minato
			name = "Rasengan (4)"
			Click()
				src.Minato_Rasengan()
		Rasengan_Barrage
			name = "Rasengan Barrage (5)"
			Click()
				src.Rasengan_Barrage()
		Space_Time_Barrier
			name = "Sealing Formation: Space-Time Barrier (6)"
			Click()
				src.Space_Time_Barrier()
		Sealing_Formation_Genesis_Rebirth
			name = "Sealing Formation: Genesis Rebirth (7)"
			Click()
				src.Absorbing_Barrier()
		Flying_Thunder_God_
			name = "Flying Thunder God (8)"
			Click()
				src.Flying_Thunder_God()
		Flying_Thunder_God_Yondaime
			name = "Flying Thunder God (9)"
			Click()
				src.Flying_Thunder_God()
		Rasengan_Quake
			name = "Rasengan Quake (3)"
			Click()
				src.Rasengan_Quake()
		Dead_Soul_Summoning
			name = "Dead Soul Summoning (1)"
			Click()
				src.Dead_Soul_Summoning()
		Feather_Illusion
			name = "Feather Illusion (2)"
			Click()
				src.Feather_Illusion()
		Chakra_Scalpel
			name = "Chakra Scalpel (3)"
			Click()
				src.Chakra_Scalpel()
		Tornedo
			name = "Tornedo (4)"
			Click()
				src.Tornedo()
		Double_Chakra_Scalpel
			name = "Double Chakra Scalpel (5)"
			Click()
				src.Double_Chakra_Scalpel()
		Heal_K
			name = "Heal (6)"
			Click()
				src.Heal()
		Revive_K
			name = "Revive (7)"
			Click()
				src.Revive()
		Special_AttackX
			name = "Special Attack (8)"
			Click()
				src.Special_AttackX()
		Explosive_Kunai_Throw_Rin
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()
		Senshokuko
			name = "Water Release.- Senshokuko (2)"
			Click()
				src.Senshokuko()
		Water_Dragon_Kisame_
			name = "Water Release.- Dragon (3)"
			Click()
				src.Water_Dragon()
		Water_Prison_Kisame
			name = "Water Release.- Prison (4)"
			Click()
				src.Water_Prison()
		Summoning_Sharks
			name = "Kuchiyose No Jutsu.- Sharks (5)"
			Click()
				src.Summon_Sharks()
		Fire_Dragon_T
			name = "Fire Dragon (2)"
			Click()
				src.Fire_Dragon()
		Phase
			name = "Phase (3)"
			Click()
				src.Phase()
		Phase_Tobi
			name = "Phase (9)"
			Click()
				src.Phase()
		Kamui
			name = "Kamui (4)"
			Click()
				src.Kamui()
		Control_Kamui
			name = "Control Kamui (5)"
			Click()
				usr.Control_Kamui()
		Rinnegan_Sword
			name = "Rinnegan Sword (6)"
			Click()
				src.Rinnegan_Sword()

		Tele_Slash
			name = "Path of Pain: Mini Shinrai(4)"
			Click()
				src.Shinra_TenseiP()
		Push_Back
			name = "Chakra Shockwave Slash(5)"
			Click()
				src.Push_BackP()
		Sharingan_Genjutsu
			name = "Sharingan Genjutsu (7)"
			Click()
				src.Sharingan_Genjutsu()
		Doton_Punch
			name = "Doton Punch (8)"
			Click()
				src.Doton_Punch()

		Doton_PunchM
			name = "Heavenly Strike (3)"
			Click()
				src.Doton_Punch()
		Bansho_Tenin
			name = "Bansho Tenin (9)"
			Click()
				src.Bansho_Tenin()
		Explosive_Meele
			name = "Explosive Meele (2)"
			Click()
				src.Explosive_Meele()
		Explosive_Combo
			name = "Explosive Combo (3)"
			Click()
				src.Explosive_Combo()
		Explosive_Fist
			name = "Explosive Fist (4)"
			Click()
				src.Explosive_Fist()
		Flaming_Fist
			name = "Flaming Fist (5)"
			Click()
				src.Flaming_Fist()
		Healing_Palm
			name = "Healing Palm (2)"
			Click()
				src.Healing_Palm()
		Heal_Rin
			name = "Heal (3)"
			Click()
				src.Heal()
		Revive_Rin
			name = "Revive (4)"
			Click()
				src.Revive()
		Shisui_FireBall
			name = "Uchiha Style - Fireball (2)"
			Click()
				src.Shisui_Fireball()
		Amaterasu_Ball_S
			name = "Shisui Style - Amaterasu (3)"
			Click()
				src.Amaterasu_Ball_S()

		Shisui_Genjutsu
			name = "Shisui - Genjutsu (5)"
			Click()
				src.Shisui_Genjutsu()
		Special_Attack
			name = "Special Attack (6)"
			Click()
				src.Special_Attack()
		Log_Summoning
			name = "Log Summoning (3)"
			Click()
				src.Log_Summoning()
		Wood_Pillar_S
			name = "Wood Pillar (1)"
			Click()
				src.Wood_Pillar()
		Mokuton_Daijurin_no_Jutsu
			name = "Mokuton: Daijurin no Jutsu (2)"
			Click()
				src.Mokuton_Daijurin_no_Jutsu()
		Brutal_Impact
			name = "Brutal Impact (2)"
			Click()
				src.Brutal_Impact()
		Chakra_Impulsion
			name = "Chakra Impulsion (1)"
			Click()
				src.Chakra_Impulsion()
		Ultra_Punch
			name = "Ultra Punch (1)"
			Click()
				src.Ultra_Punch()
		Piston_Fist
			name = "Piston Fist (2)"
			Click()
				src.Piston_Fist()
		Earth_Spikes
			name = "Earth Spikes (3)"
			Click()
				src.Earth_Spikes()
		Rage
			name = "Rage (4)"
			Click()
				src.Rage()
		Curse_Seal_Juugo
			name = "Curse Seal (5)"
			Click()
				usr.Curse_Seal_Juugo()
		Spit_Ink
			name = "Spit Ink (1)"
			Click()
				src.Spit_Ink()
		Lightning_Stab_3
			name = "Lightning Stab (2)"
			Click()
				src.Lightning_Stab()
		Lariat_3
			name = "Lariat (3)"
			Click()
				src.Lariat()
		Transform
			name = "Transform (7)"
			Click()
				usr.Transform()
		Lariat
			name = "Lariat (6)"
			Click()
				src.Lariat()
		Seven_Swords_Dance
			name = "Seven Swords Dance (4)"
			Click()
				src.Seven_Swords_Dance()
		Spinning_Blade
			name = "Spinning Blade (5)"
			Click()
				src.Spinning_Blade()
		Lightning_Stab
			name = "Lightning Stab (3)"
			Click()
				src.Lightning_Stab()
		Raikage_Summoning
			name = "Raikage Summoning (2)"
			Click()
				src.Raikage_Summoning()
		Water_Bomb
			name = "Water Bomb (1)"
			Click()
				src.Water_Bomb()
		Claws
			name = "Claws Strike (2)"
			Click()
				src.Claws()
		Chakra_Implosion
			name = "Chakra Implosion (3)"
			Click()
				src.Chakra_Implosion()
		Water_Vortex
			name = "Water Vortex (4)"
			Click()
				src.Water_Vortex()
		Earth_Walls_K
			name = "Earth Walls (2)"
			Click()
				src.Earth_Walls()
		Earth_Dragon_K
			name = "Earth Dragon (3)"
			Click()
				src.Earth_Dragon()
		Lethal_Scratch
			name = "Lethal Scratch (4)"
			Click()
				src.Lethal_Scratch()
		Spinning_Slash
			name = "Spinning Slash (5)"
			Click()
				src.Spinning_Slash()
		Earth_Fall
			name = "Rock Lodging Destruction (6)"
			Click()
				src.Earth_Fall()
		Beast_Tearing_Palm
			name = "Beast Tearing Palm (2)"
			Click()
				src.Beast_Tearing_Palm()
		Beast_Tearing_Gale_Palm
			name = "Beast Tearing Gale Palm (3)"
			Click()
				src.Beast_Tearing_Gale_Palm()
		Beast_Tearing_Gale_Scratch
			name = "Beast Tearing Gale Scratch (4)"
			Click()
				src.Beast_Tearing_Gale_Scratch()
		Throw_Kunai_Y
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()
		Throw_Kunai_E1
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()
		Water_Clone
			name = "Water Clone (2)"
			Click()
				src.Water_Clone()
		Water_Shark_Y
			name = "Water Shark (3)"
			Click()
				src.Five_Hungry_Sharks()
		Water_Prison_
			name = "Water Prison (5)"
			Click()
				src.Water_Prison_()
		Suika
			name = "Suika no Jutsu (6)"
			Click()
				src.Suika()
		Water_Tsunami
			name = "Water Tsunami (4)"
			Click()
				src.Immense_Tsunami()
		Water_Dragon_Y
			name = "Hijutsu: Sensatsu Suisho (5)"
			Click()
				src.Hijutsu_Sensatsu_Suisho()
		Sanbi_Grasp
			name = "Sanbi's Grasp (6)"
			Click()
				src.Sanbi_Hand()
		Transform_Y
			name = "Transform (7)"
			Click()
				usr.Transform_Y()

		Throw_Kunai
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()
		Naruto_Uzumaki_Barrage
			name = "Naruto Uzumaki Barrage (1)"
			Click()
				src.Naruto_Uzumaki_Barrage()

		Naruto_Rasengan
			name = "Rasengan (2)"
			Click()
				src.Rasengan()

		Sage_Rasengan
			name = "Rasengan (1)"
			Click()
				src.Rasengan()

		Giant_Rasengan
			name = "Giant Rasengan (3)"
			Click()
				src.Giant_Rasengan()

		Rasenshuriken
			name = "Rasenshuriken (4)"
			Click()
				src.Rasenshuriken()

		Throw_Rasenshuriken
			name = "Throw Rasenshuriken (5)"
			Click()
				src.Throw_Rasenshuriken()

		Sage_Mode
			name = "Sage Mode (6)"
			Click()
				usr.Sage_Mode()

		Akamaru_Summon
			name = "Akamaru Summon (1)"
			Click()
				src.Akamaru_Summon()

		Akamaru_Transformation
			name = "Akamaru Transformation (2)"
			Click()
				src.Akamaru_Transformation()

		Fang_Over_Fang
			name = "Fang Over Fang (3)"
			Click()
				src.Fang_Over_Fang()

		Wolf_Fang_Over_Fang
			name = "Wolf Fang Over Fang (4)"
			Click()
				src.Wolf_Fang_Over_Fang()

		Wrath_Of_Jashin
			name = "Wrath Of Jashin (2)"
			Click()
				src.Wrath_Of_Jashin()

		Scythe_Strike
			name = "Scythe Strike (3)"
			Click()
				src.Scythe_Strike()

		Throw_Chakra_Rod
			name = "Chakra Rod (1)"
			Click()
				src.Chakra_Rod()

		Throw_Chakra_Rod_N
			name = "Chakra Rod (2)"
			Click()
				src.Chakra_Rod()

		Summon_Ally
			name = "Summon Ally (9)"
			Click()
				src.Summon_Ally()

		Chibaku_Tensei
			name = "Summon Deva Path: Chibaku Tensei (8)"
			Click()
				src.Chibaku_Tensei()

		Chibaku_Tensei_N
			name = "Summon Deva Path: Chibaku Tensei (5)"
			Click()
				src.Chibaku_Tensei()

		Destroy_Soul
			name = "Summon Ningendo Path: Soul Removal (6)"
			Click()
				src.Destroy_Soul()

		Shinra_Tensei_C
			name = "Summon Deva Path: Shinra Tensei (7)"
			Click()
				src.Shinra_Tensei_C()

		Shinra_Tensei_N
			name = "Shinra Tensei (6)"
			Click()
				src.Shinra_Tensei_C()

		Absorb
			name = "Summon Preta Path: Absorb (5)"
			Click()
				src.Absorb()

		Absorb_N
			name = "Summon Preta Path: Absorb (3)"
			Click()
				src.Absorb()

		Wind_Cutter
			name = "Wind Cutter (4)"
			Click()
				src.Wind_Cutter()

		Bug_Barrage
			name = "Bug Barrage (2)"
			Click()
				src.Bug_Barrage()

		Poison_Jab
			name = "Poison Jab (3)"
			Click()
				src.Poison_Jab()

		Fuuton_Poison
			name = "Fuuton: Poisonous Breeze (4)"
			Click()
				src.Fuuton_Poison()

		Mind_Body_Switch_Technique
			name = "Mind Body Switch Technique (2)"
			Click()
				src.Mind_Body_Switch_Technique()

		Venomous_Insect_Clone
			name = "Venomous Insect Clone (3)"
			Click()
				src.Venomous_Insect_Clone()

		Rising_Bug_Pillars_
			name = "Rising Bug Pillars (4)"
			Click()
				src.Rising_Bug_Pillars()

		Rising_Bug_Pillars
			name = "Rising Bug Pillars (5)"
			Click()
				src.Rising_Bug_Pillars()

		Advent_Of_Bugs
			name = "Advent Of Bugs (6)"
			Click()
				src.Advent_Of_Bugs()

		Insect_Apocalypse
			name = "Insect Apocalypse (7)"
			Click()
				src.Insect_Apocalypse()

		Poison_Transformation
			name = "Poison Transformation (8)"
			Click()
				usr.Poison_Transformation()

		Sharingan_1
			name = "Sharingan (1)"
			Click()
				src.Sharingan()

		Hakke_Juushou
			name = "Hakke Juushou (3)"
			Click()
				src.Hakke_Juushou()

		Jyuuken_Shinan
			name = "Jyuuken Shinan (4)"
			Click()
				src.Jyuuken_Shinan()

		Jyuuken_Fury
			name = "Jyuuken Fury (5)"
			Click()
				src.Jyuuken_Fury()

		Spider_Sticking_Spit_K
			name = "Spider Sticking Spit (1)"
			Click()
				src.Spider_Sticking_Spit_K()

		Sound_Spiral_K
			name = "Sound Spiral (2)"
			Click()
				src.Sound_Spiral_K()

		Earthquake_K
			name = "Earthquake (3)"
			Click()
				src.Earthquake_K()

		Sawarbi_No_Mai_K
			name = "Sawarbi No Mai (4)"
			Click()
				src.Sawarbi_No_Mai_K()

		Fatal_Bite
			name = "Fatal Bite (5)"
			Click()
				src.Fatal_Bite()

		Killing_Snakes
			name = "Killing Snakes (6)"
			Click()
				src.Killing_Snakes()

		Devouring_Snakes
			name = "Devouring Snakes (7)"
			Click()
				src.Devouring_Snakes()

		Poisonous_Chakra_Scalpel
			name = "Poisonous Chakra Scalpel (8)"
			Click()
				src.Poisonous_Chakra_Scalpel()

		Edo_Tensei
			name = "Edo Tensei (9)"
			Click()
				src.Edo_Tensei()

		Mangekyou_Sharingan
			name = "Mangekyou Sharingan (1)"
			Click()
				src.Sharingan()

		Ninken_II
			name = "Ninja Hounds (2)"
			Click()
				src.Ninken_II()

		Fire_Dragon_RI
			name = "Fire Dragon (2)"
			Click()
				src.Fire_Dragon()

		Crow_Genjutsu_
			name = "Crow Genjutsu (3)"
			Click()
				src.Crow_Genjutsu_()

		Omni_Strike
			name = "Omni Strike (4)"
			Click()
				src.Omni_Strike()

		Amaterasu_AOE
			name = "Amaterasu (5)"
			Click()
				src.Amaterasu_AOE()

		Amaterasu_AOE_RS
			name = "Amaterasu (6)"
			Click()
				src.Amaterasu_AOE()

		Amaterasu_Wildfire
			name = "Amaterasu Wildfire (6)"
			Click()
				src.Amaterasu_Wildfire()

		Tsukuyomi_
			name = "Tsukuyomi no Mikoto (7)"
			Click()
				src.Tsukuyomi_()

		Slash
			name = "Slash (2)"
			Click()
				src.Slash()

		Wind_Shield
			name = "Wind Shield (3)"
			Click()
				src.Wind_Shield()

		Wind_Blast
			name = "Wind Blast (4)"
			Click()
				src.Wind_Blast()

		Wind_Blast_E1
			name = "Wind Blast (6)"
			Click()
				src.Wind_Blast()

		Wind_Blade
			name = "Wind Blade (5)"
			Click()
				src.Wind_Blade()

		Wind_Blade_E1
			name = "Wind Blade (7)"
			Click()
				src.Wind_Blade()

		Special_Combo_E1
			name = "Special Combo (8)"
			Click()
				src.Special_Combo_E1()

		Wind_Storm_Danzou
			name = "Wind Storm (6)"
			Click()
				src.Wind_StormD()

		Wind_Wave
			name = "Wind Wave (7)"
			Click()
				src.Wind_Wave()

		Explosive_Kunai_Throw
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()

		Bullet_Punch
			name = "Bullet Punch (2)"
			Click()
				src.Bullet_Punch()

		Rashomon
			name = "Rashomon (3)"
			Click()
				src.Rashomon()

		Wind_BT
			name = "Wind Release.- Great Breakthrough (5)"
			Click()
				src.Great_Breakthrough()

		Rashomon2
			name = "Rashomon (6)"
			Click()
				src.Rashomon2()

		Kyuubi_Rasengan
			name = "Rasengan (1)"
			Click()
				src.KRasengan()

		Illusionary_Warriors_Melody
			name = "Illusionary Warriors Melody (1)"
			Click()
				src.Illusionary_Warriors_Melody()

		Revolt_Demon
			name = "Revolt Demon (2)"
			Click()
				src.Revolt_Demon()

		Curse_Seal_Tayuya
			name = "Curse Seal (3)"
			Click()
				usr.Curse_SealT()

		Bullet_Punch
			name = "Bullet Punch (2)"
			Click()
				src.Bullet_Punch()

		Curse_Seal_Sakon
			name = "Curse Seal (3)"
			Click()
				usr.Curse_SealS()

		Rock_Throw
			name = "Rock Throw (1)"
			Click()
				src.Rock_Throw()

		Brutal_Tackle
			name = "Brutal Tackle (2)"
			Click()
				src.Brutal_Tackle()

		Earthquake
			name = "Earthquake (1)"
			Click()
				src.Earthquake()

		Boulder
			name = "Boulder (2)"
			Click()
				src.Boulder()

		Butterfly_Mode
			name = "Butterfly Mode (3)"
			Click()
				usr.Butterfly_Mode()

		Spinach_Pill
			name = "Spinach Pill (4)"
			Click()
				src.Choji_Pill()

		Curry_Pill
			name = "Curry Pill (4)"
			Click()
				src.Choji_Pill()

		Chilli_Pill
			name = "Chilli Pill (4)"
			Click()
				src.Choji_Pill()

		Butterfly_Bullet_Bomb
			name = "Butterfly Bullet Bomb (1)"
			Click()
				src.Butterfly_Bullet_Bomb()

		Curse_Seal_Jirobo
			name = "Curse Seal (4)"
			Click()
				usr.Curse_SealJ()

		Earth_Dome
			name = "Earth Dome (3)"
			Click()
				src.Earth_Dome()

		Water_Bubble
			name = "Water Bubble (1)"
			Click()
				src.Water_Bubble()

		Water_Bullet
			name = "Water Bullet (2)"
			Click()
				src.Water_Bullet()

		Water_Dragon_Akatsuki
			name = "Water Dragon (3)"
			Click()
				src.Water_Dragon()

		Sword_Rush
			name = "Sword Rush (3)"
			Click()
				src.Sword_Rush()

		Sword_Rush_Mifune
			name = "Sword Rush (2)"
			Click()
				src.Sword_Rush()

		Dual_Slash
			name = "Dual Slash (4)"
			Click()
				src.Dual_Slash()

		Dual_Slash
			name = "Quick Slash (3)"
			Click()
				src.Dual_Slash_Mifune()

		Crescent_Moon
			name = "Crescent Moon Beheading (5)"
			Click()
				src.Crescent_Moon()

		Crescent_Moon_Mifune
			name = "Crescent Moon (4)"
			Click()
				src.Crescent_Moon()

		Water_Dragon_Akatsuki_X
			name = "Water Dragon (3)"
			Click()
				src.Water_Dragon()

		Sword_Throw
			name = "Sword Throw (2)"
			Click()
				src.Sword_Throw()



		Water_Dragon_Anbu
			name = "Water Dragon (5)"
			Click()
				src.Water_Dragon()

		Water_Dash
			name = "Water Dash (4)"
			Click()
				src.Water_Dash()

		Water_Uprising
			name = "Water Uprising (5)"
			Click()
				src.Water_Uprising()

		Immense_Tsunami
			name = "Water Tsunami (6)"
			Click()
				src.Immense_Tsunami()

		Expand
			name = "Expand (1)"
			Click()
				src.Expand()


		Paper_Trap
			name = "Paper Trap (1)"
			Click()
				src.Paper_Trap()
		Paper_Throw
			name = "Paper Throw (2)"
			Click()
				src.Paper_Throw()
		Paper_Hurricane
			name = "Paper Hurricane (3)"
			Click()
				src.Paper_Hurricane()
		Paper_Tornado
			name = "Paper Tornado (4)"
			Click()
				src.Paper_Tornado()
		Dance_of_Wild_Papers
			name = "Dance Of Wild Papers (5)"
			Click()
				src.Dance_of_wild_Papers()

		Suffocating_Papers
			name = "Suffocating Papers (6)"
			Click()
				src.Suffocating_Paper()

		Paper_Clone
			name = "Paper Clone (7)"
			Click()
				src.Paper_Clone()

		Water_Palm_
			name = "Water Palm (1)"
			Click()
				src.Water_Palm_()
		Water_Palm
			name = "Water Palm (1)"
			Click()
				src.Water_Palm()

		Five_Hungry_Sharks
			name = "Five Hungry Sharks (4)"
			Click()
				src.Five_Hungry_Sharks()

		Five_Hungry_Sharks_Anbu
			name = "Five Hungry Sharks (6)"
			Click()
				src.Five_Hungry_Sharks()

		Summon_GiantFireball
			name = "Giant FireBall Summoning (4)"
			Click()
				src.Summon_Giant_FireBall()

		Poison_Smoke_Bomb
			name = "Poison Smoke Bomb (5)"
			Click()
				src.Poison_Smoke_Bomb()

		Explosive_Kunai_Throw_Karin
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()

		Chakra_Rush
			name = "Chakra Rush (2)"
			Click()
				src.Chakra_Rush()

		Earth_Eruption
			name = "Earth Eruption (3)"
			Click()
				src.Earth_Eruption()

		Heal_Karin
			name = "Heal (6)"
			Click()
				src.Heal()

		Revive_Karin
			name = "Revive (7)"
			Click()
				src.Revive()

		Snake_Bite_K
			name = "Snake Bite (2)"
			Click()
				src.Snake_Bite()
		Snake_Dash_K
			name = "Snake Dash (3)"
			Click()
				src.Snake_Dash()
		Absorb_Chakra_K
			name = "Chakra Absorb (4)"
			Click()
				src.Absorb_Chakra()
		Snakes_Summoning_K
			name = "Snakes Summoning (6)"
			Click()
				src.Snakes_Summoning()
		Feather_Illusion_K
			name = "Feather Illusion (7)"
			Click()
				src.Feather_Illusion()

		Sand_Manipulation
			name = "Sand Manipulation (1)"
			Click()
				src.Sand_Manipulation()

		Sand_Crush
			name = "Sand Crush (2)"
			Click()
				src.Sand_Crush()

		Sand_Shield
			name = "Sand Shield (3)"
			Click()
				src.Sand_Shield()

		Sand_Shuriken
			name = "Sand Shuriken (4)"
			Click()
				src.Sand_Shuriken()

		Sand_Bullet
			name = "Sand Bullet (5)"
			Click()
				src.Sand_Bullet()

		Sand_Spikes
			name = "Sand Spikes (6)"
			Click()
				src.Sand_Spikes()

		Sand_Tsunami
			name = "Sand Tsunami (7)"
			Click()
				src.Sand_Tsunami()

		Shukaku_Claw
			name = "Shukaku Claw (8)"
			Click()
				src.Shukaku_Claw()

		Floating_Sand_Sphere
			name = "Floating Sand Sphere (9)"
			Click()
				usr.Floating_Sand_Sphere()

		Sacrifice
			name = "Sacrifice (1)"
			Click()
				src.Sacrifice()

		Cherry_Blossom_Impact_Tsunade
			name = "Cherry Blossom Impact (2)"
			Click()
				src.Cherry_Blossom_Impact()

		Heal_Tsunade
			name = "Heal (4)"
			Click()
				src.Heal()

		Revive_Tsunade
			name = "Revive (5)"
			Click()
				src.Revive()

		Mass_Heal
			name = "Mass Heal (6)"
			Click()
				src.Mass_Heal()

		Snake_Bite
			name = "Snake Bite (1)"
			Click()
				src.Snake_Bite()

		Kusanagi
			name = "Kusanagi (2)"
			Click()
				src.Kusanagi()
		Kusanagi_K
			name = "Kusanagi (8)"
			Click()
				src.KusanagiX()
		Lava_Punch
			name = "Lava Punch (5)"
			Click()
				src.Lava_Punch()
		Basic_Puppet_Summon_Kankuro
			name = "Basic Puppet Summon (1)"
			Click()
				src.Basic_PuppetX()

		Salamander_Puppet_Summon
			name = "Salamander Puppet Summon (2)"
			Click()
				src.Salamander_Puppet_Summon()

		Crow_Puppet_Summon
			name = "Crow Puppet Summon (3)"
			Click()
				src.Crow_Puppet_Summon()
		Sasori_Puppet_Summon
			name = "Summon Sasori (6)"
			Click()
				src.Sasori_Puppet_Summon()

		Black_Ant
			name = "Black Ant Summon (4)"
			Click()
				src.Black_Ant()

		Rocket_Punch
			name = "Rocket Punch (1)"
			Click()
				src.Rocket_Punch()

		Basic_Puppet_Summon_Sasori
			name = "Basic Puppet Summon (1)"
			Click()
				src.Basic_Puppet()

		Kazekage_Puppet_Summon
			name = "Kazekage Puppet Summon (2)"
			Click()
				src.Kazekage_Puppet_Summon()

		Hiruko_Summon
			name = "Hiruko Summon (3)"
			Click()
				usr.Hiruko_Summon()

		Phoenix_Flower_Sasori
			name = "Phoenix Flower (4)"
			Click()
				src.Phoenix_Flower()

		Phoenix_Flower_Anbu
			name = "Phoenix Flower (3)"
			Click()
				src.Phoenix_Flower()

		Giant_FireBall_Sasori
			name = "Giant FireBall (5)"
			Click()
				src.Giant_FireBall()

		Giant_Fireball_Anbu
			name = "Giant FireBall (4)"
			Click()
				src.Giant_FireBall()

		Lava_Incineration
			name = "Lava Incineration (7)"
			Click()
				src.Lava_Incineration()

		Water_Revenge
			name = "Water Revenge (9)"
			Click()
				src.Water_Revenge()

		Poison_Smoke
			name = "Poison Smoke (8)"
			Click()
				src.Poison_Smoke()

		NL_Mind_Transfer
			name = "Non-Lethal Mind Transfer (5)"
			Click()
				src.NL_Mind_Transfer()

		L_Mind_Transfer
			name = "Lethal Mind Transfer (6)"
			Click()
				src.L_Mind_Transfer()

		Heal_Ino
			name = "Heal (1)"
			Click()
				src.Heal()

		Heal_Chiyo
			name = "Heal (4)"
			Click()
				src.Heal()

		Poisonous_Flowers
			name = "Poisonous Flowers (2)"
			Click()
				src.Poisonous_Flowers()

		Giant_Poisonous_Flower
			name = "Giant Poisonous Flower (3)"
			Click()
				src.Giant_Poisonous_Flower()

		Explosive_Poisonous_Flowers
			name = "Explosive Poisonous Flowers (4)"
			Click()
				src.Explosive_Poisonous_Flowers()

		Giant_FireBall_Hiruzen
			name = "Giant FireBall (1)"
			Click()
				src.Giant_FireBall()

		Phoenix_Flower_Hiruzen
			name = "Phoenix Flower (2)"
			Click()
				src.Phoenix_Flower()

		Earth_Dragon
			name = "Earth Dragon (3)"
			Click()
				src.Earth_Dragon()
		Earth_Wall_Hiruzen
			name = "Earth Wall (4)"
			Click()
				src.Earth_Wall_()
		Enma_Summon
			name = "Enma Summon (5)"
			Click()
				src.Enma_Summon()

		Shuriken_Shadow_Clone
			name = "Shuriken Shadow Clone (6)"
			Click()
				src.Shuriken_Shadow_Clone()

		Shuriken_Shadow_Clone_Sasori
			name = "Shuriken Shadow Clone (6)"
			Click()
				src.Shuriken_Shadow_Clone()

		Summoning_Puppets
			name = "Kugutsu no Jutsu (7)"
			Click()
				src.Summoning_Puppets()

		Summoning_Puppets_Chiyo
			name = "Kugutsu no Jutsu (2)"
			Click()
				src.Summoning_Puppets()

		Summon_Puppet
			name = "Summon Puppet (8)"
			Click()
				src.Summon_Puppet()

		Summon_Puppet_Chiyo
			name = "Summon Puppet (3)"
			Click()
				src.Summon_Puppet()

		Shuriken_Shadow_Clone_Anbu
			name = "Shuriken Shadow Clone (7)"
			Click()
				src.Shuriken_Shadow_Clone()

		Adamantine_Trap
			name = "Adamantine Trap (7)"
			Click()
				src.Adamantine_Trap()

		Fire_Stream
			name = "Fire Stream (1)"
			Click()
				src.Fire_Stream()

		Water_Stream
			name = "Water Stream (2)"
			Click()
				src.Water_Stream()

		Red_Secret_Technique
			name = "Red Secret Technique (3)"
			Click()
				src.Red_Secret_Technique()

		Shuriken_Shadow_Clone_Sasori_X
			name = "Shuriken Shadow Clone (4)"
			Click()
				src.Shuriken_Shadow_Clone()

		Summoning_Puppets_
			name = "Kugutsu no Jutsu (5)"
			Click()
				src.Summoning_Puppets()

		Summon_Puppet_
			name = "Summon Puppet (6)"
			Click()
				src.Summon_Puppet()
		Spider_Sticky_Gold
			name = "Spider Sticky Gold (1)"
			Click()
				src.Spider_Sticky_Gold()

		Spider_Sticking_Spit
			name = "Spider Sticking Spit (2)"
			Click()
				src.Spider_Sticking_Spit()

		Spider_Bind
			name = "Spider Bind (3)"
			Click()
				src.Spider_Bind()

		Curse_Seal_Kidoumaru
			name = "Curse Seal (4)"
			Click()
				usr.Curse_SealK()

		Rain_Of_Arrows
			name = "Rain Of Arrows (3)"
			Click()
				src.Rain_of_Arrows()

		Golden_Kunai_Slash
			name = "Golden Kunai Slash (2)"
			Click()
				src.Golden_Kunai_Slash()

		Bone_Bullets
			name = "Bone Bullets (1)"
			Click()
				src.Bone_Bullets()

		Teshi_Sendan
			name = "Teshi Sendan (2)"
			Click()
				src.Teshi_Sendan()

		Curse_Seal_Kimimaro
			name = "Curse Seal (3)"
			Click()
				usr.Curse_Seal()

		Tessenka
			name = "Tessenka (1)"
			Click()
				src.Tessenka()

		Sawarbi_No_Mai
			name = "Sawarbi No Mai (2)"
			Click()
				src.Sawarbi_No_Mai()

		Phoenix_Flower_Tobi
			name = "Phoenix Flower (3)"
			Click()
				src.Phoenix_Flower()

		Giant_FireBall_Tobi
			name = "Giant FireBall (5)"
			Click()
				src.Giant_FireBall()

		Fire_Dragon_Tobi
			name = "Fire Dragon (2)"
			Click()
				src.Fire_Dragon()

		Huge_Fire_Sphere_Tobi
			name = "Huge Fire Sphere (4)"
			Click()
				src.Huge_Fire_Sphere()

		Flame_Battle_Encampment
			name = "Flame Battle Encampment (6)"
			Click()
				src.Flame_Battle_Encampment()

		Fire_Tornadoes_Madara
			name = "Fire Tornadoes (0)"
			Click()
				src.Flame_Tornado()

		Flame_Tornado
			name = "Fire Tornadoes (8)"
			Click()
				src.Flame_Tornado()

		Flame_Imprisonment
			name = "Flame Imprisonment (7)"
			Click()
				src.Flame_Imprisonment()

		Lava_Shuriken
			name = "Lava Shuriken (1)"
			Click()
				src.Lava_Shuriken()

		Flaming_Shuriken_E1
			name = "Flaming Shuriken (2)"
			Click()
				src.Flaming_Shuriken()

		Lava_Punches
			name = "Lava Punches (2)"
			Click()
				src.Lava_Punches()

		Flaming_Shuriken
			name = "Flaming Shuriken (1)"
			Click()
				src.Flaming_Shuriken()

		Giant_FireBall_Kakuzu
			name = "Giant FireBall (2)"
			Click()
				src.Giant_FireBall()

		Fire_Coffin
			name = "Fire Coffin (3)"
			Click()
				src.Fire_Coffin()

		Huge_Fire_Sphere_Kakuzu
			name = "Huge Fire Sphere (4)"
			Click()
				src.Huge_Fire_Sphere()

		Earth_Smash
			name = "Earth Smash (5)"
			Click()
				src.Earth_Smash()

		Raiton_Sphere_Kakuzu
			name = "Raiton Sphere (6)"
			Click()
				src.Raiton_Sphere()

		Raiton_Sphere_Anbu
			name = "Raiton Sphere (2)"
			Click()
				src.Raiton_Sphere()

		Raiton_Sphere_AnbuS
			name = "Raiton Sphere (1)"
			Click()
				src.Raiton_Sphere()

		Phoenix_Flower_AnbuS
			name = "Phoenix Flower (2)"
			Click()
				src.Phoenix_Flower()

		Giant_Fireball_AnbuS
			name = "Giant FireBall (3)"
			Click()
				src.Giant_FireBall()

		Water_Dragon_AnbuS
			name = "Water Dragon (4)"
			Click()
				src.Water_Dragon()

		Wind_Slash_AnbuS
			name = "Wind Blade (5)"
			Click()
				src.Wind_Blade()

		Earth_Wall_AnbuS
			name = "Earth Wall (6)"
			Click()
				src.Earth_Wall()

		Spin_Kick
			name = "Taijutsu.- Spin Kick (7)"
			Click()
				src.Spin_Kick()

		Multiple_Exploding_Kunais_Throw_AnbuS
			name = "Multiple Exploding Kunais Throw (8)"
			Click()
				src.Multiple_Exploding_Kunai_Throw()

		Special_Combo_SA
			name = "ANBU Team.- Ultimate Combo (9)"
			Click()
				src.Special_Combo_SA()

		Bird_AnbuS
			name = "Summon Bird (0)"
			Click()
				usr.Bird_ANBU()

		Water_Dragon_Itachi
			name = "Water Dragon (2)"
			Click()
				src.Water_Dragon()

		Phoenix_Flower_Itachi
			name = "Phoenix Flower (3)"
			Click()
				src.Phoenix_Flower()

		Giant_FireBall_Itachi
			name = "Giant FireBall (4)"
			Click()
				src.Giant_FireBall()

		Crow_Genjutsu_Itachi
			name = "Crow Genjutsu (5)"
			Click()
				src.Crow_Genjutsu()

		Massive_Flaming_Shurikens
			name = "Massive Flaming Shurikens (6)"
			Click()
				src.Massive_Flaming_Shurikens()

		Susanoo_Itachi
			name = "Susanoo (7)"
			Click()
				usr.Itachi_Susanoo()

		Amaterasu_Itachi
			name = "Amaterasu (8)"
			Click()
				src.Amaterasu()

		Stop_Amaterasu_Flames_Itachi
			name = "Stop Amaterasu Flames (9)"
			Click()
				usr.Stop_Amaterasu_Flames()
		Tsukuyomi
			name = "Tsukuyomi (0)"
			Click()
				src.Tsukuyomi()

		Sakura_Inner_Rage
			name = "Sakura Inner Rage (1)"
			Click()
				src.Sakura_Inner_Rage()

		Cherry_Blossom_Impact_Sakura
			name = "Cherry Blossom Impact (2)"
			Click()
				src.Cherry_Blossom_Impact()

		Cherry_Blossom_Groundsmash
			name = "Cherry Blossom Groundsmash (3)"
			Click()
				src.Cherry_Blossom_Groundsmash()

		Heal_Sakura
			name = "Heal (4)"
			Click()
				src.Heal()

		Revive_Sakura
			name = "Revive (5)"
			Click()
				src.Revive()

		Rasengan_Yondaime
			name = "Rasengan (1)"
			Click()
				src.Rasengan_Yondaime_()

		Phoenix_Flower_Yondaime
			name = "Phoenix Flower (4)"
			Click()
				src.Phoenix_Flower()

		Giant_FireBall_Yondaime
			name = "Giant FireBall (5)"
			Click()
				src.Giant_FireBall()

		Drop_Kunai
			name = "Drop Kunai (6)"
			Click()
				src.Drop_Kunai()

		Destroy_Kunai
			name = "Destroy Kunai (7)"
			Click()
				src.Destroy_Kunai()

		Teleport_To_Kunai
			name = "Teleport To Kunai (8)"
			Click()
				src.Teleport_to_Kunai()

		Revive_Juugo
			name = "Revive (2)"
			Click()
				src.Revive()

		Absorption_Path
			name = "Absorption Path (1)"
			Click()
				src.Absorption_Path()

		Defensive_Path
			name = "Defensive Path (2)"
			Click()
				src.Defensive_Path()

		Offensive_Path
			name = "Offensive Path (3)"
			Click()
				src.Offensive_Path()

		Rain_Bomb
			name = "Rain Bomb (4)"
			Click()
				src.Rain_Bomb()

		Inferno
			name = "Inferno (5)"
			Click()
				src.Inferno()

		Shinra_Tensei
			name = "Shinra Tensei (6)"
			Click()
				src.Shinra_Tensei()

		Path_Of_Resurrection
			name = "Path Of Resurrection (7)"
			Click()
				src.Path_Of_Resurrection()

		Throw_Arrow
			name = "Throw Arrow (1)"
			Click()
				src.Throw_Arrow()

		Chidori_Sasuke
			name = "Chidori (2)"
			Click()
				src.Chidori()

		Chidori_Stream
			name = "Chidori Stream (3)"
			Click()
				src.Chidori_Stream()

		Giant_FireBall_Sasuke
			name = "Giant FireBall (4)"
			Click()
				src.Giant_FireBall()

		Kirin
			name = "Kirin (5)"
			Click()
				src.Kirin()

		Susanoo_Sasuke
			name = "Susanoo (6)"
			Click()
				usr.Susanoo()

		Amaterasu_Sasuke
			name = "Amaterasu (7)"
			Click()
				src.Amaterasu()

		Stop_Amaterasu_Flames_Sasuke
			name = "Stop Amaterasu Flames (8)"
			Click()
				usr.Stop_Amaterasu_Flames()

		Chidori_CSasuke
			name = "Chidori (1)"
			Click()
				src.CChidori()

		Chidori_Stream_2
			name = "Chidori Stream (2)"
			Click()
				src.Chidori_Stream()

		Giant_FireBall_CSasuke
			name = "Giant FireBall (3)"
			Click()
				src.Giant_FireBall()

		Byakugan
			name = "Byakugan (1)"
			Click()
				src.Byakugan()

		Rinnegan
			name = "Rinnegan (1)"
			Click()
				src.Rinnegan()
		Molten_Hand
			name = "Critical Strike (4)"
			Click()
				src.Magma_Hand()

		Rinnegan_P
			name = "Rinnegan (8)"
			Click()
				src.Rinnegan()

		Eight_Trigrams_Air_Palm
			name = "Eight Trigrams Air Palm (2)"
			Click()
				src.Air_Palm()

		Eight_Trigrams_Air_Palm_
			name = "Eight Trigrams Air Palm (2)"
			Click()
				src.Air_Palm_()

		Eight_Trigrams_Sixty_Four_Palms
			name = "Eight Trigrams Sixty Four Palms (3)"
			Click()
				src.Palms()

		Jyuuken
			name = "Jyuuken (5)"
			Click()
				src.Jyuuken()

		Protection_Palms
			name = "Eight Trigrams: Protection Of The 64 Palms (4)"
			Click()
				src.Protection_Palms()

		Chidori_Kakashi
			name = "Chidori (2)"
			Click()
				src.Kakashi_Chidori()

		Raikiri
			name = "Raikiri (3)"
			Click()
				src.Raikiri()

		Giant_FireBall_Kakashi
			name = "Giant FireBall (5)"
			Click()
				src.Giant_FireBall()

		Dynamic_Entry_Kakashi
			name = "Dynamic Entry (6)"
			Click()
				src.Dynamic_Entry()

		Ninken
			name = "Ninja Hounds (0)"
			Click()
				src.Ninken()

		Random_Weapon_Throw
			name = "Random Weapon Throw (1)"
			Click()
				src.Random_Weapon_Throw()

		Iron_Ball
			name = "Iron Ball (2)"
			Click()
				src.Iron_Ball()

		Kunai_Grenade
			name = "Kunai Grenade (3)"
			Click()
				src.Kunai_Grenade()

		Multiple_Exploding_Kunais_Throw
			name = "Multiple Exploding Kunais Throw (5)"
			Click()
				src.Multiple_Exploding_Kunai_Throw()

		Multiple_Exploding_Kunais_Throw_Anbu
			name = "Multiple Exploding Kunais Throw (8)"
			Click()
				src.Multiple_Exploding_Kunai_Throw()

		Senbon_Throw_K
			name = "Senbon Throw (2)"
			Click()
				src.Senbon_Throw()

		Sound_Spiral
			name = "Sound Spiral (3)"
			Click()
				src.Sound_Spiral()

		Explosive_Kunai_Throw_Dosu
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()

		Shuriken_Shadow_Clone_Dosu
			name = "Shuriken Shadow Clone (2)"
			Click()
				src.Shuriken_Shadow_Clone()

		Resonating_Echo_Drill
			name = "Resonating Echo Drill (3)"
			Click()
				src.Resonating_Echo_Drill()

		Resonating_Shockwave
			name = "Resonating Shockwave (4)"
			Click()
				src.Resonating_Shockwave()

		Airwave
			name = "Airwave (1)"
			Click()
				src.Airwave()

		Compressed_Airwave
			name = "Compressed Airwave (2)"
			Click()
				src.Compressed_Airwave()

		Explosive_Airwave
			name = "Explosive Airwave (3)"
			Click()
				src.Explosive_Airwave()

		Wind_Wave_Zaku
			name = "Wind Wave (4)"
			Click()
				src.Wind_Wave()

		Whirlwind
			name = "Whirlwind (1)"
			Click()
				src.Whirlwind()

		Ferocious_Wind
			name = "Ferocious Wind (2)"
			Click()
				src.Ferocious_Wind()

		Wind_Tornado
			name = "Wind Tornado (3)"
			Click()
				src.Wind_Tornado()

		Wind_Scythe
			name = "Wind Scythe (4)"
			Click()
				src.Wind_Scythe()

		Wind_Storm_Temari
			name = "Wind Storm (5)"
			Click()
				src.Wind_Storm_T()

		Wind_Sea_Dragon
			name = "Wind Sea Dragon (6)"
			Click()
				src.Sea_Dragon()

		Dynamic_Entry_Might_Gai
			name = "Dynamic Entry (1)"
			Click()
				src.Dynamic_Entry()

		Slap_Of_Youth_Might_Gai
			name = "Slap Of Youth (2)"
			Click()
				src.Slap_Of_Youth()

		Leaf_Hurricane_Might_Gai
			name = "Leaf Hurricane (4)"
			Click()
				src.Leaf_Hurricane()

		Open_Gates_Might_Gai
			name = "Open Gates (5)"
			Click()
				usr.MightGates()

		Primary_Lotus_Might_Gai
			name = "Primary Lotus (3)"
			Click()
				src.Primary_Lotus()
		Leaf_Hurricane_
			name = "Leaf Hurricane (1)"
			Click()
				src.Leaf_Hurricane_()
		Great_Whirlwind
			name = "Great Whirlwind (2)"
			Click()
				src.Great_Whirlwind()
		Primary_Lotus_Rock_Lee
			name = "Primary Lotus (1)"
			Click()
				src.Primary_Lotus()

		Doton_Fist
			name = "Doton Fist (8)"
			Click()
				src.Doton_Fist()

		Primary_Lotus_Kakashi
			name = "Primary Lotus (7)"
			Click()
				src.Primary_Lotus()

		One_Thousand
			name = "One Thousand Years Of Pain (9)"
			Click()
				src.One_Thousand()

		Leaf_Hurricane_Rock_Lee
			name = "Leaf Hurricane (2)"
			Click()
				src.Leaf_Hurricane()

		Open_Gates_Rock_Lee
			name = "Open Gates (3)"
			Click()
				usr.Gates()

		Drop_Weights
			name = "Drop Weights (4)"
			Click()
				usr.Drop_Weights()

		Clay_Dove
			name = "Clay Dove (1)"
			Click()
				src.Clay_Dove()

		Clay_Spider
			name = "Clay Spider (2)"
			Click()
				src.Clay_Spider()

		Clay_Totem
			name = "Clay Totem (3)"
			Click()
				src.Clay_Totem()

		Clay_Centipede
			name = "Clay Centipede (4)"
			Click()
				src.Clay_Centipede()

		Clay_Bird
			name = "Clay Bird (5)"
			Click()
				usr.Clay_Bird()

		Summon_Bird
			name = "Summon Bird (0)"
			Click()
				usr.Bird()

		Ink_Lion
			name = "Ink Lion (1)"
			Click()
				src.InkLion()

		Ink_Eagle
			name = "Ink Eagle (2)"
			Click()
				src.Ink_Eagle()

		Ink_Snake
			name = "Ink Snake (3)"
			Click()
				src.InkSnake()

		Ink_Dragon
			name = "Ink Dragon (4)"
			Click()
				src.InkDragon()

		Ink_Clone
			name = "Ink Clone (5)"
			Click()
				src.Ink_Clone()

		Body_Flicker
			name = "Shunshin no Shisui(6)"
			Click()
				src.Body_Flicker()

		Ink_Bird
			name = "Ink Bird (6)"
			Click()
				usr.Ink_Bird()

		Aggressive_Bug_Swarm
			name = "Aggressive Bug Swarm (1)"
			Click()
				src.Aggressive_Bug_Swarm()

		Flight
			name = "Flight (8)"
			Click()
				usr.Flight()

		Insect_Sphere
			name = "Insect Sphere (2)"
			Click()
				src.Insect_Sphere()

		Bug_Levitation
			name = "Bug Levitation (3)"
			Click()
				usr.Bug_Levitation()

		Bug_Bullet
			name = "Bug Bullet (4)"
			Click()
				src.Bug_Bullet()

		Bug_Storm
			name = "Bug Storm (5)"
			Click()
				src.Bug_Storm()

		Bug_Clone
			name = "Bug Clone (6)"
			Click()
				src.Bug_Clone()

		Rasengan_Jiraiya
			name = "Rasengan (1)"
			Click()
				src.Jiraiya_Rasengan()

		Rasengan_Ashura
			name = "Rasengan (2)"
			Click()
				src.Rasengan_Ashura()

		SpecialAttack_AS
			name = "Kyuubi Combo (3)"
			Click()
				src.SpecialAttack_As()

		Ashura_Ball
			name = "Chakra Balls (5)"
			Click()
				src.Ashura_Balls()


		Throw_RasenshurikenXX
			name = "Ultimate Rasen Shuriken (6)"
			Click()
				src.Throw_RasenshurikenXX()
		Hair_Needles
			name = "Hair Needles (2)"
			Click()
				src.Hair_Needles()

		Giant_FireBall_Jiraiya
			name = "Giant FireBall (3)"
			Click()
				src.Giant_FireBall()

		Toad_Summon
			name = "Toad Summon (4)"
			Click()
				src.Toad_Summon()

		Sage_Mode_Jiraiya
			name = "Sage Mode (5)"
			Click()
				usr.Jiraiya_Sage_Mode()

		Rasengan_Sage_Jiraiya
			name = "Rasengan (1)"
			Click()
				src.Jiraiya_Rasengan_S()

		Giant_FireBall_Sage_Jiraiya
			name = "Giant FireBall (2)"
			Click()
				src.Giant_FireBall()

		Toad_Flame_Bullet
			name = "Toad Flame Bullet (3)"
			Click()
				src.Toad_Flame_Bullet()

		Five_Hungry_Sharks_Kisame
			name = "Five Hungry Sharks (1)"
			Click()
				src.Five_Hungry_Sharks()

		Water_Dragon_Kisame
			name = "Water Dragon (2)"
			Click()
				src.Water_Dragon()

		Immense_Tsunami_Kisame
			name = "Water Tsunami (3)"
			Click()
				src.Immense_Tsunami()

		Chakra_Blade_Punch
			name = "Chakra Blade Punch (1)"
			Click()
				src.Chakra_Blade_Punch()

		Chakra_Blade_Throw
			name = "Chakra Blade Throw (2)"
			Click()
				src.Chakra_Blade_Throw()

		Phoenix_Flower_Asuma
			name = "Phoenix Flower (3)"
			Click()
				src.Phoenix_Flower()

		Giant_FireBall_Asuma
			name = "Giant FireBall (4)"
			Click()
				src.Giant_FireBall()

		Flying_Swallow
			name = "Flying Swallow (5)"
			Click()
				src.Flying_Swallow()

		Ash_Pile_Burning
			name = "Ash Pile Burning (6)"
			Click()
				src.Ash_Pile_Burning()

		Chidori_PSasuke
			name = "Chidori (2)"
			Click()
				src.Pre_Chidori()

		Leaf_Hurricane_PSasuke
			name = "Leaf Hurricane (3)"
			Click()
				src.Leaf_Hurricane()

		Lion_Barrage
			name = "Lion Barrage (4)"
			Click()
				src.Lion_Barrage()

		Phoenix_Flower_PSasuke
			name = "Phoenix Flower (5)"
			Click()
				src.Phoenix_Flower()

		Giant_FireBall_PSasuke
			name = "Giant FireBall (6)"
			Click()
				src.Giant_FireBall()

		Curse_Seal_PSasuke
			name = "Curse Seal (7)"
			Click()
				usr.PS_SCurse_Seal()

		Giant_FireBall_Madara
			name = "Giant FireBall (2)"
			Click()
				src.Giant_FireBall()

		Huge_Fire_Sphere_Madara
			name = "Huge Fire Sphere (3)"
			Click()
				src.Huge_Fire_Sphere()

		Fire_Dragon
			name = "Fire Dragon (2)"
			Click()
				src.Fire_Dragon()

		Wood_Dragon
			name = "Wood Dragon (5)"
			Click()
				src.Wood_Dragon()

		Amaterasu_Ball
			name = "Amaterasu Ball (6)"
			Click()
				src.Amaterasu_Ball()

		Great_Fire_Annihilation
			name = "Great Fire Annihilation (9)"
			Click()
				src.Fire_Tsunami()

		Heat_Explosion
			name = "Heat Explosion (7)"
			Click()
				src.Heat_Explosion()

		Amaterasu_Madara
			name = "Amaterasu (7)"
			Click()
				src.Amaterasu()
		Stop_Amaterasu_Flames_Madara
			name = "Stop Amaterasu Flames (8)"
			Click()
				usr.Stop_Amaterasu_Flames()
		Great_FireBall_Shower
			name = "Great FireBall Shower (8)"
			Click()
				src.Great_Fireball_Shower()
		Wood_Stab
			name = "Wood Stab (4)"
			Click()
				src.Wood_Stab()

		Kyuubi_Slash_Naruto
			name = "Kyuubi Claw (2)"
			Click()
				src.Kyuubi_Claw()

		Kyuubi_Hand_Crush
			name = "Kyuubi Hand Crush (3)"
			Click()
				src.Kyuubi_Hand_Crush()

		Chidori_PKakashi
			name = "Chidori (2)"
			Click()
				src.Pre_Chidori()

		Phoenix_Flower_PKakashi
			name = "Phoenix Flower (3)"
			Click()
				src.Phoenix_Flower()

		Giant_FireBall_PKakashi
			name = "Giant FireBall (4)"
			Click()
				src.Giant_FireBall()

		Raiton_Sphere_PKakashi
			name = "Raiton Sphere (5)"
			Click()
				src.Raiton_Sphere()

		Explosive_Kunai_Throw_PKakashi
			name = "Explosive Kunai Throw (6)"
			Click()
				src.Explosive_Kunai_Throw()

		Chidori_CPSasuke
			name = "Chidori (2)"
			Click()
				src.Pre_Chidori()

		Phoenix_Flower_CPSasuke
			name = "Phoenix Flower (3)"
			Click()
				src.Phoenix_Flower()

		Giant_FireBall_CPSasuke
			name = "Giant FireBall (4)"
			Click()
				src.Giant_FireBall()

		Explosive_Kunai_Throw_Shikamaru
			name = "Explosive Kunai Throw (1)"
			Click()
				src.Explosive_Kunai_Throw()


		Explosive_Kunais
			name = "Explosive Kunais (2)"
			Click()
				src.Explosive_Kunais()

		Shadow_Summoning
			name = "Shadow Summoning (3)"
			Click()
				src.Shadow_Summoning()

		Air_Palm
			name = "Eight Trigrams Air Palm (2)"
			Click()
				src.Air_Palm()

		Rotation
			name = "Eight Trigrams Palm Rotation (3)"
			Click()
				src.Rotation()

		Palms
			name = "Eight Trigrams Sixty Four Palms (4)"
			Click()
				src.Palms()

		Gentle_Fist
			name = "Gentle Fist (5)"
			Click()
				src.Gentle_Fist()

		Lava_Shoot
			name = "Lava Shoot (6)"
			Click()
				src.Lava_Shoot()

		Amat_Sword
			name = "Amaterasu Sword (2)"
			Click()
				src.Amat_Sword()

		Rinnegan_Slash
			name = "Tele Slash (4)"
			Click()
				src.Rinnegan_Slash()

		Chidori_Rinne
			name = "Chidori (3)"
			Click()
				src.Chidori_Rinne()

		Palm_Wood_Pillar
			name = "Palm Wood Pillar (1)"
			Click()
				src.Palm_Wood_Pillar()

		Wood_Binding
			name = "Wood Binding (2)"
			Click()
				src.Wood_Binding()

		Wood_Pillar
			name = "Wood Pillar (3)"
			Click()
				src.Wood_Pillar()

		Flaming_Shuriken_Obito
			name = "Flaming Shuriken (2)"
			Click()
				src.Flaming_Shuriken()
		Phoenix_Flower_Obito
			name = "Phoenix Flower (3)"
			Click()
				src.Phoenix_Flower()
		Giant_FireBall_Obito
			name = "Giant FireBall (4)"
			Click()
				src.Giant_FireBall()
		Huge_Fire_Sphere_Obito
			name = "Huge Fire Sphere (5)"
			Click()
				src.Huge_Fire_Sphere()
		Flaming_Dragon
			name = "Flaming Dragon (6)"
			Click()
				src.Flaming_Dragon()
		Obito_Combo
			name = "Special Combo (7)"
			Click()
				src.Obito_Combo()
		Blind
			name = "Blind (1)"
			Click()
				src.Blind()
		Clone_Jutsu
			name = "Split (2)"
			Click()
				src.Clone_Jutsu()
		Clone_Jutsu_Naruto
			name = "Clone Jutsu (7)"
			Click()
				src.Clone_Jutsu_Naruto()
		Clone_Jutsu_Kisame
			name = "Water Clone (4)"
			Click()
				src.Clone_Jutsu_Kisame()
		Uprising
			name = "Wood Uprising (5)"
			Click()
				src.Uprising()
		Wood_Doomed_Wall
			name = "Wood Domed Wall (4)"
			Click()
				src.Domed_Wall()
		Clone_Jutsu_Yamato
			name = "Clone Jutsu (6)"
			Click()
				src.Clone_Jutsu_Yamato()
		Chakra_Sphere
			name = "Chakra Sphere (3)"
			Click()
				src.Chakra_Sphere()
		Remember_Spot
			name = "Remember Spot (4)"
			Click()
				usr.Remember_Spot()
		Teleport_Back
			name = "Teleport Back (5)"
			Click()
				usr.Teleport_Back()
		Water_Bubble_Zabuza
			name = "Water Bubble (1)"
			Click()
				src.Water_Bubble()
		Water_Bullet_Zabuza
			name = "Water Bullet (2)"
			Click()
				src.Water_Bullet()
		Water_Dragon_Kakashi
			name = "Water Dragon (4)"
			Click()
				src.Water_Dragon()
		Bijuu_Dama
			name = "Bijuu Dama (1)"
			Click()
				src.Bijuu_Dama()
		Water_Dragon_Zabuza
			name = "Water Dragon (3)"
			Click()
				src.Water_Dragon()
		Water_Splash
			name = "Water Splash (4)"
			Click()
				src.Water_Splash()
		Water_Prison
			name = "Water Prison (5)"
			Click()
				src.Water_Prison()
		Ice_Spikes
			name = "Ice Spikes (6)"
			Click()
				src.Ice_Spikes()
		Immense_Tsunami_Zabuza
			name = "Water Tsunami (7)"
			Click()
				src.Immense_Tsunami()
		Kirigakure_Jutsu
			name = "Kirigakure No Jutsu (8)"
			Click()
				src.Kirigakure_Jutsu()
		Snake_Dash
			name = "Snake Dash (3)"
			Click()
				src.Snake_Dash()

		Snakes_Summoning
			name = "Snakes Summoning (4)"
			Click()
				src.Snakes_Summoning()


		Guillotine_Drop
			name = "Guillotine Drop (3)"
			Click()
				src.Guillotine_Drop()


		Lariat_Raikage_X
			name = "Lariat (5)"
			Click()
				src.Lariat_Raikage()

		Endless_Kicks
			name = "Endless Kicks (4)"
			Click()
				src.Endless_Kicks()

		Liger_Bomb
			name = "Liger Bomb (2)"
			Click()
				src.Raikage_Hit()


		Transform_Raikage
			name = "Lightning Release Armor (6)"
			Click()
				usr.Lightning_Release_Armour()



		Dash_Raikage
			name = "Dash (2)"
			Click()
				src.Dash()


		Drop_Kick
			name = "Drop Kick (3)"
			Click()
				src.Drop_Kick()

		Liger_Bomb_Raikage
			name = "Liger Bomb (4)"
			Click()
				src.Raikage_Hit()

		Lariat_Raikage
			name = "Lariat (5)"
			Click()
				src.LariatX()

		Elbow
			name = "Elbow (6)"
			Click()
				src.Elbow()

		Earth_Smash_Tsu
			name = "Earth Smash (1)"
			Click()
				src.Earth_Smash()

		Lava_Cannon
			name = "Lava Cannon (3)"
			Click()
				src.Lava_Cannon()

		Lava_Whirl
			name = "Lava Whirl (4)"
			Click()
				src.Lava_Whirl()

		Earth_Dragon_Tsu
			name = "Earth Dragon (2)"
			Click()
				src.Earth_Dragon()

		Rock_Walls
			name = "Earth Walls (4)"
			Click()
				src.Earth_Walls()

		Earth_Uprising
			name = "Earth Great Mud River (3)"
			Click()
				src.Uprising_()

		Rock_Smash
			name = "Rock Smash (5)"
			Click()
				src.Rock_Smash()

		Rock_Throw_Tsu
			name = "Rock Throw (6)"
			Click()
				src.Rock_Throw()

		Rockfall
			name = "Rockfall (7)"
			Click()
				src.Rockfall()
		Detachment_of_the_Primitive_World
			name = "Detachment Of The Primitive World (9)"
			Click()
				src.Detachment_of_the_Primitive_World()

		Chidori_Senbon
			name = "Chidori Senbon (1)"
			Click()
				src.Chidori_Senbon()

		Fire_Dragon_EMS
			name = "Fire Dragon (2)"
			Click()
				src.Fire_Dragon()

		Chidori_EMS
			name = "Chidori (3)"
			Click()
				src.Chidori_EMS()

		Chidori_Stab
			name = "Chidori Stab (4)"
			Click()
				src.Chidori_Stab()

		Susanoo_Shield
			name = "Susanoo Shield (5)"
			Click()
				src.Susanoo_Shield()

		Supreme_Kirin
			name = "Kirin (6)"
			Click()
				src.Supreme_Kirin()

		Amaterasu_Control
			name = "Amaterasu Control (7)"
			Click()
				src.Amaterasu_Control()


		Susanoo_Crushing_Grip
			name = "Susanoo's Crushing Grip (8)"
			Click()
				src.Susanoo_Crushing_Grip()

		Absolute_Control
			name = "Sharingan Techique: Absolute Control (9)"
			Click()
				src.Absolute_Control()
