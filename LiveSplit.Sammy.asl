state("sammypolish")
{
	string20 levelName : 0xA5AB8;
	//int levelEnd : 0x1B8BF4;
}

state("wrun")
{
    string20 levelName : 0x13E368;
}

startup
{
	vars.objList = new List<string>();
	settings.Add("szkolenie", true, "Tutorial");
	vars.szkolTags = new Dictionary<string,string> {
		{"10001.wmb","Tutorial 1"},
		{"10002.wmb","Tutorial 2"},
		{"10003.wmb","Tutorial 3"},
		{"10004.wmb","Tutorial 4"},
		{"10005.wmb","Tutorial 5"},
		{"10006.wmb","Tutorial 6"},
		{"10007.wmb","Tutorial 7"},
		{"10008.wmb","Tutorial 8"},
		{"10009.wmb","Tutorial 9"},
		{"10012.wmb","Tutorial 10"},
		{"10010.wmb","Tutorial 11"},
		{"10011.wmb","Tutorial 12"},
	};
	settings.Add("zrecz", true, "Jump'n'Run");
	vars.zreczTags = new Dictionary<string,string> {
		{"101o_j.wmb","Jump'n'Run 1"},
		{"104m_j.wmb","Jump'n'Run 2"},
		{"103j_j.wmb","Jump'n'Run 3"},
		{"112e_j.wmb","Jump'n'Run 4"},
		{"107i_j.wmb","Jump'n'Run 5"},
		{"174a_j07.wmb","Jump'n'Run 6"},
		{"111r_j.wmb","Jump'n'Run 7"},
		{"172c_j06.wmb","Jump'n'Run 8"},
		{"175c_t.wmb","Jump'n'Run 9"},
		{"177e_j.wmb","Jump'n'Run 10"},
		{"108i_j.wmb","Jump'n'Run 11"},
		{"179f_t.wmb","Jump'n'Run 12"},
	};
	settings.Add("mysl", true, "Think'n'Run");
	vars.myslTags = new Dictionary<string,string> {
		{"106g_t.wmb","Think'n'Run 1"},
		{"171c_t04.wmb","Think'n'Run 2"},
		{"110n_t.wmb","Think'n'Run 3"},
		{"180c_t.wmb","Think'n'Run 4"},
		{"170b_t00.wmb","Think'n'Run 5"},
		{"102n_t.wmb","Think'n'Run 6"},
		{"173b_t05.wmb","Think'n'Run 7"},
		{"114t_t.wmb","Think'n'Run 8"},
		{"178d_t.wmb","Think'n'Run 9"},
		{"176g_t.wmb","Think'n'Run 10"},
		{"113q_t.wmb","Think'n'Run 11"},
		{"109o_t.wmb","Think'n'Run 12"},
	};
	vars.objList = new List<string>();
	foreach (var Tag in vars.szkolTags) {
		settings.Add(Tag.Key, true, Tag.Value, "szkolenie");
	}
	foreach (var Tag in vars.zreczTags) {
		settings.Add(Tag.Key, true, Tag.Value, "zrecz");
	}
	foreach (var Tag in vars.myslTags) {
		settings.Add(Tag.Key, true, Tag.Value, "mysl");
	}
	
	settings.Add("ae", false, "Area Entry Splits");
	settings.Add("S1", false, "Split when entering Tutorial 1", "ae");
	settings.Add("Z1", false, "Split when entering Jump'n'Run 1", "ae");
	settings.Add("M1", false, "Split when entering Think'n'Run 1", "ae");
	settings.SetToolTip("S1", "Might be buggy, the game is sucks");
}

init
{
	vars.splits = new List<string>();
	vars.lastLevels = new List<string>();
	vars.lastLevels.Add("109o_t.wmb");
	vars.lastLevels.Add("179f_t.wmb");
	vars.lastLevels.Add("10011.wmb");
}

split
{
	//level end splits
	if (current.levelName != old.levelName) {
		//levels 1-11
		if (settings[old.levelName.ToLowerInvariant()] && !vars.splits.Contains(old.levelName) && !vars.splits.Contains(current.levelName)) {
			if (current.levelName.ToLowerInvariant() != "menu_greenpepper.wmb" && current.levelName.ToLowerInvariant() != "menu1.wmb") {
				if (!vars.lastLevels.Contains(old.levelName.ToLowerInvariant())) {
					vars.splits.Add(old.levelName);
					print("SammySplitter: Splat. " + old.levelName + " -> " + current.levelName);
					return true;
				}
			}
		}
		//levels 12 
		if (vars.lastLevels.Contains(old.levelName.ToLowerInvariant()) && settings[old.levelName.ToLowerInvariant()]) {
			vars.splits.Add(old.levelName);
			print("SammySplitter: Splat. " + old.levelName + " -> " + current.levelName);
			return true;
		}
	}
	
	//area entry splits
	if (current.levelName != old.levelName) {
		if (settings["S1"] && current.levelName.ToLowerInvariant() == "10001.wmb" && !vars.splits.Contains("S1c")) {
			vars.splits.Add("S1c");
			return true;
		}
		
		if (settings["Z1"] && current.levelName.ToLowerInvariant() == "101o_j.wmb" && !vars.splits.Contains("Z1c")) {
			vars.splits.Add("Z1c");
			return true;
		}
		
		if (settings["M1"] && current.levelName.ToLowerInvariant() == "106g_t.wmb" && !vars.splits.Contains("M1c")) {
			vars.splits.Add("M1c");
			return true;
		}
	}
}

start
{
	if (old.levelName.ToLowerInvariant() == "menu_greenpepper.wmb" || old.levelName.ToLowerInvariant() == "menu1.wmb") {
		if (current.levelName != old.levelName) {
			vars.splits.Clear();
			//vars.splits.Add(current.levelName);
			return true;
		}
	}
}
