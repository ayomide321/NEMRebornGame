mob
	New_Puppets
		layer = 105
		_Special_Puppet_ = 1
		var/CanAttack_ = 1
		fall_speed = 20
		Real_Person = 1
		MaxHP = 45
		HP = 45
		Def = 7
		Real = 1
		Real_C = 0
		Checked_X = 1
		density = 1
		pwidth = 32
		var/mob/Executor
		var/mob/Target_
		var/Attack_Delay = 5.5
		var/Attack_Duration = 5

		New(loc, mob/_Executor)
			..()
			Executor = _Executor
			loc = Executor.loc
			dir = Executor.dir
			NEM_Round = Executor.NEM_Round
			NEM_Round.Puppets.Add(src)
			Village = Executor.Village
			set_pos (Executor.px, Executor.py)
			spawn()
				Start()
				Chase()

		proc/Start()
			..()
			loop
				if(Deleted) return
				var/_No_New_Target_ = 0
				var/list/Enemy = list()
				if(Target_) if(Target_.dead || Target_.Dragonned || abs(Target_.px -px) >= 500) {Target_.Puppets_Chasing.Remove(src); Target_ = null}
				if(!Target_)
					for(var/mob/M in oview(15)) if(length(M.Puppets_Chasing) < 1) Enemy.Add(M)
					if(Enemy.Find(Target_)) _No_New_Target_ = 1
					if(!_No_New_Target_)
						if(Target_.) Target_.Puppets_Chasing.Remove(src)
						Target_ = null
						for(var/mob/M in Enemy) if(!Target_ && M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && !M.knocked && M.Village != Village && !M.Dragonned && M.client) {Target_ = M; Target_.Puppets_Chasing.Add(src)}
				spawn(30) goto loop

		proc/Chase()
			..()
			loop
				if(Deleted) return
				if(!Target_)
					if(dir == EAST) vel_x = 15
					else vel_x = -15
				else
					if(!Target_.Dragonned && Target_.Real && !Target_.knocked && !freeze && !knockback)
						if(Target_.px - px >= 15) {vel_x = 15; dir = EAST}
						else if(Target_.px - px <= -15) {vel_x = -15; dir = WEST}
						if(Target_.py - py >= 8) {vel_y = 8; Fall_Special = 0}
						else if(Target_.py - py <= -8) {vel_y = -8; Fall_Special = 1}

						var/D = abs(Target_.px-px)
						if(CanAttack_ && D <= 96) _Attack_()
				spawn(2.5) goto loop

		proc/_Attack_()
			CanAttack_ = 0
			flick("Attack", src)
			spawn(Attack_Delay *3.5) CanAttack_ = 1
			spawn(Attack_Duration)
				if(!loc) return
				var/obj/Bounds/Bounds = new/obj/Bounds (loc, src, 45, 60)
				var/list/Enemy = Bounds.Enemy()

				for(var/mob/M in Enemy) if(M.Gates == 0 && M.Boulder == 0 && M.BoulderX == 0 && M.Real && !M.knocked && M.Village != Village && !M.Dragonned)
					if(M.Dodging == 1) M.Auto_Dodge (src)
					else
						var/Damage = 15- M.Def
						Damage += rand(5, 7.5)
						M.Damage(Executor, Damage, 1, 1, src, 1)

		bump(atom/A, d)
			if(d == RIGHT || d == LEFT)

				if(ismob(A))
					if(Target_ && Target_ == A) return
					var/mob/M = A
					if(M.Village != Village) vel_y = 12
					else if(CanAttack_ && Target_ && Target_ == M) _Attack_()
					else if(M.client && M.Village == Village)
						Substitution = 1
						alpha = 175
						spawn(8) {Substitution = 0; alpha = 255}
					else if(prob(25))
						if(on_ground) vel_y = 12
						else vel_y = -12
				else if(!Target_)
					if(d == LEFT) {dir = EAST; vel_x = abs(vel_x)}
					else {dir = WEST; vel_x = -vel_x}
		Del()
			if(NEM_Round) NEM_Round.Puppets.Remove(src)
			if(Target_) {Target_.Puppets_Chasing.Remove(src); Target_ = null}
			if(Deleted == 1) return
			if(Deleted == 2)
				..()
				return
			Del_Puppet()

		Puppet_I
			name = "Puppet"
			icon = 'Graphics/Skills/Puppet I.dmi'

		Puppet_II
			name = "Puppet"
			icon = 'Graphics/Skills/Puppet II.dmi'

		Puppet_III
			name = "Puppet"
			icon = 'Graphics/Skills/Puppet III.dmi'

mob/var/_Special_Puppet_ = 0
mob/var/list/Puppets_Chasing = list()