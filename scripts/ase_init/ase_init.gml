vertex_format_begin();
vertex_format_add_position();
vertex_format_add_colour();

global.ase_rgba = vertex_format_end();

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_custom(vertex_type_float2, vertex_usage_color);

global.ase_greyscale = vertex_format_end();

vertex_format_begin();
vertex_format_add_position();
vertex_format_add_custom(vertex_type_float1, vertex_usage_color);

global.ase_index = vertex_format_end();

global.ase_struct =
{
	sprites : {},
	sprite_surf : -1,
	compiled_sprites : {},
};

#macro ase_system global.ase_struct