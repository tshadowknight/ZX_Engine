/// @description Attack State Handler
// You can write your code in this editor

// Inherit the parent event
/// @description Input handler
//poll input
if(is_dead){
	return;
}

attack_lock_counter--;
if(attack_lock && attack_lock_counter <= 0){
	attack_lock = 0;
	dash_cancel = 0;
}

key_right = gamepad_button_check(0, gp_padr);
key_left = -gamepad_button_check(0, gp_padl);
key_up = gamepad_button_check(0, gp_padu);
key_down = gamepad_button_check(0, gp_padd);

key_jump = gamepad_button_check_pressed(0, gp_face1);
key_dash = gamepad_button_check_pressed(0, gp_shoulderl);
key_dash_held =  gamepad_button_check(0, gp_shoulderl)

//update state
if(key_left != 0){
	facing = -1;
} else if(key_right != 0){
	facing = 1;
}

if(stateUpdate != ""){
	if(stateUpdate == "stand"){
		//external actor is trying to force a stand state
		if(state == "upper_cut"){
			stateUpdate = "upper_cut";
		}
	}
	state = stateUpdate;
	stateUpdate = "";
}

//update object properties

var actual_move_speed = move_speed;


if(state == "upper_cut"){
	upper_cut_counter--;
	if(upper_cut_counter <= 0){
		state="fall";
		forced_h_speed = -1;
		armor = 0;
	}
} else if(state == "ladder"){
	ignore_gravity_counter = 0;
	air_dash_used = 0;
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
	ignore_gravity_counter = 0;
	air_dash_used = 0;
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
			new_speed = -jump_speed;
			if(in_water){
				new_speed*=water_jump_multiplier;
			}
			vert_speed = new_speed;
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
	ignore_gravity_counter = 0;
	air_dash_used = 0;
	if(key_dash){
		dashing_counter = dash_duration;
	}
	if(key_jump != 0){
		on_slope = false;
		on_slope_left = false;
		on_slope_right = false;
		slope_cooldown = 2; //ignore slopes for 2 frames to avoid getting stuck on them after a jump
		new_speed = -jump_speed;
		if(in_water){
			new_speed*=water_jump_multiplier;
		}
		vert_speed = new_speed;
		
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
	if((key_dash || key_dash_held) && dash_cancel && !air_dash_used){
		dash_cancel = 0;	
		air_speed = move_speed * dash_multiplier;
		attack_lock = 0;
		ignore_gravity_counter = 15;
		air_dash_used = 1;
	}
	actual_move_speed = air_speed;
	if(vert_speed < 10){
		vert_speed += grav;	
	}	
}  

if(ignore_gravity_counter > 0){
	vert_speed = 0;
}
ignore_gravity_counter--;


horz_delta = key_left + key_right;
if(forced_h_speed != -1){
	horz_speed = forced_h_speed * facing;
} else {
	horz_speed = horz_delta * actual_move_speed;
}	


if(in_water){
	horz_speed*=water_h_multiplier;
}

if(horz_cooldown > 0){
	horz_cooldown--;
	horz_speed = stored_horz_speed;
}
//update object coordinates
if(!attack_lock || (dashing_counter && dash_cancel)){
	x+=horz_speed;
	y+=vert_speed; 
}


key_primary_pressed = gamepad_button_check_pressed(0, gp_face3);

if(key_primary_pressed && hitbox == -1) {
	if(key_up && state == "stand"){
		state = "upper_cut";
		upper_cut_counter = 10;
		hitbox = instantiateHitbox(36 * facing,60,10 * facing,-26,10,3 * facing, 45, 2);
		vert_speed = -10;
		forced_h_speed =  2;
		armor = 1;
	} else {
		vert_speed = 0;
		combo_cooldown = 30;
		attack_lock = 1;		
		if(combo_counter == 0) {
			hitbox = instantiateHitbox(36 * facing,60,10 * facing,-26,4,3 * facing, 45, 1);
			attack_lock_counter = 12;
			combo_counter++;
		} else if(combo_counter == 1) {
			hitbox = instantiateHitbox(36 * facing,60,10 * facing,-26,4,3 * facing, 45, 1);
			attack_lock_counter = 12;
			combo_counter++;
		} else if(combo_counter == 2) {
			hitbox = instantiateHitbox(48 * facing,60,10 * facing,-26,16,3 * facing, 45, 3);
			attack_lock_counter = 16;
			combo_counter = 0;
			dash_cancel = 1;
		}	
	}
	
} 

if(combo_cooldown <= 0) {
	combo_counter = 0;	
}	

combo_cooldown--;