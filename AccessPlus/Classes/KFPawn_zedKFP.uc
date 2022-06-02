class KFPawn_zedKFP extends KFPawn_ZedFleshpoundKing;

//Status Accessors
static simulated event bool IsABoss()
{
    return false;
}

function OnZedDied(Controller Killer)
{
    local KFGameInfo_Survival KFGI;
    super.OnZedDied(Killer);
    KFGI = KFGameInfo_Survival(WorldInfo.Game);
    if (KFGI != None)
    {
        KFGI.SpawnManager.bSummoningBossMinions = false;
    }
}

/** Called from Possessed event when this controller has taken control of a Pawn */
function PossessedBy(Controller C, bool bVehicleTransition)
{
    Super.PossessedBy(C, bVehicleTransition);

    PlayBossMusic();
}
