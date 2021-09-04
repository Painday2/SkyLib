 --[[shovi
 tweak_data.projectiles.launcher_frag_arbiter.damage = 600	--M2018 Neru
 tweak_data.projectiles.launcher_frag_arbiter.player_damage = 10
 tweak_data.projectiles.launcher_rocket.player_damage = 10	--RPG player damage
 tweak_data.projectiles.fir_com.damage = 15	--Incendiary Grenade

 
 

 --Mr. Rays Gun
 tweak_data.projectiles.raygun_blast = deep_clone(tweak_data.projectiles.ecp_arrow_exp)
 tweak_data.projectiles.raygun_blast.damage = 300
 tweak_data.projectiles.raygun_blast.adjust_z = 0
 tweak_data.projectiles.raygun_blast.push_at_body_index = 0
 
 tweak_data.projectiles.raygun_blast_pap = deep_clone(tweak_data.projectiles.ecp_arrow_exp)
 tweak_data.projectiles.raygun_blast_pap.damage = 350
 tweak_data.projectiles.raygun_blast_pap.adjust_z = 0
 tweak_data.projectiles.raygun_blast_pap.push_at_body_index = 0
 
 ]]--
 --Power Up Table
  tweak_data.pickups.zm_pwrup_max_ammo = {
     unit = Idstring("units/pd2_mod_zombies/power_ups/zm_pwrup_max_ammo/zm_pwrup_max_ammo")
 }
  tweak_data.pickups.zm_pwrup_double_points = {
     unit = Idstring("units/pd2_mod_zombies/power_ups/zm_pwrup_double_points/zm_pwrup_double_points")
 }
  tweak_data.pickups.zm_pwrup_instakill = {
     unit = Idstring("units/pd2_mod_zombies/power_ups/zm_pwrup_instakill/zm_pwrup_instakill")
 }
  tweak_data.pickups.zm_pwrup_firesale = {
     unit = Idstring("units/pd2_mod_zombies/power_ups/zm_pwrup_firesale/zm_pwrup_firesale")
 }
  tweak_data.pickups.zm_pwrup_nuke = {
     unit = Idstring("units/pd2_mod_zombies/power_ups/zm_pwrup_nuke/zm_pwrup_nuke")
 }
  tweak_data.pickups.zm_pwrup_blood_money = {
     unit = Idstring("units/pd2_mod_zombies/power_ups/zm_pwrup_blood_money/zm_pwrup_blood_money")
 }
  tweak_data.pickups.zm_pwrup_zombie_blood = {
     unit = Idstring("units/pd2_mod_zombies/power_ups/zm_pwrup_zombie_blood/zm_pwrup_zombie_blood")
 }
  tweak_data.pickups.zm_pwrup_perk = {
     unit = Idstring("units/pd2_mod_zombies/power_ups/zm_pwrup_blood_money/zm_pwrup_blood_money")
 }