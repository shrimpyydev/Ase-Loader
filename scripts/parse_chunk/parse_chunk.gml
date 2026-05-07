function parse_chunk(buf, frame_start, frame_end, _struct, _frame)
{
	buffer_seek(buf, buffer_seek_start, frame_start + 16);
	var iteration = 1;
	var last_chunk = -1;

	while (buffer_tell(buf) < frame_end)
	{
		// show_debug_message("Parsing chunk: " + string([frame_start, frame_end]));

		var chunk_start = buffer_tell(buf);

		var chunk_size = buffer_read(buf, buffer_u32);
		var chunk_type = buffer_read(buf, buffer_u16);
		var cell_array = [];

		switch (chunk_type)
		{
			case global._chunktypes.layer_chunk:
				// show_debug_message("Found layer");
				var layer_flags = buffer_read(buf, buffer_u16);
				var layer_type = buffer_read(buf, buffer_u16);
				var child_level = buffer_read(buf, buffer_u16);

				var default_w = 0;
				var default_h = 0;

				// ONLY for tilemap layers
				// if (layer_type == 2)
				{
					default_w = buffer_read(buf, buffer_u16);
					default_h = buffer_read(buf, buffer_u16);
				}

				var blend_mode = buffer_read(buf, buffer_u16);
				var opacity = buffer_read(buf, buffer_u8);

				// skip 3 reserved bytes
				buffer_seek(buf, buffer_seek_relative, 3);

				var layer_name = read_ase_string(buf);

				var layer_struct =
				{
					flags : layer_flags,
					visible : (layer_flags & 1) != 0,
					editable : (layer_flags & 2) != 0,
					locked : (layer_flags & 4) != 0,
					layer_type : layer_type,
					layer_child_level : child_level,
					default_layer_width : default_w,
					default_layer_height : default_h,
					blend_mode : blend_mode,
					opacity : opacity,
					layer_name : layer_name
				};

				struct_remove(layer_struct, "flags");

				array_push(_struct.layers, layer_struct);
				last_chunk = _struct.layers[array_length(_struct.layers) - 1];

				break;

			case global._chunktypes.cell_chunk:
				var layer_index = buffer_read(buf, buffer_u16);
				var x_pos = buffer_read(buf, buffer_s16);
				var y_pos = buffer_read(buf, buffer_s16);
				var opacity = buffer_read(buf, buffer_u8);
				var cel_type = buffer_read(buf, buffer_u16);
				var z_index = buffer_read(buf, buffer_s16);

				repeat (5)
				{
					buffer_read(buf, buffer_u8);
				}

				var chunk_struct =
				{
					layer_index : layer_index,
					x_pos : x_pos,
					y_pos : y_pos,
					opacity : opacity,
					cel_type : cel_type,
					z_index : z_index,
				};

				if (cel_type == 1)
				{
					chunk_struct.link_cell = buffer_read(buf, buffer_u16);
					//show_debug_message("linking cell: " + string(chunk_struct.link_cell));

					with (chunk_struct)
					{
						struct_set(self, "source_cell", array_filter(_struct.frames[link_cell], function(element, index)
						{
							if (is_struct(element) == false)
							{
								return false;
							}

							return element.layer_index == layer_index;
						}));
					}

					var source_cell = chunk_struct.source_cell;
					struct_remove(chunk_struct, "source_cell");
					struct_remove(chunk_struct, "link_cell");
					iteration++;

					chunk_struct.pixels = buffer_create(buffer_get_size(source_cell[0].pixels), buffer_fixed, 1);
					buffer_copy(source_cell[0].pixels, 0, buffer_get_size(source_cell[0].pixels), chunk_struct.pixels, 0);
					var copy_struct = variable_clone(source_cell[0]);
					copy_struct.pixels = chunk_struct.pixels;
					array_push(_struct.frames[_frame], copy_struct);

					last_chunk = _struct.frames[_frame][array_length(_struct.frames[_frame]) - 1];
					chunk_struct = undefined;
				}
				else if (cel_type == 2)
				{
					var cell_width = buffer_read(buf, buffer_u16);
					var cell_height = buffer_read(buf, buffer_u16);
					chunk_struct.cell_width = cell_width;
					chunk_struct.cell_height = cell_height;

					var extracted_cell = extract_compressed_cell(buf, buffer_tell(buf), chunk_start + chunk_size);
					chunk_struct.pixels = extracted_cell;
					iteration++;

					array_push(_struct.frames[_frame], chunk_struct);

					last_chunk = _struct.frames[_frame][array_length(_struct.frames[_frame]) - 1];
					chunk_struct = undefined;
					// show_debug_message("Last chunk is: " + string(last_chunk));
				}

				// buffer_seek(buf, buffer_seek_start, chunk_start + chunk_size);
				break;

			case global._chunktypes.tags_chunk:
				var tag_count = buffer_read(buf, buffer_u16);
				_struct.tag_count = tag_count;
				_struct.tags = {};

				repeat (8)
				{
					buffer_read(buf, buffer_u8);
					// reserved for unimplemented features;
				}

				for (var i = 0; i < tag_count; i++)
				{
					var from = buffer_read(buf, buffer_u16);
					var to = buffer_read(buf, buffer_u16);
					var loop_direction = buffer_read(buf, buffer_u8);
					var rep = buffer_read(buf, buffer_u16);

					repeat (10)
					{
						buffer_read(buf, buffer_u8);
						// reserved for unimplemented and depreciated features;
					}

					var name = read_ase_string(buf);

					struct_set(_struct.tags, name,
					{
						from : from,
						to : to,
						loop_direction : loop_direction,
						rep : rep,
					});
				}
				break;

			case global._chunktypes.slice_chunk:
				var number = buffer_read(buf, buffer_u32);
				var flags = buffer_read(buf, buffer_u32);
				buffer_read(buf, buffer_u32); // reserved, unused
				var name = read_ase_string(buf);
				var start = buffer_read(buf, buffer_u32);
				var x_origin = buffer_read(buf, buffer_s32);
				var y_origin = buffer_read(buf, buffer_s32);
				var slice_width = buffer_read(buf, buffer_u32);
				var slice_height = buffer_read(buf, buffer_u32);

				array_push(_struct.slices,
				{
					number : number,
					flags : flags,
					name : name,
					start : start,
					x : x_origin,
					y : y_origin,
					width : slice_width,
					height : slice_height,
				});

				last_chunk = _struct.slices[array_length(_struct.slices) - 1];
				break;

			case global._chunktypes.palette_chunk:
				if (struct_exists(_struct, "palette") == false)
				{
					_struct.palette = {};
				}

				_struct.palette.range = buffer_read(buf, buffer_u32);
				_struct.palette.first = buffer_read(buf, buffer_u32);
				_struct.palette.last = buffer_read(buf, buffer_u32);

				repeat (8)
				{
					buffer_read(buf, buffer_u8); // reserved for future func;
				}

				var palette_contents = [];

				for (var p = 0; p < _struct.palette.range; p++)
				{
					var flag = buffer_read(buf, buffer_u16);
					array_push(palette_contents, buffer_read(buf, buffer_u8) / 255); // red
					array_push(palette_contents, buffer_read(buf, buffer_u8) / 255); // blue
					array_push(palette_contents, buffer_read(buf, buffer_u8) / 255); // green
					array_push(palette_contents, buffer_read(buf, buffer_u8) / 255); // alpha

					if ((flag & 1) != 0)
					{
						_struct.palette.name = read_ase_string(buf);
					}
				}

				_struct.palette.data = palette_contents;

				//show_debug_message("parsed a palette of: " + string(_struct.palette.range));
				break;

			case global._chunktypes.user_chunk:
				var user_data = parse_user_data(buf);

				if (is_struct(last_chunk) == true)
				{
					last_chunk.user_data = user_data;
				}
				else
				{
					array_push(_struct.user_data, user_data);
				}
				break;
		}

		// show_debug_message("loop iterated " + string(iteration) + " times.");
		// show_debug_message("Chunk is a: " + dec_to_hex(chunk_type) + ", " + string(chunk_type));

		buffer_seek(buf, buffer_seek_start, chunk_start + chunk_size);
	}
}