var/Default_Chat=1
var/OOC_Chat=1
mob/var/obj/Selecting
mob/var/Effect__

mob/Quay401/verb
	Rinnegan_Tobi()
		set category = "Special"
		var/Custom = "Rinnegan Tobi"
		var/_Side = "Akatsuki"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Quay400/verb
	Kushimaru()
		set category = "Special"
		var/Custom = "Kushimaru"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Skittlz/verb
	Special_ANBU()
		set category = "Special"
		var/Custom = "Special ANBU"
		var/_Side = "Leaf"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Ashura_Naruto()
		set category = "Special"
		var/Custom = "(Ashura) Naruto"
		var/_Side = "Leaf"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Doom_Chikushodo/verb
	Chikushodo()
		set category = "Special"
		var/Custom = "Chikushodo"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Doom2/verb
	Chikushodo()
		set category = "Special"
		var/Custom = "Chikushodo"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Rinnegan_Sasuke()
		set category = "Special"
		var/Custom = "(Rinnegan) Sasuke"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Yagura()
		set category = "Special"
		var/Custom = "Yagura"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Eternal_Sasuke()
		set category = "Special"
		var/Custom = "Eternal Sasuke"
		var/_Side = "Akatsuki"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Akken/verb

	Eternal_Sasuke()
		set category = "Special"
		var/Custom = "Eternal Sasuke"
		var/_Side = "Akatsuki"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/SuperSS/verb
	Rinnegan_Tobi()
		set category = "Special"
		var/Custom = "Rinnegan Tobi"
		var/_Side = "Akatsuki"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Hanabi/verb
	Hanabi()
		set category = "Special"
		var/Custom = "Hanabi"
		var/_Side = "Leaf"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Google_Stat/verb
	Lord_Itachi()
		set category = "Special"
		var/Custom = "Lord Itachi"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Minato_Namikaze()
		set category = "Special"
		var/Custom = "Minato Namikaze"
		var/_Side = "Leaf"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)


	Kushimaru()
		set category = "Special"
		var/Custom = "Kushimaru"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)


	Yagura()
		set category = "Special"
		var/Custom = "Yagura"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)
	Torune()
		set category = "Special"
		var/Custom = "Torune"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)
	Hanabi()
		set category = "Special"
		var/Custom = "Hanabi"
		var/_Side = "Leaf"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Eternal_Sasuke()
		set category = "Special"
		var/Custom = "Eternal Sasuke"
		var/_Side = "Akatsuki"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Special_ANBU()
		set category = "Special"
		var/Custom = "Special ANBU"
		var/_Side = "Leaf"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Chikushodo()
		set category = "Special"
		var/Custom = "Chikushodo"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Kira35/verb


	Yagura()
		set category = "Special"
		var/Custom = "Yagura"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Doom3/verb

	Minato_Namikaze()
		set category = "Special"
		var/Custom = "Minato Namikaze"
		var/_Side = "Leaf"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Torune_X/verb
	Torune()
		set category = "Special"
		var/Custom = "Torune"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Kabuchimaru/verb
	Kabuchimaru()
		set category = "Special"
		var/Custom = "Kabuchimaru"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Lord_Itachi/verb
	Lord_Itachi()
		set category = "Special"
		var/Custom = "Lord Itachi"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/ANBU_Kakashi/verb
	ANBU_Kakashi()
		set category = "Special"
		var/Custom = "ANBU Kakashi"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob/Doom/verb
	Chuunin_Map()
		set category = "Modes"
		Current_Log.Add("*[key] teleported himself to Chuunin Exam Stage!", 1)
		for(var/obj/Chuunin_Player_Right_Spawn_1/L) Teleport_(L)

	Minato_Namikaze()
		set category = "Special"
		var/Custom = "Minato Namikaze"
		var/_Side = "Leaf"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Torune()
		set category = "Special"
		var/Custom = "Torune"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

	Yagura()
		set category = "Special"
		var/Custom = "Yagura"
		var/list/Players = list()
		var/Myself = "Myself"
		Players += Myself
		for(var/mob/M) if(M.client && M != src && M.name == M.key) Players.Add(M)
		var/mob/M = input("Who do you want to transform to [Custom]?", "* [Custom] *") as null | anything in Players
		if(!M) return
		if(M == "Myself") M = src
		var/Q = input(M, "Would you like to be [Custom]?","* [Custom] *") in list("Yes", "No")
		if(Q == "No") return
		var/_Side = input(M, "Who are you supporting?","* [Custom] *") in list("Leaf", "Akatsuki")
		for(var/obj/Login_Screen/L) if(L.name == Custom) L.Choose(M, _Side, null, null, src, 1)

mob
	proc
		Avatar(name)
			Announced("")
			if(name == "Rinnegan Tobi" || name == "ANBU Kakashi") Chakra_Drain()
			if(name == "Minato Namikaze")
				_Name = "Minato N."
				Avatar = 'Graphics/Faces/Minato Namikaze Face.dmi'
			if(name == "ANBU Kakashi") _Name = "ANBU K."
			if(name == "Yagura")
				_Name = "Yagura"
				Avatar = 'Graphics/Faces/Yagura Face.dmi'
			if(name == "Torune")
				_Name = "Torune"
				Avatar = 'Graphics/Faces/Torune Face.dmi'
			if(name == "Special ANBU")
				_Name = "S. ANBU"
				Avatar = 'Graphics/Faces/ANBU Face.dmi'
			if(name == "Chikushodo")
				_Name = "Chikushodo"
				Avatar = 'Graphics/Faces/Chikushodo Face.dmi'
			if(name == "Kushimaru")
				_Name = "Kushimaru"
				Avatar = 'Graphics/Faces/Kushimaru Face.dmi'
			if(name == "Eternal Sasuke")
				_Name = "EMS Sasuke"
				Avatar = 'Graphics/Faces/Eternal Sasuke Face.dmi'
			if(name == "Rinnegan Tobi")
				_Name = "R. Tobi"
				Avatar = 'Graphics/Faces/Rinnegan Tobi Face.dmi'
			if(!Avatar)
				Avatar = Question
				winset(src, "default.Avatar","image=\ref[Avatar]")
				winset(src, "default.Avatar_Name","text-color=#969696")
				winset(src, "default.Avatar_Name","text=None")
			if(client)
				winset(src, "default.Avatar","image=\ref[Avatar]")
				winset(src, "default.Avatar_Name","text-color=[Text_Color]")
				winset(src, "default.Avatar_Name","text='[_Name]'")

var/YaguraX = 0
var/ToruneX = 0
var/KushimaruX = 0
var/Special_ANBUX = 0
var/ChikushodoX = 0
var/Minato_NamikazeX = 0
var/KakkouX = 0
var/RTX = 0
var/ESX = 0

mob/proc/Kushimaru_Proc()
	..()
	if(src.name == "Kushimaru" || src.name == "{Clone} Kushimaru")
		if(src.CanMove == 1)
			src.pixel_y = -14
			src.pixel_x = -32
		spawn(15) Kushimaru_Proc()

mob/proc/EMS_Proc()
	..()
	if(src.name == "Eternal Sasuke")
		if(src.CanMove == 1)
			src.pixel_x = -14
		spawn(15) EMS_Proc()

turf
	Character_Screen
		layer = 10000000
		pixel_y = 16
		pixel_x = -224

		Background icon = 'Graphics/Screen/Background.png'

client/Click(atom/O)
	if(!O.loc) ..()
	else
		if(mob.Effect__) {mob.Effect__:Use(usr); del(mob.Effect__)}
		else ..()

obj
	Character_Screen
		layer = 10000001
		pixel_x = -224

		Dark_Spot
			pixel_x = -224
			layer = 100000000000000000000000000000000000000000
			icon = 'Graphics/Screen/Dark Spot.png'

		Menu
			icon = 'Graphics/Screen/Menu.png'
			pixel_y = -32
			MouseEntered()
				if(usr.Effect__) del(usr.Effect__)
				var/Effect = new/obj/Effect/Menu (src.loc)
				usr.Effect__ = Effect
				var/Image = image('Graphics/Screen/Menu Glow.png', Effect, null, 10000002)
				Image:pixel_x = pixel_x
				Image:pixel_y = pixel_y
				spawn() usr << Image
			Click() usr.Menu()

		Guide
			icon = 'Graphics/Screen/Guide.png'
			pixel_y = -32
			MouseEntered()
				if(usr.Effect__) del(usr.Effect__)
				var/Effect = new/obj/Effect/Guide (src.loc)
				usr.Effect__ = Effect
				var/Image = image('Graphics/Screen/Guide Glow.png', Effect, null, 10000002)
				Image:pixel_x = pixel_x
				Image:pixel_y = pixel_y
				spawn() usr << Image
			Click() usr.Guide()

		HUB
			icon = 'Graphics/Screen/HUB.png'
			pixel_y = -32
			MouseEntered()
				if(usr.Effect__) del(usr.Effect__)
				var/Effect = new/obj/Effect/HUB (src.loc)
				usr.Effect__ = Effect
				var/Image = image('Graphics/Screen/HUB Glow.png', Effect, null, 10000002)
				Image:pixel_x = pixel_x
				Image:pixel_y = pixel_y
				spawn() usr << Image
			Click() usr<<link("http://www.byond.com/games/SilentWraith/NEM")

		Settings
			icon = 'Graphics/Screen/Settings.png'
			pixel_y = -32
			MouseEntered()
				if(usr.Effect__) del(usr.Effect__)
				var/Effect = new/obj/Effect/Settings (src.loc)
				usr.Effect__ = Effect
				var/Image = image('Graphics/Screen/Settings Glow.png', Effect, null, 10000002)
				Image:pixel_x = pixel_x
				Image:pixel_y = pixel_y
				spawn() usr << Image
			Click() usr.Settings()

		Next
			icon = 'Graphics/Screen/Next.png'
			MouseEntered()
				if(usr.Effect__) del(usr.Effect__)
				if(CTD) return
				if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round)
					var/Effect = new/obj/Effect/Next (src.loc)
					usr.Effect__ = Effect
					var/Image = image('Graphics/Screen/Next Glow.png', Effect, null, 10000002)
					Image:pixel_x = pixel_x
					Image:pixel_y = pixel_y
					spawn() usr << Image
			Click()
				if(CTD) return
				if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round) usr.Next_Page()

		Previous
			icon = 'Graphics/Screen/Previous.png'
			MouseEntered()
				if(usr.Effect__) del(usr.Effect__)
				if(CTD) return
				if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round)
					var/Effect = new/obj/Effect/Previous (src.loc)
					usr.Effect__ = Effect
					var/Image = image('Graphics/Screen/Previous Glow.png', Effect, null, 10000002)
					Image:pixel_x = pixel_x
					Image:pixel_y = pixel_y
					spawn() usr << Image
			Click()
				if(CTD) return
				if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round) usr.Previous_Page()

		Switch_Side_Leaf
			icon = 'Graphics/Screen/Switch Side Leaf.png'
			MouseEntered()
				if(usr.Effect__) del(usr.Effect__)
				if(CTD) return
				if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round)
					var/Effect = new/obj/Effect/Switch_Side_Leaf (src.loc)
					usr.Effect__ = Effect
					var/Image = image('Graphics/Screen/Switch Side Leaf Glow.png', Effect, null, 10000002)
					Image:pixel_x = pixel_x
					Image:pixel_y = pixel_y
					spawn() usr << Image
			Click()
				if(CTD) return
				if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round) usr.Switch_Side_Akatsuki()

		Switch_Side_Akatsuki
			icon = 'Graphics/Screen/Switch Side Akatsuki.png'
			MouseEntered()
				if(usr.Effect__) del(usr.Effect__)
				if(CTD) return
				if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round)
					var/Effect = new/obj/Effect/Switch_Side_Akatsuki (src.loc)
					usr.Effect__ = Effect
					var/Image = image('Graphics/Screen/Switch Side Akatsuki Glow.png', Effect, null, 10000002)
					Image:pixel_x = pixel_x
					Image:pixel_y = pixel_y
					spawn() usr << Image
			Click()
				if(CTD) return
				if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round) usr.Switch_Side_Leaf()

	Effect
		var/Target

		Character
			var/Selecting
			MouseExited() {if(usr.Effect__) del(usr.Effect__); if(usr.Effect) del(usr.Effect)}
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) Selecting:Choose(usr)

		Switch_Side_Leaf
			MouseExited() if(usr.Effect__) del(usr.Effect__)
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round) usr.Switch_Side_Akatsuki(usr)

		Switch_Side_Akatsuki
			MouseExited() if(usr.Effect__) del(usr.Effect__)
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round) usr.Switch_Side_Leaf(usr)

		Menu
			MouseExited() if(usr.Effect__) del(usr.Effect__)
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) usr.Menu()

		Guide
			MouseExited() if(usr.Effect__) del(usr.Effect__)
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) usr.Guide()

		HUB
			MouseExited() if(usr.Effect__) del(usr.Effect__)
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) usr<<link("http://www.byond.com/games/Dragonpearl123/NarutoTheStory")

		Settings
			MouseExited() if(usr.Effect__) del(usr.Effect__)
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) usr.Settings()

		Next
			MouseExited() if(usr.Effect__) del(usr.Effect__)
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round) usr.Next_Page()

		Previous
			MouseExited() if(usr.Effect__) del(usr.Effect__)
			Click() Use(usr)
			proc/Use() if(usr.key == usr.name) if(Allow_New_Users || usr.NEM_Round.Mode != Current_NEM_Round) usr.Previous_Page()


mob/Dragonpearl123/verb/Expand_Icon(F as file)
	set hidden = 1
	var/icon/I = new(F)
//	I.Scale(1024, 480)
//	I.Flip(WEST)
	I.Scale(98, 89)
	spawn() src << ftp(I)

/*mob/Dragonpearl123/verb/Lol(F as file)
	var/icon/I = new(F)
	I.Scale(96, 64)
//	I.Flip(WEST)
	spawn() src << ftp(I)*/

mob/var/Wall_Key


mob
	proc

		Settings_Update()
			var/_Page = winget(src, "default.Setting Name Label", "text")
			if(_Page != "Text Color") winset(src, "default.Enabled Label", "background-color=\"#000000\"")

			if(_Page == "Music")
				if(Sound) winset(src, "default.Enabled Label", "text='Disabled'")
				else winset(src, "default.Enabled Label", "text='Enabled'")
			else if(_Page == "Effects")
				if(SeeEffects) winset(src, "default.Enabled Label", "text='Disabled'")
				else winset(src, "default.Enabled Label", "text='Enabled'")
			else if(_Page == "Wall Jump Key")
				if(!Wall_Key) winset(src, "default.Enabled Label", "text='F'")
				else winset(src, "default.Enabled Label", "text='Shift'")
			else if(_Page == "Tournament Betting")
				if(Accept_Bets) winset(src, "default.Enabled Label", "text='Disabled'")
				else winset(src, "default.Enabled Label", "text='Enabled'")
			else if(_Page == "Votes")
				if(Accept_Votes) winset(src, "default.Enabled Label", "text='Enabled'")
				else winset(src, "default.Enabled Label", "text='Disabled'")
			else if(_Page == "Text Color")
				winset(src, "default.Enabled Label", "text=' '")
				winset(src, "default.Enabled Label", "background-color=\"[Text_Color]\"")


	verb
		Next_Setting()
			set hidden = 1
			var/_Page = winget(src, "default.Setting Name Label", "text")
			if(_Page == "Music") winset(src, "default.Setting Name Label", "text='Effects")
			else if(_Page == "Effects") winset(src, "default.Setting Name Label", "text='Votes'")
			else if(_Page == "Votes") winset(src, "default.Setting Name Label", "text='Tournament Betting'")
			else if(_Page == "Tournament Betting") winset(src, "default.Setting Name Label", "text='Wall Jump Key'")
			else if(_Page == "Wall Jump Key") winset(src, "default.Setting Name Label", "text='Text Color'")
			else if(_Page == "Text Color") winset(src, "default.Setting Name Label", "text='Music'")
			Settings_Update()

		Previous_Setting()
			set hidden = 1
			var/_Page = winget(src, "default.Setting Name Label", "text")
			if(_Page == "Music") winset(src, "default.Setting Name Label", "text='Text Color'")
			else if(_Page == "Effects") winset(src, "default.Setting Name Label", "text='Music'")
			else if(_Page == "Votes") winset(src, "default.Setting Name Label", "text='Effects'")
			else if(_Page == "Tournament Betting") winset(src, "default.Setting Name Label", "text='Votes'")
			else if(_Page == "Wall Jump Key") winset(src, "default.Setting Name Label", "text='Tournament Betting'")
			else if(_Page == "Text Color") winset(src, "default.Setting Name Label", "text='Wall Jump Key'")
			Settings_Update()

		Settings_Press()
			set hidden = 1
			var/_Page = winget(src, "default.Setting Name Label", "text")
			if(_Page == "Music") Toggle_Music()
			else if(_Page == "Effects") Toggle_Effects()
			else if(_Page == "Wall Jump Key") Wall_Jump_Toggle_Key()
			else if(_Page == "Tournament Betting") Toggle_Bets()
			else if(_Page == "Votes") Toggle_Votes()
			else if(_Page == "Text Color") Text_Color()
			Settings_Update()

		Close_Settings()
			set hidden = 1
			winset(src, "default.Setting Name Label", "is-visible=false")
			winset(src, "default.Settings Label", "is-visible=false")
			winset(src, "default.Enabled Label", "is-visible=false")
			winset(src, "default.Close Settings", "is-visible=false")
			winset(src, "default.Next Setting", "is-visible=false")
			winset(src, "default.Previous Setting", "is-visible=false")


		Settings()
			src<<"<b><font color=red><u>Disabled at the moment, sorry :(</u>"
			return
			var/_Page = winget(src, "default.Setting Name Label", "is-visible")
			if(_Page == "true") Close_Settings()
			else
				Settings_Update()
				winset(src, "default.Setting Name Label", "is-visible=true")
				winset(src, "default.Settings Label", "is-visible=true")
				winset(src, "default.Enabled Label", "is-visible=true")
				winset(src, "default.Close Settings", "is-visible=true")
				winset(src, "default.Next Setting", "is-visible=true")
				winset(src, "default.Previous Setting", "is-visible=true")

		Shop()
			Center("Shop")
			winset(src,"Shop.label12","text='Ryo: [round(Statistic.Ryo, 0.01)]'")

		Buy_Kunai_Scrolls()
			set hidden = 1
			var/mob/A = input(src, "This costs 50 Ryo & 2 Reputation! Are you sure?","7x Scroll Kunais") as null | anything in list("No", "Yes")
			if(A == "Yes")
				if(Statistic.Ryo < 50)
					src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
					return
				if(Statistic.Reputation < 2)
					src<<"<font color=red><b><u>You don't have enough reputation!</b></u></font>"
					return
				Scroll_Kunais += 7
				Statistic.Reputation -= 2
				Statistic.Ryo -= 50
				Statistic.Ryo_Spent += 50
				src<<"<b><font color=red><b><u>Thank you! You've bought 7 Scroll Kunais!</b></u></font>"
			if(A == "No")
				src<<"<font color=red><b><u>Okay, farewell!</b></u>"

		Buy_Makibishi_Shurikens()
			set hidden = 1
			var/mob/A = input(src, "This costs 50 Ryo & 2 Reputation! Are you sure?","25x Makibishi Spikes") as null | anything in list("No", "Yes")
			if(A == "Yes")
				if(Statistic.Ryo < 50)
					src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
					return
				if(Statistic.Reputation < 2)
					src<<"<font color=red><b><u>You don't have enough reputation!</b></u></font>"
					return
				Statistic.Reputation -= 2
				Scroll_Kunais += 7
				Shurikens += 25
				Statistic.Ryo -= 50
				Statistic.Ryo_Spent += 50
				src<<"<b><font color=red><b><u>Thank you! You've bought 50 Makibishi Spikes!</b></u></font>"
			if(A == "No")
				src<<"<font color=red><b><u>Okay, farewell!</b></u>"

		Buy_Chain_Kunais()
			set hidden = 1
			var/mob/A = input(src, "This costs 50 Ryo & 2 Reputation! Are you sure?","5x Chain Kunais") as null | anything in list("No", "Yes")
			if(A == "Yes")
				if(Statistic.Ryo < 50)
					src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
					return
				if(Statistic.Reputation < 2)
					src<<"<font color=red><b><u>You don't have enough reputation!</b></u></font>"
					return
				Kunais += 5
				Statistic.Reputation -= 2
				Statistic.Ryo -= 50
				Statistic.Ryo_Spent += 50
				src<<"<b><font color=red><b><u>Thank you! You've bought 25 Chain Kunais!</b></u></font>"
			if(A == "No")
				src<<"<font color=red><b><u>Okay, farewell!</b></u>"

		Buy_Ranked_Ninja_Usage()
			set hidden = 1
			if(Donator)
				winshow(src,"Shop", 0)
				src<<"<b><font color=red><u>You can already use Ranked Ninjas!</b></u></font>"
				return
			else

				var
					Price = 100
					Old_Price = Price
					Tax

				if(Statistic._Village_)
					Price *= 1+(Statistic._Village_.Tax/100)
					Tax = Price -Old_Price

				var/mob/A = input(src, "This costs [Price] Ryo! Are you sure?","1x Ranked Ninja Usage") as null | anything in list("No", "Yes")
				if(A == "Yes")
					if(Statistic.Ryo < Price)
						src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
						winshow(src,"Shop", 0)
						return
					if(Tax) Statistic._Village_.Ryo += Tax
					Statistic.Ryo_Spent += Price
					Trying_Donator = 1
					Donator = 1
					Statistic.Ryo -= Price
					src<<"<b><font color=red><b><u>Thank you! You can now use 1x Ranked Ninja!</b></u></font>"
					winshow(src,"Shop", 0)
				if(A == "No")
					src<<"<font color=red><b><u>Okay, farewell!</b></u>"

		Give_Ryo()
			set hidden = 1
			var/list/Players = list()
			for(var/mob/M) if(M.client && M != src) Players.Add(M)
			var/mob/M = input("Who do you want to give ryo?", "Give Ryo") as null | anything in Players
			if(!M) return
			var/Amount = input("How much ryo do you want to give [M.name]?", "Give Ryo") as num
			if(!Amount || !M || Amount < 1) return
			if(Amount > Statistic.Ryo)
				src<<"<b><font color=#40D3E9><i>You've don't have enough ryo!</b></i></font>"
				return
			Amount = round(Amount)
			if(alert(src, "Are you sure?\nGive [Amount] Ryo to [M]", "Give Ryo", "Yes", "No") == "Yes")
				if(!M || Amount < 1) return
				if(Amount > Statistic.Ryo)
					M<<"<b><font color=#40D3E9><i>You've don't have enough ryo!</b></i></font>"
					return
				src<<"<b><font color=#40D3E9><i>You have given [M] [Amount] Ryo!</b></i></font>"
				M<<"<b><font color=#40D3E9><i>[src] has given you [Amount] Ryo!</b></i></font>"
				Statistic.Ryo -= Amount
				Statistic.Ryo_Given += Amount
				M.Statistic.Ryo += Amount
				winset(src,"Shop.label12","text='Ryo: [Statistic.Ryo]'")


		Buy_S_Ranked_Ninja_Usage()
			set hidden = 1
			if(!CanChoose || NEM_Round.Mode != "Normal")
				src<<"<b><u><font color=red>You have to wait until the next round!</u>"
				return
			var
				Price

			Price = 500

			var
				Old_Price = Price
				Tax

			if(Statistic._Village_)
				Price *= 1+(Statistic._Village_.Tax/100)
				Tax = Price -Old_Price

			if(Statistic.Ryo < Price)
				src<<"<font color=red><b><u>You don't have enough ryo!</b></u></font>"
				winshow(src,"Shop", 0)
				return

			var/list/Customs = list()
			for(var/obj/Login_Screen/L) if(L.S_Ranked && L.Choosable && L.name != "Minato Namikaze" && L.name != "Torune" && L.name != "ANBU Kakashi" && L.name != "Lord Itachi" && L.name != "Kabuchimaru" && L.name != "Hanabi") Customs.Add(L)
			var/obj/Login_Screen/Custom = input(src, "Please, select the character you wish to use.","Buy 1x S-Ranked Ninja Usage") as null | anything in Customs
			if(Custom)
				var/mob/Q = input(src, "This costs [Price] Ryo! Are you sure?\n\nBuy [Custom]?","1x S-Ranked Ninja Usage") as null | anything in list("Yes", "No")
				if(Q == "Yes" && Custom.Choosable) Custom.Choose(src, Custom.S_Side, Price, Tax, null, 1)
				else src<<"<font color=red><b><u>Okay, farewell</u>"


mob/var/Page = 1
mob/var/Trying_Donator = 0

mob/verb
	Character_Image()
		set hidden = 1
		if(Character_Image)
			Character_Image_III.loc = locate(x-7, y+1, z)
			Character_Image_II.loc = locate(x-11, y+1, z)
			Character_Image_I.loc = locate(x-14, y+1, z)
			Character_Image.loc = locate(x-15, y+4, z)

	Switch_Side_Leaf()
		set hidden = 1
		if(CTD) return
		spawn()
			loc = locate(20,56,2)
			set_pos((x*32)+44, (y*32)+8)
			Character_Image()
			check_loc()
			Page = 1

	Switch_Side_Akatsuki()
		set hidden = 1
		if(CTD) return
		spawn()
			loc = locate(192, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Character_Image()
			check_loc()
			Page = 5


	Next_Page()
		set hidden = 1
		if(CTD || usr.CanChoose <= 0) return
		spawn() Character_Image()


		if(Page == 1)
			loc = locate(63, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 2
			return

		if(Page == 2)
			loc = locate(106, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 3
			return

		if(Page == 3)
			loc = locate(107, 14, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 3.5
			return

		if(Page == 3.5)
			if(!Donator)
				loc = locate(20, 56, 2)
				set_pos((x*32)+44, (y*32)+8)
				Page = 1
			if(Donator)
				loc = locate(149, 56, 2)
				set_pos((x*32)+44, (y*32)+8)
				Page = 4
			return

		if(Page == 4)
			loc = locate(20, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 1
			return

		if(Page == 5)
			loc = locate(236, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 6
			return

		if(Page == 6)
			loc = locate(284, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 7
			return

		if(Page == 7)
			loc = locate(332, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 8
			return

		if(Page == 8)
			if(!Donator)
				loc = locate(192, 56, 2)
				set_pos((x*32)+44, (y*32)+8)
				Page = 5
			if(Donator)
				loc = locate(380, 56, 2)
				set_pos((x*32)+44, (y*32)+8)
				Page = 9
			return

		if(Page == 9)
			loc = locate(192, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 5
			return


	Previous_Page()
		set hidden = 1
		if(CTD || usr.CanChoose <= 0) return
		spawn() Character_Image()


		if(Page == 1)
			if(!Donator)
				loc = locate(107, 14, 2)
				set_pos((x*32)+44, (y*32)+8)
				Page = 3.5
				return
			if(Donator)
				loc = locate(149, 56, 2)
				set_pos((x*32)+44, (y*32)+8)
				Page = 4
				return

		if(Page == 2)
			loc = locate(20, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 1
			return

		if(Page == 3)
			loc = locate(63, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 2
			return

		if(Page == 3.5)
			loc = locate(106, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 3
			return

		if(Page == 4)
			loc = locate(107, 14, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 3.5
			return

		if(Page == 5)
			if(!Donator)
				loc = locate(332, 56, 2)
				set_pos((x*32)+44, (y*32)+8)
				Page = 8
			if(Donator)
				loc = locate(380, 56, 2)
				set_pos((x*32)+44, (y*32)+8)
				Page = 9
			return

		if(Page == 6)
			loc = locate(192, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 5
			return

		if(Page == 7)
			loc = locate(236, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 6
			return

		if(Page == 8)
			loc = locate(284, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 7
			return

		if(Page == 9)
			loc = locate(332, 56, 2)
			set_pos((x*32)+44, (y*32)+8)
			Page = 8
			return

	Toggle_Music()
		set hidden = 1
		src << sound(null)
		if(Sound)
			var/sound/S = sound('Naruto Eternal Memories Song.ogg', 1, 0, 0, 85)
			src << S
			Sound = 0

		else Sound = 1

	Toggle_Effects()
		set hidden = 1
		if(SeeEffects)
			SeeEffects = 0
			see_invisible = 10

		else
			SeeEffects = 1
			see_invisible = 0


	Toggle_Votes()
		set hidden = 1
		if(Accept_Votes) Accept_Votes = 0
		else Accept_Votes = 1


	Toggle_Bets()
		set hidden = 1
		if(!Accept_Bets) src.Accept_Bets = 1
		else Accept_Bets = 0

	Text_Color()
		set hidden = 1
		var/C = input("Please, select the color.", "Text Color") as color
		Text_Color = C
		winset(src, "default.Avatar_Name", "text-color=[Text_Color]")

	Wall_Jump_Toggle_Key()
		set hidden = 1
		if(Wall_Key) Wall_Key = null
		else Wall_Key = 1