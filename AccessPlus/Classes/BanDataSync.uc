class BanDataSync extends TcpLink;
 
var string TargetHost; //URL or P address of web server
var int TargetPort; //port you want to use for the link
var string path; //path to file you want to request
var string params;
var string message;
var JsonObject jsonBans;
var AccessPlus accessControl;
var int currentPage;

event PostBeginPlay()
{
    super.PostBeginPlay();
}
function startSync()
{
    Resolve(TargetHost);
}
event Resolved( IpAddr Addr )
{
    Addr.Port = TargetPort;
    `Log("[UAC] Bound to port: "$BindPort());
    if (!Open(Addr))
    {
        `Log("[UAC] Failed to get blocked data(page "$currentPage$")...");
    }
}
event ResolveFailed()
{
    `Log("[UAC] Unable to synchronize blocked data(page "$currentPage$")...");
}
event Opened()
{
    local string sendStr;

    sendStr = "GET /"$params$"&page="$currentPage$" HTTP/1.1"
    $chr(13)$chr(10)
    $"Host: "$TargetHost
    $chr(13)$chr(10)
    $"Connection: Close"
    $chr(13)$chr(10)$chr(13)$chr(10);

    SendText(sendStr);
}
event ReceivedText( string Text )
{
    message = message$Text;
}
event Closed()
{
    local int idx;
    local string split;

    split = "{";
    idx = InStr(message, split);

    if (Idx != -1)
    {
        message = Mid(message,Idx, Len(message));
        message -= " ";
    }

    if (parseBans(message)){
        applyBansTo();
    } else {
        `Log("[UAC] Failed to parse blocked data(page "$currentPage$")...");
    }
    `Log("[UAC] Succeeded in synchronizing blocked data(page "$currentPage$")!");
}
function bool parseBans(string data)
{
    local JsonObject jsonObj;

    jsonBans = class'JsonObject'.static.DecodeJson(data);
    if (jsonBans == None)
    {
        return false;
    }

    jsonBans = jsonBans.GetObject("bans");
    if (jsonBans == none)
    {
        return false;
    }

    foreach jsonBans.ObjectArray(jsonObj)
    {
        if (jsonObj.HasKey("steamId64") )
        {
            return true;
        }
    }
    return false;
}
function applyBansTo()
{
    local JsonObject json;
    local string tmp;
    local UniqueNetId netid;
    local string UniqueNetIdString;
    local int cnt, idx;
    local OnlineSubsystem steamWorks;
    local int i;

    accessControl.CheckBanData();
    i = accessControl.BansData.BE.Length;

    steamWorks = class'GameEngine'.static.GetOnlineSubsystem();
    foreach jsonBans.ObjectArray(json)
    {
        if (steamWorks != none) {
            tmp = json.GetStringValue("steamId64");
            tmp -= " ";
            steamWorks.Int64ToUniqueNetId(tmp, netid);
        }
        UniqueNetIdString = class'WebAdminUtils'.static.UniqueNetIdToString(netid);
        if (UniqueNetIdString == "")
        {
            // invalid id
            continue;
        }
        for (idx = 0; idx < accessControl.BansData.BE.length; ++idx)
        {
            if (accessControl.BansData.BE[idx].ID == UniqueNetIdString)
            {
                break;
            }
        }
        if (idx == accessControl.BansData.BE.length)
        {
            // does not exist yet
            accessControl.BansData.BE.Length = i+1;
            accessControl.BansData.BE[i].IX = accessControl.BansData.BID++;
            accessControl.BansData.BE[i].ID = UniqueNetIdString;
            accessControl.BansData.BE[i].IP = "0.0.0.0";
            accessControl.BansData.BE[i].N = "Cheater or Violator";
            accessControl.BansData.BE[i].R = "Cheat Or Other";
            accessControl.BansData.BE[i].T = -1;
            accessControl.BansData.BE[i].A = "(Union Anti Cheat)";
            ++cnt;
            ++i;
        }
    }
    accessControl.SaveBanData();
    `Log("[UAC] "$cnt$" blocked data were added successfully!");
    `Log("[UAC] There are now "$accessControl.BansData.BE.Length$" blocked data!");
}