class SeqAction_LevelComplete extends SequenceAction;

var Actor A;

event Activated()
{
	local UTGame Game;

	Game = UTGame(GetWorldInfo().Game);
	Game.EndGame(UTPlayerReplicationInfo(A), "triggered");
	
}

defaultproperties
{
	ObjName="Level Complete"
	ObjCategory="Custom"
	VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Player",bWriteable=true,PropertyName=A)
}