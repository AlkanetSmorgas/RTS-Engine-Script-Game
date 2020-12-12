_group = _this param [0,grpnull,[grpnull]];
_icon = "";

if(side player isEqualTo side _group)then{
	_icon = "a3\3den\data\attributes\guerallegiance\friendly_ca.paa";
	_isAI = leader _group getvariable ["_isAI",false];

	if(local leader _group && !_isAI)then{
		_icon = "a3\ui_f\data\gui\cfg\gametypes\defend_ca.paa";
	};
}else{
	_icon = "a3\3den\data\attributes\guerallegiance\enemy_ca.paa";
};

[_group,_icon] call RTSENGINE_Camera_fnc_addClickable;
