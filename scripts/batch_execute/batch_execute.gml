function batch_execute(_texgroup_name){
pack_batch();
batch_to_surface();
var sprites = produce_sprites(_texgroup_name);
batch_end();
return sprites;
}