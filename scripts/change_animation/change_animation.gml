function change_animation(_struct,_string){
//provide the name of an animation 
if(!struct_exists(_struct.tags,_string))
{
show_debug_message("animation not found");
exit;	
	
}
animation=_string;
ase_index=struct_get(_struct.tags,_string).from;


}