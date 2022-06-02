Class AccessData extends Object;

struct FAdminAccInfo
{
	var string PL,ID,PW,UID; // Playername, GroupID, (Password), Admin userID
	var transient UniqueNetID AdminID;
	var bool NA; // Not auto-admin.
};
struct FAdminGroup
{
	var string PR,GN,ID; // Priveleges, groupname, groupID
	var byte AT; // Admin type
};
struct FAdminCommand
{
	var name CM; // Command
	var int CG;  // Command-Group index (see CG below)
};

var array<FAdminAccInfo> AU; // Admin users
var array<FAdminGroup> AG; // Admin groups
var array<FAdminCommand> AC; // Admin commands
var array<string> CG; // List of commandgroups.
var string GPW; // Global admin password

var int STG; // Save tag

final function byte GetAdminType( int Index )
{
	Index = FindAdminGroup(AU[Index].ID);
	return (Index==-1 ? 255 : AG[Index].AT);
}
final function int FindAdminGroup( string N )
{
	N = Caps(N);
	return AG.Find('ID',N);
}
final function int FindAdminUser( UniqueNetID ID )
{
	return AU.Find('AdminID',ID);
}
final function int FindAdminPW( string PW )
{
	return AU.Find('PW',PW);
}
final function ParseUIDs()
{
	local int i;
	local UniqueNetId n;
	
	for( i=0; i<AU.Length; ++i )
	{
		class'OnlineSubsystem'.Static.StringToUniqueNetId(AU[i].UID,n);
		AU[i].AdminID = n;
	}
	if( GPW=="" )
		GPW = Default.GPW;
}

defaultproperties
{
	AG(0)=(PR="All",GN="Admin",ID="ADMIN",AT=0)
	GPW="Admin"
}