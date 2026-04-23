function delete_texturegroup(_texturegroup){


var sprites = texturegroup_get_sprites(_texturegroup);

for(var i=0; i<array_length(sprites); i++)
	{
	sprite_delete(sprites[i]);		
	}

texturegroup_delete(_texturegroup);
var buff = struct_get(ase_system.texture_buffers,_texturegroup);

buffer_delete(buff);



struct_remove(ase_system.texture_buffers,_texturegroup);
}