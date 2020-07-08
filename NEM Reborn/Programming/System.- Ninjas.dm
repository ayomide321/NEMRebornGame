mob/var/WoodCD = 0
mob/var/Selected_Jutsu
mob/var/Selecting_Jutsu
mob/var/list/Jutsus_Saved = list()
obj/var/Real_Name

mob/verb/Jutsu_Order()
	set hidden = 1
	if(name == key) return
	if(!Selecting_Jutsu)
		src<<"<b><font color=#6EDEFF><u>To change a jutsu's macro, select it through your keyboard.</u>"
		Selected_Jutsu = null
		Selecting_Jutsu = 1
	else
		src<<"<b><font color=#6EDEFF><u>You're no longer changing a jutsu's macro.</u>"
		Selected_Jutsu = null
		Selecting_Jutsu = 0

Jutsus_Set

	var
		list/Jutsus = list()
		name

	New(list/_Jutsus, mob/Creator)
		..()
		if(Creator)
			Jutsus = _Jutsus
			name = Creator.name
			Creator.Jutsus_Saved.Add(src)

mob
	proc
		Jutsus_Organization()
			for(var/Jutsus_Set/S in Jutsus_Saved) if(S.name == name) for(var/obj/Jutsus/J in Jutsus)
				var/J1 = findtext(J.Real_Name, "(")
				var/J1_New = copytext(J.Real_Name, 1, J1-1)
				for(var/_J in S.Jutsus)
					var/J2 = findtext(_J, "(")
					var/J2_New = copytext(_J, 1, J2-1)
					if(J1_New == J2_New)
						J.name = _J
						J.Real_Name = _J
				Reorder(1)

		Reorder(C)
			var/list/Jutsus_ = list()
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(1)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(2)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(3)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(4)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(5)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(6)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(7)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(8)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(9)")) Jutsus_.Add(J)
			for(var/obj/Jutsus/J in Jutsus) if(findtext(J.Real_Name, "(0)")) Jutsus_.Add(J)
			Jutsus = Jutsus_

			if(!C)
				for(var/Jutsus_Set/Set in Jutsus_Saved) if(Set.name == name) del(Set)
				var/list/_Jutsus_Names_ = list()
				for(var/obj/Jutsus/J in Jutsus) _Jutsus_Names_.Add(J.Real_Name)
				new/Jutsus_Set (_Jutsus_Names_, src)


		Change_Order(obj/n1, n1_order)
			var/N1 = findtext(n1.Real_Name, "(")
			var/N1_New = copytext(n1.Real_Name, 1, N1-1)
			n1.name = N1_New
			n1.name += " ([n1_order])"
			n1.Real_Name = n1.name
			if(n1.Delay == 1) n1.name = "[n1.Real_Name] - Cooldown: [n1.Delay] second"
			if(n1.Delay > 1) n1.name = "[n1.Real_Name] - Cooldown: [n1.Delay] seconds"
			Selected_Jutsu = null
			src<<"<b><font color=#6EDEFF>* You've changed [N1_New]'s macro to [n1_order]."
			Reorder()


		Switch_Order(obj/n1, n1_order, obj/n2)
			if(!n1)
				Selecting_Jutsu = null
				Selected_Jutsu = null
				return
			if(n1 == n2)
				src<<"<b><font color=#6EDEFF>* No changes have been made, you selected the same macro."
				Selecting_Jutsu = null
				Selected_Jutsu = null
				return
			var/N1 = findtext(n1.Real_Name, "(")
			var/N1_ = findtext(n1.Real_Name, ")")
			var/N1_Order = copytext(n1.Real_Name, N1+1, N1_)

			var/N2 = findtext(n2.Real_Name, "(")
			var/N2_New = copytext(n2.Real_Name, 1, N2-1)
			n2.name = N2_New
			n2.name += " ([N1_Order])"
			n2.Real_Name = n2.name

			var/N1_New = copytext(n1.Real_Name, 1, N1-1)
			n1.name = N1_New
			n1.name += " ([n1_order])"
			n1.Real_Name = n1.name

			if(n1.Delay == 1) n1.name = "[n1.Real_Name] - Cooldown: [n1.Delay] second"
			if(n1.Delay > 1) n1.name = "[n1.Real_Name] - Cooldown: [n1.Delay] seconds"
			if(n2.Delay == 1) n2.name = "[n2.Real_Name] - Cooldown: [n2.Delay] second"
			if(n2.Delay > 1) n2.name = "[n2.Real_Name] - Cooldown: [n2.Delay] seconds"

			src<<"<b><font color=#6EDEFF>* You've changed [N1_New]'s macro to [n1_order]."
			src<<"<b><font color=#6EDEFF>* [N2_New]'s macro has been automatically set to [N1_Order]."
			Selected_Jutsu = null
			Reorder()


mob/proc/Skill1()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(1)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(1)"))
			C ++
			Switch_Order(Selected_Jutsu, "1", J)
		if(!C)
			Change_Order(Selected_Jutsu, "1")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(1)")) J.Click()

mob/proc/Skill2()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(2)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(2)"))
			C ++
			Switch_Order(Selected_Jutsu, "2", J)
		if(!C)
			Change_Order(Selected_Jutsu, "2")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(2)")) J.Click()

mob/proc/Skill3()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(3)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(3)"))
			C ++
			Switch_Order(Selected_Jutsu, "3", J)
		if(!C)
			Change_Order(Selected_Jutsu, "3")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(3)")) J.Click()
mob/proc/Skill4()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(4)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(4)"))
			C ++
			Switch_Order(Selected_Jutsu, "4", J)
		if(!C)
			Change_Order(Selected_Jutsu, "4")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(4)")) J.Click()
mob/proc/Skill5()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(5)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(5)"))
			C ++
			Switch_Order(Selected_Jutsu, "5", J)
		if(!C)
			Change_Order(Selected_Jutsu, "5")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(5)")) J.Click()
mob/proc/Skill6()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(6)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(6)"))
			C ++
			Switch_Order(Selected_Jutsu, "6", J)
		if(!C)
			Change_Order(Selected_Jutsu, "6")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(6)")) J.Click()
mob/proc/Skill7()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(7)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(7)"))
			C ++
			Switch_Order(Selected_Jutsu, "7", J)
		if(!C)
			Change_Order(Selected_Jutsu, "7")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(7)")) J.Click()
mob/proc/Skill8()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(8)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(8)"))
			C ++
			Switch_Order(Selected_Jutsu, "8", J)
		if(!C)
			Change_Order(Selected_Jutsu, "8")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(8)")) J.Click()
mob/proc/Skill9()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(9)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(9)"))
			C ++
			Switch_Order(Selected_Jutsu, "9", J)
		if(!C)
			Change_Order(Selected_Jutsu, "9")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(9)")) J.Click()
mob/proc/Skill0()
	set hidden = 1
	if(input_lock) return
	if(Selecting_Jutsu)
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(0)"))
			Selected_Jutsu = J
			src<<"<b><font color=#6EDEFF>You've selected [J.Real_Name], you may now change it's macro."
			Selecting_Jutsu = null
	else if(Selected_Jutsu)
		var/C
		for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(0)"))
			C ++
			Switch_Order(Selected_Jutsu, "0", J)
		if(!C)
			Change_Order(Selected_Jutsu, "0")
	else for(var/obj/Jutsus/J in Jutsus) if(findtext(J.name, "(0)")) J.Click()
var/Spawn = 1

mob/proc/Wall_Jump()
	if(Wall_Jump)
		src<< "<b><font color=#6EDEFF><u>You will now be able to attach and jump from walls using chakra.</font></u>"
		Wall_Jump = 0
	else
		src<< "<b><font color=#6EDEFF><u>You will no longer be able to attach and jump from walls using chakra.</font></u>"
		Wall_Jump = 1


mob/var/Wall_Jump = 0

mob/proc/Auto_Spawn(var/Infinite)
	..()
	if(NEM_Round.Type == "Tourney") {Join_Tourney(); return}

	else if(NEM_Round.Type == "King Of The Hill")
		if(Squad) for(var/obj/KoTH_Flag/K) if(K.Color_Assigned == Squad.Color) {Teleport_(K); dir = pick(EAST, WEST)}
		else for(var/obj/KoTH_Flag/K) if(!K.Color_Assigned) {Teleport_(K); dir = pick(EAST, WEST); Substitution_Action(1)}

	else if(NEM_Round.Mode == "Juggernaut Mode")
		stop()
		dead = 0
		knocked = 0
		freeze = 0
		Attacking = 0
		Deaths = 4
		MaxHP = 100
		if(client)
			client.perspective = EYE_PERSPECTIVE
			client.eye = src
		verbs-=typesof(/mob/Dead/verb)
		HP = MaxHP
		Cha = MaxCha
		Energy = MaxEnergy
		invisibility = 101
		SubstitutionCD = 1
		Substitution = 1
		Dragonned = 1
		spawn(30)
			invisibility = 0
			SubstitutionCD = 0
			Substitution = 0
			Dragonned = 0
		Village = rand(1, 100000000000000000000)
		dir = EAST
		if(prob(50))
			for(var/obj/X_Leaf_First_Spawn/L in world) Teleport_(L)
			dir = EAST
		else
			for(var/obj/X_Akatsuki_First_Spawn/L in world) Teleport_(L)
			dir = WEST

	else if(NEM_Round)
		if(NEM_Round.Mode == "Normal" || NEM_Round.Mode == "Arena" || NEM_Round.Mode == "Challenge") NEM_Round.Spawn(src)

mob/var/Old_Loc_Real = null
mob/var/Old_PX = null
mob/var/Old_PY
mob/var/Holding_X = 0
mob/var/obj/Shuriken_Jutsu
mob/var/obj/Kunai_Jutsu
mob/var/obj/Scroll_Kunai_Jutsu

mob
	layer = 100
	var
		Comboed = 0
		Special_ = 0
		shooting = 0
		knockback= 0
	key_up(k)
		..()
		if(k == "x")
			Holding_X = null
			if(Boulder == 0 && BoulderX == 0 && !GoingSage && !knocked) Run_Off()
	key_down(k)
		..()

		if(Mission_On)
			if(Mission_On.Name == "Weed Picking") if(k == "w" || k == "z") {Weed_Pick(); return}

		if(CanChoose)
			if(CTD || On_Special_Character_Screen) return
			if(k == "escape")
				Selecting = null
				if(Character_Image) del(Character_Image)
				if(Character_Image_I) del(Character_Image_I)
				if(Character_Image_II) del(Character_Image_II)
				if(Character_Image_III) del(Character_Image_III)

			if(k == "return") if(Selecting) Selecting:Choose(src, null, null,null, null, 1)
			if(Allow_New_Users || NEM_Round.Mode != Current_NEM_Round)
				if(k == "east") Next_Page()
				else if(k == "west") Previous_Page()

		if(k == "s" && On_Wood_Wall) On_Wood_Wall.Delete(1)
		if(k == "s" && W_Protecting) W_Protecting.Delete(1)
		if(Sharking)
			if(k == "space" && on_ground) jump()
			if(k == "right") dir = EAST
			else if(k == "left") dir = WEST
			return
		if(k == "t" && Kunais_L) Kunai_Jutsu.Chain_Kunai(src)
		if(k == "g" && Shurikens_L) Shuriken_Jutsu.Makibishi_Shuriken(src)
		if(k == "y" && Scroll_Kunais_L) Scroll_Kunai_Jutsu.Scroll_Kunai(src)
		if(k == "p"  && Pill) Pill.Consume()
		if(k == "r" && name == "Lord Itachi") Itachi_Dash_()
		if(k == "x")
			Holding_X = 1
		if(k == "j" ) Jutsu_Order()
		if(k == "shift" && Wall_Key || k == "f" && !Wall_Key) Wall_Jump()
		if(Special_ == "Centipede" && k == "w") del(Controlling_Object)
		if(Special_ == 61 && k == "q") Reset_Mind_Control()
		if(Ant && k == "q") del(Ant)
		if(Special_ == 96 && k == "x") for(var/obj/Jutsus/Flame_Imprisonment/J in src) J.Click()
		if(Special_ == 1 && k == "x") for(var/obj/Jutsus/Shadow_Summoning/S in src) S.Click()
		if(Special_ == 1 && k == "w") for(var/obj/Shadow_Sewing/S in src) S.Click()
		if(Special_ == 1 && k == "q") for(var/obj/Shadow_Neck/S in src) S.Click()
		if(Special_ == 7 && k == "x")
			for(var/obj/Jutsus/Rising_Bug_Pillars/J in src) J.Click()
			for(var/obj/Jutsus/Rising_Bug_Pillars_/J in src) J.Click()
		if(Special_ == 2 && k == "x")
			if(name == "Kakkou") for(var/obj/Jutsus/Spinning_Slash/J in src) J.Click()
			else if(name == "Neji") for(var/obj/Jutsus/Rotation/J in src) J.Click()
			else if(name == "Gaara") for(var/obj/Jutsus/Sand_Shield/J in src) J.Click()
			else for(var/obj/Jutsus/Ice_Shield/J in src) J.Click()
		if(Special_ == 3 && k == "x") for(var/obj/Jutsus/Illusionary_Warriors_Melody/J in src) J.Click()
		if(k == "x" && Gates == 0 && Boulder==0 && Controlling == 0 && BoulderX == 0 && !knocked)
			if(Energy < 0.25 || running == 1) return
			running=1
		if(k == "1") src.Skill1()
		if(k == "2") src.Skill2()
		if(k == "3") src.Skill3()
		if(k == "4") src.Skill4()
		if(k == "5") src.Skill5()
		if(k == "6") src.Skill6()
		if(k == "7") src.Skill7()
		if(k == "8") src.Skill8()
		if(k == "9") src.Skill9()
		if(k == "0") src.Skill0()
		if(GoingSage) return
		if(S_K_A && k == "d") Set_Dodge()
		if(freeze && Controlling == 0 || Comboed == 1) return
		if(k == "e") src.Substitution()
		if(k == "d")
			src.Set_Dodge()
		if(k == "z")
			if(RestrictionFX==1)
				src.HP -= 10
			else
				src.Attack()
		if(k == "w")
			if(RestrictionFX==1)
				src.HP -= 10
			else
				src.Attack()
		if(k == "c") src.Substitution()
		if(k == "space")
			if(Levitating) src.vel_y = 10
		if(k == "x" && Controlling >= 1 && Special_ != "Centipede")
			src.Controlling=0
			del(Controlling_Object)
		if(k == "v") src.Side_Say()



obj
	Explosion
		layer=90
		icon= 'Graphics/Explosion.dmi'
		var/T=0
		New()
			..()
			loop
				if(T!=5)
					T++
					pixel_y=rand(-1,1)
					pixel_x=rand(-1,1)
					spawn(1)goto loop
				else
					del(src)
obj
	Black_Smoke
		layer=90
		icon= 'Graphics/Skills/BlackSmoke.dmi'
		var/T=0
		layer= 55
		pixel_y=-12
		New()
			..()
			spawn(10)del(src)
obj
	SpecialHit
		layer=300
		icon= 'Graphics/Skills/SpecialHit.dmi'
		pixel_y=-16
		pixel_x=-16
		New()
			..()
			spawn(5)del(src)
obj
	Ground_Explosion_X
		layer=300
		icon= 'Graphics/Skills/Ground Explosion.dmi'
		New()
			..()
			Flick("Go", src)
			spawn(8)del(src)
obj
	Piston_Hit
		layer=300
		pixel_x = 12
		icon= 'Graphics/Skills/PistonHit.dmi'
		New()
			..()
			Flick("Go", src)
			spawn(8)del(src)
obj
	TsuHit_1
		layer=300
		pixel_y = -10
		icon= 'Graphics/Skills/TsuHit.dmi'
		New()
			..()
			Flick("TsuHit_1", src)
			spawn(4) del(src)
	TsuHit_2
		layer=300
		pixel_y = -10
		icon= 'Graphics/Skills/TsuHit.dmi'
		New()
			..()
			Flick("TsuHit_2", src)
			spawn(4) del(src)
obj
	Hit
		layer = 300
		alpha = 200
		icon= 'Graphics/Hit.dmi'
		var/T=0
		New()
			..()
			icon_state="[rand(1,3)]"
			loop
				if(T!=5)
					T++
					pixel_y=rand(-1,1)
					spawn(1)goto loop
				else del(src)
obj
	Hit_X
		layer=300
		icon= 'Graphics/Hit.dmi'
		var/T=0
		New()
			..()
			icon_state="[rand(1,3)]"
			loop
				if(T!=5)
					T++
					spawn(1)goto loop
				else del(src)
	RasenganBlast
		layer=165
		blend_mode = BLEND_ADD
		icon= 'Graphics/Skills/PotonX.dmi'
		pixel_y=-16
		pixel_x=-24
		var/T=0
		New(loc, mob/Owner)
			..()
			spawn(8.25)del(src)
			for(var/mob/M in view(9))
				if(M.name != Owner.name &&M.Real==1&&M.knocked==0&&M.Dragonned==0&&M.Boulder==0&&M.BoulderX==0&& M.Village!=Owner.Village)
					if(M.dir == EAST) M.knockbackwestx()
					if(M.dir == WEST) M.knockbackeastx()
					M.Damage(Owner, 35, 1, 0, 0, 0, 0, 1)

	Splash
		layer=300
		icon= 'Graphics/Skills/Watersplash.dmi'
		var/T=0
		New()
			..()
			loop
				if(T!=5)
					T++
					pixel_y=rand(-1,1)
					spawn(1) goto loop
				else del(src)
	RealSplash
		layer=300
		icon= 'Graphics/Skills/RealWatersplash.dmi'
		var/T=0
		New()
			..()
			loop
				if(T!=5)
					T++
					pixel_y=rand(-1,1)
					spawn(1)goto loop
				else del(src)

	BigHit
		layer=300
		icon= 'Graphics/Skills/HitBig.dmi'
		var/T=0
		New()
			..()
			loop
				if(T!=5)
					T++
					pixel_y=rand(-1,1)
					spawn(1)goto loop
				else del(src)
	SmallHit
		layer=300
		icon= 'Graphics/Skills/HitSmall.dmi'
		var/T=0
		New()
			..()
			loop
				if(T!=5)
					T++
					pixel_y=rand(-1,1)
					spawn(1)goto loop
				else del(src)
mob/var/Checks_Loc = 0

obj/Bounds_Scroll
	pwidth = 8
	pheight = 2

	New(loc, mob/C)
		loc = C.loc
		bound_x = C.bound_x
		bound_x += C.step_x
		bound_y = C.bound_y
		bound_y += C.step_y
		bound_y -= 1

Statistic/var/Scroll_Perk
Statistic/var/Shuriken_Perk

obj/proc/Scroll_Kunai()
	var/mob/Executor = usr
	if(Executor.Bijuu) return
	if(!Executor.Scroll_Kunais_L || Executor.Susanoo || !Executor.Get_On_Wall) return
	if(Executor.No_Attack || Executor.GoingSage || Delay || Executor.Venomous_Clone || Executor.freeze) return
	var/Correct
	var/O
	var/F
	for(var/obj/Scroll/S in view(Executor, 5)) {Executor<<"<b><font color=red><u>There is another scroll nearby!</u>"; return}
	if(Executor.on_ground)
		var/B = new/obj/Bounds_Scroll (Executor.loc, Executor)
		for(var/atom/A in obounds(B))
			if(ismob(A) || !A:density && !istype(A, /turf/Special_Floor)) continue
			Correct = 1
		if(Executor.dir == EAST) for(var/atom/A in obounds(Executor, 42, 8))
			if(ismob(A) || !A:density && !istype(A, /turf/Special_Floor)) continue
			O ++
		if(Executor.dir == WEST) for(var/atom/A in obounds(Executor, -42, 8))
			if(ismob(A) || !A:density && !istype(A, /turf/Special_Floor)) continue
			O ++
		if(Executor.dir == EAST) for(var/atom/A in obounds(Executor, 64, -8))
			if(ismob(A) || !A:density && !istype(A, /turf/Special_Floor)) continue
			F ++
		if(Executor.dir == WEST) for(var/atom/A in obounds(Executor, -64, -8))
			if(ismob(A) || !A:density && !istype(A, /turf/Special_Floor)) continue
			F ++
	else if(Executor.Wall_Freeze) Correct = 1
	else Correct = 0
	if(O) {Executor<<"<b><font color=red><u>There is an obstacle!</u>"; return}
	if(!F && Executor.on_ground) {Executor<<"<b><font color=red><u>You can't place a Kunai Scroll in air!</u>"; return}

	spawn()
		if(!Correct) {Executor<<"<b><font color=red><u>You must be on the ground to drop a Kunai Scroll!</u>"; return}
		if(Executor.Substitution == 1)
			if(Executor.Substitution_Image) del(Executor.Substitution_Image)
			Executor.density = 1
			Executor.Dragonned = 0
			Executor.Substitution = 0
			Executor.Can_Attack_ = 1
			Executor.invisibility = 0
		if(!Executor.Wall_Freeze)
			if(Executor.name == "Suigetsu") Flick("throw", Executor)
			else Flick("punch[rand(1,5)]", Executor)
		Executor.freeze ++
		Executor.Scroll_Kunais_L --
		Real_Name = "[Executor.Scroll_Kunais_L]/[Executor.Scroll_Kunais] Kunai Scrolls (Y)"
		Delay(10)
		spawn(1.5)
			new/obj/Scroll (Executor.loc, Executor)
			spawn(1.5) {Executor.freeze --; Executor.stop()}

mob/var/Shuriken_Type
mob/var/Shuriken_Damage
mob/var/list/Existing_Shurikens = list()

mob/Eternal/verb/Refill()
	Kunais_L = 100
	Shurikens_L = 100
	Scroll_Kunais_L = 100

obj
	Scroll
		icon = 'Graphics/Skills/Scroll.dmi'
		var/mob/Creator
		var/Active = 1
		var/Allies
		var/Type
		layer = 95
		pwidth = 8
		pheight = 2

		New(loc, mob/_C)
			..()
			flick("Go", src)
			spawn(5.20) src.Active = 0
			icon_state = ""
			Creator = _C
			Creator.Scrolls.Add(src)
			if(Creator.NEM_Round) Creator.NEM_Round.Scrolls.Add(src)
			dir = Creator.dir
			loc = Creator.loc
			Allies = Creator.Village
			pixel_x = Creator.step_x
			bound_x = Creator.step_x
			if(!Creator.Wall_Freeze)
				Type = "Ground"
				if(dir == EAST) {x += 2; bound_x += 20}
				else if(dir == WEST) {x -= 2; bound_x += 24}
			else
				Type = "Wall"
				pixel_y = Creator.step_y
				bound_y = Creator.step_y
				if(Creator.dir == EAST) dir = SOUTH
				else dir = NORTH
				flick("wall-standing", Creator.Wall_Freeze)
				pixel_x = Creator.Wall_Freeze.pixel_x
				bound_y += 48

		proc/Activate(obj/M, mob/Enemy)
			if(Type == "Wall" && !Enemy.Wall_Freeze || Type == "Ground" && !Enemy.on_ground) return
			Active = 1
			Enemy.S_K_A = 1
			Enemy.freeze ++
			Enemy.Dragonned = 1
			Enemy.Can_Dodge_ = 1
			new/mob/Eternal_Kunai (Creator, src, Enemy)
			flick("Activate", src)
			spawn(5)
				Creator.Scrolls.Remove(src)
				if(Creator.NEM_Round) Creator.NEM_Round.Scrolls.Remove(src)
				del(src)


	Makibishi_Shuriken
		var
			mob/Creator
			Allies

		New(loc, mob/_C, mob/Makibishi_Shuriken/_S)
			..()
			if(_C.NEM_Round) _C.NEM_Round.Shurikens.Add(src)
			_C.Existing_Shurikens.Add(src)
			Creator = _C
			Allies = _S.Allies
			pixel_x = _S.pixel_x
			pixel_x += _S.step_x
			pixel_y = _S.pixel_y
			pixel_y += _S.step_y
			loc = _S.loc
			dir = _S.dir
			icon = _S.icon
			layer = _S.layer -1
			pwidth = _S.pwidth
			icon_state = "[_S.Shuriken_Type][pick("E", "R", "G")]"
			bound_x = pixel_x
			bound_width = 12
			bound_height = 8
			if(dir == EAST) bound_x -= 30
			else bound_x -= 32

		proc/Hurt(mob/M)
			M.Damage(Creator, 15, 1, 0, 0, 1, 0, 0, 0, 1)
			del(src)

		Del()
			if(Creator)
				Creator.Existing_Shurikens.Remove(src)
				if(Creator.NEM_Round) Creator.NEM_Round.Shurikens.Remove(src)
			..()

mob
	Makibishi_Shuriken
		icon = 'Graphics/Skills/Reputation Shurikens.dmi'

		Real_Person = 1
		Checked_X = 0
		Real = 0
		alpha = 200
		Active_M = 0
		Substitution = 1
		pheight = 4
		pwidth = 2
		density = 1
		layer = 250
		Real = 0
		Dragonned = 1
		MaxHP = 100000000000
		pixel_y = -4
		var/_g
		var/Allies
		var/Executed
		var/mob/Creator

		Del()
			if(Creator) Creator.Existing_Shurikens.Remove(src)
			..()

		New(loc, mob/_Creator)
			..()

			spawn(150) del(src)
			_Creator.Existing_Shurikens.Add(src)
			if(_Creator.NEM_Round) _Creator.NEM_Round.Shurikens.Add(src)
			Shuriken_Type = _Creator.Shuriken_Type
			icon_state = "[_Creator.Shuriken_Type]"
			Allies = _Creator.Village
			Creator = _Creator
			loc = _Creator.loc
			dir = _Creator.dir
			if(_Creator.dir == EAST) {set_pos(_Creator.px +rand(54, 62), _Creator.py +36); pixel_x += 2}
			else {set_pos(_Creator.px +42, _Creator.py +rand(32, 40)); pixel_x -= 2}
			bound_x = -8
			if(z == 1 || z == 4)
				if(dir == EAST) pixel_x += 14
				else pixel_x -= 6
			spawn()
				if(dir == EAST) {vel_x = 7; bound_x += 6}
				else {vel_x = -7; bound_x -= 0}
				vel_y = -6
				movement()

		can_bump(atom/A)
			if(!ismob(A) && A.density || A.Special_Floor_Var)
				if(dir == WEST)
					var/K
					for(var/turf/S in obounds(A, -32, 0)) if(S.density || S.Special_Floor_Var) K++
					if(!K) return 0

				if(istype(A, /turf/Wall_Stand))
					if(dir == EAST)
						if(!Executed) Execute(A)
						return 0

				bump(A, 1)
			else return 0

		bump(atom/M, var/S)
			..()
			if(ismob(M))
				M:Damage(Creator, 10, 1, 0, 0, 1, 0, 0, 0, 1)
				M:Shuriken_CD()
				del(src)
			else
				new/obj/Makibishi_Shuriken (loc, Creator, src)
				del(src)


		proc/Execute(var/A)
			var/K
			for(var/turf/T in obounds(A, 32, 0)) if(T.density || T.Special_Floor_Var) {K ++; break()}
			if(!K) return
			Executed = 1
			spawn(2.75) bump(A)

		movement()
			if(!loc) return
			if(_g) vel_y -= 0.50
			if(vel_y <= -6) {vel_y = -6; _g = 0}

			for(var/mob/A in obounds(src, 0, -18))
				if(!A.Shuriken_Damage && !A.Dodge_Next && A.Real && !A.Dragonned && !A.knocked && !A.Susanoo && !A.Boulder && !A.BoulderX && !A.Gates && Allies != A.Village)
					if(A.Dodging) {A.Auto_Dodge(src, 1); return}
					else {bump(A); return}

			if(dir == WEST)
				for(var/turf/Wall_Stand/S in obounds(src, -36, 0))
					var/K
					for(var/turf/E in obounds(S, -32, 0)) if(E.density || E.Special_Floor_Var) K++
					if(K) bump(S)


			if(dir == EAST)
				var/K
				for(var/turf/S in obounds(src, -32, -1)) if(S.density || S.Special_Floor_Var) K++
				if(K) bump(loc)

			for(var/atom/S in obounds(src, 0, -1))

				if(isobj(S) || ismob(S) && !S:Real) continue
				var/Skip
				if(dir == WEST)
					var/K
					for(var/turf/E in obounds(S, -32, 0)) if(E.density || E.Special_Floor_Var) K++
					if(K)
						if(ismob(S)) if(S:Shuriken_Damage || S:Dodge_Next || !S:Real && S:Dragonned || S:knocked || S:Susanoo || S:Boulder || S:BoulderX || S:Gates || Allies == S:Village) continue
						bump(S)
					Skip = 1

				if(!Skip && !ismob(S) && S.density && !istype(S, /turf/Wall_Stand) || S.Special_Floor_Var) bump(S)
			if(freeze) return

			set_flags()

			pixel_move(vel_x, vel_y)

			spawn(world.tick_lag)
				if(dir == EAST)
					vel_x *= 0.98
					if(vel_x < 0) vel_x = 0
				else
					vel_x *= 0.98
					if(vel_x > 0) vel_x = 0
				check_loc()
				movement()

mob/proc/Shuriken_CD()
	Shuriken_Damage = 1
	spawn(5) Shuriken_Damage = 0

mob
	Eternal_Kunai
		icon = 'Graphics/Eternal Kunais.dmi'

		Real_Person = 1
		Checked_X = 0
		Real = 0
		Active_M = 0
		Substitution = 1
		pheight = 55
		pwidth = 80
		pixel_y = 16
		density = 0
		Real = 0
		Dragonned = 1
		MaxHP = 100000000000
		var/mob/Creator
		var/Allies
		var/Executed
		var/mob/Enemy
		var/mob/_Enemy
		var/mob/Attacking_To
		var/Un_Freeze = 1

		New(_Creator, obj/Scroll/_E, mob/_F)
			..()

			Creator = _Creator
			Allies = _E.Allies
			Enemy = _E
			_Enemy = _F
			loc = _Enemy.loc
			if(_Enemy.dir == EAST) set_pos(_Enemy.px +18, _Enemy.py +180)
			else set_pos(_Enemy.px -8, _Enemy.py +180)
			spawn()
				bound_x = -8
				if(_Enemy.dir == WEST) bound_x -= 40
				Flick("Go", src)
				if(_Enemy.dir == EAST) pixel_x += 12
				freeze = 1
				spawn(5)
					freeze = 0
					vel_y = -6
					movement()

			spawn(30) del(src)

		can_bump(atom/A)
			if(ismob(A) && !Executed && A:Village != Allies && !A:knocked && !A:Dragonned && A:Real || A == _Enemy) return 1
			else return 0

		bump(atom/M)
			..()
			if(M == src) {del(src); return}
			if(_Enemy && Un_Freeze) {Un_Freeze = 0; _Enemy.freeze --; _Enemy.Dragonned = 0; _Enemy.S_K_A = 0; _Enemy.Can_Dodge_ = 0; _Enemy.stop()}
			if(ismob(M))
				if(Executed) return
				freeze = 1000
				vel_x = 0
				vel_y = 0
				layer = 0
				Attacking_To = M
				var/Was_Dodging
				if(Attacking_To.Dodging == 1) Was_Dodging = 1

				Executed = 1

				var/obj/A = new/obj/Effects/Substitution_A (Attacking_To.loc, Attacking_To)
				A.x = x
				A.pixel_x = step_x
				A.pixel_x -= 26
				if(M.dir == EAST) A.pixel_x += 8
				var/Direction = Attacking_To.dir
				if(!Was_Dodging) {Attacking_To.vel_y = 3; Attacking_To.Damage(Creator, 50, 1)}
				else {Attacking_To.Auto_Dodge(src, null, Attacking_To.dir); Attacking_To<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>The explosion has slightly damaged you!"}

				for(var/mob/W in view(Attacking_To, 2))
					if(!Was_Dodging && W == Attacking_To || W == src || W.Dragonned || W.knocked || !W.Real || W.Susanoo || W.Gates || W.Boulder || W.BoulderX) continue
					W.Damage(Creator, 10, 1)
					if(W != Attacking_To && W.step_x >= step_x) W.knockbackeast()
					else if(W != Attacking_To) W.knockbackwest()

				if(!Was_Dodging && Attacking_To == _Enemy)
					if(Direction == EAST) Attacking_To.knockbackwestx()
					else Attacking_To.knockbackeastx()
				else if(!Was_Dodging && Attacking_To != _Enemy)
					if(Attacking_To.step_x >= step_x) Attacking_To.knockbackeastx()
					else Attacking_To.knockbackwestx()

				Attacking_To.dir = Direction

				spawn() del(src)

		Del(var/G)
			if(_Enemy && Un_Freeze) {Un_Freeze = 0; _Enemy.freeze --; _Enemy.Dragonned = 0; _Enemy.S_K_A = 0; _Enemy.Can_Dodge_ = 0; _Enemy.stop()}
			loc = null
			return

		movement()
			if(!loc || freeze) return
			set_flags()
			pixel_move(vel_x*3, vel_y*3)
			spawn(world.tick_lag) if(!Executed)
				check_loc()
				movement()
mob
	ClayX
		var
			mob/owner
			damage = 0
			lifetime = 300

		New(mob/m, vx, vy)
			..()

			owner = m
			vel_x = vx
			vel_y = vy
			set_pos(m)

			spawn(world.tick_lag * lifetime)
				del src


		bump(mob/M,atom/A)
			..()
			if(ismob(M)&&M.Real==0||ismob(M)&&M.Dragonned==1)del(src)
			if(isturf(M)) del(src)
			if(ismob(M))
				if(M.Village == Village)
					Substitution = 1
					density = 0
					gravity()
					vel_y = -5
					pixel_move(vel_x*3, vel_y*3)
					spawn(2)
						Substitution = 0
						density = 1
				else
					new/obj/Hit(M.loc)
					del(src)
			 spawn(100)del(src)
		Del()
			var/E =new/obj/HugeExplosion(src.loc)
			E:Owner = Owner
			E:Village = Village
			..()

		movement()
			var/T
			if(!loc) return
			pixel_move(vel_x*4, vel_y*4)
			T++
			if(!loc) return
			for(var/mob/m in inside())
				if(T==1) continue
				if(m == owner) continue
				if(m.dead) continue
		Totem
			icon = 'Graphics/Skills/ClayTotem.dmi'
			//pwidth = 50
			Real_Person = 1
			pheight = 50
			pixel_y = 16
			density = 0
			Real=0
			Checked_X = 0


			// d is the direction the bullet will move in
			New(mob/m, d)
				// convert the direction to x/y components
				var/dx = 0
				var/dy = 0

				dy=-6

				..(m, dx, dy)
				spawn(30)del(src)

mob
	ProjectileR
		var
			mob/owner
			T=0
			damage = 0
			lifetime = 300
			var/Exploded = 0

		New(mob/m, vx, vy)
			..()

			Owner = m

			vel_x = vx
			vel_y = vy

			// passing set_pos() an atom will make this
			// projectile be centered inside that atom.
			set_pos(m)

			spawn(world.tick_lag * lifetime)
				del src

		set_state()

		bump(mob/M,atom/A)
			..()
			if(Exploded) return
			if(ismob(M)&&M.Real==0||ismob(M)&&M.Dragonned==1||ismob(M)&&M.Village=="Leaf")del(src)
			if(isturf(M) && can_bump(M)) del(src)
			if(istype(M,/turf/buildingwall))
				x=M:x
				var/dx = 0
				var/dy = 0

				if(dir == EAST) dx = 6
				if(dir == WEST) dx = -6
				if(dir == NORTH) dy = 6
				if(dir == SOUTH) dy = -6

				..(src, dx, dy)
			if(ismob(M))
				if(M.key == owner) return
				var/Damage = 5+rand(1,5)
				M.Damage(Owner, Damage, 1, 0)
				del(src)
			 spawn(100)del(src)
		Del()
			Exploded = 1
			pixel_x = -35
			pixel_y -= 30
			Flick("Explode", src)
			spawn(1.5)
				if(src.dir==EAST)
					loop
						if(T!=7)
							src.T+=1
							var/A = new/mob/Ultimate_Projectile/Kunai (null, Owner, WEST, src)
							A:pixel_y=rand(0, 32)
							spawn(1.25) goto loop
				if(src.dir==WEST)
					loop
						if(T!=7)
							src.T+=1
							var/A = new/mob/Ultimate_Projectile/Kunai (null, Owner, EAST, src)
							A:pixel_y=rand(0, 32)
							spawn(1.25) goto loop
			spawn(9) ..()

		movement()
			if(!loc) return
			if(Exploded) return
			var/T
			pixel_move(vel_x*3, vel_y*3)
			T++
			if(!loc) return
			for(var/mob/m in inside())
				if(T==1)continue
				if(m.key == owner) continue
				var/Damage = 5+rand(3,5)
				m.Damage(Owner, Damage, 1, 0)
				if(m.dead) continue
		Kunai_Grenade
			icon = 'Graphics/Skills/KunaiGrenade.dmi'
			//pwidth = 50
			pheight = 50
			pixel_y = 16
			density = 0
			Real=0
			Checked_X = 0


			// d is the direction the bullet will move in
			New(mob/m, d)
				// convert the direction to x/y components
				var/dx = 0
				var/dy = 0

				if(d & EAST) dx = 6
				if(d & WEST) dx = -6
				if(d & NORTH) dy = 6
				if(d & SOUTH) dy = -6

				..(m, dx, dy)

mob
	ProjectileE
		var
			mob/owner
			damage = 0
			lifetime = 300

		New(mob/m, vx, vy)
			..()

			owner = m

			vel_x = vx
			vel_y = vy

			// passing set_pos() an atom will make this
			// projectile be centered inside that atom.
			set_pos(m)

			spawn(world.tick_lag * lifetime)
				del src

		set_state()

		bump(mob/M,atom/A)
			..()
			if(ismob(M)&&M.Real==0||ismob(M)&&M.Dragonned==1)del(src)
			if(isturf(M) && can_bump(M)) del(src)
			if(istype(M,/turf/buildingwall))
				x=M:x
				var/dx = 0
				var/dy = 0

				if(dir == EAST) dx = 6
				if(dir == WEST) dx = -6
				if(dir == NORTH) dy = 6
				if(dir == SOUTH) dy = -6

				..(src, dx, dy)
			if(ismob(M))
				if(M.Village == "Leaf")
					if(dir == EAST)
						x += 2
						vel_x = 6
					if(dir == WEST)
						vel_x = -6
						x -= 2
					if(dir == NORTH)
						y += 2
						vel_y = 6
					if(dir == SOUTH)
						vel_y = -6
						y -= 2
				if(M.Village != "Leaf")
					var/Damage = 5+rand(1,10)
					M.Damage(Owner, Damage, 1, 0)
					var/C=new/obj/Explosion(M.loc)
					if(src.dir==EAST)
						C:x+=1
					if(src.dir==WEST)
						C:x+=1
					del(src)
			 spawn(100)del(src)
		Del()
			..()

		movement()
			if(!loc) return
			var/T
			pixel_move(vel_x*3, vel_y*3)
			T++
			// check to see if the projectile is overlapping a mob
			if(!loc) return
			for(var/mob/m in inside())
				if(T==1)continue
				//take_damage(m)
				if(m.key == owner) continue
				var/Damage = 5+rand(1,5)
				m.Damage(Owner, Damage, 1, 0)
				var/C=new/obj/Explosion(m:loc)
				if(src.dir==EAST)
					C:x+=1
				if(src.dir==WEST)
					C:x+=1
				// if the mob is the projectile's owner or if the
				// mob is dead, ignore it
				if(m.dead) continue
		Kunai
			icon = 'Graphics/Skills/Kunai.dmi'
			//pwidth = 50
			pheight = 50
			pixel_y = 16
			density = 0
			Real=0
			Checked_X = 0


			// d is the direction the bullet will move in
			New(mob/m, d)
				// convert the direction to x/y components
				var/dx = 0
				var/dy = 0

				if(d & EAST) dx = 6
				if(d & WEST) dx = -6
				if(d & NORTH) dy = 6
				if(d & SOUTH) dy = -6

				..(m, dx, dy)



mob
	Wind_Storm_All
		var
			list/_Winded_ = list()
			damage = 0
			lifetime = 1500

		New(loc, mob/_Owner)
			..()

			Owner = _Owner
			Village = _Owner.Village
			dir = _Owner.dir
			if(dir == EAST) vel_x = 12
			if(dir == WEST) vel_x = -12


			spawn(world.tick_lag * lifetime) del src

			loop
				var/_Target_
				var/list/Enemies = list()
				for(var/mob/M in hearers(13)) if(M.Village != Village && M.knocked == 0 && M.dead == 0 && M.Dragonned == 0 && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0)

					if(M.Real == 1)
						var/Difference = M.px -px
						var/Extra_Difference = M.py -py
						if(Extra_Difference < 0)
							if(M.vel_y >= 6) continue
							M.vel_y += 4
						if(Difference > 0)
							if(M.vel_x < -14) continue
							M.vel_x -= 8
							M.dir = EAST
						if(Difference < 0)
							if(M.vel_x >= 14) continue
							M.vel_x += 8
							M.dir = WEST

						M.fall_speed = 2.5
						var/K
						_Winded_.Add(M)

						spawn(7)
							_Winded_.Remove(M)
							if(_Winded_.Find(M)) K = 1
							if(!K) M.fall_speed = 25

						if(M in ohearers(src, 3))
							_Target_ ++
							if(Enemies.Find(M)) continue
							Enemies.Add(M)
							var/Damage = 3+rand(1, 2)
							M.Damage(Owner, Damage, 1, 0, 0, 1, 0, 1)

				if(_Target_) Owner:Damage_Up(3+rand(1, 2))
				spawn(rand(5)) goto loop

		set_state()

		bump(atom/A)
			if(isturf(A)) del(src)
			else if(ismob(A)) if(A:ByPass == 0) del(src)
			else return

		Del()
			Flick("2",src)
			sleep(3)
			for(var/mob/M in _Winded_)
				M.fall_speed = 25
				M.Winded = 0
			..()

		movement()
			if(!loc) return
			pixel_move(vel_x, vel_y)

		Storm
			icon = 'Graphics/Skills/KonanWind.dmi'
			pheight = 75
			pixel_y = 16
			density = 0
			Substitution = 1
			Real = 0
			Checked_X = 0

mob
	Wind_Supreme_Storm
		var
			list/_Winded_ = list()
			mob/owner
			damage = 0
			lifetime = 600
			var/T = 0
			var/list/Projectiles = list()


		New(loc, mob/Executor)
			..()


			Flick("Go", src)
			Village = Executor.Village
			owner = Executor
			Owner = Executor
			dir = Executor.dir

			if(dir == EAST) vel_x = 12
			if(dir == WEST)
				vel_x = -12
				bound_x -= 4
			spawn(lifetime) del src


			loop
				T++
				var/_Target_

				for(var/mob/M in hearers(15)) if(M != owner && M.knocked == 0 && M.Dragonned == 0 && M.Boulder == 0 && M.BoulderX == 0)
					if(!M.Real && istype(M, /mob/Ultimate_Projectile))
						if(istype(M, /mob/Ultimate_Projectile/NL_Mind_Transfer)) continue
						if(istype(M, /mob/Ultimate_Projectile/L_Mind_Transfer)) continue
						if(Projectiles.Find(M)) continue
						Projectiles.Add(M)
						M:Projectile_Owner = Owner
						M:Allies = Village
						if(M.dir == EAST)
							M.vel_x = -M.vel_x
							if(M.vel_x > 0) M.vel_x = -M.vel_x
							M.dir = WEST
						else
							M.vel_x = abs(M.vel_x)
							M.dir = EAST

					if(M.Real && M.Village != Village)
						var/Difference = M.px -px
						var/Extra_Difference = M.py -py
						if(Extra_Difference < 0)
							if(M.vel_y >= 6) continue
							M.vel_y += 5
						if(Difference > 0)
							if(M.vel_x < -14) continue
							M.vel_x -= 9
							M.dir = EAST
						if(Difference < 0)
							if(M.vel_x >= 14) continue
							M.vel_x += 9
							M.dir = WEST

						M.fall_speed = 2.5
						var/K
						_Winded_.Add(M)

						spawn(7)
							_Winded_.Remove(M)
							if(_Winded_.Find(M)) K = 1
							if(!K) M.fall_speed = 25

						if(M in hearers(src, 3))
							_Target_ ++
							if(M.Attacked_) continue
							M.Attacked(10)
							var/Damage = 3+rand(1,2)
							M.Damage(owner, Damage, 1, 0, 0, 1, 0, 1)

				if(_Target_) Owner:Damage_Up(3+rand(1, 2))
				spawn(rand(5)) goto loop

		bump(atom/A)
			if(isturf(A)) del(src)
			else if(ismob(A)) if(A:ByPass == 0) del(src)
			else return

		movement()
			if(!loc) return
			pixel_move(vel_x, vel_y)

		Del()
			freeze ++
			Flick("End", src)
			sleep(1)
			for(var/mob/M in _Winded_)
				M.fall_speed = 25
				M.Winded = 0
			..()

		Storm
			icon = 'Graphics/Skills/Wind2.dmi'
			density = 0
			pheight = 120
			Substitution = 1
			Real = 0
			Checked_X = 0

mob/var/Winded=0
mob/var/Real=1
mob/var/Checked_X=1
mob/var/First=0
var/RoundsRequired=100

obj
	InkSplash
		layer=90
		icon = 'Graphics/Skills/InkSplash.dmi'
		New()
			Flick("Splash",src)
			spawn(30)del(src)
mob/var/Controlling=0
mob/var/Levitating=0
mob/var/BugCD=0

mob/Dragonpearl123/verb
	End_Round()
		set category = "Server"
		if(alert(src, "Are you sure you want to end the round?", "End Round", "Yes", "No") == "Yes")
			world<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>DragonPearl</b>: You all will die!"
			for(var/mob/M in world)
				if(M.Real == 1 && M.name != M.key && !M.dead && !istype(M, /mob/Eternal_Kunai))
					new/mob/Eternal_Kunai (src, M)
obj/proc
	Clay_Totem()
		var/mob/Executor = usr
		if(Executor.Can_Execute(src, 75) == 0) return
		Delay(30)
		Executor.Execute_Jutsu("You shall surrender to my art!")
		Executor.freeze ++
		Executor.stop()
		Flick("totem", Executor)
		var/A=new/mob/ClayX/Totem(Executor.loc)
		A:set_pos(Executor.px, Executor.py+10)
		A:Owner = Executor
		A:owner = Executor.key
		A:dir = DOWN
		A:Village = Executor.Village
		spawn(10)
			Flick("teleport", Executor)
			Executor.stop()
			Executor.freeze --
	Aggressive_Bug_Swarm()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
		if(Executor.Can_Execute(src, 70) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor<<"<b><font color=#B5B5B5><u>Press X to destroy the Bug Swarm.</b></u></font>"
		Executor.icon_state= "puppeteer"
		var/B = new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling=1
		Executor.move_speed = 0
		var/A = new/mob/Bugs/Bugs_Swarm(Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Owner_X = Executor
		A:Owner = Executor
		A:Village = Executor.Village
		A:dir = Executor.dir
		if(Executor.dir == EAST) A:x+=1
		if(Executor.dir == WEST) A:x-=1

	Sand_Manipulation()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 50) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor<<"<b><font color=#DFD54B><u>Press X to destroy the Sand.</b></u></font>"
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 1
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/SandManipulation/SandManipulation (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Village = Executor.Village
		A:dir = Executor.dir
		A:Owner =Executor
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --

	Basic_Puppet()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor<<"<b><font color=#9A9A9A><u>Press X to destroy the Puppet.</b></u></font>"
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 1
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/Puppet/Basic_Puppet (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Village = Executor.Village
		A:dir = Executor.dir
		A:Owner =Executor
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --

	Basic_PuppetX()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 40) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor<<"<b><font color=#9A9A9A><u>Press X to destroy the Puppet.</b></u></font>"
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 1
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/PuppetEx/Basic_Puppet (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Village = Executor.Village
		A:dir = Executor.dir
		A:Owner =Executor
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --

	Kazekage_Puppet_Summon()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 75) == 0) return
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor.freeze ++
		Executor<<"<b><font color=#DFD54B><u>Press X to destroy the Kazekage Puppet.</b></u></font>"
		Flick("scroll", Executor)
		sleep(5)
		Executor.freeze --
		Executor.stop()
		Executor.Execute_Jutsu("Kuchiyose No Jutsu.- Kazekage Puppet!")
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 2
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/PuppetX/Kazekage (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Village = Executor.Village
		A:dir = Executor.dir
		A:Owner =Executor
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --

	Clay_Centipede()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Executor.Controlling >= 1)
			del(Executor.Controlling_Object)
			return
		if(Executor.Can_Execute(src, 125) == 0) return
		Executor.Special_ = "Centipede"
		Executor.Defense = Executor.Def
		Executor.Def -= 3
		Executor.freeze ++
		Executor<<"<b><font color=#E5E4E2><u>Press W to detonate the Clay Centipede.</b></u></font>"
		Flick("puppeteer", Executor)
		sleep(2.5)
		Executor.freeze --
		Executor.stop()
		Executor.Execute_Jutsu("Clay Centipede!")
		Executor.icon_state= "puppeteer"
		var/B=new/obj/BigSmoke (Executor.loc)
		B:pixel_x = Executor.pixel_x
		B:pixel_y = Executor.pixel_y
		Executor.Controlling = 10
		Executor.move_speed = 0
		Executor.stop()
		var/A = new/mob/Clay_XX/Centipede (Executor.loc)
		Executor.client:perspective = EYE_PERSPECTIVE
		Executor.client:eye = A
		Executor.Controlling_Object = A
		A:NEM_Round= Executor.NEM_Round
		A:NEM_Side = Executor.NEM_Side
		A:Village = Executor.Village
		A:dir = Executor.dir
		A:Owner = Executor
		A:_Owner__ = Executor
		if(Executor.dir == EAST) A:x ++
		if(Executor.dir == WEST) A:x --
mob
	SandManipulation
		Puppet = 1
		Checked_X = 1
		Real_Person = 1

		var
			mob/owner
			damage = 0
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0) del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				if(CanAttack_ == 1 && M.Real == 1 && M.Village != Village && M.Dragonned == 0 && M.Dodging == 0)
					CanAttack_ = 0
					spawn(3) CanAttack_ = 1
					Flick("atk", src)
					var/Damage = 5+rand(2, 3.5)
					M.Damage(Owner, Damage, 1, 0)
					Owner:Cha-=2.5+rand(1, 3.5)
					if(Owner:Cha <= 0)
						Owner<<"<b><font color=#DFD54B><u>Your Sand has vanished due to your low chakra!</u></font>"
						del(src)
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0 && M.Dodging == 1)
					M.Auto_Dodge(src)
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Sand_Manipulation/J in Owner:Jutsus) J.Delay(30)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()

		SandManipulation
			name = "Sand Coffin"
			icon = 'Graphics/Skills/SandManipulation.dmi'
			Real = 1
			Real_C = 0
			MaxHP = 25
			layer = 115
			HP = 25
			Checked_X = 1
			density = 1

mob
	Clay_XX
		Puppet = 1
		layer = 110
		Real_Person = 1
		var
			CanAttack_ = 1
			mob/_Owner__
			mob/owner
			damage = 0

		bump(mob/M,atom/A)
			..()
			return

		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			_Owner__.Controlling_Object = null
			_Owner__.Controlling = 0
			_Owner__.Run_Off()
			_Owner__.Special_ = null
			Del_Puppet()

		Centipede
			icon = 'Graphics/Skills/Centipede.dmi'
			pwidth = 64
			Real = 1
			Real_C = 0
			MaxHP = 75
			pixel_y = -8
			HP = 75
			Checked_X=1
			density = 1
			fall_speed = 20
			name = "Clay Centipede"

mob
	PuppetX
		Puppet = 1
		layer = 101
		Real_Person = 1
		var
			CanAttack_ = 1
			mob/owner
			damage = 0

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			..()
			return
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Kazekage_Puppet_Summon/J in Owner:Jutsus) J.Delay(40)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()

		Kazekage
			icon = 'Graphics/Skills/KazekagePuppet.dmi'
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 25
			Checked_X=1
			density = 1
			name = "Kazekage Puppet"
mob
	PuppetEx
		Puppet = 1
		layer = 101
		Real_Person = 1
		var
			mob/owner
			damage = 0
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0) del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				else if(CanAttack_ == 1 && M.Real == 1 && M.Village != Village && M.Dragonned == 0 && M.Dodging == 0)
					new/obj/Hit(M.loc)
					var/Damage = 35
					M.Damage(Owner, Damage, 1, 1, src)
					var/C=new/obj/Explosion(M.loc)
					C:x+=1
					del(src)
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0&&M.Dodging==1)
					M.Auto_Dodge(src)
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Basic_Puppet_Summon_Kankuro/J in Owner:Jutsus) J.Delay(10)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()

		Basic_Puppet
			icon = 'Graphics/Characters/Basic Puppet.dmi'
			icon_state = "mob-standing"
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 25
			Checked_X=1
			density = 1
mob
	Puppet
		Puppet = 1
		layer = 101
		Real_Person = 1
		var
			mob/owner
			damage = 0
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0)del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				if(CanAttack_ == 1 && M.Real == 1 && M.Village != Village && M.Dragonned == 0)
					var/Damage = 35
					M.Damage(Owner, Damage, 1, 1, src)
					var/C=new/obj/Explosion(M.loc)
					C:x+=1
					del(src)
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Basic_Puppet_Summon_Sasori/J in Owner:Jutsus) J.Delay(10)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()

		Basic_Puppet
			icon = 'Graphics/Characters/Basic Puppet.dmi'
			icon_state = "mob-standing"
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 25
			Checked_X=1
			density = 1
mob
	Salamander
		Puppet = 1
		layer = 101
		Real_Person = 1
		var
			mob/owner
			damage = 0
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0)del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				if(CanAttack_ == 1 && M.Real == 1 && M.Village != Village && M.Dragonned == 0 && M.Dodging == 0)
					CanAttack_ = 0
					spawn(3) CanAttack_ = 1
					var/Damage = 5+rand(2, 3.5)
					M.Damage(Owner, Damage, 1, 0)
					Owner:Cha-=2.5+rand(0.5, 2)
					if(Owner:Cha <= 0)
						Owner<<"<b><font color=#9A9A9A><u>Your Salamander Puppet has vanished due to your low chakra!</u></font>"
						del(src)
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0&&M.Dodging==1)
					M.Auto_Dodge(src)
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Salamander_Puppet_Summon/J in Owner:Jutsus) J.Delay(30)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()

		Salamander
			icon = 'Graphics/Skills/Salamander.dmi'
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 25
			Checked_X = 1
			density = 1
mob
	CrowPuppet
		Puppet = 1
		layer = 101
		Real_Person = 1
		var
			mob/owner
			damage = 0
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0)del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				if(CanAttack_ == 1 && M.Real == 1 && M.Village != Village && M.Dragonned == 0 && M.Dodging == 0)
					CanAttack_ = 0
					spawn(3) CanAttack_ = 1
					Flick("atk", src)
					var/Damage = 5+rand(2, 3.5)
					M.Damage(Owner, Damage, 1, 0)
					Owner:Cha-=3+rand(0.5, 3)
					if(AllowedPoison==1&&M.Poison_Immunity==0)
						if(prob(25)) M.Poison_Proc(3, name)
					if(Owner:Cha <= 0)
						Owner<<"<b><font color=#9A9A9A><u>Your Crow Puppet has vanished due to your low chakra!</u></font>"
						del(src)
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0&&M.Dodging==1)
					M.Auto_Dodge(src)
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Crow_Puppet_Summon/J in Owner:Jutsus) J.Delay(40)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()

		CrowPuppet
			name = "Crow Puppet"
			icon = 'Graphics/Skills/CrowPuppet.dmi'
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 25
			Checked_X = 1
			density = 1
mob
	SasoriP
		Puppet = 1
		layer = 101
		Real_Person = 1
		var
			mob/owner
			damage = 0
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0)del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				if(CanAttack_ == 1 && M.Real == 1 && M.Village != Village && M.Dragonned == 0 && M.Dodging == 0)
					CanAttack_ = 0
					spawn(3) CanAttack_ = 1
					Flick("punch1", src)
					var/Damage = 5.25+rand(3, 4.5)
					M.Damage(Owner, Damage, 1, 0)
					Owner:Cha-=6+rand(0.5, 3)
					if(AllowedPoison==1&&M.Poison_Immunity==0)
						if(prob(40)) M.Poison_Proc(3, name)
					if(Owner:Cha <= 0)
						Owner<<"<b><font color=#9A9A9A><u>Sasori has vanished due to your low chakra!</u></font>"
						del(src)
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0&&M.Dodging==1)
					M.Auto_Dodge(src)
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Sasori_Puppet_Summon/J in Owner:Jutsus) J.Delay(40)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()

		SasoriP
			name = "Sasori Puppet"
			icon = 'Graphics/Characters/SasoriX.dmi'
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 90
			Checked_X = 1
			density = 1
mob
	KusanagiX
		Puppet = 1
		name = "Kusanagi"
		layer = 101
		Real_Person = 1
		var
			mob/owner
			damage = 0
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0)del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				if(CanAttack_ == 1 && M.Real == 1 && M.Village != Village && M.Dragonned == 0 && M.Dodging == 0)
					CanAttack_ = 0
					spawn(3) CanAttack_ = 1
					Flick("atk",src)
					var/Damage = 5+rand(2, 3.5)
					M.Damage(Owner, Damage, 1, 0)
					Owner:Cha-=2.5+rand(1, 3.5)
					if(Owner:Cha <= 0)
						Owner<<"<b><font color=#A24E94><u>Your Kusanagi has vanished due to your low chakra!</u></font>"
						del(src)
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0&&M.Dodging==1)
					M.Auto_Dodge(src)
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Kusanagi_K/J in Owner:Jutsus) J.Delay(30)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()
		Kusanagi
			icon = 'Graphics/Skills/Kusangi.dmi'
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 25
			Checked_X = 1
			density = 1

mob
	Kusanagi
		Puppet = 1
		layer = 101
		Real_Person = 1
		var
			mob/owner
			damage = 0
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0)del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				if(CanAttack_ == 1 && M.Real == 1 && M.Village != Village && M.Dragonned == 0 && M.Dodging == 0)
					CanAttack_ = 0
					spawn(3) CanAttack_ = 1
					Flick("atk",src)
					var/Damage = 5+rand(2, 3.5)
					M.Damage(Owner, Damage, 1, 0)
					Owner:Cha-=2.5+rand(1, 3.5)
					if(Owner:Cha <= 0)
						Owner<<"<b><font color=#A24E94><u>Your Kusanagi has vanished due to your low chakra!</u></font>"
						del(src)
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0&&M.Dodging==1)
					M.Auto_Dodge(src)
		Del()
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Kusanagi/J in Owner:Jutsus) J.Delay(30)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()
		Kusanagi
			icon = 'Graphics/Skills/Kusangi.dmi'
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 25
			Checked_X = 1
			density = 1


mob
	Bugs
		Puppet = 1
		layer = 101
		Real_Person = 1
		var
			mob/owner
			damage = 0
			Owner_X
			CanAttack_ = 1

		New(mob/m)
			..()
			owner = m

		bump(mob/M,atom/A)
			if(istype(M,/turf/wall))return
			if(ismob(M))
				if(M.Real==0)del(src)
				if(M.Dodging)
					Owner<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] managed to dodge your jutsu!"
					M.Auto_Dodge (src)
					CanAttack_ = 0
					spawn(30) CanAttack_ = 1
					return
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0&&M.Dodging==0)
					new/obj/BugEffect(M.loc, M, Owner_X)
					M.Run_Off()
					M.stop()
					del(src)
				if(M.Real==1&&M.Village!=Village&&M.Dragonned==0&&M.Dodging==1)
					M.Auto_Dodge(src)
		Del()
			if(Deleted == 1)
				return
			if(Deleted == 2)
				..()
				return
			for(var/obj/Jutsus/Aggressive_Bug_Swarm/J in Owner:Jutsus) J.Delay(45)
			Owner:Def = Owner:Defense
			Owner:Controlling_Object = null
			Owner:client:perspective = MOB_PERSPECTIVE
			Owner:client:eye = Owner
			Owner:Controlling=0
			Owner:Run_Off()
			Del_Puppet()

		Bugs_Swarm
			icon = 'Graphics/Skills/Bugs.dmi'
			pixel_y = 16
			Real = 1
			Real_C = 0
			MaxHP = 25
			HP = 25
			Checked_X = 1
			density = 1


mob/var/Real_C = 1

obj/InkSnakeEffect
	icon = 'Graphics/Skills/snakeloc.dmi'
	layer = 150
	pixel_x = 6
	bound_width = 64
	bound_height = 64
	var/list/Caught=list()
	var/Village
	New(loc, _dir)
		dir = _dir
		spawn()
			for(var/mob/M in Caught)
				M.freeze ++
				M.Dodging = 0
			spawn(27.5)
				for(var/mob/D in Caught)
					D.freeze --
					D.stop()
					Caught.Remove(D)
				del(src)
obj/BindEffect
	icon = 'Graphics/Skills/BindLoc.dmi'
	layer = 150
	pixel_x = 6
	var/list/Caught=list()
	var/Village
	New()
		spawn()
			Flick("Go", src)
			for(var/mob/M in Caught)
				M.stop()
				M.layer = 0
				M.freeze ++
				M.Dodging = 0
			spawn(27.5) del(src)
	Del()
		Flick("End", src)
		sleep(2.75)
		for(var/mob/D in Caught)
			if(Caught.Find(D))
				D:CanMove = 1
				D:freeze --
				D:layer = 100
				D:stop()
				Caught.Remove(D)
		spawn(0.25) ..()
obj/SpiderEffect
	icon = 'Graphics/Skills/SpiderLock.dmi'
	layer = 150
//	pixel_x = 6
	var/list/Caught=list()
	var/T=0
	var/Village
	New()
		spawn()
			for(var/mob/M in Caught)
				src.pixel_x = M.pixel_x
				src.pixel_y = M.pixel_y
				M.loc = locate(src.x,src.y,src.z)
				M.CanMove = 0
				M.freeze ++
				M.Dodging = 0
			spawn(rand(17, 21)) del(src)
	Del()
		for(var/mob/M in Caught)
			M.CanMove = 1
			M.freeze --
			M.stop()
			Caught.Remove(M)
		spawn(2.5) ..()
obj/BugEffect
	icon = 'Graphics/Skills/buglock.dmi'
	layer = 150
//	pixel_x = 6
	var/list/Caught=list()
	var
		T=0
		Owner
		_Allies
	var/mob/Enemy
	New(loc, mob/M, mob/O)
		..()
		Enemy = M
		Owner = O
		Enemy.freeze ++
		loop
			T++
			if(T >= 13) del(src)
			var/Damage = 2.5
			Enemy.Damage(Owner, Damage, 1, 0)
			Enemy.Cha -= 2.5
			Enemy.Dragonned = 1
			Enemy.loc=locate(src.x,src.y,src.z)
			spawn(5) goto loop
	Del()
		Enemy.Dragonned = 0
		Enemy.freeze --
		Enemy.stop()
		Caught.Remove(Enemy)
		spawn(5)..()

obj/Immense_Explosion
	icon = 'Graphics/Skills/ExplosionE.dmi'
	layer = 150
	bound_width=170 //This line and the next sets the bounded box for mobcheck.
	bound_height=135 //The bounded box determines what part of the atom is dense.
	New()
		..()
		Flick("Go", src)
		spawn(10) del(src)
obj/Ultra_Explosion
	icon = 'Graphics/Skills/Explosion C.dmi'
	layer = 150
	pixel_x = -5
	pixel_y = -5
	var/Village
	var/_Owner__
	New()
		..()
		Flick("Go", src)
		var/_Target_
		spawn(11.5) del(src)
		spawn(3.5)
			for(var/mob/M in hearers(src, 8))
				if(M.Real==1&&M.Boulder == 0&&M.BoulderX == 0 && M.Dragonned == 0&& M.Gates == 0 && M.knocked == 0 && M.name!="Deidara"&&M.Village!=Village)
					var/Damage = rand(45, 70)
					_Target_ ++
					M.Damage(_Owner__, Damage, 1, 2, 0, 0, 0, 1)
			if(_Target_) _Owner__:Damage_Up(rand(45, 70))
obj/HugeExplosion
	icon = 'Graphics/Skills/HugeExplosion.dmi'
	layer = 150
	var/Village
	var/Owner
	New()
		..()
		src.x-=2
		var/_Target_
		spawn(15) del(src)
		spawn()
			for(var/mob/M in hearers(src,10))
				if(M.Real==1&&M.Boulder == 0&&M.BoulderX == 0 && M.Dragonned == 0&& M.Gates == 0 && M.knocked == 0 && M.name!="Deidara"&&M.Village!=Village)
					_Target_ ++
					var/Damage = rand(40, 70)
					M.Damage(Owner, Damage, 1, 2, 0, 0, 0, 1)
			if(_Target_) Owner:Damage_Up(rand(40, 70))


mob/var/Controlling_Shadow = 0

obj/proc/Shadow_Summoning()
	var/mob/Executor = usr
	if(Executor.NEM_Round.Type == "King Of The Hill") {Executor<<"<b><font color=red><u>This jutsu isn't allowed on King of the Hill!</u>"; return}
	if(Executor.NEM_Round.Mode == "Arena") return
	if(Delay) return
	for(var/obj/Shadow/S in world) if(S.Started)
		Executor.Controlling_Shadow = 0
		Executor.Special_ = 0
		Executor.Doming = 0
		del(S)
		return
	if(!Executor.on_ground || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
	if(Executor.Cha < 10)
		Executor.Cooldown_Display (10)
		return
	if(Executor.Substitution == 1)
		if(Executor.Substitution_Image) del(Executor.Substitution_Image)
		Executor.density = 1
		Executor.Dragonned = 0
		Executor.Substitution = 0
		Executor.Can_Attack_ = 1
		Executor.invisibility = 0
	Flick("Go", Executor)
	Executor.freeze ++
	Executor.CanMove = 0
	Executor.Dragonned = 1
	Executor.Dodging = 0
	sleep(1.5)
	Executor.Dragonned = 0
	Executor.Cha -= 10
	Executor.Special_ = 1
	view(15)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[Executor.name]</b>: Shadow Summoning!"
	Executor<<"<b><font color=#B6B6B4><u><font size=2>Press X to cancel the Shadow."
	Executor<<"<b><font color=#B6B6B4><u>Press W to use Shadow Sewing."
	Executor<<"<b><font color=#B6B6B4><u>Press Q to use Shadow Neck Binding."
	var/H = new/obj/Shadow (Executor.loc)
	Executor.Controlling_Shadow = 1
	Executor.Dodging = 0
	Executor.CanMove = 0
	Executor.Doming = 1
	Executor.icon_state = "Go"
	H:dir = Executor.dir
	H:Village = Executor.Village
	H:Owner_ = Executor
	if(Executor.dir == EAST) H:pixel_x += 42
	if(Executor.dir == WEST) H:pixel_x -= 126


obj/Shadow
	density = 0
	layer = 150
	bound_width = 200
	bound_height = 1
	var/Disappearing = 0
	var/mob/Owner_ = null
	var/Village = null
	var/list/In = list()
	var/Started
	New()
		..()
		px = 50
		icon = 'Graphics/Skills/Nara Shadow.dmi'
		icon_state = "Go"
		Flick("Go", src)
		sleep(4.5)
		Started = 1
		loop
			if(Disappearing == 1) return
			if(Owner_)
				Owner_:Dodging = 0
				Owner_:Cha -= 1.15
				if(Owner_:Cha <= 0)
					Owner_<<output("<b><font color=#10C8FF><u>The shadow has vanished due to your low chakra!</u></font></b>","Chat")
					del(src)
					return
			if(dir == EAST) for(var/mob/M in bounds(src, bound_width, bound_height, 60))
				if(M.Dragonned == 0 && M.Real == 1 && M.Village != Village && M.on_ground)
					var/C = 0
					for(var/mob/G in In) if(G == M) C++
					if(C == 0)
						M.Assisting(Owner_, 1)
						M.freeze ++
						In.Add(M)
			if(dir == WEST) for(var/mob/M in bounds(src, bound_width, bound_height, -145))
				if(M.Dragonned == 0 && M.Real == 1 && M.Village != Village && M.on_ground)
					var/C = 0
					for(var/mob/G in In) if(G == M) C++
					if(C == 0)
						M.Assisting(Owner_, 1)
						M.freeze ++
						In.Add(M)
			for(var/mob/M in In)
				M.On_Shadow = 1
				M.icon_state = "mob-standing"
				M.Run_Off()
				M.stop()
			spawn(1.25) goto loop
	Del()
		Disappearing = 1
		Flick("Stop", src)
		if(Owner_)
			for(var/obj/Jutsus/Shadow_Summoning/S in Owner_) S.Delay(30)
			Owner_:Doming = 0
			if(!Owner_:knocked) Flick("Stop", Owner_)
		spawn(4.5)
			for(var/mob/M in In)
				M.On_Shadow = 0
				M.CanMove = 1
				M.freeze --
				M.stop()
		spawn(6)
			if(Owner_)
				Owner_:Doming = 0
				Owner_:Special_ = 0
				Owner_:Controlling_Shadow = 0
				Owner_:CanMove = 1
				Owner_:freeze --
				Owner_:stop()
			..()


obj/proc
	Shadow_Neck()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Delay) return
		var/T = 0
		for(var/mob/E in view(30)) if(E.On_Shadow && !E.Dragonned && E.Real && !E.knocked && E.Village != Executor.Village) T++
		if(!T) return
		if(!Executor.Controlling_Shadow) return
		if(Executor.Levitating || Executor.Shield_ || Executor.Gates || Executor.Intangible || Executor.Boulder || Executor.BoulderX || Executor.knockback || Executor.Controlling >= 1 || Executor.Attacking || Executor.knocked) return
		if(Executor.Cha <= 60)
			Executor.Cooldown_Display (60)
			return
		Delay(7)
		Executor.Cha -= 40
		Executor.stop()
		for(var/obj/Shadow_Sewing/J in Executor) J.Delay(7)
		Flick("mob-shooting", Executor)
		sleep(0.5)
		Executor.Execute_Jutsu("Shadow Neck Binding!")
		for(var/mob/M in view(30))
			if(M.On_Shadow && !M.Dragonned && M.Real && !M.knocked && M.Village != Executor.Village)
				Executor.stop()
				M.stop()
				new/obj/Effects/Shadow_Neck (M.loc, M)
				if(M.Levitating) M.Check_Levitating()
				spawn(1.25)
					var/M1 = new/obj/Effects/Meele_Hit (M.loc, M)
					M1:pixel_y += 10
					M.HP -= 15+rand(5, 10)
					Flick("hurt", M)
					M.Death_Check(Executor)
				spawn(3.5)
					var/M2 = new/obj/Effects/Meele_Hit (M.loc, M)
					M2:pixel_y += 10
					M.HP -= 15+rand(5, 10)
					Flick("hurt", M)
					M.Death_Check(Executor)
	Shadow_Sewing()
		var/mob/Executor = usr
		src.On_Ground = 1
		if(Delay) return
		var/T = 0
		for(var/mob/E in view(30)) if(E.On_Shadow && !E.Dragonned && E.Real && !E.knocked && E.Village != Executor.Village) T++
		if(!T) return
		if(!Executor.Controlling_Shadow) return
		if(Executor.Levitating || Executor.Shield_ || Executor.Gates || Executor.Intangible || Executor.Boulder || Executor.BoulderX || Executor.knockback || Executor.Controlling >= 1 || Executor.Attacking || Executor.knocked) return
		if(Executor.Cha <= 40)
			Executor.Cooldown_Display (40)
			return
		Delay(5)
		Executor.Cha -= 25
		Executor.stop()
		for(var/obj/Shadow_Neck/J in Executor) J.Delay(7)
		Flick("mob-shooting", Executor)
		sleep(0.5)
		Executor.Execute_Jutsu("Shadow Sewing!")
		for(var/mob/M in view(30))
			if(M.On_Shadow && !M.Dragonned && M.Real && !M.knocked && M.Village != Executor.Village)
				Executor.stop()
				M.stop()
				new/obj/Effects/Shadow_Sewing (M.loc, M)
				if(M.Levitating) M.Check_Levitating()
				spawn(0.15)
					var/M1 = new/obj/Effects/Meele_Hit (M.loc, M)
					M1:pixel_y += 10
					M.HP -= 10+rand(0, 5)
					Flick("hurt", M)
					M.Death_Check(Executor)
				spawn(2.25)
					var/M2 = new/obj/Effects/Meele_Hit (M.loc, M)
					M2:pixel_y += 10
					M.HP -= 10+rand(0, 5)
					Flick("hurt", M)
					M.Death_Check(Executor)
				spawn(4.25)
					var/M2 = new/obj/Effects/Meele_Hit (M.loc, M)
					M2:pixel_y += 10
					M.HP -= 10+rand(0, 5)
					Flick("hurt", M)
					M.Death_Check(Executor)



mob/var/Deleted = 0
mob/var/On_Shadow = 0

mob/proc/Del_Puppet()
	..()
	var/T = 0
	if(istype(src, /mob/Clay_XX/Centipede))
		Deleted = 1
		Dragonned = 1
		Flick("Explosion", src)
		sleep(7.5)
		var/E = new/obj/Ultra_Explosion (src.loc)
		E:dir = dir
		E:step_x = step_x
		E:step_y = step_y
		E:px = px
		E:py = py
		E:Village = Village
		E:_Owner__ = src:_Owner__
		spawn(12)
			for(var/obj/Jutsus/Clay_Centipede/J in src:_Owner__) J.Delay(60)
			src:_Owner__:Run_Off()
			src:_Owner__.Controlling_Object = null
			src:_Owner__.freeze --
			src:_Owner__.Controlling = 0
			if(src:_Owner__:client)
				src:_Owner__:client:perspective = MOB_PERSPECTIVE
				src:_Owner__:client:eye = src:_Owner__
	loop
		T++
		if(T >= 20)
			Deleted = 2
			del(src)
			return
		else
			Substitution = 1
			HP = 1000000000
			Dragonned = 1
			Real = 0
			Deleted = 1
			freeze = 1
			density = 0
			bound_width = 0
			bound_height = 0
			pwidth = 0
			pheight = 0
			invisibility = 101
			Moving = 0
			spawn(10) goto loop