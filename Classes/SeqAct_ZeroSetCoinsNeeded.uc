class SeqAct_ZeroSetCoinsNeeded extends SequenceAction;
 
var() int NumCoins;
 
DefaultProperties
 {
    ObjName="Set Coins Needed"
        ObjCategory="Zero"
    HandlerName="SetCoinsNeeded"
    NumCoins = 0
    VariableLinks(1)=(ExpectedType=class'SeqVar_Int', LinkDesc="NumCoins", bWriteable=true, PropertyName=NumCoins)
 }