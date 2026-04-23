function batch_exploaded_layer_specific_layer(sprite_struct,layer_as_string){
var layers = sprite_struct.layers;

layers = array_map(layers,function(element,index){
return element.layer_name;	
	
});

var index = array_get_index(layers,layer_as_string);

if(index==-1) exit;

if(struct_exists(sprite_struct,"tags"))
	{
	
	
	var tag_names = struct_get_names(sprite_struct.tags)
	for(var i=0; i<array_length(tag_names); i++)
		{
			var full_name = "spr_"+sprite_struct.name+"_"+safe_string(tag_names[i]);
			var current_animation = struct_get(sprite_struct.tags,tag_names[i]);
			var sub_struct = {
			bbox : [current_animation.from*sprite_struct.width,
			index*sprite_struct.height,
			(current_animation.to+1)*sprite_struct.width,
			(1+index)*sprite_struct.height],
			source_surface : sprite_struct.surface,
			source_sprite : sprite_struct.name,
			full_name : full_name,
				
			},
		struct_set(ase_system.sprite_data.to_pack,sub_struct.full_name,sub_struct);	
			
			
			
			
		};
	
	}
	else
	{
	var sub_struct = {
	bbox : [0,index * sprite_struct.height,surface_get_width(sprite_struct.surface),(1+index)*sprite_struct.height],	
	source_surface	: sprite_struct.surface,
	source_sprite : sprite_struct.name,
		
		
	};
	struct_set(ase_system.sprite_data.to_pack,"spr_"+safe_string(sprite_struct.name),sub_struct);		
	};
	
	
}	
