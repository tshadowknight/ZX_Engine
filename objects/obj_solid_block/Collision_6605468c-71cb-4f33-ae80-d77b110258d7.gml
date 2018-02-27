/// @description Collision with Moveable



moveable_vert_sign = sign(other.vert_speed);
moveable_horz_sign = sign(other.horz_speed);
moveable_col_width = other.bbox_right - other.bbox_left;
moveable_col_height = other.bbox_bottom - other.bbox_top;
collider_width = self.bbox_bottom - self.bbox_top;

var collisions = get_collision_points(other, obj_solid_block);
top = collisions[0];
right = collisions[1];
bottom = collisions[2];
left = collisions[3];
topleft = collisions[4];
topright = collisions[5];
bottomright = collisions[6];
bottomleft = collisions[7];

var debug_msg = "Collision state: ";
debug_msg+="top: "+string(top)+", ";
debug_msg+="right: "+string(right)+", ";
debug_msg+="bottom: "+string(bottom)+", ";
debug_msg+="left: "+string(left)+", ";
debug_msg+="topleft: "+string(topleft)+", ";
debug_msg+="topright: "+string(topright)+", ";
debug_msg+="bottomright: "+string(bottomright)+", ";
debug_msg+="bottomleft: "+string(bottomleft)+", ";

show_debug_message(debug_msg);


if((other.horz_speed) == 1){
	obj_block_solid__BottomRight();
	obj_block_solid__BottomLeft();
} else {
	obj_block_solid__BottomLeft();
	obj_block_solid__BottomRight();	
}


obj_block_solid__TopRight();
obj_block_solid__TopLeft();

if(!bottomleft && !topleft && left){
	eject_horizontal(self, other, -1);
}

if(!bottomright && !topright && right){
	eject_horizontal(self, other, 1);
}





