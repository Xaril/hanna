/// @author Fredrik Omstedt
/// @description
randomize();

globalvar seconds_passed;
seconds_passed = 0;

globalvar d_key;
d_key = 0;
globalvar a_key;
a_key = 0;
globalvar space_key;
space_key = 0;
globalvar space_key_let_go;
space_key_let_go = 0;

hanna = instance_create_layer(480, 940, "Instances", obj_hanna);