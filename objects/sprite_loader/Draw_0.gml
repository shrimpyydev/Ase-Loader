if (demo == 0)
{
	determine_shader(test_sprite, pal);
	draw_surface(test_sprite.surface, x_shift, 0);
	draw_surface(test_sprite.surface, x_shift + surface_get_width(test_sprite.surface) - 1, 0);

	//draw_cell_ext(test_sprite, ase_index, room_width / 2, room_height / 2 + 128, 4, 4, direction);
    draw_cell_ext(test_sprite, ase_index, room_width / 2, room_height / 2 , 1, 1, direction);
	shader_reset();

	draw_surface(test_sprite.flat_surf, x_shift, room_height - test_sprite.height);
	draw_surface(test_sprite.flat_surf, x_shift + surface_get_width(test_sprite.flat_surf) - 1, room_height - test_sprite.height);
}
else if (demo == 1)
{
	palette_lerp = frac(palette_lerp + 0.0125);
	var blended_pal = array_create(array_length(recolor_pal));

	for (var i = 0; i < array_length(recolor_pal); i += 4)
	{
		blended_pal[i] = lerp(recolor_test.palette.data[i], recolor_pal[i], palette_lerp);
		blended_pal[i + 1] = lerp(recolor_test.palette.data[i + 1], recolor_pal[i + 1], palette_lerp);
		blended_pal[i + 2] = lerp(recolor_test.palette.data[i + 2], recolor_pal[i + 2], palette_lerp);
		blended_pal[i + 3] = lerp(recolor_test.palette.data[i + 3], recolor_pal[i + 3], palette_lerp);
	}

	determine_shader(recolor_test, blended_pal);
	draw_surface(recolor_test.surface, x_shift, 0);
	draw_surface(recolor_test.surface, x_shift + surface_get_width(recolor_test.surface) - 1, 0);

	draw_cell_ext(recolor_test, ase_index, room_width / 2, room_height / 2 + 128, 4, 4, direction);
	shader_reset();

	shader_set(shd_index);
	shader_set_uniform_f_array(shader_get_uniform(shd_index, "pal"), blended_pal);

	draw_surface(recolor_test.flat_surf, x_shift, room_height - recolor_test.height);
	draw_surface(recolor_test.flat_surf, x_shift + surface_get_width(recolor_test.flat_surf) - 1, room_height - recolor_test.height);
	shader_reset();
}
else if (demo == 2)
{
	draw_surface_ext(equip_test.surface, 0, 0, 4, 4, 0, c_white, 1);
	
	if (keyboard_check_pressed(vk_space) == true)
	{
		for (var i = 0; i < array_length(equip_test.layers); i++)
		{
			var current_layer = equip_test.layers[i];
			if (current_layer.layer_name != "Man")
			{
				current_layer.visible = 0;
			}
		}
		
		var shirt = equip_test.layers[choose(1, 2, 3)];
		shirt.visible = 1;
		equip_test.layers[4].visible = choose(0, 1);
		equip_test.layers[5].visible = choose(0, 1);
		equip_test.layers[6].visible = choose(0, 1);
		ase_flatten_layers(equip_test);
	}

	draw_cell_ext(equip_test, 0, room_width / 2, room_height / 2 + 128, 4, 4, direction);

	draw_surface_ext(equip_test.flat_surf, 0, room_height - equip_test.height * 4, 4, 4, 0, c_white, 1);
}
else if (demo == 3)
{
	if (array_length(gen_sprites) != 0)
	{
		var draw_y = room_height / 2 - 256;
		var draw_x = room_width / 2;
		
		for (var i = 0; i < array_length(gen_sprites); i++)
		{
			var current_sprite = gen_sprites[i];
			for (var j = 0; j < sprite_get_number(current_sprite); j++)
			{
				draw_sprite(current_sprite, j, draw_x, draw_y + j * sprite_get_height(current_sprite));
			}
			draw_x += sprite_get_width(current_sprite);
		}
	}
}
