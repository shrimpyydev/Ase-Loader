function ase_sprite_to_pal(_sprite, _index)
{
	var width = sprite_get_width(_sprite);
	var height = sprite_get_height(_sprite);
	var size = width * height;
	var temp_surf = surface_create(width, height);
	
	surface_set_target(temp_surf);
	draw_sprite(_sprite, _index, 0, 0);
	surface_reset_target();
	
	var pal = [];
	
	for (var i = 0; i < height; i++)
	{
		if (array_length(pal) >= 255)
		{
			break;
		}
		
		for (var j = 0; j < width; j++)
		{
			if (array_length(pal) >= 255)
			{
				break;
			}
			
			var col = surface_getpixel_ext(temp_surf, j, i);
			var alpha = (col >> 24) & 255;
			var blue = (col >> 16) & 255;
			var green = (col >> 8) & 255;
			var red = col & 255;
			
			array_push(pal, red / 255, green / 255, blue / 255, alpha / 255);
		}
	}
	
	surface_free(temp_surf);
	
	return pal;
}