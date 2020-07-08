var/Lucky_Number/Lucky_Number

Statistic/var/
	_Lucky_Number_
	_Lucky_Number_Spent_

mob/verb/Lucky_Number() Lucky_Number.Check(src)

mob/Dragonpearl123/verb/Finish_Luck() if(alert(src, "Are you sure?", "Finish Lucky Number?", "No", "Yes") == "Yes") Lucky_Number._Time_ = world.realtime

Lucky_Number
	var
		list/Previous_Winners = list()
		list/_Statistics_ = list()
		list/Playing = list("None")
		list/_CIs_ = list()
		Tickets = 25
		Ticket = 1
		Base = 50
		Open = 1
		_Time_
		Rised

	New(var/T)
		..()

		if(T) _Time_ = (world.realtime +144000) - (text2num(time2text(world.timeofday, "mm")) *600)
		Lucky_Time()

	proc
		Lucky_Time()
			..()

			loop
				if(world.realtime >= _Time_) Reward()
				spawn(600) goto loop

		Refund() for(var/Statistic/S in Statistics) if(Playing.Find(S.Ninja)) S.Ryo += S._Lucky_Number_Spent_

		Check(mob/Ninja, Content)
			var/Prize_I = round(length(Playing) *80, 0.25)
			var/_Time_Remaining_ = (_Time_ - world.realtime) /600
			var/T_Hours = round(_Time_Remaining_ /60)
			var/_Text_
			_Time_Remaining_ -= T_Hours *60
			if(T_Hours == -1) {T_Hours = 0; _Time_Remaining_ = 1}
			if(!Content && Playing.Find(Ninja.key)) _Text_ = "<font color=#D7FFE1><font size=3>You own Ticket #[Ninja.Statistic._Lucky_Number_]!"
			else if(!Content)
				if(Tickets == 0) _Text_ = "<font color=#D7FFE1><font size=3>There are no tickets left."
				else _Text_ = "<font color=#D7FFE1><font size=3><a href='?src=\ref[Ninja];action=Buy Lucky Number'>Buy one!</a>"
			else if(Content == 1)
				if(Tickets == 0) _Text_ = "<font color=#D7FFE1><font size=3>There are no tickets left."
				else _Text_ = "<font color=#D7FFE1><font size=3>Buy Ticket #[Ticket] for [Base+Rised] Ryo? - <a href='?src=\ref[Ninja]&&Price=[Base+Rised];action=Yes Buy Lucky Number'>Yes</a> <a href='?src=\ref[Ninja];action=No Buy Lucky Number'>No</a> -"
			else _Text_ = "<font color=#D7FFE1><font size=3>[Content]"

			var/Window = {"<html><body><font color=white><style = \"text/css\">body { background-color:#76C98B} #main p{text-align:right}</style></body></html><b>
<font color=#92FDAB><u><font size=6><center>* Lucky Number *<br></u>
<font color=#A4FFB9><font size=5>[T_Hours] Hour(s) & [round(_Time_Remaining_)] Minute(s)</center><br>"}
			if(length(_Statistics_) >= 5) Window += "<font color=#CBFFD8><font size=3>- 1st Prize: [round(Prize_I, 25)] & 5 Reputation<br>"
			else Window += "<font color=#CBFFD8><font size=3>- 1st Prize: [round(Prize_I, 25)] & 5 Reputation <i>{Requires [5-length(_Statistics_)] more tickets to be sold}</i><br>"
			if(length(_Statistics_) >= 10) Window += "<font color=#CBFFD8><font size=3>- 2nd Prize: [round(Prize_I *0.5, 0.25)] & 3 Reputation<br>"
			else Window += "<font color=#CBFFD8><font size=3>- 2nd Prize: [round(Prize_I *0.5, 0.25)] & 3 Reputation <i>{Requires [10-length(_Statistics_)] more tickets to be sold}</i><br>"
			if(length(_Statistics_) >= 15) Window += "<font color=#CBFFD8><font size=3>- 3rd Prize: [round(Prize_I *0.25, 0.25)] & 2 Reputation<br>"
			else Window += "<font color=#CBFFD8><font size=3>- 3rd Prize: [round(Prize_I *0.25, 0.25)] & 2 Reputation <i>{Requires [15-length(_Statistics_)] more tickets to be sold}</i><br>"
			Window += {"<br><div id="main"><div style="float:right"><a href='?src=\ref[Ninja];action=Previous Winners'>Previous Winners</a></div>\n* <font color=#D7FFE1><font size=4><u>Tickets Left: [Tickets]</u><div id="main"><div style="float:right"><a href='?src=\ref[Ninja];action=Check Who Plays'><font size=3>Check who's playing</a></div>[_Text_]"}

			Ninja << output(null, "Lucky Number.Lucky Number")
			Ninja << output(Window, "Lucky Number.Lucky Number")
			Ninja.Center("Lucky Number")

		Previous_Winners(mob/Ninja)
			var/_Time_Remaining_ = (_Time_ - world.realtime) /600
			var/T_Hours = round(_Time_Remaining_ /60)
			var/P = 1
			_Time_Remaining_ -= T_Hours *60
			if(T_Hours == -1) {T_Hours = 0; _Time_Remaining_ = 1}
			var/Window = {"<html><body><font color=white><style = \"text/css\">body { scrollbar-DarkShadow-Color:#5FC877;scrollbar-Shadow-Color:#65D17E;scrollbar-base-color:#76F093;scrollbar-arrow-color:#B2FAC3;background-color:#76C98B} </style></body></html><b>
<font color=#92FDAB><u><font size=6><center>* Lucky Number *<br></u>
<font color=#A4FFB9><font size=5>[T_Hours] Hour(s) & [round(_Time_Remaining_)] Minute(s)</center><br>"}
			Window += "<center><table border=1><tr><th><html><body><center><font color=#CBFFD8><TABLE CELLSPACING=10><tr><th><u><center><font color=#CBFFD8><font size=5>Prize</center></u></th><th><font color=#CBFFD8><u><center><font size=5>Player</center></u></th></th></tr>\n"
			for(var/S in Previous_Winners)
				Window += "<tr><td><b><font color=#CBFFD8><font size=3><b><center>[(P)]\th</td><td><font color=#CBFFD8><b>[(S)]</td></tr>\n"
				P++
			Ninja << output(Window, "Lucky Number.Lucky Number")

		Who_Plays(mob/Ninja)
			var/_Time_Remaining_ = (_Time_ - world.realtime) /600
			var/T_Hours = round(_Time_Remaining_ /60)
			_Time_Remaining_ -= T_Hours *60
			if(T_Hours == -1) {T_Hours = 0; _Time_Remaining_ = 1}
			var/Window = {"<html><body><font color=white><style = \"text/css\">body { scrollbar-DarkShadow-Color:#5FC877;scrollbar-Shadow-Color:#65D17E;scrollbar-base-color:#76F093;scrollbar-arrow-color:#B2FAC3;background-color:#76C98B} </style></body></html><b>
<font color=#92FDAB><u><font size=6><center>* Lucky Number *<br></u>
<font color=#A4FFB9><font size=5>[T_Hours] Hour(s) & [round(_Time_Remaining_)] Minute(s)</center><br>"}
			Window += "<center><table border=1><tr><th><html><body><center><font color=#CBFFD8><TABLE CELLSPACING=10><tr><th><u><center><font color=#CBFFD8><font size=5>Ticket</center></u></th><th><font color=#CBFFD8><u><center><font size=5>Player</center></u></th></th></tr>\n"
			for(var/Statistic/S in _Statistics_) Window += "<tr><td><b><font color=#CBFFD8><font size=3><b><center>#[S._Lucky_Number_]</td><td><font color=#CBFFD8><b><center>[(S.Ninja)]</td></tr>\n"
			Ninja << output(Window, "Lucky Number.Lucky Number")

		Buy_Ticket(mob/Benefactor, Statistic/Benefactor_, var/Price)
			if(Price != Base+Rised) Check(Benefactor, "This ticket was already sold!")
			else
				if(Benefactor_.Ryo < Price) Check(Benefactor, "You don't have enough ryo to afford for it!")
				else
					Tickets --
					Playing.Remove("None")
					if(_CIs_.Find(Benefactor.client.computer_id))
						Benefactor<<"<b><u><font color=red>You can not buy a Lottery Ticket with an alt!</font></u></b>"
						return
					_CIs_.Add(Benefactor.client.computer_id)
					Playing.Add(Benefactor_.Ninja)
					_Statistics_.Add(Benefactor_)
					Benefactor_.Ryo -= Price
					Benefactor_._Lucky_Number_ = Ticket
					Benefactor_._Lucky_Number_Spent_ = Price
					Check(Benefactor, "You've successfully bought Ticket #[Ticket] for [Price] Ryo!")
					Ticket ++
					Rised += 3

		Restart()
			_Time_ = (world.realtime +144000) - (text2num(time2text(world.timeofday, "mm")) *600)
			_CIs_ = list()
			_Statistics_ = list()
			Playing = list("None")
			Tickets = 25
			Ticket = 1
			Rised = 0
			Open = 1

		Reward()
			var
				Winner = pick(Playing)
				Prize_I = round(length(Playing) *80, 25)
				Prize_II = round(Prize_I *0.50, 0.25)
				Prize_III = round(Prize_I *0.25, 0.25)

			if(length(Playing) >= 5)
				Previous_Winners = list()
				Previous_Winners.Add("[Winner] - [Prize_I] Ryo")
				for(var/Statistic/S in Statistics)
					if(S.Ninja == Winner)
						world<<"<b><font color=#8EFFAD><u><font size=3>[Winner] got 1st Prize {[Prize_I] Ryo & 5 Reputation} in the Lucky Number! His number was [S._Lucky_Number_].</u>"
						S.Ryo += Prize_I
						S.Reputation += 5

				if(length(Playing) >= 10)
					Playing.Remove(Winner)
					var/Second = pick(Playing)
					Previous_Winners.Add("[Second] - [Prize_II] Ryo")
					for(var/Statistic/S in Statistics) if(S.Ninja == Second)
						world<<"<b><font color=#8EFFAD><u><font size=2>[Second] got 2nd Prize {[Prize_II] Ryo & 3 Reputation} in the Lucky Number! His number was [S._Lucky_Number_].</u>"
						S.Ryo += Prize_II
						S.Reputation += 3

					if(length(Playing) >= 14)
						Playing.Remove(Second)
						var/Third = pick(Playing)
						Previous_Winners.Add("[Third] - [Prize_III] Ryo")
						for(var/Statistic/S in Statistics) if(S.Ninja == Third)
							S.Ryo += Prize_III
							S.Reputation += 2
							world<<"<b><font color=#8EFFAD><u><font size=2>[Third] got 3rd Prize {[Prize_III] Ryo & 2 Reputation} in the Lucky Number! His number was [S._Lucky_Number_].</u>"

				for(var/Statistic/S in Statistics)
					S._Lucky_Number_ = null
					S._Lucky_Number_Spent_ = null

				Restart()

			else
				world<<"<b><font color=#8EFFAD><u><font size=3>Not enough tickets were sold on the Lucky Number, restarting!</u>"
				Refund()
				Restart()