function batch_flat_all_tags(_sprite, _name = "")
{
    var tag_array = struct_get_names(_sprite.tags)
	//show_debug_message(string(tag_array));
    for (var i = 0; i < array_length(tag_array); i++)
    {
        var current_tag = tag_array[i];
		//show_debug_message("current_tag is: "+current_tag);
        var tag_range = tag_get_range(_sprite,current_tag);
        if(_name != "")
        {
            batch_flat_range(_sprite, _name + "_" +current_tag, tag_range);    
        }
        else
        {
            batch_flat_range(_sprite, _sprite.name + "_" + current_tag, tag_range);        
        }
    }
}