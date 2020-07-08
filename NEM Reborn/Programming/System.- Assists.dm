mob/var/Assist/Active_Assist
mob/var/Assist/Last_Assist
mob/var/list/Assisted_By = list()

Assist
	var
		mob/Mob
		mob/Enemy
		Damage

	New(mob/C, mob/T, mob/D)
		..()
		Mob = C
		Enemy = T
		Damage = D
		if(!C.Active_Assist) C.Active_Assist = src
		C.Assisted_By.Add(src)
		C.Last_Assist = src

	Del()
		if(Mob.client)
			Mob.Assisted_By.Remove(src)
			if(Mob.Active_Assist == src) Mob.Active_Assist = null
			if(Mob.Last_Assist == src) Mob.Last_Assist = null
		..()

mob/proc
	Check_Assist (var/C)
		if(!Active_Assist) return

		var/A
		Active_Assist.Damage -= C

		if(Active_Assist.Damage <= 0)
			var/To_Delete = Active_Assist
			for(var/Assist/S in Assisted_By) if(S != Active_Assist) if(!A)
				S.Damage -= abs(Active_Assist.Damage)
				A ++
				Active_Assist = S
			del(To_Delete)

	Assisting(mob/Target, var/Damage)
		if(Target.client)
			if(Target == Last_Assist) Last_Assist.Damage += Damage
			else new/Assist (src, Target, Damage)