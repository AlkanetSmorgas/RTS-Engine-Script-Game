_player = _this param [0,objnull,[objnull]];
_type = _this param [1,"",[""]];
_building = _this param [2,objnull,[objnull]];

_side = side _player;

_group = createGroup [_side, true];

_dimenson = (sizeOf typeof _building) * 0.5;

if(_dimenson isEqualTo 0)then{_dimenson = 10;};

_pos = [_building, _dimenson, _dimenson+3, 1, 0, 20, 0] call BIS_fnc_findSafePos;
_hasVehicle = false;
_veh = objnull;

{
	_vehicle = getText (_x >> "vehicle");
	
	_isVehicle = getNumber(configFile >> "CfgVehicles" >> _vehicle >> "isMan") == 0;

	if(_isVehicle)then{
		_veh = createvehicle [_vehicle,_pos,[],0,"none"];
		_group addVehicle _veh;
		_hasVehicle = true;
	}else{
		_unit = _group createUnit [_vehicle, _pos, [], 0, "FORM"];
		_unit setSkill 1;
		_unit allowFleeing 0;
		_unit setvariable ["_gameType",2,true];
	};
	
	
} foreach (configproperties [missionConfigFile >> "Rsc_RTS_Main_Units" >> _type >> str _side,"isclass _x"]);

if(_hasVehicle)then{
	{_x moveInAny _veh;}foreach units _group;
};

[_group] remoteExec ["Alk_Building_fnc_addGroupToAll", 0]; 

_ownerID = owner _player;

_localityChanged = _group setGroupOwner _ownerID;

if!(isMultiplayer)then{
	_localityChanged = true;
}else{

if( !(_localityChanged) && _ownerID isEqualTo 2)then{
	_localityChanged = true;
};

};

if(_localityChanged)then{
	[_group,_type] remoteExec ["Alk_Building_fnc_addGroupToPlayer", _ownerID]; 
};
