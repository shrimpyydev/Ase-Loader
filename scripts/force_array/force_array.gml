function force_array(_val)
{
	if (is_array(_val) == true)
	{
		return _val;
	}
	else
	{
		return [_val];
	}
}