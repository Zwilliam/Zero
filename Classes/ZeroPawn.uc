class ZeroPawn extends UDNPawn
    dependson(UDNPawn);
 
simulated function Tick(float DeltaTime)
{
        local vector tmpLocation;
    super.Tick(DeltaTime);
        tmpLocation = Location;
        tmpLocation.Y = 500;
        SetLocation(tmpLocation);
}

simulated function TakeFallingDamage()
{

}


 
function bool Dodge(eDoubleClickDir DoubleClickMove)
{
	local vector X,Y,Z, TraceStart, TraceEnd, Dir, Cross, HitLocation, HitNormal;
	local Actor HitActor;
	local rotator TurnRot;

	if ( bIsCrouched || bWantsToCrouch || (Physics != PHYS_Walking && Physics != PHYS_Falling) )
		return false;

	TurnRot.Yaw = Rotation.Yaw;
	GetAxes(TurnRot,X,Y,Z);

	
	
if (DoubleClickMove == DCLICK_Forward)
	{
		Dir =  X;
		Cross = Y;
	}
	else if (DoubleClickMove == DCLICK_Back)
	{
		Dir = -1 * X;
		Cross = Y;
	}
	else if (DoubleClickMove == DCLICK_Left)
	{
		Dir = -1 * Y;
		Cross = X;
	}
	else if (DoubleClickMove == DCLICK_Right)
	{
		Dir = 10* Y;
		Cross = X;
	}
	if ( AIController(Controller) != None )
		Cross = vect(0,0,0);
	return PerformDodge(DoubleClickMove, Dir,Cross);
}



 
defaultproperties
{
 ControllerClass=class'Zero.ZeroBot'
 bCanStrafe=false
DefaultAirControl=+0.65
 MaxStepHeight=50.0
 MaxJumpHeight=96
 JumpZ=550

 
}