class CDMonsterCharacterInfo extends Object;

struct MonsterCharacterInfo
{
    var() name LocalizationKey;
    var KFCharacterInfoBase MonsterArchPath;

    structdefaultproperties
    {
        LocalizationKey=None
        MonsterArchPath=none
    }
};

var array<MonsterCharacterInfo> MonsterArchList;

static function KFCharacterInfoBase GetCharacterArch(KFPawn_Monster Monster, KFCharacterInfoBase Info)
{
    local KFCharacterInfoBase CharacterArch;

    CharacterArch = GetMonsterCharacterArch(Monster);
    if(CharacterArch != none)
    {
        return CharacterArch;
    }
    return Info;  
}

static function KFCharacterInfoBase GetMonsterCharacterArch(KFPawn_Monster Monster)
{
    local int Index;
    local MonsterCharacterInfo MonsterArch;

    Index = default.MonsterArchList.Find('LocalizationKey', Monster.LocalizationKey);
    if(Index != -1)
    {
        MonsterArch = default.MonsterArchList[Index];
        return MonsterArch.MonsterArchPath;
    }
    return none;
}


// Decompiled with UE Explorer.
defaultproperties
{
    MonsterArchList(0)=(LocalizationKey=KFPawn_ZedClot_Cyst,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Clot_Undev_Archetype')
    MonsterArchList(1)=(LocalizationKey=KFPawn_ZedClot_Alpha,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Clot_Alpha_Archetype')
    MonsterArchList(2)=(LocalizationKey=KFPawn_ZedClot_AlphaKing,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Clot_AlphaKing_Archetype')
    MonsterArchList(3)=(LocalizationKey=KFPawn_ZedClot_Slasher,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Clot_Slasher_Archetype')
    MonsterArchList(4)=(LocalizationKey=KFPawn_ZedSiren,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Siren_Archetype')
    MonsterArchList(5)=(LocalizationKey=KFPawn_ZedStalker,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Stalker_Archetype')
    MonsterArchList(6)=(LocalizationKey=KFPawn_ZedCrawler,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Crawler_Archetype')
    MonsterArchList(7)=(LocalizationKey=KFPawn_ZedCrawlerKing,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_CrawlerKing_Archetype')
    MonsterArchList(8)=(LocalizationKey=KFPawn_ZedGorefast,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Gorefast_Archetype')
    MonsterArchList(9)=(LocalizationKey=KFPawn_ZedGorefastDualBlade,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Gorefast2_Archetype')
    MonsterArchList(10)=(LocalizationKey=KFPawn_ZedBloat,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Bloat_Archetype')
    MonsterArchList(11)=(LocalizationKey=KFPawn_ZedHusk,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Husk_Archetype')
    MonsterArchList(12)=(LocalizationKey=KFPawn_ZedDAR_EMP,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_DAR_EMP_Archetype')
    MonsterArchList(13)=(LocalizationKey=KFPawn_ZedDAR_Laser,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_DAR_Laser_Archetype')
    MonsterArchList(14)=(LocalizationKey=KFPawn_ZedDAR_Rocket,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_DAR_Rocket_Archetype')
    MonsterArchList(15)=(LocalizationKey=KFPawn_ZedScrake,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Scrake_Archetype')
    MonsterArchList(16)=(LocalizationKey=KFPawn_ZedFleshpound,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Fleshpound_Archetype')
    MonsterArchList(17)=(LocalizationKey=KFPawn_ZedFleshpoundMini,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_FleshpoundMini_Archetype')
    MonsterArchList(18)=(LocalizationKey=KFPawn_ZedFleshpoundKing,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_FleshpoundKing_Archetype')
    MonsterArchList(19)=(LocalizationKey=KFPawn_ZedBloatKing,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_BloatKing_Archetype')
    MonsterArchList(20)=(LocalizationKey=KFPawn_ZedPatriarch,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Patriarch_Archetype')
    MonsterArchList(21)=(LocalizationKey=KFPawn_ZedHans,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Hans_Archetype')
    MonsterArchList(22)=(LocalizationKey=KFPawn_ZedMatriarch,MonsterArchPath=KFCharacterInfo_Monster'ZED_ARCH.ZED_Matriarch_Archetype')
}