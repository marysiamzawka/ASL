/*
Super Driver loadremover/autosplitter v1.0
by Mr. Mary

feel free to unfuck the code
*/


state("Super Driver")
{
		// is nonzero when loading
	bool isLoad : 0xF253C;
	
		// identifies current selected track (changes when switching in the menu)
	int currentTrack : 0x94DA4;
	
		// current checkpoint (resets to 0 when going to menu)
	int checkPoint : 0xADB8C;
	
		// is nonzero when in menu
	bool inGame : 0x84758;
	
		// these identify current selected track variant for each track that has these
	int osNucl : 0x93090;
	int osVill : 0x9309C;
	int osDriv : 0x930A0;
	int osShop : 0x930A4;
	int osCast : 0x930A8;
	int osDres : 0x930AC;
	int osPark : 0x930B0;
	int osOldv : 0x930B4;
	int osFrew : 0x930B8;
	int osCros : 0x930C0;
}

isLoading
{
	return current.isLoad;
}

startup
{
			// listing off all tracks
	vars.tracksSettings = new Dictionary<string,string> {
		{"nucl1","Nuclear Zone 1"},
		{"nucl2","Nuclear Zone 2"},
		{"formu","Super Formula"},
		{"frewa","Freeway"},
		{"vill1","Village 1"},
		{"vill2","Village 2"},
		{"driv1","Driver Town 1"},
		{"driv2","Driver Town 2"},
		{"shop1","Shopping Center 1"},
		{"shop2","Shopping Center 2"},
		{"cast1","Castle City 1"},
		{"cast2","Castle City 2"},
		{"dres1","Dress Town 1"},
		{"dres2","Dress Town 2"},
		{"park1","Parking 1"},
		{"park2","Parking 2"},
		{"oldv1","Old Village 1"},
		{"oldv2","Old Village 2"},
		{"frew1","Freeway 2 1"},
		{"frew2","Freeway 2 2"},
		{"racet","Race Track"},
		{"cros1","Cross Track 1"},
		{"cros2","Cross Track 2"},
	};
	
		// creating an option for each track
	foreach (var Tag in vars.tracksSettings) {
		settings.Add(Tag.Key, true, Tag.Value);
	}
}

start
{
		// starts when loaded into Nuclear Zone 1
	return (!current.inGame && (current.currentTrack == 1)
/*	&& (current.osNucl == 0)) */ );
}

split
{
		// each track has its own check, i'm sure it can be streamlined
	
	if (settings["nucl1"])
		{if (current.checkPoint == 13 && current.currentTrack == 0 && current.osNucl == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["nucl2"])
		{if (current.checkPoint == 22 && current.currentTrack == 0 && current.osNucl == 1 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["formu"])
		{if (current.checkPoint == 24 && current.currentTrack == 1 && current.checkPoint != old.checkPoint)
		return true;}
		
	if (settings["frewa"])
		{if (current.checkPoint == 18 && current.currentTrack == 2 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["vill1"])
		{if (current.checkPoint == 18 && current.currentTrack == 3 && current.osVill == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["vill2"])
		{if (current.checkPoint == 27 && current.currentTrack == 3 && current.osVill == 1 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["driv1"])
		{if (current.checkPoint == 18 && current.currentTrack == 4 && current.osDriv == 0 && current.checkPoint != old.checkPoint)
		return true;}

	if (settings["driv2"])
		{if (current.checkPoint == 21 && current.currentTrack == 4 && current.osDriv == 1 && current.checkPoint != old.checkPoint)
		return true;}

	if (settings["shop1"])
		{if (current.checkPoint == 34 && current.currentTrack == 5 && current.osShop == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["shop2"])
		{if (current.checkPoint == 52 && current.currentTrack == 5 && current.osShop == 1 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["cast1"])
		{if (current.checkPoint == 21 && current.currentTrack == 6 && current.osCast == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["cast2"])
		{if (current.checkPoint == 72 && current.currentTrack == 6 && current.osCast == 1 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["dres1"])
		{if (current.checkPoint == 36 && current.currentTrack == 7 && current.osDres == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["dres2"])
		{if (current.checkPoint == 48 && current.currentTrack == 7 && current.osDres == 1 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["park1"])
		{if (current.checkPoint == 12 && current.currentTrack == 8 && current.osPark == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["park2"])
		{if (current.checkPoint == 57 && current.currentTrack == 8 && current.osPark == 1 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["oldv1"])
		{if (current.checkPoint == 12 && current.currentTrack == 9 && current.osOldv == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["oldv2"])
		{if (current.checkPoint == 27 && current.currentTrack == 9 && current.osOldv == 1 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["frew1"])
		{if (current.checkPoint == 33 && current.currentTrack == 10 && current.osFrew == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["frew2"])
		{if (current.checkPoint == 6 && current.currentTrack == 10 && current.osFrew == 1 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["racet"])
		{if (current.checkPoint == 28 && current.currentTrack == 11 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["cros1"])
		{if (current.checkPoint == 19 && current.currentTrack == 12 && current.osCros == 0 && current.checkPoint != old.checkPoint)
		return true;}
	
	if (settings["cros2"])
		{if (current.checkPoint == 58 && current.currentTrack == 12 && current.osCros == 1 && current.checkPoint != old.checkPoint)
		return true;}
}
