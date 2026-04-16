function bake_surface(_struct){

switch(_struct.color_depth){
case 32:	
var surf = surface_create(_struct.width*_struct.frame_count,_struct.height*array_length(_struct.layers));
break;

case 16: 
if(surface_format_is_supported(surface_rg8unorm))
{
var surf = surface_create(_struct.width*_struct.frame_count,_struct.height*array_length(_struct.layers),surface_rg8unorm);
}
else
{
var surf = surface_create(_struct.width*_struct.frame_count,_struct.height*array_length(_struct.layers));
	
}
shader_set(shd_write_greyscale);
break;

case 8:
if(surface_format_is_supported(surface_r8unorm))
{
var surf = surface_create(_struct.width*_struct.frame_count,_struct.height*array_length(_struct.layers),surface_r8unorm);
}
else
{
var surf = surface_create(_struct.width*_struct.frame_count,_struct.height*array_length(_struct.layers));
	
}

shader_set(shd_write_index);
break;
}

if(surface_exists(_struct.surface))
{
surface_free(_struct.surface);	
}

_struct.surface = surf;

surface_set_target(_struct.surface);
draw_clear_alpha(c_black,0);
vertex_submit(_struct.vert_buff,pr_pointlist,-1);
surface_reset_target();
shader_reset();
}