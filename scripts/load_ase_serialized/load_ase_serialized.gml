function load_ase_serialized(_bufferfile,name="",_xorigin=0,_yorigin=0,json=-1){

var my_buff=buffer_load(_bufferfile);

var buff_string = buffer_read(my_buff,buffer_string);

var decode = buffer_base64_decode(buff_string);

buffer_delete(my_buff);

var decoded_sprite = load_ase(decode,name,_xorigin,_yorigin,json);

return decoded_sprite;
}