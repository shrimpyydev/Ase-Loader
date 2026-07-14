function draw_cell_ext(_ase, _index, _x, _y, _xscale, _yscale, angle, z_aware=false)
{
	var layer_count = array_length(_ase.layers);
	var width = _ase.width;
	var height = _ase.height;

	var init_dir = point_direction(0, 0, _ase.xoffset * _xscale, _ase.yoffset * _yscale);
	var init_dis = point_distance(0, 0, _ase.xoffset * _xscale, _ase.yoffset * _yscale);

	var offset_x = -lengthdir_x(init_dis, init_dir + angle);
	var offset_y = -lengthdir_y(init_dis, init_dir + angle);
    var current_depth = gpu_get_depth();
	
	for (var i = 0; i < layer_count; i++)
	{
		var current_layer = _ase.layers[i];

		if (current_layer.visible == false)
		{
			continue;
		}
		if(bool(z_aware) == true)
		{
			var temp_struct = {
			_index : _index,	
			layer_index : i,	
			};
			
			with(temp_struct)
			{
			current_cell = array_find_index(_ase.frames[_index],function(_element,_index){
				var is_right = false;
				if(is_struct(_element))
					{
						if(layer_index == _element.layer_index)
						{
							is_right = true;	
						}
					}
				return is_right;
			});
		}
		if(temp_struct.current_cell!=-1)
		{
			gpu_set_depth(_ase.frames[_index][temp_struct.current_cell].z_index);	
			
		}
		}
		draw_surface_general(_ase.surface, width * _index, height * i, width, height, _x + offset_x, _y + offset_y, _xscale, _yscale, angle, c_white, c_white, c_white, c_white, 1);
        gpu_set_depth(current_depth);
	}
	
	
	
	
}