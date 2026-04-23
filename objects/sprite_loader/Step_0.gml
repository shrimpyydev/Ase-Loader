demo += keyboard_check_pressed(ord("P")) -  keyboard_check_pressed(ord("O"));
if(demo>3)
{
demo=0;	
}
else if(demo<0)
{
demo=3;	
}


if(demo=0)
{
if(struct_exists(test_sprite,"tags"))
{
animation_index=clamp(animation_index+(keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)),0,array_length(animation_list)-1);

if(animation!=animation_list[animation_index])
{
	
change_animation(test_sprite,animation_list[animation_index])	
}
}

advance_frame(test_sprite,animation,1);
x_shift-=1;
if(x_shift<=-surface_get_width(test_sprite.surface))
{
x_shift+=surface_get_width(test_sprite.surface);	
	
	
	
}

}
else if(demo==1)
{
if(struct_exists(recolor_test,"tags"))
{
animation_index=clamp(animation_index+(keyboard_check_pressed(vk_right)-keyboard_check_pressed(vk_left)),0,array_length(animation_list)-1);

if(animation!=animation_list[animation_index])
{
	
change_animation(recolor_test,animation_list[animation_index])	
}
}

advance_frame(recolor_test,animation,1);
x_shift-=1;
if(x_shift<=-surface_get_width(recolor_test.surface))
{
x_shift+=surface_get_width(recolor_test.surface);	
	
	
	
}

}