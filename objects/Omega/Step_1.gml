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
// Inherit the parent event
switch(state){
	case("ladder"):
		sprite_index = omega_idle;
	break;
	case("stand"):
		var target_moving_sprite = omega_walk;
		if(dashing_counter > 0){
			target_moving_sprite = omega_dash;
		}
		if(key_left != 0){		
			sprite_index = target_moving_sprite;							
			image_xscale = -1;
		} else if(key_right != 0){			
			sprite_index = target_moving_sprite;						
			image_xscale = 1;
		} else {
			sprite_index = omega_idle;
		}		
	break;
	case("jump"):		
		if(sprite_index != omega_jump){
			animation_state = "jump_start";
		}
		if(animation_state == "jump_loop" && floor(image_index) == 0){
			image_index = 3;
		}
		if(facing == -1){
			sprite_index = omega_jump;	
			image_xscale = -1;
		} else {
			sprite_index = omega_jump;	
			image_xscale = 1;
		}		
		if(image_index >= 3){
			animation_state = "jump_loop";
		}
	break;	
	case("fall"):		
		if(sprite_index != omega_fall){
			animation_state = "fall_start";
		}
		if(animation_state == "fall_loop" && floor(image_index) == 0){
			image_index = 1;
		}
		if(facing == -1){
			sprite_index = omega_fall;	
			image_xscale = -1;
		} else {
			sprite_index = omega_fall;	
			image_xscale = 1;
		}		
		if(image_index >= 1){
			animation_state = "fall_loop";
		}
	break;
}

event_inherited();

