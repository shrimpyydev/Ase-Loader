function unload_sprite(_struct){
surface_free(_struct.surface);
vertex_delete_buffer(_struct.vert_buff);
if(struct_exists(_struct,"flat_surf"))
{
surface_free(_struct.flat_surf);	
	
}
if(struct_exists(_struct,"palette"))
{
struct_remove(_struct,"palette");
	
}
}