Class AccessPlusWebApp extends Object implements(IQueryHandler);

var WebAdmin webadmin;
var string AccessURL;
var AccessPlus AccessControl;

var string LastUserIP;
var int EditPageNum,EditSettingLine;
var byte SubEditMode;
var bool bAccConfirmed;

function cleanup()
{
	webadmin = None;
}
function init(WebAdmin webapp)
{
	webadmin = webapp;
}
function registerMenuItems(WebAdminMenu menu)
{
	menu.addMenu(AccessURL, "Access Plus", self, "Modify AccessPlus settings.", -25);
}
function bool handleQuery(WebAdminQuery q)
{
	if( LastUserIP!=q.user.getUsername() )
	{
		LastUserIP = q.user.getUsername();
		EditSettingLine = Default.EditSettingLine;
		EditPageNum = Default.EditPageNum;
		bAccConfirmed = false;
		//`Log("Start new AccessPlus user"@LastUserIP);
	}
	switch (q.request.URI)
	{
		case AccessURL:
			handleACPlus(q);
			return true;
	}
	return false;
}

final function IncludeFile( WebAdminQuery q, string file )
{
	local string S;
	
	if( webadmin.HTMLSubDirectory!="" )
	{
		S = webadmin.Path $ "/" $ webadmin.HTMLSubDirectory $ "/" $ file;
		if ( q.response.FileExists(S) )
		{
			q.response.IncludeUHTM(S);
			return;
		}
	}
	q.response.IncludeUHTM(webadmin.Path $ "/" $ file);
}
final function SendHeader( WebAdminQuery q, string Title )
{
	local IQueryHandler handler;
	
	q.response.Subst("page.title", Title);
	q.response.Subst("page.description", "");
	foreach webadmin.handlers(handler)
	{
		handler.decoratePage(q);
	}
	q.response.Subst("messages", webadmin.renderMessages(q));
	if (q.session.getString("privilege.log") != "")
	{
		q.response.Subst("privilege.log", webadmin.renderPrivilegeLog(q));
	}
	IncludeFile(q,"header.inc");
	q.response.SendText("<div id=\"content\"><h2>"$Title$"</h2></div><div class=\"section\">");
}
final function SendFooter( WebAdminQuery q )
{
	IncludeFile(q,"navigation.inc");
	IncludeFile(q,"footer.inc");
	q.response.ClearSubst();
}

final function AddConfigCheckbox( WebAdminQuery q, string InfoStr, bool bCur, string ResponseVar, string Tooltip )
{
	local string S;
	
	S = bCur ? " checked" : "";
	S = "<TR><TD><abbr title=\""$Tooltip$"\">"$InfoStr$":</abbr></TD><TD><input type=\"checkbox\" name=\""$ResponseVar$"\" value=\"1\" "$S$"></TD></TR>";
	q.response.SendText(S);
}
final function AddConfigEditbox( WebAdminQuery q, string InfoStr, string CurVal, string ResponseVar, string Tooltip, optional bool bSkipTrail )
{
	local string S;
	
	S = "<TR><TD><abbr title=\""$Tooltip$"\">"$InfoStr$":</abbr></TD><TD><input class=\"textbox\" class=\"text\" name=\""$ResponseVar$"\" value=\""$CurVal$"\"></TD>";
	if( !bSkipTrail )
		S $= "</TR>";
	q.response.SendText(S);
}
final function AddInLineEditbox( WebAdminQuery q, string CurVal, string ResponseVar )
{
	q.response.SendText("<TD><input class=\"textbox\" class=\"text\" name=\""$ResponseVar$"\" value=\""$CurVal$"\"></TD>");
}
final function AddInLineCheckbox( WebAdminQuery q, bool bCur, string ResponseVar )
{
	q.response.SendText("<TD><input type=\"checkbox\" name=\""$ResponseVar$"\" value=\"1\" "$(bCur ? " checked" : "")$"></TD>");
}
final function AddLinkButton( WebAdminQuery q, string PageName )
{
	q.response.SendText("<tr><td><form action=\""$webadmin.Path$AccessURL$"\"><input class=\"button\" name=\"GoToPage\" type=\"submit\" value=\""$PageName$"\"></form></td></tr>");
}
final function AddTextField( WebAdminQuery q, string CurVal, int Rows, string ResponseVar )
{
	q.response.SendText("<TD><textarea name=\""$ResponseVar$"\" rows=\""$Rows$"\" cols=\"50\">"$CurVal$"</textarea></TD>");
}
final function AddAdminGroupsCombo( WebAdminQuery q, string CurVal, string ResponseVar )
{
	local int i,j;

	q.response.SendText("<TD><select name=\""$ResponseVar$"\">");
	j = AccessControl.AdminData.FindAdminGroup(CurVal);
	if( j==-1 )
		q.response.SendText("<option value=\""$CurVal$"\" selected=\"selected\">!"$CurVal$"!</option>");
	for( i=0; i<AccessControl.AdminData.AG.Length; ++i )
		q.response.SendText("<option value=\""$AccessControl.AdminData.AG[i].ID$"\""$(i==j ? " selected=\"selected\"" : "")$">"$AccessControl.AdminData.AG[i].ID$"</option>");
	q.response.SendText("</select></TD>");
}
final function AddPlayerListCombo( WebAdminQuery q, string ResponseVar )
{
	local PlayerController PC;

	q.response.SendText("<select name=\""$ResponseVar$"\">");
	q.response.SendText("<option value=\"-1\" selected=\"selected\">Select one player!</option>");
	foreach AccessControl.WorldInfo.AllControllers(class'PlayerController',PC)
		if( Admin(PC)==None && PC.PlayerReplicationInfo!=None )
			q.response.SendText("<option value=\""$PC.PlayerReplicationInfo.PlayerID$"\">"$PC.PlayerReplicationInfo.PlayerName$"</option>");
	q.response.SendText("</select>");
}
final function string IncListOption( string Value, string ValName, optional bool bSelected )
{
	return "<option value=\""$Value$"\""$(bSelected ? " selected=\"selected\"" : "")$">"$ValName$"</option>";
}
final function AddAdminGroupList( WebAdminQuery q, string CurVar, string ResponseVar )
{
	local array<string> GrpList;
	local int i;
	local bool bAll;

	ParseStringIntoArray(CurVar,GrpList,",",true);
	bAll = (GrpList.Length==1 && GrpList[0]~="All");

	q.response.SendText("<TD><select name=\""$ResponseVar$"\"  size=\"10\" multiple=\"multiple\">");
	q.response.SendText(IncListOption("-2","None",(CurVar=="")));
	q.response.SendText(IncListOption("-1","All",bAll));
	for( i=0; i<AccessControl.AdminData.CG.Length; ++i )
	{
		q.response.SendText(IncListOption(string(i),AccessControl.AdminData.CG[i],(!bAll && GrpList.Find(AccessControl.AdminData.CG[i])>=0)));
	}
	q.response.SendText("</select></TD>");
}
final function AddCommandList( WebAdminQuery q, int Index, string ResponseVar )
{
	local array<name> FullList;
	local int i;
	local name N;

	FullList = class'AdminPlusCheats'.Default.CommandList;
	
	// First exclude already used commands.
	for( i=0; i<AccessControl.AdminData.AC.Length; ++i )
		if( i!=Index )
			FullList.RemoveItem(AccessControl.AdminData.AC[i].CM);
	
	N = AccessControl.AdminData.AC[Index].CM;
	if( FullList.Length==0 ) // Set one default one.
		FullList.AddItem(N);

	q.response.SendText("<TD><select class=\"mini\" name=\""$ResponseVar$"\">");
	for( i=0; i<FullList.Length; ++i )
		q.response.SendText(IncListOption(string(FullList[i]),string(FullList[i]),FullList[i]==N));
	q.response.SendText("</select></TD>");
}
final function AddCommandGroupList( WebAdminQuery q, int Index, string ResponseVar )
{
	local int i;

	q.response.SendText("<TD><select class=\"mini\" name=\""$ResponseVar$"\">");
	Index = AccessControl.AdminData.AC[Index].CG;
	for( i=0; i<AccessControl.AdminData.CG.Length; ++i )
		q.response.SendText(IncListOption(string(i),AccessControl.AdminData.CG[i],i==Index));
	q.response.SendText(IncListOption("-1","Create new one..."));
	q.response.SendText("</select><input class=\"textbox\" class=\"text\" name=\""$ResponseVar$"X\" value=\"New Group Name\"></TD>");
}
final function string GrabGroupOutput( WebAdminQuery q, string VarName )
{
	local int i,j,n;
	local string S;
	
	j = q.request.GetVariableCount(VarName);
	for( i=0; i<j; ++i )
	{
		n = int(q.request.GetVariableNumber(VarName,i));
		if( n==-1 )
			return "All";
		if( n==-2 )
			return "";
		if( i==0 )
			S = AccessControl.AdminData.CG[n];
		else S $= ","$AccessControl.AdminData.CG[n];
	}
	return S;
}
final function int CreateNewUser( int TargetID )
{
	local PlayerController PC;

	if( TargetID<=0 )
		return -1;
	
	foreach AccessControl.WorldInfo.AllControllers(class'PlayerController',PC)
		if( Admin(PC)==None && PC.PlayerReplicationInfo!=None && PC.PlayerReplicationInfo.PlayerID==TargetID )
			return AccessControl.CreateAdminAccount(PC.PlayerReplicationInfo);
	return -1;
}
function handleACPlus(WebAdminQuery q)
{
	local string S;
	local int i,j;

	S = q.request.getVariable("GoToPage");
	if( S!="" )
	{
		switch( S )
		{
		case "Main Menu":
			EditPageNum = 0;
			break;
		case "Settings":
			EditPageNum = 1;
			break;
		case "Bans":
			EditPageNum = 2;
			break;
		case "BanLog":
			EditPageNum = 3;
			break;
		}
	}
	if( q.request.getVariable("edit")=="Submit" )
	{
		switch( EditPageNum	)
		{
		case 1:
			if( !bAccConfirmed )
			{
				bAccConfirmed = (q.request.getVariable("GP")==AccessControl.AdminData.GPW);
			}
			else
			{
				S = q.request.getVariable("NGP");
				AccessControl.CheckAdminData();
				AccessControl.AdminData.GPW = S;
				AccessControl.SaveAdminData();
				AccessControl.SaveConfig();
				
				KFGameInfo(AccessControl.WorldInfo.Game).WebsiteLink = q.request.getVariable("WB");
				AccessControl.WorldInfo.Game.SaveConfig();
			}
			break;
		case 2:
			break;
		}
	}

	switch( EditPageNum	)
	{
	case 0:
		// Show main links page.
		EditSettingLine = -1;
		SendHeader(q,"Access Plus menu");
		q.response.SendText("<table id=\"settings\" class=\"grid\"><thead><tr><th>Links</th></tr></thead><tbody>");
		AddLinkButton(q,"Settings");
		AddLinkButton(q,"Bans");
		AddLinkButton(q,"BanLog");
		q.response.SendText("</tbody></table></div></div></body></html>");
		break;
	case 1:
		SendHeader(q,bAccConfirmed ? "Settings" : "Confirmation");
		q.response.SendText("<form method=\"post\" action=\""$webadmin.Path$AccessURL$"\"><table id=\"settings\" class=\"grid\">");

		if( !bAccConfirmed )
		{
			q.response.SendText("<thead><tr><th>Password</th></tr></thead><tbody>");
			AddConfigEditbox(q,"Global Adminpassword","","GP","You must enter global adminpassword to access this page");
			
			// Submit button
			q.response.SendText("<tr><td></td><td><input class=\"button\" type=\"submit\" name=\"edit\" value=\"Submit\"></td></tr></form>");
		}
		else
		{
			// See for submits.
			// Admin users.
			for( i=0; i<AccessControl.AdminData.AU.Length; ++i )
			{
				S = q.request.getVariable("editAU"$i);
				
				if( S=="Edit" )
				{
					SubEditMode = 1;
					EditSettingLine = i;
					break;
				}
				else if( S=="Delete" )
				{
					AccessControl.WebDeleteUser(i);
					EditSettingLine = -1;
					break;
				}
			}
			S = q.request.getVariable("editAU");
			if( SubEditMode==1 && S=="Save" )
			{
				AccessControl.WebUpdateUser(EditSettingLine,q.request.getVariable("PL"),q.request.getVariable("ID"),q.request.getVariable("PW"),q.request.getVariable("UID"),bool(q.request.getVariable("NA","0")));
				EditSettingLine = -1;
			}
			else if( S=="New" )
			{
				EditSettingLine = CreateNewUser(int(q.request.getVariable("AUP","-1")));
				SubEditMode = byte(EditSettingLine>=0);
			}
			
			// Admin Groups.
			for( i=0; i<AccessControl.AdminData.AG.Length; ++i )
			{
				S = q.request.getVariable("editAG"$i);
				
				if( S=="Edit" )
				{
					SubEditMode = 0;
					EditSettingLine = i;
					break;
				}
				else if( S=="Delete" )
				{
					AccessControl.WebDeleteGroup(i);
					EditSettingLine = -1;
					break;
				}
			}
			if( SubEditMode==0 )
			{
				S = q.request.getVariable("editAG");
				if( S=="Save" )
				{
					AccessControl.WebEditGroup(EditSettingLine,GrabGroupOutput(q,"PR"),q.request.getVariable("ID"),q.request.getVariable("GN"),byte(q.request.getVariable("AT")));
					EditSettingLine = -1;
				}
				else if( S=="New" )
				{
					SubEditMode = 0;
					EditSettingLine = AccessControl.WebAddGroup();
				}
			}
			
			// Admin commands.
			for( i=0; i<AccessControl.AdminData.AC.Length; ++i )
			{
				S = q.request.getVariable("editAC"$i);
				
				if( S=="Edit" )
				{
					SubEditMode = 2;
					EditSettingLine = i;
					break;
				}
				else if( S=="Delete" )
				{
					AccessControl.WebDeleteCommand(i);
					EditSettingLine = -1;
					break;
				}
			}
			S = q.request.getVariable("editAC");
			if( SubEditMode==2 && S=="Save" )
			{
				AccessControl.WebUpdateCommand(EditSettingLine,q.request.getVariable("CN"),int(q.request.getVariable("CG")),q.request.getVariable("CGX"));
				EditSettingLine = -1;
			}
			else if( S=="Add Missing" )
				AccessControl.WebAddCommands();
			
			q.response.SendText("<thead><tr><th>Generic settings</th></tr></thead><tbody>");
			AddConfigEditbox(q,"Global Adminpassword",AccessControl.AdminData.GPW,"NGP","Change the globaladmin password");
			AddConfigEditbox(q,"Server Website",KFGameInfo(AccessControl.WorldInfo.Game).WebsiteLink,"WB","Change the server website URL");
			
			// Submit button
			q.response.SendText("<tr><td></td><td><input class=\"button\" type=\"submit\" name=\"edit\" value=\"Submit\"></td></tr>");
			q.response.SendText("</tbody></table></form>");
			
			// Admin users.
			q.response.SendText("<form method=\"post\" action=\""$webadmin.Path$AccessURL$"\"><table id=\"settings\" class=\"grid\">");
			q.response.SendText("<thead><tr><th colspan=5>Admin Users</th></tr></thead><tbody>");
			q.response.SendText("<tr><th>Player</th><th>Admin Group</th><th>Password</th><th title=\"SteamID of this admin\">User ID</th><th title=\"Whatever if this admin should automatically become admin when they join\">Auto-Admin</th></tr>");
			
			for( i=0; i<AccessControl.AdminData.AU.Length; ++i )
			{
				if( SubEditMode==1 && EditSettingLine==i )
				{
					q.response.SendText("<tr>",false);
					AddInLineEditbox(q,AccessControl.AdminData.AU[i].PL,"PL");
					AddAdminGroupsCombo(q,AccessControl.AdminData.AU[i].ID,"ID");
					//AddInLineEditbox(q,AccessControl.AdminData.AU[i].ID,"ID");
					AddInLineEditbox(q,AccessControl.AdminData.AU[i].PW,"PW");
					AddInLineEditbox(q,AccessControl.AdminData.AU[i].UID,"UID");
					AddInLineCheckbox(q,!AccessControl.AdminData.AU[i].NA,"NA");
					q.response.SendText("</td><td><input class=\"button\" type=\"submit\" name=\"editAU\" value=\"Save\"><input class=\"button\" type=\"submit\" name=\"editAU"$i$"\" value=\"Delete\"></td></tr>");
				}
				else
				{
					q.response.SendText("<tr><td>"$AccessControl.AdminData.AU[i].PL$
										"</td><td>"$AccessControl.AdminData.AU[i].ID$
										"</td><td>"$AccessControl.AdminData.AU[i].PW$
										"</td><td>"$AccessControl.AdminData.AU[i].UID$
										"</td><td>"$(AccessControl.AdminData.AU[i].NA ? "" : "X")$
										"</td><td><input class=\"button\" type=\"submit\" name=\"editAU"$i$"\" value=\"Edit\"><input class=\"button\" type=\"submit\" name=\"editAU"$i$"\" value=\"Delete\"></td></tr>");
				}
			}
			q.response.SendText("</form><form method=\"post\" action=\""$webadmin.Path$AccessURL$"\"><tr><td colspan=3>");
			AddPlayerListCombo(q,"AUP");
			q.response.SendText("</td><td><input class=\"button\" type=\"submit\" name=\"editAU\" value=\"New\"></td></tr></tbody></table></form>");
			
			// Admin groups.
			q.response.SendText("<form method=\"post\" action=\""$webadmin.Path$AccessURL$"\"><table id=\"settings\" class=\"grid\">");
			q.response.SendText("<thead><tr><th colspan=4>Admin Groups</th></tr></thead><tbody>");
			q.response.SendText("<tr><th title=\"Login name information shown to public\">Name</th><th>Group ID</th><th title=\"Admin level, where 0-1 allow access to webadmin, 3+ no access to most of admin commands\">Admin Level</th><th>Priveleges</th></tr>");
			
			for( i=0; i<AccessControl.AdminData.AG.Length; ++i )
			{
				if( SubEditMode==0 && EditSettingLine==i )
				{
					q.response.SendText("<tr>",false);
					AddInLineEditbox(q,AccessControl.AdminData.AG[i].GN,"GN");
					AddInLineEditbox(q,AccessControl.AdminData.AG[i].ID,"ID");
					AddInLineEditbox(q,string(AccessControl.AdminData.AG[i].AT),"AT");
					AddAdminGroupList(q,AccessControl.AdminData.AG[i].PR,"PR");
					q.response.SendText("</td><td><input class=\"button\" type=\"submit\" name=\"editAG\" value=\"Save\"><input class=\"button\" type=\"submit\" name=\"editAG"$i$"\" value=\"Delete\"></td></tr>");
				}
				else
				{
					q.response.SendText("<tr><td>"$AccessControl.AdminData.AG[i].GN$
										"</td><td>"$AccessControl.AdminData.AG[i].ID$
										"</td><td>"$AccessControl.AdminData.AG[i].AT$
										"</td><td>"$AccessControl.AdminData.AG[i].PR$
										"</td><td><input class=\"button\" type=\"submit\" name=\"editAG"$i$"\" value=\"Edit\"><input class=\"button\" type=\"submit\" name=\"editAG"$i$"\" value=\"Delete\"></td></tr>");
				}
			}
			q.response.SendText("</form><form method=\"post\" action=\""$webadmin.Path$AccessURL$"\">");
			q.response.SendText("<tr><td><input class=\"button\" type=\"submit\" name=\"editAG\" value=\"New\"></td></tr>");
			q.response.SendText("</form>");
			
			// Admin commands
			q.response.SendText("<form method=\"post\" action=\""$webadmin.Path$AccessURL$"\"><table id=\"settings\" class=\"grid\">");
			q.response.SendText("<thead><tr><th colspan=2>Admin Commands</th></tr></thead><tbody>");
			q.response.SendText("<tr><th title=\"Admin command name\">Command</th><th title=\"Matching group of this command\">Command Group</th></tr>");
			
			for( i=0; i<AccessControl.AdminData.AC.Length; ++i )
			{
				if( SubEditMode==2 && EditSettingLine==i )
				{
					q.response.SendText("<tr>",false);
					AddCommandList(q,EditSettingLine,"CN");
					AddCommandGroupList(q,EditSettingLine,"CG");
					q.response.SendText("</td><td><input class=\"button\" type=\"submit\" name=\"editAC\" value=\"Save\"><input class=\"button\" type=\"submit\" name=\"editAC"$i$"\" value=\"Delete\"></td></tr>");
				}
				else
				{
					j = AccessControl.AdminData.AC[i].CG;
					if( j>=0 && j<AccessControl.AdminData.CG.Length )
						S = AccessControl.AdminData.CG[j];
					else S = "[MISSING GROUP]";
					q.response.SendText("<tr><td>"$AccessControl.AdminData.AC[i].CM$
										"</td><td>"$S$
										"</td><td><input class=\"button\" type=\"submit\" name=\"editAC"$i$"\" value=\"Edit\"><input class=\"button\" type=\"submit\" name=\"editAC"$i$"\" value=\"Delete\"></td></tr>");
				}
			}
			q.response.SendText("</form><form method=\"post\" action=\""$webadmin.Path$AccessURL$"\">");
			q.response.SendText("<tr><td><input class=\"button\" type=\"submit\" name=\"editAC\" value=\"Add Missing\"></td></tr>");
			q.response.SendText("</form>");
		}

		// Return to main menu button.
		q.response.SendText("<tr><td><form action=\""$webadmin.Path$AccessURL$"\"><input class=\"button\" name=\"GoToPage\" type=\"submit\" value=\"Main Menu\"></form></td></tr>");
		q.response.SendText("</tbody></table></div></div></body></html>");
		break;
	case 2:
		if( q.request.getVariable("editB")=="Save" )
		{
			AccessControl.WebEditBan(q.user.getUsername(),EditSettingLine,q.request.getVariable("N"),q.request.getVariable("IP"),q.request.getVariable("R"),int(q.request.getVariable("T")),q.request.getVariable("NT"));
			EditSettingLine = -1;
		}
		else if( q.request.getVariable("addban")=="New Ban" )
		{
			EditSettingLine = AccessControl.WebAddBan(q.user.getUsername(),q.request.getVariable("ID"));
		}
		else
		{
			for( i=0; i<AccessControl.BansData.BE.Length; ++i )
			{
				S = q.request.getVariable("editB"$i);
				
				if( S=="Edit" )
				{
					EditSettingLine = i;
					break;
				}
				else if( S=="Delete" )
				{
					AccessControl.WebDeleteBan(q.user.getUsername(),i);
					EditSettingLine = -1;
					break;
				}
			}
		}
		AccessControl.BansData.UpdateTempTime();

		SendHeader(q,"Server Bans");
		q.response.SendText("<form method=\"post\" action=\""$webadmin.Path$AccessURL$"\"><table id=\"settings\" class=\"grid\">");

		q.response.SendText("<thead><tr><th colspan=8>Ban list</th></tr></thead><tbody>");
		q.response.SendText("<tr><th title=\"Unique ban ID for this ban\">BanID</th><th title=\"The admin that initially banned this player\">Admin</th><th>Name</th><th title=\"SteamID for this user\">ID</th><th>IP</th><th title=\"Ban reason shown for the player themself\">Reason</th><th title=\"Ban expiry time in hours (minutes)\">Expires</th><th title=\"Custom notes for this ban\">Notes</th></tr>");
		for( i=0; i<AccessControl.BansData.BE.Length; ++i )
		{
			if( EditSettingLine==i )
			{
				q.response.SendText("<tr><td>"$AccessControl.BansData.BE[i].IX$"</td><td>"$AccessControl.BansData.BE[i].A$"</td>",false);
				AddInLineEditbox(q,AccessControl.BansData.BE[i].N,"N");
				q.response.SendText("<td>"$AccessControl.BansData.BE[i].ID$"</td>",false);
				AddInLineEditbox(q,AccessControl.BansData.BE[i].IP,"IP");
				AddInLineEditbox(q,AccessControl.BansData.BE[i].R,"R");
				AddInLineEditbox(q,AccessControl.BansData.WEBGetBanTime(i),"T");
				AddTextField(q,AccessControl.BansData.BE[i].NT,8,"NT");
				q.response.SendText("</td><td><input class=\"button\" type=\"submit\" name=\"editB\" value=\"Save\"><input class=\"button\" type=\"submit\" name=\"editB"$i$"\" value=\"Delete\"></td></tr>");
			}
			else
			{
				q.response.SendText("<tr><td>"$AccessControl.BansData.BE[i].IX$
									"</td><td>"$AccessControl.BansData.BE[i].A$
									"</td><td>"$AccessControl.BansData.BE[i].N$
									"</td><td>"$AccessControl.BansData.BE[i].ID$
									"</td><td>"$AccessControl.BansData.BE[i].IP$
									"</td><td>"$AccessControl.BansData.BE[i].R$
									"</td><td>"$AccessControl.BansData.WEBGetBanTimeStr(i)$
									"</td><td>"$(AccessControl.BansData.BE[i].NT!="" ? "X" : "")$
									"</td><td><input class=\"button\" type=\"submit\" name=\"editB"$i$"\" value=\"Edit\"><input class=\"button\" type=\"submit\" name=\"editB"$i$"\" value=\"Delete\"></td></tr>");
			}
		}
		q.response.SendText("</form><form method=\"post\" action=\""$webadmin.Path$AccessURL$"\"><tr>");
		AddInLineEditbox(q,"0x0000000000000000","ID");
		q.response.SendText("<td><input class=\"button\" type=\"submit\" name=\"addban\" value=\"New Ban\"></td></tr>");
		q.response.SendText("</form>");

		// Return to main menu button.
		q.response.SendText("<tr><td><form action=\""$webadmin.Path$AccessURL$"\"><input class=\"button\" name=\"GoToPage\" type=\"submit\" value=\"Main Menu\"></form></td></tr>");
		q.response.SendText("</tbody></table></div></div></body></html>");
		break;
	case 3:
		SendHeader(q,"Ban history");
		q.response.SendText("<table id=\"settings\" class=\"grid\">");
		q.response.SendText("<thead><tr><th>Log</th></tr></thead><tbody><tr><td>");
		for( i=0; i<AccessControl.BansData.BL.Length; ++i )
			q.response.SendText("*"$AccessControl.BansData.BL[i]$"<br>");
		

		// Return to main menu button.
		q.response.SendText("</td></tr><tr><td><form action=\""$webadmin.Path$AccessURL$"\"><input class=\"button\" name=\"GoToPage\" type=\"submit\" value=\"Main Menu\"></form></td></tr>");
		q.response.SendText("</tbody></table></div></div></body></html>");
		break;
	}
	SendFooter(q);
}

function bool producesXhtml()
{
	return true;
}
function bool unhandledQuery(WebAdminQuery q);
function decoratePage(WebAdminQuery q);

defaultproperties
{
	AccessURL="/policy/AccessPlusUI"
	EditSettingLine=-1
}