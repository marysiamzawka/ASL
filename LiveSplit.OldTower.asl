state("fuse")
{
	byte levelNum : "fuse.exe", 0xCAAE7B;
}
start
{
if (current.levelNum == 1 && old.levelNum == 0) return true;
}
split
{
if (old.levelNum < current.levelNum) return true;
}
reset
{
if (old.levelNum > current.levelNum && current.levelNum == 0) return true;
}