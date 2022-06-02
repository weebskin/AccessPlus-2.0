class PlayerRankRelations extends Object
	dependson(Types)
	config(YAS);

`include(Build.uci)
`include(Logger.uci)

var config array<RankRelation> Relation;

public static function InitConfig(int ConfigVersion)
{
	local RankRelation ExamplePlayer;
	
	`callstack_static("InitConfig");
	
	switch (ConfigVersion)
	{
		case 0:
			// Example player
			ExamplePlayer.ObjectID = "76561198001617867"; // GenZmeY SteamID64
			ExamplePlayer.RankID   = 0;
			default.Relation.AddItem(ExamplePlayer);
				
		case 2147483647:
			StaticSaveConfig();
	}
}

DefaultProperties
{

}