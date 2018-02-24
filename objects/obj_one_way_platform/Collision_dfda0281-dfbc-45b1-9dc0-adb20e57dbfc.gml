/// @description One way platform 

moveable_vert_sign = sign(other.vert_speed);
moveable_col_height = other.bbox_bottom - other.bbox_top;
height = self.bbox_bottom - self.bbox_top;  

if(moveable_vert_sign != -1 && abs((other.y + moveable_col_height/2)  - ( self.y - height/2)) < abs(other.vert_speed)){
	// Inherit the parent event
	event_inherited();

	if(bottom || bottomright || bottomleft){
		other.stateUpdate = "stand";
		other.surface_update = "one_way";
	} 
}