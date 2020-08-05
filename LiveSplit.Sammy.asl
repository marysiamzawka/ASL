state("sammypolish")
{
	string16 levelName : 0xA5AB8;
	int levelEnd : 0x1B8BF4;
}

state("wrun")
{
    string16 levelName : 0x13E368;
}

startup
{
	vars.objList = new List<string>();
	settings.Add("szkolenie", true, "Szkolenie");
	vars.szkolTags = new Dictionary<string,string> {
		{"10001.wmb","Szkolenie 1"},
		{"10002.wmb","Szkolenie 2"},
		{"10003.wmb","Szkolenie 3"},
		{"10004.wmb","Szkolenie 4"},
		{"10005.wmb","Szkolenie 5"},
		{"10006.wmb","Szkolenie 6"},
		{"10007.wmb","Szkolenie 7"},
		{"10008.wmb","Szkolenie 8"},
		{"10009.wmb","Szkolenie 9"},
		{"10012.wmb","Szkolenie 10"},
		{"10010.wmb","Szkolenie 11"},
		{"10011.wmb","Szkolenie 12"},
	};
	settings.Add("zrecz", true, "Ćwicz zręczność");
	vars.zreczTags = new Dictionary<string,string> {
		{"101o_j.wmb","Ćwicz zręczność 1"},
		{"104m_j.wmb","Ćwicz zręczność 2"},
		{"103j_j.wmb","Ćwicz zręczność 3"},
		{"112e_j.wmb","Ćwicz zręczność 4"},
		{"107i_j.wmb","Ćwicz zręczność 5"},
		{"174a_j07.wmb","Ćwicz zręczność 6"},
		{"111r_j.wmb","Ćwicz zręczność 7"},
		{"172c_j06.wmb","Ćwicz zręczność 8"},
		{"175c_t.wmb","Ćwicz zręczność 9"},
		{"177e_j.wmb","Ćwicz zręczność 10"},
		{"108i_j.wmb","Ćwicz zręczność 11"},
		{"179f_t.wmb","Ćwicz zręczność 12"},
	};
	settings.Add("mysl", true, "Ćwicz myślenie");
	vars.myslTags = new Dictionary<string,string> {
		{"106g_t.wmb","Ćwicz myślenie 1"},
		{"171c_t04.wmb","Ćwicz myślenie 2"},
		{"110n_t.wmb","Ćwicz myślenie 3"},
		{"180c_t.wmb","Ćwicz myślenie 4"},
		{"170b_t00.wmb","Ćwicz myślenie 5"},
		{"102n_t.wmb","Ćwicz myślenie 6"},
		{"173B_t05.wmb","Ćwicz myślenie 7"},
		{"114t_t.wmb","Ćwicz myślenie 8"},
		{"178d_t.wmb","Ćwicz myślenie 9"},
		{"176g_t.wmb","Ćwicz myślenie 10"},
		{"113q_t.wmb","Ćwicz myślenie 11"},
		{"109o_t.wmb","Ćwicz myślenie 12"},
	};
	vars.objList = new List<string>();
	foreach (var Tag in vars.szkolTags) {
		settings.Add(Tag.Key, true, Tag.Value, "szkolenie");
		vars.objList.Add(Tag.Key);
	}
	foreach (var Tag in vars.zreczTags) {
		settings.Add(Tag.Key, true, Tag.Value, "zrecz");
		vars.objList.Add(Tag.Key);
	}
	foreach (var Tag in vars.myslTags) {
		settings.Add(Tag.Key, true, Tag.Value, "mysl");
		vars.objList.Add(Tag.Key);
	}
}

init
{
	vars.szkolenie = new List<string>();
	vars.zrecz = new List<string>();
	vars.mysl = new List<string>();
	vars.splits = new List<string>();
}

split
{
	//return current.levelEnd == 4998221 && current.levelEnd != old.levelEnd;	
        if (vars.objList.Contains(current.levelName.ToLowerInvariant()) && settings[current.levelName.ToLowerInvariant()] && !vars.splits.Contains(current.levelName.ToLowerInvariant()))
		{
			vars.splits.Add(current.levelName.ToLowerInvariant());
			return true;
		}
}

start
{
    if ((old.levelName == "menu_greenpepper") || (old.levelName == "MENU1.wmb")); {
  if (current.levelName != old.levelName) {
    return true;
  }
}
}
