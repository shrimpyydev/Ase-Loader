if(demo==3 && array_length(gen_sprites)==0)
{
batch_begin();

batch_flat_all_tags(test_sprite,"merchant_sprite");



gen_sprites = batch_execute("demo_sprites");
show_debug_message(gen_sprites);
}