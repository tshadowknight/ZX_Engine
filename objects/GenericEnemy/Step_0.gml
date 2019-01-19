/// @description Insert description here
// You can write your code in this editor
bottom = position_meeting(x, bbox_bottom + 1, obj_solid_block)

if(vert_speed < 1){
	vert_speed+=grav;
}	

x+=horz_speed;
y+=vert_speed;

if(hitPoints <= 0){
	instance_destroy(hurtbox);	
	instance_destroy();
}	