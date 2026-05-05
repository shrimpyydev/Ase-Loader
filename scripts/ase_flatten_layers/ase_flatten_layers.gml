function ase_flatten_layers(_struct){
if(struct_exists(_struct,"flat_surf"))
{
	if(surface_exists(_struct.flat_surf))
	{
	surface_free(_struct.flat_surf);
	}
	
	
}

_struct.flat_surf=-1;	

var height = _struct.height;
var base_surf = _struct.surface;
var base_height=surface_get_height(base_surf);
var base_width = surface_get_width(base_surf);
var flat_surf = surface_create(surface_get_width(base_surf),height);

surface_set_target(flat_surf);
draw_clear_alpha(c_black,0);
if(_struct.color_depth == 8)
{
shader_set(shd_write_index_flat);	
}
else if(_struct.color_depth == 16)
{
shader_set(shd_write_greyscale_flat);	
}

for(var i=0; i<array_length(_struct.layers); i++)
	{
	var current_layer=_struct.layers[i];
	if(bool(current_layer.visible)==true)
	{
	draw_surface_part(base_surf,0,height*i,base_width,height,0,0);
	
	
	}
	
	}
	surface_reset_target();
	shader_reset();
	
	_struct.flat_surf=flat_surf;
}