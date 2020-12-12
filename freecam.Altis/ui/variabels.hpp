class ScrollBar;
class ctrlStaticBackground;
class ctrlListbox;
class ctrlButtonClose;
class ctrlControlsGroup;


class RscCombo
{
	
	
	access = 0;
	text="";
	type = 	4;
	colorSelect[] = {0,0,0,1};
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,1};
	colorScrollbar[] = {1,0,0,1};
	colorDisabled[] = {1,1,1,0.25};
	colorPicture[] = {1,1,1,1};
	colorPictureSelected[] = {1,1,1,1};
	colorPictureDisabled[] = {1,1,1,0.25};
	colorPictureRight[] = {1,1,1,1};
	colorPictureRightSelected[] = {1,1,1,1};
	colorPictureRightDisabled[] = {1,1,1,0.25};
	colorTextRight[] = {1,1,1,1};
	colorSelectRight[] = {0,0,0,1};
	colorSelect2Right[] = {0,0,0,1};
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};
	soundSelect[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundSelect",
		0.1,
		1
	};
	soundExpand[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundExpand",
		0.1,
		1
	};
	soundCollapse[] =
	{
		"\A3\ui_f\data\sound\RscCombo\soundCollapse",
		0.1,
		1
	};
	maxHistoryDelay = 1;
	class ComboScrollBar: ScrollBar
	{
		color[] = {1,1,1,1};
	};
	style = 0;
	font = "RobotoCondensed";
	sizeEx = 0.04;
	shadow = 0;
	x = 0;
	y = 0;
	w = 0.12;
	h = 0.035;
	colorSelectBackground[] = {1,1,1,0.7};
	arrowEmpty = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_ca.paa";
	arrowFull = "\A3\ui_f\data\GUI\RscCommon\rsccombo\arrow_combo_active_ca.paa";
	wholeHeight = 0.45;
	colorActive[] = {1,0,0,1};
};
class RscListBox2d
{
 access = 0;
 type = 5;
 style = 0;
 x = 0;
 y = 0;
 w = 0.4;
 h = 0.4;
 font = "PuristaLight";
 sizeEx = 0.04;
 rowHeight = 0;
 colorText[] = {1,1,1,1};
 colorScrollbar[] = {1,1,1,1};
 colorSelect[] = {0,0,0,1};
 colorSelect2[] = {1,0.5,0,1};
 colorSelectBackground[] = {0.6,0.6,0.6,1};
 colorSelectBackground2[] = {0.2,0.2,0.2,1};
 colorBackground[] = {0,0,0,0.5};

 colorDisabled[] = {1,1,1,0.3};
 canDrag=true;
 maxHistoryDelay = 1.0;
 soundSelect[] = {"",0.1,1};
 period = 1;
 autoScrollSpeed = -1;
 autoScrollDelay = 5;
 autoScrollRewind = 0;
 arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
 arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
 shadow = 0;
 class ListScrollBar : ScrollBar //ListScrollBar is class name required for Arma 3
 {
  color[] = {1,1,1,0.6};
  colorActive[] = {1,1,1,1};
  colorDisabled[] = {1,1,1,0.3};
  thumb = "#(argb,8,8,3)color(1,1,1,1)";
  arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
  arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
  border = "#(argb,8,8,3)color(1,1,1,1)";
  shadow = 0;
 };
};



class RscListBox3d: RscListBox2d
{
 type = 102;
 style = 16;
colorText[] = {0,0,0,1};
colorBackground[] = {0.2,0.2,0.2,1}; 
 autoScrollSpeed = -1; 
 autoScrollDelay = 5; 
 autoScrollRewind = 0; 
 arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)"; 
 arrowFull = "#(argb,8,8,3)color(1,1,1,1)"; 
 columns[] = {0.1, 0.2, 0.7}; 
 color[] = {1, 1, 1, 1}; 
 colorScrollbar[] = {0.95, 0.95, 0.95, 1}; 
 colorSelect[] = {0.95, 0.95, 0.95, 1}; 
 colorSelect2[] = {0.95, 0.95, 0.95, 1}; 
 colorSelectBackground[] = {0, 0, 0, 1}; 
 colorSelectBackground2[] = {0.8784, 0.8471, 0.651, 1}; 
 drawSideArrows = 1; 
 idcLeft = 1000; 
 idcRight = 1001; 
 maxHistoryDelay = 1; 
 rowHeight = 0; 
 soundSelect[] = {"", 0.1, 1}; 
 period = 1; 
 shadow = 2; 
};

class RscListBox3dNo: RscListBox3d
{

 idcLeft = 11; 
 idcRight = 11; 
};


class RscPicture
{
 access = 0;
 type = 0;
 idc = -1;
 style = 48;//ST_PICTURE
 colorBackground[] = {0,0,0,0};
 colorText[] = {1,1,1,1};
 font = "TahomaB";
 sizeEx = 0;
 lineSpacing = 0;
 text = "";
 fixedWidth = 0;
 shadow = 0;
};

class RscText
{
 access = 0;
 type = 0;
 idc = -1;
 style = 0;
 w = 0.1; h = 0.05;
 //x and y are not part of a global class since each rsctext will be positioned 'somewhere'
 font = "TahomaB";
 sizeEx = 0.04;
 colorBackground[] = {0,0,0,0};
 colorText[] = {1,1,1,1};
 text = "";
 fixedWidth = 0;
 shadow = 0;
};


class TSButton
{
	access = 0;
	type = 1;
	style = 0;
	x = 0; y = 0; w = 0.3; h = 0.1;
	text = "";
	font = "TahomaB";
	sizeEx = 0.04;
	colorText[] = { 0, 0, 0, 1 };
	colorFocused[] = { 1, 0, 0, 1 };		// border color for focused state
	colorDisabled[] = { 0, 0, 1, 0.7 };		// text color for disabled state
	colorBackground[] = { 1, 1, 1, 0.8 };
	colorBackgroundDisabled[] = { 1, 1, 1, 0.5 };	// background color for disabled state
	colorBackgroundActive[] = { 1, 1, 1, 1 };	
	offsetX = 0.004;
	offsetY = 0.004;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorShadow[] = { 0, 0, 0, 0.5 };
	shadow = 0;
	colorBorder[] = {0,0,0,0};
	borderSize = 0.008;
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
};

class RscButtonInvisible
{
	access = 0;
	type = 1;
	style = 0;
	x = 0; y = 0; w = 0.3; h = 0.1;
	text = "";
	font = "TahomaB";
	sizeEx = 0.04;
	colorText[] = {0,0,0,0};
	colorDisabled[] = {0.3,0.3,0.3,0};
	colorBackground[] = {0.6,0.6,0.6,0};
	colorBackgroundDisabled[] = {0.6,0.6,0.6,0};
	colorBackgroundActive[] = {1,0.5,0,0};
	offsetX = 0.004;
	offsetY = 0.004;
	offsetPressedX = 0.002;
	offsetPressedY = 0.002;
	colorFocused[] = {0,0,0,0};
	colorShadow[] = {0,0,0,0};
	shadow = 0;
	colorBorder[] = {0,0,0,0};
	borderSize = 0.008;
	soundEnter[] = {"",0.1,1};
	soundPush[] = {"",0.1,1};
	soundClick[] = {"",0.1,1};
	soundEscape[] = {"",0.1,1};
};

class TSProgress
{
	type = 8;
	style = 0;
	colorFrame[] = {0,0,0,1};
	colorBar[] = {1,1,1,1};
	texture = "#(argb,8,8,3)color(1,1,1,1)";
	w = 1;
	h = 0.03;
};

class TSStructuredText {
  idc = -1; 
  type = 13; 
  style = 0; 
  colorBackground[] = { 1, 1, 1, 1 }; 
  x = 0.1; 
  y = 0.1; 
  w = 0.3; 
  h = 0.1; 
  size = 0.018;
  text = "";
  class Attributes {
    font = "TahomaB";
    color = "#000000";
    align = "left";
    valign = "middle";
    shadow = false;
    shadowColor = "#ff0000";
    size = "1";
  };
};



#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

