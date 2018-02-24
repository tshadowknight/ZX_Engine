var collider = argument[0];
var moveable = argument[1];
var ejection_direction = argument[2];

show_debug_message("Eject vertical: "+string(ejection_direction));

if(ejection_direction != 0){
	
	while(place_meeting(collider.x, collider.y, moveable)){
		moveable.y -= ejection_direction
	}	
}
