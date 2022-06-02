Class KFGUI_FloatingWindow extends KFGUI_Page
	abstract;

`include(Build.uci)
`include(Logger.uci)

var() string WindowTitle; // Title of this window.
var float DragOffset[2], OpenAnimSpeed;
var KFGUI_FloatingWindowHeader HeaderComp;
var bool bDragWindow, bUseAnimation;

var float WindowFadeInTime;
var transient float OpenStartTime, OpenEndTime;

function InitMenu()
{
	Super.InitMenu();
	HeaderComp = new (Self) class'KFGUI_FloatingWindowHeader';
	AddComponent(HeaderComp);
}
function ShowMenu()
{
	Super.ShowMenu();

	OpenStartTime = GetPlayer().WorldInfo.RealTimeSeconds;
	OpenEndTime = GetPlayer().WorldInfo.RealTimeSeconds + OpenAnimSpeed;
}
function DrawMenu()
{
	local float TempSize;

	if (bUseAnimation)
	{
		TempSize = `TimeSinceEx(GetPlayer(), OpenStartTime);
		if (WindowFadeInTime - TempSize > 0 && FrameOpacity != default.FrameOpacity)
			FrameOpacity = (1.f - ((WindowFadeInTime - TempSize) / WindowFadeInTime)) * default.FrameOpacity;
	}

	Owner.CurrentStyle.RenderFramedWindow(Self);

	if (HeaderComp != None)
	{
		HeaderComp.CompPos[3] = Owner.CurrentStyle.DefaultHeight;
		HeaderComp.YSize = HeaderComp.CompPos[3] / CompPos[3]; // Keep header height fit the window height.
	}
}
function SetWindowDrag(bool bDrag)
{
	bDragWindow = bDrag;
	if (bDrag)
	{
		DragOffset[0] = Owner.MousePosition.X-CompPos[0];
		DragOffset[1] = Owner.MousePosition.Y-CompPos[1];
	}
}
function bool CaptureMouse()
{
	local int i;

	if (bDragWindow && HeaderComp != None ) // Always keep focus on window frame now!
	{
		MouseArea = HeaderComp;
		return true;
	}

	for (i=0; i < Components.Length; i++)
	{
		if (Components[i].CaptureMouse())
		{
			MouseArea = Components[i];
			return true;
		}
	}

	MouseArea = None;

	return Super(KFGUI_Base).CaptureMouse();
}
function PreDraw()
{
	local float Frac, CenterX, CenterY;

	if (bUseAnimation)
	{
		Frac = Owner.CurrentStyle.TimeFraction(OpenStartTime, OpenEndTime, GetPlayer().WorldInfo.RealTimeSeconds);
		XSize = Lerp(default.XSize*0.75, default.XSize, Frac);
		YSize = Lerp(default.YSize*0.75, default.YSize, Frac);

		CenterX = (default.XPosition + default.XSize * 0.5) - ((default.XSize*0.75)/2);
		CenterY = (default.YPosition + default.YSize * 0.5) - ((default.YSize*0.75)/2);

		XPosition = Lerp(CenterX, default.XPosition, Frac);
		YPosition = Lerp(CenterY, default.YPosition, Frac);

		if (bDragWindow)
		{
			XPosition = FClamp(Owner.MousePosition.X-DragOffset[0], 0,InputPos[2]-CompPos[2]) / InputPos[2];
			YPosition = FClamp(Owner.MousePosition.Y-DragOffset[1], 0,InputPos[3]-CompPos[3]) / InputPos[3];
		}
	}

	Super.PreDraw();
}

defaultproperties
{
	bUseAnimation=true
	OpenAnimSpeed=0.05f
	WindowFadeInTime=0.2f
}