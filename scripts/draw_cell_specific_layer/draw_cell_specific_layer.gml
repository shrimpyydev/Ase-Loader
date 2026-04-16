function draw_cell_specific_layer(_ase,_index,_layername,_x,_y){
var current_frame = _ase.frames[_index];
var width = _ase.width;
var height = _ase.height;
for(var i=1; i<array_length(current_frame); i++)
	{
	var layer_ref = _ase.layers[current_frame[i].layer_index];
	if(layer_ref.visible==false || layer_ref.layer_name != _layername)
	{
	continue;	
	}
	draw_surface_part(_ase.surface,width*_index,height*(i-1),width,height,_x-_ase.origin_x,_y-_ase.origin_y);
	
	
	}


}