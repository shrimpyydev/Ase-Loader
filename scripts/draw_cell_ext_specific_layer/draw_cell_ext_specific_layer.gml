function draw_cell_ext_specific_layer(_ase,_index,_layername,_x,_y,_xscale,_yscale,angle){


var current_frame = _ase.frames[_index];
var width = _ase.width;
var height = _ase.height;

var init_dir = point_direction(0,0,_ase.origin_x*_xscale,_ase.origin_y*_yscale);

var init_dis = point_distance(0,0,_ase.origin_x*_xscale,_ase.origin_y*_yscale);

var offset_x = -lengthdir_x(init_dis,init_dir+angle);

var offset_y = -lengthdir_y(init_dis,init_dir+angle);



for(var i=1; i<array_length(current_frame); i++)
	{
	var layer_ref = _ase.layers[current_frame[i].layer_index];
	if(layer_ref.visible==false || layer_ref.layer_name != _layername)
	{
	continue;	
	}
	draw_surface_general(_ase.surface,width*_index,height*(i-1),width,height,_x+offset_x,_y+offset_y,_xscale,_yscale,angle,c_white,c_white,c_white,c_white,1);	
	
	}


//matrix_set(matrix_world,matrix_current);

}