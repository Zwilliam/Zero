class ZeroBot extends UTBot;

var() actor ZeroPatrolStart;
var() actor ZeroPatrolEnd;
var() actor ZeroTarget;
var() float ZeroMaxFireRange;
 
function ZeroConfigureBot(SeqAct_ZeroConfigureBot MyAction)
{
  ZeroPatrolStart = actor(MyAction.PatrolStart);
  ZeroPatrolEnd = actor(MyAction.PatrolEnd);
  ZeroTarget = actor(MyAction.Target);
  ZeroMaxFireRange = MyAction.MaxFireRange;
  SetTimer(0.3, true, 'ScanForPlayers');
}
 
function bool ShouldStrafeTo(Actor WayPoint)
{
    return false;
}
 
function ScanForPlayers()
{
    if(ZeroTarget != none && VSize(Controller(ZeroTarget).Pawn.Location - Pawn.Location) < ZeroMaxFireRange && FastTrace(Controller(ZeroTarget).Pawn.Location, Pawn.Location,, true))
    {
        Focus = ZeroTarget;
        Enemy = Controller(ZeroTarget).Pawn;
 
        VisibleEnemy = Enemy;
        EnemyVisibilityTime = WorldInfo.TimeSeconds;
        bEnemyIsVisible = true;
 
        `log("TomatoBot::ScanForPlayers() : I see the player!");
 
                if(!IsInState('ChargingNoStrafe'))
                {
         `log("TomatoBot::ScanForPlayers() : Going to CharginNoStrafe state");
                 GotoState('ChargingNoStrafe');
                }
    }
}
 
state Defending
{
    ignores EnemyNotVisible;
 
    function Restart( bool bVehicleTransition ) {}
 
    function bool IsDefending()
    {
        return true;
    }
 
    function EnableBumps()
    {
        enable('NotifyBump');
    }
 
    event MonitoredPawnAlert()
    {
        WhatToDoNext();
    }
 
    function ClearPathFor(Controller C)
    {
    }
 
    function SetRouteGoal()
    {
        local Actor NextMoveTarget;
        local bool bCanDetour;
 
        bCanDetour = (Vehicle(Pawn) == None) || (UTVehicle_Hoverboard(Pawn) != None);
 
        if ( ActorReachable(RouteGoal) )
            NextMovetarget = RouteGoal;
        else
            NextMoveTarget = FindPathToward(RouteGoal, bCanDetour);
 
        if ( NextMoveTarget == None )
        {
            NextMoveTarget = FindPathToward(RouteGoal, bCanDetour);
        }
 
        if ( NextMoveTarget == None )
        {
            CampTime = 3;
            // No target
            GotoState('Defending','Pausing');
        }
 
        Focus = NextMoveTarget;
        MoveTarget = NextMoveTarget;
    }
 
    function EndState(Name NextStateName)
    {
        MonitoredPawn = None;
        SetCombatTimer();
        bShortCamp = false;
    }
 
    function BeginState(Name PreviousStateName) { }
Begin:
 
    `log("BEGIN DEFENDING");
 
    WaitForLanding();
    CampTime = bShortCamp ? 0.3 : 3.0;
    bShortCamp = false;
 
    SetRouteGoal();
 
    if (Pawn.ReachedDestination(RouteGoal) )
    {
        Goto('Pausing');
    }
    else
    {
Moving:
 
        `log("MOVE DEFENDING");
 
        Pawn.bWantsToCrouch = false;
 
        MoveToward(MoveTarget, MoveTarget, 20, false, true);
 
        if (Pawn.ReachedDestination(RouteGoal))
        {
            goto('Pausing');
        }
    }
    LatentWhatToDoNext();
 
Pausing:
    `log("PAUSE DEFENDING");
 
    StopMovement();
 
    Pawn.bWantsToCrouch = IsSniping() && !WorldInfo.bUseConsoleInput;
 
    SetFocalPoint( Pawn.Location + vector(MoveTarget.Rotation) * 10.0 );
 
    SwitchToBestWeapon();
 
    Sleep(0.5);
 
    if (UTWeapon(Pawn.Weapon) != None && UTWeapon(Pawn.Weapon).ShouldFireWithoutTarget())
        Pawn.BotFire(false);
 
    Sleep(FMax(0.1,CampTime - 0.5));
 
    // Paused at one destination, select the other destination
    if(RouteGoal != none && RouteGoal == ZeroPatrolEnd)
    {
        RouteGoal = ZeroPatrolStart;
    }
    else
    {
        RouteGoal = ZeroPatrolEnd;
    }
 
    LatentWhatToDoNext();
}
 
state ChargingNoStrafe extends Charging
{
    function bool StrafeFromDamage(float Damage, class<DamageType> DamageType, bool bFindDest)
    {
            return false;
    }
 
    function bool TryStrafe(vector sideDir)
    {
        return false;
    }
}
 
defaultproperties
{
  ZeroMaxFireRange = 500
  ZeroPatrolEnd = None
  ZeroPatrolStart = None
  ZeroTarget = None
}