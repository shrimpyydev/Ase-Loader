function bake_surface(_struct)
{
	var surf; // Hoisted the declaration out of the switch cases to prevent potential variable redeclaration warnings

	switch (_struct.color_depth)
	{
		case 32:
			surf = surface_create(_struct.width * _struct.frame_count, _struct.height * array_length(_struct.layers));
			break;

		case 16:
			if (surface_format_is_supported(surface_rg8unorm) == true)
			{
				surf = surface_create(_struct.width * _struct.frame_count, _struct.height * array_length(_struct.layers), surface_rg8unorm);
			}
			else
			{
				surf = surface_create(_struct.width * _struct.frame_count, _struct.height * array_length(_struct.layers));
			}
			
			shader_set(shd_write_greyscale);
			break;

		case 8:
			if (surface_format_is_supported(surface_r8unorm) == true)
			{
				surf = surface_create(_struct.width * _struct.frame_count, _struct.height * array_length(_struct.layers), surface_r8unorm);
			}
			else
			{
				surf = surface_create(_struct.width * _struct.frame_count, _struct.height * array_length(_struct.layers));
			}
			
			shader_set(shd_write_index);
			break;
	}

	if (surface_exists(_struct.surface) == true)
	{
		surface_free(_struct.surface);
	}

	_struct.surface = surf;

	surface_set_target(_struct.surface);
	draw_clear_alpha(c_black, 0);
	vertex_submit(_struct.vert_buff, pr_pointlist, -1);
	surface_reset_target();
	shader_reset();
}