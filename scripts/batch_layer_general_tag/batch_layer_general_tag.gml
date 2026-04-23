function batch_layer_general_tag_flat(_sprite, _name = "", layer_or_array_of_layers, tag_or_array_of_tags=""){
	var tag_array=force_array(tag_or_array_of_tags);

	
	for(var i=0; i<array_length(tag_array); i++)
	{
		var current_tag = tag_array[i];
		var tag_range = tag_get_range(_sprite,current_tag);
		if(_name!="")
		{
			batch_flat_range(_sprite,_name+"_"+current_tag,tag_range);	
		}
		else
		{
			batch_flat_range(_sprite,_sprite.name+"_"+current_tag,tag_range);		
		}
		
		
	}



}