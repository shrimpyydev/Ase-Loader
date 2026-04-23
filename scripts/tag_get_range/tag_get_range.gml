function tag_get_range(sprite_struct,tag_as_string){

if(struct_exists(sprite_struct,"tags") && struct_exists(sprite_struct.tags,tag_as_string))
{
return [struct_get(sprite_struct.tags,tag_as_string).from,struct_get(sprite_struct.tags,tag_as_string).to];	
}
else
{
show_debug_message(string(tag_as_string)+" not found.");	
return -1;

}
}