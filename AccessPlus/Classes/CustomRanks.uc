class CustomRanks extends Object
	dependson(Types)
	config(YAS);
	
`include(Build.uci)
`include(Logger.uci)

var config array<RankInfo> Rank;

public static function InitConfig(int ConfigVersion)
{
	local RankInfo ExampleRank;
	
	`callstack_static("InitConfig");
	
	switch (ConfigVersion)
	{
		case 0:
			// 服主
			ExampleRank.ID                              = 0;
			ExampleRank.Rank                            = "Server Master";
			ExampleRank.TextColor.R                     = 130;
			ExampleRank.TextColor.G                     = 250;
			ExampleRank.TextColor.B                     = 235;
			ExampleRank.OverrideAdminRank               = true;
			default.Rank.AddItem(ExampleRank);
			
			// VIP
			ExampleRank.ID                              = 1;
			ExampleRank.Rank                            = "VIP";
			ExampleRank.TextColor.R                     = 130;
			ExampleRank.TextColor.G                     = 250;
			ExampleRank.TextColor.B                     = 130;
			ExampleRank.OverrideAdminRank               = true;
			default.Rank.AddItem(ExampleRank);
		case 1:
			
		case 2147483647:
			StaticSaveConfig();
	}
}

DefaultProperties
{

}