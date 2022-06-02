class Types extends Object;

`include(Build.uci)
`include(Logger.uci)

struct ColorRGBA
{
	var byte R, G, B, A;
	
	StructDefaultProperties
	{
		R = 250
		G = 250
		B = 250
		A = 255
	}
};

struct Fields
{
	var bool Rank;
	var bool Player;
	var bool Level;
	var bool Perk;
	var bool Dosh;
	var bool Kills;
	var bool Assists;
	var bool Health;
	var bool Armor;
	var bool Ping;
	
	StructDefaultProperties
	{
		Rank    = true;
		Player  = true;
		Level   = false;
		Perk    = false;
		Dosh    = false;
		Kills   = false;
		Assists = false;
		Health  = false;
		Armor   = false;
		Ping    = false;
	}
};

struct RankInfo
{
	var int       ID;
	var string    Rank;
	var ColorRGBA TextColor;
	var bool      OverrideAdminRank;
	var Fields    ApplyColorToFields;
};

struct RankRelation
{
	var string ObjectID;
	var int    RankID;
	
	StructDefaultProperties
	{
		RankID = -999
	}
};

struct UIDRankRelation
{
	var UniqueNetId UID;
	var int RankID;
	
	StructDefaultProperties
	{
		RankID = -999
	}
};

struct YASSettingsAdmin
{
	var string    Rank;
	var ColorRGBA TextColor;
	var Fields    ApplyColorToFields;
	
	StructDefaultProperties
	{
		Rank               = "管理员"
		TextColor          = (R=250, G=0, B=0, A=255)
		ApplyColorToFields = (Rank=True, Player=True, Level=False, Perk=False, Dosh=False, Kills=False, Assists=False, Health=False, Armor=False, Ping=False)
	}
};

struct YASSettingsPlayer
{
	var string    Rank;
	var ColorRGBA TextColor;
	var Fields    ApplyColorToFields;
	
	StructDefaultProperties
	{
		Rank               = "玩家"
		TextColor          = (R=250, G=250, B=250, A=255)
		ApplyColorToFields = (Rank=True, Player=True, Level=False, Perk=False, Dosh=False, Kills=False, Assists=False, Health=False, Armor=False, Ping=False)
	}
};

struct YASSettingsHealth
{	
	var int Low;
	var int High;
	
	StructDefaultProperties
	{
		Low  = 40
		High = 80
	}
};

struct YASSettingsArmor
{	
	var int Low;
	var int High;
	
	StructDefaultProperties
	{
		Low  = 40
		High = 80
	}
};

struct YASSettingsPing
{
	var int Low;
	var int High;
	
	StructDefaultProperties
	{
		Low  = 60
		High = 120
	}
};

struct YASSettingsLevel
{
	var int Low [4];
	var int High[4];
	
	StructDefaultProperties
	{
		Low [0] = 0
		High[0] = 0
		Low [1] = 5
		High[1] = 15
		Low [2] = 15
		High[2] = 20
		Low [3] = 20
		High[3] = 25
	}
};

struct YASStyle
{
	// Box shapes
	var int       EdgeSize;
	var int       ShapeServerNameBox;
	var int       ShapeGameInfoBox;
	var int       ShapeWaveInfoBox;
	var int       ShapePlayersCountBox;
	var int       ShapeHeaderBox;
	var int       ShapeStateHealthBoxTopPlayer;
	var int       ShapeStateHealthBoxMidPlayer;
	var int       ShapeStateHealthBoxBottomPlayer;
	var int       ShapeStateArmorBoxTopPlayer;
	var int       ShapeStateArmorBoxMidPlayer;
	var int       ShapeStateArmorBoxBottomPlayer;
	var int       ShapePlayerBoxTopPlayer;
	var int       ShapePlayerBoxMidPlayer;
	var int       ShapePlayerBoxBottomPlayer;
	var int       ShapeStatsBoxTopPlayer;
	var int       ShapeStatsBoxMidPlayer;
	var int       ShapeStatsBoxBottomPlayer;

	// Server box
	var ColorRGBA ServerNameBoxColor;
	var ColorRGBA ServerNameTextColor;

	// Game info box
	var ColorRGBA GameInfoBoxColor;
	var ColorRGBA GameInfoTextColor;

	// Wave info box
	var ColorRGBA WaveBoxColor;
	var ColorRGBA WaveTextColor;

	// Player count box
	var ColorRGBA PlayerCountBoxColor;
	var ColorRGBA PlayerCountTextColor;

	// Header box
	var ColorRGBA ListHeaderBoxColor;
	var ColorRGBA ListHeaderTextColor;

	// State box
	var ColorRGBA StateBoxColorLobby;
	var ColorRGBA StateBoxColorReady;
	var ColorRGBA StateBoxColorNotReady;
	var ColorRGBA StateBoxColorSpectator;
	var ColorRGBA StateBoxColorDead;
	var ColorRGBA StateBoxColorNone;
	var ColorRGBA StateBoxColorHealthLow;
	var ColorRGBA StateBoxColorHealthMid;
	var ColorRGBA StateBoxColorHealthHigh;
	var ColorRGBA StateBoxColorArmorLow;
	var ColorRGBA StateBoxColorArmorMid;
	var ColorRGBA StateBoxColorArmorHigh;
	var ColorRGBA StateBoxColorArmorNone;

	// Player box
	var ColorRGBA PlayerOwnerBoxColor;
	var ColorRGBA PlayerBoxColor;

	// Stats box
	var ColorRGBA StatsOwnerBoxColor;
	var ColorRGBA StatsBoxColor;

	// State text
	var ColorRGBA StateTextColorLobby;
	var ColorRGBA StateTextColorReady;
	var ColorRGBA StateTextColorNotReady;
	var ColorRGBA StateTextColorSpectator;
	var ColorRGBA StateTextColorDead;
	var ColorRGBA StateTextColorNone;
	var ColorRGBA StateTextColorHealthLow;
	var ColorRGBA StateTextColorHealthMid;
	var ColorRGBA StateTextColorHealthHigh;
	var ColorRGBA StateTextColorArmorLow;
	var ColorRGBA StateTextColorArmorMid;
	var ColorRGBA StateTextColorArmorHigh;
	var ColorRGBA StateTextColorArmorNone;

	// Rank text
	var ColorRGBA RankTextColor;

	// Player text
	var ColorRGBA PlayerNameTextColor;

	// Level text
	var ColorRGBA LevelTextColorLow;
	var ColorRGBA LevelTextColorMid;
	var ColorRGBA LevelTextColorHigh;

	// Perk text
	var ColorRGBA ZedTextColor;
	var ColorRGBA PerkNoneTextColor;
	var ColorRGBA PerkBerserkerTextColor;
	var ColorRGBA PerkCommandoTextColor;
	var ColorRGBA PerkSupportTextColor;
	var ColorRGBA PerkFieldMedicTextColor;
	var ColorRGBA PerkDemolitionistTextColor;
	var ColorRGBA PerkFirebugTextColor;
	var ColorRGBA PerkGunslingerTextColor;
	var ColorRGBA PerkSharpshooterTextColor;
	var ColorRGBA PerkSwatTextColor;
	var ColorRGBA PerkSurvivalistTextColor;

	// Dosh text
	var ColorRGBA DoshTextColorLow;
	var ColorRGBA DoshTextColorMid;
	var ColorRGBA DoshTextColorHigh;

	// Kills text
	var ColorRGBA KillsTextColorLow;
	var ColorRGBA KillsTextColorMid;
	var ColorRGBA KillsTextColorHigh;

	// Assists text
	var ColorRGBA AssistsTextColorLow;
	var ColorRGBA AssistsTextColorMid;
	var ColorRGBA AssistsTextColorHigh;

	// Ping text
	var ColorRGBA PingTextColorNone;
	var ColorRGBA PingTextColorLow;
	var ColorRGBA PingTextColorMid;
	var ColorRGBA PingTextColorHigh;

	// Other settings
	var bool      ShowPingBars;
	var bool      HealthBoxSmoothColorChange;
	var bool      ArmorBoxSmoothColorChange;
	var bool      HealthTextSmoothColorChange;
	var bool      ArmorTextSmoothColorChange;
	var bool      LevelTextSmoothColorChange;
	var bool      DoshTextSmoothColorChange;
	var bool      KillsTextSmoothColorChange;
	var bool      AssistsTextSmoothColorChange;
	var bool      PingTextSmoothColorChange;
	
	StructDefaultProperties
	{
		EdgeSize                        = 8
		
		// Box shapes
		ShapeServerNameBox              = 150
		ShapeGameInfoBox                = 151
		ShapeWaveInfoBox                = 0
		ShapePlayersCountBox            = 152
		ShapeHeaderBox                  = 150
		ShapeStateHealthBoxTopPlayer    = 151
		ShapeStateHealthBoxMidPlayer    = 151
		ShapeStateHealthBoxBottomPlayer = 151
		ShapeStateArmorBoxTopPlayer     = 151
		ShapeStateArmorBoxMidPlayer     = 151
		ShapeStateArmorBoxBottomPlayer  = 151
		ShapePlayerBoxTopPlayer         = 0
		ShapePlayerBoxMidPlayer         = 0
		ShapePlayerBoxBottomPlayer      = 0
		ShapeStatsBoxTopPlayer          = 153
		ShapeStatsBoxMidPlayer          = 153
		ShapeStatsBoxBottomPlayer       = 153
		
		// Server box
		ServerNameBoxColor              = (R=75,  G=0,   B=0,   A=200)
		ServerNameTextColor             = (R=250, G=250, B=250, A=255)
		
		// Game info box
		GameInfoBoxColor                = (R=30,  G=30,  B=30,  A=200)
		GameInfoTextColor               = (R=250, G=250, B=250, A=255)
		
		// Wave info box
		WaveBoxColor                    = (R=10,  G=10,  B=10,  A=200)
		WaveTextColor                   = (R=250, G=250, B=250, A=255)
		
		// Player count box
		PlayerCountBoxColor             = (R=75,  G=0,   B=0,   A=200)
		PlayerCountTextColor            = (R=250, G=250, B=250, A=255)
		
		// Header box
		ListHeaderBoxColor              = (R=10,  G=10,  B=10,  A=200)
		ListHeaderTextColor             = (R=250, G=250, B=250, A=255)
		
		// State box
		StateBoxColorLobby              = (R=150, G=150, B=150, A=150)
		StateBoxColorReady              = (R=150, G=150, B=150, A=150)
		StateBoxColorNotReady           = (R=150, G=150, B=150, A=150)
		StateBoxColorSpectator          = (R=150, G=150, B=150, A=150)
		StateBoxColorDead               = (R=200, G=0,   B=0,   A=150)
		StateBoxColorNone               = (R=150, G=150, B=150, A=150)
		StateBoxColorHealthLow          = (R=200, G=50,  B=50,  A=150)
		StateBoxColorHealthMid          = (R=200, G=200, B=0,   A=150)
		StateBoxColorHealthHigh         = (R=0,   G=200, B=0,   A=150)
		StateBoxColorArmorLow           = (R=0,   G=0,   B=150, A=150)
		StateBoxColorArmorMid           = (R=0,   G=0,   B=150, A=150)
		StateBoxColorArmorHigh          = (R=0,   G=0,   B=150, A=150)
		StateBoxColorArmorNone          = (R=30,  G=30,  B=30,  A=150)
		
		// Player box
		PlayerOwnerBoxColor             = (R=100, G=10,  B=10,  A=150)
		PlayerBoxColor                  = (R=30,  G=30,  B=30,  A=150)
		
		// Stats box
		StatsOwnerBoxColor              = (R=10,  G=10,  B=10,  A=150)
		StatsBoxColor                   = (R=10,  G=10,  B=10,  A=150)
		
		// State text
		StateTextColorLobby             = (R=150, G=150, B=150, A=150)
		StateTextColorReady             = (R=150, G=150, B=150, A=150)
		StateTextColorNotReady          = (R=150, G=150, B=150, A=150)
		StateTextColorSpectator         = (R=150, G=150, B=150, A=150)
		StateTextColorDead              = (R=250, G=0,   B=0,   A=255)
		StateTextColorNone              = (R=250, G=250, B=250, A=255)
		StateTextColorHealthLow         = (R=250, G=250, B=250, A=255)
		StateTextColorHealthMid         = (R=250, G=250, B=250, A=255)
		StateTextColorHealthHigh        = (R=250, G=250, B=250, A=255)
		StateTextColorArmorLow          = (R=250, G=250, B=250, A=255)
		StateTextColorArmorMid          = (R=250, G=250, B=250, A=255)
		StateTextColorArmorHigh         = (R=250, G=250, B=250, A=255)
		StateTextColorArmorNone         = (R=0,   G=0,   B=0  , A=0  )
		
		// Rank text
		RankTextColor                   = (R=250, G=250, B=250, A=255)
		
		// Player text
		PlayerNameTextColor             = (R=250, G=250, B=250, A=255)
		
		// Level text
		LevelTextColorLow               = (R=250, G=100, B=100, A=255)
		LevelTextColorMid               = (R=250, G=250, B=0,   A=255)
		LevelTextColorHigh              = (R=0,   G=250, B=0,   A=255)
		
		// Perk text
		ZedTextColor                    = (R=255, G=0,   B=0,   A=255)
		PerkNoneTextColor               = (R=250, G=250, B=250, A=255)
		PerkBerserkerTextColor          = (R=250, G=250, B=250, A=255)
		PerkCommandoTextColor           = (R=250, G=250, B=250, A=255)
		PerkSupportTextColor            = (R=250, G=250, B=250, A=255)
		PerkFieldMedicTextColor         = (R=250, G=250, B=250, A=255)
		PerkDemolitionistTextColor      = (R=250, G=250, B=250, A=255)
		PerkFirebugTextColor            = (R=250, G=250, B=250, A=255)
		PerkGunslingerTextColor         = (R=250, G=250, B=250, A=255)
		PerkSharpshooterTextColor       = (R=250, G=250, B=250, A=255)
		PerkSwatTextColor               = (R=250, G=250, B=250, A=255)
		PerkSurvivalistTextColor        = (R=250, G=250, B=250, A=255)
	
		// Dosh text
		DoshTextColorLow                = (R=250, G=250, B=100, A=255)
		DoshTextColorMid                = (R=250, G=250, B=100, A=255)
		DoshTextColorHigh               = (R=250, G=250, B=100, A=255)
	
		// Kills text
		KillsTextColorLow               = (R=250, G=250, B=250, A=255)
		KillsTextColorMid               = (R=250, G=250, B=250, A=255)
		KillsTextColorHigh              = (R=250, G=250, B=250, A=255)
	
		// Assists text
		AssistsTextColorLow             = (R=250, G=250, B=250, A=255)
		AssistsTextColorMid             = (R=250, G=250, B=250, A=255)
		AssistsTextColorHigh            = (R=250, G=250, B=250, A=255)
		
		// Ping text
		PingTextColorNone               = (R=250, G=250, B=250, A=255)
		PingTextColorLow                = (R=0,   G=250, B=0,   A=255)
		PingTextColorMid                = (R=250, G=250, B=0,   A=255)
		PingTextColorHigh               = (R=250, G=0,   B=0,   A=255)
		
		// Other settings
		ShowPingBars                    = true
		HealthBoxSmoothColorChange      = true
		ArmorBoxSmoothColorChange       = true
		HealthTextSmoothColorChange     = false
		ArmorTextSmoothColorChange      = false
		LevelTextSmoothColorChange      = false
		DoshTextSmoothColorChange       = false
		KillsTextSmoothColorChange      = false
		AssistsTextSmoothColorChange    = false
		PingTextSmoothColorChange       = false
	}
};

struct YASSettings
{
	var YASStyle          Style;
	var YASSettingsAdmin  Admin;
	var YASSettingsPlayer Player;
	var YASSettingsPing   Ping;
	var YASSettingsLevel  Level;
	var YASSettingsHealth Health;
	var YASSettingsArmor  Armor;
};

