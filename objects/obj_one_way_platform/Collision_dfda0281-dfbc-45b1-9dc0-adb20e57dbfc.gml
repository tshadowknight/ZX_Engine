/// @description One way platform 

moveable_vert_sign = sign(other.vert_speed);
if(moveable_vert_sign != -1 && abs((other.bbox_bottom)  - ( self.bbox_top)) < abs(other.vert_speed)){
	while(position_meeting(other.x, other.bbox_bottom, self) || position_meeting(other.bbox_left, other.bbox_bottom, self) || position_meeting(other.bbox_right, other.bbox_bottom, self)){
		other.y -= 1
	}	
	other.state = "stand";
	//other.current_surface = "one_way";
}