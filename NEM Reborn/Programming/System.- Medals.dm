mob/var/Achievements = 0
mob/var/New_ = 1
mob/var/list/Mastery = list()

mob/proc
	Ryo_Reward(var/N)
		if(!client) return
		Statistic.Ryo += round(N, 0.05)
		src<<"<b><font color=#40D3E9><i>You've been rewarded with [round(N, 0.05)] Ryo!</b></i></font>"
		src.Update_Scores()

	Rep_Reward(var/N)
		if(!client) return
		Statistic.Reputation += round(N, 0.05)
		src<<"<b><font color=#40D3E9><i>You've been rewarded with [round(N, 0.05)] Reputation!</b></i></font>"
		src.Update_Scores()

	Check_Ryo()
		spawn()
			if(!findtext(src.key, "Guest-"))
				var/Scores = world.GetScores(key)
				if(Scores)
					var/list/params = params2list(Scores)
					if(params["Ryo"]) Statistic.Ryo = text2num(params["Ryo"])
					if(params["Rounds Played"]) Statistic.Rounds_Played = text2num(params["Rounds Played"])
					if(params["Ninjas Killed"]) Statistic.Kills = text2num(params["Ninjas Killed"])
					if(params["Ninjas Ko'd"]) Statistic.KOs = text2num(params["Ninjas Ko'd"])
					if(params["Times Ko'd"]) Statistic.KOds = text2num(params["Times Ko'd"])

	Update_Scores()
		if(!client) return
		if(Statistic && Statistic.Obtained_Ryo)
			if(findtext(key, "Guest-")) return
			spawn()
				var/params = list("Ryo" = Statistic.Ryo, "Rounds Played" = Statistic.Rounds_Played, "Ninjas Killed" = Statistic.Kills, "Ninjas Ko'd" = Statistic.KOs, "Times Ko'd" = Statistic.KOds, "Times Assisted" = Statistic.Assists)
				world.SetScores(key, list2params(params))

	Get_Scores()
		if(findtext(key, "Guest-")) return
		spawn()
			var/Check[] = params2list(world.GetScores(key, ""))
			Statistic.Ryo = text2num(Check["Ryo"])
			Statistic.Rounds_Played = text2num(Check["Rounds Played"])
			Statistic.Kills = text2num(Check["Ninjas Killed"])
			Statistic.KOs = text2num(Check["Ninjas Ko'd"])
			Statistic.KOds = text2num(Check["Times Ko'd"])

var
	Ryo_Wasted_On_Tourney
	Ryo_Gained_On_Tourney
	Ryo_Wasted_On_Customs

mob/var
	Ryo_Gained_On_Tourney_
	Ryo_Wasted_On_Tourney_