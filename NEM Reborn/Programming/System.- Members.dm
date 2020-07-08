var/AFK_Check = 0
var/AFK_CD = 0

mob/verb
	Un_AFK()
		set hidden = 1
		if(AFK == 1)
			Announced("")
			AFK = 0

mob/proc/Check_AFK()
	AFK = 1
	var/Time = 25
	spawn() if(alert(src, "* AFK Check! *", "AFK Check", "Not AFK!") == "Not AFK!")
		if(AFK == 1)
			Announced("")
			AFK = 0

	loop
		if(!AFK) return
		if(Time == 0)
			world<<"<b><font color=red><u>- [key] has been booted for being AFK!"
			del client
		else
			if(Time > 1) Announced("<b><u><font color=[admin_color]>* AFK Check.- You'll be booted in [Time] seconds if you don't click <a href='?src=\ref[src];action=Un_AFK'>here</a></u>!")
			else Announced("<b><u><font color=[admin_color]>* AFK Check.- You'll be booted in [Time] second if you don't click <a href='?src=\ref[src];action=Un_AFK'>here</a></u>!")
			Time --
			spawn(10) goto loop

proc
	AFK_Check_Process()
		AFK_CD = 1
		AFK_Check = 1
		spawn(250) AFK_Check = 0
		spawn(900) AFK_CD = 0
		for(var/client/C) C.mob.Check_AFK()

mob/var/Tries = 0