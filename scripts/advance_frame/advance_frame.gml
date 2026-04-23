function advance_frame(_struct,animation=-1,speed_factor=1){
if(!variable_instance_exists(self,"time_elapse"))
{
exit;	
}

if(!variable_instance_exists(self,"animation_index"))
{
animation_index=0;	
}

time_elapse+=delta_time*0.001*abs(speed_factor);

if(animation==-1)
{

var current_frame = _struct.frames[ase_index];


while(time_elapse>current_frame[0])
{
time_elapse-=current_frame[0];
ase_index+=sign(speed_factor);
}

while(ase_index<0)
{
ase_index+=_struct.frame_count;	
}

ase_index = ase_index % _struct.frame_count;


	


}
else
{
if(!struct_exists(_struct.tags,animation))
{
animation=-1;
exit;
}
var current_animation = struct_get(_struct.tags,animation);
var from = current_animation.from;
var to = current_animation.to;




var current_frame = _struct.frames[ase_index];

while(time_elapse>current_frame[0])
{
time_elapse-=current_frame[0];
ase_index+=sign(speed_factor);
}	

while(ase_index<from)
{
ase_index+=to-from+1;
}

ase_index = (ase_index - from) % (to - from + 1) + from;


}
}