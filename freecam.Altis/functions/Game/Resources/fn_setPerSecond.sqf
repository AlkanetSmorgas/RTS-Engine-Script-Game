_type = _this param [0,0,[0,""]];
_value = _this param [1,0,[0]];

_controlsGroup  = uiNamespace getvariable ["alk_fnc_freeCam_resourcesArrayCtrl",grpnull];


_valueIdc = -1;

if(_type isEqualType "")then{

_resourceIndex = resourceData findIf {(_x select 0) isEqualTo _type};

if(_resourceIndex >= 0)then{
	_resourceInfo = resourceData select _resourceIndex;
	_mainIdc = _resourceInfo select 1;
	_valueIdc = _mainIdc + 2;
	_type = _resourceIndex;
};

}else{
	_resourceInfo = resourceData select _type;
	_mainIdc = _resourceInfo select 1;
	_valueIdc = _mainIdc + 2;
};

if!(_controlsGroup isEqualTo grpnull)then{

_valueControl = _controlsGroup controlsGroupCtrl _valueIdc;
_valueControl ctrlSetText ("+" + str _value);

};

resourceArrayPerSec set [_type,_value];


/*
IDC
Moral 1001,1002,1003
Ammo 2001,2002,2003
Fuel 3001,3002,3003
Pop 4001,4002,4003
*/


