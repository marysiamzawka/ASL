state("Lithtech")
{
	bool isLoad : 0x1592FC, 0x3B8;
}

isLoading
{
	return !current.isLoad;
}