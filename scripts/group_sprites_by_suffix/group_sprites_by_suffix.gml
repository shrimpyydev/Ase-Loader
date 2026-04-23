function group_sprites_by_suffix(sprite_array)
{
    var grouped_struct = {};
    var arr_length = array_length(sprite_array);

    for (var i = 0; i < arr_length; i++)
    {
        var spr = sprite_array[i];
        var spr_name = sprite_get_name(spr);
        
        var parts = string_split(spr_name, "_");
        var num_parts = array_length(parts);

        var suffix = "unsorted";
        if (num_parts > 1)
        {
            suffix = parts[num_parts - 1];
        }

        if (struct_exists(grouped_struct, suffix) == false)
        {
            grouped_struct[$ suffix] = [];
        }

        array_push(grouped_struct[$ suffix], spr);
    }

    return grouped_struct;
}