function extract_compressed_cell(_buffer,_start,_end){

var data_size = _end-_start;
var comp = buffer_create(data_size,buffer_fixed,1);
buffer_copy(_buffer,_start,_end-_start,comp,0);
var decomp = buffer_decompress(comp);
buffer_delete(comp);

return decomp;
}