/// @description Insert description here
// You can write your code in this editor

/// @description Insert description here
// You can write your code in this editor

if(is_dead){
	visible = false;
	if(death_anim_counter == 0 || death_anim_counter == 28 ){
		var bottom_particle = instance_create_layer(x, y, "Instances", death_effect);
		bottom_particle.move_y = 1;
		var top_particle = instance_create_layer(x, y, "Instances", death_effect);
		top_particle.move_y = -1;
		var right_particle = instance_create_layer(x, y, "Instances", death_effect);
		right_particle.move_x = 1;
		var left_particle = instance_create_layer(x, y, "Instances", death_effect);
		left_particle.move_x = -1;
		
		var top_left_particle = instance_create_layer(x, y, "Instances", death_effect);
		top_left_particle.move_x = -1;
		top_left_particle.move_y = -1;
		top_left_particle.move_speed*=0.6;
		var top_right_particle = instance_create_layer(x, y, "Instances", death_effect);
		top_right_particle.move_x = 1;
		top_right_particle.move_y = -1;
		top_right_particle.move_speed*=0.6;
		var bottom_left_particle = instance_create_layer(x, y, "Instances", death_effect);
		bottom_left_particle.move_x = -1;
		bottom_left_particle.move_y = 1;
		bottom_left_particle.move_speed*=0.6;
		var bottom_right_particle = instance_create_layer(x, y, "Instances", death_effect);
		bottom_right_particle.move_x = 1;
		bottom_right_particle.move_y = 1;
		bottom_right_particle.move_speed*=0.6;
	}	
	death_anim_counter++;
	if(death_anim_counter > 200){
		instance_destroy(death_effect);
		death_anim_played = true;
	}
	return;
}

/// @description Falling State Handler
// You can write your code in this editor

current_animation_set = regular_animations;

switch(state){
	case("ladder"):
		sprite_index = current_animation_set[? "idle"];
		shooting_anim_last_context = "idle";
	break;
	case("stand"):
		var target_moving_sprite = current_animation_set[? "walk"];
		shooting_anim_last_context = "walk";
		if(dashing_counter > 0){
			target_moving_sprite = current_animation_set[? "dash"];
			shooting_anim_last_context = "dash";
		}
		if(key_left != 0){		
			sprite_index = target_moving_sprite;							
			image_xscale = base_scale * -1
		} else if(key_right != 0){			
			sprite_index = target_moving_sprite;						
			image_xscale = base_scale * 1;
		} else {
			sprite_index = current_animation_set[? "idle"];
			shooting_anim_last_context = "idle";
		}		
	break;
	case("jump"):		
		shooting_anim_last_context = "air";
		
		if(facing == -1){
			sprite_index = current_animation_set[? "jump"];	
			image_xscale = base_scale * -1;
		} else {
			sprite_index = current_animation_set[? "jump"];	
			image_xscale = base_scale * 1;
		}		
	
	break;	
	case("fall"):		
		shooting_anim_last_context = "air";		
		if(facing == -1){
			sprite_index = current_animation_set[? "fall"];	
			image_xscale = base_scale * -1;
		} else {
			sprite_index = current_animation_set[? "fall"];	
			image_xscale = base_scale * 1;
		}		
	break;
}


if(state != "jump" && state != "upper_cut"){
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

in_water = false;

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

touching_slope_top_left = false;
touching_slope_top_right = false;


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

interaction_points = ds_map_create();
interaction_points[? "bottom"] = [x, bbox_bottom];
interaction_points[? "top"] = [x, bbox_top];
interaction_points[? "left"] = [bbox_left, y];
interaction_points[? "right"] = [bbox_right, y];
interaction_points[? "bottomleft"] = [bbox_left, bbox_bottom];
interaction_points[? "bottomright"] = [bbox_right, bbox_bottom];
interaction_points[? "topleft"] = [bbox_left, bbox_top];
interaction_points[? "topright"] = [bbox_right, bbox_top];

current_interaction_points = ds_map_create();
current_interactions = ds_map_create();

var size, key, i;
size = ds_map_size(interaction_points);
key = ds_map_find_first(interaction_points);
for (i = 0; i < size; i++;){
	var check_pos = interaction_points[? key];
	current_interactable = instance_position(check_pos[0], check_pos[1], interactable);
	if(current_interactable != noone){
		current_interaction_points[? key] = current_interactable.type;
		current_interactions[? current_interactable.type] = true;
	}
	key = ds_map_find_next(interaction_points, key);
}

in_water = current_interactions[? "water"];
if(current_interactions[? "death"]){
	is_dead = true;
}

//Ladder detection
if(position_meeting(bbox_left, bbox_bottom, ladder) && position_meeting(bbox_right, bbox_bottom, ladder)){
	ladder_available = true;
} else {
	ladder_available = false;
}	 

if(ladder_available && state != "upper_cut"){
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
if(state != "stand" && state != "upper_cut"){
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
if(slope_cooldown <= 0 && vert_speed >= 0 && (on_slope || on_slope_left || on_slope_right) && state == "stand" && state != "upper_cut"){
	force_h_align = true;
} 


//Fall state detection
if(!bottom && !bottomright && !bottomleft && state != "cling_left" && state != "cling_right" && state != "ladder"  && state != "upper_cut"){
	if(sign(vert_speed) >= 0 ){ 		
		state = "fall";		
	}	
}


if(slope_cooldown >= 0){
	slope_cooldown--;
}



