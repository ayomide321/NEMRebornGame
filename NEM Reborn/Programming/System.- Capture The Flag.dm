var/Capture_The_Flag_X = 0
var/Capture_The_Flag = 0
var/Flags_Required = 5
var/Akatsuki_Flags = 0
mob/var/Flag_CD = 0
var/Leaf_Flags = 0

mob/var/Flag = 0
mob/var/Flag_ = 0

turf/Leaf_Entrance
/*	Entered(mob/M)
		..()
		if(M.Flag == 1 && Capture_The_Flag == 1)
			if(M.Village == "Leaf")
				M.Flag = 0
				M.overlays -= /obj/Akatsuki_Flag
				M.HP = M.MaxHP
				M.Cha = M.MaxCha
				M.Energy = M.MaxEnergy
				world<<"<b><font size=3><font color=#00FF00><u>Allied Shinobi Forces has captured a Flag!</u></font>"
				Leaf_Flags++
				if(Leaf_Flags >= Flags_Required)
					world<<"<b><font size=5><font color=#00FF00><u><center>Allied Shinobi Forces Has Won!</center></u></font>"
					for(var/mob/C)
						C.Refund_Custom()
							if(C.client) C.SaveScores()
					world.Reboot()
				for(var/obj/Akatsuki_Flag_Spawn/A in world) new/mob/Akatsuki_Flag (A:loc)
		..()*/

turf/Akatsuki_Entrance
	/*Entered(mob/M)
		..()
		if(M.Flag == 1)
			if(M.Village == "Akatsuki")
				M.Flag = 0
				M.HP = M.MaxHP
				M.Cha = M.MaxCha
				M.Energy = M.MaxEnergy
				M.overlays -= /obj/Leaf_Flag
				world<<"<b><font size=3><font color=#8904B1><u>Akatsuki has captured a Flag!</u></font>"
				Akatsuki_Flags++
				if(Akatsuki_Flags >= Flags_Required)
					world<<"<b><font size=5><font color=#8904B1><u><center>Akatsuki Has Won!</u></center></font>"
					for(var/mob/C)
						C.Refund_Custom()
						if(C.client) C.SaveScores()
					world.Reboot()
				for(var/obj/Leaf_Flag_Spawn/L in world) new/mob/Leaf_Flag (L:loc)
		..()*/

mob/Leaf_Flag
	bound_width=125 //This line and the next sets the bounded box for mobcheck.
	bound_height=190 //The bounded box determines what part of the atom is dense.
	Village = "Leaf"
	Dragonned = 1
	Flag_ = 1
	dir = EAST
	icon = 'Graphics/Leaf Flag.dmi'

mob/Akatsuki_Flag
	bound_width=125 //This line and the next sets the bounded box for mobcheck.
	bound_height=190 //The bounded box determines what part of the atom is dense.
	Village = "Akatsuki"
	Dragonned = 1
	Flag_ = 1
	dir = WEST
	MaxHP = 100000000000000000000000000
	HP = 100000000000000000000000000
	icon = 'Graphics/Akatsuki Flag.dmi'


obj/Akatsuki_Flag
	icon = 'Graphics/Akatsuki Flag X.dmi'
	layer = 95

obj/Leaf_Flag
	icon = 'Graphics/Leaf Flag X.dmi'
	layer = 95

obj/Akatsuki_Flag_Spawn
obj/Leaf_Flag_Spawn
obj/CTF_LS
obj/CTF_AS




mob
	proc
		Respawn_()
			src<<"<b><font color=red><u><center><font size=2>You will be respawned in 10 seconds.</u></center>"
			spawn(100)
				if(!Moving) Movement()
				if(NEM_Round.Type != "King Of The Hill") return
				src<<"<b><font color=red><u><center><font size=2>You have been respawned.</u></center>"
				src.knocked=0
				src.Dragonned = 0
				src.invisibility = 0
				src.Substitution = 0
				src.HP=MaxHP
				src.Energy = src.MaxEnergy
				src.freeze = 0
				src.stop()
				src.density=1
				src.Cha=MaxCha
				src.knocked=0
				src.dead=0
				src.CanUseGates=0
				src.CanGoKyuubi=0
				src.CanGoCS=0
				if(client)
					src.client:perspective = EYE_PERSPECTIVE
					src.client:eye = src
				src.verbs-=typesof(/mob/Dead/verb)
				src.running=0
				src.set_state()
				src.stop()
				src.Auto_Spawn()



mob/Dragonpearl123/verb
	Flags_Required(n as num)
		set category = "Modes"
		if(!n || !Capture_The_Flag) return
		Flags_Required = n