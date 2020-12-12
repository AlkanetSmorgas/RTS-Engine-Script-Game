//GLOBAL INIT
Blufor_spawn = markerPos ["Blufor_spawn", true];
Opfor_spawn = markerPos ["Opfor_spawn", true];
Gamearea_Center = markerPos ["Gamearea_Center", true];

if (isNil "Mission_Intro_Start") then	
{
	Mission_Intro_Start = false;	
};

_resourceConfig = (configproperties [missionConfigFile >> "RTS_Resources","isclass _x"]);
_bluforV = [];
_opforV = [];
_bluforVPS = [];
_opforVPS = [];
resourceArrayValue = [];
resourceArrayPerSec = [];
resourceData = [];
{
	_name = getText (_x >> "name");
	if(_name isEqualTo "")then{
		_name = configName _x;
	};
	_defaultValue = getNumber (_x >> "defaultValue");
	_defaultPerSec = getNumber (_x >> "defaultPerSec");
	_bluforV pushBack _defaultValue;
	_opforV pushBack _defaultValue;
	_bluforVPS pushBack _defaultPerSec;
	_opforVPS pushBack _defaultPerSec;
	resourceData pushBack [_name,-1];
	if(hasInterface)then{
		resourceArrayPerSec pushBack _defaultPerSec;
		resourceArrayValue pushBack _defaultValue;
	
	
		[_foreachIndex,_defaultValue] spawn Alk_Resources_fnc_setValue;
		[_foreachIndex,_defaultPerSec] spawn Alk_Resources_fnc_setPerSecond;
	};
	
} foreach _resourceConfig;



//SERVER INIT
if(isServer)then{

/*
	//If dedicated is used, edit this variabels if you want ai´s.
	if(isDedicated)then{
	
		RTS_server_AI_bluforAmount = 2;
		RTS_server_AI_opforAmount = 2;
	};
*/

	EQ = createcenter east;
	WQ = createcenter west;
	RQ = createcenter resistance;
	CQ = createcenter civilian;

	WEST setFriend [EAST, 0];
	WEST setFriend [RESISTANCE, 0];
	EAST setFriend [WEST, 0];
	EAST setFriend [RESISTANCE, 0];
	RESISTANCE setFriend [WEST, 0];
	RESISTANCE setFriend [EAST, 0];
	
	if (isNil "allCapturePoints") then{
		allCapturePoints = [];
	};
	
	AAS_MissionTime = 0;
	resourceArrayServerPerSec = [+_bluforVPS,+_opforVPS];
	resourceArrayServer = [+_bluforV,+_opforV];



	[] spawn Alk_Loops_fnc_server;
	
	if!(isMultiplayer)then{
		if(hasInterface)then{
			[] spawn
			{
				waitUntil { !isNull findDisplay 46 };
				
				_singleplayerMenu = findDisplay 46 createDisplay "RTS_SingleplayerMenu";
				_singleplayerMenu displayAddEventHandler ["Unload", {
				 params ["_display", "_exitCode"];
				_blufor = _display displayCtrl 102;
				_opfor = _display displayCtrl 103;
				RTS_server_AI_bluforAmount = _blufor lbValue (lbCurSel _blufor);
				RTS_server_AI_opforAmount = _opfor lbValue (lbCurSel _opfor);
				
				Mission_Intro_Start = true;
				publicVariable "Mission_Intro_Start";
				}];
			};
		};
		if(isDedicated)then{
			Mission_Intro_Start = true;
			publicVariable "Mission_Intro_Start";
		};
		
	}else{

		Mission_Intro_Start = true;
		publicVariable "Mission_Intro_Start";
	};


	[] spawn
	{
		waituntil {Mission_Intro_Start};
		[] spawn Alk_Loops_fnc_ai;

	};

};



//CLIENT INIT
if(hasInterface)then{
	player createDiaryRecord ["Diary", ["How to win", "The team that has less capture points than the opposite team will loose tickets (see top center of screen)<br />When a teams ticket reach 0, they loose."]];
	player createDiaryRecord ["Diary", ["Camera Movement", "1. W,S,D,A to move the camera forward, backwards, right or left.<br />2. Hold right mouse and move to rotate camera.<br />3. Hold shift to speed up.<br />4. Scroll to move forward or backwards fast.<br />5. Q or Z to move up or down.<br />6. + or - to change FOV.<br />7. Hold left ALT to speed super fast.<br /><br />Some common problems<br />1. If camera wont move, left or right click center of screen.<br />2. Camera is to fast. Click on left ALT. Sometimes it can get stuck if alt tabbing."]];
	player createDiaryRecord ["Diary", ["Capture points", "Capture points have different flags depending on it´s status.<br /><br />Controlled by none<br /><img image='\a3\ui_f\data\map\markers\flags\un_ca.paa' width='50' height='50'/><br />Controlled by blufor<br /><img image='\a3\ui_f\data\map\markers\flags\nato_ca.paa' width='50' height='50'/><br />Controlled by opfor<br /><img image='\a3\ui_f\data\map\markers\flags\csat_ca.paa' width='50' height='50'/><br /><br />With selected units, right click a capture point to make them go capture it. When one of the units are close enough, they will start capturing it.<br />Capture points are connected with different resources."]];
	player createDiaryRecord ["Diary", ["Control units","Units you can control are visible with this symbol<img image='a3\ui_f\data\gui\cfg\gametypes\defend_ca.paa' width='50' height='50'/><br /><br />Left click on it on the map or the fastmenu bottom center of the screen. <br /> When selected the units are marked with<img image='\a3\ui_f\data\gui\cfg\hints\commanding_ca.paa' width='50' height='50'/><br /><br />You can now right click on capture points, enemies or the ground to move them around."], taskNull, "", false];
	player createDiaryRecord ["Diary", ["Create units","When a building has been created and placed on the ground.<br />It is visible with this symbol<img image='\a3\ui_f\data\map\mapcontrol\tourism_ca.paa' width='50' height='50'/><br /><br />Left click on it and you can now buy units. Hover over them to see what they cost."], taskNull, "", false];
	player createDiaryRecord ["Diary", ["Buildings", "To create buildings, click on <img image='\a3\ui_f\data\gui\cfg\respawnroles\support_ca.paa' width='50' height='50'/><br /><br />Hover over a building to see what it cost and click to select.<br />The building can only be placed inside your teams area.<br />Try and place them with some space around them, spawned vehicles have a tendency to get stuck. "], taskNull, "", false];
	player createDiaryRecord ["Diary", ["How to play", "Click on the different sections bellow to see how to play. Here are some tips.<br />1. To open RTS view, scroll and select Activate RTS view.<br />2. You can play in first person if you want, but you wont be enable to capture points.<br />3. Hit escape to exit RTS view.<br />4. Here are some basics symbols.<br /><br />Enemy units<br /><img image='a3\3den\data\attributes\guerallegiance\enemy_ca.paa' width='50' height='50'/><br />Your units<br /><img image='a3\ui_f\data\gui\cfg\gametypes\defend_ca.paa' width='50' height='50'/><br />Friendly units<br /><img image='a3\3den\data\attributes\guerallegiance\friendly_ca.paa' width='50' height='50'/><br />"]];

	alk_fnc_freeCam_SELECTEDbuilding = objnull;

	currentMoveTo = [];

	buildingsArray = [];

	allUnitsControls = [];
	
	musicArrayIndex = 0;
	musicArray = ["LeadTrack02_F_EPA","EventTrack01_F_Jets","LeadTrack01_F_Jets","BackgroundTrack04_F_EPC"];

	_ehID = addMusicEventHandler ["MusicStop", {
		_musicClass = _this select 0;

		playMusic (musicArray select musicArrayIndex);

		musicArrayIndex = musicArrayIndex + 1;
		if(musicArrayIndex > ((count musicArray) - 1) )then{
			musicArrayIndex = 0;
		};

	}];

	_markerName = createMarkerLocal ["RTS_Blufor_spawn", Blufor_spawn];
	_markerName setMarkerTypeLocal "flag_NATO";
	_markerName = createMarkerLocal ["RTS_Opfor_spawn", Opfor_spawn];
	_markerName setMarkerTypeLocal "flag_CSAT";
	
	fnc_updateMiniMap = {
		_map = _this select 0;
		_cam = missionnamespace getvariable ["alk_fnc_freeCam_cam",objnull];
		_map ctrlMapAnimAdd [0, 0.08, _cam];
		ctrlMapAnimCommit _map;
	};
	[] spawn Alk_Loops_fnc_client;
	[] spawn
	{	
		waitUntil { !isNull findDisplay 46 };
		"introScreen" cutText ["Waiting for server..", "BLACK OUT"];
		sleep 1.5;
		waituntil {Mission_Intro_Start};
		"introScreen" cutFadeOut 2;
		player addAction ["Activate RTS view", { [] spawn Alk_Interface_fnc_init; }];
		playMusic (musicArray select musicArrayIndex);
	};
	
	if(didJIP)then{
	
	};
};







