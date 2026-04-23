function batch_flat_range(sprite_struct,_name="",_range){


if(!struct_exists(sprite_struct,"flat_surf"))
{


ase_flatten_layers(sprite_struct);	


	
}

	

	
	var sub_struct = {
	bbox : [sprite_struct.width*_range[0],0,
	sprite_struct.width*(_range[1]+1),
	surface_get_height(sprite_struct.flat_surf)],	
	source_surface	: sprite_struct.flat_surf,
	source_sprite : sprite_struct.name,
		
		
	};
	var final_name;
	if(_name=="")
	{
	final_name="spr_"+safe_string(sprite_struct.name);	
	}
	else
	{
	final_name=_name;	
	}
	sub_struct.full_name=final_name;
	struct_set(ase_system.sprite_data.to_pack,final_name,sub_struct);		
	
	
		
	
	
	
}
	
