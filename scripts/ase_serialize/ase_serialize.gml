function ase_serialize(_struct){
var need_flat=0;
if(struct_exists(_struct,"flat_surf"))
{
surface_free(_struct.flat_surf);	
_struct.flat_surf=-1;	
need_flat=1;
}

surface_free(_struct.surface);
_struct.surface=-1;
var buff = buffer_create_from_vertex_buffer(_struct.vert_buff, buffer_grow, 1);

var buff_string=buffer_base64_encode(buff, 0, buffer_get_size(buff));

var buff_reference = _struct.vert_buff;

buffer_delete(buff);

_struct.vert_buff=buff_string;

var encoded_buff = buffer_create(1,buffer_grow,1);



SnapBufferWriteBinary(encoded_buff,_struct);

var compressed_buff = buffer_compress(encoded_buff,0,buffer_get_size(encoded_buff));

buffer_save(compressed_buff,get_save_filename("my_sprite | *.bin",""));

buffer_delete(encoded_buff);

_struct.vert_buff = buff_reference;

bake_surface(_struct);

if(need_flat==1)
{
	
ase_flatten_layers(_struct);	
}

}