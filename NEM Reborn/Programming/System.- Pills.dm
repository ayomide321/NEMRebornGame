mob/var
	Pills = 3
	obj/Pill/Pill
	obj/Effects/Pill_Aura/Pill_Aura
	HP_Boost = 1
	Jump_Boost
	Delay_Boost
	Ryo_Boost = 1
	Movement_Boost = 1
	Substitution_Delay_Boost = 1
	Substitution_Duration_Boost
	Immune_To_Poison
	Immune_To_Amaterasu

obj
	Pill
		var/mob/Belongs_To
		var/Level
		var/Active

		proc

			End_Pill()
				Active = 0
				del(Belongs_To.Pill_Aura)
				if(Belongs_To.client)
					winset(Belongs_To, "default.Pills_Activity", "text='* Inactive *'")
					winset(Belongs_To, "default.Pills_Time", "text=''")
				if(Belongs_To.Pills == 0) del(src)

			Consume()
				if(!Belongs_To.Pills || Active) return
				Active = 1
				Belongs_To.Pill_Aura = new/obj/Effects/Pill_Aura (Belongs_To.loc, Belongs_To)
				if(name == "Blood") Belongs_To.Pill_Aura.icon *= "#C00000"
				else if(name == "Height") Belongs_To.Pill_Aura.icon *= "#55D5FF"
				else if(name == "Delay") Belongs_To.Pill_Aura.icon *= "#32C900"
				else if(name == "Stealth") Belongs_To.Pill_Aura.icon *= "#D2D2D2"
				else if(name == "Energy") Belongs_To.Pill_Aura.icon *= "#DAA804"
				else if(name == "Immunity") Belongs_To.Pill_Aura.icon *= "#B524D2"
				Belongs_To.Pills --
				if(Belongs_To.client)
					winset(Belongs_To, "default.Pills_Activity", "text='* Active *'")
					winset(Belongs_To, "default.Pills_Left", "text='[Belongs_To.Pills]'")

				if(name == "Delay")

					var/Duration
					Belongs_To.Delay_Boost = 1
					if(Level == 1) Duration = 20
					else if(Level == 2) Duration = 40
					else if(Level == 3) Duration = 60

					loop
						if(Duration)
							if(Belongs_To.client) winset(Belongs_To, "default.Pills_Time", "text='[Duration]'")
							spawn(10) {Duration -= 1; goto loop}
						else {Belongs_To.Delay_Boost = 0; End_Pill()}

				else if(name == "Stealth")

					var/Duration
					if(Level == 1) {Belongs_To.Substitution_Delay_Boost = 1.15; Belongs_To.Substitution_Duration_Boost = 0.50; Duration = 45}
					else if(Level == 2) {Belongs_To.Substitution_Delay_Boost = 1.20; Belongs_To.Substitution_Duration_Boost = 1; Duration = 60}
					else if(Level == 3) {Belongs_To.Substitution_Delay_Boost = 1.25; Belongs_To.Substitution_Duration_Boost = 1.50; Duration = 75}

					loop
						if(Duration)
							if(Belongs_To.client) winset(Belongs_To, "default.Pills_Time", "text='[Duration]'")
							spawn(10) {Duration -= 1; goto loop}
						else {Belongs_To.Substitution_Delay_Boost = 1; Belongs_To.Substitution_Duration_Boost = 0; End_Pill()}

				else if(name == "Immunity")
					var/Duration
					var/IA
					var/IP
					if(Level == 1) Duration = 20
					else if(Level == 2) Duration = 25
					else if(Level == 3) Duration = 30
					if(Belongs_To.Immune_To_Amaterasu) IA = 1
					if(Belongs_To.Immune_To_Poison) IP = 1
					Belongs_To.Immune_To_Amaterasu = 1
					Belongs_To.Immune_To_Poison = 1

					loop
						if(Duration)
							if(Belongs_To.client) winset(Belongs_To, "default.Pills_Time", "text='[Duration]'")
							spawn(10) {Duration -= 1; goto loop}
						else
							if(!IP) Belongs_To.Immune_To_Amaterasu = 0
							if(!IA) Belongs_To.Immune_To_Poison = 0
							End_Pill()

				else if(name == "Blood")
					var/Duration
					if(Level == 1) {Belongs_To.HP_Boost = 1.25; Duration = 15}
					else if(Level == 2) {Belongs_To.HP_Boost = 1.35; Duration = 20}
					else if(Level == 3) {Belongs_To.HP_Boost = 1.45; Duration = 25}

					loop
						if(Duration)
							if(Belongs_To.client) winset(Belongs_To, "default.Pills_Time", "text='[Duration]'")
							spawn(10) {Duration -= 1; goto loop}
						else {Belongs_To.HP_Boost = 1; End_Pill()}

				else if(name == "Height")
					var/Duration
					if(Level == 1) Duration = 30
					else if(Level == 2) Duration = 40
					else if(Level == 3) Duration = 50
					Belongs_To.Jump_Boost = 1

					loop
						if(Duration)
							if(Belongs_To.client) winset(Belongs_To, "default.Pills_Time", "text='[Duration]'")
							spawn(10) {Duration -= 1; goto loop}
						else {Belongs_To.Jump_Boost = 0; End_Pill()}

				else if(name == "Energy")
					var/Duration
					var/Energy_Boost
					if(Level == 1) {Belongs_To.Movement_Boost = 1.15; Duration = 10; Energy_Boost = 15}
					else if(Level == 2) {Belongs_To.Movement_Boost = 1.25; Duration = 15; Energy_Boost = 25}
					else if(Level == 3) {Belongs_To.Movement_Boost = 1.35; Duration = 20; Energy_Boost = 35}
					Belongs_To.Energy += Energy_Boost
					if(Belongs_To.Energy > Belongs_To.MaxEnergy) Belongs_To.Energy = Belongs_To.MaxEnergy

					loop
						if(Duration)
							if(Belongs_To.client) winset(Belongs_To, "default.Pills_Time", "text='[Duration]'")
							spawn(10) {Duration -= 1; goto loop}
						else {Belongs_To.Movement_Boost = 1; End_Pill()}


			Update()
				if(!Belongs_To.client) return
				winset(Belongs_To, "default.Pills_Time", "text=''")

				if(name == "Stealth")
					var/Substitution_Delay_Boost
					var/Substitution_Duration_Boost
					if(Level == 1) {Substitution_Delay_Boost = 1.15; Substitution_Duration_Boost = 0.50}
					else if(Level == 2) {Substitution_Delay_Boost = 1.20; Substitution_Duration_Boost = 1}
					else if(Level == 3) {Substitution_Delay_Boost = 1.25; Substitution_Duration_Boost = 1.50}
					var/Delay_Boost = (Substitution_Delay_Boost -1) *100
					winset(Belongs_To, "default.Pills_Description", "text=[url_encode("Substitution:\n\nLasts +[Substitution_Duration_Boost] second(s)\nCooldown decreases [Delay_Boost]%")]")

				else if(name == "Blood")
					var/HP_Boost
					if(Level == 1) HP_Boost = 1.25
					else if(Level == 2) HP_Boost = 1.35
					else if(Level == 3) HP_Boost = 1.45
					var/_Boost_ = (HP_Boost -1)*100
					winset(Belongs_To, "default.Pills_Description", "text='+[_Boost_]% HP Regeneration'")

				else if(name == "Energy")
					var/Movement_Boost
					var/Energy_Boost
					if(Level == 1) {Movement_Boost = 1.15; Energy_Boost = 15}
					else if(Level == 2) {Movement_Boost = 1.25; Energy_Boost = 25}
					else if(Level == 3) {Movement_Boost = 1.35; Energy_Boost = 35}
					var/_Boost_ = (Movement_Boost -1)*100
					winset(Belongs_To, "default.Pills_Description", "text='+[_Boost_]% Movement Speed\n+[Energy_Boost] Stamina'")

		//		else if(name == "Golden")
		//			if(Level == 1) Belongs_To.Ryo_Boost = 1.5
		//			else if(Level == 2) Belongs_To.Ryo_Boost = 2
		//			else if(Level == 3) Belongs_To.Ryo_Boost = 2.5
		//			var/_Boost_ = (Belongs_To.Ryo_Boost -1) *100
		//			winset(Belongs_To, "default.Pills_Description", "text='+[_Boost_]% Ryo Rewards'")
		//			winset(Belongs_To, "default.Pills_Activity", "text='* Active *'")
		//			winset(Belongs_To, "default.Pills_Time", "text=''")
		//			winset(Belongs_To, "default.Pills_Left", "text=''")
		//			Belongs_To.Pills = 0

				else if(name == "Immunity") winset(Belongs_To, "default.Pills_Description", "text='Immune to Amaterasu\nImmune to Poison'")
				else if(name == "Height") winset(Belongs_To, "default.Pills_Description", "text='+1 Extra Jump'")
				else if(name == "Delay") winset(Belongs_To, "default.Pills_Description", "text='-25% Cooldown'")

				winset(Belongs_To, "default.Pills_Name", "is-visible=true")
				winset(Belongs_To, "default.Pills_Name", "is-visible=true")
				winset(Belongs_To, "default.Pills_Area", "is-visible=true")
				winset(Belongs_To, "default.Pills_Activity", "is-visible=true")
				winset(Belongs_To, "default.Pills_Activity", "is-visible=true")
				winset(Belongs_To, "default.Pills_Left", "is-visible=true")
				winset(Belongs_To, "default.Pills_Left", "is-visible=true")
				winset(Belongs_To, "default.Pills_Time", "is-visible=true")
				winset(Belongs_To, "default.Pills_Time", "is-visible=true")
				winset(Belongs_To, "default.Pills_Background", "is-visible=true")
				winset(Belongs_To, "default.Pills_Activity_Background", "is-visible=true")
				winset(Belongs_To, "default.Pills_Description", "is-visible=true")
				winset(Belongs_To, "default.Pills_Description", "is-visible=true")
				winset(Belongs_To, "default.Pills_Description_Background", "is-visible=true")

		Del()
			if(Belongs_To.Pill_Aura) del(Belongs_To.Pill_Aura)
			if(Belongs_To.client)
				winset(Belongs_To, "default.Pills_Name", "is-visible=false")
				winset(Belongs_To, "default.Pills_Name", "is-visible=false")
				winset(Belongs_To, "default.Pills_Area", "is-visible=false")
				winset(Belongs_To, "default.Pills_Activity", "is-visible=false")
				winset(Belongs_To, "default.Pills_Activity", "is-visible=false")
				winset(Belongs_To, "default.Pills_Left", "is-visible=false")
				winset(Belongs_To, "default.Pills_Left", "is-visible=false")
				winset(Belongs_To, "default.Pills_Time", "is-visible=false")
				winset(Belongs_To, "default.Pills_Time", "is-visible=false")
				winset(Belongs_To, "default.Pills_Background", "is-visible=false")
				winset(Belongs_To, "default.Pills_Activity_Background", "is-visible=false")
				winset(Belongs_To, "default.Pills_Description", "is-visible=false")
				winset(Belongs_To, "default.Pills_Description", "is-visible=false")
				winset(Belongs_To, "default.Pills_Description_Background", "is-visible=false")
			..()

		New(mob/O, var/Name, Amount)
			..()
			name = Name
			Belongs_To = O
			Belongs_To.Pill = src
			Belongs_To.Pills = Amount
			var/Reputation = O.Statistic.Reputation
			if(Reputation < 25) Level = 1
			else if(Reputation >= 25 && Reputation <50) Level = 2
			else Level = 3

			if(Belongs_To.client)
				winset(Belongs_To, "default.Pills_Name", "text='[Name] Pill'")
				winset(Belongs_To, "default.Pills_Left", "text='[Belongs_To.Pills]'")
				winset(Belongs_To,"default.Pills_Activity", "text='* Inactive *'")
				winset(Belongs_To, "default.Pills_Time", "text=''")

				if(Name == "Blood")
					winset(Belongs_To, "default.Pills_Name", "background-color=\"#5A0000\"")
					winset(Belongs_To, "default.Pills_Name", "text-color=\"#AF0000\"")
					winset(Belongs_To, "default.Pills_Area", "background-color=\"#2D0000\"")
					winset(Belongs_To, "default.Pills_Activity", "background-color=\"#410000\"")
					winset(Belongs_To, "default.Pills_Activity", "text-color=\"#AF0000\"")
					winset(Belongs_To, "default.Pills_Left", "background-color=\"#2D0000\"")
					winset(Belongs_To, "default.Pills_Left", "text-color=\"#7D0000\"")
					winset(Belongs_To, "default.Pills_Time", "background-color=\"#2D0000\"")
					winset(Belongs_To, "default.Pills_Time", "text-color=\"#7D0000\"")
					winset(Belongs_To, "default.Pills_Background", "background-color=\"#4B0000\"")
					winset(Belongs_To, "default.Pills_Activity_Background", "background-color=\"#4B0000\"")
					winset(Belongs_To, "default.Pills_Description", "background-color=\"#190000\"")
					winset(Belongs_To, "default.Pills_Description", "text-color=\"#7D0000\"")
					winset(Belongs_To, "default.Pills_Description_Background", "background-color=\"#4B0000\"")

				else if(Name == "Delay")
					winset(Belongs_To, "default.Pills_Name", "background-color=\"#00C800\"")
					winset(Belongs_To, "default.Pills_Name", "text-color=\"#37FF37\"")
					winset(Belongs_To, "default.Pills_Area", "background-color=\"#004B00\"")
					winset(Belongs_To, "default.Pills_Activity", "background-color=\"#00AF00\"")
					winset(Belongs_To, "default.Pills_Activity", "text-color=\"#37FF37\"")
					winset(Belongs_To, "default.Pills_Left", "background-color=\"#004B00\"")
					winset(Belongs_To, "default.Pills_Left", "text-color=\"#008200\"")
					winset(Belongs_To, "default.Pills_Time", "background-color=\"#004B00\"")
					winset(Belongs_To, "default.Pills_Time", "text-color=\"#008200\"")
					winset(Belongs_To, "default.Pills_Background", "background-color=\"#005F00\"")
					winset(Belongs_To, "default.Pills_Activity_Background", "background-color=\"#005F00\"")
					winset(Belongs_To, "default.Pills_Description", "background-color=\"#002D00\"")
					winset(Belongs_To, "default.Pills_Description", "text-color=\"#008200\"")
					winset(Belongs_To, "default.Pills_Description_Background", "background-color=\"#005F00\"")

				else if(Name == "Stealth")
					winset(Belongs_To, "default.Pills_Name", "background-color=\"#AFAFAF\"")
					winset(Belongs_To, "default.Pills_Name", "text-color=\"#E1E1E1\"")
					winset(Belongs_To, "default.Pills_Area", "background-color=\"#5F5F5F\"")
					winset(Belongs_To, "default.Pills_Activity", "background-color=\"#9B9B9B\"")
					winset(Belongs_To, "default.Pills_Activity", "text-color=\"#E1E1E1\"")
					winset(Belongs_To, "default.Pills_Left", "background-color=\"#5F5F5F\"")
					winset(Belongs_To, "default.Pills_Left", "text-color=\"#878787\"")
					winset(Belongs_To, "default.Pills_Time", "background-color=\"#5F5F5F\"")
					winset(Belongs_To, "default.Pills_Time", "text-color=\"#878787\"")
					winset(Belongs_To, "default.Pills_Background", "background-color=\"#787878\"")
					winset(Belongs_To, "default.Pills_Activity_Background", "background-color=\"#787878\"")
					winset(Belongs_To, "default.Pills_Description", "background-color=\"#373737\"")
					winset(Belongs_To, "default.Pills_Description", "text-color=\"#878787\"")
					winset(Belongs_To, "default.Pills_Description_Background", "background-color=\"#787878\"")

				else if(Name == "Immunity")
					winset(Belongs_To, "default.Pills_Name", "background-color=\"#7D00FF\"")
					winset(Belongs_To, "default.Pills_Name", "text-color=\"#B46EFF\"")
					winset(Belongs_To, "default.Pills_Area", "background-color=\"#460096\"")
					winset(Belongs_To, "default.Pills_Activity", "background-color=\"#6E00DC\"")
					winset(Belongs_To, "default.Pills_Activity", "text-color=\"#B46EFF\"")
					winset(Belongs_To, "default.Pills_Left", "background-color=\"#460096\"")
					winset(Belongs_To, "default.Pills_Left", "text-color=\"#7300E6\"")
					winset(Belongs_To, "default.Pills_Time", "background-color=\"#460096\"")
					winset(Belongs_To, "default.Pills_Time", "text-color=\"#7300E6\"")
					winset(Belongs_To, "default.Pills_Background", "background-color=\"#5500AF\"")
					winset(Belongs_To, "default.Pills_Activity_Background", "background-color=\"#5500AF\"")
					winset(Belongs_To, "default.Pills_Description", "background-color=\"#280050\"")
					winset(Belongs_To, "default.Pills_Description", "text-color=\"#7300E6\"")
					winset(Belongs_To, "default.Pills_Description_Background", "background-color=\"#5500AF\"")

				else if(Name == "Height")
					winset(Belongs_To, "default.Pills_Name", "background-color=\"#0F87FF\"")
					winset(Belongs_To, "default.Pills_Name", "text-color=\"#8CC8FF\"")
					winset(Belongs_To, "default.Pills_Area", "background-color=\"#004691\"")
					winset(Belongs_To, "default.Pills_Activity", "background-color=\"#006EDC\"")
					winset(Belongs_To, "default.Pills_Activity", "text-color=\"#8CC8FF\"")
					winset(Belongs_To, "default.Pills_Left", "background-color=\"#004691\"")
					winset(Belongs_To, "default.Pills_Left", "text-color=\"#005ABE\"")
					winset(Belongs_To, "default.Pills_Time", "background-color=\"#004691\"")
					winset(Belongs_To, "default.Pills_Time", "text-color=\"#005ABE\"")
					winset(Belongs_To, "default.Pills_Background", "background-color=\"#0055AF\"")
					winset(Belongs_To, "default.Pills_Activity_Background", "background-color=\"#0055AF\"")
					winset(Belongs_To, "default.Pills_Description", "background-color=\"#001E46\"")
					winset(Belongs_To, "default.Pills_Description", "text-color=\"#005ABE\"")
					winset(Belongs_To, "default.Pills_Description_Background", "background-color=\"#0055AF\"")

				else if(Name == "Energy")
					winset(Belongs_To, "default.Pills_Name", "background-color=\"#964B00\"")
					winset(Belongs_To, "default.Pills_Name", "text-color=\"#C86400\"")
					winset(Belongs_To, "default.Pills_Area", "background-color=\"#5F3200\"")
					winset(Belongs_To, "default.Pills_Activity", "background-color=\"#874100\"")
					winset(Belongs_To, "default.Pills_Activity", "text-color=\"#C86400\"")
					winset(Belongs_To, "default.Pills_Left", "background-color=\"#5F3200\"")
					winset(Belongs_To, "default.Pills_Left", "text-color=\"#9B4B00\"")
					winset(Belongs_To, "default.Pills_Time", "background-color=\"#5F3200\"")
					winset(Belongs_To, "default.Pills_Time", "text-color=\"#9B4B00\"")
					winset(Belongs_To, "default.Pills_Background", "background-color=\"#7D3C00\"")
					winset(Belongs_To, "default.Pills_Activity_Background", "background-color=\"#7D3C00\"")
					winset(Belongs_To, "default.Pills_Description", "background-color=\"#371900\"")
					winset(Belongs_To, "default.Pills_Description", "text-color=\"#9B4B00\"")
					winset(Belongs_To, "default.Pills_Description_Background", "background-color=\"#7D3C00\"")

		/*		else if(Name == "Golden")
					winset(Belongs_To,"default.Pills_Activity", "text='* Active *'")
					winset(Belongs_To, "default.Pills_Name", "background-color=\"#C8C800\"")
					winset(Belongs_To, "default.Pills_Name", "text-color=\"#FFFFD7\"")
					winset(Belongs_To, "default.Pills_Area", "background-color=\"#878700\"")
					winset(Belongs_To, "default.Pills_Activity", "background-color=\"#B9B900\"")
					winset(Belongs_To, "default.Pills_Activity", "text-color=\"#FFFFD7\"")
					winset(Belongs_To, "default.Pills_Left", "background-color=\"#878700\"")
					winset(Belongs_To, "default.Pills_Left", "text-color=\"#B9B900\"")
					winset(Belongs_To, "default.Pills_Time", "background-color=\"#878700\"")
					winset(Belongs_To, "default.Pills_Time", "text-color=\"#B9B900\"")
					winset(Belongs_To, "default.Pills_Background", "background-color=\"#A5A500\"")
					winset(Belongs_To, "default.Pills_Activity_Background", "background-color=\"#A5A500\"")
					winset(Belongs_To, "default.Pills_Description", "background-color=\"#4B4B00\"")
					winset(Belongs_To, "default.Pills_Description", "text-color=\"#B9B900\"")
					winset(Belongs_To, "default.Pills_Description_Background", "background-color=\"#A5A500\"")*/

				Update()