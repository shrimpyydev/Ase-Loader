function parse_user_data(_buf)
{
    var flags = buffer_read(_buf, buffer_u32);

    var user_data = {};

    // --- Optional text ---
    if ((flags & 1) != 0)
    {
        user_data.text = read_ase_string(_buf);
    }

    // --- Optional color ---
    if ((flags & 2) != 0)
    {
        user_data.color = {
            a : buffer_read(_buf, buffer_u8),
            b : buffer_read(_buf, buffer_u8),
            g : buffer_read(_buf, buffer_u8),
            r : buffer_read(_buf, buffer_u8)
        };
    }

    // --- Optional properties ---
    if ((flags & 4) != 0)
    {
        var total_size = buffer_read(_buf, buffer_u32);
        var map_count  = buffer_read(_buf, buffer_u32);

        user_data.properties = {};

        for (var m = 0; m < map_count; m++)
        {
            var map_key    = buffer_read(_buf, buffer_u32);
            var prop_count = buffer_read(_buf, buffer_u32);

            var property_map = {};

            for (var p = 0; p < prop_count; p++)
            {
                var prop_name = read_ase_string(_buf);
                var prop_type = buffer_read(_buf, buffer_u16);
                var prop_value;

                switch (prop_type)
                {
                    case $0001: // bool
                        prop_value = (buffer_read(_buf, buffer_u8) != 0);
                    break;

                    case $0002: // int8
                        prop_value = buffer_read(_buf, buffer_s8);
                    break;

                    case $0003: // uint8
                        prop_value = buffer_read(_buf, buffer_u8);
                    break;

                    case $0004: // int16
                        prop_value = buffer_read(_buf, buffer_s16);
                    break;

                    case $0005: // uint16
                        prop_value = buffer_read(_buf, buffer_u16);
                    break;

                    case $0006: // int32
                        prop_value = buffer_read(_buf, buffer_s32);
                    break;

                    case $0007: // uint32
                        prop_value = buffer_read(_buf, buffer_u32);
                    break;

                    case $000B: // float
                        prop_value = buffer_read(_buf, buffer_f32);
                    break;

                    case $000D: // string
                        prop_value = read_ase_string(_buf);
                    break;

                    case $000E: // point
                        prop_value = {
                            x : buffer_read(_buf, buffer_s32),
                            y : buffer_read(_buf, buffer_s32)
                        };
                    break;

                    case $000F: // size
                        prop_value = {
                            width  : buffer_read(_buf, buffer_s32),
                            height : buffer_read(_buf, buffer_s32)
                        };
                    break;

                    case $0010: // rect
                        prop_value = {
                            x      : buffer_read(_buf, buffer_s32),
                            y      : buffer_read(_buf, buffer_s32),
                            width  : buffer_read(_buf, buffer_s32),
                            height : buffer_read(_buf, buffer_s32)
                        };
                    break;

                    default:
                        show_debug_message(
                            "Unhandled user data property type: " +
                            dec_to_hex(prop_type)
                        );
                        prop_value = undefined;
                    break;
                }

                struct_set(property_map, prop_name, prop_value);
            }

            struct_set(user_data.properties, string(map_key), property_map);
        }
    }

    return user_data;
}