state("SaintsRowIV", "Current Steam")
{
	int isLoad : 0x12B2314; 
	bool zeroIfComplete : 0x12C0928;
	string32 currentDialogue : 0x3BDEC30;
	int zinyakDed : 0x375E4F8;
}

state("SaintsRowIV", "Pre-Workshop cracked")
{
	int isLoad : 0x51C3D6C;
	bool zeroIfComplete : 0x51D2200; // or 51BB044
	string32 currentDialogue : 0x7AE6F90;
	int zinyakDed : 0x76902B8;
}

init
{
	if (modules.First().ModuleMemorySize == 133226496)
	{
		version = "Pre-Workshop cracked";
	}
	if (modules.First().ModuleMemorySize == 67198976)
	{
		version = "Current Steam";
	}
}

split
{
	return (current.currentDialogue == "m23_beat_down_coming_wf.ctd" || current.currentDialogue == "m23_beat_down_coming_wm.ctd") && (current.zinyakDed == 1); 
}

isLoading
{
	return current.isLoad == 101 && current.zeroIfComplete;
}