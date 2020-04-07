state("Lithtech")
{
	bool isLoad : 0x1592FC, 0x3B8;
	bool isPaused : 0x1C3334;
	string8 mapName : 0x1C220C, 0x24, 0x104, 0x14, 0x284;
}

isLoading
{
	return !current.isLoad;
}

split
{
	return current.mapName != old.mapName;
}

start
{
	return (current.mapName == "ds\\M1" && current.isPaused);
}
