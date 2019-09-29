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

startup
{
	vars.mapTags = new Dictionary<string,string> {
		{"01","Zewnętrzna Cytadela"},
		{"30","Przez Cytadelę"},
		{"10","Zamek Średni"},
		{"33","Wewnętrzny Zamek"},
		{"11","Katedra"},
		{"34","Ciemniejsza Katedra"},
		{"12","Cmentarz"},
		{"13","Zamek Wysoki"},
		{"14","Mniejsza Katedra"},
		{"17","Fabryka"},
		{"35","Park Maszynowy"},
		{"07","Peron"},
		{"08","Przystań U-Boot'ów"},
		{"32","Doki"},
		{"06","Fabryka V2"},
		{"09","Ruiny Miasta"},
		{"24","Pojedynek"},
		{"15","Maszyna Czasu"},
		{"02","Maszyna Czasu - Dalej"},
		{"28","Zaplecza Maszyny Czasu"},
		{"05","Podziemne Kanały"},
		{"31","Ścieki"},
		{"18","Kraftwerk"},
		{"03","Fabryka Droidów"},
		{"19","Centrum Obliczeniowe"},
		{"04","Miasto w Chmurach"},
		{"16","Port Kosmiczny"},
		{"29","Hangar 18"},
		{"23","Latająca Forteca"}
	};
	
	vars.objList = new List<string>();	
	
	foreach (var Tag in vars.mapTags)
	{
		settings.Add(Tag.Key, true, Tag.Value);
		vars.objList.Add(Tag.Key);
	}
}

init
{
	vars.splits =  new List<string>();
	if (modules.First().ModuleMemorySize == 4190208)
	{
		version = "English";
	}
	if (modules.First().ModuleMemorySize == 4165632)
	{
		version = "Polish";
	}
}

reset
{
	return current.diffSelect == 11 && current.diffSelect != old.diffSelect;
}

/*
update
{
	print(modules.First().ModuleMemorySize.ToString());
	// english 4190208
	// polish 4165632
}
*/
isLoading
{
	return current.isLoad;
}

start
{
	vars.splits.Clear();
	return current.testText == "MAPA" && current.testText != old.testText && current.map == "41";
}

split
{
	if (current.map != old.map && current.map != "41")
	{
		if (vars.objList.Contains(current.map) && settings[current.map])
		{
		vars.splits.Add(current.obj);
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