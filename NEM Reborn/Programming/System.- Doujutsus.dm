mob/var/Sharingan=0
mob/var/SharinganCD=0
mob/var/Byakugan=0
mob/var/ByakuganCD=0
mob/var/Rinnegan=0
mob/var/RinneganCD=0
mob/var/Gentle_Fist=0
mob/var/Amat_Sword=0
mob/var/_CD = 0
mob/var/Executor.CD_ = 0
mob/var/old_multiplier

obj
	proc
		Gentle_Fist()
			var/mob/Executor = usr
			if(Executor.NEM_Round.Mode == "Arena") return

			if(Delay || Executor.Boss || Executor.Guardian || Executor.Sage || Executor.GoingSage || Executor.knocked || Executor.Attacking || Executor.Controlling || Executor.freeze || Executor.knockback) return
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Executor.Gentle_Fist) Gentle_Fist_Off()
			else if(!Executor.Gentle_Fist)
				if(!Executor.Byakugan)
					Executor<<"<b><font color=white>You need to activate Byakugan first!"
					return
				Executor.overlays += new/obj/Gentle_Fist
				Executor<<output("<font color=#87AFC7><font size=2><b><u>The chakra is flowing around your body as you activate the Gentle Fist!</u></font>", "Chat")
				Executor.Gentle_Fist = 1
				Executor._CD = 0
				Executor.Str += 4
				Executor.Regenerate_Chakra = 0
				Executor.DoujutsuCD = 1
				spawn(30) if(Executor.Gentle_Fist) Executor.DoujutsuCD = 0
				var/M = Executor.MaxCha

				loop
					Executor.Cha -= M*0.025


					if(Executor._CD_) return
					if(!Executor.Gentle_Fist || Executor.Cha <= 0 || !Executor.Byakugan)
						if(Executor._CD_) return
						Gentle_Fist_Off()

					else
						spawn(10) goto loop

		Amat_Sword()
			var/mob/Executor = usr
			if(Executor.NEM_Round.Mode == "Arena") return

			if(Delay || Executor.Boss || Executor.Guardian || Executor.Sage || Executor.GoingSage || Executor.knocked || Executor.Attacking || Executor.Controlling || Executor.freeze || Executor.knockback) return
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Executor.Amat_Sword) Amat_Sword_Fist_Off()
			else if(!Executor.Amat_Sword)
				if(!Executor.Rinnegan)
					Executor<<"<b><font color=white>You need to activate Rinnegan first!"
					return
				Executor<<output("<font color=#87AFC7><font size=2><b><u>You feel the flames slowly burn you as you burn others!</u></font>", "Chat")
				Executor.Amat_Sword = 1
				Executor._CD = 0
				Executor.Str += 4
				Executor.Regenerate_Chakra = 0
				Executor.DoujutsuCD = 1
				spawn(30) if(Executor.Amat_Sword) Executor.DoujutsuCD = 0
				var/M = Executor.MaxCha

				loop
					Executor.Cha -= M*0.025


					if(Executor._CD_) return
					if(!Executor.Amat_Sword || Executor.Cha <= 0 || !Executor.Rinnegan)
						if(Executor._CD_) return
						Amat_Sword_Fist_Off()

					else
						spawn(10) goto loop
		Amat_Sword_Fist_Off()
			var/mob/Executor = usr
			if(!Executor) return
			if(!Executor.Amat_Sword)return
			Delay(12)
			Executor.Amat_Sword = 0
			Executor.Regenerate_Chakra = 1
			Executor<<output("<u><font color=#87AFC7><font size=2><b><u>You've Deactivated Sword of Amatrasu!</u></font>", "Chat")

		Byakugan()
			var/mob/Executor = usr

			if(Delay || Executor.DoujutsuCD || Executor.Boss || Executor.Guardian || Executor.Sage || Executor.GoingSage || Executor.knocked || Executor.Attacking || Executor.Controlling || Executor.freeze || Executor.knockback || Executor.MaxCha == 1) return
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Executor.Byakugan) Byakugan_Off()
			else if(!Executor.Byakugan)
				if(Executor.name == "Hanabi" && Executor.on_ground)
					Flick("Byakugan", Executor)
					Executor.freeze ++
					spawn(6) Executor.freeze --
				Executor.old_multiplier = Executor.speed_multiplier
				Executor.overlays += new/obj/Byakugan
				Executor<<output("<font color=white><font size=2><b><u>You've activated Byakugan!</u></font>", "Chat")
				Executor.Byakugan = 1
				Executor._CD = 0
				var/H = Executor.MaxHP
				var/C = Executor.MaxCha
				var/E = Executor.MaxEnergy
				Executor.speed_multiplier +=  0.45
				Executor.MaxEnergy += 150
				Executor.MaxHP += 40
				Executor.MaxCha += 100
				Executor.Def += 2.5
				Executor.Str += 3
				if(Executor.HP >= H/1.15) Executor.HP = Executor.MaxHP
				if(Executor.Cha >= C/1.15) Executor.Cha = Executor.MaxCha
				if(Executor.Energy >= E/1.15) Executor.Energy = Executor.MaxEnergy
				Executor.DoujutsuCD = 1
				spawn(30) if(Executor.Byakugan) Executor.DoujutsuCD = 0

				loop
					if(!Executor.Byakugan)
						if(Executor._CD) return
						else Byakugan_Off()
					else spawn(10) goto loop

		Rinnegan()
			var/mob/Executor = usr

			if(Delay || Executor.DoujutsuCD || Executor.Boss || Executor.Guardian || Executor.Sage || Executor.GoingSage || Executor.knocked || Executor.Attacking || Executor.Controlling || Executor.freeze || Executor.knockback || Executor.MaxCha == 1) return
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Executor.Rinnegan) Rinnegan_Off()
			else if(!Executor.Rinnegan)
				if(Executor.name == "Hanabi" && Executor.on_ground)
					Flick("Byakugan", Executor)
					Executor.freeze ++
					spawn(6) Executor.freeze --
				Executor.old_multiplier = Executor.speed_multiplier
				Executor.overlays += new/obj/Rinnegan
				Executor<<output("<font color=white><font size=2><b><u>You've awakened rinnegan!</u></font>", "Chat")
				Executor.Rinnegan = 1
				Executor._CD = 0
				var/H = Executor.MaxHP
				var/C = Executor.MaxCha
				var/E = Executor.MaxEnergy
				Executor.speed_multiplier +=  0.45
				Executor.MaxEnergy += 150
				Executor.MaxHP += 40
				Executor.MaxCha += 100
				Executor.Def += 2.5
				Executor.Str += 3
				if(Executor.HP >= H/1.15) Executor.HP = Executor.MaxHP
				if(Executor.Cha >= C/1.15) Executor.Cha = Executor.MaxCha
				if(Executor.Energy >= E/1.15) Executor.Energy = Executor.MaxEnergy
				Executor.DoujutsuCD = 1
				spawn(30) if(Executor.Rinnegan) Executor.DoujutsuCD = 0

				loop
					if(!Executor.Rinnegan)
						if(Executor._CD) return
						else Rinnegan_Off()
					else spawn(10) goto loop

		Gentle_Fist_Off()
			var/mob/Executor = usr
			if(!Executor) return
			Delay(30)
			Executor._CD_ = 1
			Executor.Gentle_Fist = 0
			Executor.Regenerate_Chakra = 1
			spawn(30) Executor._CD_ = 0
			Executor.overlays -= /obj/Gentle_Fist
			Executor.Str -= 4
			Executor<<output("<u><font color=#87AFC7><font size=2><b><u>The chakra stopped flowing around your body as you deactivated the Gentle Fist!</u></font>", "Chat")
			for(var/obj/Gentle_Fist/S in Executor.overlays) del(S)

		Byakugan_Off()
			var/mob/Executor = usr
			if(!Executor) return
			Delay(15)
			Executor._CD = 1
			spawn(30) Executor._CD = 0
			Executor.overlays -= /obj/Byakugan
			Executor.DoujutsuCD = 0
			Executor.Byakugan = 0
			Executor.speed_multiplier -=  0.45
			Executor.MaxEnergy -= 150
			Executor.MaxHP -= 40
			Executor.MaxCha -= 100
			Executor.Def -= 2.5
			Executor.Str -= 3
			if(Executor.HP > Executor.MaxHP) Executor.HP = Executor.MaxHP
			if(Executor.Cha > Executor.MaxCha) Executor.Cha = Executor.MaxCha
			if(Executor.Energy > Executor.MaxEnergy) Executor.Energy = Executor.MaxEnergy
			Executor<<output("<u><font color=white><font size=2><b>You've deactivated Byakugan!</u></font>", "Chat")
			for(var/obj/Byakugan/S in Executor.overlays) del(S)

		Rinnegan_Off()
			var/mob/Executor = usr
			if(!Executor) return
			Delay(15)
			Executor._CD = 1
			spawn(30) Executor._CD = 0
			Executor.overlays -= /obj/Rinnegan
			Executor.DoujutsuCD = 0
			Executor.Rinnegan = 0
			Executor.speed_multiplier -=  0.45
			Executor.MaxEnergy -= 150
			Executor.MaxHP -= 40
			Executor.MaxCha -= 100
			Executor.Def -= 2.5
			Executor.Str -= 3
			if(Executor.HP > Executor.MaxHP) Executor.HP = Executor.MaxHP
			if(Executor.Cha > Executor.MaxCha) Executor.Cha = Executor.MaxCha
			if(Executor.Energy > Executor.MaxEnergy) Executor.Energy = Executor.MaxEnergy
			Executor<<output("<u><font color=purple><font size=2><b>You've deactivated Rinnegan!</u></font>", "Chat")
			for(var/obj/Rinnegan/S in Executor.overlays) del(S)

		Sharingan()
			var/mob/Executor = usr
			if(Delay || Executor.Venomous_Clone || Executor.DoujutsuCD || Executor.Boss || Executor.Guardian || Executor.GoingSage || Executor.knocked || Executor.Attacking || Executor.Controlling || Executor.freeze || Executor.knockback || Executor.MaxCha == 1) return
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Executor.Sharingan) Sharingan_Off()
			else if(!Executor.Sharingan)
				Executor.old_multiplier = Executor.speed_multiplier
				if(Executor.name != "Lord Itachi" && Executor.name != "ANBU Kakashi")
					Executor.overlays += new/obj/Sharingan
					Executor<<output("<font color=#800517><font size=2><b><u>You've activated Sharingan!</u></font>", "Chat")
				else
					Executor<<output("<font color=#800517><font size=2><b><u>You've activated Mangekyou Sharingan!</u></font>", "Chat")
					if(Executor.name == "Lord Itachi") Executor.overlays += new/obj/Mangekyou_Sharingan
					else Executor.overlays += new/obj/Mangekyou_Sharingan_K
				Executor.Sharingan = 1
				Executor._CD = 0
				var/H = Executor.MaxHP
				var/C = Executor.MaxCha
				var/E = Executor.MaxEnergy
				Executor.speed_multiplier +=  0.40
				Executor.MaxEnergy += 150
				Executor.MaxHP += 40
				Executor.MaxCha += 50
				Executor.Def += 2.5
				Executor.Str += 2.5
				if(Executor.HP >= H/1.15) Executor.HP = Executor.MaxHP
				if(Executor.Cha >= C/1.15) Executor.Cha = Executor.MaxCha
				if(Executor.Energy >= E/1.15) Executor.Energy = Executor.MaxEnergy
				Executor.DoujutsuCD = 1
				spawn(30) if(Executor.Sharingan) Executor.DoujutsuCD = 0

				loop
					if(!Executor.Sharingan)
						if(Executor._CD) return
						else Sharingan_Off()
					else spawn(10) goto loop

		Sharingan_Off()
			var/mob/Executor = usr
			if(!Executor) return
			Delay(15)
			Executor._CD = 1
			spawn(30) Executor._CD = 0
			Executor.DoujutsuCD = 0
			Executor.Sharingan = 0
			Executor.speed_multiplier -=  0.40
			Executor.MaxEnergy -= 150
			Executor.MaxHP -= 40
			Executor.MaxCha -= 50
			Executor.Def -= 2.5
			Executor.Str -= 2.5
			if(Executor.HP > Executor.MaxHP) Executor.HP = Executor.MaxHP
			if(Executor.Cha > Executor.MaxCha) Executor.Cha = Executor.MaxCha
			if(Executor.Energy > Executor.MaxEnergy) Executor.Energy = Executor.MaxEnergy
			if(Executor.name != "Lord Itachi" && Executor.name != "ANBU Kakashi")
				Executor.overlays -= /obj/Sharingan
				for(var/obj/Sharingan/S in Executor.overlays) del(S)
				Executor<<output("<u><font color=#800517><font size=2><b>You've deactivated Sharingan!</u></font>", "Chat")
			else
				Executor.overlays -= /obj/Mangekyou_Sharingan
				Executor.overlays -= /obj/Mangekyou_Sharingan_K
				for(var/obj/Mangekyou_Sharingan/S in Executor.overlays) del(S)
				for(var/obj/Mangekyou_Sharingan_K/S in Executor.overlays) del(S)
				Executor<<output("<u><font color=#800517><font size=2><b>You've deactivated Mangekyou Sharingan!</u></font>", "Chat")

mob
	proc

		Gentle_Fist_Off(mob/Executor)
			if(!Executor) return
			for(var/obj/Jutsus/Gentle_Fist/S in src) S.Delay(30)
			Executor.Gentle_Fist = 0
			Executor._CD_ = 1
			Executor.Regenerate_Chakra = 1
			spawn(30) Executor._CD_ = 0
			Executor.overlays -= /obj/Gentle_Fist
			Executor.Str -= 5
			Executor<<output("<u><font color=#87AFC7><font size=2><b><u>The chakra stopped flowing around your body as you deactivated the Gentle Fist!</u></font>", "Chat")
			for(var/obj/Gentle_Fist/S in Executor.overlays) del(S)

		Amat_Sword_Fist_Off(mob/Executor)
			if(!Executor) return
			Executor.Amat_Sword = 0
			Executor.Regenerate_Chakra = 1
			Executor<<output("<u><font color=#87AFC7><font size=2><b><u>You've Deactivated Sword of Amatrasu!</u></font>", "Chat")

		Sharingan_Off(mob/Executor)
			if(!Executor) return
			if(!Executor.Sharingan) return
			for(var/obj/Jutsus/Sharingan_1/S in src) S.Delay(15)
			for(var/obj/Jutsus/Mangekyou_Sharingan/S in src) S.Delay(15)
			Executor._CD = 1
			spawn(30) Executor._CD = 0
			Executor.DoujutsuCD = 0
			Executor.Sharingan = 0
			Executor.speed_multiplier -=  0.40
			Executor.MaxEnergy -= 150
			Executor.MaxHP -= 40
			Executor.MaxCha -= 50
			Executor.Def -= 2.5
			Executor.Str -= 2.5
			Executor.overlays -= /obj/Sharingan
			Executor.overlays -= /obj/Mangekyou_Sharingan
			Executor.overlays -= /obj/Mangekyou_Sharingan_K
			if(Executor.HP > Executor.MaxHP) Executor.HP = Executor.MaxHP
			if(Executor.Cha > Executor.MaxCha) Executor.Cha = Executor.MaxCha
			if(Executor.Energy > Executor.MaxEnergy) Executor.Energy = Executor.MaxEnergy
			Executor<<output("<u><font color=#800517><font size=2><b>You've deactivated Sharingan!</u></font>", "Chat")
			for(var/obj/Sharingan/S in Executor.overlays) del(S)

		Byakugan_Off(mob/Executor)
			if(!Executor) return
			if(!Executor.Byakugan) return
			for(var/obj/Jutsus/Byakugan/S in src) S.Delay(15)
			Executor._CD = 1
			spawn(30) Executor._CD = 0
			Executor.overlays -= /obj/Byakugan
			Executor.DoujutsuCD = 0
			Executor.Byakugan = 0
			Executor.speed_multiplier -=  0.45
			Executor.MaxEnergy -= 150
			Executor.MaxHP -= 40
			Executor.MaxCha -= 100
			Executor.Def -= 2.5
			Executor.Str -= 3
			if(Executor.HP > Executor.MaxHP) Executor.HP = Executor.MaxHP
			if(Executor.Cha > Executor.MaxCha) Executor.Cha = Executor.MaxCha
			if(Executor.Energy > Executor.MaxEnergy) Executor.Energy = Executor.MaxEnergy
			Executor<<output("<u><font color=white><font size=2><b>You've deactivated Byakugan!</u></font>", "Chat")
			for(var/obj/Byakugan/S in Executor.overlays) del(S)

		Rinnegan_Off(mob/Executor)
			if(!Executor) return
			if(!Executor.Rinnegan) return
			for(var/obj/Jutsus/Rinnegan/S in src) S.Delay(15)
			Executor._CD = 1
			spawn(30) Executor._CD = 0
			Executor.overlays -= /obj/Rinnegan
			Executor.DoujutsuCD = 0
			Executor.Rinnegan = 0
			Executor.speed_multiplier -=  0.45
			Executor.MaxEnergy -= 150
			Executor.MaxHP -= 40
			Executor.MaxCha -= 100
			Executor.Def -= 2.5
			Executor.Str -= 3
			if(Executor.HP > Executor.MaxHP) Executor.HP = Executor.MaxHP
			if(Executor.Cha > Executor.MaxCha) Executor.Cha = Executor.MaxCha
			if(Executor.Energy > Executor.MaxEnergy) Executor.Energy = Executor.MaxEnergy
			Executor<<output("<u><font color=white><font size=2><b>You've deactivated Rinnegan!</u></font>", "Chat")
			for(var/obj/Rinnegan/S in Executor.overlays) del(S)

obj
	proc
		Explosive_Meele()
			var/mob/Executor = usr
			if(Delay || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(!Executor.Explosing)
				if(Executor.Cha >= 10)
					Executor<<"<b><font color=#F39441><u>You're now using Explosive Meele!</u>"
					Executor.Explosing = 1
					Executor.Cha -= 10
			else
				Delay(10)
				Executor.Explosing = 0
				Executor<<"<b><font color=#F39441><u>You're no longer using Explosive Meele!</u>"
				return

		Crow_Genjutsu_()
			var/mob/Executor = usr
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Delay || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(!Executor.Special_Crow)
				if(Executor.Cha >= 12.5)
					Executor<<"<font color=#800517><font size=2><b><u>You've activated Crow Genjutsu!</u>"
					Executor.Special_Crow = 1
					Executor.Dodging = 1
					Executor.Cha -= 12.5
			else
				Executor<<"<font color=#800517><font size=2><b><u>You already have Crow Genjutsu active!</u>"
				return

		Domed_Wall()
			var/mob/Executor = usr
			if(Delay || Executor.GoingSage == 1 || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(usr.Cha < 15)
				usr.Cooldown_Display (15)
				return
			var/list/Allies = list()
			for(var/mob/M in hearers(15)) if(M.Village == Executor.Village && M.Real && M.Dragonned == 0 && M.knocked == 0) Allies.Add(M)
			var/mob/M = input("Who would you like to use this jutsu on?", "Wood Domed Wall") as null|anything in Allies
			if(!M) return
			if(Executor.knockback == 1 || Executor.freeze || Executor.Attacking == 1 || Executor.knocked == 1 || M.knocked == 1|| M.Dragonned == 1) return
			if(abs(M.x - Executor.x) > 16 || abs(M.y - Executor.y) > 16) {Executor<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[M.name] is too far away!"; return}
			if(Executor.Can_Execute(src, 15) == 0) return
			Executor.Execute_Jutsu("Wood Release.- Domed Wall!")
			Executor.Attacking ++
			Executor.stop()
			Flick("mob-shooting", Executor)
			spawn(5.25) {Executor.Attacking --; Executor.stop()}
			spawn(3.75)
				var/N = new/obj/Effects/Domed_Wall (M.loc, M)
				N:_To_Drain = Executor

		Crow_Genjutsu()
			var/mob/Executor = usr
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Delay || Executor.Sage == 1 || Executor.GoingSage == 1 || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(!Executor.Crow)
				if(Executor.Cha >= 10)
					Executor<<"<font color=#800517><font size=2><b><u>You've activated Crow Genjutsu!</u>"
					Executor.Crow = 1
					Executor.Cha -= 10
			else
				Executor<<"<font color=#800517><font size=2><b><u>You already have Crow Genjutsu active!</u>"
				return

		Paper_Clone()
			var/mob/Executor = usr
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Delay || Executor.Sage == 1 || Executor.GoingSage == 1 || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(!Executor.Crow)
				if(Executor.Cha >= 10)
					Executor<<"<font color=#CEFBFF><font size=2><b><u>You've activated Paper Clone!</u>"
					Executor.Crow = 1
					Executor.Cha -= 10
			else
				Executor<<"<font color=#CEFBFF><font size=2><b><u>You already have Paper Clone active!</u>"
				return

		Ink_Clone()
			var/mob/Executor = usr
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Delay || Executor.Sage == 1 || Executor.GoingSage == 1 || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(!Executor.Crow)
				if(Executor.Cha >= 10)
					Executor<<"<font color=#848484><font size=2><b><u>You've activated Ink Clone!</u>"
					Executor.Crow = 1
					Executor.Cha -= 10
			else
				Executor<<"<font color=#848484><font size=2><b><u>You already have Ink Clone active!</u>"
				return

		Body_Flicker()
			var/mob/Executor = usr
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Delay || Executor.Sage == 1 || Executor.GoingSage == 1 || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(!Executor.Crow)
				if(Executor.Cha >= 10)
					Executor<<"<font color=#848484><font size=2><b><u>You've activated Body Flicker!</u>"
					Executor.Crow = 1
					Executor.Cha -= 10
			else
				Executor<<"<font color=#848484><font size=2><b><u>You already have Body Flicker active!</u>"
				return

		Bug_Clone()
			var/mob/Executor = usr
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Delay || Executor.Sage == 1 || Executor.GoingSage == 1 || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(!Executor.Crow)
				if(Executor.Cha >= 10)
					Executor<<"<font color=#6E6E6E><font size=2><b><u>You've activated Bug Clone!</u>"
					Executor.Crow = 1
					Executor.Cha -= 10
			else
				Executor<<"<font color=#6E6E6E><font size=2><b><u>You already have Bug Clone active!</u>"
				return

		Suika()
			var/mob/Executor = usr
			if(Executor.Mind_Controlling)
				Executor<<"<b><font color=#FCDFFF>You're not allowed to use this jutsu through Mind Control."
				return
			if(Delay || Executor.Sage == 1 || Executor.GoingSage == 1 || Executor.knockback == 1 || Executor.freeze || Executor.Controlling >= 1 || Executor.Attacking == 1 || Executor.knocked == 1) return
			if(!Executor.Crow)
				if(Executor.Cha >= 20)
					Executor<<"<font color=#81DAF5><font size=2><b><u>You've activated Suika no Jutsu!</u>"
					Executor.Crow = 1
					Executor.Cha -= 20
			else
				Executor<<"<font color=#81DAF5><font size=2><b><u>You already have Suika no Jutsu active!</u>"
				return