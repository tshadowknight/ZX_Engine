/// @description Init Variables
// You can write your code in this editor
state = "";
stateUpdate = "";
current_surface = "";
surface_update = "";
animation_state = "";
facing = 1;
dashing_counter = 0;
dash_multiplier = 1.8;

grav = 1;
horz_speed = 0;
vert_speed = 0;
jump_speed = 15;
move_speed = 4.5;
air_speed = move_speed;
wall_jump_push = 6;
cling_friction = 0.2;
water_h_multiplier = 0.6;
water_jump_multiplier = 1.2;
dash_duration = 20; //in frames
horz_cooldown = 0;
stored_horz_speed = 0;
vert_cooldown = 0;
stored_vert_speed = 0;
cling_cooldown = 0;

slope_cooldown  = 0;
ignore_current_slope = false;

ladder_available = 0;
ladder_speed = 4.5;

state_cooldown = 0;
force_h_align = false;

//death state and animation vars
is_dead = false;
death_particles_created = false;
death_anim_counter = 0;
death_anim_played = false;