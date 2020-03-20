state("sammypolish")
{
	string16 levelName : 0xA5AB8;
	int levelEnd : 0x1B8BF4;
}

startup
{
	vars.objList = new List<string>();
	settings.Add("szkolenie", true, "Szkolenie");
	vars.szkolTags = new Dictionary<string,string> {
		{"10001.WMB","Szkolenie 1"},
		{"10002.WMB","Szkolenie 2"},
		{"10003.WMB","Szkolenie 3"},
		{"10004.WMB","Szkolenie 4"},
		{"10005.WMB","Szkolenie 5"},
		{"10006.WMB","Szkolenie 6"},
		{"10007.WMB","Szkolenie 7"},
		{"10008.WMB","Szkolenie 8"},
		{"10009.WMB","Szkolenie 9"},
		{"10012.WMB","Szkolenie 10"},
		{"10010.WMB","Szkolenie 11"},
		{"10011.WMB","Szkolenie 12"},
	};
	settings.Add("zrecz", true, "Ćwicz zręczność");
	vars.zreczTags = new Dictionary<string,string> {
		{"101o_j.WMB","Ćwicz zręczność 1"},
		{"104m_j.WMB","Ćwicz zręczność 2"},
		{"103j_j.WMB","Ćwicz zręczność 3"},
		{"112e_j.WMB","Ćwicz zręczność 4"},
		{"107i_j.WMB","Ćwicz zręczność 5"},
		{"174a_j07.WMB","Ćwicz zręczność 6"},
		{"111r_j.WMB","Ćwicz zręczność 7"},
		{"172c_j06.WMB","Ćwicz zręczność 8"},
		{"175c_t.WMB","Ćwicz zręczność 9"},
		{"177e_j.WMB","Ćwicz zręczność 10"},
		{"108i_j.WMB","Ćwicz zręczność 11"},
		{"179f_t.WMB","Ćwicz zręczność 12"},
	};
	settings.Add("mysl", true, "Ćwicz myślenie");
	vars.myslTags = new Dictionary<string,string> {
		{"106g_t.WMB","Ćwicz myślenie 1"},
		{"171c_t04.WMB","Ćwicz myślenie 2"},
		{"110n_t.WMB","Ćwicz myślenie 3"},
		{"180c_t.WMB","Ćwicz myślenie 4"},
		{"170b_t00.WMB","Ćwicz myślenie 5"},
		{"102n_t.WMB","Ćwicz myślenie 6"},
		{"173B_t05.WMB","Ćwicz myślenie 7"},
		{"114t_t.WMB","Ćwicz myślenie 8"},
		{"178d_t.WMB","Ćwicz myślenie 9"},
		{"176g_t.WMB","Ćwicz myślenie 10"},
		{"113q_t.WMB","Ćwicz myślenie 11"},
		{"109o_t.WMB","Ćwicz myślenie 12"},
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
		if (vars.objList.Contains(current.levelName) && settings[current.levelName] && !vars.splits.Contains(current.levelName))
		{
			vars.splits.Add(current.levelName);
			return true;
		}
}

start
{
	return old.levelName == "menu_greenpepper" && current.levelName != old.levelName;
}