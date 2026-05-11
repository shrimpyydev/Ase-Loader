var sprite_names = struct_get_names(ase_system.sprites);

for (var i = 0; i < array_length(sprite_names); i++)
{
	ase_volitility_protection(struct_get(ase_system.sprites, sprite_names[i]));
}
