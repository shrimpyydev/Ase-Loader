function batch_layer_general(_sprite, _name = "", layer_or_array_of_layers, array_to_from = -1)
{
    var layers = _sprite.layers;
    var layer_array;

    var first_cell;
    var last_cell;

    if (array_to_from != -1)
    {
        first_cell = array_to_from[0];
        last_cell  = array_to_from[1];
    }
    else
    {
        first_cell = 0;
        last_cell  = array_length(layers) - 1;
    }

    if (is_array(layer_or_array_of_layers))
    {
        layer_array = layer_or_array_of_layers;
    }
    else
    {
        layer_array = [layer_or_array_of_layers];
    }

    for (var i = 0; i < array_length(layer_array); i++)
    {
        var sub_struct = {
            source_surface : _sprite.surface,
            source_sprite  : _sprite.name
        };

        var final_name;
        var desired_layer = layer_array[i];

        var sub_layers = array_map(layers, function(element, index)
        {
            return element.layer_name;
        });

        var index = array_get_index(sub_layers, desired_layer);

        if (index == -1) continue;

        if (_name = "")
        {
            final_name = "spr_" + _sprite.name;
        }
        else
        {
            final_name = _name;
        }

        if (array_length(layer_array) > 1)
        {
            final_name += "_" + desired_layer;
        }
		final_name = safe_string(final_name);
        var bbox = [
            first_cell * _sprite.width,
            _sprite.height * index,
            (1 + last_cell) * _sprite.width,
            _sprite.height * (index + 1)
        ];

        sub_struct.bbox = bbox;
		sub_struct.full_name = final_name;
        struct_set(ase_system.sprite_data.to_pack, final_name, sub_struct);
    }

   
}