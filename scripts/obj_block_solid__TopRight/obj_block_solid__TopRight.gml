if(topright){
	if(right && !top){
		eject_horizontal(self, other, 1);
	} else if(!right && top){
		other.vert_speed = 0;
		eject_vertical(self, other, -1);
	} else {		
		if(moveable_vert_sign == -1){
			other.vert_speed = 0;
			eject_vertical(self, other, -1);
			eject_horizontal(self, other, moveable_horz_sign);		
					
		} else {	
			eject_vertical(self, other, -1);
			eject_horizontal(self, other, moveable_horz_sign);
		}	
	}	
}