Class AccessPlusBans extends Object;

const MAX_BANLOGSIZE=30;

struct FBanEntry
{
	var string ID,IP,N,R,A,NT; // ID=ClientID,IP=ClientIP,N=PlayerName,R=Reason,A=AdminName,NT=BanNotes
	var int T,IX; // T=MinutesRemain,IX=BanID
};
var array<FBanEntry> BE;
var array<string> BL;
var int STG,BID;
var transient int StartTime,TempStartTime;
var transient bool bDirty;

final function int InitStartTime()
{
	StartTime = GetTimeMinutes();
	return StartTime;
}
final function UpdateTempTime()
{
	TempStartTime = GetTimeMinutes();
}

final function AddLogLine( string S )
{
	local int Y,M,DW,D,H,Min,Sec,MSec;

	GetSystemTime(Y,M,DW,D,H,Min,Sec,MSec);
	S = "["$Y$"/"$M$"/"$D$" "$H$":"$Min$"] "$S;
	BL.Insert(0,1);
	BL[0] = S;
	if( BL.Length>MAX_BANLOGSIZE )
		BL.Length = MAX_BANLOGSIZE;
}
final function string GetFullNotes( int i )
{
	return BE[i].NT;
}

final function string GetBanTimeStr( int i )
{
	if( BE[i].T==-2 )
		return "EXPIRED";
	if( BE[i].T==-1 )
		return "forever";
	i = BE[i].T-StartTime;
	if( i<60 )
		return string(Max(i,1))$" minutes";
	return string((i+30)/60)$" hours"; // Adding 30 mins to round up.
}
final function string WEBGetBanTime( int i )
{
	if( BE[i].T<0 )
		return string(BE[i].T);
	i = BE[i].T-TempStartTime;
	if( i<=0 )
		return "0";
	return string((i+59)/60); // Adding 59 mins to round up.
}
final function string WEBGetBanTimeStr( int i )
{
	if( BE[i].T==-2 )
		return "EXPIRED";
	if( BE[i].T==-1 )
		return "forever";
	i = BE[i].T-TempStartTime;
	if( i<=0 )
		return "just expired!";
	return string((i+59)/60)$" hours ("$i$" mins)"; // Adding 59 mins to round up.
}
final function SetBanTime( int i, int Hours )
{
	BE[i].T = (Hours<=-1 ? -1 : (GetTimeMinutes()+Hours*60));
}

final function bool CheckBanActive( int Index )
{
	if( BE[Index].T==-2 )
		return false;
	if( BE[Index].T==-1 )
		return true;
	if( StartTime>=BE[Index].T )
	{
		AddLogLine("Ban #"$BE[Index].IX$" ("$BE[Index].N$") expired.");
		BE[Index].T = -2;
		bDirty = true;
		return false;
	}
	return true;
}
final function bool AdvanceBans()
{
	local int i,T;

	T = -1;
	for( i=(BE.Length-1); i>=0; --i )
	{
		if( BE[i].T>=0 )
		{
			if( T==-1 )
				T = GetTimeMinutes();
			if( T>=BE[i].T )
			{
				AddLogLine("Ban #"$BE[i].IX$" ("$BE[i].N$") expired.");
				BE[i].T = -2;
				bDirty = true;
			}
		}
	}
	return bDirty;
}
final function int GetTimeMinutes()
{
	local int Y,M,DW,D,H,Min,Sec,MSec;

	GetSystemTime(Y,M,DW,D,H,Min,Sec,MSec);
	return (Min + (H*60) + (GetDaysPassed(D,M,Y)*1440) + ((Y-2015)*525960));
}
// Helper function, get number of days passed this year.
final function int GetDaysPassed( int D, int M, int Y )
{
	local bool bLeap;
	
	bLeap = (Y & 4)!=0;
	Y = 0;
	switch( M )
	{
	case 1:
		Y = 0;
		break;
	case 12:
		Y += 30;
	case 11:
		Y += 31;
	case 10:
		Y += 30;
	case 9:
		Y += 31;
	case 8:
		Y += 31;
	case 7:
		Y += 30;
	case 6:
		Y += 31;
	case 5:
		Y += 30;
	case 4:
		Y += 31;
	case 3:
		Y += (bLeap ? 29 : 28);
	case 2:
		Y += 31;
		break;
	}
	return (D+Y);
}
