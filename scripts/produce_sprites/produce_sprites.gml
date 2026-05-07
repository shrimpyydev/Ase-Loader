function produce_sprites(_string)
{
	var w = surface_get_width(ase_system.sprite_surf);
	var h = surface_get_height(ase_system.sprite_surf);

	if (struct_exists(ase_system, "texture_buffers") == false)
	{
		ase_system.texture_buffers = {};
	}

	struct_set(ase_system.texture_buffers, _string, buffer_create(16 + (w * h * 4), buffer_fixed, 1));
	var sprite_buff = struct_get(ase_system.texture_buffers, _string);

	// "RAW " magic (note: little-endian!)
	buffer_write(sprite_buff, buffer_u32, 0x20574152);

	// width & height
	buffer_write(sprite_buff, buffer_s32, w);
	buffer_write(sprite_buff, buffer_s32, h);

	// format (must be 0)
	buffer_write(sprite_buff, buffer_s32, 0);

	buffer_get_surface(sprite_buff, ase_system.sprite_surf, 16);
	surface_free(ase_system.sprite_surf);
	texturegroup_add(_string, sprite_buff, ase_system.compiled_sprites);

	// show_debug_message(json_stringify(ase_system.compiled_sprites, 1));

	return texturegroup_get_sprites(_string);
}