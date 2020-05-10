// OFFSET STEAM +0x1020

state("CodSP", "Retail")
{
	byte loading : 0x1025E00;
	string32 levelName : 0x485AA1;
	string32 somethingLoading : 0x102E20D; // used for start split
	// byte isOver : 0x168310; // used to detect endgame sequence
	byte inGame : 0x112D8D4;
	string11 kurwaWidelo : 0x482CA2; // used to detect if endgame video is playing
}

state("CodSP", "Steam")
{
	byte loading : 0x1149985;
	string32 levelName : 0x486AC1;
	string32 somethingLoading : 0x102F26D; // used for start split
	// byte isOver : 0x169330; // used to detect endgame sequence
	byte inGame : 0x112E934;
	string11 kurwaWidelo : 0x483CC2; // used to detect if endgame video is playing
}

init {

	//21393408 


	if (modules.First().ModuleMemorySize == 21393408)
	{
		version = "Steam";
		print("Version - Steam");
	}
	else
	{
		version = "Retail";
		print("Version - Retail");
	};
	
	vars.doneMaps = new List<string>();
	
	//list of video "maps" that we don't want to split on
    vars.skipSplit = new List<String> {
        "allied_start.bsp",
        "ru_stalingrad.bsp",
        "uk_6ab.bsp",
        "uk_sas.bsp",
        "us_intro.bsp",
        "us_mid.bsp"
    };
}

start {
	// checks if the 1st map is done loading and if we're in game
	if (current.somethingLoading == "training.bsp" && current.levelName == "training.bsp" && current.inGame == 1)
		vars.doneMaps.Clear();
		return true;
	}
}

split {
	//split on level transitions but not video "maps"
	if (!vars.skipSplit.Contains(current.levelName) && (old.levelName != current.levelName) && !vars.doneMaps.Contains(current.levelName)) {
		vars.doneMaps.Add(current.levelName);
		return true;
	}
	
	//final split
	if (current.levelName == "berlin.bsp" && current.kurwaWidelo == "cod_end.roq") {
		return true;
	}
}

reset
{
	// checks if we're loading into the 1st map and we don't have control
	return current.levelName == "training.bsp" && current.somethingLoading != old.somethingLoading && current.somethingLoading == "training.bsp" && current.inGame == 0;
}

isLoading
{
	return current.loading == 0;
}
