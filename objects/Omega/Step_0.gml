/// @description Attack state handler
// You can write your code in this editor

// Inherit the parent event
event_inherited();

max_projectiles = 3;

key_secondary_held = gamepad_button_check(0, gp_shoulderr);
key_secondary_pressed = gamepad_button_check_pressed(0, gp_shoulderr);
key_secondary_released = gamepad_button_check_released(0, gp_shoulderr);

key_primary = gamepad_button_check(0, gp_face3);

var firing_height_offset = 0;
var firing_x_offset = 50;
if(shooting_anim_last_context == "idle"){
	firing_height_offset = -4;
	firing_x_offset = 59;
} else if(shooting_anim_last_context == "walk"){
	firing_height_offset = 2;
	firing_x_offset = 55;
} else if(shooting_anim_last_context == "dash"){
	firing_height_offset = 8;
	firing_x_offset = 60;
}  else if(shooting_anim_last_context == "air"){
	firing_height_offset = -14;
	firing_x_offset = 59;
}

if(key_secondary_pressed != 0){
	if(current_projectile_count < max_projectiles){
		attack_state = "firing";
		shooting_counter = 13;
		var shot;
		if(facing == -1){
			shot = instance_create_layer(x-firing_x_offset, y+firing_height_offset, "Instances", shot_regular);
			shot._direction = -1;
			shot.image_xscale = -1;
		} else {
			shot = instance_create_layer(x+firing_x_offset, y+firing_height_offset, "Instances", shot_regular);
			shot._direction = 1;
		}
		shot.originator = self;
		current_projectile_count++;
	}
} else if(key_secondary_released != 0){
	var target_shot = noone;
	if(charge_counter > 30){
		target_shot = shot_medium;
	}
	if(charge_counter > 60){
		target_shot = shot_large;
	}
	if(target_shot != noone){	
		attack_state = "firing";
		shooting_counter = 13;
		if(current_projectile_count < max_projectiles){
			var shot;
			if(facing == -1){
				shot = instance_create_layer(x-firing_x_offset, y+firing_height_offset, "Instances", target_shot);
				shot._direction = -1;
				shot.image_xscale = -1;
			} else {
				shot = instance_create_layer(x+firing_x_offset, y+firing_height_offset, "Instances", target_shot);
				shot._direction = 1;
			}
			shot.originator = self;
			current_projectile_count++;
		}
	}
	charge_counter = 0;
}

if(key_secondary_held != 0){
	charge_counter++;
}

if(attack_state == "firing"){
	if(shooting_counter <= 0){
		attack_state = "";
	} else {
		shooting_counter--;
	}	
}