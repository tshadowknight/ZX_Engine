/// @description Init Variables
// You can write your code in this editor

// Inherit the parent event
event_inherited();
base_scale = 2;

image_xscale = base_scale;
image_yscale = base_scale;

hurtbox= instantiateHurtbox(34,65,-18,-31)
combo_counter = 0;
combo_cooldown = 0;
upper_cut_counter = 0;
forced_h_speed = -1;
attack_lock = 0;
attack_lock_counter = 0;
dash_cancel = 0;
armor = 0;
ignore_gravity_counter = 0;
air_dash_used = 0;

shooting_anim_last_context = "idle";
regular_animations = ds_map_create();
regular_animations[? "idle"] = hibiki_idle;
regular_animations[? "walk"] = hibiki_walk;
regular_animations[? "dash"] = hibiki_dash;
regular_animations[? "jump"] = hibiki_jump;
regular_animations[? "fall"] = hibiki_fall;