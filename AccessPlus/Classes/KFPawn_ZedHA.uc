class KFPawn_ZedHA extends KFPawn_ZedHans;

//Status Accessors
static simulated event bool IsABoss()
{
    return false;
}

function OnZedDied(Controller Killer)
{
    super.OnZedDied(Killer);
}

/** Called from Possessed event when this controller has taken control of a Pawn */
function PossessedBy(Controller C, bool bVehicleTransition)
{
    Super.PossessedBy(C, bVehicleTransition);

    PlayBossMusic();
}