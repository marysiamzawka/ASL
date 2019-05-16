// CMR2 AUTOSPLITTER/INGAMETIMER
// by Mr. Mary and pitp0

// Mr. Mary can't code for shit, if you feel like sanitizing the code, please do.



state("CMR2")
{
	int stageTime : 0x136E0C;
	string9 videoCountry : 0x263B60;
	byte ripSS : 0x1191A0;
	byte currentRally : 0x4173F8;
	byte currentStage : 0x4173FC;
	byte isRaceOver : 0x131BCC;
	byte isMenu : 0x12F0E0;
}

startup
{
	settings.Add("Luckysplit", false, "Split when crossing the finish line");
}

init
{
	refreshRate = 60;
    vars.newRally = new List<String> {
        "grecja",
        "francja",
        "szwecja",
        "australia",
        "kenia",
		"w�ochy",	// w�ochy
		"uk"
    };
	vars.raceTime = 0;
}

update {
	var disableTimer = current.currentStage == 10 && (current.isRaceOver == 1 || current.ripSS == 0);
	if ((current.stageTime > 0 || (current.stageTime == 0 && old.stageTime == 0)) && current.stageTime > old.stageTime && !disableTimer) {
    vars.raceTime = vars.raceTime + current.stageTime - old.stageTime;
}
}

isLoading {
    return true;
}
gameTime {
    return TimeSpan.FromMilliseconds(vars.raceTime*10);
}

start
{
	vars.raceTime = 0;
	// Are we looking at "welcome | finland" screen
	return current.videoCountry == "finlandia";
}
split
{
	//return 
		// 	Final split detection - is UK SS over
	//((current.currentRally == 7 && current.currentStage == 10 && 
	//(current.ripSS == 0 || current.isRaceOver == 1))
	//);
		// Two variants of mid-game split - per-stage or per-rally
	if (settings["Luckysplit"])
			// checking two things
			// - has the finish line been croshed
		return (current.isRaceOver == 1 && current.isRaceOver != old.isRaceOver) ||	
		// - has the SS (that is not the UK - to prevent double split) been ended abruptly (by glitch)
		(current.currentStage == 10 && current.ripSS == 0 && old.ripSS != current.ripSS && current.currentStage != 10) || (current.currentRally == 7 && current.currentStage == 10 && current.stageTime != 0 && 
	(current.ripSS == 0 || current.isRaceOver == 1));
	else
			// checking the "welcome | country" text
		 return (vars.newRally.Contains(current.videoCountry) && current.videoCountry != old.videoCountry) || (current.currentRally == 7 && current.currentStage == 10 && current.stageTime != 0 && 
	(current.ripSS == 0 || current.isRaceOver == 1));
}

reset
{
	return (current.videoCountry == "Dokonaj w" && current.videoCountry != old.videoCountry);
}