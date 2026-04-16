

function load_ase(_bufferfile,name="",_xorigin=0,_yorigin=0){
if(name!="")
{
var set_name = name;	
}
else
{
set_name = _bufferfile;

{
set_name = string_replace(set_name,filename_path(_bufferfile),"");
set_name = string_replace(set_name,filename_ext(_bufferfile),"");	
}
}

var runtime_struct ={
layers : [],
origin_x : 0,
origin_y : 0,
slices : [],
name : set_name,
};

var buf = buffer_load(_bufferfile);

// --- HEADER ---
buffer_seek(buf, buffer_seek_start, 0);

var file_size   = buffer_read(buf, buffer_u32);
var magic       = buffer_read(buf, buffer_u16);
var frame_count = buffer_read(buf, buffer_u16);
var width       = buffer_read(buf, buffer_u16);
var height      = buffer_read(buf, buffer_u16);
var color_depth = buffer_read(buf, buffer_u16);

var flags       = buffer_read(buf, buffer_u32);
var anim_speed  = buffer_read(buf, buffer_u16);

repeat(2)
{
buffer_read(buf,buffer_u32);	
}

runtime_struct.background_col_index = buffer_read(buf,buffer_u8);
runtime_struct.height = height;
runtime_struct.width = width;
runtime_struct.color_depth = color_depth;
runtime_struct.frame_count = frame_count;

runtime_struct.frames = array_create_ext(frame_count,function(_index){
return [];	
});







// Jump to end of 128-byte header
buffer_seek(buf, buffer_seek_start, 128);

// Debug
show_debug_message("Frames: " + string(frame_count));
show_debug_message("Size: " + string(width) + "x" + string(height));


// --- FRAME LOOP ---
for (var i = 0; i < frame_count; i++)
{
    var frame_start = buffer_tell(buf);

    var frame_bytes     = buffer_read(buf, buffer_u32);
    var frame_magic     = buffer_read(buf, buffer_u16);
    var old_chunk_count = buffer_read(buf, buffer_u16);
   
	var duration        = buffer_read(buf, buffer_u16);
 repeat(2)
	{
	buffer_read(buf,buffer_u8);	
	}
   // buffer_read(buf, buffer_u16); // reserved

    // ALWAYS read 32-bit chunk count (modern files)
    var chunk_count = buffer_read(buf, buffer_u32);

    if (frame_magic != $F1FA)
    {
        show_debug_message("Bad frame at " + string(i));
        break;
    }
	
runtime_struct.frames[i][0]=duration;

parse_chunk(buf,frame_start,frame_start+frame_bytes,runtime_struct,i)

buffer_seek(buf,buffer_seek_start,frame_start+frame_bytes)

} 


runtime_struct.surface = -1;
runtime_struct.vert_buff = ase_buff_to_vbuff(runtime_struct);

bake_surface(runtime_struct);
time_elapse=0;
ase_index=0;

struct_set(ase_system.sprites,set_name,runtime_struct);
var handle = struct_get(ase_system.sprites,set_name);

ase_set_origin(handle,_xorigin,_yorigin)

return handle;

}