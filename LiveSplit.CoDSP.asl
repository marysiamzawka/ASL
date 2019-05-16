// OFFSET STEAM +0x1020

state("CodSP")
{
	byte versionPls : 0x1022
}

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
	byte loading : 0xFF9E58;
	string32 levelName : 0x486AC1;
	string32 somethingLoading : 0x102F26D; // used for start split
	// byte isOver : 0x169330; // used to detect endgame sequence
	byte inGame : 0x112E934;
	string11 kurwaWidelo : 0x483CC2; // used to detect if endgame video is playing
}

isLoading
{
	return current.loading == 0;
}

// list of video-only maps, we don't wanna split on these
init {
	if (current.versionPls == 128)
	{
		version = "Steam";
		print("Version - Steam");
	}
	else
	{
		version = "Retail";
		print("Version - Retail");
	};
    vars.skipSplit = new List<String> {
        "allied_start.bsp",
        "ru_stalingrad.bsp",
        "uk_6ab.bsp",
        "uk_sas.bsp",
        "us_intro.bsp",
        "us_mid.bsp"
    };
}

// checks if current level's name is different than the previous
// OR checks if the map is Berlin and if the final video is playing
split {
	return !vars.skipSplit.Contains(current.levelName) && (old.levelName != current.levelName) || (current.levelName == "berlin.bsp" && current.kurwaWidelo == "cod_end.roq");
}

start
{
// checks if the 1st map is done loading and if we're in game
return current.somethingLoading == "training.bsp" && current.levelName == "training.bsp" && current.inGame == 1;
}

reset
{
// checks if we're loading into the 1st map and we don't have control
return current.levelName == "training.bsp" && current.somethingLoading != old.somethingLoading && current.somethingLoading == "training.bsp" && current.inGame == 0;
}