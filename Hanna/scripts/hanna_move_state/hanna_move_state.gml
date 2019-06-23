///player_move_state()
//Moves the player according to input and gravitational forces

//Get input
var right = d_key;
var left = a_key;
var jump = space_key;
var jump_let_go = space_key_let_go;
var heal = heal_key;
var x_input = (right - left) * acceleration;

var on_ground = !place_empty(x, y + 1, obj_solid);

//Take damage
if(can_get_hurt) {
	if(!place_empty(x, y, obj_spider)) {
		hp -= 10;
		can_get_hurt = false;
		velocity[0] = irandom_range(-3*max_velocity[0], 3*max_velocity[0]);
		velocity[1] = -jump_speed;
		sprite_index = spr_hanna;
		alarm[1] = room_speed/8;
		alarm[0] = 2*room_speed;
		exit;
	}
}

if(hurt_flash) {
	image_alpha = 0;	
} else {
	image_alpha = 1;	
}

//Damage enemies
if(!on_ground) {
	var spider_list = ds_list_create();
	var spiders = instance_place_list(x, y + velocity[1], obj_spider, spider_list, false);
	if(spiders > 0) {
		for(var i = 0; i < ds_list_size(spider_list); i++) {
			instance_destroy(spider_list[| i]);	
		}
	}
	spiders = instance_place_list(x - sprite_width/4, y + velocity[1], obj_spider, spider_list, false);
	if(spiders > 0) {
		for(var i = 0; i < ds_list_size(spider_list); i++) {
			instance_destroy(spider_list[| i]);	
		}
	}
	spiders = instance_place_list(x + sprite_width/4, y + velocity[1], obj_spider, spider_list, false);
	if(spiders > 0) {
		for(var i = 0; i < ds_list_size(spider_list); i++) {
			instance_destroy(spider_list[| i]);	
		}
	}
	ds_list_destroy(spider_list);	
}

//Abilities
//Healing
if(heal) {
	if(mana >= 20 && hp < max_hp) {
		mana = max(0, mana - 20);	
		hp = min(hp + 20, max_hp);
		repeat(irandom_range(20, 30)) {
			instance_create_layer(x + random_range(-abs(sprite_width)/2, abs(sprite_width)/2), y + random_range(-sprite_height/4, sprite_height/2), "Instances", obj_heal_blob);	
		}
	}
}

//Horizontal movement
velocity[0] = clamp(velocity[0]+x_input, -max_velocity[0], max_velocity[0]);

//Friction
if(x_input == 0) {
    velocity[0] = lerp(velocity[0], 0, .2);
	if(on_ground) {
		sprite_index = spr_hanna;
	} else {
		sprite_index = spr_hanna_jump;
	}
} else {
	image_xscale = sign(x_input);
	if(on_ground) {
		sprite_index = spr_hanna_running;
	} else {
		sprite_index = spr_hanna_jump;
	}
}

//Gravity
velocity[1] += grav;

//Jumping
if(on_ground) {
    jumps = jump_amount;
    if(jump) {
        velocity[1] = -jump_speed;
        jumps--;
    }
} else {
    //Control jump height
    if(jump_let_go && velocity[1] <= -(jump_speed/3)) {
        velocity[1] = -(jump_speed/3);
    }
    
    if(jump && jumps > 0) {
        velocity[1] = -jump_speed;
        jumps--;
    }
}

//Move and contact tiles
move(velocity);