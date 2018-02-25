if(bottomleft){
	if(left && !bottom){
		eject_horizontal(self, other, -1);
	} else if(!left && bottom){
		eject_vertical(self, other, 1);
	} else {
		if(moveable_vert_sign == -1){
			eject_horizontal(self, other, -1);		
		} else if(abs((other.bbox_left) - (self.bbox_right)) <= abs(other.horz_speed) ) {
			eject_horizontal(self, other, -1);	
		} else {
			eject_vertical(self, other, moveable_vert_sign);
			eject_horizontal(self, other, -1);	
		}		
	}
}