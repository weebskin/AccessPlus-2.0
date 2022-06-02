class AccessBroadcast extends BroadcastHandler;

var AccessPlus AccessController;
var BroadcastHandler NextBroadcaster;

function PostBeginPlay()
{
	NextBroadcaster = WorldInfo.Game.BroadcastHandler;
	WorldInfo.Game.BroadcastHandler = Self;
}

function UpdateSentText()
{
	NextBroadcaster.UpdateSentText();
}

final function bool UserMuted( PlayerController PC )
{
	return (PC.PlayerReplicationInfo!=None && AccessController.MutedPlayers.Find('Uid',PC.PlayerReplicationInfo.UniqueId.Uid)>=0);
}

function Broadcast( Actor Sender, coerce string Msg, optional name Type )
{
	if( (Type=='Say' || Type=='TeamSay') && PlayerController(Sender)!=None && UserMuted(PlayerController(Sender)) )
		return;
	NextBroadcaster.Broadcast(Sender,Msg,Type);
}

function BroadcastTeam( Controller Sender, coerce string Msg, optional name Type )
{
	if( (Type=='Say' || Type=='TeamSay') && PlayerController(Sender)!=None && UserMuted(PlayerController(Sender)) )
		return;
	NextBroadcaster.BroadcastTeam(Sender,Msg,Type);
}

function AllowBroadcastLocalized( actor Sender, class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject )
{
	if( Message==class'KFLocalMessage_VoiceComms' && PlayerController(Sender)!=None && UserMuted(PlayerController(Sender)) )
		return;
	NextBroadcaster.AllowBroadcastLocalized(Sender,Message,Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject);
}

event AllowBroadcastLocalizedTeam( int TeamIndex, actor Sender, class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject )
{
	NextBroadcaster.AllowBroadcastLocalizedTeam(TeamIndex,Sender,Message,Switch,RelatedPRI_1,RelatedPRI_2,OptionalObject);
}

defaultproperties
{
}