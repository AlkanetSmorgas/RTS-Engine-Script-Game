




_display = findDisplay 46 createDisplay "RscDisplayEmpty";

_playerPos = positionCameraToWorld [0,0,0];

["Init",[_display,_playerPos]] call RTSENGINE_Camera_fnc_init;

alk_fnc_freeCam_cameraLimit = [Gamearea_Center, 500, 500, 0, false,80];

_alk_fnc_freeCam_ClickFunction = {
				
	[screentoworld getmouseposition,(_this select 0)] call Alk_Interface_fnc_mapClick;

};

[_alk_fnc_freeCam_ClickFunction] call Alk_Interface_fnc_setClickEvent;

_mouseArea = uinamespace getvariable ["alk_fnc_freeCam_mouseArea",controlnull];
_mouseArea ctrlSetPosition [safezoneX,safezoneY,safezoneW,safezoneH-0.4];
_mouseArea ctrlCommit 0;




_firstSectionWidth = (safezoneX+safezoneW) * 0.2;
_secondSectionWidth = (safezoneX+safezoneW) * 0.2;
_thirdSectionWidth = (safezoneX+safezoneW) * 0.5;
_fourSectionWidth = (safezoneX+safezoneW) * 0.2;

_buttomMenuX = safezoneX;
_buttomMenuY = safezoneY + safezoneH - 0.4;
_buttomMenuWidth = _firstSectionWidth;
_buttomMenuHeight = 0.4;

//Background
private _background = _display ctrlCreate ["RscText", -1];
_background ctrlSetPosition [_buttomMenuX,_buttomMenuY,safezoneW,_buttomMenuHeight];
_background ctrlSetBackgroundColor [0,0,0,0.9];
_background ctrlEnable false;
_background ctrlCommit 0; 

//Mini map
_buttomMenu = _display ctrlCreate ["minimapi", -1];
_buttomMenu ctrlSetPosition [_buttomMenuX,_buttomMenuY,_buttomMenuWidth,_buttomMenuHeight];
_buttomMenu ctrlSetBackgroundColor [0,0,0,0.5];
_buttomMenu ctrlCommit 0; 


//Resources
_buttomMenuX = safezoneX+_firstSectionWidth;
_buttomMenuWidth = _secondSectionWidth;


_grpSelection = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_grpSelection ctrlSetPosition [_buttomMenuX,_buttomMenuY,_buttomMenuWidth,_buttomMenuHeight];
_grpSelection ctrlSetBackgroundColor [0,0,0,0.5];
_grpSelection ctrlCommit 0; 



resourceData = [];




_resourceConfig = (configproperties [missionConfigFile >> "RTS_Resources","isclass _x"]);
_resourceConfigCount = count _resourceConfig;

_btnWidth = _buttomMenuWidth / 3;
_btnHeight = _buttomMenuHeight / _resourceConfigCount;
_btnColumn = 0;
_btnRow = 0;
_idcIncrementer = 1;


{
	_name = getText (_x >> "name");
	if(_name isEqualTo "")then{
		_name = configName _x;
	};

	_idc = _idcIncrementer * 1000;
	_btnX = _btnColumn * _btnWidth;
	_btnY = _btnRow * _btnHeight;
	_idc = _idc + 1;
	
	resourceData pushBack [_name,_idc];
	private _t1 = _display ctrlCreate ["RscText", _idc, _grpSelection];
	_t1 ctrlSetPosition [_btnX,_btnY,_btnWidth,_btnHeight];
	_t1 ctrlSetText _name;
	_t1 ctrlCommit 0; 
	_btnColumn = _btnColumn + 1;
	_btnX = _btnColumn * _btnWidth;
	_idc = _idc + 1;
	private _t1 = _display ctrlCreate ["RscText", _idc, _grpSelection];
	_t1 ctrlSetPosition [_btnX,_btnY,_btnWidth,_btnHeight];
	_t1 ctrlSetText "0";
	_t1 ctrlCommit 0; 
	_idc = _idc + 1;
	_btnColumn = _btnColumn + 1;
	_btnX = _btnColumn * _btnWidth;
	private _t1 = _display ctrlCreate ["RscText", _idc, _grpSelection];
	_t1 ctrlSetPosition [_btnX,_btnY,_btnWidth,_btnHeight];
	_t1 ctrlSetText "+0";
	_t1 ctrlCommit 0; 

	_idcIncrementer = _idcIncrementer + 1;
	_btnColumn = 0;
	_btnRow = _btnRow + 1;
} foreach _resourceConfig;

{
	_mainIdc = _x select 1;
	_valueIdc = _mainIdc + 1;
	_PerSecIdc = _mainIdc + 2;
	
	_valueControl = _grpSelection controlsGroupCtrl _valueIdc;
	_value = resourceArrayValue select _foreachIndex;
	_valueControl ctrlSetText str _value;

	
	_PerSecControl = _grpSelection controlsGroupCtrl _PerSecIdc;
	_persec = resourceArrayPerSec select _foreachIndex;
	_PerSecControl ctrlSetText ("+" + str _persec);



	
}foreach resourceData;

uiNamespace setvariable ["alk_fnc_freeCam_resourcesArrayCtrl",_grpSelection];





//Units
_buttomMenuX = safezoneX+_firstSectionWidth+_secondSectionWidth;
_buttomMenuWidth = _thirdSectionWidth;


_grpSelection = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_grpSelection ctrlSetPosition [_buttomMenuX,_buttomMenuY,_buttomMenuWidth,_buttomMenuHeight];
_grpSelection ctrlSetBackgroundColor [0,0,0,0.5];
_grpSelection ctrlCommit 0; 



_alk_fnc_freeCam_unitArrayCtrl_units = 0;
_alk_fnc_freeCam_unitArrayCtrl_Rows = 0;


_grpSelectionPos = ctrlPosition _grpSelection;

_columns = 10;
_rows = 2;

_btnWidth = (_grpSelectionPos select 2) / _columns;
_btnHeight = (_grpSelectionPos select 3) / _rows;

{
	_group = _x select 1;
	_imagePath = _group getvariable ["_imagePath",""];
	if!(_group isEqualTo grpnull)then{
		_grpNetId = _group call BIS_fnc_netId;

		_btnX = _alk_fnc_freeCam_unitArrayCtrl_units * _btnWidth;
		_btnY = _alk_fnc_freeCam_unitArrayCtrl_Rows * _btnHeight;

		private _ctrlButton = _display ctrlCreate ["DDRscFlowButton", -1, _grpSelection];
		_ctrlButton setvariable ["_grpNetId",_grpNetId];
		_ctrlButton ctrlSetPosition [_btnX,_btnY,_btnWidth,_btnHeight];
		_ctrlButton ctrlCommit 0;
		
		
		
		if!(_imagePath isEqualTo "")then{
			_ctrlButton ctrlsetText _imagePath;

		};

		_ctrlButton ctrladdeventhandler ["ButtonClick",{
		params ["_control"];		
			_id = _control getvariable ["_grpNetId",""];
			
			_obj = _id call BIS_fnc_groupFromNetId;
			[units _obj] call Alk_Interface_fnc_select;
			
		}];

		_alk_fnc_freeCam_unitArrayCtrl_units = _alk_fnc_freeCam_unitArrayCtrl_units + 1;

		if(_alk_fnc_freeCam_unitArrayCtrl_units >= 9)then{
			_alk_fnc_freeCam_unitArrayCtrl_units = 0;
			_alk_fnc_freeCam_unitArrayCtrl_Rows = 1;
		};	
		allUnitsControls set [_foreachIndex,[_ctrlButton,_group]];
	}else{
		allUnitsControls deleteAt _foreachIndex;
	};
}foreach allUnitsControls;

_grpSelection setvariable ["alk_fnc_freeCam_unitArrayCtrl_Columns",_alk_fnc_freeCam_unitArrayCtrl_units];
_grpSelection setvariable ["alk_fnc_freeCam_unitArrayCtrl_Rows",_alk_fnc_freeCam_unitArrayCtrl_Rows];

uiNamespace setvariable ["alk_fnc_freeCam_unitArrayCtrl",_grpSelection];

//Menu
_buttomMenuX = safezoneX+_firstSectionWidth+_secondSectionWidth+_thirdSectionWidth;
_buttomMenuWidth = _fourSectionWidth;

_buttomMenu = _display ctrlCreate ["RscControlsGroupNoScrollbars", -1];
_buttomMenu ctrlSetPosition [_buttomMenuX,_buttomMenuY,_buttomMenuWidth,_buttomMenuHeight];
_buttomMenu ctrlSetBackgroundColor [0,0,0,0.5];
_buttomMenu ctrlCommit 0; 


_columns = getNumber (missionConfigFile >> "Rsc_RTS_Main" >> "columns");
_rows = getNumber (missionConfigFile >> "Rsc_RTS_Main" >> "rows");


_btnWidth = _buttomMenuWidth / _columns;
_btnHeight = _buttomMenuHeight / _rows;

{
	_btnColumn = getNumber (_x >> "column");
	_btnRow = getNumber (_x >> "row");
	_ui = getText (_x >> "submenu");
	_imagePath = getText (_x >> "image");

	_btnX = _btnColumn * _btnWidth;
	_btnY = _btnRow * _btnHeight;

	private _ctrlButton = _display ctrlCreate ["DDRscFlowButton", -1, _buttomMenu];
	_ctrlButton setvariable ["_ui",_ui];
	_ctrlButton ctrlSetPosition [_btnX,_btnY,_btnWidth,_btnHeight];
	_ctrlButton ctrlCommit 0; 
	_ctrlButton ctrlsetText _imagePath;
	_ctrlButton ctrlsetTooltip configName _x;
	
	_ctrlButton ctrladdeventhandler ["ButtonClick",{
		params ["_control"];		
			_ui = _control getvariable ["_ui",""];
			
			[_ui] call Alk_Interface_fnc_createSubMenu;
		}];
	
} foreach (configproperties [missionConfigFile >> "Rsc_RTS_Main","isclass _x"]);


uiNamespace setvariable ["alk_fnc_buttomMenu_current",_buttomMenu];
uiNamespace setvariable ["alk_fnc_buttomMenu",_buttomMenu];
uiNamespace setvariable ["alk_fnc_buttomMenu_submenus",[["Rsc_RTS_Main",_buttomMenu]]];





