_hitbox = instance_create_layer(x, y, "Hurtboxes", oHitBox);
_hitbox.owner = id;
_hitbox.image_xscale = argument0;
_hitbox.image_yscale = argument1;
_hitbox.xOffset = argument2;
_hitbox.yOffset = argument3;
_hitbox.life = argument4;
_hitbox.xHit = argument5;
_hitbox.hitStun = argument6;
_hitbox.damage = argument7;

return _hitbox;