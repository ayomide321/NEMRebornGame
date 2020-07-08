fmob/var/IronBallCD=0
mob/var/IronBallCDX=0
mob/var/Gates=0
mob/var/AmatsUsed=0
mob/var/Boss = 0
mob/var/Guardian = 0
var/Boss_Mode = 0
var/Boss_Name = null

mob
	President
		verb
		/*	Juggernaut_Mode()
				set category = "Modes"
				if(Boss_Mode == 1 || CTD) return
				if(alert(usr, "Confirmation", "Juggernaut Mode", "Yes", "No") == "Yes")
					var/Goal = input("How many points are required to win?", "Juggernaut Goal") as num
					if(!Goal) return
					Current_Log.Add("*[key] is hosting now a Juggernaut Round, he set goal to [Goal] points!", 1)
					Juggernaut_Mode_Start(Goal, src)*/

			King_of_the_Hill()
				set category = "Modes"
				if(New_Mode) {src<<"<b><font color=red><u>You can't host a special round until [New_Mode] ends!</u>"; return}
				if(alert(usr, "Confirmation", "King of the Hill", "No", "Yes") == "Yes")
					if(New_Mode) {src<<"<b><font color=red><u>You can't host a special round until [New_Mode] ends!</u>"; return}
					Current_Log.Add("*[key] has hosted a King of the Hill Round!", 1)
					world<<"<center><u><font color=[admin_color]><b><font size=3>* [key] is hosting King of the Hill the next round! *</font></center></u>"
					Next_Round = "King Of The Hill"


proc
	Juggernaut_Mode_Start(Goal, mob/P)
		Auto_Balancer = 0
		Juggernaut_Goal = Goal
		Boss_Mode = 1
		Boss_Mode_ = 1
		if(P) world<<"<br><center><u><font color=[admin_color]><b><font size=3>* [P.key] has started Juggernaut Mode! *</font></center></u>"
		else world<<"<br><center><u><font color=[admin_color]><b><font size=3>* Now Juggernaut Mode! *</font></center></u>"
		for(var/mob/M in world) if(M.client && M.name != M.key)
			if(M.Mind_Controlling) M.Reset_Mind_Control()
			M.Auto_Spawn()
			if(!Juggernaut)
				Juggernaut = M
				new/obj/Effects/Aura_Red (Juggernaut.loc, Juggernaut)