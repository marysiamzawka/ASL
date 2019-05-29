state("SkyDrift")
{
	int level : 0x9FD408;
}

split
{
	return (current.level > old.level && current.level != 0)
}