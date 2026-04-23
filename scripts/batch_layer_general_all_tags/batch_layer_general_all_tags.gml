function batch_layer_general_all_tags(_sprite, _name = "", layer_or_array_of_layers)
{
    var tag_array = struct_get_names(_sprite.tags)
    for (var i = 0; i < array_length(tag_array); i++)
    {
        var current_tag = tag_array[i];
        var tag_range = tag_get_range(_sprite,current_tag);
        if(_name != "")
        {
            batch_layer_general(_sprite, _name + "_" +current_tag, layer_or_array_of_layers, tag_range);    
        }
        else
        {
            batch_layer_general(_sprite, _sprite.name + "_" + current_tag, layer_or_array_of_layers, tag_range);        
        }
    }
}