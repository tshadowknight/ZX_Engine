/// @description Input handler
//update state
if(stateUpdate != ""){
	state = stateUpdate;
	stateUpdate = "";
}
var height = bbox_bottom - bbox_top;
var width = bbox_right - bbox_left;
bottom = position_meeting(x, (y + height/2) + 1, obj_solid_block);
bottomright = position_meeting(x + width/2, (y + height/2) + 1, obj_solid_block);
bottomleft = position_meeting(x - width/2, (y + height/2) + 1, obj_solid_block);
if(!bottom && !bottomright && !bottomleft){
	if(state != "jump"){
		state = "fall";
	}	
}

//update standing surface
if(surface_update != ""){
	surface = surface_update;
	surface_update = "";
}

//poll input
key_right = keyboard_check(vk_right)
key_left = -keyboard_check(vk_left)
key_up = keyboard_check(vk_up)
key_down = -keyboard_check(vk_down)

key_jump = keyboard_check_pressed(vk_space)

//update object properties
horz_delta = key_left + key_right  
horz_speed = horz_delta * move_speed

if(state == "stand"){
	vert_speed = 0;
	if(key_jump){		
		vert_speed = -jump_speed;	
		stateUpdate = "jump";
	}
} else if(vert_speed < 10){
	vert_speed += grav;	
}	

//update object coordinates
x+=horz_speed;
y+=vert_speed; 

