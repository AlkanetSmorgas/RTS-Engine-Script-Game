_nBuilding = _this param [0,objnull,[objnull,[]]];

if (isNil "alk_fnc_freeCam_CLICKABLEobject") then{
	alk_fnc_freeCam_CLICKABLEobject = [];
};

alk_fnc_freeCam_CLICKABLEobject pushBack _nBuilding;

_markerName = createMarkerLocal [str _nBuilding, _nBuilding];
_markerName setMarkerTypeLocal "flag_UN";
_markerName setMarkerSizeLocal [0.5,0.5];

_belongsTo = _nBuilding getvariable ["_belongsTo",civilian];
_flag = "\a3\ui_f\data\map\markers\flags\un_ca.paa";
if(_belongsTo isEqualTo blufor)then{_flag = "\a3\ui_f\data\map\markers\flags\nato_ca.paa";};
if(_belongsTo isEqualTo opfor)then{_flag = "\a3\ui_f\data\map\markers\flags\csat_ca.paa";};
_nBuilding setVariable ["alk_fnc_freeCam_click_icon",_flag];