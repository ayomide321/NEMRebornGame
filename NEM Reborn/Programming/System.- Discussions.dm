var/list/Discussions = list()

Discussion
	var
		Text
		Creator
		Description
		list/Likes = list()
		list/Dislikes = list()
		list/Computer_IDs = list()


	New(C, T)
		if(C && T)
			Creator = C
			Text = T
			Discussions.Add(src)


/*mob/verb

	Discussions()
		set hidden = 1
		if(Menu() == 0) return

		var/Window = {"<html><body><font color=white><style = \"text/css\">body { scrollbar-DarkShadow-Color:#854040;scrollbar-Shadow-Color:#6F3636;scrollbar-base-color:#572B2B;scrollbar-arrow-color:#411F1F;background-color:#150000} #main p{text-align:right}</style></body></html><b><font size=6><u><font color=#7C0000><center>* Discussion *</u></center><br><font size=2>"}
		for(var/Discussion/A in Discussions)
			Window += "<br><font color=#A30101><font size=3><u>- [A.Creator]: [A.Text].</u>"
			Window += {"<font color=#A30101><font size=2><div id="main"><div style="float:right">[A.Likes]+ & [A.Dislikes]-</div><br>"}
			Window += {"<div id="main"><div style="float:right"><a href='?src=\ref[usr]User=\ref[usr]&&Discussion=\ref[A];action=Support Discussion'>+</a></div><br>"}
		Window += {"<br><br><font size=3><div id="main"><div style="float:right"><a href='?src=\ref[usr];action=Discussions'>Refresh</a></div><font color=#A30101><u><a href='?src=\ref[usr];action=Discussion'>Start Discussion</a></u>"}
		winset(src, "Menu.Image", "image=\ref[Menu_Organizations]")
		src << output(null, "Menu.Browse")
		usr << output(Window, "Menu.Browse")
		winshow(src, "Menu.Return", 1)
		winshow(src, "Menu.Image", 1)
		winshow(src, "Menu.Browse", 1)
		winshow(src, "Menu.ExtraBackground", 1)*/