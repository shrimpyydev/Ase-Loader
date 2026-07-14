function draw_cell_ext_specific_layer(_ase, _index, _layername, _x, _y, _xscale, _yscale, angle)
{
	var current_frame = _ase.frames[_index];
	var width = _ase.width;
	var height = _ase.height;

	var init_dir = point_direction(0, 0, _ase.xoffset * _xscale, _ase.yoffset * _yscale);
	var init_dis = point_distance(0, 0, _ase.xoffset * _xscale, _ase.yoffset * _yscale);

	var offset_x = -lengthdir_x(init_dis, init_dir + angle);
	var offset_y = -lengthdir_y(init_dis, init_dir + angle);

	for (var i = 0; i < layer_count; i++)
	{
		var current_layer = _ase.layers[i];

		if (current_layer.visible == false || _ase.layer_name != _layername)
		{
			continue;
		}
		
		
		draw_surface_general(_ase.surface, width * _index, height * i, width, height, _x + offset_x, _y + offset_y, _xscale, _yscale, angle, c_white, c_white, c_white, c_white, 1);
        
	}
}