function draw_cell_flat(_ase, _index, _x, _y)
{
	var current_frame = _ase.frames[_index];
	var width = _ase.width;
	var height = _ase.height;

	draw_surface_part(_ase.flat_surf, width * _index, 0, width, height, _x - _ase.xoffset, _y - _ase.yoffset);
}