class BanDataSyncPager extends TcpLink;
 
var string TargetHost; //URL or P address of web server
var int TargetPort; //port you want to use for the link
var string path; //path to file you want to request
var string params;
var string message;
var JsonObject jsonBans;

var int maxPage;
var AccessPlus accessControl;

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
        `Log("[UAC] Failed to get page data...");
    }
}
event ResolveFailed()
{
    `Log("[UAC] Unable to get page data...");
}
event Opened()
{
    local string sendStr;

    sendStr = "GET /"$params$"&page=-1 HTTP/1.1"
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
    local BanDataSync banDataGet;
    local int idx;
    local int i;
    local string split;

    split = "{";
    idx = InStr(message, split);

    if (Idx != -1)
    {
        message = Mid(message,Idx, Len(message));
        message -= " ";
    }

    if (!parseBans(message))
    {
        `Log("[UAC] Failed to parse page data...");
    }
    else 
    {
        `Log("[UAC] Get "$maxPage$" pages of data!");
        if (maxPage > 0)
        {
            for (i = 1; i <= maxPage; i ++)
            {
                banDataGet = Spawn(class'BanDataSync');
                banDataGet.accessControl = accessControl;
                banDataGet.TargetHost = TargetHost;
                banDataGet.TargetPort = TargetPort;
                banDataGet.params = params;
                banDataGet.currentPage = i;
                banDataGet.startSync();
            }
        }
    }
}
function bool parseBans(string data)
{
    local JsonObject jsonObj;

    jsonObj = class'JsonObject'.static.DecodeJson(data);

    if (jsonObj == None)
    {
        return false;
    }

    maxPage = jsonObj.GetIntValue("maxpage");

    if (maxPage <= 0)
    {
        return false;
    }

    return true;
}