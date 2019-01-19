/// @description Attack State Handler
// You can write your code in this editor

// Inherit the parent event
event_inherited();

key_primary_pressed = gamepad_button_check_pressed(0, gp_face3);

if(key_primary_pressed && hitbox == -1) {
	combo_cooldown = 30;
	if(combo_counter == 0) {
		hitbox = instantiateHitbox(36 * facing,60,10 * facing,-26,4,3 * facing, 45, 1);
		combo_counter++;
	} else if(combo_counter == 1) {
		hitbox = instantiateHitbox(36 * facing,60,10 * facing,-26,4,3 * facing, 45, 1);
		combo_counter++;
	} else if(combo_counter == 2) {
		hitbox = instantiateHitbox(48 * facing,60,10 * facing,-26,16,3 * facing, 45, 3);
		combo_counter = 0;
	}	
} 

if(combo_cooldown <= 0) {
	combo_counter = 0;	
}	

combo_cooldown--;