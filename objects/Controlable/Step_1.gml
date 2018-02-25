/// @description Falling State Handler
// You can write your code in this editor
key_right = gamepad_button_check(0, gp_padr);
key_left = -gamepad_button_check(0, gp_padl);
key_up = gamepad_button_check(0, gp_padu);
key_down = gamepad_button_check(0, gp_padd);

key_jump = gamepad_button_check_pressed(0, gp_face1);
key_dash = gamepad_button_check_pressed(0, gp_shoulderl);

topright = position_meeting(bbox_right + 1, bbox_top, obj_solid_block);
topleft = position_meeting(bbox_left - 1, bbox_top, obj_solid_block);
bottom = position_meeting(x, bbox_bottom + 1, obj_solid_block);
bottomright = position_meeting(bbox_right, bbox_bottom + 1, obj_solid_block);
bottomleft = position_meeting(bbox_left, bbox_bottom + 1, obj_solid_block);


if(key_left != 0 && (position_meeting(bbox_left-1, bbox_bottom, obj_solid_block) || position_meeting(bbox_left-1, y, obj_solid_block) || position_meeting(bbox_left-1, bbox_top, obj_solid_block)) && !bottom){
	state = "cling_left";
	cling_cooldown = 5;
}

if(key_right != 0 && (position_meeting(bbox_right+1, bbox_bottom, obj_solid_block) || position_meeting(bbox_right+1, y, obj_solid_block) || position_meeting(bbox_right+1, bbox_top, obj_solid_block)) && !bottom){
	state = "cling_right";
	cling_cooldown = 5;
}


if(state == "cling_left"){
	if(key_left == 0 || !topleft){
		if(cling_cooldown <= 0){
			state = "fall";
		}		
		cling_cooldown--;
	}		
}

if(state == "cling_right"){
	if(key_right == 0 || !topright){
		if(cling_cooldown <= 0 ){
			state = "fall";
		}		
		cling_cooldown--;
	}	
}


if(!bottom && !bottomright && !bottomleft && state != "cling_left" && state != "cling_right"){
	if(sign(vert_speed) >= 0 ){ 
		state = "fall";
	}	
} else if(bottom || bottomright || bottomleft){
	state = "stand";
} 
