if(demo==3 && array_length(gen_sprites)==0)
{
batch_begin();
batch_exploaded_layer_specific_layer(test_sprite,"Merchant");





pack_batch();


batch_to_surface();

x_shift=0;
gen_sprites = produce_sprites("demo_sprites");
show_debug_message(gen_sprites);
}