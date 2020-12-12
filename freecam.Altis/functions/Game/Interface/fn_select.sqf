_units = _this param [0,[],[[]]];

if (_units isEqualTo []) exitWith{};

if (isNil "alk_fnc_freeCam_SELECTEDobject") then{
	alk_fnc_freeCam_SELECTEDobject = [];
};



alk_fnc_freeCam_SELECTEDobject = _units;

_group = group (_units select 0);

_submenu = _group getvariable ["_submenu",""];
_pos = _group getVariable ["doMove",[]];		

currentMoveTo = _pos;

if!(_submenu isEqualTo "")then{
	[_submenu] call Alk_Interface_fnc_createSubMenu;
};
			