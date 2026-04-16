function batch_begin(){
ase_system.sprite_data={
	sprites : {},
	to_pack : {},
	
	
	
};
	
}

function batch_exploaded_layer(sprite_struct){

if(struct_exists(sprite_struct,"tags"))
	{
	var tag_names = struct_get_names(sprite_struct.tags)
	for(var i=0; i<array_length(tag_names); i++)
		{
			var full_name = "spr_"+sprite_struct.name+"_"+string_replace_all(tag_names[i]," ","_");
			var current_animation = struct_get(sprite_struct.tags,tag_names[i]);
			var sub_struct = {
			bbox : [current_animation.from*sprite_struct.width,
			0,
			(current_animation.to+1)*sprite_struct.width,
			surface_get_height(sprite_struct.surface)],
			source_surface : sprite_struct.surface,
			source_sprite : sprite_struct.name,
			full_name : full_name,
				
			},
		struct_set(ase_system.sprite_data.to_pack,sub_struct.full_name,sub_struct);	
			
			
			
			
		};
	
	}
	else
	{
	var sub_struct = {
	bbox : [0,0,surface_get_width(sprite_struct.surface),surface_get_height(sprite_struct.surface)],	
	source_surface	: sprite_struct.surface,
	source_sprite : sprite_struct.name,
		
		
	};
	struct_set(ase_system.sprite_data.to_pack,"spr_"+string_replace_all(sprite_struct.name," ","_"),sub_struct);		
	};
	
	
}
	
function batch_exploaded_layer_range(sprite_struct,anim_name,first,last){


	
			
			var sub_struct = {
			bbox : [first*sprite_struct.width,
			0,
			(1+last)*sprite_struct.width,
			surface_get_height(sprite_struct.surface)],
			source_surface : sprite_struct.surface,
			source_sprite : sprite_struct.name,
				
			},
		struct_set(ase_system.sprite_data.to_pack,"spr_"+sprite_struct.name+"_"+string_replace_all(anim_name," ","_"),sub_struct);	
			
			
	
}
	
	
function batch_exploaded_layer_specific_layer(sprite_struct,layer_as_string){
var layers = sprite_struct.layers;

layers = array_map(layers,function(element,index){
return element.layer_name;	
	
});

var index = array_get_index(layers,layer_as_string);

if(index==-1) exit;

if(struct_exists(sprite_struct,"tags"))
	{
	
	
	var tag_names = struct_get_names(sprite_struct.tags)
	for(var i=0; i<array_length(tag_names); i++)
		{
			var full_name = "spr_"+sprite_struct.name+"_"+string_replace_all(tag_names[i]," ","_");
			var current_animation = struct_get(sprite_struct.tags,tag_names[i]);
			var sub_struct = {
			bbox : [current_animation.from*sprite_struct.width,
			index*sprite_struct.height,
			(current_animation.to+1)*sprite_struct.width,
			(1+index)*sprite_struct.height],
			source_surface : sprite_struct.surface,
			source_sprite : sprite_struct.name,
			full_name : full_name,
				
			},
		struct_set(ase_system.sprite_data.to_pack,sub_struct.full_name,sub_struct);	
			
			
			
			
		};
	
	}
	else
	{
	var sub_struct = {
	bbox : [0,index * sprite_struct.height,surface_get_width(sprite_struct.surface),(1+index)*sprite_struct.height],	
	source_surface	: sprite_struct.surface,
	source_sprite : sprite_struct.name,
		
		
	};
	struct_set(ase_system.sprite_data.to_pack,"spr_"+string_replace_all(sprite_struct.name," ","_"),sub_struct);		
	};
	
	
}	
	
function batch_flattened_layer(sprite_struct){

if(!struct_exists(sprite_struct,"flat_surf"))
{

if(struct_exists(sprite_struct,"palette"))
{
ase_flatten_layers(sprite_struct,sprite_struct.palette.data);	
}
else
{
ase_flatten_layers(sprite_struct,array_create(255,0));		
}
	
}

	
if(struct_exists(sprite_struct,"tags"))
	{
	var tag_names = struct_get_names(sprite_struct.tags)
	for(var i=0; i<array_length(tag_names); i++)
		{
			var full_name = "spr_"+sprite_struct.name+"_"+string_replace_all(tag_names[i]," ","_");
			var current_animation = struct_get(sprite_struct.tags,tag_names[i]);
			var sub_struct = {
			bbox : [current_animation.from*sprite_struct.width,
			0,
			(current_animation.to+1)*sprite_struct.width,
			surface_get_height(sprite_struct.flat_surf)],
			source_surface : sprite_struct.flat_surf,
			source_sprite : sprite_struct.name,
			full_name : full_name,
				
			},
		struct_set(ase_system.sprite_data.to_pack,sub_struct.full_name,sub_struct);	
			
			
			
			
		};
	
	}
	else
	{
	var sub_struct = {
	bbox : [0,0,surface_get_width(sprite_struct.flat_surf),surface_get_height(sprite_struct.flat_surf)],	
	source_surface	: sprite_struct.flat_surf,
	source_sprite : sprite_struct.name,
		
		
	};
	struct_set(ase_system.sprite_data.to_pack,"spr_"+string_replace_all(sprite_struct.name," ","_"),sub_struct);		
	};
	
		
	
	
	
}
	
	
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

for(var i=0; i<array_length(ranges); i++)
{
top_x = max(top_x,ranges[i][0]);	
top_y = max(top_y,ranges[i][1]);
	
	
}

return [top_x,top_y];	
	
	
}
	

function pack_batch(){


var names = struct_get_names(ase_system.sprite_data.to_pack);
show_debug_message(string(names));
array_sort(names,function(current, next){
var current_struct = struct_get(ase_system.sprite_data.to_pack,current);	
var next_struct = struct_get(ase_system.sprite_data.to_pack,next);	
var current_area = (current_struct.bbox[2]-current_struct.bbox[0]) * (current_struct.bbox[3]-current_struct.bbox[1]);
var next_area = (next_struct.bbox[2]-next_struct.bbox[0]) * (next_struct.bbox[3]-next_struct.bbox[1]);
return sign(next_area - current_area);	
	
});

show_debug_message(string(names));

var widths = array_map(names,function(element, index){
return struct_get(ase_system.sprite_data.to_pack,element).bbox[2]-struct_get(ase_system.sprite_data.to_pack,element).bbox[0];
	
});
	
var heights = array_map(names,function(element, index){
return struct_get(ase_system.sprite_data.to_pack,element).bbox[3]-struct_get(ase_system.sprite_data.to_pack,element).bbox[1];
	
});

var canvas = {
width : 16,
height : 16,
empty_cells : [],
placed_cells : [],

};

canvas.empty_cells[0]={
	x : 0,
	y : 0,
	width : canvas.width,
	height : canvas.height,
};

function sort_by_area(cell){
array_sort(cell,function(current, next){
var area = current.width * current.height;	
var next_area = next.width * next.height;	
return sign(area - next_area);
});
	
}



while(array_length(canvas.placed_cells)<array_length(names))
{
	
	
	for(var i=0; i<array_length(names); i++)
	{
	show_debug_message("need to pack: "+string(array_length(names)-array_length(canvas.placed_cells)));
	var current_struct = struct_get(ase_system.sprite_data.to_pack,names[i]);	
	current_struct.possible = variable_clone(canvas.empty_cells);
	current_struct.reference = variable_clone(canvas.empty_cells);
	
	
	with(current_struct)
	{
	//show_debug_message("prefilter: "+string(array_length(possible)));
	possible=array_filter(possible,function(element,index)
	{
	return (bbox[2]-bbox[0]) <= element.width && (bbox[3]-bbox[1]) <= element.height;	
	});
	//show_debug_message("postfilter: "+string(array_length(possible)));	
	
	if(array_length(possible)!=0)
	{
	sort_by_area(possible);
	array_reverse(possible);
	
	
	for(var j=0; j<array_length(reference); j++)
	{
	var optimal = array_first(possible);
	
	if(optimal.x == reference[j].x && optimal.y == reference[j].y)
	{
	cell_index =j;
	break;
	}
		
	}	
	//show_debug_message("Found viable index at: "+string(cell_index));
	}
	
	
	}
	
	
	//canvas.empty_cells=current_struct.possible;
	struct_remove(current_struct,"possible");
	struct_remove(current_struct,"reference");
	
	if(!struct_exists(current_struct,"cell_index"))
	{
		canvas.placed_cells=[];
		array_resize(canvas.empty_cells,1);
		if(canvas.width==canvas.height)
		{
		canvas.width += 16;	
		}
		else
		{
		canvas.height +=16;	
		}
		show_debug_message("Couldn't fit all sprites, resizing canvas to: "+string([canvas.width,canvas.height]));
		
		canvas.empty_cells[0]={
		x : 0,
		y : 0,
		width : canvas.width,
		height : canvas.height,
		};
		
	break;
	}
	else
	{
	
	//show_debug_message("value is: "+string(current_struct.cell_index));
	var index = current_struct.cell_index;
	var extracted = canvas.empty_cells[index];
	
	array_delete(canvas.empty_cells,index,1);
	struct_remove(current_struct,"cell_index");
	var excess_width = extracted.width - (current_struct.bbox[2]-current_struct.bbox[0]);
	var excess_height = extracted.height - (current_struct.bbox[3]-current_struct.bbox[1]);
	
	extracted.data = current_struct;
	
	array_push(canvas.placed_cells,extracted);
	
	if(excess_width>0)
	{
	array_push(canvas.empty_cells,{
	x : extracted.x + (current_struct.bbox[2] - current_struct.bbox[0]),
	y : extracted.y,
	width : extracted.width - (current_struct.bbox[2]-current_struct.bbox[0]),
	height : (current_struct.bbox[3]-current_struct.bbox[1]),
		
	});
	}
	
	if(excess_height>0)
	{
	array_push(canvas.empty_cells,{	
	x : extracted.x,
	y : extracted.y + (current_struct.bbox[3]-current_struct.bbox[1]),
	width : extracted.width,
	height : extracted.height - (current_struct.bbox[3]-current_struct.bbox[1]),
		
		
	});
	}
	
		
	}
	struct_remove(extracted,"width");
	struct_remove(extracted,"height");	
	};
	
	
	
//break;	
	
}
struct_remove(canvas,"empty_cells");
struct_remove(ase_system.sprite_data,"to_pack");
struct_remove(ase_system.sprite_data,"sprites");
struct_set(ase_system.sprite_data,"packed_data",canvas);

ase_system.compiled_sprites.sprites={};

array_foreach(ase_system.sprite_data.packed_data.placed_cells,function(element, index){
var target_struct = ase_system.compiled_sprites.sprites;
var source_struct = struct_get(ase_system.sprites,element.data.source_sprite);

var batch_sprite = {
width : source_struct.width,
height : source_struct.height,
frames : [],
	
	
};
var data_struct = element.data;
var frame_count = (data_struct.bbox[2] - data_struct.bbox[0])/batch_sprite.width;
var layer_count = (data_struct.bbox[3] - data_struct.bbox[1])/batch_sprite.height;
show_debug_message("Frames/layers: "+string([frame_count,layer_count]));
for(var j=0; j<layer_count; j++)
{
	for(var k=0; k<frame_count; k++)
	{
	array_push(batch_sprite.frames,{
	x : element.x + batch_sprite.width * k,
	y : element.y + batch_sprite.height * j,
		
	});
		
		
	}
	
	
}

struct_set(target_struct,element.data.full_name,batch_sprite);

	
});

}


function batch_to_surface(){
ase_system.sprite_surf = surface_create(ase_system.sprite_data.packed_data.width,ase_system.sprite_data.packed_data.height);	
surface_set_target(ase_system.sprite_surf);	
array_foreach(ase_system.sprite_data.packed_data.placed_cells,function(element, index){
//show_debug_message(json_stringify(element,1));
draw_surface_part(element.data.source_surface,element.data.bbox[0],element.data.bbox[1],element.data.bbox[2]-element.data.bbox[0],element.data.bbox[3]-element.data.bbox[1],
element.x,element.y);	
	
});
	
surface_reset_target();	
	
}

function produce_sprites(_string){
	
var w = surface_get_width(ase_system.sprite_surf);
var h = surface_get_height(ase_system.sprite_surf);
if(!struct_exists(ase_system,"texture_buffers"))
{
ase_system.texture_buffers ={};
}
struct_set(ase_system.texture_buffers,_string,buffer_create(16 + (w * h * 4), buffer_fixed,1));	
var sprite_buff = struct_get(ase_system.texture_buffers,_string);
// "RAW " magic (note: little-endian!)
buffer_write(sprite_buff, buffer_u32, 0x20574152);

// width & height
buffer_write(sprite_buff, buffer_s32, w);
buffer_write(sprite_buff, buffer_s32, h);

// format (must be 0)
buffer_write(sprite_buff, buffer_s32, 0);

buffer_get_surface(sprite_buff, ase_system.sprite_surf, 16);

texturegroup_add(_string,sprite_buff,ase_system.compiled_sprites);



return  texturegroup_get_sprites(_string);
	
	
}

