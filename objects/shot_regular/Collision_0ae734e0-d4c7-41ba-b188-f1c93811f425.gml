/// @description Destroy on collision with solid

if(!other.is_one_way && !other.is_ladder){

	if(originator != noone){
		originator.current_projectile_count--;
	}
	instance_destroy(self);
	
}