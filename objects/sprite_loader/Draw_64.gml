draw_text_colour(32,32,"Use O and P to change demo",c_white,c_white,c_white,c_white,1);
if(demo=0)
{
if(!surface_exists(ase_system.sprite_surf))
{
var message_text = "The top scrolling surface is the parsed .ase exploaded with all information expressed.\nAt the bottom, the image is flattened and layers with the visibility booleen set to false are not rendered.\nThe sprite in the middle of the screen is rendered dynamically, use left/right arrows to change animation.\n";
if(struct_exists(test_sprite,"tags"))
{
message_text+="Animation: "+animation+"\nFrame: "+string(ase_index-struct_get(test_sprite.tags,animation).from);	
	
}

draw_text_colour(room_width/2-512,room_height/2-96,message_text,c_white,c_white,c_white,c_white,1);
}
}
else if(demo==1)
{
	
draw_text_colour(room_width/2-512,room_height/2-96,"Observe palette swapping in action as the sprite changes from it's default to a supplied palette.",c_white,c_white,c_white,c_white,1);	
	
}
else if(demo==2)
{
draw_text_colour(room_width/2-512,room_height/2-96,"Ase Loader can also be used to dynamically toggle layers, allowing for effects such as player equipment.\nPress space to randomize equipment.\nNotice the flattened surface can be updated to match.",c_white,c_white,c_white,c_white,1);	
	
}
else
{
if(array_length(gen_sprites)==0)
{
draw_text_colour(room_width/2-512,96,"For the final demo, we'll convert the aseprite binary from demo one, into an array of real, gamemaker sprites\nthrough a process known as baking. Press B to do so now.",c_white,c_white,c_white,c_white,1);	
}
else
{
draw_text_colour(room_width/2-512,96,"Behold native gamemaker sprites rendered from a .ase file. These can be used in any way a dynamically generated sprite can be\nexpected to be used.",c_white,c_white,c_white,c_white,1);	
	
}
	
}