function draw_cell(_ase, _index, _x, _y,z_aware=false)
{
	//var current_frame = _ase.frames[_index];
	var layer_count = array_length(_ase.layers);
	var width = _ase.width;
	var height = _ase.height;



	/*for (var i = 0; i < array_length(_struct.layers); i++)
	{
		var current_layer = _struct.layers[i];

		if (bool(current_layer.visible) == true)
		{
			draw_surface_part(base_surf, 0, height * i, base_width, height, 0, 0);
		}
	}*/

	for (var i = 0; i < layer_count; i++)
	{
		var current_layer = _ase.layers[i];

		if (current_layer.visible == false)
		{
			continue;
		}
		var current_depth = gpu_get_depth();
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
		draw_surface_part(_ase.surface, width * _index, height * i, width, height, _x - _ase.xoffset, _y - _ase.yoffset);
		gpu_set_depth(current_depth);
	}
}