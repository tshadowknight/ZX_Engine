/// @description Init Variables
// You can write your code in this editor
state = "";
stateUpdate = "";
current_surface = "";
surface_update = "";
dashing_counter = 0;

grav = 0.2;
horz_speed = 0;
vert_speed = 0;
jump_speed = 8;
move_speed = 6;
air_speed = move_speed;
wall_jump_push = 6;
cling_friction = 0.2;
dash_duration = 20; //in frames
horz_cooldown = 0;
stored_horz_speed = 0;
vert_cooldown = 0;
stored_vert_speed = 0;
cling_cooldown = 0;