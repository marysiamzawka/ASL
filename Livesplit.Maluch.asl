state("maluch")
{
}

state("maluch", "1.3")
{
	int isLoad : 0x133E88;
	int currentCp : 0xEF4F0;
	int totalCp : 0xEF91C;
	int currentLevel : 0x92454;
	bool hiperLevel : 0x914A8;
	bool inMenu : 0x83608;
	bool hasControl : 0x92568;
}

state("maluch", "1.4")
{
	int isLoad : 0x133E88;
	int currentCp : 0xEF4F0;
	int totalCp : 0xEF91C;
	int currentLevel : 0x92454;
	bool hiperLevel : 0x914A8;
	bool inMenu : 0x83608;
	bool hasControl : 0x92568;
}

state("maluch", "1.5")
{
	int isLoad : 0xF0524;
	int currentCp : 0xABBA0;
	int totalCp : 0xABFCC;
	int currentLevel : 0x92B8C;
	bool hiperLevel : 0x91528;
	bool inMenu : 0x83620;
	bool hasControl : 0x92CA0;
}

init
{
    version = modules.First().FileVersionInfo.FileVersion;
}


isLoading
{
	return current.isLoad != 0;
}

split
{
	return current.currentCp == current.totalCp && current.currentCp != old.currentCp;
}

reset
{
	return !current.hiperLevel && current.currentLevel == 0 && !current.inMenu && current.inMenu != old.inMenu;
}

start
{
	return current.hasControl;
}
