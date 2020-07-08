var/list/On_Going_Polls = list()

Poll
	var
		Question
		Option_1
		Option_2
		Option_3
		Option_4
		Option_5
		Option_6
		Option_7
		Statistic/Creator
		list/Voted_Options = list()
		list/Voted = list()
		list/CTD_L = list()
		list/CTD_A = list()

	New(Q, O1, O2, O3, O4, O5, O6, O7, _C, list/_CTD_L, list/_CTD_A)
		..()
		Question = Q
		Option_1 = O1
		Option_2 = O2
		Option_3 = O3
		Option_4 = O4
		Option_5 = O5
		Option_6 = O6
		Option_7 = O7
		Creator = _C

		if(On_Going_Polls.Find(Q) || !Creator)
			del(src)
			return
		On_Going_Polls.Add(Q)

		if(Creator) for(var/mob/P in world) if(P.client && P.key == Creator.Ninja) if(!P.GM_Rank)

			if(length(CTD_L) && length(CTD_A) && CTD_Next)
				for(var/mob/M in world) if(Creator.Ninja == M.key) M<<"<font color=[admin_color]><b><u>There's already a Custom Team Deathmatch planned for the next round!"
				del(src)
				return

			if(Creator.Poll_Timer)
				var/_V_ = Creator.Poll_Timer -world.realtime
				if(_V_ < 300 || !Creator.Poll_Timer) Creator.Poll_Timer = null
				else
					_V_ /= 600
					for(var/mob/M in world) if(Creator.Ninja == M.key) M<<"<font color=[admin_color]><b><u>You must wait [round(_V_)] minute(s) before doing this."
					del(src)
					return

			if(_Timer_)
				var/_V_ = _Timer_ -world.realtime
				if(_V_ < 300 || !_Timer_) _Timer_ = null
				else
					_V_ /= 600
					for(var/mob/M in world) if(Creator.Ninja == M.key) M<<"<font color=[admin_color]><b><u>You must wait [round(_V_)] minute(s) before doing this."
					del(src)
					return

			if(length(CTD_L) && length(CTD_A) && _CTD_Timer_)
				var/_V_ = _CTD_Timer_ -world.realtime
				if(_V_ < 300 || !_CTD_Timer_) _CTD_Timer_ = null
				else
					_V_ /= 600
					for(var/mob/M in world) if(Creator.Ninja == M.key) M<<"<font color=[admin_color]><b><u>You must wait [round(_V_)] minute(s) before doing this."
					del(src)
					return

			if(Q == "Would you like to enable clones?" || Q == "Would you like to disable clones?")
				var/_V_ = _TC_Timer_ -world.realtime
				if(_V_ < 300 || !_TC_Timer_)
					_TC_Timer_ = null
					_TC_Timer_ = world.realtime +18000
				else
					_V_ /= 600
					for(var/mob/M in world) if(Creator.Ninja == M.key) M<<"<font color=[admin_color]><b><u>You must wait [round(_V_)] minute(s) before doing this."
					del(src)
					return


			if(Q == "Would you like to reboot?")
				var/_V_ = _Reboot_Poll_ -world.realtime
				if(_V_ < 300 || !_Reboot_Poll_) _Reboot_Poll_ = null
				else
					_V_ /= 600
					for(var/mob/M in world) if(Creator.Ninja == M.key) M<<"<font color=[admin_color]><b><u>You must wait [round(_V_)] minute(s) before doing this."
					del(src)
					return
			_Timer_ = world.realtime +4500
			Creator.Poll_Timer = world.realtime +18000
			CTD_L = _CTD_L
			CTD_A = _CTD_A

		Ask()


	proc
		Ask()
			..()

			for(var/mob/M)
				M<<""
				M<<"<font size=2><b><u><font color=#D70000>[Creator.Ninja] has created a Poll!<br><font color=#B00000>* Poll Question: [Question]</u></font><br>"
				M<<"<b><font color=#D73D3D><a href='?src=\ref[src];action=Vote Poll;Option=\ref[Option_1]&&Poll=\ref[src]'>Vote!</a> - [Option_1]"
				M<<"<b><font color=#D73D3D><a href='?src=\ref[src];action=Vote Poll;Option=\ref[Option_2]&&Poll=\ref[src]'>Vote!</a> - [Option_2]"
				if(Option_3) M<<"<b><font color=#D73D3D><a href='?src=\ref[src];action=Vote Poll;Option=\ref[Option_3]&&Poll=\ref[src]'>Vote!</a> - [Option_3]"
				if(Option_4) M<<"<b><font color=#D73D3D><a href='?src=\ref[src];action=Vote Poll;Option=\ref[Option_4]&&Poll=\ref[src]'>Vote!</a> - [Option_4]"
				if(Option_5) M<<"<b><font color=#D73D3D><a href='?src=\ref[src];action=Vote Poll;Option=\ref[Option_5]&&Poll=\ref[src]'>Vote!</a> - [Option_5]"
				if(Option_6) M<<"<b><font color=#D73D3D><a href='?src=\ref[src];action=Vote Poll;Option=\ref[Option_6]&&Poll=\ref[src]'>Vote!</a> - [Option_6]"
				if(Option_7) M<<"<b><font color=#D73D3D><a href='?src=\ref[src];action=Vote Poll;Option=\ref[Option_7]&&Poll=\ref[src]'>Vote!</a> - [Option_7]"
				M<<""

			spawn(300)
				On_Going_Polls.Remove("[src.Question]")

				var
					O1_Votes = 0
					O2_Votes = 0
					O3_Votes = 0
					O4_Votes = 0
					O5_Votes = 0
					O6_Votes = 0
					O7_Votes = 0

				for(var/O in Voted_Options)
					if(O == Option_1) O1_Votes ++
					if(O == Option_2) O2_Votes ++
					if(O == Option_3) O3_Votes ++
					if(O == Option_4) O4_Votes ++
					if(O == Option_5) O5_Votes ++
					if(O == Option_6) O6_Votes ++
					if(O == Option_7) O7_Votes ++

				for(var/mob/M)
					M<<""
					M<<"<font color=#8F0000><font size=3><b><u>Poll Has Concluded!</u></font>"
					M<<"<font color=#B00000><font size=2><b><u>* Poll Question: [Question]</u></font><br>"
					M<<"<font color=#D73D3D><b><u>* [O1_Votes] Votes</u>- [Option_1]"
					M<<"<font color=#D73D3D><b><u>* [O2_Votes] Votes</u>- [Option_2]"
					if(Option_3) M<<"<font color=#D73D3D><b><u>* [O3_Votes] Votes</u>- [Option_3]"
					if(Option_4) M<<"<font color=#D73D3D><b><u>* [O4_Votes] Votes</u>- [Option_4]"
					if(Option_5) M<<"<font color=#D73D3D><b><u>* [O5_Votes] Votes</u>- [Option_5]"
					if(Option_6) M<<"<font color=#D73D3D><b><u>* [O6_Votes] Votes</u>- [Option_6]"
					if(Option_7) M<<"<font color=#D73D3D><b><u>* [O7_Votes] Votes</u>- [Option_7]"
					M<<""

				if(O1_Votes || O2_Votes)

					if(length(CTD_L) && length(CTD_A))
						var/_V_ = (O1_Votes /(O1_Votes+O2_Votes))*100
						if(_V_ >= 75)
							Next_Mode = "CTD"
							CTD_Leaf_Ninjas = CTD_L
							CTD_Akatsuki_Ninjas = CTD_A
							CTD_Next = 1
							world<<"<b><font color=[admin_color]><u><center><font size=3>* A Custom Team Deathmatch will be hosted on next round! *</u>"
							var/L_Text
							var/A_Text
							for(var/obj/Login_Screen/L in CTD_Leaf_Ninjas)
								if(!L_Text) L_Text += L.name
								else L_Text += " & [L.name]"
							for(var/obj/Login_Screen/L in CTD_Akatsuki_Ninjas)
								if(!A_Text) A_Text += L.name
								else A_Text += " & [L.name]"
							world<<"<b><font size=2><center><font color=#4EFF81>[L_Text] <font color=#A92323>Vs<font color=#8904B1> [A_Text]\n</center>"
							_CTD_Timer_ = world.realtime +36000
							Creator.CTD_Timer = world.realtime +72000
						else
							world<<output("<b><font color=[admin_color]><font size=3><u>75% Players must agree, rejected!</u></font>", "Chat")
							world<<output("<b><font color=[admin_color]><font size=3><u>[Creator.Ninja] can no longer create a Poll for Custom Team Deathmatch for 2 hours!</u></font>", "Chat")
							Creator.CTD_Timer = world.realtime +72000
							_CTD_Timer_ = world.realtime +9000

					if(Question == "Would you like to reboot?")
						var/_V_ = (O1_Votes /(O1_Votes+O2_Votes))*100
						if(_V_ >= 75)
							world<<output("<b><font color=[admin_color]><font size=3><u>Rebooting!</u></font>", "Chat")
							Clones = 1
							fdel("Scoreboard.sav")
							for(var/mob/C)
								if(C.client)
									C.SaveScores()
									Ranking(C)
							for(var/mob/C) RankingDisplay(C)
							Check_Winner_Score()
							Auto_Balancer = 1
							world.Reboot()
						else
							world<<output("<b><font color=[admin_color]><font size=3><u>75% Players must agree, not rebooting!</u></font>", "Chat")
							world<<output("<b><font color=[admin_color]><font size=3><u>[Creator.Ninja] can no longer create a Poll for Reboot for 3 hours!</u></font>", "Chat")
							Creator.Reboot_Poll = world.realtime +108000
							_Reboot_Poll_ = world.realtime +18000

					if(O1_Votes > O2_Votes)

						if(Question == "Would you like to play on Underground Stage next?")
							world<<output("<b><font color=[admin_color]><u><font size=3>Next Stage: Underground!</u></font>", "Chat")
							NextSpawn = 1

						else if(Question == "Would you like to play on Jungle Stage next?")
							world<<output("<b><font color=[admin_color]><u><font size=3>Next Stage: Jungle!</u></font>", "Chat")
							NextSpawn = 2

						else if(Question == "Would you like to play on Sand Village Stage next?")
							world<<output("<b><font color=[admin_color]><u><font size=3>Next Stage: Sand Village!</u></font>", "Chat")
							NextSpawn = 3

						else if(Question == "Would you like to play on Leaf Village Stage next?")
							world<<output("<b><font color=[admin_color]><u><font size=3>Next Stage: Leaf Village!</u></font>", "Chat")
							NextSpawn = 4

						else if(Question == "Would you like to enable clones?")
							world<<output("<b><font color=[admin_color]><u>Clones have been enabled!</u></font>", "Chat")
							Clones = 1

						else if(Question == "Would you like to disable clones?")
							world<<output("<b><font color=[admin_color]><u>Clones have been disabled!</u></font>", "Chat")
							Clones = 0

				spawn() del(src)