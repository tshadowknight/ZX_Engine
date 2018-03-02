/// @description Insert description here
// You can write your code in this editor
/// @description Collision with Moveable
// You can write your code in this editor
moveable_vert_sign = sign(other.vert_speed);
moveable_horz_sign = sign(other.horz_speed);
moveable_col_width = other.bbox_right - other.bbox_left;
moveable_col_height = other.bbox_bottom - other.bbox_top;


var collisions = get_collision_points(other, obj_solid_block);
top = collisions[0];
right = collisions[1];
bottom = collisions[2];
left = collisions[3];
topleft = collisions[4];
topright = collisions[5];
bottomright = collisions[6];
bottomleft = collisions[7];


var collider_width = self.bbox_right - self.bbox_left;
var reference_x = other.x - bbox_left;

if(reference_x >= 0 && reference_x <= collider_width && !other.ignore_current_slope){
	var reference_idx = array_length_1d(bbox_heights) * floor(reference_x / collider_width);
	if(image_xscale == -1){
		reference_idx = array_length_1d(bbox_heights) - reference_idx - 1;
	}
	var reference_height = bbox_heights[reference_idx];
	if(other.on_slope || abs((other.bbox_bottom) - (bbox_bottom - reference_height)) < abs(other.vert_speed)){
		while(position_meeting(other.x, other.bbox_bottom, self)){
			other.y -= 1
		}
		if(other.vert_speed >= 0){
			other.state = "stand";
		}		
	}
}