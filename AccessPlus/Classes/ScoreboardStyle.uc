class ScoreboardStyle extends Object
	dependson(Types)
	config(YAS);

`include(Build.uci)
`include(Logger.uci)

// Box shapes
var config int       EdgeSize;
var config int       ShapeServerNameBox;
var config int       ShapeGameInfoBox;
var config int       ShapeWaveInfoBox;
var config int       ShapePlayersCountBox;
var config int       ShapeHeaderBox;
var config int       ShapeStateHealthBoxTopPlayer;
var config int       ShapeStateHealthBoxMidPlayer;
var config int       ShapeStateHealthBoxBottomPlayer;
var config int       ShapeStateArmorBoxTopPlayer;
var config int       ShapeStateArmorBoxMidPlayer;
var config int       ShapeStateArmorBoxBottomPlayer;
var config int       ShapePlayerBoxTopPlayer;
var config int       ShapePlayerBoxMidPlayer;
var config int       ShapePlayerBoxBottomPlayer;
var config int       ShapeStatsBoxTopPlayer;
var config int       ShapeStatsBoxMidPlayer;
var config int       ShapeStatsBoxBottomPlayer;

// Server box
var config ColorRGBA ServerNameBoxColor;
var config ColorRGBA ServerNameTextColor;

// Game info box
var config ColorRGBA GameInfoBoxColor;
var config ColorRGBA GameInfoTextColor;

// Wave info box
var config ColorRGBA WaveBoxColor;
var config ColorRGBA WaveTextColor;

// Player count box
var config ColorRGBA PlayerCountBoxColor;
var config ColorRGBA PlayerCountTextColor;

// Header box
var config ColorRGBA ListHeaderBoxColor;
var config ColorRGBA ListHeaderTextColor;

// State box
var config ColorRGBA StateBoxColorLobby;
var config ColorRGBA StateBoxColorReady;
var config ColorRGBA StateBoxColorNotReady;
var config ColorRGBA StateBoxColorSpectator;
var config ColorRGBA StateBoxColorDead;
var config ColorRGBA StateBoxColorNone;
var config ColorRGBA StateBoxColorHealthLow;
var config ColorRGBA StateBoxColorHealthMid;
var config ColorRGBA StateBoxColorHealthHigh;
var config ColorRGBA StateBoxColorArmorLow;
var config ColorRGBA StateBoxColorArmorMid;
var config ColorRGBA StateBoxColorArmorHigh;
var config ColorRGBA StateBoxColorArmorNone;

// Player box
var config ColorRGBA PlayerOwnerBoxColor;
var config ColorRGBA PlayerBoxColor;

// Stats box
var config ColorRGBA StatsOwnerBoxColor;
var config ColorRGBA StatsBoxColor;

// State text
var config ColorRGBA StateTextColorLobby;
var config ColorRGBA StateTextColorReady;
var config ColorRGBA StateTextColorNotReady;
var config ColorRGBA StateTextColorSpectator;
var config ColorRGBA StateTextColorDead;
var config ColorRGBA StateTextColorNone;
var config ColorRGBA StateTextColorHealthLow;
var config ColorRGBA StateTextColorHealthMid;
var config ColorRGBA StateTextColorHealthHigh;
var config ColorRGBA StateTextColorArmorLow;
var config ColorRGBA StateTextColorArmorMid;
var config ColorRGBA StateTextColorArmorHigh;
var config ColorRGBA StateTextColorArmorNone;

// Rank text
var config ColorRGBA RankTextColor;

// Player text
var config ColorRGBA PlayerNameTextColor;

// Level text
var config ColorRGBA LevelTextColorLow;
var config ColorRGBA LevelTextColorMid;
var config ColorRGBA LevelTextColorHigh;

// Perk text
var config ColorRGBA ZedTextColor;
var config ColorRGBA PerkNoneTextColor;
var config ColorRGBA PerkBerserkerTextColor;
var config ColorRGBA PerkCommandoTextColor;
var config ColorRGBA PerkSupportTextColor;
var config ColorRGBA PerkFieldMedicTextColor;
var config ColorRGBA PerkDemolitionistTextColor;
var config ColorRGBA PerkFirebugTextColor;
var config ColorRGBA PerkGunslingerTextColor;
var config ColorRGBA PerkSharpshooterTextColor;
var config ColorRGBA PerkSwatTextColor;
var config ColorRGBA PerkSurvivalistTextColor;

// Dosh text
var config ColorRGBA DoshTextColorLow;
var config ColorRGBA DoshTextColorMid;
var config ColorRGBA DoshTextColorHigh;

// Kills text
var config ColorRGBA KillsTextColorLow;
var config ColorRGBA KillsTextColorMid;
var config ColorRGBA KillsTextColorHigh;

// Assists text
var config ColorRGBA AssistsTextColorLow;
var config ColorRGBA AssistsTextColorMid;
var config ColorRGBA AssistsTextColorHigh;

// Ping text
var config ColorRGBA PingTextColorNone;
var config ColorRGBA PingTextColorLow;
var config ColorRGBA PingTextColorMid;
var config ColorRGBA PingTextColorHigh;

// Other settings
var config bool      bShowPingBars;
var config bool      bHealthBoxSmoothColorChange;
var config bool      bArmorBoxSmoothColorChange;
var config bool      bHealthTextSmoothColorChange;
var config bool      bArmorTextSmoothColorChange;
var config bool      bLevelTextSmoothColorChange;
var config bool      bDoshTextSmoothColorChange;
var config bool      bKillsTextSmoothColorChange;
var config bool      bAssistsTextSmoothColorChange;
var config bool      bPingTextSmoothColorChange;

public static function InitConfig(int ConfigVersion)
{
	local YASStyle DefaultStyle;
	
	`callstack_static("InitConfig");
	
	switch (ConfigVersion)
	{
		case 0:
			WriteSettings(DefaultSettings());
		
		case 1:
			default.AssistsTextColorHigh            = DefaultStyle.AssistsTextColorHigh;
			default.AssistsTextColorLow             = DefaultStyle.AssistsTextColorLow;
			default.AssistsTextColorMid             = DefaultStyle.AssistsTextColorMid;
			default.bArmorBoxSmoothColorChange      = DefaultStyle.ArmorBoxSmoothColorChange;
			default.bArmorTextSmoothColorChange     = DefaultStyle.ArmorTextSmoothColorChange;
			default.bAssistsTextSmoothColorChange   = DefaultStyle.AssistsTextSmoothColorChange;
			default.bDoshTextSmoothColorChange      = DefaultStyle.DoshTextSmoothColorChange;
			default.bHealthBoxSmoothColorChange     = DefaultStyle.HealthBoxSmoothColorChange;
			default.bHealthTextSmoothColorChange    = DefaultStyle.HealthTextSmoothColorChange;
			default.bKillsTextSmoothColorChange     = DefaultStyle.KillsTextSmoothColorChange;
			default.bLevelTextSmoothColorChange     = DefaultStyle.LevelTextSmoothColorChange;
			default.bPingTextSmoothColorChange      = DefaultStyle.PingTextSmoothColorChange;
			default.bShowPingBars                   = DefaultStyle.ShowPingBars;
			default.DoshTextColorHigh               = DefaultStyle.DoshTextColorHigh;
			default.DoshTextColorLow                = DefaultStyle.DoshTextColorLow;
			default.DoshTextColorMid                = DefaultStyle.DoshTextColorMid;
			default.KillsTextColorHigh              = DefaultStyle.KillsTextColorHigh;
			default.KillsTextColorLow               = DefaultStyle.KillsTextColorLow;
			default.KillsTextColorMid               = DefaultStyle.KillsTextColorMid;
			default.LevelTextColorHigh              = DefaultStyle.LevelTextColorHigh;
			default.LevelTextColorLow               = DefaultStyle.LevelTextColorLow;
			default.LevelTextColorMid               = DefaultStyle.LevelTextColorMid;
			default.PerkBerserkerTextColor          = DefaultStyle.PerkBerserkerTextColor;
			default.PerkCommandoTextColor           = DefaultStyle.PerkCommandoTextColor;
			default.PerkDemolitionistTextColor      = DefaultStyle.PerkDemolitionistTextColor;
			default.PerkFieldMedicTextColor         = DefaultStyle.PerkFieldMedicTextColor;
			default.PerkFirebugTextColor            = DefaultStyle.PerkFirebugTextColor;
			default.PerkGunslingerTextColor         = DefaultStyle.PerkGunslingerTextColor;
			default.PerkNoneTextColor               = DefaultStyle.PerkNoneTextColor;
			default.PerkSharpshooterTextColor       = DefaultStyle.PerkSharpshooterTextColor;
			default.PerkSupportTextColor            = DefaultStyle.PerkSupportTextColor;
			default.PerkSurvivalistTextColor        = DefaultStyle.PerkSurvivalistTextColor;
			default.PerkSwatTextColor               = DefaultStyle.PerkSwatTextColor;
			default.StateBoxColorArmorHigh          = DefaultStyle.StateBoxColorArmorHigh;
			default.StateBoxColorArmorLow           = DefaultStyle.StateBoxColorArmorLow;
			default.StateBoxColorArmorMid           = DefaultStyle.StateBoxColorArmorMid;
			default.StateBoxColorArmorNone          = DefaultStyle.StateBoxColorArmorNone;
			default.StateBoxColorDead               = DefaultStyle.StateBoxColorDead;
			default.StateBoxColorNone               = DefaultStyle.StateBoxColorNone;
			default.StateBoxColorHealthHigh         = DefaultStyle.StateBoxColorHealthHigh;
			default.StateBoxColorHealthLow          = DefaultStyle.StateBoxColorHealthLow;
			default.StateBoxColorHealthMid          = DefaultStyle.StateBoxColorHealthMid;
			default.StateBoxColorLobby              = DefaultStyle.StateBoxColorLobby;
			default.StateBoxColorNotReady           = DefaultStyle.StateBoxColorNotReady;
			default.StateBoxColorReady              = DefaultStyle.StateBoxColorReady;
			default.StateBoxColorSpectator          = DefaultStyle.StateBoxColorSpectator;
			default.StateTextColorArmorHigh         = DefaultStyle.StateTextColorArmorHigh;
			default.StateTextColorArmorLow          = DefaultStyle.StateTextColorArmorLow;
			default.StateTextColorArmorMid          = DefaultStyle.StateTextColorArmorMid;
			default.StateTextColorArmorNone         = DefaultStyle.StateTextColorArmorNone;
			default.StateTextColorNone              = DefaultStyle.StateTextColorNone;
			default.StateTextColorHealthHigh        = DefaultStyle.StateTextColorHealthHigh;
			default.StateTextColorHealthLow         = DefaultStyle.StateTextColorHealthLow;
			default.StateTextColorHealthMid         = DefaultStyle.StateTextColorHealthMid;
			default.StatsOwnerBoxColor              = DefaultStyle.StatsOwnerBoxColor;
			default.ShapeStateHealthBoxTopPlayer    = DefaultStyle.ShapeStateHealthBoxTopPlayer;
			default.ShapeStateHealthBoxMidPlayer    = DefaultStyle.ShapeStateHealthBoxMidPlayer;
			default.ShapeStateHealthBoxBottomPlayer = DefaultStyle.ShapeStateHealthBoxBottomPlayer;
			default.ShapeStateArmorBoxTopPlayer     = DefaultStyle.ShapeStateArmorBoxTopPlayer;
			default.ShapeStateArmorBoxMidPlayer     = DefaultStyle.ShapeStateArmorBoxMidPlayer;
			default.ShapeStateArmorBoxBottomPlayer  = DefaultStyle.ShapeStateArmorBoxBottomPlayer;
			default.PingTextColorNone               = DefaultStyle.PingTextColorNone;
			
			WriteSettings(Settings());
		
		case 2147483647:
			StaticSaveConfig();
	}
}

public static function YASStyle DefaultSettings()
{
	local YASStyle Settings;
	
	`callstack_static("DefaultSettings");
	
	return Settings;
}

public static function YASStyle Settings()
{
	local YASStyle Settings;
	
	`callstack_static("Settings");
	
	// Box shapes
	Settings.EdgeSize                        = default.EdgeSize;
	Settings.ShapeServerNameBox              = default.ShapeServerNameBox;
	Settings.ShapeGameInfoBox                = default.ShapeGameInfoBox;
	Settings.ShapeWaveInfoBox                = default.ShapeWaveInfoBox;
	Settings.ShapePlayersCountBox            = default.ShapePlayersCountBox;
	Settings.ShapeHeaderBox                  = default.ShapeHeaderBox;
	Settings.ShapeStateHealthBoxTopPlayer    = default.ShapeStateHealthBoxTopPlayer;
	Settings.ShapeStateHealthBoxMidPlayer    = default.ShapeStateHealthBoxMidPlayer;
	Settings.ShapeStateHealthBoxBottomPlayer = default.ShapeStateHealthBoxBottomPlayer;
	Settings.ShapeStateArmorBoxTopPlayer     = default.ShapeStateArmorBoxTopPlayer;
	Settings.ShapeStateArmorBoxMidPlayer     = default.ShapeStateArmorBoxMidPlayer;
	Settings.ShapeStateArmorBoxBottomPlayer  = default.ShapeStateArmorBoxBottomPlayer;
	Settings.ShapePlayerBoxTopPlayer         = default.ShapePlayerBoxTopPlayer;
	Settings.ShapePlayerBoxMidPlayer         = default.ShapePlayerBoxMidPlayer;
	Settings.ShapePlayerBoxBottomPlayer      = default.ShapePlayerBoxBottomPlayer;
	Settings.ShapeStatsBoxTopPlayer          = default.ShapeStatsBoxTopPlayer;
	Settings.ShapeStatsBoxMidPlayer          = default.ShapeStatsBoxMidPlayer;
	Settings.ShapeStatsBoxBottomPlayer       = default.ShapeStatsBoxBottomPlayer;

	// Server box
	Settings.ServerNameBoxColor              = default.ServerNameBoxColor;
	Settings.ServerNameTextColor             = default.ServerNameTextColor;

	// Game info box
	Settings.GameInfoBoxColor                = default.GameInfoBoxColor;
	Settings.GameInfoTextColor               = default.GameInfoTextColor;

	// Wave info box
	Settings.WaveBoxColor                    = default.WaveBoxColor;
	Settings.WaveTextColor                   = default.WaveTextColor;

	// Player count box
	Settings.PlayerCountBoxColor             = default.PlayerCountBoxColor;
	Settings.PlayerCountTextColor            = default.PlayerCountTextColor;

	// Header box
	Settings.ListHeaderBoxColor              = default.ListHeaderBoxColor;
	Settings.ListHeaderTextColor             = default.ListHeaderTextColor;

	// State box
	Settings.StateBoxColorLobby              = default.StateBoxColorLobby;
	Settings.StateBoxColorReady              = default.StateBoxColorReady;
	Settings.StateBoxColorNotReady           = default.StateBoxColorNotReady;
	Settings.StateBoxColorSpectator          = default.StateBoxColorSpectator;
	Settings.StateBoxColorDead               = default.StateBoxColorDead;
	Settings.StateBoxColorNone               = default.StateBoxColorNone;
	Settings.StateBoxColorHealthLow          = default.StateBoxColorHealthLow;
	Settings.StateBoxColorHealthMid          = default.StateBoxColorHealthMid;
	Settings.StateBoxColorHealthHigh         = default.StateBoxColorHealthHigh;
	Settings.StateBoxColorArmorLow           = default.StateBoxColorArmorLow;
	Settings.StateBoxColorArmorMid           = default.StateBoxColorArmorMid;
	Settings.StateBoxColorArmorHigh          = default.StateBoxColorArmorHigh;
	Settings.StateBoxColorArmorNone          = default.StateBoxColorArmorNone;

	// Player box
	Settings.PlayerOwnerBoxColor             = default.PlayerOwnerBoxColor;
	Settings.PlayerBoxColor                  = default.PlayerBoxColor;

	// Stats box
	Settings.StatsOwnerBoxColor              = default.StatsOwnerBoxColor;
	Settings.StatsBoxColor                   = default.StatsBoxColor;

	// State text
	Settings.StateTextColorLobby             = default.StateTextColorLobby;
	Settings.StateTextColorReady             = default.StateTextColorReady;
	Settings.StateTextColorNotReady          = default.StateTextColorNotReady;
	Settings.StateTextColorSpectator         = default.StateTextColorSpectator;
	Settings.StateTextColorDead              = default.StateTextColorDead;
	Settings.StateTextColorNone              = default.StateTextColorNone;
	Settings.StateTextColorHealthLow         = default.StateTextColorHealthLow;
	Settings.StateTextColorHealthMid         = default.StateTextColorHealthMid;
	Settings.StateTextColorHealthHigh        = default.StateTextColorHealthHigh;
	Settings.StateTextColorArmorLow          = default.StateTextColorArmorLow;
	Settings.StateTextColorArmorMid          = default.StateTextColorArmorMid;
	Settings.StateTextColorArmorHigh         = default.StateTextColorArmorHigh;
	Settings.StateTextColorArmorNone         = default.StateTextColorArmorNone;

	// Rank text
	Settings.RankTextColor                   = default.RankTextColor;

	// Player text
	Settings.PlayerNameTextColor             = default.PlayerNameTextColor;

	// Level text
	Settings.LevelTextColorLow               = default.LevelTextColorLow;
	Settings.LevelTextColorMid               = default.LevelTextColorMid;
	Settings.LevelTextColorHigh              = default.LevelTextColorHigh;

	// Perk text
	Settings.ZedTextColor                    = default.ZedTextColor;
	Settings.PerkNoneTextColor               = default.PerkNoneTextColor;
	Settings.PerkBerserkerTextColor          = default.PerkBerserkerTextColor;
	Settings.PerkCommandoTextColor           = default.PerkCommandoTextColor;
	Settings.PerkSupportTextColor            = default.PerkSupportTextColor;
	Settings.PerkFieldMedicTextColor         = default.PerkFieldMedicTextColor;
	Settings.PerkDemolitionistTextColor      = default.PerkDemolitionistTextColor;
	Settings.PerkFirebugTextColor            = default.PerkFirebugTextColor;
	Settings.PerkGunslingerTextColor         = default.PerkGunslingerTextColor;
	Settings.PerkSharpshooterTextColor       = default.PerkSharpshooterTextColor;
	Settings.PerkSwatTextColor               = default.PerkSwatTextColor;
	Settings.PerkSurvivalistTextColor        = default.PerkSurvivalistTextColor;

	// Dosh text
	Settings.DoshTextColorLow                = default.DoshTextColorLow;
	Settings.DoshTextColorMid                = default.DoshTextColorMid;
	Settings.DoshTextColorHigh               = default.DoshTextColorHigh;

	// Kills text
	Settings.KillsTextColorLow               = default.KillsTextColorLow;
	Settings.KillsTextColorMid               = default.KillsTextColorMid;
	Settings.KillsTextColorHigh              = default.KillsTextColorHigh;

	// Assists text
	Settings.AssistsTextColorLow             = default.AssistsTextColorLow;
	Settings.AssistsTextColorMid             = default.AssistsTextColorMid;
	Settings.AssistsTextColorHigh            = default.AssistsTextColorHigh;

	// Ping text
	Settings.PingTextColorNone               = default.PingTextColorNone;
	Settings.PingTextColorLow                = default.PingTextColorLow;
	Settings.PingTextColorMid                = default.PingTextColorMid;
	Settings.PingTextColorHigh               = default.PingTextColorHigh;
	
	// Other settings
	Settings.ShowPingBars                    = default.bShowPingBars;
	Settings.HealthBoxSmoothColorChange      = default.bHealthBoxSmoothColorChange;
	Settings.ArmorBoxSmoothColorChange       = default.bArmorBoxSmoothColorChange;
	Settings.HealthTextSmoothColorChange     = default.bHealthTextSmoothColorChange;
	Settings.ArmorTextSmoothColorChange      = default.bArmorTextSmoothColorChange;
	Settings.LevelTextSmoothColorChange      = default.bLevelTextSmoothColorChange;
	Settings.DoshTextSmoothColorChange       = default.bDoshTextSmoothColorChange;
	Settings.KillsTextSmoothColorChange      = default.bKillsTextSmoothColorChange;
	Settings.AssistsTextSmoothColorChange    = default.bAssistsTextSmoothColorChange;
	Settings.PingTextSmoothColorChange       = default.bPingTextSmoothColorChange;

	return Settings;
}

public static function WriteSettings(YASStyle Settings)
{
	`callstack_static("WriteSettings");
	
	// Box shapes
	default.EdgeSize                        = Settings.EdgeSize;
	default.ShapeServerNameBox              = Settings.ShapeServerNameBox;
	default.ShapeGameInfoBox                = Settings.ShapeGameInfoBox;
	default.ShapeWaveInfoBox                = Settings.ShapeWaveInfoBox;
	default.ShapePlayersCountBox            = Settings.ShapePlayersCountBox;
	default.ShapeHeaderBox                  = Settings.ShapeHeaderBox;
	default.ShapeStateHealthBoxTopPlayer    = Settings.ShapeStateHealthBoxTopPlayer;
	default.ShapeStateHealthBoxMidPlayer    = Settings.ShapeStateHealthBoxMidPlayer;
	default.ShapeStateHealthBoxBottomPlayer = Settings.ShapeStateHealthBoxBottomPlayer;
	default.ShapeStateArmorBoxTopPlayer     = Settings.ShapeStateArmorBoxTopPlayer;
	default.ShapeStateArmorBoxMidPlayer     = Settings.ShapeStateArmorBoxMidPlayer;
	default.ShapeStateArmorBoxBottomPlayer  = Settings.ShapeStateArmorBoxBottomPlayer;
	default.ShapePlayerBoxTopPlayer         = Settings.ShapePlayerBoxTopPlayer;
	default.ShapePlayerBoxMidPlayer         = Settings.ShapePlayerBoxMidPlayer;
	default.ShapePlayerBoxBottomPlayer      = Settings.ShapePlayerBoxBottomPlayer;
	default.ShapeStatsBoxTopPlayer          = Settings.ShapeStatsBoxTopPlayer;
	default.ShapeStatsBoxMidPlayer          = Settings.ShapeStatsBoxMidPlayer;
	default.ShapeStatsBoxBottomPlayer       = Settings.ShapeStatsBoxBottomPlayer;

	// Server box
	default.ServerNameBoxColor              = Settings.ServerNameBoxColor;
	default.ServerNameTextColor             = Settings.ServerNameTextColor;

	// Game info box
	default.GameInfoBoxColor                = Settings.GameInfoBoxColor;
	default.GameInfoTextColor               = Settings.GameInfoTextColor;

	// Wave info box
	default.WaveBoxColor                    = Settings.WaveBoxColor;
	default.WaveTextColor                   = Settings.WaveTextColor;

	// Player count box
	default.PlayerCountBoxColor             = Settings.PlayerCountBoxColor;
	default.PlayerCountTextColor            = Settings.PlayerCountTextColor;

	// Header box
	default.ListHeaderBoxColor              = Settings.ListHeaderBoxColor;
	default.ListHeaderTextColor             = Settings.ListHeaderTextColor;

	// State box
	default.StateBoxColorLobby              = Settings.StateBoxColorLobby;
	default.StateBoxColorReady              = Settings.StateBoxColorReady;
	default.StateBoxColorNotReady           = Settings.StateBoxColorNotReady;
	default.StateBoxColorSpectator          = Settings.StateBoxColorSpectator;
	default.StateBoxColorDead               = Settings.StateBoxColorDead;
	default.StateBoxColorNone               = Settings.StateBoxColorNone;
	default.StateBoxColorHealthLow          = Settings.StateBoxColorHealthLow;
	default.StateBoxColorHealthMid          = Settings.StateBoxColorHealthMid;
	default.StateBoxColorHealthHigh         = Settings.StateBoxColorHealthHigh;
	default.StateBoxColorArmorLow           = Settings.StateBoxColorArmorLow;
	default.StateBoxColorArmorMid           = Settings.StateBoxColorArmorMid;
	default.StateBoxColorArmorHigh          = Settings.StateBoxColorArmorHigh;
	default.StateBoxColorArmorNone          = Settings.StateBoxColorArmorNone;

	// Player box
	default.PlayerOwnerBoxColor             = Settings.PlayerOwnerBoxColor;
	default.PlayerBoxColor                  = Settings.PlayerBoxColor;

	// Stats box
	default.StatsOwnerBoxColor              = Settings.StatsOwnerBoxColor;
	default.StatsBoxColor                   = Settings.StatsBoxColor;

	// State text
	default.StateTextColorLobby             = Settings.StateTextColorLobby;
	default.StateTextColorReady             = Settings.StateTextColorReady;
	default.StateTextColorNotReady          = Settings.StateTextColorNotReady;
	default.StateTextColorSpectator         = Settings.StateTextColorSpectator;
	default.StateTextColorDead              = Settings.StateTextColorDead;
	default.StateTextColorNone              = Settings.StateTextColorNone;
	default.StateTextColorHealthLow         = Settings.StateTextColorHealthLow;
	default.StateTextColorHealthMid         = Settings.StateTextColorHealthMid;
	default.StateTextColorHealthHigh        = Settings.StateTextColorHealthHigh;
	default.StateTextColorArmorLow          = Settings.StateTextColorArmorLow;
	default.StateTextColorArmorMid          = Settings.StateTextColorArmorMid;
	default.StateTextColorArmorHigh         = Settings.StateTextColorArmorHigh;
	default.StateTextColorArmorNone         = Settings.StateTextColorArmorNone;

	// Rank text
	default.RankTextColor                   = Settings.RankTextColor;

	// Player text
	default.PlayerNameTextColor             = Settings.PlayerNameTextColor;

	// Level text
	default.LevelTextColorLow               = Settings.LevelTextColorLow;
	default.LevelTextColorMid               = Settings.LevelTextColorMid;
	default.LevelTextColorHigh              = Settings.LevelTextColorHigh;

	// Perk text
	default.ZedTextColor                    = Settings.ZedTextColor;
	default.PerkNoneTextColor               = Settings.PerkNoneTextColor;
	default.PerkBerserkerTextColor          = Settings.PerkBerserkerTextColor;
	default.PerkCommandoTextColor           = Settings.PerkCommandoTextColor;
	default.PerkSupportTextColor            = Settings.PerkSupportTextColor;
	default.PerkFieldMedicTextColor         = Settings.PerkFieldMedicTextColor;
	default.PerkDemolitionistTextColor      = Settings.PerkDemolitionistTextColor;
	default.PerkFirebugTextColor            = Settings.PerkFirebugTextColor;
	default.PerkGunslingerTextColor         = Settings.PerkGunslingerTextColor;
	default.PerkSharpshooterTextColor       = Settings.PerkSharpshooterTextColor;
	default.PerkSwatTextColor               = Settings.PerkSwatTextColor;
	default.PerkSurvivalistTextColor        = Settings.PerkSurvivalistTextColor;

	// Dosh text
	default.DoshTextColorLow                = Settings.DoshTextColorLow;
	default.DoshTextColorMid                = Settings.DoshTextColorMid;
	default.DoshTextColorHigh               = Settings.DoshTextColorHigh;

	// Kills text
	default.KillsTextColorLow               = Settings.KillsTextColorLow;
	default.KillsTextColorMid               = Settings.KillsTextColorMid;
	default.KillsTextColorHigh              = Settings.KillsTextColorHigh;

	// Assists text
	default.AssistsTextColorLow             = Settings.AssistsTextColorLow;
	default.AssistsTextColorMid             = Settings.AssistsTextColorMid;
	default.AssistsTextColorHigh            = Settings.AssistsTextColorHigh;

	// Ping text
	default.PingTextColorNone               = Settings.PingTextColorNone;
	default.PingTextColorLow                = Settings.PingTextColorLow;
	default.PingTextColorMid                = Settings.PingTextColorMid;
	default.PingTextColorHigh               = Settings.PingTextColorHigh;
	
	// Other settings
	default.bShowPingBars                   = Settings.ShowPingBars;
	default.bHealthBoxSmoothColorChange     = Settings.HealthBoxSmoothColorChange;
	default.bArmorBoxSmoothColorChange      = Settings.ArmorBoxSmoothColorChange;
	default.bHealthTextSmoothColorChange    = Settings.HealthTextSmoothColorChange;
	default.bArmorTextSmoothColorChange     = Settings.ArmorTextSmoothColorChange;
	default.bLevelTextSmoothColorChange     = Settings.LevelTextSmoothColorChange;
	default.bDoshTextSmoothColorChange      = Settings.DoshTextSmoothColorChange;
	default.bKillsTextSmoothColorChange     = Settings.KillsTextSmoothColorChange;
	default.bAssistsTextSmoothColorChange   = Settings.AssistsTextSmoothColorChange;
	default.bPingTextSmoothColorChange      = Settings.PingTextSmoothColorChange;
}

defaultProperties
{

}