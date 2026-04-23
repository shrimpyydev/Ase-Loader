function batch_get_minmax(){
//show_debug_message("Names :"+string(struct_get_names(ase_system)));
var _struct = ase_system.sprite_data.to_pack;
var names = struct_get_names(_struct);

var ranges = array_map(names,function(element,index){
var _sprite = struct_get(ase_system.sprite_data.to_pack,element);
return [_sprite.bbox[2]-_sprite.bbox[0],_sprite.bbox[3]-_sprite.bbox[1]];	
	
	
});

var top_x=0;
var top_y=0;
var bottom_x=infinity;
var bottom_y=infinity;
for(var i=0; i<array_length(ranges); i++)
{
top_x = max(top_x,ranges[i][0]);	
top_y = max(top_y,ranges[i][1]);
bottom_x = min(bottom_x,ranges[i][0]);	
bottom_y = min(bottom_y,ranges[i][1]);	
}

return [bottom_x,bottom_y,top_x,top_y];	
	
	
}
	