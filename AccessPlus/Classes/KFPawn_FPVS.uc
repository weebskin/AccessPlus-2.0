class KFPawn_FPVS extends KFPawn_ZedFleshPound_Versus;

simulated function Vs(KFPlayerController KFPC)
{
	KFPlayerInput(KFPC.PlayerInput).bVersusInput = false;
}

function Suicide()
{
	local vector Loc;
	local rotator Rot;
	local Pawn Human;
	local class<Pawn> DefaultPlayerClass;
	local KFPlayerController KFPC;
	
	KFPC=KFPlayerController(Instigator.Controller);
	DefaultPlayerClass = class<Pawn>(DynamicLoadObject("AccessPlus.KFPawn_HT", class'Class'));
	
	Loc = KFPC.Pawn.Location;
	Rot = KFPC.Pawn.Rotation;
	
	KFPC.Pawn.Destroy();
	Human = Spawn(DefaultPlayerClass,,,Loc,Rot, , false);
	KFPC.Pawn=Human;
	KFPC.Possess(KFPC.Pawn, false);
	WorldInfo.Game.AddDefaultInventory(KFPC.Pawn);
	WorldInfo.Game.SetPlayerDefaults(KFPC.Pawn);
	KFPC.ServerCamera('FirstPerson');
	KFPC.SetCameraMode('FirstPerson');
	Vs(KFPC);
}

simulated function SetCharacterArch(KFCharacterInfoBase Info, optional bool bForce)
{
	local KFCharacterInfoBase MonsterCharacterArch;

	MonsterCharacterArch = class'CDMonsterCharacterInfo'.static.GetCharacterArch(self, Info);
	MonsterCharacterArch.DefaultMeshScale = 1.3;
	super(KFPawn_Monster).SetCharacterArch(MonsterCharacterArch, bForce);
	MonsterCharacterArch.DefaultMeshScale = 1;
}

