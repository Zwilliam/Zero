class UDNPlayerController extends UTPlayerController;

state PlayerWalking
{
ignores SeePlayer, HearNoise, Bump;

   function ProcessMove(float DeltaTime, vector NewAccel, eDoubleClickDir DoubleClickMove, rotator DeltaRot)
   {
      local Rotator tempRot;

      if( Pawn == None )
      {
         return;
      }

      if (Role == ROLE_Authority)
      {
         // Update ViewPitch for remote clients
         Pawn.SetRemoteViewPitch( Rotation.Pitch );
      }

      Pawn.Acceleration.X = -5 * PlayerInput.aStrafe * DeltaTime * 100 * PlayerInput.MoveForwardSpeed;
      Pawn.Acceleration.Y = 0;
      Pawn.Acceleration.Z = 0;
      
      tempRot.Pitch = Pawn.Rotation.Pitch;
      tempRot.Roll = 0;
      if(Normal(Pawn.Acceleration) Dot Vect(1,0,0) > 0)
      {
         tempRot.Yaw = 0;
         Pawn.SetRotation(tempRot);
      }
      else if(Normal(Pawn.Acceleration) Dot Vect(1,0,0) < 0)
      {
         tempRot.Yaw = 32768;
         Pawn.SetRotation(tempRot);
      }
	if ( (DoubleClickMove == DCLICK_Active) && (Pawn.Physics == PHYS_Falling) )
			DoubleClickDir = DCLICK_Active;
		else if ( (DoubleClickMove != DCLICK_None) && (DoubleClickMove < DCLICK_Active) )
		{
			if ( UTPawn(Pawn).Dodge(DoubleClickMove) )
				DoubleClickDir = DCLICK_Active;
		}
      CheckJumpOrDuck();
   }

}





//function CheckJumpOrDuck()
//{
//    if ( Pawn == None )
//    {
//        return;
//    }
//    if ( bDoubleJump && (bUpdating || ((EXILAcrobaticPawn(Pawn) != None) && UTPawn(Pawn).CanDoubleJump())) )
//    {
//        //UTPawn(Pawn).DoDoubleJump( bUpdating );
//        if (maxJumpCount <= maxJumpLimitCurrent /*&& pIsInJumpVolume*/)
//        {
//            EXILAcrobaticPawn(Pawn).DoWallJump( bUpdating );
//            maxJumpCount++;
//        }
//    }
//    else if ( bPressedJump )
//    {
//        if (Pawn.Physics == PHYS_Falling)
//        {
//            if (maxJumpCount <= maxJumpLimitCurrent /*&& pIsInJumpVolume*/)
//            {
//                EXILAcrobaticPawn(Pawn).DoWallJump( bUpdating );
//                maxJumpCount++;
//            }
//        }
//        else
//        {
//            maxJumpCount = 0;
//            EXILAcrobaticPawn(Pawn).AirControlReset();
//            Pawn.DoJump( bUpdating );
//        }
//    }
//    if ( Pawn.Physics != PHYS_Falling && Pawn.bCanCrouch )
//    {
//        // crouch if pressing duck
//        Pawn.ShouldCrouch(bDuck != 0);
//    }
//}








function UpdateRotation( float DeltaTime )
{
   local Rotator   DeltaRot, ViewRotation;

   ViewRotation = Rotation;

   // Calculate Delta to be applied on ViewRotation
   DeltaRot.Yaw = Pawn.Rotation.Yaw;
   DeltaRot.Pitch   = PlayerInput.aLookUp;

   ProcessViewRotation( DeltaTime, ViewRotation, DeltaRot );
   SetRotation(ViewRotation);
}   

defaultproperties
{
}