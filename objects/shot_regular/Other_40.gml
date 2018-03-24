/// @description Destroy when out 
// You can write your code in this editor

if(originator != noone){
	originator.current_projectile_count--;
}
instance_destroy(self)