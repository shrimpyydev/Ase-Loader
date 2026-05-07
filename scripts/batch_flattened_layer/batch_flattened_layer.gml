function batch_flattened_layer(sprite_struct)
{
	if (struct_exists(sprite_struct, "flat_surf") == false)
	{
		ase_flatten_layers(sprite_struct);
	}

	if (struct_exists(sprite_struct, "tags") == true)
	{
		var tag_names = struct_get_names(sprite_struct.tags);

		for (var i = 0; i < array_length(tag_names); i++)
		{
			var full_name = "spr_" + sprite_struct.name + "_" + safe_string(tag_names[i]);
			var current_animation = struct_get(sprite_struct.tags, tag_names[i]);
			
			var sub_struct =
			{
				bbox : [current_animation.from * sprite_struct.width, 0, (current_animation.to + 1) * sprite_struct.width, surface_get_height(sprite_struct.flat_surf)],
				source_surface : sprite_struct.flat_surf,
				source_sprite : sprite_struct.name,
				full_name : full_name,
			};

			struct_set(ase_system.sprite_data.to_pack, sub_struct.full_name, sub_struct);
		}
	}
	else
	{
		var sub_struct =
		{
			bbox : [0, 0, surface_get_width(sprite_struct.flat_surf), surface_get_height(sprite_struct.flat_surf)],
			source_surface : sprite_struct.flat_surf,
			source_sprite : sprite_struct.name,
		};

		struct_set(ase_system.sprite_data.to_pack, "spr_" + safe_string(sprite_struct.name), sub_struct);
	}
}