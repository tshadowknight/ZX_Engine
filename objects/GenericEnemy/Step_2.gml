/// @description Insert description here
// You can write your code in this editor
/// @description Insert description here
// You can write your code in this editor

//hitbox
if(hitbox != -1){
    with(hitbox){
        x = other.x + xOffset;
        y = other.y + yOffset;
    }
}
//hurtbox
with(hurtbox){
    x = other.x + xOffset;
    y = other.y + yOffset;
}