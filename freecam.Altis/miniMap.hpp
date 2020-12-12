class minimapi 
{

	idc = 38555;
	type = 101;
	style = 48;
	moveOnEdges = 0;
	x = safeZoneX;
	y = safezoneY + safezoneH - 0.4;
	w = (safezoneX+safezoneW) * 0.2;
	h = 0.4;
	shadow=0;
	ptsPerSquareSea=5;
	ptsPerSquareTxt=20;
	ptsPerSquareCLn=10;
	ptsPerSquareExp=10;
	ptsPerSquareCost=10;
	ptsPerSquareFor=9;
	ptsPerSquareForEdge=9;
	ptsPerSquareRoad=6;
	ptsPerSquareObj=9;
	showCountourInterval=0;
	scaleMin=0.001;
	scaleMax=1;
	scaleDefault=0.16;
	maxSatelliteAlpha=0.85000002;
	alphaFadeStartScale=2;
	alphaFadeEndScale=2;
	font = "TahomaB";
	sizeEx = 0.040000;
	colorText[]={1,1,1,1};
	colorBackground[]={0.96899998,0.95700002,0.949,1};
	colorSea[]={0.46700001,0.63099998,0.85100001,0.5};
	colorForest[]={0.62400001,0.77999997,0.38800001,0.5};
	colorForestBorder[]={0,0,0,0};
	colorRocks[]={0,0,0,0.30000001};
	colorRocksBorder[]={0,0,0,0};
	colorLevels[]={0.28600001,0.177,0.093999997,0.5};
	colorMainCountlines[]={0.57200003,0.354,0.18799999,0.5};
	colorCountlines[]={0.57200003,0.354,0.18799999,0.25};
	colorMainCountlinesWater[]={0.491,0.57700002,0.70200002,0.60000002};
	colorCountlinesWater[]={0.491,0.57700002,0.70200002,0.30000001};
	colorPowerLines[]={0.1,0.1,0.1,1};
	colorRailWay[]={0.80000001,0.2,0,1};
	colorNames[]={0.1,0.1,0.1,0.89999998};
	colorInactive[]={1,1,1,0.5};
	colorOutside[]={0,0,0,1};
	colorTracks[]={0.83999997,0.75999999,0.64999998,0.15000001};
	colorTracksFill[]={0.83999997,0.75999999,0.64999998,1};
	colorRoads[]={0.69999999,0.69999999,0.69999999,1};
	colorRoadsFill[]={1,1,1,1};
	colorMainRoads[]={0.89999998,0.5,0.30000001,1};
	colorMainRoadsFill[]={1,0.60000002,0.40000001,1};
	colorGrid[]={0.1,0.1,0.1,0.60000002};
	colorGridMap[]={0.1,0.1,0.1,0.60000002};
	colorTrails[]={0.83999997,0.75999999,0.64999998,0.15000001};
	colorTrailsFill[]={0.83999997,0.75999999,0.64999998,0.64999998};
	widthRailWay=4;
	fontLabel="RobotoCondensed";
	sizeExLabel="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontGrid="TahomaB";
	sizeExGrid=0.02;
	fontUnits="TahomaB";
	sizeExUnits="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontNames="RobotoCondensed";
	sizeExNames="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
	fontInfo="RobotoCondensed";
	sizeExInfo="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	fontLevel="TahomaB";
	sizeExLevel=0.02;
	text="#(argb,8,8,3)color(1,1,1,1)";
	idcMarkerColor=-1;
	idcMarkerIcon=-1;
	textureComboBoxColor="#(argb,8,8,3)color(1,1,1,1)";
	showMarkers=1;
	class ActiveMarker
	{
		color[] = { 0.30, 0.10, 0.90, 1.00 };
		size = 50;
	};
	class LineMarker
	{
		lineWidthThin=0.0080000004;
		lineWidthThick=0.014;
		lineDistanceMin=2.9999999e-005;
		lineLengthMin=5;
	};
	class Legend
	{
		x="SafeZoneX + 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		y="SafeZoneY + safezoneH - 4.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		w="10 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
		h="3.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		font="RobotoCondensed";
		sizeEx="(			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		colorBackground[]={1,1,1,0.5};
		color[]={0,0,0,1};
	};
	class Task
	{
		icon="\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
		iconCreated="\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
		iconCanceled="\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
		iconDone="\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
		iconFailed="\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
		color[]=
		{
			"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])",
			"(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])",
			"(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])",
			"(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"
		};
		colorCreated[]={1,1,1,1};
		colorCanceled[]={0.69999999,0.69999999,0.69999999,1};
		colorDone[]={0.69999999,1,0.30000001,1};
		colorFailed[]={1,0.30000001,0.2,1};
		size=27;
		importance=1;
		coefMin=1;
		coefMax=1;
	};
	class Waypoint
	{
		icon="\a3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		color[]={1,1,1,1};
		size=18;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};
	class WaypointCompleted
	{
		icon="\a3\ui_f\data\map\mapcontrol\waypointcompleted_ca.paa";
		color[]={1,1,1,1};
		size=18;
		importance = 1.00;
		coefMin = 1.00;
		coefMax = 1.00;
	};
	class CustomMark
	{
		icon="\a3\ui_f\data\map\mapcontrol\custommark_ca.paa";
		size=18;
		importance=1;
		coefMin=1;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class Command
	{
		icon="\a3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
		size=18;
		importance=1;
		coefMin=1;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class Bush
	{
		icon="\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[]={0.44999999,0.63999999,0.33000001,0.40000001};
		size="14/2";
		importance="0.2 * 14 * 0.05 * 0.05";
		coefMin=0.25;
		coefMax=4;
	};
	class Rock
	{
		icon="\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
		color[]={0.1,0.1,0.1,0.80000001};
		size=12;
		importance="0.5 * 12 * 0.05";
		coefMin=0.25;
		coefMax=4;
	};
	class SmallTree
	{
		icon="\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[]={0.44999999,0.63999999,0.33000001,0.40000001};
		size=12;
		importance="0.6 * 12 * 0.05";
		coefMin=0.25;
		coefMax=4;
	};
	class Tree
	{
		icon="\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
		color[]={0.44999999,0.63999999,0.33000001,0.40000001};
		size=12;
		importance="0.9 * 16 * 0.05";
		coefMin=0.25;
		coefMax=4;
	};
	class busstop
	{
		icon="\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class fuelstation
	{
		icon="\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class hospital
	{
		icon="\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class church
	{
		icon="\A3\ui_f\data\map\mapcontrol\church_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class lighthouse
	{
		icon="\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class power
	{
		icon="\A3\ui_f\data\map\mapcontrol\power_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class powersolar
	{
		icon="\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class powerwave
	{
		icon="\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class powerwind
	{
		icon="\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class quay
	{
		icon="\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class transmitter
	{
		icon="\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class watertower
	{
		icon="\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={1,1,1,1};
	};
	class Cross
	{
		icon="\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={0,0,0,1};
	};
	class Chapel
	{
		icon="\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={0,0,0,1};
	};
	class Shipwreck
	{
		icon="\A3\ui_f\data\map\mapcontrol\Shipwreck_CA.paa";
		size=24;
		importance=1;
		coefMin=0.85000002;
		coefMax=1;
		color[]={0,0,0,1};
	};
	class Bunker
	{
		icon="\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size=14;
		importance="1.5 * 14 * 0.05";
		coefMin=0.25;
		coefMax=4;
		color[]={0,0,0,1};
	};
	class Fortress
	{
		icon="\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
		size=16;
		importance="2 * 16 * 0.05";
		coefMin=0.25;
		coefMax=4;
		color[]={0,0,0,1};
	};
	class Fountain
	{
		icon="\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
		size=11;
		importance="1 * 12 * 0.05";
		coefMin=0.25;
		coefMax=4;
		color[]={0,0,0,1};
	};
	class Ruin
	{
		icon="\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
		size=16;
		importance="1.2 * 16 * 0.05";
		coefMin=1;
		coefMax=4;
		color[]={0,0,0,1};
	};
	class Stack
	{
		icon="\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
		size=16;
		importance="2 * 16 * 0.05";
		coefMin=0.40000001;
		coefMax=2;
		color[]={0,0,0,1};
	};
	class Tourism
	{
		icon="\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
		size=16;
		importance="1 * 16 * 0.05";
		coefMin=0.69999999;
		coefMax=4;
		color[]={0,0,0,1};
	};
	class ViewTower
	{
		icon="\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
		size=16;
		importance="2.5 * 16 * 0.05";
		coefMin=0.5;
		coefMax=4;
		color[]={0,0,0,1};
	};
	onLoad = "_this call fnc_updateMiniMap";
	//onDraw = "_this call fnc_updateMiniMap";
};
