/// @description Collision with Moveable
// You can write your code in this editor
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

if(bottom){
	while(position_meeting(other.x, other.y + moveable_col_height/2, self)){
		other.y -= 1
	}	
}