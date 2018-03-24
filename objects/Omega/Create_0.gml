/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

current_projectile_count = 0;
charge_counter = 0;

shooting_counter = 0;
shooting_anim_last_context = "stand";

regular_animations = ds_map_create();
regular_animations[? "idle"] = omega_idle;
regular_animations[? "walk"] = omega_walk;
regular_animations[? "dash"] = omega_dash;
regular_animations[? "jump"] = omega_jump;
regular_animations[? "fall"] = omega_fall;

firing_animations = ds_map_create();
firing_animations[? "idle"] = omega_idle_shoot;
firing_animations[? "walk"] = omega_walk_shoot;
firing_animations[? "dash"] = omega_dash_shoot;
firing_animations[? "jump"] = omega_air_shoot;
firing_animations[? "fall"] = omega_air_shoot;