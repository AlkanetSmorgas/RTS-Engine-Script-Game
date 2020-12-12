_group = _this param [0,grpnull,[grpnull]];


_selectedUnits = [] call Alk_Interface_fnc_selected;

if!(_selectedUnits isEqualTo [])then{
	_selectedGroup = group (_selectedUnits select 0);
	if(_selectedUnits isEqualTo _group)then{
		[] call Alk_Interface_fnc_unSelect;
	};
};

_grpNetId = _group call BIS_fnc_netId;


[_group] call RTSENGINE_Camera_fnc_removeClickable;

_index = allUnitsControls findIf {
_ctrl = (_x select 0);
if!(_ctrl isEqualTo controlnull)then{
	_id = _ctrl getvariable ["_grpNetId",""];
	_id isEqualTo _grpNetId
};
};

if(_index >= 0)then{


_grpSelection = uiNamespace getvariable ["alk_fnc_freeCam_unitArrayCtrl",controlnull];
_alk_fnc_freeCam_unitArrayCtrl_units = 0;
_alk_fnc_freeCam_unitArrayCtrl_Rows = 0;

deleteGroup _group;


ctrlDelete ((allUnitsControls deleteAt _index) select 0);


_grpSelectionPos = ctrlPosition _grpSelection;

_columns = 10;
_rows = 2;

_btnWidth = (_grpSelectionPos select 2) / _columns;
_btnHeight = (_grpSelectionPos select 3) / _rows;



{
	
	_btnX = _alk_fnc_freeCam_unitArrayCtrl_units * _btnWidth;
	_btnY = _alk_fnc_freeCam_unitArrayCtrl_Rows * _btnHeight;

	_ctrlButton = _x select 0;
	_ctrlButton ctrlSetPosition [_btnX,_btnY,_btnWidth,_btnHeight];
	_ctrlButton ctrlCommit 0;

	_alk_fnc_freeCam_unitArrayCtrl_units = _alk_fnc_freeCam_unitArrayCtrl_units + 1;

	if(_alk_fnc_freeCam_unitArrayCtrl_units >= 9)then{
		_alk_fnc_freeCam_unitArrayCtrl_units = 0;
		_alk_fnc_freeCam_unitArrayCtrl_Rows = 1;
	};	

}foreach allUnitsControls;

_grpSelection setvariable ["alk_fnc_freeCam_unitArrayCtrl_Columns",_alk_fnc_freeCam_unitArrayCtrl_units];
_grpSelection setvariable ["alk_fnc_freeCam_unitArrayCtrl_Rows",_alk_fnc_freeCam_unitArrayCtrl_Rows];
};

