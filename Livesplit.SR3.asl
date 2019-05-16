// SAINTS ROW: THE THIRD AUTOSPLITTER
// WRITTEN BY MR. MARY




state("SaintsRowTheThird_DX11")		
{
	string32 currentDialogue : 0x6290C38;		// current voiceline dialogue
	string32 debugString : 0x5320B18;			// some kind of debug msg
	int totalMissions : 0x451ED10;
	int totalActivities : 0x451ED58;
}

startup
{
	vars.gownoSplity = new List<int>
	{6, 11, 18, 22, 27, 29, 34};
		settings.Add("CreditsSplit", true, "Any% Final split (Credits start)");
}

start
{
	return ((current.currentDialogue == "m01_convo_2_wm.ctd") || (current.currentDialogue == "m01_convo_2_wf.ctd")) && current.currentDialogue != old.currentDialogue;
}

split
{
	if (current.debugString == "credits_reel_peg_loaded" && old.debugString != current.debugString && settings["CreditsSplit"])
	{
		return true;
		print("final split");
	}	
 if(old.totalMissions == 0 && current.totalMissions == 1) return true;
else if ((current.totalMissions > old.totalMissions) && !vars.gownoSplity.Contains(current.totalMissions))
    return true;
	
	
	if (old.totalActivities == 0) {
	if (current.totalActivities == 1) return true;}
	else if (current.totalActivities > old.totalActivities)
return true;
}
