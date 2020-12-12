_object = _this param [0,objnull,[objnull,[]]];
_group = _this param [1,grpnull,[grpnull]];


[units _group,getPosATL _object] call Alk_AI_fnc_move;
_group setVariable ["captureBuilding",_object];		


