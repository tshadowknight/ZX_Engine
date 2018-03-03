/// @description Handle room updates


if(player_reference == noone){
	var spawn = spwan_points[? "init"];
	player_reference = instance_create_layer(spawn[0], spawn[1], "Instances", Omega);
}

if(player_reference.is_dead && player_reference.death_anim_played){	
	instance_destroy(player_reference);
	player_reference = noone;
}