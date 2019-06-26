/// @description Boss battle engaged
for(var i = 0; i < ds_list_size(platforms); i++) {
	instance_destroy(platforms[| i]);	
}
ds_list_destroy(platforms);

for(var xx = room_width/2 - 64; xx < room_width/2 + 64; xx += 32) {
	instance_create_layer(xx, 1024, "Instances", obj_solid); 
}

instance_create_layer(obj_dr_demon_before.x, obj_dr_demon_before.y, "Instances", obj_dr_demon);
instance_destroy(obj_dr_demon_before);
instance_destroy(obj_spawner);