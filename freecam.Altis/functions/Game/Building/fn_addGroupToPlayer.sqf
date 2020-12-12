_group = _this param [0,grpnull,[grpnull]];
_type = _this param [1,"",[""]];


_toCheck = units _group;

{

	_x addEventhandler ["Killed",{
		params ["_killed"];
		_toCheck = units group _killed;
		
		if (count (_toCheck select {alive _x}) isEqualTo 0) then {
		
			[group _killed] call Alk_Building_fnc_removeGroupFromPlayer;
		};
	}];
	
	
} forEach _toCheck;


_imagePath = getText (missionConfigFile >> "Rsc_RTS_Main_Units" >> _type >> "image");
_submenu = getText (missionConfigFile >> "Rsc_RTS_Main_Units" >> _type >> "submenu");
_group setvariable ["_submenu",_submenu];
_group setvariable ["_imagePath",_imagePath];

_grpSelection = uiNamespace getvariable ["alk_fnc_freeCam_unitArrayCtrl",controlnull];
_alk_fnc_freeCam_unitArrayCtrl_units = _grpSelection getvariable ["alk_fnc_freeCam_unitArrayCtrl_Columns",0];
_alk_fnc_freeCam_unitArrayCtrl_Rows = _grpSelection getvariable ["alk_fnc_freeCam_unitArrayCtrl_Rows",0];

if(_alk_fnc_freeCam_unitArrayCtrl_units >= 9)then{
	_alk_fnc_freeCam_unitArrayCtrl_units = 0;
	_grpSelection setvariable ["alk_fnc_freeCam_unitArrayCtrl_Rows",1];
	_alk_fnc_freeCam_unitArrayCtrl_Rows = 1;
};

_grpNetId = _group call BIS_fnc_netId;

_grpSelectionPos = ctrlPosition _grpSelection;

_columns = 10;
_rows = 2;

_btnWidth = (_grpSelectionPos select 2) / _columns;
_btnHeight = (_grpSelectionPos select 3) / _rows;


_btnColumn = _alk_fnc_freeCam_unitArrayCtrl_units;
_btnRow = _alk_fnc_freeCam_unitArrayCtrl_Rows;

_btnX = _btnColumn * _btnWidth;
_btnY = _btnRow * _btnHeight;

_display = ctrlParent _grpSelection;

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

allUnitsControls pushBack [_ctrlButton,_group];

_alk_fnc_freeCam_unitArrayCtrl_units = _alk_fnc_freeCam_unitArrayCtrl_units + 1;

_grpSelection setvariable ["alk_fnc_freeCam_unitArrayCtrl_Columns",_alk_fnc_freeCam_unitArrayCtrl_units];

