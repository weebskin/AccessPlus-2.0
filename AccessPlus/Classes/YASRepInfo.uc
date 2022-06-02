class YASRepInfo extends ReplicationInfo;

`include(Build.uci)
`include(Logger.uci)

// Server vars
var public AccessPlus Mut;

// Client vars
var private KFScoreBoard SC;
var private OnlineSubsystemSteamworks SW;

// Fitst time replication
var public array<UIDRankRelation> SteamGroupRelations;
var private array<UIDRankRelation> RankRelations;
var public array<RankInfo> CustomRanks;
var public YASSettings Settings;
var public UIDRankRelation RankRelation; // Current player rank relation

var private int CustomRanksRepProgress, SteamGroupsRepProgress;

simulated event PostBeginPlay()
{
	`callstack();
	
    super.PostBeginPlay();

    if (bDeleteMe) return;
	
	if (Role < ROLE_Authority || WorldInfo.NetMode == NM_StandAlone)
	{
		GetScoreboard();
		GetOnlineSubsystem();
	}
}

private reliable client function GetScoreboard()
{
	`callstack();
	
	if (SC == None)
		SC = YASHUD(GetALocalPlayerController().myHUD).Scoreboard;
	
	if (SC == None)
		SetTimer(0.1f, false, nameof(GetScoreboard));
	else
		ClearTimer(nameof(GetScoreboard));
}

private reliable client function GetOnlineSubsystem()
{
	`callstack();
	
	if (SW == None)
		SW = OnlineSubsystemSteamworks(class'GameEngine'.static.GetOnlineSubsystem());
	
	if (SW == None)
		SetTimer(0.1f, false, nameof(GetOnlineSubsystem));
	else
		ClearTimer(nameof(GetOnlineSubsystem));
}

public function StartFirstTimeReplication()
{
	`callstack();
	
	ClientAddSettings(Settings);
	SetTimer(0.01f, true, nameof(ReplicateCustomRanks));
	SetTimer(0.01f, true, nameof(ReplicateSteamGroupRelations));
}

private reliable client function ClientAddSettings(YASSettings Set)
{
	`callstack();
	
	Settings = Set;
	ClientApplySettings();
}

private reliable client function ClientApplySettings()
{
	`callstack();
	
	if (SC == None)
	{
		SetTimer(0.1f, false, nameof(ClientApplySettings));
		return;
	}
	
	ClearTimer(nameof(ClientApplySettings));
	
	if (class'ScoreboardStyleClient'.default.bEnabled)
		Settings.Style = class'ScoreboardStyleClient'.static.Settings();
	
	SC.Settings = Settings;
}

private reliable client function ClientApplyCustomRanks()
{
	`callstack();
	
	if (SC == None)
	{
		SetTimer(0.1f, false, nameof(ClientApplyCustomRanks));
		return;
	}
	
	ClearTimer(nameof(ClientApplyCustomRanks));
	SC.CustomRanks = CustomRanks;
}

private reliable client function ClientApplyRankRelations()
{
	`callstack();
	
	if (SC == None)
	{
		SetTimer(0.1f, false, nameof(ClientApplyRankRelations));
		return;
	}
	
	ClearTimer(nameof(ClientApplyRankRelations));
	SC.RankRelations = RankRelations;
}

private function ReplicateCustomRanks()
{
	`callstack();
	
	if (WorldInfo.NetMode != NM_StandAlone && CustomRanksRepProgress < CustomRanks.Length)
	{
		ClientAddCustomRank(CustomRanks[CustomRanksRepProgress]);
		++CustomRanksRepProgress;
	}
	else
	{
		ClearTimer(nameof(ReplicateCustomRanks));
		ClientApplyCustomRanks();
	}
}

private reliable client function ClientAddCustomRank(RankInfo Rank)
{
	`callstack();
	
	CustomRanks.AddItem(Rank);
}

private function ReplicateSteamGroupRelations()
{
	`callstack();
	
	if (WorldInfo.NetMode != NM_StandAlone && SteamGroupsRepProgress < SteamGroupRelations.Length)
	{
		ClientAddSteamGroupRelation(SteamGroupRelations[SteamGroupsRepProgress]);
		++SteamGroupsRepProgress;
	}
	else
	{
		ClearTimer(nameof(ReplicateSteamGroupRelations));
		if (RankRelation.RankID == INDEX_NONE)
			FindMyRankInSteamGroups();
	}
}

private reliable client function ClientAddSteamGroupRelation(UIDRankRelation Rel)
{
	`callstack();
	
	SteamGroupRelations.AddItem(Rel);
}

private reliable client function FindMyRankInSteamGroups()
{
	local UIDRankRelation SteamGroupRel;
	
	`callstack();

	foreach SteamGroupRelations(SteamGroupRel)
		if (SW.CheckPlayerGroup(SteamGroupRel.UID) && (RankRelation.RankID < 0 || SteamGroupRel.RankID < RankRelation.RankID))
			RankRelation.RankID = SteamGroupRel.RankID;

	if (RankRelation.RankID != INDEX_NONE)
		ServerApplyRank(RankRelation.RankID);
}

private reliable server function ServerApplyRank(int RankID)
{
	`callstack();
	
	RankRelation.RankID = RankID;
	Mut.UpdatePlayerRank(RankRelation);
}

public function AddRankRelation(UIDRankRelation Rel)
{
	`callstack();
	
	ClientAddRankRelation(Rel);
}

private reliable client function ClientAddRankRelation(UIDRankRelation Rel)
{
	`callstack();
	
	RankRelations.AddItem(Rel);
	ClientApplyRankRelations();
}

public function RemoveRankRelation(UIDRankRelation Rel)
{
	`callstack();
	
	ClientRemoveRankRelation(Rel);
}

private reliable client function ClientRemoveRankRelation(UIDRankRelation Rel)
{
	`callstack();
	
	RankRelations.RemoveItem(Rel);
	ClientApplyRankRelations();
}

public function UpdateRankRelation(UIDRankRelation Rel)
{
	`callstack();
	
	ClientUpdateRankRelation(Rel);
}

private reliable client function ClientUpdateRankRelation(UIDRankRelation Rel)
{
	local int Index;
	
	`callstack();
	
	Index = RankRelations.Find('UID', Rel.UID);
	
	if (Index != INDEX_NONE)
		RankRelations[Index] = Rel;
	else
		RankRelations.AddItem(Rel);

	ClientApplyRankRelations();
}

defaultproperties
{
	bAlwaysRelevant = false;
	bOnlyRelevantToOwner = true;
	Role = ROLE_Authority;
	RemoteRole = ROLE_SimulatedProxy;
	bSkipActorPropertyReplication = false; // This is needed, otherwise the client-to-server RPC fails

	CustomRanksRepProgress = 0;
	SteamGroupsRepProgress = 0;
}