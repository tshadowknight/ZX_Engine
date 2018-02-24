/// @description Input handler
//poll input
key_right = gamepad_button_check(0, gp_padr);
key_left = -gamepad_button_check(0, gp_padl);
key_up = gamepad_button_check(0, gp_padu);
key_down = gamepad_button_check(0, gp_padd);

key_jump = gamepad_button_check_pressed(0, gp_face1);
key_dash = gamepad_button_check_pressed(0, gp_shoulderl);

//update state
if(stateUpdate != ""){
	state = stateUpdate;
	stateUpdate = "";
}
var height = bbox_bottom - bbox_top;
var width = bbox_right - bbox_left;

bottom = position_meeting(x, y + height/2 + 1, obj_solid_block);
bottomright = position_meeting(x + width/2, y + height/2 + 1, obj_solid_block);
bottomleft = position_meeting(x - width/2, y + height/2 + 1, obj_solid_block);

if(state == "cling_left"){
	if(key_left == 0){
		if(cling_cooldown <= 0){
			state = "fall";
		}		
		cling_cooldown--;
	}	
}

if(state == "cling_right"){
	if(key_right == 0){
		if(cling_cooldown <= 0){
			state = "fall";
		}		
		cling_cooldown--;
	}	
}


if(!bottom && !bottomright && !bottomleft && state != "cling_left" && state != "cling_right"){
	if(state != "jump"){
		state = "fall";
	}	
}

//update standing surface
if(surface_update != ""){
	surface = surface_update;
	surface_update = "";
}

//update object properties

var actual_move_speed = move_speed;

if(state == "stand"){
	vert_speed = 0;
	air_speed = actual_move_speed;
	if(key_dash){
		dashing_counter = dash_duration;
	}
	if(dashing_counter > 0){
		dashing_counter--;
		actual_move_speed = actual_move_speed * 2;
	}	
	
	if(key_jump){		
		if(key_down && surface == "one_way"){
			stateUpdate = "fall";
			y+=2;
		} else {
			vert_speed = -jump_speed;	
			stateUpdate = "jump";
			air_speed = actual_move_speed;
		}		
	}	
} else if(state == "cling_left" || state == "cling_right"){
	if(key_dash){
		dashing_counter = dash_duration;
	}
	if(key_jump){
		vert_speed = -jump_speed;
		horz_cooldown = 5;
		if(state == "cling_left"){
			actual_move_speed = wall_jump_push;
		} else {
			actual_move_speed = -wall_jump_push;
		}
		stored_horz_speed = actual_move_speed;
		stateUpdate = "jump";
		if(dashing_counter > 0){
			air_speed = move_speed * 2;
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

