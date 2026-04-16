function ase_buff_to_vbuff(_struct){

var color_mode = _struct.color_depth;

var new_buff = vertex_create_buffer();



switch(color_mode){
	
	case 32: 
	vertex_begin(new_buff,global.ase_rgba);	
	
	for(var i=0; i<_struct.frame_count; i++)
	{
		var current_frame = _struct.frames[i];	
		
		for(var j=1; j<array_length(current_frame); j++)
		{
		//starts at 1 because index 0 holds frame duration data.
		var current_cell = current_frame[j];
		var current_buffer = current_cell.pixels;
			for(var o=0; o<buffer_get_size(current_buffer)*8; o+=32)
			{
				vertex_position(new_buff,1+current_cell.x_pos+(o / 32 % current_cell.cell_width)+_struct.width*i,current_cell.y_pos+(o/32 div current_cell.cell_width)+_struct.height*(j-1));
				var r = buffer_read(current_buffer, buffer_u8);
				var g = buffer_read(current_buffer, buffer_u8);
				var b = buffer_read(current_buffer, buffer_u8);
				var a = buffer_read(current_buffer, buffer_u8);
				vertex_color(new_buff,make_color_rgb(r,g,b),a);
				
				
			}
			buffer_delete(current_buffer);
			struct_remove(current_cell,"pixels");
		}
	}
	break;

	case 16:
	vertex_begin(new_buff,global.ase_greyscale);	
	for(var i=0; i<_struct.frame_count; i++)
	{
		var current_frame = _struct.frames[i];	
		
		for(var j=1; j<array_length(current_frame); j++)
		{
		//starts at 1 because index 0 holds frame duration data.
		var current_cell = current_frame[j];
		var current_buffer = current_cell.pixels;
			for(var o=0; o<buffer_get_size(current_buffer)*8; o+=16)
			{
				vertex_position(new_buff,1+current_cell.x_pos+(o / 16 % current_cell.cell_width)+_struct.width*i,current_cell.y_pos+(o/16 div current_cell.cell_width)+_struct.height*(j-1));
				var v = buffer_read(current_buffer, buffer_u8);
				var a = buffer_read(current_buffer, buffer_u8);
				
				vertex_float2(new_buff,v,a);
				
				
			}
			buffer_delete(current_buffer);
			struct_remove(current_cell,"pixels");
		}
	}
	break;
	
	case 8:
	vertex_begin(new_buff,global.ase_index);	
	for(var i=0; i<_struct.frame_count; i++)
	{
		var current_frame = _struct.frames[i];	
		
		for(var j=1; j<array_length(current_frame); j++)
		{
		//starts at 1 because index 0 holds frame duration data.
		var current_cell = current_frame[j];
		var current_buffer = current_cell.pixels;
			for(var o=0; o<buffer_get_size(current_buffer)*8; o+=8)
			{
				vertex_position(new_buff,1+current_cell.x_pos+(o / 8 % current_cell.cell_width)+_struct.width*i,current_cell.y_pos+(o/8 div current_cell.cell_width)+_struct.height*(j-1));
				var index = buffer_read(current_buffer, buffer_u8);
				
				
				vertex_float1(new_buff,index);
				//show_debug_message("index sanity check: "+string(index));
				
			}
			buffer_delete(current_buffer);
			struct_remove(current_cell,"pixels");
		}
	}

}




vertex_end(new_buff);
//vertex_freeze(new_buff);
return new_buff;
}