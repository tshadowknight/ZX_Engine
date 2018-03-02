/// @description Input handler
//poll input
key_right = gamepad_button_check(0, gp_padr);
key_left = -gamepad_button_check(0, gp_padl);
key_up = gamepad_button_check(0, gp_padu);
key_down = gamepad_button_check(0, gp_padd);

key_jump = gamepad_button_check_pressed(0, gp_face1);
key_dash = gamepad_button_check_pressed(0, gp_shoulderl);

//update state
if(key_left != 0){
	facing = -1;
} else if(key_right != 0){
	facing = 1;
}

if(stateUpdate != ""){
	state = stateUpdate;
	stateUpdate = "";
}

//update object properties

var actual_move_speed = move_speed;


if(state == "ladder"){
	dashing_counter = 0;
	key_left = 0;
	key_right = 0;
	vert_speed = 0;
	if(key_up != 0){
		vert_speed = -ladder_speed;
	}
	if(key_down != 0){
		vert_speed = ladder_speed;
	}
	if(key_jump != 0){
		state = "fall";
	}
} else if(state == "stand"){
	vert_speed = 0;
	actual_move_speed = move_speed;
	if(key_dash){
		dashing_counter = dash_duration;
		
	}
	if(dashing_counter > 0){
		if(key_left == 0 && key_right ==0){
			if(facing == -1){
				key_left = -1;
			} else {
				key_right = 1;
			}
		}
		dashing_counter--;
		actual_move_speed = actual_move_speed * dash_multiplier;
	}	
	
	
	
	if(key_jump != 0){		
		
		if(key_down && on_one_way){
			state = "fall";
			y+=4;
			ignore_current_slope = true;
			force_h_align = false;
		} else {
			vert_speed = -jump_speed;	
			state = "jump";					
			y-=3; //make sure the player clears slopes on the first frame of jumping
		}	
		on_slope = false;
		on_slope_left = false;
		on_slope_right = false;
		slope_cooldown = 2; //ignore slopes for 2 frames to avoid getting stuck on them after a jump
	}	
	air_speed = actual_move_speed;
} else if(state == "cling_left" || state == "cling_right"){
	if(key_dash){
		dashing_counter = dash_duration;
	}
	if(key_jump != 0){
		on_slope = false;
		on_slope_left = false;
		on_slope_right = false;
		slope_cooldown = 2; //ignore slopes for 2 frames to avoid getting stuck on them after a jump
		vert_speed = -jump_speed;
		horz_cooldown = 5;
		if(state == "cling_left"){
			actual_move_speed = wall_jump_push;
		} else {
			actual_move_speed = -wall_jump_push;
		}
		stored_horz_speed = actual_move_speed;
		state = "jump";
		
		if(dashing_counter > 0){
			air_speed = move_speed * dash_multiplier;
		} else {
			air_speed = move_speed;
		}		
	}	
	if(vert_speed < 1){
		vert_speed += grav;	
	} else {
		vert_speed -= cling_friction;	
	}
} else if(state == "fall" || state == "jump"){	
	dashing_counter = 0;
	actual_move_speed = air_speed;
	if(vert_speed < 10){
		vert_speed += grav;	
	}	
}  

horz_delta = key_left + key_right;
horz_speed = horz_delta * actual_move_speed;

if(horz_cooldown > 0){
	horz_cooldown--;
	horz_speed = stored_horz_speed;
}
//update object coordinates
x+=horz_speed;
y+=vert_speed; 

