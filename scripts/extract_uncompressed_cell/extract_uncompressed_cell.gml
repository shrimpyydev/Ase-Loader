function extract_uncompressed_cell(_buffer,_start,_end,color_type,width,height){

var data_size = _end-_start;
var comp = buffer_create(data_size,buffer_fixed,1);
buffer_copy(_buffer,_start,_end-_start,comp,0);
var decomp = buffer_decompress(comp);
buffer_delete(comp);

return decomp;
}