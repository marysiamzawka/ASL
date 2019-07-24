/*
Portal 3D Autosplitter/Autostart
written live at ESA Summer 2019
by rythin, Mr. Mary and (someone else who just happened to watch idk i just finished it)
and apparently it supports trans rights????
*/


state("Portal 3D")
{
	int currentLevel: 0x1AF2F8;
	int gameState: 0x1AF308;
	int gemStart: 0x18989C;
}


start
{
	return (current.gemStart == 0);
}

split
{
	return (current.currentLevel > old.currentLevel && current.currentLevel != 3) || (current.gameState == 5 && old.gameState != 7);

}