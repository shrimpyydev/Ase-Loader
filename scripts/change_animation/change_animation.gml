function change_animation(_struct,_string,_preserve_index=0){
//provide the name of an animation 
if(!struct_exists(_struct.tags,_string))
{
show_debug_message("animation not found");
exit;	
	
}
animation=_string;
if(_preserve_index==0)
{
ase_index=struct_get(_struct.tags,_string).from;
}
else
{
ase_index=struct_get(_struct.tags,_string).from+(ase_index-struct_get(_struct.tags,animation).from);	
}


}