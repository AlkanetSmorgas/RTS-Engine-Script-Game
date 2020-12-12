_object = _this param [0,objnull,[objnull]];
_group = _this param [1,grpnull,[grpnull,blufor]];


_belongsTo = _object getvariable ["_belongsTo",civilian];
_pointsToAdd = _object getvariable ["_pointsToAdd",0];
_gameTypeCat = _object getvariable ["_gameTypeCat",0];


//Remove old Owner
_sideIndex = -1;
if(_belongsTo isEqualTo blufor)then{
	_sideIndex = 0;
};

if(_belongsTo isEqualTo opfor)then{
	_sideIndex =1;
};

if!(_sideIndex isEqualTo -1)then{
	_sideResources = resourceArrayServerPerSec select _sideIndex; 
	_sideResourcesValue = _sideResources select _gameTypeCat;
	_sideResourcesValue = _sideResourcesValue - _pointsToAdd;
	_sideResources set [_gameTypeCat,_sideResourcesValue];
	//resourceArrayServerPerSec set [_sideIndex,_sideResources];
	[_gameTypeCat,_sideResourcesValue] remoteExec ["Alk_Resources_fnc_setPerSecond", _belongsTo]; 
};


//Add new Owner
if(_group isEqualType grpnull)then{
	_belongsTo = side _group;
}else{
	_belongsTo = _group;
};

_object setVariable ["_belongsTo",_belongsTo,true];




_flag = "\a3\ui_f\data\map\markers\flags\un_ca.paa";
if(_belongsTo isEqualTo blufor)then{_flag = "\a3\ui_f\data\map\markers\flags\nato_ca.paa";};
if(_belongsTo isEqualTo opfor)then{_flag = "\a3\ui_f\data\map\markers\flags\csat_ca.paa";};
_object setVariable ["alk_fnc_freeCam_click_icon",_flag,true];


_sideIndex = -1;
if(_belongsTo isEqualTo blufor)then{
	_sideIndex = 0;
};

if(_belongsTo isEqualTo opfor)then{
	_sideIndex =1;
};

if!(_sideIndex isEqualTo -1)then{
	_sideResources = resourceArrayServerPerSec select _sideIndex; 
	_sideResourcesValue = _sideResources select _gameTypeCat;
	_sideResourcesValue = _sideResourcesValue + _pointsToAdd;
	_sideResources set [_gameTypeCat,_sideResourcesValue];
	//resourceArrayServerPerSec set [_sideIndex,_sideResources];
	[_gameTypeCat,_sideResourcesValue] remoteExec ["Alk_Resources_fnc_setPerSecond", _belongsTo]; 
};

_blufor = allCapturePoints select {_belongsTo = _x getvariable ["_belongsTo",civilian]; _belongsTo isEqualTo blufor};
_opfor = allCapturePoints select {_belongsTo = _x getvariable ["_belongsTo",civilian]; _belongsTo isEqualTo opfor};

_bluforAmount = count _blufor;
_opforAmount = count _opfor;


if(_bluforAmount > _opforAmount)then{
	if!(losingSide isEqualTo opfor)then{
		losingSide = opfor;
		
		[losingSidePoints,opfor] remoteExec ["Alk_Objective_fnc_setWinCondition", 0]; 
	};
	
};

if(_opforAmount > _bluforAmount)then{
	if!(losingSide isEqualTo blufor)then{
		losingSide = blufor;
		
		[losingSidePoints,blufor] remoteExec ["Alk_Objective_fnc_setWinCondition", 0]; 
	};
};

if(_opforAmount isEqualTo _bluforAmount)then{
	losingSide = civilian;
	[[],civilian] remoteExec ["Alk_Objective_fnc_setWinCondition", 0]; 
};