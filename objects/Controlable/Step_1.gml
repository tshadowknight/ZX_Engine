/// @description Falling State Handler
// You can write your code in this editor

if(state != "jump"){
	if(force_h_align){
		var displacement = 0;
		standing_on = instance_position(x, bbox_bottom+1+displacement, obj_solid_block);	
		while(standing_on == noone){
			displacement++;
			standing_on = instance_position(x, bbox_bottom+1+displacement, obj_solid_block);			
		}
		if(displacement < 32){
			y+=displacement;
		}
		current_surface = standing_on.surface;		
		state = "stand";	
	} 
}
force_h_align = false;
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
bottom = position_meeting(x, bbox_bottom + 1, obj_solid_block) || position_meeting(x, bbox_bottom + 1, ladder_top);
bottomright = position_meeting(bbox_right, bbox_bottom + 1, obj_solid_block) || position_meeting(bbox_right, bbox_bottom + 1, ladder_top);
bottomleft = position_meeting(bbox_left, bbox_bottom + 1, obj_solid_block) || position_meeting(bbox_left, bbox_bottom + 1, ladder_top);

//Standing surface and slope detection


current_surface = "";
on_slope = false;
on_one_way = false;

current_surface_left = "";
on_slope_left = false;
on_one_way_left = false;

current_surface_right = "";
on_slope_right = false;
on_one_way_right = false;

touching_slope_left = false;
touching_slope_right = false;


var standing_on = instance_position(x, bbox_bottom+1, obj_solid_block);
if(standing_on != noone){
	current_surface = standing_on.surface;	
	if(sign(vert_speed) != -1){
		on_slope = standing_on.is_slope;
		on_one_way = standing_on.is_one_way;
	}	
}

var standing_on_left = instance_position(bbox_left, bbox_bottom+1, obj_solid_block);
if(standing_on_left != noone){
	current_surface_left = standing_on_left.surface;
	on_slope_left = standing_on_left.is_slope;
	on_one_way_left = standing_on_left.is_one_way;
}

var standing_on_right = instance_position(bbox_right, bbox_bottom+1, obj_solid_block);
if(standing_on_right != noone){
	current_surface_right = standing_on_right.surface;	
	on_slope_right = standing_on_right.is_slope;
	on_one_way_right = standing_on_right.is_one_way;
}

var touching_right = instance_position(bbox_right+1, y, obj_solid_block);
if(touching_right != noone){
	touching_slope_right = touching_right.is_slope;
}

var touching_left = instance_position(bbox_left+1, y, obj_solid_block);
if(touching_left != noone){
	touching_slope_left = touching_left.is_slope;
}

if(ignore_current_slope){
	if(!on_slope && !on_slope_left && !on_slope_right){
		ignore_current_slope = false;
	}
	on_slope = false;
	on_slope_left = false;
	on_slope_right = false;
}

//Ladder detection
if(position_meeting(bbox_left, bbox_bottom, ladder) && position_meeting(bbox_right, bbox_bottom, ladder)){
	ladder_available = true;
} else {
	ladder_available = false;
}	 

if(ladder_available){
	if(key_up){
		state = "ladder";		
	}	
} else if(state == "ladder") {
	var last_ladder_block = instance_position(x, bbox_bottom+ladder_speed, ladder);
	if(last_ladder_block && last_ladder_block.object_index == ladder_top){
		force_h_align = true;
	} else {
		state = "fall";
	}
}

if(key_down && current_surface_left == "ladder_top" && current_surface_right == "ladder_top"){
	state = "ladder";
}

if(state == "ladder"){
	var current_ladder_block = instance_position(x, bbox_bottom, ladder);
	if(current_ladder_block){
		x = current_ladder_block.x + (current_ladder_block.bbox_right - current_ladder_block.bbox_left)/2;
	}	
}

//Cling state detection
if(state != "stand"){
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
if(slope_cooldown <= 0 && vert_speed >= 0 && (on_slope || on_slope_left || on_slope_right) && state == "stand"){
	force_h_align = true;
} 


//Fall state detection
if(!bottom && !bottomright && !bottomleft && state != "cling_left" && state != "cling_right" && state != "ladder"){
	if(sign(vert_speed) >= 0 ){ 		
		state = "fall";		
	}	
}


if(slope_cooldown >= 0){
	slope_cooldown--;
}


