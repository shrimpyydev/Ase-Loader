//this function does nothing in and of itself, it exists to serve as a lookup table for the parse_chunks script;

global._chunktypes =
{
	old_palette_chunk_1 : hex_to_dec("0004"),
	old_palette_chunk_2 : hex_to_dec("0011"),
	layer_chunk : hex_to_dec("2004"),
	cell_chunk : hex_to_dec("2005"),
	cell_extra_chunk : hex_to_dec("2006"),
	color_profile_chunk : hex_to_dec("2007"),
	tags_chunk : hex_to_dec("2018"),
	palette_chunk : hex_to_dec("2019"),
	slice_chunk : hex_to_dec("2022"),
	user_chunk : hex_to_dec("2020"),
};