// CMR2 AUTOSPLITTER/INGAMETIMER
// by Mr. Mary and pitp0

// Mr. Mary can't code for shit, if you feel like sanitizing the code, please do.



state("CMR2")
{
	int stageTime : 0x136E0C;
	string9 videoCountry : 0x263B60;
	string5 className : 0x263B60;
	byte ripSS : 0x1191A0;
	byte currentRally : 0x4173F8;
	byte currentStage : 0x4173FC;
	bool isRaceOver : 0x131BCC;
	byte isMenu : 0x12F0E0;
	byte countrySpecific : 0x12EA54;
	bool isPause : 0x120870;
}

startup
{
	settings.Add("Luckysplit", false, "Split when crossing the finish line (Championship% only)");
}

init
{
	vars.category = timer.Run.CategoryName.ToLower();
	vars.finland = "";
	vars.menuLine = "";
    if (current.countrySpecific == 3)
	{
		vars.newRally = new List<String> {
			"grecja",
			"francja",
			"szwecja",
			"australia",
			"kenia",
			"w�ochy",	// w�ochy
			"uk"
		};
		vars.finland = "finlandia";
		vars.menuLine = "Dokonaj w";
		vars.arcadeStart = "Klasa";
	}
	else 
	{
		vars.newRally = new List<String> {
			"greece",
			"france",
			"sweden",
			"australia",
			"kenya",
			"italy",	// w�ochy
			"united ki"
		};
		vars.finland = "finland";
		vars.menuLine = "Use the c";
		vars.arcadeStart = "Class";
	}
	vars.raceTime = 0;
	vars.arcadeStop = false;
}

update 
{	
	var disableTimer = current.currentStage == 10 && (current.isRaceOver || current.ripSS == 0);
		
		
	if (current.stageTime != 0 && (current.stageTime - old.stageTime > 300))
	{
		vars.arcadeStop = true;
	}
	else if (current.stageTime == 0 && current.stageTime == old.stageTime)
	{
		vars.arcadeStop = false;
	}
		
		
	if (vars.category.Contains("championship"))
	{
	if (
	(current.stageTime > 0 || (current.stageTime == 0 && old.stageTime == 0))
	&& 
	current.stageTime > old.stageTime && !disableTimer
	)
		{
			vars.raceTime = vars.raceTime + current.stageTime - old.stageTime;
		}
	}
	else if (vars.category.Contains("arcade"))
	{
		if (current.stageTime - old.stageTime < 300)
		{
			if (current.stageTime > 0)
			{
				if (!vars.arcadeStop)
				{
					vars.raceTime = vars.raceTime + current.stageTime - old.stageTime;
				}
			}
		}
	}
}

isLoading 
{
    return true;
}

gameTime
{
    return TimeSpan.FromMilliseconds(vars.raceTime*10);
}

start
{
	vars.raceTime = 0;
	// Are we looking at "welcome | finland" screen
	if (vars.category.Contains("championship"))
	{
		return current.videoCountry == vars.finland;
	}
	else if (vars.category.Contains("arcade"))
	{
		return (old.className == vars.arcadeStart && old.className != current.className);
	}
}
split
{
		// CHAMPIONSHIP
		// Two variants of mid-game split - per-stage or per-rally
	if (vars.category.Contains("championship"))
	{
	if (settings["Luckysplit"])
			// checking two things
			// - has the finish line been croshed
		return (current.isRaceOver && current.isRaceOver != old.isRaceOver) ||	
		// - has the SS (that is not the UK - to prevent double split) been ended abruptly (by glitch)
		(current.currentStage == 10 && current.ripSS == 0 && old.ripSS != current.ripSS && current.currentStage != 10) || (current.currentRally == 7 && current.currentStage == 10 && current.stageTime != 0 && 
	(current.ripSS == 0 || current.isRaceOver));
	else
			// checking the "welcome | country" text
		 return (vars.newRally.Contains(current.videoCountry) && current.videoCountry != old.videoCountry) || (current.currentRally == 7 && current.currentStage == 10 && current.stageTime != 0 && 
	(current.ripSS == 0 || current.isRaceOver));}
	else if (vars.category.Contains("arcade"))
	{
		return (current.isRaceOver && !old.isRaceOver);
	}
}

reset
{
	if (vars.category.Contains("arcade novice") || vars.category.Contains("arcade intermediate") || vars.category.Contains("arcade expert") || vars.category.Contains("championship"))
	{
		return (current.videoCountry == vars.menuLine && current.videoCountry != old.videoCountry);
	}
	else return false;
}

/* keeping this here for whatever purposes'a
	return 
			Final split detection - is UK SS overa
	((current.currentRally == 7 && cuarrent.currentStage == 10 && 
	(current.ripSS == 0 || current.isRaceOver))
	);
*/
