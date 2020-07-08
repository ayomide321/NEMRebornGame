mob/var/Check_Icon = 0
var/_East = "_East.dmi"
var/_West = "_West.dmi"

mob/var
	Icon_State
	Change_Direction = 1
	Old_Z

var
	const
		// used to set icon states
		STANDING = "standing"
		MOVING = "moving"
		RUNNING = "running"
		CLIMBING = "climbing"
		JUMPING = "jumping"

		RIGHT = EAST
		LEFT = WEST
/*mob
	verb
		Donate()
			src<<output("<b><font color=red><font size=3>You'll need to wait some time, but you'll receive the Package :3","Chat")
			var/Donation = {"<STYLE>BODY {background: black; color: white}</STYLE>
<center><b><font size=5>The Package lasts forever!</center></font size><font size=2>
<br><br>* You'll receive the following characters:<br><br>Madara, Zetsu, Kabuto, Rin, Obito, PS Kakashi, PS Sasuke, Killer Bee, Raikage, Tsuchikage & Mizukage.<br><br>Thank you a lot for supporting our game!
<center>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post">
<input type="hidden" name="cmd" value="_s-xclick">
<input type="hidden" name="hosted_button_id" value="F3F57JRVEEWPU">
<table>
<tr><td><input type="hidden" name="on0" value="BYOND Account"><b><u>BYOND Account</u></center></font></b></td></tr><tr><td><input type="text" name="os0" value= "[src.key]"></td></tr>
</table>
<input type="image" src="https://www.paypalobjects.com/en_US/ES/i/btn/btn_buynowCC_LG.gif" border="1" name="submit" alt="PayPal - The safer, easier way to pay online!">
<img alt="" border="1" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
</form>"}
			src << browse(Donation,"window=Donation;size=400x300")
			for(var/mob/M in world)
				if(M.CanHearAll==1)
					M<<output("<b><font color=red>* [src.key] pressed Donate Button.","Chat")*/

mob
	pixel_x=-10
	pwidth = 100
	density = 1
	pheight = 100


	var
		on_left = 0
		on_right = 0
		running = 0
		on_ceiling = 0
		on_ground = 0
		falling = 0

		base_state = ""

		// acceleration and deceleration rates
		accel = 1
		decel = 1
		gravity = 0.5

		move_speed = 5
		climb_speed = 5
		fall_speed = 25

		last_x = -1
		last_y = -1
		last_z = -1

	proc

mob/var/KB_A

mob
	proc
		KB_A()
			if(!HbR)
				KB_A = 1
				spawn(5)
					KB_A = 0
					fall_speed = 25
					if(knockback) knockback = 0

		bump(atom/a, d)

			if(knockback && !KB_A  && knocked == 0)
				if(HbR && !Attacked_ || !HbR)
					Attacked_ += 7
					if(!KB_A) KB_A()
					new/obj/Effects/Meele_Hit (loc, src)
					src.HP -= 2.5
					if(!on_ground) vel_y = 5
					else vel_y = 8
					vel_x = 0
					if(Last_Person_Who_Attacked) Death_Check(Last_Person_Who_Attacked)
					else Death_Check("collision")


			if(ismob(a))

				var/mob/A = a

				if(A.Using_Sand_Shield == 1)
					if(Dashing || Rasengan || Chidori || DinamicEntry || Gates ||  HbR || Iron || Boulder >= 1 || BoulderX >= 1 || KakashiChidori)
						if(Rasengan==79874) pixel_x = 0
						for(var/obj/Jutsus/Kyuubi_Slash_Naruto/J in src) J.Delay(7)
						for(var/obj/Jutsus/Kyuubi_Hand_Crush/J in src) J.Delay(7)
						KakashiChidori = 0
						Rasengan = 0
						Chidori = 0
						DinamicEntry = 0
						Iron = 0
						if(Dashing == 1) Itachi_Dash_Off()
						Flick("teleport", src)
						return
				if(A.Dodging == 1 && A.Village != Village && A.Dragonned == 0)
					if(Dashing || Rasengan || Chidori || DinamicEntry || Gates ||  HbR || Iron || Boulder >= 1 || BoulderX >= 1 || KakashiChidori)
						if(Rasengan == "Kabuchimaru")
							for(var/obj/Jutsus/Killing_Snakes/W in src) W.Delay(5)
							for(var/obj/Jutsus/Fatal_Bite/W in src) W.Delay(5)
							for(var/obj/Jutsus/Devouring_Snakes/W in src) W.Delay(5)
							for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in src) W.Delay(3)
							for(var/obj/Jutsus/Earthquake_K/W in src) W.Delay(3)
						A.Auto_Dodge(src)
						for(var/obj/Jutsus/Kyuubi_Slash_Naruto/J in src) J.Delay(7)
						for(var/obj/Jutsus/Kyuubi_Hand_Crush/J in src) J.Delay(7)
						KakashiChidori = 0
						Rasengan = 0
						Chidori = 0
						DinamicEntry = 0
						Iron = 0
						if(Dashing == 1) Itachi_Dash_Off()
						Flick("teleport", src)
						return
				if(A.Flag_ == 1)
					if(a)
						if(A.Village == "Akatsuki" && src.Village == "Leaf" && src.Flag_CD == 0 && src.client)
							src.KakashiChidori = 0
							src.Rasengan = 0
							src.Chidori = 0
							src.DinamicEntry = 0
							src.Iron = 0
							src.Flag = 1
							src.overlays += /obj/Akatsuki_Flag
							world<<"<b><font size=2><font color=#00FF00><u>[src.name] has stolen Akatsuki's Flag!</u></font>"
							for(var/client/C)
								if(C.mob.Village == "Akatsuki") src<<"<b><font color=#8904B1><u>Kill [src.name] before he reaches Leaf Village!</u></font>"
							del(a)
							return
						if(A.Village == "Leaf" && src.Village == "Akatsuki" && src.Flag_CD == 0 && src.client)
							src.KakashiChidori = 0
							src.Rasengan = 0
							src.Chidori = 0
							src.DinamicEntry = 0
							src.Iron = 0
							src.Flag = 1
							src.overlays += /obj/Leaf_Flag
							world<<"<b><font size=2><font color=#8904B1><u>[src.name] has stolen Leaf's Flag!</u></font>"
							for(var/client/C)
								if(C.mob.Village == "Leaf") src<<"<b><font color=#00FF00><u>Kill [src.name] before he reaches Akatsuki's Hideout!</u></font>"
							del(a)
							return

				if(A.Real==1&&src.Gates==1&&A.Dragonned==0&&A.Village!=src.Village&&A.Susanoo==0)
					Flick("gate3",src)
					var/Gates_Damage = 3.5+rand(1, 3)
					Gates_Damage *= 2
					A.Damage(src, Gates_Damage, 1, 0)
					src.HP -= Gates_Damage -rand(1.75, 2.40)
					src.Death_Check("Gates' Effects")

				if(A.Real==1&&A.Susanoo==0&&A.Dragonned==0&&A.Gates==0&&src.Amaterasu==1&&A.Amaterasu==0&&A.Immune==0)
					A.Amaterasu=1
					A.Amaterasu_Proc()

				if(Rasengan)
					if(Dashing&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						new/obj/Effects/Itachi_Image (loc, src)
						if(A.Levitating) A.Check_Levitating()
						A.Dragonned = 1
						A.freeze ++
						A.stop()
						Dragonned = 1
						Rasengan = 0
						Dashing = 0
						freeze ++
						spawn(1.75)
							Itachi_Dash_Off()
							A.Damage(src, 10, 0, 0, 0, 1, 0)
							Teleport_Behind_NSS (A, src)
							flick("Kick", src)
						spawn(3.60)
							A.Dragonned = 0
							A.freeze --
							A.stop()
							A.Damage(src, 10+rand(0, 5), 1, 2, 0, 1, 0)
						spawn(6.55)
							Dragonned = 0
							freeze --
							stop()
					if(src.Rasengan=="Kabuchimaru"&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Rasengan = 0
						Flick("Chusa End", src)
						layer ++
						spawn(1.50) layer --
						var/Damage = 25+rand(0, 7)
						A.Damage(src, Damage, 1, 2)
						for(var/obj/Jutsus/Killing_Snakes/W in src) W.Delay(5)
						for(var/obj/Jutsus/Fatal_Bite/W in src) W.Delay(5)
						for(var/obj/Jutsus/Devouring_Snakes/W in src) W.Delay(5)
						for(var/obj/Jutsus/Sawarbi_No_Mai_K/W in src) W.Delay(3)
						for(var/obj/Jutsus/Earthquake_K/W in src) W.Delay(3)
						A.Poison_Proc(7, src.name)
					if(src.Rasengan==894651657&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						if(A.Levitating) A.Check_Levitating()
						Flick("Charge End", src)
						A.Dragonned = 1
						A.freeze ++
						A.stop()
						Dragonned = 1
						Rasengan = 0
						freeze ++
						layer ++

						spawn(3)
							var/Damage = 25+rand(0, 5)
							A.Damage(src, Damage, 1, 2)
							A.Dragonned = 0
							A.freeze --
						spawn(5.55)
							Dragonned = 0
							freeze --
							layer --
							stop()

					if(src.Rasengan==79874&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						if(A.Levitating) A.Check_Levitating()
						Flick("Dash_End",src)
						src.Rasengan=0
						src.freeze ++
						Dragonned = 1
						spawn(3.5)
							var/Damage = 45+rand(0, 5)
							A.Damage(src, Damage, 1, 2)
							Dragonned = 0
							spawn(3.5)
								pixel_x = 0
								freeze --
					else if(src.Rasengan==4978216&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						var/Old_Loc = loc
						Flick("Special2",src)
						src.Rasengan=0
						if(src.dir == EAST) src.x += 2
						if(src.dir == WEST) src.x -= 2
						spawn(3.5)
							var/Damage = 45
							A.Damage(src, Damage, 1, 1)
						spawn(5)
							Flick("teleport", src)
							loc = Old_Loc
							layer = 0
							Substitution = 1
							SubstitutionCD = 1
							var/G=new/obj/Smoke(src.loc)
							G:pixel_x = src.pixel_x
							G:pixel_y = src.pixel_y
							if(dir == EAST) vel_x=-25
							if(dir == WEST) vel_x=25
							spawn(10)
								SubstitutionCD = 0
								Substitution = 0
								layer = 100
						if(A.Levitating) A.Check_Levitating()
					else if(src.Rasengan==69&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						if(A.Levitating) A.Check_Levitating()
						Flick("Second",src)
						Rasengan=0
						freeze ++
						A.freeze ++
						spawn(3)
							if(src) src.freeze --
							if(a) A.freeze --
						sleep(1)
						if(dir == EAST) src.x += 2
						if(dir == WEST) src.x -= 2
						spawn(1.5)
							var/Damage = 55
							A.Damage(src, Damage, 1, 2)
					else if(src.Rasengan==88491&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						for(var/obj/Jutsus/Raikage_Summoning/L in src) L.Delay(5)
						src.Rasengan=0
						if(Sage == 1) A.HP -= 5
						var/Damage = 55
						A.Damage(src, Damage, 1, 2)
						Flick("Lariat2", src)
						var/G=new/obj/GroundSmash(A.loc)
						if(src.dir==WEST) G:pixel_x-=15
						if(src.dir==EAST) G:pixel_x-=10
					else if(src.Rasengan==79841321&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						for(var/obj/Jutsus/Endless_Kicks/L in src) L.Delay(5)
						src.Rasengan = 0
						var/Damage = 55
						A.freeze ++
						A.Dragonned = 1
						freeze ++
						layer ++
						Dragonned = 1
						Flick("Lariat End", src)
						spawn(2)
							A.Dragonned = 0
							A.freeze --
							A.stop()
							A.Damage(src, Damage, 1, 2)
							var/G=new/obj/GroundSmash(A.loc)
							if(dir == WEST) G:pixel_x -= 15
							if(dir == EAST) G:pixel_x -= 10
						spawn(7.75)
							Dragonned = 0
							freeze --
							layer --
							stop()
					else if(src.Rasengan==107&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						for(var/obj/Jutsus/Kyuubi_Slash_Naruto/J in src) J.Delay(7)
						for(var/obj/Jutsus/Kyuubi_Hand_Crush/J in src) J.Delay(7)
						Flick("rasengan4",src)
						var/Damage = 45
						A.Damage(src, Damage, 1, 0)
						src.Rasengan=0
						switch(rand(1,4))
							if(4)
								if(dir == EAST)
									A.HbR_ProcEAST()
									A.overlays+='Graphics/Skills/RasenshurikenExpandE.dmi'
								if(dir == WEST)
									A.HbR_ProcWEST()
									A.overlays+='Graphics/Skills/RasenshurikenExpandW.dmi'
							else
								if(dir == EAST) A.knockbackeast()
								if(dir == WEST) A.knockbackwest()
					else if(src.Rasengan==666&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("End",src)
						var/Damage = 25+rand(1,15)
						A.Damage(src, Damage, 1, 1)
						src.Rasengan=0
					else if(src.Rasengan==22220&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("Double Rasengan End",src)
						var/Damage = 40+rand(5,10)
						A.Damage(src, Damage, 1, 0)
						if(dir == EAST)
							A.HbR_ProcEAST()
							A.overlays+='Graphics/Skills/RasenshurikenExpandE.dmi'
						if(dir == WEST)
							A.HbR_ProcWEST()
							A.overlays+='Graphics/Skills/RasenshurikenExpandW.dmi'
						src.Rasengan = 0
					else if(src.Rasengan=="Yondaime"&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						for(var/obj/Jutsus/Hiraishin_Ni_no_Dan/K in src) K.Delay(7)
						Flick("Rasengan III", src)
						src.Rasengan = 0
						src.freeze ++
						src.Dragonned = 1
						A.Dragonned = 1
						A.freeze ++
						spawn(2.5)
							src.Dragonned = 0
							src.freeze --
							A.Dragonned = 0
							A.freeze --
							var/Damage = 20+rand(5,15)
							A.Damage(src, Damage, 1, 0)
							switch(rand(1,3))
								if(3)
									if(dir == EAST)
										A.HbR_ProcEAST()
										A.overlays+='Graphics/Skills/RasenshurikenExpandE.dmi'
									if(dir == WEST)
										A.HbR_ProcWEST()
										A.overlays+='Graphics/Skills/RasenshurikenExpandW.dmi'
								else
									if(dir == EAST) A.knockbackeast()
									if(dir == WEST) A.knockbackwest()
					else if(src.Rasengan==1&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("rasengan4",src)
						var/Damage = 20+rand(5,15)
						A.Damage(src, Damage, 1, 0)
						switch(rand(1,3))
							if(3)
								if(dir == EAST)
									A.HbR_ProcEAST()
									A.overlays+='Graphics/Skills/RasenshurikenExpandE.dmi'
								if(dir == WEST)
									A.HbR_ProcWEST()
									A.overlays+='Graphics/Skills/RasenshurikenExpandW.dmi'
							else
								if(dir == EAST) A.knockbackeast()
								if(dir == WEST) A.knockbackwest()
						src.Rasengan=0
					else if(src.Rasengan==1987461513621&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("teleport", src)
						var/Damage = 15
						view(10)<<"<font color=#10C8FF><font size=2>{PvP}<font color=#6EDEFF>  <b>[name]</b>: Snake Summoning!"
						SubstitutionCD = 0
						Cha += 10
						Energy += 10
						A.Damage(src, Damage, 1, 0)
						Rasengan = 0
						jump()
						Substitution()
						No_Attack = 1
						spawn(10) No_Attack = 0
						var/mob/G = new/mob/Ultimate_Projectile/Ink_Snake(null, src)
						G.icon = 'Graphics/Skills/Orosnake.dmi'

						if(dir == EAST)
							x += 3
							dir = WEST
						else
							x -= 3
							dir = EAST


					else if(src.Rasengan==89794161&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("Second",src)
						var/Damage = 50
						A.Damage(src, Damage, 1, 0)
						src.Rasengan = 0
						if(dir == EAST)
							A.Bomber_ProcEAST()
							A.overlays+='Graphics/Skills/Bomber.dmi'
						if(dir == WEST)
							A.Bomber_ProcWEST()
							A.overlays+='Graphics/Skills/Bomber.dmi'
					else if(src.Rasengan==1&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("rasengan4",src)
						var/Damage = 20+rand(5,15)
						A.Damage(src, Damage, 1, 2)
						src.Rasengan = 0



				if(A.Real && src.HbR == 1 && A.Dragonned==0 && !A.Dragonned && A.Gates == 0 && A.Boulder == 0 && A.BoulderX == 0 && A.Attacked == 0)
					var/Damage = 12.5
					A.Damage("Rasengan's Effect", Damage, 1, 0, src)
					A.Attacked(5)
					A.vel_y = 10
				if(A.Real && src.HbR == 2 && src.Special_HBR && A.Dragonned==0 && !A.Dragonned && A.Gates == 0 && A.Boulder == 0 && A.BoulderX == 0 && A.Attacked == 0)
					var/Damage = 15
					A.Damage("Water Bomb's Effect", Damage, 1, 0, src)
					A.Attacked(5)
					A.vel_y = 10


			//	if(src.Real==1&&src.name!="Itachi"&&src.Susanoo==0&&A.Amaterasu==1&&src.Amaterasu==0)
				if(src.Real==1&&A.Dragonned==0&&src.Susanoo==0&&A.Amaterasu==1&&src.Amaterasu==0&&src.Immune==0)
					src.Amaterasu=1
					src.Amaterasu_Proc()
				if(Iron)
					if(Iron == 2 && A.Dragonned == 0 && A.Real == 1 && A.Village != src.Village)
						var/Damage = 30+rand(5, 20)
						A.Damage(src, Damage, 1, 2)
						src.Iron = 0
						Flick("teleport",src)
					else if(src.Iron==98791651&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						src.Iron = 0
						src.stop()
						Flick("second", src)
						var/Damage = 55
						A.Damage(src, Damage, 1, 2)
						A.Quake_Effect_X(25)
						Flick("teleport",src)
					else if(src.Iron==1&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						var/Damage = 20+rand(5,20)
						A.Damage(src, Damage, 1, 2)
						src.Iron = 0
						A.Death_Check(src)
				if(src.DinamicEntry==1&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					var/Damage = 10+rand(5, 15)
					A.Damage(src, Damage, 1, 1)
					src.DinamicEntry=0
					Flick("teleport",src)
					new/obj/SmallHit (A.loc)
				if(src.Boulder>=1&&A.Dragonned==0&&A.Village!=src.Village&&A.Real==1)
					if(src.name != "Killer Bee") Flick("boulder3",src)
					if(src.name == "Killer Bee") A.HP -= 2.5
					var/Damage = 10+rand(1, 10)
					A.Damage(src, Damage, 1, 1)
					A.Dodge()
					src.Boulder++
					if(src.Boulder>=7)
						Boulder=0
						Dragonned = 0
						move_speed=5
						Real=1
						Checked_X=1
						Flick("teleport", src)
					else
						Flick("boulder2", src)
				if(src.BoulderX>=1&&A.Dragonned==0&&A.Village!=src.Village&&A.Real==1)
					Flick("fang",src)
					var/Damage = 15+rand(5, 10)
					A.Damage(src, Damage, 1, 1)
					A.Dodge()
					src.BoulderX++
					if(src.BoulderX>=5)
						BoulderX=0
						move_speed=5
						Real=1
						Checked_X=1
						Flick("fang",src)
						Dragonned = 0
						sleep(5)
						src.icon = 'Graphics/Characters/KibA.dmi'
					else
						Flick("boulder",src)
				if(src.DinamicEntry==5&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					var/Damage = 10+rand(5,20)
					A.Damage(src, Damage, 1, 2)
					src.DinamicEntry=0
					Flick("teleport",src)
					new/obj/SmallHit (A.loc)

				if(src.Rasengan==81365164&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("Best2", src)
					var/G = new/obj/Immense_Explosion(A.loc)
					if(dir == WEST)G:pixel_x = -26
					if(dir == EAST)G:pixel_x = 22
					var/Damage = 35+rand(20, 50)
					A.Damage(src, Damage, 1, 2)
					src.Rasengan=0
				if(Chidori)
					if(src.Chidori=="Chidori"&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("Chidori End", src)
						var/Damage = 35+rand(5,15)
						A.Damage(src, Damage, 1, 1)
						src.Chidori=0
					else if(src.Chidori=="Stab"&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("Chidori Stab End", src)
						src.Dragonned = 1
						spawn(5) src.Dragonned = 0
						var/G=new/obj/GroundSmash(src.loc)
						if(src.dir == WEST) G:pixel_x-=15
						if(src.dir == EAST) G:pixel_x-=10
						var/Damage = 50+rand(10,25)
						A.Damage(src, Damage, 1, 2)
						Flick("hurt",a)
						src.Chidori=0
					else if(src.Chidori==6875610655&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("Rage2", src)
						if(src.name == "(Curse Seal) Juugo") A.HP -= 10
						var/G=new/obj/GroundSmash(src.loc)
						if(src.dir==WEST)G:pixel_x-=15
						if(src.dir==EAST)G:pixel_x-=10
						var/Damage = 35+rand(5,20)
						A.Damage(src, Damage, 1, 2)
						src.Chidori=0
					else if(src.Chidori==596846163&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						src.Chidori=0
						Flick("Lariat2", src)
						var/Damage = 55+rand(20,25)
						A.Damage(src, Damage, 1, 0)
						sleep(1.5)
						var/G=new/obj/GroundSmash(A.loc)
						if(src.dir==WEST)G:pixel_x-=15
						if(src.dir==EAST)G:pixel_x-=10
					if(src.Chidori==89461324749&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						var/Damage = 30+rand(10,20)
						A.Damage(src, Damage, 1, 2)
						src.Chidori=0
					else if(src.Chidori==289846135&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("Mystic2", src)
						var/Damage = 45+rand(1,25)
						A.Damage(src, Damage, 1, 2)
						src.Chidori=0
					else if(src.Chidori==10007&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("teleport", src)
						var/Damage = 50+rand(1,10)
						A.Damage(src, Damage, 1, 2)
						src.Chidori=0
					else if(src.Chidori==892713&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("End", src)
						var/Damage = 30+rand(15,20)
						A.Damage(src, Damage, 1, 2)
						src.Chidori=0
					else if(src.Chidori==1&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("chidori4",src)
						var/Damage = 20+rand(5,15)
						A.Damage(src, Damage, 1, 1)
						src.Chidori=0
						A.Death_Check(src)
					else if(src.Chidori==1996&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("chidori4",src)
						var/Damage = 25+rand(5,15)
						A.Damage(src, Damage, 1, 1)
						src.Chidori=0
						spawn(15) Flick("teleport", src)
					else if(src.Chidori==108&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						Flick("chidori4",src)
						var/Damage = 15+rand(5,35)
						A.Damage(src, Damage, 1, 2)
						src.Chidori=0
					else if(src.Chidori=="AK"&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
						for(var/obj/Jutsus/Fire_Dragon_E1/K in src) K.Delay(3)
						Flick("End", src)
						Dragonned = 1
						Chidori = 0
						freeze ++
						A.Dragonned = 1
						A.freeze ++
						spawn(7.5) {Dragonned = 0; freeze --; stop()}
						sleep(1.5)
						A.Dragonned = 0
						A.freeze --
						A.stop()
						var/Damage = 50+rand(5, 15)
						A.Damage(src, Damage, 1, 2)

				if(src.KakashiChidori==1&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("raikiri4",src)
					var/Damage = 50+rand(1,15)
					A.Damage(src, Damage, 1, 2)
					src.KakashiChidori=0
					spawn(8)Flick("teleport",src)
					new/obj/SmallHit (A.loc)
				if(src.KakashiChidori==5&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("chidori4",src)
					var/Damage = 20+rand(10,15)
					A.Damage(src, Damage, 1, 1)
					src.KakashiChidori=0
					spawn(8)Flick("teleport",src)
					new/obj/SmallHit (A.loc)
				if(src.Rasengan==5&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("giant3",src)
					var/Damage = 30+rand(5,15)
					A.Damage(src, Damage, 1, 0)
					src.Rasengan=0
					switch(rand(1,3))
						if(3)
							if(dir == EAST)
								A.HbR_ProcEAST()
								A.overlays+='Graphics/Skills/RasenshurikenExpandE.dmi'
							if(dir == WEST)
								A.HbR_ProcWEST()
								A.overlays+='Graphics/Skills/RasenshurikenExpandW.dmi'
						else
							if(dir == EAST) A.knockbackeastx()
							if(dir == WEST) A.knockbackwestx()
				if(src.Rasengan==8&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("rasengan4",src)
					var/Damage = 40+rand(5,15)
					A.Damage(src, Damage, 1, 0)
					src.Rasengan=0
					switch(rand(1,3))
						if(3)
							if(dir == EAST)
								A.HbR_ProcEAST()
								A.overlays+='Graphics/Skills/RasenshurikenExpandE.dmi'
							if(dir == WEST)
								A.HbR_ProcWEST()
								A.overlays+='Graphics/Skills/RasenshurikenExpandW.dmi'
						else
							if(dir == EAST) A.knockbackeastx()
							if(dir == WEST) A.knockbackwestx()
				if(src.Rasengan=="Minato"&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("rasengan3", src)
					var/Damage = 40+rand(5,15)
					A.Damage(src, Damage, 1, 0)
					src.Rasengan=0
					switch(rand(1,2))
						if(2)
							if(dir == EAST)
								A.HbR_ProcEAST()
								A.overlays+='Graphics/Skills/RasenshurikenExpandE.dmi'
							if(dir == WEST)
								A.HbR_ProcWEST()
								A.overlays+='Graphics/Skills/RasenshurikenExpandW.dmi'
						else
							if(dir == EAST) A.knockbackeastx()
							if(dir == WEST) A.knockbackwestx()
				if(src.Rasengan==10&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("teleport",src)
					var/Damage = 40+rand(5,15)
					A.Damage(src, Damage, 1, 2)
					src.Rasengan=0
				if(src.ChakraBlade==1&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("blade2",src)
					var/Damage = 10+rand(5,15)
					A.Damage(src, Damage, 1, 0)
					var/D=new/obj/BigHit(src.loc)
					D:dir=src.dir
					src.ChakraBlade=0
					if(src.dir==EAST)
						A.dir=WEST
						src.loc=locate(A.x+1,A.y,A.z)
					if(src.dir==WEST)
						A.dir=EAST
						src.loc=locate(A.x-1,A.y,A.z)
				if(src.Rasengan==2&&A.Dragonned==0&&A.Real==1&&A.Village!=src.Village)
					Flick("rasen5",src)
					var/Damage = 60+rand(5,20)
					A.Damage(src, Damage, 1, 2)
					src.Rasengan=0
					A.Death_Check(src)
				if(!knockback && !Substitution && Gates == 0 && Boulder == 0 && BoulderX == 0 && istype(a,/mob/Wood_Pillar)&&src.Village!=A.Village&&Attacked==0)
					var/Damage = 3
					Attacked = 1
					spawn(5) Attacked = 0
					if(src in inside(a)) Damage(A:Creator, Damage, 1, 0, src)
					else Damage(A:Creator, Damage, 1, 2, src)
				if(!knockback && !Substitution && Gates == 0 && Boulder == 0 && BoulderX == 0 && istype(a,/mob/Earth_Wall)&&src.Village!=A.Village&&Attacked==0)
					var/Damage = 3.5
					Attacked = 1
					spawn(5) Attacked = 0
					if(src in inside(a)) Damage(A:Creator, Damage, 1, 0, src)
					else Damage(A:Creator, Damage, 1, 2, src)
				if(!knockback && !Substitution && Gates == 0 && Boulder == 0 && BoulderX == 0 && istype(a,/mob/Ice_Spike)&&src.Village!=A.Village&&name!="Zabuza"&&Attacked==0)
					new/obj/Hit(src.loc)
					var/Damage = 1
					Attacked = 1
					spawn(5) Attacked = 0
					if(src in inside(a)) Damage(A:Creator, Damage, 1, 0, src)
					else Damage(A:Creator, Damage, 1, 2, src)
				if(!knockback && !Substitution && Gates == 0 && Boulder == 0 && BoulderX == 0 && istype(a,/mob/Rock_Spike)&&src.Village!=A.Village&&name!="Tsuchikage"&&Attacked==0)
					var/Damage = 1.5
					Attacked = 1
					spawn(5) Attacked = 0
					if(src in inside(a)) Damage(A:Creator, Damage, 1, 0, src)
					else Damage(A:Creator, Damage, 1, 2, src)
				if(!knockback && !Substitution && Gates == 0 && Boulder == 0 && BoulderX == 0 && istype(a,/mob/Crystal_Spike)&&src.Village!=A.Village&&name!="Guren"&&Attacked==0)
					var/Damage = 1
					Attacked = 1
					spawn(5) Attacked = 0
					if(src in inside(a)) Damage(A:Creator, Damage, 1, 0, src)
					else Damage(A:Creator, Damage, 1, 2, src)
				if(!knockback && !Substitution && Gates == 0 && Boulder == 0 && BoulderX == 0 && istype(a,/mob/Rashomon)&&src.Village!=A.Village&&src.Boulder==0&&src.BoulderX==0&&src.Gates==0&&Attacked==0)
					var/Damage = 1.5
					Attacked = 1
					spawn(5) Attacked = 0
					if(src in inside(a)) Damage(A:Creator, Damage, 1, 0, src)
					else Damage(A:Creator, Damage, 1, 2, src)
				if(!knockback && !Substitution && Gates == 0 && Boulder == 0 && BoulderX == 0 && istype(a,/mob/Rashomon2)&&src.Village!=A.Village&&src.Boulder==0&&src.BoulderX==0&&src.Gates==0&&Attacked==0)
					var/Damage = 1.5
					Attacked = 1
					spawn(5) Attacked = 0
					if(src in inside(a)) Damage(A:Creator, Damage, 1, 0, src)
					else Damage(A:Creator, Damage, 1, 2, src)
				if(istype(a,/mob/Ultimate_Projectile))
					return
			if(d == LEFT || d == RIGHT)
				vel_x = 0
				if(Dashing) Itachi_Dash_Off()
			else vel_y = 0
			if(d == DOWN)
				if(Just_Fallen >= 30 && invisibility == 0) new/obj/Fall_Effect (loc, src)
				else Just_Fallen = 0

		Water_Drain()
			if(knocked) return

			if(Cha > 0)
				Cha -= 0.065
				Regenerate_Chakra --
				spawn(10) Regenerate_Chakra ++
			else
				Energy -= 0.100
				Regenerate_Chakra --
				Energy_Recover --
				spawn(10)
					Regenerate_Chakra ++
					Energy_Recover ++

			if(Energy <= 0)
				freeze ++
				Dragonned = 1
				stop()
				new/obj/Effects/Drown (loc, src)
				knocked = 1
				spawn(1.75)
					Dragonned = 0
					knocked = 0
					Flick("hurt", src)
					CanMove = 0
					invisibility = 101
					Substitution = 1
					density = 0
					HP = -100
					Deaths = 4
					Death_Check("Drown", 1)

		set_state()
			if(No_Icon) return

			Checks_Loc++
			if(Checks_Loc >= 3)
				if(name != "[key]" && Checked_X == 1 && Absorbed == 0)
					var/F = 0
					for(var/turf/W in obounds(src))
						if(!can_bump(W))
							if(W.Is_Water) Water_Drain()
							continue

						if(F == 0)
							F = 1
							Checks_Loc = 0
							stop()
							check_loc()
							if(Old_PX && Old_PY) set_pos(Old_PX, Old_PY)
							else Auto_Spawn()
							stop()
							check_loc()

					if(F == 0) {Old_PX = px; Old_PY = py}//Old_Loc_Real = loc

			if(Wall_Freeze)
				if(vel_y && !S_K_A)
					Wall_Freeze.icon_state = "wall-running"
					Energy -= 0.30
					Cha -= 0.15
				else
					Wall_Freeze.icon_state = "wall-standing"
					if(!S_K_A) Cha -= 0.50
				if(Cha <= 0)
					Cha = 0
					del(Wall_Freeze)
					return
				if(Energy <= 0)
					Energy = 0
					del(Wall_Freeze)
					return
				var/C
				if(dir == EAST) for(var/turf/Wall_Stand/a in right(1)) C++
				if(dir == WEST) for(var/turf/Wall_Stand/a in left(1)) C++
				if(Wall_Freeze.dir == NORTH || Wall_Freeze.dir == SOUTH)
					for(var/turf/T in bottom(2)) if(T.density)
						Wall_Freeze = null
						if(dir == EAST) dir = WEST
						else dir = EAST
						var/Dir = dir
						spawn() dir = Dir
						On_Wall = 0
				if(!C)
					if(Wall_Freeze.dir != SOUTH && Wall_Freeze.dir != NORTH) vel_y = 7
					else
						if(dir == EAST) dir = WEST
						else dir = EAST
						var/Dir = dir
						spawn() dir = Dir
					On_Wall = 1
					Wall_Freeze = null


			if(Substitution_Image)
				if(invisibility == 101) Substitution_Image.icon_state = icon_state
				else del(Substitution_Image)

			if(On_Wall > 0 && On_Wall < 16 && !Wall_Freeze) On_Wall --

			if(keys[controls.right] && !freeze && !knockback && !knocked && !On_Wall && Change_Direction && !Attacking && !GoingSage) dir = EAST
			if(keys[controls.left] && !freeze && !knockback && !knocked && !On_Wall && Change_Direction && !Attacking && !GoingSage) dir = WEST

			if(Icon_State) {icon_state = Icon_State; return}
			if(Chidori == "AK") {icon_state = "Raikiri"; return}

			if(Sharking)
				icon_state = "Shark"
				return

			if(knocked)
				icon_state = "Knocked"
				density = 0
				return

			if(Levitating)
				icon_state = "fly"
				Cha -= 0.20
				if(Cha <= 0)
					fall_speed = 25
					Check_Levitating()
				return

			if(freeze)
				if(GoingSage || Doming) return
				else
					icon_state = "mob-standing"
					return

			if(GoingSage == 1)
				if(name != "Jiraiya") icon_state = "mob-shooting"
				if(name == "Jiraiya") icon_state = "mob-sage"
				return

			if(knockback)
				icon_state = "mob-knockback"
				return

			if(Controlling)
				icon_state = "puppeteer"
				return

			if(Boulder)
				icon_state = "boulder2"
				return

			if(BoulderX)
				icon_state = "boulder"
				return

			if(Rasengan)
				if(Rasengan == "Kabuchimaru")
					icon_state = "Chusa Go"
					return
				else if(Rasengan == "Yondaime")
					icon_state = "Rasengan II"
					return

			if(vel_x != 0 && !Wall_Freeze)
				if(running)
					if(R_Effect >= 6 && invisibility == 0 && on_ground)
						if(dir == EAST && vel_x >= 8 || dir == WEST && vel_x <= -8)
							new/obj/Running_Effect (loc, src)
							R_Effect = 0
					R_Effect ++
					if(!on_ground) R_Effect = 7

					Energy -= 0.10
					if(Flag == 0)
						move_speed = speed_multiplier* 14
						if(ultra_speed == 0.5) move_speed = 1.25
						if(Gates==1)move_speed=30
						if(Boulder>=1)move_speed=50
						if(BoulderX>=1)move_speed=75
						if(Susanoo==1) move_speed= 11.5
					if(Flag == 1) move_speed = 12.5
					var/Percentage = 100*(HP/MaxHP)
					if(Percentage <= 70) move_speed /= 1.05
					if(Percentage <= 60) move_speed /= 1.05
					if(Percentage <= 50) move_speed /= 1.05
					if(Percentage <= 60) move_speed /= 1.05
					if(Percentage <= 70) move_speed /= 1.05
					if(Percentage <= 80) move_speed /= 1.05
					if(Percentage <= 90) move_speed /= 1.075
					if(!speed_multiplier) move_speed = 0
					if(Poison) move_speed -= 2.5
					move_speed *= Movement_Boost
					if(Energy <= 0)
						Energy = 0
						Run_Off()
				else Run_Off()

			if(on_ground) Double_Jump = 0

			if(!on_ground || Winded)
				if(vel_y > 0) icon_state = "mob-jumping"
				if(vel_y <= 0)
					icon_state = "mob-falling"
					Just_Fallen ++
				return

			if(!vel_x)
				icon_state = "mob-standing"
				if(Ino_NPC == 1) icon_state = "Control"
				return

			if(!running)
				if(freeze) icon_state = "mob-standing"
				if(!freeze) icon_state = "mob-moving"
				return

			if(running)
				if(freeze) icon_state = "mob-standing"
				if(!freeze) icon_state = "mob-running"
				return

		can_jump()
			if(Attacking || knockback || Controlling) return 0
			return on_ground

		jump()
			if(!Real && !client) return
			if(GoingSage||Attacking || knocked) return
			if(Controlling) return
			if(On_Wall == 20)
				Double_Jump = 0
				Wall_Freeze = null
				On_Wall = 7
				if(dir == EAST) vel_x = -15
				else vel_x = 15
				if(dir == EAST) dir = WEST
				else dir = EAST
				var/Dir = dir
				spawn() dir = Dir
				vel_y = 15
				if(Wall_Freeze) Wall_Freeze = null

			else
				Double_Jump = 0
				vel_y = 13
				if(z == 9) vel_y += 1

		double_jump()
			if(Energy < 2.5) return
			if(Levitating || GoingSage||Attacking || knockback || Controlling) return
			if(knocked) return

			if(E_Part == "Double Jump") Complete_Genin_Part()
			Energy -= 2.5
			Double_Jump ++
			if(!Substitution)
				var/J = new/obj/Double_Jump (src.loc)
				J:dir = dir
				J:layer = src.layer+1
				J:pixel_x = src.pixel_x+40
				if(dir == EAST) J:pixel_x -= 6
				J:pixel_y = src.pixel_y-15
			if(knockback==0)
				vel_y = 13
				if(z == 9 || z == 17) vel_y += 3


		move(d)
			if(Wall_Freeze)

				if(Wall_CD) return

				if(dir == EAST)
					if(d == EAST)
						if(Wall_Freeze.dir == EAST)
							if(vel_y < move_speed)
								vel_y += 3
								if(vel_y > move_speed) vel_y = move_speed
						Wall_Freeze.dir = EAST
					else if(d == WEST)
						if(Wall_Freeze.dir == SOUTH)
							if(vel_y > -move_speed)
								vel_y -= 3
								if(vel_y < -move_speed) vel_y = -move_speed
						Wall_Freeze.dir = SOUTH

				else if(dir == WEST)
					if(d == WEST)
						if(Wall_Freeze.dir == WEST)
							if(vel_y < move_speed)
								vel_y += 3
								if(vel_y > move_speed) vel_y = move_speed
						Wall_Freeze.dir = WEST
					else if(d == EAST)
						if(Wall_Freeze.dir == NORTH)
							if(vel_y > -move_speed)
								vel_y -= 3
								if(vel_y < -move_speed) vel_y = -move_speed

						Wall_Freeze.dir = NORTH


			else

				if(Controlling_Object) Controlling_(d)

				else if(d == DOWN && !Controlling_Object && !GoingSage)
					Fall_Special++
					spawn(4.5) Fall_Special --

				else if(d == RIGHT)
					if(vel_x < move_speed)
						vel_x += accel
						if(vel_x > move_speed) vel_x = move_speed

				else if(d == LEFT)
					if(vel_x > -move_speed)
						vel_x -= accel
						if(vel_x < -move_speed) vel_x = -move_speed

		gravity()
			if(on_ground || Attacking || Wall_Freeze) return
			vel_y -= gravity
			if(vel_y < -fall_speed) vel_y = -fall_speed

		action()
			if(input_lock) return
			if(!Wall_Freeze && !On_Wall)
				if(knockback == 0 && freeze == 0 && knocked == 0 && !Attacking || Controlling)
					if(keys[controls.right]) move(RIGHT)
					else if(keys[controls.left]) move(LEFT)
					if(keys[controls.down]) move(DOWN)
					if(Controlling) if(keys[controls.up]) move(UP)

			if(On_Wall && Wall_Freeze)

				if(!keys[controls.down] && !keys[controls.up])
					if(vel_y > decel) vel_y -= decel
					else if(vel_y < -decel) vel_y += decel
					else vel_y = 0

				if(keys[controls.down])
					On_Wall = 1
					Wall_Freeze = null
					if(dir == EAST) dir = WEST
					else dir = EAST
					var/Dir = dir
					spawn() dir = Dir
				if(Holding_X)
					if(keys[controls.right]) move(RIGHT)
					if(keys[controls.left]) move(LEFT)

			if(jumped)
				jumped = 0
				falling = 0
				if(On_Wall == 20) jump()
				else if(!can_jump() && Controlling == 0 && knockback == 0 && !knocked)
					if (!Double_Jump) double_jump()
					else if(Double_Jump == 1 && Jump_Boost) double_jump()
				else if(can_jump() && Controlling == 0 && knockback == 0 && !knocked) jump()

			slow_down()

		check_loc()
			if(x != last_x || y != last_y || z != last_z)
				set_pos(x * icon_width - pixel_x, y * icon_height, z)

		movement()
			if(Overlay) Overlays()
			set_state()

			if(!freeze || knocked)
				set_flags()
				gravity()
				if(client) action()
				pixel_move(vel_x, vel_y)
				if(Overlay) Overlays()

		slow_down()
			if(vel_x > move_speed) vel_x -= decel
			else if(vel_x < -move_speed) vel_x += decel
			else if(!keys[controls.right] && !keys[controls.left])
				if(vel_x > decel) vel_x -= decel
				else if(vel_x < -decel) vel_x += decel
				else vel_x = 0

		set_flags()
			on_ground = 0
			on_ceiling = 0
			on_left = 0
			on_right = 0

			// we make use of built-in procs but we also have to check for ramps
			for(var/atom/a in obounds(src, 0, -1, 0, -pheight + 1))
				if(!can_bump(a)) continue

				if(a.pleft != a.pright)
					if(py == a.height(px,py,pwidth,pheight))
						on_ground |= (1 | a.flags | a.flags_top)
				else
					if(py == a.py + a.pheight) on_ground |= (1 | a.flags | a.flags_top)

			// this still isn't perfect, but it's better. it's not
			// perfect because the bounding box is only offset, it's
			// not stretched.
			for(var/atom/a in obounds(src, -1, 0, -pwidth + 1, 0))
				// this needs to be fixed
				if(a.pleft != a.pright) if(px <= a.px + a.pwidth) continue
				if(can_bump(a)) on_left |= (1 | a.flags | a.flags_right)

			for(var/atom/a in obounds(src, pwidth, 0, -pwidth + 1, 0))
				if(a.pleft != a.pright) if(px >= a.px - pwidth) continue
				if(can_bump(a))
					on_right |= (1 | a.flags | a.flags_left)


mob
	proc
		Controlling_(var/d)
			var/mob/Controlling_Object_ = Controlling_Object
			Controlling_Object_.move_speed = 18
			Controlling_Object_.Being_Used ++

			if(d == RIGHT)
				Controlling_Object_.dir = EAST
				if(vel_x < 0) vel_x = 0
				if(Controlling_Object_.vel_x < Controlling_Object_.move_speed)
					Controlling_Object_.vel_x += Controlling_Object_.accel*5
					if(Controlling_Object_.vel_x > Controlling_Object_.move_speed) Controlling_Object_.vel_x = Controlling_Object_.move_speed

			else if(d == LEFT)
				Controlling_Object_.dir = WEST
				if(vel_x < 0) vel_x = 0
				if(Controlling_Object_.vel_x > -Controlling_Object_.move_speed)
					Controlling_Object_.vel_x -= Controlling_Object_.accel*5
					if(Controlling_Object_.vel_x < -Controlling_Object_.move_speed) Controlling_Object_.vel_x = -Controlling_Object_.move_speed

			if(d == UP)
				if(!keys[controls.right]  && !keys[controls.left]) Controlling_Object_.vel_x = 0
				if(Controlling_Object_.vel_y < 4)
					Controlling_Object_.vel_y += 15
					spawn(2.5) if(Controlling_Object_) Controlling_Object_.vel_y=0

			if(d == DOWN)
				if(!keys[controls.right]  && !keys[controls.left]) Controlling_Object_.vel_x = 0
				Controlling_Object_.vel_y = -10
				Controlling_Object_.Fall_Special++
				spawn(4.5) if(Controlling_Object_) Controlling_Object_.Fall_Special --
				spawn(2.5) if(Controlling_Object_) Controlling_Object_.vel_y=0

			spawn(1.5)
				if(!Controlling_Object_) return
				Controlling_Object_.Being_Used --
				if(!Controlling_Object_.Being_Used) Controlling_Object_.stop()

mob/var/Being_Used

client

	North() return 0
	South() return 0
	East() return 0
	West() return 0
	Southeast() return 0
	Southwest() return 0
	Northeast() return 0
	Northwest() return 0

mob/var/Fall_Special = 0
mob/var/Double_Jump = 0
mob/var/No_Icon = 0
mob/var/R_Effect


obj
	Double_Jump
		icon = 'Graphics/Double Jump.dmi'
		New()
			..()
			Flick("Go", src)
			spawn(3.5) del(src)

mob/var/Wall_CD = 0
mob/var/obj/Substitution_Image
mob/var/Just_Fallen
mob/var/Sharking
mob/var/S_K_A