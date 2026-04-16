function load_ase_serialized(_buffer,pal=[],flatten=0){

var compress_buff = buffer_load(_buffer);

var my_sprite = buffer_decompress(compress_buff);

buffer_delete(compress_buff);

var new_struct = SnapBufferReadBinary(my_sprite,0);



var new_buff = buffer_base64_decode(new_struct.vert_buff);



if(new_struct.color_depth==32)
{

var vert_buff = vertex_create_buffer_from_buffer(new_buff, global.ase_rgba);

}
else if(new_struct.color_depth==16)
{
var vert_buff = vertex_create_buffer_from_buffer(new_buff, global.ase_greyscale);	
}
else
{
var vert_buff = vertex_create_buffer_from_buffer(new_buff, global.ase_index);	
}

buffer_delete(new_buff);

new_struct.vert_buff = vert_buff;
clipboard_set_text(json_stringify(new_struct,1));
bake_surface(new_struct);

if(flatten==1)
{
ase_flatten_layers(new_struct,pal);	
}

if(struct_exists(ase_system.sprites,new_struct.name))
{
unload_sprite(struct_get(ase_system.sprites,new_struct.name));	
}

struct_set(ase_system.sprites,new_struct.name,new_struct);


	
return 	struct_get(ase_system.sprites,new_struct.name);

}