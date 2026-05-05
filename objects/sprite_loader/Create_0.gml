 //

test_sprite = load_ase_serialized("satyr.gmase");

equip_test = load_ase("demoman.ase");
recolor_test = load_ase("merchant_indexed.aseprite");
ase_set_origin(test_sprite,test_sprite.width/2,test_sprite.height/2);
ase_set_origin(equip_test,equip_test.width/2,equip_test.height/2);
ase_set_origin(recolor_test,recolor_test.width/2,recolor_test.height/2);
recolor_pal=ase_sprite_to_pal(test_palette,0);
animation=-1;




if(struct_exists(test_sprite,"tags"))
{
animation_index=0;
animation_list=struct_get_names(test_sprite.tags);
}
if(struct_exists(test_sprite,"palette"))
{
pal=test_sprite.palette.data;	
}
else
{
pal=array_create(255*4,0);
}

ase_flatten_layers(test_sprite);
ase_flatten_layers(recolor_test);
ase_flatten_layers(equip_test);
x_shift=0;
clipboard_set_text(json_stringify(test_sprite,1));

gen_index=1;
gen_sprites=[];
gpu_set_sprite_cull(0);
demo = 0;
palette_lerp=0;
gpu_set_alphatestenable(1);
alarm[0]=room_speed;
