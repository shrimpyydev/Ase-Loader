function pack_batch()
{
	var names = struct_get_names(ase_system.sprite_data.to_pack);
	// show_debug_message(string(names));
	
	array_sort(names, function(current, next)
	{
		var current_struct = struct_get(ase_system.sprite_data.to_pack, current);
		var next_struct = struct_get(ase_system.sprite_data.to_pack, next);
		var current_area = (current_struct.bbox[2] - current_struct.bbox[0]) * (current_struct.bbox[3] - current_struct.bbox[1]);
		var next_area = (next_struct.bbox[2] - next_struct.bbox[0]) * (next_struct.bbox[3] - next_struct.bbox[1]);
		return sign(next_area - current_area);
	});

	// show_debug_message(string(names));

	var widths = array_map(names, function(element, index)
	{
		return struct_get(ase_system.sprite_data.to_pack, element).bbox[2] - struct_get(ase_system.sprite_data.to_pack, element).bbox[0];
	});

	var heights = array_map(names, function(element, index)
	{
		return struct_get(ase_system.sprite_data.to_pack, element).bbox[3] - struct_get(ase_system.sprite_data.to_pack, element).bbox[1];
	});
	
	var min_width = script_execute_ext(min, widths);
	var min_height = script_execute_ext(max, heights);
	
	var canvas =
	{
		width : min_width,
		height : min_height,
		empty_cells : [],
		placed_cells : [],
	};

	canvas.empty_cells[0] =
	{
		x : 0,
		y : 0,
		width : canvas.width,
		height : canvas.height,
	};

	function sort_by_area(cell)
	{
		array_sort(cell, function(current, next)
		{
			var area = current.width * current.height;
			var next_area = next.width * next.height;
			return sign(area - next_area);
		});
	}

	while (array_length(canvas.placed_cells) < array_length(names))
	{
		for (var i = 0; i < array_length(names); i++)
		{
			// show_debug_message("need to pack: " + string(array_length(names) - array_length(canvas.placed_cells)));
			var current_struct = struct_get(ase_system.sprite_data.to_pack, names[i]);
			current_struct.possible = variable_clone(canvas.empty_cells);
			current_struct.reference = variable_clone(canvas.empty_cells);

			with (current_struct)
			{
				// show_debug_message("prefilter: " + string(array_length(possible)));
				possible = array_filter(possible, function(element, index)
				{
					return (bbox[2] - bbox[0]) <= element.width && (bbox[3] - bbox[1]) <= element.height;
				});
				// show_debug_message("postfilter: " + string(array_length(possible)));

				if (array_length(possible) != 0)
				{
					sort_by_area(possible);
					array_reverse(possible);

					for (var j = 0; j < array_length(reference); j++)
					{
						var optimal = array_first(possible);

						if (optimal.x == reference[j].x && optimal.y == reference[j].y)
						{
							cell_index = j;
							break;
						}
					}
					// show_debug_message("Found viable index at: " + string(cell_index));
				}
			}

			// canvas.empty_cells = current_struct.possible;
			struct_remove(current_struct, "possible");
			struct_remove(current_struct, "reference");

			if (struct_exists(current_struct, "cell_index") == false)
			{
				canvas.placed_cells = [];
				array_resize(canvas.empty_cells, 1);
				
				if (canvas.width <= canvas.height)
				{
					canvas.width += min_width;
				}
				else
				{
					canvas.height += min_height;
				}
				// show_debug_message("Couldn't fit all sprites, resizing canvas to: " + string([canvas.width, canvas.height]));

				canvas.empty_cells[0] =
				{
					x : 0,
					y : 0,
					width : canvas.width,
					height : canvas.height,
				};

				break;
			}
			else
			{
				// show_debug_message("value is: " + string(current_struct.cell_index));
				var index = current_struct.cell_index;
				var extracted = canvas.empty_cells[index];

				array_delete(canvas.empty_cells, index, 1);
				struct_remove(current_struct, "cell_index");
				
				var excess_width = extracted.width - (current_struct.bbox[2] - current_struct.bbox[0]);
				var excess_height = extracted.height - (current_struct.bbox[3] - current_struct.bbox[1]);

				extracted.data = current_struct;

				array_push(canvas.placed_cells, extracted);

				if (excess_width > 0)
				{
					array_push(canvas.empty_cells,
					{
						x : extracted.x + (current_struct.bbox[2] - current_struct.bbox[0]),
						y : extracted.y,
						width : extracted.width - (current_struct.bbox[2] - current_struct.bbox[0]),
						height : (current_struct.bbox[3] - current_struct.bbox[1]),
					});
				}

				if (excess_height > 0)
				{
					array_push(canvas.empty_cells,
					{
						x : extracted.x,
						y : extracted.y + (current_struct.bbox[3] - current_struct.bbox[1]),
						width : extracted.width,
						height : extracted.height - (current_struct.bbox[3] - current_struct.bbox[1]),
					});
				}
			}
			
			struct_remove(extracted, "width");
			struct_remove(extracted, "height");
		}
		// break;
	}
	
	struct_remove(canvas, "empty_cells");
	struct_remove(ase_system.sprite_data, "to_pack");
	struct_remove(ase_system.sprite_data, "sprites");
	struct_set(ase_system.sprite_data, "packed_data", canvas);

	ase_system.compiled_sprites.sprites = {};

	array_foreach(ase_system.sprite_data.packed_data.placed_cells, function(element, index)
	{
		var target_struct = ase_system.compiled_sprites.sprites;
		var source_struct = struct_get(ase_system.sprites, element.data.source_sprite);

		var batch_sprite =
		{
			width : source_struct.width,
			height : source_struct.height,
			frames : [],
			xoffset : source_struct.xoffset,
			yoffset : source_struct.yoffset,
		};
		
		var optional_attributes = ["bbox_kind", "frame_speed", "frame_type", "bbox_left", "bbox_right", "bbox_top", "bbox_bottom", "nineslice"]; // these are optional attributes that, if passed into the sprite as a json, can pass to the sprite definition
		
		for (var a = 0; a < array_length(optional_attributes); a++)
		{
			if (struct_exists(source_struct, optional_attributes[a]) == true)
			{
				struct_set(batch_sprite, optional_attributes[a], struct_get(source_struct, optional_attributes[a]));
			}
		}
		
		var data_struct = element.data;
		var frame_count = (data_struct.bbox[2] - data_struct.bbox[0]) / batch_sprite.width;
		var layer_count = (data_struct.bbox[3] - data_struct.bbox[1]) / batch_sprite.height;
		
		// show_debug_message("Frames/layers: " + string([frame_count, layer_count]));
		
		for (var j = 0; j < layer_count; j++)
		{
			for (var k = 0; k < frame_count; k++)
			{
				array_push(batch_sprite.frames,
				{
					x : element.x + batch_sprite.width * k,
					y : element.y + batch_sprite.height * j,
				});
			}
		}

		struct_set(target_struct, element.data.full_name, batch_sprite);
	});
}