function ase_set_bbox_kind(_sprite,bbox_type){
if(bbox_type = bboxkind_rectangular || bbox_type = bboxkind_ellipse || bbox_type = bboxkind_diamond || bbox_type = bboxkind_precise)
{
_sprite.bbox_kind = bbox_type;
}
else
{
show_debug_message("Invalid bbox constant");	
}

}