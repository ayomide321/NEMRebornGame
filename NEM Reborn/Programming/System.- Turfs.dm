var
	const
		CLIMBABLE = 4
turf
	wall
		density = 1
	Wall_Stand
		density = 1
	wall_op
		density = 1
		opacity = 1
	walllader
	Opacity
		density = 1
	buildingwall
		density = 1
	wall_tobi
		density = 1
		icon = 'Graphics/Tobi.dmi'

obj
	Running_Effect
		icon = 'Run Effect.dmi'
		invisibility = 10
		layer = 300
		alpha = 150

		New(loc, mob/M)
			..()
			dir = M.dir
			step_x = M.step_x
			step_y = M.step_y
			step_y -= 4
			loc = M.loc
			if(M.dir == EAST) step_x -= 70
			else step_x += 10
			flick("Go", src)
			spawn(10) del(src)

	Fall_Effect
		icon = 'Fall Effect.dmi'
		invisibility = 10
		layer = 300
		alpha = 175

		New(loc, mob/M)
			..()
			M.Just_Fallen = 0
			dir = M.dir
			step_x = M.step_x
			step_y = M.step_y
			step_y -= 7
			step_x -= 55
			loc = M.loc
			if(M.dir == EAST) step_x -= 12
			if(M.name == "Suigetsu" || M.Bijuu) step_x += 16
			else step_x -= 14
			flick("Go", src)
			spawn(4) del(src)

obj
	Stage1
		icon = 'Graphics/ChuuninStage.dmi'
		layer=50
obj
	Orochimaru_Background
		pixel_y = -48
		New()
			..()
			overlays += image('Graphics/Orochimaru Background.dmi', loc, icon_state, 30)
area
	BackGround3
		icon = 'Graphics/background3.dmi'
		layer=30
	BackGround3x
		icon = 'Graphics/background3x.dmi'
		layer=30
	BackGround1
		icon = 'Graphics/background.dmi'
		pixel_x = -256
		layer=30
/*	Konoha_WareHouse
		pixel_x = -255
		layer = 30

		One
			icon = 'Graphics/Konoha Warehouse 1.png'
			pixel_y = 240
		One_
			icon = 'Graphics/Konoha Warehouse 2.png'
			pixel_y = 240
		Two
			icon = 'Graphics/Konoha Warehouse 3.png'
			pixel_y = 234
		Two_
			icon = 'Graphics/Konoha Warehouse 4.png'
			pixel_y = 234
		BackGround
			layer = 29
			pixel_x = -205
			pixel_y = 127

			icon = 'Graphics/Konoha Warehouse.dmi'
			A/icon_state = "1"
			B/icon_state = "2"
			C/icon_state = "3"
			D/icon_state = "4"*/

	Forest_I
		layer = 30
		A
			layer = 29
			icon = 'Graphics/Forest Background.dmi'
			pixel_x = -128
			pixel_y = -128
		B
			icon = 'Graphics/Forest Background I.dmi'
			pixel_x = -112
			pixel_y = -87

		Wall
			icon = 'Graphics/Forest Background Wall I.dmi'

	Forest_II
		layer = 30
		icon = 'Graphics/Forest I Background.dmi'

	Orochimaru
		layer = 30
		A icon = 'Graphics/Orochimaru Background.dmi'
		B icon = 'Graphics/Orochimaru Background.dmi'
		C {layer = 29; icon = 'Graphics/Orochimaru Background.dmi'}
		New() {..(); pixel_y -= 12; if(icon_state in list("3", "4", "11", "1D", "1E")) overlays += new/area/Orochimaru_I}

	Leaf_Background
		layer = 25
		icon = 'Graphics/Leaf Background.dmi'

	Orochimaru_I
		layer = 1000
		alpha = 175
		icon = 'Graphics/Orochimaru Background I.dmi'


	Sasuke_Stage
		layer = 30
		icon = 'Graphics/Sasuke Background.dmi'
		Torch layer = 31
		Normal

	Forest
		layer = 30
		pixel_x = -263
		pixel_y = 251
		A icon = 'Graphics/Forest1.bmp'
		B icon = 'Graphics/Forest2.bmp'
		C icon = 'Graphics/Forest3.bmp'
		D icon = 'Graphics/Forest4.bmp'
	Tobi_1
		icon = 'Graphics/Tobi.bmp'
		pixel_x = -256
		layer=30
	Tobi_2
		icon = 'Graphics/Tobi2.bmp'
		pixel_x = -256
		layer=30
	Tobi_3
		icon = 'Graphics/Tobi3.bmp'
		pixel_x = -256
		layer=30
	Tobi_4
		icon = 'Graphics/Tobi4.bmp'
		pixel_x = -256
		layer=30
turf
	Forest_I
		icon = 'Graphics/Forest Background Floor.dmi'
		layer=31

	Forest_III
		icon = 'Graphics/Forest Background IV.dmi'
		layer=31
		pixel_y = 22

	Forest_V
		icon = 'Graphics/Forest Background II.dmi'
		layer=31
		pixel_y = 18

	Forest_O
		icon = 'Graphics/Forest Object.dmi'
		layer = 30
		pixel_x = -100
		pixel_y = -6

	Forest_II
		icon = 'Graphics/Forest Background Floor.dmi'
		layer=30
		pixel_y = 30

	Forest_Wall
		icon = 'Graphics/Forest Background Wall.dmi'
		layer=30
		pixel_y = 30

	BackGround3
		icon = 'Graphics/background3.dmi'
		layer=30

	Stage4
		layer=31
		icon = 'Graphics/Stage4.dmi'

	StageRound
		layer=33
		icon = 'Graphics/RoundStage.dmi'

	Stage2
		icon = 'Graphics/Stage2.dmi'


mob
	proc
		stop()
			vel_x = 0
			vel_y = 0
			holding_right = 0
			holding_left = 0

turf
	Stage_1
		icon = 'Graphics/Stage1.dmi'
		layer=50

	Weed
		icon = 'Graphics/Weed.dmi'
		layer=50

	Stage_New
		icon = 'Graphics/Stage1New.dmi'
		layer=50

	Stage_2
		icon = 'Graphics/Stage2.dmi'
		layer=50

	Sky
		icon = 'Graphics/Stage1.dmi'
		layer=45
turf
	New_Houses
		pixel_x = 32
		pixel_y = -14
		layer = 51
		New
			pixel_x = 0
			layer = 29
			pixel_y = -26
			icon = 'Graphics/Konoha Houses.dmi'
		New_X
			pixel_x = 0
			layer = 51
			pixel_y = -26
			icon = 'Graphics/Konoha Houses.dmi'
		One
			icon = 'Graphics/House 1.dmi'
		Two
			icon = 'Graphics/House 2.dmi'
		Three
			icon = 'Graphics/House 3.dmi'
		Four
			icon = 'Graphics/House 4.dmi'
		Five
			icon = 'Graphics/House 5.dmi'
		Six
			icon = 'Graphics/House 6.dmi'
turf

	Big_Building
		icon = 'Graphics/BigBuilding.dmi'
		layer=49
		pixel_y = 5
		pixel_x = -64
	Building
		icon = 'Graphics/building.dmi'
		layer=49
		pixel_y = 5
area
	Dark_Illusion
		icon = 'Graphics/Dark Illusion.dmi'
		layer = 100000000000000
	Dark_Illusion_X
		icon = 'Graphics/Dark Illusion.dmi'
		layer = 10
turf
	BackGround
		icon = 'Graphics/background.dmi'
		layer=30
	Academy_BackGround
		icon = 'Graphics/Ninja Academy Background.dmi'
		layer=30
	BackGround4
		icon = 'Graphics/background4.dmi'
		layer=30
	BackGround7
		icon = 'Graphics/Background7.dmi'
		layer=31
	BackGround5_M
		icon = 'Graphics/background5-x.dmi'
		pixel_x = -125
		layer=35
	BackGround5
		icon = 'Graphics/background5.dmi'
		pixel_x = -125
		layer=35
	BackGround5_
		icon = 'Graphics/background5-1.dmi'
		pixel_x = -125
		layer=35
	BackGround5_x
		icon = 'Graphics/background5-2.dmi'
		pixel_x = -125
		layer=30
	BackGround5_xx
		icon = 'Graphics/background5-3.dmi'
		pixel_x = -125
		layer=30
	BackGround7s
		icon = 'Graphics/BackGround7S.dmi'
		layer=30
	Academy
		icon = 'Graphics/Ninja Academy.dmi'
		layer=31
	WallBackGround
		icon = 'Graphics/Wall32.dmi'
		layer=50
		density = 1
	StageRound2
		layer=32
		icon = 'Graphics/RoundStage2.dmi'
	StageRound3
		layer=32
		icon = 'Graphics/RoundStage3.dmi'
	Stage4Wall
		layer=32
		icon = 'Graphics/Special.dmi'
	Stage4Under
		layer=25
		icon = 'Graphics/Stage4.dmi'
	StageExtraLayer
		layer=32
		icon = 'Graphics/Stage4.dmi'
turf
	WallBackGround
		icon = 'Graphics/Wall32.dmi'
		layer=50
		density = 1

obj/Dark
	layer = 100000000000000000000000000000000000000000000000000000000000000000000000000000000
	icon = 'Graphics/Dark.dmi'

mob
	var
		move_x
		move_y

	proc

		block_collision(atom/a)
			var/ix = 0
			var/iy = 0

			if(move_x > 0)
				ix = px + move_x + pwidth - a.px
			else if(move_x < 0)
				ix = (px + move_x) - (a.px + a.pwidth)

			if(move_y > 0)
				iy = py + move_y + pheight - a.py
			else if(move_y < 0)
				iy = (py + move_y) - (a.py + a.pheight)

			var/tx = (abs(move_x) < 0.00001) ? 1000 : ix / move_x
			var/ty = (abs(move_y) < 0.00001) ? 1000 : iy / move_y

			if(ty <= tx)

				if(py + pheight / 2 < a.py + a.pheight / 2)

					move_y = a.py - (py + pheight)

				else
					move_y = a.py + a.pheight - py

			else
				if(px + pwidth / 2 < a.px + a.pwidth / 2)

					move_x = a.px - (px + pwidth)

				else
					move_x = a.px + a.pwidth - px