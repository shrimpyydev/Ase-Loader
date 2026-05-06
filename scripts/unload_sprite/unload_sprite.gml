function unload_sprite(_aseprite_or_array)
{
	var _array = force_array(_aseprite_or_array);

	for (var i = 0; i < array_length(_array); i++)
	{
		var _struct = _array[i];
		surface_free(_struct.surface);
		vertex_delete_buffer(_struct.vert_buff);

		if (struct_exists(_struct, "flat_surf") == true)
		{
			surface_free(_struct.flat_surf);
		}

		if (struct_exists(_struct, "palette") == true)
		{
			struct_remove(_struct, "palette");
		}

		_struct.delete_flag = true;
	}

	with (ase_system)
	{
		struct_foreach(sprites, function(member_name, value)
		{
			if (struct_exists(value, "delete_flag") == true)
			{
				struct_remove(sprites, member_name);
			}
		});
	}
}