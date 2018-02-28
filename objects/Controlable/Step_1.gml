/// @description Falling State Handler
// You can write your code in this editor

//Check inputs
key_right = gamepad_button_check(0, gp_padr);
key_left = -gamepad_button_check(0, gp_padl);
key_up = gamepad_button_check(0, gp_padu);
key_down = gamepad_button_check(0, gp_padd);

key_jump = gamepad_button_check_pressed(0, gp_face1);
key_dash = gamepad_button_check_pressed(0, gp_shoulderl);

//Collision points
topright = position_meeting(bbox_right + 1, bbox_top, obj_solid_block);
topleft = position_meeting(bbox_left - 1, bbox_top, obj_solid_block);
bottom = position_meeting(x, bbox_bottom + 1, obj_solid_block);
bottomright = position_meeting(bbox_right, bbox_bottom + 1, obj_solid_block);
bottomleft = position_meeting(bbox_left, bbox_bottom + 1, obj_solid_block);

//Standing surface detection
var standing_on = instance_position(x, bbox_bottom+1, obj_solid_block);
if(standing_on != noone){
	current_surface = standing_on.surface;	
}

var standing_on_left = instance_position(bbox_left, bbox_bottom+1, obj_solid_block);
if(standing_on_left != noone){
	current_surface_left = standing_on_left.surface;	
}

var standing_on_right = instance_position(bbox_right, bbox_bottom+1, obj_solid_block);
if(standing_on_right != noone){
	current_surface_right = standing_on_right.surface;	
}

//Cling state detection
if(key_left != 0){
	var cling_bottomleft = instance_position(bbox_left-1, bbox_bottom, obj_solid_block);
	var cling_left = instance_position(bbox_left-1, y, obj_solid_block);
	var cling_topleft = instance_position(bbox_left-1, bbox_top, obj_solid_block)
	if((cling_bottomleft != noone && cling_bottomleft.clingeable) || (cling_left != noone && cling_left.clingeable) || (cling_topleft != noone && cling_topleft.clingeable)){
		state = "cling_left";
		cling_cooldown = 5;
	}	
}

if(key_right != 0){
	var cling_bottomright = instance_position(bbox_right+1, bbox_bottom, obj_solid_block);
	var cling_right = instance_position(bbox_right+1, y, obj_solid_block);
	var cling_topright = instance_position(bbox_right+1, bbox_top, obj_solid_block)
	if((cling_bottomright != noone && cling_bottomright.clingeable) || (cling_right != noone && cling_right.clingeable) || (cling_topright != noone && cling_topright.clingeable)){
		state = "cling_right";
		cling_cooldown = 5;
	}	
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

//Slope alignment
//when in contact with a slope on any bottom point the player should be forcefully aligned to the ground
if(slope_cooldown <= 0 && (current_surface == "slope" || current_surface_left == "slope" || current_surface_right == "slope")){
	while(standing_on == noone){
		y++;
		standing_on = instance_position(x, bbox_bottom+1, obj_solid_block);			
	}
	current_surface = standing_on.surface;		
	state = "stand";	
} else { //Standing state detection
	if(bottom || bottomright || bottomleft){
		state = "stand";
	} 
}
slope_cooldown--;

//Fall state detection
if(!bottom && !bottomright && !bottomleft && state != "cling_left" && state != "cling_right"){
	if(sign(vert_speed) >= 0 ){ 
		if(current_surface != "slope"){
			state = "fall";
		} 	
	}	
}
