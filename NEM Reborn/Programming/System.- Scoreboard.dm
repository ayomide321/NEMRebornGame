var/Just_Rewarded
var/_First_Rank_

/var/const/
	scoreboard={""}
	scoreboardtitle={"<STYLE>BODY {scrollbar-DarkShadow-Color:#1A0000;scrollbar-Shadow-Color:#2B0000;scrollbar-base-color:#2E0000;scrollbar-arrow-color:#4E0000;background: #160000;  color: #C63B3B}</STYLE><head><title>Scoreboard</title></head></body>"}
/Rank_Entry/
	var{Name;KOs;KOd;Kills;Date;Levels;Key;_Assists}
	New(mob/person)
		if(!person) return
		Name=(person.name)
		Key=(person.key)
		_Assists=(person._Assists)
		Kills=(person.Kills)
		KOs=(person.KOs)
		KOd=(person.KOd)
		Date=(time2text(world.realtime))

/proc/
	RankingDisplay(var/mob/person)
		if(ismob(person) && person.client)
			var/list/levels=new()
			var/savefile/F=new("Scoreboard.sav")
			F[("stuff")]>>(levels)
			var/html="<center><TABLE BORDER=1><TR><TH><html><BODY><center><h1><U><font color=#860000><font size=10>~Scoreboard~</u></font></h1><TABLE CELLSPACING=10>"
			if(!levels)html+="<TR><TD>No high rankings to display.</TD></TR>\n"
			else
				html+="<tr><th><B><u><font color=#9F0101>Rank</u></font></th><th><u><font color=#9F0101>Last Character <I>(Key)</u></font></I></th><th><u><font color=#9F0101>Kills</u></font></th><th><u><font color=#9F0101>KO(s) Performed</u></font></th><th><u><font color=#9F0101>Assist(s) Performed</u></font></th><th><u><font color=#9F0101>Times KO'd</u></font></th></tr>\n<br>"
				for(var/number in 1 to levels.len)
					var{character=(levels[(number)]);Rank_Entry/scoreplayer=(levels[(character)])}
					if(!_First_Rank_) _First_Rank_ = scoreplayer.Key
					html+="<tr><td><u><center>[(number)]\th</td><td></u></font><center><font color=#C63B3B>[(scoreplayer.Name)] <I>([(scoreplayer.Key)])</I></td><td><center>[num2text(round(scoreplayer.Kills),100)]</td><td><center>[num2text(scoreplayer.KOs,100)]</td><td><center>[num2text(scoreplayer._Assists,100)]</td><td><center>[num2text(scoreplayer.KOd,100)]</td></tr>\n"
					if(number == 3) html += "\n"
			person<<browse("[scoreboardtitle][html]","window=scoreboard;size=515x320")
	Check_Winner_Score()
		if(Boss_Mode) return
		for(var/mob/W in world) if(!Just_Rewarded && W.key == _First_Rank_)
			Just_Rewarded = 1
			spawn(50)
				_First_Rank_ = null
				Just_Rewarded = 0
			W.Ryo_Reward(10, 1)
	Ranking(var/mob/scoreplayer)
		if(!scoreplayer || !scoreplayer.client || scoreplayer.name == scoreplayer.key || !scoreplayer.Kills && !scoreplayer.KOs && !scoreplayer.KOd && !scoreplayer._Assists) return
		var/savefile/F=new("Scoreboard.sav")
		var/list/maxscores=new()
		F[("stuff")]>>(maxscores)
		if(!maxscores)maxscores=new()
		var{character="[(scoreplayer.client.ckey)]/[(scoreplayer.name)]"
			score=maxscores.Find(character)
			Rank_Entry/newest=new(scoreplayer)
			Rank_Entry/last}
		if(score)
			var/Rank_Entry/old=(maxscores[(character)])
			if((old.Kills+(old._Assists+old.KOs-old.KOd))>=(scoreplayer.Kills+(scoreplayer._Assists+scoreplayer.KOs-scoreplayer.KOd)))return score
			while(score>1)
				last=maxscores[(maxscores[(score-1)])]
				if((last.Kills+(last._Assists+last.KOs-last.KOd))>=(scoreplayer.Kills+(scoreplayer._Assists+scoreplayer.KOs-scoreplayer.KOd)))break
				maxscores[(score)]=(maxscores[(score-1)])
				maxscores[(--score)]=(character)
				maxscores[(maxscores[(score+1)])]=(last)
			maxscores[(character)]=(newest)
			F[("stuff")]<<(maxscores)
			return score
		score=(maxscores.len)
		if(score>=100)
			last=(maxscores[(maxscores[(score)])])
			if((last.Kills+(last._Assists+last.KOs-last.KOd)) >= (scoreplayer.Kills+(scoreplayer._Assists+scoreplayer.KOs-scoreplayer.KOd))) return 101
			maxscores[(score)]=(character)
		else score=(maxscores.len+1),maxscores+=(character)
		while(score>1)
			last=(maxscores[(maxscores[(score-1)])])
			if((last.Kills+(last._Assists+last.KOs-last.KOd))>=(scoreplayer.Kills+(scoreplayer._Assists+scoreplayer.KOs-scoreplayer.KOd))) break
			maxscores[(score)]=(maxscores[(score-1)])
			maxscores[(--score)]=(character)
			maxscores[(maxscores[(score+1)])]=(last)
		maxscores[(character)]=(newest)
		F[("stuff")]<<(maxscores)
		return score

mob/President/verb
	Thank_You_Points()
		set category = "Server"
		for(var/mob/M)
			if(M.GM)
				src<<"<b><font color=[admin_color]><u>[M.key] has [M.Thanked_Times] Thank You Point(s).</b></u></font>"
//	Jutsus()
//		var/Last_Jutsu
	//	for(var/obj/J in Jutsus) {world<<"[Jutsus(J.name)]"; Last_Jutsu = J}
	//	for(var/obj/J in Jutsus) {if(Last_Jutsu) Jutsus.Swap(J, Last_Jutsu); Last_Jutsu = null}
	//	for(var/obj/J in Jutsus) {world<<"[J]"; Last_Jutsu = J}