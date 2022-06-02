class SettingsPing extends Object
	dependson(Types)
	config(YAS);

`include(Build.uci)
`include(Logger.uci)

var config int Low;
var config int High;

public static function InitConfig(int ConfigVersion)
{
	`callstack_static("InitConfig");
	
	switch (ConfigVersion)
	{
		case 0:
		case 1:
			WriteSettings(DefaultSettings());
			
		case 2147483647:
			StaticSaveConfig();
	}
}

public static function YASSettingsPing DefaultSettings()
{
	local YASSettingsPing Settings;
	
	`callstack_static("DefaultSettings");
	
	return Settings;
}

public static function YASSettingsPing Settings()
{
	local YASSettingsPing Settings;
	
	`callstack_static("Settings");
	
	Settings.Low  = default.Low;
	Settings.High = default.High;
	
	return Settings;
}

public static function WriteSettings(YASSettingsPing Settings)
{
	`callstack_static("WriteSettings");
	
	default.Low  = Settings.Low;
	default.High = Settings.High;
}

DefaultProperties
{

}