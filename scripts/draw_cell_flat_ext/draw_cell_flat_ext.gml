function draw_cell_flat_ext(_ase, _index, _x, _y, _xscale, _yscale, _angle)
{
	var current_frame = _ase.frames[_index];
	var width = _ase.width;
	var height = _ase.height;

	var init_dir = point_direction(0, 0, _ase.xoffset * _xscale, _ase.yoffset * _yscale);
	var init_dis = point_distance(0, 0, _ase.xoffset * _xscale, _ase.yoffset * _yscale);

	var offset_x = -lengthdir_x(init_dis, init_dir + _angle);
	var offset_y = -lengthdir_y(init_dis, init_dir + _angle);
	
	draw_surface_general(_ase.flat_surf, width * _index, 0, width, height, _x - _ase.xoffset + offset_x, _y - _ase.yoffset + offset_y, _xscale, _yscale, _angle, c_white, c_white, c_white, c_white, 1);
}