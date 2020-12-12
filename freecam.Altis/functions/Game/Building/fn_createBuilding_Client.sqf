_building = _this param [0,objnull,[objnull]];
_type = _this param [1,"",[""]];

_building setvariable ["_type",_type];
_building setvariable ["_gameType",0];

buildingsArray pushBack _building;

	
[_building,"\a3\ui_f\data\map\mapcontrol\tourism_ca.paa"] call RTSENGINE_Camera_fnc_addClickable;
