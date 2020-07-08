var/WorldSave=1
var/Clones=1
mob/var/CloneCD = 0
mob/var/Trial = 0
mob/var/DoujutsuCD = 0
//	<br><b><i>* Trial Admins: KiloJay, Ohadx & Kuramasnigga.</i>
mob/verb/Updates()
	var/window = {"<STYLE>BODY {scrollbar-DarkShadow-Color:#000000;scrollbar-Shadow-Color:#262626;scrollbar-base-color:#484848;scrollbar-arrow-color:#686868;background: black; color: white}</STYLE>
	<html>
	<body>
	<b><font size=3><center>- <u>Naruto: Eternal Memories' Updates Log</u></font> -</center></font size>
	<br>
	<br><font size=3>*<u> Version 1.0 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Game reborn by Dragon Pearl
	<br><b>- Everything is basically the same including admins and packs!
	<br>
	<br>
	<br><font size=3>*<u> Version 5.15 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Current Staff Team:</u> <i>Eternal Memories, TeenGogeta & Deathmall.</i>
	<br><b>- Villages & Organizations were updated!
	<br><b>- Mission NPCs' AI has been slightly improved!
	<br><b>- Konoha Stage has been slightly altered!
	<br><b>- Added S Rank Mission! {May contain bugs}
	<br><b>- Added D Rank Mission!
	<br><b>- Updated Rules!
	<br><b>- New Character Screen!
	<br><b>- Updated Shop's Prices!
	<br><b>- Now Ignore includes the person's computer id!
	<br><b>- Added Chat Functions! Type /help or /functions.
	<br><b>- Mute & Boot are only usable by Eternal Memories now.
	<br><b>- NPCs can no longer dodge while executing projectile jutsus.
	<br>
	<br>
	<br><font size=3>*<u> Version 5.10 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Missions.
	<br><b>- Added Chatrooms.
	<br><b>- Added Player Menu.
	<br><b>- Slightly nerfed Torune.
	<br><b>- Reduced binding jutsus' stun time.
	<br><b>- Adamantine Trap, Wood Binding and Fire Coffin are now dodgeable.
	<br><b>- Added Wood Dragon to Hashirama Senju!
	<br><b>- Added Water Prison to Kisame!
	<br><b>- Removed Trees Summoning!
	<br><b>- Removed Genin Exam & Chuunin Exam & Colosseum & Search.
	<br><b>- There were some unusual things that were crashing the server, fixed.
	<br><b>- Down Meele would let you go through jutsus such as Wood Pillar, fixed.
	<br><b>- Ryo is no longer randomly given while playing the game, you need to complete missions, win events, send useful advises, etc.
	<br><b><i>* People who helped with ideas & bug reports: TeenGogeta {thanks a lot for all the information related to missions!)</i>
	<br>
	<br>
	<br><font size=3>*<u> Version 5.05 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Updated Character Screen!
	<br><b>- Added a new meele attack, hold down while attacking on air :3
	<br><b>- You can now press right & left to explore character screen.
	<br><b>- Suika no Jutsu has been slightly nerfed.
	<br><b>- Fixed Doton Fist's animation.
	<br><b>- Fixed Tobi & Rinnegan Tobi.
	<br><b>- Akamaru & Trees Summoning can't be used anymore in Challenges.
	<br><b>- The bug causing random crashes has been hopefully fixed.
	<br><b><i>* People who helped with ideas & bug reports: TeenGogeta, Averie.David.</i>
	<br>
	<br>
	<br><font size=3>*<u> Version 5.00 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Medals were removed, they could increase the lag.
	<br><b>- Updated the Rounds System!
	<br><b><i>* You can now select which round to join!</i>
	<br><b><i>* This involved drastic changes, so it may contain bugs!</i>
	<br><b>- Updated Movement System (it should slightly reduce the lag!)
	<br><b>- Updated Advise System!
	<br><b><i>* You can now receive reputation as a reward!</i>
	<br><b>- You can no longer kill steal!
	<br><b><i>* I did some complex changes, so please don't ask for them, I can guarantee you this is the best way to tell who is the legit killer :P</i>
	<br><b>- Now you are immortal during 3 seconds after recovering from KO.
	<br><b>- Changed the Interface windows' locations!
	<br><b>- Updated Shop Window!
	<br><b>- Added Makibishi Spikes!
	<br><b>- Added Kunai Scrolls!
	<br><b><i>* To buy them you need the Kunai Scroll Perk!
	<br><b>* You can buy the perk in Colosseum Shop!</i>
	<br><b>- You can no longer use homings on people who aren't visible on your screen.
	<br><b>- Added three coloured pills to Choji!
	<br><b><i>* Thank you @MuraHoshi!</i>
	<br><b>- Updated Rotation & Sand Shield & Spinning Slash.
	<br><b><i>* Sand Shield recovers your health & stamina.
	<br><b>* Rotation & Spinning Slash deflect jutsus.
	<br><b>* All of them can be deactivated by pressing X.</i>
	<br><b>- Updated Tobirama Senju's Avatar!
	<br><b>- Added Water Uprising to Tobirama Senju!
	<br><b>- Added Ice Shield to Tobirama Senju!
	<br><b><i>* It works like Sand Shield!</i>
	<br><b>- Reduced speed on Snake Dash & Water Dash.
	<br><b>- Shinra Tensei no longer attacks Susanoo.
	<br><b>- Flame Tornado no longer deflects Hiraishin Kunai.
	<br><b>- Now clones get on cooldown when they die.
	<br><b>- You can no longer summon dead clones.
	<br><b>- Akamaru no longer disappears when he dies, you can summon him again.
	<br><b>- Wood Domed Wall displays a list now, no need to click anymore.
	<br><b>- Slightly nerfed Hinata.
	<br><b>- Fixed a lot of bugs!
	<br>
	<br>
	<br><font size=3>*<u> Version 4.95 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Updated Rules!
	<br><b><i>* Thank you @Hellokira!</i>
	<br><b>- Added Colosseum! :3
	<br><b><i>* Thank you @MuraHoshi!</i>
	<br><b>- Updated Knockback System.
	<br><b>- Updated jutsus like Rashomon, Wood Pillar, etc... Now it's harder to troll with them.
	<br><b>- Added Settings to Village Kages & Organization Leaders.
	<br><b>- The Reputation System will be changed in the future, the limit is now set to 40.
 	<br><b>- You can now join a Village/Organization if you meet it's requirements!
	<br><b>- Ino is now playable, but her Mind Transfer can be disabled by Eternal.
	<br><b>- Now Detachment of the Primitive_World costs less chakra!
	<br><b>- Buffed Minato Namikaze!
 	<br><b>- Buffed Jirobo!
	<br><b>- Fixed Rinnegan Tobi!
	<br><b>- Fixed Kakkou!
	<br>
	<br>
	<br><font size=3>*<u> Version 4.90 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Promoted PtvKiraSuicide & HelloKira!
	<br><b>- Added Gari!
	<br><b>- Added Ferocious Wind to Temari!
	<br><b>- Added Wind Sea Dragon to Temari!
	<br><b>- Added Ink Clone to Sai!
	<br><b>- Added Bug Clone to Shino!
	<br><b>- Added Earth Great Mud River to Tsuchikage!
	<br><b>- Added Kugutsu no Jutsu to Sasori! (Normal & Puppet Body Form)
	<br><b>- Added Wood Domed Wall to Yamato & Hashirama Senju!
	<br><b>- Added Bug Bullet to Shino!
	<br><b>- Added Wood Uprising to Yamato!
	<br><b>- Added Flying Swallow to Asuma!
	<br><b>- Added Explosive Kunai Throw to Hidan & Raikage!
	<br><b>- Slightly buffed HP on Juugo, Asuma & Kidoumaru.
	<br><b>- Updated Bug Storm!
	<br><b>- Buffed Hidan's stats.
	<br><b>- Buffed Temari's stats.
	<br><b>- Jiraiya charges his Rasengan faster now.
	<br><b>- Kisame will only drop his cloak after being knocked out twice.
	<br><b>- Made Resonating Shockwave dodgeable and made it cost less chakra.
	<br><b>- Kugutsu no Jutsu now creates less puppets if there's few enemies.
	<br><b>- Now Beast Tearing Gale Scratch & Beast Tearing Gale Palm share cooldown.
	<br><b>- Absolute Control can no longer be used when there's only 1 ninja on the other side.
	<br>
	<br>
	<br><font size=3>*<u> Version 4.85 </u></font>*</b></font size>
	<font size=2>
	<br><b>- XE Silentninja is now a Supreme Staff Member.
	<br><b>- TeenGogeta is now a Supreme Staff Member.
	<br><b>- Added Kyuubi Mode to Ginkaku & Kinkaku!
	<br><b>- Added UnCloaked Mode to Kisame!
	<br><b>- Remade Rock Lee's Gates!
	<br><b><i>* Thank you @Supevict!</i>
	<br><b>- Added Hiraishin Kunai to Yondaime!
	<br><b>- Added Hiraishin Ni No Dan to Yondaime!
	<br><b>- Added Flying Thunder God to Yondaime!
	<br><b><i>* Thank you @XE Silent Ninja!</i>
	<br><b>- Added Bijuu Dama to Ginkaku & Kinkaku's Kyuubi Mode!
	<br><b>- Updated Yondaime's Rasengan!
	<br><b>- Updated Rules!
	<br><b>- Remade Suigetsu!
	<br><b>- Added King of the Hill Mode!
	<br><b><i>* Thank you a lot @TeenGogeta!</i>
	<br><b>- Added Kirigakure No Jutsu to Zabuza!
	<br><b>- Updated Zabuza's Face!
	<br><b>- Added a new stage!
	<br><b>- Increased Phase's cooldown.
	<br><b>- Rain Bomb is now dodgeable.
	<br><b>- Tsukuyomi no Mikoto no longer knockbacks.
	<br><b>- Reboot Polls can only be made once every 30 minutes.
	<br><b>- Reboot Polls can no longer be made during Tourneys & Chuunin Exams.
	<br><b>- Inner Rage, Cherry Blossom Impact & Groundsmash share cooldown.
	<br><b>- Rasengan, Kyuubi Hand Crush & Kyuubi Claw share cooldown.
	<br><b>- Tsukuyomi no Mikoto & Amaterasu share cooldown.
	<br><b>- Sawarbi No Mai & Tessenka share cooldown.
	<br><b>- Nerfed Preta Path: Absorb!
	<br>
	<br>
	<br><font size=3>*<u> Version 4.80 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Chain Kunais to the Shop!
	<br><b><i>* T to throw, limited to 5 per round!</i>
	<br><b>- Added some cool effects! :3
	<br><b><i>* You can toggle their visibility through Settings!</i>
	<br><b>- The Following Staff Members were demoted: Gepas, PurpleLeaf, Doom2u.
	<br><b>- XE Silentninja was promoted to Staff Member.
	<br><b>- Replaced Vote with Poll {Not finished yet!}
	<br><b>- Sand Stage is no longer hosted when we have >15 players.
	<br><b>- Now when you don't have enough chakra to execute a jutsu the chakra bar shows you it's cost.
	<br><b>- Now energy bar glows when you're ready to dodge.
	<br><b>- Added Lucky Number!
	<br><b><i>* It's not completely finished yet!</i>
	<br><b>- Genin Exam has been remade! Kages can now host them!
	<br><b>- Added Pills!
	<br><b><i>* Thanks @TeenGogeta! You've helped a lot!</i>
	<br><b>- Kages/Leaders can select their daily pill.
	<br><b>- Updated Rules!
	<br><b><i>* Thanks to @Gepas.</i>
	<br><b>- Added Custom Team Deathmatch Mode!
	<br><b>- Added Anko!
	<br><b>- Added 5 seconds cooldown to Crow Genjutsu & Paper Clone.
	<br><b>- Underground Snake Swamp's Damage and Chakra Cost has been reduced.
	<br><b>- Characters could be hit while being attacked by Rockfall, fixed.
	<br><b><i>* Thanks @TeenGogeta!</i>
	<br><b>- Added Reputation to Statistics! 10*((Kills+KOs) /Times KO'd)
	<br><b>- Added Reputation to Villages & Organizations!
	<br><b><i>(Same formula, but it only counts the reputation from the time you joined it)</i>
	<br><b>- Villages & Organizations display their ranking now.
	<br><b><i>It's updated every time the main round ends.</i>
	<br><b>- Academy Students can now be kicked off Villages.
	<br><b>- Shikamaru can no longer be attacked while using Explosive Kunais.
	<br><b>- Players who have access to S Ranked Ninjas for free through special verbs can no longer use or share the same character the round after using or sharing it)
	<br><b><i>* This restriction has been implemented to balance the game a bit.</i>
	<br>
	<br>
	<br><font size=3>*<u> Version 4.75 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Updated Observe!
	<br><b>- Updated Staff Team!
	<br><b>- Added Sand Village Stage!
	<br><b>- Added Challenge! (It probably contains bugs!)
	<br><b>- Added Arena! (To train!)
	<br><b><i>This version isn't stable! So it may have MANY bugs!</i>
	<br><b>- Updated the Skin! (:
	<br><b>- Added Villages & Organizations!
	<br><b>- Replaced Statistics with Search.
	<br><b>- Now Observe displays the Target's HP, Chakra & Energy.
	<br><b>- Now you can decide what messages are shown on your Chat.
	<br><b>- Recover Formula has been updated.
	<br><b>- Updated Poison & Chakra Flow Stop on meele attacks, so they aren't so common (25%).
	<br><b>- Now you can dodge jutsus like Sand Manipulation, Basic Puppet, etc!
	<br><b>- Now running drains less energy.
	<br><b>- Fixed some bugs.
	<br>
	<br>
	<br><font size=3>*<u> Version 4.70 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Wall Running! (:
	<br><b><i>* Hold "x" to run.
	<br><b>Report any bug you find!</i>
	<br><b>- Updated Statistics!
	<br><b><i>We had to delete our previous saves, sorry!</i>
	<br><b>- Now you see yourself while using Substitution (others can't!)
	<br><b>- Updated Wind Wave & Water Vortex!
	<br><b>- Fixed Konan's Paper Tornado!
	<br><b>- Hit+execute jutsus would let you move while executing them right after doing a strong attack {right/left key +w/z}, fixed.
	<br><b>- You could be attacked while on Earth Dome, fixed.
	<br><b>- Rasengan & Water Bomb could break Ink Dragon, fixed.
	<br><b>- Kyuubi's & CS Sasuke's stats were slightly nerfed.
	<br><b>- Fixed more bugs...
	<br><b>
	<br><b><i><font size=3><u>* Your Advises! *</u><font size=2></i>
	<br><b>- Tayuya's Jutsus weren't increasing her assists, fixed.
	<br><b><i>* Thank you @Guess_VVhos_Back!</i>
	<br><b>- The temporal transformations would bug people sometimes after reverting, fixed.
	<br><b><i>* Thank you @Swordslash2000!</i>
	<br><b>- Uzumaki Barrage & Suffocating Papers were draining too much chakra when dodged, it's been edited so it's more balanced.
	<br><b><i>* Recommended by @Jasonsmith24lv!</i>
	<br><b>- Nerfed Sawarbi No Mai!
	<br><b><i>* Recommended by @TheGreatEscape.</i>
	<br>
	<br>
	<br><font size=3>*<u> Version 4.60 </u></font>*</b></font size>
	<font size=2>
	<br><b><i>Special Thanks To TeenGogeta!</i>
	<br><b>- Updated Logs!
	<br><b><i>Now regular players have access to Admin Logs!</i>
	<br><b>- To suggest ideas, report bugs/people, or whatever you need, use Advise!
	<br><b><i>Thank you @Deathmall!</i>
	<br><b>- Now you automatically observe a character when you click it while dead.
	<br><b>- Now an automated AFK Check happens on fighters who are chosen during Tourney.
	<br><b>- Now you can check someone's ryo through Statistics.
	<br><b>- Updated Crow Genjutsu's Animation.
	<br><b>- Staff Team has been updated.
	<br><b>- Added Darui!
	<br><b>- Added Omoi!
	<br><b>- Added Toad Flame Bullet to Sage Jiraiya!
	<br><b>- Added Lariat to Raikage!
	<br><b>- Added Endless Kicks to Raikage!
	<br><b>- Added Giant FireBall Summoning to Karin!
	<br><b>- Added Earth Eruption to Karin!
	<br><b>- Added Chakra Rush to Karin!
	<br><b>- Added Double Chakra Scalpel to Kabuto!
	<br><b>- Added Golden Kunai Slash to CS Kidoumaru!
	<br><b>- Added Spider Bind to Kidoumaru!
	<br><b>- Added Bullet Punch to CS Sakon!
	<br><b>- Added Bullet Punch to Sakon!
	<br><b>- Added Black Ant to Kankuro!
	<br><b>- Added Water Dragon to Itachi!
	<br><b>- Added Wind Wave to Zaku!
	<br><b>- Sawarbi No Mai's Animation has been updated!
	<br><b>- Sand Shield no longer allows people to use dash jutsus such as Rasengan on it.
	<br><b>- You will no longer get damaged by Rashomon, Wood Pillar, etc, when you walk into them while being in Substitution.
	<br><b>- Now Phase makes your icon a bit transparent, so it's noticeable.
	<br><b>- Now Lightning Release Armour is usable twice.
	<br><b>- Updated: Sound 4's & {PS} Sasuke's Curse Seal Transformations.
	<br><b><i>In exchange they don't get all Health & Chakra refilled.</i>
	<br><b>- Buffed: Raikage, Zetsu, Konan, Suigetsu, Zaku & Kin.
	<br><b>- Nerfed: Stun time was reduced to 2.5 seconds on: Chakra Rod, Adamantine Trap, Wood Binding & Fire Coffin.
	<br><b>
	<br><b><i><font size=3><u>* Your Advises! *</u><font size=2></i>
	<br><b>- Added Paper Clone to Konan!
	<br><b><i>* Thank you @Jsaicecream!</i>
	<br><b>- From now on you'll only dodge projectiles (like in the past) right after dodging a projectile, if you've dodged another attack the projectiles will hit you.
	<br><b><i>* Recommended by @Iam2Cold, people agreed on the Poll.</i>
	<br><b>- Added Assist(s) Performed to Scoreboard!
	<br><b><i>* Recommended by many players.</i>
	<br><b>- Tobi's Dodge Speed has been reduced to the normal one.
	<br><b><i>* Recommended by many players.</i>
	<br><b>- {PS) (Curse Seal) Sasuke's Energy was getting bugged after being knocked out while using Sharingan, fixed.
	<br><b><i>Thank you @Doom2u!</i>
	<br><b>- Now Flame Tornado isn't usable when there are more than 25 players online.
	<br><b><i>Thank you @Deathmall!</i>
	<br><b>- You can now use Observe instead of choosing a character.
	<br><b><i>* Recommended by many players.</i>
	<br><b>- Red Secret Technique could be used on people who were unattackable.
	<br><b><i>Thank you @Deathmall!</i>
	<br><b>- Susanoo's Crushing Grip freezes Eternal Sasuke now.
	<br><b><i>Recommended by @Ermehgerd Its Temari!</i>
	<br><b>- Increased Naruto's Stamina.
	<br><b><i>* Recommended by many players.</i>
	<br><b><u>I will try to add some of the suggestions you sent me through Advise soon.<br>I have been very busy because of the school, but wait til the week-end!</u> (:
	<br>
	<br>
	<br><font size=3>*<u> Version 4.55 </u></font>*</b></font size>
	<font size=2>
	<br><b><i>Special Thanks To TeenGogeta!</i>
	<br><b>- Fixed Shikamaru!
	<br><b>- Now some jutsus share their cooldown, so the gameplay is more balanced.
	<br><b>- Removed: Statistics Tab, it was useless, random ryo rewards were kept though.
	<br><b>- Updated: Meele System, Wind Storm can be used while on air now, Now Ink Dragon, Resonating Shockwave, Earthquake and Wood Binding display their cooldown!
	<br><b>- Nerfed: Shinra Tensei (slightly!), {PS} Sasuke's Jutsus weren't sharing any cooldown, Low-ranged jutsus could be executed right after jutsus like Dynamic Entry, now they share a small cooldown.
	<br><b>- Fixed: Torune could attack while using Venomous Insect Clone, Kiba could stay forever on air through Akamaru Transformation, Kimimaro could be attacked while using Teshi Sendan, Throw Rasenshuriken (it was reporting some errors), Illusionary Warriors Melody (it was freezing people when CS Tayuya died while executing it), Wind Storm (it was bugging projectiles).
	<br>
	<br>
	<br><font size=3>*<u> Version 4.50 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Assist.
	<br><b>- Added New Mode: Juggernaut.
	<br><b>- Removed Boss Mode.
	<br><b>- Updated Frozen Status, if you find any bug please report it!
	<br><b>- Updated Dodge!
	<br><b>- Added Special Event: Chuunin Exam!
	<br><b>- Now you receive 15 Ryo daily for being a Genin!
	<br><b>- Updated the Chat.
	<br><b>- Now you walk & run slower when your HP is low!
	<br><b>- Now the 1st Scoreboard Ninja gets 10 ryo when round's over!
	<br><b>- Updated Global Say.
	<br><b>- Low-ranged jutsus were incorrectly executed when there was a dense object behind you, now they'll work as they were meant to.
	<br><b>- Now you can change your jutsus' macros! (Only to numbers)
	<br><b><i>To do this press j!</i>
	<br><b>- Buffed Gates!
	<br><b>- Updated Guide!
	<br><b><i>Thank you Hellokira & Hebephile!</i>
	<br><b>- Added Report!
	<br><b>- The Staff Team has been updated!
	<br><b>- Guest Keys are no longer allowed now!
	<br><b>- Added One Thousand Years Of Pain to Kakashi!
	<br><b>- Added Doton F
	ist to Kakashi!
	<br><b>- Added Water Dragon to Kakashi!
	<br><b>- Added Primary Lotus to Kakashi!
	<br><b>- Updated low-ranged jutsus, now you won't execute them when there's a dense object on your way!
	<br><b>- Updated Genin Exam!
	<br><b>- Updated Primary Lotus!
	<br><b>- Added Wall Jump! (Press Shift/F to toggle!)
	<br><b>- Added Falling Animation!
	<br><b>- Added some visual effects (darkness, mist... only controlled by Presidents!)
	<br><b>- Updated Kakashi's left direction appareance!
	<br><b>- Updated Deidara's left direction appareance!
	<br><b>- Now AFK Check boots Admins during Tournaments!
	<br><b>- Capture The Flag has been temporarily disabled.
	<br><b>* Buffed: Kisame's stats, Ino no longer dies now when the person she manipulates gets ko'd during Mind Control.
	<br><b>* Improved: Primary Lotus, Snake Dash.
	<br><b>* Nerfed: Basic Puppet (Cooldown: 10 seconds), Lariat & Raikage Summoning (Now they share cooldown), Kyuubi Crush & Protection Of 64 Palms (Do less damage for less chakra), Nerfed Kyuubi & CS Sasuke HP, Sand Spikes is now dodgeable, Kakashi could use a low-ranged jutsu and Raikiri during knockback, Tayuya & her jutsus, Fire Tornadoes {can only be used once per round!}, Revolt Demon {no longer knockbacks!}, Palms {slightly!}
	<br><b>* Removed: Uchiha District Map.
	<br><b>* Bugs Fixed: People could use jutsus while transforming, I think Kakkou's Spinning Slash is finally fixed, Detachment of the Primitive World wouldn't damage, {PS} Curse Seal Sasuke couldn't activate Sharingan, Tournament Bets during 1vs1 rounds weren't working correctly, Konan's Paper Tornado wouldn't disappear when bumping into a wall.
	<br>
	<br>
	<br><font size=3>*<u> Version 4.45 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Special Event: Genin Exam!
	<br><b>- Due to Akamaru's errors, I've decided to make him act like the rest of NPCs.
	<br><b>- Updated the Skin!
	<br><b>- To change your name's text color go to Settings!
	<br><b>- Now Admins can decide how much time will the people be muted.
	<br><b>- Reduced Heal Range!
	<br><b>- Now Danzou is in Leaf and Haku is in Akatsuki!
	<br><b>- Added Ino! (Report any bug related to her awesome jutsu!)
	<br><b><i>She's not finished yet! We just updated to test her!</i>
	<br><b>- Changed Tobi's icon!
	<br><b>- Changed Hinata's icon!
	<br><b>- Updated Primary Lotus, now it's visually better.
	<br><b>- Updated Shadow Summoning!
	<br><b>- Updated Huge Fire Sphere!
	<br><b>- Updated Hinata's Air Palm!
	<br><b>- Added Shadow Sewing to Shikamaru!
	<br><b>- Added Shadow Neck Binding to Shikamaru!
	<br><b>- Added Ash Pile Burning to Asuma!
	<br><b>- Changed Madara & Tobi's Avatars!
	<br><b>- Added Gentle Fist to Neji!
	<br><b>- Added Rocket Punch to Hiruko!
	<br><b>- Added Drop Weights to Rock Lee!
	<br><b>- Added Clay Centipede to Deidara!
	<br><b>- Added Earth Wall to Hiruzen Sarutobi!
	<br><b>- Added Kyuubi Claw to Kyuubi Naruto!
	<br><b>- Added Kyuubi Hand Crush to Kyuubi Naruto!
	<br><b>- Added Phase to Tobi!
	<br><b>- Added Huge Fire Sphere to Tobi!
	<br><b>- Added Flame Imprisonment to Tobi!
	<br><b>- Added Flame Battle Encampment to Tobi!
	<br><b>- Added Fire Tornadoes to Tobi & Madara!
	<br><b>- Added Wood Stab to Madara!
	<br><b>- Added Wood Dragon to Madara!
	<br><b>- Added Heat Explosion to Madara!
	<br><b>- Added Great FireBall Shower to Madara!
	<br><b>- Added Great Fire Annihilation to Madara!
	<br><b>- Added Massive Flaming Shurikens to Itachi!
	<br><b>- Added Eight Trigrams: Protection Of The 64 Palms to Hinata!
	<br><b>- Added Jyuuken to Hinata!
	<br><b>- Buffed Hiruko's Speed.
	<br><b>- Now Hiruko, Kyuubi Naruto and CS Sasuke can restore.
	<br><b>- Gaara's HP & Defense has been nerfed a bit, he was too op.
	<br><b>- Manipulations (Puppets) have got their speed slightly nerfed.
	<br><b>- Snake Bite cooldown was bugged in some conditions, fixed.
	<br><b>- Tsukiyomi is no longer allowed during Tournaments.
	<br><b>- Projectiles were undodgeable, fixed.
	<br><b>- Fixed more lame bugs!
	<br><b><i>* Special Thanks To TeenGogeta For Helping So Much!
	<br><b>* Removed: Kyuubi Slash, Madara's Substitution,
	<br><b>* Nerfed: Ninja Hounds, Paper Throw + some others jutsus that didn't share the cooldown (most of them)!</i>
	<br><b>* Bugs Fixed: Chakra bar wasn't visible for some people, I think the projectile bug has been finally fixed, Kakkou's Spinning Slash has been updated, so it'll hopefully not bug anymore, in the past Clay Centipede could explode twice, Sasori could transform during Tourney, Deidara had incorrectly set his jutsus, Hinata's Jyuuken cooldown would increase to 27 seconds after using Air Palm, Neji had no cooldown on Air Palm after using Eight Trigrams: 64 Palms.
	<br>
	<br>
	<br><font size=3>*<u> Version 4.40 </u></font>*</b></font size>
	<font size=2>
	<br><b>- TeenGogeta is now a Supreme President!
	<br><b><i>Thank you a lot for the help!</i>
	<br><b>- Updated a bit the projectiles.
	<br><b>- Fixed some lag issues.
	<br><b>- Fixed many AOE bugs.
	<br><b>- Updated Graphics.
	<br><b>- Added Floating Sand Sphere to Gaara!
	<br><b>- Added Shukaku Claw to Gaara!
	<br><b>- Added Sand Crush to Gaara!
	<br><b>- Added Ink Eagle to Sai!
	<br><b>- Added Insect Sphere to Shino!
	<br><b>- Added Wind Release.- Great Breakthrough to Orochimaru.
	<br><b>- Added Kuchiyose No Jutsu.- Ninja Hounds to Kakashi.
	<br><b>- Added Two Rising Dragons to Tenten.
	<br><b>- Added Scythe Summon to Tenten.
	<br><b>- Updated Zabuza's Water Prison.
	<br><b>- Updated Tenten's Kunai Grenade.
	<br><b>- Sawarbi No Mai is now dodgeable!
	<br><b>- Poison has been remade.
	<br><b>- Added Flight to Tsuchikage.
	<br><b>- Substitution has been updated.
	<br><b>- Now Poison slows you down a bit.
	<br><b>- Added Suffocating Papers to Konan.
	<br><b>- Orochimaru and Torune are now immune to poison.
	<br><b>- Now transformations display the time they stay active.
	<br><b>- Now when you hit Orochimaru with melee, you will be poisoned.
	<br><b>- Attacks triggered with Byakugan will now stop your chakra regeneration.
	<br><b>- Now Sacrifice & Path Of Resurrection won't revive the same person twice.
	<br><b>- Puppets were updated, hopefully this'll fix the movement bug.
	<br><b>- Fixed Phase.
	<br><b>- Buffed Gates.
	<br><b>- Fixed Earth Spikes.
	<br><b>- Buffed Bone Bullets.
	<br><b>- Buffed Chakra Sphere.
	<br><b>- Nerfed Tayuya's jutsus.
	<br><b>- More bugs have been fixed ^^
	<br>
	<br>
	<br><font size=3>*<u> Version 4.35 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Updated AI!
	<br><b>- Fixed some bugs.
	<br><b>- Updated Sharingan & Byakugan!
	<br><b>- Nerfed Demonic Ice Crystal Mirrors.
	<br><b>- Updated low ranged jutsus. {Again}
	<br><b>- Fixed Sacrifice & Path Of Resurrection.
	<br><b>- Added Give Ryo to Shop.
	<br><b>- Improved Tourney Mode.
	<br><b>- Zetsu has been buffed.
	<br><b>- Give Orders was useless, so it's been removed.
	<br><b>- Sharingan and Byakugan display cooldown now.
	<br><b>- Tayuya has been added back.
	<br><b>- Nerfed Flaming Dragon.
	<br><b>- HUD has been removed.
	<br><b>- Added S-Ranked Ninjas to Shop.
	<br><b>- Earth Dome has been hopefully fixed.
	<br><b>- Added Cherry Blossom Groundsmash to Tsunade.
	<br><b>- Removed Recover HP and Recover Chakra.
	<br><b>- Some area jutsus are dodgeable now.
	<br><b>- Chances of being randomly rewarded with ryo are higher now.
	<br><b>- Updated AI, I hope NPCs work better now.
	<br><b>- Multikeying is no longer allowed.
	<br><b>- Updated Staff Team.
	<br><b>- Buffed Gates.
	<br><b>- Some important bugs were fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 4.30 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Nerfed Gates.
	<br><b>- Fixed Ink Dragon.
	<br><b>- Fixed Leaf Village Stage.
	<br><b>- Itachi Susanoo lasts longer now.
	<br><b>- Susanoo & Amaterasu have now cooldown.
	<br><b>- Tourney Mode has been updated.
	<br><b>- Now Tournament starts after 150 seconds.
	<br><b>- Now the projectiles don't slow down when they go through allies.
	<br><b>- Teleporting Jutsus are now disabled during CTF.
	<br><b>- Tenten and Shikamaru have been boosted.
	<br><b>- Some bugs were fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 4.25 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Quay400 has been banned forever. :)
	<br><b><i>This update has been brought to you by Eternal Memories!</i>
	<br><b>- Now NPCs move better on platforms.
	<br><b>- NPCs used to lag a lot, fixed.
	<br><b>- Attack was delayed, fixed.
	<br><b>- Some Homings were bugged, fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 4.15 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added * Special Achievements *!
	<br><b>- Added Shop!
	<br><b>- Added Ryo! (You can obtain it through Special Achievements).
	<br><b><i>* The new content is incomplete at the moment, but it will be updated in the future with tons of changes!</i>
	<br><b>- Fixed Leaf Hurricane & Primary Lotus!
	<br><b><i>Thank you @Angel_heat! (He reported it!)</i>
	<br><b>- Kimimaro has been slightly buffed!
	<br><b>- Fixed some bugs.
	<br>
	<br>
	<br><font size=3>*<u> Version 4.10 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Achievements! (You can toggle the messages!)
	<br><b>- Added Uchiha District!
	<br><b>- Added Buildings & Konoha Warehouse!
	<br><b><i>* To jump off the structures press down key.</i>
	<br><b>- Updated Our Character Screen, the new one is epic!
	<br><b><i>Thank you @GreatFisher! (He made it again!)</i>
	<br><b>- Sacrifice & Path Of Resurrection have been updated!
	<br><b><i>* They reduce your defense, but you recover it when they disappear.</i>
	<br><b><i>* They can't be used if there aren't dead people in your team.</i>
	<br><b><i>* They can be controlled when you are being attacked.</i>
	<br><b><i>* They have 90 seconds cooldown by default.</i>
	<br><b>- Improved a lot our AI System!
	<br><b>- Improved the following jutsus: Sand Manipulation, Kusanagi, Aggressive Bug Swarm, Kazekage Puppet Summon, Crow Puppet Summon, Salamander Puppet Summon & Basic Puppet Summon.
	<br><b>- Fixed many bugs!
	<br>
	<br>
	<br><font size=3>*<u> Version 4.00 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Updated Our Character Screen!
	<br><b><i>Thank you @GreatFisher! (He made it :3)</i>
	<br>
	<br>
	<br><font size=3>*<u> Version 3.90 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Now Log Summoning & Special Attack share a delay.
	<br><b>- Fixed some bugs.
	<br><b>- Added Ebisu!
	<br><b>- Buffed Konan a bit.
	<br><b>- Now when your HP is under 50% you move slower.
	<br><b>- Now you can double jump! :3
	<br><b>- Added Ignore!
	<br><b>- Added some HUD Buttons! You can toggle them :3
	<br><b>- Some times the people were getting stuck on the walls, fixed.
	<br><b>- Primary Lotus and Leaf Hurricane can no longer be used at the same time, they share a small cooldown.
	<br><b>- Reduced Curse Seal Jirobo's Brutal Tackle delay to 10 seconds.
	<br><b>- Reduced Kidoumaru's Spider Bind time to 3.5 seconds.
	<br><b>- Increased Meele's Knockback delay to 10 seconds.
	<br><b>- Meele does some more damage now.
	<br><b>- Tobirama Senju's Chakra was too high, it's been nerfed.
	<br><b><i>Thank you @Doom2u! (He reported all the bugs)</i>
	<br>
	<br>
	<br><font size=3>*<u> Version 3.80 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Kakkou!
	<br><b>- Quay400 has been promoted to Supreme President.
	<br><b>- Now you have to wait 3 seconds per knockback with meele.
	<br><b>- Fixed the issues with Auto-Save System.
	<br><b>- Updated Meele System a bit.
	<br><b>- Added Statistics.
	<br><b>- Fixed a bug related to login screen.
	<br><b>- Sacrifice & Path Of Resurrection no longer boosts.
	<br><b>- Now Jutsus Cooldown Is Visible!
	<br><b><i>This feature isn't finished yet, which means it isn't available in every jutsu, but it will be as soon as possible.</i>
	<br><b>- Air Palm, Inner Rage, Primary Lotus, Leaf Hurricane, and the rest of those kind of jutsus have been improved, they now drain /4 chakra when you don't hit anybody with them.
	<br><b>- Tayuya is currently disabled.
	<br><b>- Kakashi's chakra was boosted.
	<br><b>- Added Primary Lotus to Might Gai.
	<br><b><i>Thank you @Swordslash2000!</i>
	<br><b>- Added Mizukage!
	<br><b>- Fixed Shinra Tensei delay bug.
	<br><b>- Fixed Susanoo's Throw Arrow.
	<br><b>- Byakugan & Sharingan cooldown has been halved.
	<br><b>- Fixed the -no movement- bug.
	<br><b><i>Thank you so much @Math.W.Johnson!</i>
	<br><b>- Giant Rasengan was bugged, fixed.
	<br><b><i>Thank you, Kunwar1234!</i>
	<br><b>- Lee & Gai could use Gates after being mass revived, fixed.
	<br><b><i>Thank you, Kunwar1234!</i>
	<br><b>- PS Sasuke could use Lion Barrage during CS Mode, fixed.
	<br><b><i>Thank you, Kunwar1234!</i>
	<br><b>- Projectiles got improved!
	<br><b>- Fixed a visual bug.
	<br><b><i>Thank you, Supevict!</i>
	<br><b>- Fixed a bug related to Naruto.
	<br><b><i>Thank you, Kunwar1234!</i>
	<br><b>- Gates is no longer usable when you are a Guardian.
	<br><b>- Some features got updated.
	<br><b>- Fixed some bugs.
	<br><b>- Added Capture The Flag Event!
	<br><b>- Added cooldown to Resonating Shockwave.
	<br><b>- Increased Sound Spiral's cooldown.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.70 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Now Substitution allows you to bypass the enemy next to you
	<br><b>- Leaf Village Map will now show correctly.
	<br><b>- Added Sora!
	<br><b>- Added Kin!
	<br><b>- Added Aoi!
	<br><b>- Added Haku to Leaf!
	<br><b>- Added Shinra Tensei to Pein!
	<br><b>- Shikamaru has been totally remade!
	<br><b>- Added Puppet Body Form to Sasori on his last life.
	<br><b>- Ink Dragon Cooldown has been increased to 30 seconds.
	<br><b>- Kankuro's Speed got buffed.
	<br><b>- Buffed Ink Dragon.
	<br><b>- Fixed Kazekage Puppet.
	<br><b>- Fixed Sasori's Basic Puppet.
	<br><b>- Ink Lion got slightly nerfed.
	<br><b>- Primary Lotus got slightly buffed.
	<br><b>- Added a small cooldown to Ink Lion.
	<br><b>- People will no longer regenerate on Ink Dragon.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.60 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Clay Dove & Spider got slightly buffed.
	<br><b>- Now you can't become a Healer if the other team has less. Healers without the ability to revive count aswell unless they are dead.
	<br><b>- Now Healers lose their ability to revive after being killed (Including Sacrifice, Path Of Resurrection & Mass Heal).
	<br><b>- Now Healers can see how many people they can revive.
	<br><b>- Added Dosu!
	<br><b>- Added Zaku!
	<br><b>- Buffed Enma Summon.
	<br><b>- Skills like Sand Manipulation, Kusanagi, Bugs Swarm, and the others, will no longer get stuck.
	<br><b>- Some of the characters which were normally disabled during a Tournament have been added back.
	<br><b>- Obito's Flaming Dragon was lagging a lot and not showing, fixed.
	<br><b>- Manipulable skills can no longer hit more than twice per second.
	<br><b>- Added Create NPC to Eternal (Up to 20 characters with skills).
	<br><b>- Killing certain clones was bugging regeneration, fixed.
	<br><b>- Fixed a small issue with Automated Tournament System.
	<br><b>- The Clones are back, and they are much better now!
	<br><b>- Revival Melody has been deleted.
	<br><b>- Added Wind Tornado to Temari.
	<br><b>- Buffed Temari & her jutsus.
	<br><b>- Buffed Shino.
	<br><b>- Buffed Expand.
	<br><b>- Buffed Naruto Uzumaki Barrage.
	<br><b>- Akamaru wasn't dying, fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.50 </u></font>*</b></font size>
	<font size=2>
	<br><b>- This Server belongs to Eternal Memories.
	<br><b>- Tourneys were bugged, fixed.
	<br><b>- Optimized the game.
	<br><b>- Scoreboard no longer displays people on login screen.
	<br><b>- Buffed Tenten's speed.
	<br><b>- Automated Tournament.
	<br><b>- Updated Videos.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.40 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Might Gai wasn't showing in Auto-Balancer, fixd.
	<br><b>- Added a small delay to Air Palm.
	<br><b>- Tayuya was starting with 2 lives, fixed.
	<br><b>- Clones and NPCs have been disabled for now.
	<br><b>- I have changed things that should be fixing some lag.
	<br><b>- Fixed some bugs.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.30 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Now Neji & Hinata can absorb chakra while attacking with Byakugan active.
	<br><b>- Now Kisame can absorb chakra while attacking.
	<br><b>- Getting stuck is much harder now!
	<br><b>- Added Rules & Guide Commands.
	<br><b>- Jutsus like Air Palm, Primary Lotus, and some others won't freeze you anymore when failed to execute them.
	<br><b>- People marked as abusers can no longer vote.
	<br><b>- Added Warning System.
	<br><b>- People can now vote who to increase / decrease warning.
	<br><b>- Added a new command to Presidents & GMs: Mark Abuser.
	<br><b>- Added a new command to Presidents & GMs: UnMark Abuser.
	<br><b>- Added a new command to Presidents & GMs: Warning Increase.
	<br><b>- Added a new command to Presidents & GMs: Warning Decrease.
	<br><b>- Added a new command to Presidents & GMs: Warned People.
	<br><b>- Added a new command to Presidents & GMs: Warnings Log.
	<br><b>- Ninjas can no longer jump while manipulating.
	<br><b>- Removed Controls Tab.
	<br><b>- Replaced FAQs with Introduction.
	<br><b>- Lariat does no longer 1hit-KO.
	<br><b>- Added a delay to Explosive Kunai Throw & Crystal Shurikens.
	<br><b>- Now Hair Needles has cooldown.
	<br><b>- Now Hair Needles can be dodged.
	<br><b>- Now it takes longer to attack in air.
	<br><b>- Now you can jump higher while holding the key up (^).
	<br><b>- Now network delay is automatically set to 0 every few seconds.
	<br><b>- TeenGogeta is no longer president (players voted for it).
	<br><b>- Rain Bomb will no longer damage Neji while using rotation.
	<br><b>- Shino's Bug Swarm can no longer poison.
	<br><b>- I apologize for being unactive so much, I'm currently busy with school but I'll try to do interesting updates soon, thank you and report bugs to the HUB!
	<br><b>- Neo Rapes Everything is no longer Co-Owner, he has not been working in this project for months.
	<br><b>- Rate Server wasn't useful in the past, so it's been removed.
	<br><b>- OXuchihaXO has been banned for abusing.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.25 </u></font>*</b></font size>
	<font size=2>
	<br><b>- I don't remember why Zetsu had 3 lifes instead of 4, fixed.
	<br><b>- Healers can no longer dodge while reviving.
	<br><b>- Snake Bite will no longer poison dead people.
	<br><b>- People can no longer jump while controlling puppets.
	<br><b>- Increased Rasengan Quake's cooldown.
	<br><b>- Kusanagi has been nerfed.
	<br><b>- Fixed some minor bugs.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.20 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Rin was too op'd, so it's been nerfed a bit.
	<br><b>- Raikiri was undodgeable, fixed.
	<br><b>- Added Rin!
	<br><b>- Fire Coffin would freeze Kakuzu if his targets disconnected, it's been fixed. Thanks @LethalJaggedSpine.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.15 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Tsuchikage!
	<br><b>- Recover proc has been fixed.
	<br><b>- AFK Check has been updated.
	<br><b>- Kinkaku's Wind Storm was bugged, fixed.
	<br><b>- I made a mistake with Byakugan & Sharingan, now they really do boost all your HP, Chakra and Energy if you have them full.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.10 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Updated Voting System!
	<br><b>- Madara has been buffed!
	<br><b>- Added Raikage!
	<br><b>- Explosive Puppet & Kusanagi have been buffed.
	<br><b>- Hashirama Senju's Special Attack has been nerfed.
	<br><b>- Absorb Soul will no longer force you to observe Ginkaku.
	<br><b>- AFK Check wasn't working with people on Login Screen, it has been successfully fixed!
	<br><b>- The rounds weren't restarting if there were no characters when the character selection was closed, fixed.
	<br><b>- Leaf Village Vs Sound 5 Mode was old and useless, it's been completely removed from the game, it won't get added again.
	<br><b>- On Free For All Mode, when a team was empty it rebooted, it's been fixed so it only reboots when there's only a ninja left.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.05 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Paper Tornado was bugged, it's been successfully fixed.
	<br><b>- Konan has been completely remade!
	<br><b>- Added 60 seconds cooldown to Sharingan & Byakugan.
	<br><b>- Now Jutsu Tab will be automatically displayed after choosing a character, transformations will aswell.
	<br><b>- Byakugan & Sharingan will now boost all your health, chakra and energy if they are full before activating the doujutsu.
	<br><b>- Kunai Rush has been nerfed.
	<br>
	<br>
	<br><font size=3>*<u> Version 3.00 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added AFK Check!
	<br><b>- Choji could transform while using boulder, fixed.
	<br><b>- Ginkaku can no longer carry more than 5 souls at the same time, he can release them with his new jutsu though.
	<br><b>- There was a small bug related to Rashomon & Wood Pillar that was lagging a lot, it's been successfully fixed.
	<br><b>- The projectiles will from now on disappear when they hit Rashomon & Wood Pillar.
	<br><b>- Ginkaku can now release the souls he's absorbed.
	<br><b>- Ginkaku has been nerfed a bit (only his stats).
	<br><b>- Fixed a bug related to invisibility.
	<br><b>- Added cooldown to Giant FireBall.
	<br><b>- Added a new chracter, Guren!
	<br><b>- Added a new chracter, Ginkaku!
	<br><b>- Added a new chracter, Kinkaku!
	<br><b>- Revive was working with enemies, fixed.
	<br><b>- Now when you pick a character too fast you won't get stuck ;)
	<br><b>- There was a small bug that allowed people using Sacrifice to revive their absorbed allies, fixed.
	<br><b>- The ammount of revives an user did was being kept after the round has ended, it has been successfully fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.95 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Kaiten now takes less chakra, Neji & Hinata should be able to use it without having full chakra on Byakugan.
	<br><b>- Now Madara's jutsus will drain less chakra.
	<br><b>- Now Healers can only revive 5 times per round.
	<br><b>- Primary Lotus & Leaf Hurricane are meant to be fixed now.
	<br><b>- Crow Genjutsu couldn't be used when using Sharingan, fixed.
	<br><b>- Hidan won't be able to attack anymore while using Scythe Strike.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.90 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Send Comment was bugged, so now to suggest ideas, report abusers, or anything related to the game, post it on the <a href = http://www.byond.com/games/SilentWraith/NEM>HUB</a>.
	<br><b>- Now you can recover while using Byakugan/Sharingan, but it takes 3x time, so it'll take long for you to fully recover.
	<br><b>- Now after 10 minutes the round won't allow new people to pick a character until the round is over.
	<br><b>- Five Hungry Sharks was releasing 10 sharks instead of 5, fixed.
	<br><b>- Now Five Hungry Sharks & Phoenix Flower have cooldown.
	<br><b>- Jiraiya's Rasengan's effect didn't work, fixed. Thanks @Jokury.
	<br><b>- Now Path of Resurrection auto-kills Pein & boosts his allies.
	<br><b>- Added Butterfly Mode to Choji!
	<br><b>- Buffed Sasori's jutsus.
	<br><b>- Now Jutsu Tab will refresh everytime the round restarts.
	<br><b>- Buffed Primary Lotus, Leaf Hurricane & Hinata's stats.
	<br><b>- Added Admin Help, OOC & Who buttons to Skin.
	<br><b>- Now Konan's jutsu will stop after being knocked out.
	<br><b>- Rasengan Quake could be used after being knocked out, fixed.
	<br><b>- Susanoo wasn't usable after dying while transforming, fixed.
	<br><b>- Fixed (hopefully) a bug that was making people be stuck in air.
	<br><b>- Buffed Kakashi's stats.
	<br><b>- The following jutsus now require you to attack your enemy in order to be successfully executed: Wrath of Jashin, Scythe Strike, Kabuto's Special Attack, Hashirama Senju's Special Attack, Special Combo, Flaming Dragon & Lion Barrage.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.85 </u></font>*</b></font size>
	<font size=2>
	<br><b>- After dodging Kabuto's Special Attack people were getting immortality, fixed. Thanks @Dagare-Keren.
	<br><b>- Added Contact Eternal (it sends a message to Eternal).
	<br><b>- Buffed Might Gai & Rock Lee & Deidara.
	<br><b>- Enma Summon was bugged, fixed. Thanks @Monic.
	<br><b>- Kunai Grenade releases now +2 explosive kunais.
	<br><b>- There was a small bug related to auto-deflection, fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.80 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Raikiri can now be dodged.
	<br><b>- Kakuzu's stats have been buffed.
	<br><b>- Enma Summon & Explosive Kunais are dodgeable now.
	<br><b>- People can no longer be damaged during Enma's Attack.
	<br><b>- From now on Clones & Akamaru are automatically disabled during Tourney.
	<br><b>- Kirin could damage people using Gates & Boulder form, fixed. Thanks @TeenGogeta.
	<br><b>- OOC Chat no longer allows html. Thanks @TeenGogeta.
	<br><b>- People transforming can no longer move.
	<br><b>- The following jutsus are now dodgeable: Sand Manipulation, Explosive Puppet, Kusanagi and Crow Puppet, enjoy!
	<br><b>- Kankuro's puppet was poisoning even if you were immune, fixed! Thanks @Swordslash2000.
	<br><b>- Tobi can use dodge much faster than others and it drains /4.
	<br><b>- Fixed a bug that was draining everybody's energy.
	<br><b>- Fixed some bugs related to transformations.
	<br><b>- Sand Manipulation has been nerfed a bit.
	<br><b>- Some important & minor bugs have been fixed. Thanks @TeenGogeta.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.75 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Who Command.
	<br><b>- Removed some functions in order to reduce lag (Thanks Aron!)
	<br><b>- Fixed a small bug related to Hidan's jutsus cooldown.
	<br><b>- Rotation is now dodgeable.
	<br><b>- Now dodge effect lasts longer.
	<br><b>- You can now dodge some homing skills & tai skills.
	<br><b>- In order to talk with Admins you have to use Admin Help!
	<br><b>- Updated Skin!
	<br><b>- Added Scoreboard!
	<br><b>- Removed Say.
	<br><b>- Updated Recover Proc.
	<br><b>- Updated Speed's Formulas.
	<br><b>- Changed Byakugan's HP to Sharingan's HP.
	<br><b>- Fixed a small bug with regeneration, thanks @LethalJaggedSpine.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.70 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Fixed all the bugs related to Tourney!
	<br><b>- Now you can use Village Say to chat with your allies on Tourney.
	<br><b>- Transformations are now illegal on Tourney!
	<br><b>- Added 2 Vs 2 & 3 Vs 3 Mode to Tourneys!
	<br><b>- Now on tourney people have /2 lives!
	<br><b>- Added a new map (it's pretty simple).
	<br><b>- Fixed a bug related to Rasengan's effect.
	<br><b>- Added an Anti-Lag System, it can be toggled.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.65 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Now Admin's Messages will have a different colour.
	<br><b>- Added Double Rasengan to Sage Naruto.
	<br><b>- Added Throw Rasenshuriken to Sage Naruto!
	<br><b>- Added Rasengan Quake to Sage Naruto!
	<br><b>- Added Frogs Song to Sage Naruto!
	<br><b>- Added Revolt Of The Demon Realm to Tayuya!
	<br><b>- Sage Mode will only last from now on five minutes.
	<br><b>- Sage Mode is only usable 3 times per round.
	<br><b>- Trees spawn time has been halved.
	<br><b>- Collision isn't so lethal now.
	<br><b>- Updated Byakugan & Sharingan.
	<br><b>- Added Admin Help.
	<br><b>- Fixed Ink Dragon.
	<br><b>- Buffed Tsunade.
	<br><b>- Fixed some bugs.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.60 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Kabuto!
	<br><b>- Added Hashirama Senju!
	<br><b>- Added 1 minute cooldown to Wind Storm.
	<br><b>- Palm Wood Pillar & Snake Bite have been fixed.
	<br><b>- Now it's easier to get immune to Amaterasu.
	<br><b>- Increased Trees Summoning cooldown.
	<br><b>- Ink Dragon is now enabled & fixed.
	<br><b>- Reduced Kabuto's lifes to 2.
	<br><b>- Nerfed Kabuto's HP a bit.
	<br><b>- Buffed Water Dragon!
	<br><b>- Fixed immortal bug.
	<br><b>- Fixed few bugs.
	<br><b>- The objects that damage (Rashomon, Wood Pillar, etc) won't be hurting so much anymore.
	<br><b>- Special thanks to Jokury for contributing so much with the new characters, he's been really helpful!
	<br><b>- Mass Heal, Heal, Revive, Path Of Resurrection & Sacrifice will be from now on automatically disabled on Boss Mode.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.55 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Juugo has been completely remade!
	<br><b>- Brutal Impact was 1 Hit-KO, fixed.
	<br><b>- Some minor bugs have been fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.50 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Earth Dome to Jirobo!
	<br><b>- Added Killer Bee! (He's not finished yet)
	<br><b>- Improved knockback proc.
	<br><b>- Added UnMark Relogger to Admins.
	<br><b>- Added Manual Dodge! (Press D).
	<br><b>- Updated FAQs.
	<br><b>- Fixed some bugs.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.45 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Zetsu's clone will no longer teleport.
	<br><b>- Added Clone Jutsu to Naruto, Yamato & Kisame.
	<br><b>- Added Shuriken Shadow Clone to Sasori.
	<br><b>- Added 30 seconds cooldown to Water Prison.
	<br><b>- Fixed some Water Prison's bugs.
	<br><b>- Fixed a bug with clones.
	<br><b>- Buffed Sai & his jutsus.
	<br><b>- Buffed Kazekage Puppet.
	<br><b>- Fixed some bugs.
	<br><b>- Nerfed some homing attacks.
	<br><b>- Added cooldown to Rotation & Wind Shield.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.40 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Tsukuyomi to Itachi!
	<br><b>- Added Boss Guardians!
	<br><b>- Added Zabuza!
	<br><b>- Fixed Kyuubi Slash.
	<br><b>- Now Pein has 2 lifes.
	<br><b>- Buffed Gaara's stats & his jutsus.
	<br><b>- Buffed Yamato's defense & strength.
	<br><b>- Buffed Orochimaru's defense & strength.
	<br><b>- Added Snakes Summoning to Orochimaru!
	<br><b>- Added Snake Dash to Orochimaru!
	<br><b>- Added Rashomon to Orochimaru!
	<br><b>- Added Water Dragon to Zabuza!
	<br><b>- Changed Orochimaru's Snake's icon.
	<br><b>- Added Toggle Auto-Balancer to Hosters & Presidents.
	<br><b>- Karin could poison sometimes her own allies, fixed.
	<br><b>- Fixed Deidara Totem's bug.
	<br><b>- Fixed a Tayuya's bug.
	<br><b>- Fixed some minor bugs. (:
	<br><b>- Special Thanks to Dagare-Keren, Jokury, TeenGogeta & All Contributors for ideas & bug reports.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.35 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Zetsu!
	<br><b>- Added Throw Rasenshuriken to Naruto.
	<br><b>- Added Kyuubi Slash to (Kyuubi) Naruto.
	<br><b>- Now the Boss gets automatically immune to poison.
	<br><b>- Zetsu's Clone's Orders weren't working, fixed!
	<br><b>- Buffed Kyuubi Slash, it'll also work now.
	<br><b>- Zetsu's Clone Jutsu's name is now Split.
	<br><b>- Now Split takes half chakra and half HP.
	<br><b>- Zetsu's Clone imitates now his stats.
	<br><b>- Now Zetsu requires half HP to split.
	<br><b>- Nerfed Madara's starting chakra.
	<br><b>- Kiba's Jutsus Tab's been fixed.
	<br><b>- Now Flaming Dragon is homing.
	<br><b>- Buffed {PS} Kakashi's stats.
	<br><b>- Fixed Flaming Dragon bug.
	<br><b>- Nerfed Zetsu's Clones stats.
	<br><b>- Now Zetsu starts with /2 lifes.
	<br><b>- Now Flaming Dragon doesn't blind.
	<br><b>- Nerfed a bit Flaming Dragon.
	<br><b>- Added a 45 seconds cooldown to Split.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.30 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Obito!
	<br><b>- Added Free For All Mode!
	<br><b>- Now you can vote to change the round's mode to FFA!
	<br><b>- Some people were able to go Kyuubi / CS on Boss, fixed.
	<br><b>- Now on FFA Mode the ninjas only have 2 lifes!
	<br><b>- Fixed a bug that made Sasuke immortal.
	<br><b>- Now the Boss will recover less HP.
	<br><b>- Buffed Sand Manipulation.
	<br><b>- Fixed Wood Binding, it was binding the wrong team.
	<br><b>- Boss' HP Formula is now the ammount of people online*100.
	<br><b>- Now clay totem will not damage dead people, people on gates, etc...
	<br><b>- You can no longer mix modes' votations when one has already started.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.25 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Tournament Mode!
	<br><b>- Added Boss Mode!
	<br><b>- Now you can vote to have Boss Mode!
	<br><b>- Changed the way you see the game! (:
	<br><b>- Fixed a small bug on Character Selection.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.20 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Nerfed Mass Heal.
	<br><b>- Reduced Healer's HP (-25 HP).
	<br><b>- Now you become immune to poison after dying with it.
	<br><b>- Now Pein dies after his second usage of Path of Resurrection.
	<br><b>- Now you can interrupt a person who's reviving by damaging him/her.
	<br>
	<br>
	<br><font size=3>*<u> Version 2.15 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Jutsus Tab has been remade.
	<br><b>- Some minor bugs have been fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 1.90 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Underground Stage.
	<br><b>- Nerfed Tenten's jutsus.
	<br><b>- Fixed some bugs.
	<br>
	<br>
	<br><font size=3>*<u> Version 1.80 </u></font>*</b></font size>
	<font size=2>
	<br><b>- We've only kept Leaf Village Map, we'll add more soon.
	<br><b>- Fixed some bugs which caused some lag.
	<br><b>- Now you receive all your energy back after being revived.
	<br>
	<br>
	<br><font size=3>*<u> Version 1.70 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Pre-Shippuden Kakashi!
	<br><b>- Remade Leaf Village Stage!
	<br><b>- Fixed a bug which stopped various skills from being executed.
	<br><b>- Fixed a small bug related to Susanoo, thanks @EthemP.
	<br><b>- Fixed many bugs (:
	<br>
	<br>
	<br><font size=3>*<u> Version 1.60 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Pre-Shippuden Sasuke!
	<br><b>- Fixed some bugs related to the new systems.
	<br><b>- Now "knock out" message is also displayed.
	<br><b>- We've done some "fixes" on the maps.
	<br><b>- Now running drain less energy.
	<br><b>- Changed FPS from 30 to 25.
	<br>
	<br>
	<br><font size=3>*<u> Version 1.50 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Boot Key to GMs.
	<br><b>- Fixed Anti-Reloggers System.
	<br><b>- Remade almost all the jutsus!
	<br><b>- Remade the way the jutsus work!
	<br><b>- Now you'll see who's killed who!
	<br><b>- Now the jutsus pass through Owner's allies!
	<br><b>- Now Pein's Path Jutsus CD is higher!
	<br><b>- Wind Shield isn't spammeable anymore!
	<br><b>- Water Jutsus auto-killed, they've been fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version 1.30 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Fixed a bug which allowed reading your previous village's chat.
	<br><b>- Yondaime's Kunai will disappear after reboot.
	<br><b>- Now you won't keep Sharingan / Byakugan after reboot.
	<br><b>- The puppets didn't disappear while dead, now they do.
	<br><b>- Added Mass Heal to Tsunade.
	<br><b>- Nerfed Kirin, plus it has a cooldown now.
	<br><b>- You will start with max. lifes after auto-restart, thanks @Nxsinz!
	<br><b>- Maps switch now on the new system.
	<br><b>- Fixed one bug with recover process.
	<br><b>- Changed Auto-Reboot System... Please report any bug.
	<br>
	<br>
	<br><font size=3>*<u> Version 1.10 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added some special functions for Owner.
	<br><b>- Now Yamato starts with more chakra.
	<br>
	<br>
	<br><font size=3>*<u> Version 1.00 </u></font>*</b></font size>
	<font size=2>
	<br><b>- Removed Shadow Imitation! It was buggy as hell.
	<br><b>- Fixed a small bug with super jump's drain.
	<br><b>- Buffed normal jump on Boulder & Gates Mode.
	<br><b>- Added Shikamaru! (It hasn't been finished yet).
	<br><b>- Super Jump requires some energy now.
	<br><b>- Explosive Kunai Throw has been buffed.
	<br><b>- Gates auto-kills yourself after 3 minutes.
	<br><b>- If you hold "x" while jumping, it'll drain your energy.
	<br><b>- Explosive Kunai was sometimes stuck in map, it's been fixed.
	<br><b>- Added Explosive Kunai Throw to (Curse Seal) Sakon.
	<br><b>- Karin could poison enemies on Boulder & Gates Mode, it's been fixed.
	<br><b>- Even though Sakura's Groundsmash isn't a long-ranged attack, it'll shake your screen.
	<br><b>- Some minor bugs were fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- If you manage to survive for long when you are damaged by Amaterasu Flames, you can become immune to them.
	<br><b>- Now it's harder to dodge tsunamis.
	<br><b>- Removed Amaterasu from Tobi and added it to Sasuke.
	<br><b>- Updated Controls Tab.
	<br><b>- Bug Swarm moves faster now.
	<br><b>- Susanoo moves faster now.
	<br><b>- Susanoo's Arrow was bugged, it's been fixed.
	<br><b>- Added Toggle Poison, Amaterasu & Healers.
	<br><b>- Sharingan and Byakugan have /2 delay now.
	<br><b>- Added Sense to some characters.
	<br><b>- Revive takes now 2x chakra.
	<br><b>- Some bugs related to the maps were fixed.
	<br><b>- Sai's Snake could freeze allies, it doesn't anymore.
	<br><b>- There was a bug related to Kiba, thanks @Angel_Heat.
	<br><b>- Hidan could use his jutsus while dead... It's been fixed.
	<br><b>- People voted to remove Snow Stage, so done!
	<br><b>- We've added Myself Option to Observe.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Please welcome our new president, TeenGogeta!
	<br><b>- You can choose who to revive with Revival Melody.
	<br><b>- Enma Summon has been updated.
	<br><b>- Ninja Academy Stage has been added again.
	<br><b>- Kirin won't happen after being knocked out.
	<br><b>- Revival Melody is no longer allowed in Akatsuki Mode.
	<br><b>- Sai's Dragon will hopefully not bug people anymore.
	<br><b>- Fixed a small bug with Rashomon.
	<br><b>- Added Pwipe Command to Eternal.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Update Verb.
	<br><b>- Path of Resurrection can be used now twice per round.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- We've changed the HUB Password, we'll get rid of the useless server!
	<br><b>- There was a small bug with Warriors Melody, it's been fixed.
	<br><b>- Nerfed Sand Bullet!
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Ink Bird, enjoy Sai! (:
	<br><b>- Added three new skills to Yondaime!
	<br><b>- Added Sacrifice to Tsunade {it mass revives}!
	<br><b>- Nerfed Path of Resurrection to 1 per round!
	<br><b>- There was a small bug with bugs swarm effect, so it was fixed!
	<br><b>- Scythe Strike's cooldown has been increased.
	<br><b>- There were two small errors in two maps, thank you for reporting @TeenGogeta!
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Now you can vote to enable or disable auto-balancer!
	<br><b>- Snake moves faster now, it'll hopefully help Sai!
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Primary Lotus & Leaf Hurricane could TK, they've been fixed.
	<br><b>- Scythe Strike has been nerfed, it does less damage now.
	<br><b>- Clay Totem, Tsunami & Bug Storm have a decent delay now.
	<br><b>- Clay Dove & Clay Spider have been buffed.
	<br><b>- If the round is unbalanced, you'll be forced to choose the village with less ninjas.
	<br><b>- We've added a small system which verifies if a Server is marked as illegal, if it's often on HUB and it can't be played, it'll be probably added to the list of illegal servers by Eternal.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Now you can add yourself as Hoster if you host on a Shell Server.
	<br><b>- We've removed TK, please report any bug!
	<br><b>- Amaterasu can team kill, it's meant to work that way.
	<br><b>- Now you won't stay forever on Boulder Mode, it stops after 30 seconds.
	<br><b>- Added Wind Storm to Temari.
	<br><b>- Nerfed Chidori Stream.
	<br><b>- Fixed a bug with Naruto's Kyuubi Mode.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Now Hidan has +2 lives.
	<br><b>- Scythe Strike was reported by a player, we don't know if it's been completely fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Hidan Character!
	<br><b>- Now Kiba can select who to attack with Akamaru.
	<br><b>- Sharingan & Byakugan will be auto-deactivated after being ko'd.
	<br><b>- Fixed a bug which created immense lag due to an error on AI System.
	<br><b>- Special thanks to Deal166 for reporting some bugs.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Kiba Character!
	<br><b>- Added Whisper Command to Verified Players.
	<br><b>- Added Disable Poison Option to Vote.
	<br><b>- Added Disable Amaterasu Option to Vote.
	<br><b>- Poisoning an enemy is harder now.
	<br><b>- Rasengan's Effect won't happen so often, it's random now.
	<br><b>- You can transform into Susanoo as Itachi much faster now.
	<br><b>- Added a longer cooldown to Rock Lee & Might Gai Jutsus.
	<br><b>- Your movement will be resetted after being auto-unstuck.
	<br><b>- You won't be able to whisper / vote as a relogger.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Send Comment Command.
	<br><b>- Added Cancel Option to Vote.
	<br><b>- Now Susanoo fits well with it's size.
	<br><b>- Fixed a small issue with the locked characters.
	<br><b>- Fixed a minor bug which only allowed CS once per round.
	<br><b>- We've changed Ninja Academy to Snow Stage, now it's bigger.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Itachi, Yondaime, Danzou and Tobirama Senju aren't auto-unlocked for all the people.
	<br><b>- To unlock them, please check FAQs. We are often updating the list.
	<br><b>- Fixed Global Bans & added Global Confirmed Players.
	<br><b>- Some minor bugs were fixed.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Danzou.
	<br><b>- Added a new effect to Rasengan.
	<br><b>- Removed the time needed to execute Open Gates.
	<br><b>- Removed the time needed to executed Summon Hiruko.
	<br><b>- Now Tayuya's Curse Seal shares her Warriors Melody Cooldown, so she won't be able to abuse.
	<br>
	<br>
	<br><font size=3>*<u> Version ??? </u></font>*</b></font size>
	<font size=2>
	<br><b>- Added Global Bans.
	<br><b>- Now you receive alerts before executing special jutsus.
	<br><b>- Buffed Kyuubi Naruto & CS Sasuke.
	<br><b>- The NPCs have been fixed."}
	usr << browse(window,"window=Updates;size=525x375")