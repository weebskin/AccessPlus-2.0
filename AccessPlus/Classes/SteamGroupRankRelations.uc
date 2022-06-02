class SteamGroupRankRelations extends Object
	dependson(Types)
	config(YAS);

`include(Build.uci)
`include(Logger.uci)

var config array<RankRelation> Relation;

public static function InitConfig(int ConfigVersion)
{
	local RankRelation ExampleSteamGroup;
	
	`callstack_static("InitConfig");
	
	switch (ConfigVersion)
	{
		case 0:
			// Example steam group
			ExampleSteamGroup.ObjectID = "103582791465384046"; // MSK-GS SteamID64
			ExampleSteamGroup.RankID   = 1;
			default.Relation.AddItem(ExampleSteamGroup);
				
		case 2147483647:
			StaticSaveConfig();
	}
}

DefaultProperties
{

}