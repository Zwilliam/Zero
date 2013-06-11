class ZeroPlayerController extends UDNPlayerController
    dependson(UDNPlayerController);
     //dependson(SeqAct_ZeroGivePoints);
     //dependson(SeqAct_ZeroSetCoinsNeeded);
     //dependson(SeqAct_ZeroCollectCoin);
     
     var() int ZeroPoints;
     var() int ZeroCoinsCollected;
     var() int ZeroCoinsNeededThisLevel;
     
     exec function TestWinningConditions()
{
  `log("TestWinningConditions() : Checking winning conditions");
  `log("TestWinningConditions() : Collected: "$ZeroCoinsCollected);
  `log("TestWinningConditions() : Needed: "$ZeroCoinsNeededThisLevel);
 
  if(ZeroCoinsCollected > 0 && ZeroCoinsNeededThisLevel > 0 && ZeroCoinsCollected >= ZeroCoinsNeededThisLevel)
  {
       `log("TestWinningConditions() : Victory!");
  }
  else
  {
       `log("TestWinningConditions() : Go collect more coins!");
  }
}

function CollectCoin(SeqAct_ZeroCollectCoin MyAction)
{
  `log("CollectCoin() : Collected coin");
  ZeroCoinsCollected += 1;
  TestWinningConditions();
}
function SetCoinsNeeded(SeqAct_ZeroSetCoinsNeeded MyAction)
{
  `log("SetCoinsNeeded() : Set needed coins to "$MyAction.NumCoins);
  ZeroCoinsNeededThisLevel = MyAction.NumCoins;
}
function AddPoints(SeqAct_ZeroGivePoints MyAction)
{
  `log("AddPoints() : Adding points: "$MyAction.NumPoints);
  ZeroPoints += MyAction.NumPoints;
}





defaultproperties
{
  ZeroPoints = 0
  ZeroCoinsCollected = 0
  ZeroCoinsNeededThisLevel = 1
}