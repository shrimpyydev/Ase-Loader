function batch_to_surface()
{
	ase_system.sprite_surf = surface_create(ase_system.sprite_data.packed_data.width, ase_system.sprite_data.packed_data.height);
	surface_set_target(ase_system.sprite_surf);
	
	array_foreach(ase_system.sprite_data.packed_data.placed_cells, function(element, index)
	{
		// show_debug_message(json_stringify(element, 1));
		draw_surface_part(element.data.source_surface, element.data.bbox[0], element.data.bbox[1], element.data.bbox[2] - element.data.bbox[0], element.data.bbox[3] - element.data.bbox[1], element.x, element.y);
		// show_debug_message("Batching: " + element.data.full_name);
	});
	
	surface_reset_target();
}