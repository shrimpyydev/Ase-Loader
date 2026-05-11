function determine_shader(_struct, _palette_index = array_create(255, 0))
{
	var color_depth = _struct.color_depth;

	if (color_depth == 16)
	{
		shader_set(shd_greyscale);
	}
	else if (color_depth == 8)
	{
		shader_set(shd_index);
		shader_set_uniform_f_array(shader_get_uniform(shd_index, "pal"), _palette_index);
	}
}