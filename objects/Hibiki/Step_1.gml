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

event_inherited();

