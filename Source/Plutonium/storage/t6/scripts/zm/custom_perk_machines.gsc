#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes_zm/_hud_util;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_stats;
#include maps/mp/gametypes_zm/_spawnlogic;
#include maps/mp/animscripts/traverse/shared;
#include maps/mp/animscripts/utility;
#include maps/mp/zombies/_load;
#include maps/mp/_createfx;
#include maps/mp/_music;
#include maps/mp/_busing;
#include maps/mp/_script_gen;
#include maps/mp/gametypes_zm/_globallogic_audio;
#include maps/mp/gametypes_zm/_tweakables;
#include maps/mp/_challenges;
#include maps/mp/gametypes_zm/_weapons;
#include maps/mp/_demo;
#include maps/mp/gametypes_zm/_hud_message;
#include maps/mp/gametypes_zm/_spawning;
#include maps/mp/gametypes_zm/_globallogic_utils;
#include maps/mp/gametypes_zm/_spectating;
#include maps/mp/gametypes_zm/_globallogic_spawn;
#include maps/mp/gametypes_zm/_globallogic_ui;
#include maps/mp/gametypes_zm/_hostmigration;
#include maps/mp/gametypes_zm/_globallogic_score;
#include maps/mp/gametypes_zm/_globallogic;
#include maps/mp/zombies/_zm;
#include maps/mp/zombies/_zm_ai_faller;
#include maps/mp/zombies/_zm_spawner;
#include maps/mp/zombies/_zm_pers_upgrades_functions;
#include maps/mp/zombies/_zm_pers_upgrades;
#include maps/mp/zombies/_zm_score;
#include maps/mp/animscripts/zm_run;
#include maps/mp/animscripts/zm_death;
#include maps/mp/zombies/_zm_blockers;
#include maps/mp/animscripts/zm_shared;
#include maps/mp/animscripts/zm_utility;
#include maps/mp/zombies/_zm_ai_basic;
#include maps/mp/zombies/_zm_laststand;
#include maps/mp/zombies/_zm_net;
#include maps/mp/zombies/_zm_audio;
#include maps/mp/gametypes_zm/_zm_gametype;
#include maps/mp/_visionset_mgr;
#include maps/mp/zombies/_zm_equipment;
#include maps/mp/zombies/_zm_power;
#include maps/mp/zombies/_zm_server_throttle;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_zonemgr;
#include maps/mp/zombies/_zm_perks;
#include maps/mp/zombies/_zm_melee_weapon;
#include maps/mp/zombies/_zm_audio_announcer;
#include maps/mp/zombies/_zm_magicbox;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/zombies/_zm_ai_dogs;
#include maps/mp/gametypes_zm/_hud_message;
#include maps/mp/zombies/_zm_game_module;
#include maps/mp/zombies/_zm_buildables;
#include codescripts/character;
#include maps/mp/zombies/_zm_weap_riotshield;
#include maps/mp/zombies/_zm_ai_sloth;
#include maps/mp/zombies/_zm_ai_sloth_ffotd;
#include maps/mp/zombies/_zm_ai_sloth_utility;
#include maps/mp/zombies/_zm_ai_sloth_magicbox;
#include maps/mp/zombies/_zm_ai_sloth_crawler;
#include maps/mp/zombies/_zm_ai_sloth_buildables;

init()
{
		
	precacheshader("menu_mp_lobby_icon_film");
	precacheshader( "menu_mp_lobby_icon_customgamemode" );
	precacheshader( "waypoint_revive" );
	precacheshader( "killiconheadshot" );
	precacheshader( "menu_lobby_icon_twitter" );
	precacheshader( "menu_mp_weapons_1911" );
	precacheshader( "menu_zm_weapons_shield" );
	precacheshader( "menu_mp_lobby_icon_screenshot" );
	precacheshader( "zom_icon_minigun" );
	precacheshader( "damage_feedback" ); 
	precacheshader( "zombies_rank_1" );
	precacheshader( "zombies_rank_1_ded");
	precacheshader( "zombies_rank_3" );
	precacheshader( "zombies_rank_2" );
	precacheshader( "zombies_rank_4" );
	precacheshader( "zombies_rank_4_ded");
	precacheshader( "zombies_rank_5" );
	precacheshader( "zombies_rank_5_ded");
	precacheshader( "menu_mp_weapons_xm8" );
	precacheshader( "menu_mp_weapons_minigun" );
	precacheshader( "menu_mp_lobby_icon_highlight" );
	precacheshader( "faction_cdc" ); 
	precacheshader( "menu_mp_weapons_hamr" ); 
	precacheshader( "zombies_rank_5" );
	precacheshader( "hud_grenadeicon" );
	precacheshader( "specialty_instakill_zombies" );
	precacheshader( "menu_mp_weapons_1911" );
	precacheshader( "hud_icon_colt" );
	precachemodel("p6_zm_buildable_sq_meteor");
	precachemodel( "collision_player_wall_512x512x10" );
	precachemodel( "collision_physics_512x512x10" );
	precachemodel( "t5_foliage_tree_burnt03" );
	precachemodel( "p_rus_door_roller" );
	precachemodel( "ch_tombstone1" );
	precachemodel( "collision_geo_256x256x10_standard" );
	precachemodel( "specialty_divetonuke_zombies");
	precachemodel( "zombie_vending_tombstone_on" );
	precachemodel( "zombie_vending_revive_on" );
	precachemodel( "zombie_vending_sleight_on" );
	precachemodel( "zombie_vending_doubletap2_on" );
	precachemodel( "p6_zm_vending_vultureaid_on" );
	precachemodel( "zombie_vending_marathon_on" );
	precachemodel( "zombie_pickup_perk_bottle" );
	precachemodel( "zm_collision_perks1" );
	level._effect["fx_zombie_cola_revive_on"] = loadfx( "misc/fx_zombie_cola_revive_on" );
	level._effect["fx_zombie_cola_dtap_on"] = loadfx( "misc/fx_zombie_cola_dtap_on" );
	level._effect["fx_zombie_cola_on"] = loadfx( "misc/fx_zombie_cola_on" );
	level.effect_WebFX = loadfx("misc/fx_zombie_powerup_solo_grab");
	if (  !(  getdvar("mapname") == "zm_buried" || getdvar("mapname") == "zm_tomb"  )  )
	{
		level._effect["fx_default_explosion"] = loadfx( "explosions/fx_default_explosion" );
	}
	else
	{
		level._effect["fx_default_explosion"] = level._effect["divetonuke_groundhit"];
	}
	
	level thread onPlayerConnect();
	level thread perk_machine_removal( "specialty_scavenger" );
	init_custom_map(); 

	level.get_player_weapon_limit = ::custom_get_player_weapon_limit;
	level.zombie_last_stand = ::LastStand;
	level.custom_vending_precaching = ::default_vending_precaching;
	level.original_damagecallback = level.callbackactordamage;
	level.callbackactordamage = ::actor_damage_override_wrapper;
	register_player_damage_callback( ::damage_callback );

	


   
	level.player_out_of_playable_area_monitor = 0;
	level.perk_purchase_limit = 50;
	
} 
	
	
onPlayerConnect()
{
	while ( 1 )
	{
		level waittill( "connected", player);
		player thread onPlayerSpawned();
	}
}
onPlayerSpawned()
{
	self endon( "disconnect" );
	level endon( "game_ended" );
	self waittill( "spawned_player" );
	self.perkarray = [];
	self.dying_wish_on_cooldown = 0;
	self.thunder_wall_on_cooldown = 0;
	self.rampage_on_cooldown = 0;
	self.rampage = 0;
    self.perk_reminder = 0;
    self.perk_count = 0;
    self.num_perks = 0;
	self thread removeperkshader();
    self thread perkboughtcheck();
	self thread damagehitmarker();
	
}





damagehitmarker()
{
	self thread startwaiting();
	self.hitmarker = newdamageindicatorhudelem( self );
	self.hitmarker.horzalign = "center";
	self.hitmarker.vertalign = "middle";
	self.hitmarker.x = -12;
	self.hitmarker.y = -12;
	self.hitmarker.alpha = 0;
	self.hitmarker setshader( "damage_feedback", 24, 48 );

}
	
	
startwaiting()
{
	while( 1 )
	{
		foreach( zombie in getaiarray( level.zombie_team ) )
		{
			if( !(IsDefined( zombie.waitingfordamage )) )
			{
				zombie thread hitmark();
			}
		}
		wait 0.25;
	}
}


hitmark()
{
	self endon( "killed" );
	self.waitingfordamage = 1;
	while( 1 )
	{
		self waittill( "damage", amount, attacker, dir, point, mod );
		attacker.hitmarker.alpha = 0;
		if( isplayer( attacker ) )
		{
			if( isalive( self ) )
			{
				attacker.hitmarker.color = ( 1, 1, 1 );
				attacker.hitmarker.alpha = 1;
				attacker.hitmarker fadeovertime( 1 );
				attacker.hitmarker.alpha = 0;
			}
			else
			{
				attacker.hitmarker.color = ( 1, 0, 0 );
				attacker.hitmarker.alpha = 1;
				attacker.hitmarker fadeovertime( 1 );
				attacker.hitmarker.alpha = 0;
				self notify( "killed" );
			}
		}
	}
}	

init_custom_map()
{
	if( getdvar( "mapname" ) == "zm_transit" && getdvar( "g_gametype" ) == "zstandard")
	{
		//Town
		//Bookstore
		perk_system( "script_model", (847, -1037, 120), "zombie_vending_revive_on", ( 0, 326, 0 ), "custom", "mus_perks_sleight_sting", "Downer's Delight", 3000, "revive_light", "Downers_Delight","zombie_perk_bottle_revive" );
		//Laundry Door
		perk_system( "script_model", (1851, -810, -55), "zombie_vending_jugg_on", ( 0, 180, 0 ), "custom", "mus_perks_sleight_sting", "Rampage", 10000, "jugger_light", "Rampage","zombie_perk_bottle_jugg" );
		//West Town, infront of bookstore
		perk_system( "script_model", (488, -281, -62), "zombie_vending_marathon_on", ( 0, 45, 0 ), "custom", "mus_perks_sleight_sting", "PhD Flopper", 5000, "marathon_light", "PHD_FLOPPER","zombie_perk_bottle_marathon" );
		//North Town corner
		perk_system( "script_model", (2002, 844, -56), "zombie_vending_sleight_on", ( 0, 270, 0 ), "custom", "mus_perks_sleight_sting", "Electric Cherry", 3000, "revive_light", "ELECTRIC_CHERRY","zombie_perk_bottle_sleight" );
		//North Town wall
		perk_system( "script_model", (1131, 613, -50), "zombie_vending_sleight_on", ( 0, 90, 0 ), "custom", "mus_perks_sleight_sting", "Guarding Strike", 10000, "sleight_light", "Guarding_Strike","zombie_perk_bottle_sleight" );
		//Bar Ground door
		perk_system( "script_model", (1846, 680, -55), "zombie_vending_revive_on", ( 0, 0, 0 ), "custom", "mus_perks_sleight_sting", "Dying Wish", 20000, "revive_light", "Dying_Wish","zombie_perk_bottle_revive" );
		//Bar top stairs
		perk_system( "script_model", (713, -1400, 128), "zombie_vending_doubletap2_on", ( 0, 45, 0 ), "custom", "mus_perks_sleight_sting", "Bloodthirst", 2500, "doubletap_light", "Bloodthirst","zombie_perk_bottle_doubletap" );
		//Opposite tombstone
		perk_system( "script_model", (1167, -1086, -55), "zombie_vending_sleight_on", ( 0, 90, 0 ), "custom", "mus_perks_sleight_sting", "Widow's Wine", 4000, "sleight_light", "WIDOWS_WINE","zombie_perk_bottle_sleight" );
		//next to EC
		perk_system( "script_model", (2442, -771, -55), "zombie_vending_marathon_on", ( 0, 215, 0 ), "custom", "mus_perks_sleight_sting", "Ammo Regen", 12000, "marathon_light", "Ammo_Regen","zombie_perk_bottle_marathon" );
		//Bank
		perk_system( "script_model", (795, 426, -40), "zombie_vending_marathon_on", ( 0, 90, 0 ), "custom", "mus_perks_sleight_sting", "Executioner's Edge", 15000, "marathon_light", "Executioners_Edge","zombie_perk_bottle_marathon" );
		//Bookstore stairs
		perk_system( "script_model", (555, -1354, 120), "zombie_vending_tombstone_on", ( 0, 180, 0 ), "custom", "mus_perks_sleight_sting", "Mule Kick", 4000, "tombstone_light", "MULE","zombie_perk_bottle_tombstone" );
		//south town inside building
		perk_system( "script_model", (843, -1475, -45), "zombie_vending_marathon_on", ( 0, 90, 0 ), "custom", "mus_perks_sleight_sting", "Headshot Mayhem", 30000, "marathon_light", "Headshot_Mayhem","zombie_perk_bottle_marathon" );
		//next to tombstone
		perk_system( "script_model", (1832, -1220, -56), "zombie_vending_marathon_on", ( 0, 270, 0 ), "custom", "mus_perks_sleight_sting", "Thunder Wall", 20000, "marathon_light", "THUNDER_WALL","zombie_perk_bottle_marathon" );
		//east town bar wall
		perk_system( "script_model", (2350, -44, -56), "zombie_vending_doubletap2_on", ( 0, 270, 0 ), "custom", "mus_perks_sleight_sting", "Burn Heart", 12000, "doubletap_light", "Burn_Heart","zombie_perk_bottle_doubletap" );
		
		
		//Farm 
		//pap();
		perk_system( "script_model", ( 8256, -6396, 92.6), "zombie_vending_sleight_on", ( 0, 120, 0 ), "custom", "mus_perks_sleight_sting", "Widow's Wine", 3000, "sleight_light", "WIDOWS_WINE","zombie_perk_bottle_sleight" );
		perk_system( "script_model", ( 7057, -5728, -48), "zombie_vending_marathon_on", ( 0, 90, 0 ), "custom", "mus_perks_tombstone_sting", "Thunder Wall", 25000, "tombstone_light", "THUNDER_WALL","zombie_perk_bottle_marathon" );
		perk_system( "script_model", ( 8460, -4593, 48), "zombie_vending_doubletap2_on", ( 0, 0, 0 ), "custom", "mus_perks_doubletap_sting", "Ammo Regen", 15000, "doubletap_light", "Ammo_Regen","zombie_perk_bottle_doubletap" );
		perk_system( "script_model", ( 7938, -4675, 48 ), "zombie_vending_marathon_on", ( 0, 45, 0 ), "custom", "mus_perks_stamin_sting", "Burn Heart", 15000, "marathon_light", "Burn_Heart","zombie_perk_bottle_marathon" );
		perk_system( "script_model", ( 7893, -6527, 117 ), "zombie_vending_revive_on", ( 0, 120, 0 ), "custom", "mus_perks_tombstone_sting", "Dying Wish", 15000, "revive_light", "Dying_Wish","zombie_perk_bottle_revive" );
		perk_system( "script_model", ( 7848, -4878, 47 ), "zombie_vending_sleight_on", ( 0, 270, 0 ), "custom", "mus_perks_sleight_sting", "Electric Cherry", 3000, "revive_light", "ELECTRIC_CHERRY","zombie_perk_bottle_sleight" );
		perk_system( "script_model", ( 8738, -6577, 109 ), "zombie_vending_tombstone_on", ( 0, 210, 0 ), "custom", "mus_perks_tombstone_sting", "Executioner's Edge", 18000, "tombstone_light", "Executioners_Edge","zombie_perk_bottle_tombstone" );
		perk_system( "script_model", ( 7767, -6329, 117  ), "zombie_vending_jugg_on", ( 0, 120, 0 ), "custom", "mus_perks_phd_sting", "PhD Flopper", 8000, "jugger_light", "PHD_FLOPPER","zombie_perk_bottle_jugg" );
		perk_system( "script_model", (  7921, -5408, 48 ), "zombie_vending_sleight_on", ( 0, 180, 0 ), "custom", "mus_perks_mulekick_sting", "Mule Kick", 4000, "sleight_light", "MULE","zombie_perk_bottle_sleight" );
		perk_system( "script_model", (  8820, -5785, 50 ), "zombie_vending_tombstone_on", ( 0, 270, 0 ), "custom", "mus_perks_tombstone_sting", "Rampage", 18000, "tombstone_light", "Rampage", "zombie_perk_bottle_tombstone" );

		
	}
	else if (getdvar("mapname") == "zm_buried")
	{
		//outside saloon and toy store nook
		perk_system( "script_model", (945, -1048, 52), "zombie_vending_revive_on", ( 0, 270, 0 ), "custom", "mus_perks_sleight_sting", "Downer's Delight", 3000, "revive_light", "Downers_Delight","zombie_perk_bottle_revive" );
		//candy store upstairs
		perk_system( "script_model", (572, -375, 144), "zombie_vending_doubletap2_on", ( 0, 180, 0 ), "custom", "mus_perks_sleight_sting", "Rampage", 10000, "doubletap_light", "Rampage","zombie_perk_bottle_doubletap" );
		//opposite saloon upstairs
		perk_system( "script_model", (-84, -1512, 168), "zombie_vending_marathon_on", ( 0, 180, 0 ), "custom", "mus_perks_sleight_sting", "PhD Flopper", 5000, "marathon_light", "PHD_FLOPPER","zombie_perk_bottle_marathon" );
		//saloon
		perk_system( "script_model", (532, -1172, 208), "zombie_vending_sleight_on", ( 0, 310, 0 ), "custom", "mus_perks_sleight_sting", "Electric Cherry", 3000, "revive_light", "ELECTRIC_CHERRY","zombie_perk_bottle_sleight" );
		//general store
		perk_system( "script_model", (80, -428, 144), "zombie_vending_jugg_on", ( 0, 270, 0 ), "custom", "mus_perks_sleight_sting", "Guarding Strike", 10000, "sleight_light", "Guarding_Strike","zombie_perk_bottle_sleight" );
		//outside gunsmith nook
		perk_system( "script_model", (-981, -1002, -24), "zombie_vending_revive_on", ( 0, 270, 0 ), "custom", "mus_perks_sleight_sting", "Dying Wish", 20000, "revive_light", "Dying_Wish","zombie_perk_bottle_revive" );
		//jail upstairs
		perk_system( "script_model", (-785, 705, 145), "p6_zm_vending_vultureaid_on", ( 0, 300, 0 ), "custom", "mus_perks_sleight_sting", "Bloodthirst", 2500, "jugger_light", "Bloodthirst","zombie_perk_bottle_jugg" );
		//courthouse downstairs
		perk_system( "script_model", (291, 1295, 8), "zombie_vending_sleight_on", ( 0, 180, 0 ), "custom", "mus_perks_sleight_sting", "Widow's Wine", 4000, "sleight_light", "WIDOWS_WINE","zombie_perk_bottle_sleight" );
		//graveyard
		perk_system( "script_model", (615, 1368, -20), "zombie_vending_marathon_on", ( 0, 90, 0 ), "custom", "mus_perks_sleight_sting", "Ammo Regen", 12000, "marathon_light", "Ammo_Regen","zombie_perk_bottle_marathon" );
		//mansion backyard
		perk_system( "script_model", (3403, 860, 50), "zombie_vending_marathon_on", ( 0, 90, 0 ), "custom", "mus_perks_sleight_sting", "Executioner's Edge", 15000, "marathon_light", "Executioners_Edge","zombie_perk_bottle_marathon" );
		//church downstairs
		perk_system( "script_model", (1698, 2394, 40), "zombie_vending_marathon_on", ( 0, 340, 0 ), "custom", "mus_perks_sleight_sting", "Headshot Mayhem", 30000, "marathon_light", "Headshot_Mayhem","zombie_perk_bottle_marathon" );
		//bank
		perk_system( "script_model", (-494, -198, 20), "zombie_vending_marathon_on", ( 0, 90, 0 ), "custom", "mus_perks_sleight_sting", "Thunder Wall", 20000, "marathon_light", "THUNDER_WALL","zombie_perk_bottle_marathon" );
	}
		
	else if (getdvar( "mapname" ) == "zm_nuked") 
	{	
		
		perk_system( "script_model", ( 632, 418, -57 ), "zombie_vending_sleight_on", ( 0, 190, 0 ), "custom", "mus_perks_sleight_sting", "Widow's Wine", 3000, "sleight_light", "WIDOWS_WINE","zombie_perk_bottle_sleight" );
		perk_system( "script_model", ( 1919, 697, -64 ), "zombie_vending_doubletap2_on", ( 0, 330, 0 ), "custom", "mus_perks_tombstone_sting", "Thunder Wall", 25000, "doubletap_light", "THUNDER_WALL","zombie_perk_bottle_doubletap" );
		perk_system( "script_model", ( 701, 358, 80	 ), "zombie_vending_doubletap2_on", ( 0, 20, 0 ), "custom", "mus_perks_doubletap_sting", "Ammo Regen", 15000, "doubletap_light", "Ammo_Regen","zombie_perk_bottle_doubletap" );
		perk_system( "script_model", ( -998, 211, -34 ), "zombie_vending_revive_on", ( 0, 250, 0 ), "custom", "mus_perks_tombstone_sting", "Dying Wish", 15000, "revive_light", "Dying_Wish","zombie_perk_bottle_revive" );
		perk_system( "script_model", ( 699, 560.7, -57 ), "zombie_vending_sleight_on", ( 0, 105, 0 ), "custom", "mus_perks_sleight_sting", "Electric Cherry", 3000, "revive_light", "ELECTRIC_CHERRY","zombie_perk_bottle_sleight" );
		perk_system( "script_model", ( -1830, 686, -48 ), "zombie_vending_doubletap2_on", ( 0, 340, 0 ), "custom", "mus_perks_tombstone_sting", "Executioner's Edge", 18000, "doubletap_light", "Executioners_Edge","zombie_perk_bottle_doubletap" );
		perk_system( "script_model", ( -934, 271, -55 ), "zombie_vending_jugg_on", ( 0, 75, 0 ), "custom", "mus_perks_jugg_sting", "PhD Flopper", 8000, "jugger_light", "PHD_FLOPPER","zombie_perk_bottle_jugg" );
		perk_system( "script_model", (  -897.749, -170, -60), "zombie_vending_sleight_on", ( 0, 110, 0 ), "custom", "mus_perks_mulekick_sting", "Mule Kick", 4000, "sleight_light", "MULE","zombie_perk_bottle_sleight" );
		perk_system( "script_model", ( -868, 352, 85 ), "zombie_vending_doubletap2_on", ( 0, 160, 0 ), "custom", "mus_perks_tombstone_sting", "Rampage", 18000, "doubletap_light", "Rampage", "zombie_perk_bottle_doubletap" );
	}
}



play_fx( fx )
{
	playfxontag( level._effect[ fx ], self, "tag_origin" );
}

default_vending_precaching()
{
	level._effect[ "sleight_light" ] = loadfx( "misc/fx_zombie_cola_on" );
	level._effect[ "tombstone_light" ] = loadfx( "misc/fx_zombie_cola_on" );
	level._effect[ "revive_light" ] = loadfx( "misc/fx_zombie_cola_revive_on" );
	level._effect[ "marathon_light" ] = loadfx( "maps/zombie/fx_zmb_cola_staminup_on" );
	level._effect[ "jugger_light" ] = loadfx( "misc/fx_zombie_cola_jugg_on" );
	level._effect[ "doubletap_light" ] = loadfx( "misc/fx_zombie_cola_dtap_on" );
	level._effect[ "deadshot_light" ] = loadfx( "misc/fx_zombie_cola_dtap_on" );
	level._effect[ "additionalprimaryweapon_light" ] = loadfx( "misc/fx_zombie_cola_arsenal_on" );
	level._effect[ "packapunch_fx" ] = loadfx( "maps/zombie/fx_zombie_packapunch" );
	level._effect[ "wall_taseknuck" ] = loadfx( "maps/zombie/fx_zmb_wall_buy_taseknuck" );
}

custom_get_player_weapon_limit( player )
{
    weapon_limit = 2;
    if ( player hascustomperk("MULE") )
    {
        weapon_limit = 3;
    } 
	else 
	{
        weapons = self getWeaponsListPrimaries();
        if(weapons.size > 2)
		{
            self takeWeapon(weapons[2]);
        }
    }
    return weapon_limit;
}

playchalkfx(effect, origin, angles)
{
    fx = SpawnFX(level._effect[ effect ], origin,AnglesToForward(angles),AnglesToUp(angles));
    TriggerFX(fx);
    level waittill("connected", player);
    fx Delete();
}
/*
pap_system(pos, angles)
{
	pap_machine = spawn("script_model", pos);
	pap_machine setmodel("p6_anim_zm_buildable_pap_on");
	pap_machine.angles = angles;
	collision=spawn("script_model", pos);
	collision setmodel("collision_geo_32x32x128_standard");
	pap_machine thread pap_buy_system();
}
*/

perk_system( script, pos, model, angles, type, sound, name, cost, fx, perk, bottle)
{
	perkmachine = spawn( script, pos);
	perkmachine setmodel( model );
	perkmachine.angles = angles;
	collision= spawn( script, pos );
	collision setmodel( "collision_geo_32x32x128_standard" );
	collision.angles = angles;
    perkmachine thread buy_system( perk, sound, name, cost, type, bottle );
    perkmachine thread play_fx( fx );
}
/*
pap_buy_system()
{
	self endon( "game_ended")
	while( 1 )
	{
		foreach( player in level.players )
        {
            if(!player.machine_is_in_use)
			{
                if( distance( self.origin, player.origin ) <= 70 )
                {
				    player thread SpawnHint( self.origin, 30, 30, "HINT_ACTIVATE", "Hold ^3&&1^7 to upgrade your weapon. Cost: 5000" );
                    if(player usebuttonpressed() && !player hasperk(perk) && !player hascustomperk(perk) && player.score >= cost && !player maps/mp/zombies/_zm_laststand::player_is_in_laststand())
                    {
                        player.machine_is_in_use = 1;
                        player playsound( "zmb_cha_ching" );
                        player.score -= 5000;
						weapona = getcurrentweapon();
						weaponb = getupgradevariant(weapona)
			    	    self giveweapon( weaponb );
        				self switchtoweapon( weaponb );
						
	
						self setblur( 4, 0.1 );
						wait 0.1;
						self setblur( 0, 0.1 );
						self allowProne(true);
						wait 10;
                    	player.machine_is_in_use = 0;
					}
					else
                    {
                        if( player usebuttonpressed() && player.score < cost )
                        {
                            player maps/mp/zombies/_zm_audio::create_and_play_dialog( "general", "perk_deny", undefined, 0 );
                        }
                    }
                }
            }
        }
        wait 0.1;
    }
}
*/
buy_system( perk, sound, name, cost, type, bottle)
{
    self endon( "game_ended" );
    while( 1 )
    {
        foreach( player in level.players )
        {
            if(!player.machine_is_in_use)
			{
                if( distance( self.origin, player.origin ) <= 70 )
                {
				    player thread SpawnHint( self.origin, 30, 30, "HINT_ACTIVATE", "Hold ^3&&1^7 for " + name + " [Cost: " + cost + "]" );
                    if(player usebuttonpressed() && !player hasperk(perk) && !player hascustomperk(perk) && player.score >= cost && !player maps/mp/zombies/_zm_laststand::player_is_in_laststand())
                    {
                        player.machine_is_in_use = 1;
                        player playsound( "zmb_cha_ching" );
                        player.score -= cost;
                        player playsound( sound );
			    	    player thread drawshader_and_shadermove( perk, 1, 1, bottle );
						wait 4;
                    	player.machine_is_in_use = 0;
					}
					else
                    {
                        if( player usebuttonpressed() && player.score < cost )
                        {
                            player maps/mp/zombies/_zm_audio::create_and_play_dialog( "general", "perk_deny", undefined, 0 );
                        }
                    }
                }
            }
        }
        wait 0.1;
    }
}

hascustomperk(perk)
{
	for(i = 0; i < self.perkarray.size; i++)
	{
		if(self.perkarray[i].name == perk)
		{
			return 1;
		}
	}
	return 0;
}

removeperkshader()
{
    for(;;)
    {
        self waittill_any_return( "fake_death", "player_downed", "player_revived", "spawned_player", "disconnect", "death" );
        self.num_perks = 0;
        self.perk_reminder = 0;
        self.perk_count = 0;
		self.dying_wish_on_cooldown = 0;
		self.thunder_wall_on_cooldown = 0;
		self.rampage_on_cooldown = 0;
		self.rampage = 0;
		self removeallcustomshader();
		self.perkarray = [];
        self notify( "stopcustomperk" );
        self.bleedout_time = 30;
	    self.ignore_lava_damage = 0;
    }
}

removeallcustomshader()
{
	for(i = 0; i < self.perkarray.size; i++)
	{
		self.perkarray[i] destroy();
	}
}

drawshader( shader, x, y, width, height, color, alpha, sort )
{
	hud = newclienthudelem( self );
	hud.elemtype = "icon";
	hud.color = color;
	hud.alpha = alpha;
	hud.sort = sort;
	hud.children = [];
    hud.hidewheninmenu = 1;
	hud setparent( level.uiparent );
	hud setshader( shader, width, height );
	hud.x = x;
	hud.y = y;
	return hud;
}

perkboughtcheck()
{
    self endon("death");
    self endon("disconnect");
    for(;;)
    {
        self.perk_reminder = self.num_perks;
        self waittill("perk_acquired");
		n = 1;
        if(!(self.num_perks > self.perk_reminder))
        {
			n = (self.num_perks - self.perk_reminder);
            self.num_perks = (self.perk_reminder + n);
        }
        self.perk_reminder = self.num_perks;
        self.perk_count += n;
        self drawshader_and_shadermove("none", 0, 0);
    }
}
set_anim_rate( n_speed )
{
	self setclientfield( "anim_rate", n_speed );
	n_rate = self getclientfield( "anim_rate" );
	self setentityanimrate( n_rate );
	if ( n_speed != 1 )
	{
		self.preserve_asd_substates = 1;
	}
	wait_network_frame();
	if ( !is_true( self.is_traversing ) )
	{
		self.needs_run_update = 1;
		self notify( "needs_run_update" );
	}
	wait_network_frame();
	if ( n_speed == 1 )
	{
		self.preserve_asd_substates = 0;
	}
}

drawshader_and_shadermove(perk, custom, print, bottle)
{
    if(custom)
	{
        self allowProne(false);
        self allowSprint(true);
        self disableoffhandweapons();
        self disableweaponcycling();
        weapona = self getcurrentweapon();
        weaponb = bottle;
        self giveweapon( weaponb );
        self switchtoweapon( weaponb );
        self waittill( "weapon_change_complete" );
        self enableoffhandweapons();
        self enableweaponcycling();
        self takeweapon( weaponb );
        self switchtoweapon( weapona );
        self maps/mp/zombies/_zm_audio::playerexert( "burp" );
        self setblur( 4, 0.1 );
        wait 0.1;
        self setblur( 0, 0.1 );
        self allowProne(true);
    }
    x = -408 + (self.perk_count * 30);
	if (getdvar("mapname")=="zm_buried" || getdvar("mapname") == "zm_tomb")
	{
		y = 320;
	}
	else
	{
		y = 350;
	}
	
    for(i = 0; i < self.perkarray.size; i++)
	{
    	self.perkarray[i].x = self.perkarray[i].x + 30;
	}
        if(perk == "Downers_Delight")
        {
            self.perk1back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );  
            self.perk1front = self drawshader( "waypoint_revive", x, y, 23, 23, ( 0, 1, 1 ), 100, 0 ); 
            self.perk1front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk1front;
			self.perk1back.name = perk;
			self.perkarray[self.perkarray.size] = self.perk1back;
			self.num_perks++;
			self thread DDown();
			if(print)
			{
				self iprintln("^9Downer's Delight");
				wait 0.2;
				self iprintln("This Perk will increase players bleedout time by 10 seconds and current weapons is used in laststand.");
			}
		}
        if(perk == "MULE")
        {   
            self.perk2back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk2front = self drawshader( "menu_mp_weapons_1911", x, y, 22, 22, ( 0, 1, 0 ), 100, 0 );
            self.perk2front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk2front;
			self.perk2back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk2back;
			self.num_perks++;
			if(print)
			{
				self iprintln("^9Mule Kick");
				wait 0.2;
				self iprintln("This Perk enables additional primary weapon slot for player. ");
			}
		}
        if(perk == "PHD_FLOPPER")
        {    
            self.perk3back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk3front = self drawshader( "hud_grenadeicon", x, y, 23, 23, (1, 0, 1 ), 100, 0 );
            self.perk3front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk3front;
			self.perk3back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk3back;
			self.num_perks++;
			self thread doPHDdive();
			if(print)
			{
				self iprintln("^9PhD Flopper");
				wait 0.2;
				self iprintln("This Perk removes explosion and fall damage also player creates explosion when dive to prone.");
			}
		}
        if(perk == "Victorious_Tortoise")
        {    
            self.perk4back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 200, 0 ), 100, 0 );
            self.perk4front = self drawshader( "zombies_rank_2", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk4front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk4front;
			self.perk4back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk4back;
			self.num_perks++;
			self thread start_vt();
			if(print)
			{
				self iprintln("^9Victorious Tortoise");
				wait 0.2;
				self iprintln("This Perk allows shield block damage from all directions when in use.");
        	}
		}
        if(perk == "ELECTRIC_CHERRY")
        {    
            self.perk5back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 200 ), 100, 0 );
            self.perk5front = self drawshader( "zombies_rank_5", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk5front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk5front;
			self.perk5back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk5back;
			self.num_perks++;
			self thread start_ec();
			if(print)
			{
				self iprintln("^9Electric Cherry");
				wait 0.2;
				self iprintln("This Perk creates an electric shockwave around the player whenever they reload.");
        	}
		}	
        if(perk == "THUNDER_WALL")
        {    
            self.perk6back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk6front = self drawshader( "zombies_rank_5_ded", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk6front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk6front;
			self.perk6back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk6back;
			self.num_perks++;
			self thread thunder_wall_checker();
			if(print)
			{
				self iprintln("^9Thunder Wall");
				wait 0.2;
				self iprintln("This Perk launches nearby zombies into the air when the player is hit.");
        	}
		}
        if(perk == "Executioners_Edge")
        {    
            self.perk7back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 200, 0, 0 ), 100, 0 );
            self.perk7front = self drawshader( "menu_mp_weapons_xm8", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
			self.perk7front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk7front;
			self.perk7back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk7back;
			self.num_perks++;
			if(print)
			{
				self iprintln("^9Executioner's Edge");
				wait 0.2;
				self iprintln("This perk gives melee attacks one shot kills and gives extra points.");
        	}
		}
		if(perk == "Ammo_Regen")
        {
            self.perk8back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk8front = self drawshader( "menu_mp_lobby_icon_customgamemode", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk8front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk8front;
			self.perk8back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk8back;
			self.num_perks++;
			self thread ammoregen();
            self thread grenadesregen();
			if(print)
			{
				self iprintln("^9Ammo Regen");
				wait 0.2;
				self iprintln("This Perk will slowly regenerate the players ammunation and grenades.");			
			}
		}
        if(perk == "Burn_Heart")
        {
            self.perk9back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 200, 0, 0 ), 100, 0 );
            self.perk9front = self drawshader( "faction_cdc", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk9front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk9front;
			self.perk9back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk9back;
			self.num_perks++;
            self.ignore_lava_damage = 1;
			if(print)
			{
				self iprintln("^9Burn Heart");
				wait 0.2;
				self iprintln("This Perk removes lava damage.");
			}
		}
        if(perk == "Dying_Wish")
        {
            self.perk10back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 200, 0, 0 ), 100, 0 );
            self.perk10front = self drawshader( "zombies_rank_5", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk10front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk10front;
			self.perk10back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk10back;
			self.num_perks++;
            self thread dying_wish_checker();
			if(print)
			{
				self iprintln("^9Dying Wish");
				wait 0.2;
				self iprintln("This perk gives you a second chance if you die.");
				wait 0.1;
				self iprintln("( cooldown of 5 minutes )");
			}
		}
	
        if(perk == "WIDOWS_WINE")
        {
            self.perk11back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk11front = self drawshader( "zombies_rank_3", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk11front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk11front;
			self.perk11back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk11back;
			self.num_perks++;
			if(print)
			{
				self iprintln("^9Widow's Wine");
				wait 0.2;
				self iprintln("This Perk damages zombies around the player when they are hit and slows zombies down.");
        	}
		}

		if (perk == "Rampage")
		{
			self.perk12back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk12front = self drawshader( "zombies_rank_4_ded", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk12front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk12front;
			self.perk12back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk12back;
			self.num_perks++;
			self thread rampage_checker();
			self thread rampage_damage();
			if(print)
			{
				self iprintln("^9Rampage");
				wait 0.2;
				self iprintln("This Perk will grant the player a chance, upon killing a zombie, to kill zombies in one shot for 10 seconds.");
        	}
		}
		if (perk == "Bloodthirst")
		{
			self.perk13back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk13front = self drawshader( "zombies_rank_4", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk13front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk13front;
			self.perk13back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk13back;
			self.num_perks++;
			if(print)
			{
				self iprintln("^9Bloodthirst");
				wait 0.2;
				self iprintln("This Perk grants the player a small amount of health when killing a zombie");
        	}
		}
		if (perk == "Guarding_Strike")
		{
			self.perk14back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk14front = self drawshader( "zombies_rank_1", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk14front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk14front;
			self.perk14back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk14back;
			self.num_perks++;
			self thread generate_shield();
			
			if(print)
			{
				self iprintln("^9Guarding Strike");
				wait 0.2;
				self iprintln("This Perk has a chance to create a shield that absorbs all damage for 5 seconds when killing a zombie ");
        	}
		}
		if (perk == "Headshot_Mayhem")
		{
			self.perk15back = self drawshader( "specialty_marathon_zombies", x, y, 24, 24, ( 0, 0, 0 ), 100, 0 );
            self.perk15front = self drawshader( "killiconheadshot", x, y, 23, 23, ( 1, 1, 1 ), 100, 0 );
            self.perk15front.name = perk;
			self.perkarray[self.perkarray.size] = self.perk15front;
			self.perk15back.name = perk;
            self.perkarray[self.perkarray.size] = self.perk15back;
			self.num_perks++;
			
			
			if(print)
			{
				self iprintln("^9Headshot Mayhem");
				wait 0.2;
				self iprintln("This Perk has a chance to create an explosion upon a headshot kill as well as");
				self iprintln("an additional 2x damage multiplier for headshots and extra points for headshot damage.");
        	}
		}
}

custom_get_player_weapon_limit( player )
{
    weapon_limit = 2;
    if ( player hascustomperk("MULE") )
    {
        weapon_limit = 3;
    } 
	else 
	{
        weapons = self getWeaponsListPrimaries();
        if(weapons.size > 2)
		{
            self takeWeapon(weapons[2]);
        }
    }
    return weapon_limit;
}

ammoregen()
{
	self endon( "disconnect" );
	level endon( "end_game" );
	self endon( "stopcustomperk" );
	for(;;)
	{
		if(!self GetCurrentWeapon() == "" && !is_grenade_launcher( self GetCurrentWeapon()) )
		{
			stockcount = self getweaponammostock( self GetCurrentWeapon() );
			self setWeaponAmmostock( self GetCurrentWeapon(), stockcount + 1 );
			wait 1;
		}
		wait 0.1;
	}
}
doPHDdive() //credit to extinct
{
	self endon("disconnect");
	level endon("end_game");
	
	for(;;)
	{
		if(isDefined(self.divetoprone) && self.divetoprone)
		{
			if(self isOnGround() && (self hascustomperk("PHD_FLOPPER")))
			{
				points=0;
				explosionfx = level._effect["fx_default_explosion"];
				self playSound("zmb_phdflop_explo");
				playfx(explosionfx, self.origin);
				zombies = getAiArray(level.zombie_team);
				foreach(zombie in zombies)
				{
					if(distance(zombie.origin, self.origin) < 300)
					{
						zombie doDamage(zombie.health * 2, zombie.origin, self);
						points+=50;
					}
				}
				wait .3;
			}
		}
		wait .05;
	}
}
grenadesregen()
{
	self endon( "disconnect" );
	level endon( "end_game" );
	self endon( "stopcustomperk" );
	for(;;)
	{
		grenades = self get_player_lethal_grenade();
        grenade_count = self getweaponammoclip(grenades);
        if(grenade_count < 4)
		{
        	self setweaponammoclip(grenades, (grenade_count + 1));
		}
		tactical_grenades = self get_player_tactical_grenade();
        tactical_grenade_count = self getweaponammoclip(tactical_grenades);
        if(tactical_grenade_count < 3 )
		{
        	self setweaponammoclip(tactical_grenades, (tactical_grenade_count + 1));
		}
		wait 300;
	}
}

start_ec()
{
	level endon("end_game");
	self endon("disconnect");
	self endon("stopcustomperk");
	for(;;)
	{
		self waittill( "reload_start" );
    	playfxontag( level._effect[ "poltergeist"], self, "J_SpineUpper" );
		self EnableInvulnerability();
		RadiusDamage(self.origin, 120, 200, 100, self);
		self DisableInvulnerability();
		self playsound( "zmb_turbine_explo" );
		wait 1;
	}
}

start_vt()
{
	level endon("end_game");
	self endon("disconnect");
	self endon("stopcustomperk");
	for(;;)
	{
		if(self getcurrentweapon() == "riotshield_zm" )
		{
			self enableInvulnerability();
			self.shielddamagetaken += 100;
			wait 0.9;
		}
		else
		{
			self disableInvulnerability();
		}
		wait 0.1;
	}
}



LastStand()
{
    if(self hascustomperk("Downers_Delight"))
	{
        self.customlaststandweapon = self getcurrentweapon();
		self switchtoweapon( self.customlaststandweapon );
		self setweaponammoclip( self.customlaststandweapon, 150 );
		self.bleedout_time = 40;
    } 
	else 
	{
        self maps/mp/zombies/_zm::last_stand_pistol_swap();
    }
}

DDown() 
{
	self endon( "disconnect" );
	level endon( "end_game" );
	self endon( "stopcustomperk" );
	for(;;)
	{
		self waittill("player_downed");
		self playsound( "zmb_phdflop_explo" );
		explosionfx = level._effect["fx_default_explosion"];
		playfx(explosionfx, self.origin, anglestoforward( ( 0, 45, 55  ) ) ); 
		RadiusDamage(self.origin, 150, 600, 400, self);
		wait 0.1;
	}
}



SpawnHint( origin, width, height, cursorhint, string )
{
	hint = spawn( "trigger_radius", origin, 1, width, height );
	hint setcursorhint( cursorhint, hint );
	hint sethintstring( string );
	hint setvisibletoall();
	wait 0.2;
	hint delete();
}
object_touching_lava()
{
	if ( !isDefined( level.lava ) )
	{
		level.lava = getentarray( "lava_damage", "targetname" );
	}
	if ( !isDefined( level.lava ) || level.lava.size < 1 )
	{
		return 0;
	}
	if ( isDefined( self.lasttouching ) && self istouching( self.lasttouching ) )
	{
		return 1;
	}
	i = 0;
	while ( i < level.lava.size )
	{
		if ( distancesquared( self.origin, level.lava[ i ].origin ) < 2250000 )
		{
			if ( isDefined( level.lava[ i ].target ) )
			{
				if ( self istouching( level.lava[ i ].volume ) )
				{
					if ( isDefined( level.lava[ i ].script_float ) && level.lava[ i ].script_float <= 0.1 )
					{
						return 0;
					}
					self.lasttouching = level.lava[ i ].volume;
					return 1;
				}
			}
			else
			{
				if ( self istouching( level.lava[ i ] ) )
				{
					self.lasttouching = level.lava[ i ];
					return 1;
				}
			}
		}
		i++;
	}
	self.lasttouching = undefined;
	return 0;
}

ww_points( player )
{
    for(i = 0; i < 3; i++)
    {
		self maps/mp/zombies/_zm_utility::set_zombie_run_cycle("walk");
        player maps/mp/zombies/_zm_score::add_to_player_score( 10 );
        PlayFXOnTag(level.effect_WebFX,self,"j_spineupper");
        self doDamage(150, (0, 0, 0));
        if(getdvar( "mapname" ) == "zm_tomb" )
        {
            self set_anim_rate(0.1);
        }
        wait 1;
    }
    if(getdvar( "mapname" ) == "zm_tomb" )
    {
        self set_anim_rate( 1 );
        if(!isalive(self))
        {
            self delete();
        }
    }
}

ww_nade_explosion()
{
    wait 2;
	if(getdvar( "mapname" ) == "zm_transit")
    {
        if( self object_touching_lava())
        {
            self delete();
            return 0;
        }
    }
	foreach(zombie in getAiArray(level.zombie_team))
	{
        if( distance( zombie.origin, self.origin ) < 210 )
		{
            zombie thread ww_points( self );
        }
    }
    self delete();
}

ww_nades()
{
    level endon("end_game");
    self endon("disconnect");
    self endon("stopcustomperk");
    for(;;)
	{
        self waittill( "grenade_fire", grenade, weapname );
        if( weapname == "sticky_grenade_zm" )
		{
            ww_nade = spawnsm( grenade.origin, "zombie_bomb" );
            ww_nade hide();
            ww_nade linkto( grenade );
            ww_nade thread ww_nade_explosion();
        }
    }
}

spawnsm( origin, model, angles )
{
    ent = spawn( "script_model", origin );
    ent setmodel( model );
    if( IsDefined( angles ) )
    {
        ent.angles = angles;
    }
    return ent;
}



	
	
cool_down(time)
{
	self.cooldown = 1;
	wait time;
	self.cooldown = 0;
}

thunderwall( eattacker ) 
{
	thunder_wall_blast_pos = self.origin;
	ai_zombies = get_array_of_closest( thunder_wall_blast_pos, getaiarray( level.zombie_team ), undefined, undefined, 250  );
	if ( !isDefined( ai_zombies ) )
	{
		return;
	}
	if (ai_zombies.size > 4)
	{
		self notify("thunder_wall_activation");
		flung_zombies = 0;
		for ( i = 0; i < ai_zombies.size; i++ )
		{
			if(isDefined(ai_zombies[i].is_avogadro) && ai_zombies[i].is_avogadro || isDefined(ai_zombies[i].is_brutus) && ai_zombies[i].is_brutus || isDefined(ai_zombies[i].is_mechz) && ai_zombies[i].is_mechz )
			{
				//boss zombie check
			}
			else
			{
				n_random_x = RandomFloatRange( -3, 3 );
				n_random_y = RandomFloatRange( -3, 3 );
				ai_zombies[i] StartRagdoll();
				ai_zombies[i] LaunchRagdoll( (n_random_x, n_random_y, 150) );
				playfxontag( level._effect[ "jetgun_smoke_cloud"], ai_zombies[i], "J_SpineUpper" );
				ai_zombies[i] DoDamage( ai_zombies[i].health * 2, ai_zombies[i].origin, self, self, "none", "MOD_IMPACT" );
				flung_zombies++;
				if ( flung_zombies >= 50 )
				{
					break;
				}
			}
		}
	}
}





actor_damage_override_wrapper( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex ) 
{
	damage_override = self actor_damage_override_override( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
	if ( ( self.health - damage_override ) > 0 || !is_true( self.dont_die_on_me ) )
	{
		self finishactordamage( inflictor, attacker, damage_override, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
	}
}



actor_damage_override_override( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
	if(isdefined(level.sloth) && self == level.sloth || isDefined(self.is_avogadro) && self.is_avogadro || isDefined(self.is_brutus) && self.is_brutus || isDefined(self.is_mechz) && self.is_mechz )
    {
		return [[level.original_damagecallback]]( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
    }
	if ( isdefined(attacker) && isplayer( attacker ) )
	
	{
		finaldamage = damage;
		if (attacker hascustomperk("Bloodthirst") && (damage>self.health) )
		{
			if (attacker.health < attacker.maxhealth)
			{
				attacker.health+=10;
			}
			else
			{
				attacker.maxhealth+=1;
				attacker.health+=1;
				if (attacker.maxhealth == 320)
				{
					attacker.maxhealth = 300;
					attacker.health = attacker.maxhealth;
				}
			}
		}
		if (attacker hascustomperk("Guarding_Strike") && (damage > self.health) && !attacker.GS_on)
		{
			if(find_truefalse(10))
			{
				attacker notify("GS_activation");
			}
		}
		if ( meansofdeath == "MOD_MELEE" && attacker hascustomperk("Executioners_Edge") )
		{
			attacker maps/mp/zombies/_zm_score::add_to_player_score(250);
			attacker.health+=20;
			return (self.health);
		}
		
		if ( ( maps/mp/gametypes_zm/_globallogic_utils::isheadshot( weapon, shitloc, meansofdeath, inflictor ) ) && attacker hascustomperk("Headshot_Mayhem") )
		{
		
			finaldamage = (finaldamage + (damage * 2) );
			attacker maps/mp/zombies/_zm_score::add_to_player_score( 50 );
			if (damage > self.health)
			{
				
				if (find_truefalse(15))
				{
					self thread headshot_explosion();
				}
			}
		}

			
		if( attacker hascustomperk("Rampage") )
		{
			if( !attacker.rampage && damage>self.health )
			{
				if (find_truefalse(20))
				{
					attacker notify("rampage_activation");
				}
				return [[level.original_damagecallback]]( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
			}
			if(attacker.rampage)
			{
				self iprintln(damage);
				self iprintln(damage * 5);
				finaldamage = (finaldamage + (damage*5));
			}
		return (finaldamage);	
		}
	}
	
	return [[level.original_damagecallback]]( inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex );
}



find_truefalse(chance)
{
	number = randomintrange(0,101);
	if (number >= 0 && number <= chance)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
damage_callback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex )
{
	if( isDefined( eattacker.is_zombie ) && eattacker.is_zombie && self hascustomperk("THUNDER_WALL") && !self.thunder_wall_on_cooldown)
	{	
		self thread thunderwall(eAttacker);
	}
	if( isDefined( eattacker.is_zombie ) && eattacker.is_zombie && self hascustomperk("WIDOWS_WINE") )
	{
		zombies = getaiarray(level.zombie_team);
        foreach(zombie in zombies)
    	{
	   		if(distance(self.origin, zombie.origin) < 150)
        	{
				zombie thread ww_points( self );
			}
		}
    }
	
    if (self hascustomperk("PHD_FLOPPER"))
	{
		if( smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_FALLING" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH")
		{
			return 0;
		}
		
	}
	
    
    if(idamage > self.health && !self.dying_wish_on_cooldown && self hascustomperk("Dying_Wish") )
	{
		self notify("dying_wish_charge");
	    self thread dying_wish_effect();
        return 0;
	}
	return idamage;
}

generate_shield()
{
	level endon("end_game");
    self endon("disconnect");
    self endon( "stopcustomperk" );
	for(;;)
	{
		self.perk14back.alpha = 0.3;
        self.perk14front.alpha = 0.4;
		self.GS_on = 0;
		self waittill("GS_activation");
		self.GS_on = 1;
		self iprintln("Guarding Strike Activated!");
		self enableInvulnerability();
		self.perk14back.alpha = 1;
        self.perk14front.alpha = 1;
		wait 5;
		self iprintln("Guarding Strike Shield Dissipated!"); 
		self disableInvulnerability();
	}
}
rampage_checker()
{

	level endon("end_game");
    self endon("disconnect");
    self endon( "stopcustomperk" );
	for(;;)
	{
		self.perk12back.alpha = 0.3;
        self.perk12front.alpha = 0.4;
		self waittill("rampage_activation");
		self.rampage = 1;
		self iprintln("Rampage Ability Activated");
		self.perk12back.alpha = 1;
        self.perk12front.alpha = 1;
		wait 15;
		self iprintln("Rampage Effect Finished");
		self.perk12back.alpha = 0.3;
        self.perk12front.alpha = 0.4;
		self.rampage = 0;
	}
}
rampage_damage()
{
	level endon("end_game");
    self endon("disconnect");
    self endon( "stopcustomperk" );
	for(;;)
	{
		self waittill("set_damage_undefined");
		self.damage_to_deal = undefined;
	}
}
thunder_wall_checker()
{
	level endon("end_game");
    self endon("disconnect");
    self endon( "stopcustomperk" );
	for(;;)
	{
		self.thunder_wall_on_cooldown = 0;
		self.perk6back.alpha = 1;
        self.perk6front.alpha = 1;
		self waittill("thunder_wall_activation");
		self.perk6back.alpha = 0.3;
        self.perk6front.alpha = 0.4;
		self.thunder_wall_on_cooldown = 1;
		wait 180;
	}
}
	
dying_wish_checker()
{
    level endon("end_game");
    self endon("disconnect");
    self endon( "stopcustomperk" );
    self.dying_wish_uses = 0;
    for(;;)
	{
        self.dying_wish_on_cooldown = 0;
        self.perk10back.alpha = 1;
        self.perk10front.alpha = 1;
        self waittill("dying_wish_charge");
        self.perk10back.alpha = 0.3;
        self.perk10front.alpha = 0.4;
        self.dying_wish_uses++;
        self.dying_wish_on_cooldown = 1;
        delay = 300;
        wait delay;
    }
}


dying_wish_effect()
{
    self iprintln("Dying Wish saved you!");
    self enableInvulnerability();
    self.ignoreme = 1;
    self useServerVisionSet(1);
    self setvisionsetforplayer( "zombie_death", 0 );
    wait 9;
	self.health = 1;
    self disableInvulnerability();
    self.ignoreme = 0;
    self useServerVisionSet(0);
    self setvisionsetforplayer("remote_mortar_enhanced", 0);
}

headshot_explosion()
{
	explosion_fx = level._effect["fx_default_explosion"];
	self playSound("zmb_phdflop_explo");
	playfx(explosionfx, self.origin);
	zombies = getAiArray(level.zombie_team);
	foreach(zombie in zombies)
	{
		if(distance(zombie.origin, self.origin) < 300)
		{
			zombie doDamage(zombie.health, zombie.origin, self);
		}
	}
}

player_burning_audio()
{
	fire_ent = spawn( "script_model", self.origin );
	wait_network_frame();
	fire_ent linkto( self );
	fire_ent playloopsound( "evt_plr_fire_loop" );
	self waittill_any( "stop_flame_damage", "stop_flame_sounds", "death", "disconnect" );
	fire_ent delete();
}

Perkaholic()
{
	self.num_perks = 0;
	if(!self hasperk("specialty_armorvest"))
	{
    	self give_perk( "specialty_armorvest" );
		wait 0.1;
	}
	else
	{
		self.num_perks++;
	}
	if(!self hasperk("specialty_fastreload"))
	{
		self give_perk( "specialty_fastreload" );
		wait 0.1;
	}
	else
	{
		self.num_perks++;
	}
	if(!self hasperk("specialty_rof"))
	{
    	self give_perk( "specialty_rof" );
		wait 0.1;
	}
	else
	{
		self.num_perks++;
	}
	if( getdvar( "mapname" ) == "zm_transit")
	{
		if(!self hasperk("specialty_quickrevive"))
		{
			self give_perk( "specialty_quickrevive" );
			wait 0.1;
		}
		else
		{
			self.num_perks++;
		}
		/*if(!self hasperk("specialty_scavenger"))
    	{
			self give_perk( "specialty_scavenger" );
			wait 0.1;
		}
		else
		{
			self.num_perks++;
		}*/
		if(!self hasperk("specialty_longersprint"))
		{
			self give_perk( "specialty_longersprint" );
			wait 0.1;
		}
		else
		{
			self.num_perks++;
		}
	}
	if( getdvar( "mapname" ) == "zm_prison" )
	{
		if(!self hasperk("specialty_grenadepulldeath"))
		{
        	self give_perk("specialty_grenadepulldeath");
		}
		if(!self hasperk("specialty_deadshot"))
        {
			self give_perk("specialty_deadshot");
		}
	}
	if( getdvar( "mapname" ) == "zm_nuked" )
	{
		if(!self hasperk("specialty_quickrevive"))
		{
			self give_perk("specialty_quickrevive");
		}
	}
	if( getdvar( "mapname" ) == "zm_tomb")
	{
		if(!self hasperk("specialty_deadshot"))
		{
			self give_perk( "specialty_deadshot" );
		}
		if(!self hasperk("specialty_grenadepulldeath"))
		{
    		self give_perk( "specialty_grenadepulldeath" );
		}
		if(!self hasperk("specialty_flakjacket"))
    	{
			self give_perk( "specialty_flakjacket" );
		}
		if(!self hasperk("specialty_quickrevive"))
        {
			self give_perk( "specialty_quickrevive" );
		}
		if(!self hasperk("specialty_additionalprimaryweapon"))
		{
			self give_perk( "specialty_additionalprimaryweapon" );
		}
		if(!self hasperk("specialty_longersprint"))
		{
			self give_perk( "specialty_longersprint" );
		}
	}
	if( getdvar( "mapname" ) == "zm_buried")
	{
		if(!self hasperk("specialty_nomotionsensor"))
    	{
			self give_perk("specialty_nomotionsensor");
		}
		if(!self hasperk("specialty_additionalprimaryweapon"))
		{
			self give_perk( "specialty_additionalprimaryweapon" );
		}
		if(!self hasperk("specialty_quickrevive"))
    	{
			self give_perk( "specialty_quickrevive" );
		}
		if(!self hasperk("specialty_longersprint"))
		{
			self give_perk( "specialty_longersprint" );
		}
	}
	if( getdvar( "mapname" ) == "zm_highrise" )
	{
		if(!self hasperk("specialty_quickrevive"))
		{
			self give_perk("specialty_quickrevive");
		}
		if(!self hasperk("specialty_finalstand"))
    	{
			self give_perk( "specialty_finalstand" );
		}
		if(!self hasperk("specialty_additionalprimaryweapon"))
	    {
			self give_perk("specialty_additionalprimaryweapon");
		}
	}
    self.perk_reminder = self.num_perks;
    self.perk_count = self.num_perks;
	wait 0.2;
	if(level.town)
	{
		if(!self hascustomperk("Downers_Delight"))
		{
			self drawshader_and_shadermove( "Downers_Delight", 0, 0 );
			wait 0.15;
		}
    	if(!self hascustomperk("MULE"))
		{
			self drawshader_and_shadermove( "MULE", 0, 0 );
			wait 0.15;
    	}
    	if(!self hascustomperk("PHD_FLOPPER"))
		{
			self drawshader_and_shadermove( "PHD_FLOPPER", 0, 0 );
			wait 0.15;
    	}
    	if(!self hascustomperk("Victorious_Tortoise"))
		{
			self drawshader_and_shadermove( "Victorious_Tortoise", 0, 0 );
			wait 0.15;
    	}
    	if(!self hascustomperk("ELECTRIC_CHERRY"))
		{
			self drawshader_and_shadermove( "ELECTRIC_CHERRY", 0, 0 );
			wait 0.15;
    	}
    	if(!self hascustomperk("WIDOWS_WINE"))
		{
			self drawshader_and_shadermove( "WIDOWS_WINE", 0, 0 );
			wait 0.15;
    	}
    	if(!self hascustomperk("Executioners_Edge"))
		{
			self drawshader_and_shadermove( "Executioners_Edge", 0, 0 );
			wait 0.15;
    	}
    	if(!self hascustomperk("Ammo_Regen"))
		{
			self drawshader_and_shadermove( "Ammo_Regen", 0, 0 );
			wait 0.15;
    	}
		if(!self hascustomperk("Burn_Heart"))
		{
			self drawshader_and_shadermove( "Burn_Heart", 0, 0 );
			wait 0.15;
    	}
		if(!self hascustomperk("Dying_Wish"))
		{
			self drawshader_and_shadermove( "Dying_Wish", 0, 0 );
			wait 0.15;
    	}
		if(!self hascustomperk("deadshot"))
		{
			self drawshader_and_shadermove( "deadshot", 0, 0 );
			wait 0.15;
    	}
	}
	if(level.diner)
	{
		if(!self hascustomperk("Downers_Delight"))
		{
			self thread drawshader_and_shadermove( "Downers_Delight", 0, 0 );
    	}
    	if(!self hascustomperk("MULE"))
		{
			self thread drawshader_and_shadermove( "MULE", 0, 0 );
    	}
    	if(!self hascustomperk("PHD_FLOPPER"))
		{
			self thread drawshader_and_shadermove( "PHD_FLOPPER", 0, 0 );
    	}
    	if(!self hascustomperk("Victorious_Tortoise"))
		{
			self thread drawshader_and_shadermove( "Victorious_Tortoise", 0, 0 );
    	}
    	if(!self hascustomperk("ELECTRIC_CHERRY"))
		{
			self thread drawshader_and_shadermove( "ELECTRIC_CHERRY", 0, 0 );
    	}
    	if(!self hascustomperk("WIDOWS_WINE"))
		{
			self thread drawshader_and_shadermove( "WIDOWS_WINE", 0, 0 );
    	}
    	if(!self hascustomperk("Executioners_Edge"))
		{
			self thread drawshader_and_shadermove( "Executioners_Edge", 0, 0 );
    	}	
	}
}

