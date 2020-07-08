var/MCKN = "Nobody"
var/MCKNV = 0
Statistic/var/TV = 0
Statistic/var/TD = 0
Statistic/var/MC_Victories = 0
Statistic/var/C_Victories = 0
Statistic/var/Reputation_Rank
Statistic/var/Wasted_Cloak
Statistic/var/Total_Reputation = 10
var/list/Auctions = list()

Statistic/proc
	Reputation_Rank()
		if(Wasted_Cloak) Reputation_Rank = "Random Ninja"
		else if(Reputation >= 5 && Reputation < 8) Reputation_Rank = "Weak Slave"
		else if(Reputation >= 8 && Reputation < 12) Reputation_Rank = "Average Slave"
		else if(Reputation >= 12 && Reputation < 15) Reputation_Rank = "Strong Slave"
		else if(Reputation >= 15 && Reputation < 20) Reputation_Rank = "Weak Peasant"
		else if(Reputation >= 20 && Reputation < 25) Reputation_Rank = "Average Peasant"
		else if(Reputation >= 25 && Reputation < 30) Reputation_Rank = "Strong Peasant"
		else if(Reputation >= 30 && Reputation < 35) Reputation_Rank = "Weak Fighter"
		else if(Reputation >= 35 && Reputation < 40) Reputation_Rank = "Average Fighter"
		else if(Reputation >= 40 && Reputation < 45) Reputation_Rank = "Strong Fighter"
		else if(Reputation >= 45 && Reputation < 50) Reputation_Rank = "Weak Warrior"
		else if(Reputation >= 50 && Reputation < 55) Reputation_Rank = "Average Warrior"
		else if(Reputation >= 55 && Reputation < 60) Reputation_Rank = "Strong Warrior"
		else if(Reputation >= 60 && Reputation < 65) Reputation_Rank = "Weak Barbarian"
		else if(Reputation >= 65 && Reputation < 70) Reputation_Rank = "Average Barbarian"
		else if(Reputation >= 70 && Reputation < 75) Reputation_Rank = "Strong Barbarian"
		else if(Reputation >= 75 && Reputation < 80) Reputation_Rank = "Weak Knight"
		else if(Reputation >= 80 && Reputation < 85) Reputation_Rank = "Average Knight"
		else if(Reputation >= 85 && Reputation < 90) Reputation_Rank = "Strong Knight"
		else if(Reputation >= 90 && Reputation < 95) Reputation_Rank = "Weak Gladiator"
		else if(Reputation >= 95 && Reputation < 100) Reputation_Rank = "Average Gladiator"
		else if(Reputation >= 100 && Reputation < 105) Reputation_Rank = "Strong Gladiator"
		else if(Reputation >= 105 && Reputation < 115) Reputation_Rank = "Weak Champion"
		else if(Reputation >= 115 && Reputation < 130) Reputation_Rank = "Average Champion"
		else if(Reputation >= 130 && Reputation) Reputation_Rank = "Strong Champion"

Auction
	var
		Statistic/Creator
		Reputation
		Statistic/Bid_Creator
		Highest_Bid
		Time

	New(var/S, var/R)
		..()

		if(S && R)
			Time = world.realtime +54000
			Creator = S
			Reputation = R
			Highest_Bid = 10 *(R)
			Auctions.Add(src)
		Time()

	proc
		Time()
			..()

			loop
				if(world.realtime >= Time) End()
				spawn(600) goto loop

		End()
			if(!Bid_Creator || !istype(Bid_Creator, /Statistic))
				world<<"<b><font color=#A80000><font size=3><u>Auctions~ [Creator.Ninja]'s [Reputation] reputation auction has been cancelled!</u>"
				for(var/Statistic/S in Statistics) if(S.Ninja == Creator.Ninja) Creator = S
				Creator.Total_Reputation += Reputation
				Creator.Reputation += Reputation
				Creator.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Failed to auction [Reputation] reputation! *"
			else
				world<<"<b><font color=#A80000><font size=3><u>Auctions~ [Creator.Ninja]'s [Reputation] reputation auction has been claimed by [Bid_Creator.Ninja] for [Highest_Bid] ryo!</u>"
				for(var/Statistic/S in Statistics)
					if(S.Ninja == Creator.Ninja) Creator = S
					if(S.Ninja == Bid_Creator.Ninja) Bid_Creator = S
				Creator.Ryo += Highest_Bid
				Creator.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Claimed [Highest_Bid] ryo from [Bid_Creator.Ninja] for [Reputation] reputation! *"
				Bid_Creator.Log += "<br><font color=#FFFAC0>[time2text(world.timeofday, "DD/MM/YYYY -hh:mm:ss")]<font color=white>- * Claimed [Reputation] reputation from [Creator.Ninja] for [Highest_Bid] ryo! *"
				Bid_Creator.Total_Reputation += Reputation
				Bid_Creator.Reputation += Reputation
			Auctions.Remove(src)
			del(src)

		Buy(mob/Ninja)
			if(Creator.Ninja == usr.key) {usr<<"<b><font color=red><u>You can't bid for your own auction!</u>"; return}
			var/Ryo = input(usr, "How much ryo would you like to bid?\n\nReputation Auctioned: [Reputation]\nCurrent Bid: [Highest_Bid]", "Bid Now") as num
			Ryo = round(Ryo, 0.05)
			if(Bid_Creator) if(Highest_Bid+10 > Ryo) {usr<<"<b><font color=red><u>Your bid must be at least [Highest_Bid+10] ryo!</u>"; return}
			else if(Highest_Bid > Ryo) {usr<<"<b><font color=red><u>Your bid must be at least [Highest_Bid] ryo!</u>"; return}
			if(usr.Statistic.Ryo < Ryo) {usr<<"<b><font color=red><u>You don't have enough ryo!</u>"; return}
			if(alert(usr, "Are you sure?\n\nBidding [Ryo] Ryo for [Reputation] Reputation!", "Bid now", "Yes", "No") == "Yes") if(alert(usr, "Really?\n\nBidding [Ryo] Ryo for [Reputation] Reputation!", "Bid now", "No", "Yes") == "Yes")
				if(Bid_Creator) if(Highest_Bid+10 > Ryo) {usr<<"<b><font color=red><u>Your bid must be at least [Highest_Bid+10] ryo!</u>"; return}
				else if(Highest_Bid > Ryo) {usr<<"<b><font color=red><u>Your bid must be at least [Highest_Bid] ryo!</u>"; return}

				if(usr.Statistic.Ryo < Ryo) {usr<<"<b><font color=red><u>You don't have enough ryo!</u>"; return}
				if(Bid_Creator)
					for(var/Statistic/S in Statistics) if(S.Ninja == Bid_Creator.Ninja) Bid_Creator = S
					Bid_Creator.Ryo += Highest_Bid
					for(var/mob/M in world) if(M.client && M.key == Bid_Creator.Ninja) M<<"<b><font color=#A80000><font size=3><u>Auctions~ [usr.key] has outbid you with [Ryo] ryo in [Creator.Ninja]'s [Reputation] reputation auction!</u>"
					usr<<"<b><font color=#A80000><font size=3><u>Auctions~ You have outbid [Bid_Creator.Ninja] with [Ryo] ryo in [Creator.Ninja]'s [Reputation] reputation auction!</u>"
				else usr<<"<b><font color=#A80000><font size=3><u>Auctions~ You have bid [Ryo] ryo in [Creator.Ninja]'s [Reputation] reputation auction!</u>"
				for(var/mob/M in world) if(M.client && M.key == Creator.Ninja) M<<"<b><font color=#A80000><font size=3><u>Auctions~ [usr.key] has bid [Ryo] ryo in your [Reputation] reputation auction!</u>"
				Bid_Creator = usr.Statistic
				Bid_Creator.Ryo -= Ryo
				Highest_Bid = Ryo
			//	Colosseum_D.Black_Market(usr)