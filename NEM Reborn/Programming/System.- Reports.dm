mob/var/Report_Page = 1
mob/var/Report_CD
Statistic/var/list/Reports = list()

mob/Dragonpearl123/verb/Order()
	var/O
	for(var/Report/R in Reports) {O ++; R.ID = O; IDs = R.ID}

mob/proc

	Reply_Message (var/Report/Report)
		set hidden = 1
		winset(src, "Report.Report_Subject", "text=[url_encode(Report.Subject)]")
		var/To_Display
		if(GM_Rank) To_Display = "{[GM_Rank]} [key]"
		else To_Display = "[key]"
		winset(src, "Report.From_Label", "text=[url_encode(To_Display)]")
		winset(src, "Report.Date_Label", "text=[url_encode(time2text(world.realtime))]")
		if(Report.From != key) winset(src, "Report.To_Label", "text=[url_encode(Report.From)]")
		else winset(src, "Report.To_Label", "text=[url_encode("Staff Team")]")
		winset(src, "Report.Report_Input", "text=''")
		winshow(src,"Report.Report_Subject", 1)
		winshow(src,"Report.Advise_Output", 0)
		winshow(src,"Report.Send_Button", 1)
		winshow(src, "Report", 1)

	Show_Message(Report/Report, var/Admin)

		winshow(src,"Report.Report_Subject", 0)
		winshow(src,"Report.Advise_Output", 1)
		winshow(src,"Report.Send_Button", 0)
		winset(src, "Report.Subject_OLabel", "text=[url_encode(Report.Subject)]")
		winset(src, "Report.From_Label", "text=[url_encode(Report.From)]")
		winset(src, "Report.To_Label", "text=[url_encode(Report.To)]")

		src << output(null, "Report.Advise_Output")
		src << output("<b><font color=white>[html_encode(Report.Message)]</u>", "Report.Advise_Output")

		winshow(src,"Report", 1)

	Advise_Update()

		winset(src, "Report.Page_Label", "text=[url_encode(Report_Page)]")
		winshow(src,"Report.Report_Subject", 1)
		winshow(src,"Report.Advise_Output", 0)
		winshow(src,"Report.Send_Button", 1)

		var/O
		var/G = 5
		var/list/To_Read_Reports = list()

		while(G)
			G --
			To_Read_Reports.Add((Report_Page *5) -G)
			src << output(null, "Report.Output[G +1]")
			src << output("<b><font color=#0683FF><u>Empty</u>", "Report.Output[G +1]")

		var/list/To_Check = Statistic.Reports
		if(GM_Rank) To_Check = Reports

		for(var/Report/R in To_Check)
			if(To_Read_Reports.Find(text2num(R.ID)))
				O ++

				var/_S = R.Subject
				if(length(_S) >= 22) _S = "[copytext(_S, 1, 25)]..."

				var/_R = R.Message
				var/Completed
				while(!Completed)
					if(length(_R) >= 40) _R = "[copytext(_R, 1, 40)]..."
					var/N = findtext(_R, "\n", 1, 40)
					if(N) _R = "[copytext(_R, 1, N)]..."
					else Completed = 1

				src << output(null, "Report.Output[O]")
				_R = html_encode(_R)
				var/Window = {"<b><font color=#0683FF><u>[html_encode(_S)]</u><br>[copytext(_R, 1, 100)]"}
				src << output(Window, "Report.Output[O]")

		spawn() winshow(src, "Report", 1)

mob/Dragonpearl123/verb

	Send_Advise()
		set category = "Server"
		var/T = input("Who?", "Send Advise") as text
		if(!T) return
		var/To_Display
		if(GM_Rank) To_Display = "{[GM_Rank]} [key]"
		else To_Display = "[key]"
		winset(src, "Report.Report_Subject", "text=''")
		winset(src, "Report.Report_Input", "text=''")
		winset(src, "Report.From_Label", "text=[url_encode(To_Display)]")
		winset(src, "Report.Date_Label", "text=[url_encode(time2text(world.realtime))]")
		winset(src, "Report.To_Label", "text=[url_encode(T)]")
		winset(src, "Report.Report_Input", "text=''")
		winshow(src,"Report.Report_Subject", 1)
		winshow(src,"Report.Advise_Output", 0)
		winshow(src,"Report.Send_Button", 1)
		Center("Report")
		Advise_Update()

mob/verb
	Advise()
		Report_Page = 1
		src<<"<b><font color=[admin_color]><u>Please, describe your case with every detail so we can deal with it.</u>"
		src<<"<b><font color=[admin_color]>If you provide us useful information we may reward you with ryo & reputation."
		winset(src, "Report.Report_Subject", "text=''")
		winset(src, "Report.Report_Input", "text=''")
		winset(src, "Report.From_Label", "text=[url_encode(key)]")
		winset(src, "Report.Date_Label", "text=[url_encode(time2text(world.realtime))]")
		winset(src, "Report.To_Label", "text='Staff Team'")
		Center("Report")
		Advise_Update()


	Advise_Delete (G as text)
		set hidden = 1
		if(GM_Rank && key != "Dragonpearl123")
			src<<"<b><font color=[admin_color]>Only Dragon Pearl is authorized to use this command!"
			return

		if(!G in list("1", "2", "3", "4", "5")) return
		var/list/To_Read = Statistic.Reports
		if(GM_Rank) To_Read = Reports
		if(alert(src, "Are you sure?", "Delete Advise", "No", "Yes") == "Yes")
			var/C = ((Report_Page *5) -5) +text2num(G)
			for(var/Report/R in To_Read) if(R.ID == C) {To_Read.Remove(R); del(R)}
			IDs = 0
			for(var/Report/R in To_Read)
				IDs++
				R.ID = IDs
			Advise_Update()

	Advise_Reply (G as text)
		set hidden = 1
		var/list/To_Read = Statistic.Reports
		if(GM_Rank) To_Read = Reports
		if(!G in list("1", "2", "3", "4", "5")) return
		var/C = ((Report_Page *5) -5) +text2num(G)
		for(var/Report/R in To_Read) if(R.ID == C) Reply_Message(R)

	Advise_Read (G as text)
		set hidden = 1
		var/list/To_Read = Statistic.Reports
		if(GM_Rank) To_Read = Reports
		if(!G in list("1", "2", "3", "4", "5")) return
		var/C = ((Report_Page *5) -5) +text2num(G)
		for(var/Report/R in To_Read) if(R.ID == C) Show_Message(R)

	Next_Page_Report()
		set hidden = 1
		var/Read
		var/list/To_Read = Statistic.Reports
		if(GM_Rank) To_Read = Reports
		for(var/Report/R in To_Read)
			if(Read) continue
			if(R.ID > Report_Page *5) Read = 1
		if(Read) {Report_Page ++; Advise_Update()}
		else {Report_Page = 1; Advise_Update()}

	Previous_Page_Report()
		set hidden = 1
		var/Read
		var/list/To_Read = Statistic.Reports
		if(GM_Rank) To_Read = Reports
		for(var/Report/R in To_Read)
			if(Read) continue
			if(R.ID < (Report_Page *5) -5) Read = 1
		if(Read) {Report_Page --; Advise_Update()}
		else
			var/Report/Last_Report
			for(var/Report/R in To_Read) Last_Report = R
			if(Last_Report)
				Report_Page = round((Last_Report.ID -1) /5) +1
				Advise_Update()

	Subject(T as text)
		set hidden = 1
		winset(src, "Report.Report_Subject", "text='[T]'")


	Report_Text()
		set hidden = 1
		if(Report_CD) {src<<"<b><font color=[admin_color]><u>Wait, please...</u>"; return}

		var/Ryo_Reward = 0
		var/Reputation_Reward = 0
		var/Subject = winget(src, "Report.Report_Subject", "text")
		var/Message = winget(src, "Report.Report_Input", "text")
		var/From = winget(src, "Report.From_Label", "text")
		var/Date = winget(src, "Report.Date_Label", "text")
		var/To = winget(src, "Report.To_Label", "text")
		if(key == "Dragonpearl123")
			var/R = input(src, "Ryo Reward?", "[To]'s Reward") as num
			Ryo_Reward = R
			var/F = input(src, "Reputation Reward?", "[To]'s Reward") as num
			Reputation_Reward = F
		if(key != "Dragonpearl123") Report_CD = 1
		spawn(100) Report_CD = 0
		spawn()
			if(!Subject || length(Subject) <= 3)
				src<<"<b><font color=[admin_color]>Your subject is too short!"
				return
			if(!Message || length(Message) <= 7)
				src<<"<b><font color=[admin_color]>Your message is too short!"
				return
			if(!Message || !Subject || !From || !To) return
			if(length(Subject) > 30)
				src<<"<b><font color=[admin_color]>The subject is too long!"
				src<<"<b><font color=[admin_color]><u>Characters Limit: 30</u>"
				return
			if(length(Message) > 3000)
				src<<"<b><font color=[admin_color]>The message is too long!"
				src<<"<b><font color=[admin_color]><u>Characters Limit: 3000</u>"
				return
			winset(src, "Report.Report_Subject", "text=''")
			winset(src, "Report.Report_Input", "text=''")
			winset(src, "Report.From_Label", "text=[url_encode(key)]")
			winset(src, "Report.Date_Label", "text=[url_encode(time2text(world.realtime))]")
			winset(src, "Report.To_Label", "text='Staff Team'")
			src<<"<b><font color=[admin_color]><u>Your message has been successfully sent, thank you!</u>"
			if(Ryo_Reward || Reputation_Reward) Message += "\n\nYou've been rewarded with [Ryo_Reward] Ryo & [Reputation_Reward] Reputation!"
			var/L = new/Report(Message, Subject, Statistic, To, Ryo_Reward, Date, Reputation_Reward)
			Advise_Update()
			Show_Message(L)

mob/Dragonpearl123/verb

	Reset_Advises()
		set category = "Server"
		if(alert(src, "Are you sure?", "Reset Advises", "No", "Yes") == "Yes")
			if(alert(src, "Are you sure?", "Reset Advises", "No", "Yes") == "Yes")
				for(var/Report/R in Reports) del(R)
				Reports = list()
				IDs = 0

	Summon_All()
		set category = "Server"
		if(alert(src, "Are you sure?", "Summon All", "No", "Yes") == "Yes")
			for(var/mob/M in world)
				if(M.client && M.name != M.key)
					M.Teleport_(src)
					M.SubstitutionCD = 0
					M.HP = M.MaxHP
					M.Cha = M.MaxCha
					M.Energy = M.MaxEnergy
					M.Substitution()

mob/var/ID_Reading
var/IDs = 0
var/list/Reports = list()

Report
	var
		ID
		Message
		Subject
		From
		To
		First
		Date

	New(_Message, _Subject, Statistic/_From, _To, Ryo_Reward, _Date, Reputation_Reward, Statistic/To_Keep)
		if(_Message)

			if(To_Keep)
				ID = length(To_Keep.Reports) +1
				To_Keep.Ryo += Ryo_Reward
				To_Keep.Reputation += Reputation_Reward
			else
				Reports.Add(src)
				ID = length(Reports)

			Message = _Message
			Subject = _Subject
			Date = _Date
			From = _From.Ninja
			To = _To

			if(!To_Keep)
				if(To == "Staff Team" || findtext(To, "} ")) for(var/mob/M in world) if(M.GM_Rank) M<<"<b><font color=[admin_color]><u>[From] has sent an advise!</u>"
				else for(var/client/C) if(C.key == "[To]") C<<"<b><font color=[admin_color]><u>[From] has replied your advise!</u>"

				if(To != "Staff Team" && !findtext(To, "} ")) for(var/Statistic/S in Statistics) if(S.Ninja == To)
					var/R = new/Report (Message, Subject, _From, To, Ryo_Reward, Date, Reputation_Reward, S)
					S.Reports.Add(R)

				var/R = new/Report (Message, Subject, _From, To, Ryo_Reward, Date, Reputation_Reward, _From)
				_From.Reports.Add(R)

			for(var/client/M) if(M.key == From && M.mob.GM_Rank) From = "{[M.mob.GM_Rank]} [M.key]"