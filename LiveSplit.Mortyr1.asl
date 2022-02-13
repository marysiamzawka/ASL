state("Mortyr", "English")
{
	int diffSelect : 0x389064;
	bool isLoad : 0x389070;
	string4 testText : 0x3A229B;
	string2 map : 0xDC578;
	int finalSplit : 0xC22DC;
}

state("Mortyr", "Polish")
{
	int diffSelect : 0x383990;
	bool isLoad : 0x38399C;
	string4 testText : 0x39CBC3;
	string2 map : 0xD6EA8;
	int finalSplit : 0xBE2B4;
}

state("Mortyr", "CoolGames")
{
	int diffSelect : 0x383964; 
	bool isLoad : 0x383970; 
	string2 testText : 0x39CBC3; 
	string2 map : 0xD6E78; 
	int finalSplit : 0xBE2B8; 
}


startup
{
	vars.splits =  new List<string>();
}

init
{
	
	vars.value = memory.ReadValue<byte>(modules.First().BaseAddress + 0xBE2B4);
	if (modules.First().ModuleMemorySize == 4190208)
	{
		version = "English";
	}
	else if (modules.First().ModuleMemorySize == 4165632)
	{
		version = vars.value==2 ? "CoolGames" : "Polish";
	}
}

reset
{
	return current.diffSelect == 11 && current.diffSelect != old.diffSelect;
}

/*
update
{
	//print(modules.First().ModuleMemorySize.ToString());
	// english 4190208
	// polish or CoolGames 4165632
}
*/

isLoading
{
	return current.isLoad;
}

start
{
	vars.splits.Clear();
	if(version=="CoolGames")
	{
		return current.testText=="//" && current.testText != old.testText && current.map == "41";
	}
	else return current.testText == "MAPA" && current.testText != old.testText && current.map == "41";
}

split
{
	if (current.map != old.map && current.map != "41")
	{
		if (!vars.splits.Contains(current.map))
		{
		vars.splits.Add(current.map);
		return true;
		}
	}
	
	if (current.map == "23" && current.finalSplit != 20)
	{
		return true;
	}
}

exit {
    timer.IsGameTimePaused = true;
}