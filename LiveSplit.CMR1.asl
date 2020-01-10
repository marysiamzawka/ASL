state("Rally")
{
	int stageTime : 0x1FF9FC;
	int isDone : 0x14FC40;
	bool runStart : 0xEE84C;
	bool inMain : 0x9905E0;
}

init
{
	vars.raceTime = 0;
	vars.runBegin = false;
}

update
{
	if (vars.runBegin)
	{
		vars.raceTime = 0;
	}
	else if (current.stageTime == 0 && old.stageTime > 0)
	{
		vars.raceTime = vars.raceTime;
	}
	else
	{
		vars.raceTime = vars.raceTime + current.stageTime - old.stageTime;
	}
	if (current.stageTime == 0)
	{
		vars.runBegin = false;
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

split
{
	return (current.isDone == 1 && old.isDone == 11);
}

start
{
	if (current.runStart && !old.runStart)
	{
		vars.runBegin = true;
		return true;
	}
}

reset
{
	return !current.inMain;
}
