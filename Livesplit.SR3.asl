// SR:TT Autosplitter/loadremover by Mr. Mary and hoxi(hoxiak)(hoxi___)(hoxiu_)
// what works:
// - autostart
// - splitting on mission/activity end
// - splitting on cutscenes
// - final split (slightly delayed at times)

state("SaintsRowTheThird_DX11")		
{
	string32 currentDialogue : 0x6290C38;		// current voiceline dialogue
	string32 debugString : 0x5320B18;			// some kind of debug msg
	string32 missionBank : 0x44CF985;			// mission/activity bank
	string13 voiceLine : 0x6290C38;
	string16 activityName : 0x55FAE64, 0xAC, 0x104, 0x2C;
	int totalMissions : 0x451ED10;
	int totalActivities : 0x451ED58;
	int runStart : 0xF03CA4;
	int missionPass : 0xF136B0;
	int totalActivities : 0x451ED58;
	int isLoad : 0xEEAAAC;
	// collectibles
    int sexdolls : 0x451EF50;
    int photoops : 0x451EF98;
    int moneypallet : 0x451EF08;
    int drugpackage : 0x451EEC0;
	// activities
	int escort : 0x451F100;
	int genki : 0x451F268;
	int tank : 0x451F220;
	int heli : 0x451F190;
	int fraud : 0x451F1D8;
	int trafficking : 0x451F148;
	int mayhem : 0x451F388;
	int trail : 0x451F2F8;
	int snatch : 0x451F340;
	// cutscene stuff
	bool isCutscene : 0xEEAB80;
	int cutsceneCheck : 0x4542FEC;
	
}
// 1029655572

startup
{
	settings.Add("missions", true, "Missions");
	vars.missionTags = new Dictionary<string,string> {
		{"m01_media.bnk_pc","When Good Heists Go Bad"},
		{"m02_media.bnk_pc","I'm Free, Free Falling"},
		{"m03_media.bnk_pc","We're Going To Need Guns"},
		{"m04_media.bnk_pc","Steelport Here I Am"},
		{"m05_media.bnk_pc","Party Time"},
		{"pierceGA","Guardian Angel (Pierce)"},
		{"ttc","Takeover The City"},
		{"sh01_media.bnk_pc","Hit The Powder Room"},
		{"m06_media.bnk_pc","The Belgian Problem"},
		{"m07_media.bnk_pc","Return to Steelport"},
		{"m08_media.bnk_pc","Trojan Whores"},
		{"sh02_media.bnk_pc","Pimps Up, Hos Down"},
		{"kinzieGA","Guardian Angel (Kinzie)"},
		{"m09_media.bnk_pc","The Ho Boat"},
		{"m10_media.bnk_pc","Gang Bang"},
		{"m11_media.bnk_pc","Convoy Decoy"},
		{"m12_media.bnk_pc","Nyte Blayde's Return"},
		{"m13_media.bnk_pc","STAG Party"},
		{"m14_media.bnk_pc","Live! with Killbane"},
		{"m15_media.bnk_pc","Learning Computer"},
		{"sh03_media.bnk_pc","Stop All The Downloading"},
		{"m16_media.bnk_pc","http://deckers.die"},
		{"m17_media.bnk_pc","My Name Is Cyrus Temple"},
		{"m18_media.bnk_pc","Air Steelport"},
		{"m19_media.bnk_pc","Zombie Attack"},
		{"m20_media.bnk_pc","A Remote Chance"},
		{"sh04_media.bnk_pc","3 Count Beatdown"},
		{"m21_media.bnk_pc","Murderbrawl XXXI"},
		{"m22_media.bnk_pc","Three Way (Kill Killbane)"},
		{"saveShaundi","Three Way (Save Shaundi)"},
		{"m23_media.bnk_pc","STAG Film"},
		{"m24_media.bnk_pc","Gangstas in Space"},
	};
	vars.objList = new List<string>();
	foreach (var Tag in vars.missionTags) {
		settings.Add(Tag.Key, true, Tag.Value, "missions");
		vars.objList.Add(Tag.Key);
	}
	settings.Add("cutscenes", true, "Cutscenes");
	vars.cutsceneIds = new Dictionary<int,string> {
		{1111001216,"We've Only Just Begun"},
		{1111438131,"Painting a Picture"},
		{1106439936,"Face Your Fear"},
		{1110826471,"Phone Phreak"},
	};
	vars.cutList = new List<int>();
	foreach (var Tag in vars.cutsceneIds) {
		settings.Add (Tag.Key.ToString(), true, Tag.Value, "cutscenes");
		vars.cutList.Add(Tag.Key);
	}
			
	settings.Add("activities", true, "Activities");
	settings.Add("blazing", true, "Cyber/Trail Blazing", "activities");
	settings.Add("escort", true, "Escort", "activities");
	settings.Add("heli", true, "Heli Assault", "activities");
	settings.Add("fraud", true, "Insurance Fraud", "activities");
	settings.Add("mayhem", true, "Mayhem", "activities");
	settings.Add("genki", true, "Professor Genki", "activities");
	settings.Add("snatch", true, "Snatch", "activities");
	settings.Add("tank", true, "Tank Mayhem", "activities");
	settings.Add("trafficking", true, "Trafficking", "activities");
	
	settings.Add("finalSplit", true, "Any% Final Split (credits roll)", "missions");
	settings.Add("collectibles", false, "Collectibles");
	settings.Add("drugpackage", true, "Drug Packages", "collectibles");
	settings.Add("moneypallet", true, "Money Pallets", "collectibles");
	settings.Add("photoops", true, "Photo Ops", "collectibles");
	settings.Add("sexdolls", true, "Sex Dolls", "collectibles");
}

init
{
	vars.splits = new List<string>();
	vars.cuts = new List<int>();
	vars.ttc = false;
	vars.pirs = false;
	vars.kinz = false;
	vars.passStates = new List<int>();
	vars.passStates.Add(1037973993);
	vars.passStates.Add(1029655572);
	vars.passStates.Add(1040572168);
	vars.passStates.Add(1032183560);
	vars.cutLines = new List<string>();
	vars.cutLines.Add("mm_a_04_c2_ph");
	vars.cutLines.Add("mm_p_06_c2_ph");
	vars.cutLines.Add("mm_k_05_c2_ph");
	vars.cutLines.Add("mm_z_04_c2_ph");
	
}

update
{
	if (current.voiceLine == "mm_p_03_start")
	{
		vars.ttc = true;
	}
	
	if (current.voiceLine == "_a_ga_nw_01_a")
	{
		vars.kinz = true;
	}
	
	if (current.voiceLine == "_a_ga_dt_03_a")
	{
		vars.pirs = true;
	}
	
	
	//print(current.activityName);
}

start
{
	return ((current.currentDialogue == "m01_convo_2_wm.ctd" || current.currentDialogue == "m01_convo_2_wf.ctd") && current.runStart == old.runStart - 1);
}

split
{
	if (current.missionPass == old.missionPass + 1029655572)
	{
		if (vars.objList.Contains(current.missionBank) && settings[current.missionBank] && !vars.splits.Contains(current.missionBank))
		{
			vars.splits.Add(current.missionBank);
			return true;
		}
	}
	
	if (settings["blazing"])
    {
        if (current.trail == old.trail+1)
        {
            return true;
        }
    }
	
	if (settings["escort"])
	{
		if (current.escort == old.escort+1)
		{
			return true;
		}
	}

	if (settings["genki"])
    {
        if (current.genki == old.genki+1)
        {
            return true;
        }
    }
	
	if (settings["tank"])
	{
		if (current.tank == old.tank+1)
		{
			return true;
		}
	}	
	
	if (settings["snatch"])
	{
		if (current.snatch == old.snatch+1)
		{
			return true;
		}
	}
	
	if (settings["trafficking"])
	{
		if (current.trafficking == old.trafficking+1)
		{
			return true;
		}
	}
	
	if (settings["fraud"])
	{
		if (current.fraud == old.fraud+1)
		{
			return true;
		}
	}
	
	if (settings["heli"])
	{
		if (current.heli == old.heli+1)
		{
			return true;
		}
	}
	
	if (settings["mayhem"])
	{
		if (current.mayhem == old.mayhem+1)
		{
			return true;
		}
	}

	if (settings["kinzieGA"] && vars.kinz && (current.missionPass == old.missionPass + 1029655572))
	{
			vars.kinz = false;
			return true;
	}	

	if (settings["pierceGA"] && vars.pirs && (current.missionPass == old.missionPass + 1029655572))
	{
			vars.pirs = false;
			return true;
	}	

	if (vars.ttc)
	{
		if (settings["ttc"] && (current.missionPass == old.missionPass + 1029655572))
		{
			vars.ttc = false;
			return true;
		}
	}
	
	if (current.missionBank == "m24_media.bnk_pc" && old.missionBank == "m22_media.bnk_pc")
	{ 
		if (settings["saveShaundi"])
		{
			return true;
		}
	}
	
	if (current.debugString == "credits_reel_peg_loaded" && current.debugString != old.debugString)
	{
		if (settings["finalSplit"])
		{
			return true;
		}
	}
	
	if (settings["sexdolls"])
    {
        if (current.sexdolls == old.sexdolls+1)
        {
            return true;
        }
    }

    if (settings["photoops"])
    {
        if (current.photoops == old.photoops+1)
        {
            return true;
        }
    }

    if (settings["moneypallet"])
    {
        if (current.moneypallet == old.moneypallet+1)
        {
            return true;
        }
    }

    if (settings["drugpackage"])
    {
        if (current.drugpackage == old.drugpackage+1)
        {
            return true;
        }
    }
	
	if (current.cutsceneCheck == 0 && old.cutsceneCheck != current.cutsceneCheck && vars.cutLines.Contains(current.voiceLine))
	{
		if (vars.cutList.Contains(old.cutsceneCheck) && settings[old.cutsceneCheck.ToString()] && !vars.cuts.Contains(old.cutsceneCheck))
		{
			vars.cuts.Add(old.cutsceneCheck);
			return true;
		}
	}
	
	

}

isLoading
{
	return (current.isLoad == 3 && !vars.passStates.Contains(current.missionPass));
}
