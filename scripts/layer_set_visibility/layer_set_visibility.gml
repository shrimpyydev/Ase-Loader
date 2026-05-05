function layer_set_visibility(_struct,_string, _is_visible){
var layers = _struct.layers,
var layer_index=-1;

for(var i=0; i<array_length(layers); i++)
{
	if(layers[i].layer_name==_string)
	{
	layer_index=i;
	break;
		
	}
	
	
	
}
if(layer_index==-1)
{
exit;	
}
else
{
layers[layer_index].visible=_is_visible;	
if(struct_exists(_struct,"flat_surf"))
	{
		ase_flatten_layers(_struct);
		
	}

}

}