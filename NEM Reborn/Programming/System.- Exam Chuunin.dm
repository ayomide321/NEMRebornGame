obj
	var/Ocuppied
	Chuunin_Player_Right_Spawn_1
	Chuunin_Spawn_Team
	Chuunin_Spawn_Rogues

	Heaven_Scroll
	Earth_Scroll

	Platform
		icon = 'Platform.dmi'
		layer = 165
		pixel_x = 32
		New()
			..()
			Activate()

		proc/Activate()
			..()
			bound_x = -16
			bound_height = 96
			bound_width = 96

			loop
				Flick("Go", src)
				spawn(2.5) for(var/mob/M in obounds(src)) if(M.Real == 1 && !M.Dragonned && !M.knocked) M.vel_y = 40
				spawn(12) goto loop

mob
	Scrolls
		layer = 200
		HP = 1000000000000000000000000000000000000000000000000000000000000000000000000000000000
		Dragonned = 1
		pixel_x = -4
		knocked = 1
		dead = 0
		No_Icon = 1
		icon = 'Scrolls.dmi'
		pheight = 10
		Dodge_Next = 1
		Earth_Scroll icon_state = "Earth"
		Heaven_Scroll icon_state = "Heaven"



mob
	Chuunin_Hokage
		No_Icon = 1
		icon = 'Graphics/Hokage.dmi'
		knocked = 1
		Dragonned = 1
		layer = 250
		icon_state = ""
		New()
			..()
			Flick("Go", src)

obj
	Temari
		icon = 'Graphics/Hokage.dmi'
		icon_state = "Temari"
		pixel_x = 16
		layer = 250

	Kankuro
		icon = 'Graphics/Hokage.dmi'
		icon_state = "Kankuro"
		layer = 250

	Tsunade
		icon = 'Graphics/Hokage.dmi'
		icon_state = "Tsunade"
		layer = 250

turf
	var/Is_Water = 0

	Chuunin_Last_Stage_East
		layer = 32
		pixel_y = -12
		icon = 'Chuunin Last Stage East.dmi'

	Chuunin_Last_Stage_West
		layer = 32
		pixel_x = -24
		pixel_y = -12
		icon = 'Chuunin Last Stage West.dmi'

	Chuunin_Exam
		pixel_y = 0
		layer = 32
		icon = 'Graphics/Stage Chuunin.dmi'

	Chuunin_Exam_Bottom_East
		pixel_y = 0
		layer = 32
		icon = 'Graphics/Chuunin Bottom East.dmi'

	Chuunin_Exam_Bottom_West
		pixel_y = 0
		layer = 32
		icon = 'Graphics/Chuunin Bottom West.dmi'

	Chuunin_Exam_Water_East
		Is_Water = 1
		pixel_y = -25
		layer = 32
		icon = 'Graphics/Chuunin Water East.dmi'

	Chuunin_Exam_Water_West
		Is_Water = 1
		pixel_y = -25
		layer = 32
		icon = 'Graphics/Chuunin Water West.dmi'

	Chunin_Exam_Platforms

		pixel_y = 0
		layer = 35
		First icon = 'Graphics/Stage Chuunin A.dmi'
		First_West icon = 'Graphics/Stage Chuunin A West.dmi'
		Second icon = 'Graphics/Stage Chuunin B.dmi'
		Second_West icon = 'Graphics/Stage Chuunin B West.dmi'
		Third icon = 'Graphics/Stage Chuunin C.dmi'

	Snow
		layer = 35
		Air icon = 'Graphics/Snow Platform Air.dmi'
		Wall icon = 'Graphics/Snow Platform Wall.dmi'
		Corner icon = 'Graphics/Snow Platform Corner.dmi'
		Corner_Wall icon = 'Graphics/Snow Platform Corner Wall.dmi'
		Platform_I icon = 'Graphics/Snow Platform I.dmi'
		Platform_II icon = 'Graphics/Snow Platform II.dmi'

	Sand
		layer = 36
		Floor icon = 'Graphics/Sand Platform.dmi'
		Wall {icon = 'Graphics/Sand Platform Wall.dmi'; pixel_y = 17; layer = 40}
		Wall_Corner_L {icon = 'Graphics/Sand Platform Corner.dmi'; layer = 42}
		Wall_Corner_LI {icon = 'Graphics/Sand Platform Corner I.dmi'; layer = 41}
		Wall_Corner {icon = 'Graphics/Sand Platform Corner.dmi'; pixel_y = -4; layer = 35}
		Wall_I {icon = 'Graphics/Sand Platform I.dmi'; pixel_y = -28; layer = 34}
		Wall_I_ {icon = 'Graphics/Sand Platform I.dmi'; pixel_y = -47; layer = 34}
		Wall_I__ {icon = 'Graphics/Sand Platform I.dmi'; pixel_y = -66; layer = 34}
		Wall_I___ {icon = 'Graphics/Sand Platform I.dmi'; pixel_y = -85; layer = 34}
		Wall_II {icon = 'Graphics/Sand Platform II.dmi'; pixel_y = 17}
		Wall_II_ {icon = 'Graphics/Sand Platform III.dmi'; pixel_y = 17}
		Wall_III {icon = 'Graphics/Sand Platform Big.dmi'; layer = 37}
area

	Background_Snow {icon = 'Graphics/background4.dmi'; layer = 30}
	Background_Sand {icon = 'Graphics/Sand Platform Background.dmi'; layer = 30}
	Background_Sand_Sky {icon = 'Graphics/Sand Platform Sky.dmi'; layer = 30}
	Background_Sand_Floor {icon = 'Graphics/Sand Platform Sky.dmi'; layer = 50}
	Forest_Chuunin
		layer = 15
		icon = 'Graphics/Stage Chuunin.dmi'
		icon_state = "M"
	Water_Chuunin
		layer = 15
		East icon = 'Graphics/Chuunin Background Bottom East.dmi'
		West icon = 'Graphics/Chuunin Background Bottom West.dmi'