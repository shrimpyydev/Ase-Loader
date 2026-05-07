function batch_exploaded_layer_range(sprite_struct, anim_name, first, last)
{
	var sub_struct =
	{
		bbox : [first * sprite_struct.width, 0, (1 + last) * sprite_struct.width, surface_get_height(sprite_struct.surface)],
		source_surface : sprite_struct.surface,
		source_sprite : sprite_struct.name,
	};

	struct_set(ase_system.sprite_data.to_pack, "spr_" + sprite_struct.name + "_" + safe_string(anim_name), sub_struct);
}