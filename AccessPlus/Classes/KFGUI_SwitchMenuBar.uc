// Same as SwitchComponent, but with buttons.
Class KFGUI_SwitchMenuBar extends KFGUI_MultiComponent;

`include(Build.uci)
`include(Logger.uci)

var array<KFGUI_Base> SubPages;
var() byte ButtonPosition; // 0 = top, 1 = bottom, 2 = left, 3 = right
var() float BorderWidth, ButtonAxisSize; // Width for buttons.
var() float PagePadding; // Padding for pages

var int NumButtons, CurrentPageNum, PageComponentIndex;
var array<KFGUI_Button> PageButtons;

function ShowMenu()
{
	GrabKeyFocus();
	Super.ShowMenu();
}

function CloseMenu()
{
	ReleaseKeyFocus();
	Super.CloseMenu();
}

// Remember to call InitMenu() on the newly created page after.
final function KFGUI_Base AddPage(class<KFGUI_Base> PageClass, string Caption, string Hint, optional out KFGUI_Button Button)
{
	local KFGUI_Base P;
	local KFGUI_Button B;

	// Add page.
	P = new (Self) PageClass;
	P.Owner = Owner;
	P.ParentComponent = Self;
	SubPages.AddItem(P);

	// Add page switch button.
	B = new (Self) class'KFGUI_Button';
	B.ButtonText = Caption;
	B.ToolTip = Hint;
	B.OnClickLeft = PageSwitched;
	B.OnClickRight = PageSwitched;
	B.IDValue = NumButtons;

	if (ButtonPosition < 2)
	{
		B.XPosition = NumButtons*ButtonAxisSize;
		B.XSize = ButtonAxisSize*0.99;

		if (ButtonPosition == 0)
			B.YPosition = 0.f;
		else B.YPosition = YSize-BorderWidth*0.99;
		B.YSize = BorderWidth*0.99;

		if (NumButtons > 0)
			PageButtons[PageButtons.Length-1].ExtravDir = 1;
	}
	else
	{
		if (ButtonPosition == 2)
			B.XPosition = 0.f;
		else B.XPosition = XSize-BorderWidth*0.99;
		B.XSize = BorderWidth*0.99;

		B.YPosition = NumButtons*ButtonAxisSize;
		B.YSize = ButtonAxisSize*0.99;
		if (NumButtons > 0)
			PageButtons[PageButtons.Length-1].ExtravDir = 2;
	}

	++NumButtons;
	PageButtons.AddItem(B);
	AddComponent(B);
	Button = B;
	return P;
}

function PageSwitched(KFGUI_Button Sender)
{
	SelectPage(Sender.IDValue);
}

final function SelectPage(int Index)
{
	PlayMenuSound(MN_LostFocus);

	if (CurrentPageNum >= 0)
	{
		PageButtons[CurrentPageNum].bIsHighlighted = false;
		SubPages[CurrentPageNum].CloseMenu();
		Components.Remove(PageComponentIndex, 1);
		PageComponentIndex = -1;
	}
	CurrentPageNum = (Index >= 0 && Index < SubPages.Length) ? Index : -1;
	if (CurrentPageNum >= 0)
	{
		PageButtons[CurrentPageNum].bIsHighlighted = true;
		SubPages[CurrentPageNum].ShowMenu();
		PageComponentIndex = Components.Length;
		Components.AddItem(SubPages[CurrentPageNum]);
	}
}

function PreDraw()
{
	local int i;
	local byte j;

	if (!bVisible)
		return;

	if (CurrentPageNum == -1 && NumButtons > 0)
		SelectPage(0);
	ComputeCoords();
	Canvas.SetOrigin(CompPos[0], CompPos[1]);
	Canvas.SetClip(CompPos[0]+CompPos[2], CompPos[1]+CompPos[3]);
	DrawMenu();
	for (i=0; i < Components.Length; ++i)
	{
		Components[i].Canvas = Canvas;
		for (j=0; j < 4; ++j)
			Components[i].InputPos[j] = CompPos[j];
		if (i == PageComponentIndex)
		{
			switch(ButtonPosition)
			{
			case 0:
				Components[i].InputPos[1] += (InputPos[3]*BorderWidth*PagePadding);
			case 1:
				Components[i].InputPos[3] -= (InputPos[3]*BorderWidth*PagePadding);
				break;
			case 2:
				Components[i].InputPos[0] += (InputPos[2]*BorderWidth*PagePadding);
			default:
				Components[i].InputPos[2] -= (InputPos[2]*BorderWidth*PagePadding);
			}
		}
		Components[i].PreDraw();
	}
}

function bool ReceievedControllerInput(int ControllerId, name Key, EInputEvent Event)
{
	switch(Key)
	{
		case 'XboxTypeS_LeftShoulder':
			if (Event == IE_Pressed)
				SelectPage(Clamp(CurrentPageNum - 1, 0, NumButtons));
			return true;
		case 'XboxTypeS_RightShoulder':
			if (Event == IE_Pressed)
				SelectPage(Clamp(CurrentPageNum + 1, 0, NumButtons));
			return true;
	}

	return false;
}

defaultproperties
{
	PagePadding=1.0
	BorderWidth=0.05
	ButtonAxisSize=0.08
	CurrentPageNum=-1
	PageComponentIndex=-1
}