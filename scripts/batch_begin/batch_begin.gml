function batch_begin()
{
	ase_system.sprite_data =
	{
		to_pack : {},
	};

	if (struct_exists(ase_system.sprite_data, "sprites") == false)
	{
		ase_system.sprite_data.sprites = {};
	}
}