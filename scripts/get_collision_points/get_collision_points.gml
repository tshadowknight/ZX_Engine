var requestor = argument[0];
var collide_with = argument[1];

var height = requestor.bbox_bottom - requestor.bbox_top

top = position_meeting(requestor.x , requestor.bbox_top, collide_with);
bottom = position_meeting(requestor.x, requestor.bbox_bottom, collide_with);
left = (
	position_meeting(requestor.bbox_left, requestor.y, collide_with)  || 
	position_meeting(requestor.bbox_left, requestor.y + height/4 , collide_with) || 
	position_meeting(requestor.bbox_left, requestor.y + height/8 , collide_with) || 
	position_meeting(requestor.bbox_left, requestor.y + (height/8)*3 , collide_with) ||
	position_meeting(requestor.bbox_left, requestor.y - height/4 , collide_with) ||
	position_meeting(requestor.bbox_left, requestor.y - height/8 , collide_with) || 
	position_meeting(requestor.bbox_left, requestor.y - (height/8)*3 , collide_with) 
);	
right = (
	position_meeting(requestor.bbox_right, requestor.y, collide_with)  || 
	position_meeting(requestor.bbox_right, requestor.y + height/4 , collide_with) || 
	position_meeting(requestor.bbox_right, requestor.y + height/8 , collide_with) || 
	position_meeting(requestor.bbox_right, requestor.y + (height/8)*3 , collide_with) ||
	position_meeting(requestor.bbox_right, requestor.y - height/4 , collide_with) ||
	position_meeting(requestor.bbox_right, requestor.y - height/8 , collide_with) || 
	position_meeting(requestor.bbox_right, requestor.y - (height/8)*3 , collide_with) 
);

topleft = position_meeting(requestor.bbox_left, requestor.bbox_top, collide_with);
topright = position_meeting(requestor.bbox_right, requestor.bbox_top, collide_with);
bottomright = position_meeting(requestor.bbox_right, requestor.bbox_bottom, collide_with);
bottomleft = position_meeting(requestor.bbox_left, requestor.bbox_bottom, collide_with);

return [top, right, bottom, left, topleft, topright, bottomright, bottomleft];