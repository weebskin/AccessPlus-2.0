class KFWeap_Zedheal extends KFWeap_HealerBase;

simulated function CustomFire()
{
	local KFPlayerController KFPC;
	
	KFPC=KFPlayerController(Instigator.Controller);
	KFPC.ServerCamera( 'ThirdPerson' );
	KFPlayerInput(KFPC.PlayerInput).bVersusInput = true;
	
	Big();
}

function class<KFPawn_Monster> LoadMonsterByName()
{
	local class<KFPawn_Monster> SpawnClass;
	
	SpawnClass = class<KFPawn_Monster>(DynamicLoadObject("AccessPlus.KFPawn_FPVS", class'Class'));
	
	if( SpawnClass != none )
	{
		SpawnClass = SpawnClass.static.GetAIPawnClassToSpawn();
	}
	else 
	{
		return none;
	}
	
	return SpawnClass;
}

function Big()
{
	local class<KFPawn_Monster> MonsterClass;
	local vector SpawnLoc;
	local rotator SpawnRot;
	local KFPawn KFP;
	local KFPlayerController KFPC;
	
	KFPC=KFPlayerController(Instigator.Controller);
	//KFPCC = KFPC;
	MonsterClass = LoadMonsterByName();
	
	if( MonsterClass != none )
	{
		// The ZED should be spawned X units in front of the view location
		if( KFPC.Pawn != None )
		{
			SpawnLoc = KFPC.Pawn.Location;
		}
		else
		{
			SpawnLoc = Location;
		}

		SpawnLoc += 200.f * vector(Rotation) + vect(0,0,1) * 15.f;
		SpawnRot.Yaw = Rotation.Yaw + 32768;
		
		KFP = Spawn( MonsterClass,,, SpawnLoc, SpawnRot,, false );
		if( KFP != none )
		{
			if( KFPC.Pawn != none )
			{
				KFPC.Pawn.Destroy();
			}
			
			KFPawn_Monster(KFP).bDebug_SpawnedThroughCheat = true;
			KFP.SetPhysics( PHYS_Falling );

			if( KFP.Controller != none )
			{
				KFP.Controller.Destroy();
			}
			
			KFGameInfo(WorldInfo.Game).SetMonsterDefaults( KFPawn_Monster(KFP));
			KFPC.Possess( KFP, false );
		}
		KFP.UpdateLastTimeDamageHappened();
	}
}

function InitializeAmmo()
{
	// Set ammo amounts based on perk.  MagazineCapacity must be replicated, but
	// only the server needs to know the InitialSpareMags value
	MagazineCapacity[0] = default.MagazineCapacity[0];
	InitialSpareMags[0] = default.InitialSpareMags[0];

	AmmoCount[0] = MagazineCapacity[0];
	AddAmmo(InitialSpareMags[0] * MagazineCapacity[0]);
}

defaultproperties
{
	// Content
	PackageKey="Healer"
	FirstPersonMeshName="WEP_1P_Healer_MESH.Wep_1stP_Healer_Rig"
	FirstPersonAnimSetNames(0)="WEP_1P_Healer_ANIM.Wep_1st_Healer_Anim"
	AttachmentArchetypeName="WEP_Healer_ARCH.Wep_Healer_3P"

	Begin Object Name=FirstPersonMesh
		Animations=AnimTree'CHR_1P_Arms_ARCH.WEP_1stP_Animtree_Healer'
	End Object

	FireModeIconPaths(DEFAULT_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_MedicDart'
	FireModeIconPaths(ALTFIRE_FIREMODE)=Texture2D'ui_firemodes_tex.UI_FireModeSelect_MedicDart'
	
	WeaponSelectTexture=Texture2D'ui_weaponselect_tex.UI_WeaponSelect_Healer'

	bCanThrow=false
	bDropOnDeath=false
	bStorePreviouslyEquipped=false
}