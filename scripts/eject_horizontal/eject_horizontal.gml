var collider = argument[0];
var moveable = argument[1];
var ejection_direction = argument[2];

show_debug_message("Eject horizontal: "+string(ejection_direction));

if(ejection_direction != 0){
	
	while(place_meeting(x, y, moveable)){
		moveable.x -= ejection_direction
	}	
}
