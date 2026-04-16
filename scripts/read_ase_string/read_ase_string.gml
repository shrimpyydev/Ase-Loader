function read_ase_string(_buf)
{
    var len = buffer_read(_buf, buffer_u16);
    
    var str = "";
    
    for (var i = 0; i < len; i++)
    {
        str += chr(buffer_read(_buf, buffer_u8));
    }
    
    return str;
}