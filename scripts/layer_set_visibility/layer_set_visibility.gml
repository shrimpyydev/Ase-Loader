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
layers[layer_index].visible=bool(_is_visible);	
}

}