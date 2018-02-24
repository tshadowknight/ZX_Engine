var requestor = argument[0];
var collide_with = argument[1];

var height = requestor.bbox_bottom - requestor.bbox_top;
var width = requestor.bbox_right - requestor.bbox_left;

top = position_meeting(requestor.x , requestor.y - height/2, collide_with);
right = position_meeting(requestor.x + width/2, requestor.y , collide_with);
bottom = position_meeting(requestor.x, requestor.y + height/2, collide_with);
left = position_meeting(requestor.x - width/2, requestor.y, collide_with);
topleft = position_meeting(requestor.x - width/2, requestor.y - height/2, collide_with);
topright = position_meeting(requestor.x + width/2, requestor.y - height/2, collide_with);
bottomright = position_meeting(requestor.x + width/2, requestor.y + height/2, collide_with);
bottomleft = position_meeting(requestor.x - width/2, requestor.y + height/2, collide_with);

return [top, right, bottom, left, topleft, topright, bottomright, bottomleft];